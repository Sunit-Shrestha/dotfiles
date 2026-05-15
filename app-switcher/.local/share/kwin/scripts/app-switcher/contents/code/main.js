function switchOrLaunch(
  workspaceNumber,
  windowClass,
  windowTitle,
  focusFlag,
  command,
) {
  //
  //
  // 2. Search windows
  //
  const clients = workspace.windowList();
  const desktops = workspace.desktops;

  for (const client of clients) {
    const resourceClass = client.resourceClass || "";
    const caption = client.caption || "";

    //
    // Match class
    // Equivalent to:
    // wmctrl -lx exact class match
    //
    const classMatch = resourceClass
      .toLowerCase()
      .includes(windowClass.toLowerCase());

    //
    // Match title substring
    //
    const titleMatch =
      windowTitle === "" ||
      caption.toLowerCase().startsWith(windowTitle.toLowerCase());

    if (classMatch && titleMatch) {
      print("Found matching window: " + caption);

      //
      // 3. Focus if requested
      //
      if (focusFlag) {
        workspace.activeWindow = client;

        client.raiseWindow();
        client.demandsAttention = false;

        print("Focused window.");
      } else {
        if (workspaceNumber >= 1 && workspaceNumber <= desktops.length) {
          workspace.currentDesktop = desktops[workspaceNumber - 1];
        }
        print("Window found, focus not requested.");
      }

      return;
    }
  }

  //
  // 4. Launch command if not found
  //
  print("No matching window found. Launching: " + command);

  // 1. Switch workspace
  //

  if (workspaceNumber >= 1 && workspaceNumber <= desktops.length) {
    workspace.currentDesktop = desktops[workspaceNumber - 1];
  }

  callDBus(
    "com.user.DesktopLauncher",
    "/DesktopLauncher",
    "com.user.DesktopLauncher",
    "Launch",
    command,
  );
}

//
// Example usages
//

registerShortcut(
  "SwitchToBrave",
  "Switch To Brave",
  "Meta+Ctrl+J",
  function () {
    switchOrLaunch(
      2, // workspace
      "brave", // class
      "", // title substring
      false, // focus flag
      "brave", // launch command
    );
  },
);

registerShortcut("SwitchToCode", "Switch To Code", "Meta+Ctrl+K", function () {
  switchOrLaunch(
    3, // workspace
    "code", // class
    "", // title substring
    true, // focus flag
    "vscode", // launch command
  );
});

registerShortcut(
  "SwitchToDolphin",
  "Switch To Dolphin",
  "Meta+Ctrl+F",
  function () {
    switchOrLaunch(
      1, // workspace
      "dolphin", // class
      "", // title substring
      true, // focus flag
      "dolphin", // launch command
    );
  },
);

registerShortcut(
  "SwitchToObsidian",
  "Switch To Obsidian",
  "Meta+Ctrl+N",
  function () {
    switchOrLaunch(
      3, // workspace
      "obsidian", // class
      "", // title substring
      true, // focus flag
      "obsidian", // launch command
    );
  },
);

registerShortcut(
  "SwitchToOkular",
  "Switch To Okular",
  "Meta+Ctrl+I",
  function () {
    switchOrLaunch(
      1, // workspace
      "okular", // class
      "", // title substring
      true, // focus flag
      "okular", // launch command
    );
  },
);

registerShortcut(
  "SwitchToSpotify",
  "Switch To Spotify",
  "Meta+Ctrl+M",
  function () {
    switchOrLaunch(
      3, // workspace
      "spotify", // class
      "", // title substring
      true, // focus flag
      "spotify", // launch command
    );
  },
);

registerShortcut(
  "SwitchToKitty",
  "Switch To Kitty",
  "Meta+Ctrl+.",
  function () {
    switchOrLaunch(
      3, // workspace
      "kitty", // class
      "Terminal", // title substring
      true, // focus flag
      "kitty", // launch command
    );
  },
);

registerShortcut("SwitchToYazi", "Switch To Yazi", "Meta+Ctrl+L", function () {
  switchOrLaunch(
    1, // workspace
    "kitty", // class
    "Yazi", // title substring
    true, // focus flag
    "yazi", // launch command
  );
});
