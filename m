Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542F4151153
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBCUuN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35658 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgBCUuN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so15722462qki.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOfkyzOUkFULcMpjwDQqJD9gUSljfm479gIu1cilTPQ=;
        b=MCIk6UKYL1IAGZuvN6Ld3DEL/VyAQQCl56cyOiBskseffxzvNAcsspC4pSrA9IQwPa
         0+qpr/y5JbBDm/9O/jXIJ3SRUIbULmrtU5MKUtFud5ODBmpGuCP+frjaJCHgEz5vDyfL
         uQAEGLXpu/4uc0vU9HIadgCOPbi2wvUZXMF2LRQzZaZnprg43QGS1ametIUa/lm/GHRJ
         AsjW1wrOOBmGtv8JeajOLB9AA0VDS38l4MiVB/3XfRSDnCdMgo+fv5ONVGNkYkCaF2Tc
         BTC/YcCu/0+Wazzd4ec+WLsNUBr3Ha6FKiLrOk/+vtjFOS/MWXB45YjAnlA0cfgmtGeJ
         hy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOfkyzOUkFULcMpjwDQqJD9gUSljfm479gIu1cilTPQ=;
        b=cVmocuFHMRYfWX5p9i4r3HrWheSzDJ44kZp6fyxIOfQw8xykaDgoFDD+9JUCxd0YTs
         TFpq90IaE5XZQBuMAc3i2kQvwT1MKc55NOSQHkDjFl62Fq5HXimD8ZPDpZABgVxKfoAI
         vgbkxVEki/1x906O/AzY50h9DikQejd4ZnLbarx8FvENGaUrqOrVSO1zPSJudVTEs1zz
         XEOqVWa1DeWXyWFVuGWRBChH0vAyF/q/QgOfGkpJUqtoQdFAXAcx5AP6da8biAi95XCl
         F5gU/HwM+cJxvODGt4lYSHPZb3cCW1HzFEJp5tCkEmwRv075VHTsplPyWjCBuxN7BeVO
         336g==
X-Gm-Message-State: APjAAAUF4RoPBb8aqzZSCWA9i/zgopjYXLtjLm/hindB6zz4sfnjeB7m
        EgVN4AiyXGiu0UlbFfBzJxPDHMP3jejT0A==
X-Google-Smtp-Source: APXvYqwHP7Gn4o/Hqk9Km/nsfBO2tmDY6IsuVS3HF30gGPhvZNJGqFd/vop6XX/O82GZ4c0q7pBjUQ==
X-Received: by 2002:a37:a8ca:: with SMTP id r193mr25724833qke.346.1580763010658;
        Mon, 03 Feb 2020 12:50:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a24sm9812378qkl.82.2020.02.03.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/24] btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
Date:   Mon,  3 Feb 2020 15:49:37 -0500
Message-Id: <20200203204951.517751-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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

