Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A832E1C9C25
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgEGUUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGUUv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E83E6AE0A;
        Thu,  7 May 2020 20:20:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 973ECDA732; Thu,  7 May 2020 22:20:00 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 14/19] btrfs: drop unnecessary offset_in_page in extent buffer helpers
Date:   Thu,  7 May 2020 22:20:00 +0200
Message-Id: <1adbed2929f7a9d390e62cca943c78ebe4b4e9fe.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Helpers that iterate over extent buffer pages set up several variables,
one of them is finding out offset of the extent buffer start within a
page. Right now we have extent buffers aligned to page sizes so this is
effectively storing zero. This makes the code harder the follow and can
be simplified.

The same change is done in all the helpers:

* remove: size_t start_offset = offset_in_page(eb->start);
* simplify code using start_offset

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 51 ++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index da6f0c1ed80c..c59e07360083 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5622,8 +5622,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	struct page *page;
 	char *kaddr;
 	char *dst = (char *)dstv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	unsigned long i = start >> PAGE_SHIFT;
 
 	if (start + len > eb->len) {
 		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
@@ -5632,7 +5631,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 		return;
 	}
 
-	offset = offset_in_page(start_offset + start);
+	offset = offset_in_page(start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5657,14 +5656,13 @@ int read_extent_buffer_to_user(const struct extent_buffer *eb,
 	struct page *page;
 	char *kaddr;
 	char __user *dst = (char __user *)dstv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	unsigned long i = start >> PAGE_SHIFT;
 	int ret = 0;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start_offset + start);
+	offset = offset_in_page(start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5693,14 +5691,13 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	struct page *page;
 	char *kaddr;
 	char *ptr = (char *)ptrv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	unsigned long i = start >> PAGE_SHIFT;
 	int ret = 0;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start_offset + start);
+	offset = offset_in_page(start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5749,13 +5746,12 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	struct page *page;
 	char *kaddr;
 	char *src = (char *)srcv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	unsigned long i = start >> PAGE_SHIFT;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start_offset + start);
+	offset = offset_in_page(start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5779,13 +5775,12 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 	size_t offset;
 	struct page *page;
 	char *kaddr;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	unsigned long i = start >> PAGE_SHIFT;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = offset_in_page(start_offset + start);
+	offset = offset_in_page(start);
 
 	while (len > 0) {
 		page = eb->pages[i];
@@ -5825,12 +5820,11 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	size_t offset;
 	struct page *page;
 	char *kaddr;
-	size_t start_offset = offset_in_page(dst->start);
-	unsigned long i = (start_offset + dst_offset) >> PAGE_SHIFT;
+	unsigned long i = dst_offset >> PAGE_SHIFT;
 
 	WARN_ON(src->len != dst_len);
 
-	offset = offset_in_page(start_offset + dst_offset);
+	offset = offset_in_page(dst_offset);
 
 	while (len > 0) {
 		page = dst->pages[i];
@@ -5866,7 +5860,6 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 				    unsigned long *page_index,
 				    size_t *page_offset)
 {
-	size_t start_offset = offset_in_page(eb->start);
 	size_t byte_offset = BIT_BYTE(nr);
 	size_t offset;
 
@@ -5875,7 +5868,7 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 	 * the bitmap item in the extent buffer + the offset of the byte in the
 	 * bitmap item.
 	 */
-	offset = start_offset + start + byte_offset;
+	offset = start + byte_offset;
 
 	*page_index = offset >> PAGE_SHIFT;
 	*page_offset = offset_in_page(offset);
@@ -6022,7 +6015,6 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 	size_t cur;
 	size_t dst_off_in_page;
 	size_t src_off_in_page;
-	size_t start_offset = offset_in_page(dst->start);
 	unsigned long dst_i;
 	unsigned long src_i;
 
@@ -6040,11 +6032,11 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 	}
 
 	while (len > 0) {
-		dst_off_in_page = offset_in_page(start_offset + dst_offset);
-		src_off_in_page = offset_in_page(start_offset + src_offset);
+		dst_off_in_page = offset_in_page(dst_offset);
+		src_off_in_page = offset_in_page(src_offset);
 
-		dst_i = (start_offset + dst_offset) >> PAGE_SHIFT;
-		src_i = (start_offset + src_offset) >> PAGE_SHIFT;
+		dst_i = dst_offset >> PAGE_SHIFT;
+		src_i = src_offset >> PAGE_SHIFT;
 
 		cur = min(len, (unsigned long)(PAGE_SIZE -
 					       src_off_in_page));
@@ -6070,7 +6062,6 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	size_t src_off_in_page;
 	unsigned long dst_end = dst_offset + len - 1;
 	unsigned long src_end = src_offset + len - 1;
-	size_t start_offset = offset_in_page(dst->start);
 	unsigned long dst_i;
 	unsigned long src_i;
 
@@ -6091,11 +6082,11 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 		return;
 	}
 	while (len > 0) {
-		dst_i = (start_offset + dst_end) >> PAGE_SHIFT;
-		src_i = (start_offset + src_end) >> PAGE_SHIFT;
+		dst_i = dst_end >> PAGE_SHIFT;
+		src_i = src_end >> PAGE_SHIFT;
 
-		dst_off_in_page = offset_in_page(start_offset + dst_end);
-		src_off_in_page = offset_in_page(start_offset + src_end);
+		dst_off_in_page = offset_in_page(dst_end);
+		src_off_in_page = offset_in_page(src_end);
 
 		cur = min_t(unsigned long, len, src_off_in_page + 1);
 		cur = min(cur, dst_off_in_page + 1);
-- 
2.25.0

