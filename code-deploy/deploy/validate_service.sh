#!/bin/bash
if [[ "$HOSTNAME" =~ -web$ ]]; then
	printf '%s\n' "Check web status"
	systemctl status nginx
fi