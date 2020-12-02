Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452982CB547
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgLBGtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:53484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgLBGtz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/+HBOxlv7qk/fJJlPVeM7oxzIPT1suWEJP5DtJBf5Q=;
        b=eKtuD2Gy6wnlWx/drZnWQaeBhKdpXpFOjQh2yUV0PsP26Rh+rvcdhQiQHDh+dolgQ/E+Lt
        LSFeJpc7gRMHU/nsbVYWQAJeiH8Wdxw7P3TAoNgMDwGxFAAuGYXH3z3iTe+pfNxEk9sFMO
        TOZPCNXVP3aDaEFnxiX4F+M99xQadrI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48359AEDE;
        Wed,  2 Dec 2020 06:48:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v3 08/15] btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
Date:   Wed,  2 Dec 2020 14:48:04 +0800
Message-Id: <20201202064811.100688-9-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support sectorsize < PAGE_SIZE case, we need to take extra care for
extent buffer accessors.

Since sectorsize is smaller than PAGE_SIZE, one page can contain
multiple tree blocks, we must use eb->start to determine the real offset
to read/write for extent buffer accessors.

This patch introduces two helpers to do these:
- get_eb_page_index()
  This is to calculate the index to access extent_buffer::pages.
  It's just a simple wrapper around "start >> PAGE_SHIFT".

  For sectorsize == PAGE_SIZE case, nothing is changed.
  For sectorsize < PAGE_SIZE case, we always get index as 0, and
  the existing page shift works also fine.

- get_eb_offset_in_page()
  This is to calculate the offset to access extent_buffer::pages.
  This needs to take extent_buffer::start into consideration.

  For sectorsize == PAGE_SIZE case, extent_buffer::start is always
  aligned to PAGE_SIZE, thus adding extent_buffer::start to
  offset_in_page() won't change the result.
  For sectorsize < PAGE_SIZE case, adding extent_buffer::start gives
  us the correct offset to access.

This patch will touch the following parts to cover all extent buffer
accessors:

