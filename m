Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E55B8B6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiINPHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiINPHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D477E9A
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:06 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b23so6461759qtr.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=al9+AnyXUCeLyEiVoBI+wJ/piSc70KkHcNevdqkvIsI=;
        b=A+abR0xea29aRosezIQHOLfCOkdxr6EKqbz8VC9pzgrxraSPVjK3RTHVo8BkaC279t
         XHagmaoGLfCJndKLVxpUx9jxdLUYCz0aMdTtr2h/YWUcaijVUqpOLSCMy9ImJC2081Dd
         Smxn3obJ69apLdxl+gYazyt29Zf8QisaMTs7/B+Y0QKaJtxRa5KJFPdoFQdMKHjKAHtM
         kaNleH8rPdUM60fuq5pOBo3/kVsV4koiU5cZ2yhKnV0zh4956wsWpkzDr5t4cxXkBznn
         banTs4tEP46CzGJ56V9C0B/qiKn6gcXw6rUQX1P9B2Ltd0UO9jYDveCa7lns/WNTqRhV
         ipgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=al9+AnyXUCeLyEiVoBI+wJ/piSc70KkHcNevdqkvIsI=;
        b=yxb4o3Hr7OL65aCrUamn5lIAbby4nKITAPQQr8yI4YLMxUH/wW1Y0ZMVV1mhgjrSzj
         XTD4qfqgUtAmfoFd8cX+uNUZvsyft0IRCreFER3X9qy+bhOEcjgA/xVaMhmlnQi8v9NR
         nA+Zmb/8S5KWAx/zoGshbln3wpS7DI5pf03y4uyFajZdk2cDH72XWleRRZ7/EX7n/j08
         32AE3y7VqHLYhNc2ScLbKIC9HK4dImqkEbFE50tJ3YEmHyRGgDE78wHl9KZKUeCv9Ggx
         p3853bS0OWv9WxzGjI1Kaik5IIvqkvo0NCZ6G67OqpjYD/X2P+34H2EDI8EfGYxGiy2z
         78Ig==
X-Gm-Message-State: ACgBeo0tZjnU0nl1GNESPjgPxYhzWaRlwEkXv2ClN2CEJatm07yOyPIk
        QL8ByC/JiyFqWpleYcL9jpIXUooojvlk1Q==
X-Google-Smtp-Source: AA6agR69a3IrTmZlILVUgtMb1pdYyduwbzzmi2WZTaP1l4jBYY48qHTslmSyQ+J7a+nvK1NCdxLl8Q==
X-Received: by 2002:ac8:7f0c:0:b0:35b:b013:3913 with SMTP id f12-20020ac87f0c000000b0035bb0133913mr16063057qtk.39.1663168025667;
        Wed, 14 Sep 2022 08:07:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl7-20020a05622a244700b0035a71a41645sm1732501qtb.37.2022.09.14.08.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:07:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/17] btrfs: move free space cachep's out of ctree.h
Date:   Wed, 14 Sep 2022 11:06:39 -0400
Message-Id: <d74e617ece68c21850260393cdce86ad5ae33ee9.1663167824.git.josef@toxicpanda.com>
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

This is local to the free-space-cache.c code, remove it from ctree.h and
inode.c, create new init/exit functions for the cachep, and move it
locally to free-space-cache.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            |  2 --
 fs/btrfs/free-space-cache.c | 28 ++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/inode.c            | 16 ----------------
 fs/btrfs/super.c            |  9 ++++++++-
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3a61f5c0ab5f..af6f6764d9a4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -41,8 +41,6 @@ struct btrfs_pending_snapshot;
 struct btrfs_delayed_ref_root;
 struct btrfs_space_info;
 struct btrfs_block_group;
-extern struct kmem_cache *btrfs_free_space_cachep;
-extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
 struct btrfs_ordered_sum;
 struct btrfs_ref;
 struct btrfs_bio;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7859eeca484c..ee03c5e6db4c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -29,6 +29,9 @@
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
 #define FORCE_EXTENT_THRESHOLD	SZ_1M
 
+static struct kmem_cache *btrfs_free_space_cachep;
+static struct kmem_cache *btrfs_free_space_bitmap_cachep;
+
 struct btrfs_trim_range {
 	u64 start;
 	u64 bytes;
@@ -4132,6 +4135,31 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool act
 	return ret;
 }
 
