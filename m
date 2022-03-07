Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065E54D0A9A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245725AbiCGWMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242951AbiCGWMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:15 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19F581896
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:19 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d194so3623007qkg.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cTcvX8ZYgl1xA1KXVVz4j+p31hnynZLYi89B2UOpO8s=;
        b=qLZJMCNwf5hEjMWq+QBf8hOZ1JRMsWPdKg7gDvDAZr2z5OPSkqSUUIMPgyod2El+H5
         P9rQ36qKt9UtTSufkKted9Jzt5uVqsu7KhauwK4J0wsln8cK51ouAhtTBF9ja5sa8S2T
         8tjFaSxvWds+ERjTmTuYpD2V5FzIxLKfPtmCniwzOwg1pSSA0F+LtltCRaKITfxvmn2P
         fm7CPA3wdZE71aIuTBBL9KrLJa3gp1GEoMTfpeUFWO7x5DOZx87ySWtMliyH7U3E1MTM
         sxRGO9V5FnTAtdcLUnJkVx6j7NlW4i1DNmCv5yrdjpDCHx352UfliChlJlKXQ7bXVqBR
         /oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTcvX8ZYgl1xA1KXVVz4j+p31hnynZLYi89B2UOpO8s=;
        b=NAzj6Tw140lM0WJ6ILPU6NKeh5Xo6huewjNccnaRQO8wXResZlcKhj2tfO683TWzI8
         CxHAWbIvYEV9qkE6m4Oan9n5eAg9dmRmwG05NPryuJF4asa0Dam/9T1XeV7T0RBpaU0q
         myURZdFxKe9z0pabVYMHqFcdWwMj3OxsX2YNMcuyTjNlkEIqBSXNmfdMiq/hJ9lQ9Q5z
         vK7Wai4qGT5tFXSqSV66ys9XO5tnDmQZJh0R9hW3wB2bK3dm8L9+KMzKeAYom1tqMoyd
         iYQQrH+nSMR3FpmoNnzLevvbWd56oyqorcnF3qEvyy6cCY9r99L0azvmxOLCghacLDDy
         9Ddg==
X-Gm-Message-State: AOAM533IOr/eUhBXP2qTuiNaKnj8xMimuFGiLzQMLbGriPAIlUJDBd67
        b6GRdkRSI0I7IuKzY9MmyrQ7NEM6wh2IaMIS
X-Google-Smtp-Source: ABdhPJwAdssGsyCTkRNbZ4lbFYVVvMXWQXXGuRignHA7GIyum1eKXIVO0NYLESqjMQ8oI0Swtbp+vw==
X-Received: by 2002:a05:620a:24c1:b0:662:e76f:4e4d with SMTP id m1-20020a05620a24c100b00662e76f4e4dmr8303616qkn.771.1646691078834;
        Mon, 07 Mar 2022 14:11:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x26-20020ae9f81a000000b005f1916fc61fsm6607956qkh.106.2022.03.07.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 09/19] btrfs-progs: check: make free space tree validation extent tree v2 aware
Date:   Mon,  7 Mar 2022 17:10:54 -0500
Message-Id: <9487421e57a44598f81ccf6b2ddc0f3d14386027.1646690972.git.josef@toxicpanda.com>
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

The free space tree needs to be validated against all referenced blocks
in the file system, so use the btrfs_mark_used_blocks() helper to check
the free space tree and free space cache against.  This will do the
right thing for both extent tree v1 and extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 90 ++++++++++++++++++----------------------------------
 1 file changed, 31 insertions(+), 59 deletions(-)

diff --git a/check/main.c b/check/main.c
index a0f4ee91..9d090fdc 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5637,72 +5637,38 @@ static int check_cache_range(struct btrfs_root *root,
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
@@ -5716,11 +5682,17 @@ out:
 
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
@@ -5765,14 +5737,14 @@ static int check_space_cache(struct btrfs_root *root)
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

