Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186C313028C
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 14:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgADN4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 08:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:34812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgADN4O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Jan 2020 08:56:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E8CDAC2F;
        Sat,  4 Jan 2020 13:56:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: relocation: Fix KASAN reports caused by extended reloc tree lifespan
Date:   Sat,  4 Jan 2020 21:56:02 +0800
Message-Id: <20200104135602.34601-1-wqu@suse.com>
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

Also, set_bit()/clear_bit()/test_bit() doesn't imply a memory barrier,
and BTRFS_ROOT_DEAD_RELOC_TREE is the only indicator, also add extra
memory barrier for that bit.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Singed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Difference between this and David's diff:
- Use proper smp_mb__after_atomic() for clear_bit()
- Use test_bit() only check for should_ignore_root()
  That call site is an except, can't go regular have_reloc_root() check
- Add extra comment for have_reloc_root()
---
 fs/btrfs/relocation.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..586f045bb6dc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -517,6 +517,23 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
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
+	smp_mb__before_atomic();
+	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
+		return false;
+	if (!root->reloc_root)
+		return false;
+	return true;
+}
 
 static int should_ignore_root(struct btrfs_root *root)
 {
@@ -525,6 +542,11 @@ static int should_ignore_root(struct btrfs_root *root)
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return 0;
 
+	/* This root has been merged with its reloc tree, we can ignore it */
+	smp_mb__before_atomic();
+	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
+		return 1;
+
 	reloc_root = root->reloc_root;
 	if (!reloc_root)
 		return 0;
@@ -1439,6 +1461,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	 * The subvolume has reloc tree but the swap is finished, no need to
 	 * create/update the dead reloc tree
 	 */
+	smp_mb__before_atomic();
 	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
 		return 0;
 
@@ -1478,8 +1501,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_root_item *root_item;
 	int ret;
 
-	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) ||
-	    !root->reloc_root)
+	if (!have_reloc_root(root))
 		goto out;
 
 	reloc_root = root->reloc_root;
@@ -1489,6 +1511,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	if (fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
 		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+		smp_mb__after_atomic();
 		__del_reloc_root(reloc_root);
 	}
 
@@ -2202,6 +2225,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 					ret = ret2;
 			}
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+			smp_mb__after_atomic();
 			btrfs_put_fs_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
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

