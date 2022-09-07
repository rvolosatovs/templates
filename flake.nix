{
  description = "A collection of flake templates";

  outputs = {self}: {
    templates.rust.description = "Rust template";
    templates.rust.path = ./rust;
  };
}
