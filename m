Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7D6E8399
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjDSVYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjDSVYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B790E76BD
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id ey8so674468qtb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939457; x=1684531457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rz1YLu+MmdhFfjhTIeHo4Qw3MKzLzFTxZhsTOEjXCkU=;
        b=5q9Mo2EHOt1Iz92djYUZ+2OzvDeQt7pkG1Bs/0dpXuuFjh613szmOIs1XXLfspwjxo
         7vPluqkMdSMjWEa6Na1TUOaTK0idriahJEq7vAKI6/evAAviN7Fdf9xnTLY5mup85uUr
         YgzAEIlR6PUE95tX9NuAySt+4/qp4y+KlnH4uF/rW1XRX06akrOGhBFALV3/PxOW4L2R
         e9mDK5INpN4MWcL3JRtvys9RhkWJyKQkVhqU4E8Ia0A7uuKLcuZE/M4QjEgBjNV1K2Ln
         RFJ3e0cL9lluzRNFQuIJFOwtRMyHGolzS8bfy8Q/nZzmuWHk82RrJYAOZB4URg9vyEa2
         JslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939457; x=1684531457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz1YLu+MmdhFfjhTIeHo4Qw3MKzLzFTxZhsTOEjXCkU=;
        b=F+n+iMiSj9IwxCgLZcCHpZCW8id6o9bD5HhT9AXuGS2W8ljSV+KLqRXPd+OWiMXeuk
         X2a9gYwi6u9zXhOpWDbrqb7ipKAEhNC6ebghsadoGNHtSH3yPHDzGr7AmJJ1BWhvmO/k
         VXQ5khV9nWlkEreyPPvQ42CdPw7ZeoH7/UruzzYyiuVOmb/EpDdcAWgZz4vYu3VX1FBg
         DCaCs0IZ20Pakdr7hgn3jM1zhcw9FNG7Z1bFzLgzpnghSmy5ZlVjKLMjYcUTs30Ns0bz
         L8xF7Qv1RUvfhwAUkU/JQbHRT3ew5pSL+cKuvzgghwZfN+7ix5Ay6EbZ9UIIXTU/sopk
         LKcg==
X-Gm-Message-State: AAQBX9dUVENY8wC1wi6oIXptZeCxMiStLRzKXu8LUMTek6SLK9TeEcOA
        hSS30H+V5FWDVPmE+Ww4ftV5jALJS1hO0MNOvOX6Fw==
X-Google-Smtp-Source: AKy350YEBMp71WoHxLVu/P6jKNkJujD878mdouuofPUmgqV+Okv7Kb9v61+SvBXvmt3Fh7xXpD9qkg==
X-Received: by 2002:a05:622a:1aa7:b0:3e6:3851:b945 with SMTP id s39-20020a05622a1aa700b003e63851b945mr9299998qtc.67.1681939457409;
        Wed, 19 Apr 2023 14:24:17 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a449600b0074e077c9317sm1322714qkp.99.2023.04.19.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/18] btrfs-progs: remove root argument from free_extent and inc_extent_ref
Date:   Wed, 19 Apr 2023 17:23:54 -0400
Message-Id: <49d525ba3ef5dc1a8b31b829e4f8ecd809a0cb46.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Neither of these actually need the root argument, we provide all the
information for the ref through the arguments we pass through.  Remove
the root argument from both of them.  These needed to be done in the
same patch because of the __btrfs_mod_ref helper which will pick one or
the other function for processing reference updates.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/clear-cache.c              |  5 +++--
 check/main.c                     | 10 ++++------
 check/mode-lowmem.c              | 10 +++++-----
 kernel-shared/ctree.c            | 29 +++++++++++++----------------
 kernel-shared/ctree.h            |  2 --
 kernel-shared/extent-tree.c      | 24 ++++++++++--------------
 kernel-shared/free-space-cache.c |  5 ++---
 7 files changed, 37 insertions(+), 48 deletions(-)

