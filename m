Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30E14299C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 01:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhJKXYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 19:24:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:42351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJKXYt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 19:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633994567;
        bh=iBvA5Rhpd0ECJUKv4e8ua0LS/DSg6TW1SIrmDcA7I+A=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=QOTpgKVIGycEWhOymZ7NMPuTcBbXhKM360w88yPtOWU/XNzFQnySPAvMqyBpSNVXi
         eTwvegQ5heWHsUf0xUrE9tKw602LeQn0ROtg1R7HenEcbX6rItat9pzMXpc0Erx78D
         MIqv+M/X1ckhvKrLwM+uA8MrTNEsCWH9eLzoH5w0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95eJ-1mmptp26C7-0163zj; Tue, 12
 Oct 2021 01:22:47 +0200
Message-ID: <91bf1af1-494b-ee3a-01c9-07a4ad836eb7@gmx.com>
Date:   Tue, 12 Oct 2021 07:22:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Kyle James Chapman <kyle.chapman@stud.uni-heidelberg.de>,
        linux-btrfs@vger.kernel.org
References: <fa22-61644680-fb-24052640@191566126>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: All Three Superblocks Damaged After Kernel Panic
In-Reply-To: <fa22-61644680-fb-24052640@191566126>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjW9r9CeKXhdWQABSUzIljFKbo1HSuuQdSPzQN/Weh6L0RczKIj
 R94q6QBxnLZWl5jW0IxHFhRm08zy4DFAFl0Eh97wwCgo424cKHr+NyflGyWnQlZsim3ijUh
 zhuV3QeFYcl9SpRk2Gwm9LiJbg8U6QCRlPcsohaPOPn3EHRB0ibzX9lHAA1UPGbA31K799t
 EbrvzE1BcVmvI0D5bekjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:biK1WMvD7IY=:AFmfEe9sn4MgvP2EV/gcPi
 IoaxDMT4F9gXnoGxEYC+WAvNEUWcnIHxO5pX/k6w4FKXlcmL6hHIcrjjWcccTCnabUuBF8MlL
 sArescKzcclGj5tcUHvsq4zDlK8ghHQZzBFqFAiXpC4eDAG/piKOug2/W+1OAHSb9xX2XEJSq
 0WqjUw8ONQBEw1lq2MM8s1xkK+6Bc4XTiNXrr49zM5euw0L1t5UwyGIKtVO7p00dt1DbETGsW
 xVQRXDugmiKsdG0JU1USvZ1pcAO4nVS3KUFkJnrvIUrCJXyk7NEyibYADmTk+VZhx0suauhm4
 ofeoAR+lWOx0Vnbmf0ihm62kAK/T4NY/5kEwyfOwjGD77Il1lrtQ+eVskIqS+LXZ4Wb2nF/0w
 cfSZlmuk4Cc/CzYVD9x+OzV01Gqhr33PTNxpmy+w95XlV1+1rAnW68PTKKQPLlRfzUJh2AGT8
 uUCNaaUqyvxokGliIUeXzlP4Nenc03+y1wmNXQjz3RkLRYClwJTkAM8UBw/xtPtfqVRIeL0ZX
 5xobM5f9mb+OJaI2mLjbF7sKP7N8s6e1F7FSKkLyHxmYctcuLCO383myV5K4FncyaQv/ct8Od
 qfZRvzFmpxssS1Nd+oLspH/AbtQguifhT/s4iJH5OYshowrKmkNGexK9Tgi/3xU1/r4r5Q6tT
 h87uJ8fRYcbfNnWDps1g9ajwCzheoLEuxNri9rv3jZSYAtztyszFMxFMUHAbLT3zCjhpjgDeD
 UP8uQOJ3wJT8imq1qAxQnn4TlUT4jei0+rHdwvJjNo7RhorbrwZGykqZZ6NevKSgdeQzg3625
 cQGL/EeKDDOjQ2BtpS2dvbkRqkDJp+3X+q9DswckzSP+oyfin5yrntxXfOHYtRWi2cFz/9hnr
 70psUWj/XvBTXNw1EKS/bKwAuMJa0bkuEMTk+Zu/R2pW4xde0gxzRB+Fw2GSa4wOy0HnUaK3D
 OOIIXL+G/IMuoAqwlBoC62t3OBL1+nv+VkF+w4DBQ6eKLvJZ993Cf5MeXgChFtUg1tTxAfZFe
 ZNKM9iv34GvC0kVM62EFaNUHfVpOfbHND5f8r+s+ZTIbuDTVnnKulFjH6B3rIgG7Lh5TdGhxl
 hUyNOXrf6XuUcg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/11 22:13, Kyle James Chapman wrote:
> Hello,
>
> I lost access to my home BTRFS filesystem on a 4TB SATA drive without pa=
rtitioning today.
>
> I am a graduate student of translation studies at a foreign university. =
Programming is not my specialty but have ran Linux for over a decade becau=
se I support open source endeavors. I say this for background on my techni=
cal capabilities, I am also a radio amateur extra-class in the United Stat=
es. I have some technical competence and run Arch Linux for general duty.
>
> The system boots and reads the kernel into memory from an optical ROM dr=
ive, reads keyfiles from a USB stick, decrypts the home and swap partition=
s on different devices, asks for a password for the root partition, and fi=
nishes booting. I was rebooting my system from userspace and observed a ke=
rnel panic after finishing some work repartitioning a small USB stick usin=
g gparted.

