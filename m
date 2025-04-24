Return-Path: <linux-btrfs+bounces-13397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A92A9B668
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A55E1B65ED4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E882900A8;
	Thu, 24 Apr 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JHbnJVfr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319529009A
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519594; cv=none; b=qRueUPkeCwqv5uB0bpUwZfAvTzOHs/gNM5scUb5jIwp+1iXObXFopCLuNNYRwuHHkSI3U8cfgqk/6oaRj4drLgm1OtnyKQu6CLSnCRw5o+1k94tPmQdrAuM3VDDFgT2HX960IGizuVq0Km4bO/7DWG6bvidXHYX5oKi29sa/fgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519594; c=relaxed/simple;
	bh=BM4/UhlHDrrmzdzJzqWNJFaCU99QdS9lIljuRjog/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIuId42d6/Dg5CUintTWpCjivfG387wAKhPqBfkM3a1ZQcFJrDMtJdzExxpLB69wJRlhuguykuTmnPga9St8HgESzF4gSntGWLdxG6BHoJoeUmcXz74G4KA35rqvXGuF6yWEs4xfo1bT9VrNADMOW5ieIv3zN+BGMk8mmnBHakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JHbnJVfr; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so9581486d6.2
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745519589; x=1746124389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt7ve2KPdP4wTrckeV5sNtSrAbFx6rQxd1wYhIGufKk=;
        b=JHbnJVfr6+GBBeFZoBID06WrqZfuqaygVZFXOAJhtt7myCkhnSqdGkx8OK9Pc1BYAp
         4qfFZcFQGVFI1OQLBWwF0BSFwNWFP/EZXZZEM1fUSYbDpUx2F9hHlQfqFK4KKUw2L1KS
         4IcHgeKo3h+KsqL9DpphfwMDaN34U0hTmTXJq5wohAuazeLF7keMT710/UWrlwl97zJa
         fKIbENd56RPKIlMXLGyz7TUneeCRY4YMDSDMUYJ2yVr5dWXg9+E3DmQMRZmhA0tR9nb6
         7mhKFLtVYtuFSFvHL/1/35GuWxcBoBgbsgagxI4MtDq/qLQgcz6fAadBdDvH8cg2bIsE
         3cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519589; x=1746124389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt7ve2KPdP4wTrckeV5sNtSrAbFx6rQxd1wYhIGufKk=;
        b=GKMsdM2kMj17OsrrzhaRXjzemEwtsQetaICucQepGfkQj6raBkCUKGuHVlUX6/WaIV
         1q4n4Dk1GrUBe3bi98VK41wmrG2LjsCEs4mZIXppEQs3tAkZZNbDUM9Mw8k2a1hVCRZH
         gHbGndifGeFT3NPyf6rSDUKXS/0Vr+Ky3Ghx5Jj0SRZOHOzCLaWGzWt9Yj76JmqBqun5
         RiVZ6x47hTjGlyJQ6qNxGAjqfWGDzSLRffhQBhDARCaGEkcnixMhdwjpDfrDMlPoWP8M
         r83kXxXqYU19rb5Du+Z6W1q821vX8doCE6AQMiZBAINrRBfcK3SvOsq/23fmafqduwfC
         yOPw==
X-Gm-Message-State: AOJu0YwStDrw/Z4WWJADmk4YHfhj4I072WFzlTElV66lsvHhcbabj9kQ
	82bgCE60dItY/T0jIHnN+9xbpVtyYj8OUMI24u4Xo/fsCekADf7oEwFo3/E7RJkzAdvek0ibdD9
	YoioRSA==
X-Gm-Gg: ASbGncvQ7zDdqbm1YcLnwNdOJF2I8IvGhZivsfPAD2qdO6rq5tjZUI38HtT5VGK2mSc
	ZFFCaZ1ZhmJbX1rzSHU5oiTwZWYKDl1XkXh8hbvPko7jUpfX7Y8C3ugxk/YgSuhlc9AQLVX7iSy
	vRovexkM3PbiC182r/GMIBhjfTJImFJuT0wGa3PknVAtUklgesmi3akjuzEu1+WqKKLclk9e0RJ
	DdDUifyedv/EbwTK5NBg/99fx/K3Z2mpgtYQ2kyzxUj9TaeSj9u2TayXXrX0x5IvY4yujyVLx+X
	/JClqZm6BI1eZdVgexCKg/odk4EBeaJIYoWzyLT1so03nE1axwgF5NbD8K2uY6z+m6zjs/dqeMe
	wzKIT7l7pQFLk
X-Google-Smtp-Source: AGHT+IE27V5h8ziFHVbR0ecZhRdvopRlMONqERLwAlGoTv+L+AosM5xWrHgNzCtsOPHIeg2fR+cFAw==
X-Received: by 2002:a05:6214:407:b0:6f2:b0a7:397e with SMTP id 6a1803df08f44-6f4c960885fmr9276946d6.43.1745519589095;
        Thu, 24 Apr 2025 11:33:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0ad4382sm12239846d6.125.2025.04.24.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:33:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 3/3] btrfs: use buffer radix for extent buffer writeback operations
Date: Thu, 24 Apr 2025 14:32:58 -0400
Message-ID: <247b15d0ca0f5b5678c2c379f49b5f0766b00cde.1745519463.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1745519463.git.josef@toxicpanda.com>
References: <cover.1745519463.git.josef@toxicpanda.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c   | 339 ++++++++++++++++++++---------------------
 fs/btrfs/extent_io.h   |   2 +
 fs/btrfs/transaction.c |   5 +-
 3 files changed, 169 insertions(+), 177 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 65a769329981..6082f37cfca3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1923,6 +1923,111 @@ static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_mark_t mar
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
+static inline bool eb_batch_add(struct eb_batch *batch, struct extent_buffer *eb)
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
+	if (end == ULONG_MAX)
+		*start = ULONG_MAX;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+
+	return batch->nr;
+}
+
 /*
  * The endio specific version which won't touch any unsafe spinlock in endio
  * context.
@@ -2032,163 +2137,38 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
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
+ * @fs_info:	The fs_info for this file system.
+ * @start:	The offset of the range to start waiting on writeback.
+ * @end:	The end of the range, inclusive. This is meant to be used in
+ *		conjuction with wait_marked_extents, so this will usually be
+ *		the_next_eb->start - 1.
  */
-static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
+void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start,
+				      u64 end)
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
@@ -2199,25 +2179,27 @@ int btree_write_cache_pages(struct address_space *mapping,
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
@@ -2227,31 +2209,40 @@ int btree_write_cache_pages(struct address_space *mapping,
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
index b344162f790c..b7c1cd0b3c20 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -240,6 +240,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
+void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start,
+				      u64 end);
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
 void clear_folio_extent_mapped(struct folio *folio);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 39e48bf610a1..a538a85ac2bd 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1155,7 +1155,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		if (!ret)
 			ret = filemap_fdatawrite_range(mapping, start, end);
 		if (!ret && wait_writeback)
-			ret = filemap_fdatawait_range(mapping, start, end);
+			btrfs_btree_wait_writeback_range(fs_info, start, end);
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
+			btrfs_btree_wait_writeback_range(fs_info, start, end);
 		btrfs_free_extent_state(cached_state);
 		if (ret)
 			break;
-- 
2.48.1


