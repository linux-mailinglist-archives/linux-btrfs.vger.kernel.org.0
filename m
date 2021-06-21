Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938633AE79F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhFUKvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFUKvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 06:51:23 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Jun 2021 03:49:09 PDT
Received: from rootvole.net (cuveland.de [IPv6:2a01:4f8:201:91f8::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069EC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 03:49:09 -0700 (PDT)
Received: from [192.168.178.33] (HSI-KBW-46-223-130-48.hsi.kabel-badenwuerttemberg.de [46.223.130.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by rootvole.net (Postfix) with ESMTPSA id 43FA8CC332B
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 12:41:48 +0200 (CEST)
To:     linux-btrfs@vger.kernel.org
From:   Volker <volker@fsync.org>
Subject: Recovering from filesystem errors?
Message-ID: <a2d39735-b54d-a11f-cee3-92f72e3f00b9@fsync.org>
Date:   Mon, 21 Jun 2021 12:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've been running btrfs for a number of years now on a Debian server 
without problems, but now got into trouble. The filesystem automatically 
switched to read-only due to errors and that's how I noticed. I could 
actually find in the logs of the regularly running scrub that there were 
errors but, shame on me, I didn't notice these log messages before now. 
Now I'm trying to fix the errors, but didn't succeed so far.

After finding the disk read-only, I could remount the disk with "-o 
recovery" and subsequent mounts were successful. However, a new run of 
scrub found errors, as did "btrfs check /dev/sda4":

- errors found in extent allocation tree or chunk allocation

- errors 2000, link count wrong
         unresolved ref dir ...

- errors 2001, no inode item, link count wrong
         unresolved ref dir ...

But I don't know what to do now without putting the data in danger (like 
using "btrfs check --repair"), also didn't find any solutions on the 
btrfs wiki or the web so far. Any help is appreciated. All details 
following right below.

I don't know any specific reason that might have caused the filesystem 
corruption (no known power failure or alike, no disk failure). A 
"smartctl" selftest shows the disk being in good health without errors, 
"badblocks" (read-only) found no problems either.

Best regards,
Volker



# lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux 10 (buster)
Release:        10
Codename:       buster

# uname -a
Linux rv 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 
GNU/Linux

# btrfs --version
btrfs-progs v4.20.1

# btrfs fi show /dev/sda4
Label: none  uuid: f3789d71-6576-400f-b729-bd37173b592a
         Total devices 1 FS bytes used 1.18TiB
         devid    1 size 3.38TiB used 1.22TiB path /dev/sda4

# btrfs fi df /data/1
Data, single: total=1.18TiB, used=1.17TiB
System, DUP: total=32.00MiB, used=176.00KiB
Metadata, DUP: total=19.50GiB, used=10.77GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

 From dmesg:
...
[    7.084677] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    7.084764] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    7.084842] sd 4:0:0:0: Attached scsi generic sg2 type 0
[    7.084915] sd 5:0:0:0: Attached scsi generic sg3 type 0
[    7.454690] asus_wmi: ASUS WMI generic driver loaded
[    7.535349] asus_wmi: Initialization: 0x0
[    7.535421] asus_wmi: BIOS WMI version: 0.9
[    7.535499] asus_wmi: SFUN value: 0x0
[    7.535767] input: Eee PC WMI hotkeys as 
/devices/platform/eeepc-wmi/input/input3
[    7.535896] asus_wmi: Number of fans: 1
[    8.188670] EXT4-fs (md1): mounting ext3 file system using the ext4 
subsystem
[    8.238854] BTRFS info (device sdc4): disk space caching is enabled
[    8.299930] BTRFS info (device sdd4): disk space caching is enabled
[    8.440013] intel_rapl: Found RAPL domain package
[    8.440070] intel_rapl: Found RAPL domain core
[    8.440123] intel_rapl: Found RAPL domain uncore
[    8.440179] intel_rapl: RAPL package 0 domain package locked by BIOS
[    8.685569] BTRFS info (device sdb4): disk space caching is enabled
[    8.713723] Adding 8384444k swap on /dev/md0.  Priority:-2 extents:1 
across:8384444k FS
[    8.761835] BTRFS info (device sda4): disk space caching is enabled
[    8.788208] EXT4-fs (md1): mounted filesystem with ordered data mode. 
Opts: (null)
[    9.059383] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd 
0, flush 0, corrupt 21, gen 0
[   21.607638] audit: type=1400 audit(1623925717.843:2): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/man" pid=625 comm="apparmor_parser"
[   21.607729] audit: type=1400 audit(1623925717.843:3): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_filter" pid=625 comm="apparmor_parser"
[   21.607838] audit: type=1400 audit(1623925717.843:4): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_groff" pid=625 comm="apparmor_parser"
[   21.609145] audit: type=1400 audit(1623925717.843:5): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe" pid=628 comm="apparmor_parser"
[   21.609251] audit: type=1400 audit(1623925717.843:6): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe//kmod" pid=628 comm="apparmor_parser"
[   21.611017] audit: type=1400 audit(1623925717.843:7): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/sbin/haveged" pid=629 comm="apparmor_parser"
[   21.630456] audit: type=1400 audit(1623925717.863:8): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/sbin/ntpd" pid=624 comm="apparmor_parser"
[   21.632419] audit: type=1400 audit(1623925717.867:9): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/sbin/ejabberdctl" pid=626 comm="apparmor_parser"
[   21.632541] audit: type=1400 audit(1623925717.867:10): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/sbin/ejabberdctl//su" pid=626 comm="apparmor_parser"
[   23.377589] r8169 0000:04:00.0: firmware: direct-loading firmware 
rtl_nic/rtl8168e-2.fw
[   23.377998] RTL8211DN Gigabit Ethernet r8169-400:00: attached PHY 
driver [RTL8211DN Gigabit Ethernet] (mii_bus:phy_addr=r8169-400:00, 
irq=IGNORE)
[   23.605939] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   26.282210] r8169 0000:04:00.0 eth0: Link is Up - 1Gbps/Full - flow 
control rx/tx
[   26.282308] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   38.223192] aufs: loading out-of-tree module taints kernel.
[   38.223461] aufs: module verification failed: signature and/or 
required key missing - tainting kernel
[   38.230138] aufs 4.19.17+-20190211
[   42.137916] audit: type=1400 audit(1623925738.788:11): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="docker-default" pid=1322 comm="apparmor_parser"
[   52.484644] bridge: filtering via arp/ip/ip6tables is no longer 
available by default. Update your scripts to load br_netfilter if you 
need this.
[   52.626953] Bridge firewalling registered
[   52.955046] Initializing XFRM netlink socket
[   53.072440] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[  189.683406] conntrack: generic helper won't handle protocol 47. 
Please consider loading the specific helper module.
[ 1258.935918] BTRFS warning (device sda4): checksum error at logical 
185499615232 on dev /dev/sda4, physical 122526334976, root 5, inode 
1022460897, offset 8192, length 4096, links 6 (path: 
backup/rsnapshot/monthly.0/rootvole/usr/share/perl/5.28.1/B/Deparse.pm)
[ 1258.936011] BTRFS warning (device sda4): checksum error at logical 
185499615232 on dev /dev/sda4, physical 122526334976, root 5, inode 
1022460897, offset 8192, length 4096, links 6 (path: 
backup/rsnapshot/weekly.0/rootvole/usr/share/perl/5.28.1/B/Deparse.pm)
[ 1258.936112] BTRFS warning (device sda4): checksum error at logical 
185499615232 on dev /dev/sda4, physical 122526334976, root 5, inode 
1022460897, offset 8192, length 4096, links 6 (path: 
backup/rsnapshot/daily.3/rootvole/usr/share/perl/5.28.1/B/Deparse.pm)
[ 1258.936251] BTRFS warning (device sda4): checksum error at logical 
185499615232 on dev /dev/sda4, physical 122526334976, root 5, inode 
1022460897, offset 8192, length 4096, links 6 (path: 
backup/rsnapshot/daily.2/rootvole/usr/share/perl/5.28.1/B/Deparse.pm)
[ 1258.936390] BTRFS warning (device sda4): checksum error at logical 
185499615232 on dev /dev/sda4, physical 122526334976, root 5, inode 
1022460897, offset 8192, length 4096, links 6 (path: 
backup/rsnapshot/daily.1/rootvole/usr/share/perl/5.28.1/B/Deparse.pm)
[ 1258.936529] BTRFS warning (device sda4): checksum error at logical 
185499615232 on dev /dev/sda4, physical 122526334976, root 5, inode 
1022460897, offset 8192, length 4096, links 6 (path: 
backup/rsnapshot/daily.0/rootvole/usr/share/perl/5.28.1/B/Deparse.pm)
[ 1258.936673] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0, rd 
0, flush 0, corrupt 22, gen 0
[ 1258.936759] BTRFS error (device sda4): unable to fixup (regular) 
error at logical 185499615232 on dev /dev/sda4
[ 1269.270950] BTRFS warning (device sda4): checksum error at logical 
186789908480 on dev /dev/sda4, physical 123816628224, root 5, inode 
981455359, offset 778240, length 4096, links 3 (path: 
backup/rsnapshot/daily.6/rootvole/XXXX)
[ 1269.271126] BTRFS warning (device sda4): checksum error at logical 
186789908480 on dev /dev/sda4, physical 123816628224, root 5, inode 
981455359, offset 778240, length 4096, links 3 (path: 
backup/rsnapshot/daily.5/rootvole/XXXX)
[ 1269.271296] BTRFS warning (device sda4): checksum error at logical 
186789908480 on dev /dev/sda4, physical 123816628224, root 5, inode 
981455359, offset 778240, length 4096, links 3 (path: 
backup/rsnapshot/daily.4/rootvole/XXXX)
[ 1269.271469] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0, rd 
0, flush 0, corrupt 23, gen 0
[ 1269.271556] BTRFS error (device sda4): unable to fixup (regular) 
error at logical 186789908480 on dev /dev/sda4
[ 1758.383764] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[ 1760.720490] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[ 1760.724971] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[54653.918256] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[54654.070094] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[54654.070247] BTRFS: error (device sda4) in 
btrfs_finish_ordered_io:3131: errno=-5 IO failure
[54654.070317] BTRFS info (device sda4): forced readonly
[89778.620651] BTRFS info (device sda4): disk space caching is enabled
[89778.861394] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd 
0, flush 0, corrupt 23, gen 0
[89892.442988] BTRFS warning (device sda4): 'recovery' is deprecated, 
use 'usebackuproot' instead
[89892.443078] BTRFS info (device sda4): trying to use backup root at 
mount time
[89892.443146] BTRFS info (device sda4): disk space caching is enabled
[89892.665258] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd 
0, flush 0, corrupt 23, gen 0
[91148.220467] BTRFS info (device sda4): disk space caching is enabled
[91148.486704] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd 
0, flush 0, corrupt 23, gen 0
[91282.111038] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91282.641833] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91282.642007] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91282.942527] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91283.462764] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91283.462922] BTRFS info (device sda4): no csum found for inode 
1070749910 start 4096
[91283.879329] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91283.988504] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91283.988680] BTRFS info (device sda4): no csum found for inode 
1070749910 start 8192
[91284.087489] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91284.209374] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91284.209509] BTRFS info (device sda4): no csum found for inode 
1070749910 start 12288
[91284.467159] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91284.883794] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91284.883933] BTRFS info (device sda4): no csum found for inode 
1070749910 start 16384
[91285.268720] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91285.788965] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91285.789110] BTRFS info (device sda4): no csum found for inode 
1070749910 start 20480
[91285.965558] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91285.966184] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91285.966355] BTRFS info (device sda4): no csum found for inode 
1070749910 start 24576
[91286.053056] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91286.320483] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91286.320623] BTRFS info (device sda4): no csum found for inode 
1070749910 start 28672
[91286.710734] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91286.988923] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91286.989049] BTRFS info (device sda4): no csum found for inode 
1070749910 start 32768
[91287.615981] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91287.852042] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91287.852183] BTRFS info (device sda4): no csum found for inode 
1070749910 start 36864
[91287.917659] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91287.918375] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91287.918514] BTRFS info (device sda4): no csum found for inode 
1070749910 start 40960
[91288.033442] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.177533] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.177710] BTRFS info (device sda4): no csum found for inode 
1070749910 start 45056
[91288.179205] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.186287] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.186452] BTRFS info (device sda4): no csum found for inode 
1070749910 start 49152
[91288.197595] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.310022] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.310739] BTRFS info (device sda4): no csum found for inode 
1070749910 start 53248
[91288.311383] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.312427] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.312562] BTRFS info (device sda4): no csum found for inode 
1070749910 start 57344
[91288.417985] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.418564] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.418700] BTRFS info (device sda4): no csum found for inode 
1070749910 start 61440
[91288.518410] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.672613] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91288.672776] BTRFS info (device sda4): no csum found for inode 
1070749910 start 65536
[91288.966621] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.051898] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.052036] BTRFS info (device sda4): no csum found for inode 
1070749910 start 69632
[91289.189162] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.190428] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.190539] BTRFS info (device sda4): no csum found for inode 
1070749910 start 73728
[91289.211313] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.219394] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.233441] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.242520] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.248080] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.259022] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.265716] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.275883] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.286814] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.294706] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.303355] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.313367] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.329183] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.332623] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.342675] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.343016] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.343283] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.343676] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.346892] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.533529] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.534643] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.611097] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.626089] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.626783] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.627507] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.628022] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.721222] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91289.758805] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.770095] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91289.771051] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91291.394644] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91291.525449] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91291.625608] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91292.332090] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91292.348071] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91292.348545] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91293.447156] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91293.546401] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91293.546612] __btrfs_lookup_bio_sums: 16 callbacks suppressed
[91293.546614] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91293.562215] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91295.396521] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91295.397339] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91295.397472] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91295.410498] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91296.878567] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91296.883069] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91296.883243] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91296.983154] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91299.528835] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91299.529653] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91299.529822] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91299.529993] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91306.044652] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91306.058784] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91306.058958] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91306.061188] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91311.833740] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91311.874239] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91311.874412] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91311.900869] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91323.112902] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.121408] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.121741] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.122047] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.122176] BTRFS info (device sda4): no csum found for inode 
1070749910 start 1712128
[91323.122366] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.122648] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.122975] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.123102] BTRFS info (device sda4): no csum found for inode 
1070749910 start 1716224
[91323.123108] BTRFS info (device sda4): no csum found for inode 
1070749910 start 0
[91323.141510] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 1712128 csum 0x7e65917e expected csum 0x00000000 mirror 1
[91323.141544] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 0 csum 0x3052e521 expected csum 0x00000000 mirror 1
[91323.142079] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.167226] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.167338] BTRFS info (device sda4): no csum found for inode 
1070749910 start 1712128
[91323.181249] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 1712128 csum 0x7e65917e expected csum 0x00000000 mirror 1
[91323.234935] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.303983] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.304344] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.304719] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.305131] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.305607] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.305959] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.306258] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.306587] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.306940] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.334190] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.348317] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.348458] BTRFS info (device sda4): no csum found for inode 
1070749910 start 1712128
[91323.366361] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 1712128 csum 0x7e65917e expected csum 0x00000000 mirror 1
[91323.366395] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.366777] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.367130] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.367951] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.368080] BTRFS info (device sda4): no csum found for inode 
1070749910 start 2744320
[91323.373710] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.374089] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.374483] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.374612] BTRFS info (device sda4): no csum found for inode 
1070749910 start 1761280
[91323.415837] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 1761280 csum 0xa27d2b88 expected csum 0x00000000 mirror 1
[91323.415878] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.416068] BTRFS info (device sda4): no csum found for inode 
1070749910 start 430080
[91323.429769] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.429901] BTRFS info (device sda4): no csum found for inode 
1070749910 start 1703936
[91323.430090] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 1703936 csum 0x0a8edc47 expected csum 0x00000000 mirror 1
[91323.430111] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.430316] BTRFS info (device sda4): no csum found for inode 
1070749910 start 425984
[91323.430696] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.431417] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 1708032 csum 0x1d350ea4 expected csum 0x00000000 mirror 1
[91323.431491] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.440961] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.441407] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.441789] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.458131] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 425984 csum 0x708d52c8 expected csum 0x00000000 mirror 1
[91323.458167] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 430080 csum 0x295c9299 expected csum 0x00000000 mirror 1
[91323.465224] BTRFS warning (device sda4): csum failed root 5 ino 
1070749910 off 2744320 csum 0x349a5df4 expected csum 0x00000000 mirror 1
[91323.531707] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.545737] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.546549] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.547039] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.547595] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.548229] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.605334] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.619574] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.619949] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.620344] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.634451] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.634931] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.635311] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.700115] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.714431] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.714766] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.715213] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.715696] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.716003] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.716445] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.716764] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.763195] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.777742] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.778098] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.785175] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.785737] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.836944] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.851573] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.851922] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.852272] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.852623] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.853052] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.853736] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.854081] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.854587] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.854855] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.855171] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.855464] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.855739] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.856003] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.856261] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.856521] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.856777] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.857037] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.857293] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.857556] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.857812] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.858076] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.858393] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.858656] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.858969] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.859252] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.859515] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.859780] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.860037] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.860297] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.860554] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.860814] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.861070] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.861330] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.861588] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.861830] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.862534] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[91323.862777] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[96544.729579] BTRFS info (device sda4): disk space caching is enabled
[96544.907903] BTRFS info (device sda4): bdev /dev/sda4 errs: wr 0, rd 
0, flush 0, corrupt 23, gen 0
[96564.084355] btrfs_print_data_csum_error: 3 callbacks suppressed
[96564.084360] BTRFS warning (device sda4): csum failed root 5 ino 
1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
[96564.084738] BTRFS warning (device sda4): csum failed root 5 ino 
1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
[96569.215362] BTRFS warning (device sda4): csum failed root 5 ino 
1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
[96569.215683] BTRFS warning (device sda4): csum failed root 5 ino 
1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
[96636.773580] BTRFS warning (device sda4): csum failed root 5 ino 
1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
[96641.012152] BTRFS warning (device sda4): csum failed root 5 ino 
1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
[96641.012508] BTRFS warning (device sda4): csum failed root 5 ino 
1022460897 off 8192 csum 0x4ee4ca07 expected csum 0x4ee4ca87 mirror 1
[99638.309938] perf: interrupt took too long (2514 > 2500), lowering 
kernel.perf_event_max_sample_rate to 79500
[99963.456786] btrfs_printk: 55 callbacks suppressed
[99963.456799] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[99963.461266] BTRFS critical (device sda4): corrupt node: root=7 
block=644705402880 slot=247, bad key order, current 
(18446744073709551606 128 9223372547127476224) next 
(18446744073709551606 128 510283886592)
[99963.461430] BTRFS: error (device sda4) in 
btrfs_finish_ordered_io:3131: errno=-5 IO failure
[99963.461521] BTRFS info (device sda4): forced readonly
[118332.979501] perf: interrupt took too long (3149 > 3142), lowering 
kernel.perf_event_max_sample_rate to 63500

