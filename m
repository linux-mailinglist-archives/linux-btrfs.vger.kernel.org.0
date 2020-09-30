Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14A627DE1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgI3B5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbgI3B5B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmVdilXneXqnUVyvIupvFb83PQ7eOKq1hRiJvxyGibQ=;
        b=A/amcoZ1SYNyD7/aqLPL78qIionE5DAA6Nzako1DFgHF++vrVnsmQAkrS/pyjeau5x2nCP
        2y1FPvuJ9pAzPfRlpo8LCf5ap3Y1fxr/AinaoDx7RoHOBnZfwsSxULGkjMR41XjeFJNk/b
        kjtFjnqqxIkOaAXi3PVpYvh2aBjfLwE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB93CAF95
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 36/49] btrfs: extent_io: implement try_release_extent_buffer() for subpage metadata support
Date:   Wed, 30 Sep 2020 09:55:26 +0800
Message-Id: <20200930015539.48867-37-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For try_release_extent_buffer(), we just iterate through all the range
with EXTENT_NEW set, and try freeing each extent buffer.

Also introduce a helper, find_first_subpage_eb(), to locate find the
first eb in the range.
This helper will also be utilized for later subpage patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  6 ++++
 fs/btrfs/extent_io.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 89021e552da0..efbe12e4f952 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1047,6 +1047,12 @@ static int btree_writepages(struct address_space *mapping,
 
 static int btree_readpage(struct file *file, struct page *page)
 {
+	/*
+	 * For subpage, we don't support VFS to call btree_readpages(),
+	 * directly.
+	 */
+	if (btrfs_is_subpage(page_to_fs_info(page)))
+		return -ENOTTY;
 	return extent_read_full_page(page, btree_get_extent, 0);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1423f69bc210..6aa25681aea4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2743,6 +2743,48 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	return status;
 }
 
+/*
+ * A helper for locate subpage extent buffer.
+ *
+ * NOTE: returned extent buffer won't has its ref increased.
+ *
+ * @extra_bits:		Extra bits to match.
+ * 			The returned eb range will match all extra_bits.
+ *
+ * Return 0 if we found one extent buffer and record it in @eb_ret.
+ * Return 1 if there is no extent buffer in the range.
+ */
+static int find_first_subpage_eb(struct btrfs_fs_info *fs_info,
+				 struct extent_buffer **eb_ret, u64 start,
+				 u64 end, u32 extra_bits)
+{
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	u64 found_start;
+	u64 found_end;
+	int ret;
+
+	ASSERT(btrfs_is_subpage(fs_info) && eb_ret);
+
+	ret = find_first_extent_bit(io_tree, start, &found_start, &found_end,
+			EXTENT_HAS_TREE_BLOCK | extra_bits, true, NULL);
+	if (ret > 0 || found_start > end)
+		return 1;
+
+	/* found_start can be smaller than start */
+	start = max(start, found_start);
+
+	/*
+	 * Here we can't call find_extent_buffer() which will increase
+	 * eb->refs.
+	 */
+	rcu_read_lock();
+	*eb_ret = radix_tree_lookup(&fs_info->buffer_radix,
+				    start / fs_info->sectorsize);
+	rcu_read_unlock();
+	ASSERT(*eb_ret);
+	return 0;
+}
+
 /* lots and lots of room for performance fixes in the end_bio funcs */
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
@@ -6374,10 +6416,51 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
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
+
+		ret = find_first_subpage_eb(fs_info, &eb, cur, end, 0);
+		if (ret > 0)
+			break;
+
+		cur = eb->start + eb->len;
+
+		spin_lock(&eb->refs_lock);
+		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb) ||
+		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
+			spin_unlock(&eb->refs_lock);
+			continue;
+		}
+		/*
+		 * Here we don't care the return value, we will always check
+		 * the EXTENT_HAS_TREE_BLOCK bit at the end.
+		 */
+		release_extent_buffer(eb);
+	}
+
+	/* Finally check if there is any EXTENT_HAS_TREE_BLOCK bit remaining */
+	if (test_range_bit(io_tree, page_offset(page), end,
+			   EXTENT_HAS_TREE_BLOCK, 0, NULL))
+		ret = 0;
+	else
+		ret = 1;
+	return ret;
+}
+
 int try_release_extent_buffer(struct page *page)
 {
 	struct extent_buffer *eb;
 
+	if (btrfs_is_subpage(page_to_fs_info(page)))
+		return try_release_subpage_eb(page);
 	/*
 	 * We need to make sure nobody is attaching this page to an eb right
 	 * now.
-- 
2.28.0

