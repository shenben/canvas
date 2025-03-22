## ConnectX-3 RNIC with IB switch; 
* client communicate with server via IPoIB
* It seems remote memory is pulled accordingly, but client side does not work right.

```server
id_17@node0:/mnt/data/canvas/remoteswap/server$ ./run.sh 
+ make clean
rm rswap-server
+ make
g++ -std=c++11 -Wall -Werror -O2 -I/mnt/data/canvas/remoteswap/server/.. -I/usr/src/ofa_kernel/default/include -o rswap-server rswap_server.cpp -pthread -lrdmacm -libverbs
+ ./rswap-server 10.10.2.1 9400 8 8
main, trying to bind to 10.10.2.1:9400.
listening on port 9400.
init_memory_pool, Register Semeru Space: 0x7f6a4f4c5010, size : 0x200000000. 
init_memory_pool, Prepare to register memory Region[0] (Meta DATA)  : 0x7f6a4f4c5010, size 0x40000000
init_memory_pool, Prepare to register memory Region[1] (Object DATA) : 0x7f6a8f4c5010, size 0x40000000
init_memory_pool, Prepare to register memory Region[2] (Object DATA) : 0x7f6acf4c5010, size 0x40000000
init_memory_pool, Prepare to register memory Region[3] (Object DATA) : 0x7f6b0f4c5010, size 0x40000000
init_memory_pool, Prepare to register memory Region[4] (Object DATA) : 0x7f6b4f4c5010, size 0x40000000
init_memory_pool, Prepare to register memory Region[5] (Object DATA) : 0x7f6b8f4c5010, size 0x40000000
init_memory_pool, Prepare to register memory Region[6] (Object DATA) : 0x7f6bcf4c5010, size 0x40000000
init_memory_pool, Prepare to register memory Region[7] (Object DATA) : 0x7f6c0f4c5010, size 0x40000000
init_memory_pool, Registered 8 GB (whole head) as RDMA Buffer
Get RDMA_CM_EVENT_CONNECT_REQUEST
get_qp_type, initial type: 0
on_connect_request, final type: 0
on_connect_request, rdma_queue[0] received connection request.
register_rdma_comm_buffer, Reserve 2-sided rdma buffer done.
on_connect_request, rdma_queue[0] sends ACCEPT back to CPU server.
Get RDMA_CM_EVENT_ESTABLISHED
rdma_connected, connection build. Register heap as RDMA buffer.
Register Region[0] : 0x7f6a4f4c5010 to RDMA Buffer[0] : 0x5578b4e67b30, rkey: 0x10500, mapped_size 0x40000000 done 
Register Region[1] : 0x7f6a8f4c5010 to RDMA Buffer[1] : 0x5578b4e68790, rkey: 0x10600, mapped_size 0x40000000 done 
Register Region[2] : 0x7f6acf4c5010 to RDMA Buffer[2] : 0x5578b4e687d0, rkey: 0x10700, mapped_size 0x40000000 done 
Register Region[3] : 0x7f6b0f4c5010 to RDMA Buffer[3] : 0x5578b4e68810, rkey: 0x10800, mapped_size 0x40000000 done 
Register Region[4] : 0x7f6b4f4c5010 to RDMA Buffer[4] : 0x5578b4e68850, rkey: 0x10900, mapped_size 0x40000000 done 
Register Region[5] : 0x7f6b8f4c5010 to RDMA Buffer[5] : 0x5578b4e68890, rkey: 0x10a00, mapped_size 0x40000000 done 
Register Region[6] : 0x7f6bcf4c5010 to RDMA Buffer[6] : 0x5578b4e688d0, rkey: 0x10b00, mapped_size 0x40000000 done 
Register Region[7] : 0x7f6c0f4c5010 to RDMA Buffer[7] : 0x5578b4e68910, rkey: 0x10c00, mapped_size 0x40000000 done 
inform_memory_pool_available , rdma_queue [0] Inform CPU server that memory server is prepared well for serving.
send_message, message size = 168
handle_cqe, 2-sided RDMA message sent done ?
```

