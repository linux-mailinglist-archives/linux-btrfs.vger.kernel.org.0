Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC27AB054
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjIVLOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjIVLOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:14:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D4122
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:14:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A48E21A56;
        Fri, 22 Sep 2023 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdqAfD4AhtmYOHK0OHvM/vWemrWXQDkUAPHY2r5/9Yw=;
        b=rdS7SQ3lHDKJjpGM4PY+D7nRYbhYL3Pe6Njq5JMPISZ98cPUN90Nlt3fSVv6T05VCM/Pc4
        QGV1ihR6MRR3FTP2YqhVM2wWaigWxu6oK82BZKUfOImUYxq6ZaP1lCH1fFnciUdB4Ab9+H
        9EkHUTE8nRgBvQDyiFQL7ZRXv6gxr6o=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 604092C142;
        Fri, 22 Sep 2023 11:14:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8EF6FDA832; Fri, 22 Sep 2023 13:07:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/8] btrfs: relocation: constify parameters where possible
Date:   Fri, 22 Sep 2023 13:07:29 +0200
Message-ID: <0b1645424c12abc4bcd04c14779f2618645867ba.1695380646.git.dsterba@suse.com>
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

Lots of the functions in relocation.c don't change pointer parameters
but lack the annotations. Add them and reformat according to current
coding style if needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 56 +++++++++++++++++++++----------------------
 fs/btrfs/relocation.h |  9 +++----
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6a31e73c3df7..903621a65244 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -295,7 +295,7 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 	return 1;
 }
 
-static bool reloc_root_is_dead(struct btrfs_root *root)
+static bool reloc_root_is_dead(const struct btrfs_root *root)
 {
 	/*
 	 * Pair with set_bit/clear_bit in clean_dirty_subvols and
@@ -316,7 +316,7 @@ static bool reloc_root_is_dead(struct btrfs_root *root)
  * from no reloc root.  But btrfs_should_ignore_reloc_root() below is a
  * special case.
  */
-static bool have_reloc_root(struct btrfs_root *root)
+static bool have_reloc_root(const struct btrfs_root *root)
 {
 	if (reloc_root_is_dead(root))
 		return false;
@@ -325,7 +325,7 @@ static bool have_reloc_root(struct btrfs_root *root)
 	return true;
 }
 
-bool btrfs_should_ignore_reloc_root(struct btrfs_root *root)
+bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root;
 
@@ -541,7 +541,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
  */
 static int clone_backref_node(struct btrfs_trans_handle *trans,
 			      struct reloc_control *rc,
-			      struct btrfs_root *src,
+			      const struct btrfs_root *src,
 			      struct btrfs_root *dest)
 {
 	struct btrfs_root *reloc_root = src->reloc_root;
@@ -1181,9 +1181,9 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static noinline_for_stack
-int memcmp_node_keys(struct extent_buffer *eb, int slot,
-		     struct btrfs_path *path, int level)
+static noinline_for_stack int memcmp_node_keys(const struct extent_buffer *eb,
+					       int slot, const struct btrfs_path *path,
+					       int level)
 {
 	struct btrfs_disk_key key1;
 	struct btrfs_disk_key key2;
@@ -1515,8 +1515,8 @@ int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *path,
  * [min_key, max_key)
  */
 static int invalidate_extent_cache(struct btrfs_root *root,
-				   struct btrfs_key *min_key,
-				   struct btrfs_key *max_key)
+				   const struct btrfs_key *min_key,
+				   const struct btrfs_key *max_key)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct inode *inode = NULL;
@@ -2828,7 +2828,7 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 
 static noinline_for_stack int prealloc_file_extent_cluster(
 				struct btrfs_inode *inode,
-				struct file_extent_cluster *cluster)
+				const struct file_extent_cluster *cluster)
 {
 	u64 alloc_hint = 0;
 	u64 start;
@@ -2963,7 +2963,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 /*
  * Allow error injection to test balance/relocation cancellation
  */
-noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
+noinline int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
 		atomic_read(&fs_info->reloc_cancel_req) ||
@@ -2971,7 +2971,7 @@ noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
 }
 ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
 
-static u64 get_cluster_boundary_end(struct file_extent_cluster *cluster,
+static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
 				    int cluster_nr)
 {
 	/* Last extent, use cluster end directly */
@@ -2983,7 +2983,7 @@ static u64 get_cluster_boundary_end(struct file_extent_cluster *cluster,
 }
 
 static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
-			     struct file_extent_cluster *cluster,
+			     const struct file_extent_cluster *cluster,
 			     int *cluster_nr, unsigned long page_index)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -3118,7 +3118,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 }
 
 static int relocate_file_extent_cluster(struct inode *inode,
-					struct file_extent_cluster *cluster)
+					const struct file_extent_cluster *cluster)
 {
 	u64 offset = BTRFS_I(inode)->index_cnt;
 	unsigned long index;
@@ -3156,9 +3156,9 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	return ret;
 }
 
