Return-Path: <linux-btrfs+bounces-4359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159838A8605
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C014C2838EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715E1422A4;
	Wed, 17 Apr 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RHASYPZU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136DA141995
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364572; cv=none; b=jAh8UsaBOCtUGqbWvaxyC/PoPLx3K1ojFBqXsYC6/n+9FxSULD85o/5aPr+VipnHPO8+QmZTSN5TJjWRZ3hfhNR2uWitpifwQnENstcafr/ch1uZn5xGQ6hWb5bHrXZ4NyQ+8lQZEwwStTDzAtxo/6pxkW9kvXhAWa3F9aEr/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364572; c=relaxed/simple;
	bh=aNcZdPxo8u/pCayIkB5q7CYhN4+vt6ALpPLNXTIm0v0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW7NUuHMenvLdV9TIRFP9CeWmZkIkd9JgaUdrNbLw1gDYtSSpcVIwVfh6ZiJv9CG1hPJl42qNSzFj3L3773AHFaJcisrfOe79LFKgc2aZrSdAD2fEYHoWeqSrv0Dy9Pjkkto5YjPUf7SWRbnSUWYmNeMgYDJ6xn/HSqAI6oUHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RHASYPZU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b7d2de292so10981026d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364569; x=1713969369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ok6H1BKlMw4Nai5Jk/eY9RxUhrfqn1qPYvewp5xF6EM=;
        b=RHASYPZU7dtjT5r8++l01yhmdf8AKNgno9sy+JCnjs4k+aoaHwoWXA4XuJwec8rKEK
         NRc9t9wkQMqZ629IvRyhxu+KMa3YRZ1bj4l2J8aL8sk+KTS42Qe/6afvkTqganYgfABV
         r/WP62NlULbc3mzKIlA/25+a2TbKWDhglSMnFkELINPkBAY947eTeuZwHh0BWAWR8nWM
         B3ZKa1c0kWAfi70kRGbNyB8I/oqQNBO36PJK/8YsvpvhUPes67U/Lrjllo0yHz8sgLIJ
         mcxfdf7GICLq9bQ+FHLzOZFiTwngokD77ts4R6QKQ9A12+jN83EPHplyJIcMJtjBaj08
         +FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364569; x=1713969369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok6H1BKlMw4Nai5Jk/eY9RxUhrfqn1qPYvewp5xF6EM=;
        b=HHtKQgKPNWSejmFBwEX20cAs9jU/V67LPdNJw5VqQnhaSW/u6KppF226DqDY4Sp1Gi
         VHC6/6LsG5BzNdA6OJbLjtmAd8AyZOOtRTg3jC24eIudXKU0l/j4NtEWUI99frwEa7RA
         Kz/rIeYAKX5CP9dfY6WvhTTv+BTyBF7oaPzMJESa65ntsID/PYTQs8kQ0RYOMmwFCVB4
         KavYFoM5d2lvXsnoLZHLU4qRCfG+kygqmFXnwWTskiZdykLI9yqblrwfelUFR5b8w6db
         yQc9G8icnBSZ0PZl5CsR632Rf6db4a5Ea8g2nC/ltOHSrOw5GX/6d3h+iI194D2xuzqu
         hu4Q==
X-Gm-Message-State: AOJu0Yxay/scsRmsgAbq6MOeDdDoduROEXtq9ciDWBtjnSnlNfHt5biC
	b75Xmro1LxhRdAwsXNpN1yglBxr+Wcqrlu/HH/Fi3LnJeUUmvZA4HxAiraN/acfrGqnWsz0T37O
	s
X-Google-Smtp-Source: AGHT+IGXiSQuSRcVRFoYL88BoM4Wy5FxebE74/yoaqZwZDMeT85WBrjKAHb4B+bJ5bYBiKBp6CUUTg==
X-Received: by 2002:a05:6214:c67:b0:69b:da6:b9d3 with SMTP id t7-20020a0562140c6700b0069b0da6b9d3mr18363319qvj.65.1713364568610;
        Wed, 17 Apr 2024 07:36:08 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jh17-20020a0562141fd100b006990b44228dsm8374699qvb.125.2024.04.17.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 02/17] btrfs: push all inline logic into cow_file_range
Date: Wed, 17 Apr 2024 10:35:46 -0400
Message-ID: <2796fb5d2b04c3ff87c2ab5b285fd7e072a8e4a2.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have a lot of duplicated checks of

if (start == 0 && fs_info->sectorsize == PAGE_SIZE)
	cow_file_range_inline();

Instead of duplicating this check everywhere, consolidate all of the
inline extent logic into a helper which documents all of the checks and
then use that helper inside of cow_file_range_inline().  With this we
can clean up all of the calls to either unconditionally call
cow_file_range_inline(), or at least reduce the checks we're doing
before we call cow_file_range_inline();

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 143 +++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 94d9a74a912c..925a53d886b4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -614,14 +614,56 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static bool can_cow_file_range_inline(struct btrfs_inode *inode,
+				      u64 offset, u64 size,
+				      size_t compressed_size)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u64 data_len = (compressed_size ?: size);
+
+	/* Inline extents must start at offset 0. */
+	if (offset != 0)
+		return false;
+
+	/*
+	 * Due to the page size limit, for subpage we can only trigger the
+	 * writeback for the dirty sectors of page, that means data writeback
+	 * is doing more writeback than what we want.
+	 *
+	 * This is especially unexpected for some call sites like fallocate,
+	 * where we only increase i_size after everything is done.
+	 * This means we can trigger inline extent even if we didn't want to.
+	 * So here we skip inline extent creation completely.
+	 */
+	if (fs_info->sectorsize != PAGE_SIZE)
+		return false;
+
+	/* Inline extents are limited to sectorsize. */
+	if (size > fs_info->sectorsize)
+		return false;
+
+	/* We cannot exceed the maximum inline data size. */
+	if (data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
+		return false;
+
+	/* We cannot exceed the user specified max_inline size. */
+	if (data_len > fs_info->max_inline)
+		return false;
+
+	/* Inline extents must be the entirety of the file. */
+	if (size < i_size_read(&inode->vfs_inode))
+		return false;
+
+	return true;
+}
 
 /*
  * conditionally insert an inline extent into the file.  This
  * does the checks required to make sure the data is small enough
  * to fit as an inline extent.
  */
