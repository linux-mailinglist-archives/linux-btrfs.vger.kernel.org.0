Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83178446A07
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhKEUtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhKEUtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:49:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC787C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:20 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w9so3234778qtk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X35N+CYz0/04ZuiZiVkNio97ZqNo54wDOSpWIfIECRo=;
        b=AnJkBBxrWeURfYkUuQ6c/nuXbZeR78BENILW5keTQtpwtCt+U9FTzQmaP4h2RLfDQw
         J7EcJG7WR/2R+JAsMlIirwRtAYNc0mc1SkPtAuLIPVeForRmgnsGmfWSQrgtv+KZlehs
         jJLdUeu0dj8syaPgi6Eks4jzk/cG7rFGJz8Ki4foResv5Jn5S/GK0942s6wdT1eH+k2y
         twMXR7VNhRwD4VQMwV0ZVRPeLNOH85yA4CXRzkJIyiZW+mOEUBKwnL/1opW94o586Ra7
         8aS4GJq6vHsBGjRZV0PGw7k3H2H6mRIIB+6YA1VUOYhv50V9f3ZjhczFKvNRrNoWJFnf
         fWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X35N+CYz0/04ZuiZiVkNio97ZqNo54wDOSpWIfIECRo=;
        b=B9Msmi60v9/OMa5Y6jiqyKaN3p0oMNoasmyjU0+kY97LC6DCkI/5/hGk8GPCqvKKKo
         SVY/4G1BwkdmZo6xvRdt/N2fPwVbFvkZlNyhvbeKfIy7krw0bPClBRLQGrHvDXlR2C2I
         e4PU/gjzFgZTByz6o4bWJnHRwiVY/FHRte+zBtq9T53CM+W6VXsByzj0H7/ne/JGsH7A
         3qeRcBf35QqiaQPucUlsEHkZPET3eJp7asd0IvrD9eVzKLuAc8n/cROEFHWXPptfU+IE
         F2yELNgK+pT3tt2TOvlIr1qi0HM8DMyYEawFXv8hMINHN/QkvP/j5rn6pQtKwCw135eA
         ecsw==
X-Gm-Message-State: AOAM530vpYOWV2pjbhSwUft6JSrIn9Z7ezAiiDP0iU8garRYShRzh7kG
        /uHKXFY4LEBu7EdbTTmIqqjiWPDFid3IAQ==
X-Google-Smtp-Source: ABdhPJx/KZqrxWHKdqLv4ei5/DkxLpZ0KtqXFyKqg/PSpOxXd9JIo/NLUDD1y8mYihaQ1EqSBcNZHg==
X-Received: by 2002:ac8:5916:: with SMTP id 22mr38317379qty.288.1636145179418;
        Fri, 05 Nov 2021 13:46:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u16sm217085qkp.57.2021.11.05.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/25] btrfs: stop accessing ->extent_root directly
Date:   Fri,  5 Nov 2021 16:45:45 -0400
Message-Id: <e3c3576c389bb85c96b7aea7521820dc023f7148.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we start having multiple extent roots we'll need to use a helper to
get to the correct extent_root.  Rename fs_info->extent_root to
_extent_root and convert all of the users of the extent root to using
the btrfs_extent_root() helper.  This will allow us to easily clean up
the remaining direct accesses in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c                | 16 ++++++++-----
 fs/btrfs/block-group.c            |  3 ++-
 fs/btrfs/block-rsv.c              |  4 +++-
 fs/btrfs/ctree.h                  |  2 +-
 fs/btrfs/disk-io.c                | 15 ++++++------
 fs/btrfs/disk-io.h                |  8 ++++++-
 fs/btrfs/extent-tree.c            | 40 +++++++++++++++++++------------
 fs/btrfs/free-space-tree.c        |  3 ++-
 fs/btrfs/qgroup.c                 |  5 +++-
 fs/btrfs/ref-verify.c             |  6 +++--
 fs/btrfs/relocation.c             |  4 ++--
 fs/btrfs/scrub.c                  |  6 +++--
 fs/btrfs/tests/free-space-tests.c |  2 +-
 fs/btrfs/tests/qgroup-tests.c     |  2 +-
 fs/btrfs/transaction.c            |  2 +-
 fs/btrfs/zoned.c                  |  3 ++-
 16 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0c5c7cc14604..96c520634521 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1170,7 +1170,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 			     struct ulist *roots, const u64 *extent_item_pos,
 			     struct share_check *sc, bool ignore_offset)
 {
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, bytenr);
 	struct btrfs_key key;
 	struct btrfs_path *path;
 	struct btrfs_delayed_ref_root *delayed_refs = NULL;
