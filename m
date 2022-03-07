Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9E34D0ABA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbiCGWOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343656AbiCGWOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:36 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF056772
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:40 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id bt3so14638324qtb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jrigeGAPz9SdZduHaJcsOilea0eirdqW2GdsZ8b9yoI=;
        b=uArTFNQiaTNcgeUgZFAiMyt06pZs6eQ1yweBI4/rU62eyNquiUAdPiEuCsHLjtrRB3
         ivuc/8npBBlIqXQLHcE/a2DGIN/gA0OlSOvDykWWVDgZw4mEs6xpcOhdNNJSoRZsyZ+K
         VPIcDH1gdCPlNuy1C1aBSWLCYTu/+HVXidZEinjOZFBKgriAKnbaNiuBf6EUtdc3t0Md
         psCIzGVLx61hiw7JopUOa3q9B8fEjf2NujONwXctwKC80LIJVzjdgKci1r0ffZPjdf93
         QmMY+oU5dkTkrsdv6gIlRTdhP9Z8XjGy1L7/w9P+DG7Fd9YUTXlzmWuTRsw20w9aaF+O
         V0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrigeGAPz9SdZduHaJcsOilea0eirdqW2GdsZ8b9yoI=;
        b=L6IzeHpcMa0gnW3LLdA2oxXpuV+8ubq8TOlDlqiu4qhN6l3Um5pOPgqTVXlzS4O9kc
         V7oWk8wMDmR8ro2lVzwX5HaPq2jlEfBWu6Usqr61T62cxWAV+sFdgjb8jOlo+Kmor+y2
         NJosJl3Y9Jq3HlDA/zGR0kKVgkUQh/SDERbqbTmgX1KHJncFcTSVslY6hk0HenuN3yYx
         k4w7KS9T/jZ/BSoReSSSky8ePRVqxRniGDn9GumX2foBH8dYfRPxkldLljopkOjPdtUi
         aA6CiYvun9keB1iYwsv05mT6rBKYwq9+AhKAd4sMS4bqDfBmBFb1WPvkPyD8C6cuTElf
         by9Q==
X-Gm-Message-State: AOAM533WgSks7KDilKSXiuBaDC/IDgZS5MGC6iv5XYvvxXZRXqaDI4/x
        HTA6UEpCmeFxVxukcNj/tZw7+0M0nBk3jgpe
X-Google-Smtp-Source: ABdhPJyKRKBWmIuW+3tJaxESLX7N8v7WIK1q00v/MmQc3QSKp+5E6rrgUCJJ1SiYuTMfLNPHUxN0MA==
X-Received: by 2002:ac8:7fcc:0:b0:2e0:684e:42cc with SMTP id b12-20020ac87fcc000000b002e0684e42ccmr5196819qtk.35.1646691219639;
        Mon, 07 Mar 2022 14:13:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b004b2d02f8a92sm6937238qkb.126.2022.03.07.14.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/15] btrfs-progs: mkfs: don't populate extent tree with extent tree v2
Date:   Mon,  7 Mar 2022 17:13:17 -0500
Message-Id: <3cd97dcb4c508a98c36b9e9ce870eccb5fc6f9f0.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have extent tree v2 set then we don't track metadata in the extent
tree, and we can skip creating these items at mkfs time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 201 +++++++++++++++++++++++++++-----------------------
 1 file changed, 110 insertions(+), 91 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 75680d03..2e13da17 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -232,6 +232,106 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 	return 0;
 }
 
