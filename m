Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2262824F28D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 08:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXGbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 02:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:36768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgHXGbu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 02:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CBBFAE56
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 06:32:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: change how we calculate the nrptrs for btrfs_buffered_write()
Date:   Mon, 24 Aug 2020 14:31:37 +0800
Message-Id: <20200824063139.70880-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824063139.70880-1-wqu@suse.com>
References: <20200824063139.70880-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

@nrptrs of btrfs_bufferd_write() determines the up limit of pages we can
process in one batch.

Normally we want it to be as large as possible as btrfs metadata/data
reserve and release can cost quite a lot of time.

Commit 142349f541d0 ("btrfs: lower the dirty balance poll interval")
introduced two extra limitations which are suspicious now:
- limit the page number to nr_dirtied_pause - nr_dirtied
  However I can't find any mainline fs nor iomap utilize these two
  members.
  Although page write back still uses those two members, as no other fs
  utilizeing them at all, I doubt about the usefulness.

- ensure we always have 8 pages allocates
  The 8 lower limit looks pretty strange, this means even we're just
  writing 4K, we will allocate page* for 8 pages no matter what.
  To me, this 8 pages look more like a upper limit.

This patch will change it by:
- Extract the calculation into another function
  This allows us to add more comment explaining every calculation.

- Do proper page alignment calculation
  The old calculation, DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE)
  doesn't take @pos into consideration.
  In fact we can easily have iov_iter_count(i) == 2, but still cross two
  pages. (pos == page_offset() + PAGE_SIZE - 1).

- Remove the useless max(8)

- Use PAGE_SIZE independent up limit
  Now we use 64K as nr_pages limit, so we should get similar performance
  between different arches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5a818ebcb01f..c592350a5a82 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1620,6 +1620,29 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
+/* Helper to get how many pages we should alloc for the batch */
+static int get_nr_pages(struct btrfs_fs_info *fs_info, loff_t pos,
+			struct iov_iter *iov)
+{
+	int nr_pages;
+
+	/*
+	 * Try to cover the full iov range, as btrfs metadata/data reserve
+	 * and release can be pretty slow, thus the more pages we process in
+	 * one batch the better.
+	 */
+	nr_pages = (round_up(pos + iov_iter_count(iov), PAGE_SIZE) -
+		    round_down(pos, PAGE_SIZE)) / PAGE_SIZE;
+
+	/*
+	 * But still limit it to 64KiB, so we can still get a similar
+	 * buffered write performance between different page sizes
+	 */
+	nr_pages = min_t(int, nr_pages, SZ_64K / PAGE_SIZE);
+
+	return nr_pages;
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1638,10 +1661,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 
-	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
-			PAGE_SIZE / (sizeof(struct page *)));
-	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
-	nrptrs = max(nrptrs, 8);
+	nrptrs = get_nr_pages(fs_info, pos, i);
 	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
-- 
2.28.0