- BTRFS_SETGET_HEADER_FUNCS()
- read_extent_buffer()
- read_extent_buffer_to_user()
- memcmp_extent_buffer()
- write_extent_buffer_chunk_tree_uuid()
- write_extent_buffer_fsid()
- write_extent_buffer()
- memzero_extent_buffer()
- copy_extent_buffer_full()
- copy_extent_buffer()
- memcpy_extent_buffer()
- memmove_extent_buffer()
- btrfs_get_token_##bits()
- btrfs_get_##bits()
- btrfs_set_token_##bits()
- btrfs_set_##bits()
- generic_bin_search()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c        |  3 +-
 fs/btrfs/ctree.h        | 38 ++++++++++++++++++++++--
 fs/btrfs/extent_io.c    | 64 ++++++++++++++++++++++++-----------------
 fs/btrfs/struct-funcs.c | 18 ++++++------
 4 files changed, 85 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e5a0941c4bde..07810891e204 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1683,9 +1683,10 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
 		oip = offset_in_page(offset);
 
 		if (oip + key_size <= PAGE_SIZE) {
-			const unsigned long idx = offset >> PAGE_SHIFT;
+			const unsigned long idx = get_eb_page_index(offset);
 			char *kaddr = page_address(eb->pages[idx]);
 
+			oip = get_eb_offset_in_page(eb, offset);
 			tmp = (struct btrfs_disk_key *)(kaddr + oip);
 		} else {
 			read_extent_buffer(eb, &unaligned, offset, key_size);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c5ef29078954..c9eb6d881064 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1552,13 +1552,14 @@ static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
 #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
 static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
 {									\
-	const type *p = page_address(eb->pages[0]);			\
+	const type *p = page_address(eb->pages[0]) +			\
+			offset_in_page(eb->start);			\
 	return get_unaligned_le##bits(&p->member);			\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
 				    u##bits val)			\
 {									\
-	type *p = page_address(eb->pages[0]);				\
+	type *p = page_address(eb->pages[0]) + offset_in_page(eb->start); \
 	put_unaligned_le##bits(val, &p->member);			\
 }
 
@@ -3366,6 +3367,39 @@ static inline void assertfail(const char *expr, const char* file, int line) { }
 #define ASSERT(expr)	(void)(expr)
 #endif
 
+/*
+ * Get the correct offset inside the page of extent buffer.
+ *
+ * Will handle both sectorsize == PAGE_SIZE and sectorsize < PAGE_SIZE cases.
+ *
+ * @eb:		The target extent buffer
+ * @start:	The offset inside the extent buffer
+ */
+static inline size_t get_eb_offset_in_page(const struct extent_buffer *eb,
+					   unsigned long offset)
+{
+	/*
+	 * For sectorsize == PAGE_SIZE case, eb->start will always be aligned
+	 * to PAGE_SIZE, thus adding it won't cause any difference.
+	 *
+	 * For sectorsize < PAGE_SIZE, we must only read the data belongs to
+	 * the eb, thus we have to take the eb->start into consideration.
+	 */
+	return offset_in_page(offset + eb->start);
+}
+
+static inline unsigned long get_eb_page_index(unsigned long offset)
+{
+	/*
+	 * For sectorsize == PAGE_SIZE case, plain >> PAGE_SHIFT is enough.
+	 *
+	 * For sectorsize < PAGE_SIZE case, we only support 64K PAGE_SIZE,
+	 * and has ensured all tree blocks are contained in one page, thus
+	 * we always get index == 0.
+	 */
+	return offset >> PAGE_SHIFT;
+}
+
 /*
  * Use that for functions that are conditionally exported for sanity tests but
  * otherwise static
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8cbd6d43b154..8719c51bb4c5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5702,12 +5702,12 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	struct page *page;
 	char *kaddr;
 	char *dst = (char *)dstv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 
 	if (check_eb_range(eb, start, len))
 		return;
 
-	offset = offset_in_page(start);
+	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5732,13 +5732,13 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	struct page *page;
 	char *kaddr;
 	char __user *dst = (char __user *)dstv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 	int ret = 0;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start);
+	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5767,13 +5767,13 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	struct page *page;
 	char *kaddr;
 	char *ptr = (char *)ptrv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 	int ret = 0;
 
 	if (check_eb_range(eb, start, len))
 		return -EINVAL;
 
-	offset = offset_in_page(start);
+	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5799,7 +5799,7 @@ void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 	char *kaddr;
 
 	WARN_ON(!PageUptodate(eb->pages[0]));
-	kaddr = page_address(eb->pages[0]);
+	kaddr = page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
 			BTRFS_FSID_SIZE);
 }
@@ -5809,7 +5809,7 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 	char *kaddr;
 
 	WARN_ON(!PageUptodate(eb->pages[0]));
-	kaddr = page_address(eb->pages[0]);
+	kaddr = page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
 			BTRFS_FSID_SIZE);
 }
@@ -5822,12 +5822,12 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	struct page *page;
 	char *kaddr;
 	char *src = (char *)srcv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 
 	if (check_eb_range(eb, start, len))
 		return;
 
-	offset = offset_in_page(start);
+	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5851,12 +5851,12 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 	size_t offset;
 	struct page *page;
 	char *kaddr;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 
 	if (check_eb_range(eb, start, len))
 		return;
 
-	offset = offset_in_page(start);
+	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5880,10 +5880,20 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 
 	ASSERT(dst->len == src->len);
 
-	num_pages = num_extent_pages(dst);
-	for (i = 0; i < num_pages; i++)
-		copy_page(page_address(dst->pages[i]),
-				page_address(src->pages[i]));
+	if (dst->fs_info->sectorsize == PAGE_SIZE) {
+		num_pages = num_extent_pages(dst);
+		for (i = 0; i < num_pages; i++)
+			copy_page(page_address(dst->pages[i]),
+				  page_address(src->pages[i]));
+	} else {
+		size_t src_offset = get_eb_offset_in_page(src, 0);
+		size_t dst_offset = get_eb_offset_in_page(dst, 0);
+
+		ASSERT(src->fs_info->sectorsize < PAGE_SIZE);
+		memcpy(page_address(dst->pages[0]) + dst_offset,
+		       page_address(src->pages[0]) + src_offset,
+		       src->len);
+	}
 }
 
 void copy_extent_buffer(const struct extent_buffer *dst,
@@ -5896,7 +5906,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	size_t offset;
 	struct page *page;
 	char *kaddr;
-	unsigned long i = dst_offset >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(dst_offset);
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(src, src_offset, len))
@@ -5904,7 +5914,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 	WARN_ON(src->len != dst_len);
 
-	offset = offset_in_page(dst_offset);
+	offset = get_eb_offset_in_page(dst, dst_offset);
 
 	while (len > 0) {
 		page = dst->pages[i];
@@ -5948,7 +5958,7 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 	 * the bitmap item in the extent buffer + the offset of the byte in the
 	 * bitmap item.
 	 */
-	offset = start + byte_offset;
+	offset = start + offset_in_page(eb->start) + byte_offset;
 
 	*page_index = offset >> PAGE_SHIFT;
 	*page_offset = offset_in_page(offset);
@@ -6102,11 +6112,11 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 		return;
 
 	while (len > 0) {
-		dst_off_in_page = offset_in_page(dst_offset);
-		src_off_in_page = offset_in_page(src_offset);
+		dst_off_in_page = get_eb_offset_in_page(dst, dst_offset);
+		src_off_in_page = get_eb_offset_in_page(dst, src_offset);
 
-		dst_i = dst_offset >> PAGE_SHIFT;
-		src_i = src_offset >> PAGE_SHIFT;
+		dst_i = get_eb_page_index(dst_offset);
+		src_i = get_eb_page_index(src_offset);
 
 		cur = min(len, (unsigned long)(PAGE_SIZE -
 					       src_off_in_page));
@@ -6142,11 +6152,11 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 		return;
 	}
 	while (len > 0) {
-		dst_i = dst_end >> PAGE_SHIFT;
-		src_i = src_end >> PAGE_SHIFT;
+		dst_i = get_eb_page_index(dst_end);
+		src_i = get_eb_page_index(src_end);
 
-		dst_off_in_page = offset_in_page(dst_end);
-		src_off_in_page = offset_in_page(src_end);
+		dst_off_in_page = get_eb_offset_in_page(dst, dst_end);
+		src_off_in_page = get_eb_offset_in_page(dst, src_end);
 
 		cur = min_t(unsigned long, len, src_off_in_page + 1);
 		cur = min(cur, dst_off_in_page + 1);
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index c46be27be700..fc282eec7291 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -57,8 +57,9 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 			       const void *ptr, unsigned long off)	\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
-	const unsigned long oip = offset_in_page(member_offset);	\
+	const unsigned long idx = get_eb_page_index(member_offset);	\
+	const unsigned long oip = get_eb_offset_in_page(token->eb,	\
+						     member_offset);	\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
 	const int part = PAGE_SIZE - oip;				\
@@ -85,8 +86,8 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long oip = offset_in_page(member_offset);	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
+	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
+	const unsigned long idx = get_eb_page_index(member_offset);	\
 	char *kaddr = page_address(eb->pages[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = PAGE_SIZE - oip;				\
@@ -106,8 +107,9 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    u##bits val)				\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
-	const unsigned long oip = offset_in_page(member_offset);	\
+	const unsigned long idx = get_eb_page_index(member_offset);	\
+	const unsigned long oip = get_eb_offset_in_page(token->eb,	\
+						     member_offset);	\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
 	const int part = PAGE_SIZE - oip;				\
@@ -136,8 +138,8 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val)			\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long oip = offset_in_page(member_offset);	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
+	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
+	const unsigned long idx = get_eb_page_index(member_offset);	\
 	char *kaddr = page_address(eb->pages[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = PAGE_SIZE - oip;				\
-- 
2.29.2

