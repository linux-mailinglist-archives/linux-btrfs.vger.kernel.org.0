Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A7F77A7D6
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHMPvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 11:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjHMPvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 11:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F271735;
        Sun, 13 Aug 2023 08:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB42463269;
        Sun, 13 Aug 2023 15:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D3DC433C9;
        Sun, 13 Aug 2023 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941844;
        bh=0vtLVwYP2XUHwn0Ebz5MegU8kOFdNRYjrJ3wNMKfoIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+txeAcDILAYDTAgBbqxob0wQHd9idd5Gtd9/X8NWNdNyh57m0lDLM2a4Xr3KjtvV
         WCZIaw8iD+9v5n3Qi7AcwyhwIN1X16TCXlCrz6JpbFTKFn4EFingm3gj5h+UI4IE41
         OQWCTE24HcfOrPKHhhF7CWLkAQU0tG2HQLTA+qb466wGTh0Zn78JovSkBiYOxH47XQ
         Dm/H/sp/5fG32evZbn0H9GPCCC5Rn6Oi5zvUrmdOQ6uTzdw0yRFjpHaqw4sO19lv3d
         sS98XKOp/Ojj3MS/MuQB5EkbeTRSnlGDmIRZv2nruDmuxI4C2mR1cmG6nVQnAVK5gM
         HUMDkRG3SRT2g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 23/54] btrfs: remove BUG_ON()'s in add_new_free_space()
Date:   Sun, 13 Aug 2023 11:49:02 -0400
Message-Id: <20230813154934.1067569-23-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit d8ccbd21918fd7fa6ce3226cffc22c444228e8ad ]

At add_new_free_space() we have these BUG_ON()'s that are there to deal
with any failure to add free space to the in memory free space cache.
Such failures are mostly -ENOMEM that should be very rare. However there's
no need to have these BUG_ON()'s, we can just return any error to the
caller and all callers and their upper call chain are already dealing with
errors.

So just make add_new_free_space() return any errors, while removing the
BUG_ON()'s, and returning the total amount of added free space to an
optional u64 pointer argument.

Reported-by: syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000e9cb8305ff4e8327@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c     | 51 +++++++++++++++++++++++++-------------
 fs/btrfs/block-group.h     |  4 +--
 fs/btrfs/free-space-tree.c | 24 ++++++++++++------
 3 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 152b3ec911599..ad14dd745e4ae 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -499,12 +499,16 @@ static void fragment_free_space(struct btrfs_block_group *block_group)
  * used yet since their free space will be released as soon as the transaction
  * commits.
  */
