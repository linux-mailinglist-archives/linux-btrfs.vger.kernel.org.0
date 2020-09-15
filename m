Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53097269DE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIOFgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgIOFgV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:36:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26841AF39
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:36:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 18/19] btrfs: implement btree_readpage() and try_release_extent_buffer() for subpage
Date:   Tue, 15 Sep 2020 13:35:31 +0800
Message-Id: <20200915053532.63279-19-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btree_readpage() we just block the function, as btree read should
only be triggered by btrfs itself, VFS shouldn't need to bother.

For try_release_extent_buffer(), we just iterate through all the range
with EXTENT_NEW set, and try freeing each extent buffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  6 +++++
 fs/btrfs/extent_io.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1de5a0fef2f5..769ffb191683 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1048,6 +1048,12 @@ static int btree_writepages(struct address_space *mapping,
 
 static int btree_readpage(struct file *file, struct page *page)
 {
+	/*
+	 * For subpage, we don't support VFS to call btree_readpages(),
+	 * directly.
+	 */
+	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
+		return -ENOTTY;
 	return extent_read_full_page(page, btree_get_extent, 0);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 75437a55a986..4eceae7183c9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6324,10 +6324,72 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	}
 }
 
+static int try_release_subpage_eb(struct page *page)
+{
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	u64 cur = page_offset(page);
+	u64 end = page_offset(page) + PAGE_SIZE - 1;
+	int ret;
+
+	while (cur <= end) {
+		struct extent_buffer *eb;
+		u64 found_start;
+		u64 found_end;
+
+		spin_lock(&page->mapping->private_lock);
+		ret = find_first_extent_bit(io_tree, cur, &found_start,
+				&found_end, EXTENT_NEW, NULL);
+		/* No found or found range beyond end */
+		if (ret > 0 || found_start > end) {
+			spin_unlock(&page->mapping->private_lock);
+			goto out;
+		}
+
+		/* found_start can be smaller than cur */
+		cur = max(cur, found_start);
+
+		/*
+		 * Here we have private_lock and is very safe to lookup the
+		 * radix tree.
+		 * And we can't call find_extent_buffer() which will increase
+		 * eb->refs.
+		 */
+		eb = radix_tree_lookup(&fs_info->buffer_radix,
+				cur / fs_info->sectorsize);
+		ASSERT(eb);
+		cur = eb->start + eb->len;
+
+		spin_lock(&eb->refs_lock);
+		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb) ||
+		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
+			spin_unlock(&eb->refs_lock);
+			spin_unlock(&page->mapping->private_lock);
+			continue;
+		}
+		spin_unlock(&page->mapping->private_lock);
+		/*
+		 * Here we don't care the return value, we will always check
+		 * the EXTENT_NEW bits at the end.
+		 */
+		release_extent_buffer(eb);
+	}
+out:
+	/* Finally check if there is any EXTENT_NEW bit in the range */
+	if (test_range_bit(io_tree, page_offset(page), end, EXTENT_NEW, 0,
+			   NULL))
+		ret = 0;
+	else
+		ret = 1;
+	return ret;
+}
+
 int try_release_extent_buffer(struct page *page)
 {
 	struct extent_buffer *eb;
 
+	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
+		return try_release_subpage_eb(page);
 	/*
 	 * We need to make sure nobody is attaching this page to an eb right
 	 * now.
-- 
2.28.0

