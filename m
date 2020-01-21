Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DBE144537
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 20:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAUTe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 14:34:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38028 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 14:34:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so3957313qki.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=APUmSdEBavMGuEdXrLeoEsw5TY2AFWjwc9iE1vOC/jo=;
        b=tK8v6ce9GD6p40Vx9AL8OpJ9MM1ptwj75CX02GhMHyGFCrYXhuANOwlJv/SO5MbTzA
         NB+jlSt7JwWFbqEOhL77Qzpa+NgVsApSkEsTFVezd9FB2cmqfUgycsw16OMvJXBsuX43
         GqewYqLsi/ORu9LTzTt9s/Hv8ztRrk6eewriavto9DjlQJIIrpEJQ69r1kurAObYty6A
         KhXv563iujF9yVwsjch2EyCu8dXZmv4L32Pl39XQyCCr6Op5+aXouNwdyvb16pXmcZKy
         /Q3sSODEqiY8+TU6g93+ghRzD/vj4u/8kXrE6IYdSOfHa7zhdoD0Da13fTX6yrs9RUXG
         lz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APUmSdEBavMGuEdXrLeoEsw5TY2AFWjwc9iE1vOC/jo=;
        b=mOzIyGRbYfHB8OiCWa7L7H1PdT9VInYMJkjOwq77tEe0MfhyyOSlHKK3p0F+te4bb3
         MS4DORTjD/y5KnkmuuP6yt6riEj4ftjcCG9BnYTPNd6yW/LPk7DEaFKR8tWVXdCVh/Xb
         9xFk6aGmAWMl8+oezcBY+wAp+ROiJ6sDLi4x41i1z0LmZOYUkGdvg6eiCiloFG2zLG2M
         FZ5W8LxmKD247pdXM/SPkJjU6c9kcT2+xkD7n5MAunJMvekR0x3z1wE8+tOuOU4NJjNb
         z3EhzfjvkdMiZXIo/rejFXhCLoWw8Ki1bKyG62n6yViTPflKTbC+OcjUD+ySZT+2zcdV
         5HgQ==
X-Gm-Message-State: APjAAAWcd9URDvLVBTFeA2ACqOX/mC5j1mUvu3HTiqpMA7lMrPxGA0CJ
        1ElxCjED7KcIFJ3iRV5Fhv8nIah/GRBHGQ==
X-Google-Smtp-Source: APXvYqweQeQut7lMWBXaULE8pgsJRHmh1pW+e99t7RFWTax/5Ko5Ej5HAI/oE2n2/LQJWSXAwvXAbQ==
X-Received: by 2002:a37:6794:: with SMTP id b142mr6244120qkc.216.1579635294132;
        Tue, 21 Jan 2020 11:34:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k9sm19703389qtq.75.2020.01.21.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 11:34:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v3] btrfs: do not do delalloc reservation under page lock
Date:   Tue, 21 Jan 2020 14:34:52 -0500
Message-Id: <20200121193452.2175678-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121165144.2174309-4-josef@toxicpanda.com>
References: <20200121165144.2174309-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We ran into a deadlock in production with the fixup worker.  The stack
traces were as follows

Thread responsible for the writeout, waiting on the page lock

[<0>] io_schedule+0x12/0x40
[<0>] __lock_page+0x109/0x1e0
[<0>] extent_write_cache_pages+0x206/0x360
[<0>] extent_writepages+0x40/0x60
[<0>] do_writepages+0x31/0xb0
[<0>] __writeback_single_inode+0x3d/0x350
[<0>] writeback_sb_inodes+0x19d/0x3c0
[<0>] __writeback_inodes_wb+0x5d/0xb0
[<0>] wb_writeback+0x231/0x2c0
[<0>] wb_workfn+0x308/0x3c0
[<0>] process_one_work+0x1e0/0x390
[<0>] worker_thread+0x2b/0x3c0
[<0>] kthread+0x113/0x130
[<0>] ret_from_fork+0x35/0x40
[<0>] 0xffffffffffffffff

Thread of the fixup worker who is holding the page lock

[<0>] start_delalloc_inodes+0x241/0x2d0
[<0>] btrfs_start_delalloc_roots+0x179/0x230
[<0>] btrfs_alloc_data_chunk_ondemand+0x11b/0x2e0
[<0>] btrfs_check_data_free_space+0x53/0xa0
[<0>] btrfs_delalloc_reserve_space+0x20/0x70
[<0>] btrfs_writepage_fixup_worker+0x1fc/0x2a0
[<0>] normal_work_helper+0x11c/0x360
[<0>] process_one_work+0x1e0/0x390
[<0>] worker_thread+0x2b/0x3c0
[<0>] kthread+0x113/0x130
[<0>] ret_from_fork+0x35/0x40
[<0>] 0xffffffffffffffff

Thankfully the stars have to align just right to hit this.  First you
have to end up in the fixup worker, which is tricky by itself (my
reproducer does DIO reads into a MMAP'ed region, so not a common
operation).  Then you have to have less than a page size of free data
space and 0 unallocated space so you go down the "commit the transaction
to free up pinned space" path.  This was accomplished by a random
balance that was running on the host.  Then you get this deadlock.

