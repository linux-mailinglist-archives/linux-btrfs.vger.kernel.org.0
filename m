Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372A58AC3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbiHEOPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiHEOPT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD0E06
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d139so1999409iof.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M5mKYfj9LKNxcTja+WNSM/UgZiSnO1ml+in4pdevVgs=;
        b=68mGwpgC5Yyz7xTx1laI2TEF5Jeo3iEjZwCAqc5yMsoL1FucuaJh6wJRgBmviuJpl6
         LS4oYSA9RlI9KkWaRQMxHYKMSAxE+HxYtTPbjPQ7DqYpiP8+376jgPoPKod5mpxPilwJ
         7pDDkSN2yG72EsY3yhSqlwGDNJ7dt33mvqvuHXXo4QsAe/5KNd89f6dfV+zPv2WvbC+x
         G3z419PG9viSq9ddokoBN1Jg531Zl+TIO7VMHuTXmvj5cbKe73Tsy4+icDjIJUXCu23m
         IbfDit3r6TGxPqD0x/3XpKqvs2HiQoIl1YcH77ynByQhtyhm913WfZDTcSStQQiPagGd
         xpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5mKYfj9LKNxcTja+WNSM/UgZiSnO1ml+in4pdevVgs=;
        b=yMNHVvnRipaKN5WAjNYkVbeezrX03eJZy4jb2uiQeZHJFuXjC6u4f2qJJAqQv7WaAh
         Jh2EaQZ4DJ/Ca4sMTKkXlIKWxLYEWtXNoZiY7NIpvRYcm1yFNzG4kbzRnlMc5l6PgaRi
         LcX4VB9d50IX12DhbAyliw5EiNsEQju53DdFjHgUjX+jS6XdAJ8HkM2HH/oyr6Ek1d3R
         IxxqLlYMoJktnpVmcGczZ+RCgI1xnEz3XDwd90box7qeyZVE9SAIJ17KzTdgP9yQTlyw
         55yaaGL9CZleTDyTCHg7ugthF6Q+twO5k9zYfTpB+apmAwjuttexp9PV6WH/ksPR/J6s
         3oBA==
X-Gm-Message-State: ACgBeo3nzKjv8Bow97C6aBF0aQyskh+Mov+1olM/ZhC7v+l3FUSUUXVZ
        21quF6ILb9zn4YCXAOjfMpMsSPD0mGhVfQ==
X-Google-Smtp-Source: AA6agR6NhWl+dU9Vv1xgfyarKCVcFljeZdSRadmHr4rjgPRp6IWQsSOGey9qjMS1ZRbsDp3URZanaA==
X-Received: by 2002:a05:620a:424d:b0:6a7:9714:9443 with SMTP id w13-20020a05620a424d00b006a797149443mr5164884qko.544.1659708904803;
        Fri, 05 Aug 2022 07:15:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a158300b006b5e3ca6400sm2760122qkk.103.2022.08.05.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/9] btrfs: simplify btrfs_update_space_info
Date:   Fri,  5 Aug 2022 10:14:53 -0400
Message-Id: <ee65b7482f5c656c4f526aa931b6289a65d9b9fa.1659708822.git.josef@toxicpanda.com>
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

This function has grown a bunch of new arguments, and it just boils down
to passing in all the block group fields as arguments.  Simplify this by
passing in the block group itself and updating the space_info fields
based on the block group fields directly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 28 +++++++++++-----------------
 fs/btrfs/space-info.c  | 29 ++++++++++++++---------------
 fs/btrfs/space-info.h  |  7 +++----
 3 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fd3bf13d5b40..9790f01de93e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2118,10 +2118,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super,
-				cache->zone_unusable, cache->zone_is_active,
-				&space_info);
+	btrfs_add_bg_to_space_info(info, cache, &space_info);
 
 	cache->space_info = space_info;
 
@@ -2190,8 +2187,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 
-		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
-					0, 0, false, &space_info);
+		btrfs_add_bg_to_space_info(fs_info, bg, &space_info);
 		bg->space_info = space_info;
 		link_block_group(bg);
 
@@ -2542,14 +2538,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 
 	btrfs_free_excluded_extents(cache);
 
-#ifdef CONFIG_BTRFS_DEBUG
-	if (btrfs_should_fragment_free_space(cache)) {
-		u64 new_bytes_used = size - bytes_used;
-
-		bytes_used += new_bytes_used >> 1;
-		fragment_free_space(cache);
-	}
-#endif
 	/*
 	 * Ensure the corresponding space_info object is created and
 	 * assigned to our block group. We want our bg to be added to the rbtree
@@ -2570,11 +2558,17 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * the rbtree, update the space info's counters.
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
-	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, cache->zone_unusable,
-				cache->zone_is_active, &cache->space_info);
+	btrfs_add_bg_to_space_info(fs_info, cache, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
+#ifdef CONFIG_BTRFS_DEBUG
+	if (btrfs_should_fragment_free_space(cache)) {
+		u64 new_bytes_used = size - bytes_used;
+
+		cache->space_info->bytes_used += new_bytes_used >> 1;
+		fragment_free_space(cache);
+	}
+#endif
 	link_block_group(cache);
 
 	list_add_tail(&cache->bg_list, &trans->new_bgs);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d0cbeb7ae81c..a9433d19d827 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -293,28 +293,27 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
-			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly, u64 bytes_zone_unusable,
-			     bool active, struct btrfs_space_info **space_info)
+void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
+				struct btrfs_block_group *block_group,
+				struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
 	int factor;
 
-	factor = btrfs_bg_type_to_factor(flags);
+	factor = btrfs_bg_type_to_factor(block_group->flags);
 
-	found = btrfs_find_space_info(info, flags);
+	found = btrfs_find_space_info(info, block_group->flags);
 	ASSERT(found);
 	spin_lock(&found->lock);
-	found->total_bytes += total_bytes;
-	if (active)
-		found->active_total_bytes += total_bytes;
-	found->disk_total += total_bytes * factor;
-	found->bytes_used += bytes_used;
-	found->disk_used += bytes_used * factor;
-	found->bytes_readonly += bytes_readonly;
-	found->bytes_zone_unusable += bytes_zone_unusable;
-	if (total_bytes > 0)
+	found->total_bytes += block_group->length;
+	if (block_group->zone_is_active)
+		found->active_total_bytes += block_group->length;
+	found->disk_total += block_group->length * factor;
+	found->bytes_used += block_group->used;
+	found->disk_used += block_group->used * factor;
+	found->bytes_readonly += block_group->bytes_super;
+	found->bytes_zone_unusable += block_group->zone_unusable;
+	if (block_group->length > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
 	spin_unlock(&found->lock);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 12fd6147f92d..101e83828ee5 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -123,10 +123,9 @@ DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
-void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
-			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly, u64 bytes_zone_unusable,
-			     bool active, struct btrfs_space_info **space_info);
+void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
+				struct btrfs_block_group *block_group,
+				struct btrfs_space_info **space_info);
 void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
-- 
2.26.3

