Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD08746EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfGYGMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 02:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:45360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfGYGMq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 02:12:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C94DAB090
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 06:12:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer read write functions
Date:   Thu, 25 Jul 2019 14:12:18 +0800
Message-Id: <20190725061222.9581-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725061222.9581-1-wqu@suse.com>
References: <20190725061222.9581-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we have start, len check for extent buffer reader/write (e.g.
read_extent_buffer()), those checks has its limitations:
- No overflow check
  Values like start = 1024 len = -1024 can still pass the basic
   (start + len) > eb->len check.

- Checks are not consistent
  For read_extent_buffer() we only check (start + len) against eb->len.
  While for memcmp_extent_buffer() we also check start against eb->len.

- Different error reporting mechanism
  We use WARN() in read_extent_buffer() but BUG() in
  memcpy_extent_buffer().

- Still modify memory if the request is obviously wrong
  In read_extent_buffer() even we find (start + len) > eb->len, we still
  call memset(dst, 0, len), which can eaisly cause memory access error
  if start + len overflows.

To address above problems, this patch creates a new common function to
check such access, check_eb_range().
- Add overflow check
  This function checks start, start + len against eb->len and overflow
  check.

- Unified checks

- Unified error reports
  Will call WARN() if CONFIG_BTRFS_DEBUG is configured.
  And also do btrfs_warn() message for non-debug build.

- Exit ASAP if check fails
  No more possible memory corruption.

- Add extra comment for @start @len used in those functions
  Even experienced developers sometimes get confused with the @start
  @len with logical address in those functions.
  I'm not sure what's the cause, maybe it's the extent_buffer::start
  naming.
  For now, just add some comment.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202817
[ Inspired by above report, the report itself is already addressed ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 76 +++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index db337e53aab3..d44a629e0cce 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5429,6 +5429,28 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	return ret;
 }
 
+/*
+ * Check if the [start, start + len) range is valid before reading/writing
+ * the eb.
+ * NOTE: @start and @len are offset *INSIDE* the eb, *NOT* logical address.
+ *
+ * Caller should not touch the dst/src memory if this function returns error.
+ */
+static int check_eb_range(const struct extent_buffer *eb, unsigned long start,
+			  unsigned long len)
+{
+	/* start, start + len should not go beyond eb->len nor overflow */
+	if (unlikely(start > eb->len || start + len > eb->len ||
+		     len > eb->len)) {
+		btrfs_warn(eb->fs_info,
+"btrfs: bad eb rw request, eb bytenr=%llu len=%lu rw start=%lu len=%lu\n",
+			   eb->start, eb->len, start, len);
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		return -EINVAL;
+	}
+	return 0;
+}
+
 void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 			unsigned long start, unsigned long len)
 {
@@ -5440,12 +5462,8 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	size_t start_offset = offset_in_page(eb->start);
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 
-	if (start + len > eb->len) {
-		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
-		     eb->start, eb->len, start, len);
-		memset(dst, 0, len);
+	if (check_eb_range(eb, start, len))
 		return;
-	}
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5554,8 +5572,8 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (check_eb_range(eb, start, len))
+		return -EINVAL;
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5609,8 +5627,8 @@ void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
 	size_t start_offset = offset_in_page(eb->start);
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (check_eb_range(eb, start, len))
+		return;
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5639,8 +5657,8 @@ void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
 	size_t start_offset = offset_in_page(eb->start);
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (check_eb_range(eb, start, len))
+		return;
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5684,6 +5702,10 @@ void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
 	size_t start_offset = offset_in_page(dst->start);
 	unsigned long i = (start_offset + dst_offset) >> PAGE_SHIFT;
 
+	if (check_eb_range(dst, dst_offset, len) ||
+	    check_eb_range(src, src_offset, len))
+		return;
+
 	WARN_ON(src->len != dst_len);
 
 	offset = offset_in_page(start_offset + dst_offset);
@@ -5872,7 +5894,6 @@ static void copy_pages(struct page *dst_page, struct page *src_page,
 void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len)
 {
-	struct btrfs_fs_info *fs_info = dst->fs_info;
 	size_t cur;
 	size_t dst_off_in_page;
 	size_t src_off_in_page;
@@ -5880,18 +5901,9 @@ void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
 	unsigned long dst_i;
 	unsigned long src_i;
 
-	if (src_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			"memmove bogus src_offset %lu move len %lu dst len %lu",
-			 src_offset, len, dst->len);
-		BUG();
-	}
-	if (dst_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			"memmove bogus dst_offset %lu move len %lu dst len %lu",
-			 dst_offset, len, dst->len);
-		BUG();
-	}
+	if (check_eb_range(dst, dst_offset, len) ||
+	    check_eb_range(dst, src_offset, len))
+		return;
 
 	while (len > 0) {
 		dst_off_in_page = offset_in_page(start_offset + dst_offset);
@@ -5917,7 +5929,6 @@ void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
 void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len)
 {
-	struct btrfs_fs_info *fs_info = dst->fs_info;
 	size_t cur;
 	size_t dst_off_in_page;
 	size_t src_off_in_page;
@@ -5927,18 +5938,9 @@ void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
 	unsigned long dst_i;
 	unsigned long src_i;
 
-	if (src_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			  "memmove bogus src_offset %lu move len %lu len %lu",
-			  src_offset, len, dst->len);
-		BUG();
-	}
-	if (dst_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			  "memmove bogus dst_offset %lu move len %lu len %lu",
-			  dst_offset, len, dst->len);
-		BUG();
-	}
+	if (check_eb_range(dst, dst_offset, len) ||
+	    check_eb_range(dst, src_offset, len))
+		return;
 	if (dst_offset < src_offset) {
 		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
 		return;
-- 
2.22.0

