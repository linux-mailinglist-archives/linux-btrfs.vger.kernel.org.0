Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D86476272
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhLOUAL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhLOUAK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:10 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B532C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:10 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id gu12so21317754qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJkU2YZwc51y08EIHzwBlHM6La5aKH1qBJw15/eVmvI=;
        b=NNWhrYUA3Unk5iy57epAJfwJ02cJdC/lhNytd4daHSWJu2r18Tk9TrBv2YoUFL6IdT
         lfGbBMyBIVc6vK0XFPJEPnSUb4/T7dFQ8cW725jwpFHYqHj29V8pS3slIhrMDH51JVM5
         MX9bG9jn+VN0qjgJXQLax8oOwgOlcAEdqW4BZzpSW+gd178QXf0WJLzS2DpTA1UE16xB
         Rk8i5mWkK53kkZVHeYlfqF1GCf/2PmvpCaMWIJRCvkACfHl2wv9+hKAsKyy3oj5b6qqY
         5Mvmn3JSspk2Lgo7Vx0FkVHClWFXOC3IpXEa/NCAmWNJGc/1csx7eeb9JNeZJX5ArNaU
         iGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJkU2YZwc51y08EIHzwBlHM6La5aKH1qBJw15/eVmvI=;
        b=Y0t65iMigSWXn4qOLLL51LY/ojUvhKRgQKnnd1PM3unXSTgapMFLJWZ4DlQLrkfkhg
         k8US35i0ak2foT93oxMQvQQJ9V5OC9FKI86IYUgt+6devPPowet6K4H6kDZyo6aAu61v
         dx8yc02A1gXt1DgzRisCVaIq5hd8AhZEJxXzEHAeGlihX0BAZ63gIZnHL2D2oKDwclyu
         QJfCUzCaNfNTrg7KEirPnREos8pHxYmxCP4o4bo5HJS8mU2OqzLEK+U3jMVKTNUYyaTe
         92UNudB9n1tiAXT8aMRydjUJEWvmOMy145AelQs46anMpMCHI2wWTd7MaZisp9x5mH43
         V4cA==
X-Gm-Message-State: AOAM532CqNhdyiF3miCTnZluorw6ExePiSculrMADr5gGPtta5+GTLSz
        xSF+EirRR/uYLsGkoIXOWSWo56cfxGiqVQ==
X-Google-Smtp-Source: ABdhPJx0LQF/tN6XooDuV8zT0on8HleZEb/bOOZYG/hAEy4U/rsMQU7WiSkRSiGaZnhniyTysGC7ng==
X-Received: by 2002:a05:6214:c42:: with SMTP id r2mr13077059qvj.53.1639598409319;
        Wed, 15 Dec 2021 12:00:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl16sm1623796qkb.44.2021.12.15.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 12/22] btrfs-progs: check: make free space tree validation extent tree v2 aware
Date:   Wed, 15 Dec 2021 14:59:38 -0500
Message-Id: <70c2664edea4585775c8a3c4ba64a6949f4cee09.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
index da66735b..3eea186f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5624,72 +5624,38 @@ static int check_cache_range(struct btrfs_root *root,
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
@@ -5703,11 +5669,17 @@ out:
 
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
@@ -5752,14 +5724,14 @@ static int check_space_cache(struct btrfs_root *root)
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

