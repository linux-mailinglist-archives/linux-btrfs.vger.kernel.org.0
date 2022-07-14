Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF052574093
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiGNAeU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 20:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiGNAeR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 20:34:17 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF7E11170
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:16 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cw12so351074qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kjkRwg8jfH6b+qiR1JFfbgIzBXQec75ehKw85ntmgHo=;
        b=63gv6sEit1a18HDiK/s1QOt6UF0M/GLuI9GecSVkIv3pUF4s9iLtJ4zvEdrIZeJQ3A
         vmP9cNeeOsv0I1NtjFNCY9GNeyEn6BpEI1w6wezN6uKNCIE6W+AjXSAQpabY5lqk+Xj/
         t3Gl/ARTfZHYfcLz2x5bj0quVoqounc97Qr9Oa6JkanGDV4x+OD+je/3CZt/ShG7DzdJ
         kqQVVK4BVSZzLkY1pveFySeV5gq/CWSgMGqICfAwop8zBS4ozOHhc4AQkj6TTU5ULtZV
         aOOjF/2nruP8T96/lXO4YNiBaFDmNb5gkt2KXEk8eUB60bPsMrF3d368+nV1utE/sh+5
         2FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjkRwg8jfH6b+qiR1JFfbgIzBXQec75ehKw85ntmgHo=;
        b=f9rfGDWqBxkEifPYhSzExUqqj1gzOdLQTXOeSYB7vV8t/uTNNzWsCgrLtDitpvAT0h
         q7cCDIFLjbuKOglO3X88ylE1QE4WGV2of3foydEn/dkI+nVruOchOev34ra4jQWHZgc8
         uCVo1LSD6wpGELs1arA8L/XzpJ6t9i5oRgxSgBzff63iCQjQ8MoAQUDEqJiR4b9QPObZ
         XHITzcOCx+fKUY1CD6nMxyNYPBVRkVvwkW79MW5QsIhLMkGfcslvT7wsTtx2ZZHaWCCN
         M66PdadoxytqTFU9fd9OFAxUtM0mIY4O/wURvH3MUzQHRgFaZzTnQ/v6HXjRSG0IMVT9
         Z/Kw==
X-Gm-Message-State: AJIora//XtQmKiP0//Pj5lzgZISLN0d7cO9T4hc141i5frxXfgBWCwt5
        eL4AsLBPU/RojHvOG+hlqw+D7qt0tnFg1Q==
X-Google-Smtp-Source: AGRyM1v8a48Mm6HtZz7G9TfnKMIhVTuTX8yJUfX7qAKO/uZSoMy3vz7Y7FYgyzEOvlWQFDK6TSEg1A==
X-Received: by 2002:ad4:5be6:0:b0:473:9831:541a with SMTP id k6-20020ad45be6000000b004739831541amr4145929qvc.118.1657758855247;
        Wed, 13 Jul 2022 17:34:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i20-20020a05620a405400b006b1eb3a8364sm192521qko.5.2022.07.13.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:34:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: remove block_group->lock protection for TO_COPY
Date:   Wed, 13 Jul 2022 20:34:07 -0400
Message-Id: <7274bb25f458795173dabe6a3c84363a5d100450.1657758678.git.josef@toxicpanda.com>
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

