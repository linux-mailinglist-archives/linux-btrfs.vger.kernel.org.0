Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306825B8B61
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiINPHT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiINPHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:07 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5978218
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:05 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l14so3500987qvq.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=vw2Fm/9gAI44uV/t8/cp6x8gY3GrT4SwYS1ONv7XFi0=;
        b=laYly4OjFheN/8OrN8ujTDW4UnLbuKccl5/TPCtPE6cZnCie1XhHunwPvdXz6txb9O
         wTAI4/1G+JRNys+sxrGk+cMVbmldlTQhEVTZg22dWxRadndYYLGNCG+rxS/uI9Vd5MvF
         DX+vKq4uQFvaAVFpsmdGY6q8Ouna0Yanq57/xzt5SEO0kB+LZoKD6mKmyuSaNLS8H6ED
         9Vq3jV1WcEXGoGeXRtm7buA/io5B9RDuq+IAH9w9UJ0kRefF81+lXQFcAhRvrN24zUto
         S9Mj8mbWWGfUs4b65ENaLz/irZWzXDBr9/s7YuRAugXL5SOzYJ42RI8peNxZ5oCHyZXc
         1MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vw2Fm/9gAI44uV/t8/cp6x8gY3GrT4SwYS1ONv7XFi0=;
        b=RkQxIUmkAp3se8NjKDZG8gaCFGxpJjd2bnJvroz2fHdRJce4J/rl1Jk/+K6YBUCgkR
         /eZVe1RaO/9OFfRVP2IxU1aeUN4N/GhsxKSCc+cV974BjkwFHrY8FTPJyYnn/6k3F28v
         MFTS5aerW523BiXtg33eea9VjK5AJfyhPmswsxc5D3IIOi91IBdEc72jbDLgNOZvVGxq
         cieopkeEIVicopHXidff6jIV6x2/r5r2V7WzYoJ7boTBgWLx7w5PpRH+B54Xuto82Tpo
         8tBX/UpxJ0km3+B1cWHzWb155Z35tl+uAQbjZHOjU2zvmWGXyz1Zk9FDm8tBAz4Etwen
         PBNg==
X-Gm-Message-State: ACgBeo0ZCEiOJRTt++PqQ4pCga1xWVLUAmVZVzmZ7qO3u5nJqpaWc/YF
        778YUOTpAKWinIIm0Xvz9O1NUgs1i1g4wg==
X-Google-Smtp-Source: AA6agR78pi4XxidTkujwHB1DzX9niEvyBAVFPipJA6zM+hOOyQZfHxgePXTCLg+BqPf3FLou5RC/fg==
X-Received: by 2002:a05:6214:c83:b0:4ac:acbd:7efd with SMTP id r3-20020a0562140c8300b004acacbd7efdmr15355321qvr.29.1663168024378;
        Wed, 14 Sep 2022 08:07:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s9-20020ac87589000000b0035cb93ba803sm1519589qtq.45.2022.09.14.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:07:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/17] btrfs: move btrfs_path_cachep out of ctree.h
Date:   Wed, 14 Sep 2022 11:06:38 -0400
Message-Id: <c52053467e423a650b9fd0edbf789d62fb7df87a.1663167823.git.josef@toxicpanda.com>
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

This is local to the ctree code, remove it from ctree.h and inode.c,
create new init/exit functions for the cachep, and move it locally to
ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 17 +++++++++++++++++
 fs/btrfs/ctree.h |  3 ++-
 fs/btrfs/inode.c |  8 --------
 fs/btrfs/super.c |  9 ++++++++-
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ebfa35fe1c38..1f0355c74fe6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -18,6 +18,8 @@
 #include "tree-mod-log.h"
 #include "tree-checker.h"
 
+static struct kmem_cache *btrfs_path_cachep;
+
 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_path *path, int level);
 static int split_leaf(struct btrfs_trans_handle *trans, struct btrfs_root *root,
@@ -4856,3 +4858,18 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 	}
 	return 1;
 }
+
+int __init btrfs_ctree_init(void)
+{
+	btrfs_path_cachep = kmem_cache_create("btrfs_path",
+			sizeof(struct btrfs_path), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!btrfs_path_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void __cold btrfs_ctree_exit(void)
+{
+	kmem_cache_destroy(btrfs_path_cachep);
+}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 439b205f4207..3a61f5c0ab5f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -41,7 +41,6 @@ struct btrfs_pending_snapshot;
 struct btrfs_delayed_ref_root;
 struct btrfs_space_info;
 struct btrfs_block_group;
-extern struct kmem_cache *btrfs_path_cachep;
 extern struct kmem_cache *btrfs_free_space_cachep;
 extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
 struct btrfs_ordered_sum;
@@ -2677,6 +2676,8 @@ void btrfs_end_write_no_snapshotting(struct btrfs_root *root);
 void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
 
 /* ctree.c */
+int __init btrfs_ctree_init(void);
+void __cold btrfs_ctree_exit(void);
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 		     int *slot);
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 78e7f5397d58..1401e2da9284 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -107,7 +107,6 @@ static const struct address_space_operations btrfs_aops;
 static const struct file_operations btrfs_dir_file_operations;
 
 static struct kmem_cache *btrfs_inode_cachep;
-struct kmem_cache *btrfs_path_cachep;
 struct kmem_cache *btrfs_free_space_cachep;
 struct kmem_cache *btrfs_free_space_bitmap_cachep;
 
@@ -8937,7 +8936,6 @@ void __cold btrfs_destroy_cachep(void)
 	rcu_barrier();
 	bioset_exit(&btrfs_dio_bioset);
 	kmem_cache_destroy(btrfs_inode_cachep);
-	kmem_cache_destroy(btrfs_path_cachep);
 	kmem_cache_destroy(btrfs_free_space_cachep);
 	kmem_cache_destroy(btrfs_free_space_bitmap_cachep);
 }
@@ -8951,12 +8949,6 @@ int __init btrfs_init_cachep(void)
 	if (!btrfs_inode_cachep)
 		goto fail;
 
-	btrfs_path_cachep = kmem_cache_create("btrfs_path",
-			sizeof(struct btrfs_path), 0,
-			SLAB_MEM_SPREAD, NULL);
-	if (!btrfs_path_cachep)
-		goto fail;
-
 	btrfs_free_space_cachep = kmem_cache_create("btrfs_free_space",
 			sizeof(struct btrfs_free_space), 0,
 			SLAB_MEM_SPREAD, NULL);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9f7fc1c71148..acd590bed579 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2741,10 +2741,14 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_cachep;
 
-	err = extent_state_init_cachep();
+	err = btrfs_ctree_init();
 	if (err)
 		goto free_transaction;
 
+	err = extent_state_init_cachep();
+	if (err)
+		goto free_ctree;
+
 	err = extent_buffer_init_cachep();
 	if (err)
 		goto free_extent_cachep;
@@ -2813,6 +2817,8 @@ static int __init init_btrfs_fs(void)
 	extent_buffer_free_cachep();
 free_extent_cachep:
 	extent_state_free_cachep();
+free_ctree:
+	btrfs_ctree_exit();
 free_transaction:
 	btrfs_transaction_exit();
 free_cachep:
@@ -2826,6 +2832,7 @@ static int __init init_btrfs_fs(void)
 
 static void __exit exit_btrfs_fs(void)
 {
+	btrfs_ctree_exit();
 	btrfs_transaction_exit();
 	btrfs_destroy_cachep();
 	btrfs_delayed_ref_exit();
-- 
2.26.3

