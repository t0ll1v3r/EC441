# In this lab, you will develop a web server that handles one HTTP request at a time. Your web server should accept and parse the HTTP request, get the requested file from the server’s file system, create an HTTP response message consisting of the requested file preceded by header lines, and then send the response directly to the client. If the requested file is not present in the server, the server should send an HTTP “404 Not Found” message back to the client.

from socket import *
import sys


# message to be sent
msg = '\r\n I LOVE EMAIL RAHH'.encode()
endmsg = '\r\n.\r\n'.encode()


# choose a bu mail server, call it mailserver
mailserver = 'smtp.bu.edu'


# create socket called clientSocket and establish a TCP connection with mailserver
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((mailserver, 25))

recv = clientSocket.recv(1024).decode()
print(recv)
if recv[:3] != '220':
	print('220 reply not recieved from server.')
	sys.exit(1)


# send HELO command and print server response
heloCommand = 'HELO ... \r\n'.encode()
clientSocket.send(heloCommand)

recv1 = clientSocket.recv(1024).decode()
print(recv1)
if recv1[:3] != '250':
	print('250 reply not recieved from server.')
	sys.exit(1)


# send MAIL FROM command and print server response.
mailFrom = 'MAIL FROM:<jclary@bu.edu>\r\n'.encode()
clientSocket.send(mailFrom)

recv2 = clientSocket.recv(1024).decode()
print(recv2)
if recv2[:3] != '250':
	print('250 reply not recieved from server.')
	sys.exit(1)


# send RCPT TO command and print server response
rcptTo = 'RCPT TO:<jackson.clary@c2mg.org>\r\n'.encode()
clientSocket.send(rcptTo)

recv3 = clientSocket.recv(1024).decode()
print(recv3)
if recv3[:3] != '250':
	print('250 reply not recieved from server.')
	sys.exit(1)

# send DATA command and print server response
dataCommand = 'DATA\r\n'.encode()
clientSocket.send(dataCommand)

recv4 = clientSocket.recv(1024).decode()
print(recv4)
if recv4[:3] != '354':
	print('354 reply not recieved from server.')
	sys.exit(1)


# send message data.
clientSocket.send(msg)


#message ends with a single period.
clientSocket.send(endmsg)

recv5 =clientSocket.recv(1024).decode()
print(recv5)
if recv5[:3] != '250':
	print('250 reply not recieved from server.')
	sys.exit(1)


#send QUIT command and get server response.
quitCommand = 'QUIT\r\n'.encode()
clientSocket.send(quitCommand)

recv6 = clientSocket.recv(1024).decode()
print(recv6)
if recv6 != '221':
	print('221 reply not recieved from the server.')
	sys.exit(1)


#close client socket
#HERE
