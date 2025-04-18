Return-Path: <linux-btrfs+bounces-13164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94717A93828
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 15:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB622465911
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A32142E67;
	Fri, 18 Apr 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oms21tpS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E7141987
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984658; cv=none; b=cu6CD0WkKfhW25EK7OIw3CSax8ZxLKe/DrbHALymn+F+YC3fwCM8JZKlfRpQXndLJVncba9xcc8bq0+59lqeR/xedvKTX066V3bYP4BEIqUhcDJwBJVX81Y5wsafJ/9OVBWZnuPuNcq827nfBtuAHQHZg2D8yq4yXG4CV3m4L8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984658; c=relaxed/simple;
	bh=/3pfs0nzK+m+R1DjY+InhlAm7TZB87GSw/NKieNqj5k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD2JrHt+R2dDk9UMF+GaIR1wUy/wG/nkF+POKqCvwdWA1yVgRQyPTVLEhvi863phljUO7jAmTPgrkIWAAQLHF4qKnNUHvyDoCAhaY4z0qN0RaitQWdBv2CFLjyTaoN2/qh7yUn35EkMycU+bofW4mh73wAQW/56V46SyGOoVWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oms21tpS; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7270e0edf5so1792403276.2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744984654; x=1745589454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOIUXC/JSqD5u7FJMUZoWntsB2kqudDzYLrI9sTAs2Y=;
        b=oms21tpSE9BxbUjcANzTe905Kav6Gt13qtGyviU6KvQm0AQZ29pB7ZpAA2CQy4Xfsl
         yoXpEoVwd5bqrjcoe4uxsVqNMCU0Ej40b6jXksDwLWcoYMPYBIFckueUhg41SthjR26k
         oWYEehBs1o9I/tOkuT+10UmXA8gRHPVDIvdjDpBNA9HddQzhUJ1A5VC2LTLobK2873k5
         SgNRmPNr9jJs9T3u3zo4rF5FHQ/n4ok7hw8Tv7Bm2yapOqSknbwJjB5tTxVpjJI1ogWM
         AIUv07onWGdoq47aHwDTKpiGtrltjLT4sTLHuBR5dXnLzciQ07suWbFN+DvGIRdXoNZL
         oj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744984654; x=1745589454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOIUXC/JSqD5u7FJMUZoWntsB2kqudDzYLrI9sTAs2Y=;
        b=GAEdsrQg9POVLi2/JKO1KcDA4/EGg0NdtpMorqpSNpz/vs5zDqNDvHJiHaIcPAj9dx
         isU5Z5zWvLzDwlFDqd4Y61mk8ZOLEmcurWeikjvPjDFORDMUmyEw2i1c0J9LJTEw8lrR
         pIRVzQxsuQLA89t1Wqqk+cggbHrF5Kl5VwPujFzpYVlB6+6EbiPLHUeIPmgv9bLGEnup
         s6YhRV47qbrYXRGvjOxJaC9E0l/BaUlDLMe42WwsmU1oSg2OZXdrNLpdm9yaUndLLFZ6
         pvln/e6C+AIHVEKtCviRNthEOedNI8nnaEVzgLALkf9TtdeQpWe9vhDZnPzvWMY2rMjE
         I5NA==
X-Gm-Message-State: AOJu0Ywah5D4BfWVhz1GUG4PuUCl0d0pZNduISCgjawpSrWPbfWoGY5T
	W16H5UP28xyX6LWn/fdfBMfdrQNrMQjMOG1Z1EH9rhLGoHmcfqIxn1Z1jVRrbvzXd5lUAGnzOHN
	s
X-Gm-Gg: ASbGncs7yx2UMVCKKG5A9weRDaQFW9cu9Xa2Td1jy8q8fjGRp9aZlADwJGec2PFaCI6
	diWaFewNOJ0Z1OnS81k4tScH/6acYrH7ffNyTPWPGLRwpVqCcKH9cT2uNcX2BgSL2YLIL096l+9
	ws75KRYpgM/Me430fFurqlABG7yErOG+xPDMy6hJcOzEHdtHehIcsYSI4vUfOlNIIkWVYv1y3r9
	VjmGImLPuWhX4GfqwO3VAJgSu/qTiRIvQpqmahldHnvParau8XJrXUfbSsK5NF3OImEWhiNq3Tc
	7kcAHsKpnVQxEBiQiaxKdavkwVLIRKOUC/0X4XfJbUCflcARvi4LfhOPUi/1CHwVAA6pw/YDyG8
	gRg==
