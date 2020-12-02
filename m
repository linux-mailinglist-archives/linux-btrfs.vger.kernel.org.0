Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6868A2CB543
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgLBGtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:53282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbgLBGtP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ox2BwghMIpJpnG6f4dUT/FZWX7wEuTF3Fsl/J/sOM4=;
        b=ndxrr28UUBzb0ElArW4V2GTf5SHDNVeBfIwqqj/jiHdFmZmGdoREuZESxJfa7/RQEmcz7X
        UjGGOgLY9xnpJOsnFS6ekqrcwubR3ox9jGGmeI4tnpEY1E00/spKmRyNDFTQiKhPdZGrwd
        Pza7Jvr/CSi+Dd6hH0iExpPYmK1Nl5c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0607BAEBB;
        Wed,  2 Dec 2020 06:48:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH v3 04/15] btrfs: extent_io: extract the btree page submission code into its own helper function
Date:   Wed,  2 Dec 2020 14:48:00 +0800
Message-Id: <20201202064811.100688-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 122 ++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a28b61510265..4b72c824064c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3987,10 +3987,81 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	return ret;
 }
 
+/*
+ * Submit all page(s) of one extent buffer.
+ *
+ * @page:	The page of one extent buffer
+ * @eb_context:	To determine if we need to submit this page. If current page
+ *		belongs to this eb, we don't need to submit.
+ *
+ * The caller should pass each page in their bytenr order, and here we use
+ * @eb_context to determine if we have submitted pages of one extent buffer.
+ *
+ * If have submitted, we just skip until we hit a new page that doesn't belong
+ * to current @eb_context.
+ *
+ * If not yet submitted, we submit all the page(s) of the extent buffer.
+ *
+ * Return >0 if we have submitted the extent buffer successfully.
+ * Return 0 if we don't need to submit the page, as it's already submitted by
+ * previous call.
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
@@ -4036,55 +4107,13 @@ int btree_write_cache_pages(struct address_space *mapping,
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
+			ret = submit_eb_page(page, wbc, &epd, &eb_context);
+			if (ret == 0)
 				continue;
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
@@ -4105,7 +4134,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 		index = 0;
 		goto retry;
 	}
-	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
 		return ret;
-- 
2.29.2

