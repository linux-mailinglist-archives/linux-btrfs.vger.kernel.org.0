Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54632D5411
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgLJGk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387526AbgLJGkr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16hOVy9/figJJmrvKBZ6vZO8aylb6nCxXkTXMPHWcOA=;
        b=jxRiOaWMz3Ge9RdtcskizlBrsrQDu2HzTo9OXWClPfTrJK6f3gBcNEacC8ZcON75mlsp2u
        uOncmU7de1Tv1ddkTNoOlvd17M9VfLWzeCTHCPCMMeoNopI08BBKoICr9qabAZEwDBHHFC
        zNsNXiCvtLFGHQ34lz1itS8Y0S+68s4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 143B1AD60
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/18] btrfs: extent_io: implement try_release_extent_buffer() for subpage metadata support
Date:   Thu, 10 Dec 2020 14:38:59 +0800
Message-Id: <20201210063905.75727-13-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
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
 fs/btrfs/extent_io.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 141e414b1ab9..4d55803302e9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6258,10 +6258,83 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
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
+		 * Make sure the page still has private, as previous run can
+		 * detach the private
+		 */
+		spin_lock(&page->mapping->private_lock);
+		if (!PagePrivate(page)) {
+			spin_unlock(&page->mapping->private_lock);
+			break;
+		}
+		subpage = (struct btrfs_subpage *)page->private;
+		spin_unlock(&page->mapping->private_lock);
+
+		spin_lock_irqsave(&subpage->lock, flags);
+		if (!(tmp & subpage->tree_block_bitmap))  {
+			spin_unlock_irqrestore(&subpage->lock, flags);
+			bit_start++;
+			continue;
+		}
+		spin_unlock_irqrestore(&subpage->lock, flags);
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
+		rcu_read_unlock();
+		ASSERT(eb);
+		spin_lock(&eb->refs_lock);
+		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb) ||
+		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
+			spin_unlock(&eb->refs_lock);
+			continue;
+		}
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

