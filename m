Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3F14F4D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgAaWgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43461 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgAaWgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so6682217qtj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2b5P75+IzoL0lqF+p1WcmspeZm2Y3yh4egu0l6pb7eo=;
        b=z2mA7ZW2iGURSgtx7Td4mGqFrE8uQ8+M8YgLs4N0sPX2YlUkPhi8wojkFySQW3eV77
         FrG9LEIi2wXaCCKHCOMr5EZ3LlleNcf7rvnJcMmRfkCzdZ0pxzHg4sJvNsbn/Djv8nss
         Fh++5U3/3MmSzfbguKMsQvCxLYeAiCUUde0Ak0PVELC7O9zUhOk5APuEyaFWrYnRmEzS
         xOs6ucAwcUj5KlEX5cEGrPy75ddJRfDF9xkN29qpMUn9KDHQnUD8UBs+WiXaGq3WTQc8
         3nfiIEcVwas2Zbrf3VnZal3wZHN/5p4J8Q7n+QdoB6OXPRQ23ASndpEnfWhxXYZ7KIsf
         iPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2b5P75+IzoL0lqF+p1WcmspeZm2Y3yh4egu0l6pb7eo=;
        b=WDLwLEm4iViVpQ3Zcf1CPnFg//z9h0KA18S9EHJ6xz4D1+Y1MfbHlcJVE3LzRHP7Bn
         hP0mTi4XQFwCtmbELPhYESn7n2To4bhwcGC0XK8mr8086zF/22/+59hjGcmsDCX4ekx4
         rdUzWf/cLpAV2VawjjccTWY3+hXjLEntlZO/iYI86CeO3mUMb5AM3jXDM4tARlqriilT
         h64W3UVcy28ErwfosoQmb+Fnpipp0pt0kwIYDg4izF7Cn2zzZc5/yy1jj0WvQi46ZCYL
         cNZgVAYWhPYW/JmSfty12Nm10QTVMXh3seNgMAAY77TFgftSt0N/IO3irqE1RpiX/wnz
         nR2w==
X-Gm-Message-State: APjAAAXvkteu7NmOO8gvv+AlOX97e27G6l00jHfazVAVn+kQd1ntozH7
        mlfkDfMALeQtAtwcogBXnTLZdw+JgMelHQ==
X-Google-Smtp-Source: APXvYqxrvgNo8mdeARaoFXud2Hnpk57D0NBYmB79H45AqJZGLmwn7853EW1eyWk6OxLJpkbF+cKRVw==
X-Received: by 2002:ac8:3418:: with SMTP id u24mr12938167qtb.87.1580510194003;
        Fri, 31 Jan 2020 14:36:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 16sm5307547qkm.93.2020.01.31.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
Date:   Fri, 31 Jan 2020 17:36:00 -0500
Message-Id: <20200131223613.490779-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 55 +------------------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5a92851af2b3..a69e3d9057ff 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -309,28 +309,6 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
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
@@ -356,10 +334,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
-	u64 async_pages;
 	u64 items;
 	long time_left;
-	unsigned long nr_pages;
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
@@ -400,37 +376,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
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

