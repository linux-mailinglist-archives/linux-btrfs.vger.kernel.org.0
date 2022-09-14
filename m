Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6375B8B5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiINPHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiINPHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E613E77EB0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y2so11382553qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=yChKzDuGkSJeaB68JMiVPP35OWAvh8MC5ifwtbkDGEE=;
        b=q/dJXf1kl0HxAiJ/dH3dVECqGxdAretzZj2gS4oezVwbk86rteqzhqS9nnNs0F8dw9
         8Q0Iz1GPupbQd+zfAt61iMH1Y+fAl+XhcdtDuWitxhZuyZ+bxZTzz1eq9xVafPayo8PH
         5K5a+OWSEi+1kZYkRn69whrB76v1FO6vPONLKKpZiaes+UnyzN6uZE/pWSerSD67+Bul
         LuLDj1JcIEjQyyuRZzF9HxYT/yQsx00t2mGB7Xx5Mctodv2VuvCdkhsWUxkDR3NwBxsS
         SB9vsAxKx96+TFelAeeOfUAIRTom1vv8HXKa6oNyWiRr+fVDRZj6Msaa3dYYpuez0w4S
         SApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yChKzDuGkSJeaB68JMiVPP35OWAvh8MC5ifwtbkDGEE=;
        b=3nGohGDx5nf7vWbNhERrLM+28zTBK42QNbbPCZvT+DOm9qeDnLSqz3LXVeUu0Vi3Vu
         2cTr2nx1KhZwTH7fpUEISzXbP4nw0Wa6OgtGu67uz0IJzA2mSbULVq+39n8+z+ZW4yYa
         9RNRAru8lt6PhTzeo/eGa/M0REeONHUjUzsK/x6HqB3ko3V7o/mDYlgmDys0QdYAeD54
         t2VXzCilCk3nlpy3FlUWChRVH3ooKd0ZD28pm7JqESfeVNFsWDD9h3ec+AeO++QCr9Ie
         a+QjIJg/Fn1i+/65qsHB3a/f3Kjv0Or1R5ZgGLo+O3kVkZDNjRvSuEbvT4gMD/EUDei6
         cPzA==
X-Gm-Message-State: ACgBeo1Evz4/5loW49Vz21QGwulJZ61/TkqkvC1qsHrIEFHrFYla3+hA
        cSDXcaNxK2Z9utV9yeveUTO3csbUfRYTjw==
X-Google-Smtp-Source: AA6agR5q3EZPFzygkEpz+X1v9HfO1zkxPF+WMQezPCwiKyCqfOBvOC+EWgE/vO+n3ll/UWEsz+2JKw==
X-Received: by 2002:ac8:5885:0:b0:343:74df:9b26 with SMTP id t5-20020ac85885000000b0034374df9b26mr33924346qta.406.1663168022627;
        Wed, 14 Sep 2022 08:07:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a205500b006b942f4ffe3sm1770741qka.18.2022.09.14.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:07:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/17] btrfs: move trans_handle_cachep out of ctree.h
Date:   Wed, 14 Sep 2022 11:06:37 -0400
Message-Id: <68e9b87432b738ef6547294d9e5d307cfbdaf13d.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This is local to the transaction code, remove it from ctree.h and
inode.c, create new helpers in the transaction to handle the init work
and move the cachep locally to transaction.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/inode.c       |  8 --------
 fs/btrfs/super.c       |  9 ++++++++-
 fs/btrfs/transaction.c | 17 +++++++++++++++++
 fs/btrfs/transaction.h |  2 ++
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d99720cf4835..439b205f4207 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -41,7 +41,6 @@ struct btrfs_pending_snapshot;
 struct btrfs_delayed_ref_root;
 struct btrfs_space_info;
 struct btrfs_block_group;