@@ -1747,6 +1747,7 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 			struct btrfs_path *path, struct btrfs_key *found_key,
 			u64 *flags_ret)
 {
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
 	int ret;
 	u64 flags;
 	u64 size = 0;
@@ -1762,11 +1763,11 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	key.objectid = logical;
 	key.offset = (u64)-1;
 
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 
-	ret = btrfs_previous_extent_item(fs_info->extent_root, path, 0);
+	ret = btrfs_previous_extent_item(extent_root, path, 0);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
@@ -2337,6 +2338,7 @@ struct btrfs_backref_iter *btrfs_backref_iter_alloc(
 int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 {
 	struct btrfs_fs_info *fs_info = iter->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
 	struct btrfs_path *path = iter->path;
 	struct btrfs_extent_item *ei;
 	struct btrfs_key key;
@@ -2347,7 +2349,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 	key.offset = (u64)-1;
 	iter->bytenr = bytenr;
 
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 	if (ret == 0) {
@@ -2390,7 +2392,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 
 	/* If there is no inline backref, go search for keyed backref */
 	if (iter->cur_ptr >= iter->end_ptr) {
-		ret = btrfs_next_item(fs_info->extent_root, path);
+		ret = btrfs_next_item(extent_root, path);
 
 		/* No inline nor keyed ref */
 		if (ret > 0) {
@@ -2434,6 +2436,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 {
 	struct extent_buffer *eb = btrfs_backref_get_eb(iter);
+	struct btrfs_root *extent_root;
 	struct btrfs_path *path = iter->path;
 	struct btrfs_extent_inline_ref *iref;
 	int ret;
@@ -2464,7 +2467,8 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 	}
 
 	/* We're at keyed items, there is no inline item, go to the next one */
-	ret = btrfs_next_item(iter->fs_info->extent_root, iter->path);
+	extent_root = btrfs_extent_root(iter->fs_info, iter->bytenr);
+	ret = btrfs_next_item(extent_root, iter->path);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b5dfb1e3446e..7eb0a8632a01 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -514,7 +514,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 {
 	struct btrfs_block_group *block_group = caching_ctl->block_group;
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -529,6 +529,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		return -ENOMEM;
 
 	last = max_t(u64, block_group->start, BTRFS_SUPER_INFO_OFFSET);
+	extent_root = btrfs_extent_root(fs_info, last);
 
 #ifdef CONFIG_BTRFS_DEBUG
 	/*
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 166f6c74c943..7f5c230ea547 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -6,6 +6,7 @@
 #include "space-info.h"
 #include "transaction.h"
 #include "block-group.h"
+#include "disk-io.h"
 
 /*
  * HOW DO BLOCK RESERVES WORK
@@ -353,6 +354,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	struct btrfs_space_info *sinfo = block_rsv->space_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
 	u64 num_bytes;
 	unsigned min_items;
 
@@ -361,7 +363,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	 * checksum tree and the root tree.  If the fs is empty we want to set
 	 * it to a minimal amount for safety.
 	 */
-	num_bytes = btrfs_root_used(&fs_info->extent_root->root_item) +
+	num_bytes = btrfs_root_used(&extent_root->root_item) +
 		btrfs_root_used(&fs_info->csum_root->root_item) +
 		btrfs_root_used(&fs_info->tree_root->root_item);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fb49162311b9..dac5741cb6fa 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -621,7 +621,7 @@ enum btrfs_exclusive_operation {
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
-	struct btrfs_root *extent_root;
+	struct btrfs_root *_extent_root;
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	struct btrfs_root *dev_root;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 372adb8ec20f..1ada4c96ef71 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1557,7 +1557,7 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 	if (objectid == BTRFS_ROOT_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->tree_root);
 	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->extent_root);
+		return btrfs_grab_root(fs_info->_extent_root);
 	if (objectid == BTRFS_CHUNK_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->chunk_root);
 	if (objectid == BTRFS_DEV_TREE_OBJECTID)
@@ -1630,7 +1630,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
-	btrfs_put_root(fs_info->extent_root);
+	btrfs_put_root(fs_info->_extent_root);
 	btrfs_put_root(fs_info->tree_root);
 	btrfs_put_root(fs_info->chunk_root);
 	btrfs_put_root(fs_info->dev_root);
@@ -2000,6 +2000,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	const int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
+	struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 
 	root_backup = info->super_for_commit->super_roots + next_backup;
 
@@ -2024,11 +2025,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	btrfs_set_backup_extent_root(root_backup, info->extent_root->node->start);
+	btrfs_set_backup_extent_root(root_backup, extent_root->node->start);
 	btrfs_set_backup_extent_root_gen(root_backup,
-			       btrfs_header_generation(info->extent_root->node));
+			       btrfs_header_generation(extent_root->node));
 	btrfs_set_backup_extent_root_level(root_backup,
-			       btrfs_header_level(info->extent_root->node));
+			       btrfs_header_level(extent_root->node));
 
 	/*
 	 * we might commit during log recovery, which happens before we set
@@ -2158,7 +2159,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->tree_root);
 
 	free_root_extent_buffers(info->dev_root);
-	free_root_extent_buffers(info->extent_root);
+	free_root_extent_buffers(info->_extent_root);
 	free_root_extent_buffers(info->csum_root);
 	free_root_extent_buffers(info->quota_root);
 	free_root_extent_buffers(info->uuid_root);
@@ -2449,7 +2450,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		}
 	} else {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->extent_root = root;
+		fs_info->_extent_root = root;
 	}
 
 	location.objectid = BTRFS_DEV_TREE_OBJECTID;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index baca29523d35..e2824c6ada72 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -103,9 +103,15 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 	return NULL;
 }
 
+static inline struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
+						   u64 bytenr)
+{
+	return fs_info->_extent_root;
+}
+
 static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
 {
-	return fs_info->extent_root;
+	return btrfs_extent_root(fs_info, 0);
 }
 
 void btrfs_put_root(struct btrfs_root *root);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f40b97072231..de80b7109a08 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -87,6 +87,7 @@ void btrfs_free_excluded_extents(struct btrfs_block_group *cache)
 /* simple helper to search for an existing data extent at a given offset */
 int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 {
+	struct btrfs_root *root = btrfs_extent_root(fs_info, start);
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_path *path;
@@ -98,7 +99,7 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 	key.objectid = start;
 	key.offset = len;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -116,6 +117,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 offset, int metadata, u64 *refs, u64 *flags)
 {
+	struct btrfs_root *extent_root;
 	struct btrfs_delayed_ref_head *head;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_path *path;
@@ -153,7 +155,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	else
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 
-	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
+	extent_root = btrfs_extent_root(fs_info, bytenr);
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out_free;
 
@@ -443,7 +446,7 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 					   u64 root_objectid,
 					   u64 owner, u64 offset)
 {
-	struct btrfs_root *root = trans->fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
 	struct btrfs_key key;
 	struct btrfs_extent_data_ref *ref;
 	struct extent_buffer *leaf;
@@ -519,7 +522,7 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 					   u64 root_objectid, u64 owner,
 					   u64 offset, int refs_to_add)
 {
-	struct btrfs_root *root = trans->fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	u32 size;
@@ -686,7 +689,7 @@ static noinline int lookup_tree_block_ref(struct btrfs_trans_handle *trans,
 					  u64 bytenr, u64 parent,
 					  u64 root_objectid)
 {
-	struct btrfs_root *root = trans->fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
 	struct btrfs_key key;
 	int ret;
 
@@ -710,6 +713,7 @@ static noinline int insert_tree_block_ref(struct btrfs_trans_handle *trans,
 					  u64 bytenr, u64 parent,
 					  u64 root_objectid)
 {
+	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
 	struct btrfs_key key;
 	int ret;
 
@@ -722,8 +726,7 @@ static noinline int insert_tree_block_ref(struct btrfs_trans_handle *trans,
 		key.offset = root_objectid;
 	}
 
-	ret = btrfs_insert_empty_item(trans, trans->fs_info->extent_root,
-				      path, &key, 0);
+	ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 	btrfs_release_path(path);
 	return ret;
 }
@@ -788,7 +791,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 				 u64 owner, u64 offset, int insert)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, bytenr);
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	struct btrfs_extent_item *ei;
@@ -1574,6 +1577,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 				 struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root;
 	struct btrfs_key key;
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
@@ -1603,8 +1607,9 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 		key.offset = head->num_bytes;
 	}
 
+	root = btrfs_extent_root(fs_info, key.objectid);
 again:
-	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 1);
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
 		err = ret;
 		goto out;
@@ -2287,7 +2292,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 					bool strict)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
 	struct extent_buffer *leaf;
 	struct btrfs_extent_data_ref *ref;
 	struct btrfs_extent_inline_ref *iref;
@@ -2922,7 +2927,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_key key;
 	struct btrfs_path *path;
-	struct btrfs_root *extent_root = info->extent_root;
+	struct btrfs_root *extent_root;
 	struct extent_buffer *leaf;
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
@@ -2938,6 +2943,8 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	int last_ref = 0;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
 
+	extent_root = btrfs_extent_root(info, bytenr);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4572,6 +4579,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      struct btrfs_key *ins, int ref_mod)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *extent_root;
 	int ret;
 	struct btrfs_extent_item *extent_item;
 	struct btrfs_extent_inline_ref *iref;
@@ -4591,8 +4599,8 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_insert_empty_item(trans, fs_info->extent_root, path,
-				      ins, size);
+	extent_root = btrfs_extent_root(fs_info, ins->objectid);
+	ret = btrfs_insert_empty_item(trans, extent_root, path, ins, size);
 	if (ret) {
 		btrfs_free_path(path);
 		return ret;
@@ -4644,6 +4652,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 				     struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *extent_root;
 	int ret;
 	struct btrfs_extent_item *extent_item;
 	struct btrfs_key extent_key;
@@ -4675,8 +4684,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_insert_empty_item(trans, fs_info->extent_root, path,
-				      &extent_key, size);
+	extent_root = btrfs_extent_root(fs_info, extent_key.objectid);
+	ret = btrfs_insert_empty_item(trans, extent_root, path, &extent_key,
+				      size);
 	if (ret) {
 		btrfs_free_path(path);
 		return ret;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a33bca94d133..968c79d86d72 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1046,7 +1046,7 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans,
 static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 				    struct btrfs_block_group *block_group)
 {
-	struct btrfs_root *extent_root = trans->fs_info->extent_root;
+	struct btrfs_root *extent_root;
 	struct btrfs_path *path, *path2;
 	struct btrfs_key key;
 	u64 start, end;
@@ -1080,6 +1080,7 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = 0;
 
+	extent_root = btrfs_extent_root(trans->fs_info, key.objectid);
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out_locked;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db680f5be745..be0c6ce3205d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3141,6 +3141,7 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 			      struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *extent_root;
 	struct btrfs_key found;
 	struct extent_buffer *scratch_leaf = NULL;
 	struct ulist *roots = NULL;
@@ -3150,7 +3151,9 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
 	int ret;
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	ret = btrfs_search_slot_for_read(fs_info->extent_root,
+	extent_root = btrfs_extent_root(fs_info,
+				fs_info->qgroup_rescan_progress.objectid);
+	ret = btrfs_search_slot_for_read(extent_root,
 					 &fs_info->qgroup_rescan_progress,
 					 path, 1, 0);
 
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index e2b9f8616501..a1ee19501030 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -972,6 +972,7 @@ void btrfs_free_ref_tree_range(struct btrfs_fs_info *fs_info, u64 start,
 /* Walk down all roots and build the ref tree, meant to be called at mount */
 int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 {
+	struct btrfs_root *extent_root;
 	struct btrfs_path *path;
 	struct extent_buffer *eb;
 	int tree_block_level = 0;
@@ -985,7 +986,8 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 	if (!path)
 		return -ENOMEM;
 
-	eb = btrfs_read_lock_root_node(fs_info->extent_root);
+	extent_root = btrfs_extent_root(fs_info, 0);
+	eb = btrfs_read_lock_root_node(extent_root);
 	level = btrfs_header_level(eb);
 	path->nodes[level] = eb;
 	path->slots[level] = 0;
@@ -998,7 +1000,7 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		 * would have had to added a ref key item which may appear on a
 		 * different leaf from the original extent item.
 		 */
-		ret = walk_down_tree(fs_info->extent_root, path, level,
+		ret = walk_down_tree(extent_root, path, level,
 				     &bytenr, &num_bytes, &tree_block_level);
 		if (ret)
 			break;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f167ce645016..dc99b4a27d5f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3964,7 +3964,7 @@ static const char *stage_to_string(int stage)
 int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 {
 	struct btrfs_block_group *bg;
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
 	struct reloc_control *rc;
 	struct inode *inode;
 	struct btrfs_path *path;
@@ -4215,7 +4215,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		goto out_end;
 	}
 
-	rc->extent_root = fs_info->extent_root;
+	rc->extent_root = btrfs_extent_root(fs_info, 0);
 
 	set_reloc_control(rc);
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf82ea6f54fb..7c272cfd241f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2897,7 +2897,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						  u64 logic_end)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_extent_root(fs_info, logic_start);
 	struct btrfs_root *csum_root = fs_info->csum_root;
 	struct btrfs_extent_item *extent;
 	struct btrfs_io_context *bioc = NULL;
@@ -3168,7 +3168,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 {
 	struct btrfs_path *path, *ppath;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root;
 	struct btrfs_root *csum_root = fs_info->csum_root;
 	struct btrfs_extent_item *extent;
 	struct blk_plug plug;
@@ -3262,6 +3262,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
 
+	root = btrfs_extent_root(fs_info, logical);
+
 	/* FIXME it might be better to start readahead at commit root */
 	key.objectid = logical;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index 8f05c1eb833f..c3709138f7cf 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -858,7 +858,7 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	root->fs_info->extent_root = root;
+	root->fs_info->_extent_root = root;
 
 	ret = test_extents(cache);
 	if (ret)
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 19ba7d5b7d8f..88e19781e83f 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -455,7 +455,7 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 	}
 
 	/* We are using this root as our extent root */
-	root->fs_info->extent_root = root;
+	root->fs_info->_extent_root = root;
 
 	/*
 	 * Some of the paths we test assume we have a filled out fs_info, so we
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9f03c727aa6a..f51edfe3681d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -413,7 +413,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
-		WARN_ON(root == fs_info->extent_root);
+		WARN_ON(root == fs_info->_extent_root);
 		WARN_ON(!force && root->commit_root != root->node);
 
 		/*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 67d932d70798..90d73e4e1827 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1104,7 +1104,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 				   u64 *offset_ret)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
@@ -1119,6 +1119,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	key.type = 0;
 	key.offset = 0;
 
+	root = btrfs_extent_root(fs_info, key.objectid);
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	/* We should not find the exact match */
 	if (!ret)
-- 
2.26.3

