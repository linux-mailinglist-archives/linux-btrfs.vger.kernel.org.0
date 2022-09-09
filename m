Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3535B41BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiIIVyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiIIVyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4593CEB26
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:53:59 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j6so2203940qkl.10
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=752VRjdEIKUyzdIAZx69Lfw1LXg03xV1xqhBLDgwr3g=;
        b=nOy+ye8iau0CPVm10l0B3SAkNVJiSWgg1yjr8SNPGLEe6x+ObDOF7f/+zi/qzkpITq
         8IMhuz9HoTogyV3ohtOxis9rrVlck6uQZ/y3TY685AJTvw6QQncrM3hETOTD3ZFMATDK
         oH+KBwUjcviEt+PkMMBknshuA9MzqU3mqa3bRpxE1ospjkVNwlckAG0ngwT5aln2MF9z
         2LWdefzcnvOdRpBC073HL4kdFXefUEU6LnZkTunnNnLxo2Uo51UqFgCUOpJ1GTsG1F9x
         tvT2WWESA4YIFyxnUZNhutJ7XUbe8XskQRSfwa1D5ohCB130J2aOFLLDIWu6lp86wMYE
         +nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=752VRjdEIKUyzdIAZx69Lfw1LXg03xV1xqhBLDgwr3g=;
        b=6hITcC+40DUdJuIdDO09FnBpbTUB4Q0cG0Xt8v7JX3W5lePZgT8BHXKdjM8OQfm6pl
         RiuX4Bvng2hXnUb0xQj1yABS53VyClc/AZmHrJbWmIek5cMGTfoLf/7ZMzLStD9oTlxG
         tD0r6vUwvAekOsynoxwS1OI4NGMKBT/k0O+OqYHX4LS3l4ic0knpQSVvdCisaSxZld56
         BTcfjPL3PvTCABlrMbRU+SZHodvbsTYBBclzKMcT6HE342trJc40/fKs/xyz3OzHM+gX
         U7hjBQwbpuF2Mgtnmuh5VF78Hyk4SsmnpS8SPE+7w9v64ag+PXGOlsWLkgQsyX/j79Eq
         Meww==
X-Gm-Message-State: ACgBeo1h6U29KdSexrMJKGCRASTNUtfj3H1RnPEWP/8ycv763fj+K31m
        brySqX4SEFTR7NHJW9zc9k9PYUL9cVlf8g==
X-Google-Smtp-Source: AA6agR51E96eAaKmDO29EdrGgM/N1khWR4koc/9YnOxt2Jo3vHz7uWc2wpZrOqFlp+mhPhdePgL9Bg==
X-Received: by 2002:a05:620a:470a:b0:6bb:6dc1:67ce with SMTP id bs10-20020a05620a470a00b006bb6dc167cemr11908634qkb.589.1662760438685;
        Fri, 09 Sep 2022 14:53:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c6-20020a05620a268600b006b93b61bc74sm1555586qkp.9.2022.09.09.14.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:53:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/36] btrfs: separate out the extent state and extent buffer init code
Date:   Fri,  9 Sep 2022 17:53:18 -0400
Message-Id: <16e57635b3262ea0ce9c1fb391665e34a8ccc804.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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

In order to help separate the extent buffer from the extent io tree code
we need to break up the init functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h |  4 ++--
 fs/btrfs/extent_io.c      | 21 ++++++++++++++-------
 fs/btrfs/extent_io.h      |  3 +++
 fs/btrfs/super.c          | 17 ++++++++++++-----
 4 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ee2ba4b6e4a1..6c2016db304b 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -108,8 +108,8 @@ static inline int lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 
 int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end);
 
-int __init extent_io_init(void);
-void __cold extent_io_exit(void);
+int __init extent_state_init_cachep(void);
+void __cold extent_state_free_cachep(void);
 
 u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0f087ab1b175..34b03bd2352e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -230,7 +230,7 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
 	}
 }
 
-int __init extent_io_init(void)
+int __init extent_state_init_cachep(void)
 {
 	extent_state_cache = kmem_cache_create("btrfs_extent_state",
 			sizeof(struct extent_state), 0,
@@ -238,18 +238,27 @@ int __init extent_io_init(void)
 	if (!extent_state_cache)
 		return -ENOMEM;
 
+	return 0;
+}
+
+int __init extent_buffer_init_cachep(void)
+{
 	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
 			sizeof(struct extent_buffer), 0,
 			SLAB_MEM_SPREAD, NULL);
-	if (!extent_buffer_cache) {
-		kmem_cache_destroy(extent_state_cache);
+	if (!extent_buffer_cache)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
 
-void __cold extent_io_exit(void)
+void __cold extent_state_free_cachep(void)
+{
+	btrfs_extent_state_leak_debug_check();
+	kmem_cache_destroy(extent_state_cache);
+}
+
+void __cold extent_buffer_free_cachep(void)
 {
 	/*
 	 * Make sure all delayed rcu free are flushed before we
@@ -257,8 +266,6 @@ void __cold extent_io_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(extent_buffer_cache);
-	btrfs_extent_state_leak_debug_check();
-	kmem_cache_destroy(extent_state_cache);
 }
 
 /*
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 879f8a60cd6f..52e4dfea2164 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -64,6 +64,9 @@ struct btrfs_fs_info;
 struct io_failure_record;
 struct extent_io_tree;
 
+int __init extent_buffer_init_cachep(void);
+void __cold extent_buffer_free_cachep(void);
+
 typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 					 int mirror_num,
 					 enum btrfs_compression_type compress_type);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eb0ae7e396ef..be7df8d1d5b8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2736,13 +2736,17 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_compress;
 
-	err = extent_io_init();
+	err = extent_state_init_cachep();
 	if (err)
 		goto free_cachep;
 
+	err = extent_buffer_init_cachep();
+	if (err)
+		goto free_extent_cachep;
+
 	err = btrfs_bioset_init();
 	if (err)
-		goto free_extent_io;
+		goto free_eb_cachep;
 
 	err = extent_map_init();
 	if (err)
@@ -2800,8 +2804,10 @@ static int __init init_btrfs_fs(void)
 	extent_map_exit();
 free_bioset:
 	btrfs_bioset_exit();
-free_extent_io:
-	extent_io_exit();
+free_eb_cachep:
+	extent_buffer_free_cachep();
+free_extent_cachep:
+	extent_state_free_cachep();
 free_cachep:
 	btrfs_destroy_cachep();
 free_compress:
@@ -2821,7 +2827,8 @@ static void __exit exit_btrfs_fs(void)
 	ordered_data_exit();
 	extent_map_exit();
 	btrfs_bioset_exit();
-	extent_io_exit();
+	extent_state_free_cachep();
+	extent_buffer_free_cachep();
 	btrfs_interface_exit();
 	unregister_filesystem(&btrfs_fs_type);
 	btrfs_exit_sysfs();
-- 
2.26.3

