Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5402F1412F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAQV1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34345 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgAQV1O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so24189814qkk.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W9bYrWIf26pXVM8x8x40i6bJMwAGF8hatl/9wT8cPGU=;
        b=FjHVFgOcdgb+TV5ZLB/EoAdWl1rLWtygc1J+ulc5kyl3p8rgREj2xU/OL3tjWiJNsM
         gmacNCxHBbdzIHNZn3YfJ6IzDZX8EEGTDlMw/gy+2RZatGEjTTyBcsEfIb/BdaKIqnMc
         jFF4g4JceOY8/NHIyLWPwGf5KgFEDKcnnnLHzx/NdmtKig+F4S62vKgn4oggBZe+Qy+W
         K9SswSKi97Wy9TtTTXCEIfIcS4FaeI6swjbqnyw703PCFm3jSrbESDBPQDFEes7IPLZ2
         XZjVN8D71Tz78/907CeZ5v39yOIn31j0UTzLmWnFENSjmKAUfhSpyv2lHwudoDILLEcS
         68yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9bYrWIf26pXVM8x8x40i6bJMwAGF8hatl/9wT8cPGU=;
        b=VQhQVHU7q6fZqKRIPuSV13fIyQbfHvRCSfRFpeTgW/kFaeYpngwGMSe9xQAKM+VpSf
         LvMEk2rStmjWtvN38rFCimwZxJKzSyLxPvaxmeZ9KPbAS2cKXHfuApx+AjhnWtbnNafY
         QhvOFmH7p8dEKKMZwJG03inN5gSk5Lg4UU+YIiC/Sq8k1gEbYjQv6X3ZpI1ZL96J1qrM
         JyTzVaX19DElTCSdBi1AsHIAjCXUJdvhVqxZxmWktcc74eyjevUBGBjqJHcR69ngrkVb
         ovRZA01I5NIK/Bh9APCEzwUOjAyfARtrkF/41eRRS/HLERXt2KSS5NQQRmrV/SuisOwN
         cq1A==
X-Gm-Message-State: APjAAAX06y3Zs+ny9/Rb8e56YH84yRJd8Al0DluCKhsqDwST6DjYmu3b
        dtErEd3ugy5q8nlGX+2OGokUb8VFXkR5sQ==
X-Google-Smtp-Source: APXvYqxjqGfxNsJZtFdO7EbA1KYzdGsNz0xs1MajNSZi/NBOGT1sCi0AMYyy+95wHDJT2JFMB/gD8A==
X-Received: by 2002:a37:801:: with SMTP id 1mr41790579qki.326.1579296432691;
        Fri, 17 Jan 2020 13:27:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q2sm12403123qkm.5.2020.01.17.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 39/43] btrfs: free more things in btrfs_free_fs_info
Date:   Fri, 17 Jan 2020 16:25:58 -0500
Message-Id: <20200117212602.6737-40-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Things like the percpu_counters, the mapping_tree, and the csum hash can
all be free'd at btrfs_free_fs_info time, since the helpers all check if
the structure has been init'ed already.  This significantly cleans up
the error cases in open_ctree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 60 +++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ac306807e5cd..d8adc9c6d8ea 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -98,6 +98,12 @@ void __cold btrfs_end_io_wq_exit(void)
 	kmem_cache_destroy(btrfs_end_io_wq_cache);
 }
 
