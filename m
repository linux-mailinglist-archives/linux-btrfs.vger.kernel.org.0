Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79F427DE27
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgI3B5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:51142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbgI3B5V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCU1gdUHsGiMPxMjDplrQJ0PCIqbC/J9C9iJRZpzwRU=;
        b=JSYyByXh2ExLFDDIqv1CFEzUFiaNqSZuX+rZcc1NQZAeW8VI77w6l+zUNge4gVNE7nPYLt
        NSO+Ssgt2nh0G66wQJYWxbuU5CKQ3fzd1QaTW9I3HuGSw2wgHN3JLH6m93UE8tfpxKkEC5
        wWGm/9SQ0l/pAZ1A1BKL00ShkG0a5/M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7A5CAF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 46/49] btrfs: extent_io: make lock_extent_buffer_for_io() subpage compatible
Date:   Wed, 30 Sep 2020 09:55:36 +0800
Message-Id: <20200930015539.48867-47-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage metadata locking, the following aspects are modified:
- Locking sequence
  For regular sectorsize, we lock extent buffer first, then lock each
  page.
  For subpage sectorsize, we can't do that anymore, but let the caller
  to lock the whole page first, then lock each extent buffer in the
  page.

- Extent io tree locking
  For subpage metadata, we also lock the range in btree io tree.
  This allow the endio function to get unmerged extent_state, so that in
  endio function we don't need to allocate memory in atomic context.
  This also follows the behavior in metadata read path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 47 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 736bc33a0e64..be8c863f7806 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3803,6 +3803,9 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
  * Lock extent buffer status and pages for write back.
  *
  * May try to flush write bio if we can't get the lock.
+ * For subpage extent buffer, caller is responsible to lock the page, we won't
+ * flush write bio, which can cause extent buffers in the same page submitted
+ * to different bios.
  *
  * Return  0 if the extent buffer doesn't need to be submitted.
  * (E.g. the extent buffer is not dirty)
@@ -3813,26 +3816,47 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 			  struct extent_page_data *epd)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
 	int i, num_pages, failed_page_nr;
+	bool extent_locked = false;
 	int flush = 0;
 	int ret = 0;
 
+	if (btrfs_is_subpage(fs_info)) {
+		/*
+		 * For subpage extent buffer write, caller is responsible to
+		 * lock the page first.
+		 */
+		ASSERT(PageLocked(eb->pages[0]));
+
+		/*
+		 * Also lock the range so that endio can always get unmerged
+		 * extent_state.
+		 */
+		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		if (ret < 0)
+			goto out;
+		extent_locked = true;
+	}
+
 	if (!btrfs_try_tree_write_lock(eb)) {
 		ret = flush_write_bio(epd);
 		if (ret < 0)
-			return ret;
+			goto out;
 		flush = 1;
 		btrfs_tree_lock(eb);
 	}
 
 	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
-		if (!epd->sync_io)
-			return 0;
+		if (!epd->sync_io) {
+			ret = 0;
+			goto out;
+		}
 		if (!flush) {
 			ret = flush_write_bio(epd);
 			if (ret < 0)
-				return ret;
+				goto out;
 			flush = 1;
 		}
 		while (1) {
@@ -3860,11 +3884,19 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 		ret = 1;
 	} else {
 		spin_unlock(&eb->refs_lock);
+		if (extent_locked)
+			unlock_extent(io_tree, eb->start,
+				      eb->start + eb->len - 1);
 	}
 
 	btrfs_tree_unlock(eb);
 
-	if (!ret)
+	/*
+	 * Either the tree does not need to be submitted, or we're
+	 * submitting subpage extent buffer.
+	 * Either we we don't need to lock the page(s).
+	 */
+	if (!ret || btrfs_is_subpage(fs_info))
 		return ret;
 
 	num_pages = num_extent_pages(eb);
@@ -3906,6 +3938,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 				 fs_info->dirty_metadata_batch);
 	btrfs_clear_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
 	btrfs_tree_unlock(eb);
+	/* Subpage should never reach this routine */
+	ASSERT(!btrfs_is_subpage(fs_info));
+out:
+	if (extent_locked)
+		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1);
 	return ret;
 }
 
-- 
2.28.0

