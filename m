Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4576B24252E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHLGFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:05:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgHLGFQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:05:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55A45AC7C;
        Wed, 12 Aug 2020 06:05:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v4 1/4] btrfs: extent_io: Do extra check for extent buffer read write functions
Date:   Wed, 12 Aug 2020 14:05:06 +0800
Message-Id: <20200812060509.71590-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812060509.71590-1-wqu@suse.com>
References: <20200812060509.71590-1-wqu@suse.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 76 +++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 617ea38e6fd7..9f583ef1e387 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5620,6 +5620,28 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
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
@@ -5630,12 +5652,8 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	char *dst = (char *)dstv;
 	unsigned long i = start >> PAGE_SHIFT;
 
-	if (start + len > eb->len) {
-		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
-		     eb->start, eb->len, start, len);
-		memset(dst, 0, len);
+	if (check_eb_range(eb, start, len))
 		return;
-	}
 
 	offset = offset_in_page(start);
 
@@ -5700,8 +5718,8 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	unsigned long i = start >> PAGE_SHIFT;
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (check_eb_range(eb, start, len))
+		return -EINVAL;
 
 	offset = offset_in_page(start);
 
@@ -5754,8 +5772,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	char *src = (char *)srcv;
 	unsigned long i = start >> PAGE_SHIFT;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (check_eb_range(eb, start, len))
+		return;
 
 	offset = offset_in_page(start);
 
@@ -5783,8 +5801,8 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 	char *kaddr;
 	unsigned long i = start >> PAGE_SHIFT;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (check_eb_range(eb, start, len))
+		return;
 
 	offset = offset_in_page(start);
 
@@ -5828,6 +5846,10 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	char *kaddr;
 	unsigned long i = dst_offset >> PAGE_SHIFT;
 
+	if (check_eb_range(dst, dst_offset, len) ||
+	    check_eb_range(src, src_offset, len))
+		return;
+
 	WARN_ON(src->len != dst_len);
 
 	offset = offset_in_page(dst_offset);
@@ -6017,25 +6039,15 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 			  unsigned long dst_offset, unsigned long src_offset,
 			  unsigned long len)
 {
-	struct btrfs_fs_info *fs_info = dst->fs_info;
 	size_t cur;
 	size_t dst_off_in_page;
 	size_t src_off_in_page;
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
 		dst_off_in_page = offset_in_page(dst_offset);
@@ -6062,7 +6074,6 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 			   unsigned long dst_offset, unsigned long src_offset,
 			   unsigned long len)
 {
-	struct btrfs_fs_info *fs_info = dst->fs_info;
 	size_t cur;
 	size_t dst_off_in_page;
 	size_t src_off_in_page;
@@ -6071,18 +6082,9 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
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
2.28.0