-extern struct kmem_cache *btrfs_trans_handle_cachep;
 extern struct kmem_cache *btrfs_path_cachep;
 extern struct kmem_cache *btrfs_free_space_cachep;
 extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 998d1c7134ff..78e7f5397d58 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -107,7 +107,6 @@ static const struct address_space_operations btrfs_aops;
 static const struct file_operations btrfs_dir_file_operations;
 
 static struct kmem_cache *btrfs_inode_cachep;
-struct kmem_cache *btrfs_trans_handle_cachep;
 struct kmem_cache *btrfs_path_cachep;
 struct kmem_cache *btrfs_free_space_cachep;
 struct kmem_cache *btrfs_free_space_bitmap_cachep;
@@ -8938,7 +8937,6 @@ void __cold btrfs_destroy_cachep(void)
 	rcu_barrier();
 	bioset_exit(&btrfs_dio_bioset);
 	kmem_cache_destroy(btrfs_inode_cachep);
-	kmem_cache_destroy(btrfs_trans_handle_cachep);
 	kmem_cache_destroy(btrfs_path_cachep);
 	kmem_cache_destroy(btrfs_free_space_cachep);
 	kmem_cache_destroy(btrfs_free_space_bitmap_cachep);
@@ -8953,12 +8951,6 @@ int __init btrfs_init_cachep(void)
 	if (!btrfs_inode_cachep)
 		goto fail;
 
-	btrfs_trans_handle_cachep = kmem_cache_create("btrfs_trans_handle",
-			sizeof(struct btrfs_trans_handle), 0,
-			SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
-	if (!btrfs_trans_handle_cachep)
-		goto fail;
-
 	btrfs_path_cachep = kmem_cache_create("btrfs_path",
 			sizeof(struct btrfs_path), 0,
 			SLAB_MEM_SPREAD, NULL);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2add5b23c476..9f7fc1c71148 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2737,10 +2737,14 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_compress;
 
-	err = extent_state_init_cachep();
+	err = btrfs_transaction_init();
 	if (err)
 		goto free_cachep;
 
+	err = extent_state_init_cachep();
+	if (err)
+		goto free_transaction;
+
 	err = extent_buffer_init_cachep();
 	if (err)
 		goto free_extent_cachep;
@@ -2809,6 +2813,8 @@ static int __init init_btrfs_fs(void)
 	extent_buffer_free_cachep();
 free_extent_cachep:
 	extent_state_free_cachep();
+free_transaction:
+	btrfs_transaction_exit();
 free_cachep:
 	btrfs_destroy_cachep();
 free_compress:
@@ -2820,6 +2826,7 @@ static int __init init_btrfs_fs(void)
 
 static void __exit exit_btrfs_fs(void)
 {
+	btrfs_transaction_exit();
 	btrfs_destroy_cachep();
 	btrfs_delayed_ref_exit();
 	btrfs_auto_defrag_exit();
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d1f1da6820fb..ae7d4aca771d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -24,6 +24,8 @@
 #include "space-info.h"
 #include "zoned.h"
 
+static struct kmem_cache *btrfs_trans_handle_cachep;
+
 #define BTRFS_ROOT_TRANS_TAG 0
 
 /*
@@ -2600,3 +2602,18 @@ void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info)
 		btrfs_warn(fs_info,
 			"unknown pending changes left 0x%lx, ignoring", prev);
 }
+
+int __init btrfs_transaction_init(void)
+{
+	btrfs_trans_handle_cachep = kmem_cache_create("btrfs_trans_handle",
+			sizeof(struct btrfs_trans_handle), 0,
+			SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
+	if (!btrfs_trans_handle_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void __cold btrfs_transaction_exit(void)
+{
+	kmem_cache_destroy(btrfs_trans_handle_cachep);
+}
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 970ff316069d..b5651c372946 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -236,4 +236,6 @@ void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
 void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
 
+int __init btrfs_transaction_init(void);
+void __cold btrfs_transaction_exit(void);
 #endif
-- 
2.26.3