+static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
+{
+	if (fs_info->csum_shash)
+		crypto_free_shash(fs_info->csum_shash);
+}
+
 /*
  * async submit bios are used to offload expensive checksumming
  * onto the worker threads.  They checksum file and metadata bios
@@ -1527,6 +1533,13 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
+	percpu_counter_destroy(&fs_info->delalloc_bytes);
+	percpu_counter_destroy(&fs_info->dio_bytes);
+	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
+	btrfs_free_csum_hash(fs_info);
+	btrfs_free_stripe_hash_table(fs_info);
+	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
 	btrfs_put_fs_root(fs_info->extent_root);
@@ -2207,11 +2220,6 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 	return 0;
 }
 
-static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
-{
-	crypto_free_shash(fs_info->csum_shash);
-}
-
 static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 			    struct btrfs_fs_devices *fs_devices)
 {
@@ -2686,7 +2694,7 @@ int __cold open_ctree(struct super_block *sb,
 	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
 	if (ret) {
 		err = ret;
-		goto fail_dio_bytes;
+		goto fail_srcu;
 	}
 	fs_info->dirty_metadata_batch = PAGE_SIZE *
 					(1 + ilog2(nr_cpu_ids));
@@ -2694,14 +2702,14 @@ int __cold open_ctree(struct super_block *sb,
 	ret = percpu_counter_init(&fs_info->delalloc_bytes, 0, GFP_KERNEL);
 	if (ret) {
 		err = ret;
-		goto fail_dirty_metadata_bytes;
+		goto fail_srcu;
 	}
 
 	ret = percpu_counter_init(&fs_info->dev_replace.bio_counter, 0,
 			GFP_KERNEL);
 	if (ret) {
 		err = ret;
-		goto fail_delalloc_bytes;
+		goto fail_srcu;
 	}
 
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
@@ -2769,7 +2777,7 @@ int __cold open_ctree(struct super_block *sb,
 	fs_info->btree_inode = new_inode(sb);
 	if (!fs_info->btree_inode) {
 		err = -ENOMEM;
-		goto fail_bio_counter;
+		goto fail_srcu;
 	}
 	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
 
@@ -2882,7 +2890,7 @@ int __cold open_ctree(struct super_block *sb,
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
 		brelse(bh);
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	/*
@@ -2919,11 +2927,11 @@ int __cold open_ctree(struct super_block *sb,
 	if (ret) {
 		btrfs_err(fs_info, "superblock contains fatal errors");
 		err = -EINVAL;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	if (!btrfs_super_root(disk_super))
-		goto fail_csum;
+		goto fail_alloc;
 
 	/* check FS state, whether FS is broken. */
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
@@ -2938,7 +2946,7 @@ int __cold open_ctree(struct super_block *sb,
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super) &
@@ -2948,7 +2956,7 @@ int __cold open_ctree(struct super_block *sb,
 		    "cannot mount because of unsupported optional features (%llx)",
 		    features);
 		err = -EINVAL;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super);
@@ -2992,7 +3000,7 @@ int __cold open_ctree(struct super_block *sb,
 		btrfs_err(fs_info,
 "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
 			nodesize, sectorsize);
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	/*
@@ -3008,7 +3016,7 @@ int __cold open_ctree(struct super_block *sb,
 	"cannot mount read-write because of unsupported optional features (%llx)",
 		       features);
 		err = -EINVAL;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
@@ -3343,25 +3351,14 @@ int __cold open_ctree(struct super_block *sb,
 fail_sb_buffer:
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
-fail_csum:
-	btrfs_free_csum_hash(fs_info);
 fail_alloc:
 fail_iput:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	iput(fs_info->btree_inode);
-fail_bio_counter:
-	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
-fail_delalloc_bytes:
-	percpu_counter_destroy(&fs_info->delalloc_bytes);
-fail_dirty_metadata_bytes:
-	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
-fail_dio_bytes:
-	percpu_counter_destroy(&fs_info->dio_bytes);
 fail_srcu:
 	cleanup_srcu_struct(&fs_info->subvol_srcu);
 fail:
-	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_close_devices(fs_info->fs_devices);
 	return err;
 }
@@ -4061,16 +4058,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 	btrfs_close_devices(fs_info->fs_devices);
-
-	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
-	percpu_counter_destroy(&fs_info->delalloc_bytes);
-	percpu_counter_destroy(&fs_info->dio_bytes);
-	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	cleanup_srcu_struct(&fs_info->subvol_srcu);
-
-	btrfs_free_csum_hash(fs_info);
-	btrfs_free_stripe_hash_table(fs_info);
-	btrfs_free_ref_cache(fs_info);
 }
 
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
-- 
2.24.1

