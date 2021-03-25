Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEC3489F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCYHPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCYHPY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcKcn6lT10xpe/artok4RQBVTpeCfv0NItQhwPwie6U=;
        b=X0JhmsY6cG2xe6FE6CXa4bq8vzzqnMrnnoGEkaacayj+alqF3IMpSJMlSgPOa0lr2puLSY
        LiB4dnjsjyiBLMY4unsvkg5czFjXX5CaFrP6G6fpZsc12qLL/Bfc6pe6fWyty/YStSRwV2
        MGuPR0eO/xDDJGWxV+Daard6Gy7BqvM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59E46AD4A
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:15:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 12/13] btrfs: make set_btree_ioerr() accept extent buffer and to be subpage compatible
Date:   Thu, 25 Mar 2021 15:14:44 +0800
Message-Id: <20210325071445.90896-13-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
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
index 6844d951f2c1..9c0c6f1d7710 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4012,12 +4012,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
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
 
@@ -4025,7 +4024,6 @@ static void set_btree_ioerr(struct page *page)
 	 * If we error out, we should add back the dirty_metadata_bytes
 	 * to make it consistent.
 	 */
-	fs_info = eb->fs_info;
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 				 eb->len, fs_info->dirty_metadata_batch);
 
@@ -4069,13 +4067,13 @@ static void set_btree_ioerr(struct page *page)
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
@@ -4100,7 +4098,7 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 		if (bio->bi_status ||
 		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
 			ClearPageUptodate(page);
-			set_btree_ioerr(page);
+			set_btree_ioerr(page, eb);
 		}
 
 		end_page_writeback(page);
@@ -4156,7 +4154,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
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

