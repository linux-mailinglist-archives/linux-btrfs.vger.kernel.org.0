Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5129482D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440747AbgJUG0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440746AbgJUG0f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08vX3OsbP4cRIH4PqVdGijiNbykNGElajfWY6H+enR8=;
        b=YiWIATgXUHTxWBxW/DVPMYxcLhX3mYl6EDkj+VWSxPnElWJipKbPpFO4HR4+GtwIZzBGVl
        nZLMfo5tkWUNEPk32Dezz285lEccnyrhiWHXcffp9iiDhr5WO79o4+soJGVF+xBV4qx+kU
        VliUmuKhi0Qw7JmOiVd9jV5HNy5JP0w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26D12AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 17/68] btrfs: extent_io: extract the btree page submission code into its own helper function
Date:   Wed, 21 Oct 2020 14:25:03 +0800
Message-Id: <20201021062554.68132-18-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btree_write_cache_pages() we have a btree page submission routine
buried deeply into a nested loop.

This patch will extract that part of code into a helper function,
submit_btree_page(), to do the same work.

Also, since submit_btree_page() now can return >0 for successfull extent
buffer submission, remove the "ASSERT(ret <= 0);" line.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 116 +++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8bf38948bd37..0d5d0581af06 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3984,10 +3984,75 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	return ret;
 }
 
+/*
+ * A helper to submit a btree page.
+ *
+ * This function is not always submitting the page, as we only submit the full
+ * extent buffer in a batch.
+ *
+ * @page:	The btree page
+ * @prev_eb:	Previous extent buffer, to determine if we need to submit
+ * 		this page.
+ *
+ * Return >0 if we have submitted the extent buffer successfully.
+ * Return 0 if we don't need to do anything for the page.
+ * Return <0 for fatal error.
+ */
+static int submit_btree_page(struct page *page, struct writeback_control *wbc,
+			     struct extent_page_data *epd,
+			     struct extent_buffer **prev_eb)
+{
+	struct address_space *mapping = page->mapping;
+	struct extent_buffer *eb;
+	int ret;
+
+	if (!PagePrivate(page))
+		return 0;
+
+	spin_lock(&mapping->private_lock);
+	if (!PagePrivate(page)) {
+		spin_unlock(&mapping->private_lock);
+		return 0;
+	}
+
+	eb = (struct extent_buffer *)page->private;
+
+	/*
+	 * Shouldn't happen and normally this would be a BUG_ON but no sense
+	 * in crashing the users box for something we can survive anyway.
+	 */
+	if (WARN_ON(!eb)) {
+		spin_unlock(&mapping->private_lock);
+		return 0;
+	}
+
+	if (eb == *prev_eb) {
+		spin_unlock(&mapping->private_lock);
+		return 0;
+	}
+	ret = atomic_inc_not_zero(&eb->refs);
+	spin_unlock(&mapping->private_lock);
+	if (!ret)
+		return 0;
+
+	*prev_eb = eb;
+
+	ret = lock_extent_buffer_for_io(eb, epd);
+	if (ret <= 0) {
+		free_extent_buffer(eb);
+		return ret;
+	}
+	ret = write_one_eb(eb, wbc, epd);
+	free_extent_buffer(eb);
+	if (ret < 0)
+		return ret;
+	return 1;
+}
+
 int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
-	struct extent_buffer *eb, *prev_eb = NULL;
+	struct extent_buffer *prev_eb = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
 		.extent_locked = 0,
@@ -4033,55 +4098,13 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			if (!PagePrivate(page))
-				continue;
-
-			spin_lock(&mapping->private_lock);
-			if (!PagePrivate(page)) {
-				spin_unlock(&mapping->private_lock);
-				continue;
-			}
-
-			eb = (struct extent_buffer *)page->private;
-
-			/*
-			 * Shouldn't happen and normally this would be a BUG_ON
-			 * but no sense in crashing the users box for something
-			 * we can survive anyway.
-			 */
-			if (WARN_ON(!eb)) {
-				spin_unlock(&mapping->private_lock);
-				continue;
-			}
-
-			if (eb == prev_eb) {
-				spin_unlock(&mapping->private_lock);
-				continue;
-			}
-
-			ret = atomic_inc_not_zero(&eb->refs);
-			spin_unlock(&mapping->private_lock);
-			if (!ret)
-				continue;
-
-			prev_eb = eb;
-			ret = lock_extent_buffer_for_io(eb, &epd);
-			if (!ret) {
-				free_extent_buffer(eb);
+			ret = submit_btree_page(page, wbc, &epd, &prev_eb);
+			if (ret == 0)
 				continue;
-			} else if (ret < 0) {
-				done = 1;
-				free_extent_buffer(eb);
-				break;
-			}
-
-			ret = write_one_eb(eb, wbc, &epd);
-			if (ret) {
+			if (ret < 0) {
 				done = 1;
-				free_extent_buffer(eb);
 				break;
 			}
-			free_extent_buffer(eb);
 
 			/*
 			 * the filesystem may choose to bump up nr_to_write.
@@ -4102,7 +4125,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 		index = 0;
 		goto retry;
 	}
-	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
 		return ret;
-- 
2.28.0

