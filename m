Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BFD47232E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhLMIpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 03:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhLMIpX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 03:45:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA96C06173F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 00:45:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C236DCE0DD8
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5DCC341C8
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639385119;
        bh=57LpQU90IN+9UP3/QkzbUjQvWYgpAkB7spD6ETeNL9M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WiwvIElM9TsZW+8Jd+ZN6PkgvkJcnSiO9rW6WIIG1+EeQJalSDikKKM7uTawmumaw
         EpuvSrjE4/eqQJfaZ4jp0XaqCDVXE5/66jkIYI6jVE321nkzJq/73rRyc7lslrDZ9h
         8uYuqFMDqylMmBQfWLtBx49LDOlIF1f3Nq92qfNqlg3ALendED1HSlurCmpt7YeAsD
         UivUHBTcp03Ou0d9Y0pNK57JjpsQo2JxeVyCfHiSCca8NChoxLaYnaogmEf29GVT7K
         SjTjsgL5tYc7EexJQUzkTCC1dhGyAusn36n924qADgOgDTX0eWkoqs7fGYuPQfA4+V
         lwqLl/BGaqR4g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix invalid delayed ref after subvolume creation failure
Date:   Mon, 13 Dec 2021 08:45:12 +0000
Message-Id: <0dff116a040f92739f84745f5c957519fb360a81.1639384875.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1639384875.git.fdmanana@suse.com>
References: <cover.1639384875.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When creating a subvolume, at ioctl.c:create_subvol(), if we fail to
insert the new root's root item into the root tree, we are freeing the
metadata extent we reserved for the new root to prevent a metadata
extent leak, as we don't abort the transaction at that point (since
there is nothing at that point that is irreversible).

However we allocated the metadata extent for the new root which we are
creating for the new subvolume, so its delayed reference refers to the
ID of this new root. But when we free the metadata extent we pass the
root of the subvolume where the new subvolume is located to
btrfs_free_tree_block() - this is incorrect because this will generate
a delayed reference that refers to the ID of the parent subvolume's root,
and not to ID of the new root.

This results in a failure when running delayed references that leads to
a transaction abort and a trace like the following:

