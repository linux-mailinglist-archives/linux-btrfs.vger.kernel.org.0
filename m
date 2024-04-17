Return-Path: <linux-btrfs+bounces-4374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B228A8615
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731671C209B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8E1420B7;
	Wed, 17 Apr 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iWRU/aj0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91D1420A0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364590; cv=none; b=e3IWb7yDlCrtsXaOJwrBxRDbEQqQbloLYARTZBqxand332WB4xC7KH7mEzg/VZMNrHb6R1A8LzqtWgM8IBHZjp8tP8db9wr577wHDfbOCERoBWvLU8n99/a/4KzZlK5OVQw0VtcTF/x3S8vxJRGNibRHCZvzeXft2B8khvBswU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364590; c=relaxed/simple;
	bh=Om2AfipYw7ru6GSgAMqWPEQO8Y3gFFZag0Py3INjPoM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMJZPGBqAmuzbRjQEUsMeU0ZKWG0LlqgakSAUc/oWyKne7EQ8wXE2Rk8FMrH54XYEjzCkcyvd0iC9r/vNmMO2wiPZBKdZc7+rF+1ieUiDzT7swHdnQBcygM8r1qZDe9j3/SRRqbpqrH0IbyY/DMioljoim52IGn7v577Z0stk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iWRU/aj0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78f05afc8d6so22477485a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364587; x=1713969387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPTGjQs9Rh0XgjJ58BcQlKVgIL04uXdsncQ+roVpz9Q=;
        b=iWRU/aj02zN/NyBGVRXUlIu3W9J5SeG4lHqdIfv0VyR+7/SsvDVEbc5Au8LOiBGc0N
         jlkmLm90cOcAOUNBeT+/X3ziHyCUTlUMunZCcPxnjRPREkaAImyLY5YjVGbN4E3RaseW
         znpkhr7aKw3u1Qzm7Oicph2eCzmECUs5bijKYBnbwxLCNX/GYwjQJv7DsZwebnzFwJ3a
         10ALrOk9ZF+Ss0Nekh2qd94fDm7u4Y4x1FgZIkNJcx0/tHO3hGFDYqtqMc2OFoNgJGyT
         zO1JUPSteoDxZa5ySPik1i1FRBQc3r8HzfPULlEMNVcQnY1NNs+bj3ydJqH9Daas7WV5
         VYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364587; x=1713969387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPTGjQs9Rh0XgjJ58BcQlKVgIL04uXdsncQ+roVpz9Q=;
        b=clFNzui0JAqgtPPsGreYlSYSJ78HnH+hP5PgjL2j4SAL6bDiumWMQMlRKPhtxTf+2s
         UeuwCpoj95HU6vjMVk7LAZENgH8wY2OUtkhuWz5TnxKN81fdPtL4bZ4xDM+wxmgib1SZ
         hS8skytonIZreepLlwocwlzyV6YXRDf9W0zdY0w7FX8NLqQeE5JR+UVw+VL7T3ZO7Gu9
         +D+M+PSo9QV929hvO5vTp6UO/ue0IOGh4eeiYIkHJEZjmbPOiuUCCXSNP5AfqEdGWeBb
         HJC73Yn3mL2X+wI7kOBrUs21WQ0M3Wd4FMOtYBvJyCgF5zudHpXtKAbecVC1M1Xi4Xo+
         iTDw==
X-Gm-Message-State: AOJu0YwKG0a7AiV3IXyChS3ObvPKx0/0rKcvRXuXFNMERPlKLxxG0xp3
	Z7E16AzB+TqXPPVqXNm4UIpeFBMPOHMWFKQoyBTAheDRnWcNauUj7aGSsyBZWOj6xVfloDZ0Ixo
	S
X-Google-Smtp-Source: AGHT+IELaL6fGLSnZZDbBBvLDpYzwf5LDCYRXkflxiw7mCjmQZbY+zOOw+9PO+i1HsCNhVDuxWqCGA==
X-Received: by 2002:a05:620a:370f:b0:78d:579a:29ea with SMTP id de15-20020a05620a370f00b0078d579a29eamr21820076qkb.52.1713364587441;
        Wed, 17 Apr 2024 07:36:27 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a240600b0078d735ca917sm8453081qkn.123.2024.04.17.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 17/17] btrfs: add a cached state to extent_clear_unlock_delalloc
Date: Wed, 17 Apr 2024 10:36:01 -0400
Message-ID: <62f3c0fa890b9bebc7f2d1871ec4c885c5287ed5.1713363472.git.josef@toxicpanda.com>
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

