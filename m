Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1721BAE69
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 21:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgD0Tsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 15:48:32 -0400
Received: from mx.ewheeler.net ([173.205.220.69]:44673 "EHLO mail.ewheeler.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgD0Tsb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 15:48:31 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 15:48:31 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.ewheeler.net (Postfix) with ESMTP id 00D32A0415
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 19:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mail.ewheeler.net ([127.0.0.1])
        by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 22ICttSqZ3D6 for <linux-btrfs@vger.kernel.org>;
        Mon, 27 Apr 2020 19:42:53 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.ewheeler.net (Postfix) with ESMTPSA id 2A21DA0669
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 19:42:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ewheeler.net 2A21DA0669
Date:   Mon, 27 Apr 2020 19:42:43 +0000 (UTC)
From:   Eric Wheeler <btrfs@lists.ewheeler.net>
X-X-Sender: lists@mail.ewheeler.net
To:     linux-btrfs@vger.kernel.org
Subject: Out of space, but not out of space
Message-ID: <alpine.LRH.2.11.2004271931100.11277@mail.ewheeler.net>
User-Agent: Alpine 2.11 (LRH 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello All,

We are using BTRFS as an archive store for virtual machines. We only
transfer the blocks that differ in 64k chunks and we snapshot between
copies to keep a history. This means that all of the data on the volume
is 64k aligned. When we formatted the volume we used default settings,
so I expect that nodesize is 16384.

We ran out of space and got the kernel dump below in Linux 4.19.86. After
rebooting, it seems that we can write to the volume. Because our
blocks are aligned, a rebalance does not seem to help trigger a metadata
resize. There is almost 1tb of space that BTRFS indicates as "Unallocated"
so I am hoping that the metadata can be encouraged to grow into that
space if the backtrace below was caused by full metadata---but even
at 92% full metadata, there is still over 2gb of free meta space so it
seems unlikely that it was out of metadata space.

We are going to upgrade to the latest kernel to see if this is a bug that
has been fixed and I can report back, but if you know this to be a fixed
bug or if you have an insight as to the cause, then I would appreciate any
feedback. Let me know if you need any additional information, see below:

These are out mount options from fstab:
    /dev/sdb /mnt/btrbackup btrfs space_cache=v2,compress-force=lzo,nofail,noexec  0  0


~]# btrfs fi usage /mnt/btrbackup/
Overall:
    Device size:		   6.00TiB
    Device allocated:		   5.07TiB
    Device unallocated:		 946.91GiB
    Device missing:		     0.00B
    Used:			   5.06TiB
    Free (estimated):		 957.94GiB	(min: 484.49GiB)
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)

Data,single: Size:4.98TiB, Used:4.97TiB (99.78%)
   /dev/sdb	   4.98TiB

Metadata,DUP: Size:47.00GiB, Used:44.34GiB (94.34%)
   /dev/sdb	  94.00GiB

System,DUP: Size:8.00MiB, Used:560.00KiB (6.84%)
   /dev/sdb	  16.00MiB

Unallocated:
   /dev/sdb	 946.91GiB


