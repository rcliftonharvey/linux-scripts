#!/usr/bin/env bash

#
#   SHUTTLE LANDER SERVICE CONTROL SCRIPT -- START
#
# Shuttle Lander seems to auto-start its service from time to time,
# even if it was previously manually stopped. This can screw up the
# way the Contour Shuttle devices behave in apps which can natively
# handle them.
#
# My fix is to entirely deactivate its background service, and then
# start and stop it manually as required.
#
# This script manually starts the shuttleworker background service
# for Shuttle Lander, if it isn't running already.
#

SERVICE="shuttleworker.service"

if systemctl is-active --quiet "$SERVICE"; then
    echo "Shuttle Lander is already running."
else
    echo "Starting Shuttle Lander..."
    sudo systemctl start "$SERVICE"

    if systemctl is-active --quiet "$SERVICE"; then
        echo "Shuttle Lander started successfully."
    else
        echo "ERROR: Failed to start Shuttle Lander."
        exit 1
    fi
fi
