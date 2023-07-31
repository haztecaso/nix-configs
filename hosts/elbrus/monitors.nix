{ config, pkgs, ... }:
let
  eDP = "00ffffffffffff000daec3140000000026190104951f1178027e45935553942823505400000001010101010101010101010101010101da1d56e250002030442d470035ad10000018000000fe004e3134304247412d4541330a20000000fe00434d4e0a202020202020202020000000fe004e3134304247412d4541330a200053";
  HDMI = "00ffffffffffff0009d11b8045540000251b010380351e78260cd5a9554ca1250d5054a56b80818081c08100a9c0b300d1c001010101565e00a0a0a02950302035000f282100001a000000ff0044394830303535383031390a20000000fd00324c1e591b000a202020202020000000fc0042656e51204c43440a202020200158020322f14f901f05140413031207161501061102230907078301000065030c001000023a801871382d40582c450056502100001f011d8018711c1620582c250056502100009f011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e960056502100001800000000000000000000000000000000000000000047";
in
{
  custom.monitors = {
    profiles = {
      onlysmall = {
        fingerprint.eDP-1 = eDP;
        config = {
          eDP-1 = {
            enable = true;
            crtc = 1;
            primary = true;
            position = "0x0";
            mode = "1366x768";
            rate = "59.99";
          };
        };
      };
      both = {
        fingerprint = {
          HDMI-2 = HDMI;
          eDP-1 = eDP;
        };
        config = {
          HDMI-2 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "1366x0";
            mode = "2560x1440";
            rate = "59.95";
          };
          eDP-1 = {
            enable = true;
            crtc = 1;
            primary = false;
            position = "0x0";
            mode = "1366x768";
            rate = "59.99";
          };
        };
      };
    };
    defaultTarget = "onlysmall";
  };
}
