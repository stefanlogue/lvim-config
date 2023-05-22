local kind = require('user.kind')

local wk = lvim.builtin.which_key

wk.mappings["a"] = { ":Alpha<cr>", kind.icons.screen .. " Dashboard" }

wk.mappings[";"] = { "<cmd>Neotree action=focus<CR>", "Explorer" }

wk.mappings["g"] = { "<cmd>Neotree float git_status<CR>", "Git Status" }

wk.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

wk.mappings["S"] = { "<cmd>Telescope simulators run<CR>", "Simulators" }

wk.mappings["P"] = {
  name = " persistence",
  s = { "<cmd>lua require('persistence').load()<cr>", kind.icons.clock .. " Reload last session for dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", kind.icons.clock .. " Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", kind.icons.exit .. " Quit without saving session" },
}

wk.mappings["G"] = {
  name = ' ' .. kind.icons.hint .. " Github Copilot",
  a = { ":lua require('copilot.suggestion').accept()<cr>", "Accept" },
  n = { ":lua require('copilot.suggestion').next()<cr>", "Next" },
  N = { ":lua require('copilot.suggestion').prev()<cr>", "Prev" },
  d = { ":lua require('copilot.suggestion').dismiss()<cr>", "Dismiss" },
  t = { ":lua require('copilot.suggestion').toggle_auto_trigger()<cr>", "Toggle Auto Trigger" },
}

wk.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  t = { "<cmd>TroubleToggle<cr>", "Toggle" },
}

wk.mappings["e"] = {
  name = "+Explorer",
  g = { "<cmd>Neotree float git_status<cr>", "Git Status" },
  f = { "<cmd>Neotree find_file<cr>", "Find File" },
}

-- wk.mappings["m"] = {
--   name = "+Minimap",
--   o = { "<cmd>Minimap<cr>", "Open" },
--   c = { "<cmd>MinimapClose<cr>", "Close" },
--   m = { "<cmd>MinimapToggle<cr>", "Toggle" },
--   r = { "<cmd>MinimapRefresh<cr>", "Refresh" },
--   u = { "<cmd>MinimapUpdateHighlight<cr>", "Update Highlight" },
--   s = { "<cmd>MinimapRescan<cr>", "Rescan" },
-- }
