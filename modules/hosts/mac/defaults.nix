{ ... }:
{
  dendritic.modules.darwin.mac =
    { pkgs, ... }:
    {
      system.defaults = {
        controlcenter = {
          BatteryShowPercentage = true;
          NowPlaying = false;
        };
        menuExtraClock = {
          Show24Hour = true;
          ShowDate = 1;
          ShowDayOfWeek = true;
          ShowSeconds = false;
        };
        CustomUserPreferences = {
          "com.apple.desktopservices" = {
            DSDontWriteNetworkStores = true;
            DSDontWriteUSBStores = true;
          };
          "com.apple.symbolichotkeys" = {
            "64".enabled = false;
            "65".enabled = false;
            "238" = {
              enabled = true;
              value = {
                parameters = [
                  99
                  8
                  1310720
                ];
                type = "standard";
              };
            };
            "98" = {
              enabled = false;
              value = {
                parameters = [
                  47
                  44
                  1179648
                ];
                type = "standard";
              };
            };
          };
        };
        CustomSystemPreferences."com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          ConfigDataInstall = true;
          CriticalUpdateInstall = true;
        };
        NSGlobalDomain = {
          "com.apple.sound.beep.volume" = 0.000;
          AppleInterfaceStyleSwitchesAutomatically = true;
          AppleKeyboardUIMode = 3;
          ApplePressAndHoldEnabled = false;
          AppleShowAllExtensions = true;
          AppleMetricUnits = 1;
          InitialKeyRepeat = 20;
          KeyRepeat = 2;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticInlinePredictionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          NSAutomaticWindowAnimationsEnabled = false;
          NSDocumentSaveNewDocumentsToCloud = false;
          NSNavPanelExpandedStateForSaveMode = true;
          NSWindowShouldDragOnGesture = true;
          PMPrintingExpandedStateForPrint = true;
        };
        trackpad = {
          TrackpadRightClick = true;
          TrackpadThreeFingerDrag = true;
          Clicking = true;
        };
        finder = {
          AppleShowAllFiles = true;
          CreateDesktop = false;
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
          FXPreferredViewStyle = "Nlsv";
          FXRemoveOldTrashItems = true;
          QuitMenuItem = true;
          NewWindowTarget = "Home";
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowPathbar = true;
          ShowRemovableMediaOnDesktop = false;
          ShowStatusBar = true;
          _FXShowPosixPathInTitle = true;
          _FXSortFoldersFirst = true;
        };
        dock = {
          autohide = true;
          autohide-delay = 0.0;
          autohide-time-modifier = 0.15;
          expose-animation-duration = 0.1;
          expose-group-apps = true;
          launchanim = false;
          mineffect = "scale";
          minimize-to-application = true;
          mru-spaces = false;
          show-recents = false;
          showhidden = true;
          persistent-apps = [ ];
          tilesize = 50;
          wvous-bl-corner = 1;
          wvous-br-corner = 1;
          wvous-tl-corner = 1;
          wvous-tr-corner = 1;
        };
        spaces.spans-displays = false;
        screencapture = {
          disable-shadow = true;
          location = "/Users/mika/Pictures";
          type = "png";
        };
        screensaver = {
          askForPassword = true;
          askForPasswordDelay = 0;
        };
        loginwindow = {
          DisableConsoleAccess = true;
          GuestEnabled = false;
        };
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
        WindowManager = {
          EnableStandardClickToShowDesktop = false;
          HideDesktop = true;
          StandardHideDesktopIcons = true;
        };
      };

      system.keyboard = {
        enableKeyMapping = true;
        swapLeftCtrlAndFn = true;
        nonUS.remapTilde = true;
        userKeyMapping = [
          {
            HIDKeyboardModifierMappingSrc = 30064771172;
            HIDKeyboardModifierMappingDst = 30064771125;
          }
        ];
      };

      launchd.user.agents.keyboard-remap.serviceConfig = {
        ProgramArguments = [
          "/usr/bin/hidutil"
          "property"
          "--set"
          ''{"UserKeyMapping":[{"HIDKeyboardModifierMappingDst":30064771125,"HIDKeyboardModifierMappingSrc":30064771172},{"HIDKeyboardModifierMappingDst":1095216660483,"HIDKeyboardModifierMappingSrc":30064771296},{"HIDKeyboardModifierMappingDst":30064771296,"HIDKeyboardModifierMappingSrc":1095216660483}]}''
        ];
        RunAtLoad = true;
      };

      launchd.user.agents.stats.serviceConfig = {
        ProgramArguments = [ "${pkgs.stats}/bin/stats" ];
        RunAtLoad = true;
      };
    };
}
