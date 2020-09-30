Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A89327DE23
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgI3B5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgI3B5M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfWv7koY0dyceo8JE3xCSKQAF7wUxt/o89+5X+bjTrg=;
        b=i2aF//8OFdKjoYSQbifEfyw0g9VaZlxJr2uTThJ3NeTRuTiW6Cpnffs4y5/07t5BKW/LWf
        wKrsx2XKf0sq9SVI/UYuMahCD/MZ2IdXn1stHVebGPP87Nrxm9pGkwdapkVMWst8aLM9qO
        YQfYwUMSNV29Y+OqL3O/8epAkxNJmU8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3830AF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 42/49] btrfs: extent_io: make set_extent_buffer_dirty() to support subpage sized metadata
Date:   Wed, 30 Sep 2020 09:55:32 +0800
Message-Id: <20200930015539.48867-43-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
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
 fs/btrfs/extent_io.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d9a05979396d..ae7ab7364115 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5354,6 +5354,22 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -5426,12 +5442,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -5651,6 +5668,22 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
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
+	}
+
 #ifdef CONFIG_BTRFS_DEBUG
 	for (i = 0; i < num_pages; i++)
 		ASSERT(PageDirty(eb->pages[i]));
-- 
2.28.0

