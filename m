Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6704304D44
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 00:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbhAZXHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbhAZVZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:25 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D81AC0613ED
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:44 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p5so70468qvs.7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHHw5KS1v6RcJLBwNqbChzsgddI3N4GcSf5BsyrTz94=;
        b=1rJhsZ3SaXfM0lP7T0TZGB6t/x3GJ2LmKrza8RCJJA7aNvAZPet2re094pyQMY4Yuw
         G+3U35NI5mDlVGd2c9sbNU+Jd3hOOKb8a8o39sM4sVjMbgr2i8jAWIdrRyceHPvOqzJW
         Ho/MM6eGwlSwm7/zQ5yKLux+84+93RHMPTQ3bbzHG+8dCiGJ1ZmaU9HkXnFfHWj40tyD
         gOn+XPCQmCCiG/WlsLB3OTQAeuPUAMvq/qSi3U1ENsGLQRHIyu7VoJt0pcOqxPK50nv0
         3rEX8GGs43h4tKF3T2Q6pcU/dUM+lZrDPI+/y1PEz3vkmd0RF5+kzbzeSSAvI6h3jj+S
         wAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHHw5KS1v6RcJLBwNqbChzsgddI3N4GcSf5BsyrTz94=;
        b=TsUSom/lOhbYtt+m2+G7BXbL+CTqs3ZQbLxbpXF9dRpyZVcPMt/7JgorFiS7UUhCmU
         CnJ+pp1DtbQps2h914g2cwIscxC0EYTFVxUzPq80PclccqJvzOoyQJmLcse6Lcu0Bh2w
         9R3fWosd1p6e6pRpYBgGOGC/+3rd2VYeXqCXcSm3J4Jrr5XKXKfjA/oYWuRX+7+6DsOv
         mzHdE0uIjKgRkQOxA1FQXGaEXoJukvAHL6Sxa7ILb15a52P6DnJwIjEhRGZJRthI4xF4
         GAt+kR9R2ff6EazaTecTKbuVI+na8hZhRng5/f8Hbl6ZZAX7IlHLeJk1XZQodzQpx5Md
         FphA==
X-Gm-Message-State: AOAM530uTVk+HiA/6rT8MnS/qs3/EkzLEMOKx8zwAm5r1a4QYaXEzfd9
        t5IwbFjfg9ZFb189asdAA/MYlq9Dcu77+2QN
X-Google-Smtp-Source: ABdhPJxiOEIKFAYkLqebP9tzgTCTFkY8J4gV3UcfQYK6YTHN2omW1OgLnIFuEFxu6ks7iZzbvvCVSw==
X-Received: by 2002:ad4:55cd:: with SMTP id bt13mr6726776qvb.6.1611696283209;
        Tue, 26 Jan 2021 13:24:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w28sm8844316qtv.93.2021.01.26.13.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 03/12] btrfs: track ordered bytes instead of just dio ordered bytes
Date:   Tue, 26 Jan 2021 16:24:27 -0500
Message-Id: <4447efff3c9450d1903758e1dde899623885241f.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h        |  2 +-
 fs/btrfs/disk-io.c      |  8 ++++----
 fs/btrfs/ordered-data.c | 13 ++++++-------
 fs/btrfs/space-info.c   | 18 +++++++-----------
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ed6bb46a2572..7d8660227520 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -797,7 +797,7 @@ struct btrfs_fs_info {
 	/* used to keep from writing metadata until there is a nice batch */
 	struct percpu_counter dirty_metadata_bytes;
 	struct percpu_counter delalloc_bytes;
-	struct percpu_counter dio_bytes;
+	struct percpu_counter ordered_bytes;
 	s32 dirty_metadata_batch;
 	s32 delalloc_batch;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5473bed6a7e8..e0d56b3d1223 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1469,7 +1469,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
-	percpu_counter_destroy(&fs_info->dio_bytes);
+	percpu_counter_destroy(&fs_info->ordered_bytes);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
@@ -2802,7 +2802,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
-	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
+	ret = percpu_counter_init(&fs_info->ordered_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -4163,9 +4163,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
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
index b4e6500548a2..e8dee1578d4a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -206,11 +206,11 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	       type == BTRFS_ORDERED_COMPRESSED);
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
@@ -503,9 +503,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
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
index af6ab30e36e7..ff138cef7d0b 100644
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
@@ -513,25 +513,20 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
-	dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
-	if (delalloc_bytes == 0 && dio_bytes == 0) {
-		if (trans)
-			return;
-		if (wait_ordered)
-			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
+	ordered_bytes = percpu_counter_sum_positive(&fs_info->ordered_bytes);
+	if (delalloc_bytes == 0 && ordered_bytes == 0)
 		return;
-	}
 
 	/*
 	 * If we are doing more ordered than delalloc we need to just wait on
 	 * ordered extents, otherwise we'll waste time trying to flush delalloc
 	 * that likely won't give us the space back we need.
 	 */
-	if (dio_bytes > delalloc_bytes)
+	if (ordered_bytes > delalloc_bytes)
 		wait_ordered = true;
 
 	loops = 0;
-	while ((delalloc_bytes || dio_bytes) && loops < 3) {
+	while ((delalloc_bytes || ordered_bytes) && loops < 3) {
 		u64 temp = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
 		long nr_pages = min_t(u64, temp, LONG_MAX);
 
@@ -556,7 +551,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 		delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
-		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
+		ordered_bytes = percpu_counter_sum_positive(
+						&fs_info->ordered_bytes);
 	}
 }
 
-- 
2.26.2

