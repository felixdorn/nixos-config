{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.packages = [
    pkgs.fd # for telescope
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

    plugins.treesitter = {
      # URL: <https://github.com/nvim-treesitter/nvim-treesitter>
      enable = true;
      ensureInstalled = "all";
      nixvimInjections = true; # Enables nixvim specific injections, like lua highlighting in extraConfigLua.
      indent = true;
    };

    plugins.telescope = {
      # URL: <https://github.com/nvim-telescope/telescope.nvim>
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

            layout_config = {
              width = 0.9;
              height = 0.9;
              mirror = false;
              preview_cutoff = 1;
              prompt_position = "top";
            };

            borderchars = {
              prompt = ["─" "│" " " "│" "╭" "╮" "│" "│"];
              results = ["─" "│" "─" "│" "├" "┤" "╯" "╰"];
              preview = ["─" "│" "─" "│" "╭" "╮" "╯" "╰"];
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

      keymaps.lspBuf = {
        K = "hover";
        gD = "declaration";
        "<C-k>" = "signature_help";
        "<leader>rn" = "rename";
        "<leader>ca" = "code_action";
      };

      keymaps.extra = [
        {
          key = "gd";
          action = "require('telescope.builtin').lsp_definitions";
          lua = true;
        }
        {
          key = "<leader>D";
          action = "require('telescope.builtin').lsp_type_definitions";
          lua = true;
        }
        {
          key = "gr";
          action = "require('telescope.builtin').lsp_references";
          lua = true;
        }
        {
          key = "gi";
          action = "require('telescope.builtin').lsp_implementations";
          lua = true;
        }
      ];

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
        gopls = {
          enable = true;
          onAttach.function = ''
                if not client.server_capabilities.semanticTokensProvider then
                    local semantic = client.config.capabilities.textDocument.semanticTokens
                        client.server_capabilities.semanticTokensProvider = {
                            full = true,
                            legend = {
                                tokenTypes = semantic.tokenTypes,
                                tokenModifiers = semantic.tokenModifiers,
                            },
                            range = true,
                        }
            end
          '';
          extraOptions = {
            settings = {
              gopls = {
                codelenses = {
                  gc_details = false;
                  generate = true;
                  regenerate_cgo = true;
                  run_govulncheck = true;
                  test = true;
                  tidy = true;
                  upgrade_dependency = true;
                  vendor = true;
                };
                hints = {
                  assignVariableTypes = true;
                  compositeLiteralFields = true;
                  compositeLiteralTypes = true;
                  constantValues = true;
                  functionTypeParameters = true;
                  parameterNames = true;
                  rangeVariableTypes = true;
                };
                analyses = {
                  fieldalignment = true;
                  nilness = true;
                  unusedparams = true;
                  unusedwrite = true;
                  useany = true;
                };
                usePlaceholders = true;
                completeUnimported = true;
                staticcheck = true;
                directoryFilters = ["-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules"];
                semanticTokens = true;
              };
            };
          };
        };
        jsonls.enable = true;
        emmet_ls.enable = true;
      };
    };

    plugins.lsp-format = {
      enable = true;
    };

    # URL: <https://github.com/nvimtools/none-ls.nvim>
    plugins.none-ls = {
      enable = true;
      enableLspFormat = true;
      updateInInsert = true;
      # See: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
      sources = {
        code_actions = {
          gomodifytags.enable = true;
          impl.enable = true;
          statix.enable = true;
        };

        diagnostics = {
          actionlint.enable = true;
          buf.enable = true;
          checkmake.enable = true;
          codespell.enable = true;
          cppcheck.enable = true;
          dotenv_linter.enable = true;
          editorconfig_checker.enable = true;
          golangci_lint.enable = true;
          hadolint.enable = true;
          ltrs.enable = true;
          phpstan.enable = true;
          protolint.enable = true;
          revive.enable = true;
          sqlfluff.enable = true;
          statix.enable = true;
          stylelint.enable = true;
          tidy.enable = true;
          trail_space.enable = true;
        };

        formatting = {
          # Nix
          alejandra.enable = true;

          # Python
          blackd.enable = true;

          # Go
          gofumpt.enable = true;
          goimports_reviser.enable = true;
          golines.enable = true;

          # JS
          prettier.enable = true;
          prettier.disableTsServerFormatter = true;
        };
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
        key = "<leader>pv";
        action = "<CMD>Oil<CR>";
        options.desc = "Open filetree";
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
