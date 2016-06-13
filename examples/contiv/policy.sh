#!/bin/bash
netctl net create -s 50.1.1.0/24 -g 50.1.1.254 user-net2
netctl policy create icmpPol
netctl policy rule-add  -d in --protocol icmp --action deny icmpPol 2
netctl group create user-net2 pingme-epg
netctl group create user-net2 noping-epg -policy=icmpPol
netctl group ls
