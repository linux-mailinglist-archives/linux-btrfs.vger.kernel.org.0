Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D33F51DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhHWUPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhHWUPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:42 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A85C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:14:59 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t4so6223583qkb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D+2jZRy7/aZMd3WdFd2lIGfMuqdFaSIxMjPxzmvi5UE=;
        b=VsS9YF7PQkQipxoYKjs+BuM4yI1VcT7R2IQv7Sh9sh12GcHl8QI1TJDCHUWOCWklpG
         Ov5sgkVqyFIp5LO51au3iE5L4MWhh7HIanXso0Lm1liMuFLpGlzEHVBZOghFetdVBbae
         tsqgnYRF7tyHv7FnKZeTEP7dS+u+ZpR11rL7AOj9py0fno9GCMRbmfzpJjl26j+d8S0A
         AHAsz4aFRTSVMMfWMFdJd2FGhQqxAurDxGC1G6cssnV4lfmuE5rnHclBVuvwCNOn9RAc
         OlgBBj+oqcnQl6Dba9hZ0KYicjXoUZJrx4MNHpscXnvhwYW0Gr/fhAsi6xjs+r1zm5VF
         cJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+2jZRy7/aZMd3WdFd2lIGfMuqdFaSIxMjPxzmvi5UE=;
        b=Ys9CwHAbgrsn4aZHfguABGmQmoboCzg5bzfZCMOXVPFIok89yKVceLj3zaN2re8xWb
         pN2QEvvzRVLB86Cb13ztX/EdJoHiLXab64pi+XIA4jdI3/jF3j71hS9099OmQD6Op7z1
         vkRWLuqy5InfIyQZVHSbLyfZk3qep1db4NxowxOk0izI0qyZl8E8TxqTJQxjybYhFJ4f
         2YQUz29r71qrWQfrO9wLSqI+Ny0vOGf3bV2v1XCR8w+TVWIgqCiedK+9u4Kt8liFz3EM
         +7VXmWYCCJa7yHB7laLfQLey5dg1ygWAcHTJ+gBzQS23itAdx8Mp9NouQQATJRz1V1xr
         ABoQ==
X-Gm-Message-State: AOAM530ibFfEVBfGDxq5HYkOZXnT/gfDbsSQi/BwUrFkBIq8WdwPxJWy
        Fx6dPZ8mpzq1lPZCBaRMBFM0H3/AiFMnmg==
X-Google-Smtp-Source: ABdhPJxivbI6ciYjpKM/7x6WIUuwRD7BFrlTboss++D+U33Qo13yY/fv7tGaeHzbUeDi0VYKEdfo2g==
X-Received: by 2002:a37:84c3:: with SMTP id g186mr22225847qkd.276.1629749698214;
        Mon, 23 Aug 2021 13:14:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h24sm1548374qtp.63.2021.08.23.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:14:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/10] btrfs-progs: mkfs: use an associative array for init blocks
Date:   Mon, 23 Aug 2021 16:14:46 -0400
Message-Id: <c3a3598c387f9a7637f3549527f23f0eec7df3e5.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Extent tree v2 will not create an extent tree or csum tree initially,
and it will create a block group tree.  To handle this we want to rework
the initial mkfs step to take an array of the blocks we want to create
and use the array to keep track of which blocks we need to create.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 53 ++++++++++++++++++++++++++++++++-------------------
 mkfs/common.h | 10 ++++++++++
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 2c041224..35ee4bff 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -31,16 +31,18 @@
 #include "mkfs/common.h"
 
 static u64 reference_root_table[] = {
-	[1] =	BTRFS_ROOT_TREE_OBJECTID,
-	[2] =	BTRFS_EXTENT_TREE_OBJECTID,
-	[3] =	BTRFS_CHUNK_TREE_OBJECTID,
-	[4] =	BTRFS_DEV_TREE_OBJECTID,
-	[5] =	BTRFS_FS_TREE_OBJECTID,
-	[6] =	BTRFS_CSUM_TREE_OBJECTID,
+	[MKFS_ROOT_TREE]	=	BTRFS_ROOT_TREE_OBJECTID,
+	[MKFS_EXTENT_TREE]	=	BTRFS_EXTENT_TREE_OBJECTID,
+	[MKFS_CHUNK_TREE]	=	BTRFS_CHUNK_TREE_OBJECTID,
+	[MKFS_DEV_TREE]		=	BTRFS_DEV_TREE_OBJECTID,
+	[MKFS_FS_TREE]		=	BTRFS_FS_TREE_OBJECTID,
+	[MKFS_CSUM_TREE]	=	BTRFS_CSUM_TREE_OBJECTID,
 };
 
 static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
