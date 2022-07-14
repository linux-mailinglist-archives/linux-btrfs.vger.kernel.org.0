Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B084574095
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 02:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiGNAeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 20:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGNAeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 20:34:20 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8461114A
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l2so288719qtp.11
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AzAKqCbii3v8YpeQag4dhSNjaB7G06Dq7Rhj6S+eXXk=;
        b=VPQmdw9pJDKhtf3Cvli3cG2NGBDMBtORD7SJlSRrWIQzhhMiu+xT5T9AHnDhvLSKhI
         yjvA9ZflFZOk8g38S+YmQznCRzbXznJ0bFFwIeIAs0XE+6CQDZ5WNmUV2qW7LhXknocS
         udg2tZUEEI6s5D042IFg2vTVw/8W/xBJmhA3cVD3/3pnmv+IMgCvPAlPs3nXylNgggpe
         /hAcSfnou3EdKTHB9Dw2RHNtBIzjpL0rz18Yg6yR5ywhWgJ7pkbg635IsDV4IZTVYyXJ
         uid3g7+JXSm6jnU3FF7YUPSUBuLXZORTwY3DgVcM34iKB/t6DeM/mnfqfperf2+P7Q9x
         D+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzAKqCbii3v8YpeQag4dhSNjaB7G06Dq7Rhj6S+eXXk=;
        b=KTWgXFSOipZmQ9EyUn6mPBwVFIBnRGJSee/xlVv7PPbhSaSc7rd+n0BfucJtmO2IKW
         ghlweSO4vyeMgEwpQlB028SkoC+GCtUUGlSxnGGXlStZhrS5KnXm9RF/3njLmoXJ0ojc
         8P7vuQ0HC9o8/Pkcqk9Ls+AeKjaahzl8TSBKFOmHIaNOxU3VHzfYtQizugyowuA0eQal
         65rpthXtkyvijigR5ss1vG927r0alj/9yjUiqKympze5gFAbjANcMb/Y0H6/PreuYlhu
         EKNdxmsrSlfrfycxI00781u/rkxUUlNPPpZQGMHVHJE+3GikmTl7vSMcOI8ggt0+vP3h
         +NPw==
X-Gm-Message-State: AJIora/e0ujrIKAVEZP9s0JjtwaQmfaMj32tcbU/+53QGp/TmMIHMMm4
        aRofMCtm27BMWU45kB5B7zVhf6oEoZd/wg==
X-Google-Smtp-Source: AGRyM1tgMCRsQtUK9GP7VPVBf7c03vp7rTUcUGjhkk/dHeWLXRZ5E4rohq6Q32jRxkmpGma54xeR0w==
X-Received: by 2002:ac8:5f09:0:b0:31e:9704:dfab with SMTP id x9-20020ac85f09000000b0031e9704dfabmr5648610qta.375.1657758858171;
        Wed, 13 Jul 2022 17:34:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a295200b006af0ce13499sm126812qkp.115.2022.07.13.17.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:34:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL
Date:   Wed, 13 Jul 2022 20:34:09 -0400
Message-Id: <0d44c8274ba71c4765edbcbe6afa5a7102a42d5c.1657758678.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657758678.git.josef@toxicpanda.com>
References: <cover.1657758678.git.josef@toxicpanda.com>
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
index 51096f88b8d3..26202918bc9f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -789,7 +789,6 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 		cache->cached = BTRFS_CACHE_FAST;
 	else
 		cache->cached = BTRFS_CACHE_STARTED;
-	set_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL, &cache->runtime_flags);
 	spin_unlock(&cache->lock);
 
 	write_lock(&fs_info->block_group_cache_lock);
@@ -1005,34 +1004,31 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		kobject_put(kobj);
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

