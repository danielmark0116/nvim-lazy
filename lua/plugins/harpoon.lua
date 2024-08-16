return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  keys = {
    {
      "<leader>H",
      function()
        require("harpoon"):list():append()
      end,
      desc = "harpoon file",
    },
    {
      "<leader>a",
      function()
        -- NOTE: non-telescope version
        -- local harpoon = require("harpoon")
        -- harpoon.ui:toggle_quick_menu(harpoon:list())

        -- NOTE: telescope version
        local harpoon = require("harpoon")
        local conf = require("telescope.config").values

        -- NOTE: telescope version with default config
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          local finder = function()
            local paths = {}
            for _, item in ipairs(harpoon_files.items) do
              table.insert(paths, item.value)
            end

            return require("telescope.finders").new_table({
              results = paths,
            })
          end

          require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
              layout_config = {
                height = 0.7,
                width = 0.85,
                prompt_position = "top",
                preview_cutoff = 120,
              },
              attach_mappings = function(prompt_bufnr, map)
                map({ "n" }, "d", function()
                  local state = require("telescope.actions.state")
                  local selected_entry = state.get_selected_entry()
                  local current_picker = state.get_current_picker(prompt_bufnr)

                  table.remove(harpoon_files.items, selected_entry.index)
                  current_picker:refresh(finder())
                end)
                return true
              end,
            })
            :find()
        end

        -- NOTE: telescope version with custom config and deleting entries

        -- local pickers = require("telescope.pickers")
        -- local themes = require("telescope.themes")
        -- local finders = require("telescope.finders")
        -- local actions = require("telescope.actions")
        -- local action_state = require("telescope.actions.state")
        -- local function list_indexOf(list, predicate)
        --   for i, v in ipairs(list) do
        --     if predicate(v) then
        --       return i
        --     end
        --   end
        --   return -1
        -- end
        --
        -- local function generate_new_finder(harpoon_files)
        --   local files = {}
        --   for i, item in ipairs(harpoon_files.items) do
        --     table.insert(files, i .. ". " .. item.value)
        --   end
        --
        --   return finders.new_table({
        --     results = files,
        --   })
        -- end
        --
        -- -- move_mark_up will move the mark up in the list, refresh the picker's result list and move the selection accordingly
        -- local function move_mark_up(prompt_bufnr, harpoon_files)
        --   local selection = action_state.get_selected_entry()
        --   if not selection then
        --     return
        --   end
        --   if selection.index == 1 then
        --     return
        --   end
        --
        --   local mark = harpoon_files.items[selection.index]
        --
        --   table.remove(harpoon_files.items, selection.index)
        --   table.insert(harpoon_files.items, selection.index - 1, mark)
        --
        --   local current_picker = action_state.get_current_picker(prompt_bufnr)
        --   current_picker:refresh(generate_new_finder(harpoon_files), {})
        --
        --   -- yes defer_fn is an awful solution. If you find a better one, please let the world know.
        --   -- it's used here because we need to wait for the picker to refresh before we can set the selection
        --   -- actions.move_selection_previous() doesn't work here because the selection gets reset to 0 on every refresh.
        --   vim.defer_fn(function()
        --     -- don't even bother finding out why this is -2 here. (i don't know either)
        --     current_picker:set_selection(selection.index - 2)
        --   end, 2) -- 2ms was the minimum delay I could find that worked without glitching out the picker
        -- end
        --
        -- -- move_mark_down will move the mark down in the list, refresh the picker's result list and move the selection accordingly
        -- local function move_mark_down(prompt_bufnr, harpoon_files)
        --   local selection = action_state.get_selected_entry()
        --   if not selection then
        --     return
        --   end
        --
        --   local length = harpoon:list():length()
        --   if selection.index == length then
        --     return
        --   end
        --
        --   local mark = harpoon_files.items[selection.index]
        --
        --   table.remove(harpoon_files.items, selection.index)
        --   table.insert(harpoon_files.items, selection.index + 1, mark)
        --
        --   local current_picker = action_state.get_current_picker(prompt_bufnr)
        --   current_picker:refresh(generate_new_finder(harpoon_files), {})
        --
        --   -- yes defer_fn is an awful solution. If you find a better one, please let the world know.
        --   -- it's used here because we need to wait for the picker to refresh before we can set the selection
        --   -- actions.move_selection_next() doesn't work here because the selection gets reset to 0 on every refresh.
        --   vim.defer_fn(function()
        --     current_picker:set_selection(selection.index)
        --   end, 2) -- 2ms was the minimum delay I could find that worked without glitching out the picker
        -- end
        --
        -- local function toggle_telescope(harpoon_files)
        --   pickers
        --     .new(
        --       themes.get_dropdown({
        --         --TODO: make previewer work.
        --         previewer = false,
        --       }),
        --       {
        --         prompt_title = "Harpoon",
        --         finder = generate_new_finder(harpoon_files),
        --         previewer = conf.file_previewer({}),
        --         sorter = conf.generic_sorter({}),
        --         -- Initial mode, change this to your liking. Normal mode is better for navigating with j/k
        --         initial_mode = "normal",
        --         -- Make telescope select buffer from harpoon list
        --         attach_mappings = function(_, map)
        --           actions.select_default:replace(function(prompt_bufnr)
        --             local curr_entry = action_state.get_selected_entry()
        --             if not curr_entry then
        --               return
        --             end
        --             actions.close(prompt_bufnr)
        --
        --             harpoon:list():select(curr_entry.index)
        --           end)
        --           -- Delete entries in insert mode from harpoon list with <C-d>
        --           -- Change the keybinding to your liking
        --           map({ "n", "i" }, "<C-d>", function(prompt_bufnr)
        --             local curr_picker = action_state.get_current_picker(prompt_bufnr)
        --             curr_picker:delete_selection(function(selection)
        --               local mark_idx = list_indexOf(harpoon_files.items, function(v)
        --                 return v.value == selection[1]
        --               end)
        --               if mark_idx == -1 then
        --                 return
        --               end
        --
        --               harpoon:list():removeAt(mark_idx)
        --             end)
        --           end)
        --           -- Move entries up and down with <C-j> and <C-k>
        --           -- Change the keybinding to your liking
        --           map({ "n", "i" }, "<C-j>", function(prompt_bufnr)
        --             move_mark_down(prompt_bufnr, harpoon_files)
        --           end)
        --           map({ "n", "i" }, "<C-k>", function(prompt_bufnr)
        --             move_mark_up(prompt_bufnr, harpoon_files)
        --           end)
        --
        --           return true
        --         end,
        --       }
        --     )
        --     :find()
        -- end

        toggle_telescope(harpoon:list())
      end,
      desc = "harpoon quick menu",
    },
    {
      "<leader>1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "harpoon to file 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "harpoon to file 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "harpoon to file 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "harpoon to file 4",
    },
    {
      "<leader>5",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "harpoon to file 5",
    },
  },
}
