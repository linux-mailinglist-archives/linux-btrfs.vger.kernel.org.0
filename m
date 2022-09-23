Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A215E74C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIWHXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiIWHXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 03:23:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A112B4A0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 00:23:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D5B71FA3E
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663917783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5nmfdDiqWaRfwz9wL0t28ZvPJHI6pwStjMLI+itzVxI=;
        b=ND3jn2GEynrRd1IYVeyTJN6TfxY0Yp6ZEStdhXPfivmxyTE4jceiH6Eh3DIomaK1xy8Wg8
        WduaX1e8WtJ9Xf38be7a9teHLCFAucV+KFGAYVekemsNMfaxe228dpdDNxT0Hvjk9sBv81
        ruArdqmaQmtn+NyBBBvZ7GAnqjhAfSI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6376713A00
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oiLECtZeLWNTaQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:23:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: btrfstune: add -B option to convert back to extent tree
Date:   Fri, 23 Sep 2022 15:22:44 +0800
Message-Id: <18c52a4ae1bb038beb16ad6d011d6dbe10321922.1663917740.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With previous btrfstune support to convert to block group tree, it has
implemented most of the infrastructure for bi-directional convert.

This patch will implement the remaining conversion support to go back to
extent tree.

The modification includes:

- New convert_to_extent_tree() function in btrfstune.c
  It's almost the same as convert_to_bg_tree(), but with small changes:
  * No need to set extra features like NO_HOLES/FST.
  * Need to delete the block group tree when everything finished.

- Update btrfs_delete_and_free_root() to handle non-global roots
  Currently the function can only accept global roots (extent/csum/free
  space trees)

  If we pass a non-global root into the function, we will screw up
  global_roots_tree and crash.

  Since we're going to use btrfs_delete_and_free_root() to free block
  group tree which is not a global tree, this is needed.

- New handling for half converted fs in get_last_converted_bg()
  There are two cases need to be handled:
  * The bg tree is already empty
    We need to grab the first bg in extent tree.
    Or at convertion function we will fail at grabbing the first bg.

  * The bg tree is not empty
    Then we need to grab the last bg in extent tree.

- Extra root switching in involved functions
  This involves:
  * read_converting_block_groups()
  * insert_block_group_item()
  * update_block_group_item()

  We just need to update our target root according to the current
  compat_ro and super flags.

- Various misc changes
  Like introducing the new getopt() option and help strings/docs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfstune.rst |   4 +
 btrfstune.c                 | 154 +++++++++++++++++++++++++++++++++++-
 kernel-shared/disk-io.c     |  11 ++-
 kernel-shared/extent-tree.c |  93 ++++++++++++++++++----
 4 files changed, 245 insertions(+), 17 deletions(-)

diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index 01c59d6dbf3b..be2a43750b16 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -29,6 +29,10 @@ OPTIONS
         Enable block group tree feature (greatly reduce mount time),
         enabled by mkfs feature *block-group-tree*.
 
+-B
+        Disable block group tree feature,
+        mostly for compatibility reasons.
+
 -f
         Allow dangerous changes, e.g. clear the seeding flag or change fsid.
         Make sure that you are aware of the dangers.
diff --git a/btrfstune.c b/btrfstune.c
index aa5fd7bc1d8a..85378f6b2aef 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -899,6 +899,127 @@ error:
 	return ret;
 }
 
