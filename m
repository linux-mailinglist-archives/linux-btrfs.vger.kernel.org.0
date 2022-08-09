Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C058D30B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 07:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiHIFCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 01:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiHIFCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 01:02:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141B1DA5B
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 22:02:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70F842023D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 05:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660021358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kkON57QwdYrxNsxsd9mNzSeKQ+gTjl4F8mw3GIzd70=;
        b=jMfafRhCDfCryWjHMYxaSKk+rSq279xhF9FCl+X0GHNXKh8anghhAFZJV7cZTRZE7ZVSQx
        osDN4fBofsvvwuSQp5nss9nlxoHXLZwqshP898M1JHLIZvqg+rz2kPRxSWCDbF2e/vZ+d/
        GOIihEFUBgAfNXPFXWK//7zmHUQbm38=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA66C13A9D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 05:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mLyPKm3q8WKaPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Aug 2022 05:02:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: don't save block group root into super block
Date:   Tue,  9 Aug 2022 13:02:17 +0800
Message-Id: <31b7ea04b0a278eb264fe7fe401b75ba6384c5ff.1660021230.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1660021230.git.wqu@suse.com>
References: <cover.1660021230.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 51c480439263..bdcf0e24882f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -280,14 +280,9 @@ struct btrfs_super_block {
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
 
@@ -2480,17 +2475,6 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
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
 
@@ -2623,13 +2607,6 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
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
index 6268dafeeb2d..0e280f84cb15 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1526,6 +1526,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 	if (objectid == BTRFS_UUID_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->uuid_root) ?
 			fs_info->uuid_root : ERR_PTR(-ENOENT);
+	if (objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->block_group_root) ?
+			fs_info->block_group_root : ERR_PTR(-ENOENT);
 	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
 		struct btrfs_root *root = btrfs_global_root(fs_info, &key);
 
@@ -1982,14 +1985,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
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
 
@@ -2531,10 +2527,24 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -2862,17 +2872,7 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
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
index 6e3b2cb6a04a..363e6e1d9d30 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1935,14 +1935,6 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
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

