Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E877314427A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 17:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAUQvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 11:51:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42067 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAUQvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 11:51:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so2641883qke.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0wNrU2aPvsE4v2HqBVOLad1V73ySZ4Kw5khlHhY1Ms=;
        b=R4nxzcgSFFIX4JRN5yyAkbzzi3p8GZnMwv8NP7wU0gyPSaQR8k2kWw0UnvdZPbU4/R
         vyCkN5L9bGi3eolpedYgj8PFQk2BdJIuUt899xv9HmEL71qj/svczpr/O5hK1YpPHADt
         S9aU37AeakIyRP+QQM6r2Bup3eMnMB6HXwK+NE0qxYYZsxYmAtsvLD4B3MIoSYSbvS5f
         az8XwhESmTwbcpws1AWuXK4zAkMBo6HwRag1j7cQDuxlkw6ApYz3UigvCj/VssDsOp9g
         Ntbv5Ife01QeWBfurYDIYrZcYc2hZAuP322VZDA6Hf/lOp89TTwKDIotX/xS9R3Uf8wT
         pqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0wNrU2aPvsE4v2HqBVOLad1V73ySZ4Kw5khlHhY1Ms=;
        b=hqMnu49RwsYzzUHGJP431fSG26ho0BOtkYwBwXFp3ky2cG0Y7YonoDyGe9PPC5UXah
         P8MXlKMb0HElxq25swI67kO8LY69uMQG1kwpMQxduqFeMgrrIY65tNtD6rdUhImCqiEI
         Tm94diWvnoQKsCpq75tQg+a2f0ljCpx7taJcelqWpqD2eaaIxirRj5R/vNTvfBJQMx8b
         oBxvSLLuqoyoNZdpQRI70yBa4ozYmPItKizRRfZSkO8Rfl2evjoS1lsSVXWiSjESjDHF
         JOdo7obt9+vVzZNx1nIyAEbBHFT8HPPLF5LnT/VGH2u0Q9F7Z0+SlKSO7OapyXpeXB3K
         5LFA==
X-Gm-Message-State: APjAAAXJwpRxCke2MEP9zJOeXclDRjzDyx6KiNW4vKMHbx4sAD+6jrx9
        JJAvkECtq23LzsmZiR1S1XK8WZpq5zxz8g==
X-Google-Smtp-Source: APXvYqzA6Fvfw5Xc5yJl85pzpBR96nF77YkbYtIU1pjgYkJvoYb/OkIS58YDAGMlWr/P6WAnO34zIA==
X-Received: by 2002:a05:620a:4a:: with SMTP id t10mr5647445qkt.296.1579625509497;
        Tue, 21 Jan 2020 08:51:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m21sm17537059qka.117.2020.01.21.08.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:51:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Chris Mason <clm@fb.com>
Subject: [PATCH 1/3] Btrfs: keep pages dirty when using btrfs_writepage_fixup_worker
Date:   Tue, 21 Jan 2020 11:51:42 -0500
Message-Id: <20200121165144.2174309-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121165144.2174309-1-josef@toxicpanda.com>
References: <20200121165144.2174309-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

For COW, btrfs expects pages dirty pages to have been through a few setup
steps.  This includes reserving space for the new block allocations and marking
the range in the state tree for delayed allocation.

A few places outside btrfs will dirty pages directly, especially when unmapping
mmap'd pages.  In order for these to properly go through COW, we run them
through a fixup worker to wait for stable pages, and do the delalloc prep.

87826df0ec36 added a window where the dirty pages were cleaned, but pending
more action from the fixup worker.  We clear_page_dirty_for_io() before
we call into writepage, so the page is no longer dirty.  The commit
changed it so now we leave the page clean between unlocking it here and
the fixup worker starting at some point in the future.

During this window, page migration can jump in and relocate the page.  Once our
fixup work actually starts, it finds page->mapping is NULL and we end up
freeing the page without ever writing it.

