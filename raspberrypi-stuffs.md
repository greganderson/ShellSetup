1. Create a file called `ssh` in `/boot/`
2. Unsure on this one, but instructions had you create a file called wpa_supplicant.conf in `/boot/` with
specific contents, google it if it doesn't work
3. Reboot

On a computer on the same network, run:

```
ping -c 1 raspberrypi.local
```

That's the ip address for the pi, you can use it for ssh.
