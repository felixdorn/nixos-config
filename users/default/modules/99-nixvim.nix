{ pkgs, inputs, ... }: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    defaultEditor = true;

    colorschemes.gruvbox.enable = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      scrolloff = 8;
      expandtab = true;
      smartindent = true;
    };

    autoCmd = [
      {
	event = "TextYankPost";
	group = "highlight_yank";
	command = "silent! lua vim.highlight.on_yank{higroup='Search', timeout=200}";
      }
    ];
    autoGroups.highlight_yank.clear = true;

    globals.mapleader = " ";

    plugins.treesitter = { # URL: <https://github.com/nvim-treesitter/nvim-treesitter>
      enable = true;
      ensureInstalled = "all"; 
      nixvimInjections = true; # Enables nixvim specific injections, like lua highlighting in extraConfigLua.  
	indent = true;
    };

    plugins.telescope = { # URL: <https://github.com/nvim-telescope/telescope.nvim>
      enable = true;

      keymaps = {
	"<leader>ff" = "find_files";
	"<leader>fg" = "live_grep";
	"<leader>fe" = "oldfiles";
	"<leader>fb" = "buffers";
      };

      settings = {
	defaults = {
	  file_ignore_patterns = [
	    "^.git/"
	      "^__pycache__/"
	  ];
	};

	pickers = {
	  find_files = {
	    hidden = true;
	    sorting_strategy = "ascending";
	    layout_strategy = "vertical";

	    layout_config =  { 
	      width = 0.9;
	      height = 0.9;
	      mirror = false;
	      preview_cutoff = 1;
	      prompt_position = "top";
	    };

	    borderchars = {
	      prompt  = [ "─" "│" " " "│" "╭" "╮" "│" "│" ];
	      results = [ "─" "│" "─" "│" "├" "┤" "╯" "╰" ];
	      preview = [ "─" "│" "─" "│" "╭" "╮" "╯" "╰" ];
	    };
	  };

	  oldfiles = {
	    previewer = false;

	    layout_config = {
	      width = 0.9;
	      prompt_position = "top";
	    };
	  };
	};
      };
    };

    # URL: <https://github.com/hiphish/rainbow-delimiters.nvim>
    plugins.rainbow-delimiters.enable = true;

    # URL: <https://github.com/mbbill/undotree>
    plugins.undotree = {
      enable = true;

      settings = {
	# https://github.com/mbbill/undotree/blob/0e11ba7325efbbb3f3bebe06213afa3e7ec75131/plugin/undotree.vim#L29
	WindowLayout = 3;
	SetFocusWhenToggle = true;
      };
    };

    plugins.lualine.enable = true;
    plugins.oil.enable = true;
    plugins.luasnip.enable = true;
    plugins.nvim-colorizer.enable = true;

    plugins.lsp = {
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
	sqls.enable = true;
	yamlls.enable = true;
	volar.enable = true;
	rust-analyzer = {
	  enable = true;
	  installCargo = true;
	  installRustc = true;
	};
	nixd.enable = true;
	dockerls.enable = true;
	bashls.enable = true;
	gopls.enable = true;
	jsonls.enable = true;
	emmet_ls.enable = true;
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
      {name = "nvim_lsp";}
      {name = "path";}
      {name = "buffer";}
      {name = "luasnip";}
      ];
    };

    keymaps = [
    {
      key = "<C-s>";
      action = "<CMD>w<CR>";
      options.desc = "Save";
    }
    {
      mode = "n";
      key = "<leader>tu";
      action = "<CMD>UndotreeToggle<CR>";
      options.desc = "Toggle undotree";
    }
    ];

    extraConfigVim = ''
     if has("persistent_undo")
  	  let target_path = expand('~/.cache/undodir')

	  " create the directory and any parent directories
	  " if the location does not exist.
	if !isdirectory(target_path)
	  call mkdir(target_path, "p", 0700)
	endif

	let &undodir=target_path
	set undofile
      endif
    '';
  };
		       }