# btrfs scrub start -Bd /data/1
ERROR: there are uncorrectable errors
scrub device /dev/sda4 (id 1) done
         scrub started at Wed Jun  2 04:00:01 2021 and finished after 
03:58:49
         total bytes scrubbed: 1.11TiB with 3 errors
         error details: csum=3
         corrected errors: 0, uncorrectable errors: 3, unverified errors: 0
Scrub cancelled at /data/1

# btrfs check /dev/sda4
[1/7] checking root items
[2/7] checking extents
bad block 644705402880
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
root 5 inode 3512270 errors 2000, link count wrong
         unresolved ref dir 916764783 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 943259148 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 969705813 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 974995567 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 980161404 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 992269117 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 993044815 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 993822406 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1067415879 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1069639034 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070274492 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070433553 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070591910 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070750860 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070906112 index 2 namelen 17 name 
grub-mkconfig_lib filetype 0 errors 3, no dir item, no dir index
root 5 inode 3512278 errors 2000, link count wrong
         unresolved ref dir 916764783 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 943259148 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 969705813 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 974995567 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 980161404 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 992269117 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 993044815 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 993822406 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1067415879 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1069639034 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070274492 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070433553 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070591910 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070750860 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 1070906112 index 4 namelen 7 name grubenv 
filetype 0 errors 3, no dir item, no dir index
root 5 inode 3512279 errors 2000, link count wrong
         unresolved ref dir 916764783 index 5 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 943259148 index 5 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 969705813 index 5 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 974995567 index 5 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 980161404 index 5 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
