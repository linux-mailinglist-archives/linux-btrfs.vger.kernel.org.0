Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77132EB769
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbhAFBEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:04:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:45864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAFBEA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:04:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zex/HDW7nARyUBeGrMHsapz35zKeWeoBlZmwCzlsbEA=;
        b=O5z1yVpHo+Re5krcFvCLw4Fmf4Pfn8Rgqfwqe7SZlH97+tX0nUEgXGfMlzrawbLi4ZhVnh
        oH1zY9/2pgFPx5jNJnWYcYKKQAXyEYZVc5VYyZv//D4lOMJbIDWQOpDRFM4hnky6qwAoHn
        6ybZ4MEyFcoJbyezHUAlR3TqltRkZMU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81DC8AF61
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 16/22] btrfs: extent_io: implement try_release_extent_buffer() for subpage metadata support
Date:   Wed,  6 Jan 2021 09:01:55 +0800
Message-Id: <20210106010201.37864-17-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike the original try_release_extent_buffer,
try_release_subpage_extent_buffer() will iterate through
btrfs_subpage::tree_block_bitmap, and try to release each extent buffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 194cb8b63216..792264f5c3c2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6258,10 +6258,86 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	}
 }
 
+static int try_release_subpage_extent_buffer(struct page *page)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	u64 page_start = page_offset(page);
+	int bitmap_size = BTRFS_SUBPAGE_BITMAP_SIZE;
+	int bit_start = 0;
+	int ret;
+
+	while (bit_start < bitmap_size) {
+		struct btrfs_subpage *subpage;
+		struct extent_buffer *eb;
+		unsigned long flags;
+		u16 tmp = 1 << bit_start;
+		u64 start;
+
+		/*
+		 * Make sure the page still has private, as previous iteration
+		 * can detach page private.
+		 */
+		spin_lock(&page->mapping->private_lock);
+		if (!PagePrivate(page)) {
+			spin_unlock(&page->mapping->private_lock);
+			break;
+		}
+
+		subpage = (struct btrfs_subpage *)page->private;
+
+		spin_lock_irqsave(&subpage->lock, flags);
+		spin_unlock(&page->mapping->private_lock);
+
+		if (!(tmp & subpage->tree_block_bitmap))  {
+			spin_unlock_irqrestore(&subpage->lock, flags);
+			bit_start++;
+			continue;
+		}
+
+		start = bit_start * fs_info->sectorsize + page_start;
+		bit_start += fs_info->nodesize >> fs_info->sectorsize_bits;
+		/*
+		 * Here we can't call find_extent_buffer() which will increase
+		 * eb->refs.
+		 */
+		rcu_read_lock();
+		eb = radix_tree_lookup(&fs_info->buffer_radix,
+				start >> fs_info->sectorsize_bits);
+		ASSERT(eb);
+		spin_lock(&eb->refs_lock);
+		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb) ||
+		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
+			spin_unlock(&eb->refs_lock);
+			rcu_read_unlock();
+			continue;
+		}
+		rcu_read_unlock();
+		spin_unlock_irqrestore(&subpage->lock, flags);
+		/*
+		 * Here we don't care the return value, we will always check
+		 * the page private at the end.
+		 * And release_extent_buffer() will release the refs_lock.
+		 */
+		release_extent_buffer(eb);
+	}
+	/* Finally to check if we have cleared page private */
+	spin_lock(&page->mapping->private_lock);
+	if (!PagePrivate(page))
+		ret = 1;
+	else
+		ret = 0;
+	spin_unlock(&page->mapping->private_lock);
+	return ret;
+
+}
+
 int try_release_extent_buffer(struct page *page)
 {
 	struct extent_buffer *eb;
 
+	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+		return try_release_subpage_extent_buffer(page);
+
 	/*
 	 * We need to make sure nobody is attaching this page to an eb right
 	 * now.
-- 
2.29.2

