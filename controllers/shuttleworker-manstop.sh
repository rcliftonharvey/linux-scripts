#!/usr/bin/env bash

#
#   SHUTTLE LANDER SERVICE CONTROL SCRIPT -- STOP
#
# Shuttle Lander seems to auto-start its service from time to time,
# even if it was previously manually stopped. This can screw up the
# way the Contour Shuttle devices behave in apps which can natively
# handle them.
#
# My fix is to entirely deactivate its background service, and then
# start and stop it manually as required.
#
# This script manually stops the shuttleworker background service
# for Shuttle Lander, if it is indeed still running.
#

SERVICE="shuttleworker.service"

if ! systemctl is-active --quiet "$SERVICE"; then
    echo "Shuttle Lander is already stopped."
else
    echo "Stopping Shuttle Lander..."
    sudo systemctl stop "$SERVICE"

    if ! systemctl is-active --quiet "$SERVICE"; then
        echo "Shuttle Lander stopped successfully."
    else
        echo "ERROR: Failed to stop Shuttle Lander."
        exit 1
    fi
fi
