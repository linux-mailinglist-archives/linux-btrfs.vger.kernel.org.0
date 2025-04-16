Return-Path: <linux-btrfs+bounces-13110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D928A90E03
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 23:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6944944254F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1DF23315B;
	Wed, 16 Apr 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mEJGJudW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3323537B
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840240; cv=none; b=UsTFuI5JCcK1BGW7SxZBXKUKqpE1JLvu6yg9TwMUfgxHlF0VyzXodtCvg6ohvDYjZNqG2t4R9ZLyaEl7nUp6XuthB67czw9mh3DCfnyGgzRiOgR/PIhlOmVU/lqpzvEG7sy1pwHUrlk/TIlrwUtSGFdrovmMWWGIgNcnppQL8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840240; c=relaxed/simple;
	bh=aO/BPEswyHqwac6mLtoPy5Z3X4e/Ec3ORCQWyBaBHwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNK41EcSQvcGbDl0CISwKAvh9rXccfG5FZyRGfNoK3Egtoq1xBaeh7Etabr0iP2T3HCWxL5RmmJLBXIzDc8AtXLWDqNLxX7dREewpAhQFX97UHplF5V+rshFImQkugxs76ZHoJt58gn7NGMzjDG4khoeBeWMcfnpHFCQ6TJmjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mEJGJudW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fedefb1c9cso780387b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744840236; x=1745445036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zflA4EVisdpuiU28rJ7f0dQVMzul4Jr7VRwItdMuUOI=;
        b=mEJGJudW6egJhCw6V0sLCzOOVQDT5uqtukZK0YXlf9tu1IuuzeMJIuSF07PCDYQX8A
         F8D23U8u+grO6jWMUpivyQE0g2n6uH1KRCRqkNiINyqZ5g9R6l5lqGJrv/MDmiTLveoP
         DNOiCnQ2CqNgXbvrYTsJhT+sSwL7l0dAsR9hvJJKFR09xvZ7jyRSHgTDTMEh9PaNscX6
         3tPzL1g5Blv0tl85sJhCmOmLpGJSQzB218Zpv9YBEHu1YEXQEUKSYVDKMAlfD7b12XFB
         kWvqy8HwszgW2bwxTb0B/cUYYpo6xI00Cak92REtFWPj9jnyZ+1ECy8fgNTwuOTgZG6C
         lPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840236; x=1745445036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zflA4EVisdpuiU28rJ7f0dQVMzul4Jr7VRwItdMuUOI=;
        b=TRqPTZlxEUVwWF0d0HBTVS2IKyr4KD83LzOvmChKZYQ1mP7Nuffy5usb9ORFSe8ee2
         1Um7g0L/qT8H/6/ap8vaODw6YhsvsBbP2ekK6/tGsMjGh9Y9UDLlph5xWFlKfv4xOabE
         iio+8XkaQxhpnLcjpW4fFXbqU3lT5c8QEXAYY5zVndLgX16r3uQ8WkYj5cU749hllX5T
         rm06sPl67pcLe02AWKiBxT5z4eVfiUdy3umkFsl76iTBFmtKBmYnucFXOC9ob9CYNjd4
         653AHq3EY01030TdoSh8A0C0scJgRzo0sQPflxGqbU915jjLnu5woQHp1p8uG9lG0lEe
         CZKg==
X-Gm-Message-State: AOJu0Yw06iMC1vZFnDsGqrcdiqiXwidN+0BuFvvB3lfhplReLKWaqGhh
	tzCgWXI1g+qkIltDlhspcdzFiXtIHO4bhtNrkwNExjQUAtRlKOkqzaXc4srM3zSM2m3VUPD5bQw
	SN2o=
X-Gm-Gg: ASbGncvFcix81keXIUl1iL8sLkzGAcQpPFdeN0QurHBfy2B+Fg3P8M/2qZFJKQzRHep
	d/gzFqkp8tTkSIa6pzz0KN4vr7JZH04ZG4WaySDCiMd5vodOB7hB1Sr0lb+I2vPOUOzySSlTFm7
	dZoN9lDwszjMo9wMEZGIqchEojtsd8NE6ue1EFV3UHrmABVtFLpFAiMrrxA9hF3jfKD/wBsw+yL
	Lrx/eQjRprqacPpEvAHCYbX7NkEF43/HUtHwRVoK9Eosg8q/1zYiTxdT0xUnY0bOZ2rnlceVCCV
	sRUDw+1TP1iJCE4+WriDGU+35rdJKgplx8br547jz08ksaPxvZSdYw8tQ8LNn/UK8JNTx1UAFko
	aFA==
X-Google-Smtp-Source: AGHT+IGZLwjBmAaYxmlYaSMc8p5cGphRnAENt0JuAHoDK+Xkkbshy5NHoW81VskkiHN7LOELsHmazg==
X-Received: by 2002:a05:690c:3707:b0:703:afd6:42b8 with SMTP id 00721157ae682-706b32d8396mr53699567b3.19.1744840235620;
        Wed, 16 Apr 2025 14:50:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e3a1b88sm43258077b3.117.2025.04.16.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:50:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/3] btrfs: use buffer radix for extent buffer writeback operations
Date: Wed, 16 Apr 2025 17:50:25 -0400
Message-ID: <306c71cc0374fe1a08e97e25f83a99c360494dd8.1744840038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1744840038.git.josef@toxicpanda.com>
References: <cover.1744840038.git.josef@toxicpanda.com>
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
index dfed1157ebe1..2503fc1f704b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1926,6 +1926,117 @@ static void buffer_xarray_clear_mark(const struct extent_buffer *eb,
 	xas_unlock_irqrestore(&xas, flags);
 }
 
+static void buffer_xarray_tag_for_writeback(struct btrfs_fs_info *fs_info,
+					    unsigned long start, unsigned long end)
+{
+	XA_STATE(xas, &fs_info->buffer_xarray, start);
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
+static unsigned int buffer_xarray_get_ebs_tag(struct btrfs_fs_info *fs_info,
+					      unsigned long *start,
+					      unsigned long end, xa_mark_t tag,
+					      struct eb_batch *batch)
+{
+	XA_STATE(xas, &fs_info->buffer_xarray, *start);
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
+		nr_ebs = buffer_xarray_get_ebs_tag(fs_info, &start_index,
+						   end_index,
+						   PAGECACHE_TAG_WRITEBACK,
+						   &batch);
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
+		buffer_xarray_tag_for_writeback(fs_info, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
-					    tag, &fbatch))) {
-		unsigned i;
+	       (nr_ebs = buffer_xarray_get_ebs_tag(fs_info, &index, end, tag,
+						   &batch))) {
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