```client 
id_17@node2:/mnt/data/canvas/remoteswap/client$ sudo ./manage_rswap_client.sh.multi  install
++ awk -F= '/^NAME/{print $2}' /etc/os-release
++ sed -e 's/^"//' -e 's/"$//'
+ OS_DISTRO=Ubuntu
+ [[ Ubuntu == \C\e\n\t\O\S\ \L\i\n\u\x ]]
+ [[ Ubuntu == \U\b\u\n\t\u ]]
+ echo 'Running on Ubuntu...'
Running on Ubuntu...
+ mem_server_ip=10.10.2.1
+ mem_server_port=9400
+ '[' -z /users/id_17 ']'
+ home_dir=/users/id_17
+ swap_files=("/mnt/data/shared_swapfile")
+ SWAP_PARTITION_SIZE_GBs=("8")
+ SWAP_PARTITION_SIZE_GB=8
+ cpu_core_num=8
+ echo ' !! Warning, check the parameters below : '
 !! Warning, check the parameters below : 
+ echo ' Assigned memory server IP 10.10.2.1 Port 9400'
 Assigned memory server IP 10.10.2.1 Port 9400
+ echo ' swapfile /mnt/data/shared_swapfile, size 8 GB'
 swapfile /mnt/data/shared_swapfile, size 8 GB
+ echo ' Assign 8 cores to cpu server'
 Assign 8 cores to cpu server
+ echo ' '
 
+ echo ' '
 
+ action=install
+ [[ -z install ]]
+ [[ install = \i\n\s\t\a\l\l ]]
+ echo 'Close current swap partition && Create swap file'
Close current swap partition && Create swap file
+ close_swap_partition
+ [[ Ubuntu == \C\e\n\t\O\S\ \L\i\n\u\x ]]
+ [[ Ubuntu == \U\b\u\n\t\u ]]
++ swapon -s
++ grep swap.img
++ cut -d ' ' -f 1
+ swap_bd=
+ '[' -z '' ']'
++ swapon -s
++ grep swapfile
+ swap_bd=
+ [[ -z '' ]]
+ echo 'Nothing to close.'
Nothing to close.
+ echo 'Current swap partition:'
Current swap partition:
+ swapon -s
Filename                                Type            Size    Used    Priority
/dev/sda3                               partition       3145724 0       -2
+ create_swap_file
+ (( i=0 ))
+ (( i<1 ))
+ swap_file=/mnt/data/shared_swapfile
+ file_size=8
+ [[ -e /mnt/data/shared_swapfile ]]
+ echo 'Please confirm the size of swapfile match the expected 8G'
Please confirm the size of swapfile match the expected 8G
++ du -sh /mnt/data/shared_swapfile
++ awk '{print $1;}'
++ tr -cd '[[:digit:]]'
+ cur_size=75
+ [[ 75 -ne 8 ]]
+ echo 'Current /mnt/data/shared_swapfile: 75G NOT equal to expected 8G'
Current /mnt/data/shared_swapfile: 75G NOT equal to expected 8G
+ echo 'Delete it'
Delete it
+ sudo swapoff /mnt/data/shared_swapfile
swapoff: /mnt/data/shared_swapfile: swapoff failed: Invalid argument
+ sudo rm /mnt/data/shared_swapfile
+ echo 'Create a file, /mnt/data/shared_swapfile, with size 8G as swap device.'
Create a file, /mnt/data/shared_swapfile, with size 8G as swap device.
+ sudo dd if=/dev/zero of=/mnt/data/shared_swapfile bs=1000000000 count=8
8+0 records in
8+0 records out
8000000000 bytes (8.0 GB, 7.5 GiB) copied, 45.7923 s, 175 MB/s
+ sudo chmod 600 /mnt/data/shared_swapfile
+ sudo mkswap /mnt/data/shared_swapfile
Setting up swapspace version 1, size = 7.5 GiB (7999995904 bytes)
no label, UUID=e4933614-0f08-44b9-a8cd-c96af223c9be
+ sleep 1
+ echo 'Mount the /mnt/data/shared_swapfile as swap device'
Mount the /mnt/data/shared_swapfile as swap device
+ sudo mkswap /mnt/data/shared_swapfile
mkswap: /mnt/data/shared_swapfile: warning: wiping old swap signature.
Setting up swapspace version 1, size = 7.5 GiB (7999995904 bytes)
no label, UUID=2d8d4857-61cf-4e83-8a41-8b783d264f6e
+ [[ i -eq 0 ]]
+ sudo swapon /mnt/data/shared_swapfile
+ swapon -s
Filename                                Type            Size    Used    Priority
/dev/sda3                               partition       3145724 0       -2
/mnt/data/shared_swapfile               file            7812496 0       -3
+ (( i++ ))
+ (( i<1 ))
+ echo 'insmod ./rswap-client.ko sip=10.10.2.1 sport=9400 rmsize=8 cpunum=8'
insmod ./rswap-client.ko sip=10.10.2.1 sport=9400 rmsize=8 cpunum=8
+ sudo insmod ./rswap-client.ko sip=10.10.2.1 sport=9400 rmsize=8 cpunum=8

```