+static int convert_to_extent_tree(struct btrfs_fs_info *fs_info)
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
+	/* We're resuming from previous run. */
+	if (btrfs_super_flags(sb) & BTRFS_SUPER_FLAG_CHANGING_BG_TREE)
+		goto iterate_bgs;
+
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
+	/* Now convert each block group. */
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
+	 * Remove block group tree, at this stage, the block group tree root
+	 * should be empty.
+	 */
+	ASSERT(btrfs_header_nritems(fs_info->block_group_root->node) == 0);
+	ret = btrfs_delete_and_free_root(trans, fs_info->block_group_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to remove bg tree: %m");
+		goto error;
+	}
+	fs_info->block_group_root = NULL;
+
+	/*
+	 * All bgs converted and bg tree removed, remove the CHANGING_BG flag
+	 * and remove the compat ro flag.
+	 */
+	fs_info->last_converted_bg_bytenr = 0;
+	btrfs_set_super_flags(sb,
+		btrfs_super_flags(sb) &
+		~BTRFS_SUPER_FLAG_CHANGING_BG_TREE);
+	btrfs_set_super_compat_ro_flags(sb,
+			btrfs_super_compat_ro_flags(sb) &
+			~BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE);
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		error("faield to commit the final transaction: %d", ret);
+		return ret;
+	}
+	printf("Converted the filesystem to traditional extent tree feature\n");
+	return 0;
+
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 static void print_usage(void)
 {
 	printf("usage: btrfstune [options] device\n");
@@ -906,6 +1027,7 @@ static void print_usage(void)
 	printf("Options:\n");
 	printf("  change feature status:\n");
 	printf("\t-b          enable block group tree (mkfs: block-group-tree, for less mount time)\n");
+	printf("\t-B          diskable block group tree (mkfs: ^block-group-tree)\n");
 	printf("\t-r          enable extended inode refs (mkfs: extref, for hardlink limits)\n");
 	printf("\t-x          enable skinny metadata extent refs (mkfs: skinny-metadata)\n");
 	printf("\t-n          enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)\n");
@@ -937,6 +1059,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	int random_fsid = 0;
 	int change_metadata_uuid = 0;
 	bool to_bg_tree = false;
+	bool to_extent_tree = false;
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
 	int ret;
@@ -953,7 +1076,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			{ NULL, 0, NULL, 0 }
 		};
 #if EXPERIMENTAL
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
+		int c = getopt_long(argc, argv, "S:rxfuU:nmM:bB", long_options, NULL);
 #else
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
 #endif
@@ -964,6 +1087,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case 'b':
 			to_bg_tree = true;
 			break;
+		case 'B':
+			to_extent_tree = true;
+			break;
 		case 'S':
 			seeding_flag = 1;
 			seeding_value = arg_strtou64(optarg);
@@ -1023,7 +1149,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
-	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree) {
+	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
+	    !to_extent_tree) {
 		error("at least one option should be specified");
 		print_usage();
 		return 1;
@@ -1070,6 +1197,11 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	if (to_bg_tree) {
+		if (to_extent_tree) {
+			error("-b option conflicts with -B option");
+			ret = 1;
+			goto out;
+		}
 		if (btrfs_fs_compat_ro(root->fs_info, BLOCK_GROUP_TREE)) {
 			error("the filesystem already has block group tree feature");
 			ret = 1;
@@ -1087,6 +1219,24 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		}
 		goto out;
 	}
+	if (to_extent_tree) {
+		if (to_bg_tree) {
+			error("-B option conflicts with -b option");
+			ret = 1;
+			goto out;
+		}
+		if (!btrfs_fs_compat_ro(root->fs_info, BLOCK_GROUP_TREE)) {
+			error("the filesystem doesn't has block group tree feature");
+			ret = 1;
+			goto out;
+		}
+		ret = convert_to_extent_tree(root->fs_info);
+		if (ret < 0) {
+			error("failed to convert the filesystem from block group tree feature");
+			goto out;
+		}
+		goto out;
+	}
 	if (seeding_flag) {
 		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
 			error("SEED flag cannot be changed on a metadata-uuid changed fs");
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 37bb22ed19f7..d20ee77d23ca 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2283,6 +2283,14 @@ int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
 	return set_extent_buffer_uptodate(eb);
 }
 
+static bool is_global_root(struct btrfs_root *root)
+{
+	if (root->root_key.objectid == BTRFS_EXTENT_TREE_OBJECTID ||
+	    root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID ||
+	    root->root_key.objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
+		return true;
+	return false;
+}
 int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
@@ -2301,7 +2309,8 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 	ret = btrfs_free_tree_block(trans, root, root->node, 0, 1);
 	if (ret)
 		return ret;
-	rb_erase(&root->rb_node, &fs_info->global_roots_tree);
+	if (is_global_root(root))
+		rb_erase(&root->rb_node, &fs_info->global_roots_tree);
 	free_extent_buffer(root->node);
 	free_extent_buffer(root->commit_root);
 	kfree(root);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index d04b57de8571..595c6ecde2a8 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1551,8 +1551,14 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	 */
 	if (btrfs_super_flags(fs_info->super_copy) &
 	    BTRFS_SUPER_FLAG_CHANGING_BG_TREE &&
-	    cache->start >= fs_info->last_converted_bg_bytenr)
-		root = fs_info->block_group_root;
+	    cache->start >= fs_info->last_converted_bg_bytenr) {
+		if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
+			/* Converting back to extent tree. */
+			root = btrfs_extent_root(fs_info, 0);
+		else
+			/* Convert to new bg tree.*/
+			root = fs_info->block_group_root;
+	}
 
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2741,6 +2747,57 @@ static int get_last_converted_bg(struct btrfs_fs_info *fs_info)
 	struct btrfs_key key = {0};
 	int ret;
 
+	/* Converting back to extent tree case. */
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+		struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
+
+		/* Load the first bg in bg tree. */
+		ret = btrfs_search_slot(NULL, bg_root, &key, &path, 0, 0);
+		if (ret < 0)
+			return ret;
+		ASSERT(ret > 0);
+		/* We should always be at the slot 0 of the first leaf. */
+		ASSERT(path.slots[0] == 0);
+
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+
+		/* Empty bg tree, all converted, then grab the first bg. */
+		if (btrfs_header_nritems(path.nodes[0]) == 0) {
+			btrfs_release_path(&path);
+			ret = find_first_block_group(extent_root, &path, &key);
+			/* We should have at least one bg item in extent tree. */
+			ASSERT(ret == 0);
+
+			btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+			fs_info->last_converted_bg_bytenr = key.objectid;
+			goto out;
+		}
+		btrfs_release_path(&path);
+
+		/* Grab the last bg in extent tree as the last converted one. */
+		key.objectid = (u64)-1;
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		key.offset = (u64)-1;
+
+		ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
+		if (ret < 0)
+			goto out;
+		ASSERT(ret > 0);
+		ret = btrfs_previous_item(extent_root, &path, 0,
+					  BTRFS_BLOCK_GROUP_ITEM_KEY);
+		if (ret < 0)
+			goto out;
+
+		/* No converted bg item in extent tree.*/
+		if (ret > 0) {
+			ret = 0;
+			fs_info->last_converted_bg_bytenr = (u64)-1;
+			goto out;
+		}
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		fs_info->last_converted_bg_bytenr = key.objectid;
+		goto out;
+	}
 	/* Load the first bg in bg tree, that would be our last converted bg. */
 	ret = btrfs_search_slot(NULL, bg_root, &key, &path, 0, 0);
 	if (ret < 0)
