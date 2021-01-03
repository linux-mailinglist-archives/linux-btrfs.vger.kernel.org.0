Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B872E8A86
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 06:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbhACFDD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 00:03:03 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:45970 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbhACFDC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Jan 2021 00:03:02 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 5A0EF6C00692;
        Sun,  3 Jan 2021 07:02:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1609650129; bh=xcgnWMs+Jp9KYr+vyW+6WbVk2V9KtWxDvpbC7ZcYr3U=;
        h=From:To:Cc:Subject:Date;
        b=R7fhDLI5bp5F5/+gDfkOwedxXry4lL9akPxeKjsae9m1zj0Xg1d9YxibH3tpngD1k
         FQbNa9L9sIhb645PXmnTzdMxlFPbLUBu2GHJUo0tURLcFXzoU9oQG1bdH85X+ma7Ck
         fcmPwiIYaQxfc7AudqIxFUtOTChMxIRmuxV0LHTg=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 4ACA66C00691;
        Sun,  3 Jan 2021 07:02:09 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id eDz-gT8nVw7H; Sun,  3 Jan 2021 07:02:08 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id AE4BC6C0068F;
        Sun,  3 Jan 2021 07:02:08 +0200 (EET)
Received: from localhost.localdomain (unknown [211.106.132.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 03CD61BE00CF;
        Sun,  3 Jan 2021 07:02:06 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs: fix NULL pointer dereference in extent_io_tree_panic()
Date:   Sun,  3 Jan 2021 13:01:56 +0800
Message-Id: <20210103050156.2866-1-l@damenly.su>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1ygQmXfBQAprilLQu/l+fvYoxBbgBmOPC+CfkkPWBO2mWpqPg+1xV0X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

while mounting the poc image user-provided, kernel panics due to the
NULL deference of @tree->inode.
========================================================================
[  109.663024] BTRFS error: found node 12582912 29360127 on insert of 37748736 29360127
[  109.663032] BUG: kernel NULL pointer dereference, address: 0000000000000028
[  109.664494] #PF: supervisor read access in kernel mode
[  109.665543] #PF: error_code(0x0000) - not-present page
[  109.666598] PGD 0 P4D 0
[  109.667119] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  109.668015] CPU: 14 PID: 641 Comm: mount Tainted: G        W  O      5.11.0-rc1-custom #45
[  109.669707] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.14.0-1 04/01/2014
[  109.671607] RIP: 0010:extent_io_tree_panic.isra.0+0x6/0x30 [btrfs]
[  109.672911] Code: 89 fe 48 c7 c7 20 0e aa c0 48 89 e5 e8 3a b9 ee dd 0f 0b be c0 13 00 00 48 c7 c7 48 0e aa c0 e8 d1 ff ff ff 0f 1f 44 00 00 55 <48> 8b 47 28 89 f1 49 c7 c0 70 0e aa c0 ba a9 02 00 00 48 c7 c6 00
[  109.676740] RSP: 0018:ffffb76c814fb948 EFLAGS: 00010282
[  109.677808] RAX: 00000000ffffffef RBX: 0000000001bfffff RCX: 0000000000000000
[  109.679271] RDX: ffffb76c814fb99c RSI: 00000000ffffffef RDI: 0000000000000000
[  109.680722] RBP: ffffb76c814fb9e0 R08: 0000000000000001 R09: 0000000000000001
[  109.682179] R10: ffffb76c814fb658 R11: 0000000000000000 R12: ffff9acac353e500
[  109.683629] R13: ffff9acac89a8228 R14: ffff9acac353e8c0 R15: 0000000002400000
[  109.685092] FS:  00007fb1f7dc3580(0000) GS:ffff9acb48c00000(0000) knlGS:0000000000000000
[  109.686749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  109.687927] CR2: 0000000000000028 CR3: 0000000103982000 CR4: 0000000000750ee0
[  109.689380] PKRU: 55555554
[  109.689935] Call Trace:
[  109.690438]  ? set_extent_bit.cold+0x30/0x98 [btrfs]
[  109.718452]  set_extent_bits_nowait+0x1d/0x20 [btrfs]
[  109.741357]  add_extent_mapping+0x1e0/0x2f0 [btrs]
[  109.761474]  read_one_chunk+0x33c/0x420 [btrfs]
[  109.781087]  btrfs_read_chunk_tree+0x6a4/0x870 [btrfs]
[  109.800486]  ? kvm_sched_clock_read+0x18/0x40
[  109.819669]  open_ctree+0xb32/0x1734 [btrfs]
[  109.838794]  ? bdi_register_va+0x1b/0x20
[  109.857812]  ? super_setup_bdi_name+0x79/0xd0
[  109.876880]  btrfs_mount_root.cold+0x12/0xeb [btrfs]
[  109.895860]  ? __kmalloc_track_caller+0x217/0x3b0
[  109.914731]  legacy_get_tree+0x34/0x60
[  109.933041]  vfs_get_tree+0x2d/0xc0
[  109.950757]  vfs_kern_mount.part.0+0x78/0xc0
[  109.968262]  vfs_kern_mount+0x13/0x20
[  109.984976]  btrfs_mount+0x11f/0x3c0 [btrfs]
[  110.001475]  ? kfree+0x5ff/0x670
[  110.017410]  ? __kmalloc_track_caller+0x217/0x3b0
[  110.033439]  legacy_get_tree+0x34/0x60
[  110.049000]  vfs_get_tree+0x2d/0xc0
[  110.064604]  path_mount+0x48c/0xd30
[  110.080199]  __x64_sys_mount+0x108/0x140
[  110.095918]  do_syscall_64+0x38/0x50
[  110.111366]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  110.126869] RIP: 0033:0x7fb1f7f42f6e
[  110.141818] Code: 48 8b 0d 05 0f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d2 0e 0c 00 f7 d8 64 89 01 48
[  110.188250] RSP: 002b:00007fff152c68a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  110.220331] RAX: ffffffffffffffda RBX: 00007fb1f8067264 RCX: 00007fb1f7f42f6e
[  110.237474] RDX: 00005608be216360 RSI: 00005608be208690 RDI: 00005608be20f6c0
[  110.254718] RBP: 00005608be208440 R08: 0000000000000000 R09: 0000000000000001
[  110.272042] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  110.288955] R13: 00005608be20f6c0 R14: 00005608be216360 R15: 00005608be208440
[  110.305969] Modules linked in:
[  110.458051] CR2: 0000000000000028
[  110.478548] ---[ end trace 3499c8e7baa57952 ]---
========================================================================

The image has a device extent whose end(29360127) is less than the start
(37748736). btrfs did warn but continued to insert the invalid sate
to device::alloc_state tree. Then tree_insert() returned -EEXIST
because of the duplicate end. extent_io_tree_panic() was to be called.
However, the @tree->inode is NULL in extent_io_tree_panic() and it
should be NULL here because that device::alloc_state io tree's member
@private is NULL by design.

Just pass @tree->fs_info as parameter to extent_io_tree_panic()
directly. Let it panic as expected at least.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208929
Fixes: 05912a3c04eb ("btrfs: drop extent_io_ops::tree_fs_info callback")
Signed-off-by: Su Yue <l@damenly.su>

---
I don't know why insert_state() code only warns about the invalid state
and extent io operations are used in so many places. So just send the
simple patch.
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e3b72e63e42..c9cee458e001 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -676,9 +676,7 @@ alloc_extent_state_atomic(struct extent_state *prealloc)
 
 static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
 {
-	struct inode *inode = tree->private_data;
-
-	btrfs_panic(btrfs_sb(inode->i_sb), err,
+	btrfs_panic(tree->fs_info, err,
 	"locking error: extent tree was modified by another thread while locked");
 }
 
-- 
2.29.2