X-Google-Smtp-Source: AGHT+IFFIyeQy+gI1rS0gZJSbAxELDngD+2m0rNX8Pxgbk+B8b7cZ5jbg2yQguT4wDYXKDC7zVDpuA==
X-Received: by 2002:a05:6902:2b8d:b0:e6d:f320:7825 with SMTP id 3f1490d57ef6-e7297d8f355mr3433585276.3.1744984654473;
        Fri, 18 Apr 2025 06:57:34 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e72959f4877sm447731276.52.2025.04.18.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:57:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 3/3] btrfs: use buffer radix for extent buffer writeback operations
Date: Fri, 18 Apr 2025 09:57:23 -0400
Message-ID: <cd0f8b9b2ab02a3c0a5fc30596cc5f2b9c7ea349.1744984487.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1744984487.git.josef@toxicpanda.com>
References: <cover.1744984487.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have this ugly back and forth with the btree writeback
where we find the folio, find the eb associated with that folio, and
then attempt to writeback.  This results in two different paths for
subpage eb's and >= pagesize eb's.

Clean this up by adding our own infrastructure around looking up tag'ed
eb's and writing the eb's out directly.  This allows us to unify the
subpage and >= pagesize IO paths, resulting in a much cleaner writeback
path for extent buffers.

I ran this through fsperf on a VM with 8 CPUs and 16gib of ram.  I used
smallfiles100k, but reduced the files to 1k to make it run faster, the
results are as follows, with the statistically significant improvements
marked with *, there were no regressions.  fsperf was run with -n 10 for
both runs, so the baseline is the average 10 runs and the test is the
average of 10 runs.

smallfiles100k results
      metric           baseline       current        stdev            diff
================================================================================
avg_commit_ms               68.58         58.44          3.35   -14.79% *
commits                    270.60        254.70         16.24    -5.88%
dev_read_iops                  48            48             0     0.00%
dev_read_kbytes              1044          1044             0     0.00%
dev_write_iops          866117.90     850028.10      14292.20    -1.86%
dev_write_kbytes      10939976.40   10605701.20     351330.32    -3.06%
elapsed                     49.30            33          1.64   -33.06% *
end_state_mount_ns    41251498.80   35773220.70    2531205.32   -13.28% *
end_state_umount_ns      1.90e+09      1.50e+09   14186226.85   -21.38% *
max_commit_ms                 139        111.60          9.72   -19.71% *
sys_cpu                      4.90          3.86          0.88   -21.29%
write_bw_bytes        42935768.20   64318451.10    1609415.05    49.80% *
write_clat_ns_mean      366431.69     243202.60      14161.98   -33.63% *
write_clat_ns_p50        49203.20         20992        264.40   -57.34% *
write_clat_ns_p99          827392     653721.60      65904.74   -20.99% *
write_io_kbytes           2035940       2035940             0     0.00%
write_iops               10482.37      15702.75        392.92    49.80% *
write_lat_ns_max         1.01e+08      90516129    3910102.06   -10.29% *
write_lat_ns_mean       366556.19     243308.48      14154.51   -33.62% *

As you can see we get about a 33% decrease runtime, with a 50%
throughput increase, which is pretty significant.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c   | 344 ++++++++++++++++++++---------------------
 fs/btrfs/extent_io.h   |   1 +
 fs/btrfs/transaction.c |   5 +-
 3 files changed, 173 insertions(+), 177 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ef6df7bcef5d..080409e068e9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1926,6 +1926,117 @@ static void buffer_tree_clear_mark(const struct extent_buffer *eb,
 	xas_unlock_irqrestore(&xas, flags);
 }
 
