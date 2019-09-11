Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF2AFFF2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfIKP0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 11:26:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37668 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfIKP0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so18299064qkd.4
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vHCP+hHJvToV9YWamNnRTjUFVOTcK8JGrxTKm0NP8ew=;
        b=wKuNUBH40jptzqO76a7vPf2iFh++tx10Vfu/scsq+eVNNTWpOTFZXTl2qVxDk6ByQ+
         gXHFffehlN2l+BW25qf/+9yjUvdZath2jiFQV2zRyp5B6k3wbNnMhC6qCOQauKGjdHnl
         dmtlA+t6rZ9gtkX46bzO/sh6JwKWRTV6+FGv6CE42ii4EYo+HQXGPTcVKDjTYPNfn1E6
         HA6mRqw6ax1ANl1LYwEU2Pxzv2xYXz20jvIKFRFBYJaBfxDofjv6PG1Qe974pP7lInra
         LOlQ4VaXo0JvbZRw4MS4YOIgl5FWaOgTdY8O/cZRbuERTTfH3ZR5/LYfQNSheGgOd8Py
         uDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHCP+hHJvToV9YWamNnRTjUFVOTcK8JGrxTKm0NP8ew=;
        b=lM9THrN8P4nAobvqMEECtupbhDsiE860MLOYVOcsrUHy6dCdXFmuyz8LHJR63WCNyV
         jVycbsi23FhpK6mrqesMOnr6fScgM6+LOFfjevzGmJHXWQqSZeAtanl5SqnOFAz5b+iH
         FVrJ3oJ1sIrIr/7NE62FeM7DYJdImgy99nQ6YA3gUTVKkE1Ig0GbL0MExU4/hmB1A5ky
         +JSchOOxfVeS6Db/5UVzgmDpEVJ5xfT49wLyYzrc4Mfq6owT5P5cf3QX1770AvaKSr+/
         dy+NBlneuFhhz2Mg9gdI1ERkJlbM3vgh+U6XzLtqNq3cBpzNeTTHRUdc5Wnb3agDnHVC
         f8Eg==
X-Gm-Message-State: APjAAAVsffNuDIor2xuk35/pREZIDCcyBLsuc9R+WArbdOpMzu4yVCiq
        U8eTPXAzzm3SYNaCjcuDCTB/umAUDlfW3w==
X-Google-Smtp-Source: APXvYqy5ZEf3GJ38xM8Xb19F8vspvtUba7n+gacg+0md8tm0gZsDotn8vWWtOSoLGsjdsD2j8X2U+Q==
X-Received: by 2002:a37:5187:: with SMTP id f129mr34807326qkb.382.1568215578336;
        Wed, 11 Sep 2019 08:26:18 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f24sm9210574qkl.135.2019.09.11.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 08:26:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs: separate out the extent io init function
Date:   Wed, 11 Sep 2019 11:26:04 -0400
Message-Id: <20190911152611.3393-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911152611.3393-1-josef@toxicpanda.com>
References: <20190911152611.3393-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are moving extent_io_tree into it's on file, so separate out the
extent_state init stuff from extent_io_tree_init().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++++-------
 fs/btrfs/extent_io.h |  2 ++
 fs/btrfs/super.c     |  9 ++++++++-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b4b786a9d870..bdd9b7f5a295 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -201,19 +201,23 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
 	return ret;
 }
 
-int __init extent_io_init(void)
+int __init extent_state_cache_init(void)
 {
 	extent_state_cache = kmem_cache_create("btrfs_extent_state",
 			sizeof(struct extent_state), 0,
 			SLAB_MEM_SPREAD, NULL);
 	if (!extent_state_cache)
 		return -ENOMEM;
+	return 0;
+}
 
+int __init extent_io_init(void)
+{
 	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
 			sizeof(struct extent_buffer), 0,
 			SLAB_MEM_SPREAD, NULL);
 	if (!extent_buffer_cache)
-		goto free_state_cache;
+		return -ENOMEM;
 
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
 			offsetof(struct btrfs_io_bio, bio),
@@ -231,24 +235,24 @@ int __init extent_io_init(void)
 free_buffer_cache:
 	kmem_cache_destroy(extent_buffer_cache);
 	extent_buffer_cache = NULL;
+	return -ENOMEM;
+}
 
-free_state_cache:
+void __cold extent_state_cache_exit(void)
+{
+	btrfs_extent_state_leak_debug_check();
 	kmem_cache_destroy(extent_state_cache);
-	extent_state_cache = NULL;
-	return -ENOMEM;
 }
 
 void __cold extent_io_exit(void)
 {
 	btrfs_extent_buffer_leak_debug_check();
-	btrfs_extent_state_leak_debug_check();
 
 	/*
 	 * Make sure all delayed rcu free are flushed before we
 	 * destroy caches.
 	 */
 	rcu_barrier();
-	kmem_cache_destroy(extent_state_cache);
 	kmem_cache_destroy(extent_buffer_cache);
 	bioset_exit(&btrfs_bioset);
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index cf3424d58fec..e813f593202d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -556,4 +556,6 @@ bool find_lock_delalloc_range(struct inode *inode,
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start);
 
+int __init extent_state_cache_init(void);
+void __cold extent_state_cache_exit(void);
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1b151af25772..843015b9a11e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2360,10 +2360,14 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_cachep;
 
-	err = extent_map_init();
+	err = extent_state_cache_init();
 	if (err)
 		goto free_extent_io;
 
+	err = extent_map_init();
+	if (err)
+		goto free_extent_state_cache;
+
 	err = ordered_data_init();
 	if (err)
 		goto free_extent_map;
@@ -2422,6 +2426,8 @@ static int __init init_btrfs_fs(void)
 	ordered_data_exit();
 free_extent_map:
 	extent_map_exit();
+free_extent_state_cache:
+	extent_state_cache_exit();
 free_extent_io:
 	extent_io_exit();
 free_cachep:
@@ -2442,6 +2448,7 @@ static void __exit exit_btrfs_fs(void)
 	btrfs_prelim_ref_exit();
 	ordered_data_exit();
 	extent_map_exit();
+	extent_state_cache_exit();
 	extent_io_exit();
 	btrfs_interface_exit();
 	btrfs_end_io_wq_exit();
-- 
2.21.0

