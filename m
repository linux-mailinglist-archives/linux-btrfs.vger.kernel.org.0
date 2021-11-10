Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368CA44CA29
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhKJULP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:14 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A1C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:27 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v4so3251628qtw.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=omc2vO0v0jEOioKSoUj4nNxVsXrVb+wt/R03tbX1q9k=;
        b=huvfCMeIWw2QO1fCHx0sZ7ANrQq7zYpvNDCWaBVsCgUIT2A6CiRYI16ILmbgwL0qfq
         VyLsvC4uy/D9IVlGeVk+jXwPEpN4lpDcHpiYUm7YcmbJ0rKCYUtWESc2yh+HIg9HnfH8
         f+1nUPDOo1sLXUoQGcW0hkbt+v2eci3Be0/ShUbY0dsAFzvdPU/02lDJNyN37GGjRM47
         IQ7HBHhUVliPHE+mCsLnD9oSvzxG6L3yhEmEqyse1+OMir4aTDYqyRrIHqR1Bs0LL/cL
         z7Nfs3SiLDZ4E22JtDRe1hpfS5HqVvsjiCQ3GgL0VFhoUHA99mR2fqg3IEBgVr7ACX1h
         4wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omc2vO0v0jEOioKSoUj4nNxVsXrVb+wt/R03tbX1q9k=;
        b=wxt9mydQk94wU58sdQrnd1jITJg0k9Y64ZhimNuilrdOU6LWUGjOZPyB0PokDP1pjD
         WtumnGpAcPqk6jcEPcWSiUCL0+xO/YhvA5mmXXD5WtaLFl6H/6h//3LA85jgrW4Xcm+X
         lQ9ElvCRVZFkxArHP/FrwnvxZk8unRGfMF8VLnrcg6iRRYfkP8EuHRM+fHWV7UHSAGba
         QFNck/QnM//6R7H/YxU3La16R4sn3ol8lU70yejJbLQYWeaCSc3Csd44ojcWrAU+nMIb
         IJpt3n3LL8z7oCTIQGrx6pVjCIeY3cBKWhUS3EtVQnZnOZu0DyDGaCvpam6F4rBL5kxV
         vHOQ==
X-Gm-Message-State: AOAM5309irFGIAD9x6isgK4vOtvVrEEdnuAVqgVHZhxKaAJt0x66g+QP
        dSvgWrXdKn9RSBNyhdkGv2O/sBaZi2yb6Q==
X-Google-Smtp-Source: ABdhPJxnWXdil70T2Ro19g0syc5zOaFqMbmTg/jfoM/ld9CEKspBUaMsbKx4I89+J/3XvlIRD4e1Cg==
X-Received: by 2002:ac8:674a:: with SMTP id n10mr1795227qtp.145.1636574905868;
        Wed, 10 Nov 2021 12:08:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h12sm397794qkp.52.2021.11.10.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/13] btrfs-progs: check: abstract out the used marking helpers
Date:   Wed, 10 Nov 2021 15:08:02 -0500
Message-Id: <da25f7d057cf82eaf9bc01b12c0eb3f7faab52cf.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
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
index 47b141a7..5dc41e8d 100644
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
@@ -667,24 +665,24 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
 			u64 end;
 
 			bytenr = btrfs_node_blockptr(eb, i);
-			end = bytenr + gfs_info->nodesize - 1;
+			end = bytenr + fs_info->nodesize - 1;
 
 			/* If we aren't the tree root don't read the block */
 			if (level == 1 && !tree_root) {
 				if (pin)
-					btrfs_pin_extent(gfs_info, bytenr,
-							 gfs_info->nodesize);
+					btrfs_pin_extent(fs_info, bytenr,
+							 fs_info->nodesize);
 				else
 					set_extent_dirty(tree, bytenr, end);
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
@@ -694,30 +692,25 @@ static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root, int pin
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
@@ -726,10 +719,7 @@ int exclude_metadata_blocks(void)
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

