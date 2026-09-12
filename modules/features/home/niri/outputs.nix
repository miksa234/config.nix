{ ... }:
let
  monitors = {
    left = "Philips Consumer Electronics Company 27E1N1200A UHB2549032242";
    right = "Philips Consumer Electronics Company 27E1N1200A UHB2549032244";
    laptop = "BOE 0x0BCA Unknown";
  };
  external = x: {
    mode = {
      width = 1920;
      height = 1080;
      refresh = 120.0;
    };
    scale = 1.0;
    position = {
      inherit x;
      y = 0;
    };
  };
in
{
  dendritic.data.niriMonitors = monitors;
  dendritic.data.niriOutputs = {
    ${monitors.left} = external 0;
    ${monitors.right} = external 1920;
    ${monitors.laptop} = {
      mode = {
        width = 2256;
        height = 1504;
      };
      position = {
        x = 3840;
        y = 0;
      };
    };
  };
}