@@ -2758,7 +2815,6 @@ static int get_last_converted_bg(struct btrfs_fs_info *fs_info)
 	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
 	fs_info->last_converted_bg_bytenr = key.objectid;
-
 out:
 	btrfs_release_path(&path);
 	return ret;
@@ -2881,12 +2937,19 @@ out:
 
 static int read_converting_block_groups(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *old_root = btrfs_extent_root(fs_info, 0);
-	struct btrfs_root *new_root = btrfs_block_group_root(fs_info);
+	struct btrfs_root *old_root;
+	struct btrfs_root *new_root;
 	int ret;
 
-	/* Currently we only support converting to bg tree feature. */
-	ASSERT(!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE));
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+		/* Converting back to extent tree. */
+		old_root = fs_info->block_group_root;
+		new_root = btrfs_extent_root(fs_info, 0);
+	} else {
+		/* Converting to block group tree. */
+		old_root = btrfs_extent_root(fs_info, 0);
+		new_root = fs_info->block_group_root;
+	}
 
 	ret = get_last_converted_bg(fs_info);
 	if (ret < 0) {
@@ -2994,8 +3057,15 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	 */
 	if (btrfs_super_flags(fs_info->super_copy) &
 	    BTRFS_SUPER_FLAG_CHANGING_BG_TREE &&
-	    block_group->start >= fs_info->last_converted_bg_bytenr)
-		root = fs_info->block_group_root;
+	    block_group->start >= fs_info->last_converted_bg_bytenr) {
+		if (btrfs_super_compat_ro_flags(fs_info->super_copy) &
+		    BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
+			/* Converting to extent tree, return extent root. */
+			root = btrfs_extent_root(fs_info, block_group->start);
+		else
+			/* Converting to bg tree, return bg root. */
+			root = fs_info->block_group_root;
+	}
 
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
@@ -4032,11 +4102,6 @@ int btrfs_convert_one_bg(struct btrfs_trans_handle *trans, u64 bytenr)
 	ASSERT(fs_info->block_group_root && btrfs_extent_root(fs_info, 0));
 	ASSERT(btrfs_super_flags(fs_info->super_copy) &
 	       BTRFS_SUPER_FLAG_CHANGING_BG_TREE);
-	/*
-	 * Only support converting to bg tree yet, thus the feature should not
-	 * be set.
-	 */
-	ASSERT(!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE));
 
 	bg = btrfs_lookup_block_group(fs_info, bytenr);
 	if (!bg) {
-- 
2.37.3