[ 3868.738042] RIP: 0010:__btrfs_free_extent+0x709/0x950 [btrfs]
[ 3868.739857] Code: 68 0f 85 e6 fb ff (...)
[ 3868.742963] RSP: 0018:ffffb0e9045cf910 EFLAGS: 00010246
[ 3868.743908] RAX: 00000000fffffffe RBX: 00000000fffffffe RCX: 0000000000000002
[ 3868.745312] RDX: 00000000fffffffe RSI: 0000000000000002 RDI: ffff90b0cd793b88
[ 3868.746643] RBP: 000000000e5d8000 R08: 0000000000000000 R09: ffff90b0cd793b88
[ 3868.747979] R10: 0000000000000002 R11: 00014ded97944d68 R12: 0000000000000000
[ 3868.749373] R13: ffff90b09afe4a28 R14: 0000000000000000 R15: ffff90b0cd793b88
[ 3868.750725] FS:  00007f281c4a8b80(0000) GS:ffff90b3ada00000(0000) knlGS:0000000000000000
[ 3868.752275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3868.753515] CR2: 00007f281c6a5000 CR3: 0000000108a42006 CR4: 0000000000370ee0
[ 3868.754869] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3868.756228] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3868.757803] Call Trace:
[ 3868.758281]  <TASK>
[ 3868.758655]  ? btrfs_merge_delayed_refs+0x178/0x1c0 [btrfs]
[ 3868.759827]  __btrfs_run_delayed_refs+0x2b1/0x1250 [btrfs]
[ 3868.761047]  btrfs_run_delayed_refs+0x86/0x210 [btrfs]
[ 3868.762069]  ? lock_acquired+0x19f/0x420
[ 3868.762829]  btrfs_commit_transaction+0x69/0xb20 [btrfs]
[ 3868.763860]  ? _raw_spin_unlock+0x29/0x40
[ 3868.764614]  ? btrfs_block_rsv_release+0x1c2/0x1e0 [btrfs]
[ 3868.765870]  create_subvol+0x1d8/0x9a0 [btrfs]
[ 3868.766766]  btrfs_mksubvol+0x447/0x4c0 [btrfs]
[ 3868.767669]  ? preempt_count_add+0x49/0xa0
[ 3868.768444]  __btrfs_ioctl_snap_create+0x123/0x190 [btrfs]
[ 3868.769639]  ? _copy_from_user+0x66/0xa0
[ 3868.770391]  btrfs_ioctl_snap_create_v2+0xbb/0x140 [btrfs]
[ 3868.771495]  btrfs_ioctl+0xd1e/0x35c0 [btrfs]
[ 3868.772364]  ? __slab_free+0x10a/0x360
[ 3868.773198]  ? rcu_read_lock_sched_held+0x12/0x60
[ 3868.774121]  ? lock_release+0x223/0x4a0
[ 3868.774863]  ? lock_acquired+0x19f/0x420
[ 3868.775634]  ? rcu_read_lock_sched_held+0x12/0x60
[ 3868.776530]  ? trace_hardirqs_on+0x1b/0xe0
[ 3868.777373]  ? _raw_spin_unlock_irqrestore+0x3e/0x60
[ 3868.778280]  ? kmem_cache_free+0x321/0x3c0
[ 3868.779011]  ? __x64_sys_ioctl+0x83/0xb0
[ 3868.779718]  __x64_sys_ioctl+0x83/0xb0
[ 3868.780387]  do_syscall_64+0x3b/0xc0
[ 3868.781059]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3868.781953] RIP: 0033:0x7f281c59e957
[ 3868.782585] Code: 3c 1c 48 f7 d8 4c (...)
[ 3868.785867] RSP: 002b:00007ffe1f83e2b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[ 3868.787198] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f281c59e957
[ 3868.788450] RDX: 00007ffe1f83e2c0 RSI: 0000000050009418 RDI: 0000000000000003
[ 3868.789748] RBP: 00007ffe1f83f300 R08: 0000000000000000 R09: 00007ffe1f83fe36
[ 3868.791214] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[ 3868.792468] R13: 0000000000000003 R14: 00007ffe1f83e2c0 R15: 00000000000003cc
[ 3868.793765]  </TASK>
[ 3868.794037] irq event stamp: 0
[ 3868.794548] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 3868.795670] hardirqs last disabled at (0): [<ffffffff98294214>] copy_process+0x934/0x2040
[ 3868.797086] softirqs last  enabled at (0): [<ffffffff98294214>] copy_process+0x934/0x2040
[ 3868.798309] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 3868.799284] ---[ end trace be24c7002fe27747 ]---
[ 3868.799928] BTRFS info (device dm-0): leaf 241188864 gen 1268 total ptrs 214 free space 469 owner 2
[ 3868.801133] BTRFS info (device dm-0): refs 2 lock_owner 225627 current 225627
[ 3868.802056]  item 0 key (237436928 169 0) itemoff 16250 itemsize 33
[ 3868.802863]          extent refs 1 gen 1265 flags 2
[ 3868.803447]          ref#0: tree block backref root 1610
(...)
[ 3869.064354]  item 114 key (241008640 169 0) itemoff 12488 itemsize 33
[ 3869.065421]          extent refs 1 gen 1268 flags 2
[ 3869.066115]          ref#0: tree block backref root 1689
(...)
[ 3869.403834] BTRFS error (device dm-0): unable to find ref byte nr 241008640 parent 0 root 1622  owner 0 offset 0
[ 3869.405641] BTRFS: error (device dm-0) in __btrfs_free_extent:3076: errno=-2 No such entry
[ 3869.407138] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2159: errno=-2 No such entry

Fix this by passing the new subvolume's root ID to btrfs_free_tree_block().
This requires changing the root argument of btrfs_free_tree_block() from
struct btrfs_root * to a u64, since at this point during the subvolume
creation we have not yet created the struct btrfs_root for the new
subvolume, and btrfs_free_tree_block() only needs a root ID and nothing
else from a struct btrfs_root.

This was triggered by test case generic/475 from fstests.

Fixes: 67addf29004c5b ("btrfs: fix metadata extent leak after failure to create subvolume")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c           | 17 +++++++++--------
 fs/btrfs/ctree.h           |  7 ++++++-
 fs/btrfs/extent-tree.c     | 13 +++++++------
 fs/btrfs/free-space-tree.c |  4 ++--
 fs/btrfs/ioctl.c           |  9 +++++----
 fs/btrfs/qgroup.c          |  3 ++-
 6 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 781537692a4a..defc494a2d08 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -463,8 +463,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		BUG_ON(ret < 0);
 		rcu_assign_pointer(root->node, cow);
 
-		btrfs_free_tree_block(trans, root, buf, parent_start,
-				      last_ref);
+		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+				      parent_start, last_ref);
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
 	} else {
@@ -485,8 +485,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 				return ret;
 			}
 		}
