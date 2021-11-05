Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC844469B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhKEUbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhKEUbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCABC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bl12so9788286qkb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=slxXPeWtKXAvZ5mqd1ugPnarXNovBwbWlYPuqHFSVaE=;
        b=WyJKFl4SoVO+RW84RMNz2WxU/CzSJzc1cxskZ7DxwU8YXBBXiJtNGSyi6jgDKGvW1F
         VGlC2US53qIEXUsW/Le2XfHfYVItOKVt0WTzx8RlBMrDRL83i5AcdxoV6XhVCo+lPdRF
         ZxaW7UXjSHevmTX/tn640S34y9bCqkHzutwn+2Uf1CMCKMGid4iVUrynNwh5NSYDwzlk
         M22LeJqdJYGWKUNy8JR5zOm5eqpvfTastOjByW/cIxl/+s7+wzneOJsbUiZhVfPVaByZ
         Ny3+QNtC0Lr0vaSDdaHafe1riCH++1mT5hCllLgpBBOh7EHdO2051Mu4+IfG4jqqEA0i
         Q43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slxXPeWtKXAvZ5mqd1ugPnarXNovBwbWlYPuqHFSVaE=;
        b=s9PIMPWy6SgGtTM0o5z7zeG9eq6sWg+Gy3bbHEU+FkEjBJi7Y+ym+Yl0f4MqkF+myb
         NRYYd3oO6UMfhxIynwxal83xg2knNeNI3e3ioryEdsBB+vnt8t0Uqf06mD8G3kmfJtx/
         Vao3VG9FTvjdCVup0AUWb2sMz6FCwFUZweOqMLdCaiyt8GcBYDQLDDFaEOK0jVCDdDCT
         Z5QIC7hQlGdoRymjqk5XaNOUOIytlHktzskS2XxevlrFmbcOB7Qh6dwqRkch4/pdXYGx
         ULeYwlsN/euO2GtsHZSFyNlN2gNSM5BRo9MDPUkVQhbh5Dx4nXY22YbxhBQrRlYN7Qcv
         MArw==
X-Gm-Message-State: AOAM531DKQNq2dSDxguwjpnewXW9nyQmLfdJ8o4mt8LYegNQ6dvtkX7P
        ODrMiR48pPIaGFRhxm6Tq6hBPRHXpCNfBg==
X-Google-Smtp-Source: ABdhPJzeIvoRLd0xXlrHe+TANxOzcP1LqVDUdeHsIHjcoM5BfzVSmxDOvlqqooMyW4RrAxfswTrlgg==
X-Received: by 2002:a05:620a:2402:: with SMTP id d2mr48302663qkn.202.1636144142565;
        Fri, 05 Nov 2021 13:29:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q4sm6610343qtw.19.2021.11.05.13.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/20] btrfs-progs: check: abstract out the used marking helpers
Date:   Fri,  5 Nov 2021 16:28:35 -0400
Message-Id: <c82b4edc2e8619a4359ae3933e821e66db80beb3.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
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
 check/mode-common.c | 57 ++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 0c3bd38b..a4a09714 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -599,23 +599,21 @@ void reset_cached_block_groups()
 	}
 }
 
-static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin)
+static int traverse_tree_blocks(struct btrfs_fs_info *fs_info,
+				struct extent_io_tree *tree,
+				struct extent_buffer *eb, int tree_root)
 {
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
+			ret = traverse_tree_blocks(fs_info, tree, tmp, 0);
 			free_extent_buffer(tmp);
 			if (ret)
 				return ret;
@@ -669,20 +667,21 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
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
+			ret = traverse_tree_blocks(fs_info, tree, tmp,
+						   tree_root);
 			free_extent_buffer(tmp);
 			if (ret)
 				return ret;
@@ -692,30 +691,27 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
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
+	ret = traverse_tree_blocks(fs_info, tree,
+				   fs_info->chunk_root->node, 0);
+	if (!ret)
+		ret = traverse_tree_blocks(fs_info, tree,
+					   fs_info->tree_root->node, 1);
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
@@ -724,10 +720,7 @@ int exclude_metadata_blocks(void)
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

