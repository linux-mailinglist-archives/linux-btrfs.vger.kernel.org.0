Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AA58AC3C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbiHEOPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbiHEOPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD8BC0
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d16so2099953qtw.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=myCiLxZUhctKOC0V6TYsgEep63NSo41G2R6Ef0Puz7w=;
        b=ZLs48eio9u+aRfDcthq60yqb8SazoZTtaNEOm+nCNQNDJdB/ae5eZAF9blteJIEHtN
         ODJOrhuCf2qyYOtjOySJtJj7wIALfub6/vrkUOFPi321UM7UBSl0FumJoVy+UiRy9l6f
         jcgMT4kdXovfums3/FMXoF+o1AH+5MdQuVkEWLRFU/ZTh+TSqD6Elegmy3XQniXqyGLc
         275sdr8+TrsDiuipB50hgLdMv5XVCo8NlBNSpL0sjnTV7VgXLgpC4y4Tq5tG7PahmKPp
         JmTJPu1DBhDwlWZzlkT+x3gv00g+uXDYDI/oBovWrrNg3QxelBraEbQeVWqf14AMvNgO
         grgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myCiLxZUhctKOC0V6TYsgEep63NSo41G2R6Ef0Puz7w=;
        b=t6eEydBAk1OJ1SaFLIPTLjHNB1SfA6l3GBmXfKw+n7gZH5m+imI+ERPxQfw5KrhCBK
         QnvhMeA/ew/cTMlboNfCkDyxI3Bs7F2FhsJ/NsnMAc3H2OYeXs0QzWF0myKfvxbsiW+O
         oOhVZ0FK7yHJ2lpOcLhBsI9EhkGaQ7KX6aXHAQmTM/NpusjSiWQvHNFT5kW40Ml/0GRg
         6Kjfp9G/002fkg0KAKInslCFkXZUj+Vcs6Q95axRvbIIjErK51PmeDS6gmVJe7md+c4Q
         1w6nFmqmJk5Fk1GyhD2Sfh3oMY2g94MevEj18pOiwXWkEZaWE/fqnfUXDL/DjP3hjM2k
         Mxpw==
X-Gm-Message-State: ACgBeo1DEpcEUbsLqYkT61szgFTcV4bPsmVCgc2R5hgtAZV/rNBozqNH
        EasPbNe/5fXRPB4LABm3XgNfWjK9cK965A==
X-Google-Smtp-Source: AA6agR4bwiqK9zPoVE7DezASYraCB5uQwsNEJ5lC2M47JG890godyshmcX6lnGY1n3tpLMFw58ua2w==
X-Received: by 2002:ac8:7f09:0:b0:31f:1e5e:4c05 with SMTP id f9-20020ac87f09000000b0031f1e5e4c05mr5881353qtk.437.1659708914100;
        Fri, 05 Aug 2022 07:15:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a284d00b006a6d7c3a82esm1600859qkp.15.2022.08.05.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 9/9] btrfs: delete btrfs_wait_space_cache_v1_finished
Date:   Fri,  5 Aug 2022 10:15:00 -0400
Message-Id: <e905a31f40e21f2afd50c02ac0be8a9108a1120f.1659708822.git.josef@toxicpanda.com>
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

We used to use this in a few spots, but now we only use it directly
inside of block-group.c, so remove the helper and just open code where
we were using it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 8 +-------
 fs/btrfs/block-group.h | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6215f50b62d2..8028a4c26b89 100644
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

