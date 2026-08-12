{ inputs, ... }:
{
  dendritic.modules.nixos.networkmanager-secrets =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      networkManagerProfileFiles = builtins.filter
        (profileFile: lib.hasSuffix ".nmconnection" (toString profileFile))
        (lib.filesystem.listFilesRecursive ./profiles);
      serviceName = "NetworkManager-load-profiles.service";
      profileRelativePath =
        profileFile: lib.removePrefix "${toString ./profiles}/" (toString profileFile);
      profileSecretName = profileFile: "networkmanager/profiles/${profileRelativePath profileFile}";
      profileName = profileFile: lib.removeSuffix ".nmconnection" (builtins.baseNameOf profileFile);
      renderedProfilePath =
        profileFile: "/run/NetworkManager/system-connections/${builtins.baseNameOf profileFile}";
      profileSecrets = lib.listToAttrs (
        map (profileFile: {
          name = profileSecretName profileFile;
          value = {
            format = "binary";
            sopsFile = profileFile;
            restartUnits = [ serviceName ];
          };
        }) networkManagerProfileFiles
      );
    in
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops.age.keyFile = "/etc/sops/age/keys.txt";
      sops.secrets = profileSecrets;

      systemd.services.NetworkManager-load-profiles = {
        description = "Load NetworkManager profiles from sops secrets";
        wantedBy = [ "multi-user.target" ];
        wants = [
          "NetworkManager.service"
          "sops-install-secrets.service"
        ];
        after = [
          "NetworkManager.service"
          "sops-install-secrets.service"
        ];
        before = [ "network-online.target" ];
        script =
          ''
            mkdir -p /run/NetworkManager/system-connections
          ''
          + lib.concatMapStringsSep "\n" (
            profileFile:
            let
              secretName = profileSecretName profileFile;
              secretPath = config.sops.secrets.${secretName}.path;
              targetPath = renderedProfilePath profileFile;
              connectionName = profileName profileFile;
            in
            ''
              if ${config.networking.networkmanager.package}/bin/nmcli connection show ${lib.escapeShellArg connectionName} >/dev/null 2>&1; then
                ${config.networking.networkmanager.package}/bin/nmcli connection delete ${lib.escapeShellArg connectionName}
              fi
              ${pkgs.coreutils}/bin/cat ${lib.escapeShellArg secretPath} > ${lib.escapeShellArg targetPath}
              chmod 600 ${lib.escapeShellArg targetPath}
            ''
          ) networkManagerProfileFiles
          + ''
            ${config.networking.networkmanager.package}/bin/nmcli connection reload
          '';
        serviceConfig = {
          Type = "oneshot";
          UMask = "0177";
        };
      };
    };
}
