Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746D727DE1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgI3B46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbgI3B45 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8QL7yhujweGOV9TJ9X7yk4d3Yo9faHnV7MYdCpAgWo=;
        b=Lm1/fbct7d0x9vu1Zz5xPhPb8bFpo11Fyq4VOwyzW+6Me+J544/LNGeP2hhixrlvlT8Dnj
        aswQsBDjqkQAdeN8g//lmUjhVxzqmdldpOaMkVpoq9SknTGSS/jMgOUPnbNXRsk2XraX49
        EeAd+bGG4LYlIpR9hZXvsV5in9An0P0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61F27AF95
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 34/49] btrfs: extent_io: make the assert test on page uptodate able to handle subpage
Date:   Wed, 30 Sep 2020 09:55:24 +0800
Message-Id: <20200930015539.48867-35-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite some assert test on page uptodate in extent buffer write
accessors.
They ensure the destination page is already uptodate.

This is fine for regular sector size case, but not for subpage case, as
for subpage we only mark the page uptodate if the page contains no hole
and all its extent buffers are uptodate.

So instead of checking PageUptodate(), for subpage case we check
EXTENT_UPTODATE bit for the range covered by the extent buffer.

To make the check more elegant, introduce a helper,
assert_eb_range_uptodate() to do the check for both subpage and regular
sector size cases.

The following functions are involved:
- write_extent_buffer_chunk_tree_uuid()
- write_extent_buffer_fsid()
- write_extent_buffer()
- memzero_extent_buffer()
- copy_extent_buffer()
- extent_buffer_test_bit()
- extent_buffer_bitmap_set()
- extent_buffer_bitmap_clear()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c9bbb91c6155..210ae3349108 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5867,12 +5867,36 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	return ret;
 }
 
+/*
+ * A helper to ensure that the extent buffer is uptodate.
+ *
+ * For regular sector size == PAGE_SIZE case, check if @page is uptodate.
+ * For subpage case, check if the range covered by the eb has EXTENT_UPTODATE.
+ */
+static void assert_eb_range_uptodate(const struct extent_buffer *eb,
+				     struct page *page)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+
+	if (btrfs_is_subpage(fs_info) && page->mapping) {
+		struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+
+		/* For subpage and mapped eb, check the EXTENT_UPTODATE bit. */
+		WARN_ON(!test_range_bit(io_tree, eb->start,
+				eb->start + eb->len - 1, EXTENT_UPTODATE, 1,
+				NULL));
+	} else {
+		/* For regular eb or dummy eb, check the page status directly */
+		WARN_ON(!PageUptodate(page));
+	}
+}
+
 void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 		const void *srcv)
 {
 	char *kaddr;
 
-	WARN_ON(!PageUptodate(eb->pages[0]));
+	assert_eb_range_uptodate(eb, eb->pages[0]);
 	kaddr = page_address(eb->pages[0]) + get_eb_page_offset(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
 			BTRFS_FSID_SIZE);
@@ -5882,7 +5906,7 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 {
 	char *kaddr;
 
-	WARN_ON(!PageUptodate(eb->pages[0]));
+	assert_eb_range_uptodate(eb, eb->pages[0]);
 	kaddr = page_address(eb->pages[0]) + get_eb_page_offset(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
 			BTRFS_FSID_SIZE);
@@ -5905,7 +5929,7 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_range_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
@@ -5934,7 +5958,7 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_range_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
@@ -5990,7 +6014,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 	while (len > 0) {
 		page = dst->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_range_uptodate(dst, page);
 
 		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
 
@@ -6052,7 +6076,7 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_range_uptodate(eb, page);
 	kaddr = page_address(page);
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
@@ -6077,7 +6101,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 
 	eb_bitmap_offset(eb, start, pos, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_range_uptodate(eb, page);
 	kaddr = page_address(page);
 
 	while (len >= bits_to_set) {
@@ -6088,7 +6112,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 		if (++offset >= PAGE_SIZE && len > 0) {
 			offset = 0;
 			page = eb->pages[++i];
-			WARN_ON(!PageUptodate(page));
+			assert_eb_range_uptodate(eb, page);
 			kaddr = page_address(page);
 		}
 	}
@@ -6120,7 +6144,7 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 
 	eb_bitmap_offset(eb, start, pos, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_range_uptodate(eb, page);
 	kaddr = page_address(page);
 
 	while (len >= bits_to_clear) {
@@ -6131,7 +6155,7 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 		if (++offset >= PAGE_SIZE && len > 0) {
 			offset = 0;
 			page = eb->pages[++i];
-			WARN_ON(!PageUptodate(page));
+			assert_eb_range_uptodate(eb, page);
 			kaddr = page_address(page);
 		}
 	}
-- 
2.28.0

