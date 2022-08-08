Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60BB58CEE9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 22:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbiHHUKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbiHHUKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 16:10:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA1E1C
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 13:10:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ct13so7150843qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CsbkyX5GgHkVLzNpcD5gZN5JJcPm7Aoi+Rr8DQx58Rg=;
        b=W5plFGqi4pNwg9Xjo6W3U+Z0edvE0g1qPxAJd3CYCPhPko7eRkV+kBAyrYmkcnl3Nh
         m2FonBlG2+0z2R+CNU/Pd902fDnJGAXzK0kekwHg9dg5egyNRYRjo6NcgfI4uIg1zdtJ
         JKHiMKFy5L/kEuOa6lj0XY5vEtRn2Tg1O00XLg3326kztknu6U7NJ7DScYZ7ErAgokxS
         H2StblncvwHIS7qzwH0Qj7RkVlUOmxCE4xGGSGJaZjfmjpj7aKFuc6WNGxmUjyIhO3Y9
         wHnoBtVeWYGpnuY7Kq7nBUI+dLkt2WVuvx2k6DHe7mOsujiom+dPZBf6GeR6X+loIxIP
         8KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsbkyX5GgHkVLzNpcD5gZN5JJcPm7Aoi+Rr8DQx58Rg=;
        b=KAQDWDxWTs5eF9f1lKyqnxpskginAzhuq5UZ5pR3kVBkZ1VSMfZtoKdsxRYxMiic9U
         h1TVFx7aRlVmuul8LPp224BFGvuvt3eJLTh/apYEo/JG0rTSbePwcV2GmFwtpgg2ftqK
         ID13QB0MYmQlayOnuP4QA1iFOfO3PHfGaj//YW8NaMoI8qOts9ztZC/q7M6S3HeELy8W
         44YNMosX/U64oAKFm0049zO7cA8KKDimGBRYvV0RcXL6eh2EIP6NNOlOf7noh5XDlH7H
         dYefQcpmdTv1unYihTtMk2AeJEfKN0nohQU3W1mHMa3mK4wvE8F+/GjvaptagfPUAu7w
         a6lg==
X-Gm-Message-State: ACgBeo3phI+ZpFcZmNfIYCjQpbIFomuPsZqsxbRUSFG+2iPG2wDsPQs1
        p5qK2fdPDlrR7zyj1oRtLWjLEdth/XGfkA==
X-Google-Smtp-Source: AA6agR7HLDeOzEF4jKzoIbFdSawOOxkMEsXJNi91E60Fc28zU9d0WIQQo+mnRbxLlARK2uzbWnGHUw==
X-Received: by 2002:a0c:a90f:0:b0:473:93b1:81ef with SMTP id y15-20020a0ca90f000000b0047393b181efmr17043489qva.27.1659989433547;
        Mon, 08 Aug 2022 13:10:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id gd9-20020a05622a5c0900b0031eb393aa45sm8705338qtb.40.2022.08.08.13.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:10:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: remove use btrfs_remove_free_space_cache instead of variant
Date:   Mon,  8 Aug 2022 16:10:27 -0400
Message-Id: <8dd29aebfc9d33f400ba60d916fcb4df1aa30d8c.1659989333.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1659989333.git.josef@toxicpanda.com>
References: <cover.1659989333.git.josef@toxicpanda.com>
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

We are calling __btrfs_remove_free_space_cache everywhere to cleanup the
block group free space, however we can just use
btrfs_remove_free_space_cache and pass in the block group in all of
these places.  Then we can remove __btrfs_remove_free_space_cache and
rename __btrfs_remove_free_space_cache_locked to
__btrfs_remove_free_space_cache.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c            |  2 +-
 fs/btrfs/free-space-cache.c       | 26 ++++----------------------
 fs/btrfs/free-space-cache.h       |  1 -
 fs/btrfs/tests/btrfs-tests.c      |  2 +-
 fs/btrfs/tests/free-space-tests.c | 22 +++++++++++-----------
 5 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c8162b8d85a2..699b69be2cb9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4132,7 +4132,7 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 		 * tasks trimming this block group have left 1 entry each one.
 		 * Free them if any.
 		 */
-		__btrfs_remove_free_space_cache(block_group->free_space_ctl);
+		btrfs_remove_free_space_cache(block_group);
 	}
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ca9b190f3b80..6b70371d4918 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -48,8 +48,7 @@ static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 			      struct btrfs_free_space *info, u64 offset,
 			      u64 bytes, bool update_stats);
 
