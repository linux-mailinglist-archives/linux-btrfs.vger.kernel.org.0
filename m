Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBEC58495D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiG2Bkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 21:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiG2Bkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 21:40:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E553F1AF31
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 18:40:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DDDD1206BB
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659058834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zei6QOEl9asGeAuNGsZeCsNS2NGrshNK5kvYybTlNMM=;
        b=Iral3+rPt4ID95ppMmFC0LlZ1ZTwon7LDI3cv1h6+8FELJfxBoSzMHITJuV1FFvBl7Ntja
        0F135yXIGxQdCGUMirXpf8pChM8NpLwLM0KUR488PeA0gM3yy9s6U4P9tjUIP7jbjx0L1c
        jbaHqFfevsKICM4oESnB5RBPKblo210=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55195133A6
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 01:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iLQ7CpI642I5QgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 01:40:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs-progs: don't save block group root into super block
Date:   Fri, 29 Jul 2022 09:40:13 +0800
Message-Id: <9cb9b430afb99e55bd9c5b57cfb062fbaafd9c99.1659058423.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659058423.git.wqu@suse.com>
References: <cover.1659058423.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent tree v2 (thankfully not yet fully materialized) needs a
new root for storing all block group items.

My initial proposal years ago just added a new tree rootid, and load it
from tree root, just like what we did for quota/free space tree/uuid/extent
roots.

But the extent tree v2 patches introduced a completely new (and to me,
wasteful) way to store block group tree root into super block.

Currently there are only 3 trees stored in super blocks, and they all
have their valid reasons:

- Chunk root
  Needed for bootstrap.

- Tree root
  Really the entrance of all trees.

- Log root
  This is special as log root has to be updated out of existing
  transaction mechanism.

There is not even any reason to put block group root into super blocks,
the block group tree is updated at the same timing as old extent tree,
no need for extra bootstrap/out-of-transaction update.

So just move block group root from super block into tree root.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect-dump-tree.c   | 11 ------
 kernel-shared/ctree.h      | 26 +------------
 kernel-shared/disk-io.c    | 75 ++++++++------------------------------
 kernel-shared/print-tree.c |  6 ---
 mkfs/common.c              | 11 ++----
 5 files changed, 20 insertions(+), 109 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 73ffd57eb13d..6374f137f7fb 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -517,11 +517,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 				       info->log_root_tree->node->start,
 					btrfs_header_level(
 						info->log_root_tree->node));
-			if (info->block_group_root)
-				printf("block group tree: %llu level %d\n",
-				       info->block_group_root->node->start,
-					btrfs_header_level(
-						info->block_group_root->node));
 		} else {
 			if (info->tree_root->node) {
 				printf("root tree\n");
@@ -540,12 +535,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 				btrfs_print_tree(info->log_root_tree->node,
 					BTRFS_PRINT_TREE_FOLLOW | print_mode);
 			}
-
-			if (info->block_group_root) {
-				printf("block group tree\n");
-				btrfs_print_tree(info->block_group_root->node,
-					BTRFS_PRINT_TREE_FOLLOW | print_mode);
-			}
 		}
 	}
 	tree_root_scan = info->tree_root;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index fc8b61eda829..c12076202577 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -457,13 +457,7 @@ struct btrfs_super_block {
 
 	__le64 nr_global_roots;
 
-	__le64 block_group_root;
-	__le64 block_group_root_generation;
-	u8 block_group_root_level;
-
-	/* future expansion */
-	u8 reserved8[7];
-	__le64 reserved[24];
+	__le64 reserved[27];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 	/* Padded to 4096 bytes */
@@ -2304,17 +2298,6 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
 BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
 		   num_devices, 64);
 
-/*
- * Extent tree v2 doesn't have a global csum or extent root, so we use the
- * extent root slot for the block group root.
- */
-BTRFS_SETGET_STACK_FUNCS(backup_block_group_root, struct btrfs_root_backup,
-		   extent_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_gen, struct btrfs_root_backup,
-		   extent_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_level, struct btrfs_root_backup,
-		   extent_root_level, 8);
-
 /* struct btrfs_super_block */
 
 BTRFS_SETGET_STACK_FUNCS(super_bytenr, struct btrfs_super_block, bytenr, 64);
@@ -2365,13 +2348,6 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
 BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root, struct btrfs_super_block,
-			 block_group_root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
-			 struct btrfs_super_block,
-			 block_group_root_generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level,
-			 struct btrfs_super_block, block_group_root_level, 8);
 BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
 			 nr_global_roots, 64);
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 26b1c9aa192a..80db5976cc3f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1209,33 +1209,9 @@ static int load_important_roots(struct btrfs_fs_info *fs_info,
 		goto tree_root;
 	}
 
-	if (backup) {
-		bytenr = btrfs_backup_block_group_root(backup);
-		gen = btrfs_backup_block_group_root_gen(backup);
-		level = btrfs_backup_block_group_root_level(backup);
-	} else {
-		bytenr = btrfs_super_block_group_root(sb);
-		gen = btrfs_super_block_group_root_generation(sb);
-		level = btrfs_super_block_group_root_level(sb);
-	}
 	root = fs_info->block_group_root;
 	btrfs_setup_root(root, fs_info, BTRFS_BLOCK_GROUP_TREE_OBJECTID);
 
