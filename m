Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E8E3EF998
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 06:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhHREkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 00:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhHREkB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 00:40:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51BC061764
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 21:39:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t16so598203qta.9
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 21:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UKrYz/gXwyXuYNqxlnQrNZvk8Szq25t+W8rM5yA+JJg=;
        b=MLNsAy9f3/uOyDVe0zlcrlU6D1d/qx423cTkxpm9Jt/yuO24RjesLEkAvo0mH/fo6P
         Y0fgIQ0Oik/UvP8mYkKNHa4ucxZth6F/tedXemVvwxOAuaCHjOHVOVnF9rqw6t7kCD25
         cAFInKIUtbA8fnKXoZ5DXmF8I2UiL/amFPRPH6uXZkYjK/PT1I8QN480S2lyO+6CPiD6
         UvXMCY3vkxjx8tE4yQIpnbRKztwBnggSp7o3XwJ+/t/TAN7p7wHQh0cz/iZNGb98jJFA
         BHlhXrhierlFO9mExJ1C5oZaeFNGUbaUOHdnYYYXJ2h7ca8W/2fTNfO6YMcx6ZHAadyR
         tlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKrYz/gXwyXuYNqxlnQrNZvk8Szq25t+W8rM5yA+JJg=;
        b=rQRKDuzDKQ19c8XeCrjYoyNAQTdb371/AC5CX7RitV306hCiTRuvxfNJPk9gp4FWO2
         frShB4/Iz6TE1lHzWUhIeNZElacnVlMVGhxqRRKILc/70oFAaP71dHZpUz4qFPdVa9/d
         L5f0RcJV/tbUNNPFd9mEj15M5drkVUi7SLNUxWjOg472UIlBQ8xf1gXtLryiv2x1tPIc
         F7j+1iUJ90usnKSzsuftgDolrFSDQQ1ejz6GejxdajuwdM9pUB/+fUHj7NP/WDBt5dRm
         bO5WUhd+n4dhJt1TF/o3EtqsmWhzOTuoc0V1pSdC2S9xolEm7WRSyvZLmN5znLyYV++T
         ZJyg==
X-Gm-Message-State: AOAM533BnsXGEh8QxhC+STyAGXGiXdN9JjhxpKcnYzJlnIBEe+c9l3M9
        XhFI5vb8eteEqj5qHnu+tmrKm27uZhwqMQ==
X-Google-Smtp-Source: ABdhPJzRzBQ4PvfiIXeplm2CLAiCtv+mzql3S5mAWT8W/RYn0KzBHOkr8X0JzWOfagHWEPayYETBBA==
X-Received: by 2002:a05:622a:1106:: with SMTP id e6mr6240744qty.172.1629261566636;
        Tue, 17 Aug 2021 21:39:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n189sm2959041qka.69.2021.08.17.21.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:39:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs-progs: make check detect and fix invalid used for block groups
Date:   Wed, 18 Aug 2021 00:39:21 -0400
Message-Id: <feba5f8a5a79da9abe564655c5e7d74fbdbe976c.1629261403.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629261403.git.josef@toxicpanda.com>
References: <cover.1629261403.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The lowmem mode validates the used field of the block group item, but
the normal mode does not.  Fix this by keeping a running tally of what
we think the used value for the block group should be, and then if it
mismatches report an error and fix the problem if we have repair set.
We have to keep track of pending extents because we process leaves as we
see them, so it could be much later in the process that we find the
block group item to associate the extents with.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/common.h |  5 +++
 check/main.c   | 89 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/check/common.h b/check/common.h
index e72379a0..ba4e291e 100644
--- a/check/common.h
+++ b/check/common.h
@@ -37,10 +37,14 @@ struct block_group_record {
 	u64 offset;
 
 	u64 flags;
+
+	u64 disk_used;
+	u64 actual_used;
 };
 
 struct block_group_tree {
 	struct cache_tree tree;
+	struct extent_io_tree pending_extents;
 	struct list_head block_groups;
 };
 
@@ -141,6 +145,7 @@ u64 calc_stripe_length(u64 type, u64 length, int num_stripes);
 static inline void block_group_tree_init(struct block_group_tree *tree)
 {
 	cache_tree_init(&tree->tree);
+	extent_io_tree_init(&tree->pending_extents);
 	INIT_LIST_HEAD(&tree->block_groups);
 }
 
diff --git a/check/main.c b/check/main.c
index a8851815..f7285865 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5083,9 +5083,27 @@ static void free_block_group_record(struct cache_extent *cache)
 
 void free_block_group_tree(struct block_group_tree *tree)
 {
+	extent_io_tree_cleanup(&tree->pending_extents);
 	cache_tree_free_extents(&tree->tree, free_block_group_record);
 }
 
