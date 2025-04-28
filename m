Return-Path: <linux-btrfs+bounces-13463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F4A9F3D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF941A8190D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58126FDBD;
	Mon, 28 Apr 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wUyOEo62"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BC26A1AA
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851986; cv=none; b=Fkyb2ipwxrpG8Af4FNmj0XNUKAYYJVtS8caHatlnAWwi5vLs2OJnl/WDaR+7O8NjOKiz/qDSeBp2UxrQlL9tX3G3F0dO3mXfJv5nDN33ix88voUTfElQS3kz7OWTY3aalVnwg1uRXD9V4omKkKlU0KSNmR0i0m0cvqTuYrC6kZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851986; c=relaxed/simple;
	bh=9dD+Zdj78945uWyB//NkCdieCifsIP1kkIRmZME4C8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g72NjSXY17+uJLG5cmpfPQq0lFJmRGx9kBwXHaNUDDMIYEFbbTQxIp9aJxEmhheSVNUVBJsDns0v2wmKvjV/Pfu12UiT9KvB6cGPtZP0ZIS39n98CQkoi9vXxbIdNyoQa3GguFwqRqgdLY8C3U7r4MhpTrWnyT9LiBQAGoF0y0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wUyOEo62; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e6582542952so4149930276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745851983; x=1746456783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAoC95Uv1z9RGgnoR42LoDFt53R0ECNLkp+zijkl3Ao=;
        b=wUyOEo62/hDZYQY1qCLbLGgJbS4jTNqmBJDBxc+iNtCjQ4CVsEs3t2L/AU5ei2Rmov
         +6gUnokmRbpToOJZutn8kAeHZeGgQqnAWW3XSWfrE8wK1cxhHq/2tAmBPQ1dtnoq+if/
         XB+hMGljFI4KGZK7OLxJRRFFE3NZq/2UbN9N6tQL68I5ozO48rwfVztMIJAlGjeSTdSs
         +HoAYG23RnOB1vQwLBxEDcKbQffvL/gYCwDHxZTZ1QDnaokIG3/JFOi7ZUX59oE3mehA
         Y7AkDHRzMmkMbF7+OcuDN1/WdzNBx8HOOKG/K2Rp/6Z4eEv3djXT7VvSoAhjIexCF2cV
         jKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851983; x=1746456783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAoC95Uv1z9RGgnoR42LoDFt53R0ECNLkp+zijkl3Ao=;
        b=sul1UHqDjZP+306w428ukNXWOioz8Opn5UqZE7SKmUXT5JnD64caxufJmg+GINPtGt
         2nvQjree9SR16LNAulrsZKQgOJ4h5qig7cxZnv34WwY5sQ/jYJ0FFJBP6i7j+CBcl5XV
         jR5hfNNX3UW7+r2GlVYxjglMVhBhzG+qZpZbO24tStXCCnQgCZ5/VEOznNMzodTptHVS
         KwbK6IAfW07UmOzdjuMR6KbxyIe9RyblcRyxzcxf//jVHXJYF6kLPZg8PGO+RjkKxdTk
         iCQro5ZgE+1RGaw9s0n/VkfCrDU2QxQcZFrHbaA4JO5Vqw0IJ6dZQKXAqDrwW/MdJ9tW
         B0AQ==
X-Gm-Message-State: AOJu0YwNqZg6BmnDuSgksFTzdzWWnFP1cBY83HR8m+Aw9kmeXhVqMqMF
	W6qngSedkGSd5fUIfnsRYNRwr6lS3hoRJuRW5zdAZZU8aKIXOtkgRoPpzKycZdZtn/kDi1QNBzx
	bmAQ=
X-Gm-Gg: ASbGnctN41lN6vtNUhcgvEgQroNTK26PLTDE9vvQxJyV9fEgJFfZz98TpAicIpJquhU
	sJbX8V+FUBl3CxYolIozmp7ZhVKYn/MCxpBwKFdR5+jIOyxCwoHeg5eFm4dD57b/Stw/Wg/CU+d
	ftbx0vEssyyQtp/3O75HlqzM/Ar7DT3X2w/KmqEwFA+usnDn1jtv8ufx8X27v8CRRRL8aVmhscv
	q4dYN40x68s+bqiNRSPeWv+iAHXMx2OEyJXfLxOwUklY1sQRt0xRuEFMYoforN/UB4wky3j/bYT
	P2zkaN/xbeh55EJxMIbKY8bbiOCbBGvEsZnkNS5kWipIJYHspNX+1rHLPCR3jkGFH2bCqDFOaf1
	4cg==
X-Google-Smtp-Source: AGHT+IH+Ucm7HQTlOmRKxI2N6IXJ1B7gmtY/HTqL8LW7ym6upO8+Akw3wfn82L1oHV7lu0X9KjdSUg==
X-Received: by 2002:a05:6902:2402:b0:e72:97bc:a1a1 with SMTP id 3f1490d57ef6-e73165a2212mr15652529276.7.1745851982940;
        Mon, 28 Apr 2025 07:53:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7303a7741esm2341675276.23.2025.04.28.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:53:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v5 1/3] btrfs: convert the buffer_radix to an xarray