-static void __btrfs_remove_free_space_cache_locked(
-				struct btrfs_free_space_ctl *ctl)
+static void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 {
 	struct btrfs_free_space *info;
 	struct rb_node *node;
@@ -898,12 +897,8 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 free_cache:
 	io_ctl_drop_pages(&io_ctl);
 
-	/*
-	 * We need to call the _locked variant so we don't try to update the
-	 * discard counters.
-	 */
 	spin_lock(&ctl->tree_lock);
-	__btrfs_remove_free_space_cache_locked(ctl);
+	__btrfs_remove_free_space_cache(ctl);
 	spin_unlock(&ctl->tree_lock);
 	goto out;
 }
@@ -1040,12 +1035,8 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 		if (ret == 0)
 			ret = 1;
 	} else {
-		/*
-		 * We need to call the _locked variant so we don't try to update
-		 * the discard counters.
-		 */
 		spin_lock(&ctl->tree_lock);
-		__btrfs_remove_free_space_cache_locked(&tmp_ctl);
+		__btrfs_remove_free_space_cache(&tmp_ctl);
 		spin_unlock(&ctl->tree_lock);
 		btrfs_warn(fs_info,
 			   "block group %llu has wrong amount of free space",
@@ -3010,15 +3001,6 @@ static void __btrfs_return_cluster_to_free_space(
 	btrfs_put_block_group(block_group);
 }
 
-void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
-{
-	spin_lock(&ctl->tree_lock);
-	__btrfs_remove_free_space_cache_locked(ctl);
-	if (ctl->block_group)
-		btrfs_discard_update_discardable(ctl->block_group);
-	spin_unlock(&ctl->tree_lock);
-}
-
 void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
@@ -3036,7 +3018,7 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 
 		cond_resched_lock(&ctl->tree_lock);
 	}
-	__btrfs_remove_free_space_cache_locked(ctl);
+	__btrfs_remove_free_space_cache(ctl);
 	btrfs_discard_update_discardable(block_group);
 	spin_unlock(&ctl->tree_lock);
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 15591b299895..6d419ba53e95 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -113,7 +113,6 @@ int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 				       u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			    u64 bytenr, u64 size);
-void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
 void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group);
 bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group);
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index cc9377cf56a3..9c478fa256f6 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -243,7 +243,7 @@ void btrfs_free_dummy_block_group(struct btrfs_block_group *cache)
 {
 	if (!cache)
 		return;
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 	kfree(cache->free_space_ctl);
 	kfree(cache);
 }
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index 5930cdcae5cb..ebf68fcd2149 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -82,7 +82,7 @@ static int test_extents(struct btrfs_block_group *cache)
 	}
 
 	/* Cleanup */
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 
 	return 0;
 }
@@ -149,7 +149,7 @@ static int test_bitmaps(struct btrfs_block_group *cache, u32 sectorsize)
 		return -1;
 	}
 
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 
 	return 0;
 }
@@ -230,7 +230,7 @@ static int test_bitmaps_and_extents(struct btrfs_block_group *cache,
 		return -1;
 	}
 
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 
 	/* Now with the extent entry offset into the bitmap */
 	ret = test_add_free_space_entry(cache, SZ_4M, SZ_4M, 1);
@@ -266,7 +266,7 @@ static int test_bitmaps_and_extents(struct btrfs_block_group *cache,
 	 *      [ bitmap ]
 	 *        [ del ]
 	 */
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 	ret = test_add_free_space_entry(cache, bitmap_offset + SZ_4M, SZ_4M, 1);
 	if (ret) {
 		test_err("couldn't add bitmap %d", ret);
@@ -291,7 +291,7 @@ static int test_bitmaps_and_extents(struct btrfs_block_group *cache,
 		return -1;
 	}
 
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 
 	/*
 	 * This blew up before, we have part of the free space in a bitmap and
@@ -317,7 +317,7 @@ static int test_bitmaps_and_extents(struct btrfs_block_group *cache,
 		return ret;
 	}
 
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 	return 0;
 }
 
@@ -629,7 +629,7 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	if (ret)
 		return ret;
 
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 
 	/*
 	 * Now test a similar scenario, but where our extent entry is located
@@ -819,7 +819,7 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 		return ret;
 
 	cache->free_space_ctl->op = orig_free_space_ops;
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 
 	return 0;
 }
@@ -868,7 +868,7 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	}
 
 	/* Now validate bitmaps do the correct thing. */
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 	for (i = 0; i < 2; i++) {
 		offset = i * BITS_PER_BITMAP * sectorsize;
 		bytes = (i + 1) * SZ_1M;
@@ -891,7 +891,7 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	}
 
 	/* Now validate bitmaps with different ->max_extent_size. */
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 	orig_free_space_ops = cache->free_space_ctl->op;
 	cache->free_space_ctl->op = &test_free_space_ops;
 
@@ -998,7 +998,7 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	}
 
 	cache->free_space_ctl->op = orig_free_space_ops;
-	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	btrfs_remove_free_space_cache(cache);
 	return 0;
 }
 
-- 
2.26.3

