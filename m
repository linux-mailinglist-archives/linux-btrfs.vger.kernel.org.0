Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E506133AB6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 06:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgAHFMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 00:12:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAHFMM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 00:12:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 070C3B1E5;
        Wed,  8 Jan 2020 05:12:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by extended reloc tree lifespan
Date:   Wed,  8 Jan 2020 13:12:00 +0800
Message-Id: <20200108051200.8909-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are several different KASAN reports for balance + snapshot
workloads.
Involved call paths include:

   should_ignore_root+0x54/0xb0 [btrfs]
   build_backref_tree+0x11af/0x2280 [btrfs]
   relocate_tree_blocks+0x391/0xb80 [btrfs]
   relocate_block_group+0x3e5/0xa00 [btrfs]
   btrfs_relocate_block_group+0x240/0x4d0 [btrfs]
   btrfs_relocate_chunk+0x53/0xf0 [btrfs]
   btrfs_balance+0xc91/0x1840 [btrfs]
   btrfs_ioctl_balance+0x416/0x4e0 [btrfs]
   btrfs_ioctl+0x8af/0x3e60 [btrfs]
   do_vfs_ioctl+0x831/0xb10
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x43/0x50
   do_syscall_64+0x79/0xe0
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

   create_reloc_root+0x9f/0x460 [btrfs]
   btrfs_reloc_post_snapshot+0xff/0x6c0 [btrfs]
   create_pending_snapshot+0xa9b/0x15f0 [btrfs]
   create_pending_snapshots+0x111/0x140 [btrfs]
   btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
   btrfs_mksubvol+0x915/0x960 [btrfs]
   btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
   btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
   btrfs_ioctl+0x241b/0x3e60 [btrfs]
   do_vfs_ioctl+0x831/0xb10
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x43/0x50
   do_syscall_64+0x79/0xe0
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

   btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
   create_pending_snapshot+0x209/0x15f0 [btrfs]
   create_pending_snapshots+0x111/0x140 [btrfs]
   btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
   btrfs_mksubvol+0x915/0x960 [btrfs]
   btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
   btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
   btrfs_ioctl+0x241b/0x3e60 [btrfs]
   do_vfs_ioctl+0x831/0xb10
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x43/0x50
   do_syscall_64+0x79/0xe0
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

[CAUSE]
All these call sites are only relying on root->reloc_root, which can
undergo btrfs_drop_snapshot(), and since we don't have real refcount
based protection to reloc roots, we can reach already dropped reloc
root, triggering KASAN.

[FIX]
To avoid such access to unstable root->reloc_root, we should check
BTRFS_ROOT_DEAD_RELOC_TREE bit first.

This patch introduces a new wrapper, have_reloc_root(), to do the proper
check for most callers who don't distinguish merged reloc tree and no
reloc tree.

The only exception is should_ignore_root(), as merged reloc tree can be
ignored, while no reloc tree shouldn't.

[CRITICAL SECTION ANALYSE]
Although test_bit()/set_bit()/clear_bit() doesn't imply a barrier, the
DEAD_RELOC_TREE bit has extra help from transaction as a higher level
barrier, the lifespan of root::reloc_root and DEAD_RELOC_TREE bit are:

	NULL: reloc_root is NULL	PTR: reloc_root is not NULL
	0: DEAD_RELOC_ROOT bit not set	DEAD: DEAD_RELOC_ROOT bit set

	(NULL, 0)    Initial state		 __
	  |					 /\ Section A
        btrfs_init_reloc_root()			 \/
	  |				 	 __
	(PTR, 0)     reloc_root initialized      /\
          |					 |
	btrfs_update_reloc_root()		 |  Section B
          |					 |
	(PTR, DEAD)  reloc_root has been merged  \/
          |					 __
	=== btrfs_commit_transaction() ====================
	  |					 /\
	clean_dirty_subvols()			 |
	  |					 |  Section C
	(NULL, DEAD) reloc_root cleanup starts   \/
          |					 __
	btrfs_drop_snapshot()			 /\
	  |					 |  Section D
	(NULL, 0)    Back to initial state	 \/

Very have_reloc_root() or test_bit(DEAD_RELOC_ROOT) caller has hold a
transaction handler, so none of such caller can cross transaction
boundary.

In Section A, every caller just found no DEAD bit, and grab reloc_root.

In the cross section A-B, caller may get no DEAD bit, but since
reloc_root is still completely valid thus accessing reloc_root is
completely safe.

No test_bit() caller can cross the boundary of Section B and Section C.

In Section C, every caller found the DEAD bit, so no one will access
reloc_root.

In the cross section C-D, either caller gets the DEAD bit set, avoiding
access reloc_root no matter if it's safe or not.
Or caller get the DEAD bit cleared, then access reloc_root, which is
already NULL, nothing will be wrong.

Here we need extra memory barrier in cross section C-D, to ensure
proper memory order between reloc_root and clear_bit().

In Section D, since no DEAD bit and no reloc_root, it's back to initial
state.

With this lifespan, it should be clear only one memory barrier is
needed, between setting reloc_root to NULL and clearing DEAD_RELOC_ROOT
bit.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add the [CRITICAL SECTION ANALYSE] part
  This gets me into the rabbit hole of memory ordering, but thanks for
  the help from David (initially mentioning the mb hell) and Nikolay
  (for the proper doc), finally I could explain clearly why only
  one mb is needed.
- Add comment for the only needed memory barrier.
---
 fs/btrfs/relocation.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..17a2484f76a5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -517,6 +517,22 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 	return 1;
 }
 
+/*
+ * Check if this subvolume tree has valid reloc(*) tree.
+ *
+ * *: Reloc tree after swap is considered dead, thus not considered as valid.
+ *    This is enough for most callers, as they don't distinguish dead reloc
+ *    root from no reloc root.
+ *    But should_ignore_root() below is a special case.
+ */
+static bool have_reloc_root(struct btrfs_root *root)
+{
+	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
+		return false;
+	if (!root->reloc_root)
+		return false;
+	return true;
+}
 
 static int should_ignore_root(struct btrfs_root *root)
 {
@@ -525,6 +541,10 @@ static int should_ignore_root(struct btrfs_root *root)
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return 0;
 
+	/* This root has been merged with its reloc tree, we can ignore it */
+	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
+		return 1;
+
 	reloc_root = root->reloc_root;
 	if (!reloc_root)
 		return 0;
@@ -1478,8 +1498,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_root_item *root_item;
 	int ret;
 
-	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) ||
-	    !root->reloc_root)
+	if (!have_reloc_root(root))
 		goto out;
 
 	reloc_root = root->reloc_root;
@@ -2201,6 +2220,11 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 				if (ret2 < 0 && !ret)
 					ret = ret2;
 			}
+			/*
+			 * Need barrier to ensure clear_bit() only happens after
+			 * root->reloc_root = NULL.
+			 */
+			smp_mb__before_atomic();
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 			btrfs_put_fs_root(root);
 		} else {
@@ -4717,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 	struct btrfs_root *root = pending->root;
 	struct reloc_control *rc = root->fs_info->reloc_ctl;
 
-	if (!root->reloc_root || !rc)
+	if (!rc || !have_reloc_root(root))
 		return;
 
 	if (!rc->merge_reloc_tree)
@@ -4751,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 	struct reloc_control *rc = root->fs_info->reloc_ctl;
 	int ret;
 
-	if (!root->reloc_root || !rc)
+	if (!rc || !have_reloc_root(root))
 		return 0;
 
 	rc = root->fs_info->reloc_ctl;
-- 
2.24.1

