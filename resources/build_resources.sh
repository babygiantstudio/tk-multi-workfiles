#!/usr/bin/env bash
# 
# Copyright (c) 2013 Shotgun Software Inc.
# 
# CONFIDENTIAL AND PROPRIETARY
# 
# This work is provided "AS IS" and subject to the Shotgun Pipeline Toolkit 
# Source Code License included in this distribution package. See LICENSE.
# By accessing, using, copying or modifying this work you indicate your 
# agreement to the Shotgun Pipeline Toolkit Source Code License. All rights 
# not expressly granted therein are reserved by Shotgun Software Inc.

# The path to output all built .py files to: 
UI_PYTHON_PATH=../python/tk_multi_workfiles/ui


# Helper functions to build UI files
function build_qt {
    echo " > Building " $2
    
    # compile ui to python
    $1 $2 > $UI_PYTHON_PATH/$3.py
    
    # replace PySide imports with tank.platform.qt and remove line containing Created by date
    sed -i "" -e "s/from PySide import/from tank.platform.qt import/g" -e "/# Created:/d" $UI_PYTHON_PATH/$3.py
}

function build_ui {
    build_qt "pyside-uic --from-imports" "$1.ui" "$1"
}  

function build_res {
    build_qt "pyside-rcc" "$1.qrc" "$1_rc"
}


# build UI's:
echo "building user interfaces..."
build_ui select_work_area_form
build_ui work_files_form
build_ui change_version_form
build_ui save_as_form
build_ui open_file_form
build_ui new_task_form
build_ui file_item_form

# new UI's:
build_ui file_open_form
build_ui file_save_form
build_ui file_list_form
build_ui my_tasks_form
build_ui entity_tree_form
build_ui navigation_widget
build_ui search_widget
build_ui breadcrumb_widget
build_ui task_widget

build_ui test_form

build_ui file_tile
build_ui group_header_widget

build_ui file_group_widget

# build resources
echo "building resources..."
build_res resources