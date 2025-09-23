Return-Path: <linux-btrfs+bounces-17126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5179B96AC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4508718A11C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84AB270EBB;
	Tue, 23 Sep 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="MytezTfo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F7267B02
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642937; cv=none; b=dczwg7ItyOB3uuWNbdP2AUcwpW4UIhd+yyGT+xqmly6O+mYPzhPBWiCdpj4AcupGJ67P8qKyOKDDyGLHxkjwQVxOI2UNGdVJft+Q6QdIo+QBi5x5UudoQb2R8AuqkSYUYC028eLHtiXJOy0XB9V5tngVkYAt8it8Mq6gTtn8OkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642937; c=relaxed/simple;
	bh=22dBZQf2H2unl+PItcrqs9RldrCJv2U353VDQP7Jw34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=vBiSTeliu9HnFm6sovytiyDKwLK+N8Be71jle2CTlgTGL/04bBdqaGJcHU+xKqoPPR12ERObKpTTbuPYsCHUyjPDSl7/cS/zuZx+PBEgVWKZig4CsvnR/cRsDWOp0Um6kcjv9Yd/wdIF9jztCCjGN3+wjhLigJF7UHEgLpLWj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=MytezTfo; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id D48712BBA00;
	Tue, 23 Sep 2025 16:55:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1758642924;
	bh=DUvy3HRTN7lAVFI2bn2qcR4a1m5O2vbtd0UgUGAb9eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MytezTfon/xpPXe5dBo4nbUbrPRV7oAtWpDCihQcUK/Z3/n05w5GQY0NGJ7HsfiMP
	 3MRCfzwS+agAYkJ2dxADEugFIBe7Tmo6p4FyT05hmeZDigkOQO4Knb6GWAk57DbgMi
	 28WwAR/bwe2sAvCoFK0TIIZNXCWYrjBW7Dkn0SuA=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH 2/2] btrfs: clear spurious free-space entries
Date: Tue, 23 Sep 2025 16:54:56 +0100
Message-ID: <20250923155523.31617-2-mark@harmstone.com>
In-Reply-To: <20250923155523.31617-1-mark@harmstone.com>
References: <20250923155523.31617-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Version 6.16.1 of btrfs-progs fixes a broken btrfs check test for
spurious entries in the free-space tree, those that don't belong to any
block group. Unfortunately mkfs.btrfs had been generating these, meaning
that these filesystems will now fail btrfs check.

Add a compat flag BTRFS_FEATURE_COMPAT_NO_SPURIOUS_FREE_SPACE, and if on
mount we find this isn't set, clean any spurious entries from the
beginning of the free-space tree.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/disk-io.c         |  10 ++++
 fs/btrfs/free-space-tree.c | 115 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-tree.h |   1 +
 include/uapi/linux/btrfs.h |   2 +
 4 files changed, 128 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21c2a19d690f..224369c450e4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3077,6 +3077,16 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		}
 	}
 
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat(fs_info, NO_SPURIOUS_FREE_SPACE)) {
+		ret = btrfs_remove_spurious_free_space(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to remove spurious free space: %d",
+				   ret);
+		}
+	}
+
 	/*
 	 * btrfs_find_orphan_roots() is responsible for finding all the dead
 	 * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and load
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index dad0b492a663..5980710cf6b5 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1722,3 +1722,118 @@ int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 	else
 		return load_free_space_extents(caching_ctl, path, extent_count);
 }
+
+/*
+ * Earlier versions of mkfs.btrfs created spurious entries at the beginning of
+ * the free-space tree, before the start of any block group.
+ * If the compat flag NO_SPURIOUS_FREE_SPACE is not set, clean these up and
+ * set the flag so we know we don't have to check again.
+ */
+int btrfs_remove_spurious_free_space(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *fst;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_block_group *bg;
+	u64 bg_start;
+	BTRFS_PATH_AUTO_FREE(path);
+	int ret, ret2;
+	unsigned int entries_to_remove = 0;
+
+	struct btrfs_key root_key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	fst = btrfs_grab_root(btrfs_global_root(fs_info, &root_key));
+	if (!fst)
+		return -EINVAL;
+
+	trans = btrfs_start_transaction(fst, 0);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto end;
+	}
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(trans, fst, &key, path, 0, 0);
+	if (ret < 0)
+		goto end_trans;
+
+	while (true) {
+		leaf = path->nodes[0];
+		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(fst, path);
+			if (ret < 0)
+				goto end_trans;
+			if (ret > 0)
+				break;
+			leaf = path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+		bg = btrfs_lookup_first_block_group(fs_info, key.objectid);
+		if (!bg)
+			break;
+
+		bg_start = bg->start;
+
+		btrfs_put_block_group(bg);
+
+		if (key.objectid >= bg_start)
+			break;
+
+		entries_to_remove++;
+
+		path->slots[0]++;
+	}
+
+	if (entries_to_remove == 0) {
+		ret = 0;
+		goto end_trans;
+	}
+
+	btrfs_release_path(path);
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(trans, fst, &key, path, -1, 1);
+	if (ret < 0)
+		goto end_trans;
+
+	ret = btrfs_del_items(trans, fst, path, 0, entries_to_remove);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+end_trans:
+	btrfs_release_path(path);
+
+	if (!ret)
+		btrfs_set_fs_compat(fs_info, NO_SPURIOUS_FREE_SPACE);
+
+	ret2 = btrfs_commit_transaction(trans);
+	if (!ret)
+		ret = ret2;
+
+	if (!ret && entries_to_remove > 0) {
+		btrfs_info(fs_info, "removed %u spurious free-space entries",
+			   entries_to_remove);
+	}
+
+end:
+	btrfs_put_root(fst);
+
+	return ret;
+}
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index 3d9a5d4477fc..b501c41acf3b 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 				 u64 start, u64 size);
 int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 				      u64 start, u64 size);
+int btrfs_remove_spurious_free_space(struct btrfs_fs_info *fs_info);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_free_space_info *
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 8e710bbb688e..6219e2b8e334 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -337,6 +337,8 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
 
+#define BTRFS_FEATURE_COMPAT_NO_SPURIOUS_FREE_SPACE	(1ULL << 0)
+
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
 	__u64 compat_ro_flags;
-- 
2.49.1


