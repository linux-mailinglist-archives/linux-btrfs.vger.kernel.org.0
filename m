Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A582A465522
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352226AbhLASVF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352252AbhLASU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:56 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B73C061757
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id de30so32073568qkb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4l91HVV/v5Bstov0d0M5YDFYrPEwlzXFTGAFfoyqa14=;
        b=Lr6HUZvqRj62kQgw0IkSU6RLbJq9KJJk6sgiBnyYSMka8VovxCOP8xSc+PK3XIxoym
         7+MLfoI4aq/WJFnhdTPqs1u5iC9tz3IB5praGkcsmIW8rumYoNgRMTh6JR+7jN88upS4
         OQEPZ+uJSLIoAqdqbnF5maea5qZe53Ne/VDLIVWeCwTcVLA9J82Ttn5iiUbg8Z1V+c2L
         ZCqsxLK28TCX7ytn9P+dj2zYIxPDWN9xAwOIYPZI/6dPsq/8Dd98AXn69xLQK/e8z+Uv
         uGNEJV7W952Nc64vsuBIbenRR1xUmwVfK34g/1N4cPjV3H+KnH/v0s/lSpKiJhTp7ZfM
         QczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4l91HVV/v5Bstov0d0M5YDFYrPEwlzXFTGAFfoyqa14=;
        b=cyqg2pnJOaF8XyrlLnMAVADM9TN9rVMqVIQEdLNV+BZg6o2912xOF0xS2aljSNst8i
         0Sp3d1d2P3G8s+KXK0IrnnXFMc+0IO2YuIjoF3A9q3OYdbwRMKYXEZVNJQ0ADOtC6WzX
         EiclaPoi2UoKMH/x/159M1ziFoQrcnTrHkucFWAtYTI4nFIQQd/Dnd19N2iLK3TK1nLI
         6RJBb8+DdaqICok3zYyeyKboF8QmQ/DXpzhWZqdYyfJMP81pcr/ewmC8q5PvqRcXDWuY
         GHQE3ewu56mms+THDR94LjQXU7KqUbXhnzYvaYwL6Jy6DqlZaNkdFvi9STjFJm9voczE
         yflg==
X-Gm-Message-State: AOAM531d3XQp2EJ+1mytHiPQeWzaPxxAA++K5XZ69JOVQ+aMIeFIRmRY
        PhqK3jX+n8rFROAYnP34tmxWMqdkwjUU+w==
X-Google-Smtp-Source: ABdhPJyQvscB8tKp7q3/AvrYnbHGz5EA2Y4mc5qYutlaGYwiBTCiFUvgfkPRdkHPQK85LkRhJA6A4Q==
X-Received: by 2002:a05:620a:652:: with SMTP id a18mr8073181qka.146.1638382654567;
        Wed, 01 Dec 2021 10:17:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 139sm244297qkn.37.2021.12.01.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/22] btrfs-progs: check: make free space tree validation extent tree v2 aware
Date:   Wed,  1 Dec 2021 13:17:06 -0500
Message-Id: <67cc55b2906ccd9ccfe62174158c39a39fe835e4.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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
index 6341dd43..4b7b52b5 100644
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

