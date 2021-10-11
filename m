Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38DD4291AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhJKOZL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 11 Oct 2021 10:25:11 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:16095 "EHLO
        relay.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241242AbhJKOXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 10:23:08 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 10:23:07 EDT
X-IPAS-Result: =?us-ascii?q?A2D6AwDzRWRh/6lkzoFagQmBWYF0ggIBhTKOaYIlhUqWV?=
 =?us-ascii?q?oF8CwEBAQEBAQEBAQlBBAEBh0gCJTQJDgECBAEBAQEDAgMBAQEBAQEDAQEGA?=
 =?us-ascii?q?QEBAQEGBIEkhXWGbIELAhQSAklCgliDCK1GgTGBAYl4gRAqhXkTQUuHGoFlR?=
 =?us-ascii?q?IE/glCEa4EXgkmCZQSKZR6BJ1w4Lz8MTV8LL5E+EwsngxGWRZIqBwOCBIEsi?=
 =?us-ascii?q?TEClXuDWYMHiGWGDwI1kHu2OiMGhTKBYYEBgRNxgzlQGQ+NeAEwAxaOMD8Da?=
 =?us-ascii?q?AIGCwEBAwmRYBWCIAEB?=
IronPort-Data: A9a23:zzAWIaDwOFrAzRVW/+/jw5YqxClBgxIJ4kV8jS/XYbTApD8j0mBUx
 mBKWWmDaffbZGLyfdklOty09U8H65eAm95nOVdlrnsFo1Bi8JeaX4THci8cHM8wwunrFh8PA
 xA2M4GYRCwMo/u1Si6FatANl1EkvU2zbue6WLOs1hxZH1c+EX550Es7wobVv6Yx6TSHK1LV0
 T/Ni5CHULOV82Yc3rU8sv/rRLtH5ZweiRtA1rAMTakjUGz2zxH5OKkiyZSZdBMUdGX08tmSH
 I4vxJnhlo/QEoxE5tmNyt4XeWVSKlLe0JTnZnd+A8CfbhZ+SiMa6qcpM6YsNFVtqBaDltJqz
 s0QlcOicFJ8VkHMsLx1vxhwCCZxOvUfvqLdMz6it83Wz0DHf3boyfh0Awc6MOX0+M4uWzAIr
 6RGbmlVNlba2bPeLLGTE4GAguwgPc3meogfs2llxDfxFuo7TdbeRaSP5dJZ0Do0jM1UErDSa
 qL1bBI2N02cPkMQag1/5JQWxbyzu0nRVSFilFfM5rNrylGO3Rxz3+24WDbSUofWG5kPxx7wS
 nj912D4BAwKcdaD0zSe2myji/WJni7hXo8WUrqi+ZZXbEa73WscD0VPE0ahs7+kjE/7W99eJ
 0EQ8Cc0ou4++SRHU+URQTWAoWyD4i5BSeBzMOcz6hqL0vf0vBSgUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYS/DnltzhW7jURX5PVPudgdYHFddvICLTJUb3kyfEYYL/Lud07XI9SfML
 yeigAVWa187rcMK26i/913djFpATbCXH1dsu207skqP5w90YsuazFiy9UTW6PxNNonxc7Vsl
 GMDlM/GtaYTF4PLiSqMBeUAHb2k4/yIKjKajVMH83gdG9aFpi/LkWN4uW8WyKJV3iAsImOBj
 Kj74l052XOrFCH2BZKbmqroYynqpIC5fTgfatjab8BVfr96fxKd8SdlaCa4hj62yxh9yf9nY
 MjCLq5A6Er274w5l1JaoM9DjtcWKtwWnDqKLXwG507/gOfFOib9pUktYQDeN4jVE59oUC2Or
 4gDbZLSo/mueOfzZjbK/MYOK1EUIGIgBIzn48paavGEOAkOJY3SI6C5/F/VQKQ7xP49vrmTo
 RmAtrlwlwKn3RUq6GyiNBheVV8Ydc8n9yxkZnZwYQ/ANrpKSd/H0ZrzvqAfJdEPnNGPB9YtJ
 xXZU61s2shydwk=
