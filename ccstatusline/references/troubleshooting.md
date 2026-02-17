# Claude Code Status Line Troubleshooting Guide

## Common Issues and Solutions

### Issue 1: Status Line Not Showing Anything

**Symptoms**:
- Status line area is blank/empty
- No error messages displayed

**Possible Causes**:

1. **ccstatusline not installed**:
   ```bash
   # Check installation
   which ccstatusline
   # or
   ccstatusline --help
   ```

2. **Claude Code configuration incorrect**:
   - Check `~/.claude/settings.json` (or `%USERPROFILE%\.claude\settings.json` on Windows)
   - Verify `statusLine.command` is set to `"ccstatusline"`

3. **Claude Code not restarted**:
   - Configuration changes require restart
   - Ensure all Claude Code processes are terminated

4. **Terminal compatibility issues**:
   - Some terminals may not support status line feature
   - Try a different terminal (Windows Terminal, PowerShell, iTerm2, etc.)

**Solutions**:

1. **Install/verify ccstatusline**:
   ```bash
   npm install -g ccstatusline
   echo '{"model": {"display_name": "test"}}' | ccstatusline
   ```

2. **Verify configuration**:
   ```bash
   # Check configuration file
   cat ~/.claude/settings.json | grep -A3 -B3 statusLine
   ```

3. **Complete restart**:
   - Close all Claude Code windows
   - Check process list for any `claude` processes
   - Kill any remaining processes
   - Restart Claude Code

4. **Test in different terminal**:
   - Try Windows Terminal if using cmd/PowerShell
   - Try iTerm2 if using macOS Terminal
   - Try different terminal emulator on Linux

### Issue 2: Status Line Shows Raw Text

**Symptoms**:
- Displays literal text like `"\u@\h:\w\$(git branch...)"`
- Shows unparsed command strings

**Cause**:
- Claude Code configuration contains custom shell commands with escape sequences
- These sequences are not being interpreted by ccstatusline

