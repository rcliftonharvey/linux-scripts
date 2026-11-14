#
#   PIPEWIRE RESTART SCRIPT for RME HDSPe AIO
# 
# Fixes RME HDSPe AIO not connecting to amplifier over optical S/PDIF port after waking 
# the PC up from sleep.
#
# You can put this in /usr/local/bin/ and add it to your Application/Start Menu, or use 
# a sleep-mode related system hook to automatically execute this script every time the
# system wakes from sleep.
#

# Restart 3 PipeWire related services to make sure the services "are there" after waking.
systemctl --user restart pipewire pipewire-pulse wireplumber

# Deactivate optical output by telling the RME card to switch its S/PDIF output to coaxial.
amixer -c 0 set 'S/PDIF Out Optical' off

# Activate optical output again by telling the RME card to switch S/PDIF output to optical.
amixer -c 0 set 'S/PDIF Out Optical' on

# Restart the 3 Pipewire related services again to make sure "they know" about the
# RME card with its re-configured S/PDIF optical output, if they previously didn't.
systemctl --user restart pipewire pipewire-pulse wireplumber

# Launch the HDSPMixer GUI app to apply the default preset that brings back correct routing.
# Once the HDSPMixer GUI app loads the default preset, it's safe to close it again.
# Set routing and default preset loading up beforehand in the HDSPMixer GUI app.
hdspmixer
