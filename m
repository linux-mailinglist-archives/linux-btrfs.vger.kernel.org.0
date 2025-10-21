Return-Path: <linux-btrfs+bounces-18116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32513BF7159
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D648351F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AAE33DEC2;
	Tue, 21 Oct 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="EA07soDy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F917338F38;
	Tue, 21 Oct 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056912; cv=none; b=AUHnQfZElTXI57dU+X0PIIZE68nbMn768QMzrl21Qq48p5WMJvqQnr8ysm6FTvEU+RGv4NNzh3fVb+kr/5/R2T5ir2yo6zW6MECT4BvRGUsFdDe+pbCRh14EhAYaoLETKaW1hOQBmAUDHKGmZWbnhTCFRxrhoHwKw48MYElr3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056912; c=relaxed/simple;
	bh=/8bVVTr/f5koIplbbifjRrkpftNfOUSsSZx1Pb5YROo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+46HUecCEez1CEfGQrypp5GXH3bvY/3TelkUk/O7nNljyuuZrdNcPgl1YHedhZgTm8Ieb5q2ETy044OmSWzBu3hyL481Z2CzSy58TJKbTIhOVDuy1j9CYV9uydmdJuh20KiQTQSSCTf7Ly0aQyQByksTf3+M04ZA8j+uLO7NXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=EA07soDy; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4crZQx1CLXzB0hg;
	Tue, 21 Oct 2025 16:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761056905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/f9P1v0BBQh+CTO8kyD9MdWqixiz0cFKU1SeKBP+QM=;
	b=EA07soDyELttqBG7bbp+6gDRKI3Z8OLA/18NJb1o/qfk5yALON8UsAJz8po/bFOOqOl/zX
	m2u7euQTrMmi6R5AF3HVb2v0sflg7DloJf7wiEdAr9hb+FqofAcuLZ+u9ir8Hjqi/nbuPo
	JHAlIhVbbCO0CrAjNUS/kF9AHF7J0bcA+Qw2rVtAzgtPepRzEC5SLyUp5ZC+UjiOaYg1ZR
	D7o+XS4c62zVfiTDi9r+huG4AF4SQpjIsSG7TFJXAMVK4IfVGg+0hKMBRNkwhCNbc4Rro7
	0WBJkcLMXxVJumYwbUV8vnfhPCsqOkHqvtbOfG0BNS+iwGgVutXcT3A2OKSOPA==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	neal@gompa.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 3/4] btrfs: apply the AUTO_K(V)FREE_PTR macros throughout the tree
Date: Tue, 21 Oct 2025 16:27:48 +0200
Message-ID: <20251021142749.642956-4-mssola@mssola.com>
In-Reply-To: <20251021142749.642956-1-mssola@mssola.com>
References: <20251021142749.642956-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apply the AUTO_KFREE_PTR and AUTO_KVFREE_PTR macros wherever it makes
sense. Since this macro is expected to improve code readability, it has
been avoided in places where the lifetime of objects wasn't easy to
follow and a cleanup attribute would've made things worse; or when the
cleanup section of a function involved many other things and thus there
was no readability impact anyways. This change has also not been applied
in extremely short functions where readability was clearly not an issue.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/acl.c                    | 29 ++++++++----------
 fs/btrfs/delayed-inode.c          | 17 +++++------
 fs/btrfs/extent-tree.c            | 17 +++++------
 fs/btrfs/ioctl.c                  | 31 +++++++------------
 fs/btrfs/qgroup.c                 |  3 +-
 fs/btrfs/raid-stripe-tree.c       | 14 +++------
 fs/btrfs/reflink.c                |  7 ++---
 fs/btrfs/relocation.c             | 34 ++++++++-------------
 fs/btrfs/send.c                   | 50 ++++++++++++-------------------
 fs/btrfs/super.c                  |  3 +-
 fs/btrfs/tests/extent-io-tests.c  |  3 +-
 fs/btrfs/tests/extent-map-tests.c |  6 ++--
 fs/btrfs/tree-log.c               | 46 +++++++++++-----------------
 fs/btrfs/volumes.c                | 28 +++++------------
 fs/btrfs/zoned.c                  |  3 +-
 15 files changed, 105 insertions(+), 186 deletions(-)

diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index e0ba00d64ea0..36731beb8f37 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -14,12 +14,13 @@
 #include "ctree.h"
 #include "xattr.h"
 #include "acl.h"
+#include "misc.h"
 
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
 {
 	int size;
 	const char *name;
-	char *value = NULL;
+	char AUTO_KFREE_PTR(value);
 	struct posix_acl *acl;
 
 	if (rcu)
@@ -49,7 +50,6 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
 		acl = NULL;
 	else
 		acl = ERR_PTR(size);
-	kfree(value);
 
 	return acl;
 }
@@ -57,9 +57,9 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
 int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 		    struct posix_acl *acl, int type)
 {
-	int ret, size = 0;
+	int ret = 0, size = 0;
 	const char *name;
-	char *value = NULL;
+	char AUTO_KFREE_PTR(value);
 
 	switch (type) {
 	case ACL_TYPE_ACCESS:
@@ -85,34 +85,29 @@ int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 		nofs_flag = memalloc_nofs_save();
 		value = kmalloc(size, GFP_KERNEL);
 		memalloc_nofs_restore(nofs_flag);
-		if (!value) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!value)
+			return -ENOMEM;
 
 		ret = posix_acl_to_xattr(&init_user_ns, acl, value, size);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	if (trans)
 		ret = btrfs_setxattr(trans, inode, name, value, size, 0);
 	else
 		ret = btrfs_setxattr_trans(inode, name, value, size, 0);
+	if (ret < 0)
+		return ret;
 
-out:
-	kfree(value);
-
-	if (!ret)
-		set_cached_acl(inode, type, acl);
-
-	return ret;
+	set_cached_acl(inode, type, acl);
+	return 0;
 }
 
 int btrfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct posix_acl *acl, int type)
 {
-	int ret;
+	int ret = 0;
 	struct inode *inode = d_inode(dentry);
 	umode_t old_mode = inode->i_mode;
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 41e37f7f67cc..7ec94f6bc1e0 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -668,8 +668,8 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	struct btrfs_key first_key;
 	const u32 first_data_size = first_item->data_len;
 	int total_size;
-	char *ins_data = NULL;
-	int ret;
+	char AUTO_KFREE_PTR(ins_data);
+	int ret = 0;
 	bool continuous_keys_only = false;
 
 	lockdep_assert_held(&node->mutex);
@@ -740,10 +740,8 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 
 		ins_data = kmalloc_array(batch.nr,
 					 sizeof(u32) + sizeof(struct btrfs_key), GFP_NOFS);
-		if (!ins_data) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!ins_data)
+			return -ENOMEM;
 		ins_sizes = (u32 *)ins_data;
 		ins_keys = (struct btrfs_key *)(ins_data + batch.nr * sizeof(u32));
 		batch.keys = ins_keys;
@@ -759,7 +757,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_items(trans, root, path, &batch);
 	if (ret)
-		goto out;
+		return ret;
 
 	list_for_each_entry(curr, &item_list, tree_list) {
 		char *data_ptr;
@@ -814,9 +812,8 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		list_del(&curr->tree_list);
 		btrfs_release_delayed_item(curr);
 	}
