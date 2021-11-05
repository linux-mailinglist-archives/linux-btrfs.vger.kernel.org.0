Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC9446A0A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhKEUtG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhKEUtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:49:04 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97577C061208
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d21so8298089qtw.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i7rp3b4P5njvg3O/GnagV1vA+am3TedFEDudIKpe7FQ=;
        b=rnarlWSHHxyh0tLYdgKsmz08/APQpcR4d4+XE1mJl01gPvIg15SXhK3oEdLLc7tdBv
         U91hc9fFGONofjAxgzycZSx75xS5hmEZBrWdLycucB43sITQGxw9LZjyRrB9fZx3YL2S
         lqhLmFozMT1WMis8stJopJoAz3nF8uxP7mNmvAKKhvbbGxblbI+XIpZNHrUE/vlaqq6B
         iS2nhKaLPCg2HrwP7VbKrsvPTpAXVsspMEfDgKx3NO/1SkLNChFkOwblbU2GIIKP1u4D
         YXUNdbYoiiC5+ceLCXAgYpfH/jlCUy20WTEhvpxqvF7ySCP+JfaOPmLhHID17WjnCjgf
         w3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7rp3b4P5njvg3O/GnagV1vA+am3TedFEDudIKpe7FQ=;
        b=8RvIq6/Zv+PjbBw2PGtwYMZfNPxRnP5c8eZWdC5CmbLGxNxJliBozGz4YqGAfyBwUS
         OYIZEbFV8/Nr89Ik6lYIp8fJ8yDHu2QWdnVRQfbp8kK1d/FNtS3EiUsIvCE/qUf8iDbD
         SfTnjhhgyFnB/5uv5zLVyS6iXVUHZuo+eTarYFsIVDnPEw7gMo+K6HcR9/XxKsooZzY+
         E0QQIK1sEt5iG92jJdqRAyi9eI8v3nuMPvxOibRbGvoMKaZO2uvi1qQp77V5EACdsGQc
         lacUK6JF0jiC8XAVteJaMKe+snY+XB80PeKtZSPsrkSVujp+aEXc+6gD7+Dm674CeVwZ
         obzQ==
X-Gm-Message-State: AOAM5329abSqdWsf38KcmSu3OfucU8NQ+M+xxZzH2oJio/0JqJHXSnqg
        edfcRs6vT/CWgrc8YIec6r3OiFf7ESTbpA==
X-Google-Smtp-Source: ABdhPJyuhgoiRrvbr/RAuFajTxMKU0NshXJ6eWc8lsunwlUWCkkjdKO3vCndis7i5pjsDIdvfUORjA==
X-Received: by 2002:ac8:5e12:: with SMTP id h18mr44272036qtx.168.1636145183473;
        Fri, 05 Nov 2021 13:46:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az39sm6431080qkb.2.2021.11.05.13.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/25] btrfs: stop accessing ->csum_root directly
Date:   Fri,  5 Nov 2021 16:45:48 -0400
Message-Id: <8502fb8b2b46ccbe497691a3d721f015bf95fb19.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to have multiple csum roots in the future, so convert all
users of ->csum_root to btrfs_csum_root() and rename ->csum_root to
->_csum_root so we can easily find remaining users in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c   |  8 +++++---
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/disk-io.c     | 15 ++++++++-------
 fs/btrfs/disk-io.h     |  6 ++++++
 fs/btrfs/extent-tree.c | 11 ++++++++---
 fs/btrfs/file-item.c   |  4 +++-
 fs/btrfs/inode.c       | 11 ++++++++---
 fs/btrfs/relocation.c  |  4 +++-
 fs/btrfs/scrub.c       |  7 +++++--
 fs/btrfs/tree-log.c    | 19 +++++++++++++------
 10 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 7f5c230ea547..7dcbe901b583 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -355,6 +355,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	struct btrfs_space_info *sinfo = block_rsv->space_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
 	u64 num_bytes;
 	unsigned min_items;
 
@@ -364,7 +365,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	 * it to a minimal amount for safety.
 	 */
 	num_bytes = btrfs_root_used(&extent_root->root_item) +
