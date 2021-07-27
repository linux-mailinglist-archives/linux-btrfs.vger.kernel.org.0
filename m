Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54D3D6E9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhG0GCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 02:02:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0GCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 02:02:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B66C200BC
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 06:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627365751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NpSDGb5GQUASxCepAPn/Ma67Sp2stQgg7M4ijFHZaAs=;
        b=VhFa/ahQ/NpS6cxn2oSP/0WBi4K22WISOOey3sn55YDCUwMYyhyxIC55OAdd3ieOSX4ysK
        pvOoBrW0sh67DRz4gc1AtR9Vlz6b6GUWgZdS5yI3C7XLPqcjXPIve1vtFaQtfEfL6xvs4x
        YPdfnKIJ7QKjo8ArbfP3k0fMPV4lDMk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 704B2133DE
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 06:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id lvwdDHah/2D6dgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 06:02:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the unnecessary @nr_written parameters
Date:   Tue, 27 Jul 2021 14:02:27 +0800
Message-Id: <20210727060227.172750-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
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
 fs/btrfs/extent_io.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b0751920f5ee..d97fb7fca899 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3798,12 +3798,13 @@ static void update_nr_written(struct writeback_control *wbc,
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
+	/* Number of pages started by the delalloc range */
+	unsigned long nr_written = 0;
 	int ret;
 	int page_started = 0;
 
@@ -3819,7 +3820,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			continue;
 		}
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
-				delalloc_end, &page_started, nr_written, wbc,
+				delalloc_end, &page_started, &nr_written, wbc,
 				true);
 		if (ret) {
 			btrfs_page_set_error(inode->root->fs_info, page,
@@ -3858,7 +3859,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		 * the mapping's writeback index, just update
 		 * nr_to_write.
 		 */
-		wbc->nr_to_write -= *nr_written;
+		wbc->nr_to_write -= nr_written;
 		return 1;
 	}
 
@@ -3926,7 +3927,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 struct writeback_control *wbc,
 				 struct extent_page_data *epd,
 				 loff_t i_size,
-				 unsigned long nr_written,
 				 int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -3946,7 +3946,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	if (ret) {
 		/* Fixup worker will requeue */
 		redirty_page_for_writepage(wbc, page);
-		update_nr_written(wbc, nr_written);
 		unlock_page(page);
 		return 1;
 	}
@@ -3955,7 +3954,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
 	 */
-	update_nr_written(wbc, nr_written + 1);
+	update_nr_written(wbc, 1);
 
 	while (cur <= end) {
 		u64 disk_bytenr;
@@ -4094,7 +4093,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	size_t pg_offset;
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
-	unsigned long nr_written = 0;
 
 	trace___extent_writepage(page, inode, wbc);
 
@@ -4123,8 +4121,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (!epd->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, wbc,
-					 &nr_written);
+		ret = writepage_delalloc(BTRFS_I(inode), page, wbc);
 		if (ret == 1)
 			return 0;
 		if (ret)
@@ -4132,7 +4129,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, epd, i_size,
-				    nr_written, &nr);
+				    &nr);
 	if (ret == 1)
 		return 0;
 
-- 
2.32.0

