Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB17B5767A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiGOTpq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiGOTpo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:44 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAFA6392F
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:43 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d17so4467101qvs.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=31HjCkIJflT46tQmbUfH4BzcWZ5I3a+IT+l1oD90TbA=;
        b=D2UqTLY06bAbvxRmDyze9d4P33P6gvpf2evQ6b5s/rFcEMA8gzzVZ+xF5WkWB8pbN6
         LhRYCzhMU9cLEW2S8i2weq76RsHUUvD4Dp+S4wyqeAmsAjGfWU5v/qKgWkxPa93pTGad
         G61f10It0EhGZE5yTm5pfSYyjl0NWNC3cp4e9vud4/dir8fd93mAd4/D3WqOYSB+Ndh9
         5HHnyxnY7qfW2Yo32YX8S6eA7rpV47Nzexgfm/omRaRgCNxh24oOyDZbz6q9XaRMDzvO
         w0CayGlA6Luxx5KPr9kaTSVRPsxifr7aXk9CXAbsmohp51jzl+Rushih7BrnQQRCbMzP
         qtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31HjCkIJflT46tQmbUfH4BzcWZ5I3a+IT+l1oD90TbA=;
        b=u++Sr+e3LeShLi9LdEkK6QCPPpYWKMZW9J5fmOGFPjyEBadF4zp1uNbYO7x5fc11V1
         cX7vxkxQD3znChfZTWWKOzaQxbEznCK6u66e+SA1exq6cmPXYOCbN9AtXi1de1w8G7C+
         tscAI6x0WpX9VfKo5+jr/kqSuuhZV9sKbBNsQ5SBrkw6OIj7hcXUal7WDooDn78OyFQ3
         DvTrRgNj9V+scIZbVhaK2jPcs6vP/YjyfcSaWE2dRs2tni6OMrNckRYz76mj59InMqgB
         ZAzpEgT7NVDO+y986NKZslm8RprzblQhtM3rZ6nlKwSAn3IgD0ShiFiliWblGDeKM5Qg
         kPWQ==
X-Gm-Message-State: AJIora81SDkoGYNEZ9bYeKBSbnHS44OLYcOWMcNQy3gT9sM2+Pv1VxWS
        tlZA/CKIxvJMbr+6OJCbrbR6fdeDZe6RcA==
X-Google-Smtp-Source: AGRyM1v7ZTG8iCnxZDRuAV+Ydfa6OutfFo/KTJxPo67Ucsi1tEj0VxmLQpouYey8t9QepxtI4Lde1A==
X-Received: by 2002:a0c:b210:0:b0:472:ba83:5bab with SMTP id x16-20020a0cb210000000b00472ba835babmr13262401qvd.123.1657914343117;
        Fri, 15 Jul 2022 12:45:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a400b00b006b5a12eb838sm4742538qko.31.2022.07.15.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 9/9] btrfs: delete btrfs_wait_space_cache_v1_finished
Date:   Fri, 15 Jul 2022 15:45:29 -0400
Message-Id: <65da3f09e40379e7aa4eead424c340222522ac8a.1657914198.git.josef@toxicpanda.com>
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

We used to use this in a few spots, but now we only use it directly
inside of block-group.c, so remove the helper and just open code where
we were using it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 8 +-------
 fs/btrfs/block-group.h | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ca50ae7a9054..4f7655f181e3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -467,12 +467,6 @@ static bool space_cache_v1_done(struct btrfs_block_group *cache)
 	return ret;
 }
 
-void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
-				struct btrfs_caching_control *caching_ctl)
-{
-	wait_event(caching_ctl->wait, space_cache_v1_done(cache));
-}
-
 #ifdef CONFIG_BTRFS_DEBUG
 static void fragment_free_space(struct btrfs_block_group *block_group)
 {
@@ -801,7 +795,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
 out:
 	if (load_cache_only && caching_ctl)
-		btrfs_wait_space_cache_v1_finished(cache, caching_ctl);
+		wait_event(caching_ctl->wait, space_cache_v1_done(cache));
 	if (caching_ctl)
 		btrfs_put_caching_control(caching_ctl);
 
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index fffcc7789fa7..96382ca5cbfb 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -310,8 +310,6 @@ void btrfs_reserve_chunk_metadata(struct btrfs_trans_handle *trans,
 u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
-void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
-				struct btrfs_caching_control *caching_ctl);
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		       struct block_device *bdev, u64 physical, u64 **logical,
 		       int *naddrs, int *stripe_len);
-- 
2.26.3

