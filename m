Return-Path: <linux-btrfs+bounces-2042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A780484619C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 20:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3331F27E34
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1098529F;
	Thu,  1 Feb 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="x2CMNKF5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291429B0
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817541; cv=none; b=EBlCvNGVlZ7xtY5+SCJR1HzIFvIBhSx1fuEZn3Olzq5Asm3eXh1HF6wXFcvR7kN5UwZWuhhBxvJeCDoPqoRUUm2J029YVUgF+FwAGvqrBQVITASk49bCAVuykQ9kx8RoiP9gB+Z9rS901j4sYUz6RfT0SCWMyMm8NiN3vDCN/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817541; c=relaxed/simple;
	bh=OnezgRTYXYI8VtAQZUVRRV7jjeTrO8TG/LK4DeCW2VA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gcLeLInDqUQXwmwQit0kZQ3i/QwkJwyhC9gvw63bhskY3CpnGPiYrYZ3hxk1jhcG+Q3N4kdm+k+UjqqEujCHyihviIdaSkM7SpvZQEqJlvuX58bxBC9P31m/tNMH7D/ZOqzUhX0rezDFWGvmrJZrzdNQe1eG3z3584JWvPIUSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=x2CMNKF5; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e12f8506ccso741427a34.2
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Feb 2024 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706817538; x=1707422338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oeu5xlKW8pJl77VSExE+Jp/n5nA3/46c/5cPYWGGtJ0=;
        b=x2CMNKF5IawB+2RfOygNW2OeBQVlxUVBHha5WC0zwZEg3JIl43lv82Hxaj3RdMdzIZ
         KkapFBRTayRy5EDMP/wt0FRs7ddq2/Eh4DpJ9Y9/m2zzL5mSeZetErra8XXqWqeweo1h
         vhwAf6nR7CrLA0meADK8Ze3Gn8eq9FlzXHvEVWc86p2XjwNqiLiuzdL830ngg7VgwUWM
         PCF7QHaXxMrT4+1hdgDA9XYvrjAiMzqoo7hMrZzGgdYReVtSfTQBQdos3Gv1mULvKNcG
         OiOl290F5fwbwdFQCPywyJIPoczsujTIJd1zyIzzC8Ftejr+vF3XrB/dOZTdtw4V1mSP
         wF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817538; x=1707422338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oeu5xlKW8pJl77VSExE+Jp/n5nA3/46c/5cPYWGGtJ0=;
        b=qfINJvbSLM9+WkaHopopvUOugjnCS1n6159rQvxSCfKpNsUJB4Ps5+YUNPfQZT4U/y
         4XSW/PcngDjCqceEJAPCfmRn0F9z4X4eanW4+LXZ0hqwW3SNncV/uz6yr4kkUlAjF7kG
         QK3X8D7PbHDA8t43ZnM9sYFC0yCYhsk76eC58mvTwv8ZnoEqM9ABROFDTvPBCqNnDhla
         +bFiir86Jb8b7Ckc7Sj3e1MynmoseCvyybuc72gLgDCfgFLih8+wgXT8qKvaiKiYT7vY
         JY1agqjnuB4InW+zoUY5KVTDoJFMA1s/kpYpEXahqG2bZh/H2DpSR9+pv16y4DEHimlH
         X2wQ==
X-Gm-Message-State: AOJu0YydVRoobIwHkSkqbaBxiqWiKc4TNB8352qSWLTWweb+JTSO7Utk
	uTB6dfxqzTgConip3i6CozCS04+waUjgV2tr40od/i6EXdAoZKEUqaNJKGGYZ6IyoN9CxApdl98
	G