+static void buffer_tree_tag_for_writeback(struct btrfs_fs_info *fs_info,
+					    unsigned long start, unsigned long end)
+{
+	XA_STATE(xas, &fs_info->buffer_tree, start);
+	unsigned int tagged = 0;
+	void *eb;
+
+	xas_lock_irq(&xas);
+	xas_for_each_marked(&xas, eb, end, PAGECACHE_TAG_DIRTY) {
+		xas_set_mark(&xas, PAGECACHE_TAG_TOWRITE);
+		if (++tagged % XA_CHECK_SCHED)
+			continue;
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
+		cond_resched();
+		xas_lock_irq(&xas);
+	}
+	xas_unlock_irq(&xas);
+}
+
+struct eb_batch {
+	unsigned int nr;
+	unsigned int cur;
+	struct extent_buffer *ebs[PAGEVEC_SIZE];
+};
+
+static inline bool eb_batch_add(struct eb_batch *batch,
+			       struct extent_buffer *eb)
+{
+	batch->ebs[batch->nr++] = eb;
+	return (batch->nr < PAGEVEC_SIZE);
+}
+
+static inline void eb_batch_init(struct eb_batch *batch)
+{
+	batch->nr = 0;
+	batch->cur = 0;
+}
+
+static inline unsigned int eb_batch_count(struct eb_batch *batch)
+{
+	return batch->nr;
+}
+
+static inline struct extent_buffer *eb_batch_next(struct eb_batch *batch)
+{
+	if (batch->cur >= batch->nr)
+		return NULL;
+	return batch->ebs[batch->cur++];
+}
+
+static inline void eb_batch_release(struct eb_batch *batch)
+{
+	for (unsigned int i = 0; i < batch->nr; i++)
+		free_extent_buffer(batch->ebs[i]);
+	eb_batch_init(batch);
+}
+
+static inline struct extent_buffer *find_get_eb(struct xa_state *xas, unsigned long max,
+						xa_mark_t mark)
+{
+	struct extent_buffer *eb;
+
+retry:
+	eb = xas_find_marked(xas, max, mark);
+
+	if (xas_retry(xas, eb))
+		goto retry;
+
+	if (!eb)
+		return NULL;
+
+	if (!atomic_inc_not_zero(&eb->refs))
+		goto reset;
+
+	if (unlikely(eb != xas_reload(xas))) {
+		free_extent_buffer(eb);
+		goto reset;
+	}
+
+	return eb;
+reset:
+	xas_reset(xas);
+	goto retry;
+}
+
+static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_info,
+					    unsigned long *start,
+					    unsigned long end, xa_mark_t tag,
+					    struct eb_batch *batch)
+{
+	XA_STATE(xas, &fs_info->buffer_tree, *start);
+	struct extent_buffer *eb;
+
+	rcu_read_lock();
+	while ((eb = find_get_eb(&xas, end, tag)) != NULL) {
+		if (!eb_batch_add(batch, eb)) {
+			*start = (eb->start + eb->len) >> fs_info->sectorsize_bits;
+			goto out;
+		}
+	}
+	if (end == (unsigned long)-1)
+		*start = (unsigned long)-1;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+
+	return eb_batch_count(batch);
+}
+
 /*
  * The endio specific version which won't touch any unsafe spinlock in endio
  * context.
@@ -2031,163 +2142,37 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 }
 
 /*
- * Submit one subpage btree page.
+ * Wait for all eb writeback in the given range to finish.
  *
- * The main difference to submit_eb_page() is:
- * - Page locking
- *   For subpage, we don't rely on page locking at all.
- *
- * - Flush write bio
- *   We only flush bio if we may be unable to fit current extent buffers into
- *   current bio.
- *
- * Return >=0 for the number of submitted extent buffers.
- * Return <0 for fatal error.
+ * @fs_info:	the fs_info for this file system
+ * @start:	the offset of the range to start waiting on writeback
+ * @end:	the end of the range, inclusive. This is meant to be used in
+ *		conjuction with wait_marked_extents, so this will usually be
+ *		the_next_eb->start - 1.
  */