-		btrfs_free_tree_block(trans, root, buf, parent_start,
-				      last_ref);
+		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+				      parent_start, last_ref);
 	}
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
@@ -930,7 +930,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		free_extent_buffer(mid);
 
 		root_sub_used(root, mid->len);
-		btrfs_free_tree_block(trans, root, mid, 0, 1);
+		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		/* once for the root ptr */
 		free_extent_buffer_stale(mid);
 		return 0;
@@ -989,7 +989,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_tree_unlock(right);
 			del_ptr(root, path, level + 1, pslot + 1);
 			root_sub_used(root, right->len);
-			btrfs_free_tree_block(trans, root, right, 0, 1);
+			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
+					      0, 1);
 			free_extent_buffer_stale(right);
 			right = NULL;
 		} else {
@@ -1034,7 +1035,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(mid);
 		del_ptr(root, path, level + 1, pslot);
 		root_sub_used(root, mid->len);
-		btrfs_free_tree_block(trans, root, mid, 0, 1);
+		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
 		mid = NULL;
 	} else {
@@ -4156,7 +4157,7 @@ static noinline void btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	root_sub_used(root, leaf->len);
 
 	atomic_inc(&leaf->refs);
-	btrfs_free_tree_block(trans, root, leaf, 0, 1);
+	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
 }
 /*
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 02f06ee02e4e..459d00211181 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2269,6 +2269,11 @@ static inline bool btrfs_root_dead(const struct btrfs_root *root)
 	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
 }
 
+static inline u64 btrfs_root_id(const struct btrfs_root *root)
+{
+	return root->root_key.objectid;
+}
+
 /* struct btrfs_root_backup */
 BTRFS_SETGET_STACK_FUNCS(backup_tree_root, struct btrfs_root_backup,
 		   tree_root, 64);
@@ -2731,7 +2736,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     u64 empty_size,
 					     enum btrfs_lock_nesting nest);
 void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
+			   u64 root_id,
 			   struct extent_buffer *buf,
 			   u64 parent, int last_ref);
 int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8cb67df5acef..d89273c4b6b8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3290,20 +3290,20 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 }
 
 void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
+			   u64 root_id,
 			   struct extent_buffer *buf,
 			   u64 parent, int last_ref)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_ref generic_ref = { 0 };
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
 			       buf->start, buf->len, parent);
 	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
-			    root->root_key.objectid, 0, false);
+			    root_id, 0, false);
 
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
 		BUG_ON(ret); /* -ENOMEM */
@@ -3313,7 +3313,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		struct btrfs_block_group *cache;
 		bool must_pin = false;
 
-		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+		if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
 			if (!ret) {
 				btrfs_redirty_list_add(trans->transaction, buf);
@@ -5516,7 +5516,8 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			goto owner_mismatch;
 	}
 
-	btrfs_free_tree_block(trans, root, eb, parent, wc->refs[level] == 1);
+	btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
+			      wc->refs[level] == 1);
 out:
 	wc->refs[level] = 0;
 	wc->flags[level] = 0;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a3eb6bce2a4d..655aad0f9e1c 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1278,8 +1278,8 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_tree_lock(free_space_root->node);
 	btrfs_clean_tree_block(free_space_root->node);
 	btrfs_tree_unlock(free_space_root->node);
-	btrfs_free_tree_block(trans, free_space_root, free_space_root->node,
-			      0, 1);
+	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
+			      free_space_root->node, 0, 1);
 
 	btrfs_put_root(free_space_root);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 61c90086072d..1a6784e99082 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -643,11 +643,12 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		 * Since we don't abort the transaction in this case, free the
 		 * tree block so that we don't leak space and leave the
 		 * filesystem in an inconsistent state (an extent item in the
-		 * extent tree without backreferences). Also no need to have
-		 * the tree block locked since it is not in any tree at this
-		 * point, so no other task can find it and use it.
+		 * extent tree with a backreference for a root that does not
+		 * exists). Also no need to have the tree block locked since it
+		 * is not in any tree at this point, so no other task can find
+		 * it and use it.
 		 */
-		btrfs_free_tree_block(trans, root, leaf, 0, 1);
+		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
 		free_extent_buffer(leaf);
 		goto fail;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b126cc39ffd4..8928275823a1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1238,7 +1238,8 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clean_tree_block(quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
-	btrfs_free_tree_block(trans, quota_root, quota_root->node, 0, 1);
+	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
+			      quota_root->node, 0, 1);
 
 	btrfs_put_root(quota_root);
 
-- 
2.33.0