-	ret = read_root_node(fs_info, root, bytenr, gen, level);
-	if (ret) {
-		fprintf(stderr, "Couldn't read block group root\n");
-		return -EIO;
-	}
-
-	if (maybe_load_block_groups(fs_info, flags)) {
-		int ret = btrfs_read_block_groups(fs_info);
-		if (ret < 0 && ret != -ENOENT) {
-			errno = -ret;
-			error("failed to read block groups: %m");
-			return ret;
-		}
-	}
-
 tree_root:
 	if (backup) {
 		bytenr = btrfs_backup_tree_root(backup);
@@ -1280,6 +1256,17 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	if (ret)
 		return ret;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		ret = find_and_setup_root(root, fs_info,
+				BTRFS_BLOCK_GROUP_TREE_OBJECTID,
+				fs_info->block_group_root);
+		if (ret) {
+			error("Couldn't load block group tree\n");
+			return -EIO;
+		}
+		fs_info->block_group_root->track_dirty = 1;
+	}
+
 	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
 				  fs_info->dev_root);
 	if (ret) {
@@ -1288,6 +1275,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	}
 	fs_info->dev_root->track_dirty = 1;
 
+
 	ret = find_and_setup_root(root, fs_info, BTRFS_UUID_TREE_OBJECTID,
 				  fs_info->uuid_root);
 	if (ret) {
@@ -1313,8 +1301,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 			return -EIO;
 	}
 
-	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2) &&
-	    maybe_load_block_groups(fs_info, flags)) {
+	if (maybe_load_block_groups(fs_info, flags)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
 		 * If we don't find any blockgroups (ENOENT) we're either
@@ -1834,20 +1821,6 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		goto error_out;
 	}
 
-	if (btrfs_super_incompat_flags(sb) & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
-		if (btrfs_super_block_group_root_level(sb) >= BTRFS_MAX_LEVEL) {
-			error("block_group_root level too big: %d >= %d",
-			      btrfs_super_block_group_root_level(sb),
-			      BTRFS_MAX_LEVEL);
-			goto error_out;
-		}
-		if (!IS_ALIGNED(btrfs_super_block_group_root(sb), 4096)) {
-			error("block_group_root block unaligned: %llu",
-			      btrfs_super_block_group_root(sb));
-			goto error_out;
-		}
-	}
-
 	if (btrfs_super_incompat_flags(sb) & BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
 		metadata_uuid = sb->metadata_uuid;
 	else
@@ -2165,16 +2138,9 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_num_devices(root_backup,
 			     btrfs_super_num_devices(info->super_copy));
 
-	if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
-		btrfs_set_backup_block_group_root(root_backup,
-				info->block_group_root->node->start);
-		btrfs_set_backup_block_group_root_gen(root_backup,
-			btrfs_header_generation(info->block_group_root->node));
-		btrfs_set_backup_block_group_root_level(root_backup,
-			btrfs_header_level(info->block_group_root->node));
-	} else {
-		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
+	if (!btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
+		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
 		btrfs_set_backup_csum_root_gen(root_backup,
@@ -2235,7 +2201,7 @@ int write_ctree_super(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
-	struct btrfs_root *block_group_root = fs_info->block_group_root;
+
 	if (fs_info->readonly)
 		return 0;
 
@@ -2252,15 +2218,6 @@ int write_ctree_super(struct btrfs_trans_handle *trans)
 	btrfs_set_super_chunk_root_generation(fs_info->super_copy,
 				btrfs_header_generation(chunk_root->node));
 
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
-		btrfs_set_super_block_group_root(fs_info->super_copy,
-						 block_group_root->node->start);
-		btrfs_set_super_block_group_root_generation(fs_info->super_copy,
-				btrfs_header_generation(block_group_root->node));
-		btrfs_set_super_block_group_root_level(fs_info->super_copy,
-				btrfs_header_level(block_group_root->node));
-	}
-
 	ret = write_all_supers(fs_info);
 	if (ret)
 		fprintf(stderr, "failed to write new super block err %d\n", ret);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a5886ff602ee..bffe30b405c7 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -2046,12 +2046,6 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	       (unsigned long long)btrfs_super_cache_generation(sb));
 	printf("uuid_tree_generation\t%llu\n",
 	       (unsigned long long)btrfs_super_uuid_tree_generation(sb));
-	printf("block_group_root\t%llu\n",
-	       (unsigned long long)btrfs_super_block_group_root(sb));
-	printf("block_group_root_generation\t%llu\n",
-	       (unsigned long long)btrfs_super_block_group_root_generation(sb));
-	printf("block_group_root_level\t%llu\n",
-	       (unsigned long long)btrfs_super_block_group_root_level(sb));
 
 	uuid_unparse(sb->dev_item.uuid, buf);
 	printf("dev_item.uuid\t\t%s\n", buf);
diff --git a/mkfs/common.c b/mkfs/common.c
index d5a49ca11cde..b72338551dfb 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -98,8 +98,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
-		if (blk == MKFS_ROOT_TREE || blk == MKFS_CHUNK_TREE ||
-		    blk == MKFS_BLOCK_GROUP_TREE)
+		if (blk == MKFS_ROOT_TREE || blk == MKFS_CHUNK_TREE)
 			continue;
 
 		btrfs_set_root_bytenr(&root_item, cfg->blocks[blk]);
@@ -440,13 +439,9 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_super_compat_ro_flags(&super, ro_flags);
 		btrfs_set_super_cache_generation(&super, 0);
 	}
-	if (extent_tree_v2) {
+	if (extent_tree_v2)
 		btrfs_set_super_nr_global_roots(&super, 1);
-		btrfs_set_super_block_group_root(&super,
-						 cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
-		btrfs_set_super_block_group_root_generation(&super, 1);
-		btrfs_set_super_block_group_root_level(&super, 0);
-	}
+
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
-- 
2.37.0

