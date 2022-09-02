Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95765AB943
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiIBURG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiIBUQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BEDF43B0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:49 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g14so2335104qto.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=phfHhYPseWCVNRFeUcRit5SlAyGmW0qmPuPJE5jR5sU=;
        b=gP3vd0NtPdv3DH+5AejF89FaC13HIRPQU2rLyjaMN0E44cW2/oxY0pnIiWMgz7PMwD
         1jM8h19DX1nfd0oW+pf4aVXvGtMbkyJnlespsUyqT06ebvbTSPh6PVGhQJ3i2eE+Cs3f
         /+hjjuT4F47nXKoCNZ52E8sS4KBpG04XxM9pMfzlBRjAfvAiuE8yLYQig4F332/XsFY3
         9heY1bvPIAPbw7HRfZbpWtCApE/C/ByMwJO7PIL31U8KKPBOMdd5sG1viKX1wyuNmNZM
         kq5vA45PqAqqthvRa97mHidFLwDEh92MluS2m+X0NPKSQnurquhGe76q2OB0caIMiOjC
         3SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=phfHhYPseWCVNRFeUcRit5SlAyGmW0qmPuPJE5jR5sU=;
        b=YcClrG3Vukpbjf0rw71zyW1+KSCcecfvqwlXLa+7/Kqx6A3yIkkp5O6hFoIALD9V9o
         9DrUnC/QWwgIqB0hUFH6Ub4qqOjq+2jwKbzG9Fj/JthJleu8WjvSaZUjZJ1jZkEcvDyy
         gLjlNFtX953G3Jl1OkU/PLz8ZsPNmoQHDAJ3u3nxddhu6cmSxdFkJ0PAlcUTB2plA6Dp
         heai5G1yWuRRJ6+bi0W1SWnzgsKOks1pLpmm1k0xOkPajh03Pb5kby8pTp7PJtMXvJSV
         6Bem05+PidL/heT6VwTSpN/Szy3ZPDIdJUIn5c8H3wJgTt2gDoeZeP6Hxy06lBCu1SA1
         UPMw==
X-Gm-Message-State: ACgBeo0qJm/c1knZK9NeQslm7GELpf1vl1tCXOPusGskUjmkCqxdFqVf
        zq6egPK7WgDNf6oY7lIqs9CScI7PUJxDrQ==
X-Google-Smtp-Source: AA6agR4hgHTDAM3da46NFFE7H9ca/pY/N5LcNcBRnvRQHJ80deqQb6VBKEoQCdw/GJFof2YFB8qYHg==
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id n6-20020a05622a040600b0034307ae4fe9mr30273853qtx.541.1662149807701;
        Fri, 02 Sep 2022 13:16:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id br36-20020a05620a462400b006b945519488sm2064561qkb.88.2022.09.02.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/31] btrfs: separate out the extent state and extent buffer init code
Date:   Fri,  2 Sep 2022 16:16:10 -0400
Message-Id: <8647f71f352e274f1ad97c4cdbdce6451d10e47b.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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
index 598cb66f65df..d95f0779676b 100644
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
index 767b86e7fe82..1593d4479dde 100644
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

