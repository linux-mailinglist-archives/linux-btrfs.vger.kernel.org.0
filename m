Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E7442388
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 23:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKAWrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 18:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhKAWq7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 18:46:59 -0400
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A7C061714
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Nov 2021 15:44:25 -0700 (PDT)
Received: from jumpgate.fsf.org ([74.94.156.211]:36580 helo=mail.iankelling.org)
        by mail.fsf.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <iank@fsf.org>)
        id 1mhg2R-0003gt-JH
        for linux-btrfs@vger.kernel.org; Mon, 01 Nov 2021 18:44:23 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.93)
        (envelope-from <iank@fsf.org>)
        id 1mhg2Q-00C0vC-JN
        for linux-btrfs@vger.kernel.org; Mon, 01 Nov 2021 18:44:22 -0400
User-agent: mu4e 1.7.0; emacs 28.0.50
From:   Ian Kelling <iank@fsf.org>
To:     linux-btrfs@vger.kernel.org
Subject: NULL pointer dereference while balancing
Date:   Mon, 01 Nov 2021 18:40:19 -0400
Message-ID: <87zgqncx89.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It happened near the end of a data balance. The filesystem stopped doing
writes. I rebooted and it seems to be working fine again. Just sharing
in case it is useful.

#   uname -a
Linux hostname-redacted.fsf.org 5.11.0-38-generic #42~20.04.1-Ubuntu SMP Tue Sep 28 20:41:07 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
 #   btrfs --version
btrfs-progs v5.14.1
 #   btrfs fi show
Label: none  uuid: cdbab81e-20ec-49e6-904c-649f6096b112
        Total devices 6 FS bytes used 17.08TiB
        devid    1 size 14.55TiB used 8.61TiB path /dev/mapper/btrfs0
        devid    2 size 14.55TiB used 8.61TiB path /dev/mapper/btrfs2
        devid    3 size 14.55TiB used 8.61TiB path /dev/mapper/btrfs1
        devid    4 size 14.55TiB used 8.55TiB path /dev/mapper/btrfs3
        devid    5 size 14.55TiB used 8.54TiB path /dev/mapper/btrfs4
        devid    6 size 14.55TiB used 8.54TiB path /dev/mapper/btrfs5

 # btrfs fi df /srv/backup-online
Data, RAID1C3: total=17.03TiB, used=16.97TiB
System, RAID1C3: total=32.00MiB, used=3.20MiB
Metadata, RAID1C3: total=120.00GiB, used=119.12GiB
GlobalReserve, single: total=512.00MiB, used=176.00KiB

dmesg output

