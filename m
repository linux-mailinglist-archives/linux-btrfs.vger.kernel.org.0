Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1044CA5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhKJUSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhKJUSB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:01 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D78C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:13 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z9so3269684qtj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Fx5zkf+JCd5xeyOZgGTbI6N5LU0o9nCwDJxj2dtLvFE=;
        b=e+NMsnBKHBcq8GZj4ENbFPLatIlrcZaJ8vgdHc2XS1mb2197JwCYajCYYQH/9ypNkp
         r0gnWbIzfqVN1dsMViVU8gVhTIunJ6BHqmbEtm0jz7T8gSv9lk5SqTF5w7Aj2Q+sIIsV
         a9yT9DSsxjvBLR+GZTj2ZkyGRrjq0FYFgXuynh1Kgq4PH1PnCekktE8WPeHpDihJ54+x
         2JKfbxCUtUNsHosVofgARwz7nBsSYnBOsEjfI7SKc9m1+phiCU2N59ukMhU+nS7X78yh
         gKEXoytC0+MTpo2XavR8SWv6sqfNXk6n5D4bQ9uW6u2kg7/WAggEa7MU6yrnEDff2x12
         KQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fx5zkf+JCd5xeyOZgGTbI6N5LU0o9nCwDJxj2dtLvFE=;
        b=lJR1C3xS5jHiUXgwQL1CbABvREFjNT+VYMpjvU0pWCBz6MU8AiXmYHyOQ/fhb00AY1
         jYUSPUi7i2YcCbPEVV1IPyJWhJ/4MASP/E1mvEVXF+pM1tsWJCn9ENPG7QeCT8giqyAK
         VcA3S7zNiNQbwcqkD37c1Y90L7F4ve0iauGr2f6MGBdSiIKk6qCMhd7lFzHfV9sjAdKh
         ToIkUalwOaBPp8slw3b/q3R1AJODg2nK4fqgkow0Y6sh2+iGGarzLwftbHZS6xFMTRUp
         S1zTY7O/3vXA37ec0km4spdQOmfzRyrTe6ZD4bxAXPa3ZQskmt60Zikev1JPL5OvgcxS
         /gSw==
X-Gm-Message-State: AOAM531mu8U43kXO8d1VsXsI41jK9K4SmZsJOkByHMD3OpUuwCmWfuPh
        EMslUQqRCla/4DlzmgR7jjTHOpTqsslaDQ==
X-Google-Smtp-Source: ABdhPJyp8zd62nCmyisKU+vFD76CBSnRPQi9U0HhwoDzH2iK77oi6Evo6+dYCP3prH0J9wEvG/+XBQ==
X-Received: by 2002:a05:622a:1a93:: with SMTP id s19mr1913974qtc.414.1636575312117;
        Wed, 10 Nov 2021 12:15:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m20sm488418qkp.78.2021.11.10.12.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 17/30] btrfs-progs: mkfs: add support for the block group tree
Date:   Wed, 10 Nov 2021 15:14:29 -0500
Message-Id: <a250b631459f1098a85e60777a11491433cba436.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index ca5393d5..71589c0d 100644
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
@@ -188,6 +190,50 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
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
+	btrfs_set_item_offset(buf, btrfs_item_nr(nr), itemoff);
+	btrfs_set_item_size(buf, btrfs_item_nr(nr), sizeof(*bg_item));
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
+			       __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) -
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
@@ -240,11 +286,19 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
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
@@ -309,6 +363,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
 		btrfs_set_super_compat_ro_flags(&super, ro_flags);
 	}
+	if (extent_tree_v2) {
+		btrfs_set_super_block_group_root(&super,
+						 cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
+		btrfs_set_super_block_group_root_generation(&super, 1);
+		btrfs_set_super_block_group_root_level(&super, 0);
+	}
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
@@ -340,25 +400,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
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
-			btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-			btrfs_set_item_size(buf, btrfs_item_nr(nritems), sizeof(*bg_item));
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
 
@@ -579,6 +626,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
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
index 66c9d9d0..6a48aa52 100644
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
index 9a57cef8..1653ab32 100644
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