+int __init btrfs_free_space_init(void)
+{
+	btrfs_free_space_cachep = kmem_cache_create("btrfs_free_space",
+			sizeof(struct btrfs_free_space), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!btrfs_free_space_cachep)
+		return -ENOMEM;
+
+	btrfs_free_space_bitmap_cachep = kmem_cache_create("btrfs_free_space_bitmap",
+							PAGE_SIZE, PAGE_SIZE,
+							SLAB_MEM_SPREAD, NULL);
+	if (!btrfs_free_space_bitmap_cachep) {
+		kmem_cache_destroy(btrfs_free_space_cachep);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void __cold btrfs_free_space_exit(void)
+{
+	kmem_cache_destroy(btrfs_free_space_cachep);
+	kmem_cache_destroy(btrfs_free_space_bitmap_cachep);
+}
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 /*
  * Use this if you need to make a bitmap or extent entry specifically, it
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index eaf30f6444dd..cab954a9d97b 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -88,6 +88,8 @@ struct btrfs_io_ctl {
 	int bitmaps;
 };
 
+int __init btrfs_free_space_init(void);
+void __cold btrfs_free_space_exit(void);
 struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
 		struct btrfs_path *path);
 int create_free_space_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1401e2da9284..da5be8f23f68 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -107,8 +107,6 @@ static const struct address_space_operations btrfs_aops;
 static const struct file_operations btrfs_dir_file_operations;
 
 static struct kmem_cache *btrfs_inode_cachep;
-struct kmem_cache *btrfs_free_space_cachep;
-struct kmem_cache *btrfs_free_space_bitmap_cachep;
 
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
 static int btrfs_truncate(struct inode *inode, bool skip_writeback);
@@ -8936,8 +8934,6 @@ void __cold btrfs_destroy_cachep(void)
 	rcu_barrier();
 	bioset_exit(&btrfs_dio_bioset);
 	kmem_cache_destroy(btrfs_inode_cachep);
-	kmem_cache_destroy(btrfs_free_space_cachep);
-	kmem_cache_destroy(btrfs_free_space_bitmap_cachep);
 }
 
 int __init btrfs_init_cachep(void)
@@ -8949,18 +8945,6 @@ int __init btrfs_init_cachep(void)
 	if (!btrfs_inode_cachep)
 		goto fail;
 
-	btrfs_free_space_cachep = kmem_cache_create("btrfs_free_space",
-			sizeof(struct btrfs_free_space), 0,
-			SLAB_MEM_SPREAD, NULL);
-	if (!btrfs_free_space_cachep)
-		goto fail;
-
-	btrfs_free_space_bitmap_cachep = kmem_cache_create("btrfs_free_space_bitmap",
-							PAGE_SIZE, PAGE_SIZE,
-							SLAB_MEM_SPREAD, NULL);
-	if (!btrfs_free_space_bitmap_cachep)
-		goto fail;
-
 	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
 			offsetof(struct btrfs_dio_private, bio),
 			BIOSET_NEED_BVECS))
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index acd590bed579..c2e634de01e4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2745,10 +2745,14 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_transaction;
 
-	err = extent_state_init_cachep();
+	err = btrfs_free_space_init();
 	if (err)
 		goto free_ctree;
 
+	err = extent_state_init_cachep();
+	if (err)
+		goto free_free_space;
+
 	err = extent_buffer_init_cachep();
 	if (err)
 		goto free_extent_cachep;
@@ -2817,6 +2821,8 @@ static int __init init_btrfs_fs(void)
 	extent_buffer_free_cachep();
 free_extent_cachep:
 	extent_state_free_cachep();
+free_free_space:
+	btrfs_free_space_exit();
 free_ctree:
 	btrfs_ctree_exit();
 free_transaction:
@@ -2832,6 +2838,7 @@ static int __init init_btrfs_fs(void)
 
 static void __exit exit_btrfs_fs(void)
 {
+	btrfs_free_space_exit();
 	btrfs_ctree_exit();
 	btrfs_transaction_exit();
 	btrfs_destroy_cachep();
-- 
2.26.3

