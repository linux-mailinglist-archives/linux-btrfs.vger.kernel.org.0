Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05508294840
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440804AbgJUG1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440802AbgJUG1S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfzgZfpuqC40mp71PSIP/hR8jxVXp76IWffKRQwphv0=;
        b=uN/ZGpf9mlBOmQLk6zCKUsLJ1F8OvomGa72o0Tz6Sgr2UW3BP98WbUiOpct5MC+NPJvmj4
        IX/ML7HlUs8jgWcDYqtCoG2eFVXPt5TGAuvoCqeQab+gicik+yGOvxwi1f3E4WHQpF4kxf
        vwPsw9+9C4UbQczjXq6Tip6FymOj980=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E86D2AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 36/68] btrfs: extent_io: make the assert test on page uptodate able to handle subpage
Date:   Wed, 21 Oct 2020 14:25:22 +0800
Message-Id: <20201021062554.68132-37-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
index 1e959e6e8ce8..dcc7d4602cea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5896,12 +5896,36 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
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
@@ -5911,7 +5935,7 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 {
 	char *kaddr;
 
-	WARN_ON(!PageUptodate(eb->pages[0]));
+	assert_eb_range_uptodate(eb, eb->pages[0]);
 	kaddr = page_address(eb->pages[0]) + get_eb_page_offset(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
 			BTRFS_FSID_SIZE);
@@ -5934,7 +5958,7 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_range_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
@@ -5963,7 +5987,7 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_range_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
@@ -6019,7 +6043,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 	while (len > 0) {
 		page = dst->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_range_uptodate(dst, page);
 
 		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
 
@@ -6081,7 +6105,7 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_range_uptodate(eb, page);
 	kaddr = page_address(page);
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
@@ -6106,7 +6130,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 
 	eb_bitmap_offset(eb, start, pos, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_range_uptodate(eb, page);
 	kaddr = page_address(page);
 
 	while (len >= bits_to_set) {
@@ -6117,7 +6141,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 		if (++offset >= PAGE_SIZE && len > 0) {
 			offset = 0;
 			page = eb->pages[++i];
-			WARN_ON(!PageUptodate(page));
+			assert_eb_range_uptodate(eb, page);
 			kaddr = page_address(page);
 		}
 	}
@@ -6149,7 +6173,7 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 
 	eb_bitmap_offset(eb, start, pos, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_range_uptodate(eb, page);
 	kaddr = page_address(page);
 
 	while (len >= bits_to_clear) {
@@ -6160,7 +6184,7 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
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