-static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
-					  size_t compressed_size,
+static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
+					  u64 size, size_t compressed_size,
 					  int compress_type,
 					  struct folio *compressed_folio,
 					  bool update_i_size)
@@ -634,16 +676,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	int ret;
 	struct btrfs_path *path;
 
-	/*
-	 * We can create an inline extent if it ends at or beyond the current
-	 * i_size, is no larger than a sector (decompressed), and the (possibly
-	 * compressed) data fits in a leaf and the configured maximum inline
-	 * size.
-	 */
-	if (size < i_size_read(&inode->vfs_inode) ||
-	    size > fs_info->sectorsize ||
-	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
-	    data_len > fs_info->max_inline)
+	if (!can_cow_file_range_inline(inode, offset, size, compressed_size))
 		return 1;
 
 	path = btrfs_alloc_path();
@@ -971,43 +1004,38 @@ static void compress_file_range(struct btrfs_work *work)
 	 * Check cow_file_range() for why we don't even try to create inline
 	 * extent for the subpage case.
 	 */
-	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
-		if (total_in < actual_end) {
-			ret = cow_file_range_inline(inode, actual_end, 0,
-						    BTRFS_COMPRESS_NONE, NULL,
-						    false);
-		} else {
-			ret = cow_file_range_inline(inode, actual_end,
-						    total_compressed,
-						    compress_type, folios[0],
-						    false);
-		}
-		if (ret <= 0) {
-			unsigned long clear_flags = EXTENT_DELALLOC |
-				EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
-				EXTENT_DO_ACCOUNTING;
+	if (total_in < actual_end)
+		ret = cow_file_range_inline(inode, start, actual_end, 0,
+					    BTRFS_COMPRESS_NONE, NULL, false);
+	else
+		ret = cow_file_range_inline(inode, start, actual_end,
+					    total_compressed, compress_type,
+					    folios[0], false);
+	if (ret <= 0) {
+		unsigned long clear_flags = EXTENT_DELALLOC |
+			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
+			EXTENT_DO_ACCOUNTING;
 
-			if (ret < 0)
-				mapping_set_error(mapping, -EIO);
+		if (ret < 0)
+			mapping_set_error(mapping, -EIO);
 
-			/*
-			 * inline extent creation worked or returned error,
-			 * we don't need to create any more async work items.
-			 * Unlock and free up our temp pages.
-			 *
-			 * We use DO_ACCOUNTING here because we need the
-			 * delalloc_release_metadata to be done _after_ we drop
-			 * our outstanding extent for clearing delalloc for this
-			 * range.
-			 */
-			extent_clear_unlock_delalloc(inode, start, end,
-						     NULL,
-						     clear_flags,
-						     PAGE_UNLOCK |
-						     PAGE_START_WRITEBACK |
-						     PAGE_END_WRITEBACK);
-			goto free_pages;
-		}
+		/*
+		 * inline extent creation worked or returned error,
+		 * we don't need to create any more async work items.
+		 * Unlock and free up our temp pages.
+		 *
+		 * We use DO_ACCOUNTING here because we need the
+		 * delalloc_release_metadata to be done _after_ we drop
+		 * our outstanding extent for clearing delalloc for this
+		 * range.
+		 */
+		extent_clear_unlock_delalloc(inode, start, end,
+					     NULL,
+					     clear_flags,
+					     PAGE_UNLOCK |
+					     PAGE_START_WRITEBACK |
+					     PAGE_END_WRITEBACK);
+		goto free_pages;
 	}
 
 	/*
@@ -1315,22 +1343,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
 
-	/*
-	 * Due to the page size limit, for subpage we can only trigger the
-	 * writeback for the dirty sectors of page, that means data writeback
-	 * is doing more writeback than what we want.
-	 *
-	 * This is especially unexpected for some call sites like fallocate,
-	 * where we only increase i_size after everything is done.
-	 * This means we can trigger inline extent even if we didn't want to.
-	 * So here we skip inline extent creation completely.
-	 */
-	if (start == 0 && fs_info->sectorsize == PAGE_SIZE && !no_inline) {
+	if (!no_inline) {
 		u64 actual_end = min_t(u64, i_size_read(&inode->vfs_inode),
 				       end + 1);
 
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, actual_end, 0,
+		ret = cow_file_range_inline(inode, start, actual_end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
 		if (ret == 0) {
 			/*
@@ -10229,10 +10247,11 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		goto out_qgroup_free_data;
 
 	/* Try an inline extent first. */
-	if (start == 0 && encoded->unencoded_len == encoded->len &&
+	if (encoded->unencoded_len == encoded->len &&
 	    encoded->unencoded_offset == 0) {
-		ret = cow_file_range_inline(inode, encoded->len, orig_count,
-					    compression, folios[0], true);
+		ret = cow_file_range_inline(inode, start, encoded->len,
+					    orig_count, compression, folios[0],
+					    true);
 		if (ret <= 0) {
 			if (ret == 0)
 				ret = orig_count;
-- 
2.43.0


