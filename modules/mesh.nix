{ config, lib, pkgs, ... }: 
let
  cfg = config.custom.mesh;
  nodeName = config.networking.hostName;
  nodeOptions = with lib; types.submodule {
    options = {
      publicIp = mkOption {
        type = types.nullOr types.str;
        description = ''
          The public ipv4 address of the node.
        '';
        default = null;
      };
      ip = mkOption {
        type = types.str;
        example = "10.0.0.1";
        description = ''
          The ipv4 address of the node in the tinc network.
        '';
      };
      port = mkOption {
        type = types.port;
        default = 665;
        description = ''
          TCP/UDP port used by the tinc network.
        '';
      };
      connectTo = mkOption {
        type = types.nullOr types.str;
        example = "node0";
        description = ''
          Node name to establish connection.
        '';
        default = null;
      };
      Ed25519PublicKey = mkOption {
        type = types.str;
        description = ''
          The Ed25519 public key of the node.
        '';
      };
      rsaPublicKey = mkOption {
        type = types.str;
        description = ''
          The RSA public key of the node.
        '';
      };
    };
  };
  mkTincHost = name: node: ''
    ${if (isNull node.publicIp) then "" else "Address = ${node.publicIp}"}
    ${if (isNull node.connectTo) then "" else "ConnectTo = ${node.connectTo}"}
    Subnet = ${node.ip}
    Port = ${toString node.port}
    Ed25519PublicKey = ${node.Ed25519PublicKey}
    -----BEGIN RSA PUBLIC KEY-----
    ${node.rsaPublicKey}
    -----END RSA PUBLIC KEY-----
  '';
in
{
  options.custom.mesh = with lib; {
    nodes = mkOption {
      default = [];
      type = types.attrsOf nodeOptions;
      description = ''
        Nodes of the tinc mesh network.
        The name of the node (the set key) must match the machine's hostname.
      '';
    };
  };
  config = lib.mkIf (builtins.elem nodeName (lib.attrNames cfg.nodes)) (let 
    node = cfg.nodes.${nodeName};
  in {
    networking = {
      firewall = {
        allowedTCPPorts = [ node.port ];
        allowedUDPPorts = [ node.port ];
      };
      interfaces."tinc.mesh".ipv4 = {
        addresses = [ { address = node.ip;  prefixLength = 24; } ];
        # routes    = [ { address = "192.168.0.0"; prefixLength = 24; via = "10.0.0.2"; } ];
      };
    };
    services.tinc.networks.mesh = {
      name = nodeName;
      hosts = lib.mapAttrs mkTincHost cfg.nodes;
    };
  });
}