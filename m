Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B122B29484C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440834AbgJUG1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IxhoKgeEr3UTnU1OJxt8dgSF5UFeU09NqjuBNYOI1Yg=;
        b=HZlL99z6qs13cz6qyyePZPKi+A5S1RtyovIoiCKGs3mW1ZmrH0okV4dzhknbw3O8dZeDoR
        FTNSWe5yT6/J9OYPl2QJOarzCwfgGXqB5cI0WtBA7MuGXKqFBaakeWdZ8aDNXg12pX38RR
        l/6TaKWN7sLZTUatIZA8QGhbho5OoqA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2AD8AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 48/68] btrfs: extent_io: make set_btree_ioerr() accept extent buffer
Date:   Wed, 21 Oct 2020 14:25:34 +0800
Message-Id: <20201021062554.68132-49-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
index 76123d0f416a..1e182dfbb499 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4047,10 +4047,9 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
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
@@ -4060,7 +4059,6 @@ static void set_btree_ioerr(struct page *page)
 	 * If we error out, we should add back the dirty_metadata_bytes
 	 * to make it consistent.
 	 */
-	fs_info = eb->fs_info;
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 				 eb->len, fs_info->dirty_metadata_batch);
 
@@ -4104,13 +4102,13 @@ static void set_btree_ioerr(struct page *page)
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
@@ -4135,7 +4133,7 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 		if (bio->bi_status ||
 		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
 			ClearPageUptodate(page);
-			set_btree_ioerr(page);
+			set_btree_ioerr(page, eb);
 		}
 
 		end_page_writeback(page);
@@ -4191,7 +4189,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
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