-static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
+void btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start, u64 end)
 {
-	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
-	int submitted = 0;
-	u64 folio_start = folio_pos(folio);
-	int bit_start = 0;
-	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
-	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
+	struct eb_batch batch;
+	unsigned long start_index = start >> fs_info->sectorsize_bits;
+	unsigned long end_index = end >> fs_info->sectorsize_bits;
 
-	/* Lock and write each dirty extent buffers in the range */
-	while (bit_start < blocks_per_folio) {
-		struct btrfs_subpage *subpage = folio_get_private(folio);
+	eb_batch_init(&batch);
+	while (start_index <= end_index) {
 		struct extent_buffer *eb;
-		unsigned long flags;
-		u64 start;
+		unsigned int nr_ebs;
 
-		/*
-		 * Take private lock to ensure the subpage won't be detached
-		 * in the meantime.
-		 */
-		spin_lock(&folio->mapping->i_private_lock);
-		if (!folio_test_private(folio)) {
-			spin_unlock(&folio->mapping->i_private_lock);
+		nr_ebs = buffer_tree_get_ebs_tag(fs_info, &start_index,
+						 end_index,
+						 PAGECACHE_TAG_WRITEBACK,
+						 &batch);
+		if (!nr_ebs)
 			break;
-		}
-		spin_lock_irqsave(&subpage->lock, flags);
-		if (!test_bit(bit_start + btrfs_bitmap_nr_dirty * blocks_per_folio,
-			      subpage->bitmaps)) {
-			spin_unlock_irqrestore(&subpage->lock, flags);
-			spin_unlock(&folio->mapping->i_private_lock);
-			bit_start += sectors_per_node;
-			continue;
-		}
 
-		start = folio_start + bit_start * fs_info->sectorsize;
-		bit_start += sectors_per_node;
-
-		/*
-		 * Here we just want to grab the eb without touching extra
-		 * spin locks, so call find_extent_buffer_nolock().
-		 */
-		eb = find_extent_buffer_nolock(fs_info, start);
-		spin_unlock_irqrestore(&subpage->lock, flags);
-		spin_unlock(&folio->mapping->i_private_lock);
-
-		/*
-		 * The eb has already reached 0 refs thus find_extent_buffer()
-		 * doesn't return it. We don't need to write back such eb
-		 * anyway.
-		 */
-		if (!eb)
-			continue;
-
-		if (lock_extent_buffer_for_io(eb, wbc)) {
-			write_one_eb(eb, wbc);
-			submitted++;
-		}
-		free_extent_buffer(eb);
+		while ((eb = eb_batch_next(&batch)) != NULL)
+			wait_on_extent_buffer_writeback(eb);
+		eb_batch_release(&batch);
+		cond_resched();
 	}
-	return submitted;
-}
-
-/*
- * Submit all page(s) of one extent buffer.
- *
- * @page:	the page of one extent buffer
- * @eb_context:	to determine if we need to submit this page, if current page
- *		belongs to this eb, we don't need to submit
- *
- * The caller should pass each page in their bytenr order, and here we use
- * @eb_context to determine if we have submitted pages of one extent buffer.
- *
- * If we have, we just skip until we hit a new page that doesn't belong to
- * current @eb_context.
- *
- * If not, we submit all the page(s) of the extent buffer.
- *
- * Return >0 if we have submitted the extent buffer successfully.
- * Return 0 if we don't need to submit the page, as it's already submitted by
- * previous call.
- * Return <0 for fatal error.
- */
-static int submit_eb_page(struct folio *folio, struct btrfs_eb_write_context *ctx)
-{
-	struct writeback_control *wbc = ctx->wbc;
-	struct address_space *mapping = folio->mapping;
-	struct extent_buffer *eb;
-	int ret;
-
-	if (!folio_test_private(folio))
-		return 0;
-
-	if (btrfs_meta_is_subpage(folio_to_fs_info(folio)))
-		return submit_eb_subpage(folio, wbc);
-
-	spin_lock(&mapping->i_private_lock);
-	if (!folio_test_private(folio)) {
-		spin_unlock(&mapping->i_private_lock);
-		return 0;
-	}
-
-	eb = folio_get_private(folio);
-
-	/*
-	 * Shouldn't happen and normally this would be a BUG_ON but no point
-	 * crashing the machine for something we can survive anyway.
-	 */
-	if (WARN_ON(!eb)) {
-		spin_unlock(&mapping->i_private_lock);
-		return 0;
-	}
-
-	if (eb == ctx->eb) {
-		spin_unlock(&mapping->i_private_lock);
-		return 0;
-	}
-	ret = atomic_inc_not_zero(&eb->refs);
-	spin_unlock(&mapping->i_private_lock);
-	if (!ret)
-		return 0;
-
-	ctx->eb = eb;
-
-	ret = btrfs_check_meta_write_pointer(eb->fs_info, ctx);
-	if (ret) {
-		if (ret == -EBUSY)
-			ret = 0;
-		free_extent_buffer(eb);
-		return ret;
-	}
-
-	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		free_extent_buffer(eb);
-		return 0;
-	}
-	/* Implies write in zoned mode. */
-	if (ctx->zoned_bg) {
-		/* Mark the last eb in the block group. */
-		btrfs_schedule_zone_finish_bg(ctx->zoned_bg, eb);
-		ctx->zoned_bg->meta_write_pointer += eb->len;
-	}
-	write_one_eb(eb, wbc);
-	free_extent_buffer(eb);
-	return 1;
 }
 
 int btree_write_cache_pages(struct address_space *mapping,
@@ -2198,25 +2183,27 @@ int btree_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct folio_batch fbatch;
-	unsigned int nr_folios;
-	pgoff_t index;
-	pgoff_t end;		/* Inclusive */
+	struct eb_batch batch;
+	unsigned int nr_ebs;
+	unsigned long index;
+	unsigned long end;
 	int scanned = 0;
 	xa_mark_t tag;
 
-	folio_batch_init(&fbatch);
+	eb_batch_init(&batch);
 	if (wbc->range_cyclic) {
-		index = mapping->writeback_index; /* Start from prev offset */
+		index = (mapping->writeback_index << PAGE_SHIFT) >> fs_info->sectorsize_bits;
 		end = -1;
+
 		/*
 		 * Start from the beginning does not need to cycle over the
 		 * range, mark it as scanned.
 		 */
 		scanned = (index == 0);
 	} else {
-		index = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
+		index = wbc->range_start >> fs_info->sectorsize_bits;
+		end = wbc->range_end >> fs_info->sectorsize_bits;
+
 		scanned = 1;
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL)
@@ -2226,31 +2213,40 @@ int btree_write_cache_pages(struct address_space *mapping,
 	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
-		tag_pages_for_writeback(mapping, index, end);
+		buffer_tree_tag_for_writeback(fs_info, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
-					    tag, &fbatch))) {
-		unsigned i;
+	       (nr_ebs = buffer_tree_get_ebs_tag(fs_info, &index, end, tag,
+						 &batch))) {
+		struct extent_buffer *eb;
 
-		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+		while ((eb = eb_batch_next(&batch)) != NULL) {
+			ctx.eb = eb;
 
-			ret = submit_eb_page(folio, &ctx);
-			if (ret == 0)
+			ret = btrfs_check_meta_write_pointer(eb->fs_info, &ctx);
+			if (ret) {
+				if (ret == -EBUSY)
+					ret = 0;
+				if (ret) {
+					done = 1;
+					break;
+				}
+				free_extent_buffer(eb);
 				continue;
-			if (ret < 0) {
-				done = 1;
-				break;
 			}
 
-			/*
-			 * the filesystem may choose to bump up nr_to_write.
-			 * We have to make sure to honor the new nr_to_write
-			 * at any time
-			 */
-			nr_to_write_done = wbc->nr_to_write <= 0;
+			if (!lock_extent_buffer_for_io(eb, wbc))
+				continue;
+
+			/* Implies write in zoned mode. */
+			if (ctx.zoned_bg) {
+				/* Mark the last eb in the block group. */
+				btrfs_schedule_zone_finish_bg(ctx.zoned_bg, eb);
+				ctx.zoned_bg->meta_write_pointer += eb->len;
+			}
+			write_one_eb(eb, wbc);
 		}
-		folio_batch_release(&fbatch);
+		nr_to_write_done = wbc->nr_to_write <= 0;
+		eb_batch_release(&batch);
 		cond_resched();
 	}
 	if (!scanned && !done) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b344162f790c..4f0cf5b0d38f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -240,6 +240,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
+void btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
 void clear_folio_extent_mapped(struct folio *folio);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 39e48bf610a1..b72ac8b70e0e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1155,7 +1155,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		if (!ret)
 			ret = filemap_fdatawrite_range(mapping, start, end);
 		if (!ret && wait_writeback)
-			ret = filemap_fdatawait_range(mapping, start, end);
+			btree_wait_writeback_range(fs_info, start, end);
 		btrfs_free_extent_state(cached_state);
 		if (ret)
 			break;
@@ -1175,7 +1175,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 				       struct extent_io_tree *dirty_pages)
 {
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct extent_state *cached_state = NULL;
 	u64 start = 0;
 	u64 end;
@@ -1196,7 +1195,7 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 		if (ret == -ENOMEM)
 			ret = 0;
 		if (!ret)
-			ret = filemap_fdatawait_range(mapping, start, end);
+			btree_wait_writeback_range(fs_info, start, end);
 		btrfs_free_extent_state(cached_state);
 		if (ret)
 			break;
-- 
2.48.1


