Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E99743E35
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjF3PEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjF3PEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1535AF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8E56176D
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39786C433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137437;
        bh=LnEJZ0hWqYV2gv4w5TYgjMImjZCfGv8+McVtM8mF+qc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KtM5oLJNFB543ewCrWZ9lNT6XVnyf31MqAS+xxPDsoqi+vMB05UbqnbR5/pYMXTl4
         CGs7c0cfcdZ8j8tARRSKuA2scxz36/hkkm6OFf4FNr3GWz9GAJOOaxVnn4pnQ5HGQQ
         LH3dt2VL9beUAYM6GjOKxPFuujNne0lWee9cO76Y8+WPujXUhIpv8pOFW+hMI9qNej
         frRWKuh0uDJZRN338pjezYsbKuYEWJSI9VorwMuEmajpTllOjfAQdJOEKpPhAc2V2n
         qtHFD581lFLuh0yg5h0Zx2mu45I108zGpMwv8b7xNZptygO/9O2MFUmkuj/Yr19rKG
         CGe7Lqkh/YRbA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: rename add_new_free_space() to btrfs_add_new_free_space()
Date:   Fri, 30 Jun 2023 16:03:46 +0100
Message-Id: <eb9ac6d0595238ce154af4e0143f2e0afe44d7d4.1688137156.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688137155.git.fdmanana@suse.com>
References: <cover.1688137155.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Since add_new_free_space() is exported, used outside block-group.c, rename
it to include the 'btrfs_' prefix.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c     | 20 ++++++++++----------
 fs/btrfs/block-group.h     |  4 ++--
 fs/btrfs/free-space-tree.c | 16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ec4c6edb556b..ac098d62169d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -506,8 +506,8 @@ static void fragment_free_space(struct btrfs_block_group *block_group)
  *
  * Returns 0 on success or < 0 on error.
  */
-int add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end,
-		       u64 *total_added_ret)
+int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
+			     u64 end, u64 *total_added_ret)
 {
 	struct btrfs_fs_info *info = block_group->fs_info;
 	u64 extent_start, extent_end, size;
@@ -796,8 +796,8 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		    key.type == BTRFS_METADATA_ITEM_KEY) {
 			u64 space_added;
 
-			ret = add_new_free_space(block_group, last, key.objectid,
-						 &space_added);
+			ret = btrfs_add_new_free_space(block_group, last,
+						       key.objectid, &space_added);
 			if (ret)
 				goto out;
 			total_found += space_added;
@@ -816,9 +816,9 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		path->slots[0]++;
 	}
 
-	ret = add_new_free_space(block_group, last,
-				 block_group->start + block_group->length,
-				 NULL);
+	ret = btrfs_add_new_free_space(block_group, last,
+				       block_group->start + block_group->length,
+				       NULL);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -2312,8 +2312,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_free_excluded_extents(cache);
 	} else if (cache->used == 0) {
 		cache->cached = BTRFS_CACHE_FINISHED;
-		ret = add_new_free_space(cache, cache->start,
-					 cache->start + cache->length, NULL);
+		ret = btrfs_add_new_free_space(cache, cache->start,
+					       cache->start + cache->length, NULL);
 		btrfs_free_excluded_extents(cache);
 		if (ret)
 			goto error;
@@ -2760,7 +2760,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		return ERR_PTR(ret);
 	}
 
-	ret = add_new_free_space(cache, chunk_offset, chunk_offset + size, NULL);
+	ret = btrfs_add_new_free_space(cache, chunk_offset, chunk_offset + size, NULL);
 	btrfs_free_excluded_extents(cache);
 	if (ret) {
 		btrfs_put_block_group(cache);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a6e7d66b9d80..2267be0aa66a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -289,8 +289,8 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait);
 void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
 struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group *cache);
-int add_new_free_space(struct btrfs_block_group *block_group,
-		       u64 start, u64 end, u64 *total_added_ret);
+int btrfs_add_new_free_space(struct btrfs_block_group *block_group,
+			     u64 start, u64 end, u64 *total_added_ret);
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 53b4ad1abdbc..c0e734082dcc 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1517,10 +1517,10 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 			} else if (prev_bit == 1 && bit == 0) {
 				u64 space_added;
 
-				ret = add_new_free_space(block_group,
-							 extent_start,
-							 offset,
-							 &space_added);
+				ret = btrfs_add_new_free_space(block_group,
+							       extent_start,
+							       offset,
+							       &space_added);
 				if (ret)
 					goto out;
 				total_found += space_added;
@@ -1535,7 +1535,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 		}
 	}
 	if (prev_bit == 1) {
-		ret = add_new_free_space(block_group, extent_start, end, NULL);
+		ret = btrfs_add_new_free_space(block_group, extent_start, end, NULL);
 		if (ret)
 			goto out;
 		extent_count++;
@@ -1592,9 +1592,9 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 		ASSERT(key.type == BTRFS_FREE_SPACE_EXTENT_KEY);
 		ASSERT(key.objectid < end && key.objectid + key.offset <= end);
 
-		ret = add_new_free_space(block_group, key.objectid,
-					 key.objectid + key.offset,
-					 &space_added);
+		ret = btrfs_add_new_free_space(block_group, key.objectid,
+					       key.objectid + key.offset,
+					       &space_added);
 		if (ret)
 			goto out;
 		total_found += space_added;
-- 
2.34.1

