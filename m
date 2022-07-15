Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE45767A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiGOTpo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiGOTpm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970A6392F
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l14so2179852qtv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0UTo4TAMLP61aof+Lo5zdjBLcVZpBd/8Bmbp4QtYAX0=;
        b=5N12biHzaUosSiaiHyp93pbKalX08+yWaVXqUJF3usXYGkZEibBvYWj3VJo4it2GMZ
         xq9rBZj+dycqW3CRXeqGtvBHI6K7RF8wQywZHLjJCkGRtDWLM/PUYIGL0DYiEIQGJKpU
         6vBKazvf0zXPmyO2zIG1yFHqVgsP5oiiDS33RFZQvUkQx7TG+2Cw8LKK8cEJ1IkItfU+
         kRPPt+DWIAdma2G37LE2GmuDwe0LidN7gscZ1bkLrC3sORmUnO92HEVIcJxbHugl78Cb
         NopctlMb9KZaMVwHXFJCR886P4cEzyamQA197quFu7zj6w7dePXFNYAYG/mZYdfjKzum
         YLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UTo4TAMLP61aof+Lo5zdjBLcVZpBd/8Bmbp4QtYAX0=;
        b=hFeOeCLdQevfh6Qh/Dx35/Nl2xRplpQYiO7JpUwIaRs6RQXswGqAiyjl6nTgDKNXpi
         mmZ+X2UYQxQo2TQvxEOG9O0ET+pouWyLyg1UfMlReL7DmZhDieMcmZlvffB1Ns1obePf
         C8kbyOxWw7BnS47e+T0LiKNPPOO3U2j4YE9BmPx5pbwDV4dLXJXtKt9BT3TXkmqlBkfP
         D5gfty1T1LsasQNVIc9SK364WzWZKB2W32kW0iQMqmWAxVV+WiLKzrfeWqB+R+6tHxT6
         UlVMnL3Wlw+Z4sK1x7iuDmFm5i4Gkn95oqvs1Z6SfTkN8ilt9pRZhHBWEyB/dk7Mtlba
         qJYw==
X-Gm-Message-State: AJIora8nDYnqR5KRHgEdXHw/jOhNS68ytSCh0JaGuG2u1xQPXzfk8i92
        6t7p6cD4h1IVgBolOjxlZKyigbB9ZPpPqg==
X-Google-Smtp-Source: AGRyM1u6g2hw6Dj3otDU/iM2YxenIGC9Mva9ILNMtG7j0mhqAAuKaOd1b39Ns5FrnTwiwHbcvtKZ0A==
X-Received: by 2002:a05:622a:1745:b0:31e:b0e1:f303 with SMTP id l5-20020a05622a174500b0031eb0e1f303mr13620399qtk.13.1657914340749;
        Fri, 15 Jul 2022 12:45:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a0f0b00b006b28349678dsm5055383qkl.80.2022.07.15.12.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 7/9] btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL
Date:   Fri, 15 Jul 2022 15:45:27 -0400
Message-Id: <ca8a0752e484a855d6649f2da0d37476feeb8d12.1657914198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657914198.git.josef@toxicpanda.com>
References: <cover.1657914198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used mostly to determine if we need to look at the caching ctl
list and clean up any references to this block group.  However we never
clear this flag, specifically because we need to know if we have to
remove a caching ctl we have for this block group still.  This is in the
remove block group path which isn't a fast path, so the optimization
doesn't really matter, simplify this logic and remove the flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 46 +++++++++++++++++++-----------------------
 fs/btrfs/block-group.h |  1 -
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0fd6b9b8dae5..ca50ae7a9054 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -789,7 +789,6 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 		cache->cached = BTRFS_CACHE_FAST;
 	else
 		cache->cached = BTRFS_CACHE_STARTED;
-	set_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL, &cache->runtime_flags);
 	spin_unlock(&cache->lock);
 
 	write_lock(&fs_info->block_group_cache_lock);
@@ -1006,34 +1005,31 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	}
 
 
-	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
-		     &block_group->runtime_flags))
-		caching_ctl = btrfs_get_caching_control(block_group);
 	if (block_group->cached == BTRFS_CACHE_STARTED)
 		btrfs_wait_block_group_cache_done(block_group);
-	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
-		     &block_group->runtime_flags)) {
-		write_lock(&fs_info->block_group_cache_lock);
-		if (!caching_ctl) {
-			struct btrfs_caching_control *ctl;
-
-			list_for_each_entry(ctl,
-				    &fs_info->caching_block_groups, list)
-				if (ctl->block_group == block_group) {
-					caching_ctl = ctl;
-					refcount_inc(&caching_ctl->count);
-					break;
-				}
-		}
-		if (caching_ctl)
-			list_del_init(&caching_ctl->list);
-		write_unlock(&fs_info->block_group_cache_lock);
-		if (caching_ctl) {
-			/* Once for the caching bgs list and once for us. */
-			btrfs_put_caching_control(caching_ctl);
-			btrfs_put_caching_control(caching_ctl);
+
+	write_lock(&fs_info->block_group_cache_lock);
+	caching_ctl = btrfs_get_caching_control(block_group);
+	if (!caching_ctl) {
+		struct btrfs_caching_control *ctl;
+
+		list_for_each_entry(ctl, &fs_info->caching_block_groups, list) {
+			if (ctl->block_group == block_group) {
+				caching_ctl = ctl;
+				refcount_inc(&caching_ctl->count);
+				break;
+			}
 		}
 	}
+	if (caching_ctl)
+		list_del_init(&caching_ctl->list);
+	write_unlock(&fs_info->block_group_cache_lock);
+
+	if (caching_ctl) {
+		/* Once for the caching bgs list and once for us. */
+		btrfs_put_caching_control(caching_ctl);
+		btrfs_put_caching_control(caching_ctl);
+	}
 
 	spin_lock(&trans->transaction->dirty_bgs_lock);
 	WARN_ON(!list_empty(&block_group->dirty_list));
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8008a391ed8c..fffcc7789fa7 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -48,7 +48,6 @@ enum btrfs_chunk_alloc_enum {
 
 enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_IREF,
-	BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
 	BLOCK_GROUP_FLAG_REMOVED,
 	BLOCK_GROUP_FLAG_TO_COPY,
 	BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
-- 
2.26.3