```client's kernel log
id_17@node2:/mnt/data/canvas$ sudo journalctl -n 40
-- Logs begin at Fri 2025-03-21 20:05:19 MDT, end at Sat 2025-03-22 07:14:24 MDT. --
Mar 22 07:11:33 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[8181]: pam_unix(sudo:session): session closed for user root
Mar 22 07:11:37 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[8321]:    id_17 : TTY=pts/4 ; PWD=/mnt/data/canvas ; USER=root ; COMMAND=/usr/bin>
Mar 22 07:11:37 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[8321]: pam_unix(sudo:session): session opened for user root by (uid=0)
Mar 22 07:11:49 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:11:50 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:11:50 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:11:50 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:11:53 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[8321]: pam_unix(sudo:session): session closed for user root
Mar 22 07:11:53 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[8366]: Invalid user ubnt from 112.120.113.246 port 58707
Mar 22 07:11:54 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[8366]: Connection closed by invalid user ubnt 112.120.113.246 port 58707 [preauth]
Mar 22 07:12:19 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net srp_daemon[4681]: SM LID is 0, maybe no SM is running
Mar 22 07:12:25 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[8445]: Invalid user donna from 182.93.50.90 port 40638
Mar 22 07:12:25 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[8445]: Received disconnect from 182.93.50.90 port 40638:11: Bye Bye [preauth]
Mar 22 07:12:25 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[8445]: Disconnected from invalid user donna 182.93.50.90 port 40638 [preauth]
Mar 22 07:12:25 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:12:26 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:12:26 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:12:26 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:12:38 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[8504]: error: kex_exchange_identification: Connection closed by remote host
Mar 22 07:12:53 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: cma_event type 10, type_name: RDMA_CM_EVENT_DISCONNECTED 
Mar 22 07:12:53 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: rswap_rdma_cm_event_handler, Receive DISCONNECTED  signal 
Mar 22 07:12:53 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: rswap_rdma_cm_event_handler, RDMA disconnect evetn, requested by client. 
Mar 22 07:12:55 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: cma_event type 15, type_name: RDMA_CM_EVENT_TIMEWAIT_EXIT 
Mar 22 07:12:55 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: rswap_rdma_cm_event_handler, Wait for in-the-fly RDMA message finished. 
Mar 22 07:13:06 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:06 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:06 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:06 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:19 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net srp_daemon[4681]: SM LID is 0, maybe no SM is running
Mar 22 07:13:41 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:42 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:42 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:42 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:14:19 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net srp_daemon[4681]: SM LID is 0, maybe no SM is running
Mar 22 07:14:22 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:14:23 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:14:23 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:14:23 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:14:24 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[8524]:    id_17 : TTY=pts/4 ; PWD=/mnt/data/canvas ; USER=root ; COMMAND=/usr/bin>
Mar 22 07:14:24 node2.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[8524]: pam_unix(sudo:session): session opened for user root by (uid=0)
```

