Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97129115391
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLFOqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45898 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfLFOqx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so6612404qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U++7CsDgUAoHRCm78Kd0126Dyi+0UgtaVwJWjzfHBzM=;
        b=HKtgUUInI8qSDAb2+rDS57oAEGj6jCws9Thw2vjrLuaWElTABrbz08aSdAD82leZan
         +Kkos2lsoOHhfPog3wlmIKU4ehQ9e/Pcvg06G6YK13FJFl4aLQlP422rMatqEAHP/r+T
         Ji+MHULmtQPTJfB5TfgQzzpR++dUv7DHfYWHrIXZ8yr58IivsQbGi576LoQiRgh7jRWN
         2qZ+P1Ca01HqE8dfSp/Evv+Xs5Xrnxl3IjOrgO1oaUD3DuRXLI+QRzP9OaojFwlQYFte
         LWNaih90jAFls1+gznL4oE4jKiCfHfCVTcPZmNPfZf5kydJqOp3XAmAvo74GbW9hwOqW
         pwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U++7CsDgUAoHRCm78Kd0126Dyi+0UgtaVwJWjzfHBzM=;
        b=tg216+6G8/f2CmuJJmZIS93nRViECBQ+sDjSsCERRqnJed1C1JMQdf2xRmAyKYyRu7
         DWRD+ORbXqtjJXYeKOH4LAZxftX3DFGpawvhcYsIBqmFTsXZQR9X92yQBdQGq+Gn2vEr
         TVkANgaPh7UK4BLcIl7tFIyYQETv3jq+768FQB2xMh5dwou08Ywr4HjfZhLmtPVebHk7
         LkDCV8tqI9WD0+q7XVviSh5OMOHaSKMJQ+SAneB605I5/7XDHuKIWU4++9QXhhbBM2Ix
         rOgAjpNpoq1HIqPbxEBtw5ejh5M8BON20hMcWZH5iS0m/1pWczG3x9eDr3UX+jLKddZS
         BYcw==
X-Gm-Message-State: APjAAAWby75EQRSCsE0aDkARXNUNUuO6PgErA4uxNwjcTuyIj5xOsQJ8
        lyjr0IRF6Yor20desgw+HUOuPDxMpI7iNQ==
X-Google-Smtp-Source: APXvYqx9omaTU9hWVIfUJZWxH6tqvz6c92dcxkV8A9mdc9X4Wo22QmwOuWPwxD2AjZwfN2yQuJ4utw==
X-Received: by 2002:a05:620a:23a:: with SMTP id u26mr13862076qkm.426.1575643612424;
        Fri, 06 Dec 2019 06:46:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j25sm780632qtc.70.2019.12.06.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 41/44] btrfs: free more things in btrfs_free_fs_info
Date:   Fri,  6 Dec 2019 09:45:35 -0500
Message-Id: <20191206144538.168112-42-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index adcabd6d3a92..c7163229effc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -97,6 +97,12 @@ void __cold btrfs_end_io_wq_exit(void)
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
@@ -1529,6 +1535,13 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 
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
 
@@ -2881,7 +2889,7 @@ int __cold open_ctree(struct super_block *sb,
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
 		brelse(bh);
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	/*
@@ -2918,11 +2926,11 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -2937,7 +2945,7 @@ int __cold open_ctree(struct super_block *sb,
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super) &
@@ -2947,7 +2955,7 @@ int __cold open_ctree(struct super_block *sb,
 		    "cannot mount because of unsupported optional features (%llx)",
 		    features);
 		err = -EINVAL;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super);
@@ -2991,7 +2999,7 @@ int __cold open_ctree(struct super_block *sb,
 		btrfs_err(fs_info,
 "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
 			nodesize, sectorsize);
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	/*
@@ -3007,7 +3015,7 @@ int __cold open_ctree(struct super_block *sb,
 	"cannot mount read-write because of unsupported optional features (%llx)",
 		       features);
 		err = -EINVAL;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
@@ -3348,25 +3356,14 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -4063,16 +4060,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
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
2.23.0

