# loopback interface
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# allows established and related incoming traffic, so that the server will allow return traffic for outgoing connections initiated by the server itself
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# established connections, which are typically the response to legitimate incoming connections
sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# drop invalid stuff
sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# ssh for lan
sudo iptables -A INPUT -s 192.168.0.0/24 -p tcp --dport 22 -j ACCEPT

# allow https
sudo iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# forward http tp https
sudo iptables -A PREROUTING -t nat -p tcp -m multiport --dports 80 -j REDIRECT --to-port 443

# the server cannot send emails (SMTP)
sudo iptables -A OUTPUT -p tcp --dport 25 -j REJECT

# drop all - basic
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
