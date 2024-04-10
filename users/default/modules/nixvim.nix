{ pkgs, ... }: {
 programs.nixvim = {
   enable = true;

   viAlias = true;
   vimAlias = true;

   colorschemes.gruvbox.enable = true;

   options = {
     relativenumber = true;
     shiftwidth = 2;
   };

   globals.mapleader = " ";

   plugins = {
     treesitter.enable = true;
     telescope.enable = true;
     lualine.enable = true;
     oil.enable = true;
     luasnip.enable = true;
     nvim-colorizer.enable = true;

     lsp = {
       enable = true;
       servers = {
         lua-ls = {
	   enable = true;
	   settings.telemetry.enable = false;
	 };
	 html.enable = true;
	 tsserver.enable = true;
	 tailwindcss.enable = true;
	 phpactor.enable = true;
	 cssls.enable = true;
	 bashls.enable = true;
	 gopls.enable = true;
	 jsonls.enable = true;
	 emmet_ls.enable = true;
       };
     };

     cmp = {
       enable = true;
	autoEnableSources = true;
	settings = {
	mapping = {
	  "<CR>" = "cmp.mapping.confirm({ select = true })";
	  "<Tab>" = ''
	    function(fallback)
	    if cmp.visible() then
	      cmp.select_next_item()
	    else
	      fallback()
		end
		end
		'';
	};
	};
     };

        keymaps = [
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>g";
    }
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>o";
    }
    ];
   };
 };
};
