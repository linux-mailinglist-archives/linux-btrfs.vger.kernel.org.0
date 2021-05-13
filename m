Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF82B37FDC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhEMTFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 15:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbhEMTFG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 15:05:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4428661264
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620932636;
        bh=x6Ne2kpOkKWHFM2g8hiAABVBwoV/AbnXZTncwTcw+o4=;
        h=Date:From:To:Subject:From;
        b=dhnL6t89TVwPSi1lyrLHvZFiApX8H9T1enyY8tnK6KkXQJb7w/7YTCZ64RGCbhgk7
         1nx9jSiFUItzxF+eLBGGGpK4aaOCEJvRCGn+f2s48r0j34J858Tj7+mORTp3WiOE9v
         6yl3A3UATuTwcr8T/dUQq5LzDNpD4XCd3/2KY8pKvURcXveANEkYYafbro0vSU/ixf
         WXFpWqTMAcEmOpR1/sucbe9Si+H7Rz3C3r0W8M8JDCORFh1qgc+L2jOZTzB7X/4Es5
         ZIZlzmnjbuqzdmENjex0mBKJ3uq6Ul1hjfxFrUMZOi8In2iqm6/LkceMaSH9WA+UUy
         MKwFgHxUJ1fyg==
Date:   Thu, 13 May 2021 12:03:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: btrfs/232 crashing on 5.13-rc1?
Message-ID: <20210513190355.GA9610@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone,

Sorry if this has already been fixed somewhere else, but I noticed the
following crash in btrfs/232 on 5.13-rc1.  It's not quite vanilla, but
the only changes to the kernel source are some unexciting xfs realtime
bug fixes:

 run fstests btrfs/232 at 2021-05-12 19:53:40
 BTRFS info (device sda3): disk space caching is enabled
 BTRFS info (device sda3): has skinny extents
 BTRFS: device fsid 83eea612-5b69-486e-9e29-b1e46742d469 devid 1 transid 5 /dev/sda4 scanned by mkfs.btrfs (1783608)
 BTRFS info (device sda4): disk space caching is enabled
 BTRFS info (device sda4): has skinny extents
 BTRFS info (device sda4): flagging fs with big metadata feature
 BTRFS info (device sda4): checking UUID tree
 BTRFS warning (device sda4): qgroup rescan is already in progress
 BTRFS info (device sda4): qgroup scan completed (inconsistency flag cleared)
 BUG: unable to handle page fault for address: ffffffffffffff86
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 43f010067 P4D 43f010067 PUD 43f012067 PMD 0 
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 PID: 1783648 Comm: fsstress Not tainted 5.13.0-rc1-xfsx #rc1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
 RIP: 0010:btrfs_update_root_times+0x3a/0x90 [btrfs]
 Code: 8d a3 98 04 00 00 48 83 ec 18 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 48 89 e7 e8 be d0 b7 e0 4c 89 e7 e8 76 c1 19 e1 <48> 8b 45 00 4c 89 e7 48 89 83 4f 01 00 00 48 8b 04 24 48 89 83 6f
 RSP: 0018:ffffc90002e57d88 EFLAGS: 00010246
 RAX: ffff888102513e80 RBX: ffff888142406000 RCX: 0000000000000017
 RDX: 0000000000000001 RSI: 00000000001623ac RDI: ffff888142406498
 RBP: ffffffffffffff86 R08: 0017b8ff80000000 R09: 0000000000000005
 R10: 0000000000000000 R11: ffff88810479ee30 R12: ffff888142406498
 R13: ffffffffffffff86 R14: ffff8882f393e548 R15: 0000000000000000
 FS:  00007f3872c9d740(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffff86 CR3: 000000016afce000 CR4: 00000000001506b0
 Call Trace:
  btrfs_update_inode+0x8e/0x100 [btrfs]
  btrfs_fileattr_set+0x282/0x470 [btrfs]
  vfs_fileattr_set+0x21e/0x260
  do_vfs_ioctl+0xc9/0x920
  __x64_sys_ioctl+0x3d/0xa0
  do_syscall_64+0x3a/0x70
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f3872db750b
 Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
 RSP: 002b:00007fff626c66b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f3872db750b
 RDX: 00007fff626c6770 RSI: 00000000401c5820 RDI: 0000000000000004
 RBP: 0000000000000004 R08: 0000000000000048 R09: 0000000000000001
 R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000002de
 R13: 0000000000000000 R14: 00007fff626c6770 R15: 000055df450225e0
 Modules linked in: ext4 mbcache jbd2 dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey btrfs xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip_set_hash_ip ip_set_hash_net auth_rpcgss oid_registry xt_tcpudp xt_set ip_set_hash_mac blake2b_generic xor zstd_decompress zstd_compress lzo_compress lzo_decompress zlib_deflate ip_set nfnetlink ip6table_filter ip6_tables raid6_pq libcrc32c iptable_filter sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
 Dumping ftrace buffer:
    (ftrace buffer empty)
 CR2: ffffffffffffff86
 ---[ end trace 4d6b79bcb0d4bd5f ]---

--D
