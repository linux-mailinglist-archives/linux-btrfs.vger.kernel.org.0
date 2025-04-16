Return-Path: <linux-btrfs+bounces-13108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F675A90E01
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 23:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1C97AF37F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA723BD00;
	Wed, 16 Apr 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zj99vdRG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2701A2658
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840237; cv=none; b=KLFu27QTTk/0IclSij7oUs1KymWRWFvSkgko9orf76UDp6rDYS33BdNva5DU4fSMqvU4BK75RtlKswDPl4mQbD2LstSX/K0+0B7A2gTPauIF0D6OpfvUkLMrWW6uNPzgS64+SC0WNie5ZACKJxR+C+wRRx5A6VSR3OEmOYWVgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840237; c=relaxed/simple;
	bh=SVUMOiU5VjXwjl1gHyGCw+TUeJ0pfZbKZS06ZeO8jCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzOCDHcQCRglvR0mJzzm9Cw/sR4R4aYqpuVad822AO5TMZoTQvYTSJAHj0DtDCMxGa5k6j2ChSR5pOLAtQVXilU6z2CnZ4RHMrXFQB0kHnMPt4OgWGcyMYBktliYPq8EpOQT2zoLTtnHTR2E/z7bzTsp1CuXsn7cII7O7Oq5ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zj99vdRG; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e589c258663so163284276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744840232; x=1745445032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTN1i34a53LNgOCNXlJaEMOQLfikRX8LcxuYAMgcHn4=;
        b=zj99vdRG2Fjs4ZQbVUZ5ssFJ0LOMB52+5T6M3yEanZHfXsPIUAVGWFU9WogwpoEItB
         /DP+TPfDehOyh8Di1YfHd1sffxndcwSgpNyI3kEJB5+OCj0BiHeSnwS10vNP8gv5hSpB
         46kq+HoWclpt/R8NwGD/Ud7sRQ1NA6m6nnDaOcNn7GXkwOPSnOCtVC4ywB+eCSe2JdRC
         575+Y/W85o0bc2+2qLdOMHWbZxN0ub7BnRK8FStV+oWbJ+IcQP7YU7Ur7T66EcHIYjsg
         WD37VGwBsV2YS1rWTPLgtST4x153+d14sgNEXY21dLYOt9rReeBO6UhcEh8zs3R4V2NO
         pkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840232; x=1745445032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTN1i34a53LNgOCNXlJaEMOQLfikRX8LcxuYAMgcHn4=;
        b=Ju9xWFcPoyBgiIaPgYzjx8nFi+NcamhV0uZgLgPrjFOBBvhbcdEH2lqXVHhnAIyeYb
         sWPoAXXInpbHnqZhYAQ/wkJLvEbWQTsXncRy+AUFaE6xu/G9NCzbnsda8Bi/31yXMw5j
         ooi7J6MxtEKDemaiVHIsjNRRTgfO4qsX04RfIEv4WzUhbCxdjam33kba8cY6IUB1AI4h
         Xuuzi+vu4xeVLr8kZFetlvA4Xs66p+B1dsn+ZQFNdC4p8SgEg0jA3TtJYk1GmjEO3yi2
         HBzxDKT8RivUTX35C4pY4C7UkCmu8U3QgJSHgGNR0aRnEbjrCr+6jigYSxeJu1cOvF9n
         xKpg==
X-Gm-Message-State: AOJu0YxURZ1Rz5QgjGMdn2/2zLRWKQtbCoSxomk+xAQfwksyYpVcfoGk
	+a8UEvs28cKQCtGYt7NGX2ldZY2/jwQGcA7DBzZcbtYVp8eNr75ab8+AsW/QMkGTFYtENLKzZBx
	qjwQ=
X-Gm-Gg: ASbGncuuPu/higVj5cKo+p+gyw5jDRACGK6MwYLQIL6qg7a+Gn+F3i6F8Itz5Mdrhdr
	VptQT3dexEcrxXR1W6EYWnxVGNUaFpAgwyi9O9MRr+jG+mijtnh9YeaBvFUo1l9hK7AlH+PMzwm
	79LeIIUnWanT/mvAfqifk8fmtQGcVsqAnCyRXmTrWkhtCi514ixERffa302cRFxi4BAF20VI7qb
	mnmj5US8kUlkszGq9InyF1wGwSqDjvVhJF7w88+OmqpXx+cYjg3+HtyDJOeleXmZ1qjHSHGybmO
	dHuxvuo76NO5gQRagJ/5rImIVKB9FdZtyB55LgwBBgZFWrjrGqxrahxA3HAESvSyFm1g8CT70+B
	IFA==