-static noinline_for_stack
-int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
-			 struct file_extent_cluster *cluster)
+static noinline_for_stack int relocate_data_extent(struct inode *inode,
+				const struct btrfs_key *extent_key,
+				struct file_extent_cluster *cluster)
 {
 	int ret;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -3222,7 +3222,7 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
  * the major work is getting the generation and level of the block
  */
 static int add_tree_block(struct reloc_control *rc,
-			  struct btrfs_key *extent_key,
+			  const struct btrfs_key *extent_key,
 			  struct btrfs_path *path,
 			  struct rb_root *blocks)
 {
@@ -3473,11 +3473,10 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
 /*
  * helper to find all tree blocks that reference a given data extent
  */
-static noinline_for_stack
-int add_data_references(struct reloc_control *rc,
-			struct btrfs_key *extent_key,
-			struct btrfs_path *path,
-			struct rb_root *blocks)
+static noinline_for_stack int add_data_references(struct reloc_control *rc,
+						  const struct btrfs_key *extent_key,
+						  struct btrfs_path *path,
+						  struct rb_root *blocks)
 {
 	struct btrfs_backref_walk_ctx ctx = { 0 };
 	struct ulist_iterator leaf_uiter;
@@ -3918,9 +3917,9 @@ static void delete_orphan_inode(struct btrfs_trans_handle *trans,
  * helper to create inode for data relocation.
  * the inode is in data relocation tree and its link count is 0
  */
-static noinline_for_stack
-struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
-				 struct btrfs_block_group *group)
+static noinline_for_stack struct inode *create_reloc_inode(
+					struct btrfs_fs_info *fs_info,
+					const struct btrfs_block_group *group)
 {
 	struct inode *inode = NULL;
 	struct btrfs_trans_handle *trans;
@@ -4467,7 +4466,8 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 }
 
 int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, struct extent_buffer *buf,
+			  struct btrfs_root *root,
+			  const struct extent_buffer *buf,
 			  struct extent_buffer *cow)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -4606,7 +4606,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
  *
  * Return U64_MAX if no running relocation.
  */
-u64 btrfs_get_reloc_bg_bytenr(struct btrfs_fs_info *fs_info)
+u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info)
 {
 	u64 logical = U64_MAX;
 
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index af749c780b4e..5fb60f2deb53 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -10,15 +10,16 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 int btrfs_recover_relocation(struct btrfs_fs_info *fs_info);
 int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered);
 int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, struct extent_buffer *buf,
+			  struct btrfs_root *root,
+			  const struct extent_buffer *buf,
 			  struct extent_buffer *cow);
 void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 			      u64 *bytes_to_reserve);
 int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			      struct btrfs_pending_snapshot *pending);
-int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info);
+int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
-bool btrfs_should_ignore_reloc_root(struct btrfs_root *root);
-u64 btrfs_get_reloc_bg_bytenr(struct btrfs_fs_info *fs_info);
+bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
+u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.41.0