-out:
-	kfree(ins_data);
-	return ret;
+
+	return 0;
 }
 
 static int btrfs_insert_delayed_items(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ae2c3dc9957e..3e4c30a54e7a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6060,7 +6060,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root_item *root_item = &root->root_item;
-	struct walk_control *wc;
+	struct walk_control AUTO_KFREE_PTR(wc);
 	struct btrfs_key key;
 	const u64 rootid = btrfs_root_id(root);
 	int ret = 0;
@@ -6078,9 +6078,8 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 
 	wc = kzalloc(sizeof(*wc), GFP_NOFS);
 	if (!wc) {
-		btrfs_free_path(path);
 		ret = -ENOMEM;
-		goto out;
+		goto out_free;
 	}
 
 	/*
@@ -6290,7 +6289,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 
 	btrfs_end_transaction_throttle(trans);
 out_free:
-	kfree(wc);
 	btrfs_free_path(path);
 out:
 	if (!ret && root_dropped) {
@@ -6333,7 +6331,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	BTRFS_PATH_AUTO_FREE(path);
-	struct walk_control *wc;
+	struct walk_control AUTO_KFREE_PTR(wc);
 	int level;
 	int parent_level;
 	int ret = 0;
@@ -6372,18 +6370,17 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	while (1) {
 		ret = walk_down_tree(trans, root, path, wc);
 		if (ret < 0)
-			break;
+			return ret;
 
 		ret = walk_up_tree(trans, root, path, wc, parent_level);
 		if (ret) {
-			if (ret > 0)
-				ret = 0;
+			if (ret < 0)
+				return ret;
 			break;
 		}
 	}
 
-	kfree(wc);
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 453832ded917..97c62c2803b1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -503,7 +503,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
-	struct btrfs_root_item *root_item;
+	struct btrfs_root_item AUTO_KFREE_PTR(root_item);
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *leaf;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
@@ -516,7 +516,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		.subvol = true,
 	};
 	unsigned int trans_num_items;
-	int ret;
+	int ret = 0;
 	dev_t anon_dev;
 	u64 objectid;
 	u64 qgroup_reserved = 0;
@@ -527,20 +527,18 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 
 	ret = btrfs_get_free_objectid(fs_info->tree_root, &objectid);
 	if (ret)
-		goto out_root_item;
+		return ret;
 
 	/*
 	 * Don't create subvolume whose level is not zero. Or qgroup will be
 	 * screwed up since it assumes subvolume qgroup's level to be 0.
 	 */
-	if (btrfs_qgroup_level(objectid)) {
-		ret = -ENOSPC;
-		goto out_root_item;
-	}
+	if (btrfs_qgroup_level(objectid))
+		return -ENOSPC;
 
 	ret = get_anon_bdev(&anon_dev);
 	if (ret < 0)
-		goto out_root_item;
+		return ret;
 
 	new_inode_args.inode = btrfs_new_subvol_inode(idmap, dir);
 	if (!new_inode_args.inode) {
@@ -692,8 +690,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 out_anon_dev:
 	if (anon_dev)
 		free_anon_bdev(anon_dev);
-out_root_item:
-	kfree(root_item);
+
 	return ret;
 }
 
@@ -2956,7 +2953,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 	struct btrfs_ioctl_space_args space_args = { 0 };
 	struct btrfs_ioctl_space_info space;
 	struct btrfs_ioctl_space_info *dest;
-	struct btrfs_ioctl_space_info *dest_orig;
+	struct btrfs_ioctl_space_info AUTO_KFREE_PTR(dest_orig);
 	struct btrfs_ioctl_space_info __user *user_dest;
 	struct btrfs_space_info *info;
 	static const u64 types[] = {
@@ -3077,9 +3074,8 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 		(arg + sizeof(struct btrfs_ioctl_space_args));
 
 	if (copy_to_user(user_dest, dest_orig, alloc_size))
-		ret = -EFAULT;
+		return -EFAULT;
 
-	kfree(dest_orig);
 out:
 	if (ret == 0 && copy_to_user(arg, &space_args, sizeof(space_args)))
 		ret = -EFAULT;
@@ -3610,7 +3606,7 @@ static long btrfs_ioctl_balance_ctl(struct btrfs_fs_info *fs_info, int cmd)
 static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 					 void __user *arg)
 {
-	struct btrfs_ioctl_balance_args *bargs;
+	struct btrfs_ioctl_balance_args AUTO_KFREE_PTR(bargs);
 	int ret = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -3632,8 +3628,6 @@ static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 
 	if (copy_to_user(arg, bargs, sizeof(*bargs)))
 		ret = -EFAULT;
-
-	kfree(bargs);
 out:
 	mutex_unlock(&fs_info->balance_mutex);
 	return ret;
@@ -4227,7 +4221,7 @@ static int check_feature_bits(const struct btrfs_fs_info *fs_info,
 			      u64 safe_set, u64 safe_clear)
 {
 	const char *type = btrfs_feature_set_name(set);
-	char *names;
+	const char AUTO_KFREE_PTR(names);
 	u64 disallowed, unsupported;
 	u64 set_mask = flags & change_mask;
 	u64 clear_mask = ~flags & change_mask;
@@ -4239,7 +4233,6 @@ static int check_feature_bits(const struct btrfs_fs_info *fs_info,
 			btrfs_warn(fs_info,
 				   "this kernel does not support the %s feature bit%s",
 				   names, strchr(names, ',') ? "s" : "");
-			kfree(names);
 		} else
 			btrfs_warn(fs_info,
 				   "this kernel does not support %s bits 0x%llx",
@@ -4254,7 +4247,6 @@ static int check_feature_bits(const struct btrfs_fs_info *fs_info,
 			btrfs_warn(fs_info,
 				   "can't set the %s feature bit%s while mounted",
 				   names, strchr(names, ',') ? "s" : "");
-			kfree(names);
 		} else
 			btrfs_warn(fs_info,
 				   "can't set %s bits 0x%llx while mounted",
@@ -4269,7 +4261,6 @@ static int check_feature_bits(const struct btrfs_fs_info *fs_info,
 			btrfs_warn(fs_info,
 				   "can't clear the %s feature bit%s while mounted",
 				   names, strchr(names, ',') ? "s" : "");
-			kfree(names);
 		} else
 			btrfs_warn(fs_info,
 				   "can't clear %s bits 0x%llx while mounted",
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 51d696e49768..6adb57d5c958 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4792,7 +4792,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_tree_parent_check check = { 0 };
 	struct btrfs_qgroup_swapped_blocks *blocks = &root->swapped_blocks;
-	struct btrfs_qgroup_swapped_block *block;
+	struct btrfs_qgroup_swapped_block AUTO_KFREE_PTR(block);
 	struct extent_buffer *reloc_eb = NULL;
 	struct rb_node *node;
 	bool swapped = false;
@@ -4849,7 +4849,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	ret = qgroup_trace_subtree_swap(trans, reloc_eb, subvol_eb,
 			block->last_snapshot, block->trace_leaf);
 free_out:
-	kfree(block);
 	free_extent_buffer(reloc_eb);
 out:
 	if (ret < 0) {
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index cc6f6095cc9f..8a7277329df9 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -19,7 +19,7 @@ static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 					       u64 newlen, u64 frontpad)
 {
 	struct btrfs_root *stripe_root = trans->fs_info->stripe_root;
-	struct btrfs_stripe_extent *extent, *newitem;
+	struct btrfs_stripe_extent *extent, AUTO_KFREE_PTR(newitem);
 	struct extent_buffer *leaf;
 	int slot;
 	size_t item_size;
@@ -53,14 +53,10 @@ static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_del_item(trans, stripe_root, path);
 	if (ret)
-		goto out;
+		return ret;
 
 	btrfs_release_path(path);
-	ret = btrfs_insert_item(trans, stripe_root, &newkey, newitem, item_size);
-
-out:
-	kfree(newitem);
-	return ret;
+	return btrfs_insert_item(trans, stripe_root, &newkey, newitem, item_size);
 }
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)
@@ -299,7 +295,7 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_key stripe_key;
 	struct btrfs_root *stripe_root = fs_info->stripe_root;
 	const int num_stripes = btrfs_bg_type_to_factor(bioc->map_type);
-	struct btrfs_stripe_extent *stripe_extent;
+	struct btrfs_stripe_extent AUTO_KFREE_PTR(stripe_extent);
 	const size_t item_size = struct_size(stripe_extent, strides, num_stripes);
 	int ret;
 
@@ -336,8 +332,6 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 	}
 
-	kfree(stripe_extent);
-
 	return ret;
 }
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 1bbe3bb7e1bb..2155850431b1 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -343,7 +343,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_trans_handle *trans;
-	char *buf = NULL;
+	char AUTO_KVFREE_PTR(buf);
 	struct btrfs_key key;
 	u32 nritems;
 	int slot;
@@ -358,10 +358,8 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		return ret;
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		kvfree(buf);
+	if (!path)
 		return ret;
-	}
 
 	path->reada = READA_FORWARD;
 	/* Clone data */
@@ -611,7 +609,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	}
 
 out:
-	kvfree(buf);
 	clear_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &BTRFS_I(inode)->runtime_flags);
 
 	return ret;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 96539e8b7b4b..9d591a466c9b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -511,7 +511,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *rb_node;
