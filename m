Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33054469DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhKEUnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhKEUnq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4101C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:06 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bj27so8214135qkb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OxZHNbFkK+aqNyGYkT8WGjyYAA0mg2WTPkkDCaYEn3c=;
        b=QMUop7ZdrBdhsfQOeIIty/vojIEVecWWnzyortvcpmyds24PSd+pUrpFFo82XY0nCk
         jjskrtGR2yKwFKXcTKYh0XaGSGdyT0yWNt787TZRUaJrRw2db+85eNpBOb8wO8QIdZCj
         C84QymHgNzw3xlm0GEC0oa+TqD1EEnHcBOy73jCczlz3oTWQqK97ZFOcgpOb9Nxi8PEa
         In0agmazuV6sJxYwJdKDv6044+cBguHbe4IND6I9J4+LADYfm3opysS0lHFxgCgNZxXi
         99/2lrb5M4QlBMLMfAIqwHHC9LHGvHqTOs33gnsD0qKVHqUeZIYL3e+s6HWyQLPPWEUJ
         qqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxZHNbFkK+aqNyGYkT8WGjyYAA0mg2WTPkkDCaYEn3c=;
        b=GFh1PeOWKKMQcg8Uv19CB0UtMEmVgX3Euey+dAmt8gXO3HOE3l592OXndr4+RokeZZ
         9xhU4/Q54ky+C2QruxPELpyp9Cre63VUZr8t0qJ+zPW1kkK0s7g6Xec/7KaKXjH2j3Oc
         0krjMW8nfnBi8wkxq9OCgNWLrJbnZdM+rVzxPbLzQYIDw/NNTpZkMIcjPzZyhlqOtt0i
         D2Gj8xoue3hLBhuEtDQooNJACNtwlx/ewzpKHl60zzMLjIZULokST/jwrqWUWXX6gkDz
         rq5WbgmG1m2p+rWPIhDC6FiKe2Pufp9dNwYrA3kMc5GVLrdgccvtOnxIEC9hgvMtDyjl
         OCBA==
X-Gm-Message-State: AOAM5305CpJyIh8/fSzsHCouE0/FFiSx84p1T4xkRbJlBbGIacc6scC0
        osswR5fT18GXjDkaK7HXwG9VTWPuq1F6EQ==
X-Google-Smtp-Source: ABdhPJzuJleqS3oPVxCNYaysWtw9R8Q5oCMjyx4bfTpu0YNOcdZp4nWUT2oBtHYZg/th/tFREHNz9w==
X-Received: by 2002:a37:6003:: with SMTP id u3mr20468630qkb.508.1636144865708;
        Fri, 05 Nov 2021 13:41:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s10sm6922534qkp.132.2021.11.05.13.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/22] btrfs-progs: check: make free space tree validation extent tree v2 aware
Date:   Fri,  5 Nov 2021 16:40:38 -0400
Message-Id: <3126aa7cdb414b430e182fc0718b72a3f5705991.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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

