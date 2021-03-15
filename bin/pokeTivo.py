#!/usr/bin/env python
 
import socket
import time
 
hosts = (
  ("10.10.30.102"),
  ("10.10.30.104"),
  ("10.10.30.105"),
  ("10.10.30.106")
)
port = 31339
 
for ip in hosts:
  print("%s:" % ip)
  s = socket.socket()
  s.connect((ip, port))

  time.sleep(2) 
  s.sendall(b"IRCODE CLEAR\r")
  time.sleep(2)
 
  s.close()
