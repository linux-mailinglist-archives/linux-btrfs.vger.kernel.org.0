Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2614110B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 19:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgAQSpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 13:45:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44445 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 13:45:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id w8so8112958qts.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFsqefi7HnS6rwBfMuBNQ/eYaSi2dW4bRFXq/10IfFE=;
        b=otGgjFg0S809OxKe81tdkvchEtMsz8Q+xZgMxf02kOL3Cih2R19iCRUFiLzyqV5UNr
         i6WpHw+FdvgCP4l6S6LNkLNIj1Yyq1haR9L1G6WsGfqM9nqyib52T2KpGMVXcIomcK16
         CnPt1guLyGXXd+HLm+0+p/s3T3+fkmPQKssM9zGI353ve6veRZ7y0uBkz+yENKwv34eh
         kpm9bcTNeycMajntpbojBo3HAHjEr1DiRtqCNEYzCTIZlqHmKDzmFOdjkJRE/UWF+oML
         SgWbuthj9O2M/eZwsJN4ouHK1VuIR4Z/0HOg8g2L6LjcInEysWwfMFD22FPOIBz4R/uW
         SnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFsqefi7HnS6rwBfMuBNQ/eYaSi2dW4bRFXq/10IfFE=;
        b=CmglOPMb+rYncxH1D1OzDz68HODs9vRm7Mr8E/2GFu8UAbtXqZOZbaOjNOKoGittc2
         l6k01ei7+u8yYlvzGZL2baIt9bfdxZKesy70HqH1h6o/1XnG6e3GB40MxsuMluRBNh7z
         fVJlbJoOfYoaZtj/0C2xPl22IgB1FhgF0FG5wCAyF/eNyiAxFV7UySfio5E0GV1UdNo/
         AgnY8pFU1QzcviZne9eScTq6QgJ168/Bcz83oFXTh3QuCRr94VKC3I54NKO6lEqtrJnX
         HJWw5l1oEjs7LdlIfVozD6V2vlXWkGYcxMNPL7DREeCCgYxpIrG23MgBpg3R+EmENvNx
         8jjg==
X-Gm-Message-State: APjAAAWX4BXYe+ptV6fCtqGo8Zco1dQaul3mytRt1c4/p4LHXLqyKxIw
        hqsPorhmddjy/ZZ68JK+nyJPNSMZTOTLUQ==
X-Google-Smtp-Source: APXvYqwt5Eom0/XlQNYnGxOklVeRbLIGp2yRgiYRauQH/ML/aVTFMSFlJF1+ZSnqtb7dKamac9Asuw==
X-Received: by 2002:ac8:408e:: with SMTP id p14mr9139741qtl.66.1579286698932;
        Fri, 17 Jan 2020 10:44:58 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x19sm13346079qtm.47.2020.01.17.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 10:44:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not do delalloc reservation under page lock
Date:   Fri, 17 Jan 2020 13:44:57 -0500
Message-Id: <20200117184457.1343-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
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
 fs/btrfs/inode.c | 55 ++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da31571b150b..9886c15e00d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2198,6 +2198,7 @@ int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
 /* see btrfs_writepage_start_hook for details on why this is required */
 struct btrfs_writepage_fixup {
 	struct page *page;
+	struct inode *inode;
 	struct btrfs_work work;
 };
 
@@ -2212,26 +2213,37 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	u64 page_start;
 	u64 page_end;
 	int ret;
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
+	if (ret) {
+		mapping_set_error(inode->i_mapping, ret);
+		goto out_page;
+	}
 again:
 	lock_page(page);
 	if (!page->mapping || !PageDirty(page) || !PageChecked(page)) {
 		ClearPageChecked(page);
-		goto out_page;
+		goto out_reserved;
 	}
 
-	inode = page->mapping->host;
-	page_start = page_offset(page);
-	page_end = page_offset(page) + PAGE_SIZE - 1;
-
 	lock_extent_bits(&BTRFS_I(inode)->io_tree, page_start, page_end,
 			 &cached_state);
 
 	/* already ordered? We're done */
 	if (PagePrivate2(page))
-		goto out;
+		goto out_reserved;
 
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start,
 					PAGE_SIZE);
@@ -2244,39 +2256,32 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		goto again;
 	}
 
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
-					   PAGE_SIZE);
-	if (ret) {
-		mapping_set_error(page->mapping, ret);
-		end_extent_writepage(page, ret, page_start, page_end);
-		ClearPageChecked(page);
-		goto out;
-	 }
-
 	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
 					&cached_state);
 	if (ret) {
 		mapping_set_error(page->mapping, ret);
 		end_extent_writepage(page, ret, page_start, page_end);
 		ClearPageChecked(page);
-		goto out_reserved;
+		goto out;
 	}
 
 	ClearPageChecked(page);
 	set_page_dirty(page);
+	free_delalloc_space = false;
+out:
+	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
+			     &cached_state);
 out_reserved:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-	if (ret)
+	if (free_delalloc_space)
 		btrfs_delalloc_release_space(inode, data_reserved, page_start,
 					     PAGE_SIZE, true);
-out:
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
-			     &cached_state);
-out_page:
 	unlock_page(page);
+out_page:
 	put_page(page);
 	kfree(fixup);
 	extent_changeset_free(data_reserved);
+	iput(inode);
 }
 
 /*
@@ -2307,10 +2312,18 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
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
 	return -EBUSY;
 }
-- 
2.24.1