This leads to crc errors and other exciting problems, since it screws up the
whole statemachine for waiting for ordered extents.  The fix here is to keep
the page dirty while we're waiting for the fixup worker to get to work.
This is accomplished by returning -EAGAIN from btrfs_writepage_cow_fixup
if we queued the page up for fixup, which will cause the writepage
function to redirty the page.

Because we now expect the page to be dirty once it gets to the fixup
worker we must adjust the error cases to call clear_page_dirty_for_io()
on the page.  That is the bulk of the patch, but it is not the fix, the
fix is the -EAGAIN from btrfs_writepage_cow_fixup.  We cannot separate
these two changes out because the error conditions change with the new
expectations.

Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 61 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da31571b150b..69f8e65b378b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2211,17 +2211,27 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	struct inode *inode;
 	u64 page_start;
 	u64 page_end;
-	int ret;
+	int ret = 0;
 
 	fixup = container_of(work, struct btrfs_writepage_fixup, work);
 	page = fixup->page;
 again:
 	lock_page(page);
-	if (!page->mapping || !PageDirty(page) || !PageChecked(page)) {
-		ClearPageChecked(page);
+
+	/*
+	 * before we queued this fixup, we took a reference on the page.
+	 * page->mapping may go NULL, but it shouldn't be moved to a
+	 * different address space.
+	 */
+	if (!page->mapping || !PageDirty(page) || !PageChecked(page))
 		goto out_page;
-	}
 
+	/*
+	 * we keep the PageChecked() bit set until we're done with the
+	 * btrfs_start_ordered_extent() dance that we do below.  That
+	 * drops and retakes the page lock, so we don't want new
+	 * fixup workers queued for this page during the churn.
+	 */
 	inode = page->mapping->host;
 	page_start = page_offset(page);
 	page_end = page_offset(page) + PAGE_SIZE - 1;
@@ -2246,24 +2256,22 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 
 	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
 					   PAGE_SIZE);
-	if (ret) {
-		mapping_set_error(page->mapping, ret);
-		end_extent_writepage(page, ret, page_start, page_end);
-		ClearPageChecked(page);
+	if (ret)
 		goto out;
-	 }
 
 	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
 					&cached_state);
-	if (ret) {
-		mapping_set_error(page->mapping, ret);
-		end_extent_writepage(page, ret, page_start, page_end);
-		ClearPageChecked(page);
+	if (ret)
 		goto out_reserved;
-	}
 
-	ClearPageChecked(page);
-	set_page_dirty(page);
+	/*
+	 * everything went as planned, we're now the proud owners of a
+	 * Dirty page with delayed allocation bits set and space reserved
+	 * for our COW destination.
+	 *
+	 * The page was dirty when we started, nothing should have cleaned it.
+	 */
+	BUG_ON(!PageDirty(page));
 out_reserved:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	if (ret)
@@ -2273,6 +2281,17 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
 			     &cached_state);
 out_page:
+	if (ret) {
+		/*
+		 * We hit ENOSPC or other errors.  Update the mapping and page
+		 * to reflect the errors and clean the page.
+		 */
+		mapping_set_error(page->mapping, ret);
+		end_extent_writepage(page, ret, page_start, page_end);
+		clear_page_dirty_for_io(page);
+		SetPageError(page);
+	}
+	ClearPageChecked(page);
 	unlock_page(page);
 	put_page(page);
 	kfree(fixup);
@@ -2300,6 +2319,13 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 	if (TestClearPagePrivate2(page))
 		return 0;
 
+	/*
+	 * PageChecked is set below when we create a fixup worker for this page,
+	 * don't try to create another one if we're already PageChecked()
+	 *
+	 * The extent_io writepage code will redirty the page if we send
+	 * back EAGAIN.
+	 */
 	if (PageChecked(page))
 		return -EAGAIN;
 
@@ -2312,7 +2338,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL);
 	fixup->page = page;
 	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
-	return -EBUSY;
+
+	return -EAGAIN;
 }
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
-- 
2.24.1