root 5 inode 3512280 errors 2000, link count wrong
         unresolved ref dir 916764785 index 2 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 943259150 index 2 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 969705815 index 2 namelen 11 name 
unicode.pf2 filetype 0 errors 3, no dir item, no dir index
[.............................. and many more 
................................]
root 5 inode 13212542 errors 2000, link count wrong
         unresolved ref dir 916786610 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 943280989 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 969727650 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 975017417 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 980183268 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 992290605 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 993066289 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 993844140 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 1067436637 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 1069659820 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 1070295571 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 1070454374 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 1070612977 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 1070771975 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
         unresolved ref dir 1070926909 index 3 namelen 49 name 
7f60a44abc43c1dfe98d3f6da5f0df6d5e41c3ce.svn-base filetype 0 errors 3, 
no dir item, no dir index
root 5 inode 13681648 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 9 namelen 2 name 08 filetype 
2 errors 4, no inode ref
root 5 inode 13681653 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 10 namelen 2 name 09 filetype 
2 errors 4, no inode ref
root 5 inode 13681658 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 11 namelen 2 name 10 filetype 
2 errors 4, no inode ref
root 5 inode 13681663 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 12 namelen 2 name 11 filetype 
2 errors 4, no inode ref
root 5 inode 13681668 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 13 namelen 2 name 12 filetype 
2 errors 4, no inode ref
root 5 inode 13681673 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 14 namelen 2 name 13 filetype 
2 errors 4, no inode ref
root 5 inode 13681678 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 15 namelen 2 name 14 filetype 
2 errors 4, no inode ref
root 5 inode 13681683 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 16 namelen 2 name 15 filetype 
2 errors 4, no inode ref
root 5 inode 13681688 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 17 namelen 2 name 16 filetype 
2 errors 4, no inode ref
root 5 inode 13681693 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 18 namelen 2 name 17 filetype 
2 errors 4, no inode ref
root 5 inode 13681698 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 19 namelen 2 name 18 filetype 
2 errors 4, no inode ref
root 5 inode 13681703 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 20 namelen 2 name 19 filetype 
2 errors 4, no inode ref
root 5 inode 13681708 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 21 namelen 2 name 20 filetype 
2 errors 4, no inode ref
root 5 inode 13681713 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 22 namelen 2 name 21 filetype 
2 errors 4, no inode ref
root 5 inode 13681718 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 23 namelen 2 name 22 filetype 
2 errors 4, no inode ref
root 5 inode 13681723 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 24 namelen 2 name 23 filetype 
2 errors 4, no inode ref
root 5 inode 13681728 errors 2001, no inode item, link count wrong
         unresolved ref dir 13681610 index 25 namelen 2 name 24 filetype 
