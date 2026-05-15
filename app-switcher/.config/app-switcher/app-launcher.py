#!/usr/bin/env python3

import logging
import os
import subprocess

import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib

logging.basicConfig(level=logging.INFO, format="[DesktopLauncher] %(message)s")

BUS_NAME = "com.user.DesktopLauncher"
OBJ_PATH = "/DesktopLauncher"

SYSTEM_DESKTOP_DIRS = [
    "/usr/share/applications/",
    "/usr/local/share/applications/",
]

USER_DESKTOP_DIR = os.path.expanduser("~/.local/share/applications/")


class DesktopLauncher(dbus.service.Object):

    ALLOWED_APPS = {
        "brave": "brave-browser.desktop",
        "vscode": "code.desktop",
        "dolphin": "org.kde.dolphin.desktop",
        "okular": "org.kde.okular.desktop",
        "spotify": "spotify.desktop",
        "kitty": "kitty.desktop",
        "obsidian": "obsidian.desktop",
        "yazi": "yazi.desktop",
    }

    def _resolve_desktop(self, desktop_name: str) -> str | None:
        """
        Resolve only whitelisted keys → .desktop files
        """

        if desktop_name not in self.ALLOWED_APPS:
            logging.warning(f"DENIED unknown app key: {desktop_name}")
            return None

        file_name = self.ALLOWED_APPS[desktop_name]

        # safety: still enforce format
        if "/" in file_name:
            logging.warning(f"DENIED Invalid desktop entry path: {file_name}")
            return None

        # search system + user dirs
        user_path = os.path.join(USER_DESKTOP_DIR, file_name)
        if os.path.isfile(user_path):
            return user_path

        for d in SYSTEM_DESKTOP_DIRS:
            path = os.path.join(d, file_name)
            if os.path.isfile(path):
                return path

        logging.error(f"Desktop file not found: {file_name}")
        return None

    @dbus.service.method(
        "com.user.DesktopLauncher",
        in_signature="s",
        out_signature="b",
    )
    def Launch(self, app_key):

        path = self._resolve_desktop(app_key)

        if not path:
            logging.error(f"Launch denied for: {app_key}")
            return False

        try:
            # app_id = os.path.basename(path).replace(".desktop", "")
            app_id = path

            env = os.environ.copy()
            subprocess.Popen(
                ["kioclient", "exec", app_id],
                start_new_session=True,
                env=env,
            )

            logging.info(f"Launched: {app_key} → {path}")
            return True

        except Exception as e:
            logging.exception(f"Launch failed: {e}")
            return False


# start DBus service
DBusGMainLoop(set_as_default=True)

bus = dbus.SessionBus()

name = dbus.service.BusName(
    BUS_NAME,
    bus,
)

DesktopLauncher(bus, OBJ_PATH)

logging.info("DesktopLauncher daemon running...")
GLib.MainLoop().run()