-			struct extent_buffer *buf)
+				  struct extent_buffer *buf,
+				  const enum btrfs_mkfs_block *blocks,
+				  int blocks_nr)
 {
 	struct btrfs_root_item root_item;
 	struct btrfs_inode_item *inode_item;
@@ -49,6 +51,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	u32 itemoff;
 	int ret = 0;
 	int blk;
+	int i;
 	u8 uuid[BTRFS_UUID_SIZE];
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
@@ -71,7 +74,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_disk_key_offset(&disk_key, 0);
 	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) - sizeof(root_item);
 
-	for (blk = 0; blk < MKFS_BLOCK_COUNT; blk++) {
+	for (i = 0; i < blocks_nr; i++) {
+		blk = blocks[i];
 		if (blk == MKFS_SUPER_BLOCK || blk == MKFS_ROOT_TREE
 		    || blk == MKFS_CHUNK_TREE)
 			continue;
@@ -145,10 +149,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	struct btrfs_chunk *chunk;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_extent;
+	const enum btrfs_mkfs_block *blocks = extent_tree_v1_blocks;
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	u8 *ptr;
 	int i;
 	int ret;
+	int blocks_nr = ARRAY_SIZE(extent_tree_v1_blocks);
+	int blk;
 	u32 itemoff;
 	u32 nritems = 0;
 	u64 first_free;
@@ -195,7 +202,10 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	uuid_generate(chunk_tree_uuid);
 
 	cfg->blocks[MKFS_SUPER_BLOCK] = BTRFS_SUPER_INFO_OFFSET;
-	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
+	for (i = 0; i < blocks_nr; i++) {
+		blk = blocks[i];
+		if (blk == MKFS_SUPER_BLOCK)
+			continue;
 		cfg->blocks[i] = system_group_offset + cfg->nodesize * (i - 1);
 	}
 
@@ -236,7 +246,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			    btrfs_header_chunk_tree_uuid(buf),
 			    BTRFS_UUID_SIZE);
 
-	ret = btrfs_create_tree_root(fd, cfg, buf);
+	ret = btrfs_create_tree_root(fd, cfg, buf, blocks, blocks_nr);
 	if (ret < 0)
 		goto out;
 
@@ -245,30 +255,33 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		cfg->nodesize - sizeof(struct btrfs_header));
 	nritems = 0;
 	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
-	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
+	for (i = 0; i < blocks_nr; i++) {
+		blk = blocks[i];
+		if (blk == MKFS_SUPER_BLOCK)
+			continue;
 		item_size = sizeof(struct btrfs_extent_item);
 		if (!skinny_metadata)
 			item_size += sizeof(struct btrfs_tree_block_info);
 
-		if (cfg->blocks[i] < first_free) {
+		if (cfg->blocks[blk] < first_free) {
 			error("block[%d] below first free: %llu < %llu",
-					i, (unsigned long long)cfg->blocks[i],
+					i, (unsigned long long)cfg->blocks[blk],
 					(unsigned long long)first_free);
 			ret = -EINVAL;
 			goto out;
 		}
-		if (cfg->blocks[i] < cfg->blocks[i - 1]) {
+		if (cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
 			error("blocks %d and %d in reverse order: %llu < %llu",
-				i, i - 1,
-				(unsigned long long)cfg->blocks[i],
-				(unsigned long long)cfg->blocks[i - 1]);
+				blk, blocks[i - 1],
+				(unsigned long long)cfg->blocks[blk],
+				(unsigned long long)cfg->blocks[blocks[i - 1]]);
 			ret = -EINVAL;
 			goto out;
 		}
 
 		/* create extent item */
 		itemoff -= item_size;
-		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[i]);
+		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
 		if (skinny_metadata) {
 			btrfs_set_disk_key_type(&disk_key,
 						BTRFS_METADATA_ITEM_KEY);
@@ -292,8 +305,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		nritems++;
 
 		/* create extent ref */
-		ref_root = reference_root_table[i];
-		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[i]);
+		ref_root = reference_root_table[blk];
+		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
 		btrfs_set_disk_key_offset(&disk_key, ref_root);
 		btrfs_set_disk_key_type(&disk_key, BTRFS_TREE_BLOCK_REF_KEY);
 		btrfs_set_item_key(buf, &disk_key, nritems);
diff --git a/mkfs/common.h b/mkfs/common.h
index ea87c3ca..378da6bd 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -55,6 +55,16 @@ enum btrfs_mkfs_block {
 	MKFS_BLOCK_COUNT
 };
 
+static const enum btrfs_mkfs_block extent_tree_v1_blocks[] = {
+	MKFS_SUPER_BLOCK,
+	MKFS_ROOT_TREE,
+	MKFS_EXTENT_TREE,
+	MKFS_CHUNK_TREE,
+	MKFS_DEV_TREE,
+	MKFS_FS_TREE,
+	MKFS_CSUM_TREE,
+};
+
 struct btrfs_mkfs_config {
 	/* Label of the new filesystem */
 	const char *label;
-- 
2.26.3

