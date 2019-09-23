Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C15BB62F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405379AbfIWOFe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:05:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43295 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404990AbfIWOFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:05:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id c3so17224024qtv.10
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kwptywQUOqrBKAV0n02cPezllmiMOzJTAQJwnm6sx3w=;
        b=mt/ueceNjN/8Xa+iThmgsnCyn3RcnrJOgMkTS2eI1m3dDfDrSp+xhz5BCa4h/FvI+D
         HVfgCK+F7s9hehIpJa0mVK+Hw1/gEdlzGBAdLK8i2yn81CxSqYdR/1COUoa6e0TQEnLi
         RESCezBaoULObfr6M15gkba23nn6FDg4hDk51KLbaHaOCT9REJ372Pih4kL0yNX6I9W2
         clZLXBiUegsSl7UIPMpinzzhQW13stBEw4XvhE4W2Anrb3nObEQxtrt20ICA0yT1PvfU
         zTqwz2+pMJsN85+k+xctQlp+1XeB7QOSFq5smIRg/IrhvXaYyjKLSEZ5eA24cjfRpiim
         h/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwptywQUOqrBKAV0n02cPezllmiMOzJTAQJwnm6sx3w=;
        b=Izw9jNzAaqyzwq2vWTGFCPzXmNX22hy8tu0a3945sG7JiVRhlGkrsVl0xG/D3YS93n
         oKY9JkTk7ZPQizXSlVru1attK82KTUAwHe4TilfVNmnFOTG1KKCL7vuSgyCx1SUWK4OC
         t9RbnDE11BFU9gv48lxnRVA8rBqB1yNFDw/jaxkDgnUWAgnPI6GdSjnnd0FkXVqcUvmx
         92BMmeoV8dGKpitSLhLUMw+F2wHPbvnueBLormpwimCRis/4RLm6aG8DopH08FrKN0WG
         dj0zUi8wby/W2omuh6EYlj+OrBgVfWXT1rGTOQm3/2gy3zRzIljE1tpAkXaahMAA1Mwn
         J6JA==
X-Gm-Message-State: APjAAAVdoO058WPxNBjXg9QJaMkrzKYWYWbQjxgceXjRUGdfnlxp1DLT
        LO+Z2S98PDRadYMkkMV4ade6E337NH4HOA==
X-Google-Smtp-Source: APXvYqw6cL05uQjvWIOletjs+qfPITrzkWttC1qnnU9P5qTtTalGlJf2pl3P08LT+rRfAXDsR0hOng==
X-Received: by 2002:a0c:b4d2:: with SMTP id h18mr24751296qvf.208.1569247532316;
        Mon, 23 Sep 2019 07:05:32 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 139sm5411332qkf.14.2019.09.23.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:05:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs: separate out the extent io init function
Date:   Mon, 23 Sep 2019 10:05:18 -0400
Message-Id: <20190923140525.14246-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923140525.14246-1-josef@toxicpanda.com>
References: <20190923140525.14246-1-josef@toxicpanda.com>
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
index 8db378fa14da..ca763b99aa27 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -202,19 +202,23 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
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
@@ -232,24 +236,24 @@ int __init extent_io_init(void)
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

