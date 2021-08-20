Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF03F345F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhHTTMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbhHTTMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:49 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B5C061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:11 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g11so6081723qvd.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bs9ZoG5re8ANULP9VoKm92pqLdxtTZ3N879FSxAJPDY=;
        b=AeTuF0t4dLwOexEMP8ss/HR0K0HGdoE2Cva2wO0YKAPwHMkCoVS7hoRI6wlNG33Au7
         K1dJOXt3RzV1CUlBSV667VJ5Iqs89ncxrlKk62+H65pnSeiSKMI9F0HSDX0i8QWvKBqe
         rQ02WhzVo5iSFp7lFBsVvnyyvXO7XMZkDPzxAyEPvxayyGHRakdCj4ioNfUqT7NJFFrY
         VVfN1hH0vJoi8aYDE3c6g7ZKatebMEWDTEBsuF72/wW8Gd6R439frGYxvE8DVaPHOpxP
         mWR6q8Eb+gDCHEqgnLeUqIHURbp/uS/eQMnRsYRetimgVowoqug4BbMU3piEC8YuniTK
         M/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bs9ZoG5re8ANULP9VoKm92pqLdxtTZ3N879FSxAJPDY=;
        b=kAxOfdcKQSt9DTwZA2DKcf3CZXllI3mfaWMFIiZSaE6TrSnFNISzA5TE6ikeFZe8oH
         0Ny4zH6wrTCPLnVpvT8TJFq+N/oriEEki91Ui14mtYDZLcTSS5th8jgtkSU0QcH0wfjA
         qFa+6YXcSqGTj0BgEtycfNpjMHZ4eS7G1JCUqr0gxjrXTIazGK9ZVQMIf9wU3DfcydDm
         dDM9zabz4Y6umCWs0yDiPyVxVq1Du23xEcKYo1JW76dHYkjAKeKlNH901rATZMevKCrb
         xGjg2RbqXZ2Q2tkL6HGgqEjSR5sR5gT3iC3pnrYytc8+C86DDoHW1NeylGNg9pxa7x6b
         s69w==
X-Gm-Message-State: AOAM531sFKcMX9x4cnNmfAo6I5v/yA/JY1P3KFVK1dUSK0YRX4cBf7sK
        oYFYzLn8uMzsHbIf54ZPBQOcn/Qf5XJaoQ==
X-Google-Smtp-Source: ABdhPJweDa+pXei0UdJyWWxX1gXNS1vjxz2oeKZ0LfqhnOGSs9kpBxR27jAgx+pOIMZvTenlMrfitw==
X-Received: by 2002:a05:6214:29cd:: with SMTP id gh13mr21365501qvb.25.1629486730468;
        Fri, 20 Aug 2021 12:12:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v14sm3653108qkb.88.2021.08.20.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/9] btrfs-progs: generate free space tree at make_btrfs() time
Date:   Fri, 20 Aug 2021 15:11:56 -0400
Message-Id: <fdfe6f848275e2d89eb75b7f8105857d467e3cc0.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent-tree-v2 we won't be able to cache block groups based on the
extent tree, so we need to have a valid free space tree before we open
the temporary file system to finish setting the file system up.  Set up
the basic free space entries for our temporary system chunk if we have
the free space tree enabled and stop generating the tree after the fact.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/common.h |  9 +++++++
 mkfs/main.c   |  9 +------
 3 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index cba97687..cf91f4d2 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -37,6 +37,7 @@ static u64 reference_root_table[] = {
 	[MKFS_DEV_TREE]		=	BTRFS_DEV_TREE_OBJECTID,
 	[MKFS_FS_TREE]		=	BTRFS_FS_TREE_OBJECTID,
 	[MKFS_CSUM_TREE]	=	BTRFS_CSUM_TREE_OBJECTID,
+	[MKFS_FREE_SPACE_TREE]	=	BTRFS_FREE_SPACE_TREE_OBJECTID,
 };
 
 static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cfg,
@@ -140,6 +141,55 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	return ret;
 }
 
