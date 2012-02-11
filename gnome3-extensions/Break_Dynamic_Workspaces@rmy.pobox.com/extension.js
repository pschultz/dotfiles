// Copyright (C) 2011 R M Yorston
// Licence: GPLv2+

const Main = imports.ui.main;

function main() {
    Main._nWorkspacesChanged = function() {};
    Main._queueCheckWorkspaces = function() {};
    Main._checkWorkspaces = function() {};

    if ( global.screen.n_workspaces == 1 ) {
        global.screen.append_new_workspace(false, global.get_current_time());
        global.screen.append_new_workspace(false, global.get_current_time());
        global.screen.append_new_workspace(false, global.get_current_time());
    }
}
