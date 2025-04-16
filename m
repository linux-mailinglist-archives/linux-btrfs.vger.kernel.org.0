Return-Path: <linux-btrfs+bounces-13096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97AA90961
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E337918887F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D4214A9D;
	Wed, 16 Apr 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fbEX3QXR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AF211497
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822283; cv=none; b=Sam38AzSxYSh/ZpGTJ4pFI4KfHmRCoFfVniRDjVrfBUBSlpuR+yyQUUnShAJ7z0wKxEdK5rI9MIIHQVJ2orgH0zgUd7lSkRGq7g9ORinLp0wV1FMByBU3moOhD/E5mJH+oa7G4cWsAaKaRKaELdsD1e1q8p+V7Py7PdD2rOFth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822283; c=relaxed/simple;
	bh=BtsDrSaho4O7vhoJ36s5IQ1PYzSOqvGAumgDRZrJs/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/BWsmcwHAcJ9z82lKn/ZY0dCCVsB6X+eGQXzNpcWG1awZjOP2kdfkuwsaL8ok7HWmFyXjX7UvSvFSsSyhQGjS2iRLA+Azv63Bknoij1NXMe5hZd1bwo3z7/55Y1+cDavWouN0usqAi8mBscSHS5B9/avpxodBwOe/uZ9fhAbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fbEX3QXR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6582542952so5680243276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744822277; x=1745427077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kz38nrJsD9YSiNj3v233oolLRaZgwZpkx9h/3qniT04=;
        b=fbEX3QXRcX1r5zlIz3m3VJc9RxSqRFn4K8eHuGNVUVaKVEy7EZ1+MW8llNF0ry/gx0
         Wr2U4muX/sdozBJTyCGxMy/8NROOmhW+0H9xroG7PAJOjn5FFTcpQpILSr6hUV00QR1d
         ASJRJWMx3+C5vTDZGuWouBKSKFHBMn3mW9kEZV33gBdOVe+5bdYnJ+vJRo4wIkV0Uk8b
         sElQqdbdytd5uGKGncdkrn5+wrWad1kDzBDcJMaGitCpy42m57AWAj2jvrXWOZVVGeGJ
         ixOG9UxLk7cAfKIXgB0ISNBjP62AISbDbNj+QTxm2DcXU5QejkV94MDbo09jaosmEtC+
         gFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822277; x=1745427077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kz38nrJsD9YSiNj3v233oolLRaZgwZpkx9h/3qniT04=;
        b=QtGB3Lhoy4mNXGRCcGnCkbgUh95hbyvt9lZIf4BaODvBnBoYZWurHLO74haKq9Xbfj
         Fre8Mb+Ckgwudt8oRfoxIjcC9mZninKlAh0tosF4SPNjexl5z7M6KaVx3c3XbxHDsgWU
         MpOGrDe1s33OTU6spYkl8B6qclYXFW41+JCfuzt/iuMIqGGdQuuRl+1Bu9wbWVbYFpmG
         iyRyxfHnsvJerz49kHFqIPYTSXTbhrSLbLP7deqVjJ74tqrx6DHM3D1tyA1IXcnGsI4P
         zpXiCPDVumdrGdPSoiuuwKMX8IWDe8nb6smVT2ug2nCEM/qgrJtkJte5fvBDEH0ydxWK
         Yptw==
X-Gm-Message-State: AOJu0YxOBrS5yVWqx03/xHqZ+ST0P7TOSiqsCV8+f0YxHnlj9z2kuVl4
	sOPRLPfywxkbdqgMRl6NWXzfUfxCp7zO8DqSR4W6bTwXBWpUsoUuEtRx5Y+oRaiwMnfn8JnpOty
	M8U4s0w==
