Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0B58D389
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiHIGE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 02:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiHIGEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 02:04:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD61FCC1
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 23:04:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5B82344D8
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660025058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Y0cO9cBKhuzibadkaOld1FLwh3G3Z/8BKJnvUoouac=;
        b=bz9MRNYH97baCza2pMNqTMwNG4NAl64j3wkD+Oshjz5vtNEx4Upx/3xlITYF0f+KGtOV1p
        yj8mZnSTtXfhInfJZXitBJpF2HYb3QFI99CtbCwcLXvOzZ1s8QX3X5YYQ2XiNzlSHpKN02
        2k/srN1GPG1BIKkAriOx0WfFGwHnUKA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF19613AA1
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WFd3KeH48WJTVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Aug 2022 06:04:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/5] btrfs-progs: btrfstune: add the ability to convert to block group tree feature
Date:   Tue,  9 Aug 2022 14:03:54 +0800
Message-Id: <d82711fecc60d06ebde5b58a6cf6446514e17c72.1660024949.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1660024949.git.wqu@suse.com>
References: <cover.1660024949.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new '-b' option will be responsible for converting to block group
tree compat ro feature.

The workflow looks like this for new convert:

- Setting CHANGEING_BG_TREE flag
  And initialize fs_info->last_converted_bg_bytenr value to (u64)-1.

  Any bg with bytenr >= last_converted_bg_bytenr will have its bg item
  update go to the new root (bg tree).

- Iterate each block group by their bytenr in descending order
  This involves:
  * Delete the old bg item from the old tree (extent tree)
  * Update last_converted_bg_bytenr to the bytenr of the bg
  * Add the new bg item into the new tree (bg tree)
  * If we have converted a bunch of bgs, commit current transaction

- Clear CHANGEING_BG_TREE flag
  And set the new BLOCK_GROUP_TREE compat ro flag and commit.

And since we're doing the convert in multiple transactions, we also need
to resume from last interrupted convert.

In that case, we just grab the last unconverted bg, and start from it.

And to co-operate with the new kernel requirement for both no-holes and
free-space-tree features, the convert tool will check for
free-space-tree feature. If not enabled, will error out with an error
message to how to continue (by mounting with "-o space_cache=v2").

For missing no-holes feature, we just need to set the flag during
convert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfstune.rst |   5 +
 btrfstune.c                 | 148 ++++++++++++++++++++-
 kernel-shared/ctree.c       |   8 ++
 kernel-shared/ctree.h       |  20 +++
 kernel-shared/disk-io.c     |  32 +++--
 kernel-shared/disk-io.h     |   3 +
 kernel-shared/extent-tree.c | 247 ++++++++++++++++++++++++++++++++++--
 7 files changed, 436 insertions(+), 27 deletions(-)

diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index 47caccc647b2..01c59d6dbf3b 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -24,6 +24,11 @@ means.  Please refer to the *FILESYSTEM FEATURES* in ``btrfs(5)``.
 OPTIONS
 -------
 
+-b
+        (since kernel 6.0)
+        Enable block group tree feature (greatly reduce mount time),
+        enabled by mkfs feature *block-group-tree*.
+
 -f
         Allow dangerous changes, e.g. clear the seeding flag or change fsid.
         Make sure that you are aware of the dangers.
diff --git a/btrfstune.c b/btrfstune.c
index d1a1877ee45c..add7b1804400 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -775,12 +775,134 @@ out:
 	return ret;
 }
 