IronPort-HdrOrdr: A9a23:5GPtRqD94T7AfDLlHem+55DYdb4zR+YMi2TDsHoBLCC9E/b1qy
 nAppsmPHPP4gr5O0tApTnjAtjifZq0z/ccirX5Vo3NYOCJgguVxc1ZnOnfK0yKIUDDytI=
X-IronPort-Anti-Spam-Filtered: true
Received: from sogo01.urz.uni-heidelberg.de ([129.206.100.169])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2021 16:13:57 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by sogo01.urz.uni-heidelberg.de (Postfix) with ESMTP id B573E127413
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 16:13:55 +0200 (CEST)
From:   "Kyle James Chapman" <kyle.chapman@stud.uni-heidelberg.de>
X-Forward: 185.230.160.25
Content-Type: text/plain; charset="utf-8"
Date:   Mon, 11 Oct 2021 16:13:55 +0200
Subject: All Three Superblocks Damaged After Kernel Panic
MIME-Version: 1.0
To:     linux-btrfs@vger.kernel.org
Message-ID: <fa22-61644680-fb-24052640@191566126>
User-Agent: SOGoMail 2.3.23
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I lost access to my home BTRFS filesystem on a 4TB SATA drive without partitioning today.

I am a graduate student of translation studies at a foreign university. Programming is not my specialty but have ran Linux for over a decade because I support open source endeavors. I say this for background on my technical capabilities, I am also a radio amateur extra-class in the United States. I have some technical competence and run Arch Linux for general duty.

The system boots and reads the kernel into memory from an optical ROM drive, reads keyfiles from a USB stick, decrypts the home and swap partitions on different devices, asks for a password for the root partition, and finishes booting. I was rebooting my system from userspace and observed a kernel panic after finishing some work repartitioning a small USB stick using gparted. After rebooting, my home BTRFS system was not mountable. Some information seems present in some of the superblocks, but I do not understand everything. I was careful in my use of the disk tool, and it was clear that only the USB stick was being accessed, because of the simple work I was doing, resizing a partition on the obvious drive. I would like to recover the data. I finished writing my master's thesis and have already submitted it, so no real work was lost, but I would like to understand why this is happening and how the data can be recovered. A memory fault seems plausible, but the fact that I was accessing the partitions (through gparted) seems to indicate other possibilities. Please do not get sidetracked into thinking I wrote data on the drive through carelessness. I have made many many uses of disk tools throughout my life and the simple nature of the operations which did not involve the filesystem in question are completely understandable and I remember them clearly.

Please advise.

Relevant /dev/fstab entry which has worked for several months until I commented it out today:

#/dev/mapper/home	/home		btrfs		rw,compress,autodefrag,inode_cache	0   1

cat /proc/version:

Linux version 5.15.0-rc3-1-git-00319-g7b66f4393ad4 (linux-git@archlinux) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Sun, 03 Oct 2021 17:24:26 +0000


sudo  smartctl -a /dev/sdd excerpt: 

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 2.5 5400
Device Model:     ST4000LM024-2AN17V
Serial Number:    WCK03H8Y
LU WWN Device Id: 5 000c50 09e55827b
Firmware Version: 0001
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5526 rpm
Form Factor:      2.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon Oct 11 16:07:49 2021 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

btrfs --version:

btrfs-progs v5.14.1 


sudo btrfs inspect-internal dump-super -s 0 /dev/mapper/home : 