X-Google-Smtp-Source: AGHT+IEx8Guln49mgbzJjNDN4oQ3f9NRNPRT9mxEB4/NBGT8/V5F+wp9hyO5w7vJAh8PJD5z2zauRQ==
X-Received: by 2002:a05:6902:2845:b0:e69:1efc:97e5 with SMTP id 3f1490d57ef6-e72757660a4mr4923729276.8.1744840232365;
        Wed, 16 Apr 2025 14:50:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e727dc7d31dsm199659276.48.2025.04.16.14.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:50:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/3] btrfs: convert the buffer_radix to an xarray
Date: Wed, 16 Apr 2025 17:50:23 -0400
Message-ID: <1f3982ec56c49f642ef35698c39e16f56f4bc4f5.1744840038.git.josef@toxicpanda.com>
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

In order to fully utilize xarray tagging to improve writeback we need to
convert the buffer_radix to a proper xarray.  This conversion is
relatively straightforward as the radix code uses the xarray underneath.
Using xarray directly allows for quite a lot less code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c           |  15 ++-
 fs/btrfs/extent_io.c         | 196 +++++++++++++++--------------------
 fs/btrfs/fs.h                |   4 +-
 fs/btrfs/tests/btrfs-tests.c |  27 ++---
 fs/btrfs/zoned.c             |  16 +--
 5 files changed, 113 insertions(+), 145 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59da809b7d57..5593873f5c0f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+/*
+ * lockdep gets confused between our buffer_xarray which requires IRQ locking
+ * because we modify marks in the IRQ context, and our delayed inode xarray
+ * which doesn't have these requirements. Use a class key so lockdep doesn't get
+ * them mixed up.
+ */
+static struct lock_class_key buffer_xa_class;
+
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 {
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
-	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
+
+	/* Use the same flags as mapping->i_pages. */
+	xa_init_flags(&fs_info->buffer_xarray, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
+	lockdep_set_class(&fs_info->buffer_xarray.xa_lock, &buffer_xa_class);
+
 	INIT_LIST_HEAD(&fs_info->trans_list);
 	INIT_LIST_HEAD(&fs_info->dead_roots);
 	INIT_LIST_HEAD(&fs_info->delayed_iputs);
@@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->delayed_iput_lock);
 	spin_lock_init(&fs_info->defrag_inodes_lock);
 	spin_lock_init(&fs_info->super_lock);
-	spin_lock_init(&fs_info->buffer_lock);
 	spin_lock_init(&fs_info->unused_bgs_lock);
 	spin_lock_init(&fs_info->treelog_bg_lock);
 	spin_lock_init(&fs_info->zone_active_bgs_lock);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6cfd286b8bbc..309c86d1a696 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1893,19 +1893,20 @@ static void set_btree_ioerr(struct extent_buffer *eb)
  * context.
  */
 static struct extent_buffer *find_extent_buffer_nolock(
-		const struct btrfs_fs_info *fs_info, u64 start)
+		struct btrfs_fs_info *fs_info, u64 start)
 {
+	XA_STATE(xas, &fs_info->buffer_xarray, start >> fs_info->sectorsize_bits);
 	struct extent_buffer *eb;
 
 	rcu_read_lock();
-	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> fs_info->sectorsize_bits);
-	if (eb && atomic_inc_not_zero(&eb->refs)) {
-		rcu_read_unlock();
-		return eb;
-	}
+	do {
+		eb = xas_load(&xas);
+	} while (xas_retry(&xas, eb));
+
+	if (eb && !atomic_inc_not_zero(&eb->refs))
+		eb = NULL;
 	rcu_read_unlock();
-	return NULL;
+	return eb;
 }
 
 static void end_bbio_meta_write(struct btrfs_bio *bbio)
