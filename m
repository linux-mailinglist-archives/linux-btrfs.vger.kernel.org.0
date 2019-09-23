Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9EBB633
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407361AbfIWOFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:05:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40927 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407326AbfIWOFo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:05:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id x5so17260676qtr.7
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0N1RNqcL26KtLzdQqsGahUX1TgqJkw8YRJIm4AvUHAk=;
        b=fHl9jzwTjSVbYg6WgW86yn+L6UqbhhhzxF8oJSUu7cFMkjE/YlT/i4JZ+lRo2b+oKx
         yrJX84GcyzLprJdDjzKE7t2GXFvccYZ/fuC+d/CgD9g7puem6SxyZjHHKbsBirlVpDrK
         x+HKwVrD5P6q8Zu+S7YlWlIrRzbYimNKDdfOgb0Z3b5hV9f0u+KFz9aszAlGP7ugSvRa
         Jap92AD4icdEDnqi20cM0JQU/GOwDddO6GdPsHWhn5yLUutAROcvqB2AXhKJYyVtMqrO
         ezZCE04U2Rq5lQGryRg2Ze6DeNSbJNrXRW1NgP3KOoLNUvaBfkKVxDKG/tNdCe8tw8Ji
         wjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0N1RNqcL26KtLzdQqsGahUX1TgqJkw8YRJIm4AvUHAk=;
        b=Vzk22tMIIhycPKw0Z18kmfY3EP3apqTmmdIE9StZW2FQyruVvHV81obHn4se31ai90
         C9tZRJAD6B+955WS+Vea96cAADe1SRa7r711KTx/RbEAhyDjdmQ9UKs9mLVQc8TH8yis
         gaYPhWXCAxg5bBDi60cbn4x7OqfVYmMJ0EbdnozqAT72RmMyZJ6zPIg/NsYBj2T+LyOb
         RczJSa05lTUv+CWTVUzrfE04FPCgPeKy+OabmHGeK8W+7rWA6GbGrvr9aSw9boRG9pKV
         IjnmlpIrWt3x+KVUa6i4RvHx+Xqm/ZEJI2HgEh0c6Y1BByLIIHFWLAzywfKqbBR7BSWf
         84zA==
X-Gm-Message-State: APjAAAUOgqr4uc8Lgor1M7x6D9n7WhC3mQ0uQIhH2AZN5r6vDnVafJMG
        yaj+F410ONKTG6BDQoc9Rbge7q9ditUE/A==
X-Google-Smtp-Source: APXvYqxMSsvBMItJdrviEn6Ctgk2Bpexdw5zjUR1xVg+WYZuzs7SexIGGe3NwODYVyD9b8Z5oi63DQ==
X-Received: by 2002:ac8:75c6:: with SMTP id z6mr15498qtq.375.1569247543338;
        Mon, 23 Sep 2019 07:05:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 92sm5751872qte.30.2019.09.23.07.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:05:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: separate out the extent buffer init code
Date:   Mon, 23 Sep 2019 10:05:23 -0400
Message-Id: <20190923140525.14246-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923140525.14246-1-josef@toxicpanda.com>
References: <20190923140525.14246-1-josef@toxicpanda.com>
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
index 4adcdcdd80c3..e4bc40302225 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -137,32 +137,30 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
 
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
 
@@ -172,6 +170,10 @@ void __cold extent_io_exit(void)
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

