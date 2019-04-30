Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7CEDBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2019 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfD3Aai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 20:30:38 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:54927 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729391AbfD3Aah (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 20:30:37 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Apr 2019 20:30:37 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id A6C47180199C7
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2019 00:21:17 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C104D100E86C3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2019 00:21:16 +0000 (UTC)
X-Session-Marker: 73657267696F406D617474612E636F6D
X-Spam-Summary: 13,1.2,0,,d41d8cd98f00b204,sergio@matta.com,:,RULES_HIT:41:69:355:379:582:960:969:973:988:989:1152:1260:1277:1311:1313:1314:1345:1381:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2917:3138:3139:3140:3141:3142:3622:3740:3867:3868:3870:3871:3872:3873:4321:4362:4384:4605:5007:6117:6119:6238:6261:6684:7903:7904:8603:8660:8784:8906:8957:9121:10008:10848:11026:11233:11658:11914:12043:12296:12438:12555:12663:12679:12739:12740:12760:12895:12986:13019:13148:13230:13439:13870:14181:14659:14685:14721:21080:21326:21433:21451:21611:21622:21740:21795:30012:30041:30051:30054:30056:30070:30075:30090:30091,0,RBL:216.40.42.5:@matta.com:.lbl8.mailshell.net-62.14.55.100 66.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:1:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: burst81_62735e2d7cd4e
X-Filterd-Recvd-Size: 5503
Received: from mail.matta.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@sergio@matta.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2019 00:21:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Apr 2019 21:21:16 -0300
From:   Sergio Matta <sergio@matta.com>
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS changes to RO after a while
Organization: Da Matta
Reply-To: sergio@damatta.com.br
Mail-Reply-To: sergio@damatta.com.br
Message-ID: <2000b609442bc5dcebc972895e0c1a5f@matta.com>
X-Sender: sergio@matta.com
User-Agent: Roundcube Webmail/1.2.7
X-Originating-IP: [201.80.0.126]
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Sir,

It is not a urgent question. I am not loosing files.

I am using Qubes. It has all linux virtualized and based on templates. 
In my template, I changed my private.img file and it has inside /rw, 
/home and /usr/local from ext4 to btrfs, using btrfs-convert.
It starts ok, rw and after a while it changes to ro.

Thank You.



uname -a
Linux app-personal 4.19.36-1.pvops.qubes.x86_64 #1 SMP Sun Apr 21 
23:53:50 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

btrfs --version
btrfs-progs v4.20.2

sudo btrfs fi show
Label: none  uuid: a6f85221-6c15-4181-84f5-2012ebffb38d
     Total devices 1 FS bytes used 212.35GiB
     devid    1 size 250.00GiB used 249.81GiB path /dev/xvdb

/etc/fstab:
/dev/xvdb               /rw                     auto    
noauto,defaults,discard 1 2
/rw/home        /home       none    noauto,bind,defaults 0 0
/rw/usrlocal        /usr/local       none    noauto,bind,defaults 0 0


sudo btrfs fi df /rw
Data, single: total=249.00GiB, used=211.86GiB
System, single: total=4.00MiB, used=64.00KiB
Metadata, single: total=827.12MiB, used=505.20MiB
GlobalReserve, single: total=269.50MiB, used=0.00B

sudo btrfs fi df /home
Data, single: total=249.00GiB, used=211.86GiB
System, single: total=4.00MiB, used=64.00KiB
Metadata, single: total=827.12MiB, used=505.20MiB
GlobalReserve, single: total=269.50MiB, used=0.00B

sudo btrfs fi df /usr/local
Data, single: total=249.00GiB, used=211.86GiB
System, single: total=4.00MiB, used=64.00KiB
Metadata, single: total=827.12MiB, used=505.20MiB
GlobalReserve, single: total=269.50MiB, used=0.00B



MOUNT:
/dev/xvdb on /rw type btrfs 
(ro,relatime,ssd,discard,space_cache,subvolid=5,subvol=/)
/dev/xvdb on /home type btrfs 
(ro,relatime,ssd,discard,space_cache,subvolid=5,subvol=/home)
/dev/xvdb on /usr/local type btrfs 
(ro,relatime,ssd,discard,space_cache,subvolid=5,subvol=/usrlocal)
/dev/xvdb on /var/spool/cron type btrfs 
(ro,relatime,ssd,discard,space_cache,subvolid=5,subvol=/bind-dirs/var/spool/cron)



DMESG:
[  302.185704] ------------[ cut here ]------------
[  302.185726] BTRFS: Transaction aborted (error -95)
[  302.185830] WARNING: CPU: 1 PID: 1450 at 
/home/user/rpmbuild/BUILD/kernel-4.19.36/linux-4.19.36/fs/btrfs/inode.c:3063 
btrfs_finish_ordered_io+0x6f1/0x7d0 [btrfs]
[  302.185871] Modules linked in: fuse ip6table_filter ip6_tables 
xt_conntrack ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 xen_netfront edac_mce_amd crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel pcspkr btrfs xor zstd_compress raid6_pq 
libcrc32c crc32c_intel zstd_decompress xxhash binfmt_misc u2mfn(O) 
xen_gntdev xen_gntalloc xen_blkback xen_evtchn xenfs xen_privcmd 
xen_blkfront
[  302.185985] CPU: 1 PID: 1450 Comm: kworker/u8:9 Tainted: G           
O      4.19.36-1.pvops.qubes.x86_64 #1
[  302.186027] Workqueue: btrfs-endio-write btrfs_endio_write_helper 
[btrfs]
[  302.186062] RIP: 0010:btrfs_finish_ordered_io+0x6f1/0x7d0 [btrfs]
[  302.186080] Code: fc ff ff 49 8b 45 50 f0 48 0f ba a8 88 0c 00 00 02 
72 19 8b 44 24 08 83 f8 fb 74 37 89 c6 48 c7 c7 c8 de 1f c0 e8 5f 7e f4 
c0 <0f> 0b 8b 4c 24 08 ba f7 0b 00 00 48 c7 c6 d0 f2 1e c0 4c 89 ef e8
[  302.186123] RSP: 0018:ffffc90002b37dc0 EFLAGS: 00010282
[  302.186138] RAX: 0000000000000000 RBX: ffff8882e4b549a0 RCX: 
0000000000000000
[  302.186156] RDX: ffff8883d909cf40 RSI: ffff8883d90968b8 RDI: 
ffff8883d90968b8
[  302.186176] RBP: ffff8882e4b54780 R08: 0000000000000001 R09: 
0000000000000198
[  302.186195] R10: 00000000ffffffff R11: 0000000000000000 R12: 
0000000000001000
[  302.186214] R13: ffff8883a1fac1a0 R14: ffff88831fe41800 R15: 
ffff8882d16efd40
[  302.186237] FS:  0000000000000000(0000) GS:ffff8883d9080000(0000) 
knlGS:0000000000000000
[  302.186260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  302.186276] CR2: 00003f85975751c0 CR3: 0000000233502000 CR4: 
00000000000406e0
[  302.186297] Call Trace:
[  302.186325]  normal_work_helper+0xd0/0x320 [btrfs]
[  302.186344]  ? __schedule+0x3fd/0x870
[  302.186357]  process_one_work+0x191/0x370
[  302.186370]  worker_thread+0x4f/0x3b0
[  302.186382]  kthread+0xf8/0x130
[  302.186393]  ? rescuer_thread+0x340/0x340
[  302.186405]  ? kthread_create_worker_on_cpu+0x70/0x70
[  302.186422]  ret_from_fork+0x22/0x40
[  302.186436] ---[ end trace a159086bba5ec4c0 ]---
[  302.186451] BTRFS: error (device xvdb) in 
btrfs_finish_ordered_io:3063: errno=-95 unknown
[  302.186472] BTRFS info (device xvdb): forced readonly

[18866.153953] BTRFS info (device xvdb): disk space caching is enabled
[18866.153979] BTRFS error (device xvdb): Remounting read-write after 
error is not allowed
