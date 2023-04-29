Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802C6F262F
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjD2UHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjD2UHc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:32 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A952B1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:31 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fe25c2765so20037017b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798850; x=1685390850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/7el9dzDebHbMEYNB5E3CBrWi/19wcM8pDAIzADdvs=;
        b=pIDj80Xa+pdOfLO63TibdBrbcN8NGeCfsBN1IJtUl7utgwJj4O1NahDBMp5Pfua4xU
         ygzXu+JLPmOA7SEG91uLSJ4ip4yX6+WxQZhektDsDXn4aneVKdfuqRYH8zWw5+mI2iif
         gspkKXyuMfK1Hj6gGooMfHxbSOFdjMF7Imys70HYwUD+sXoIzM95zg9mCPNlLUX94i+a
         GJRgS1yhk2RUAH29MGg7+NaQHcwVBD7ACHkt453t92HyF1g5t9jq9l8CEJvLNi1u82dx
         fjQxLnVZRDjDkO+kUqT+AdDxAWolUhnhKpAEih2t5m3L5SMg9ghFMg4pMnZ3C2VKDkzc
         9ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798850; x=1685390850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/7el9dzDebHbMEYNB5E3CBrWi/19wcM8pDAIzADdvs=;
        b=be6DXU/y4VM8nJr6xNdL7DGrkEqt/4vIUrx1vUmxw55KiTFPBILEk3Q8q/A+AAg0FJ
         kqS1fHD9u3xXt2UqqxPlDgYBJbuxQVLBhTGY61x3OOEtWavwvhLV2aOSziTEL9MWFkYW
         hyuUhqu3dtZFlfBuTWL7bSZ1rfajyXG4DDzRwVtc3QdsNgfXZy7zf00I//JqoEPeWVVj
         ImN4y3Mmqfs5XB6rdnub6dSD8Pk+KCj1ncwGcRuW2UOvyuZiheJQavOa9zaiHAZfuPe9
         90OhFbBQXEmKL1eQRlOHgRttqKMFv49KNUHzckmHql+GM+X2vbEyHc1HbIWN3kz3BRgT
         +4hw==
X-Gm-Message-State: AC+VfDyELWBHhpXVAi+0s+ueVCXVfMGbXbyWo+M7iBzMf/z5NnmGmFpM
        OoLYGgaLbkG47+WdyrbZJnJdC6oZ0qXsbCIuiUt6EA==
X-Google-Smtp-Source: ACHHUZ5eM7u+gswCwzm19A1I41E2HtwaaszkDBOHGTa7hb4b4vr5UZSV0unUfkqBmHDUSrbyC7cnBw==
X-Received: by 2002:a81:d351:0:b0:556:1cbb:fa1d with SMTP id d17-20020a81d351000000b005561cbbfa1dmr7926236ywl.38.1682798850155;
        Sat, 29 Apr 2023 13:07:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g143-20020a815295000000b00545a08184c1sm6280764ywb.81.2023.04.29.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/12] btrfs: move btrfs_check_trunc_cache_free_space into block-rsv.c
Date:   Sat, 29 Apr 2023 16:07:10 -0400
Message-Id: <2b127b68d0e4faf2e0950c16dcaf4d0d4542a232.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

This is completely related to block rsv's, move it out of the free space
cache code and into block-rsv.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c        | 19 +++++++++++++++++++
 fs/btrfs/block-rsv.h        |  2 ++
 fs/btrfs/free-space-cache.c | 19 -------------------
 fs/btrfs/free-space-cache.h |  2 --
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 3ab707e26fa2..156ddb557004 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -540,3 +540,22 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 
 	return ERR_PTR(ret);
 }
+
+int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
+				       struct btrfs_block_rsv *rsv)
+{
+	u64 needed_bytes;
+	int ret;
+
+	/* 1 for slack space, 1 for updating the inode */
+	needed_bytes = btrfs_calc_insert_metadata_size(fs_info, 1) +
+		btrfs_calc_metadata_size(fs_info, 1);
+
+	spin_lock(&rsv->lock);
+	if (rsv->reserved < needed_bytes)
+		ret = -ENOSPC;
+	else
+		ret = 0;
+	spin_unlock(&rsv->lock);
+	return ret;
+}
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 6dc781709aca..b0bd12b8652f 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -82,6 +82,8 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info);
 struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 					    struct btrfs_root *root,
 					    u32 blocksize);
+int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
+				       struct btrfs_block_rsv *rsv);
 static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
 					 struct btrfs_block_rsv *block_rsv,
 					 u32 blocksize)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d84cef89cdff..5cef89162193 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -292,25 +292,6 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
-				       struct btrfs_block_rsv *rsv)
-{
-	u64 needed_bytes;
-	int ret;
-
-	/* 1 for slack space, 1 for updating the inode */
-	needed_bytes = btrfs_calc_insert_metadata_size(fs_info, 1) +
-		btrfs_calc_metadata_size(fs_info, 1);
-
-	spin_lock(&rsv->lock);
-	if (rsv->reserved < needed_bytes)
-		ret = -ENOSPC;
-	else
-		ret = 0;
-	spin_unlock(&rsv->lock);
-	return ret;
-}
-
 int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 				    struct btrfs_block_group *block_group,
 				    struct inode *vfs_inode)
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index a855e0483e03..33b4da3271b1 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -101,8 +101,6 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 				  struct inode *inode,
 				  struct btrfs_block_group *block_group);
 
-int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
-				       struct btrfs_block_rsv *rsv);
 int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 				    struct btrfs_block_group *block_group,
 				    struct inode *inode);
-- 
2.40.0

