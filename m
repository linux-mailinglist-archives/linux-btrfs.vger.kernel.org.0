Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7544E193
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 06:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhKLFgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 00:36:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKLFgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 00:36:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1976421B1F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636695213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sWUko77XU88dL5OkkjPbu/65596NVZfR12LlAoKWGEo=;
        b=BrVXAT9s0PZgCEqkz1+jx0xMc+vaj9gNJ6gSVv86imFTSkVbYbjJtRVdEzJ3V79yeZIbn4
        /X5KBG56edA8CiKbOAKhE1IEOB6CmPnCxVCmEqckdtKZnRgwCIDwQo7LhTU88sSr+TuAH8
        kS72X6oRRgDEVuhX2N5ta2Dc4sDTO9A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F0D413E3B
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 05:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vq9oCaz8jWEWTAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 05:33:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: remove unnecessary @nr_written parameters
Date:   Fri, 12 Nov 2021 13:33:14 +0800
Message-Id: <20211112053314.30009-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use @nr_written to record how many pages have been started by
btrfs_run_delalloc_range().

Currently there are only two cases that would populate @nr_written:

- Inline extent creation
- Compressed write

But both cases will also set @page_started to one.

In fact, in writepage_delalloc() we have the following code, showing
that @nr_written is really only utilized for above two cases:

	/* did the fill delalloc function already unlock and start
	 * the IO?
	 */
	if (page_started) {
		/*
		 * we've unlocked the page, so we can't update
		 * the mapping's writeback index, just update
		 * nr_to_write.
		 */
		wbc->nr_to_write -= nr_written;
		return 1;
	}

But for such cases, writepage_delalloc() will return 1, and exit
__extent_writepage() without going through __extent_writepage_io().

Thus this means, inside __extent_writepage_io(), we always get
@nr_written as 0.

So this patch is going to remove the unnecessary parameter from the
following functions:

- writepage_delalloc()

  As @nr_written passed in is always the initial value 0.

  Although inside that function, we still need a local @nr_written
  to update wbc->nr_to_write.

- __extent_writepage_io()

  As explained above, @nr_written passed in can only be 0.

  This also means we can remove one update_nr_written() call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Rebased to lastest misc-next
- Small comment update for old comments
---
 fs/btrfs/extent_io.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4e03a6d3aa32..47bbc2f79273 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3785,12 +3785,13 @@ static void update_nr_written(struct writeback_control *wbc,
  * This returns < 0 if there were errors (page still locked)
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
-		struct page *page, struct writeback_control *wbc,
-		unsigned long *nr_written)
+		struct page *page, struct writeback_control *wbc)
 {
 	const u64 page_end = page_offset(page) + PAGE_SIZE - 1;
 	u64 delalloc_start = page_offset(page);
 	u64 delalloc_to_write = 0;
+	/* How many pages are started by btrfs_run_delalloc_range() */
+	unsigned long nr_written = 0;
 	int ret;
 	int page_started = 0;
 
@@ -3806,7 +3807,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			continue;
 		}
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
-				delalloc_end, &page_started, nr_written, wbc);
+				delalloc_end, &page_started, &nr_written, wbc);
 		if (ret) {
 			btrfs_page_set_error(inode->root->fs_info, page,
 					     page_offset(page), PAGE_SIZE);
@@ -3829,16 +3830,14 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 					 thresh);
 	}
 
-	/* did the fill delalloc function already unlock and start
-	 * the IO?
-	 */
+	/* Did btrfs_run_dealloc_range() already unlock and start the IO? */
 	if (page_started) {
 		/*
-		 * we've unlocked the page, so we can't update
+		 * We've unlocked the page, so we can't update
 		 * the mapping's writeback index, just update
 		 * nr_to_write.
 		 */
-		wbc->nr_to_write -= *nr_written;
+		wbc->nr_to_write -= nr_written;
 		return 1;
 	}
 
@@ -3910,7 +3909,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 struct writeback_control *wbc,
 				 struct extent_page_data *epd,
 				 loff_t i_size,
-				 unsigned long nr_written,
 				 int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -3929,7 +3927,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	if (ret) {
 		/* Fixup worker will requeue */
 		redirty_page_for_writepage(wbc, page);
-		update_nr_written(wbc, nr_written);
 		unlock_page(page);
 		return 1;
 	}
@@ -3938,7 +3935,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
 	 */
-	update_nr_written(wbc, nr_written + 1);
+	update_nr_written(wbc, 1);
 
 	while (cur <= end) {
 		u64 disk_bytenr;
@@ -4076,7 +4073,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	size_t pg_offset;
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
-	unsigned long nr_written = 0;
 
 	trace___extent_writepage(page, inode, wbc);
 
@@ -4105,7 +4101,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (!epd->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, &nr_written);
+		ret = writepage_delalloc(BTRFS_I(inode), page, wbc);
 		if (ret == 1)
 			return 0;
 		if (ret)
@@ -4113,7 +4109,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, epd, i_size,
-				    nr_written, &nr);
+				    &nr);
 	if (ret == 1)
 		return 0;
 
-- 
2.33.1