Date: Mon, 28 Apr 2025 10:52:55 -0400
Message-ID: <b03b3a49255646818261cf5ce02cfdea656acffd.1745851722.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1745851722.git.josef@toxicpanda.com>
References: <cover.1745851722.git.josef@toxicpanda.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c           |  15 ++-
 fs/btrfs/extent_io.c         | 199 ++++++++++++++++-------------------
 fs/btrfs/fs.h                |   4 +-
 fs/btrfs/tests/btrfs-tests.c |  28 ++---
 fs/btrfs/zoned.c             |  16 +--
 5 files changed, 112 insertions(+), 150 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59da809b7d57..24c08eb86b7b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+/*
+ * lockdep gets confused between our buffer_tree which requires IRQ locking
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
+	xa_init_flags(&fs_info->buffer_tree, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
+	lockdep_set_class(&fs_info->buffer_tree.xa_lock, &buffer_xa_class);
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
index 6cfd286b8bbc..bedcacaf809f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1893,19 +1893,17 @@ static void set_btree_ioerr(struct extent_buffer *eb)
  * context.
  */
 static struct extent_buffer *find_extent_buffer_nolock(
-		const struct btrfs_fs_info *fs_info, u64 start)
+		struct btrfs_fs_info *fs_info, u64 start)
 {
 	struct extent_buffer *eb;
+	unsigned long index = start >> fs_info->sectorsize_bits;
 
 	rcu_read_lock();
-	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> fs_info->sectorsize_bits);
-	if (eb && atomic_inc_not_zero(&eb->refs)) {
-		rcu_read_unlock();
-		return eb;
-	}
+	eb = xa_load(&fs_info->buffer_tree, index);
+	if (eb && !atomic_inc_not_zero(&eb->refs))
+		eb = NULL;
 	rcu_read_unlock();
-	return NULL;
+	return eb;
 }
 
 static void end_bbio_meta_write(struct btrfs_bio *bbio)
@@ -2769,11 +2767,10 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 
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
@@ -2938,9 +2935,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
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
@@ -2952,13 +2949,12 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
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
@@ -3022,23 +3018,26 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 	eb->fs_info = fs_info;
 again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		exists = ERR_PTR(ret);