-	struct mapping_node *node = NULL;
+	struct mapping_node AUTO_KFREE_PTR(node);
 	struct reloc_control *rc = fs_info->reloc_ctl;
 	bool put_ref = false;
 
@@ -544,7 +544,6 @@ static void __del_reloc_root(struct btrfs_root *root)
 	spin_unlock(&fs_info->trans_lock);
 	if (put_ref)
 		btrfs_put_root(root);
-	kfree(node);
 }
 
 /*
@@ -586,10 +585,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *reloc_root;
 	struct extent_buffer *eb;
-	struct btrfs_root_item *root_item;
+	struct btrfs_root_item AUTO_KFREE_PTR(root_item);
 	struct btrfs_key root_key;
 	int ret = 0;
-	bool must_abort = false;
 
 	root_item = kmalloc(sizeof(*root_item), GFP_NOFS);
 	if (!root_item)
@@ -617,15 +615,14 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 			btrfs_err(fs_info,
 	"cannot relocate partially dropped subvolume %llu, drop progress key " BTRFS_KEY_FMT,
 				  objectid, BTRFS_KEY_FMT_VALUE(&cpu_key));
-			ret = -EUCLEAN;
-			goto fail;
+			return ERR_PTR(-EUCLEAN);
 		}
 
 		/* called by btrfs_init_reloc_root */
 		ret = btrfs_copy_root(trans, root, root->commit_root, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
 		if (ret)
-			goto fail;
+			return ERR_PTR(ret);
 
 		/*
 		 * Set the last_snapshot field to the generation of the commit
@@ -648,14 +645,13 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 		ret = btrfs_copy_root(trans, root, root->node, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
 		if (ret)
-			goto fail;
+			return ERR_PTR(ret);
 	}
 
 	/*
 	 * We have changed references at this point, we must abort the
-	 * transaction if anything fails.
+	 * transaction if anything fails (i.e. 'goto abort').
 	 */
-	must_abort = true;
 
 	memcpy(root_item, &root->root_item, sizeof(*root_item));
 	btrfs_set_root_bytenr(root_item, eb->start);
@@ -675,9 +671,7 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_root(trans, fs_info->tree_root,
 				&root_key, root_item);
 	if (ret)
-		goto fail;
-
-	kfree(root_item);
+		goto abort;
 
 	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
 	if (IS_ERR(reloc_root)) {
@@ -687,11 +681,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	set_bit(BTRFS_ROOT_SHAREABLE, &reloc_root->state);
 	btrfs_set_root_last_trans(reloc_root, trans->transid);
 	return reloc_root;
-fail:
-	kfree(root_item);
+
 abort:
-	if (must_abort)
-		btrfs_abort_transaction(trans, ret);
+	btrfs_abort_transaction(trans, ret);
 	return ERR_PTR(ret);
 }
 
@@ -2947,7 +2939,7 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	const struct file_extent_cluster *cluster = &rc->cluster;
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	u64 cur_file_offset = cluster->start - offset;
-	struct file_ra_state *ra;
+	struct file_ra_state AUTO_KFREE_PTR(ra);
 	int cluster_nr = 0;
 	int ret = 0;
 
@@ -2960,13 +2952,13 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 
 	ret = prealloc_file_extent_cluster(rc);
 	if (ret)
-		goto out;
+		return ret;
 
 	file_ra_state_init(ra, inode->i_mapping);
 
 	ret = setup_relocation_extent_mapping(rc);
 	if (ret)
-		goto out;
+		return ret;
 
 	while (cur_file_offset < cluster->end - offset) {
 		ret = relocate_one_folio(rc, ra, &cluster_nr, &cur_file_offset);
@@ -2975,8 +2967,6 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	}
 	if (ret == 0)
 		WARN_ON(cluster_nr != cluster->nr);
-out:
-	kfree(ra);
 	return ret;
 }
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index caeaa50f2f44..3d00a9390b45 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2458,7 +2458,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	struct btrfs_key key;
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
-	char *name = NULL;
+	char AUTO_KFREE_PTR(name);
 	int namelen;
 
 	path = btrfs_alloc_path();
