Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E483F449C70
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhKHT3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhKHT3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:49 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088BC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:04 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id bi29so16560413qkb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PUKcAsRuJx7vlbVEa8LlLmYMl21+VtUjY7RvKGziNwI=;
        b=N0xTYGD76nIc+02flWNp0DqbkDACDxqcL49SfnCI9mAB/3I3ehtufN7BCOA6ayQpza
         fQ19FyYt0JhWVdyDiyLAZD1ZOJt1DOCiUloAzoTcFWIrjq+Tqzay17HfOpszZtY3rkcx
         nTWn4jW903hoRbydmf3PCbp8d3t6QP9ospwOY2p70/I/okJkxGdH796k1q4jPXx6QAhZ
         PXp5SFKRMLuplikPVMVEqbA1XYhtt7jgp5gDFuVfwtp96R24xWkXna7D0JOBkCMjW5ma
         r6LLagpCzvXitJO6WLofJTyeZJrjtDR3uMPms4w8RkQ1nxLU6mBY+SOrnyVr6Yf6ROUZ
         IR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUKcAsRuJx7vlbVEa8LlLmYMl21+VtUjY7RvKGziNwI=;
        b=xmajs7q1WlCkbq/Dyz7NhlhW6lXif1BEzsGyAMAmMzd06rLFQmvDCmacLLnd/6A5Hm
         4VEWjp1O6RXrhBfHMaXuIKLzqdZu8ltbNW1DCzHdHBwizmM4Op43gjnX4J81pdNbFKdG
         zab+AxDNcFgfruqsauQqLjqe2hD17I+LQQgr3amURr7ca3XqR8KydF+kLOgPUzrA6uHV
         4u/rHxjQARWSKe6Y4w15k3fQnob7BPIgt/1oiekXbr0N1tjO74DujdektxQU9S9DIsbk
         rThyv0DAprW8cnB13c+si7pnuWWNUltnKMk4lrVZhPNrIIky9TLTpP1z8DCfyKsink1i
         mPRA==
X-Gm-Message-State: AOAM532ac8JqC5GD1WIwyZajJbTzUtuvxyskzM7rs6MFsYtucvyjokzQ
        x4LGXuEb5H56o+Eg1wU/JzJ8Ye1U6neNdA==
X-Google-Smtp-Source: ABdhPJy4w/8lD+DNgNb9gCKMxNyF/HGbOYKLkLSjgDgXyPiKJztO/yWdDN35wwB7Nlbrne9ZuRMRlw==
X-Received: by 2002:a05:620a:2903:: with SMTP id m3mr1293192qkp.452.1636399623367;
        Mon, 08 Nov 2021 11:27:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r10sm11409441qta.27.2021.11.08.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/20] btrfs-progs: check: abstract out the used marking helpers
Date:   Mon,  8 Nov 2021 14:26:38 -0500
Message-Id: <a9cc80d4d05e61e1e02d4ce194bbbd66f8165d4b.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will walk all referenced tree blocks during check in order to avoid
writing over any referenced blocks during fsck.  However in the future
we're going to need to do this for things like fixing block group
accounting with extent tree v2.  This is because extent tree v2 will not
refer to all of the allocated blocks in the extent tree.  Refactor the
code some to allow us to send down an arbitrary extent_io_tree so we can
use this helper for any case where we need to figure out where all the
used space is on an extent tree v2 file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-common.c | 54 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 0c3bd38b..3106902d 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -599,23 +599,21 @@ void reset_cached_block_groups()
 	}
 }
 
-static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin)
+static int traverse_tree_blocks(struct extent_io_tree *tree,
+				struct extent_buffer *eb, int tree_root)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_buffer *tmp;
 	struct btrfs_root_item *ri;
 	struct btrfs_key key;
-	struct extent_io_tree *tree;
 	u64 bytenr;
 	int level = btrfs_header_level(eb);
 	int nritems;
 	int ret;
 	int i;
 	u64 end = eb->start + eb->len;
+	bool pin = tree == &fs_info->pinned_extents;
 