diff --git a/check/clear-cache.c b/check/clear-cache.c
index 5ffdd430..031379ce 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -513,8 +513,9 @@ int truncate_free_ino_items(struct btrfs_root *root)
 			extent_offset = found_key.offset -
 					btrfs_file_extent_offset(leaf, fi);
 			UASSERT(extent_offset == 0);
-			ret = btrfs_free_extent(trans, root, extent_disk_bytenr,
-						extent_num_bytes, 0, root->objectid,
+			ret = btrfs_free_extent(trans, extent_disk_bytenr,
+						extent_num_bytes, 0,
+						root->objectid,
 						BTRFS_FREE_INO_OBJECTID, 0);
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
diff --git a/check/main.c b/check/main.c
index 09805511..275f912b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3586,7 +3586,7 @@ static int repair_btree(struct btrfs_root *root,
 		 * return value is not concerned.
 		 */
 		btrfs_release_path(&path);
-		ret = btrfs_free_extent(trans, root, offset,
+		ret = btrfs_free_extent(trans, offset,
 				gfs_info->nodesize, 0,
 				root->root_key.objectid, level - 1, 0);
 		cache = next_cache_extent(cache);
@@ -6861,9 +6861,8 @@ static int record_extent(struct btrfs_trans_handle *trans,
 			 * just makes the backref allocator create a data
 			 * backref
 			 */
-			ret = btrfs_inc_extent_ref(trans, extent_root,
-						   rec->start, rec->max_size,
-						   parent,
+			ret = btrfs_inc_extent_ref(trans, rec->start,
+						   rec->max_size, parent,
 						   dback->root,
 						   parent ?
 						   BTRFS_FIRST_FREE_OBJECTID :
@@ -6890,8 +6889,7 @@ static int record_extent(struct btrfs_trans_handle *trans,
 		else
 			parent = 0;
 
-		ret = btrfs_inc_extent_ref(trans, extent_root,
-					   rec->start, rec->max_size,
+		ret = btrfs_inc_extent_ref(trans, rec->start, rec->max_size,
 					   parent, tback->root, 0, 0);
 		fprintf(stderr,
 "adding new tree backref on start %llu len %llu parent %llu root %llu\n",
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 0bc95930..10f86161 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -755,8 +755,8 @@ static int repair_tree_block_ref(struct btrfs_root *root,
 		parent = nrefs->bytenr[level + 1];
 
 	/* increase the ref */
-	ret = btrfs_inc_extent_ref(trans, extent_root, bytenr, node_size,
-			parent, root->objectid, level, 0);
+	ret = btrfs_inc_extent_ref(trans, bytenr, node_size, parent,
+				   root->objectid, level, 0);
 
 	nrefs->refs[level]++;
 out:
@@ -3335,7 +3335,7 @@ static int repair_extent_data_item(struct btrfs_root *root,
 		btrfs_release_path(&path);
 	}
 
-	ret = btrfs_inc_extent_ref(trans, root, disk_bytenr, num_bytes, parent,
+	ret = btrfs_inc_extent_ref(trans, disk_bytenr, num_bytes, parent,
 				   root->objectid,
 		   parent ? BTRFS_FIRST_FREE_OBJECTID : fi_key.objectid,
 				   offset);
@@ -4132,8 +4132,8 @@ static int repair_extent_item(struct btrfs_path *path, u64 bytenr, u64
 		goto out;
 	}
 	/* delete the backref */
-	ret = btrfs_free_extent(trans, gfs_info->fs_root, bytenr,
-			num_bytes, parent, root_objectid, owner, offset);
+	ret = btrfs_free_extent(trans, bytenr, num_bytes, parent, root_objectid,
+				owner, offset);
 	if (!ret)
 		printf("Delete backref in extent [%llu %llu]\n",
 		       bytenr, num_bytes);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index da9282b9..c3e9830a 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -491,8 +491,8 @@ static int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		root->node = cow;
 		extent_buffer_get(cow);
 
-		btrfs_free_extent(trans, root, buf->start, buf->len,
-				  0, root->root_key.objectid, level, 0);
+		btrfs_free_extent(trans, buf->start, buf->len, 0,
+				  root->root_key.objectid, level, 0);
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
 	} else {
@@ -504,8 +504,8 @@ static int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_mark_buffer_dirty(parent);
 		WARN_ON(btrfs_header_generation(parent) != trans->transid);
 
-		btrfs_free_extent(trans, root, buf->start, buf->len,
-				  0, root->root_key.objectid, level, 0);
+		btrfs_free_extent(trans, buf->start, buf->len, 0,
+				  root->root_key.objectid, level, 0);
 	}
 	if (!list_empty(&buf->recow)) {
 		list_del_init(&buf->recow);
@@ -942,9 +942,8 @@ static int balance_level(struct btrfs_trans_handle *trans,
 
 		root_sub_used(root, mid->len);
 
-		ret = btrfs_free_extent(trans, root, mid->start, mid->len,
-					0, root->root_key.objectid,
-					level, 0);
+		ret = btrfs_free_extent(trans, mid->start, mid->len, 0,
+					root->root_key.objectid, level, 0);
 		/* once for the root ptr */
 		free_extent_buffer(mid);
 		return ret;
@@ -999,10 +998,9 @@ static int balance_level(struct btrfs_trans_handle *trans,
 				ret = wret;
 
 			root_sub_used(root, blocksize);
-			wret = btrfs_free_extent(trans, root, bytenr,
-						 blocksize, 0,
-						 root->root_key.objectid,
-						 level, 0);
+			wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
+						 root->root_key.objectid, level,
+						 0);
 			if (wret)
 				ret = wret;
 		} else {
@@ -1047,9 +1045,8 @@ static int balance_level(struct btrfs_trans_handle *trans,
 			ret = wret;
 
 		root_sub_used(root, blocksize);
-		wret = btrfs_free_extent(trans, root, bytenr, blocksize,
-					 0, root->root_key.objectid,
-					 level, 0);
+		wret = btrfs_free_extent(trans, bytenr, blocksize, 0,
+					 root->root_key.objectid, level, 0);
 		if (wret)
 			ret = wret;
 	} else {
@@ -2956,8 +2953,8 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 
 	root_sub_used(root, leaf->len);
 
-	ret = btrfs_free_extent(trans, root, leaf->start, leaf->len,
-				0, root->root_key.objectid, 0, 0);
+	ret = btrfs_free_extent(trans, leaf->start, leaf->len, 0,
+				root->root_key.objectid, 0, 0);
 	return ret;
 }
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d5cd7803..2f41b58d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -875,12 +875,10 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			  struct extent_buffer *buf,
 			  u64 parent, int last_ref);
 int btrfs_free_extent(struct btrfs_trans_handle *trans,
-		      struct btrfs_root *root,
 		      u64 bytenr, u64 num_bytes, u64 parent,
 		      u64 root_objectid, u64 owner, u64 offset);
 void btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root,
 			 u64 bytenr, u64 num_bytes, u64 parent,
 			 u64 root_objectid, u64 owner, u64 offset);
 int btrfs_update_extent_ref(struct btrfs_trans_handle *trans,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 4dfb35d4..8d4483cd 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1242,11 +1242,10 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root,
 			 u64 bytenr, u64 num_bytes, u64 parent,
 			 u64 root_objectid, u64 owner, u64 offset)
 {
-	struct btrfs_root *extent_root = btrfs_extent_root(root->fs_info,
+	struct btrfs_root *extent_root = btrfs_extent_root(trans->fs_info,
 							   bytenr);
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
@@ -1467,7 +1466,6 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 	int level;
 	int ret = 0;
 	int (*process_func)(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root,
 			    u64, u64, u64, u64, u64, u64);
 
 	ref_root = btrfs_header_owner(buf);
@@ -1504,9 +1502,8 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 
 			num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
 			key.offset -= btrfs_file_extent_offset(buf, fi);
-			ret = process_func(trans, root, bytenr, num_bytes,
-					   parent, ref_root, key.objectid,
-					   key.offset);
+			ret = process_func(trans, bytenr, num_bytes, parent,
+					   ref_root, key.objectid, key.offset);
 			if (ret) {
 				WARN_ON(1);
 				goto fail;
@@ -1514,8 +1511,8 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 		} else {
 			bytenr = btrfs_node_blockptr(buf, i);
 			num_bytes = root->fs_info->nodesize;
-			ret = process_func(trans, root, bytenr, num_bytes,
-					   parent, ref_root, level - 1, 0);
+			ret = process_func(trans, bytenr, num_bytes, parent,
+					   ref_root, level - 1, 0);
 			if (ret) {
 				WARN_ON(1);
 				goto fail;
@@ -2148,7 +2145,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			  struct extent_buffer *buf,
 			  u64 parent, int last_ref)
 {
-	return btrfs_free_extent(trans, root, buf->start, buf->len, parent,
+	return btrfs_free_extent(trans, buf->start, buf->len, parent,
 				 root->root_key.objectid,
 				 btrfs_header_level(buf), 0);
 }
@@ -2158,13 +2155,12 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
  */
 
 int btrfs_free_extent(struct btrfs_trans_handle *trans,
-		      struct btrfs_root *root,
 		      u64 bytenr, u64 num_bytes, u64 parent,
 		      u64 root_objectid, u64 owner, u64 offset)
 {
 	int ret;
 
-	WARN_ON(num_bytes < root->fs_info->sectorsize);
+	WARN_ON(num_bytes < trans->fs_info->sectorsize);
 	/*
 	 * tree log blocks never actually go into the extent allocation
 	 * tree, just update pinning info and exit early.
@@ -2579,8 +2575,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 
 	buf = btrfs_find_create_tree_block(root->fs_info, ins.objectid);
 	if (!buf) {
-		btrfs_free_extent(trans, root, ins.objectid, ins.offset,
-				  0, root->root_key.objectid, level, 0);
+		btrfs_free_extent(trans, ins.objectid, ins.offset, 0,
+				  root->root_key.objectid, level, 0);
 		BUG_ON(1);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -3723,7 +3719,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_inode_nbytes(inode, nbytes);
 	btrfs_release_path(path);
 
-	ret = btrfs_inc_extent_ref(trans, root, extent_bytenr, extent_num_bytes,
+	ret = btrfs_inc_extent_ref(trans, extent_bytenr, extent_num_bytes,
 				   0, root->root_key.objectid, objectid,
 				   file_pos - extent_offset);
 	if (ret)
diff --git a/kernel-shared/free-space-cache.c b/kernel-shared/free-space-cache.c
index 83897f10..7bd76e39 100644
--- a/kernel-shared/free-space-cache.c
+++ b/kernel-shared/free-space-cache.c
@@ -982,9 +982,8 @@ int btrfs_clear_free_space_cache(struct btrfs_trans_handle *trans,
 		disk_bytenr = btrfs_file_extent_disk_bytenr(node, fi);
 		disk_num_bytes = btrfs_file_extent_disk_num_bytes(node, fi);
 
-		ret = btrfs_free_extent(trans, tree_root, disk_bytenr,
-					disk_num_bytes, 0, tree_root->objectid,
-					ino, key.offset);
+		ret = btrfs_free_extent(trans, disk_bytenr, disk_num_bytes, 0,
+					tree_root->objectid, ino, key.offset);
 		if (ret < 0) {
 			error("failed to remove backref for disk bytenr %llu: %d",
 			      disk_bytenr, ret);
-- 
2.40.0