-		btrfs_root_used(&fs_info->csum_root->root_item) +
+		btrfs_root_used(&csum_root->root_item) +
 		btrfs_root_used(&fs_info->tree_root->root_item);
 
 	/*
@@ -478,8 +479,9 @@ static struct btrfs_block_rsv *get_block_rsv(
 	struct btrfs_block_rsv *block_rsv = NULL;
 
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
-	    (root == fs_info->csum_root && trans->adding_csums) ||
-	    (root == fs_info->uuid_root))
+	    (root == fs_info->uuid_root) ||
+	    (trans->adding_csums &&
+	     root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID))
 		block_rsv = trans->block_rsv;
 
 	if (!block_rsv)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 13bd6fc3901a..c8bd1abc7b89 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -628,7 +628,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *chunk_root;
 	struct btrfs_root *dev_root;
 	struct btrfs_root *fs_root;
-	struct btrfs_root *csum_root;
+	struct btrfs_root *_csum_root;
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 898b4ff83718..b8a92bb6081d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1563,7 +1563,7 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 	if (objectid == BTRFS_DEV_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->dev_root);
 	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->csum_root);
+		return btrfs_grab_root(fs_info->_csum_root);
 	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->quota_root) ?
 			fs_info->quota_root : ERR_PTR(-ENOENT);
@@ -1634,7 +1634,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->tree_root);
 	btrfs_put_root(fs_info->chunk_root);
 	btrfs_put_root(fs_info->dev_root);
-	btrfs_put_root(fs_info->csum_root);
+	btrfs_put_root(fs_info->_csum_root);
 	btrfs_put_root(fs_info->quota_root);
 	btrfs_put_root(fs_info->uuid_root);
 	btrfs_put_root(fs_info->free_space_root);
@@ -2001,6 +2001,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	const int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
 	struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
+	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 	root_backup = info->super_for_commit->super_roots + next_backup;
 
@@ -2050,11 +2051,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_dev_root_level(root_backup,
 				       btrfs_header_level(info->dev_root->node));
 
-	btrfs_set_backup_csum_root(root_backup, info->csum_root->node->start);
+	btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
 	btrfs_set_backup_csum_root_gen(root_backup,
-			       btrfs_header_generation(info->csum_root->node));
+				       btrfs_header_generation(csum_root->node));
 	btrfs_set_backup_csum_root_level(root_backup,
-			       btrfs_header_level(info->csum_root->node));
+					 btrfs_header_level(csum_root->node));
 
 	btrfs_set_backup_total_bytes(root_backup,
 			     btrfs_super_total_bytes(info->super_copy));
@@ -2160,7 +2161,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 
 	free_root_extent_buffers(info->dev_root);
 	free_root_extent_buffers(info->_extent_root);
-	free_root_extent_buffers(info->csum_root);
+	free_root_extent_buffers(info->_csum_root);
 	free_root_extent_buffers(info->quota_root);
 	free_root_extent_buffers(info->uuid_root);
 	free_root_extent_buffers(info->fs_root);
@@ -2481,7 +2482,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 			}
 		} else {
 			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-			fs_info->csum_root = root;
+			fs_info->_csum_root = root;
 		}
 	} else {
 		set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e2824c6ada72..a4d1788acd24 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -109,6 +109,12 @@ static inline struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info
 	return fs_info->_extent_root;
 }
 
+static inline struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
+						 u64 bytenr)
+{
+	return fs_info->_csum_root;
+}
+
 static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
 {
 	return btrfs_extent_root(fs_info, 0);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index de80b7109a08..3cf354223e55 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1851,8 +1851,11 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 	if (head->must_insert_reserved) {
 		btrfs_pin_extent(trans, head->bytenr, head->num_bytes, 1);
 		if (head->is_data) {
-			ret = btrfs_del_csums(trans, fs_info->csum_root,
-					      head->bytenr, head->num_bytes);
+			struct btrfs_root *csum_root;
+
+			csum_root = btrfs_csum_root(fs_info, head->bytenr);
+			ret = btrfs_del_csums(trans, csum_root, head->bytenr,
+					      head->num_bytes);
 		}
 	}
 
@@ -3188,7 +3191,9 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 
 		if (is_data) {
-			ret = btrfs_del_csums(trans, info->csum_root, bytenr,
+			struct btrfs_root *csum_root;
+			csum_root = btrfs_csum_root(info, bytenr);
+			ret = btrfs_del_csums(trans, csum_root, bytenr,
 					      num_bytes);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4904286139bf..be2bd13b34e0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -257,6 +257,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 			    struct btrfs_path *path, u64 disk_bytenr,
 			    u64 len, u8 *dst)
 {
+	struct btrfs_root *csum_root;
 	struct btrfs_csum_item *item = NULL;
 	struct btrfs_key key;
 	const u32 sectorsize = fs_info->sectorsize;
@@ -285,7 +286,8 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 
 	/* Current item doesn't contain the desired range, search again */
 	btrfs_release_path(path);
-	item = btrfs_lookup_csum(NULL, fs_info->csum_root, path, disk_bytenr, 0);
+	csum_root = btrfs_csum_root(fs_info, disk_bytenr);
+	item = btrfs_lookup_csum(NULL, csum_root, path, disk_bytenr, 0);
 	if (IS_ERR(item)) {
 		ret = PTR_ERR(item);
 		goto out;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d14dd2cf36e..613b4dd13aec 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1530,11 +1530,12 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 					u64 bytenr, u64 num_bytes)
 {
-	int ret;
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bytenr);
 	struct btrfs_ordered_sum *sums;
+	int ret;
 	LIST_HEAD(list);
 
