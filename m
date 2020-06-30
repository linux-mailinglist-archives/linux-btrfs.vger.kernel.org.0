Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14D20F68C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgF3N7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgF3N7r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9D1C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so18621067qko.7
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnXtZZSzIs9CL8rkYhMWWfG8VP/VpNFi+WpvwqR/TWE=;
        b=FidGbfmu+Y84gsQumxE8Ace+PqnJU4ZkWF7zxvkaNZ41hd//eYLt9pz1W3oGVBEm6X
         +nmmgB6IJzrocNA7Mg4yGZlf/nCu+oXgVc6/QNz9NI3u8NGLjMTyGtATdl9cudsd3gwi
         o0bwDS/F+MifskQFeh/asPIYqZv2tjnPNCtEspEfnV5ZYUoZ3XgD2o4ow9YjGiD+SP5e
         P6LL3ZJp9Ynhc+STIByk1scD1I8nesIF6Z8kRl20JaRZS6Fi0l/xR9VFr73DgEoMJkra
         RgMJ6EQAjSCutbOJoeFV7sPmISq1o0kHD1ayLA41rDPQp8qzq7rk42em6vv7SPJ2b2v6
         PTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnXtZZSzIs9CL8rkYhMWWfG8VP/VpNFi+WpvwqR/TWE=;
        b=ThYzEiHjfDtmytmoVLGT7qDwKMisMn8dn34XvATkUvSLjFnB/2YPP3UVvwRWj5GAq+
         1uaft+GbySr1sX0xj2CwTvJF6y5dPvcTrQk2Ctmx2YUU3yHCyH9K5EZ7x/+FRnpO8WR2
         FOq6KqoQ5XqhiUXXIBm/y0PIZTZxbFogXx6W9bXMBVUBmm0M/FvJZm760i26Gdl3b/if
         6Nx94U/0PRiuGwGaHYCcSgPscQbK5Tsj3pAC8JB7zxN1OKe3UvG01fD/lqXr8RXbz9Zd
         AcIR533sNbxmUtA8wwdniqZxYD1CLOA8/3stLEcJXOIlOV+bT8AxkxeBZiWWSMpKJ+59
         RC+g==
X-Gm-Message-State: AOAM531YsgMO8LABAmDXoUR2uFnoVLLz28990s6MrLTWXdafYhoH2q2/
        Gp739FcMR+DEYiNqgPm620nkCVWrmtwd3g==
X-Google-Smtp-Source: ABdhPJzwqYjpWMPLsDpXwo10J4bo+GnKtL69zef3pf/BnNPgyvnXDLs/p1iJ6WWtSgg+0M5PH9TvmQ==
X-Received: by 2002:a37:c246:: with SMTP id j6mr18992459qkm.444.1593525586304;
        Tue, 30 Jun 2020 06:59:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w28sm2819396qkw.92.2020.06.30.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
Date:   Tue, 30 Jun 2020 09:59:08 -0400
Message-Id: <20200630135921.745612-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The original iteration of flushing had us flushing delalloc and then
checking to see if we could make our reservation, thus we were very
careful about how many pages we would flush at once.

But now that everything is async and we satisfy tickets as the space
becomes available we don't have to keep track of any of this, simply try
and flush the number of dirty inodes we may have in order to reclaim
space to make our reservation.  This cleans up our delalloc flushing
significantly.

The async_pages stuff is dropped because btrfs_start_delalloc_roots()
handles the case that we generate async extents for us, so we no longer
require this extra logic.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 55 +------------------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3f0e6fa31937..1d3af37b0ad0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -476,28 +476,6 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	up_read(&info->groups_sem);
 }
 
-static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
-					 unsigned long nr_pages, u64 nr_items)
-{
-	struct super_block *sb = fs_info->sb;
-
-	if (down_read_trylock(&sb->s_umount)) {
-		writeback_inodes_sb_nr(sb, nr_pages, WB_REASON_FS_FREE_SPACE);
-		up_read(&sb->s_umount);
-	} else {
-		/*
-		 * We needn't worry the filesystem going from r/w to r/o though
-		 * we don't acquire ->s_umount mutex, because the filesystem
-		 * should guarantee the delalloc inodes list be empty after
-		 * the filesystem is readonly(all dirty pages are written to
-		 * the disk).
-		 */
-		btrfs_start_delalloc_roots(fs_info, nr_items);
-		if (!current->journal_info)
-			btrfs_wait_ordered_roots(fs_info, nr_items, 0, (u64)-1);
-	}
-}
-
 static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 					u64 to_reclaim)
 {
@@ -523,10 +501,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
-	u64 async_pages;
 	u64 items;
 	long time_left;
-	unsigned long nr_pages;
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
@@ -567,37 +543,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	loops = 0;
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
-
-		/*
-		 * Triggers inode writeback for up to nr_pages. This will invoke
-		 * ->writepages callback and trigger delalloc filling
-		 *  (btrfs_run_delalloc_range()).
-		 */
-		btrfs_writeback_inodes_sb_nr(fs_info, nr_pages, items);
-
-		/*
-		 * We need to wait for the compressed pages to start before
-		 * we continue.
-		 */
-		async_pages = atomic_read(&fs_info->async_delalloc_pages);
-		if (!async_pages)
-			goto skip_async;
-
-		/*
-		 * Calculate how many compressed pages we want to be written
-		 * before we continue. I.e if there are more async pages than we
-		 * require wait_event will wait until nr_pages are written.
-		 */
-		if (async_pages <= nr_pages)
-			async_pages = 0;
-		else
-			async_pages -= nr_pages;
+		btrfs_start_delalloc_roots(fs_info, items);
 
-		wait_event(fs_info->async_submit_wait,
-			   atomic_read(&fs_info->async_delalloc_pages) <=
-			   (int)async_pages);
-skip_async:
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets) &&
 		    list_empty(&space_info->priority_tickets)) {
-- 
2.24.1

