Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69202CC70C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbgLBTwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388128AbgLBTwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:39 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A0C061A48
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:27 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so2463062qkk.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=m/LH2FSzY1zTagwTv/NRKUfbPtitEZMU5I27qWJ5qJvXdZZ/nS74sv5AaQt82K27j3
         zGsKQxVDbNWggHmlRYrJ/iU2aYPiAIRqjO2o5SSdlGC8vjY265JJel8VRG/c0vgFrSOO
         hWjtkAgwxNlyvsLr+WZUkii3zKEPgq1tSGJbBD9SA6uzCr47Yl/EiqNVgRXRgvtbOla3
         1tDxMUx6Fpa2nlCGCmPPZBP2CjwIglKP0RsN2eABEEk7Cx+Kvl5K7gE/gOQYcr2wO1uD
         qn6KXE3iHU7v1uXkJ/ZB5ksL7EzpGREso1zxnv0vNqgLWKl6Xm0f/ucF7ythU/JMCryF
         op6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=snHNowPOEuk/ywY9O8MLvRdj/zOIqd9u142hFy/bzV1u8Djmp620a8NUHnGPUsnI7N
         4EWoPiHlOnDRdEodNz0F21E7vqwn7oRw0kh7FvXAVz8RlarmmvJ2hhYO97XsDJwBFZQG
         dcKuM6vkjhhIzPfGGzB1ZxnyJzdOYlN9NIuCUIVrAqoQZ6zzN13LquQppc2Rpw8bwZKW
         sTpy92djJQTUHfea6raigeNY/dPOacVyJdi18Z41K+sIClCmvvDt7MG0a1hvlokh/gVv
         fxGP+KRJ7NLMv8bBZTDEQE6wgk1sbH3g/LA1pjcoJBXrddYXeuNB5vO+kPhtuDQZh5Xo
         SXoA==
X-Gm-Message-State: AOAM530MW0QmBWy9yHHL0Dmv6XpkUKSpLTaTbr/Aw4IQi9n5HfF9ZGwg
        SjhCtQBd6+krnaB8fsvi/UxrYsjtrtWrFg==
X-Google-Smtp-Source: ABdhPJwIRJjuheI+FQ7CAIm6P/rcdRtO94fRIL1hz7St23syA5GQYbNXoXXw+/amcQk2U6BlClTOJw==
X-Received: by 2002:a37:9c41:: with SMTP id f62mr4247331qke.97.1606938686448;
        Wed, 02 Dec 2020 11:51:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a7sm2814820qth.41.2020.12.02.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 07/54] btrfs: pass down the tree block level through ref-verify
Date:   Wed,  2 Dec 2020 14:50:25 -0500
Message-Id: <17006f2f8420ee8b6178b435b529366e9faa7f4c.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed that sometimes I would have the wrong level printed out with
ref-verify while testing some error injection related problems.  This is
because we only get the level from the main extent item, but our
references could go off the current leaf into another, and at that point
we lose our level.  Fix this by keeping track of the last tree block
level that we found, the same way we keep track of our bytenr and
num_bytes, in case we happen to wander into another leaf while still
processing the references for a bytenr.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ref-verify.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 4b9b6c52a83b..409b02566b25 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -495,14 +495,15 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 }
 
 static int process_leaf(struct btrfs_root *root,
-			struct btrfs_path *path, u64 *bytenr, u64 *num_bytes)
+			struct btrfs_path *path, u64 *bytenr, u64 *num_bytes,
+			int *tree_block_level)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
 	u32 count;
-	int i = 0, tree_block_level = 0, ret = 0;
+	int i = 0, ret = 0;
 	struct btrfs_key key;
 	int nritems = btrfs_header_nritems(leaf);
 
@@ -515,15 +516,15 @@ static int process_leaf(struct btrfs_root *root,
 		case BTRFS_METADATA_ITEM_KEY:
 			*bytenr = key.objectid;
 			ret = process_extent_item(fs_info, path, &key, i,
-						  &tree_block_level);
+						  tree_block_level);
 			break;
 		case BTRFS_TREE_BLOCK_REF_KEY:
 			ret = add_tree_block(fs_info, key.offset, 0,
-					     key.objectid, tree_block_level);
+					     key.objectid, *tree_block_level);
 			break;
 		case BTRFS_SHARED_BLOCK_REF_KEY:
 			ret = add_tree_block(fs_info, 0, key.offset,
-					     key.objectid, tree_block_level);
+					     key.objectid, *tree_block_level);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = btrfs_item_ptr(leaf, i,
@@ -549,7 +550,8 @@ static int process_leaf(struct btrfs_root *root,
 
 /* Walk down to the leaf from the given level */
 static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
-			  int level, u64 *bytenr, u64 *num_bytes)
+			  int level, u64 *bytenr, u64 *num_bytes,
+			  int *tree_block_level)
 {
 	struct extent_buffer *eb;
 	int ret = 0;
@@ -565,7 +567,8 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			path->slots[level-1] = 0;
 			path->locks[level-1] = BTRFS_READ_LOCK;
 		} else {
-			ret = process_leaf(root, path, bytenr, num_bytes);
+			ret = process_leaf(root, path, bytenr, num_bytes,
+					   tree_block_level);
 			if (ret)
 				break;
 		}
@@ -974,6 +977,7 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_path *path;
 	struct extent_buffer *eb;
+	int tree_block_level = 0;
 	u64 bytenr = 0, num_bytes = 0;
 	int ret, level;
 
@@ -998,7 +1002,7 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		 * different leaf from the original extent item.
 		 */
 		ret = walk_down_tree(fs_info->extent_root, path, level,
-				     &bytenr, &num_bytes);
+				     &bytenr, &num_bytes, &tree_block_level);
 		if (ret)
 			break;
 		ret = walk_up_tree(path, &level);
-- 
2.26.2