I'm still in the process of trying to force the deadlock to happen on
demand, but I've hit other issues.  I can still trigger the fixup worker
path itself so this patch has been tested in that regard, so the normal
case is fine.

Fixes: 87826df0ec36 ("btrfs: delalloc for page dirtied out-of-band in fixup worker")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- Use a delayed iput in the fixup worker.  I *think* we can deadlock if we do
  the final iput and need to flush space, which may trigger the fixup worker
  which is busy doing our iput.  Err on the side of caution and use a delayed
  iput.

 fs/btrfs/inode.c | 71 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 69f8e65b378b..9320f13778ce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2198,6 +2198,7 @@ int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
 /* see btrfs_writepage_start_hook for details on why this is required */
 struct btrfs_writepage_fixup {
 	struct page *page;
+	struct inode *inode;
 	struct btrfs_work work;
 };
 
@@ -2212,9 +2213,20 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	u64 page_start;
 	u64 page_end;
 	int ret = 0;
+	bool free_delalloc_space = true;
 
 	fixup = container_of(work, struct btrfs_writepage_fixup, work);
 	page = fixup->page;
+	inode = fixup->inode;
+	page_start = page_offset(page);
+	page_end = page_offset(page) + PAGE_SIZE - 1;
+
+	/*
+	 * This is similar to page_mkwrite, we need to reserve the space before
+	 * we take the page lock.
+	 */
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
+					   PAGE_SIZE);
 again:
 	lock_page(page);
 
@@ -2223,25 +2235,48 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	 * page->mapping may go NULL, but it shouldn't be moved to a
 	 * different address space.
 	 */
-	if (!page->mapping || !PageDirty(page) || !PageChecked(page))
+	if (!page->mapping || !PageDirty(page) || !PageChecked(page)) {
+		/*
+		 * Unfortunately this is a little tricky, either
+		 *
+		 * 1) We got here and our page had already been dealt with and
+		 *    we reserved our space, thus ret == 0, so we need to just
+		 *    drop our space reservation and bail.  This can happen the
+		 *    first time we come into the fixup worker, or could happen
+		 *    while waiting for the ordered extent.
+		 * 2) Our page was already dealt with, but we happened to get an
+		 *    ENOSPC above from the btrfs_delalloc_reserve_space.  In
+		 *    this case we obviously don't have anything to release, but
+		 *    because the page was already dealt with we don't want to
+		 *    mark the page with an error, so make sure we're resetting
+		 *    ret to 0.  This is why we have this check _before_ the ret
+		 *    check, because we do not want to have a surprise ENOSPC
+		 *    when the page was already properly dealt with.
+		 */
+		if (!ret) {
+			btrfs_delalloc_release_extents(BTRFS_I(inode),
+						       PAGE_SIZE);
+			btrfs_delalloc_release_space(inode, data_reserved,
+						     page_start, PAGE_SIZE,
+						     true);
+		}
+		ret = 0;
 		goto out_page;
+	}
 
 	/*
-	 * we keep the PageChecked() bit set until we're done with the
-	 * btrfs_start_ordered_extent() dance that we do below.  That
-	 * drops and retakes the page lock, so we don't want new
-	 * fixup workers queued for this page during the churn.
+	 * We can't mess with the page state unless it is locked, so now that we
+	 * are locked bail if we failed to make our space reservation.
 	 */
-	inode = page->mapping->host;
-	page_start = page_offset(page);
-	page_end = page_offset(page) + PAGE_SIZE - 1;
+	if (ret)
+		goto out_page;
 
 	lock_extent_bits(&BTRFS_I(inode)->io_tree, page_start, page_end,
 			 &cached_state);
 
 	/* already ordered? We're done */
 	if (PagePrivate2(page))
-		goto out;
+		goto out_reserved;
 
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start,
 					PAGE_SIZE);
@@ -2254,11 +2289,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		goto again;
 	}
 
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
-					   PAGE_SIZE);
-	if (ret)
-		goto out;
-
 	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
 					&cached_state);
 	if (ret)
@@ -2272,12 +2302,12 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	 * The page was dirty when we started, nothing should have cleaned it.
 	 */
 	BUG_ON(!PageDirty(page));
+	free_delalloc_space = false;
 out_reserved:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-	if (ret)
+	if (free_delalloc_space)
 		btrfs_delalloc_release_space(inode, data_reserved, page_start,
 					     PAGE_SIZE, true);
-out:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
 			     &cached_state);
 out_page:
@@ -2296,6 +2326,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	put_page(page);
 	kfree(fixup);
 	extent_changeset_free(data_reserved);
+	btrfs_add_delayed_iput(inode);
 }
 
 /*
@@ -2333,10 +2364,18 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 	if (!fixup)
 		return -EAGAIN;
 
+	/*
+	 * We are already holding a reference to this inode from
+	 * write_cache_pages.  We need to hold it because the space reservation
+	 * takes place outside of the page lock, and we can't trust
+	 * page->mapping outside of the page lock.
+	 */
+	ihold(inode);
 	SetPageChecked(page);
 	get_page(page);
 	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL);
 	fixup->page = page;
+	fixup->inode = inode;
 	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
 
 	return -EAGAIN;
-- 
2.24.1

