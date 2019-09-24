Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870E5BD3A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 22:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439419AbfIXUdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 16:33:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45810 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437989AbfIXUdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 16:33:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so3192917qkb.12
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jq3faWqMSoEEPyOswvh/pf1xQgFAzhb4c/h70agWqr0=;
        b=nF5ximpvlgg2H68s4a40wHb7tdJ4t68vU+i7EEm8DQtJxxzU1iQ0lodQTft2G8wQFS
         BQ52KgipBZ6yn3Wghjj4OlIE7PH6aM2X5HQp5SwF/MD/E6BIIB++kd9Qx0OXqPJA2e4D
         IPB97JeDA6P3xKjlvjxHcB6aarJKH+Ms6pcwiwdANcT4kWWk3n+brZVUemX/+1HxZ1Au
         +7AWB/habQXGkMlebZ5yjbeqP+da2y1pMndssUOALpL/R4IufoZ3R5QT+3iRyoZByVEh
         a44AqfYy13jRkZcuvIRJe3viF2tHWySranc8uYeEIYLJ+b/Wkm5hfu7QffMTOXSm1Yy3
         pVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jq3faWqMSoEEPyOswvh/pf1xQgFAzhb4c/h70agWqr0=;
        b=Rv/8kke7NHWcoLxXT/+eVwtFGfcc87CP7LGJ+TFMZk8sFY+tJMM4Jm3ateUwzlyF0r
         nvP81H3sVULKhQtiHxw9rNZS5wbUuSoSMT1Xr7sqHz+RKnOjjBIDE8IOlDcyC0wPTl4Q
         WdCfMAsbDU6WsC7hFYsTELOZJ0t6/f7MjGqNlR+3y2VyNPSFTBTKhlY6rzyf4cX10c2p
         PNkBRS/NxLezfqsNN6PIPN0KrJIGRbMo6Orw949uUzO4QHPEFO4djTfSjTQ4axsxh48L
         2LbbwT6TQF7kyNAAf9Yvsp8VZZotj4QbmGXsIxu/kQM/0Ha1e4mXBGrlOjMOPB3gOI+1
         +aEw==
X-Gm-Message-State: APjAAAWWE506TN+EvQ48YcoYmvLhJdMR2vJV+Bl6ZhySTTPSa7TsDlzA
        fEquN0PTQxWGYftCTKbCdrwI0nSURBBQ6Q==
X-Google-Smtp-Source: APXvYqwD8eKiDsdiq1eokYECNJUFfEb7FZtQqJJgXQcv3jLH0YbD5VQOUGxhKU3GL2zKnOX9tGHf3g==
X-Received: by 2002:a37:a411:: with SMTP id n17mr4612701qke.216.1569357179754;
        Tue, 24 Sep 2019 13:32:59 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y26sm1604188qkj.75.2019.09.24.13.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 13:32:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: separate out the extent buffer init code
Date:   Tue, 24 Sep 2019 16:32:50 -0400
Message-Id: <20190924203252.30505-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924203252.30505-1-josef@toxicpanda.com>
References: <20190924203252.30505-1-josef@toxicpanda.com>
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
index 2e40ce6d0452..07ef107f0e6c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -136,32 +136,30 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
 
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
 
@@ -171,6 +169,10 @@ void __cold extent_io_exit(void)
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

