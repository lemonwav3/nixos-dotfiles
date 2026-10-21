{ ... }:
{
  programs.nvf = {
    enable = true;
    settings.vim = {
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      lsp.enable = true;

      languages = {
        enableTreesitter = true;
        nix.enable = true;
        typescript.enable = true;
        rust.enable = true;
        python.enable = true;
      };
    };
  };
}
