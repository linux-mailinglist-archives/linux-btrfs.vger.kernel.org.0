Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533BB4D0A92
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiCGWMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbiCGWMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:10 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91179C71
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:15 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c4so14609577qtx.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JaMIdLGcl0sFl0d/gnRdCruErMj95dJv6nYS1qXbElU=;
        b=BPVi+9wXbxeiGyBZ/8ucIfKhdqyxgONBFvnjLgI78NQsFR1b4FNw4QTkNcY4col4ji
         TYVULyqOqmAaEZF2PpGhZOhsLf1i8pWS94RU+kNoWUsHGKPaIDDRZ6DcXJymGqgRqA1E
         FOtB60VVZ47FlRYDm2Tb2SGZUcsO539xoZxsvGecl8vlTFZdHHbjNSXj2pKEtSp0b2wf
         C6KwUbmz9EE2j7gH/jRwIKJxWXXkE/EJ41/YBWZJLUmakDU0VV1sVRQijPujaVIDlajJ
         XX82CHOpE3rOZcg4UKKa1eGnID1FXlKK2Q+ECbKAdtpgTZBvSfOnD8GBNikQsonUXD7i
         VEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaMIdLGcl0sFl0d/gnRdCruErMj95dJv6nYS1qXbElU=;
        b=4ID8QWzr+8w4f7S0YcvgZqAbV+14O5AWPfGcChWk/K6c0dtLc9gKHPnNNtoeFT1aoK
         y5DnuKKBOPloSBi4wVSmq97OZnD6fsl8QCihV/tV8LMi27tPnqx+ihOXSOGBctf07acg
         xf7GaheEwFWFekHVzZSso8aznYfcuRFGzHMGAknH6+AQI7ygJe9UrHzr1BjZsGG4TiQb
         3mtLw/NZK7XScnTX+oPKRJEj4D/7iQAC+eYJiXTnkuUf0bEG6YWzbEbe3wkUuY8WJI7f
         lGX3WELPO3NaNbJ2QcgV9FwWKP2748K9YwBmptGfCY3QQcNLKLSH5uu6y9cuUremReut
         OXnA==
X-Gm-Message-State: AOAM530pNdhTavNpuux5q5mg3WtrBLyQQQ38MaDRSV37/8chBRuhtk06
        Mebq+opy4LVwWJRjkeJBOQuDfzB7/aGoYLq5
X-Google-Smtp-Source: ABdhPJy/b1tTvXbXOUJXg5FEQVHHlVGvXZ8f4dt6sA9wMP/3m4DVXYVEB7SkpP02MQSfHF7aOefkUw==
X-Received: by 2002:a05:622a:4cb:b0:2d5:1c21:254a with SMTP id q11-20020a05622a04cb00b002d51c21254amr11041394qtx.319.1646691074500;
        Mon, 07 Mar 2022 14:11:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a15d500b006097f0a8e13sm6638142qkm.119.2022.03.07.14.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 06/19] btrfs-progs: mkfs: add support for the block group tree
Date:   Mon,  7 Mar 2022 17:10:51 -0500
Message-Id: <9d4489ecd87ad62bf84d66c383e2e10190180023.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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

Add the extent tree v2 table with the block group tree as a root, and
then create the empty root and use the proper root for cleanup up the
temporary block groups.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
 mkfs/common.h | 12 +++++++
 mkfs/main.c   |  5 +++
 3 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 11d92c8b..aa65543b 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -39,6 +39,7 @@ static u64 reference_root_table[] = {
 	[MKFS_FS_TREE]		=	BTRFS_FS_TREE_OBJECTID,
 	[MKFS_CSUM_TREE]	=	BTRFS_CSUM_TREE_OBJECTID,
 	[MKFS_FREE_SPACE_TREE]	=	BTRFS_FREE_SPACE_TREE_OBJECTID,
+	[MKFS_BLOCK_GROUP_TREE]	=	BTRFS_BLOCK_GROUP_TREE_OBJECTID,
 };
 
 static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cfg,
@@ -97,7 +98,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
-		if (blk == MKFS_ROOT_TREE || blk == MKFS_CHUNK_TREE)
+		if (blk == MKFS_ROOT_TREE || blk == MKFS_CHUNK_TREE ||
+		    blk == MKFS_BLOCK_GROUP_TREE)
 			continue;
 
 		btrfs_set_root_bytenr(&root_item, cfg->blocks[blk]);
@@ -187,6 +189,50 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 	return 0;
 }
 
