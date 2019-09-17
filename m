Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E36B5587
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfIQSnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 14:43:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33066 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfIQSnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 14:43:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so5174153qkb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vHCP+hHJvToV9YWamNnRTjUFVOTcK8JGrxTKm0NP8ew=;
        b=WDb82yo6EG5tYsIhNh1BVL9psSHi4meuLNPHEm8hwpLsjG26p+Rg8Pw8Md5BUiVDJq
         y82IhDjpgrvIHT7E06GUeyH8+pzjL/Z/mmd7a3R+a3AAzKwtxRxBxkaLPfXZtVvykFbK
         OaU6VxoqyN2HYoOXobCs1dkVga+dwEJXh04duHQk8Ds287hTUcH9MYC9xVQ8mdUuWFuG
         jVSIi+T7E7YujE31KU/QwNmArPtCBEAyBmpxB+m+JeX8klm0mIBlhMsyXnknEwevwOe7
         h3VbbekAMkDT+F4EO1Sd0si1P1NOfJIEHvGbbvI+mLRD1Qg0VGxacPWV5hfssB1lMSaf
         +UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHCP+hHJvToV9YWamNnRTjUFVOTcK8JGrxTKm0NP8ew=;
        b=owv7Dp1K32VYvGYDVrBA/WFR/KSGGf1MbgfOt5TZbjM5PCCD3pIcde2PL3PghF3FB/
         pfcbf/zoNZ0RenCET3FvPiQnAOKVbnTlkdLN75fDOFgHlC4LDGI9OJ+8+Q3JrRHc4vHv
         a/5xI2kjanybD9OpvP6GKK/fXV/SdADt60xbxxrICHilhoipJmjtr2jJiUEwiP2QiDuv
         NNDz7DSvuR4MGQBFdC545ips+DcdU9f1e4671LvKz5HAdkVfz3zIpmTaA1ZM+xWvP828
         ng2j4ksmML64t6ClwZpZcKa6w8dJpW//ZE/C4FdoMNyUJ5CKo/LNo+HK+7kUDnbHwZKN
         oLEQ==
X-Gm-Message-State: APjAAAWoe9EbhO01uxxMvqCSKEQMuP+kDKtyh1uL/ZeanOnLMa/bBiIi
        JuYVyjug5iAIUvAf9/6BQzks2+iw+IUe0w==
X-Google-Smtp-Source: APXvYqzA0pFqaW3YN4CfY+HFSuxnAbAftM2B9A6G5gloOJnMSsM6XhwSPqQJ+e8Y0d38kOXH8O8HUA==
X-Received: by 2002:a37:a704:: with SMTP id q4mr5110546qke.385.1568745830393;
        Tue, 17 Sep 2019 11:43:50 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b130sm1758646qkc.100.2019.09.17.11.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:43:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs: separate out the extent io init function
Date:   Tue, 17 Sep 2019 14:43:36 -0400
Message-Id: <20190917184344.13155-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917184344.13155-1-josef@toxicpanda.com>
References: <20190917184344.13155-1-josef@toxicpanda.com>
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

