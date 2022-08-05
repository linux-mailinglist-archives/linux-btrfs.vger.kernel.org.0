Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21F458AC41
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbiHEOPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbiHEOPQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:16 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92513DC9
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:13 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u8so1845773qvv.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vnfXtN2axr4Dx0TS58ttwkgTZ0Vt+1OZA3kMkOEhS74=;
        b=uL+TEzS7sxFuUgZH3s5Z/jpNDaPVsHYqNOhpNvoxOQGk2RZYxVqIy3YQHtNMKr9AgE
         DxyLgGatYkVpzJE4LH4h8SIe5k6zvn1vIxVrg+N3p6JKW0FZzF35xNwd9lYcHkGfMQfU
         654wENi7C8I8yuRzagOeJPFrtrDQ7p0DSrelX7c3kv43VSIWkb08cd7LFGfEtiZdh397
         kBvBfQyP+cN2fCus+c+hozV7tfmU04aPVDRnBU9gp09BVdiwCncL0kpw25vlCZGuarWz
         DUj/W3nAZT5lseteqK7HbtSA6gALARxkaCJELWZf6kKanQlGl65i1xkjaljWz0dytM8Y
         wd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnfXtN2axr4Dx0TS58ttwkgTZ0Vt+1OZA3kMkOEhS74=;
        b=7saez5o2Mpkw8AgHIp0nNbBpjlXXIm4Ls7QI7zvIrNH8uOXmxnCxb4JM/HLeNAr6/a
         3AZH87iMNOilst8tk/vodgo7QqU+QlTjInrfK6NJvPDJnxZ4qj5JXgRHgyFIbq3ytULs
         rsCQNGDAl6McvqZK0jXo4PJvHX2nSTNSwPfkw2R2uaMol6qb1V3JWrorlilsaAj+77RJ
         zLanguFEz06c/zC86MatJtn8SHmQTJsdb88gBoBYOrsShrUlZhKPA4xLhWks7XvftSPZ
         Ur0b7xtbmYalP5gqiBi8eYslddO61wM0qM/u7PrTegvzHJBQks3nIwm5rQqkTV6lMEhM
         ko/w==
X-Gm-Message-State: ACgBeo3xJF5uL3aCxG5nJHzxutfVY9pitLwRPhzkSvLzCRnrAqNVsOCZ
        I7Q9bMbnBHLuihAcqhQq9P4tSrqXZmU9eQ==
X-Google-Smtp-Source: AA6agR7W489ZMuxgoRHinkxZFyhhm05QjK7AsxsOsQ0u9cIUYXjvlt6lDSNiQpAsrQ/BwUoid4Z25Q==
X-Received: by 2002:a05:6214:20ed:b0:476:dde3:ed29 with SMTP id 13-20020a05621420ed00b00476dde3ed29mr5920075qvk.102.1659708911038;
        Fri, 05 Aug 2022 07:15:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h17-20020a05620a245100b006b568bdd7d5sm3080532qkn.71.2022.08.05.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 7/9] btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL
Date:   Fri,  5 Aug 2022 10:14:58 -0400
Message-Id: <e6ef7df62730799c7aea0800b272f3f99d2f7e64.1659708822.git.josef@toxicpanda.com>
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
index b94aa8087d98..6215f50b62d2 100644
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