+static int fill_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
+			    struct extent_buffer *buf, u64 bg_offset,
+			    u64 bg_size, u64 bg_used,
+			    const enum btrfs_mkfs_block *blocks, int blocks_nr)
+{
+	struct btrfs_extent_item *extent_item;
+	struct btrfs_disk_key disk_key;
+	u64 first_free, ref_root;
+	u32 nritems = 0, itemoff, item_size;
+	int i, ret, blk;
+	bool add_block_group = true;
+	bool skinny_metadata = !!(cfg->features &
+				  BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
+
+	first_free = BTRFS_SUPER_INFO_OFFSET + cfg->sectorsize * 2 - 1;
+	first_free &= ~((u64)cfg->sectorsize - 1);
+
+	/* create the items for the extent tree */
+	memset(buf->data + sizeof(struct btrfs_header), 0,
+		cfg->nodesize - sizeof(struct btrfs_header));
+	itemoff = cfg->leaf_data_size;
+	for (i = 0; i < blocks_nr; i++) {
+		blk = blocks[i];
+
+		/* Add the block group item for our temporary chunk. */
+		if (cfg->blocks[blk] > bg_offset && add_block_group) {
+			itemoff -= sizeof(struct btrfs_block_group_item);
+			write_block_group_item(buf, nritems, bg_offset, bg_size,
+					       bg_used,
+					       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
+					       itemoff);
+			add_block_group = false;
+			nritems++;
+		}
+
+		item_size = sizeof(struct btrfs_extent_item);
+		if (!skinny_metadata)
+			item_size += sizeof(struct btrfs_tree_block_info);
+
+		if (cfg->blocks[blk] < first_free) {
+			error("block[%d] below first free: %llu < %llu",
+					i, (unsigned long long)cfg->blocks[blk],
+					(unsigned long long)first_free);
+			return -EINVAL;
+		}
+		if (i > 0 && cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
+			error("blocks %d and %d in reverse order: %llu < %llu",
+				blk, blocks[i - 1],
+				(unsigned long long)cfg->blocks[blk],
+				(unsigned long long)cfg->blocks[blocks[i - 1]]);
+			return -EINVAL;
+		}
+
+		/* create extent item */
+		itemoff -= item_size;
+		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
+		if (skinny_metadata) {
+			btrfs_set_disk_key_type(&disk_key,
+						BTRFS_METADATA_ITEM_KEY);
+			btrfs_set_disk_key_offset(&disk_key, 0);
+		} else {
+			btrfs_set_disk_key_type(&disk_key,
+						BTRFS_EXTENT_ITEM_KEY);
+			btrfs_set_disk_key_offset(&disk_key, cfg->nodesize);
+		}
+		btrfs_set_item_key(buf, &disk_key, nritems);
+		btrfs_set_item_offset(buf, nritems, itemoff);
+		btrfs_set_item_size(buf, nritems, item_size);
+		extent_item = btrfs_item_ptr(buf, nritems,
+					     struct btrfs_extent_item);
+		btrfs_set_extent_refs(buf, extent_item, 1);
+		btrfs_set_extent_generation(buf, extent_item, 1);
+		btrfs_set_extent_flags(buf, extent_item,
+				       BTRFS_EXTENT_FLAG_TREE_BLOCK);
+		nritems++;
+
+		/* create extent ref */
+		ref_root = reference_root_table[blk];
+		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
+		btrfs_set_disk_key_offset(&disk_key, ref_root);
+		btrfs_set_disk_key_type(&disk_key, BTRFS_TREE_BLOCK_REF_KEY);
+		btrfs_set_item_key(buf, &disk_key, nritems);
+		btrfs_set_item_offset(buf, nritems, itemoff);
+		btrfs_set_item_size(buf, nritems, 0);
+		nritems++;
+	}
+	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
+	btrfs_set_header_owner(buf, BTRFS_EXTENT_TREE_OBJECTID);
+	btrfs_set_header_nritems(buf, nritems);
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
+			     cfg->csum_type);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_EXTENT_TREE], cfg->zone_size);
+	if (ret != cfg->nodesize)
+		ret = (ret < 0 ? -errno : -EIO);
+	else
+		ret = 0;
+	return ret;
+}
+
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
  *
@@ -258,7 +358,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	struct btrfs_super_block super;
 	struct extent_buffer *buf;
 	struct btrfs_disk_key disk_key;
-	struct btrfs_extent_item *extent_item;
 	struct btrfs_chunk *chunk;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_extent;
@@ -271,17 +370,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	int blk;
 	u32 itemoff;
 	u32 nritems = 0;
-	u64 first_free;
-	u64 ref_root;
 	u32 array_size;
 	u32 item_size;
 	u64 total_used = 0;
