{ pkgs, ... }:

pkgs.nixosTest {
  name = "linguee-api";
  meta = with pkgs.lib.maintainers; {
    maintainers = [  ];
  };

  nodes = {
    machine = { pkgs, ... }: {
      imports = [ ../modules/linguee-api ];
      services.linguee-api.enable = true;
      virtualisation.memorySize = 512;
    };
  };

  testScript =
    ''
      start_all()
      machine.wait_for_unit("linguee-api.service")
      machine.wait_for_open_port(8000)
    '';
}
