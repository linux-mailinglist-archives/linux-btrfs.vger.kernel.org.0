Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53046573011
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiGMIGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMIGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 04:06:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF1E8DA4
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 01:06:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74B551F9D1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657699609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhRCUueunpWtV3TSyhHw/Jo4ULxOK9ohlNE1VqstwQ0=;
        b=VRWoI/9Jhv1KlaAhF4FOJsgmm1cM5YThVju2NLvRv5IIqC7fR00NRI8lxULjkMN5LEwNSI
        aMrZPVpI9sxcQ8S9/SZYPXvBcDD/kmEH5O53tYk4EvM4zid+nA/P9Kf9X8ppFxiaIXna13
        9DfqTtnYqEnTk/GXzOeqh8CLjvreGEg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C225413AAD
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aPQ6Ihh9zmISLgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:06:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: don't save block group root into super block
Date:   Wed, 13 Jul 2022 16:06:27 +0800
Message-Id: <ccb0779d99235b305b378e2012081eac605e5e55.1657699083.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657699083.git.wqu@suse.com>
References: <cover.1657699083.git.wqu@suse.com>
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
 fs/btrfs/block-rsv.c   |  1 +
 fs/btrfs/ctree.h       | 27 ++-------------------------
 fs/btrfs/disk-io.c     | 40 ++++++++++++++++++++--------------------
 fs/btrfs/transaction.c |  8 --------
 4 files changed, 23 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 06be0644dd37..6ce704d3bdd2 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -424,6 +424,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_CSUM_TREE_OBJECTID:
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
+	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aab..36efb1f4c9ff 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -288,14 +288,9 @@ struct btrfs_super_block {
 	/* the UUID written into btree blocks */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
-	/* Extent tree v2 */
-	__le64 block_group_root;
-	__le64 block_group_root_generation;
-	u8 block_group_root_level;
-
 	/* future expansion */
-	u8 reserved8[7];
-	__le64 reserved[25];
+	u8 reserved8[8];
+	__le64 reserved[27];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 
@@ -2389,17 +2384,6 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
 BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
 		   num_devices, 64);
 
-/*
- * For extent tree v2 we overload the extent root with the block group root, as
- * we will have multiple extent roots.
- */
-BTRFS_SETGET_STACK_FUNCS(backup_block_group_root, struct btrfs_root_backup,
-			 extent_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_gen, struct btrfs_root_backup,
-			 extent_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_level,
-			 struct btrfs_root_backup, extent_root_level, 8);
-
 /* struct btrfs_balance_item */
 BTRFS_SETGET_FUNCS(balance_flags, struct btrfs_balance_item, flags, 64);
 
@@ -2532,13 +2516,6 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
 BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root, struct btrfs_super_block,
-			 block_group_root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
-			 struct btrfs_super_block,
-			 block_group_root_generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level, struct btrfs_super_block,
-			 block_group_root_level, 8);
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 76835394a61b..f62371f5fcfc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1606,6 +1606,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 	if (objectid == BTRFS_UUID_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->uuid_root) ?
 			fs_info->uuid_root : ERR_PTR(-ENOENT);
+	if (objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->block_group_root) ?
+			fs_info->block_group_root : ERR_PTR(-ENOENT);
 	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
 		struct btrfs_root *root = btrfs_global_root(fs_info, &key);
 
@@ -2056,14 +2059,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
-		btrfs_set_backup_block_group_root(root_backup,
-					info->block_group_root->node->start);
-		btrfs_set_backup_block_group_root_gen(root_backup,
-			btrfs_header_generation(info->block_group_root->node));
-		btrfs_set_backup_block_group_root_level(root_backup,
-			btrfs_header_level(info->block_group_root->node));
-	} else {
+	if (!btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
@@ -2596,10 +2592,24 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	if (ret)
 		return ret;
 
-	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = 0;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		location.objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID;
+		root = btrfs_read_tree_root(tree_root, &location);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->block_group_root = root;
+		}
+	}
+
+	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
 		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
@@ -2927,17 +2937,7 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
 		btrfs_warn(fs_info, "couldn't read tree root");
 		return ret;
 	}
-
-	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
-		return 0;
-
-	bytenr = btrfs_super_block_group_root(sb);
-	gen = btrfs_super_block_group_root_generation(sb);
-	level = btrfs_super_block_group_root_level(sb);
-	ret = load_super_root(fs_info->block_group_root, bytenr, gen, level);
-	if (ret)
-		btrfs_warn(fs_info, "couldn't read block group root");
-	return ret;
+	return 0;
 }
 
 static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0a50d5746f6f..192f08c5a557 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1898,14 +1898,6 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
 		super->cache_generation = 0;
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
 		super->uuid_tree_generation = root_item->generation;
-
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
-		root_item = &fs_info->block_group_root->root_item;
-
-		super->block_group_root = root_item->bytenr;
-		super->block_group_root_generation = root_item->generation;
-		super->block_group_root_level = root_item->level;
-	}
 }
 
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
-- 
2.37.0

