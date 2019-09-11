Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938E0AFFF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfIKP03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 11:26:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40743 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfIKP03 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so13130880qkb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B6hJSVUHrKZ8eY2kCiTt3uaSh6jMgto2MY5oGUhfO1w=;
        b=rQUz5q/ZSiOmkfG/YP0/1imJNMco8jYd9KXUCFyf4obvYkgYSel2dAdVbnouTfL4B9
         hdOcBDBtl4Ls1EBq1/Ftqc8COdLrgmWA4M+219tJrPbTCQBPaq/2/i7t3d6V3bx05Dem
         v8GOQ4pcp0+tF+bKCx1oM8qLV7eM/q4zWDxm//ScXrBlV5QCrb+dX0l2Fq1FJmx3geXP
         vT7SpBw3Y6r447jS6a0bwfK++G5YErjtPKg4IFjQMxLXBHaQQ6zD0RXH3j1bErs0n6I7
         L6jYzbJx1ID17yFLUrjlxBMPdJlOJB+XSnTYpb+jtLzHmRL3YK1w7JhvXVdx334b+5XS
         +S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6hJSVUHrKZ8eY2kCiTt3uaSh6jMgto2MY5oGUhfO1w=;
        b=S0vMpZpX9Gwrlg2FCaiBDAHaG4v7HSUWLfhl8nNVOqCNdfCyAdOuudV0XNfT3jM6Sp
         ZT2U20jRtGu4ufx0ZyLICk8Xm5SQ2wWvqb5YNqLAINrTTwGmc4xfGve+AKStyXQ39SRV
         iptxQd6paAKZsHOss+XoRhF/u62cKJrudiSz3Ze0RECMuS67/Ibq2ApCRZ4hbcDs124x
         /aV5f9/ZJ9/hQm2ygl1Dy3Y3cXre4O5DWzo4fwMW0VQ15QXcbYp7M9NziN2jNqhT9bo0
         vq8JYwHHMEQbdCmtLYEIFiVwU4LRY1wO0e1Z87w9xyw8/ks1iVme9Di1/R+LlI86wi6g
         jJSw==
X-Gm-Message-State: APjAAAUzn/NCzFj9Oha7k+OlzB14jAlU2ezS7AFPYJqaGc7Mj9Gl3dgU
        BXgvSPS7RD4plpMV7mqAVFVzX71pHQEwFg==
X-Google-Smtp-Source: APXvYqyaJ9+Vi0PHG87S9g5RqkTyk/SYTjgYYbA1Zvo/MM9RoDBzbJqpbzP1fOYEsS8JBSn9gnHfMg==
X-Received: by 2002:a37:9c81:: with SMTP id f123mr36018681qke.66.1568215587717;
        Wed, 11 Sep 2019 08:26:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b1sm5101875qkk.72.2019.09.11.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 08:26:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: separate out the extent buffer init code
Date:   Wed, 11 Sep 2019 11:26:09 -0400
Message-Id: <20190911152611.3393-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911152611.3393-1-josef@toxicpanda.com>
References: <20190911152611.3393-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to move this into it's own file, so separate out the init/exit
code for setting up the extent_buffer cache.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 36 +++++++++++++++++++-----------------
 fs/btrfs/extent_io.h |  2 ++
 fs/btrfs/super.c     |  9 ++++++++-
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 80c105b78bbf..d8acf5df35e7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -135,32 +135,30 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
 
 int __init extent_io_init(void)
 {
-	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
-			sizeof(struct extent_buffer), 0,
-			SLAB_MEM_SPREAD, NULL);
-	if (!extent_buffer_cache)
-		return -ENOMEM;
-
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
 			offsetof(struct btrfs_io_bio, bio),
 			BIOSET_NEED_BVECS))
-		goto free_buffer_cache;
+		return -ENOMEM;
 
-	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE))
-		goto free_bioset;
+	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE)) {
+		bioset_exit(&btrfs_bioset);
+		return -ENOMEM;
+	}
 
 	return 0;
+}
 
-free_bioset:
-	bioset_exit(&btrfs_bioset);
-
-free_buffer_cache:
-	kmem_cache_destroy(extent_buffer_cache);
-	extent_buffer_cache = NULL;
-	return -ENOMEM;
+int __init extent_buffer_init(void)
+{
+	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
+			sizeof(struct extent_buffer), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!extent_buffer_cache)
+		return -ENOMEM;
+	return 0;
 }
 
-void __cold extent_io_exit(void)
+void __cold extent_buffer_exit(void)
 {
 	btrfs_extent_buffer_leak_debug_check();
 
@@ -170,6 +168,10 @@ void __cold extent_io_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(extent_buffer_cache);
+}
+
+void __cold extent_io_exit(void)
+{
 	bioset_exit(&btrfs_bioset);
 }
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e22045cef89b..e2246956e544 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -332,4 +332,6 @@ bool find_lock_delalloc_range(struct inode *inode,
 #endif
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start);
+int __init extent_buffer_init(void);
+void __cold extent_buffer_exit(void);
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 843015b9a11e..7207bb39f236 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2360,10 +2360,14 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_cachep;
 
-	err = extent_state_cache_init();
+	err = extent_buffer_init();
 	if (err)
 		goto free_extent_io;
 
+	err = extent_state_cache_init();
+	if (err)
+		goto free_extent_buffer;
+
 	err = extent_map_init();
 	if (err)
 		goto free_extent_state_cache;
@@ -2428,6 +2432,8 @@ static int __init init_btrfs_fs(void)
 	extent_map_exit();
 free_extent_state_cache:
 	extent_state_cache_exit();
+free_extent_buffer:
+	extent_buffer_exit();
 free_extent_io:
 	extent_io_exit();
 free_cachep:
@@ -2449,6 +2455,7 @@ static void __exit exit_btrfs_fs(void)
 	ordered_data_exit();
 	extent_map_exit();
 	extent_state_cache_exit();
+	extent_buffer_exit();
 	extent_io_exit();
 	btrfs_interface_exit();
 	btrfs_end_io_wq_exit();
-- 
2.21.0

