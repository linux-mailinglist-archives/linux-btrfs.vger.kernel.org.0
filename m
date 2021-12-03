Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA53467FCD
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383388AbhLCWV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383382AbhLCWVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:55 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF5BC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:31 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t34so4837300qtc.7
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZS+ol8O8pmIgXaXsYBrUfZI8GDYZiX0j1omdO4gu9sA=;
        b=1XhZgpRFCBSIvwBL3Nwv0ymhmYQ3j7jpWqEXp7PjvVV1M3TQwW20yDKqUPCz2jTNVN
         rGY77yleCbuFFkJ0dZLsCZpbe6I0b2+wQeJVIrtwYw+3bTuFLiZD6voXwSnaXWuYu54b
         9v9eOt6BVVK0mhtjwecdl5bMcUFZMdrVGerFfRDlsHMqoYW7apzvcNmX1BKq7AtCFRTR
         nymWt76G6r3QgXjDHweEdy/zx2foOqm3LhPBRBlilK8l5Lcbms/ry5PNiE3aSSrG4lbO
         xUK1aWDRC114YBgHwYqcJLMZfjFETm9k4GAv2WmZTjh/j20i5qcSjWWNK7L44ObgAB0v
         XHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS+ol8O8pmIgXaXsYBrUfZI8GDYZiX0j1omdO4gu9sA=;
        b=fzuxdwxXy8qtCGP52tQSl3HWSQqW3nwCOnHM3Kpsq+Jj33pEyFOHnpIb/DeSoKXtKD
         +1HPA9nNkfOy6Xz6xR9OCosoS+5LoRFQ9DKJrpK4VXTtyz3t1nSzTDxj98Loq94mwrMM
         KG42kKyfsAYXXS2qfed0oejWVEbMTVJRsEbwK2obaLABRuBbbNlhevgmCl5Oc0UScweu
         RpFDznya6bzNdutVegZ7T7nZFTsAsDu0WzG/j1YmW202BNYq0GLSkjY5licrLD2eMnG2
         hrEIoHJ6BRgBW460+GE3HMv7yWVu4bgDbwC839ebBRqDEsFq6MJTpow+3LmUTutv1CGo
         bOMQ==
X-Gm-Message-State: AOAM532QMGmdhUcnMqrsd5s/Td6FTNHU7wgM0HRCW6mHSQNAxC0JsJIm
        rvnHBYHgETTf6/P8G5A2Yh2ETMWJ4UvRJw==
X-Google-Smtp-Source: ABdhPJwLg+yvXU8YE94BW5Mbi3gm26U8eu4hGPRNjOAIRDM2IhHkWF333Zy3B4egSP9vzaH4QfoREQ==
X-Received: by 2002:a05:622a:50d:: with SMTP id l13mr23920835qtx.75.1638569910130;
        Fri, 03 Dec 2021 14:18:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f1sm3376947qtf.74.2021.12.03.14.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/18] btrfs: add btrfs_truncate_control struct
Date:   Fri,  3 Dec 2021 17:18:09 -0500
Message-Id: <da13ec640742c084527e14ca5ab636b04047f7f0.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm going to be adding more arguments and counters to
btrfs_truncate_inode_items, so add a control struct to handle all of the
extra arguments to make it easier to follow.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c |  7 +++++--
 fs/btrfs/inode-item.c       | 25 ++++++++-----------------
 fs/btrfs/inode-item.h       | 18 ++++++++++++++++--
 fs/btrfs/inode.c            | 18 ++++++++++++------
 fs/btrfs/tree-log.c         |  6 +++++-
 5 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 28b9c63ba536..a05dd3d29695 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -291,6 +291,10 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 				    struct btrfs_block_group *block_group,
 				    struct inode *vfs_inode)
 {
+	struct btrfs_truncate_control control = {
+		.new_size = 0,
+		.min_type = BTRFS_EXTENT_DATA_KEY,
+	};
 	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	struct btrfs_root *root = inode->root;
 	struct extent_state *cached_state = NULL;
@@ -333,8 +337,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	 * We skip the throttling logic for free space cache inodes, so we don't
 	 * need to check for -EAGAIN.
 	 */
-	ret = btrfs_truncate_inode_items(trans, root, inode, 0,
-					 BTRFS_EXTENT_DATA_KEY, NULL);
+	ret = btrfs_truncate_inode_items(trans, root, inode, &control);
 	unlock_extent_cached(&inode->io_tree, 0, (u64)-1, &cached_state);
 	if (ret)
 		goto fail;
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 8afc8d1c607b..fa172c760fe2 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -425,16 +425,8 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
  * @trans:		A transaction handle.
  * @root:		The root from which to remove items.
  * @inode:		The inode whose items we want to remove.
- * @new_size:		The new i_size for the inode. This is only applicable when
- *			@min_type is BTRFS_EXTENT_DATA_KEY, must be 0 otherwise.
- * @min_type:		The minimum key type to remove. All keys with a type
- *			greater than this value are removed and all keys with
- *			this type are removed only if their offset is >= @new_size.
- * @extents_found:	Output parameter that will contain the number of file
- *			extent items that were removed or adjusted to the new
- *			inode i_size. The caller is responsible for initializing
- *			the counter. Also, it can be NULL if the caller does not
- *			need this counter.
+ * @control:		The btrfs_truncate_control to control how and what we
+ *			are truncating.
  *
  * Remove all keys associated with the inode from the given root that have a key
  * with a type greater than or equals to @min_type. When @min_type has a value of
@@ -448,8 +440,7 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       struct btrfs_inode *inode,
-			       u64 new_size, u32 min_type,
-			       u64 *extents_found)
+			       struct btrfs_truncate_control *control)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
@@ -457,6 +448,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
+	u64 new_size = control->new_size;
 	u64 extent_num_bytes = 0;
 	u64 extent_offset = 0;
 	u64 item_end = 0;
