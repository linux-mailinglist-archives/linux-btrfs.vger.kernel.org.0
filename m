Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B1740A15
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjF1H51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 03:57:27 -0400
Received: from domac.alu.unizg.hr ([161.53.235.3]:59300 "EHLO domac.alu.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbjF1HzV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 03:55:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 36C78601C6;
        Wed, 28 Jun 2023 07:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687929974; bh=R3Adk+Vp7beQRzKZSsyxacxg7sRWAmigJgHBXXIf6Jg=;
        h=Date:To:Cc:From:Subject:From;
        b=MSQTX3cPNFzeO/0KNrebRAlxQXl+WnyfrGxsmynXvJGAsb0txEP2eI4WgfJSsf8Nw
         hBsSGf/INXMvwo2kiJwLgjpZHIg46NccVFajpZwblpUmWZujf6FJSBFbY9fVDlRy9T
         uyhmTu8YHzqlUksilHxoRJENLpR9vrWVbVSb5ibEg7p+RWSVGkCloJkDqDG+8Pbiqa
         A5nG2NNbqbW2e2f8ejLY3jhkOoYicEuNGMFJEPu8FdVA/zJfHiQjiSFJcQ9PGIGcNG
         llC9pYE26qo9S93Me/328Tf/ma33Wzx2KAI+Y9GrfIvjVPDza6r0k6VLC6fwtWJjcF
         laUJLAltYYLLA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f-90LmHaFzYp; Wed, 28 Jun 2023 07:26:11 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 4CBDC601B4;
        Wed, 28 Jun 2023 07:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687929971; bh=R3Adk+Vp7beQRzKZSsyxacxg7sRWAmigJgHBXXIf6Jg=;
        h=Date:To:Cc:From:Subject:From;
        b=RfpjWoiOU+J3EZjhZi2+/mWJiUHUEkVDI9O3n+qA/XKnVCgekb9g6X28nD5dnlOBZ
         1GDxcs4gBnD6ImcuikPxsm8gV6YxjAQmRHxjDXjFBB+HW/KqnXVslMmAfwloS3KiOb
         lFTuN2ZCZb2p05v9ObDM/9WelZ1RQw/lvHEC8XFYCX4D9KNcoDkFVKK7AW5IsLfXO5
         Nq7dKJzeE5xyvuoVCTEN1J+TymuD0hTCOYvbV0ByBg26GCoHydTIxrJgN0TkOdU6Wm
         MsmRwOHB6jfICmzF+VF2qC5ELH20oJhUgXcyytSv4njDP2VjpE4qE0Q46kVCI7igX6
         jQJQYzQbBZLig==
Message-ID: <e369408c-175a-e24a-c113-f63042bd1587@alu.unizg.hr>
Date:   Wed, 28 Jun 2023 07:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [POSSIBLE BUG]: btrfs partition: cat sees one version of the script,
 exec the old version
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Due to another bug discovered by kselftests, on the 6.4.0 kernel from Torvalds
tree with Ubuntu generic config merged with per-kselftest configs ...

It seems that the bash shell while executing a scripts sees the old version
when compared to that seen in the editor like vi.

The modified script on the btrfs partition is:

root@defiant:/linux/kernel/linux_torvalds/tools/testing/selftests/drivers/net/bonding# cat ./test.sh
#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
#
# cause kernel oops in bond_rr_gen_slave_id
DEBUG=${DEBUG:-0}

set -e -x
test ${DEBUG} -ne 0 && set -x

finish()
{
	ip link show
	ip link del link1_1 || true
	ip netns delete server || true
	ip netns delete client || true
}

trap finish EXIT

client_ip4=192.168.1.198
server_ip4=192.168.1.254

# setup kernel so it reboots after causing the panic
echo 180 >/proc/sys/kernel/panic

# build namespaces
ip link add dev link1_1 type veth peer name link1_2

ip netns add "server"
ip link set dev link1_2 netns server up name eth0
ip netns exec server ip addr add ${server_ip4}/24 dev eth0

ip netns add "client"
ip link set dev link1_1 netns client down name eth0
ip netns exec client ip link add dev bond0 down type bond mode 1 \
	miimon 100 all_slaves_active 1
ip netns exec client ip link set dev eth0 down master bond0
ip netns exec client ip link set dev bond0 up
ip netns exec client ip addr add ${client_ip4}/24 dev bond0
ip netns exec client ping -c 5 $server_ip4 >/dev/null

ip netns exec client ip link set dev eth0 down nomaster
ip netns exec client ip link set dev bond0 down
ip netns exec client ip link set dev bond0 type bond mode 0 \
	arp_interval 1000 arp_ip_target "+${server_ip4}"
ip netns exec client ip link set dev eth0 down master bond0
ip netns exec client ip link set dev bond0 up
ip link show
# ip netns exec client ping -c 5 $server_ip4 >/dev/null

echo "Exiting"

exit 0
root@defiant:/linux/kernel/linux_torvalds/tools/testing/selftests/drivers/net/bonding#

However, the bash appears to run the older version no matter what I try:

# ./test.sh
# bash ./test.sh
# . ./test.sh
# sh ./test.sh
# cat test.sh | bash -

What is executed is not what is in the test.sh, but the old version:

root@defiant:/linux/kernel/linux_torvalds/tools/testing/selftests/drivers/net/bonding# sh ./test.sh
+ test 0 -ne 0
+ trap finish EXIT
+ client_ip4=192.168.1.198
+ server_ip4=192.168.1.254
+ echo 180
+ ip link add dev link1_1 type veth peer name link1_2
+ ip netns add server
+ ip link set dev link1_2 netns server up name eth0
+ ip netns exec server ip addr add 192.168.1.254/24 dev eth0
+ ip netns add client
+ ip link set dev link1_1 netns client down name eth0
+ ip netns exec client ip link add dev bond0 down type bond mode 1 miimon 100 all_slaves_active 1
+ ip netns exec client ip link set dev eth0 down master bond0
+ ip netns exec client ip link set dev bond0 up
+ ip netns exec client ip addr add 192.168.1.198/24 dev bond0
+ ip netns exec client ping -c 5 192.168.1.254
+ finish
+ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 02:fc:ca:49:e2:d4 brd ff:ff:ff:ff:ff:ff
3: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ipip 0.0.0.0 brd 0.0.0.0
4: gre0@NONE: <NOARP> mtu 1476 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/gre 0.0.0.0 brd 0.0.0.0
5: gretap0@NONE: <BROADCAST,MULTICAST> mtu 1462 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
6: erspan0@NONE: <BROADCAST,MULTICAST> mtu 1450 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
7: ip_vti0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ipip 0.0.0.0 brd 0.0.0.0
8: ip6_vti0@NONE: <NOARP> mtu 1332 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/tunnel6 :: brd :: permaddr c689:f12:e1f6::
9: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
10: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/tunnel6 :: brd :: permaddr 7e18:b0ed:661a::
11: ip6gre0@NONE: <NOARP> mtu 1448 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/gre6 :: brd :: permaddr ce4b:1aae:bc8f::
12: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
     link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
+ ip link del link1_1
Cannot find device "link1_1"
+ true
+ ip netns delete server
+ ip netns delete client
root@defiant:/linux/kernel/linux_torvalds/tools/testing/selftests/drivers/net/bonding#

(The ip netns exec client ping -c 5 192.168.1.254 is executed even when commented
in the program.)

The "strace ./test.sh" command shows that ./test.sh is really opened, so
the only thing possible might be that bash and cat see different versions?

# strace ./test.sh
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0755, st_size=522, ...}, 0) = 0
openat(AT_FDCWD, "./test.sh", O_RDONLY) = 3
fcntl(3, F_DUPFD, 10)                   = 10
close(3)                                = 0
fcntl(10, F_SETFD, FD_CLOEXEC)          = 0
geteuid()                               = 0
getegid()                               = 0
rt_sigaction(SIGINT, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x55d28c956aa0, sa_mask=~[RTMIN RT_1], sa_flags=SA_RESTORER, sa_restorer=0x7f5f1b842520}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=~[RTMIN RT_1], sa_flags=SA_RESTORER, sa_restorer=0x7f5f1b842520}, NULL, 8) = 0
rt_sigaction(SIGTERM, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTERM, {sa_handler=SIG_DFL, sa_mask=~[RTMIN RT_1], sa_flags=SA_RESTORER, sa_restorer=0x7f5f1b842520}, NULL, 8) = 0
read(10, "#!/bin/sh\n# SPDX-License-Identif"..., 8192) = 1441


# strace cat ./test.sh

newfstatat(1, "", {st_mode=S_IFIFO|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
openat(AT_FDCWD, "./test.sh", O_RDONLY) = 3
newfstatat(3, "", {st_mode=S_IFREG|0775, st_size=1441, ...}, AT_EMPTY_PATH) = 0
fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f9eceaa6000
read(3, "#!/bin/sh\n# SPDX-License-Identif"..., 131072) = 1441
write(1, "#!/bin/sh\n# SPDX-License-Identif"..., 1441#!/bin/sh

Unless I'm not doing anything stupid, this could be a bug in btrfs COW?

The kernel is 6.4.0 torvalds tree release.

The /home partition is BTRFS on NVME Samsung 980 1 TB disk PCIe 3.0.

# /home was on /dev/nvme0n1p7 during installation
UUID=adfbacf5-c1d4-46c0-80ff-e1312696b829 /home           btrfs   defaults,subvol=@home 0       2

Best regards,
Mirsad Todorovac
