Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075BA269DDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIOFgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgIOFf7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:35:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7307CB03C;
        Tue, 15 Sep 2020 05:36:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v2 08/19] btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
Date:   Tue, 15 Sep 2020 13:35:21 +0800
Message-Id: <20200915053532.63279-9-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
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

- get_eb_page_offset()
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

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h        | 38 ++++++++++++++++++++++--
 fs/btrfs/extent_io.c    | 66 ++++++++++++++++++++++++-----------------
 fs/btrfs/struct-funcs.c | 18 ++++++-----
 3 files changed, 85 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9a72896bed2e..81d5a6cc97b5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1448,14 +1448,15 @@ static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
 #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
 static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
 {									\
-	const type *p = page_address(eb->pages[0]);			\
+	const type *p = page_address(eb->pages[0]) +			\
+			offset_in_page(eb->start);			\
 	u##bits res = le##bits##_to_cpu(p->member);			\
 	return res;							\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
 				    u##bits val)			\
 {									\
-	type *p = page_address(eb->pages[0]);				\
+	type *p = page_address(eb->pages[0]) + offset_in_page(eb->start); \
 	p->member = cpu_to_le##bits(val);				\
 }
 
@@ -3241,6 +3242,39 @@ static inline void assertfail(const char *expr, const char* file, int line) { }
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
+static inline size_t get_eb_page_offset(const struct extent_buffer *eb,
+					unsigned long start)
+{
+	/*
+	 * For sectorsize == PAGE_SIZE case, eb->start will always be aligned
+	 * to PAGE_SIZE, thus adding it won't cause any difference.
+	 *
+	 * For sectorsize < PAGE_SIZE, we must only read the data belongs to
+	 * the eb, thus we have to take the eb->start into consideration.
+	 */
+	return offset_in_page(start + eb->start);
+}
+
+static inline unsigned long get_eb_page_index(unsigned long start)
+{
+	/*
+	 * For sectorsize == PAGE_SIZE case, plain >> PAGE_SHIFT is enough.
+	 *
+	 * For sectorsize < PAGE_SIZE case, we only support 64K PAGE_SIZE,
+	 * and has ensured all tree blocks are contained in one page, thus
+	 * we always get index == 0.
+	 */
+	return start >> PAGE_SHIFT;
+}
+
 /*
  * Use that for functions that are conditionally exported for sanity tests but
  * otherwise static
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9af972999a09..ba9cc864d9c0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5637,7 +5637,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	struct page *page;
 	char *kaddr;
 	char *dst = (char *)dstv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 
 	if (start + len > eb->len) {
 		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
@@ -5646,7 +5646,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 		return;
 	}
 
-	offset = offset_in_page(start);
+	offset = get_eb_page_offset(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5671,13 +5671,13 @@ int read_extent_buffer_to_user(const struct extent_buffer *eb,
 	struct page *page;
 	char *kaddr;
 	char __user *dst = (char __user *)dstv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 	int ret = 0;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start);
+	offset = get_eb_page_offset(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5706,13 +5706,13 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	struct page *page;
 	char *kaddr;
 	char *ptr = (char *)ptrv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 	int ret = 0;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start);
+	offset = get_eb_page_offset(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5738,7 +5738,7 @@ void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 	char *kaddr;
 
 	WARN_ON(!PageUptodate(eb->pages[0]));
-	kaddr = page_address(eb->pages[0]);
+	kaddr = page_address(eb->pages[0]) + get_eb_page_offset(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
 			BTRFS_FSID_SIZE);
 }
@@ -5748,7 +5748,7 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 	char *kaddr;
 
 	WARN_ON(!PageUptodate(eb->pages[0]));
-	kaddr = page_address(eb->pages[0]);
+	kaddr = page_address(eb->pages[0]) + get_eb_page_offset(eb, 0);
 	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
 			BTRFS_FSID_SIZE);
 }
@@ -5761,12 +5761,12 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	struct page *page;
 	char *kaddr;
 	char *src = (char *)srcv;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start);
+	offset = get_eb_page_offset(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5790,12 +5790,12 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 	size_t offset;
 	struct page *page;
 	char *kaddr;
-	unsigned long i = start >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(start);
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start);
+	offset = get_eb_page_offset(eb, start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5819,10 +5819,22 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 
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
+		unsigned long src_index = get_eb_page_index(src->start);
+		unsigned long dst_index = get_eb_page_index(dst->start);
+		size_t src_offset = get_eb_page_offset(src, 0);
+		size_t dst_offset = get_eb_page_offset(dst, 0);
+
+		ASSERT(src_index == 0 && dst_index == 0);
+		memcpy(page_address(dst->pages[dst_index]) + dst_offset,
+		       page_address(src->pages[src_index]) + src_offset,
+		       src->len);
+	}
 }
 
 void copy_extent_buffer(const struct extent_buffer *dst,
@@ -5835,11 +5847,11 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	size_t offset;
 	struct page *page;
 	char *kaddr;
-	unsigned long i = dst_offset >> PAGE_SHIFT;
+	unsigned long i = get_eb_page_index(dst_offset);
 
 	WARN_ON(src->len != dst_len);
 
-	offset = offset_in_page(dst_offset);
+	offset = get_eb_page_offset(dst, dst_offset);
 
 	while (len > 0) {
 		page = dst->pages[i];
@@ -5883,7 +5895,7 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 	 * the bitmap item in the extent buffer + the offset of the byte in the
 	 * bitmap item.
 	 */
-	offset = start + byte_offset;
+	offset = start + offset_in_page(eb->start) + byte_offset;
 
 	*page_index = offset >> PAGE_SHIFT;
 	*page_offset = offset_in_page(offset);
@@ -6047,11 +6059,11 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 	}
 
 	while (len > 0) {
-		dst_off_in_page = offset_in_page(dst_offset);
-		src_off_in_page = offset_in_page(src_offset);
+		dst_off_in_page = get_eb_page_offset(dst, dst_offset);
+		src_off_in_page = get_eb_page_offset(dst, src_offset);
 
-		dst_i = dst_offset >> PAGE_SHIFT;
-		src_i = src_offset >> PAGE_SHIFT;
+		dst_i = get_eb_page_index(dst_offset);
+		src_i = get_eb_page_index(src_offset);
 
 		cur = min(len, (unsigned long)(PAGE_SIZE -
 					       src_off_in_page));
@@ -6097,11 +6109,11 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 		return;
 	}
 	while (len > 0) {
-		dst_i = dst_end >> PAGE_SHIFT;
-		src_i = src_end >> PAGE_SHIFT;
+		dst_i = get_eb_page_index(dst_end);
+		src_i = get_eb_page_index(src_end);
 
-		dst_off_in_page = offset_in_page(dst_end);
-		src_off_in_page = offset_in_page(src_end);
+		dst_off_in_page = get_eb_page_offset(dst, dst_end);
+		src_off_in_page = get_eb_page_offset(dst, src_end);
 
 		cur = min_t(unsigned long, len, src_off_in_page + 1);
 		cur = min(cur, dst_off_in_page + 1);
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 079b059818e9..769901c2b3c9 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -67,8 +67,9 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 			       const void *ptr, unsigned long off)	\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
-	const unsigned long oip = offset_in_page(member_offset);	\
+	const unsigned long idx = get_eb_page_index(member_offset);	\
+	const unsigned long oip = get_eb_page_offset(token->eb, 	\
+						     member_offset);	\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
 	const int part = PAGE_SIZE - oip;				\
@@ -95,8 +96,8 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long oip = offset_in_page(member_offset);	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
+	const unsigned long oip = get_eb_page_offset(eb, member_offset);\
+	const unsigned long idx = get_eb_page_index(member_offset);	\
 	char *kaddr = page_address(eb->pages[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = PAGE_SIZE - oip;				\
@@ -116,8 +117,9 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    u##bits val)				\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
-	const unsigned long oip = offset_in_page(member_offset);	\
+	const unsigned long idx = get_eb_page_index(member_offset);	\
+	const unsigned long oip = get_eb_page_offset(token->eb,		\
+						     member_offset);	\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
 	const int part = PAGE_SIZE - oip;				\
@@ -146,8 +148,8 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val)			\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long oip = offset_in_page(member_offset);	\
-	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
+	const unsigned long oip = get_eb_page_offset(eb, member_offset);\
+	const unsigned long idx = get_eb_page_index(member_offset);	\
 	char *kaddr = page_address(eb->pages[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = PAGE_SIZE - oip;				\
-- 
2.28.0

