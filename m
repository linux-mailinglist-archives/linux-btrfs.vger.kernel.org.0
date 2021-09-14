Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4240A647
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbhINF4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 01:56:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56786 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhINF4q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 01:56:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52B93220A7;
        Tue, 14 Sep 2021 05:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631598927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FxB+wvZnINiqf152quFETmLr70BJXQwck88G61WIzZ4=;
        b=PmLU9tMYPDKPsTHEEN0Jne7Swmzly/jPqx2RI2G4ndE14FLPes7eyDAFPP24NmbP4qcyRK
        w61Ue2XZDidJF1+macGVvyBKQLrqA2X3U2/MwycMqDCF1G4wo0LLT8YBjsG6kVWyQqPD44
        JL6uIVg55pdzgp9WnJRdivTpes+iRqg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B9AD13E4A;
        Tue, 14 Sep 2021 05:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EK9PA045QGHrVQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 14 Sep 2021 05:55:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH] btrfs: unlock the original extent buffer when error happens in __btrfs_cow_block()
Date:   Tue, 14 Sep 2021 13:55:23 +0800
Message-Id: <20210914055523.33220-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a very detailed bug report that injected ENOMEM error could
leave a tree block locked while we return to user-space:

  BTRFS info (device loop0): enabling ssd optimizations
  FAULT_INJECTION: forcing a failure.
  name failslab, interval 1, probability 0, space 0, times 0
  CPU: 0 PID: 7579 Comm: syz-executor Not tainted 5.15.0-rc1 #16
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
  rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
  Call Trace:
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
   fail_dump lib/fault-inject.c:52 [inline]
   should_fail+0x13c/0x160 lib/fault-inject.c:146
   should_failslab+0x5/0x10 mm/slab_common.c:1328
   slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
   slab_alloc_node mm/slub.c:3120 [inline]
   slab_alloc mm/slub.c:3214 [inline]
   kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
   btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
   btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
   __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
   btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
   btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
   btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
   btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
   btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
   lookup_open+0x660/0x780 fs/namei.c:3282
   open_last_lookups fs/namei.c:3352 [inline]
   path_openat+0x465/0xe20 fs/namei.c:3557
   do_filp_open+0xe3/0x170 fs/namei.c:3588
   do_sys_openat2+0x357/0x4a0 fs/open.c:1200
   do_sys_open+0x87/0xd0 fs/open.c:1216
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x46ae99
  Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
  89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
  01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f46711b9c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
  RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
  RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
  RBP: 00007f46711b9c80 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000017
  R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc129da6e0

  ================================================
  WARNING: lock held when returning to user space!
  5.15.0-rc1 #16 Not tainted
  ------------------------------------------------
  syz-executor/7579 is leaving the kernel with locks still held!
  1 lock held by syz-executor/7579:
   #0: ffff888104b73da8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
  __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112

[CAUSE]
In __btrfs_cow_block() we could have a case where buf == *cow_ret, this
is the common call pattern in btrfs_search_slow().

In that case, before we return we should unlock the original buffer.

As in the btrfs_search_slot() call site:

			if (last_level)
				err = btrfs_cow_block(trans, root, b, NULL, 0,
						      &b,
						      BTRFS_NESTING_COW);
			else
				err = btrfs_cow_block(trans, root, b,
						      p->nodes[level + 1],
						      p->slots[level + 1], &b,
						      BTRFS_NESTING_COW);

btrfs_search_slot() expects btrfs_cow_block() to unlock the original
extent buffer @b.

As btrfs_search_slot() only puts the cowed tree block into path @p, thus
if btrfs_cow_block() fails, there will be no one to unlock extent buffer
@b.

[FIX]
Add unlock_orig check for all error paths in __btrfs_cow_block().

Reported-by: Hao Sun <sunhao.th@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CACkBjsZ9O6Zr0KK1yGn=1rQi6Crh1yeCRdTSBxx9R99L4xdn-Q@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 84627cbd5b5b..5cbbeb8384c7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -415,8 +415,11 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	cow = btrfs_alloc_tree_block(trans, root, parent_start,
 				     root->root_key.objectid, &disk_key, level,
 				     search_start, empty_size, nest);
-	if (IS_ERR(cow))
+	if (IS_ERR(cow)) {
+		if (unlock_orig)
+			btrfs_tree_unlock(buf);
 		return PTR_ERR(cow);
+	}
 
 	/* cow is set to blocking by btrfs_init_new_buffer */
 
@@ -436,6 +439,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
 	if (ret) {
 		btrfs_tree_unlock(cow);
+		if (unlock_orig)
+			btrfs_tree_unlock(buf);
 		free_extent_buffer(cow);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -445,6 +450,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
 		if (ret) {
 			btrfs_tree_unlock(cow);
+			if (unlock_orig)
+				btrfs_tree_unlock(buf);
 			free_extent_buffer(cow);
 			btrfs_abort_transaction(trans, ret);
 			return ret;
@@ -479,6 +486,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 			ret = btrfs_tree_mod_log_free_eb(buf);
 			if (ret) {
 				btrfs_tree_unlock(cow);
+				if (unlock_orig)
+					btrfs_tree_unlock(buf);
 				free_extent_buffer(cow);
 				btrfs_abort_transaction(trans, ret);
 				return ret;
-- 
2.33.0