-u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end)
+int add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end,
+		       u64 *total_added_ret)
 {
 	struct btrfs_fs_info *info = block_group->fs_info;
-	u64 extent_start, extent_end, size, total_added = 0;
+	u64 extent_start, extent_end, size;
 	int ret;
 
+	if (total_added_ret)
+		*total_added_ret = 0;
+
 	while (start < end) {
 		ret = find_first_extent_bit(&info->excluded_extents, start,
 					    &extent_start, &extent_end,
@@ -517,10 +521,12 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 			start = extent_end + 1;
 		} else if (extent_start > start && extent_start < end) {
 			size = extent_start - start;
-			total_added += size;
 			ret = btrfs_add_free_space_async_trimmed(block_group,
 								 start, size);
-			BUG_ON(ret); /* -ENOMEM or logic error */
+			if (ret)
+				return ret;
+			if (total_added_ret)
+				*total_added_ret += size;
 			start = extent_end + 1;
 		} else {
 			break;
@@ -529,13 +535,15 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 
 	if (start < end) {
 		size = end - start;
-		total_added += size;
 		ret = btrfs_add_free_space_async_trimmed(block_group, start,
 							 size);
-		BUG_ON(ret); /* -ENOMEM or logic error */
+		if (ret)
+			return ret;
+		if (total_added_ret)
+			*total_added_ret += size;
 	}
 
-	return total_added;
+	return 0;
 }
 
 /*
@@ -779,8 +787,13 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
 		    key.type == BTRFS_METADATA_ITEM_KEY) {
-			total_found += add_new_free_space(block_group, last,
-							  key.objectid);
+			u64 space_added;
+
+			ret = add_new_free_space(block_group, last, key.objectid,
+						 &space_added);
+			if (ret)
+				goto out;
+			total_found += space_added;
 			if (key.type == BTRFS_METADATA_ITEM_KEY)
 				last = key.objectid +
 					fs_info->nodesize;
@@ -795,11 +808,10 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		}
 		path->slots[0]++;
 	}
-	ret = 0;
-
-	total_found += add_new_free_space(block_group, last,
-				block_group->start + block_group->length);
 
+	ret = add_new_free_space(block_group, last,
+				 block_group->start + block_group->length,
+				 NULL);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -2290,9 +2302,11 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_free_excluded_extents(cache);
 	} else if (cache->used == 0) {
 		cache->cached = BTRFS_CACHE_FINISHED;
-		add_new_free_space(cache, cache->start,
-				   cache->start + cache->length);
+		ret = add_new_free_space(cache, cache->start,
+					 cache->start + cache->length, NULL);
 		btrfs_free_excluded_extents(cache);
+		if (ret)
+			goto error;
 	}
 
 	ret = btrfs_add_block_group_cache(info, cache);
@@ -2728,9 +2742,12 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		return ERR_PTR(ret);
 	}
 
-	add_new_free_space(cache, chunk_offset, chunk_offset + size);
-
+	ret = add_new_free_space(cache, chunk_offset, chunk_offset + size, NULL);
 	btrfs_free_excluded_extents(cache);
+	if (ret) {
+		btrfs_put_block_group(cache);
+		return ERR_PTR(ret);
+	}
 
 	/*
 	 * Ensure the corresponding space_info object is created and
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index cc0e4b37db2da..3195d0b0dbed8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -277,8 +277,8 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait);
 void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
 struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group *cache);
-u64 add_new_free_space(struct btrfs_block_group *block_group,
-		       u64 start, u64 end);
+int add_new_free_space(struct btrfs_block_group *block_group,
+		       u64 start, u64 end, u64 *total_added_ret);
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 045ddce32eca4..f169378e2ca6e 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1515,9 +1515,13 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 			if (prev_bit == 0 && bit == 1) {
 				extent_start = offset;
 			} else if (prev_bit == 1 && bit == 0) {
-				total_found += add_new_free_space(block_group,
-								  extent_start,
-								  offset);
+				u64 space_added;
+
+				ret = add_new_free_space(block_group, extent_start,
+							 offset, &space_added);
+				if (ret)
+					goto out;
+				total_found += space_added;
 				if (total_found > CACHING_CTL_WAKE_UP) {
 					total_found = 0;
 					wake_up(&caching_ctl->wait);
@@ -1529,8 +1533,9 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 		}
 	}
 	if (prev_bit == 1) {
-		total_found += add_new_free_space(block_group, extent_start,
-						  end);
+		ret = add_new_free_space(block_group, extent_start, end, NULL);
+		if (ret)
+			goto out;
 		extent_count++;
 	}
 
@@ -1569,6 +1574,8 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 	end = block_group->start + block_group->length;
 
 	while (1) {
+		u64 space_added;
+
 		ret = btrfs_next_item(root, path);
 		if (ret < 0)
 			goto out;
@@ -1583,8 +1590,11 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 		ASSERT(key.type == BTRFS_FREE_SPACE_EXTENT_KEY);
 		ASSERT(key.objectid < end && key.objectid + key.offset <= end);
 
-		total_found += add_new_free_space(block_group, key.objectid,
-						  key.objectid + key.offset);
+		ret = add_new_free_space(block_group, key.objectid,
+					 key.objectid + key.offset, &space_added);
+		if (ret)
+			goto out;
+		total_found += space_added;
 		if (total_found > CACHING_CTL_WAKE_UP) {
 			total_found = 0;
 			wake_up(&caching_ctl->wait);
-- 
2.40.1

