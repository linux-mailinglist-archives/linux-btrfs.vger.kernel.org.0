Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0817E3F3456
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbhHTTMk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhHTTMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:39 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170AC061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:01 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l24so8287050qtj.4
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hx1l4ALZ+Xap7GPz8G/7/S3A2lH9sZf9TWYwp0yM9aU=;
        b=KohK2ktexaEsYblgKx2oY4BcIdLS4HRrEkNSlnSBMCMm2CruwhOy4YC19VfSicJPY7
         9f02W5gMGOi1WD+19RRdGtYuPqoj5BhpeGb/jnnAYAVtpykN9EnK3I4xg7DJESdNXf0A
         QLi4NcJ2ODvPIu3VMeWrSlFaag7U7ZZgaXLIM8qA791DNeYEQiLIWRf5AmKwlvD7UN3v
         8p5n37yYHGFtGDgdAmbbeRl8WHtE3s8lKzvE7ndQ6mcQBrIzHCZWUqY3yiqDg9pH5sAE
         NXuy5vGQeik7wW4QsYLQCapBRXHXrmtSnm/Voczy5Iq647zWIbtNsqZ7wOh//vnUqRZw
         PGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hx1l4ALZ+Xap7GPz8G/7/S3A2lH9sZf9TWYwp0yM9aU=;
        b=Slixt0ihpjIXUNs3p0kJS8g5UIYmxxibJju9uabVrsYVewXmrezyLvFlmCFyM96yl4
         o6YZDOk7/vEz4whOY2DML+1mh4fThhp1fW6hUKRmYlqIaU1oun5PRBoO1CrklH3nzytQ
         4Y3KKTQhgOXtQVs+95WPVGcMIAvW0Lh2YPnalsv9xd2L7p8dxcQ2EbljneUwx620CjRc
         TWdTsDXvPq8KyF7ficVpzruKHkmFgyq6su2akuIH2v6RcRtGq+jdT3eEjriQNIeUL7RK
         eVF48AWSGmFIse873jSdpQ2QuuRxLjYXd+UKJY5fJ1mZAomrLdBeNFTipZ/X0hgrM2qb
         6Wow==
X-Gm-Message-State: AOAM530jRCp3vPtQvI22QkxvkYKF8lBH1xistAONqWZP+4Ztee5NQQGx
        Od4F1BisRvJbJc8sACgUrrdkQEuF8HjWXg==
X-Google-Smtp-Source: ABdhPJwsv+9zqI/Jq0oRR8gzN/4Yv7MTpkElM3lfJTeWI9OoU0jWIW8DZuaDfOU/p43ruO+//a1jyw==
X-Received: by 2002:ac8:6886:: with SMTP id m6mr19771732qtq.255.1629486720604;
        Fri, 20 Aug 2021 12:12:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j2sm3001167qtn.46.2021.08.20.12.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/9] btrfs-progs: use an associative array for init mkfs blocks
Date:   Fri, 20 Aug 2021 15:11:49 -0400
Message-Id: <9e4cd53b74631be7c4bf78653de2d931d53dce3c.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
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
 mkfs/common.c | 56 ++++++++++++++++++++++++++++++++-------------------
 mkfs/common.h | 10 +++++++++
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 2c041224..e9ff529a 100644
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
@@ -195,8 +202,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	uuid_generate(chunk_tree_uuid);
 
 	cfg->blocks[MKFS_SUPER_BLOCK] = BTRFS_SUPER_INFO_OFFSET;
-	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
-		cfg->blocks[i] = system_group_offset + cfg->nodesize * (i - 1);
+	for (i = 0; i < blocks_nr; i++) {
+		blk = blocks[i];
+		if (blk == MKFS_SUPER_BLOCK)
+			continue;
+		cfg->blocks[blk] = system_group_offset + cfg->nodesize * i;
 	}
 
 	btrfs_set_super_bytenr(&super, cfg->blocks[MKFS_SUPER_BLOCK]);
@@ -236,7 +246,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			    btrfs_header_chunk_tree_uuid(buf),
 			    BTRFS_UUID_SIZE);
 
-	ret = btrfs_create_tree_root(fd, cfg, buf);
+	ret = btrfs_create_tree_root(fd, cfg, buf, blocks, blocks_nr);
 	if (ret < 0)
 		goto out;
 
@@ -245,30 +255,34 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		cfg->nodesize - sizeof(struct btrfs_header));
 	nritems = 0;
 	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
-	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
+	for (i = 0; i < blocks_nr; i++) {
+		blk = blocks[i];
+		if (blk == MKFS_SUPER_BLOCK)
+			continue;
+
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
@@ -292,8 +306,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
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

