Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22BC7AB053
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjIVLOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjIVLOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:14:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C635AF
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:14:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4CA251FD90;
        Fri, 22 Sep 2023 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/6JRIjz43mBzU13Odkt5ZFTBtE8lRCLaPPLkNXs7p4=;
        b=Pp4Eo/TSyZfCeTcbUEM6/XubkFXtgx2RGvB1zGCd4Y5kXmOptA/v70I5jTD6ieUEw9zI0D
        dshIVCfkIBMlrmhVkFJlyLd5xHEsg6SjijgZg1mT5YWgLAwvvTujF0PuzuxnA73Xj7S6YN
        1APT7WH+JENc0tFWOhIuH+JdolHXxM8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 328F62C142;
        Fri, 22 Sep 2023 11:14:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 64E86DA832; Fri, 22 Sep 2023 13:07:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/8] btrfs: relocation: use on-stack iterator in build_backref_tree
Date:   Fri, 22 Sep 2023 13:07:27 +0200
Message-ID: <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695380646.git.dsterba@suse.com>
References: <cover.1695380646.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

build_backref_tree() is called in a loop by relocate_tree_blocks()
for each relocated block. The iterator is allocated and freed repeatedly
while we could simply use an on-stack variable to avoid the allocation
and remove one more failure case. The stack grows by 48 bytes.

This was the only use of btrfs_backref_iter_alloc() so it's changed to
be an initializer and btrfs_backref_iter_free() can be removed
completely.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c    | 26 ++++++++++----------------
 fs/btrfs/backref.h    | 11 ++---------
 fs/btrfs/relocation.c | 12 ++++++------
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0dc91bf654b5..691b20b47065 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2828,26 +2828,20 @@ void free_ipath(struct inode_fs_paths *ipath)
 	kfree(ipath);
 }
 
-struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
+int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
+			    struct btrfs_backref_iter *iter)
 {
-	struct btrfs_backref_iter *ret;
-
-	ret = kzalloc(sizeof(*ret), GFP_NOFS);
-	if (!ret)
-		return NULL;
-
-	ret->path = btrfs_alloc_path();
-	if (!ret->path) {
-		kfree(ret);
-		return NULL;
-	}
+	memset(iter, 0, sizeof(struct btrfs_backref_iter));
+	iter->path = btrfs_alloc_path();
+	if (!iter->path)
+		return -ENOMEM;
 
 	/* Current backref iterator only supports iteration in commit root */
-	ret->path->search_commit_root = 1;
-	ret->path->skip_locking = 1;
-	ret->fs_info = fs_info;
+	iter->path->search_commit_root = 1;
+	iter->path->skip_locking = 1;
+	iter->fs_info = fs_info;
 
-	return ret;
+	return 0;
 }
 
 int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 83a9a34e948e..24fabbd2a80a 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -269,15 +269,8 @@ struct btrfs_backref_iter {
 	u32 end_ptr;
 };
 
-struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
-
-static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
-{
-	if (!iter)
-		return;
-	btrfs_free_path(iter->path);
-	kfree(iter);
-}
+int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
+			    struct btrfs_backref_iter *iter);
 
 static inline struct extent_buffer *btrfs_backref_get_eb(
 		struct btrfs_backref_iter *iter)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d1dcbb15baa7..6a31e73c3df7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -464,7 +464,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 			struct reloc_control *rc, struct btrfs_key *node_key,
 			int level, u64 bytenr)
 {
-	struct btrfs_backref_iter *iter;
+	struct btrfs_backref_iter iter;
 	struct btrfs_backref_cache *cache = &rc->backref_cache;
 	/* For searching parent of TREE_BLOCK_REF */
 	struct btrfs_path *path;
@@ -474,9 +474,9 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	int ret;
 	int err = 0;
 
-	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info);
-	if (!iter)
-		return ERR_PTR(-ENOMEM);
+	ret = btrfs_backref_iter_init(rc->extent_root->fs_info, &iter);
+	if (ret < 0)
+		return ERR_PTR(ret);
 	path = btrfs_alloc_path();
 	if (!path) {
 		err = -ENOMEM;
@@ -494,7 +494,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 
 	/* Breadth-first search to build backref cache */
 	do {
-		ret = btrfs_backref_add_tree_node(cache, path, iter, node_key,
+		ret = btrfs_backref_add_tree_node(cache, path, &iter, node_key,
 						  cur);
 		if (ret < 0) {
 			err = ret;
@@ -522,7 +522,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	if (handle_useless_nodes(rc, node))
 		node = NULL;
 out:
-	btrfs_backref_iter_free(iter);
+	btrfs_backref_iter_release(&iter);
 	btrfs_free_path(path);
 	if (err) {
 		btrfs_backref_error_cleanup(cache, node);
-- 
2.41.0

