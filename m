Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CBD12309B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfLQPhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43887 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfLQPhx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id b3so9012426qti.10
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f2TST9dJu+A6dXCHQVy+3rk00jr+PHxV3GlpwRtCYLU=;
        b=ItOu3sFhWn8oMLg8S+E2v7rP5ve2OEPUmgkn2ssUrUwk5KG1/lkT6uVSAqvsQ93NHl
         mXKIldZewU1xQHyCGGE25/EYWqJLs3xZQauoJzb46/xuXfYn1grs/VOXRl0fQeo9RUPC
         Zlo1rV4oPDZkoXc4JtA/uSp62m/s7AwVMgPoIaN2yPth2Q8HSNVO+CJeqUQqDoxKRCwD
         Omesg19YxKSgboelEM9kmTP94qaGMODb4M7cDTIMNGNF77VzA/8r/VXtR7QZawBg/xtp
         V5OR0KOi1PLo4BsCEkLbkEzkFJNNfGp/by8KccVYn40gAJLPlWhzbX3DJO9t6WwXn0hR
         e4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2TST9dJu+A6dXCHQVy+3rk00jr+PHxV3GlpwRtCYLU=;
        b=mw40WR94QyRKnaTY7JAMbVijihxznpyOkl4y+SnL+zjjfNbbLc28Q7XgnN99AH/V0v
         phIkYp+X2Hg2WXFykSIomv32HJlDdGtDD9jGwN5ywuh66/5u4SVk8mMBkMCqURNGcV7c
         OAPGAZgUhvmWPnh8+FF319D9yHQa5HpoSzTxz0GdKzWhDg4Cb723jigTSEkSyOJiXnpA
         k2hWtB+sWBRZ/SSSXoyoWWD/A5eicUh9/OkVdNfIfGimesHNUAVa81l7OyjbKqBDyk6I
         gfKGxFSRQ047WiKzoT8qqFKbEdZ2EL0gRbXoHqdXmBX7Ze6USdUrURFqaZ/lbc2+SGi6
         XGhw==
X-Gm-Message-State: APjAAAVTBrUWCp9UAPiYGiAiGWl+TU6jCLltsxZGvLj4voIrbnq8aug+
        kHYeGqlV8+NxVQBpF0oMoOHH90vW3x/a8A==
X-Google-Smtp-Source: APXvYqwdIm01WhCJQ2eBEzdrj+UqiYzkOH0PlTYyGr+uXvve1RT4pyegcSeLDRZBB/vePgvN9js9QQ==
X-Received: by 2002:aed:304e:: with SMTP id 72mr4901501qte.113.1576597071965;
        Tue, 17 Dec 2019 07:37:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q30sm8171704qtd.5.2019.12.17.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 41/45] btrfs: free more things in btrfs_free_fs_info
Date:   Tue, 17 Dec 2019 10:36:31 -0500
Message-Id: <20191217153635.44733-42-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
index 64e9df8e64fd..b13f3f6e326d 100644
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
@@ -2204,11 +2217,6 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
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
@@ -2683,7 +2691,7 @@ int __cold open_ctree(struct super_block *sb,
 	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
 	if (ret) {
 		err = ret;
-		goto fail_dio_bytes;
+		goto fail_srcu;
 	}
 	fs_info->dirty_metadata_batch = PAGE_SIZE *
 					(1 + ilog2(nr_cpu_ids));
@@ -2691,14 +2699,14 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -2766,7 +2774,7 @@ int __cold open_ctree(struct super_block *sb,
 	fs_info->btree_inode = new_inode(sb);
 	if (!fs_info->btree_inode) {
 		err = -ENOMEM;
-		goto fail_bio_counter;
+		goto fail_srcu;
 	}
 	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
 
@@ -2878,7 +2886,7 @@ int __cold open_ctree(struct super_block *sb,
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
 		brelse(bh);
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	/*
@@ -2915,11 +2923,11 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -2934,7 +2942,7 @@ int __cold open_ctree(struct super_block *sb,
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super) &
@@ -2944,7 +2952,7 @@ int __cold open_ctree(struct super_block *sb,
 		    "cannot mount because of unsupported optional features (%llx)",
 		    features);
 		err = -EINVAL;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super);
@@ -2988,7 +2996,7 @@ int __cold open_ctree(struct super_block *sb,
 		btrfs_err(fs_info,
 "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
 			nodesize, sectorsize);
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	/*
@@ -3004,7 +3012,7 @@ int __cold open_ctree(struct super_block *sb,
 	"cannot mount read-write because of unsupported optional features (%llx)",
 		       features);
 		err = -EINVAL;
-		goto fail_csum;
+		goto fail_alloc;
 	}
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
@@ -3345,25 +3353,14 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -4060,16 +4057,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
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