```server's kernel log
id_17@node0:/mnt/data/canvas$ sudo journalctl -n 40
-- Logs begin at Fri 2025-03-21 20:05:31 MDT, end at Sat 2025-03-22 07:15:50 MDT. --
Mar 22 07:12:34 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[16112]: Invalid user solana from 45.148.10.240 port 50226
Mar 22 07:12:34 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[16112]: Connection closed by invalid user solana 45.148.10.240 port 50226 [preauth]
Mar 22 07:12:49 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net srp_daemon[7818]: SM LID is 0, maybe no SM is running
Mar 22 07:12:50 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:01 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net OpenSM[7868]: Errors during initialization
Mar 22 07:13:01 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net OpenSM[7868]: Found remote SM (0,1,2,33,3) with non-matching sm_key
Mar 22 07:13:01 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:13:06 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[13043]: Received disconnect from 202.175.67.228 port 59124:11: disconnected by user
Mar 22 07:13:06 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[13043]: Disconnected from user id_17 202.175.67.228 port 59124
Mar 22 07:13:06 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net systemd-logind[1464]: Session 19 logged out. Waiting for processes to exit.
Mar 22 07:13:06 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[13009]: pam_unix(sshd:session): session closed for user id_17
Mar 22 07:13:10 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[16182]: Accepted publickey for id_17 from 202.175.67.228 port 61379 ssh2: RSA SHA256:+RyOc9xgUp/wlBnvz2qe2IJN>
Mar 22 07:13:10 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[16182]: pam_unix(sshd:session): session opened for user id_17 by (uid=0)
Mar 22 07:13:10 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net systemd-logind[1464]: New session 61 of user id_17.
Mar 22 07:13:10 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net systemd[1]: Started Session 61 of user id_17.
Mar 22 07:13:40 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net systemd[1]: session-19.scope: Succeeded.
Mar 22 07:13:40 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net systemd[1]: session-19.scope: Consumed 6.662s CPU time.
Mar 22 07:13:40 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net systemd-logind[1464]: Removed session 19.
Mar 22 07:13:44 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[16451]: Invalid user deploy from 152.200.181.42 port 35309
Mar 22 07:13:44 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[16451]: Received disconnect from 152.200.181.42 port 35309:11: Bye Bye [preauth]
Mar 22 07:13:44 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sshd[16451]: Disconnected from invalid user deploy 152.200.181.42 port 35309 [preauth]
Mar 22 07:13:49 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net srp_daemon[7818]: SM LID is 0, maybe no SM is running
Mar 22 07:14:06 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:14:18 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net OpenSM[7868]: Errors during initialization
Mar 22 07:14:18 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net OpenSM[7868]: Found remote SM (0,1,1,33,3) with non-matching sm_key
Mar 22 07:14:18 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:14:49 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net srp_daemon[7818]: SM LID is 0, maybe no SM is running
Mar 22 07:15:01 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net CRON[16455]: pam_unix(cron:session): session opened for user root by (uid=0)
Mar 22 07:15:01 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net CRON[16456]: (root) CMD ([ -x /usr/sbin/dma ] && /usr/sbin/dma -q1)
Mar 22 07:15:01 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net CRON[16455]: pam_unix(cron:session): session closed for user root
Mar 22 07:15:23 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:15:33 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net OpenSM[7868]: Errors during initialization
Mar 22 07:15:34 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net OpenSM[7868]: Found remote SM (0,1,2,33,3) with non-matching sm_key
Mar 22 07:15:34 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net kernel: mlx4_core 0000:08:00.0: command 0x24 failed: fw status = 0x30
Mar 22 07:15:38 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[16500]:    id_17 : TTY=pts/3 ; PWD=/mnt/data/canvas ; USER=root ; COMMAND=/usr/bin/journalctl -n 40
Mar 22 07:15:38 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[16500]: pam_unix(sudo:session): session opened for user root by (uid=0)
Mar 22 07:15:46 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[16500]: pam_unix(sudo:session): session closed for user root
Mar 22 07:15:49 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net srp_daemon[7818]: SM LID is 0, maybe no SM is running
Mar 22 07:15:50 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[16575]:    id_17 : TTY=pts/3 ; PWD=/mnt/data/canvas ; USER=root ; COMMAND=/usr/bin/journalctl -n 40
Mar 22 07:15:50 node0.id-17-247490.rdmatestbench-pg0.apt.emulab.net sudo[16575]: pam_unix(sudo:session): session opened for user root by (uid=0)
```
