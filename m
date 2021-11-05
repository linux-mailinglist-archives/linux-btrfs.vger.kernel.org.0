Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E874469FE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhKEUs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhKEUss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:48 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BE3C06120A
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w4so7246797qtn.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qFo66iPkSqMDUawfz5gOpd9YXCaqa9bYkfGTO+ClMq0=;
        b=4EAsi70vHdM6zp0LieTm4x49u8CH9fHK3eurH9kjmMzosXZ3+LKmiQHhFI/fymb1yL
         sHhGVJzB7ezAun0mJ8XAJGj/zbCc/CLocoP76VXKsG//NZw/LVH2/F+JlQGbWrf9HyG7
         iRIxRIGfqqz2o22wMzqEop/S6xwdVguuXsY+EVIQscopG6puMqUDZNjneij1i2zzpcSH
         ChohvIWxwRTxY+IdWw4MzU802g1hK/ddVN78w4LhiWuThTAixCAwpZ94jOT4Jr2CLin1
         FKnw2coLLw1NXIsoba1C3Oy9ZLIyfxsVOiSc4Wzm//rfckMieaAxOQ/PCbE4sYtXNQlW
         LuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFo66iPkSqMDUawfz5gOpd9YXCaqa9bYkfGTO+ClMq0=;
        b=s2TgG01UG0gwFJAnq7kABZHa+5RGtsVp1Ky0TkTvxbXmijz/bv2+A79BqRyDIZDQkX
         N9XF4h5e7W9Wym7YXZ4KgxiQRGi6TdXX0uz1QfQncrhwSlG94Y6XpG4/CuFP6F6aImpW
         wjnGToo7Aq5G3ZMmr7LW7Kz10srP0bDAvHqKSe9Ox9YjN4eliksgdaJSbe50dp9qNvbU
         xXsQF38ZhmGJpKvBNxkueXY0D7vI//DTEJeEcmuyprY2QMSQCDlYVtev0lhbnVhOCkIY
         6j0Lp71Z3016oAycGC0elBwDKdIVEjTi8FWoEZvuXLkYu+m6Hridpzg+WsOVxvEXBqoG
         b1Wg==
X-Gm-Message-State: AOAM533vuMxfWeAXyxqnw7w1XBzMO/hTulJww7G1hVtDi97LBdb1wVWS
        UAuvMr1M6jkZ/6o4V4fsokM/jXF2McOxdQ==
X-Google-Smtp-Source: ABdhPJylxsoVSfpD0LozrbXHug3QSm2lj7s59NiSFUC1vNMIh24KYKo0c+v7xQBmOUdwJ4ztosOFMQ==
X-Received: by 2002:ac8:5c92:: with SMTP id r18mr9976758qta.135.1636145167063;
        Fri, 05 Nov 2021 13:46:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o14sm6746079qtv.34.2021.11.05.13.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/25] btrfs: add a btrfs_block_group_root() helper
Date:   Fri,  5 Nov 2021 16:45:36 -0400
Message-Id: <ebd5a6b76353126ab9e2958b55f25981379f038a.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent tree v2 we will have a separate root to hold the block group
items.  Add a btrfs_block_group_root() that will return the appropriate
root given the flags of the fs, and convert all functions that need to
modify block group items to use the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 19 ++++++++++---------
 fs/btrfs/disk-io.h     |  5 +++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2390df7fa345..b5dfb1e3446e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -841,7 +841,7 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
-	root = fs_info->extent_root;
+	root = btrfs_block_group_root(fs_info);
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
@@ -1106,6 +1106,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 		struct btrfs_fs_info *fs_info, const u64 chunk_offset)
 {
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -1139,8 +1140,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	num_items = 3 + map->num_stripes;
 	free_extent_map(em);
 
-	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
-							   num_items);
+	return btrfs_start_transaction_fallback_global_rsv(root, num_items);
 }
 
 /*
@@ -1678,7 +1678,7 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				  struct btrfs_path *path,
 				  struct btrfs_key *key)
 {
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	int ret;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
@@ -2165,6 +2165,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
+	struct btrfs_root *root = btrfs_block_group_root(info);
 	struct btrfs_path *path;
 	int ret;
 	struct btrfs_block_group *cache;
@@ -2173,7 +2174,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 
-	if (!info->extent_root)
+	if (!root)
 		return fill_dummy_bgs(info);
 
 	key.objectid = 0;
@@ -2276,7 +2277,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group_item bgi;
-	struct btrfs_root *root;
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
 
 	spin_lock(&block_group->lock);
@@ -2289,7 +2290,6 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	key.offset = block_group->length;
 	spin_unlock(&block_group->lock);
 
-	root = fs_info->extent_root;
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
@@ -2543,12 +2543,13 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_trans_handle *trans;
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	u64 alloc_flags;
 	int ret;
 	bool dirty_bg_running;
 
 	do {
-		trans = btrfs_join_transaction(fs_info->extent_root);
+		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
@@ -2653,7 +2654,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	unsigned long bi;
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a2b5db4ba262..baca29523d35 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -103,6 +103,11 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 	return NULL;
 }
 
+static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
+{
+	return fs_info->extent_root;
+}
+
 void btrfs_put_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
-- 
2.26.3