+/* After this many block groups we need to commit transaction. */
+#define BLOCK_GROUP_BATCH	64
+
+static int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	struct btrfs_trans_handle *trans;
+	struct cache_extent *ce;
+	int converted_bgs = 0;
+	int ret;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 2);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		error("failed to start transaction: %d", ret);
+		return ret;
+	}
+
+	/* Set NO_HOLES feature */
+	btrfs_set_super_incompat_flags(sb, btrfs_super_incompat_flags(sb) |
+				       BTRFS_FEATURE_INCOMPAT_NO_HOLES);
+
+	/* We're resuming from previous run. */
+	if (btrfs_super_flags(sb) & BTRFS_SUPER_FLAG_CHANGING_BG_TREE)
+		goto iterate_bgs;
+
+	ret = btrfs_create_root(trans, fs_info,
+				BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+	if (ret < 0) {
+		error("failed to create block group root: %d", ret);
+		goto error;
+	}
+	btrfs_set_super_flags(sb,
+			btrfs_super_flags(sb) |
+			BTRFS_SUPER_FLAG_CHANGING_BG_TREE);
+	fs_info->last_converted_bg_bytenr = (u64)-1;
+
+	/* Now commit the transaction to make above changes to reach disks. */
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		error("failed to commit transaction for the new bg root: %d",
+		      ret);
+		goto error;
+	}
+	trans = btrfs_start_transaction(fs_info->tree_root, 2);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		error("failed to start transaction: %d", ret);
+		return ret;
+	}
+
+iterate_bgs:
+	if (fs_info->last_converted_bg_bytenr == (u64)-1) {
+		ce = last_cache_extent(&fs_info->mapping_tree.cache_tree);
+	} else {
+		ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
+					 fs_info->last_converted_bg_bytenr);
+		if (!ce) {
+			error("failed to find block group for bytenr %llu",
+			      fs_info->last_converted_bg_bytenr);
+			ret = -ENOENT;
+			goto error;
+		}
+		ce = prev_cache_extent(ce);
+		if (!ce) {
+			error("no more block group before bytenr %llu",
+			      fs_info->last_converted_bg_bytenr);
+			ret = -ENOENT;
+			goto error;
+		}
+	}
+
+	/* Now convert each block */
+	while (ce) {
+		struct cache_extent *prev = prev_cache_extent(ce);
+		u64 bytenr = ce->start;
+
+		ret = btrfs_convert_one_bg(trans, bytenr);
+		if (ret < 0)
+			goto error;
+		converted_bgs++;
+		ce = prev;
+
+		if (converted_bgs % BLOCK_GROUP_BATCH == 0) {
+			ret = btrfs_commit_transaction(trans,
+							fs_info->tree_root);
+			if (ret < 0) {
+				error("failed to commit transaction: %d", ret);
+				return ret;
+			}
+			trans = btrfs_start_transaction(fs_info->tree_root, 2);
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				error("failed to start transaction: %d", ret);
+				return ret;
+			}
+		}
+	}
+	/*
+	 * All bgs converted, remove the CHANGING_BG flag and set the compat ro
+	 * flag.
+	 */
+	fs_info->last_converted_bg_bytenr = 0;
+	btrfs_set_super_flags(sb,
+		btrfs_super_flags(sb) &
+		~BTRFS_SUPER_FLAG_CHANGING_BG_TREE);
+	btrfs_set_super_compat_ro_flags(sb,
+			btrfs_super_compat_ro_flags(sb) |
+			BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE);
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		error("faield to commit the final transaction: %d", ret);
+		return ret;
+	}
+	printf("Converted the filesystem to block group tree feature\n");
+	return 0;
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 static void print_usage(void)
 {
 	printf("usage: btrfstune [options] device\n");
 	printf("Tune settings of filesystem features on an unmounted device\n\n");
 	printf("Options:\n");
 	printf("  change feature status:\n");
+	printf("\t-b          enable block group tree (mkfs: block-group-tree, for less mount time)\n");
 	printf("\t-r          enable extended inode refs (mkfs: extref, for hardlink limits)\n");
 	printf("\t-x          enable skinny metadata extent refs (mkfs: skinny-metadata)\n");
 	printf("\t-n          enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)\n");
@@ -811,6 +933,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	u64 seeding_value = 0;
 	int random_fsid = 0;
 	int change_metadata_uuid = 0;
+	bool to_bg_tree = false;
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
 	int ret;
@@ -826,11 +949,14 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
+		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
 
 		if (c < 0)
 			break;
 		switch(c) {
+		case 'b':
+			to_bg_tree = true;
+			break;
 		case 'S':
 			seeding_flag = 1;
 			seeding_value = arg_strtou64(optarg);
@@ -890,7 +1016,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
-	    !change_metadata_uuid && csum_type == -1) {
+	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree) {
 		error("at least one option should be specified");
 		print_usage();
 		return 1;
@@ -936,6 +1062,24 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 
+	if (to_bg_tree) {
+		if (btrfs_fs_compat_ro(root->fs_info, BLOCK_GROUP_TREE)) {
+			error("the filesystem already has block group tree feature");
+			ret = 1;
+			goto out;
+		}
+		if (!btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE_VALID)) {
+			error("the filesystem doesn't have space cache v2, needs to be mounted with \"-o space_cache=v2\" first");
+			ret = 1;
+			goto out;
+		}
+		ret = convert_to_bg_tree(root->fs_info);
+		if (ret < 0) {
+			error("failed to convert the filesystem to block group tree feature");
+			goto out;
+		}
+		goto out;
+	}
 	if (seeding_flag) {
 		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
 			fprintf(stderr, "SEED flag cannot be changed on a metadata-uuid changed fs\n");
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 2707e0e64f31..834dcf412e11 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -267,6 +267,14 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 		fs_info->quota_root = new_root;
 		fs_info->quota_enabled = 1;
 		break;
+	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+		if (fs_info->block_group_root) {
+			error("bg root already exists");
+			ret = -EEXIST;
+			goto free;
+		}
+		fs_info->block_group_root = new_root;
+		break;
 	/*
 	 * Essential trees can't be created by this function, yet.
 	 * As we expect such skeleton exists, or a lot of functions like
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d8909b3fdf20..d9ec945690d6 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -324,6 +324,13 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 #define BTRFS_SUPER_FLAG_CHANGING_FSID_V2	(1ULL << 36)
 #define BTRFS_SUPER_FLAG_CHANGING_CSUM		(1ULL << 37)
 
+/*
+ * The fs is undergoing block group tree feature change.
+ * If no BLOCK_GROUP_TREE compat ro flag, it's changing from regular
+ * bg item in extent tree to new bg tree.
+ */
+#define BTRFS_SUPER_FLAG_CHANGING_BG_TREE	(1ULL << 38)
+
 #define BTRFS_BACKREF_REV_MAX		256
 #define BTRFS_BACKREF_REV_SHIFT		56
 #define BTRFS_BACKREF_REV_MASK		(((u64)BTRFS_BACKREF_REV_MAX - 1) << \
@@ -1264,6 +1271,18 @@ struct btrfs_fs_info {
 	struct cache_tree *fsck_extent_cache;
 	struct cache_tree *corrupt_blocks;
 
+	/*
+	 * For converting to/from bg tree feature, this records the bytenr
+	 * of the last processed block group item.
+	 *
+	 * Any new block group item after this bytenr is using the target
+	 * block group item format. (e.g. if converting to bg tree, bg item
+	 * after this bytenr should go into block group tree).
+	 *
+	 * Thus the number should decrease as our convert progress goes.
+	 */
+	u64 last_converted_bg_bytenr;
+
 	/* Cached block sizes */
 	u32 nodesize;
 	u32 sectorsize;
@@ -2665,6 +2684,7 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 u64 add_new_free_space(struct btrfs_block_group *block_group,
 		       struct btrfs_fs_info *info, u64 start, u64 end);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
+int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6eeb5ecd1d59..58030ebf16cd 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -562,9 +562,9 @@ err:
 	return -EIO;
 }
 
-static int find_and_setup_root(struct btrfs_root *tree_root,
-			       struct btrfs_fs_info *fs_info,
-			       u64 objectid, struct btrfs_root *root)
+int btrfs_find_and_setup_root(struct btrfs_root *tree_root,
+			      struct btrfs_fs_info *fs_info,
+			      u64 objectid, struct btrfs_root *root)
 {
 	int ret;
 
@@ -644,7 +644,7 @@ struct btrfs_root *btrfs_read_fs_root_no_cache(struct btrfs_fs_info *fs_info,
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 	if (location->offset == (u64)-1) {
-		ret = find_and_setup_root(tree_root, fs_info,
+		ret = btrfs_find_and_setup_root(tree_root, fs_info,
 					  location->objectid, root);
 		if (ret) {
 			free(root);
@@ -1203,7 +1203,9 @@ static int load_important_roots(struct btrfs_fs_info *fs_info,
 		backup = sb->super_roots + index;
 	}
 
-	if (!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+	if (!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) &&
+	    !(btrfs_super_flags(fs_info->super_copy) &
+	      BTRFS_SUPER_FLAG_CHANGING_BG_TREE)) {
 		free(fs_info->block_group_root);
 		fs_info->block_group_root = NULL;
 		goto tree_root;
@@ -1256,8 +1258,9 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	if (ret)
 		return ret;
 
-	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
-		ret = find_and_setup_root(root, fs_info,
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) ||
+	    btrfs_super_flags(sb) & BTRFS_SUPER_FLAG_CHANGING_BG_TREE) {
+		ret = btrfs_find_and_setup_root(root, fs_info,
 				BTRFS_BLOCK_GROUP_TREE_OBJECTID,
 				fs_info->block_group_root);
 		if (ret) {
@@ -1267,8 +1270,9 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		fs_info->block_group_root->track_dirty = 1;
 	}
 
-	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
-				  fs_info->dev_root);
+	ret = btrfs_find_and_setup_root(root, fs_info,
+					BTRFS_DEV_TREE_OBJECTID,
+					fs_info->dev_root);
 	if (ret) {
 		printk("Couldn't setup device tree\n");
 		return -EIO;
@@ -1276,8 +1280,9 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	fs_info->dev_root->track_dirty = 1;
 
 
-	ret = find_and_setup_root(root, fs_info, BTRFS_UUID_TREE_OBJECTID,
-				  fs_info->uuid_root);
+	ret = btrfs_find_and_setup_root(root, fs_info,
+					BTRFS_UUID_TREE_OBJECTID,
+					fs_info->uuid_root);
 	if (ret) {
 		free(fs_info->uuid_root);
 		fs_info->uuid_root = NULL;
@@ -1285,8 +1290,9 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		fs_info->uuid_root->track_dirty = 1;
 	}
 
-	ret = find_and_setup_root(root, fs_info, BTRFS_QUOTA_TREE_OBJECTID,
-				  fs_info->quota_root);
+	ret = btrfs_find_and_setup_root(root, fs_info,
+					BTRFS_QUOTA_TREE_OBJECTID,
+					fs_info->quota_root);
 	if (ret) {
 		free(fs_info->quota_root);
 		fs_info->quota_root = NULL;
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 6c8eaa2bd13d..2424060d705f 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -228,6 +228,9 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 			     struct btrfs_root *root);
+int btrfs_find_and_setup_root(struct btrfs_root *tree_root,
+			      struct btrfs_fs_info *fs_info,
+			      u64 objectid, struct btrfs_root *root);
 
 static inline struct btrfs_root *btrfs_block_group_root(
 						struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 5807b11a7b1a..4e8cf635b7e8 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1546,6 +1546,15 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 
+	/*
+	 * If we're doing convert and the bg is beyond our last converted bg,
+	 * it should go to the new root.
+	 */
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    BTRFS_SUPER_FLAG_CHANGING_BG_TREE &&
+	    cache->start >= fs_info->last_converted_bg_bytenr)
+		root = fs_info->block_group_root;
+
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = cache->length;
@@ -2726,33 +2735,99 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
+static int get_last_converted_bg(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_path path;
-	struct btrfs_root *root;
+	struct btrfs_root *bg_root = fs_info->block_group_root;
+	struct btrfs_path path = {0};
+	struct btrfs_key key = {0};
 	int ret;
+
+	/* Load the first bg in bg tree, that would be our last converted bg. */
+	ret = btrfs_search_slot(NULL, bg_root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	ASSERT(ret > 0);
+	/* We should always be at the slot 0 of the first leaf. */
+	ASSERT(path.slots[0] == 0);
+
+	/* Empty bg tree, no converted bg item at all. */
+	if (btrfs_header_nritems(path.nodes[0]) == 0) {
+		fs_info->last_converted_bg_bytenr = (u64)-1;
+		ret = 0;
+		goto out;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+	fs_info->last_converted_bg_bytenr = key.objectid;
+
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+/*
+ * Helper to read old block groups items from specified root.
+ *
+ * The difference between this and read_block_groups_from_root() is,
+ * we will exit if we have already read the last bg in the old root.
+ *
+ * This is to avoid wasting time finding bg items which should be in the
+ * new root.
+ */
+static int read_old_block_groups_from_root(struct btrfs_fs_info *fs_info,
+					   struct btrfs_root *root)
+{
+	struct btrfs_path path = {0};
 	struct btrfs_key key;
+	struct cache_extent *ce;
+	/* The last block group bytenr in the old root. */
+	u64 last_bg_in_old_root;
+	int ret;
+
+	if (fs_info->last_converted_bg_bytenr != (u64)-1) {
+		/*
+		 * We know the last converted bg in the other tree, load the chunk
+		 * before that last converted as our last bg in the tree.
+		 */
+		ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
+			         fs_info->last_converted_bg_bytenr);
+		if (!ce || ce->start != fs_info->last_converted_bg_bytenr) {
+			error("no chunk found for bytenr %llu",
+			      fs_info->last_converted_bg_bytenr);
+			return -ENOENT;
+		}
+		ce = prev_cache_extent(ce);
+		/*
+		 * We should have previous unconverted chunk, or we have
+		 * already finished the convert.
+		 */
+		ASSERT(ce);
+
+		last_bg_in_old_root = ce->start;
+	} else {
+		last_bg_in_old_root = (u64)-1;
+	}
 
-	root = btrfs_block_group_root(fs_info);
-	key.objectid = 0;
-	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	btrfs_init_path(&path);
 
-	while(1) {
+	while (true) {
 		ret = find_first_block_group(root, &path, &key);
 		if (ret > 0) {
 			ret = 0;
-			goto error;
+			goto out;
 		}
 		if (ret != 0) {
-			goto error;
+			goto out;
 		}
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 
 		ret = read_one_block_group(fs_info, &path);
 		if (ret < 0 && ret != -ENOENT)
-			goto error;
+			goto out;
+
+		/* We have reached last bg in the old root, no need to continue */
+		if (key.objectid >= last_bg_in_old_root)
+			break;
 
 		if (key.offset == 0)
 			key.objectid++;
@@ -2762,11 +2837,91 @@ int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 		btrfs_release_path(&path);
 	}
 	ret = 0;
-error:
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+/* Helper to read all block groups items from specified root. */
+static int read_block_groups_from_root(struct btrfs_fs_info *fs_info,
+					   struct btrfs_root *root)
+{
+	struct btrfs_path path = {0};
+	struct btrfs_key key = {0};
+	int ret;
+
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+
+	while (true) {
+		ret = find_first_block_group(root, &path, &key);
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+		if (ret != 0) {
+			goto out;
+		}
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+
+		ret = read_one_block_group(fs_info, &path);
+		if (ret < 0 && ret != -ENOENT)
+			goto out;
+
+		if (key.offset == 0)
+			key.objectid++;
+		else
+			key.objectid = key.objectid + key.offset;
+		key.offset = 0;
+		btrfs_release_path(&path);
+	}
+	ret = 0;
+out:
 	btrfs_release_path(&path);
 	return ret;
 }
 
+static int read_converting_block_groups(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *old_root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *new_root = btrfs_block_group_root(fs_info);
+	int ret;
+
+	/* Currently we only support converting to bg tree feature. */
+	ASSERT(!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE));
+
+	ret = get_last_converted_bg(fs_info);
+	if (ret < 0) {
+		error("failed to load the last converted bg: %d", ret);
+		return ret;
+	}
+
+	ret = read_old_block_groups_from_root(fs_info, old_root);
+	if (ret < 0) {
+		error("failed to load block groups from the old root: %d", ret);
+		return ret;
+	}
+
+	/* For block group items in the new tree, just read them all. */
+	ret = read_block_groups_from_root(fs_info, new_root);
+	if (ret < 0) {
+		error("failed to load block groups from the new root: %d", ret);
+		return ret;
+	}
+	return ret;
+}
+
+int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *root;
+
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    BTRFS_SUPER_FLAG_CHANGING_BG_TREE)
+		return read_converting_block_groups(fs_info);
+
+	root = btrfs_block_group_root(fs_info);
+	return read_block_groups_from_root(fs_info, root);
+}
+
 /*
  * For extent tree v2 we use the block_group_item->chunk_offset to point at our
  * global root id.  For v1 it's always set to BTRFS_FIRST_CHUNK_TREE_OBJECTID.
@@ -2834,6 +2989,15 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	key.offset = block_group->length;
 
 	root = btrfs_block_group_root(fs_info);
+	/*
+	 * If we're doing convert and the bg is beyond our last converted bg,
+	 * it should go to the new root.
+	 */
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    BTRFS_SUPER_FLAG_CHANGING_BG_TREE &&
+	    block_group->start >= fs_info->last_converted_bg_bytenr)
+		root = fs_info->block_group_root;
+
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
@@ -2958,6 +3122,15 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	key.offset = block_group->length;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 
+	/*
+	 * If we're doing convert and the bg is beyond our last converted bg,
+	 * it should go to the new root.
+	 */
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    BTRFS_SUPER_FLAG_CHANGING_BG_TREE &&
+	    block_group->start >= fs_info->last_converted_bg_bytenr)
+		root = fs_info->block_group_root;
+
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0)
 		ret = -ENOENT;
@@ -3849,3 +4022,53 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long nr)
 
 	return 0;
 }
+
+int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *new_root = fs_info->block_group_root;
+	struct btrfs_root *old_root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_block_group *bg;
+	struct btrfs_path path = {0};
+	int ret;
+
+	ASSERT(new_root);
+	ASSERT(old_root);
+	ASSERT(btrfs_super_flags(fs_info->super_copy) &
+	       BTRFS_SUPER_FLAG_CHANGING_BG_TREE);
+	/*
+	 * Only support converting to bg tree yet, thus the feature should not
+	 * be set.
+	 */
+	ASSERT(!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE));
+
+	bg = btrfs_lookup_block_group(fs_info, bytenr);
+	if (!bg) {
+		error("failed to find block group for bytenr %llu", bytenr);
+		return -ENOENT;
+	}
+	/*
+	 * Delete the block group item from the old tree first.
+	 * As we haven't yet update last_converted_bg_bytenr, the delete will
+	 * be done in the old tree.
+	 */
+	ret = remove_block_group_item(trans, &path, bg);
+	btrfs_release_path(&path);
+	if (ret < 0) {
+		error("failed to delete block group item from the old root: %d",
+		      ret);
+		return ret;
+	}
+	fs_info->last_converted_bg_bytenr = bytenr;
+	/*
+	 * Now last_converted_bg_bytenr is updated, the insert will happen for
+	 * the new root.
+	 */
+	ret = insert_block_group_item(trans, bg);
+	if (ret < 0) {
+		error("failed to insert block group item into the new root: %d",
+		      ret);
+		return ret;
+	}
+	return ret;
+}
-- 
2.37.0

