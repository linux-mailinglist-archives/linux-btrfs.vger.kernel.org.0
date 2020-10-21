Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90B029484A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440829AbgJUG1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:44246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgjENHHmLth06O1Zk0SfixXcVngmFirYjT/+wPiPKZc=;
        b=RH2sRL+h32TbblP7cFK+qof5j5LL9pBynOgWoJswHqYHNltT5z6hAovSq67RtJU80v6yqp
        Yk06TR70pERAr2MuFjSrduVVxJgU6NmPVXr5tLhvLjF/2Oba+Kdma7yabrcbqc/ZM2jKR8
        DKw3yu4EteQHpZ3u9fmYlAbr9/BbfeM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF022AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 46/68] btrfs: extent_io: make set_extent_buffer_dirty() to support subpage sized metadata
Date:   Wed, 21 Oct 2020 14:25:32 +0800
Message-Id: <20201021062554.68132-47-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For set_extent_buffer_dirty() to support subpage sized metadata, we only
need to call set_extent_dirty().

As any dirty extent buffer in the page would make the whole page dirty,
we can re-use the existing routine without problem, just need to add
above call of set_extent_buffer_dirty().

Now since a page is dirty if any extent buffer in it is dirty, the
WARN_ON() in alloc_extent_buffer() can be falsely triggered, also update
the WARN_ON(PageDirty()) check into assert_eb_range_not_dirty() to
support subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f67d88586d05..2cb9abdb0d60 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5494,6 +5494,22 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 }
 #endif
 
+static void assert_eb_range_not_dirty(struct extent_buffer *eb,
+				      struct page *page)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+
+	if (btrfs_is_subpage(fs_info) && page->mapping) {
+		struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+
+		WARN_ON(test_range_bit(io_tree, eb->start,
+				eb->start + eb->len - 1, EXTENT_DIRTY, 0,
+				NULL));
+	} else {
+		WARN_ON(PageDirty(page));
+	}
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start)
 {
@@ -5566,12 +5582,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			 * drop the ref the old guy had.
 			 */
 			ClearPagePrivate(p);
+			assert_eb_range_not_dirty(eb, p);
 			WARN_ON(PageDirty(p));
 			put_page(p);
 		}
 		attach_extent_buffer_page(eb, p);
 		spin_unlock(&mapping->private_lock);
-		WARN_ON(PageDirty(p));
+		assert_eb_range_not_dirty(eb, p);
 		eb->pages[i] = p;
 		if (!PageUptodate(p))
 			uptodate = 0;
@@ -5791,6 +5808,24 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 		for (i = 0; i < num_pages; i++)
 			set_page_dirty(eb->pages[i]);
 
+	/*
+	 * For subpage size, also set the sector aligned EXTENT_DIRTY range for
+	 * btree io tree
+	 */
+	if (btrfs_is_subpage(eb->fs_info)) {
+		struct extent_io_tree *io_tree =
+			info_to_btree_io_tree(eb->fs_info);
+
+		/*
+		 * set_extent_buffer_dirty() can be called with
+		 * path->leave_spinning == 1, in that case we can't sleep.
+		 */
+		set_extent_dirty(io_tree, eb->start, eb->start + eb->len - 1,
+				 GFP_ATOMIC);
+		set_page_dirty(eb->pages[0]);
+		return was_dirty;
+	}
+
 #ifdef CONFIG_BTRFS_DEBUG
 	for (i = 0; i < num_pages; i++)
 		ASSERT(PageDirty(eb->pages[i]));
-- 
2.28.0