X-Google-Smtp-Source: AGHT+IFms6TYkY70iWr95rRf3N7/EvDNbwESuS/6RBx+A2E0bSVqBZFM6lyKsXDtN2VofsiWuw2k5w==
X-Received: by 2002:a9d:5914:0:b0:6dc:3e02:92aa with SMTP id t20-20020a9d5914000000b006dc3e0292aamr5519812oth.22.1706817538417;
        Thu, 01 Feb 2024 11:58:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDmPBHhBlkFEiigK7mwc98tmB0zl2hGm4U7SDBVCTrpHmHJYM+Wj3xXSyE7VTIjC1IjX2kmqeza9SaABYa7tbKEc0=
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f13-20020a05622a114d00b004299f09e3aesm90941qty.51.2024.02.01.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:58:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix deadlock with fiemap and extent locking
Date: Thu,  1 Feb 2024 14:58:54 -0500
Message-ID: <47ac92a6c8be53a5e10add9315255460c062b52d.1706817512.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on the patchset to remove extent locking I got a lockdep
splat with fiemap and pagefaulting with my new extent lock replacement
lock.

This deadlock exists with our normal code, we just don't have lockdep
annotations with the extent locking so we've never noticed it.

Since we're copying the fiemap extent to user space on every iteration
we have the chance of pagefaulting.  Because we hold the extent lock for
the entire range we could mkwrite into a range in the file that we have
mmap'ed.  This would deadlock with the following stack trace