[762015.588861] BUG: kernel NULL pointer dereference, address: 0000000000000001
[762015.590331] #PF: supervisor read access in kernel mode
[762015.590331] #PF: error_code(0x0000) - not-present page
[762015.590331] PGD 10576c067 P4D 10576c067 PUD 89b4de067 PMD 0 
[762015.590331] Oops: 0000 [#1] SMP NOPTI
[762015.590331] CPU: 3 PID: 7545 Comm: rest-server Not tainted 5.11.0-38-generic #42~20.04.1-Ubuntu
[762015.590331] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[762015.638083] RIP: 0010:__set_page_dirty_buffers+0x5a/0x110
[762015.638083] Code: 00 49 8b 04 24 f6 c4 20 74 35 49 8b 04 24 f6 c4 20 0f 84 bc 00 00 00 49 8b 44 24 28 48 89 c2 eb 09 48 8b 52 08 48 39 d0 74 15 <48> 8b 0a 83 e1 02 75 ef f0 80 0a 02 48 8b 52 08 48 39 d0 75 eb 4c
[762015.638083] RSP: 0018:ffffba364777fba8 EFLAGS: 00010202
[762015.638083] RAX: 0000000000000001 RBX: ffff9fa9e055ca00 RCX: 0000000000000000
[762015.638083] RDX: 0000000000000001 RSI: ffffffffc02bf23d RDI: ffff9fa9e055ca84
[762015.638083] RBP: ffffba364777fbc0 R08: 0000000000000000 R09: ffffba364777fb14
[762015.638083] R10: ffff9fa20330d800 R11: ffff9fa208397000 R12: ffffe2278211b000
[762015.638083] R13: ffff9fa9e055ca84 R14: ffff9fa9e055c680 R15: 0000000000000000
[762015.638083] FS:  000000c000681890(0000) GS:ffff9faa3fac0000(0000) knlGS:0000000000000000
[762015.638083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[762015.638083] CR2: 0000000000000001 CR3: 0000000106d7c000 CR4: 00000000000406e0
[762015.638083] Call Trace:
[762015.638083]  set_page_dirty+0x61/0xc0
[762015.638083]  btrfs_dirty_pages+0xd7/0x110 [btrfs]
[762015.638083]  __btrfs_write_out_cache+0x34f/0x4b0 [btrfs]
[762015.638083]  btrfs_write_out_cache+0x82/0xf0 [btrfs]
[762015.638083]  btrfs_start_dirty_block_groups+0x1ff/0x4f0 [btrfs]
[762015.638083]  btrfs_commit_transaction+0xc2/0xa70 [btrfs]
[762015.638083]  ? start_transaction+0xd5/0x590 [btrfs]
[762015.638083]  ? dput+0x62/0x320
[762015.638083]  btrfs_sync_file+0x35d/0x480 [btrfs]
[762015.638083]  vfs_fsync_range+0x49/0x80
[762015.638083]  ? __fget_light+0x62/0x80
[762015.638083]  do_fsync+0x3d/0x70
[762015.638083]  __x64_sys_fsync+0x14/0x20
[762015.638083]  do_syscall_64+0x38/0x90
[762015.638083]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[762015.638083] RIP: 0033:0x4b57fb
[762015.638083] Code: fb ff eb bd e8 06 50 fb ff e9 61 ff ff ff cc e8 7b 1c fb ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[762015.638083] RSP: 002b:000000c0000697e0 EFLAGS: 00000206 ORIG_RAX: 000000000000004a
[762015.638083] RAX: ffffffffffffffda RBX: 000000c00002e800 RCX: 00000000004b57fb
[762015.638083] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
[762015.638083] RBP: 000000c000069820 R08: 0000000000000001 R09: fffff80000000001
[762015.638083] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
[762015.638083] R13: 000000c00024bc80 R14: 000080c000400000 R15: 0000000000000000
[762015.638083] Modules linked in: dm_crypt algif_skcipher af_alg nf_log_ipv6 xt_hl ip6t_rt ip6t_REJECT nf_reject_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_recent xt_limit xt_tcpudp xt_addrtype xt_conntrack kvm_amd ccp ipt_REJECT kvm nf_reject_ipv4 crct10dif_pclmul crc32_pclmul ip6table_filter ghash_clmulni_intel ip6_tables aesni_intel nf_conntrack_netbios_ns nf_conntrack_broadcast crypto_simd input_leds joydev cryptd nf_nat_ftp glue_helper serio_raw nf_nat nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter sch_fq_codel bpfilter sunrpc ip_tables x_tables autofs4 xfs btrfs blake2b_generic xor raid6_pq libcrc32c virtio_net psmouse net_failover virtio_blk failover floppy
[762015.638083] CR2: 0000000000000001
[762016.017540] ---[ end trace d88a46a2c96f3118 ]---
[762016.024758] RIP: 0010:__set_page_dirty_buffers+0x5a/0x110
[762016.032920] Code: 00 49 8b 04 24 f6 c4 20 74 35 49 8b 04 24 f6 c4 20 0f 84 bc 00 00 00 49 8b 44 24 28 48 89 c2 eb 09 48 8b 52 08 48 39 d0 74 15 <48> 8b 0a 83 e1 02 75 ef f0 80 0a 02 48 8b 52 08 48 39 d0 75 eb 4c
[762016.055583] RSP: 0018:ffffba364777fba8 EFLAGS: 00010202
[762016.061236] RAX: 0000000000000001 RBX: ffff9fa9e055ca00 RCX: 0000000000000000
[762016.068966] RDX: 0000000000000001 RSI: ffffffffc02bf23d RDI: ffff9fa9e055ca84
[762016.077362] RBP: ffffba364777fbc0 R08: 0000000000000000 R09: ffffba364777fb14
[762016.086150] R10: ffff9fa20330d800 R11: ffff9fa208397000 R12: ffffe2278211b000
[762016.095117] R13: ffff9fa9e055ca84 R14: ffff9fa9e055c680 R15: 0000000000000000
[762016.105129] FS:  000000c000681890(0000) GS:ffff9faa3fac0000(0000) knlGS:0000000000000000
[762016.116998] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[762016.124153] CR2: 0000000000000001 CR3: 0000000106d7c000 CR4: 00000000000406e0
[762040.956585] BTRFS critical (device dm-5): corrupt leaf: root=1 block=1371110457344 slot=6 ino=4227, invalid mode: has 00 expect valid S_IF* bit(s)
[762040.997627] BTRFS info (device dm-5): leaf 1371110457344 gen 255620 total ptrs 60 free space 8393 owner 1
[762041.009561]         item 0 key (4221 1 0) itemoff 16123 itemsize 160
[762041.022141]                 inode generation 0 size 262144 mode 100600
[762041.028192]         item 1 key (4221 108 0) itemoff 16070 itemsize 53
[762041.040761]                 extent data disk bytenr 5483252187136 nr 262144
[762041.048162]                 extent data offset 0 nr 262144 ram 262144
[762041.053693]         item 2 key (4224 1 0) itemoff 15910 itemsize 160
[762041.063935]                 inode generation 0 size 262144 mode 100600
[762041.074938]         item 3 key (4224 108 0) itemoff 15857 itemsize 53
[762041.088608]                 extent data disk bytenr 5483257683968 nr 262144
[762041.102739]                 extent data offset 0 nr 262144 ram 262144
[762041.120975]         item 4 key (4225 1 0) itemoff 15697 itemsize 160
[762041.130203]                 inode generation 0 size 262144 mode 100600
[762041.137582]         item 5 key (4225 108 0) itemoff 15644 itemsize 53
[762041.145184]                 extent data disk bytenr 5483265597440 nr 262144
[762041.152361]                 extent data offset 0 nr 262144 ram 262144
[762041.161727]         item 6 key (4227 1 0) itemoff 15484 itemsize 160
[762041.170297]                 inode generation 0 size 262144 mode 0
[762041.176653]         item 7 key (4227 108 0) itemoff 15431 itemsize 53
[762041.183734]                 extent data disk bytenr 5483283075072 nr 262144
[762041.190740]                 extent data offset 0 nr 262144 ram 262144
[762041.197287]         item 8 key (4229 1 0) itemoff 15271 itemsize 160
[762041.204643]                 inode generation 177936 size 262144 mode 100600
[762041.212830]         item 9 key (4229 108 0) itemoff 15218 itemsize 53
[762041.219857]                 extent data disk bytenr 4553824010240 nr 262144
[762041.226694]                 extent data offset 0 nr 262144 ram 262144
[762041.236668]         item 10 key (4231 1 0) itemoff 15058 itemsize 160
[762041.243789]                 inode generation 177936 size 262144 mode 100600
[762041.250168]         item 11 key (4231 108 0) itemoff 15005 itemsize 53
[762041.258015]                 extent data disk bytenr 4554353876992 nr 262144
[762041.265384]                 extent data offset 0 nr 262144 ram 262144
[762041.271538]         item 12 key (4233 1 0) itemoff 14845 itemsize 160
[762041.278874]                 inode generation 177302 size 262144 mode 100600
[762041.286131]         item 13 key (4233 108 0) itemoff 14792 itemsize 53
[762041.292222]                 extent data disk bytenr 4554982940672 nr 262144
[762041.298621]                 extent data offset 0 nr 262144 ram 262144
[762041.304914]         item 14 key (4234 1 0) itemoff 14632 itemsize 160
[762041.312524]                 inode generation 177936 size 262144 mode 100600
[762041.312527]         item 15 key (4234 108 0) itemoff 14579 itemsize 53
[762041.312527]                 extent data disk bytenr 4550949793792 nr 262144
[762041.312527]                 extent data offset 0 nr 262144 ram 262144
[762041.312527]         item 16 key (4236 1 0) itemoff 14419 itemsize 160
[762041.312527]                 inode generation 177302 size 262144 mode 100600
[762041.312527]         item 17 key (4236 108 0) itemoff 14366 itemsize 53
[762041.312527]                 extent data disk bytenr 4555210395648 nr 262144
[762041.312527]                 extent data offset 0 nr 262144 ram 262144
[762041.312527]         item 18 key (4237 1 0) itemoff 14206 itemsize 160
[762041.312528]                 inode generation 187358 size 262144 mode 100600
[762041.384297]         item 19 key (4237 108 0) itemoff 14153 itemsize 53
[762041.384305]                 extent data disk bytenr 2705354170368 nr 262144
[762041.384308]                 extent data offset 0 nr 262144 ram 262144
[762041.384310]         item 20 key (4240 1 0) itemoff 13993 itemsize 160
[762041.384314]                 inode generation 177302 size 262144 mode 100600
[762041.384317]         item 21 key (4240 108 0) itemoff 13940 itemsize 53
[762041.384320]                 extent data disk bytenr 4555236409344 nr 262144
[762041.384323]                 extent data offset 0 nr 262144 ram 262144
[762041.384325]         item 22 key (4243 1 0) itemoff 13780 itemsize 160
[762041.384328]                 inode generation 177302 size 262144 mode 100600
[762041.384330]         item 23 key (4243 108 0) itemoff 13727 itemsize 53
[762041.384333]                 extent data disk bytenr 4555236671488 nr 262144
[762041.384335]                 extent data offset 0 nr 262144 ram 262144
[762041.384337]         item 24 key (4245 1 0) itemoff 13567 itemsize 160
[762041.384340]                 inode generation 177938 size 262144 mode 100600
[762041.384343]         item 25 key (4245 108 0) itemoff 13514 itemsize 53
[762041.384346]                 extent data disk bytenr 4613660700672 nr 262144
[762041.501407]                 extent data offset 0 nr 262144 ram 262144
[762041.501413]         item 26 key (4248 1 0) itemoff 13354 itemsize 160
[762041.501418]                 inode generation 186493 size 262144 mode 100600
[762041.501422]         item 27 key (4248 108 0) itemoff 13301 itemsize 53
[762041.501427]                 extent data disk bytenr 2638844817408 nr 262144
[762041.501429]                 extent data offset 0 nr 262144 ram 262144
[762041.501432]         item 28 key (4251 1 0) itemoff 13141 itemsize 160
[762041.501436]                 inode generation 177302 size 262144 mode 100600
[762041.501439]         item 29 key (4251 108 0) itemoff 13088 itemsize 53
[762041.501442]                 extent data disk bytenr 4555284959232 nr 262144
[762041.501445]                 extent data offset 0 nr 262144 ram 262144
[762041.501447]         item 30 key (4253 1 0) itemoff 12928 itemsize 160
[762041.501451]                 inode generation 177938 size 262144 mode 100600
[762041.501453]         item 31 key (4253 108 0) itemoff 12875 itemsize 53
[762041.501457]                 extent data disk bytenr 4613717594112 nr 262144
[762041.501459]                 extent data offset 0 nr 262144 ram 262144
[762041.501461]         item 32 key (4254 1 0) itemoff 12715 itemsize 160
[762041.501464]                 inode generation 177938 size 262144 mode 100600
[762041.501466]         item 33 key (4254 108 0) itemoff 12662 itemsize 53
[762041.501469]                 extent data disk bytenr 4613278470144 nr 262144
[762041.501470]                 extent data offset 0 nr 262144 ram 262144
[762041.501473]         item 34 key (4256 1 0) itemoff 12502 itemsize 160
[762041.501476]                 inode generation 177302 size 262144 mode 100600
[762041.501478]         item 35 key (4256 108 0) itemoff 12449 itemsize 53
[762041.501481]                 extent data disk bytenr 4555288244224 nr 262144
[762041.501483]                 extent data offset 0 nr 262144 ram 262144
[762041.501485]         item 36 key (4257 1 0) itemoff 12289 itemsize 160
[762041.501488]                 inode generation 177936 size 262144 mode 100600
[762041.501490]         item 37 key (4257 108 0) itemoff 12236 itemsize 53
[762041.501493]                 extent data disk bytenr 4552479526912 nr 262144
[762041.501495]                 extent data offset 0 nr 262144 ram 262144
[762041.501497]         item 38 key (4258 1 0) itemoff 12076 itemsize 160
[762041.501501]                 inode generation 177302 size 262144 mode 100600
[762041.501503]         item 39 key (4258 108 0) itemoff 12023 itemsize 53
[762041.501506]                 extent data disk bytenr 4555311644672 nr 262144
[762041.501508]                 extent data offset 0 nr 262144 ram 262144
[762041.501510]         item 40 key (4259 1 0) itemoff 11863 itemsize 160
[762041.501513]                 inode generation 255487 size 262144 mode 100600
[762041.501515]         item 41 key (4259 108 0) itemoff 11810 itemsize 53
[762041.501518]                 extent data disk bytenr 5222257565696 nr 262144
[762041.501521]                 extent data offset 0 nr 262144 ram 262144
[762041.501523]         item 42 key (4263 1 0) itemoff 11650 itemsize 160
[762041.501526]                 inode generation 175984 size 262144 mode 100600
[762041.501528]         item 43 key (4263 108 0) itemoff 11597 itemsize 53
[762041.501532]                 extent data disk bytenr 2616231034880 nr 262144
[762041.501533]                 extent data offset 0 nr 262144 ram 262144
[762041.797059]         item 44 key (4266 1 0) itemoff 11437 itemsize 160
[762041.797068]                 inode generation 177938 size 262144 mode 100600
[762041.797071]         item 45 key (4266 108 0) itemoff 11384 itemsize 53
[762041.797076]                 extent data disk bytenr 4614042877952 nr 262144
[762041.797079]                 extent data offset 0 nr 262144 ram 262144
[762041.797081]         item 46 key (4268 1 0) itemoff 11224 itemsize 160
[762041.797085]                 inode generation 177938 size 262144 mode 100600
[762041.797089]         item 47 key (4268 108 0) itemoff 11171 itemsize 53
[762041.797092]                 extent data disk bytenr 4614010925056 nr 262144
[762041.797094]                 extent data offset 0 nr 262144 ram 262144
[762041.797097]         item 48 key (4270 1 0) itemoff 11011 itemsize 160
[762041.797100]                 inode generation 255487 size 262144 mode 100600
[762041.797103]         item 49 key (4270 108 0) itemoff 10958 itemsize 53
[762041.877750]                 extent data disk bytenr 5222258798592 nr 262144
[762041.877755]                 extent data offset 0 nr 262144 ram 262144
[762041.877758]         item 50 key (4272 1 0) itemoff 10798 itemsize 160
[762041.877763]                 inode generation 255487 size 262144 mode 100600
[762041.877766]         item 51 key (4272 108 0) itemoff 10745 itemsize 53
[762041.877770]                 extent data disk bytenr 5222260088832 nr 262144
[762041.877772]                 extent data offset 0 nr 262144 ram 262144
[762041.877774]         item 52 key (4275 1 0) itemoff 10585 itemsize 160
[762041.877778]                 inode generation 255487 size 262144 mode 100600
[762041.877780]         item 53 key (4275 108 0) itemoff 10532 itemsize 53
[762041.877784]                 extent data disk bytenr 5222260510720 nr 262144
[762041.877786]                 extent data offset 0 nr 262144 ram 262144
[762041.877788]         item 54 key (4277 1 0) itemoff 10372 itemsize 160
[762041.877791]                 inode generation 255487 size 262144 mode 100600
[762041.877793]         item 55 key (4277 108 0) itemoff 10319 itemsize 53
[762041.877796]                 extent data disk bytenr 5222262603776 nr 262144
[762041.877798]                 extent data offset 0 nr 262144 ram 262144
[762041.877800]         item 56 key (4279 1 0) itemoff 10159 itemsize 160
[762041.877814]                 inode generation 255487 size 262144 mode 100600
[762041.877816]         item 57 key (4279 108 0) itemoff 10106 itemsize 53
[762041.877819]                 extent data disk bytenr 5222276358144 nr 262144
[762041.877821]                 extent data offset 0 nr 262144 ram 262144
[762041.877823]         item 58 key (4281 1 0) itemoff 9946 itemsize 160
[762041.877826]                 inode generation 255487 size 262144 mode 100600
[762041.877828]         item 59 key (4281 108 0) itemoff 9893 itemsize 53
[762041.877831]                 extent data disk bytenr 5222289219584 nr 262144
[762041.877833]                 extent data offset 0 nr 262144 ram 262144
[762041.877837] BTRFS error (device dm-5): block=1371110457344 write time tree block corruption detected


-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