Apr 21 11:54:45 btrbackup kernel: ------------[ cut here ]------------
Apr 21 11:54:45 btrbackup kernel: WARNING: CPU: 1 PID: 1814 at fs/btrfs/extent-tree.c:2149 __btrfs_inc_extent_ref.isra.62+0x1e3/0x270 [btrfs]
Apr 21 11:54:45 btrbackup kernel: Modules linked in: binfmt_misc dm_crypt loop xt_CHECKSUM ipt_MASQUERADE ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter sunrpc btrfs xor zstd_decompress zstd_compress xxhash kvm_intel raid6_pq kvm libcrc32c irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sg virtio_balloon pcspkr i2c_piix4 ip_tables ext4 mbcache jbd2 sr_mod cdrom ata_generic pata_acpi cirrus drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ata_piix
Apr 21 11:54:45 btrbackup kernel: libata floppy virtio_net crc32c_intel i2c_core net_failover serio_raw failover dm_mirror dm_region_hash dm_log dm_mod
Apr 21 11:54:46 btrbackup kernel: CPU: 1 PID: 1814 Comm: btrfs-transacti Not tainted 4.19.86 #1
Apr 21 11:54:46 btrbackup kernel: Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
Apr 21 11:54:46 btrbackup kernel: RIP: 0010:__btrfs_inc_extent_ref.isra.62+0x1e3/0x270 [btrfs]
Apr 21 11:54:46 btrbackup kernel: Code: ff ff 49 8b 44 24 50 f0 48 0f ba a8 10 ce 00 00 02 72 19 41 83 fd fb 74 78 44 89 ee 48 c7 c7 50 8e 60 a0 31 c0 e8 bd 89 b5 e0 <0f> 0b 44 89 e9 ba 65 08 00 00 48 c7 c6 70 1a 60 a0 4c 89 e7 e8 a8
Apr 21 11:54:46 btrbackup kernel: RSP: 0018:ffffc9000139bc80 EFLAGS: 00010282
Apr 21 11:54:46 btrbackup kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
Apr 21 11:54:46 btrbackup kernel: RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff888236c568b0
Apr 21 11:54:46 btrbackup kernel: RBP: 0000000000000101 R08: 0000000000000038 R09: 0000000000000316
Apr 21 11:54:46 btrbackup kernel: R10: ffffffff82814c64 R11: 0000000000000000 R12: ffff888020e85478
Apr 21 11:54:46 btrbackup kernel: R13: 00000000ffffffe4 R14: ffff88802bebe930 R15: 000000000000239b
Apr 21 11:54:46 btrbackup kernel: FS:  0000000000000000(0000) GS:ffff888236c40000(0000) knlGS:0000000000000000
Apr 21 11:54:46 btrbackup kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 21 11:54:46 btrbackup kernel: CR2: 00007f8f389d4000 CR3: 000000005f8e8000 CR4: 00000000000406e0
Apr 21 11:54:46 btrbackup kernel: Call Trace:
Apr 21 11:54:46 btrbackup kernel: __btrfs_run_delayed_refs+0x675/0x1170 [btrfs]
Apr 21 11:54:46 btrbackup kernel: btrfs_run_delayed_refs+0xe1/0x1d0 [btrfs]
Apr 21 11:54:46 btrbackup kernel: btrfs_commit_transaction+0x2fb/0x940 [btrfs]
Apr 21 11:54:46 btrbackup kernel: ? start_transaction+0x9b/0x420 [btrfs]
Apr 21 11:54:46 btrbackup kernel: transaction_kthread+0x14d/0x180 [btrfs]
Apr 21 11:54:46 btrbackup kernel: kthread+0xf8/0x130
Apr 21 11:54:46 btrbackup kernel: ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
Apr 21 11:54:46 btrbackup kernel: ? kthread_bind+0x10/0x10
Apr 21 11:54:46 btrbackup kernel: ret_from_fork+0x35/0x40
Apr 21 11:54:46 btrbackup kernel: ---[ end trace 77c698c81b16d791 ]---
Apr 21 11:54:46 btrbackup kernel: BTRFS: error (device sdb) in __btrfs_inc_extent_ref:2149: errno=-28 No space left
Apr 21 11:54:46 btrbackup kernel: BTRFS info (device sdb): forced readonly
Apr 21 11:54:46 btrbackup kernel: BTRFS: error (device sdb) in btrfs_run_delayed_refs:2935: errno=-28 No space left
Apr 21 11:54:46 btrbackup kernel: BTRFS warning (device sdb): Skipping commit of aborted transaction.
Apr 21 11:54:46 btrbackup kernel: BTRFS: error (device sdb) in cleanup_transaction:1860: errno=-28 No space left
Apr 21 11:54:46 btrbackup kernel: BTRFS error (device sdb): pending csums is 2498560


--
Eric Wheeler