+static void update_block_group_used(struct block_group_tree *tree,
+				    u64 bytenr, u64 num_bytes)
+{
+	struct cache_extent *bg_item;
+	struct block_group_record *bg_rec;
+
+	bg_item = lookup_cache_extent(&tree->tree, bytenr, num_bytes);
+	if (!bg_item) {
+		set_extent_dirty(&tree->pending_extents, bytenr,
+				 bytenr + num_bytes - 1);
+		return;
+	}
+	bg_rec = container_of(bg_item, struct block_group_record,
+			      cache);
+	bg_rec->actual_used += num_bytes;
+}
+
 int insert_device_extent_record(struct device_extent_tree *tree,
 				struct device_extent_record *de_rec)
 {
@@ -5270,6 +5288,7 @@ btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
 
 	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
 	rec->flags = btrfs_block_group_flags(leaf, ptr);
+	rec->disk_used = btrfs_block_group_used(leaf, ptr);
 
 	INIT_LIST_HEAD(&rec->list);
 
@@ -5281,6 +5300,7 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
 				    struct extent_buffer *eb, int slot)
 {
 	struct block_group_record *rec;
+	u64 start, end;
 	int ret = 0;
 
 	rec = btrfs_new_block_group_record(eb, key, slot);
@@ -5289,6 +5309,22 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
 		fprintf(stderr, "Block Group[%llu, %llu] existed.\n",
 			rec->objectid, rec->offset);
 		free(rec);
+		return ret;
+	}
+
+	while (!find_first_extent_bit(&block_group_cache->pending_extents,
+				      rec->objectid, &start, &end,
+				      EXTENT_DIRTY)) {
+		u64 len;
+
+		if (start >= rec->objectid + rec->offset)
+			break;
+		start = max(start, rec->objectid);
+		len = min(end - start + 1,
+			  rec->objectid + rec->offset - start);
+		rec->actual_used += len;
+		clear_extent_dirty(&block_group_cache->pending_extents, start,
+				   start + len - 1);
 	}
 
 	return ret;
@@ -5352,6 +5388,7 @@ process_device_extent_item(struct device_extent_tree *dev_extent_cache,
 
 static int process_extent_item(struct btrfs_root *root,
 			       struct cache_tree *extent_cache,
+			       struct block_group_tree *block_group_cache,
 			       struct extent_buffer *eb, int slot)
 {
 	struct btrfs_extent_item *ei;
@@ -5380,6 +5417,8 @@ static int process_extent_item(struct btrfs_root *root,
 		num_bytes = key.offset;
 	}
 
+	update_block_group_used(block_group_cache, key.objectid, num_bytes);
+
 	if (!IS_ALIGNED(key.objectid, gfs_info->sectorsize)) {
 		error("ignoring invalid extent, bytenr %llu is not aligned to %u",
 		      key.objectid, gfs_info->sectorsize);
@@ -6348,13 +6387,13 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 			}
 			if (key.type == BTRFS_EXTENT_ITEM_KEY) {
-				process_extent_item(root, extent_cache, buf,
-						    i);
+				process_extent_item(root, extent_cache,
+						    block_group_cache, buf, i);
 				continue;
 			}
 			if (key.type == BTRFS_METADATA_ITEM_KEY) {
-				process_extent_item(root, extent_cache, buf,
-						    i);
+				process_extent_item(root, extent_cache,
+						    block_group_cache, buf, i);
 				continue;
 			}
 			if (key.type == BTRFS_EXTENT_CSUM_KEY) {
@@ -8599,6 +8638,41 @@ static int deal_root_from_list(struct list_head *list,
 	return ret;
 }
 
+static int check_block_groups(struct block_group_tree *bg_cache)
+{
+	struct btrfs_trans_handle *trans;
+	struct cache_extent *item;
+	struct block_group_record *bg_rec;
+	int ret = 0;
+
+	for (item = first_cache_extent(&bg_cache->tree); item;
+	     item = next_cache_extent(item)) {
+		bg_rec = container_of(item, struct block_group_record,
+				      cache);
+		if (bg_rec->disk_used == bg_rec->actual_used)
+			continue;
+		fprintf(stderr,
+			"block group[%llu %llu] used %llu but extent items used %llu\n",
+			bg_rec->objectid, bg_rec->offset, bg_rec->disk_used,
+			bg_rec->actual_used);
+		ret = -1;
+	}
+
+	if (!repair || !ret)
+		return ret;
+
+	trans = btrfs_start_transaction(gfs_info->extent_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		fprintf(stderr, "Failed to start a transaction\n");
+		return ret;
+	}
+
+	ret = btrfs_fix_block_accounting(trans);
+	btrfs_commit_transaction(trans, gfs_info->extent_root);
+	return ret ? ret : -EAGAIN;
+}
+
 /**
  * parse_tree_roots - Go over all roots in the tree root and add each one to
  *		      a list.
@@ -8890,6 +8964,13 @@ again:
 		goto out;
 	}
 
+	ret = check_block_groups(&block_group_cache);
+	if (ret) {
+		if (ret == -EAGAIN)
+			goto loop;
+		goto out;
+	}
+
 	ret = check_devices(&dev_cache, &dev_extent_cache);
 	if (ret && err)
 		ret = err;
-- 
2.26.3

