{
  description = "A collection of flake templates";

  outputs = {self}: {
    templates.enarx.description = "Enarx template";
    templates.enarx.path = ./enarx;

    templates.rust.description = "Rust template";
    templates.rust.path = ./rust;
  };
}
