args: {
  containers.rednix = {
    privateNetwork = true;
    hostAddress = "192.168.100.2";
    localAddress = "192.168.100.11";

    forwardPorts = [
      {
        containerPort = 22;
        hostPort = 2222;
        protocol = "tcp";
      }
      {
        containerPort = 80;
        hostPort = 8080;
        protocol = "tcp";
      }
    ];

    bindMounts."/" = {
      hostPath = "/mnt/rednix";
      isReadOnly = false;
    };

    config = import ./container-config.nix args;
  };
}