@@ -472,7 +464,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	bool be_nice = false;
 	bool should_throttle = false;
 
-	BUG_ON(new_size > 0 && min_type != BTRFS_EXTENT_DATA_KEY);
+	BUG_ON(new_size > 0 && control->min_type != BTRFS_EXTENT_DATA_KEY);
 
 	/*
 	 * For shareable roots we want to back off from time to time, this turns
@@ -527,7 +519,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		if (found_key.objectid != ino)
 			break;
 
-		if (found_type < min_type)
+		if (found_type < control->min_type)
 			break;
 
 		item_end = found_key.offset;
@@ -551,7 +543,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			}
 			item_end--;
 		}
-		if (found_type > min_type) {
+		if (found_type > control->min_type) {
 			del_item = 1;
 		} else {
 			if (item_end < new_size)
@@ -566,8 +558,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		if (found_type != BTRFS_EXTENT_DATA_KEY)
 			goto delete;
 
-		if (extents_found != NULL)
-			(*extents_found)++;
+		control->extents_found++;
 
 		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
 			u64 num_dec;
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 63e8f45f110f..47c3fec579f8 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -9,10 +9,24 @@
  */
 #define BTRFS_NEED_TRUNCATE_BLOCK 1
 
+struct btrfs_truncate_control {
+	/* IN: the size we're truncating to. */
+	u64 new_size;
+
+	/* OUT: the number of extents truncated. */
+	u64 extents_found;
+
+	/*
+	 * IN: minimum key type to remove.  All key types with this type are
+	 * removed only if their offset >= new_size.
+	 */
+	u32 min_type;
+};
+
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
-			       struct btrfs_inode *inode, u64 new_size,
-			       u32 min_type, u64 *extents_found);
+			       struct btrfs_inode *inode,
+			       struct btrfs_truncate_control *control);
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   const char *name, int name_len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 73bb7acf6813..6600c474b2e8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5251,6 +5251,11 @@ void btrfs_evict_inode(struct inode *inode)
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 
 	while (1) {
+		struct btrfs_truncate_control control = {
+			.new_size = 0,
+			.min_type = 0,
+		};
+
 		trans = evict_refill_and_join(root, rsv);
 		if (IS_ERR(trans))
 			goto free_rsv;
@@ -5258,7 +5263,7 @@ void btrfs_evict_inode(struct inode *inode)
 		trans->block_rsv = rsv;
 
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
-						 0, 0, NULL);
+						 &control);
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
@@ -8527,6 +8532,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 {
+	struct btrfs_truncate_control control = {
+		.min_type = BTRFS_EXTENT_DATA_KEY,
+	};
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_block_rsv *rsv;
@@ -8534,7 +8542,6 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	struct btrfs_trans_handle *trans;
 	u64 mask = fs_info->sectorsize - 1;
 	u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
-	u64 extents_found = 0;
 
 	if (!skip_writeback) {
 		ret = btrfs_wait_ordered_range(inode, inode->i_size & (~mask),
@@ -8599,6 +8606,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		const u64 new_size = inode->i_size;
 		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
 
+		control.new_size = new_size;
 		lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
 				 &cached_state);
 		/*
@@ -8611,9 +8619,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 					(u64)-1, 0);
 
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
-						 inode->i_size,
-						 BTRFS_EXTENT_DATA_KEY,
-						 &extents_found);
+						 &control);
 		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start,
 				     (u64)-1, &cached_state);
 
@@ -8692,7 +8698,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	 * between the old i_size and the new i_size, and there were no prealloc
 	 * extents beyond i_size to drop.
 	 */
-	if (extents_found > 0)
+	if (control.extents_found > 0)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
 
 	return ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c7a7f78708d5..04374a7346db 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4095,11 +4095,15 @@ static int truncate_inode_items(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode,
 				u64 new_size, u32 min_type)
 {
+	struct btrfs_truncate_control control = {
+		.new_size = new_size,
+		.min_type = min_type,
+	};
 	int ret;
 
 	do {
 		ret = btrfs_truncate_inode_items(trans, log_root, inode,
-						 new_size, min_type, NULL);
+						 &control);
 	} while (ret == -EAGAIN);
 
 	return ret;
-- 
2.26.3

