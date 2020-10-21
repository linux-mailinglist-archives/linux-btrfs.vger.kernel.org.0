Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A510129484E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436497AbgJUG1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:44422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLtAXF9WHSiEw0hv457BhohOUxodBdrQq/83YGtEv2w=;
        b=ioV7EDrUBGlMcHP1vpzSFgIWxlnCSsj8i9EdN695JK1zW8p5PlkQPfE3mJILqz0Wy+BnRP
        5lyJN5Ot36DAih2i7JrJ01MzTR92WbVRUiwBuFI/uBF4wHchxAz0/G009886/bNKYygLew
        gPkssw3H6G4+g0O6UGOD398+qFYIDuY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 576F2AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 50/68] btrfs: extent_io: make lock_extent_buffer_for_io() subpage compatible
Date:   Wed, 21 Oct 2020 14:25:36 +0800
Message-Id: <20201021062554.68132-51-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage metadata locking, the following aspects are modified:
- Locking sequence
  For regular sectorsize, we lock extent buffer first, then lock each
  page.
  For subpage sectorsize, we only lock extent buffer, but not to lock
  the page as one page can contain multiple extent buffers.

- Extent io tree locking
  For subpage metadata, we also lock the range in btree io tree.
  This allow the endio function to get unmerged extent_state, so that in
  endio function we don't need to allocate memory in atomic context.
  This also follows the behavior in metadata read path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1e039848539..d07972f94c40 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3943,6 +3943,9 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
  * Lock extent buffer status and pages for write back.
  *
  * May try to flush write bio if we can't get the lock.
+ * For subpage extent buffer, caller is responsible to lock the page, we won't
+ * flush write bio, which can cause extent buffers in the same page submitted
+ * to different bios.
  *
  * Return  0 if the extent buffer doesn't need to be submitted.
  * (E.g. the extent buffer is not dirty)
@@ -3953,26 +3956,41 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
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
@@ -3998,13 +4016,22 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 					 -eb->len,
 					 fs_info->dirty_metadata_batch);
 		ret = 1;
+		btrfs_tree_unlock(eb);
 	} else {
 		spin_unlock(&eb->refs_lock);
+		btrfs_tree_unlock(eb);
+		if (extent_locked)
+			unlock_extent(io_tree, eb->start,
+				      eb->start + eb->len - 1);
 	}
 
-	btrfs_tree_unlock(eb);
 
-	if (!ret)
+	/*
+	 * Either the tree does not need to be submitted, or we're
+	 * submitting subpage extent buffer.
+	 * Either we we don't need to lock the page(s).
+	 */
+	if (!ret || btrfs_is_subpage(fs_info))
 		return ret;
 
 	num_pages = num_extent_pages(eb);
@@ -4046,6 +4073,11 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
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