@@ -2476,18 +2476,15 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	ret = btrfs_search_slot_for_read(send_root->fs_info->tree_root,
 				&key, path, 1, 0);
 	if (ret < 0)
-		goto out;
-	if (ret) {
-		ret = -ENOENT;
-		goto out;
-	}
+		return ret;
+	if (ret)
+		return -ENOENT;
 
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	if (key.type != BTRFS_ROOT_BACKREF_KEY ||
 	    key.objectid != btrfs_root_id(send_root)) {
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 	ref = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_root_ref);
 	namelen = btrfs_root_ref_name_len(leaf, ref);
@@ -2497,11 +2494,11 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	if (parent_root) {
 		ret = begin_cmd(sctx, BTRFS_SEND_C_SNAPSHOT);
 		if (ret < 0)
-			goto out;
+			return ret;
 	} else {
 		ret = begin_cmd(sctx, BTRFS_SEND_C_SUBVOL);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	TLV_PUT_STRING(sctx, BTRFS_SEND_A_PATH, name, namelen);
@@ -2529,8 +2526,6 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	kfree(name);
 	return ret;
 }
 
@@ -4077,7 +4072,7 @@ static int update_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
  */
 static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 {
-	char *name;
+	char AUTO_KFREE_PTR(name);
 	int ret;
 
 	name = kmemdup(ref->name, ref->name_len, GFP_KERNEL);
@@ -4087,17 +4082,16 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 	fs_path_reset(ref->full_path);
 	ret = get_cur_path(sctx, ref->dir, ref->dir_gen, ref->full_path);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = fs_path_add(ref->full_path, name, ref->name_len);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/* Update the reference's base name pointer. */
 	set_ref_path(ref, ref->full_path);
-out:
-	kfree(name);
-	return ret;
+
+	return 0;
 }
 
 static int rbtree_check_dir_ref_comp(const void *k, const struct rb_node *node)