@@ -2769,11 +2770,10 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 
 	if (!btrfs_meta_is_subpage(fs_info)) {
 		/*
-		 * We do this since we'll remove the pages after we've
-		 * removed the eb from the radix tree, so we could race
-		 * and have this page now attached to the new eb.  So
-		 * only clear folio if it's still connected to
-		 * this eb.
+		 * We do this since we'll remove the pages after we've removed
+		 * the eb from the xarray, so we could race and have this page
+		 * now attached to the new eb.  So only clear folio if it's
+		 * still connected to this eb.
 		 */
 		if (folio_test_private(folio) && folio_get_private(folio) == eb) {
 			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
@@ -2938,9 +2938,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
 {
 	int refs;
 	/*
-	 * The TREE_REF bit is first set when the extent_buffer is added
-	 * to the radix tree. It is also reset, if unset, when a new reference
-	 * is created by find_extent_buffer.
+	 * The TREE_REF bit is first set when the extent_buffer is added to the
+	 * xarray. It is also reset, if unset, when a new reference is created
+	 * by find_extent_buffer.
 	 *
 	 * It is only cleared in two cases: freeing the last non-tree
 	 * reference to the extent_buffer when its STALE bit is set or
@@ -2952,13 +2952,12 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
 	 * conditions between the calls to check_buffer_tree_ref in those
 	 * codepaths and clearing TREE_REF in try_release_extent_buffer.
 	 *
-	 * The actual lifetime of the extent_buffer in the radix tree is
-	 * adequately protected by the refcount, but the TREE_REF bit and
-	 * its corresponding reference are not. To protect against this
-	 * class of races, we call check_buffer_tree_ref from the codepaths
-	 * which trigger io. Note that once io is initiated, TREE_REF can no
-	 * longer be cleared, so that is the moment at which any such race is
-	 * best fixed.
+	 * The actual lifetime of the extent_buffer in the xarray is adequately
+	 * protected by the refcount, but the TREE_REF bit and its corresponding
+	 * reference are not. To protect against this class of races, we call
+	 * check_buffer_tree_ref from the codepaths which trigger io. Note that
+	 * once io is initiated, TREE_REF can no longer be cleared, so that is
+	 * the moment at which any such race is best fixed.
 	 */
 	refs = atomic_read(&eb->refs);
 	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
@@ -3022,23 +3021,26 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 	eb->fs_info = fs_info;
 again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		exists = ERR_PTR(ret);
+	xa_lock_irq(&fs_info->buffer_xarray);
+	exists = __xa_cmpxchg(&fs_info->buffer_xarray,
+			      start >> fs_info->sectorsize_bits, NULL, eb,
+			      GFP_NOFS);
+	if (xa_is_err(exists)) {
+		ret = xa_err(exists);
+		xa_unlock_irq(&fs_info->buffer_xarray);
+		btrfs_release_extent_buffer(eb);
+		return ERR_PTR(ret);
+	}
+	if (exists) {
+		if (!atomic_inc_not_zero(&exists->refs)) {
+			/* The extent buffer is being freed, retry. */
+			xa_unlock_irq(&fs_info->buffer_xarray);
+			goto again;
+		}
+		xa_unlock_irq(&fs_info->buffer_xarray);
 		goto free_eb;
 	}
-	spin_lock(&fs_info->buffer_lock);
-	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> fs_info->sectorsize_bits, eb);
-	spin_unlock(&fs_info->buffer_lock);
-	radix_tree_preload_end();
-	if (ret == -EEXIST) {
-		exists = find_extent_buffer(fs_info, start);
-		if (exists)
-			goto free_eb;
-		else
-			goto again;
-	}
+	xa_unlock_irq(&fs_info->buffer_xarray);
 	check_buffer_tree_ref(eb);
 
 	return eb;
@@ -3059,9 +3061,9 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
 	lockdep_assert_held(&folio->mapping->i_private_lock);
 
 	/*
-	 * For subpage case, we completely rely on radix tree to ensure we
-	 * don't try to insert two ebs for the same bytenr.  So here we always
-	 * return NULL and just continue.
+	 * For subpage case, we completely rely on xarray to ensure we don't try
+	 * to insert two ebs for the same bytenr.  So here we always return NULL
+	 * and just continue.
 	 */
 	if (btrfs_meta_is_subpage(fs_info))
 		return NULL;
@@ -3194,7 +3196,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	/*
 	 * To inform we have an extra eb under allocation, so that
 	 * detach_extent_buffer_page() won't release the folio private when the
-	 * eb hasn't been inserted into radix tree yet.
+	 * eb hasn't been inserted into the xarray yet.
 	 *
 	 * The ref will be decreased when the eb releases the page, in
 	 * detach_extent_buffer_page().  Thus needs no special handling in the
@@ -3328,10 +3330,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 		/*
 		 * We can't unlock the pages just yet since the extent buffer
-		 * hasn't been properly inserted in the radix tree, this
-		 * opens a race with btree_release_folio which can free a page
-		 * while we are still filling in all pages for the buffer and
-		 * we could crash.
+		 * hasn't been properly inserted in the xarray, this opens a
+		 * race with btree_release_folio which can free a page while we
+		 * are still filling in all pages for the buffer and we could
+		 * crash.
 		 */
 	}
 	if (uptodate)
@@ -3340,23 +3342,25 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (page_contig)
 		eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
 again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret)
