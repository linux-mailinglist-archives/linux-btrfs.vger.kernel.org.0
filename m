Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279E82281F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgGUOW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgGUOW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F117C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so410600qtn.7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRKc63P5E/fKmHUwzOTIMk+4mmOzl1OUpVjs2y9i3Qw=;
        b=T2CSDLu9C2YBc/MjoahruamjAyScjld+2gy9GzNKvwHuhEiPQPgyff79LtHzXiR9Fc
         Y6vu1bHm4XcOAFQUrPRgNvuujDc8iZCSG+P+bBcvXD7FwiFphU/+gc5jzvtbocisPtTi
         kxnw5MsUlrw0x0JxgzoFfZ3Aqrnq8x47XgkS+CWPIZ57OngKxpNdM+FAZxYGIzzZN5rr
         i/c5GXvV08lHDlADIDIzw+oHa5MqoSaRIO3y2eN9ayqgvtHSyBdBVkAA7+2NsWStkm5d
         2+ZKyECKgvylX9izbmK0vUQXJF1h3kSMz7A+GXE8RJ2NDyfV5T7gfRihUvyZcCmgXs2a
         KRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRKc63P5E/fKmHUwzOTIMk+4mmOzl1OUpVjs2y9i3Qw=;
        b=P6a6T5TqWIDFgrG5CXia3qvQz3DKKhrmPkPdfkA0srx3VdG8TuufYVX3lgR8wCePp+
         +4N1+7iJepmkT7cklun0V0NHXVSojKXETPVbwQjZqABeIgQPeggP40fHBA0wPYXS1lgl
         Ze5qpxI12CQqmUpamFJ+On1yWK9OkyCqWaNK80yjIFj3bkOvgo+DhvTURDD5oHUOhQUd
         9cF6KQox20j/HF+z3fT2wegvnPRr9ole0AyO91wEd7hVTfKQSFOQFzGKaD4SAo6zt9Uf
         q/J3Lllczr5HZbfr55IKQNTeahFZ3KqGKmFGmZatxq1HgQ6hPuVEF+q9QlOfkQwjX6k5
         pYfQ==
X-Gm-Message-State: AOAM533NTbgVyUnG/S7TCPRl3TSP4dkAYpGnxDGZ4X43jmMF6HrDwvGW
        bohR3+J3lxTGlXITH+nPt/1GatU4wQDghg==
X-Google-Smtp-Source: ABdhPJxmuS08CfgOG4MKn5aOUem2qNVtLwNMZAstC9wlIRQc6bnJY75LgiZZ/WcHw5HclXXih9N2Wg==
X-Received: by 2002:ac8:4d85:: with SMTP id a5mr28694352qtw.60.1595341377093;
        Tue, 21 Jul 2020 07:22:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v184sm2741335qki.12.2020.07.21.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
Date:   Tue, 21 Jul 2020 10:22:21 -0400
Message-Id: <20200721142234.2680-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index 8450864c5b77..de8a49de5fdb 100644
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