@@ -5006,8 +5000,8 @@ static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
 {
 	int ret;
 	struct send_ctx *sctx = ctx;
-	char *found_data = NULL;
-	int found_data_len  = 0;
+	char AUTO_KFREE_PTR(found_data);
+	int found_data_len = 0;
 
 	ret = find_xattr(sctx->parent_root, sctx->right_path,
 			 sctx->cmp_key, name, name_len, &found_data,
@@ -5025,7 +5019,6 @@ static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
 		}
 	}
 
-	kfree(found_data);
 	return ret;
 }
 
@@ -5762,7 +5755,7 @@ static int send_capabilities(struct send_ctx *sctx)
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
 	unsigned long data_ptr;
-	char *buf = NULL;
+	char AUTO_KFREE_PTR(buf);
 	int buf_len;
 	int ret = 0;
 
@@ -5774,28 +5767,23 @@ static int send_capabilities(struct send_ctx *sctx)
 				XATTR_NAME_CAPS, strlen(XATTR_NAME_CAPS), 0);
 	if (!di) {
 		/* There is no xattr for this inode */
-		goto out;
+		return 0;
 	} else if (IS_ERR(di)) {
-		ret = PTR_ERR(di);
-		goto out;
+		return PTR_ERR(di);
 	}
 
 	leaf = path->nodes[0];
 	buf_len = btrfs_dir_data_len(leaf, di);
 
 	buf = kmalloc(buf_len, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!buf)
+		return -ENOMEM;
 
 	data_ptr = (unsigned long)(di + 1) + btrfs_dir_name_len(leaf, di);
 	read_extent_buffer(leaf, buf, data_ptr, buf_len);
 
 	ret = send_set_xattr(sctx, XATTR_NAME_CAPS,
 			strlen(XATTR_NAME_CAPS), buf, buf_len);
-out:
-	kfree(buf);
 	return ret;
 }
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5cd8d8185a29..aa7416ee1556 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1614,7 +1614,7 @@ static inline void btrfs_descending_sort_devices(
 static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 					      u64 *free_bytes)
 {
-	struct btrfs_device_info *devices_info;
+	struct btrfs_device_info AUTO_KFREE_PTR(devices_info);
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
 	u64 type;
@@ -1712,7 +1712,6 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		nr_devices--;
 	}
 
