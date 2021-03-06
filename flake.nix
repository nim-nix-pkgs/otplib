{
  description = ''Easy to use OTP library for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."otplib-master".dir   = "master";
  inputs."otplib-master".owner = "nim-nix-pkgs";
  inputs."otplib-master".ref   = "master";
  inputs."otplib-master".repo  = "otplib";
  inputs."otplib-master".type  = "github";
  inputs."otplib-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."otplib-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}