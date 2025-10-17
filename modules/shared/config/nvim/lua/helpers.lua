local helpers = {}

local spec_comment_lines = { "-- $> hspec spec", "" }

local function add_hspec_comments()
  local function add_hspec_comment(search_string, comment_lines)
    local search_result = vim.fn.search(search_string)

    if search_result > 0 then
      local existing_comments_result = vim.fn.search(comment_lines[1], "n")

      if existing_comments_result > 0 then return true end

      vim.api.nvim_buf_set_lines(0, search_result - 1, search_result - 1, true, comment_lines)
      vim.cmd.write()
      return true
    end
    return false
  end

  local has_spec_comment = add_hspec_comment(":: Spec$", spec_comment_lines)

  if not has_spec_comment then add_hspec_comment(":: SpecWeb$", spec_comment_lines) end
end

local function delete_hspec_comments()
  local function table_length(T)
    local count = 0
    for _ in pairs(T) do
      count = count + 1
    end
    return count
  end

  local function delete_hspec_comment(comment_lines)
    local num_lines = table_length(comment_lines)
    local search_result = vim.fn.search(comment_lines[1])

    if search_result > 0 then
      vim.api.nvim_buf_set_lines(0, search_result - 1, search_result + (num_lines - 1), true, {})
      vim.cmd.write()
    end
  end

  delete_hspec_comment(spec_comment_lines)
end

function helpers.toggle_hspec_comments()
  -- Check if we have an eval line in this file
  local search_result = vim.fn.search "-- $> hspec"
  if search_result > 0 then
    delete_hspec_comments()
  else
    add_hspec_comments()
  end
end

function helpers.get_visual_selection()
  local current_clipboard_content = vim.fn.getreg '"'

  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})

  vim.fn.setreg('"', current_clipboard_content)

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

return helpers
