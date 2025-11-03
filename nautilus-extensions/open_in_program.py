import os
import subprocess

from gi.repository import Nautilus, GObject

# ============================
# CONFIGURATION
# ============================

# List of programs to appear in the menu
# Format: "Display Name": "command"
# Use full path if needed, or just command if in PATH
PROGRAMS = {
    "IntelliJ IDEA": "/snap/bin/intellij-idea-ultimate",
    "VS Code": "/usr/bin/code",
}

# ============================
# USAGE
# ============================
#
# Place it inside $HOME/.local/share/nautilus-python/extensions

# ============================
# EXTENSION
# ============================

class OpenInProgramExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        super().__init__()

    def get_background_items(self, current_folder):
        """
        Triggered when right-clicking the background of a folder.
        Returns a list of Nautilus.MenuItem objects.
        """
        items = []
        folder_path = self._get_path(current_folder)

        for name, command in PROGRAMS.items():
            item = Nautilus.MenuItem(
                name=f"OpenInProgramExtension::{name.replace(' ', '')}",
                label=f"Open in {name}",
                tip=f"Open directory in {name}"
            )
            item.connect('activate', self.open_folder, folder_path, command)
            items.append(item)
        return items

    def open_folder(self, menu, folder_path, command):
        """
        Open the folder using the specified command.
        """
        if not os.path.exists(folder_path):
            print(f"Folder does not exist: {folder_path}")
            return

        try:
            subprocess.Popen([command, folder_path])
        except Exception as e:
            print(f"Failed to open {folder_path} with {command}: {e}")

    def _get_path(self, file_obj):
        """
        Returns the filesystem path of the Nautilus.FileInfo object
        """
        try:
            return file_obj.get_location().get_path()
        except AttributeError:
            return file_obj.get_path()
