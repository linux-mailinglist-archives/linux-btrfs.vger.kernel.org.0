Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF32956D495
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 08:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiGKGVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 02:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKGVd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 02:21:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545AB167FC
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jul 2022 23:21:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0534A226B1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 06:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657520491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gtAl+nD01cPdijRDAngPlq3AZeK3B3ieswU3M1zxu+Y=;
        b=e8CJ6jGByq24gOX6oW0VJwnSFu6S/wX1gFj0bCtH2wqqsXlN/p0ZgZuh+0VXxZovAjeHUi
        0pQLAFJJmdUJsRCBVPQ/b9fbOhIv+q+dyLIQAi4my5jX85yixoPhZXYhFWNK6rA1e2GSMa
        PsPrqCjtc2fMM67s2T4RnhYDPnYqAyc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CDD613322
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 06:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d+JNOmnBy2K7cAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 06:21:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: don't save block group root into super block
Date:   Mon, 11 Jul 2022 14:21:12 +0800
Message-Id: <40ce67d5bbb8f9c471b3c9a33504b0bb4022a51b.1657520391.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

The extent tree v2 (both thankfully not yet fully materialized) needs a
new root for storing all block group items.

My initial proposal years just added a new tree rootid, and load it from
tree root, just like what we did for quota/free space tree/uuid/extent
roots.

But the extent tree v2 patches introduced a completely new (and to me,
wasteful) way to store block group tree root into super block.

Currently only two roots enjoying the privilege to stay in super blocks:
tree root and chunk root.

There is no special reason to store block group root into super block,
even performance wise it doesn't make sense.

So just move block group root from super block into tree root.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix a wrong check in btrfs_read_roots(), which makes us to read
  block group root when EXTENT_TREE_V2 is not enabled 
---
 fs/btrfs/block-rsv.c   |  1 +
 fs/btrfs/ctree.h       | 16 ++--------------
 fs/btrfs/disk-io.c     | 32 +++++++++++++++++++++-----------
 fs/btrfs/transaction.c |  8 --------
 4 files changed, 24 insertions(+), 33 deletions(-)

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
index 4e2569f84aab..2ffd8daaa26e 100644
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
 
@@ -2532,13 +2527,6 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
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
index 76835394a61b..470f6f4962e8 100644
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
 
@@ -2596,6 +2599,23 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	if (ret)
 		return ret;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		location.objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID;
+		location.type = BTRFS_ROOT_ITEM_KEY;
+		location.offset = 0;
+
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
 	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = 0;
@@ -2927,17 +2947,7 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
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
2.36.1