-	kfree(devices_info);
 	*free_bytes = avail_space;
 	return 0;
 }
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index b19328d077d3..2c5d10e558e4 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -505,7 +505,7 @@ static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb)
 static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
-	unsigned long *bitmap = NULL;
+	unsigned long AUTO_KFREE_PTR(bitmap);
 	struct extent_buffer *eb = NULL;
 	int ret;
 
@@ -551,7 +551,6 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 	ret = __test_eb_bitmaps(bitmap, eb);
 out:
 	free_extent_buffer(eb);
-	kfree(bitmap);
 	btrfs_free_dummy_fs_info(fs_info);
 	return ret;
 }
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 42af6c737c6e..2a2c61cb99d1 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -1013,7 +1013,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 			   struct rmap_test_vector *test)
 {
 	struct btrfs_chunk_map *map;
-	u64 *logical = NULL;
+	u64 AUTO_KFREE_PTR(logical);
 	int i, out_ndaddrs, out_stripe_len;
 	int ret;
 
@@ -1046,7 +1046,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	if (ret) {
 		test_err("error adding chunk map to mapping tree");
 		btrfs_free_chunk_map(map);
-		goto out_free;
+		return ret;
 	}
 
 	ret = btrfs_rmap_block(fs_info, map->start, btrfs_sb_offset(1),
@@ -1079,8 +1079,6 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	ret = 0;
 out:
 	btrfs_remove_chunk_map(fs_info, map);
-out_free:
-	kfree(logical);
 	return ret;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 65079eb651da..2144adcff05c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3281,7 +3281,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
 	mutex_unlock(&root->log_mutex);
 }
 
-/* 
+/*
  * Invoked in log mutex context, or be sure there is no other task which
  * can access the list.
  */
@@ -4015,7 +4015,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 				 int count)
 {
 	struct btrfs_root *log = inode->root->log_root;
-	char *ins_data = NULL;
+	char AUTO_KFREE_PTR(ins_data);
 	struct btrfs_item_batch batch;
 	struct extent_buffer *dst;
 	unsigned long src_offset;
@@ -4060,7 +4060,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_items(trans, log, dst_path, &batch);
 	if (ret)
-		goto out;
+		return ret;
 
 	dst = dst_path->nodes[0];
 	/*
@@ -4092,8 +4092,6 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 
 	if (btrfs_get_first_dir_index_to_log(inode) == 0)
 		btrfs_set_first_dir_index_to_log(inode, batch.keys[0].offset);
-out:
-	kfree(ins_data);
 
 	return ret;
 }
@@ -4760,7 +4758,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	struct btrfs_key *ins_keys;
 	u32 *ins_sizes;
 	struct btrfs_item_batch batch;
-	char *ins_data;
+	char AUTO_KFREE_PTR(ins_data);
 	int dst_index;
 	const bool skip_csum = (inode->flags & BTRFS_INODE_NODATASUM);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
@@ -4888,7 +4886,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 					      disk_bytenr + extent_num_bytes - 1,
 					      &ordered_sums, false);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = 0;
 
 		list_for_each_entry_safe(sums, sums_next, &ordered_sums, list) {
@@ -4898,7 +4896,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 			kfree(sums);
 		}
 		if (ret)
-			goto out;
+			return ret;
 
 add_to_batch:
 		ins_sizes[dst_index] = btrfs_item_size(src, src_slot);
@@ -4912,11 +4910,11 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	 * so we don't need to do anything.
 	 */
 	if (batch.nr == 0)
-		goto out;
+		return 0;
 
 	ret = btrfs_insert_empty_items(trans, log, dst_path, &batch);
 	if (ret)
-		goto out;
+		return ret;
 
 	dst_index = 0;
 	for (int i = 0; i < nr; i++) {
@@ -4969,8 +4967,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_release_path(dst_path);
-out:
-	kfree(ins_data);
 
 	return ret;
 }
@@ -5689,9 +5685,8 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 					 struct btrfs_inode *inode,
 					 u64 *other_ino, u64 *other_parent)
 {
-	int ret;
 	BTRFS_PATH_AUTO_FREE(search_path);
-	char *name = NULL;
+	char AUTO_KFREE_PTR(name);
 	u32 name_len = 0;
 	u32 item_size = btrfs_item_size(eb, slot);
 	u32 cur_offset = 0;
@@ -5734,10 +5729,8 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 			char *new_name;
 
 			new_name = krealloc(name, this_name_len, GFP_NOFS);
-			if (!new_name) {
-				ret = -ENOMEM;
-				goto out;
-			}
+			if (!new_name)
+				return -ENOMEM;
 			name_len = this_name_len;
 			name = new_name;
 		}
