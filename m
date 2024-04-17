Return-Path: <linux-btrfs+bounces-4366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307688A860C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532601C20888
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CA14039D;
	Wed, 17 Apr 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PUrL2VfQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6F13D2B5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364580; cv=none; b=SC4JJhpfSFyWyEFz8rw/77vejHTCkX6B3YzzT0FqgSG+50a1A/oPAIEWXgyhMfLxVMvzZv421ixrBCiNPdfxm6pc6Za4E+0plIbo0wPEEOCdxGTlIc3LgCUTlksFx8fpliKZ9DU3IJNsq9ACWo5lxfE+sZ5dATgzsXs6Rc8HxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364580; c=relaxed/simple;
	bh=CN1fabPY01Y45PR27Ovs+cDoICKXpAkTzB3PxjpziUQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiWKAvFR1lzHpbmCh1E2Z8nWBCYr+FBPX6U5E6FlaLrQOQwl7sfoVEWcJJ1cyX0QOnyy9Kk5a3JU5F5O6y20N5DA0BB8GfWKkKs9kuxDFFva1sDz+W8/RNP5/rH1DsHiS63kbR70TEOIPwftdIuuKqe0dxYY1B3+aMHIxZWOdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PUrL2VfQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b40061bbeso29968476d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364577; x=1713969377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AReq9/l6IknEl65HbhwH0wLmQr5fkR4CqQNmIWsSnR4=;
        b=PUrL2VfQq2F77vOJ2WD8JSQd57MIUSBWHRACnuqbj8TxmUMF11668pshB4x4b5JFuB
         toSdyv01LqdtKaLbJ5HqoIYjqiOrGQCGEFNrUvDUAfVeiKojf4rhLhvmj7NeEOd0bimx
         81g0IiLh/wW4rX0LvaJvABUE5FePJCzacA0TY9bQoMMhvpyh07C5DLpGG92EUz6TA1i1
         +1l+SXw1fcCfYpyc5um2ZzvJBiAzKZDuF+6UJbSe+lRrOb+L7GbyqzSdSioPZl5i1IuU
         XY5srhX+6ID01lK8K89U8IYnSCJtH6JRsy3w4U3A4LZqGtWHkzTXvl5L6ZDUEfNhwt2X
         F1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364577; x=1713969377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AReq9/l6IknEl65HbhwH0wLmQr5fkR4CqQNmIWsSnR4=;
        b=Qvj4V89XNwH5PJhN6ADzsEPtr8Vrg33TbQ0xcakhDdVkGjHf4dseXzxv8RLrDLFVVe
         Lq4sD0l5vEkis9F09qcFHuzbrKrHn7c0fqk0YiO6ZtZFUJ7KlwZsjvQeCkbhgq+Mt00R
         CJ1s0GvsIeLK3onJxdZOrXri/+Wp4KhnYj6Eq006ZwZVikavwNnmIHWYsWdgkXEunNCU
         UjsNuusGeGlJXMdnnlOLmf+ttrV6rJO/YjWDGk7pUZDQlNr6Z7Z1zbTNmElEmyWg9mv9
         0+WkRxZyqZ8VqMaaQZBLwvH79cSm7CkRg4w3xaRAeDZCC4bBcX+HQoxCjsUkKNssMSKa
         fDsg==
X-Gm-Message-State: AOJu0YyoRhh3AAqpy9j/70Dp/jxhzg6isuhUGucsES6+sl9AiMvDJNp6
	vWYacwM0zRGWSHWcE+VwB0MvlPHybZ/PVtmQYvgjIt1Oo0Vf/ODTmsgmKG9MnoZQ72scWMPk/ba
	7
X-Google-Smtp-Source: AGHT+IEyA5as89eWCuZNl1oqaboJmvl74u61kUuGRWXKa+TaWQ7trUaxkTXDpGKqFiA7DE6BoPIfeQ==
X-Received: by 2002:a05:6214:c67:b0:69b:20a7:5669 with SMTP id t7-20020a0562140c6700b0069b20a75669mr20369462qvj.53.1713364577361;
        Wed, 17 Apr 2024 07:36:17 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ceb4c000000b0069b5672bab8sm7067844qvq.134.2024.04.17.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 09/17] btrfs: push extent lock down in run_delalloc_nocow
Date: Wed, 17 Apr 2024 10:35:53 -0400
Message-ID: <be4f89a0ad01fc580a11bfe52300a0c2e7669cc4.1713363472.git.josef@toxicpanda.com>
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

run_delalloc_nocow is a little special because we use the file extents
to see if we can nocow a range.  We don't actually need the protection
of the extent lock to look at the file extents at this point however.
We are currently holding the page lock for this range, so we are
protected from anybody who would simultaneously be modifying the file
extent items for this range.

* mmap() - we're holding the page lock.
* buffered writes - we're holding the page lock.
* direct writes - we're holding the page lock and direct IO has to flush
  page cache before it's able to continue.
* fallocate() - all callers flush the range and wait on ordered extents
  while holding the inode lock and the mmap lock, so we are again saved
  by the page lock.

We want to use the extent lock to protect

1) The mapping tree for the given range.
2) The ordered extents for the given range.
3) The io_tree for the given range.

Push the extent lock down to cover these operations.  In the
fallback_to_cow() case we simply lock before doing anything and rely on
the cow_file_range() helper to handle it's range properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 80e92d37af34..ab3d6ebbce6a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1747,6 +1747,8 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	u64 count;
 	int ret;
 
+	lock_extent(io_tree, start, end, NULL);
+
 	/*
 	 * If EXTENT_NORESERVE is set it means that when the buffered write was
 	 * made we had not enough available data space and therefore we did not
@@ -1977,8 +1979,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
 
-	lock_extent(&inode->io_tree, start, end, NULL);
-
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
@@ -1994,6 +1994,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
+		struct extent_state *cached_state = NULL;
 		u64 extent_end;
 		u64 ram_bytes;
 		u64 nocow_end;
@@ -2131,6 +2132,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
+		lock_extent(&inode->io_tree, cur_offset, nocow_end, &cached_state);
+
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
@@ -2144,6 +2147,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
+				unlock_extent(&inode->io_tree, cur_offset,
+					      nocow_end, &cached_state);
 				btrfs_dec_nocow_writers(nocow_bg);
 				ret = PTR_ERR(em);
 				goto error;
@@ -2164,6 +2169,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				btrfs_drop_extent_map_range(inode, cur_offset,
 							    nocow_end, false);
 			}
+			unlock_extent(&inode->io_tree, cur_offset,
+				      nocow_end, &cached_state);
 			ret = PTR_ERR(ordered);
 			goto error;
 		}
@@ -2182,6 +2189,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
+		free_extent_state(cached_state);
 
 		cur_offset = extent_end;
 
@@ -2217,13 +2225,20 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	if (cow_start != (u64)-1)
 		cur_offset = cow_start;
-	if (cur_offset < end)
+
+	/*
+	 * We need to lock the extent here because we're clearing DELALLOC and
+	 * we're not locked at this point.
+	 */
+	if (cur_offset < end) {
+		lock_extent(&inode->io_tree, cur_offset, end, NULL);
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
+	}
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.43.0


