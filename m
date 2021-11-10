Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B517444CA62
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhKJUSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhKJUSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:06 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F67C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j17so3297726qtx.2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OxZHNbFkK+aqNyGYkT8WGjyYAA0mg2WTPkkDCaYEn3c=;
        b=NYPQQCKwAynw7Q6bwh3fiW0jKaMl6BPuB/2RMbBypdC9sdqJNuVL4e2DxUA8Ugbbs1
         TjPo0USEDZSclYGTTozxyPUwcoBSFTjzjErgjko6NUju+hpruSmpcIdyFsIdaJzgou+s
         5TJDrCSrbEjOuy9EVfXaXYfhmYQXNd75E2yr+xrtGOMJNumJuqPdK5gNKN2vNBkkL+Za
         s7/a3t7o7PE34D3jDLnSvgsE6MlNXEVBsw2fVh+t3tV8gM2HW5wL6da+1jI3b9+dJp/0
         0VGczPtllHiNIEssOezky3hTJqsTTNKRvq6TNnohtyqoAMPdrAMcmge6s3GrQ3sYhpar
         kQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxZHNbFkK+aqNyGYkT8WGjyYAA0mg2WTPkkDCaYEn3c=;
        b=7SKtCfFLjTRHq1m6lxrt2Kz1oHo9VqNZlvY42Gp9ROFYlmp34mp/IsL2xWmu89Zi2B
         6sKPKRxeSdvVVcNuDEyOZDDw4UVy+BhsnRSAEoEav6+Mw5BINbccLZNQGCU4T9OMSCIb
         sH++ur0A/x4Dqy6CdzMQ0ZpSUdYXl5paZ5tsnGF8no1iNFpWCSbQjPqXgbqs4sPKc+E6
         PRccOO8ocAplEMhQXU1kX2hZu5nYIhbg7xYx2Z0hgd8MN+9moYOlYO/0aDIUdIRGBZl7
         w1nQk8INLE4wiBDpAmHBaRn7lHY33igzdZGcKsstYdS1Pcejfel9mAMx+j63b9llyT26
         Uq0g==
X-Gm-Message-State: AOAM532vAuOOoI+e+32HdJXRmUeRyrbla0rrixp9cKqcFJZO6HC+hmWN
        uLvVYucYO7rfsSr734eVoT1x3+AQhIasAg==
X-Google-Smtp-Source: ABdhPJxtbEtz/NhBu3/NhTgYGmJ4gyj1SCi+2cwqLepkJ0W/q0pqd1LPZmNYiiWjYvbjvt47k0p1JQ==
X-Received: by 2002:ac8:5996:: with SMTP id e22mr1869379qte.373.1636575317320;
        Wed, 10 Nov 2021 12:15:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j15sm541546qtx.67.2021.11.10.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 20/30] btrfs-progs: check: make free space tree validation extent tree v2 aware
Date:   Wed, 10 Nov 2021 15:14:32 -0500
Message-Id: <d271023fe2d9aa16a604d4d4ba6e8420decb11b6.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The free space tree needs to be validated against all referenced blocks
in the file system, so use the btrfs_mark_used_blocks() helper to check
the free space tree and free space cache against.  This will do the
right thing for both extent tree v1 and extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 90 ++++++++++++++++++----------------------------------
 1 file changed, 31 insertions(+), 59 deletions(-)

diff --git a/check/main.c b/check/main.c
index 46d08040..6252a890 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5611,72 +5611,38 @@ static int check_cache_range(struct btrfs_root *root,
 }
 
 static int verify_space_cache(struct btrfs_root *root,
-			      struct btrfs_block_group *cache)
+			      struct btrfs_block_group *cache,
+			      struct extent_io_tree *used)
 {
-	struct btrfs_path path;
-	struct extent_buffer *leaf;
-	struct btrfs_key key;
-	u64 last;
+	u64 start, end, last_end, bg_end;
 	int ret = 0;
 
-	root = btrfs_extent_root(root->fs_info, cache->start);
+	start = cache->start;
+	bg_end = cache->start + cache->length;
+	last_end = start;
 
-	last = max_t(u64, cache->start, BTRFS_SUPER_INFO_OFFSET);
-
-	btrfs_init_path(&path);
-	key.objectid = last;
-	key.offset = 0;
-	key.type = BTRFS_EXTENT_ITEM_KEY;
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	if (ret < 0)
-		goto out;
-	ret = 0;
-	while (1) {
-		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
-			ret = btrfs_next_leaf(root, &path);
-			if (ret < 0)
-				goto out;
-			if (ret > 0) {
-				ret = 0;
-				break;
-			}
-		}
-		leaf = path.nodes[0];
-		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
-		if (key.objectid >= cache->start + cache->length)
+	while (start < bg_end) {
+		ret = find_first_extent_bit(used, cache->start, &start, &end,
+					    EXTENT_DIRTY);
+		if (ret || start >= bg_end) {
+			ret = 0;
 			break;
-		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
-		    key.type != BTRFS_METADATA_ITEM_KEY) {
-			path.slots[0]++;
-			continue;
 		}
-
-		if (last == key.objectid) {
-			if (key.type == BTRFS_EXTENT_ITEM_KEY)
-				last = key.objectid + key.offset;
-			else
-				last = key.objectid + gfs_info->nodesize;
-			path.slots[0]++;
-			continue;
+		if (last_end < start) {
+			ret = check_cache_range(root, cache, last_end,
+						start - last_end);
+			if (ret)
+				return ret;
 		}
-
-		ret = check_cache_range(root, cache, last,
-					key.objectid - last);
-		if (ret)
-			break;
-		if (key.type == BTRFS_EXTENT_ITEM_KEY)
-			last = key.objectid + key.offset;
-		else
-			last = key.objectid + gfs_info->nodesize;
-		path.slots[0]++;
+		end = min(end, bg_end - 1);
+		clear_extent_dirty(used, start, end);
+		start = end + 1;
+		last_end = start;
 	}
 
-	if (last < cache->start + cache->length)
-		ret = check_cache_range(root, cache, last,
-					cache->start + cache->length - last);
-
-out:
-	btrfs_release_path(&path);
+	if (last_end < bg_end)
+		ret = check_cache_range(root, cache, last_end,
+					bg_end - last_end);
 
 	if (!ret &&
 	    !RB_EMPTY_ROOT(&cache->free_space_ctl->free_space_offset)) {
@@ -5690,11 +5656,17 @@ out:
 
 static int check_space_cache(struct btrfs_root *root)
 {
+	struct extent_io_tree used;
 	struct btrfs_block_group *cache;
 	u64 start = BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE;
 	int ret;
 	int error = 0;
 
+	extent_io_tree_init(&used);
+	ret = btrfs_mark_used_blocks(gfs_info, &used);
+	if (ret)
+		return ret;
+
 	while (1) {
 		ctx.item_count++;
 		cache = btrfs_lookup_first_block_group(gfs_info, start);
@@ -5739,14 +5711,14 @@ static int check_space_cache(struct btrfs_root *root)
 				continue;
 		}
 
-		ret = verify_space_cache(root, cache);
+		ret = verify_space_cache(root, cache, &used);
 		if (ret) {
 			fprintf(stderr, "cache appears valid but isn't %llu\n",
 				cache->start);
 			error++;
 		}
 	}
-
+	extent_io_tree_cleanup(&used);
 	return error ? -EINVAL : 0;
 }
 
-- 
2.26.3