X-Gm-Gg: ASbGncuLEzqKPMay2Vew8WL58A9cXnaHCqQ5raVG5tfhIcdi1kg3EcJVJNTHa1+yZ6x
	BptwFQoh34rrsnoYZoz90MzpCCleX2B9nKjQyN5gAi8LeQZC+viEbLv+XRBnsM3IXj8LRkQINGR
	V+SBv+d1+h04yGA432Gz7fLe0miCPbPS+m2mf4+bFkRlvFclq1JKwE3/b94JvJV/V7JSOYDIyva
	A8is8zFV7I8rf4YwU4kRjPpIhjhGYwg4FMO1WRPjRm7aW8GPb53QLgXhFMzzaH+JiquZ5x+tdgZ
	6B8qS/NqYj55ZOZPR1xcsUM1wnISEHu6bB+Hhwr3JtY7WsCiFkdUGGtt22DWESmfcohveffuU2S
	O/Q==
X-Google-Smtp-Source: AGHT+IE/lW0/H/n/rWhdHnxWajdRHi1EdREN+OCkpzVv5s8QQJ7AL7tobq1j4JlzoRBVdYRRsdmoDA==
X-Received: by 2002:a05:6902:2989:b0:e6b:8256:5d6d with SMTP id 3f1490d57ef6-e7275905867mr2786148276.10.1744822277373;
        Wed, 16 Apr 2025 09:51:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e726f4150e4sm432536276.40.2025.04.16.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:51:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: use buffer radix for extent buffer writeback operations
Date: Wed, 16 Apr 2025 12:51:07 -0400
Message-ID: <ebb84aae51d174b292693b389d28d758271c9ad7.1744822090.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1744822090.git.josef@toxicpanda.com>
References: <cover.1744822090.git.josef@toxicpanda.com>
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
 fs/btrfs/disk-io.c     |  10 ++
 fs/btrfs/extent_io.c   | 344 ++++++++++++++++++++---------------------
 fs/btrfs/extent_io.h   |   1 +
 fs/btrfs/transaction.c |   5 +-
 4 files changed, 183 insertions(+), 177 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59da809b7d57..9e32b574b32b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2762,10 +2762,20 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static struct lock_class_key buffer_radix_lock_key;
+
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 {
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
+
+	/*
+	 * We have to do this because we also use a radix tree for the delayed
+	 * inodes, and lockdep will sometimes confuse that radix tree for this
+	 * one and then complain about IRQ locking differences.
+	 */
+	lockdep_set_class(&fs_info->buffer_radix.xa_lock,
+			  &buffer_radix_lock_key);
 	INIT_LIST_HEAD(&fs_info->trans_list);
 	INIT_LIST_HEAD(&fs_info->dead_roots);
 	INIT_LIST_HEAD(&fs_info->delayed_iputs);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e5de0f57cf7e..780120add4d5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1926,6 +1926,117 @@ static void buffer_radix_clear_mark(const struct extent_buffer *eb,
 	xas_unlock_irqrestore(&xas, flags);
 }
 
+static void buffer_radix_tag_for_writeback(struct btrfs_fs_info *fs_info,
+					   unsigned long start, unsigned long end)
+{
+	XA_STATE(xas, &fs_info->buffer_radix, start);
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
+static unsigned int buffer_radix_get_ebs_tag(struct btrfs_fs_info *fs_info,
+					     unsigned long *start,
+					     unsigned long end, xa_mark_t tag,
+					     struct eb_batch *batch)
+{
+	XA_STATE(xas, &fs_info->buffer_radix, *start);
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
@@ -2030,163 +2141,37 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
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
+		nr_ebs = buffer_radix_get_ebs_tag(fs_info, &start_index,
+						  end_index,
+						  PAGECACHE_TAG_WRITEBACK,
+						  &batch);
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
@@ -2197,25 +2182,27 @@ int btree_write_cache_pages(struct address_space *mapping,
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
@@ -2225,31 +2212,40 @@ int btree_write_cache_pages(struct address_space *mapping,
 	btrfs_zoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
-		tag_pages_for_writeback(mapping, index, end);
+		buffer_radix_tag_for_writeback(fs_info, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
-					    tag, &fbatch))) {
-		unsigned i;
+	       (nr_ebs = buffer_radix_get_ebs_tag(fs_info, &index, end, tag,
+						  &batch))) {
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


