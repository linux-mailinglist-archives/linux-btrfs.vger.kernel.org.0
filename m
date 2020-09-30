Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C185327DE25
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgI3B5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgI3B5R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2D4tuPYMVI49qB8ctr0d9pHlZR4ZnqLI8lYfLMyEsC0=;
        b=A5IGfnoGNi9H045BYs+nIVa+hrSNy7yQklyMjj1+h6b/glmcAb9zrhidFSTkJvLfXpiR28
        BoyrKScI2ZBFHDr8Jaf7K1JLEqPQ/+EmHvapDYLZbv165+alwevT9JndBSN/HcHN8689zT
        DuEE6K7nRjb2xTYSqtWe3nu5vrLdq9Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF0D8AE07
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 44/49] btrfs: extent_io: make set_btree_ioerr() accept extent buffer
Date:   Wed, 30 Sep 2020 09:55:34 +0800
Message-Id: <20200930015539.48867-45-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
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

Also since we are here, change how we grab "fs_info->flags" by using the
fs_info directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 07dec345f662..f80ba4c13fe6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3907,10 +3907,9 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	return ret;
 }
 
-static void set_btree_ioerr(struct page *page)
+static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 {
-	struct extent_buffer *eb = (struct extent_buffer *)page->private;
-	struct btrfs_fs_info *fs_info;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 
 	SetPageError(page);
 	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
@@ -3920,7 +3919,6 @@ static void set_btree_ioerr(struct page *page)
 	 * If we error out, we should add back the dirty_metadata_bytes
 	 * to make it consistent.
 	 */
-	fs_info = eb->fs_info;
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 				 eb->len, fs_info->dirty_metadata_batch);
 
@@ -3964,13 +3962,13 @@ static void set_btree_ioerr(struct page *page)
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
@@ -3995,7 +3993,7 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 		if (bio->bi_status ||
 		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
 			ClearPageUptodate(page);
-			set_btree_ioerr(page);
+			set_btree_ioerr(page, eb);
 		}
 
 		end_page_writeback(page);
@@ -4051,7 +4049,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 					 end_bio_extent_buffer_writepage,
 					 0, 0, 0, false);
 		if (ret) {
-			set_btree_ioerr(p);
+			set_btree_ioerr(p, eb);
 			if (PageWriteback(p))
 				end_page_writeback(p);
 			if (atomic_sub_and_test(num_pages - i, &eb->io_pages))
-- 
2.28.0

