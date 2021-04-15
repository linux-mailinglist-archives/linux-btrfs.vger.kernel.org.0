Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ED9360153
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhDOFFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhDOFFX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvTNKdjF0BXzB1WM5bvecxUfM+FboeODm1fY24LbLHU=;
        b=Y+3A8FSW5AtFixNDOCBP+qelKUzD8BJ5f/ifXNxIvtDQRmITqzpo2WFfZQXpkPFf0VA0li
        Q49QfK3BR8tOXj6qzlq61q6eUoOXV/5sn3JtVi+iU0JzS8LuwW1oatiMLDgDn6rB18uN0g
        fAb+3fGR9kZDbHLF2VEaH8Q5MvmTMsY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F01BAFC9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/42] btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
Date:   Thu, 15 Apr 2021 13:04:10 +0800
Message-Id: <20210415050448.267306-5-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new function, submit_eb_subpage(), will submit all the dirty extent
buffers in the page.

The major difference between submit_eb_page() and submit_eb_subpage()
is:
- How to grab extent buffer
  Now we use find_extent_buffer_nospinlock() other than using
  page::private.

All other different handling is already done in functions like
lock_extent_buffer_for_io() and write_one_eb().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c068c2fcba09..7d1fca9b87f0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4323,6 +4323,98 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	return ret;
 }
 
+/*
+ * Submit one subpage btree page.
+ *
+ * The main difference between submit_eb_page() is:
+ * - Page locking
+ *   For subpage, we don't rely on page locking at all.
+ *
+ * - Flush write bio
+ *   We only flush bio if we may be unable to fit current extent buffers into
+ *   current bio.
+ *
+ * Return >=0 for the number of submitted extent buffers.
+ * Return <0 for fatal error.
+ */
+static int submit_eb_subpage(struct page *page,
+			     struct writeback_control *wbc,
+			     struct extent_page_data *epd)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	int submitted = 0;
+	u64 page_start = page_offset(page);
+	int bit_start = 0;
+	int nbits = BTRFS_SUBPAGE_BITMAP_SIZE;
+	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
+	int ret;
+
+	/* Lock and write each dirty extent buffers in the range */
+	while (bit_start < nbits) {
+		struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+		struct extent_buffer *eb;
+		unsigned long flags;
+		u64 start;
+
+		/*
+		 * Take private lock to ensure the subpage won't be detached
+		 * halfway.
+		 */
+		spin_lock(&page->mapping->private_lock);
+		if (!PagePrivate(page)) {
+			spin_unlock(&page->mapping->private_lock);
+			break;
+		}
+		spin_lock_irqsave(&subpage->lock, flags);
+		if (!((1 << bit_start) & subpage->dirty_bitmap)) {
+			spin_unlock_irqrestore(&subpage->lock, flags);
+			spin_unlock(&page->mapping->private_lock);
+			bit_start++;
+			continue;
+		}
+
+		start = page_start + bit_start * fs_info->sectorsize;
+		bit_start += sectors_per_node;
+
+		/*
+		 * Here we just want to grab the eb without touching extra
+		 * spin locks. So here we call find_extent_buffer_nospinlock().
+		 */
+		eb = find_extent_buffer_nospinlock(fs_info, start);
+		spin_unlock_irqrestore(&subpage->lock, flags);
+		spin_unlock(&page->mapping->private_lock);
+
+		/*
+		 * The eb has already reached 0 refs thus find_extent_buffer()
+		 * doesn't return it. We don't need to write back such eb
+		 * anyway.
+		 */
+		if (!eb)
+			continue;
+
+		ret = lock_extent_buffer_for_io(eb, epd);
+		if (ret == 0) {
+			free_extent_buffer(eb);
+			continue;
+		}
+		if (ret < 0) {
+			free_extent_buffer(eb);
+			goto cleanup;
+		}
+		ret = write_one_eb(eb, wbc, epd);
+		free_extent_buffer(eb);
+		if (ret < 0)
+			goto cleanup;
+		submitted++;
+	}
+	return submitted;
+
+cleanup:
+	/* We hit error, end bio for the submitted extent buffers */
+	end_write_bio(epd, ret);
+	return ret;
+}
+
 /*
  * Submit all page(s) of one extent buffer.
  *
@@ -4355,6 +4447,9 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!PagePrivate(page))
 		return 0;
 
+	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+		return submit_eb_subpage(page, wbc, epd);
+
 	spin_lock(&mapping->private_lock);
 	if (!PagePrivate(page)) {
 		spin_unlock(&mapping->private_lock);
-- 
2.31.1