+	xa_lock_irq(&fs_info->buffer_tree);
+	exists = __xa_cmpxchg(&fs_info->buffer_tree,
+			      start >> fs_info->sectorsize_bits, NULL, eb,
+			      GFP_NOFS);
+	if (xa_is_err(exists)) {
+		ret = xa_err(exists);
+		xa_unlock_irq(&fs_info->buffer_tree);
+		btrfs_release_extent_buffer(eb);
+		return ERR_PTR(ret);
+	}
+	if (exists) {
+		if (!atomic_inc_not_zero(&exists->refs)) {
+			/* The extent buffer is being freed, retry. */
+			xa_unlock_irq(&fs_info->buffer_tree);
+			goto again;
+		}
+		xa_unlock_irq(&fs_info->buffer_tree);
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
+	xa_unlock_irq(&fs_info->buffer_tree);
 	check_buffer_tree_ref(eb);
 
 	return eb;
@@ -3059,9 +3058,9 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -3194,7 +3193,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	/*
 	 * To inform we have an extra eb under allocation, so that
 	 * detach_extent_buffer_page() won't release the folio private when the
-	 * eb hasn't been inserted into radix tree yet.
+	 * eb hasn't been inserted into the xarray yet.
 	 *
 	 * The ref will be decreased when the eb releases the page, in
 	 * detach_extent_buffer_page().  Thus needs no special handling in the
@@ -3328,10 +3327,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
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
@@ -3340,23 +3339,25 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (page_contig)
 		eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
 again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret)
+	xa_lock_irq(&fs_info->buffer_tree);
+	existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
+				   start >> fs_info->sectorsize_bits, NULL, eb,
+				   GFP_NOFS);
+	if (xa_is_err(existing_eb)) {
+		ret = xa_err(existing_eb);
+		xa_unlock_irq(&fs_info->buffer_tree);
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
+			xa_unlock_irq(&fs_info->buffer_tree);
+			goto again;
+		}
+		xa_unlock_irq(&fs_info->buffer_tree);
+		goto out;
+	}
+	xa_unlock_irq(&fs_info->buffer_tree);
+
 	/* add one reference for the tree */
 	check_buffer_tree_ref(eb);
 
@@ -3426,10 +3427,23 @@ static int release_extent_buffer(struct extent_buffer *eb)
 
 		spin_unlock(&eb->refs_lock);
 
-		spin_lock(&fs_info->buffer_lock);
-		radix_tree_delete_item(&fs_info->buffer_radix,
-				       eb->start >> fs_info->sectorsize_bits, eb);
-		spin_unlock(&fs_info->buffer_lock);
+		/*
+		 * We're erasing, theoretically there will be no allocations, so
+		 * just use GFP_ATOMIC.
+		 *
+		 * We use cmpxchg instead of erase because we do not know if
+		 * this eb is actually in the tree or not, we could be cleaning
+		 * up an eb that we allocated but never inserted into the tree.
+		 * Thus use cmpxchg to remove it from the tree if it is there,
+		 * or leave the other entry if this isn't in the tree.
+		 *
+		 * The documentation says that putting a NULL value is the same
+		 * as erase as long as XA_FLAGS_ALLOC is not set, which it isn't
+		 * in this case.
+		 */
+		xa_cmpxchg_irq(&fs_info->buffer_tree,
+			       eb->start >> fs_info->sectorsize_bits, eb, NULL,
+			       GFP_ATOMIC);
 
 		btrfs_leak_debug_del_eb(eb);
 		/* Should be safe to release folios at this point. */
@@ -4260,44 +4274,6 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
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
@@ -4306,21 +4282,22 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 	int ret;
 
 	while (cur < end) {
+		unsigned long index = cur >> fs_info->sectorsize_bits;
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
+		xa_lock_irq(&fs_info->buffer_tree);
+		eb = xa_load(&fs_info->buffer_tree, index);
 		if (!eb) {
 			/* No more eb in the page range after or at cur */
-			spin_unlock(&fs_info->buffer_lock);
+			xa_unlock_irq(&fs_info->buffer_tree);
 			break;
 		}
 		cur = eb->start + eb->len;
@@ -4332,10 +4309,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		spin_lock(&eb->refs_lock);
 		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
-			spin_unlock(&fs_info->buffer_lock);
+			xa_unlock_irq(&fs_info->buffer_tree);
 			break;
 		}
-		spin_unlock(&fs_info->buffer_lock);
+		xa_unlock_irq(&fs_info->buffer_tree);
 
 		/*
 		 * If tree ref isn't set then we know the ref on this eb is a
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bcca43046064..ed02d276d908 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -776,10 +776,8 @@ struct btrfs_fs_info {
 
 	struct btrfs_delayed_root *delayed_root;
 
-	/* Extent buffer radix tree */
-	spinlock_t buffer_lock;
 	/* Entries are eb->start / sectorsize */
-	struct radix_tree_root buffer_radix;
+	struct xarray buffer_tree;
 
 	/* Next backup root to be overwritten */
 	int backup_root_index;
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 02a915eb51fb..b576897d71cc 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -157,9 +157,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 {
-	struct radix_tree_iter iter;
-	void **slot;
 	struct btrfs_device *dev, *tmp;
+	struct extent_buffer *eb;
+	unsigned long index;
 
 	if (!fs_info)
 		return;
@@ -169,25 +169,13 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 
 	test_mnt->mnt_sb->s_fs_info = NULL;
 
-	spin_lock(&fs_info->buffer_lock);
-	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter, 0) {
-		struct extent_buffer *eb;
-
-		eb = radix_tree_deref_slot_protected(slot, &fs_info->buffer_lock);
-		if (!eb)
-			continue;
-		/* Shouldn't happen but that kind of thinking creates CVE's */
-		if (radix_tree_exception(eb)) {
-			if (radix_tree_deref_retry(eb))
-				slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		spin_unlock(&fs_info->buffer_lock);
-		free_extent_buffer_stale(eb);
-		spin_lock(&fs_info->buffer_lock);
+	xa_lock_irq(&fs_info->buffer_tree);
+	xa_for_each(&fs_info->buffer_tree, index, eb) {
+		xa_unlock_irq(&fs_info->buffer_tree);
+		free_extent_buffer(eb);
+		xa_lock_irq(&fs_info->buffer_tree);
 	}
-	spin_unlock(&fs_info->buffer_lock);
+	xa_unlock_irq(&fs_info->buffer_tree);
 
 	btrfs_mapping_tree_free(fs_info);
 	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7b30700ec930..4b59bc480663 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2171,27 +2171,15 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	const u64 end = block_group->start + block_group->length;
-	struct radix_tree_iter iter;
 	struct extent_buffer *eb;
-	void __rcu **slot;
+	unsigned long index, start = block_group->start >> fs_info->sectorsize_bits;
 
 	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
-				 block_group->start >> fs_info->sectorsize_bits) {
-		eb = radix_tree_deref_slot(slot);
-		if (!eb)
-			continue;
-		if (radix_tree_deref_retry(eb)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-
+	xa_for_each_start(&fs_info->buffer_tree, index, eb, start) {
 		if (eb->start < block_group->start)
 			continue;
 		if (eb->start >= end)
 			break;
-
-		slot = radix_tree_iter_resume(slot, &iter);
 		rcu_read_unlock();
 		wait_on_extent_buffer_writeback(eb);
 		rcu_read_lock();
-- 
2.48.1


