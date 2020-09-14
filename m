Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6277E268DA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgINO2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 10:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgINO1y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 10:27:54 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE9B20829
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600093673;
        bh=FZEnicL3Py28tpp8sQzMyxWJigcJ4bAeNu+h2kXjV68=;
        h=From:To:Subject:Date:From;
        b=hPiT0B7BOZdP61Myt7tDM5LJbk7Ux8QqnF10tvNP0ngMtPFodXYjxJwoKW6w4JPh0
         fV1DSRmGw2L8J8UjNdDaica6exlRgAvD/9qODSHu4cD5ob6gDB4G8rDzaVFEFryqge
         uiBsnuTJiWjuqbnzzjexJ0m+6Tow568d9IdVtVYE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reschedule if necessary when logging directory items
Date:   Mon, 14 Sep 2020 15:27:50 +0100
Message-Id: <606910fad0a0c62d162acf92953d8f38c8537643.1600093362.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Logging directories with many entries can take a significant amount of
time, and in some cases monopolize a cpu/core for a long time if the
logging task doesn't happen to block often enough.

Johannes and Lu Fengqi reported test case generic/041 triggering a soft
lockup when the kernel has CONFIG_SOFTLOCKUP_DETECTOR=y. For this test
case we log an inode with 3002 hard links, and because the test removed
one hard link before fsyncing the file, the inode logging causes the
parent directory do be logged as well, which has 6004 directory items to
log (3002 BTRFS_DIR_ITEM_KEY items plus 3002 BTRFS_DIR_INDEX_KEY items),
so it can take a significant amount of time and trigger the soft lockup.

So just make tree-log.c:log_dir_items() reschedule when necessary,
releasing the current search path before doing so and then resume from
where it was before the reschedule.

The stack trace produced when the soft lockup happens is the following:

[10480.277653] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [xfs_io:28172]
[10480.279418] Modules linked in: dm_thin_pool dm_persistent_data (...)
[10480.284915] irq event stamp: 29646366
[10480.285987] hardirqs last  enabled at (29646365): [<ffffffff85249b66>] __slab_alloc.constprop.0+0x56/0x60
[10480.288482] hardirqs last disabled at (29646366): [<ffffffff8579b00d>] irqentry_enter+0x1d/0x50
[10480.290856] softirqs last  enabled at (4612): [<ffffffff85a00323>] __do_softirq+0x323/0x56c
[10480.293615] softirqs last disabled at (4483): [<ffffffff85800dbf>] asm_call_on_stack+0xf/0x20
[10480.296428] CPU: 2 PID: 28172 Comm: xfs_io Not tainted 5.9.0-rc4-default+ #1248
[10480.298948] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[10480.302455] RIP: 0010:__slab_alloc.constprop.0+0x19/0x60
[10480.304151] Code: 86 e8 31 75 21 00 66 66 2e 0f 1f 84 00 00 00 (...)
[10480.309558] RSP: 0018:ffffadbe09397a58 EFLAGS: 00000282
[10480.311179] RAX: ffff8a495ab92840 RBX: 0000000000000282 RCX: 0000000000000006
[10480.313242] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff85249b66
[10480.315260] RBP: ffff8a497d04b740 R08: 0000000000000001 R09: 0000000000000001
[10480.317229] R10: ffff8a497d044800 R11: ffff8a495ab93c40 R12: 0000000000000000
[10480.319169] R13: 0000000000000000 R14: 0000000000000c40 R15: ffffffffc01daf70
[10480.321104] FS:  00007fa1dc5c0e40(0000) GS:ffff8a497da00000(0000) knlGS:0000000000000000
[10480.323559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10480.325235] CR2: 00007fa1dc5befb8 CR3: 0000000004f8a006 CR4: 0000000000170ea0
[10480.327259] Call Trace:
[10480.328286]  ? overwrite_item+0x1f0/0x5a0 [btrfs]
[10480.329784]  __kmalloc+0x831/0xa20
[10480.331009]  ? btrfs_get_32+0xb0/0x1d0 [btrfs]
[10480.332464]  overwrite_item+0x1f0/0x5a0 [btrfs]
[10480.333948]  log_dir_items+0x2ee/0x570 [btrfs]
[10480.335413]  log_directory_changes+0x82/0xd0 [btrfs]
[10480.336926]  btrfs_log_inode+0xc9b/0xda0 [btrfs]
[10480.338374]  ? init_once+0x20/0x20 [btrfs]
[10480.339711]  btrfs_log_inode_parent+0x8d3/0xd10 [btrfs]
[10480.341257]  ? dget_parent+0x97/0x2e0
[10480.342480]  btrfs_log_dentry_safe+0x3a/0x50 [btrfs]
[10480.343977]  btrfs_sync_file+0x24b/0x5e0 [btrfs]
[10480.345381]  do_fsync+0x38/0x70
[10480.346483]  __x64_sys_fsync+0x10/0x20
[10480.347703]  do_syscall_64+0x2d/0x70
[10480.348891]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10480.350444] RIP: 0033:0x7fa1dc80970b
[10480.351642] Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 (...)
[10480.356952] RSP: 002b:00007fffb3d081d0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
[10480.359458] RAX: ffffffffffffffda RBX: 0000562d93d45e40 RCX: 00007fa1dc80970b
[10480.361426] RDX: 0000562d93d44ab0 RSI: 0000562d93d45e60 RDI: 0000000000000003
[10480.363367] RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fa1dc7b2a40
[10480.365317] R10: 0000562d93d0e366 R11: 0000000000000293 R12: 0000000000000001
[10480.367299] R13: 0000562d93d45290 R14: 0000562d93d45e40 R15: 0000562d93d45e60

Link: https://github.com/btrfs/fstests/issues/22
Link: https://lore.kernel.org/linux-btrfs/20180713090216.GC575@fnst.localdomain/
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e35cfe8cf68b..56cbc1706b6f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3611,6 +3611,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	 * search and this search we'll not find the key again and can just
 	 * bail.
 	 */
+search:
 	ret = btrfs_search_slot(NULL, root, &min_key, path, 0, 0);
 	if (ret != 0)
 		goto done;
@@ -3630,6 +3631,13 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 
 			if (min_key.objectid != ino || min_key.type != key_type)
 				goto done;
+
+			if (need_resched()) {
+				btrfs_release_path(path);
+				cond_resched();
+				goto search;
+			}
+
 			ret = overwrite_item(trans, log, dst_path, src, i,
 					     &min_key);
 			if (ret) {
-- 
2.26.2

