Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300A82889C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgJIN2j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbgJIN2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE8AC0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c5so7897052qtw.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TNchmHo9Lcyrgb7+5XCiMKeNczgC1I7OF5JL5wmyvvM=;
        b=tXJ0VJc3Li8VEe8/dYd9XLtWDvdXWb+Wud/EnqHBLmIhekLDhsUxxJPNxvKhP6l/60
         xRlIMYF1Gj6NtYaQAfHlxARM0t41RVevMMP88sIbrnod1Wp3yI+n3KyAsV9ZX6JfhlY7
         vgtgeivhuad/WEgoAJBDw8t7lKQq0c8hYEpNmjhEbn62xtyjEXUCKF5gKG6poeiR39OK
         komn0i4z0NKXZntAL1ixHPiyXBKIxN2FK9nNaONDdQXV1vVH2d0fWJ7MrafYPYtZmvN+
         MzJfp7KD9F0Lg6GyZstAKK9tRdr07/aV3v+VUt32vpass4/kgq36wyUXQhPu3yi5bbs6
         Rttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNchmHo9Lcyrgb7+5XCiMKeNczgC1I7OF5JL5wmyvvM=;
        b=pvX+xQXA4IPJzCLPERxg/LOwumRjzSLbE8CfM/fSdWM0WJjyxfxK5qJ0U8fB/4cEr3
         V+drfj+sPCFOI/ByYbOKHiWX3oE6vjaAZvXHmVigQwkdRgiCSMzeJcZLM1+2kN+khD3a
         0w2+4LmtqcDglZMUXFxg1dRrX6KJD1ZnyhXP/N/e3QIDV4bO2AzB0DpeF8+868GBJ+pL
         7TKH1jlzvaMW1I3sUE0WJGZxwjtZJABeU8sD/YggSLNKhglb5AqVQt6BJZFcyWHy76kE
         oqTWMqXON8UjX2jx2ZzoT6+WpX0wJrLqHe4yEWzMKnh8CDi/rAAHZl6FbQv/kxJETeRk
         Lvrw==
X-Gm-Message-State: AOAM531y237DUIrVBOuLg+RA2VdwxQYMH9FdL/hNwGtgAt4dy5Du9zjH
        rV1MGk8xID3U5Ez4rnkbFjCEltZenfygAIRY
X-Google-Smtp-Source: ABdhPJzfazSe4x/lHjkKvJ8fuPpkEGW8XLbDjVTl1Gpw73DXFslg0BCgbPlyvPOFry/4VKIRQGBbqQ==
X-Received: by 2002:aed:362a:: with SMTP id e39mr13372648qtb.121.1602250117529;
        Fri, 09 Oct 2020 06:28:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r187sm5864933qkc.63.2020.10.09.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 03/12] btrfs: track ordered bytes instead of just dio ordered bytes
Date:   Fri,  9 Oct 2020 09:28:20 -0400
Message-Id: <578ef22806511ccbe29ebe9e70bb6524793ba813.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c   | 18 +++++++-----------
 4 files changed, 18 insertions(+), 23 deletions(-)

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
index ac7269cf1904..540960365787 100644
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
 		btrfs_start_delalloc_roots(fs_info, items);
 
 		loops++;
@@ -553,7 +548,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 		delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
-		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
+		ordered_bytes = percpu_counter_sum_positive(
+						&fs_info->ordered_bytes);
 	}
 }
 
-- 
2.26.2

