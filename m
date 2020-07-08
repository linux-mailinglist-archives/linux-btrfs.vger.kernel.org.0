Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80B62189AC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgGHOAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgGHOAl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:41 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25545C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:41 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so15545708qvb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRKc63P5E/fKmHUwzOTIMk+4mmOzl1OUpVjs2y9i3Qw=;
        b=kytZjOyCYHF5oWqdLvrxUPfP5T6amtkdSVmyGKARmw/850CjMai8wKSfBeygv04AXd
         AKFeylCK33VV/R11tOk4okC+Cz6LytKIa7A5Q7PBB1rIuqQ5+Uow3FQoli9Vwbuv67UX
         8OwuE8kPMovss2Yoy1okVOZRm3Yw721SX4GlB5y0UDg2OOkVRSm0dWg+W8SOY9oFWvwJ
         gHOqKMPQKwDLwkGIFAp7ADZn9yMzdQYWvp/EkcLrXMRcYKi9Vol6FnfFrevRg8n7QFIY
         MhzVq2mdnVhn8X6seEh1S6+yJiuulAY6kjTPxZa59X50NNvVoYu5B7ZKtUv/iKBj9MFY
         CKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRKc63P5E/fKmHUwzOTIMk+4mmOzl1OUpVjs2y9i3Qw=;
        b=WegpB66p9J53R1hwdQcIEdYW/TBeXzUFhOErj3BgboUyPkJ17ekcUGdGLgkXJE4/n5
         EIuHsvLu2XPLuOCausXJ/CmhUyc1e9yT9d64XHnp0forjC7BDFK2yWWNYSIe0kfymvl6
         VsihOIr/EPQKhW4SVV4cE/16aGOdrayn+w177NpmLaV94br1DWLkT0LXmIcE4YYmJ7T7
         9rLeHm0k6vKUw1dQ+CwDB6uCsUEQSY74ZELN18agamLJP4O879df5iYKsyTMcAY1EONI
         4IUZb3vD7BOfas4zcqLJ4CPwBfPGqRrrHgkMrKpH621gDdcmUAH5q9yB/tk0QkddrAGe
         duGQ==
X-Gm-Message-State: AOAM531JVWgzdwtNSIBlX2Q5mXcxO39DTn/r9IIbfI8MwBUVJpzexxis
        GiLQDtNKLrJtZRqD1HnsvFW1EEklJpaVSQ==
X-Google-Smtp-Source: ABdhPJwI/cHso0BV9C5m5iWgFahU6h0+4yFknME29mMDZQzdoxYV/dqMR3GfrF8+jZ30kU2XSSHiXA==
X-Received: by 2002:a0c:f0c8:: with SMTP id d8mr58393570qvl.217.1594216839938;
        Wed, 08 Jul 2020 07:00:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e25sm28069950qtc.93.2020.07.08.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
Date:   Wed,  8 Jul 2020 10:00:00 -0400
Message-Id: <20200708140013.56994-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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

