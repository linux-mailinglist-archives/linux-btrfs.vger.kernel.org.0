Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0D58D386
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 08:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiHIGET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 02:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiHIGER (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 02:04:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0601F619
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 23:04:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BAAB1F9C0
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660025055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+p4zM/yWzimBQZDcxi6K0U/bstBnvAloS71lIG8jOc=;
        b=ffeiGouEAet4SA9S+gjYDVlmL8Y6RFUx2li6OML+3+ygCYgyGFC+MN1YqRX2y6fbag2mLu
        fE/AL4AtNYpeRm6cTNP5FHz2dmM4wLBkyQipEmgLlu/0GdM+epuMAsIxv94I0zSbm43xhp
        yIltRoJ9roU/vCy7i51dj87Wv8qcOEk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B76213AA1
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 06:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UFwNGd748WJTVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Aug 2022 06:04:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/5] btrfs-progs: mkfs: dynamically modify mkfs blocks array
Date:   Tue,  9 Aug 2022 14:03:51 +0800
Message-Id: <febf59c659d2fd8922d6e6a16c6ac63e34a0d850.1660024949.git.wqu@suse.com>
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

In mkfs_btrfs(), we have a btrfs_mkfs_block array to store how many tree
blocks we need to reserve for the initial btrfs image.

Currently we have two very similar arrays, extent_tree_v1_blocks and
extent_tree_v2_blocks.

The only difference is just v2 has an extra block for block group tree.

This patch will add two helpers, mkfs_blocks_add() and
mkfs_blocks_remove() to properly add/remove one block dynamically from
the array.

This allows 3 things:

- Merge extent_tree_v1_blocks and extent_tree_v2_blocks into one array
  The new array will be the same as extent_tree_v1_blocks.
  For extent-tree-v2, we just dynamically add MKFS_BLOCK_GROUP_TREE.

- Remove free space tree block on-demand
  This only works for extent-tree-v1 case, as v2 has a hard requirement
  on free space tree.
  But this still make code much cleaner, not doing any special hacks.

- Allow future expansion without introduce new array
  I strongly doubt why this is not properly done in extent-tree-v2
  preparation patches.
  We should not allow bad practice to sneak in just because it's some
  preparation patches for a larger feature.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
 mkfs/common.h | 20 +++-----------
 2 files changed, 69 insertions(+), 24 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 218854491c14..d5a49ca11cde 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -260,6 +260,60 @@ next:
 	__builtin_unreachable();
 }
 
+/*
+ * Add @block into the @blocks array.
+ *
+ * The @blocks should already be in ascending order and no duplicate.
+ */
+static void mkfs_blocks_add(enum btrfs_mkfs_block *blocks, int *blocks_nr,
+			    enum btrfs_mkfs_block to_add)
+{
+	int i;
+
+	for (i = 0; i < *blocks_nr; i++) {
+		/* The target is already in the array. */
+		if (blocks[i] == to_add)
+			return;
+
+		/*
+		 * We find the first one past @to_add, move the array one slot
+		 * right, insert a new one.
+		 */
+		if (blocks[i] > to_add) {
+			memmove(blocks + i + 1, blocks + i, *blocks_nr - i);
+			blocks[i] = to_add;
+			(*blocks_nr)++;
+			return;
+		}
+		/* Current one still smaller than @to_add, go to next slot. */
+	}
+	/* All slots iterated and not match, insert into the last slot. */
+	blocks[i] = to_add;
+	(*blocks_nr)++;
+	return;
+}
+
+/*
+ * Remove @block from the @blocks array.
+ *
+ * The @blocks should already be in ascending order and no duplicate.
+ */
+static void mkfs_blocks_remove(enum btrfs_mkfs_block *blocks, int *blocks_nr,
+			       enum btrfs_mkfs_block to_remove)
+{
+	int i;
+
+	for (i = 0; i < *blocks_nr; i++) {
+		/* Found the target, move the array one slot left. */
+		if (blocks[i] == to_remove) {
+			memmove(blocks + i, blocks + i + 1, *blocks_nr - i - 1);
+			(*blocks_nr)--;
+		}
+	}
+	/* Nothing found, exit directly. */
+	return;
+}
+
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
  *
@@ -290,12 +344,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	struct btrfs_chunk *chunk;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_extent;
-	const enum btrfs_mkfs_block *blocks = extent_tree_v1_blocks;
+	enum btrfs_mkfs_block blocks[MKFS_BLOCK_COUNT];
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	u8 *ptr;
 	int i;
 	int ret;
-	int blocks_nr = ARRAY_SIZE(extent_tree_v1_blocks);
+	int blocks_nr;
 	int blk;
 	u32 itemoff;
 	u32 nritems = 0;
@@ -315,16 +369,21 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	bool extent_tree_v2 = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 
-	/* Don't include the free space tree in the blocks to process. */
-	if (!free_space_tree)
-		blocks_nr--;
+	memcpy(blocks, default_blocks,
+	       sizeof(enum btrfs_mkfs_block) * ARRAY_SIZE(default_blocks));
+	blocks_nr = ARRAY_SIZE(default_blocks);
 
+	/* Extent tree v2 needs an extra block for block group tree.*/
 	if (extent_tree_v2) {
-		blocks = extent_tree_v2_blocks;
-		blocks_nr = ARRAY_SIZE(extent_tree_v2_blocks);
+		mkfs_blocks_add(blocks, &blocks_nr, MKFS_BLOCK_GROUP_TREE);
 		add_block_group = false;
 	}
 
+	/* Don't include the free space tree in the blocks to process. */
+	if (!free_space_tree)
+		mkfs_blocks_remove(blocks, &blocks_nr, MKFS_FREE_SPACE_TREE);
+
+
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
 		system_group_offset = zoned_system_group_offset(cfg->zone_size);
 		system_group_size = cfg->zone_size;
diff --git a/mkfs/common.h b/mkfs/common.h
index 3533e114e81c..47b14cdae2f3 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -52,25 +52,12 @@ enum btrfs_mkfs_block {
 	MKFS_CSUM_TREE,
 	MKFS_FREE_SPACE_TREE,
 	MKFS_BLOCK_GROUP_TREE,
-	MKFS_BLOCK_COUNT
-};
-
-static const enum btrfs_mkfs_block extent_tree_v1_blocks[] = {
-	MKFS_ROOT_TREE,
-	MKFS_EXTENT_TREE,
-	MKFS_CHUNK_TREE,
-	MKFS_DEV_TREE,
-	MKFS_FS_TREE,
-	MKFS_CSUM_TREE,
 
-	/*
-	 * Since the free space tree is optional with v1 it must always be last
-	 * in this array.
-	 */
-	MKFS_FREE_SPACE_TREE,
+	/* MKFS_BLOCK_COUNT should be the max blocks we can have at mkfs time. */
+	MKFS_BLOCK_COUNT
 };
 
-static const enum btrfs_mkfs_block extent_tree_v2_blocks[] = {
+static const enum btrfs_mkfs_block default_blocks[] = {
 	MKFS_ROOT_TREE,
 	MKFS_EXTENT_TREE,
 	MKFS_CHUNK_TREE,
@@ -78,7 +65,6 @@ static const enum btrfs_mkfs_block extent_tree_v2_blocks[] = {
 	MKFS_FS_TREE,
 	MKFS_CSUM_TREE,
 	MKFS_FREE_SPACE_TREE,
-	MKFS_BLOCK_GROUP_TREE,
 };
 
 struct btrfs_mkfs_config {
-- 
2.37.0