@@ -5755,28 +5748,24 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 						  di, &di_key);
 			if (di_key.type == BTRFS_INODE_ITEM_KEY) {
 				if (di_key.objectid != key->objectid) {
-					ret = 1;
 					*other_ino = di_key.objectid;
 					*other_parent = parent;
+					return 1;
 				} else {
-					ret = 0;
+					return 0;
 				}
 			} else {
-				ret = -EAGAIN;
+				return -EAGAIN;
 			}
-			goto out;
 		} else if (IS_ERR(di)) {
-			ret = PTR_ERR(di);
-			goto out;
+			return PTR_ERR(di);
 		}
 		btrfs_release_path(search_path);
 
 		cur_offset += this_len;
 	}
-	ret = 0;
-out:
-	kfree(name);
-	return ret;
+
+	return 0;
 }
 
 /*
@@ -8044,4 +8033,3 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		btrfs_end_log_trans(root);
 	free_extent_buffer(ctx.scratch_eb);
 }
-
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 45d89b12025b..dcc6c400bb5f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -739,7 +739,7 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 {
 	struct path old = { .mnt = NULL, .dentry = NULL };
 	struct path new = { .mnt = NULL, .dentry = NULL };
-	char *old_path = NULL;
+	char AUTO_KFREE_PTR(old_path);
 	bool is_same = false;
 	int ret;
 
@@ -765,7 +765,6 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 	if (path_equal(&old, &new))
 		is_same = true;
 out:
-	kfree(old_path);
 	path_put(&old);
 	path_put(&new);
 	return is_same;
@@ -4384,7 +4383,7 @@ static void describe_balance_start_or_resume(struct btrfs_fs_info *fs_info)
 {
 	u32 size_buf = 1024;
 	char tmp_buf[192] = {'\0'};
-	char *buf;
+	char AUTO_KFREE_PTR(buf);
 	char *bp;
 	u32 size_bp = size_buf;
 	int ret;
@@ -4432,8 +4431,6 @@ static void describe_balance_start_or_resume(struct btrfs_fs_info *fs_info)
 	btrfs_info(fs_info, "balance: %s %s",
 		   (bctl->flags & BTRFS_BALANCE_RESUME) ?
 		   "resume" : "start", buf);
-
-	kfree(buf);
 }
 
 /*
@@ -5562,9 +5559,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
-	struct btrfs_device_info *devices_info = NULL;
+	struct btrfs_device_info AUTO_KFREE_PTR(devices_info);
 	struct alloc_chunk_ctl ctl;
-	struct btrfs_block_group *block_group;
 	int ret;
 
 	lockdep_assert_held(&info->chunk_mutex);
@@ -5597,22 +5593,14 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 		return ERR_PTR(-ENOMEM);
 
 	ret = gather_device_info(fs_devices, &ctl, devices_info);
-	if (ret < 0) {
-		block_group = ERR_PTR(ret);
-		goto out;
-	}
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
-	if (ret < 0) {
-		block_group = ERR_PTR(ret);
-		goto out;
-	}
-
-	block_group = create_chunk(trans, &ctl, devices_info);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
-out:
-	kfree(devices_info);
-	return block_group;
+	return create_chunk(trans, &ctl, devices_info);
 }
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2e3145c1a102..0f026dc3dfe8 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1631,7 +1631,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	struct btrfs_chunk_map *map;
 	u64 logical = cache->start;
 	u64 length = cache->length;
-	struct zone_info *zone_info = NULL;
+	struct zone_info AUTO_KFREE_PTR(zone_info);
 	int ret;
 	int i;
 	unsigned long *active = NULL;
@@ -1786,7 +1786,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->physical_map = NULL;
 	}
 	bitmap_free(active);
-	kfree(zone_info);
 
 	return ret;
 }
-- 
2.51.1