+	xa_lock_irq(&fs_info->buffer_xarray);
+	existing_eb = __xa_cmpxchg(&fs_info->buffer_xarray,
+				   start >> fs_info->sectorsize_bits, NULL, eb,
+				   GFP_NOFS);
+	if (xa_is_err(existing_eb)) {
+		ret = xa_err(existing_eb);
+		xa_unlock_irq(&fs_info->buffer_xarray);
 		goto out;
-
-	spin_lock(&fs_info->buffer_lock);
-	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> fs_info->sectorsize_bits, eb);
-	spin_unlock(&fs_info->buffer_lock);
-	radix_tree_preload_end();
-	if (ret == -EEXIST) {
-		ret = 0;
-		existing_eb = find_extent_buffer(fs_info, start);
-		if (existing_eb)
-			goto out;
-		else
-			goto again;
 	}
+	if (existing_eb) {
+		if (!atomic_inc_not_zero(&existing_eb->refs)) {
+			xa_unlock_irq(&fs_info->buffer_xarray);
+			goto again;
+		}
+		xa_unlock_irq(&fs_info->buffer_xarray);
+		goto out;
+	}
+	xa_unlock_irq(&fs_info->buffer_xarray);
+
 	/* add one reference for the tree */
 	check_buffer_tree_ref(eb);
 
@@ -3426,10 +3430,13 @@ static int release_extent_buffer(struct extent_buffer *eb)
 
 		spin_unlock(&eb->refs_lock);
 
-		spin_lock(&fs_info->buffer_lock);
-		radix_tree_delete_item(&fs_info->buffer_radix,
-				       eb->start >> fs_info->sectorsize_bits, eb);
-		spin_unlock(&fs_info->buffer_lock);
+		/*
+		 * We're erasing, theoretically there will be no allocations, so
+		 * just use GFP_ATOMIC.
+		 */
+		xa_cmpxchg_irq(&fs_info->buffer_xarray,
+			       eb->start >> fs_info->sectorsize_bits, eb, NULL,
+			       GFP_ATOMIC);
 
 		btrfs_leak_debug_del_eb(eb);
 		/* Should be safe to release folios at this point. */
@@ -4260,44 +4267,6 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	}
 }
 