Now that we have the lock_extent tightly coupled with
extent_clear_unlock_delalloc we can add a cached state to
extent_clear_unlock_delalloc and benefit from skipping the extra lookup
when we're doing cow.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  3 ++-
 fs/btrfs/extent_io.h |  2 ++
 fs/btrfs/inode.c     | 42 ++++++++++++++++++++++++------------------
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c09f46f969b1..8ec5f5c7bfe1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -412,9 +412,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
+				  struct extent_state **cached,
 				  u32 clear_bits, unsigned long page_ops)
 {
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits, NULL);
+	clear_extent_bit(&inode->io_tree, start, end, clear_bits, cached);
 
 	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
 			       start, end, page_ops);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c81a9b546c9f..e62dc720e1d2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -27,6 +27,7 @@ struct address_space;
 struct writeback_control;
 struct extent_io_tree;
 struct extent_map_tree;
+struct extent_state;
 struct btrfs_block_group;
 struct btrfs_fs_info;
 struct btrfs_inode;
@@ -352,6 +353,7 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
+				  struct extent_state **cached,
 				  u32 bits_to_clear, unsigned long page_ops);
 int extent_invalidate_folio(struct extent_io_tree *tree,
 			    struct folio *folio, size_t offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a96f68f61495..7a738ec41095 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -762,8 +762,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 		return ret;
 	}
 
-	free_extent_state(cached);
-	extent_clear_unlock_delalloc(inode, offset, end, NULL, clear_flags,
+	extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
+				     clear_flags,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
 	return ret;
@@ -1154,6 +1154,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_key ins;
 	struct page *locked_page = NULL;
+	struct extent_state *cached = NULL;
 	struct extent_map *em;
 	int ret = 0;
 	u64 start = async_extent->start;
@@ -1194,7 +1195,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		goto done;
 	}
 
-	lock_extent(io_tree, start, end, NULL);
+	lock_extent(io_tree, start, end, &cached);
 
 	/* Here we're doing allocation and writeback of the compressed pages */
 	em = create_io_em(inode, start,
@@ -1229,7 +1230,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	/* Clear dirty, set writeback and unlock the pages. */
 	extent_clear_unlock_delalloc(inode, start, end,
-			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
+			NULL, &cached, EXTENT_LOCKED | EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
 	btrfs_submit_compressed_write(ordered,
 			    async_extent->folios,	/* compressed_folios */
@@ -1247,7 +1248,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
 	extent_clear_unlock_delalloc(inode, start, end,
-				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
+				     NULL, &cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
@@ -1329,6 +1331,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct extent_state *cached = NULL;
 	u64 alloc_hint = 0;
 	u64 orig_start = start;
 	u64 num_bytes;
@@ -1429,7 +1432,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		ram_size = ins.offset;
 
-		lock_extent(&inode->io_tree, start, start + ram_size - 1, NULL);
+		lock_extent(&inode->io_tree, start, start + ram_size - 1,
+			    &cached);
 
 		em = create_io_em(inode, start, ins.offset, /* len */
 				  start, /* orig_start */
@@ -1441,7 +1445,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				  BTRFS_ORDERED_REGULAR /* type */);
 		if (IS_ERR(em)) {
 			unlock_extent(&inode->io_tree, start,
-				      start + ram_size - 1, NULL);
+				      start + ram_size - 1, &cached);
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
@@ -1453,7 +1457,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					BTRFS_COMPRESS_NONE);
 		if (IS_ERR(ordered)) {
 			unlock_extent(&inode->io_tree, start,
-				      start + ram_size - 1, NULL);
+				      start + ram_size - 1, &cached);
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
 		}
@@ -1493,7 +1497,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		page_ops |= PAGE_SET_ORDERED;
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
-					     locked_page,
+					     locked_page, &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
 					     page_ops);
 		if (num_bytes < cur_alloc_size)
@@ -1552,7 +1556,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (!locked_page)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
-					     locked_page, 0, page_ops);
+					     locked_page, NULL, 0, page_ops);
 	}
 
 	/*
@@ -1575,7 +1579,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
 					     start + cur_alloc_size - 1,
-					     locked_page,
+					     locked_page, &cached,
 					     clear_bits,
 					     page_ops);
 		start += cur_alloc_size;
@@ -1590,7 +1594,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	if (start < end) {
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
-					     clear_bits, page_ops);
+					     &cached, clear_bits, page_ops);
 	}
 	return ret;
 }
@@ -2206,11 +2210,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		btrfs_put_ordered_extent(ordered);
 
 		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
-					     locked_page, EXTENT_LOCKED |
-					     EXTENT_DELALLOC |
+					     locked_page, &cached_state,
+					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
-		free_extent_state(cached_state);
 
 		cur_offset = extent_end;
 
@@ -2252,10 +2255,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 * we're not locked at this point.
 	 */
 	if (cur_offset < end) {
-		lock_extent(&inode->io_tree, cur_offset, end, NULL);
+		struct extent_state *cached = NULL;
+
+		lock_extent(&inode->io_tree, cur_offset, end, &cached);
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
-					     locked_page, EXTENT_LOCKED |
-					     EXTENT_DELALLOC | EXTENT_DEFRAG |
+					     locked_page, &cached,
+					     EXTENT_LOCKED | EXTENT_DELALLOC |
+					     EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
-- 
2.43.0


