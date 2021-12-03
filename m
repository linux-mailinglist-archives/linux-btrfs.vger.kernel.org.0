Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D9467FD3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383400AbhLCWWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383391AbhLCWWD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:03 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D5C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:39 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id n15so4919241qta.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ukI+l95mZb18s6Or2llHiNBO59CmInfCJad/XlhqzUk=;
        b=joigiQQfV7O7HXpklaEW4J8IEccXSqQyT83ohRYvUk24uCrLLNRtM3Og/mh3urcXW3
         p7ASmqxyUjgYo56OYUsht4/f1iFf03SN3wMnd4pLcoavgAT4QpALjQZO5Col8l1E94nb
         zC2RnuRM1oKJZOZbRYSvnxNZGWZBdeK0M1/KmYYnG9bfpjD8sEjf+ytZRDTz+6c1+WRN
         BmJdT1bFRY1oT0Km60BWKxQn0oOJ8D6aUHFHxynr/j1s9GOfpdC1U8BjuZ6yhoARR4bS
         UVKSkkx3a/UMtR6FpyxJ2pwCmiF7X95ckdhopsjKVmGqpETeXzBkSMSaPEuMrJdC7QiO
         RN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukI+l95mZb18s6Or2llHiNBO59CmInfCJad/XlhqzUk=;
        b=GNly53pj8Iqp+7YlF6OyYTwssvn1AET76XZ1w+3kOb1OXW2V5sstqD8zrHAOatjeeg
         BMbAXPl6Zztrqzf1dflen8pWkIvzYkPWLubV/ccOMKBgX6WuQJ/DPwv1KZW+xj41hDNU
         9qkv0/BWdjSnwZZI/kAya4BxMFOj/ZDLkDJ2krSD4x2egsTwBf4nU9d8pGxK2CLNWX+M
         WlvD4VdKz6fccF0u0+96ZGSJyKT/LzlKadnr8yo9Si4vjPdRyCJqlMPTpdxU1XRjK7AV
         I9f486PxtmJ1BXDpsWnmmcjLDuijDjUEWaNWWdBA2DBN90kjmkiQ6NSWw5o9Htx8Ysng
         0g0w==
X-Gm-Message-State: AOAM533aUnCj4bc8rHrQ7952yfd2L7EDCbjmjyPtksiqYCBNVX0qzDSL
        AwW2sQJizU2SxXBUip91q8IYUP8WzA6DLg==
X-Google-Smtp-Source: ABdhPJxkWXaze4HtMbcjsfujHzadC3i2Sp4It7rH4Git4tJfKxPkZPkMV80ZzQogthgMlXh+Ep1O4g==
X-Received: by 2002:ac8:7489:: with SMTP id v9mr23387228qtq.676.1638569917993;
        Fri, 03 Dec 2021 14:18:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 196sm2710160qkd.61.2021.12.03.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/18] btrfs: add inode to btrfs_truncate_control
Date:   Fri,  3 Dec 2021 17:18:15 -0500
Message-Id: <67c6672e3493fbe4ef7f83fb75f6ea021d8fd024.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the future we're going to want to use btrfs_truncate_inode_items
without looking up the associated inode.  In order to accommodate this
add the inode to btrfs_truncate_control and handle the case where
control->inode is NULL appropriately.  This is fairly straightforward,
we simply need to add a helper for the trace points, as the file extent
map update is controlled by a flag on btrfs_truncate_control.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c |  3 ++-
 fs/btrfs/inode-item.c       | 32 +++++++++++++++++++++-----------
 fs/btrfs/inode-item.h       |  7 ++++++-
 fs/btrfs/inode.c            |  8 ++++----
 fs/btrfs/tree-log.c         |  3 +--
 5 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c2a34179bddc..01a408db5683 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -292,6 +292,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 				    struct inode *vfs_inode)
 {
 	struct btrfs_truncate_control control = {
+		.inode = BTRFS_I(vfs_inode),
 		.new_size = 0,
 		.ino = btrfs_ino(BTRFS_I(vfs_inode)),
 		.min_type = BTRFS_EXTENT_DATA_KEY,
@@ -339,7 +340,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	 * We skip the throttling logic for free space cache inodes, so we don't
 	 * need to check for -EAGAIN.
 	 */
-	ret = btrfs_truncate_inode_items(trans, root, inode, &control);
+	ret = btrfs_truncate_inode_items(trans, root, &control);
 
 	inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 	btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b11c3da680fd..aee374e18131 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -419,6 +419,20 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
 	return ret;
 }
 
+static inline void btrfs_trace_truncate(struct btrfs_inode *inode,
+					struct extent_buffer *leaf,
+					struct btrfs_file_extent_item *fi,
+					u64 offset, int extent_type, int slot)
+{
+	if (!inode)
+		return;
+	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
+		trace_btrfs_truncate_show_fi_inline(inode, leaf, fi, slot,
+						    offset);
+	else
+		trace_btrfs_truncate_show_fi_regular(inode, leaf, fi, offset);
+}
+
 /*
  * Remove inode items from a given root.
  *
@@ -439,7 +453,6 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
  */
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
-			       struct btrfs_inode *inode,
 			       struct btrfs_truncate_control *control)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -462,6 +475,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	bool be_nice = false;
 	bool should_throttle = false;
 
