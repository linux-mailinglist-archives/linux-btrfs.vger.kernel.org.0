Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7782A3489F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCYHPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhCYHPU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROxr7mu98XKqJPEPc7xlCbPt/HoA7tJUMDqhVH6429I=;
        b=smdQe91BhU7f3cBT/xmf9VFJmTTZwi37B+wmv3Bh8+i0etC2VZi5RzsQmfEhHUFskSK/MH
        0mmWZU4WWSuDYYGQ7Fjlf0+ewL7yR1c8e5P59GstknpQT9QzqPmKMsYgxCtjONSxY0dS1J
        pn19fWuOzLd4GYn+nruMa7yMl/qiQCc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 856E7AE1B
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:15:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/13] btrfs: make the page uptodate assert to be subpage compatible
Date:   Thu, 25 Mar 2021 15:14:42 +0800
Message-Id: <20210325071445.90896-11-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite some assert check on page uptodate in extent buffer write
accessors.
They ensure the destination page is already uptodate.

This is fine for regular sector size case, but not for subpage case, as
for subpage we only mark the page uptodate if the page contains no hole
and all its extent buffers are uptodate.

So instead of checking PageUptodate(), for subpage case we check the
uptodate bitmap of btrfs_subpage structure.

To make the check more elegant, introduce a helper,
assert_eb_page_uptodate() to do the check for both subpage and regular
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
 fs/btrfs/extent_io.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7c195d8dc07b..24e1cd00e15e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6217,12 +6217,34 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	return ret;
 }
 
+/*
+ * A helper to ensure that the extent buffer is uptodate.
+ *
+ * For regular sector size == PAGE_SIZE case, check if @page is uptodate.
+ * For subpage case, check if the range covered by the eb has EXTENT_UPTODATE.
+ */
+static void assert_eb_page_uptodate(const struct extent_buffer *eb,
+				    struct page *page)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+
+	if (fs_info->sectorsize < PAGE_SIZE) {
+		bool uptodate;
+
+		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
+						eb->start, eb->len);
+		WARN_ON(!uptodate);
+	} else {
+		WARN_ON(!PageUptodate(page));
+	}
+}
+
 void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 		const void *srcv)
 {
 	char *kaddr;
 
-	WARN_ON(!PageUptodate(eb->pages[0]));
+	assert_eb_page_uptodate(eb, eb->pages[0]);
 	kaddr = page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
 			BTRFS_FSID_SIZE);
@@ -6232,7 +6254,7 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 {
 	char *kaddr;
 
-	WARN_ON(!PageUptodate(eb->pages[0]));
+	assert_eb_page_uptodate(eb, eb->pages[0]);
 	kaddr = page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
 			BTRFS_FSID_SIZE);
@@ -6257,7 +6279,7 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_page_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
@@ -6286,7 +6308,7 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_page_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
@@ -6344,7 +6366,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 	while (len > 0) {
 		page = dst->pages[i];
-		WARN_ON(!PageUptodate(page));
+		assert_eb_page_uptodate(dst, page);
 
 		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
 
@@ -6406,7 +6428,7 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_page_uptodate(eb, page);
 	kaddr = page_address(page);
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
@@ -6431,7 +6453,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 
 	eb_bitmap_offset(eb, start, pos, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_page_uptodate(eb, page);
 	kaddr = page_address(page);
 
 	while (len >= bits_to_set) {
@@ -6442,7 +6464,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 		if (++offset >= PAGE_SIZE && len > 0) {
 			offset = 0;
 			page = eb->pages[++i];
-			WARN_ON(!PageUptodate(page));
+			assert_eb_page_uptodate(eb, page);
 			kaddr = page_address(page);
 		}
 	}
@@ -6474,7 +6496,7 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 
 	eb_bitmap_offset(eb, start, pos, &i, &offset);
 	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
+	assert_eb_page_uptodate(eb, page);
 	kaddr = page_address(page);
 
 	while (len >= bits_to_clear) {
@@ -6485,7 +6507,7 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 		if (++offset >= PAGE_SIZE && len > 0) {
 			offset = 0;
 			page = eb->pages[++i];
-			WARN_ON(!PageUptodate(page));
+			assert_eb_page_uptodate(eb, page);
 			kaddr = page_address(page);
 		}
 	}
-- 
2.30.1

