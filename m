Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D229D2CDD5F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgLCSYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbgLCSYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:35 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E83C08C5F2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:16 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f15so2028106qto.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=aLVk024lERVqvieh5pgZuWJdLHwbn5VZnFF752ziUc5/e3gSX6PoWRidP5tx2HBVq4
         WLmTbaxSWBkfA6zPrJBwI2ZH2yAVFo+so09h1whOi7C9rZvN0iP3yEgn/o8ZYymF+xmf
         pdZg2mMfH/MLavN5ozz+WzFizkEBhzmQs0XHx3RnU2ZhvKCn/2Z810pgGTc03hDUoKrJ
         0PtXzU+ueLEnhudrgbf3OPabxh9vsH0YZI+i2brM9MzJlVYrnsPOK/LVlgZnhoeaK0er
         j3fxyFoMIHaizZJE8Ws8c4bzOAPGKlsuUybT0ChHtlHOcRu9PkfjjQIRs3Pwi1jHp4k4
         fkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPX5Za2NooXPbg+T4vFkZbU7CR5nDWX/OvCiwKAeGGo=;
        b=PC/HMti+iS0J1BlLPSFYmzsIz6pick42YsSmDsxNjRhZ9fzB8FBbETu+6LFLWmiLm2
         C+kuIfw9tBN8U2iLhBZHGCpJwCG49JUmyISp4RnKMPyfaDQ4/lXA0DifApNSf0XW6mmi
         SYrC+QwMcJfocS2K9flQkjeSLHLjPVw44lDe6k257orRp5LSpdlLyZ9XA9B59MK7yqJD
         QBwxZ5A+G8o/Sp0SbaWuts2tUAQWGTiW01ATIvYYSth7rjYKCpHAfoPiy7CIum5sVvPx
         rIzJVaMOnk/9UMRioNfcV5rTqworUzomjRmmGZtw8b2VEKBMn5YsuRrJEymXlJhG977T
         0Nlw==
X-Gm-Message-State: AOAM532wVeVTfgHZYnIY0odTCkKw3TGCa5Hc0Frbt9iAghV/387wgqY2
        8rUU3v2xRCyEzDu8TIb95JdVmbc+Hw/VPboP
X-Google-Smtp-Source: ABdhPJzs91mAEGuTah1b1St5jV2l4o12RFPCBpTHa7luDZpweNCczzRoJrGHs548T5Uhbv9xRWNhDA==
X-Received: by 2002:ac8:5990:: with SMTP id e16mr4523223qte.52.1607019794898;
        Thu, 03 Dec 2020 10:23:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 131sm1996721qkg.69.2020.12.03.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 08/53] btrfs: pass down the tree block level through ref-verify
Date:   Thu,  3 Dec 2020 13:22:14 -0500
Message-Id: <b35ee6a7fda2a597baf0073b9e82d8371eaf54ef.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

