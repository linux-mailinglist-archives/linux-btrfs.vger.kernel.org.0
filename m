Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B15D333860
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhCJJJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:09:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:34872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232700AbhCJJJC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:09:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TElCWuNZMZo/S1OFUwv5ZzDImbOvoJUb08wR9xNk/us=;
        b=pydv/ueUrSnR09gFiysAAOGj6MLCjImWvTqX5ls+AY4hyQhMczPCmWN02oJLS6+hjUqQP0
        wLLWtixBL4dz8kpXwB7Bf4TVWeo4B81qVTi4IdEW11HIBfbWB5tdbxRFqPBLHlUY4yXIPw
        lZlkpG/Uo88Ser3nvqqycZg8oX7T5RA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF681AD74
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:09:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/15] btrfs: make set_btree_ioerr() accept extent buffer and to be subpage compatible
Date:   Wed, 10 Mar 2021 17:08:29 +0800
Message-Id: <20210310090833.105015-12-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current set_btree_ioerr() only accepts @page parameter and grabs extent
buffer from page::private.

This works fine for sector size == PAGE_SIZE case, but not for subpage
case.

Adds an extra parameter, @eb, for callers to pass extent buffer to this
function, so that subpage code can reuse this function.

And also add subpage special handling to update
btrfs_subpage::error_bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d16d92107bc..b6fbb512abfd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3982,12 +3982,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	return ret;
 }
 
-static void set_btree_ioerr(struct page *page)
+static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 {
-	struct extent_buffer *eb = (struct extent_buffer *)page->private;
-	struct btrfs_fs_info *fs_info;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 
-	SetPageError(page);
+	btrfs_page_set_error(fs_info, page, eb->start, eb->len);
 	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
 		return;
 
@@ -3995,7 +3994,6 @@ static void set_btree_ioerr(struct page *page)
 	 * If we error out, we should add back the dirty_metadata_bytes
 	 * to make it consistent.
 	 */
-	fs_info = eb->fs_info;
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 				 eb->len, fs_info->dirty_metadata_batch);
 
@@ -4039,13 +4037,13 @@ static void set_btree_ioerr(struct page *page)
 	 */
 	switch (eb->log_index) {
 	case -1:
-		set_bit(BTRFS_FS_BTREE_ERR, &eb->fs_info->flags);
+		set_bit(BTRFS_FS_BTREE_ERR, &fs_info->flags);
 		break;
 	case 0:
-		set_bit(BTRFS_FS_LOG1_ERR, &eb->fs_info->flags);
+		set_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags);
 		break;
 	case 1:
-		set_bit(BTRFS_FS_LOG2_ERR, &eb->fs_info->flags);
+		set_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags);
 		break;
 	default:
 		BUG(); /* unexpected, logic error */
@@ -4070,7 +4068,7 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 		if (bio->bi_status ||
 		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
 			ClearPageUptodate(page);
-			set_btree_ioerr(page);
+			set_btree_ioerr(page, eb);
 		}
 
 		end_page_writeback(page);
@@ -4126,7 +4124,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 					 end_bio_extent_buffer_writepage,
 					 0, 0, 0, false);
 		if (ret) {
-			set_btree_ioerr(p);
+			set_btree_ioerr(p, eb);
 			if (PageWriteback(p))
 				end_page_writeback(p);
 			if (atomic_sub_and_test(num_pages - i, &eb->io_pages))
-- 
2.30.1