**Solution**:
1. **Replace custom commands with ccstatusline**:
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "ccstatusline"
     }
   }
   ```

2. **Remove any platform-specific commands**:
   - Remove PowerShell/bash commands
   - Remove environment variable expansions
   - Remove Git command pipelines

3. **Use provided setup scripts**:
   ```powershell
   # Windows
   .\scripts\setup-windows.ps1
   ```
   ```bash
   # Unix/Linux/macOS
   ./scripts/setup-unix.sh
   ```

### Issue 3: Missing Git Information

**Symptoms**:
- Status line shows model info but no Git branch/changes
- Git repository not detected

**Possible Causes**:

1. **Not in Git repository**:
   ```bash
   git status  # Check if in Git repo
   ```

2. **Git not installed**:
   ```bash
   git --version
   ```

3. **Git not in PATH**:
   - Windows: Git may not be added to PATH during installation
   - Verify `git` command works in terminal

4. **ccstatusline Git module disabled**:
   - Check ccstatusline configuration
   - Verify `git-branch` and `git-changes` modules are included

**Solutions**:

1. **Verify Git repository**:
   ```bash
   cd /path/to/project
   git status
   ```

2. **Install Git**:
   - Windows: Download from https://git-scm.com/
   - macOS: `brew install git`
   - Linux: `sudo apt-get install git` (Ubuntu/Debian)

3. **Check Git PATH**:
   ```bash
   which git  # Unix/Linux/macOS
   where git  # Windows
   ```

4. **Enable Git modules**:
   Edit `~/.config/ccstatusline/settings.json`:
   ```json
   {
     "lines": [
       [
         {"id": "1", "type": "model", "color": "cyan"},
         {"id": "2", "type": "separator"},
         {"id": "3", "type": "git-branch", "color": "magenta"},
         {"id": "4", "type": "separator"},
         {"id": "5", "type": "git-changes", "color": "yellow"}
       ]
     ]
   }
   ```

### Issue 4: Powerline Glyphs Not Displaying

**Symptoms**:
- Powerline separators show as empty boxes or question marks
- Missing or incorrect characters

**Cause**:
- Terminal font doesn't include Powerline glyphs
- Font not configured in terminal settings

**Solutions**:

1. **Install Powerline-patched font**:
   - **Windows**: Install "Cascadia Code PL" or "Fira Code Retina"
   - **macOS**: `brew install --cask font-fira-code-nerd-font`
   - **Ubuntu/Debian**: `sudo apt-get install fonts-powerline`
   - **Fedora**: `sudo dnf install powerline-fonts`

2. **Configure terminal to use Powerline font**:
   - Windows Terminal: Settings → Profiles → Font face
   - PowerShell: Properties → Font
   - iTerm2: Preferences → Profiles → Text → Font
   - GNOME Terminal: Edit → Preferences → Text → Custom font

3. **Test font installation**:
   ```bash
   echo -e "\uE0B0"  # Should show Powerline right triangle
   ```

4. **Fallback: Disable Powerline**:
   Edit ccstatusline configuration:
   ```json
   {
     "powerline": {
       "enabled": false
     }
   }
   ```

### Issue 5: Colors Not Working

**Symptoms**:
- Status line shows in monochrome
- Colors appear incorrect or distorted
- Text is hard to read due to poor contrast

**Possible Causes**:

1. **Terminal doesn't support colors**:
   - Basic terminals may not support 256 colors
   - Color support disabled

2. **NO_COLOR environment variable set**:
   ```bash
   echo $NO_COLOR
   ```

3. **ccstatusline colorLevel setting**:
   - May be set too low for terminal capabilities

4. **Terminal color scheme issues**:
   - Background/foreground color conflicts
   - Colors not suitable for current theme (dark/light)

5. **Theme compatibility problems**:
   - Using dark text on dark background
   - Using light text on light background
   - Poor contrast for current terminal theme

**Solutions**:

1. **Check terminal color support**:
   ```bash
   # Test 256 colors
   for i in {0..255}; do printf "\e[48;5;${i}m  \e[0m"; done
   ```

2. **Unset NO_COLOR**:
   ```bash
   unset NO_COLOR
   # or in PowerShell
   Remove-Item Env:\NO_COLOR
   ```

3. **Adjust colorLevel**:
   Edit ccstatusline configuration:
   ```json
   {
     "colorLevel": 2  # 0: no color, 1: 16 colors, 2: 256 colors, 3: true color
   }
   ```

4. **Theme-aware color adjustment**:
   - **For dark themes**: Use light text colors (`white`, `brightWhite`) with dark backgrounds
   - **For light themes**: Use dark text colors (`black`, `brightBlack`) with light backgrounds
   - **Universal**: Test with both themes, ask user if unsure

   Example fix for dark theme:
   ```json
   {
     "id": "1",
     "type": "model",
     "color": "white",        // Changed from black
     "background": "blue",
     "bold": true
   }
   ```

5. **Test with basic colors**:
   ```bash
   echo '{"model": {"display_name": "test"}}' | ccstatusline
   ```

### Issue 6: Performance Issues

**Symptoms**:
- Status line updates slowly
- High CPU usage when status line active
- Lag in Claude Code interface

**Possible Causes**:

1. **Git operations on large repositories**:
   - Git status operations may be slow
   - Repository with many files or submodules

2. **Frequent status line updates**:
   - Too many updates per second
   - Resource-intensive modules

3. **System resource constraints**:
   - Low memory or CPU
   - Multiple instances running

**Solutions**:

1. **Simplify configuration**:
   ```json
   {
     "lines": [[
       {"id": "1", "type": "model", "color": "cyan"}
     ]]
   }
   ```

2. **Disable Git modules**:
   Remove `git-branch` and `git-changes` from configuration

3. **Use caching if supported**:
   Check ccstatusline documentation for caching options

4. **Reduce update frequency**:
   - Some terminals allow controlling status line update rate
   - Check terminal settings

### Issue 7: Platform-Specific Issues

#### Windows Specific

**Problem**: PowerShell execution policy restricts script execution

**Solution**:
```powershell
# Set execution policy for current user
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Or run script with bypass
powershell -ExecutionPolicy Bypass -File .\scripts\setup-windows.ps1
```

**Problem**: Windows Terminal not displaying colors correctly

**Solution**:
1. Update Windows Terminal to latest version
2. Enable "Use acrylic material" in settings
3. Check color scheme compatibility

#### macOS Specific

**Problem**: Font rendering issues in Terminal.app

**Solution**:
1. Use iTerm2 instead of Terminal.app
2. Install and configure nerd-fonts
3. Adjust anti-aliasing settings

**Problem**: Homebrew installation issues

**Solution**:
```bash
# Reinstall Node.js/npm via Homebrew
brew reinstall node
npm install -g ccstatusline
```

#### Linux Specific

**Problem**: Permission issues with global npm installation

**Solution**:
```bash
# Fix npm permissions
sudo chown -R $USER:$USER ~/.npm
# or use npm config
npm config set prefix ~/.npm-global
```

**Problem**: Different terminal emulators (GNOME, Konsole, etc.)

**Solution**:
- Test with multiple terminal emulators
- Check emulator-specific configuration

### Issue 8: Configuration File Errors

**Symptoms**:
- ccstatusline fails to start
- JSON parsing errors
- Missing or malformed configuration

**Diagnosis**:

1. **Check configuration file syntax**:
   ```bash
   python3 -m json.tool ~/.config/ccstatusline/settings.json
   ```

2. **Validate with jq**:
   ```bash
   jq empty ~/.config/ccstatusline/settings.json
   ```

3. **Test with minimal configuration**:
   ```bash
   echo '{"lines":[[{"id":"1","type":"model","color":"cyan"}]]}' | ccstatusline
   ```

**Solutions**:

1. **Fix JSON syntax**:
   - Ensure proper quoting
   - Check for trailing commas
   - Validate array/object structure

2. **Restore default configuration**:
   ```bash
   rm ~/.config/ccstatusline/settings.json
   echo '{"model": {"display_name": "test"}}' | ccstatusline
   ```

3. **Use example configuration**:
   Copy `assets/example-config.json` to configuration location

### Issue 9: Claude Code Version Compatibility

**Symptoms**:
- Status line works in some versions but not others
- Different behavior between updates

**Diagnosis**:

1. **Check Claude Code version**:
   ```bash
   claude --version
   ```

2. **Review changelog** for status line changes

3. **Test with minimal configuration**

**Solutions**:

1. **Update Claude Code**:
   ```bash
   # Check for updates
   claude --update-check
   ```

2. **Use compatible configuration**:
   - Stick to basic `statusLine.command` format
   - Avoid experimental features

3. **Report issues**:
   - GitHub: https://github.com/anthropics/claude-code
   - Include version information and configuration

### General Troubleshooting Steps

1. **Isolate the issue**:
   ```bash
   # Test ccstatusline independently
   echo '{"model": {"display_name": "test"}}' | ccstatusline
   ```

2. **Check logs**:
   - Claude Code may have debug logs
   - Check terminal output for error messages
   - Look for crash reports

3. **Minimal test case**:
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "echo 'test'"
     }
   }
   ```

4. **Environment variables**:
   ```bash
   # Check relevant environment variables
   echo "PATH: $PATH"
   echo "NODE_PATH: $NODE_PATH"
   echo "NO_COLOR: $NO_COLOR"
   ```

5. **Reinstall components**:
   ```bash
   # Clean reinstall
   npm uninstall -g ccstatusline
   npm cache clean --force
   npm install -g ccstatusline
   ```

6. **Seek community help**:
   - Claude Code GitHub issues
   - Stack Overflow
   - Developer forums

### Getting Help

If issues persist:

1. **Collect diagnostic information**:
   ```bash
   # System information
   uname -a
   node --version
   npm --version
   claude --version

   # Configuration
   cat ~/.claude/settings.json
   cat ~/.config/ccstatusline/settings.json 2>/dev/null || echo "No ccstatusline config"
   ```

2. **Document the issue**:
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Screenshots if applicable

3. **Search for similar issues**:
   - Check GitHub issues for ccstatusline
   - Search Claude Code documentation
   - Look for platform-specific solutions