-	int skinny_metadata = !!(cfg->features &
-				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
-	bool add_block_group = true;
 	bool free_space_tree = !!(cfg->runtime_features &
 				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
 	bool extent_tree_v2 = !!(cfg->features &
@@ -294,7 +388,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (extent_tree_v2) {
 		blocks = extent_tree_v2_blocks;
 		blocks_nr = ARRAY_SIZE(extent_tree_v2_blocks);
-		add_block_group = false;
 	}
 
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
@@ -306,9 +399,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (!buf)
 		return -ENOMEM;
 
-	first_free = BTRFS_SUPER_INFO_OFFSET + cfg->sectorsize * 2 - 1;
-	first_free &= ~((u64)cfg->sectorsize - 1);
-
 	memset(&super, 0, sizeof(super));
 
 	num_bytes = (cfg->num_bytes / cfg->sectorsize) * cfg->sectorsize;
@@ -381,89 +471,18 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (ret < 0)
 		goto out;
 
-	/* create the items for the extent tree */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
-	nritems = 0;
-	itemoff = cfg->leaf_data_size;
-	for (i = 0; i < blocks_nr; i++) {
-		blk = blocks[i];
-
-		/* Add the block group item for our temporary chunk. */
-		if (cfg->blocks[blk] > system_group_offset && add_block_group) {
-			itemoff -= sizeof(struct btrfs_block_group_item);
-			write_block_group_item(buf, nritems,
-					       system_group_offset,
-					       system_group_size, total_used,
-					       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
-					       itemoff);
-			add_block_group = false;
-			nritems++;
-		}
-
-		item_size = sizeof(struct btrfs_extent_item);
-		if (!skinny_metadata)
-			item_size += sizeof(struct btrfs_tree_block_info);
-
-		if (cfg->blocks[blk] < first_free) {
-			error("block[%d] below first free: %llu < %llu",
-					i, (unsigned long long)cfg->blocks[blk],
-					(unsigned long long)first_free);
-			ret = -EINVAL;
+	if (extent_tree_v2) {
+		ret = btrfs_write_empty_tree(fd, cfg, buf,
+					     BTRFS_EXTENT_TREE_OBJECTID,
+					     cfg->blocks[MKFS_EXTENT_TREE]);
+		if (ret)
 			goto out;
-		}
-		if (i > 0 && cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
-			error("blocks %d and %d in reverse order: %llu < %llu",
-				blk, blocks[i - 1],
-				(unsigned long long)cfg->blocks[blk],
-				(unsigned long long)cfg->blocks[blocks[i - 1]]);
-			ret = -EINVAL;
+	} else {
+		ret = fill_extent_tree(fd, cfg, buf, system_group_offset,
+				       system_group_size, total_used, blocks,
+				       blocks_nr);
+		if (ret)
 			goto out;
-		}
-
-		/* create extent item */
-		itemoff -= item_size;
-		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
-		if (skinny_metadata) {
-			btrfs_set_disk_key_type(&disk_key,
-						BTRFS_METADATA_ITEM_KEY);
-			btrfs_set_disk_key_offset(&disk_key, 0);
-		} else {
-			btrfs_set_disk_key_type(&disk_key,
-						BTRFS_EXTENT_ITEM_KEY);
-			btrfs_set_disk_key_offset(&disk_key, cfg->nodesize);
-		}
-		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset(buf, nritems, itemoff);
-		btrfs_set_item_size(buf, nritems, item_size);
-		extent_item = btrfs_item_ptr(buf, nritems,
-					     struct btrfs_extent_item);
-		btrfs_set_extent_refs(buf, extent_item, 1);
-		btrfs_set_extent_generation(buf, extent_item, 1);
-		btrfs_set_extent_flags(buf, extent_item,
-				       BTRFS_EXTENT_FLAG_TREE_BLOCK);
-		nritems++;
-
-		/* create extent ref */
-		ref_root = reference_root_table[blk];
-		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
-		btrfs_set_disk_key_offset(&disk_key, ref_root);
-		btrfs_set_disk_key_type(&disk_key, BTRFS_TREE_BLOCK_REF_KEY);
-		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset(buf, nritems, itemoff);
-		btrfs_set_item_size(buf, nritems, 0);
-		nritems++;
-	}
-	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
-	btrfs_set_header_owner(buf, BTRFS_EXTENT_TREE_OBJECTID);
-	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
-			     cfg->csum_type);
-	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
-			   cfg->blocks[MKFS_EXTENT_TREE], cfg->zone_size);
-	if (ret != cfg->nodesize) {
-		ret = (ret < 0 ? -errno : -EIO);
-		goto out;
 	}
 
 	/* create the chunk tree */
-- 
2.26.3

