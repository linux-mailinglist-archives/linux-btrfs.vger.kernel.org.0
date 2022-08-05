Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4158AC3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiHEOPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiHEOPM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED95724C
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:07 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a2so1949497qkk.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=57qCfcsItQsdOjii2/x/L4L4WxHB5ORjui4nrT085gA=;
        b=UBTzlXjUS13uj2f7WtrTfOi4KuoPEZaGwRbH65POJgw1NsPi82mYrm7s9tqU4TNujG
         aRQ8obInj9+KDy72OV7XPxDDIaWvYqgLkPD5gv3PlyYlvhD6cimqMSVt/mMI1a3xRabp
         NIu3uAxoAXzGegzNAbwU3ElgpHRcLL4864diUOesuz643THfU1JyDd6vV+ZA9HDi58jz
         2Y92xZUc/zWOne1w4G3LlsuHPGIb/U9QJ3Gr1mFOCSjycRJLq9fmzMtiAyYp4nysdPVj
         DlPJpSHCc3g19BhH+7of48xRX8qtABzg8MalpNPosfedMC8gs5Yp3XvzQxUhNqFlz/h1
         OShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57qCfcsItQsdOjii2/x/L4L4WxHB5ORjui4nrT085gA=;
        b=BX3cWKmGF6GKA+BsozMRmTLdFIJGCTOAwqpuY/GiJpxcjmrpgJGwSOyhAKwa12vvHL
         3P4sAHF1I43uo9A9cRCUSe93ed0FKdIAxk97FCnIjKkX56RA+AmBP1G128RqNP2CIO1/
         cvrqGl6dGfORCjWFof31L3jTSGo8gIWgdWB1xVeVjClcEUp6vgMVbDo0rdrZ+Ek8Blk+
         i404/5mq4XpqcdRDWhl9oSBg7D5JgQNGtLFrjvDpKWdrJ5EMQon2vfiKA+SqQKAQvQ2o
         bK+rfT4piO0FKCg6k3QSdF2Epc2lWSsdo4bQJZqqkfCpSFGcBXOf3O4Sl2cHPdTU/tRs
         XIRw==
X-Gm-Message-State: ACgBeo2S3rXecShYo7XyK0FRIk6JjjwHyBuNzmcgF4LlV3nYhNOr2toh
        FCx4yBoG2Yx4gzMzgjXKZaAFlr2K0uSB+w==
X-Google-Smtp-Source: AA6agR4B1Ni1g+KRby4CSXHkKPw8+kQq9936fYt5DEq5wm8Q17pUugdt9lCKHew6NPHvgcwo2nyKXA==
X-Received: by 2002:ae9:e102:0:b0:6b8:f8e6:7f8d with SMTP id g2-20020ae9e102000000b006b8f8e67f8dmr4953243qkm.139.1659708906010;
        Fri, 05 Aug 2022 07:15:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006b627d42616sm3033784qko.35.2022.08.05.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/9] btrfs: handle space_info setting of bg in btrfs_add_bg_to_space_info
Date:   Fri,  5 Aug 2022 10:14:54 -0400
Message-Id: <516660b8cd99f8d0ed090c5554b4390bc32d0b02.1659708822.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1659708822.git.josef@toxicpanda.com>
References: <cover.1659708822.git.josef@toxicpanda.com>
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

We previously had the pattern of

btrfs_update_space_info(all, the, bg, fields, &space_info);
link_block_group(bg);
bg->space_info = space_info;

Now that we're passing the bg into btrfs_add_bg_to_space_info we can do
the linking in that function, transforming this to simply

btrfs_add_bg_to_space_info(fs_info, bg);

and put the link_block_group() and bg->space_info assignment directly in
btrfs_add_bg_to_space_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 25 +++----------------------
 fs/btrfs/space-info.c  | 13 +++++++++----
 fs/btrfs/space-info.h  |  3 +--
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9790f01de93e..5f062c5d3b6f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1913,16 +1913,6 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 	return 0;
 }
 
-static void link_block_group(struct btrfs_block_group *cache)
-{
-	struct btrfs_space_info *space_info = cache->space_info;
-	int index = btrfs_bg_flags_to_raid_index(cache->flags);
-
-	down_write(&space_info->groups_sem);
-	list_add_tail(&cache->list, &space_info->block_groups[index]);
-	up_write(&space_info->groups_sem);
-}
-
 static struct btrfs_block_group *btrfs_create_block_group_cache(
 		struct btrfs_fs_info *fs_info, u64 start)
 {
@@ -2025,7 +2015,6 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 				int need_clear)
 {
 	struct btrfs_block_group *cache;
-	struct btrfs_space_info *space_info;
 	const bool mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
 	int ret;
 
@@ -2118,11 +2107,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_add_bg_to_space_info(info, cache, &space_info);
-
-	cache->space_info = space_info;
-
-	link_block_group(cache);
+	btrfs_add_bg_to_space_info(info, cache);
 
 	set_avail_alloc_bits(info, cache->flags);
 	if (btrfs_chunk_writeable(info, cache->start)) {
@@ -2146,7 +2131,6 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 {
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct btrfs_space_info *space_info;
 	struct rb_node *node;
 	int ret = 0;
 
@@ -2187,9 +2171,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 
-		btrfs_add_bg_to_space_info(fs_info, bg, &space_info);
-		bg->space_info = space_info;
-		link_block_group(bg);
+		btrfs_add_bg_to_space_info(fs_info, bg);
 
 		set_avail_alloc_bits(fs_info, bg->flags);
 	}
@@ -2558,7 +2540,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * the rbtree, update the space info's counters.
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
-	btrfs_add_bg_to_space_info(fs_info, cache, &cache->space_info);
+	btrfs_add_bg_to_space_info(fs_info, cache);
 	btrfs_update_global_block_rsv(fs_info);
 
 #ifdef CONFIG_BTRFS_DEBUG
@@ -2569,7 +2551,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		fragment_free_space(cache);
 	}
 #endif
-	link_block_group(cache);
 
 	list_add_tail(&cache->bg_list, &trans->new_bgs);
 	trans->delayed_ref_updates++;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a9433d19d827..f89aa49f53d4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -294,11 +294,10 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 }
 
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
-				struct btrfs_block_group *block_group,
-				struct btrfs_space_info **space_info)
+				struct btrfs_block_group *block_group)
 {
 	struct btrfs_space_info *found;
-	int factor;
+	int factor, index;
 
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
@@ -317,7 +316,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
 	spin_unlock(&found->lock);
-	*space_info = found;
+
+	block_group->space_info = found;
+
+	index = btrfs_bg_flags_to_raid_index(block_group->flags);
+	down_write(&found->groups_sem);
+	list_add_tail(&block_group->list, &found->block_groups[index]);
+	up_write(&found->groups_sem);
 }
 
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 101e83828ee5..2039096803ed 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -124,8 +124,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
-				struct btrfs_block_group *block_group,
-				struct btrfs_space_info **space_info);
+				struct btrfs_block_group *block_group);
 void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
-- 
2.26.3