-#define GANG_LOOKUP_SIZE	16
-static struct extent_buffer *get_next_extent_buffer(
-		const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr)
-{
-	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
-	struct extent_buffer *found = NULL;
-	u64 folio_start = folio_pos(folio);
-	u64 cur = folio_start;
-
-	ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
-	lockdep_assert_held(&fs_info->buffer_lock);
-
-	while (cur < folio_start + PAGE_SIZE) {
-		int ret;
-		int i;
-
-		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
-				(void **)gang, cur >> fs_info->sectorsize_bits,
-				min_t(unsigned int, GANG_LOOKUP_SIZE,
-				      PAGE_SIZE / fs_info->nodesize));
-		if (ret == 0)
-			goto out;
-		for (i = 0; i < ret; i++) {
-			/* Already beyond page end */
-			if (gang[i]->start >= folio_start + PAGE_SIZE)
-				goto out;
-			/* Found one */
-			if (gang[i]->start >= bytenr) {
-				found = gang[i];
-				goto out;
-			}
-		}
-		cur = gang[ret - 1]->start + gang[ret - 1]->len;
-	}
-out:
-	return found;
-}
-
 static int try_release_subpage_extent_buffer(struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
@@ -4306,21 +4275,26 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 	int ret;
 
 	while (cur < end) {
+		XA_STATE(xas, &fs_info->buffer_xarray,
+			 cur >> fs_info->sectorsize_bits);
 		struct extent_buffer *eb = NULL;
 
 		/*
 		 * Unlike try_release_extent_buffer() which uses folio private
-		 * to grab buffer, for subpage case we rely on radix tree, thus
-		 * we need to ensure radix tree consistency.
+		 * to grab buffer, for subpage case we rely on xarray, thus we
+		 * need to ensure xarray tree consistency.
 		 *
-		 * We also want an atomic snapshot of the radix tree, thus go
+		 * We also want an atomic snapshot of the xarray tree, thus go
 		 * with spinlock rather than RCU.
 		 */
-		spin_lock(&fs_info->buffer_lock);
-		eb = get_next_extent_buffer(fs_info, folio, cur);
+		xa_lock_irq(&fs_info->buffer_xarray);
+		do {
+			eb = xas_find(&xas, end >> fs_info->sectorsize_bits);
+		} while (xas_retry(&xas, eb));
+
 		if (!eb) {
 			/* No more eb in the page range after or at cur */
-			spin_unlock(&fs_info->buffer_lock);
+			xa_unlock(&fs_info->buffer_xarray);
 			break;
 		}
 		cur = eb->start + eb->len;
@@ -4332,10 +4306,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		spin_lock(&eb->refs_lock);
 		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
-			spin_unlock(&fs_info->buffer_lock);
+			xa_unlock(&fs_info->buffer_xarray);
 			break;
 		}
-		spin_unlock(&fs_info->buffer_lock);
+		xa_unlock_irq(&fs_info->buffer_xarray);
 
 		/*
 		 * If tree ref isn't set then we know the ref on this eb is a
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bcca43046064..d5d94977860c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -776,10 +776,8 @@ struct btrfs_fs_info {
 
 	struct btrfs_delayed_root *delayed_root;
 
-	/* Extent buffer radix tree */
-	spinlock_t buffer_lock;
 	/* Entries are eb->start / sectorsize */
-	struct radix_tree_root buffer_radix;
+	struct xarray buffer_xarray;
 
 	/* Next backup root to be overwritten */
 	int backup_root_index;
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 02a915eb51fb..741117ce7d3f 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -157,9 +157,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 {
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &fs_info->buffer_xarray, 0);
 	struct btrfs_device *dev, *tmp;
+	struct extent_buffer *eb;
 
 	if (!fs_info)
 		return;
@@ -169,25 +169,16 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 
 	test_mnt->mnt_sb->s_fs_info = NULL;
 
-	spin_lock(&fs_info->buffer_lock);
-	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter, 0) {
-		struct extent_buffer *eb;
-
-		eb = radix_tree_deref_slot_protected(slot, &fs_info->buffer_lock);
-		if (!eb)
+	xa_lock_irq(&fs_info->buffer_xarray);
+	xas_for_each(&xas, eb, ULONG_MAX) {
+		if (xas_retry(&xas, eb))
 			continue;
-		/* Shouldn't happen but that kind of thinking creates CVE's */
-		if (radix_tree_exception(eb)) {
-			if (radix_tree_deref_retry(eb))
-				slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		spin_unlock(&fs_info->buffer_lock);
+		xas_pause(&xas);
+		xa_unlock_irq(&fs_info->buffer_xarray);
 		free_extent_buffer_stale(eb);
-		spin_lock(&fs_info->buffer_lock);
+		xa_lock_irq(&fs_info->buffer_xarray);
 	}
-	spin_unlock(&fs_info->buffer_lock);
+	xa_unlock_irq(&fs_info->buffer_xarray);
 
 	btrfs_mapping_tree_free(fs_info);
 	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7b30700ec930..7ed19ca399f3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2170,28 +2170,22 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	XA_STATE(xas, &fs_info->buffer_xarray,
+		 block_group->start >> fs_info->sectorsize_bits);
 	const u64 end = block_group->start + block_group->length;
-	struct radix_tree_iter iter;
 	struct extent_buffer *eb;
-	void __rcu **slot;
 
 	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
-				 block_group->start >> fs_info->sectorsize_bits) {
-		eb = radix_tree_deref_slot(slot);
-		if (!eb)
+	xas_for_each(&xas, eb, end >> fs_info->sectorsize_bits) {
+		if (xas_retry(&xas, eb))
 			continue;
-		if (radix_tree_deref_retry(eb)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
 
 		if (eb->start < block_group->start)
 			continue;
 		if (eb->start >= end)
 			break;
 
-		slot = radix_tree_iter_resume(slot, &iter);
+		xas_pause(&xas);
 		rcu_read_unlock();
 		wait_on_extent_buffer_writeback(eb);
 		rcu_read_lock();
-- 
2.48.1