+static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
+				  struct extent_buffer *buf, u64 group_start,
+				  u64 group_size, u64 free_start)
+{
+	struct btrfs_free_space_info *info;
+	struct btrfs_disk_key disk_key;
+	enum btrfs_mkfs_block blk;
+	int itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
+	int nritems = 0;
+	int i = 0;
+	int ret;
+
+	memset(buf->data + sizeof(struct btrfs_header), 0,
+	       cfg->nodesize - sizeof(struct btrfs_header));
+	itemoff -= sizeof(*info);
+
+	btrfs_set_disk_key_objectid(&disk_key, group_start);
+	btrfs_set_disk_key_offset(&disk_key, group_size);
+	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_INFO_KEY);
+	btrfs_set_item_key(buf, &disk_key, nritems);
+	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
+	btrfs_set_item_size(buf, btrfs_item_nr(nritems), sizeof(*info));
+
+	info = btrfs_item_ptr(buf, nritems, struct btrfs_free_space_info);
+	btrfs_set_free_space_extent_count(buf, info, 1);
+	btrfs_set_free_space_flags(buf, info, 0);
+
+	nritems++;
+	btrfs_set_disk_key_objectid(&disk_key, free_start);
+	btrfs_set_disk_key_offset(&disk_key, group_start + group_size -
+				  free_start);
+	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_EXTENT_KEY);
+	btrfs_set_item_key(buf, &disk_key, nritems);
+	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
+	btrfs_set_item_size(buf, btrfs_item_nr(nritems), 0);
+
+	nritems++;
+	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FREE_SPACE_TREE]);
+	btrfs_set_header_owner(buf, BTRFS_FREE_SPACE_TREE_OBJECTID);
+	btrfs_set_header_nritems(buf, nritems);
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
+			     cfg->csum_type);
+	ret = pwrite(fd, buf->data, cfg->nodesize,
+		     cfg->blocks[MKFS_FREE_SPACE_TREE]);
+	if (ret != cfg->nodesize)
+		return ret < 0 ? -errno : -EIO;
+	return 0;
+}
+
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
  *
@@ -191,6 +241,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	bool add_block_group = true;
+	bool free_space_tree = !!(cfg->runtime_features &
+				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
+
+	/* Don't include the free space tree in the blocks to process. */
+	if (!free_space_tree)
+		blocks_nr--;
 
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
 		system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
@@ -253,6 +309,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	else
 		btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features);
+	if (free_space_tree) {
+		u64 ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+			BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID;
+		btrfs_set_super_compat_ro_flags(&super, ro_flags);
+	}
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
@@ -520,6 +581,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (ret)
 		goto out;
 
+	if (free_space_tree) {
+		ret = create_free_space_tree(fd, cfg, buf, system_group_offset,
+					     system_group_size,
+					     system_group_offset + total_used);
+		if (ret)
+			goto out;
+	}
+
 	/* and write out the super block */
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
 	memcpy(buf->data, &super, sizeof(super));
diff --git a/mkfs/common.h b/mkfs/common.h
index 378da6bd..e9cc62dd 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -52,6 +52,7 @@ enum btrfs_mkfs_block {
 	MKFS_DEV_TREE,
 	MKFS_FS_TREE,
 	MKFS_CSUM_TREE,
+	MKFS_FREE_SPACE_TREE,
 	MKFS_BLOCK_COUNT
 };
 
@@ -63,6 +64,12 @@ static const enum btrfs_mkfs_block extent_tree_v1_blocks[] = {
 	MKFS_DEV_TREE,
 	MKFS_FS_TREE,
 	MKFS_CSUM_TREE,
+
+	/*
+	 * Since the free space tree is optional with v1 it must always be last
+	 * in this array.
+	 */
+	MKFS_FREE_SPACE_TREE,
 };
 
 struct btrfs_mkfs_config {
@@ -74,6 +81,8 @@ struct btrfs_mkfs_config {
 	u32 stripesize;
 	/* Bitfield of incompat features, BTRFS_FEATURE_INCOMPAT_* */
 	u64 features;
+	/* Bitfield of BTRFS_RUNTIME_FEATURE_* */
+	u64 runtime_features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
 	/* checksum algorithm to use */
diff --git a/mkfs/main.c b/mkfs/main.c
index ea53e9c7..bf09a963 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -137,7 +137,6 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 
 	root->fs_info->system_allocs = 0;
 	ret = btrfs_commit_transaction(trans, root);
-
 err:
 	return ret;
 }
@@ -1366,6 +1365,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
+	mkfs_cfg.runtime_features = runtime_features;
 	mkfs_cfg.csum_type = csum_type;
 	mkfs_cfg.zone_size = zone_size(file);
 
@@ -1529,13 +1529,6 @@ raid_groups:
 			goto out;
 		}
 	}
-	if (runtime_features & BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE) {
-		ret = btrfs_create_free_space_tree(fs_info);
-		if (ret < 0) {
-			error("failed to create free space tree: %d (%m)", ret);
-			goto out;
-		}
-	}
 	if (verbose) {
 		char features_buf[64];
 
-- 
2.26.3