-	ret = btrfs_lookup_csums_range(fs_info->csum_root, bytenr,
+	ret = btrfs_lookup_csums_range(csum_root, bytenr,
 				       bytenr + num_bytes - 1, &list, 0);
 	if (ret == 0 && list_empty(&list))
 		return 0;
@@ -2584,11 +2585,15 @@ static int add_pending_csums(struct btrfs_trans_handle *trans,
 			     struct list_head *list)
 {
 	struct btrfs_ordered_sum *sum;
+	struct btrfs_root *csum_root = NULL;
 	int ret;
 
 	list_for_each_entry(sum, list, list) {
 		trans->adding_csums = true;
-		ret = btrfs_csum_file_blocks(trans, trans->fs_info->csum_root, sum);
+		if (!csum_root)
+			csum_root = btrfs_csum_root(trans->fs_info,
+						    sum->bytenr);
+		ret = btrfs_csum_file_blocks(trans, csum_root, sum);
 		trans->adding_csums = false;
 		if (ret)
 			return ret;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index dc99b4a27d5f..1bbe15dfb496 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4306,6 +4306,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_root *csum_root;
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered;
 	int ret;
@@ -4317,7 +4318,8 @@ int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
 	BUG_ON(ordered->file_offset != file_pos || ordered->num_bytes != len);
 
 	disk_bytenr = file_pos + inode->index_cnt;
-	ret = btrfs_lookup_csums_range(fs_info->csum_root, disk_bytenr,
+	csum_root = btrfs_csum_root(fs_info, disk_bytenr);
+	ret = btrfs_lookup_csums_range(csum_root, disk_bytenr,
 				       disk_bytenr + len - 1, &list, 0);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7c272cfd241f..6b0ee1b17ae5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2898,7 +2898,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root = btrfs_extent_root(fs_info, logic_start);
-	struct btrfs_root *csum_root = fs_info->csum_root;
+	struct btrfs_root *csum_root;
 	struct btrfs_extent_item *extent;
 	struct btrfs_io_context *bioc = NULL;
 	u64 flags;
@@ -3060,6 +3060,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 			extent_dev = bioc->stripes[0].dev;
 			btrfs_put_bioc(bioc);
 
+			csum_root = btrfs_csum_root(fs_info, extent_logical);
 			ret = btrfs_lookup_csums_range(csum_root,
 						extent_logical,
 						extent_logical + extent_len - 1,
@@ -3169,7 +3170,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	struct btrfs_path *path, *ppath;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root;
-	struct btrfs_root *csum_root = fs_info->csum_root;
+	struct btrfs_root *csum_root;
 	struct btrfs_extent_item *extent;
 	struct blk_plug plug;
 	u64 flags;
@@ -3273,6 +3274,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	key_end.offset = (u64)-1;
 	reada1 = btrfs_reada_add(root, &key, &key_end);
 
+	csum_root = btrfs_csum_root(fs_info, logical);
+
 	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
 		key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 		key.type = BTRFS_EXTENT_CSUM_KEY;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ab33caf016f..3dcee69299c4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -872,17 +872,21 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			 */
 			while (!list_empty(&ordered_sums)) {
 				struct btrfs_ordered_sum *sums;
+				struct btrfs_root *csum_root;
+
 				sums = list_entry(ordered_sums.next,
 						struct btrfs_ordered_sum,
 						list);
+				csum_root = btrfs_csum_root(fs_info,
+							    sums->bytenr);
 				if (!ret)
-					ret = btrfs_del_csums(trans,
-							      fs_info->csum_root,
+					ret = btrfs_del_csums(trans, csum_root,
 							      sums->bytenr,
 							      sums->len);
 				if (!ret)
 					ret = btrfs_csum_file_blocks(trans,
-						fs_info->csum_root, sums);
+								     csum_root,
+								     sums);
 				list_del(&sums->list);
 				kfree(sums);
 			}
@@ -4391,6 +4395,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 
 			found_type = btrfs_file_extent_type(src, extent);
 			if (found_type == BTRFS_FILE_EXTENT_REG) {
+				struct btrfs_root *csum_root;
 				u64 ds, dl, cs, cl;
 				ds = btrfs_file_extent_disk_bytenr(src,
 								extent);
@@ -4409,8 +4414,8 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 					cl = dl;
 				}
 
-				ret = btrfs_lookup_csums_range(
-						fs_info->csum_root,
+				csum_root = btrfs_csum_root(fs_info, ds);
+				ret = btrfs_lookup_csums_range(csum_root,
 						ds + cs, ds + cs + cl - 1,
 						&ordered_sums, 0);
 				if (ret)
@@ -4462,6 +4467,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 			    struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_root *csum_root;
 	u64 csum_offset;
 	u64 csum_len;
 	u64 mod_start = em->mod_start;
@@ -4542,7 +4548,8 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	}
 
 	/* block start is already adjusted for the file extent offset. */
-	ret = btrfs_lookup_csums_range(trans->fs_info->csum_root,
+	csum_root = btrfs_csum_root(trans->fs_info, em->block_start);
+	ret = btrfs_lookup_csums_range(csum_root,
 				       em->block_start + csum_offset,
 				       em->block_start + csum_offset +
 				       csum_len - 1, &ordered_sums, 0);
-- 
2.26.3

