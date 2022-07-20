Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9E57B036
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 07:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiGTFH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 01:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiGTFHY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 01:07:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB266AC9
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 22:07:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7301D1F982
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 05:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658293642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmQLxf91ZcphZdxUWBC3uYYgj+yetkkzglScDsYgHXQ=;
        b=HzmmAwcH2/2a9gklnRDIg53PwbgIQNF8aUKznFZn5ZWLzTJZAU6Ur7Rjzrkz30JkRnvrdX
        hAr6hKJa3CY0/NZX6ufQwWX+H8pYIRn+cjfTfxC/gBtkePHfQyxkbLaWWzXc5dfgah7DTs
        e1SjprE8XiaPrpR3w15iBrjIXLz8zKQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5653813AA1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 05:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sE80CImN12KLIwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 05:07:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: don't save block group root into super block
Date:   Wed, 20 Jul 2022 13:07:00 +0800
Message-Id: <96a09ee46121228a55053d82c1bd90bc6973a636.1658293417.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658293417.git.wqu@suse.com>
References: <cover.1658293417.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 4db85b9dc7ed..7a1ff777f61b 100644
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
 
@@ -2392,17 +2387,6 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
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
 
@@ -2535,13 +2519,6 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
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
index 3fac429cf8a4..91d443755174 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1608,6 +1608,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 	if (objectid == BTRFS_UUID_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->uuid_root) ?
 			fs_info->uuid_root : ERR_PTR(-ENOENT);
+	if (objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->block_group_root) ?
+			fs_info->block_group_root : ERR_PTR(-ENOENT);
 	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
 		struct btrfs_root *root = btrfs_global_root(fs_info, &key);
 
@@ -2064,14 +2067,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
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
 
@@ -2613,10 +2609,24 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -2944,17 +2954,7 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
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
index 0bec10740ad3..8fab3b274957 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1912,14 +1912,6 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
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

