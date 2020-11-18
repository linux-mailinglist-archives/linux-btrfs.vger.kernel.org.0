Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126692B7999
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKRIxs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiPPDMMgipJI7Lx96z3mVMeHfhxE0jO+psrNZsOwyN4=;
        b=slcgx4bUJiINXkrbfPvGz6AquFLHhBmOEF1ft9QaWl7qvUPR2whUWZmgYQtFW1z5nTNFqD
        5tbKWDpYx3pD9H/1G0almKwvoJ4nPtkFBB2tXSwo1zQGu9nz0t0I52W+po0TP4I7PtHJhP
        xXf9F6/fVVjANaTNidDjG8s6iaBKfXw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3E8EAD2F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/14] btrfs: extent_io: make endio_readpage_update_page_status() to handle subpage case
Date:   Wed, 18 Nov 2020 16:53:15 +0800
Message-Id: <20201118085319.56668-11-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To handle subpage status update, add the following new tricks:
- Set btrfs_subpage::error_bitmap
  Now if we hit an error, we set the corresponding bits in error bitmap,
  then call ClearPageUptodate() and SetPageError().

- Uptodate page status according to uptodate_bitmap
  Now we only SetPageUptodate() when the full page contains uptodate
  sectors.
  Also if we cleared all error bit during read, then we also
  ClearPageError()

- No page unlock for metadata
  Since metadata doesn't utilize page locking at all, skip it for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 56 +++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/extent_io.h |  1 +
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 35aee688d6c1..236de0b6b20a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2847,15 +2847,59 @@ endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
-static void endio_readpage_update_page_status(struct page *page, bool uptodate)
+static void endio_readpage_update_page_status(struct page *page, bool uptodate,
+					      u64 start, u64 end)
 {
-	if (uptodate) {
-		SetPageUptodate(page);
-	} else {
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_subpage *subpage;
+	int bit_start;
+	int nbits;
+	bool all_uptodate = false;
+	bool no_error = false;
+
+	ASSERT(page_offset(page) <= start &&
+		end <= page_offset(page) + PAGE_SIZE - 1);
+
+	if (!btrfs_is_subpage(fs_info)) {
+		if (uptodate) {
+			SetPageUptodate(page);
+		} else {
+			ClearPageUptodate(page);
+			SetPageError(page);
+		}
+		unlock_page(page);
+		return;
+	}
+
+	ASSERT(PagePrivate(page) && page->private);
+	subpage = (struct btrfs_subpage *)page->private;
+	bit_start = (start - page_offset(page)) >> fs_info->sectorsize_bits;
+	nbits = fs_info->nodesize >> fs_info->sectorsize_bits;
+
+	if (!uptodate) {
+		spin_lock_bh(&subpage->lock);
+		bitmap_set(subpage->error_bitmap, bit_start, nbits);
+		spin_unlock_bh(&subpage->lock);
+
 		ClearPageUptodate(page);
 		SetPageError(page);
+		return;
 	}
-	unlock_page(page);
+
+	spin_lock_bh(&subpage->lock);
+	bitmap_set(subpage->uptodate_bitmap, bit_start, nbits);
+	bitmap_clear(subpage->error_bitmap, bit_start, nbits);
+	if (bitmap_full(subpage->uptodate_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE))
+		all_uptodate = true;
+	if (bitmap_empty(subpage->error_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE))
+		no_error = true;
+	spin_unlock_bh(&subpage->lock);
+
+	if (no_error)
+		ClearPageError(page);
+	if (all_uptodate)
+		SetPageUptodate(page);
+	return;
 }
 
 /*
@@ -2985,7 +3029,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		}
 		bio_offset += len;
 
-		endio_readpage_update_page_status(page, uptodate);
+		endio_readpage_update_page_status(page, uptodate, start, end);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 11e1e013cb8c..b4d0e39ebceb 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -312,6 +312,7 @@ struct btrfs_subpage {
 	spinlock_t lock;
 	DECLARE_BITMAP(tree_block_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE);
 	DECLARE_BITMAP(uptodate_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE);
+	DECLARE_BITMAP(error_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE);
 };
 
 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
-- 
2.29.2