+	ASSERT(control->inode || !control->clear_extent_range);
 	BUG_ON(new_size > 0 && control->min_type != BTRFS_EXTENT_DATA_KEY);
 
 	control->last_size = new_size;
@@ -528,20 +542,16 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			fi = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_file_extent_item);
 			extent_type = btrfs_file_extent_type(leaf, fi);
-			if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
+			if (extent_type != BTRFS_FILE_EXTENT_INLINE)
 				item_end +=
 				    btrfs_file_extent_num_bytes(leaf, fi);
-
-				trace_btrfs_truncate_show_fi_regular(
-					inode, leaf, fi, found_key.offset);
-			} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+			else if (extent_type == BTRFS_FILE_EXTENT_INLINE)
 				item_end += btrfs_file_extent_ram_bytes(leaf,
 									fi);
 
-				trace_btrfs_truncate_show_fi_inline(
-					inode, leaf, fi, path->slots[0],
-					found_key.offset);
-			}
+			btrfs_trace_truncate(control->inode, leaf, fi,
+					     found_key.offset, extent_type,
+					     path->slots[0]);
 			item_end--;
 		}
 		if (found_type > control->min_type) {
@@ -632,7 +642,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		 * normal truncate path.
 		 */
 		if (control->clear_extent_range) {
-			ret = btrfs_inode_clear_file_extent_range(inode,
+			ret = btrfs_inode_clear_file_extent_range(control->inode,
 						  clear_start, clear_len);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 1948461e5a46..b8c788f71c95 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -10,6 +10,12 @@
 #define BTRFS_NEED_TRUNCATE_BLOCK 1
 
 struct btrfs_truncate_control {
+	/*
+	 * IN: the inode we're operating on, this can be NULL if
+	 * ->clear_extent_range is false.
+	 */
+	struct btrfs_inode *inode;
+
 	/* IN: the size we're truncating to. */
 	u64 new_size;
 
@@ -46,7 +52,6 @@ struct btrfs_truncate_control {
 
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
-			       struct btrfs_inode *inode,
 			       struct btrfs_truncate_control *control);
 int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 06e7c5e26a65..07e8539819b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5252,6 +5252,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 	while (1) {
 		struct btrfs_truncate_control control = {
+			.inode = BTRFS_I(inode),
 			.ino = btrfs_ino(BTRFS_I(inode)),
 			.new_size = 0,
 			.min_type = 0,
@@ -5263,8 +5264,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 		trans->block_rsv = rsv;
 
-		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
-						 &control);
+		ret = btrfs_truncate_inode_items(trans, root, &control);
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
@@ -8534,6 +8534,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 {
 	struct btrfs_truncate_control control = {
+		.inode = BTRFS_I(inode),
 		.ino = btrfs_ino(BTRFS_I(inode)),
 		.min_type = BTRFS_EXTENT_DATA_KEY,
 		.clear_extent_range = true,
@@ -8621,8 +8622,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 					ALIGN(new_size, fs_info->sectorsize),
 					(u64)-1, 0);
 
-		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
-						 &control);
+		ret = btrfs_truncate_inode_items(trans, root, &control);
 
 		inode_sub_bytes(inode, control.sub_bytes);
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode),
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fb3bf7cc21c5..80520ad1de4f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4104,8 +4104,7 @@ static int truncate_inode_items(struct btrfs_trans_handle *trans,
 	int ret;
 
 	do {
-		ret = btrfs_truncate_inode_items(trans, log_root, inode,
-						 &control);
+		ret = btrfs_truncate_inode_items(trans, log_root, &control);
 	} while (ret == -EAGAIN);
 
 	return ret;
-- 
2.26.3

