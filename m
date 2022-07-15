Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9D5767AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiGOTpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGOTpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:40 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D96392F
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:39 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g1so3588178qki.7
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kjkRwg8jfH6b+qiR1JFfbgIzBXQec75ehKw85ntmgHo=;
        b=H/ipUhBXJ8VxeF8x98xOsTReuCshgEKSwS4DokqKIXL+UAoeHChFsbaY/5lxNJ1eI7
         uC6jBy7cWEH2lPh6D+LHeBKoTZk4GpKNX1laz6mqSsF/DphI4AqhFg7C3KCKRUNXN9jS
         UR3ortKALZlVd4j+NcqdpVBO9iG4S8vA8MTcMUQ/mcPen26d0PvTG367Mjj4pBpFNBNd
         7q99VGmlBQiuZmNHs3cddziAXgIJo0H0a1dCiQzypczQpi8rNUvq+ST+9OXzeU9S9fh2
         QVlNOom7s9WJ/pAEnlCA8K/f8wpN5gGpXTML+fhXbgo/0XNfS+ZfQ9rGyF6KhueVg6QN
         NBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjkRwg8jfH6b+qiR1JFfbgIzBXQec75ehKw85ntmgHo=;
        b=wW44wVmohKhxe1zP9vy6CHCty7mcoX3reICQj8UwwI4xoaHsB2TSBWpPlhEh3U7oiJ
         /R+MGdPabPU4Z1KTSmeGEWy0bmEu4xmNgZDzI+Le8y/aMvutGNsOImbZvO7tD9SRk1dJ
         c53xsyQqHPn4BfLQDo6qeLtQ1+18GXcjfIlj65+fye/286/Vdcd6U2LuJdZMJ87UF0Jg
         qGGqkbrGrLXjIAiV3VNg5cED31Unh6YaOeU2TRcJXbhYe53cEqBLhXT3W7yiE5hECXK1
         N0hxtZYiF8iOA/w7PqRJPWY9SV+PJuWtXIQ6RY3fPYbqWofhCols7ZmZ/T5nF8BjxibV
         5TAg==
X-Gm-Message-State: AJIora9ATFikmjZtrXTaqedV+J6xfOSCrQif9h7TxdvyAjYC2HpsGFj5
        hgb0BXpaSNEs5NFVDyTpe59LRZDNfGFuDQ==
X-Google-Smtp-Source: AGRyM1v4CCFxauyw42oF4xxko4wpw8UyV8+eWda1Fm+d6gqx4r8RivrKjC1u1Re7h0EnuTMWy/dP0A==
X-Received: by 2002:a05:620a:1641:b0:6b5:bef0:e30 with SMTP id c1-20020a05620a164100b006b5bef00e30mr8362177qko.478.1657914338140;
        Fri, 15 Jul 2022 12:45:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id cm17-20020a05622a251100b00304f3e320f2sm4399768qtb.4.2022.07.15.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/9] btrfs: remove block_group->lock protection for TO_COPY
Date:   Fri, 15 Jul 2022 15:45:25 -0400
Message-Id: <321f4d3aeec3c8c56b16207cb62dd88da6c3a547.1657914198.git.josef@toxicpanda.com>
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

We use this during device replace for zoned devices, we were simply
taking the lock because it was in a bit field and we needed the lock to
be safe with other modifications in the bitfield.  With the bit helpers
we no longer require that locking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dev-replace.c | 5 -----
 fs/btrfs/scrub.c       | 3 ---
 fs/btrfs/volumes.c     | 2 --
 3 files changed, 10 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f85bbd99230b..488f2105c5d0 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -545,10 +545,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 		if (!cache)
 			continue;
 
-		spin_lock(&cache->lock);
 		set_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
-		spin_unlock(&cache->lock);
-
 		btrfs_put_block_group(cache);
 	}
 	if (iter_ret < 0)
@@ -610,9 +607,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 	}
 
 	/* Last stripe on this device */
-	spin_lock(&cache->lock);
 	clear_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
-	spin_unlock(&cache->lock);
 
 	return true;
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b7be62f1cd8e..14af085fe868 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3764,14 +3764,11 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		}
 
 		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
-			spin_lock(&cache->lock);
 			if (!test_bit(BLOCK_GROUP_FLAG_TO_COPY,
 				      &cache->runtime_flags)) {
-				spin_unlock(&cache->lock);
 				btrfs_put_block_group(cache);
 				goto skip;
 			}
-			spin_unlock(&cache->lock);
 		}
 
 		/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7637eae1a699..83c9bae144c7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6148,9 +6148,7 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 
 	cache = btrfs_lookup_block_group(fs_info, logical);
 
-	spin_lock(&cache->lock);
 	ret = test_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
-	spin_unlock(&cache->lock);
 
 	btrfs_put_block_group(cache);
 	return ret;
-- 
2.26.3

