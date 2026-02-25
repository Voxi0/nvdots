## try it
first install Nix and then run the following command to temporarily try out nvdots. it looks complex because the two lines after `nix run` is making sure that cachix is being used or else you'd have to compile neovim and it's plugins and all from source which would take a while. binary caches are far more faster and convenient.
```bash
nix run github:Voxi0/nvdots \
    --extra-trusted-public-keys nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs \
    --extra-substituters https://nix-community.cachix.org
    --experimental-features 'nix-command flakes'
```
