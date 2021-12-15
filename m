Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEB4762F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhLOUPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhLOUPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:13 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025B6C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:13 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id o17so23132734qtk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S2Hbgr7s6Yr4nNr3qbY3CRHfznuIsR11r9MrR1HkuDA=;
        b=i09f1Dr2IXRiqm7Xo1jehU6dvk/plOxQVYfTRsrgDxc1Yw8UMDGw/ct8IIUmKNANY7
         VEzO4jjbFw1Tk2hj0RyBRk0L9YxMsN4ePNSXUZyJbOKkiifUHut/cSiGlgKQ3XKFQo5t
         5EUhxiDw/hLKULPCuef1JZy1mXA2zFLw2yrCjn2wJhc7BNu2EmBeYwPaMtJa/NB4Yu2o
         rt9bJPoiNbSShVZgnAF5ibaBagTQ7TZCvqYRB5bX3W/2oazxxk5n9SHD8jfbaTSlk0H9
         VJzFAY7xybWD+6u4Q2ZBR95yt+clRB1Dg4iWN9BNUPi3O2d2R3mVPUbvU2KQymN6AvkG
         bu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2Hbgr7s6Yr4nNr3qbY3CRHfznuIsR11r9MrR1HkuDA=;
        b=hOwAvKTBcPxRzroFesVa3AoYYOG+vPl94YYKvdvTbTfRIyX8HMAHC4/W8EBKw7UHa6
         wpF+PiqHfbhxbHQ/ZlaCSzSB96HihpWxDEiDL8cn8p2+Cj53Nc4KwWjslN6VGMQ6Grtd
         8z0qlzoOhqURshZrGuoVIXEeMNZlhfVk2UGHnTc3B3eLDR5jvpBra05jcqOyq02CKQdP
         Vbd2n9iuAVv5m1066kxN8HawMu3s41RE7+xrFuzYydLspYkOrkDboKzmj8hHo/qXg5WJ
         Jed7YbKfKpo7MF8DfNANydcmpwvRTpGCxzn+UjOlxXe6Lp+f4+v98mBkkSuKPqcV2mTm
         vQdw==
X-Gm-Message-State: AOAM533ezSu8reilJgITFI4reVNFc7Xa+L9EsI63MnUWkr6secp/eklA
        Zsmx55t/2QM6cg663kygOyuz4PcAnL5UUA==
X-Google-Smtp-Source: ABdhPJw9hLHOxSpV5vc9Awj5qVM1nY6Re6Wn+xRS2IfR3NN/D+jymfYFKidPbsySKjhKcdBLe9kGKQ==
X-Received: by 2002:ac8:58cd:: with SMTP id u13mr14045370qta.426.1639599311868;
        Wed, 15 Dec 2021 12:15:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h11sm1588652qko.18.2021.12.15.12.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/15] btrfs-progs: mkfs: don't populate extent tree with extent tree v2
Date:   Wed, 15 Dec 2021 15:14:50 -0500
Message-Id: <6f989e8fa1c898707865feac6c3bee61376588b3.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have extent tree v2 set then we don't track metadata in the extent
tree, and we can skip creating these items at mkfs time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 207 +++++++++++++++++++++++++++-----------------------
 1 file changed, 113 insertions(+), 94 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index a4412a1f..e4435aaa 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -233,6 +233,109 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
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
+	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
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
+		btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
+				      itemoff);
+		btrfs_set_item_size(buf, btrfs_item_nr(nritems),
+				    item_size);
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
+		btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
+				      itemoff);
+		btrfs_set_item_size(buf, btrfs_item_nr(nritems), 0);
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
@@ -259,7 +362,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	struct btrfs_super_block super;
 	struct extent_buffer *buf;
 	struct btrfs_disk_key disk_key;
-	struct btrfs_extent_item *extent_item;
 	struct btrfs_chunk *chunk;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_extent;
@@ -272,17 +374,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
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
@@ -295,7 +392,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (extent_tree_v2) {
 		blocks = extent_tree_v2_blocks;
 		blocks_nr = ARRAY_SIZE(extent_tree_v2_blocks);
-		add_block_group = false;
 	}
 
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
@@ -307,9 +403,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (!buf)
 		return -ENOMEM;
 
-	first_free = BTRFS_SUPER_INFO_OFFSET + cfg->sectorsize * 2 - 1;
-	first_free &= ~((u64)cfg->sectorsize - 1);
-
 	memset(&super, 0, sizeof(super));
 
 	num_bytes = (cfg->num_bytes / cfg->sectorsize) * cfg->sectorsize;
@@ -390,92 +483,18 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (ret < 0)
 		goto out;
 
-	/* create the items for the extent tree */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
-	nritems = 0;
-	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
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
-		btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
-				      itemoff);
-		btrfs_set_item_size(buf, btrfs_item_nr(nritems),
-				    item_size);
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
-		btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
-				      itemoff);
-		btrfs_set_item_size(buf, btrfs_item_nr(nritems), 0);
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