2 errors 4, no inode ref
[............................. and many more 
...............................]
root 5 inode 1070274489 errors 2001, no inode item, link count wrong
         unresolved ref dir 2608501 index 86490 namelen 13 name 
_delete.11674 filetype 2 errors 4, no inode ref
root 5 inode 1070433550 errors 2001, no inode item, link count wrong
         unresolved ref dir 2608501 index 86491 namelen 7 name daily.3 
filetype 2 errors 4, no inode ref
root 5 inode 1070591907 errors 2001, no inode item, link count wrong
         unresolved ref dir 2608501 index 86492 namelen 7 name daily.2 
filetype 2 errors 4, no inode ref
root 5 inode 1070750857 errors 2001, no inode item, link count wrong
         unresolved ref dir 2608501 index 86493 namelen 7 name daily.1 
filetype 2 errors 4, no inode ref
root 5 inode 1070906109 errors 2001, no inode item, link count wrong
         unresolved ref dir 2608501 index 86494 namelen 7 name daily.0 
filetype 2 errors 4, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/sda4
UUID: f3789d71-6576-400f-b729-bd37173b592a
found 1255738060800 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 10121838592
total fs tree bytes: 9876291584
total extent tree bytes: 243253248
btree space waste bytes: 2333042844
file data blocks allocated: 1244220567552
  referenced 1244174794752


