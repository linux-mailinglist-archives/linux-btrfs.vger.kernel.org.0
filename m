Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AED3F345D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhHTTMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbhHTTMq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:46 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E39C061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:08 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id g11so6081652qvd.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ss/EXzPnq9HZemckL35kUkPLO0VZFy7z162a28UmkdM=;
        b=xOX5e7rDQoMBsi6pnNOfcO3IWXfcLj0iwxy08j5TisHJATCzkUrv4nqiY+cATX6lVe
         BMORIMYeVWzTWdISUCMHl6Q962+ugadry26UqJJ7QVZlwgWU+P4L29UiPW8OkTwahget
         MsDeVNdeSHaIE61mY/l8vS0KOROjCH5WJ2xkkMtEHc1QCC6mTOaa7kY5wnRN6om8JStG
         LT/hmsf2tRqvwNFqEUDIpTX6C5VvkWGzLvkmh16KXlfe7A5qBVo3dIAIvFwZBLd00woL
         BHaJzv0BXQMFZHywECpnMxzVRykjiW+SEV6enkpjGmZGO/++mncDtQYTn9iGEw8z+5Gc
         l9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ss/EXzPnq9HZemckL35kUkPLO0VZFy7z162a28UmkdM=;
        b=ZjJy8wmjuKE0akpzGZzQvnEQWBJ+D7OwVFMOE/4PWggiDpPDUk1frz/u1Sx8BpIdlE
         PMTjMls1HGZGDWrpvFv0aiA30V3irEImy+vpmXu+6QdXtjz57Yp+I3YA3NeuYjBNhlHv
         z6JzBljMmZMAQ4K+F1p7In7I7adTuubJsG9Hx8gMSJLcRcRF7P0qlOQF2Rb8kLkx9Vfi
         Z7nTFR+M9Apen8gkh833Qp4EyCSLk9hq0ghawIxGQ7WD2YCXa5pQuR8HPodbZKSjrnOL
         FQESTdYMZLwYvxG9OUkOi3hkMDgAizMmMwYP6QJ8J24nr5gVpwuLDl7uzqzprE4A5zHY
         Viyw==
X-Gm-Message-State: AOAM531V5mJdTFc16rL/CPNGXSnlxb+KfnVnqhwWkQ/YALE0RLP/qPai
        oN8/ffH3O5Hp9YrD55ynxwNS4k2XvrlY7w==
X-Google-Smtp-Source: ABdhPJyvG/Qfvn87l+VJ/5ysCN8kZSw2kRCfiEYwUczMjQxRiVz1X27yGkx1U7eSPTigWb9ICV+DSw==
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr21965563qvl.9.1629486727542;
        Fri, 20 Aug 2021 12:12:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v145sm3663787qkb.132.2021.08.20.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/9] btrfs-progs: add the block group item in make_btrfs()
Date:   Fri, 20 Aug 2021 15:11:54 -0400
Message-Id: <d433af292d5e99ff194bc6362133e64704ecd006.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we build a bare-bones file system in make_btrfs(), and then we
load it up and fill in the rest of the file system after the fact.  One
thing we omit in make_btrfs() is the block group item for the temporary
system chunk we allocate, because we just add it after we've opened the
file system.

However I want to be able to generate the free space tree at
make_btrfs() time, because extent tree v2 will not have an extent tree
that has every block allocated in the system.  In order to do this I
need to make sure that the free space tree entries are added on block
group creation, which is annoying if we have to add this chunk after
I've created a free space tree.

So make future work simpler by simply adding our block group item at
make_btrfs() time, this way I can do the right things with the free
space tree in the generic make block group code without needing a
special case for our temporary system chunk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 31 +++++++++++++++++++++++++++++++
 mkfs/main.c   |  9 ++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 9263965e..cba97687 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -190,6 +190,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u64 num_bytes;
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	bool add_block_group = true;
 
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
 		system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
@@ -283,6 +284,36 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		if (blk == MKFS_SUPER_BLOCK)
 			continue;
 
+		/* Add the block group item for our temporary chunk. */
+		if (cfg->blocks[blk] > system_group_offset &&
+		    add_block_group) {
+			struct btrfs_block_group_item *bg_item;
+
+			add_block_group = false;
+
+			itemoff -= sizeof(*bg_item);
+			btrfs_set_disk_key_objectid(&disk_key,
+						    system_group_offset);
+			btrfs_set_disk_key_offset(&disk_key,
+						  system_group_size);
+			btrfs_set_disk_key_type(&disk_key,
+						BTRFS_BLOCK_GROUP_ITEM_KEY);
+			btrfs_set_item_key(buf, &disk_key, nritems);
+			btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
+					      itemoff);
+			btrfs_set_item_size(buf, btrfs_item_nr(nritems),
+					    sizeof(*bg_item));
+
+			bg_item = btrfs_item_ptr(buf, nritems,
+						 struct btrfs_block_group_item);
+			btrfs_set_block_group_used(buf, bg_item, total_used);
+			btrfs_set_block_group_flags(buf, bg_item,
+						    BTRFS_BLOCK_GROUP_SYSTEM);
+			btrfs_set_block_group_chunk_objectid(buf, bg_item,
+					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+			nritems++;
+		}
+
 		item_size = sizeof(struct btrfs_extent_item);
 		if (!skinny_metadata)
 			item_size += sizeof(struct btrfs_tree_block_info);
diff --git a/mkfs/main.c b/mkfs/main.c
index eab93eb3..ea53e9c7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -67,7 +67,6 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_space_info *sinfo;
 	u64 flags = BTRFS_BLOCK_GROUP_METADATA;
-	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
@@ -90,16 +89,12 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 
 	trans = btrfs_start_transaction(root, 1);
 	BUG_ON(IS_ERR(trans));
-	bytes_used = btrfs_super_bytes_used(fs_info->super_copy);
 
 	root->fs_info->system_allocs = 1;
 	/*
-	 * First temporary system chunk must match the chunk layout
-	 * created in make_btrfs().
+	 * We already created the block group item for our temporary system
+	 * chunk in make_btrfs(), so account for the size here.
 	 */
-	ret = btrfs_make_block_group(trans, fs_info, bytes_used,
-				     BTRFS_BLOCK_GROUP_SYSTEM,
-				     system_group_offset, system_group_size);
 	allocation->system += system_group_size;
 	if (ret)
 		return ret;
-- 
2.26.3

