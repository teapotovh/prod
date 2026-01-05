let
  pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
in pkgs.mkShell {
  buildInputs = with pkgs; [
      kubectl
      kubernetes-helm
      k9s
      kubeseal
  ];
}