[<0>] lock_extent+0x28d/0x2f0
[<0>] btrfs_page_mkwrite+0x273/0x8a0
[<0>] do_page_mkwrite+0x50/0xb0
[<0>] do_fault+0xc1/0x7b0
[<0>] __handle_mm_fault+0x2fa/0x460
[<0>] handle_mm_fault+0xa4/0x330
[<0>] do_user_addr_fault+0x1f4/0x800
[<0>] exc_page_fault+0x7c/0x1e0
[<0>] asm_exc_page_fault+0x26/0x30
[<0>] rep_movs_alternative+0x33/0x70
[<0>] _copy_to_user+0x49/0x70
[<0>] fiemap_fill_next_extent+0xc8/0x120
[<0>] emit_fiemap_extent+0x4d/0xa0
[<0>] extent_fiemap+0x7f8/0xad0
[<0>] btrfs_fiemap+0x49/0x80
[<0>] __x64_sys_ioctl+0x3e1/0xb50
[<0>] do_syscall_64+0x94/0x1a0
[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

I wrote an fstest to reproduce this deadlock without my replacement lock
and verified that the deadlock exists with our existing locking.

To fix this simply don't take the extent lock for the entire duration of
the fiemap.  This is safe in general because we keep track of where we
are when we're searching the tree, so if an ordered extent updates in
the middle of our fiemap call we'll still emit the correct extents
because we know what offset we were on before.

The only place we maintain the lock is searching delalloc.  Since the
delalloc stuff can change during writeback we want to lock the extent
range so we have a consistent view of delalloc at the time we're
checking to see if we need to set the delalloc flag.

With this patch applied we no longer deadlock with my testcase.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 49 +++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8648ea9b5fb5..f8b68249d958 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2683,16 +2683,25 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 	 * it beyond i_size.
 	 */
 	while (cur_offset < end && cur_offset < i_size) {
+		struct extent_state *cached_state = NULL;
 		u64 delalloc_start;
 		u64 delalloc_end;
 		u64 prealloc_start;
+		u64 lockstart, lockend;
 		u64 prealloc_len = 0;
 		bool delalloc;
 
+		lockstart = round_down(cur_offset,
+				       inode->root->fs_info->sectorsize);
+		lockend = round_up(end, inode->root->fs_info->sectorsize);
+
+		lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
 							delalloc_cached_state,
 							&delalloc_start,
 							&delalloc_end);
+		unlock_extent(&inode->io_tree, lockstart, lockend,
+			      &cached_state);
 		if (!delalloc)
 			break;
 
@@ -2860,15 +2869,14 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len)
 {
 	const u64 ino = btrfs_ino(inode);
-	struct extent_state *cached_state = NULL;
 	struct extent_state *delalloc_cached_state = NULL;
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_share_check_ctx *backref_ctx;
 	u64 last_extent_end;
 	u64 prev_extent_end;
-	u64 lockstart;
-	u64 lockend;
+	u64 align_start;
+	u64 align_end;
 	bool stopped = false;
 	int ret;
 
@@ -2879,12 +2887,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	lockstart = round_down(start, inode->root->fs_info->sectorsize);
-	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
-	prev_extent_end = lockstart;
+	align_start = round_down(start, inode->root->fs_info->sectorsize);
+	align_end = round_up(start + len, inode->root->fs_info->sectorsize);
+	prev_extent_end = align_start;
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
@@ -2892,7 +2899,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_release_path(path);
 
 	path->reada = READA_FORWARD;
-	ret = fiemap_search_slot(inode, path, lockstart);
+	ret = fiemap_search_slot(inode, path, align_start);
 	if (ret < 0) {
 		goto out_unlock;
 	} else if (ret > 0) {
@@ -2904,7 +2911,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto check_eof_delalloc;
 	}
 
-	while (prev_extent_end < lockend) {
+	while (prev_extent_end < align_end) {
 		struct extent_buffer *leaf = path->nodes[0];
 		struct btrfs_file_extent_item *ei;
 		struct btrfs_key key;
@@ -2927,14 +2934,14 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		 * The first iteration can leave us at an extent item that ends
 		 * before our range's start. Move to the next item.
 		 */
-		if (extent_end <= lockstart)
+		if (extent_end <= align_start)
 			goto next_item;
 
 		backref_ctx->curr_leaf_bytenr = leaf->start;
 
 		/* We have in implicit hole (NO_HOLES feature enabled). */
 		if (prev_extent_end < key.offset) {
-			const u64 range_end = min(key.offset, lockend) - 1;
+			const u64 range_end = min(key.offset, align_end) - 1;
 
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  &delalloc_cached_state,
@@ -2949,7 +2956,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			}
 
 			/* We've reached the end of the fiemap range, stop. */
-			if (key.offset >= lockend) {
+			if (key.offset >= align_end) {
 				stopped = true;
 				break;
 			}
@@ -3043,29 +3050,40 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_free_path(path);
 	path = NULL;
 
-	if (!stopped && prev_extent_end < lockend) {
+	if (!stopped && prev_extent_end < align_end) {
 		ret = fiemap_process_hole(inode, fieinfo, &cache,
 					  &delalloc_cached_state, backref_ctx,
-					  0, 0, 0, prev_extent_end, lockend - 1);
+					  0, 0, 0, prev_extent_end, align_end - 1);
 		if (ret < 0)
 			goto out_unlock;
-		prev_extent_end = lockend;
+		prev_extent_end = align_end;
 	}
 
 	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
 		const u64 i_size = i_size_read(&inode->vfs_inode);
 
 		if (prev_extent_end < i_size) {
+			struct extent_state *cached_state = NULL;
 			u64 delalloc_start;
 			u64 delalloc_end;
+			u64 lockstart, lockend;
 			bool delalloc;
 
+			lockstart = round_down(prev_extent_end,
+					       inode->root->fs_info->sectorsize);
+			lockend = round_up(i_size,
+					   inode->root->fs_info->sectorsize);
+
+			lock_extent(&inode->io_tree, lockstart, lockend,
+				    &cached_state);
 			delalloc = btrfs_find_delalloc_in_range(inode,
 								prev_extent_end,
 								i_size - 1,
 								&delalloc_cached_state,
 								&delalloc_start,
 								&delalloc_end);
+			unlock_extent(&inode->io_tree, lockstart, lockend,
+				      &cached_state);
 			if (!delalloc)
 				cache.flags |= FIEMAP_EXTENT_LAST;
 		} else {
@@ -3076,7 +3094,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 
 out_unlock:
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 out:
 	free_extent_state(delalloc_cached_state);
-- 
2.43.0


