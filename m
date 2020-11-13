Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352672B1B5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgKMMwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:46552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKMMwO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zK1DqvZoFjHhGMI2AhY5/glmJMQs2XevmVdYZ6z3VBE=;
        b=Y9H3FsU3B5mrSMQXG24VAcSHAPphPmUdWtQZDGELC1OOo0ocK/9zCxKp7z0e3E0j4BlXa6
        sc/kk3+JfrLTN5YOtpwXhx6dKg6WsvZvLlvD5BVR1DMYzFNxxBHlSZ7HmRMTYW+7IdEnFa
        7b32mfGP6Qq9RO4IGKNgjjwcZOQ1pBk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B4D8AC2E;
        Fri, 13 Nov 2020 12:52:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 05/24] btrfs: extent_io: extract the btree page submission code into its own helper function
Date:   Fri, 13 Nov 2020 20:51:30 +0800
Message-Id: <20201113125149.140836-6-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btree_write_cache_pages() we have a btree page submission routine
buried deeply into a nested loop.

This patch will extract that part of code into a helper function,
submit_eb_page(), to do the same work.

Also, since submit_eb_page() now can return >0 for successful extent
buffer submission, remove the "ASSERT(ret <= 0);" line.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 116 +++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index caafe44542e8..fd4845b06989 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3987,10 +3987,75 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	return ret;
 }
 
+/*
+ * Submit one page of one extent buffer.
+ *
+ * Will try to submit all pages of one extent buffer, thus will skip some pages
+ * if it's already submitted.
+ *
+ * @page:	The page of one extent buffer
+ * @eb_context:	To determine if we need to submit this page. If current page
+ *		belongs to this eb, we don't need to submit.
+ *
+ * Return >0 if we have submitted the extent buffer successfully.
+ * Return 0 if we don't need to do anything for the page.
+ * Return <0 for fatal error.
+ */
+static int submit_eb_page(struct page *page, struct writeback_control *wbc,
+			  struct extent_page_data *epd,
+			  struct extent_buffer **eb_context)
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
+	if (eb == *eb_context) {
+		spin_unlock(&mapping->private_lock);
+		return 0;
+	}
+	ret = atomic_inc_not_zero(&eb->refs);
+	spin_unlock(&mapping->private_lock);
+	if (!ret)
+		return 0;
+
+	*eb_context = eb;
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
+	struct extent_buffer *eb_context = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
 		.extent_locked = 0,
@@ -4036,55 +4101,13 @@ int btree_write_cache_pages(struct address_space *mapping,
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
+			ret = submit_eb_page(page, wbc, &epd, &eb_context);
+			if (ret == 0)
 				continue;
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
-				continue;
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
@@ -4105,7 +4128,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 		index = 0;
 		goto retry;
 	}
-	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
 		return ret;
-- 
2.29.2

