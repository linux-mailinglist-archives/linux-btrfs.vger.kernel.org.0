Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1807E2D12C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLGN7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGN7P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:15 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD0C061A52
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:01 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h19so7129339qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=TU1Ok7+G0nW7q1KEq8ApKMOQSo+5xc79TJmVZ7NMAqqkbI5CQLQbQ0RuL0OKLKJWwt
         1WAimDbsb9gVFzzVLegeJjNZ/sA7Ya3o5YdcfR6/vJAC59LHCB0ULX5mJ+Pw8na7fu6o
         +jfisjprt1wsSSPXfGdqUp7BAPndpJxASMuz8VwdCz7PJY1F1TaxTCiHqQy2wRU/vMhY
         QArwVUXGJ14tl5SbG/wIIHm3/umAEzSNUkjxIcONXdOVx6CdhEYOhT/hEA8iMoe6NhB7
         Xwchaz6pu7SSuDJ/jeh00wPnfSQjcoUNBI2pEwS8O91JaX+QorX0um3mwyvMdL29Sx5m
         9dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=MRSbTphi2J05WhV/MV1w5P/eUTrKJ+UZKH+TGz9plgvE+qXj7nYf4WLUm7miUeEltH
         DGZq5KdBVNG+NeiuGPDWEy6lOZkpzVjSO+zLK+XQs3CrLPWT7NXvi9JBrGyz9N6x6ZaD
         sAjQ3bJDpaximGcMaNA13AvjIuPCEemVPHaOJwyUnxxUrqlSqHSAWMamBzNocl/IU0/8
         amjBfZHcqXMgim3i2Ewl/3LP+waVJ3/1sG2mVYdAT/oBMkdYzcJz3b72lDwJjLkJDMcd
         44pjM5F1KT2le5M2yQPjFX1CI5LRpAZECG8z1V5TDyq8/L2SD935EcMoORujBtqWS+Hj
         +uww==
X-Gm-Message-State: AOAM531NV+yLxFhVBYZWJ3MjR8zwUR9gTPgYOmKwBUTU1QR1Z4oabS2c
        gysxSysnCZ1XWtYoPTGGDfdB14lxDAMCDB43
X-Google-Smtp-Source: ABdhPJzB3zsQkmV632epKEkH+HR2pN1CT/zAFf8jcMWi9/WiIzALYE/yp8gZHSgklnhJ2IcN+/Go0Q==
X-Received: by 2002:ac8:4c8c:: with SMTP id j12mr3915146qtv.133.1607349480630;
        Mon, 07 Dec 2020 05:58:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v13sm12052445qkb.130.2020.12.07.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:57:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 07/52] btrfs: pass down the tree block level through ref-verify
Date:   Mon,  7 Dec 2020 08:56:59 -0500
Message-Id: <1a1622dea6d4db850e6822c136003f373a5f0eb9.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

