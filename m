Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F06F11AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjD1GNc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 02:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345267AbjD1GN3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 02:13:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260B2737
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 23:13:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20DB91FFDC
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 06:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682662403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZmrquDT2TyXNbeAFyeWI+kfdbJfk1mg8e6Ymbh1pt98=;
        b=OKMjj/pJPBRNSF6Qjf/lCS7z9vrHqZ5Y+RA2eWIt05tTAOgLl6ORqjU3Gb9jHkysyz8lff
        5OC3Fw8AZjQP101+RXOB8xP10D9LzwBIWpgvslKrrL+kXQZh6moA6zu5FS0J6G/OMUitvi
        Sp80oVZZ97d3Wgi9+GlJxuetFL4M7H0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 761161390E
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 06:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cj9BEAJkS2RaMQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 06:13:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make clear_cache mount option to rebuild FST without disabling it
Date:   Fri, 28 Apr 2023 14:13:05 +0800
Message-Id: <f104498c17b3d428a6bb6071ccf46b19d6ac8ace.1682662078.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously clear_cache mount option would simply disable free-space-tree
feature temporarily then re-enable it to rebuild the whole free space
tree.

But this is problematic for block-group-tree feature, as we have an
artificial dependency on free-space-tree feature.

If we go the existing method, after clearing the free-space-tree
feature, we would flip the filesystem to read-only mode, as we detects a
super block write with block-group-tree but no free-space-tree feature.

This patch would change the behavior by properly rebuilding the free
space tree without disabling this feature, thus allowing clear_cache
mount option to work with block group tree.

Now we can mount a filesystem with block-group-tree feature and
clear_mount option:

 $ mkfs.btrfs  -O block-group-tree /dev/test/scratch1  -f
 $ sudo mount /dev/test/scratch1 /mnt/btrfs -o clear_cache
 $ sudo dmesg -t | head -n 5
 BTRFS info (device dm-1): force clearing of disk cache
 BTRFS info (device dm-1): using free space tree
 BTRFS info (device dm-1): auto enabling async discard
 BTRFS info (device dm-1): rebuilding free space tree
 BTRFS info (device dm-1): checking UUID tree

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Currently this patch is dependent on the patch
"btrfs: properly reject clear_cache and v1 cache for block-group-tree".

The size of the patch makes me wonder if it's a good candidate for
backports.
It's at my personal border line for patch sizes.

But if we choose to backport this patch (with the dependency),
then we can make bgt support much more consistent.

The final decision is still on David, I am happy to update both patches
if needed.
---
 fs/btrfs/disk-io.c         | 25 +++++++++++++------
 fs/btrfs/free-space-tree.c | 50 +++++++++++++++++++++++++++++++++++++-
 fs/btrfs/free-space-tree.h |  3 ++-
 fs/btrfs/super.c           |  3 +--
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59ea049fe7ee..fbf9006c6234 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3121,23 +3121,34 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 {
 	int ret;
 	const bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
-	bool clear_free_space_tree = false;
+	bool rebuild_free_space_tree = false;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
 		btrfs_warn(fs_info, "free space tree is invalid");
-		clear_free_space_tree = true;
+		rebuild_free_space_tree = true;
 	}
 
-	if (clear_free_space_tree) {
-		btrfs_info(fs_info, "clearing free space tree");
-		ret = btrfs_clear_free_space_tree(fs_info);
+	if (rebuild_free_space_tree) {
+		btrfs_info(fs_info, "rebuilding free space tree");
+		ret = btrfs_rebuild_free_space_tree(fs_info);
 		if (ret) {
 			btrfs_warn(fs_info,
-				   "failed to clear free space tree: %d", ret);
+				   "failed to rebuild free space tree: %d", ret);
+			goto out;
+		}
+	}
+
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+		btrfs_info(fs_info, "disabling free space tree");
+		ret = btrfs_delete_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to disable free space tree: %d", ret);
 			goto out;
 		}
 	}
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 4d155a48ec59..b21da1446f2a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1252,7 +1252,7 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -1298,6 +1298,54 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_root *free_space_root = btrfs_global_root(fs_info, &key);
+	struct rb_node *node;
+	int ret;
+
+	trans = btrfs_start_transaction(free_space_root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	set_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+	set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+
+	ret = clear_free_space_tree(trans, free_space_root);
+	if (ret)
+		goto abort;
+
+	node = rb_first_cached(&fs_info->block_group_cache_tree);
+	while (node) {
+		struct btrfs_block_group *block_group;
+
+		block_group = rb_entry(node, struct btrfs_block_group,
+				       cache_node);
+		ret = populate_free_space_tree(trans, block_group);
+		if (ret)
+			goto abort;
+		node = rb_next(node);
+	}
+
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
+	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
+	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+
+	ret = btrfs_commit_transaction(trans);
+	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	btrfs_end_transaction(trans);
+	return ret;
+}
+
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path)
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index dc2463e4cfe3..6d5551d0ced8 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -18,7 +18,8 @@ struct btrfs_caching_control;
 
 void set_free_space_tree_thresholds(struct btrfs_block_group *block_group);
 int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info);
-int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info);
+int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info);
 int load_free_space_tree(struct btrfs_caching_control *caching_ctl);
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
 			       struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0f2f915e42b0..ec18e2210602 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -828,8 +828,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		ret = -EINVAL;
 	}
 	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	    (btrfs_test_opt(info, CLEAR_CACHE) ||
-	     !btrfs_test_opt(info, FREE_SPACE_TREE))) {
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
 		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
 		ret = -EINVAL;
 	}
-- 
2.39.2

