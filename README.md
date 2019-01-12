# ONF M-CORD lite version for K-ONE project (K-ONE-M-CORD-Lite)
M-CORD lite version for K-ONE project

## Configuration
### config/interface.cfg
```
21: dp_comm_ip = <IP address of DP container connected in `brspgw` bridge>
...
23: cp_comm_ip = <IP address of CP container connected in `brspgw` bridge>
```

### config/cp\_config.cfg
```
1: S11_SGW_IP=<IP address of CP container connected in `brs11` bridge>
2: S11_MME_IP=<IP address of traffic container connected in `brs11` bridge>
3: S1U_SGW_IP=<IP address of DP container connected in `brs1u` bridge>
```

### config/dp\_config.cfg
```
1: S1U_IP=<IP address of DP container connected in `brs1u` bridge>
...
5: SGI_IP=<IP address of DP container connected in `brsgi` bridge>
...
8: SGI_GW_IP=<IP address of traffic container connected in `brsgi` bridge>
```

## Generate pcap files to run `TCPReplay`

First, access to traffic container.
Then, input the following command:
```
root# ./rewrite_pcaps.py enb.s1u.ngic spgw.s11.ngic spgw.s1u.ngic spgw.sgi.ngic
```
where
```
enb.s1u.ngic: IP address of traffic container connected in `brs1u` bridge
spgw.s11.ngic: IP address of CP container connected in `brs11` bridge
spgw.s1u.ngic: IP address of DP container connected in `brs1u` bridge
spgw.sgi.ngic: IP address of DP container connected in `brsgi` bridge
```
Note that this step spends 1-2 minutes.

## How to run?
### Overview
To run ONF M-CORD lite version for K-ONE project, there is the sequence which is DP -> CP -> traffic generator

### How to run DP?
```
root# . /opt/ngic/config/dp_config.cfg && ifconfig -a && ./ngic_dataplane $EAL_ARGS -- $APP_ARGS
```

### How to run CP?
```
root# . /opt/ngic/config/cp_config.cfg && ifconfig -a && ./ngic_controlplane $EAL_ARGS -- $APP_ARGS
```

### How to generate traffic for each LTE interface?
```
root# tcpreplay --pps=200 -i $S11_IFACE tosend-s11.pcap # to generate S11 traffic
root# tcpreplay --pps=2000 -i $S1U_IFACE tosend-s1u.pcap # to generate S1U traffic
root# tcpreplay --pps=2000 -i $SGI_IFACE tosend-sgi.pcap # to generate SGI traffic
```

## Release information
* Release 1 - single PM version
* Release 2 - multiple PM version by using Docker Swarm (Under maintenance by Woojoong Kim @ POSTECH and ONF)

