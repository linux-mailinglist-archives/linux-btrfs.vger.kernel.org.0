Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901A7140B86
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAQNtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:49:08 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40369 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQNtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:49:08 -0500
Received: by mail-qt1-f195.google.com with SMTP id v25so21781733qto.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W9bYrWIf26pXVM8x8x40i6bJMwAGF8hatl/9wT8cPGU=;
        b=a37LUz7CND7MrsDwm4kr5HQuFaoRg7o4bPwrRqLE0r37cfVnpLiVtAy5e34c56hFY4
         oVN94Dc1AGJKHYX/ru/YYDpvP/+IbybWClX42+tdg5HARzvU7v72KHw/v9Ux5Kafp6oK
         u90l+aSI/xTXSMSvjiOLoYU/lVuQJkrsWLUUaobym3mBGw5nzc39GzlijUWqaLlOV58F
         vssbM2bm9Chou/7B9wl/hrYUakpTxlRDptN1kG55wx5MeXYTX/mw4C1u1nOHRzjVzq8j
         t5baiC8wqEylzhK2UBuizk/TKrfKiS0QAd55tk7ptXQh8G465D9OYi8+B7LE0zM/JAIw
         Jd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9bYrWIf26pXVM8x8x40i6bJMwAGF8hatl/9wT8cPGU=;
        b=NVowt4xJedv6O7A0p1zR/SASMLMTgIqOhjbmVDyQcX6E2KOtmEzgbrcyIch10bDPe7
         HWFnnttnAnTnQwnr17f74iPjX9f7/T+0Zr92nh7U3B1QZFda6wMwQpMMrl3SHUe9AKUd
         Q8+iJ2KR66DxL6WR6PGMWudAvQts6h9/TGeKZWKTKy96iOoYHgmGl9aUZLjqdIOWDzx2
         wlqwTGyHcePeli1D3oNFH0fmXFKlTLXrixnoE6793Gzskxa2gzZ2XW7AGdyqJycxvY4f
         5uU9TrC0HaC8kIJCn1wV1eAOlb34x3ChLTd2I5s/pPh8T+U0CSPVUsKPPGk0IGT8JhDc
         TRgw==
X-Gm-Message-State: APjAAAWqSzJA04tCytR1Yc6wWck2mwmc59/Qhc72lbseAfD7lGRXXqLI
        swbgKPFsxaeQS1IFiIIhVmJ0F15V/OJKww==
X-Google-Smtp-Source: APXvYqyN4T0hzigSBgrdY7l6n1RwV++MYV+afzqDXy5Xkb11MId4UczcSZ5LKfebdLlx33A862OOxA==
X-Received: by 2002:ac8:410f:: with SMTP id q15mr7455328qtl.192.1579268947076;
        Fri, 17 Jan 2020 05:49:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c16sm11611624qka.18.2020.01.17.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:49:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 39/43] btrfs: free more things in btrfs_free_fs_info
Date:   Fri, 17 Jan 2020 08:47:54 -0500
Message-Id: <20200117134758.41494-40-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

