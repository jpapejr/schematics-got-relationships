#cloud-config
manage_etc_hosts: true
package_upgrade: false
packages:
- httpd
- git
- nodejs
runcmd:
- 'cp /usr/share/httpd/noindex/index.html /var/www/html'
- 'git clone https://github.com/jpapejr/got-relationships /tmp/app'
- 'cd /tmp/app && grunt dist'
- 'systemctl start httpd'
final_message: "The system is finally up, after $UPTIME seconds"