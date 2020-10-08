Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFDF287D6E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgJHUtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJHUtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D5C0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g3so6288956qtq.10
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b7wlyUf0+LhXlj1tfj1Dt6sA44k40R/Fu9Edp1aUcfw=;
        b=y6MSI9LKExjg70d8PBeDQzYsna+53eMLXSE4t4WqMA9Yrdc1RFst86TzRlVrYucxPL
         SUvurm585FGoJdE3NSK/eHYYsUTRJ79WQKkUGV97Arhg1wJsdorlBmAHO5qjylme9wmU
         qfvRBvuY997l4huTDt78AwDliRCZZU2Vu/KNntVaQgykZmOQoTzMKLlLuM4oUZfwVmCs
         9SSv8m2SJDIdpCOEF20vVF2Zp7IVuN6f/PkpaEN9uF3TZ/dT9gUT7NLaQxZI3DFf4PDi
         AtxxNS5w0YRz+hlaHtYxKc67sW8uaWx6mv6Ii41MTXzRgzJXyrOR8Nt5oB0q9v8vaplR
         z0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7wlyUf0+LhXlj1tfj1Dt6sA44k40R/Fu9Edp1aUcfw=;
        b=BhZnMk70SDW+G6USkCK6xBi2W4esnuxGwKbNXR/HM2ZHbub2VRQ4kjKW95KPZ8Fna1
         rPw+7gEsymJ6VRz26iCX7u8X0ciBj3gwUPg2avgYsiwII+F/ULkYwcurQ22bajfe/w/0
         6wjerLBYksobbi0IIjC2TEf7Wxz5cD7etXbJNL68YJi2nP+GfcZsHdQlOrmMPgZQL72G
         u5vUNxxoW+xc5EH8TMRFy1U0MJMonuvOknpyspwEfrfksLM11Hy9IY2cmshVWSF3SemQ
         gaWRFtwZhgZ3jsWiFM/EFyXraqRp3gRW+fTdC7yuZ4DMS+SrSH3XP/l0TzvSRruyCULY
         pSRg==
X-Gm-Message-State: AOAM533P3Wes36Q1jdTdgTUCLd6zbq2XepwGmwONWUK8d9CvuEMMLbcf
        bFczqJRjTgDQ0c+yzpT68WuVuU5Pf6YGIgwd
X-Google-Smtp-Source: ABdhPJwbWrpF3KH2D3mgqY3/eJaKxxKy5UHTyft4le8zHxRfoyxnz5GCAeJ6l9yJ9vnanqg0bW6yZA==
X-Received: by 2002:ac8:2f79:: with SMTP id k54mr10729737qta.148.1602190141393;
        Thu, 08 Oct 2020 13:49:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 128sm4453510qkh.53.2020.10.08.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/11] btrfs: track ordered bytes instead of just dio ordered bytes
Date:   Thu,  8 Oct 2020 16:48:46 -0400
Message-Id: <cf8c1d7231092a9fbe9128339739352d84448b8a.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We track dio_bytes because the shrink delalloc code needs to know if we
have more DIO in flight than we have normal buffered IO.  The reason for
this is because we can't "flush" DIO, we have to just wait on the
ordered extents to finish.

However this is true of all ordered extents.  If we have more ordered
space outstanding than dirty pages we should be waiting on ordered
extents.  We already are ok on this front technically, because we always
do a FLUSH_DELALLOC_WAIT loop, but I want to use the ordered counter in
the preemptive flushing code as well, so change this to count all
ordered bytes instead of just DIO ordered bytes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h        |  2 +-
 fs/btrfs/disk-io.c      |  8 ++++----
 fs/btrfs/ordered-data.c | 13 ++++++-------
 fs/btrfs/space-info.c   | 13 +++++++------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..e817b3b3483d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -790,7 +790,7 @@ struct btrfs_fs_info {
 	/* used to keep from writing metadata until there is a nice batch */
 	struct percpu_counter dirty_metadata_bytes;
 	struct percpu_counter delalloc_bytes;
-	struct percpu_counter dio_bytes;
+	struct percpu_counter ordered_bytes;
 	s32 dirty_metadata_batch;
 	s32 delalloc_batch;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 764001609a15..61bb3321efaa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1466,7 +1466,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
-	percpu_counter_destroy(&fs_info->dio_bytes);
+	percpu_counter_destroy(&fs_info->ordered_bytes);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
@@ -2748,7 +2748,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
-	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
+	ret = percpu_counter_init(&fs_info->ordered_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -4055,9 +4055,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 		       percpu_counter_sum(&fs_info->delalloc_bytes));
 	}
 
-	if (percpu_counter_sum(&fs_info->dio_bytes))
+	if (percpu_counter_sum(&fs_info->ordered_bytes))
 		btrfs_info(fs_info, "at unmount dio bytes count %lld",
-			   percpu_counter_sum(&fs_info->dio_bytes));
+			   percpu_counter_sum(&fs_info->ordered_bytes));
 
 	btrfs_sysfs_remove_mounted(fs_info);
 	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 87bac9ecdf4c..9a277a475a1c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -202,11 +202,11 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
 		set_bit(type, &entry->flags);
 
-	if (dio) {
-		percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
-					 fs_info->delalloc_batch);
+	percpu_counter_add_batch(&fs_info->ordered_bytes, num_bytes,
+				 fs_info->delalloc_batch);
+
+	if (dio)
 		set_bit(BTRFS_ORDERED_DIRECT, &entry->flags);
-	}
 
 	/* one ref for the tree */
 	refcount_set(&entry->refs, 1);
@@ -480,9 +480,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 		btrfs_delalloc_release_metadata(btrfs_inode, entry->num_bytes,
 						false);
 
-	if (test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
-		percpu_counter_add_batch(&fs_info->dio_bytes, -entry->num_bytes,
-					 fs_info->delalloc_batch);
+	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
+				 fs_info->delalloc_batch);
 
 	tree = &btrfs_inode->ordered_tree;
 	spin_lock_irq(&tree->lock);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f1a525251c2a..96d40f8df246 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -489,7 +489,7 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
-	u64 dio_bytes;
+	u64 ordered_bytes;
 	u64 items;
 	long time_left;
 	int loops;
@@ -513,8 +513,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
-	dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
-	if (delalloc_bytes == 0 && dio_bytes == 0) {
+	ordered_bytes = percpu_counter_sum_positive(&fs_info->ordered_bytes);
+	if (delalloc_bytes == 0 && ordered_bytes == 0) {
 		if (trans)
 			return;
 		if (wait_ordered)
@@ -527,11 +527,11 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	 * ordered extents, otherwise we'll waste time trying to flush delalloc
 	 * that likely won't give us the space back we need.
 	 */
-	if (dio_bytes > delalloc_bytes)
+	if (ordered_bytes > delalloc_bytes)
 		wait_ordered = true;
 
 	loops = 0;
-	while ((delalloc_bytes || dio_bytes) && loops < 3) {
+	while ((delalloc_bytes || ordered_bytes) && loops < 3) {
 		btrfs_start_delalloc_roots(fs_info, items);
 
 		loops++;
@@ -553,7 +553,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 		delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
-		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
+		ordered_bytes = percpu_counter_sum_positive(
+						&fs_info->ordered_bytes);
 	}
 }
 
-- 
2.26.2