-	if (pin)
-		tree = &gfs_info->pinned_extents;
-	else
-		tree = gfs_info->excluded_extents;
 	/*
 	 * If we have pinned/excluded this block before, don't do it again.
 	 * This can not only avoid forever loop with broken filesystem
@@ -625,7 +623,7 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 		return 0;
 
 	if (pin)
-		btrfs_pin_extent(gfs_info, eb->start, eb->len);
+		btrfs_pin_extent(fs_info, eb->start, eb->len);
 	else
 		set_extent_dirty(tree, eb->start, end - 1);
 
@@ -654,12 +652,12 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 			 * in, but for now this doesn't actually use the root so
 			 * just pass in extent_root.
 			 */
-			tmp = read_tree_block(gfs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr, 0);
 			if (!extent_buffer_uptodate(tmp)) {
 				fprintf(stderr, "Error reading root block\n");
 				return -EIO;
 			}
-			ret = traverse_tree_blocks(tmp, 0, pin);
+			ret = traverse_tree_blocks(tree, tmp, 0);
 			free_extent_buffer(tmp);
 			if (ret)
 				return ret;
@@ -669,20 +667,20 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 			/* If we aren't the tree root don't read the block */
 			if (level == 1 && !tree_root) {
 				if (pin)
-					btrfs_pin_extent(gfs_info, bytenr,
-							 gfs_info->nodesize);
+					btrfs_pin_extent(fs_info, bytenr,
+							 fs_info->nodesize);
 				else
 					set_extent_dirty(tree, bytenr,
-							 gfs_info->nodesize);
+							 fs_info->nodesize);
 				continue;
 			}
 
-			tmp = read_tree_block(gfs_info, bytenr, 0);
+			tmp = read_tree_block(fs_info, bytenr, 0);
 			if (!extent_buffer_uptodate(tmp)) {
 				fprintf(stderr, "Error reading tree block\n");
 				return -EIO;
 			}
-			ret = traverse_tree_blocks(tmp, tree_root, pin);
+			ret = traverse_tree_blocks(tree, tmp, tree_root);
 			free_extent_buffer(tmp);
 			if (ret)
 				return ret;
@@ -692,30 +690,25 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 	return 0;
 }
 
-static int pin_down_tree_blocks(struct extent_buffer *eb, int tree_root)
-{
-	return traverse_tree_blocks(eb, tree_root, 1);
-}
-
-int pin_metadata_blocks(void)
+int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
+				struct extent_io_tree *tree)
 {
 	int ret;
 
-	ret = pin_down_tree_blocks(gfs_info->chunk_root->node, 0);
-	if (ret)
-		return ret;
-
-	return pin_down_tree_blocks(gfs_info->tree_root->node, 1);
+	ret = traverse_tree_blocks(tree, fs_info->chunk_root->node, 0);
+	if (!ret)
+		ret = traverse_tree_blocks(tree, fs_info->tree_root->node, 1);
+	return ret;
 }
 
-static int exclude_tree_blocks(struct extent_buffer *eb, int tree_root)
+int pin_metadata_blocks(void)
 {
-	return traverse_tree_blocks(eb, tree_root, 0);
+	return btrfs_mark_used_tree_blocks(gfs_info,
+					   &gfs_info->pinned_extents);
 }
 
 int exclude_metadata_blocks(void)
 {
-	int ret;
 	struct extent_io_tree *excluded_extents;
 
 	excluded_extents = malloc(sizeof(*excluded_extents));
@@ -724,10 +717,7 @@ int exclude_metadata_blocks(void)
 	extent_io_tree_init(excluded_extents);
 	gfs_info->excluded_extents = excluded_extents;
 
-	ret = exclude_tree_blocks(gfs_info->chunk_root->node, 0);
-	if (ret)
-		return ret;
-	return exclude_tree_blocks(gfs_info->tree_root->node, 1);
+	return btrfs_mark_used_tree_blocks(gfs_info, excluded_extents);
 }
 
 void cleanup_excluded_extents(void)
-- 
2.26.3

