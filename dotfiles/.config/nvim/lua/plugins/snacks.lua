return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
        ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
        ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
        ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
        ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
        ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
        ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
 ]],
        keys = {

          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    bigfile = { enabled = true },
    indent = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      level = vim.log.levels.TRACE,
      replace = true,
    },
    explorer = {
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          exclude = { ".venv/", "undodir/", ".git/" },
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = { ".venv/", "undodir/", ".git/" },
        },
      }
    },
    quickfile = {
      exclude = { "lua", "python", "latex", "tex" },
    }
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fs", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
  },
}