+static void write_block_group_item(struct extent_buffer *buf, u32 nr,
+				   u64 objectid, u64 offset, u64 used,
+				   u32 itemoff)
+{
+	struct btrfs_block_group_item *bg_item;
+	struct btrfs_disk_key disk_key;
+
+	btrfs_set_disk_key_objectid(&disk_key, objectid);
+	btrfs_set_disk_key_offset(&disk_key, offset);
+	btrfs_set_disk_key_type(&disk_key, BTRFS_BLOCK_GROUP_ITEM_KEY);
+	btrfs_set_item_key(buf, &disk_key, nr);
+	btrfs_set_item_offset(buf, nr, itemoff);
+	btrfs_set_item_size(buf, nr, sizeof(*bg_item));
+
+	bg_item = btrfs_item_ptr(buf, nr, struct btrfs_block_group_item);
+	btrfs_set_block_group_used(buf, bg_item, used);
+	btrfs_set_block_group_flags(buf, bg_item, BTRFS_BLOCK_GROUP_SYSTEM);
+	btrfs_set_block_group_chunk_objectid(buf, bg_item,
+					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+}
+
+static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
+				   struct extent_buffer *buf,
+				   u64 bg_offset, u64 bg_size, u64 bg_used)
+{
+	int ret;
+
+	memset(buf->data + sizeof(struct btrfs_header), 0,
+		cfg->nodesize - sizeof(struct btrfs_header));
+	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used,
+			       cfg->leaf_data_size -
+			       sizeof(struct btrfs_block_group_item));
+	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
+	btrfs_set_header_owner(buf, BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+	btrfs_set_header_nritems(buf, 1);
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
+			     cfg->csum_type);
+	ret = pwrite(fd, buf->data, cfg->nodesize,
+		     cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
+	if (ret != cfg->nodesize)
+		return ret < 0 ? -errno : -EIO;
+	return 0;
+}
+
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
  *
@@ -239,11 +285,19 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	bool add_block_group = true;
 	bool free_space_tree = !!(cfg->runtime_features &
 				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
+	bool extent_tree_v2 = !!(cfg->features &
+				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 
 	/* Don't include the free space tree in the blocks to process. */
 	if (!free_space_tree)
 		blocks_nr--;
 
+	if (extent_tree_v2) {
+		blocks = extent_tree_v2_blocks;
+		blocks_nr = ARRAY_SIZE(extent_tree_v2_blocks);
+		add_block_group = false;
+	}
+
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
 		system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
 		system_group_size = cfg->zone_size;
@@ -300,6 +354,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_super_compat_ro_flags(&super, ro_flags);
 		btrfs_set_super_cache_generation(&super, 0);
 	}
+	if (extent_tree_v2) {
+		btrfs_set_super_block_group_root(&super,
+						 cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
+		btrfs_set_super_block_group_root_generation(&super, 1);
+		btrfs_set_super_block_group_root_level(&super, 0);
+	}
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
@@ -331,25 +391,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
 		/* Add the block group item for our temporary chunk. */
 		if (cfg->blocks[blk] > system_group_offset && add_block_group) {
-			struct btrfs_block_group_item *bg_item;
-
+			itemoff -= sizeof(struct btrfs_block_group_item);
+			write_block_group_item(buf, nritems,
+					       system_group_offset,
+					       system_group_size, total_used,
+					       itemoff);
 			add_block_group = false;
-
-			itemoff -= sizeof(*bg_item);
-			btrfs_set_disk_key_objectid(&disk_key, system_group_offset);
-			btrfs_set_disk_key_offset(&disk_key, system_group_size);
-			btrfs_set_disk_key_type(&disk_key, BTRFS_BLOCK_GROUP_ITEM_KEY);
-			btrfs_set_item_key(buf, &disk_key, nritems);
-			btrfs_set_item_offset(buf, nritems, itemoff);
-			btrfs_set_item_size(buf, nritems, sizeof(*bg_item));
-
-			bg_item = btrfs_item_ptr(buf, nritems,
-						 struct btrfs_block_group_item);
-			btrfs_set_block_group_used(buf, bg_item, total_used);
-			btrfs_set_block_group_flags(buf, bg_item,
-						    BTRFS_BLOCK_GROUP_SYSTEM);
-			btrfs_set_block_group_chunk_objectid(buf, bg_item,
-					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 			nritems++;
 		}
 
@@ -565,6 +612,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			goto out;
 	}
 
+	if (extent_tree_v2) {
+		ret = create_block_group_tree(fd, cfg, buf,
+					      system_group_offset,
+					      system_group_size, total_used);
+		if (ret)
+			goto out;
+	}
+
 	/* and write out the super block */
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
 	memcpy(buf->data, &super, sizeof(super));
diff --git a/mkfs/common.h b/mkfs/common.h
index 428cd366..3533e114 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -51,6 +51,7 @@ enum btrfs_mkfs_block {
 	MKFS_FS_TREE,
 	MKFS_CSUM_TREE,
 	MKFS_FREE_SPACE_TREE,
+	MKFS_BLOCK_GROUP_TREE,
 	MKFS_BLOCK_COUNT
 };
 
@@ -69,6 +70,17 @@ static const enum btrfs_mkfs_block extent_tree_v1_blocks[] = {
 	MKFS_FREE_SPACE_TREE,
 };
 
+static const enum btrfs_mkfs_block extent_tree_v2_blocks[] = {
+	MKFS_ROOT_TREE,
+	MKFS_EXTENT_TREE,
+	MKFS_CHUNK_TREE,
+	MKFS_DEV_TREE,
+	MKFS_FS_TREE,
+	MKFS_CSUM_TREE,
+	MKFS_FREE_SPACE_TREE,
+	MKFS_BLOCK_GROUP_TREE,
+};
+
 struct btrfs_mkfs_config {
 	/* Label of the new filesystem */
 	const char *label;
diff --git a/mkfs/main.c b/mkfs/main.c
index 20dc0436..7f79ba1a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -299,6 +299,11 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 	ret = __recow_root(trans, info->dev_root);
 	if (ret)
 		return ret;
+        if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
+		ret = __recow_root(trans, info->block_group_root);
+		if (ret)
+			return ret;
+        }
 	ret = recow_global_roots(trans);
 	if (ret)
 		return ret;
-- 
2.26.3