superblock: bytenr=65536, device=/dev/mapper/home
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xc59083ff [DON'T MATCH]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			bd5872ad-8fee-4d90-b048-b81120ce3254
metadata_uuid		bd5872ad-8fee-4d90-b048-b81120ce3254
label			
generation		161054
root			4028020703232
sys_array_size		129
chunk_root_generation	154912
root_level		1
chunk_root		22020096
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		4000787030016
bytes_used		3969357348864
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	161054
uuid_tree_generation	161054
dev_item.uuid		47593c4d-689d-4e1e-a310-dc7b8ab26c51
dev_item.fsid		bd5872ad-8fee-4d90-b048-b81120ce3254 [match]
dev_item.type		0
dev_item.total_bytes	4000787030016
dev_item.bytes_used	3997564731392
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

sudo btrfs inspect-internal dump-super -s 1 /dev/mapper/home :

superblock: bytenr=67108864, device=/dev/mapper/home
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x65f1ab31 [DON'T MATCH]
bytenr			14039944498490823899
flags			0xcdc898509422934d
			( WRITTEN |
			  unknown flag: 0xcdc898509422934c )
magic			_BHRfS_M [match]
fsid			4468b2e4-d249-639c-dc54-792caf170cc9
metadata_uuid		4468b2e4-d249-639c-dc54-792caf170cc9
label			
generation		161054
root			4028020703232
sys_array_size		129
chunk_root_generation	154912
root_level		1
chunk_root		22020096
chunk_root_level	1
log_root		11922660382425005768
log_root_transid	14582268926853107316
log_root_level		0
total_bytes		10532150587539085458
bytes_used		8124524553913841719
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	161054
uuid_tree_generation	161054
dev_item.uuid		47593c4d-689d-4e1e-a310-dc7b8ab26c51
dev_item.fsid		bd5872ad-8fee-4d90-b048-b81120ce3254 [DON'T MATCH]
dev_item.type		0
dev_item.total_bytes	4000787030016
dev_item.bytes_used	3997564731392
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

sudo btrfs inspect-internal dump-super -s 2 /dev/mapper/home:

superblock: bytenr=274877906944, device=/dev/mapper/home
---------------------------------------------------------
csum_type		62267 (INVALID)
csum_size		32
csum			0x9876fd0000000000000000000000000000000000000000000000000000000000 [UNKNOWN CSUM TYPE OR SIZE]
bytenr			274877906944
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			bd5872ad-8fee-4d90-b048-b81120ce3254
metadata_uuid		07eb556b-df56-afbd-12c1-32f496c9ae5e
label			...^k...cA..[....ws.......!...&+..@...U.^..Fi.....^s....%.....G.....\..z.0..8N......l
generation		161054
root			4028020703232
sys_array_size		1346087890
chunk_root_generation	14973196025592430218
root_level		113
chunk_root		22020096
chunk_root_level	54
log_root		0
log_root_transid	0
log_root_level		77
total_bytes		4000787030016
bytes_used		3969357348864
sectorsize		544999736
nodesize		1626255393
leafsize (deprecated)	365786189
stripesize		1625894637
root_dir		4621774357935484814
num_devices		6281988177397337675
compat_flags		0x9c8dbbf37bf3e638
compat_ro_flags		0xe392e94b904707de
			( FREE_SPACE_TREE_VALID |
			  unknown flag: 0xe392e94b904707dc )
incompat_flags		0xe7c3113fe08815af
			( MIXED_BACKREF |
			  DEFAULT_SUBVOL |
			  MIXED_GROUPS |
			  COMPRESS_LZO |
			  BIG_METADATA |
			  RAID56 |
			  SKINNY_METADATA |
			  METADATA_UUID |
			  ZONED |
			  unknown flag: 0xe7c3113fe0880000 )
cache_generation	2740636164699663627
uuid_tree_generation	143387309824099247
dev_item.uuid		8ca1383a-3aaf-986e-30f3-1081cc4423b9
dev_item.fsid		d3b80203-160e-b664-1fa0-0121596e5fbf [DON'T MATCH]
dev_item.type		2243501307224589742
dev_item.total_bytes	17886909296177165879
dev_item.bytes_used	843442598421986990
dev_item.io_align	3037217492
dev_item.io_width	3952451380
dev_item.sector_size	2707671125
dev_item.devid		4105250638360812501
dev_item.dev_group	3766056873
dev_item.seek_speed	182
dev_item.bandwidth	229
dev_item.generation	9452573969509059034


