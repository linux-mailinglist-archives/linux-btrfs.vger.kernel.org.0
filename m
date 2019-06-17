Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82BF47F36
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 12:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfFQKFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 06:05:51 -0400
Received: from briare1.fullpliant.org ([78.227.24.35]:35140 "HELO
        briare1.fullpliant.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727726AbfFQKFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 06:05:51 -0400
X-Greylist: delayed 899 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2019 06:05:51 EDT
From:   Hubert Tonneau <hubert.tonneau@fullpliant.org>
To:     linux-btrfs@vger.kernel.org
Subject: Oops in mainline kernel 4.19.50 while btrfs scrubing
Date:   Mon, 17 Jun 2019 11:53:34 GMT
Message-ID: <0J8M6DA11@briare1.fullpliant.org>
X-Mailer: Pliant 114
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Here is the report of the oops I got while scrubing 2 disks in RAID1.
No complete crash, no error reported by scrub in the end, just this strage kernel message.
The kernel is mainline 4.19.50

Label: 'data1'  uuid: a1d97cfd-e793-4a40-98ae-010454321e9c
	Total devices 2 FS bytes used 2.25TiB
	devid    1 size 3.14TiB used 2.25TiB path /dev/sda2
	devid    2 size 3.14TiB used 2.25TiB path /dev/sdb2

Data, RAID1: total=2.25TiB, used=2.24TiB
System, RAID1: total=64.00MiB, used=368.00KiB
Metadata, RAID1: total=6.00GiB, used=4.35GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

<4>[ 3851.858792] RIP: 0010:btrfs_update_device+0x1ba/0x1d0 [btrfs]
<4>[ 3851.858794] Code: 4c 89 f7 45 31 c0 ba 10 00 00 00 4c 89 ee e8 ed 39 ff ff 4c 89 f7 e8 15 0e fd ff e9 d4 fe ff ff b8 f4 ff ff ff e9 d4 fe ff ff <0f> 0b eb b7 e8 4d 19 aa cc 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
<4>[ 3851.858796] RSP: 0000:ffffac16c0e87a00 EFLAGS: 00010206
<4>[ 3851.858799] RAX: 0000000000000fff RBX: 0000000000000000 RCX: 0000032380c00200
<4>[ 3851.858800] RDX: 0000000000001000 RSI: 0000000000003f5c RDI: ffff9a4059084578
<4>[ 3851.858802] RBP: ffff9a40cbaef7e0 R08: ffffac16c0e879b0 R09: ffffac16c0e879b8
<4>[ 3851.858804] R10: 0000000000000003 R11: 0000000000000000 R12: ffff9a40d9f85600
<4>[ 3851.858805] R13: 0000000000003f3c R14: ffff9a4059084578 R15: ffff9a409b7264e0
<4>[ 3851.858808] FS:  00007fbe95d62700(0000) GS:ffff9a40dba00000(0000) knlGS:0000000000000000
<4>[ 3851.858810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 3851.858812] CR2: 00000000e614f364 CR3: 00000000c1ffa000 CR4: 00000000000006f0
<4>[ 3851.858813] Call Trace:
<4>[ 3851.858838]  ? btrfs_finish_chunk_alloc+0x10b/0x480 [btrfs]
<4>[ 3851.858854]  ? btrfs_insert_item+0x7e/0xf0 [btrfs]
<4>[ 3851.858872]  ? btrfs_create_pending_block_groups+0x103/0x220 [btrfs]
<4>[ 3851.858891]  ? __btrfs_end_transaction+0x8c/0x2e0 [btrfs]
<4>[ 3851.858909]  ? btrfs_inc_block_group_ro+0xbd/0x150 [btrfs]
<4>[ 3851.858930]  ? scrub_enumerate_chunks+0x1a7/0x5b0 [btrfs]
<4>[ 3851.858935]  ? woken_wake_function+0x20/0x20
<4>[ 3851.858956]  ? btrfs_scrub_dev+0x1fe/0x560 [btrfs]
<4>[ 3851.858960]  ? __kmalloc_track_caller+0x1ba/0x200
<4>[ 3851.858982]  ? btrfs_ioctl+0x1911/0x2c20 [btrfs]
<4>[ 3851.858986]  ? filemap_map_pages+0x35f/0x370
<4>[ 3851.858990]  ? __handle_mm_fault+0xc19/0x1400
<4>[ 3851.858993]  ? do_vfs_ioctl+0x9e/0x610
<4>[ 3851.858996]  ? create_task_io_context+0x9b/0x100
<4>[ 3851.858998]  ? get_task_io_context+0x43/0x80
<4>[ 3851.859000]  ? ksys_ioctl+0x5e/0x90
<4>[ 3851.859002]  ? __x64_sys_ioctl+0x16/0x20
<4>[ 3851.859006]  ? do_syscall_64+0x61/0x300
<4>[ 3851.859009]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[ 3851.859012] ---[ end trace b8b153a7aef691f4 ]---

scrub status for a1d97cfd-e793-4a40-98ae-010454321e9c
	scrub started at Sun Jun 16 15:03:18 2019 and finished after 04:56:01
	total bytes scrubbed: 4.50TiB with 0 errors