Any idea on what part is causing the panic, or any log/screenshot of the
panic message?

> After rebooting, my home BTRFS system was not mountable. Some informatio=
n seems present in some of the superblocks, but I do not understand everyt=
hing. I was careful in my use of the disk tool, and it was clear that only=
 the USB stick was being accessed, because of the simple work I was doing,=
 resizing a partition on the obvious drive. I would like to recover the da=
ta. I finished writing my master's thesis and have already submitted it, s=
o no real work was lost, but I would like to understand why this is happen=
ing and how the data can be recovered. A memory fault seems plausible, but=
 the fact that I was accessing the partitions (through gparted) seems to i=
ndicate other possibilities. Please do not get sidetracked into thinking I=
 wrote data on the drive through carelessness. I have made many many uses =
of disk tools throughout my life and the simple nature of the operations w=
hich did not involve the filesystem in question are completely understanda=
ble and I remember them clearly.
>
> Please advise.
>
> Relevant /dev/fstab entry which has worked for several months until I co=
mmented it out today:
>
> #/dev/mapper/home	/home		btrfs		rw,compress,autodefrag,inode_cache	0   1

Inode cache is already deprecated, but it won't do anything to the
kernel, thus it shouldn't cause any problem.

>
> cat /proc/version:
>
> Linux version 5.15.0-rc3-1-git-00319-g7b66f4393ad4 (linux-git@archlinux)=
 (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Sun, 03 O=
ct 2021 17:24:26 +0000
>
>
> sudo  smartctl -a /dev/sdd excerpt:
>
> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Model Family:     Seagate Barracuda 2.5 5400
> Device Model:     ST4000LM024-2AN17V
> Serial Number:    WCK03H8Y
> LU WWN Device Id: 5 000c50 09e55827b
> Firmware Version: 0001
> User Capacity:    4,000,787,030,016 bytes [4.00 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    5526 rpm
> Form Factor:      2.5 inches
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   ACS-3 T13/2161-D revision 5
> SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
> Local Time is:    Mon Oct 11 16:07:49 2021 CEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>
> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
> SMART overall-health self-assessment test result: PASSED
>
> btrfs --version:
>
> btrfs-progs v5.14.1
>
>
> sudo btrfs inspect-internal dump-super -s 0 /dev/mapper/home :
>
> superblock: bytenr=3D65536, device=3D/dev/mapper/home

The first copy in fact looks pretty good.

If there is something wrong, then it would be in the backup roots or sys
chunk map.

Mind to dump the full super block with "btrfs ins dump-super -Ffa"?
> ---------------------------------------------------------
> csum_type		0 (crc32c)
> csum_size		4
> csum			0xc59083ff [DON'T MATCH]
> bytenr			65536
> flags			0x1
> 			( WRITTEN )
> magic			_BHRfS_M [match]
> fsid			bd5872ad-8fee-4d90-b048-b81120ce3254
> metadata_uuid		bd5872ad-8fee-4d90-b048-b81120ce3254
> label
> generation		161054
> root			4028020703232
> sys_array_size		129
> chunk_root_generation	154912
> root_level		1
> chunk_root		22020096
> chunk_root_level	1
> log_root		0
> log_root_transid	0
> log_root_level		0
> total_bytes		4000787030016
> bytes_used		3969357348864
> sectorsize		4096
> nodesize		16384
> leafsize (deprecated)	16384
> stripesize		4096
> root_dir		6
> num_devices		1
> compat_flags		0x0
> compat_ro_flags		0x0
> incompat_flags		0x161
> 			( MIXED_BACKREF |
> 			  BIG_METADATA |
> 			  EXTENDED_IREF |
> 			  SKINNY_METADATA )
> cache_generation	161054
> uuid_tree_generation	161054
> dev_item.uuid		47593c4d-689d-4e1e-a310-dc7b8ab26c51
> dev_item.fsid		bd5872ad-8fee-4d90-b048-b81120ce3254 [match]
> dev_item.type		0
> dev_item.total_bytes	4000787030016
> dev_item.bytes_used	3997564731392
> dev_item.io_align	4096
> dev_item.io_width	4096
> dev_item.sector_size	4096
> dev_item.devid		1
> dev_item.dev_group	0
> dev_item.seek_speed	0
> dev_item.bandwidth	0
> dev_item.generation	0
>
> sudo btrfs inspect-internal dump-super -s 1 /dev/mapper/home :
>
> superblock: bytenr=3D67108864, device=3D/dev/mapper/home
> ---------------------------------------------------------
> csum_type		0 (crc32c)
> csum_size		4
> csum			0x65f1ab31 [DON'T MATCH]
> bytenr			14039944498490823899
> flags			0xcdc898509422934d
> 			( WRITTEN |
> 			  unknown flag: 0xcdc898509422934c )

The 2nd one begins to have some garbage, but not yet full of garbage.

This means there are some writes into the 2nd super block, and mostly
the writes are just into part of the super block.

> magic			_BHRfS_M [match]
> fsid			4468b2e4-d249-639c-dc54-792caf170cc9
> metadata_uuid		4468b2e4-d249-639c-dc54-792caf170cc9

The UUID is damaged.

> label
> generation		161054
> root			4028020703232 > sys_array_size		129
> chunk_root_generation	154912
> root_level		1
> chunk_root		22020096
> chunk_root_level	1

But then some good data.

> log_root		11922660382425005768
> log_root_transid	14582268926853107316
> log_root_level		0
> total_bytes		10532150587539085458
> bytes_used		8124524553913841719

Some garbage again.

I don't think it can be even caused by simple memory corruption, too
many random part gets corrupted.

It's really hard to say if btrfs itself is involved, until we see the
calltrace.


For the recovery, the superblock needs to be manually fixed to allow any
further data salvage attempts.

And that can only be done with the extra "btrfs ins dump-super -Ffa" outpu=
t.

Thanks,
Qu

> sectorsize		4096
> nodesize		16384
> leafsize (deprecated)	16384
> stripesize		4096
> root_dir		6
> num_devices		1
> compat_flags		0x0
> compat_ro_flags		0x0
> incompat_flags		0x161
> 			( MIXED_BACKREF |
> 			  BIG_METADATA |
> 			  EXTENDED_IREF |
> 			  SKINNY_METADATA )
> cache_generation	161054
> uuid_tree_generation	161054
> dev_item.uuid		47593c4d-689d-4e1e-a310-dc7b8ab26c51
> dev_item.fsid		bd5872ad-8fee-4d90-b048-b81120ce3254 [DON'T MATCH]
> dev_item.type		0
> dev_item.total_bytes	4000787030016
> dev_item.bytes_used	3997564731392
> dev_item.io_align	4096
> dev_item.io_width	4096
> dev_item.sector_size	4096
> dev_item.devid		1
> dev_item.dev_group	0
> dev_item.seek_speed	0
> dev_item.bandwidth	0
> dev_item.generation	0
>
> sudo btrfs inspect-internal dump-super -s 2 /dev/mapper/home:
>
> superblock: bytenr=3D274877906944, device=3D/dev/mapper/home
> ---------------------------------------------------------
> csum_type		62267 (INVALID)
> csum_size		32
> csum			0x9876fd000000000000000000000000000000000000000000000000000000000=
0 [UNKNOWN CSUM TYPE OR SIZE]
> bytenr			274877906944
> flags			0x1
> 			( WRITTEN )
> magic			_BHRfS_M [match]
> fsid			bd5872ad-8fee-4d90-b048-b81120ce3254
> metadata_uuid		07eb556b-df56-afbd-12c1-32f496c9ae5e
> label			...^k...cA..[....ws.......!...&+..@...U.^..Fi.....^s....%.....G.=
....\..z.0..8N......l
> generation		161054
> root			4028020703232
> sys_array_size		1346087890
> chunk_root_generation	14973196025592430218
> root_level		113
> chunk_root		22020096
> chunk_root_level	54
> log_root		0
> log_root_transid	0
> log_root_level		77
> total_bytes		4000787030016
> bytes_used		3969357348864
> sectorsize		544999736
> nodesize		1626255393
> leafsize (deprecated)	365786189
> stripesize		1625894637
> root_dir		4621774357935484814
> num_devices		6281988177397337675
> compat_flags		0x9c8dbbf37bf3e638
> compat_ro_flags		0xe392e94b904707de
> 			( FREE_SPACE_TREE_VALID |
> 			  unknown flag: 0xe392e94b904707dc )
> incompat_flags		0xe7c3113fe08815af
> 			( MIXED_BACKREF |
> 			  DEFAULT_SUBVOL |
> 			  MIXED_GROUPS |
> 			  COMPRESS_LZO |
> 			  BIG_METADATA |
> 			  RAID56 |
> 			  SKINNY_METADATA |
> 			  METADATA_UUID |
> 			  ZONED |
> 			  unknown flag: 0xe7c3113fe0880000 )
> cache_generation	2740636164699663627
> uuid_tree_generation	143387309824099247
> dev_item.uuid		8ca1383a-3aaf-986e-30f3-1081cc4423b9
> dev_item.fsid		d3b80203-160e-b664-1fa0-0121596e5fbf [DON'T MATCH]
> dev_item.type		2243501307224589742
> dev_item.total_bytes	17886909296177165879
> dev_item.bytes_used	843442598421986990
> dev_item.io_align	3037217492
> dev_item.io_width	3952451380
> dev_item.sector_size	2707671125
> dev_item.devid		4105250638360812501
> dev_item.dev_group	3766056873
> dev_item.seek_speed	182
> dev_item.bandwidth	229
> dev_item.generation	9452573969509059034
>
>
