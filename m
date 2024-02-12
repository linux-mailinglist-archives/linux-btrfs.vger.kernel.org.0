Return-Path: <linux-btrfs+bounces-2334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B6851A45
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC54E1C21C37
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC93EA8A;
	Mon, 12 Feb 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="meQ/taVU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05C3C495
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756971; cv=none; b=uCtwvyYAWiz9OwAOZD3qNm3hGDs/jU86fFOICdMeawXbK/rhwMec/7GUrA+Wqwp4mYy5773Ep6hL97YGVvQtvDHMbMTz6A3DRJkN0WvsKTKX4/VHcsgkzPQOdB7JV+ATCxw0Z7Owf0KedWHCAZQBS381DrMtk9Pu48PTfObdQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756971; c=relaxed/simple;
	bh=h2rM2FnfEGXitr7pLhT7uY9c3ni+YzpKuow1l304GI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qD1nFI0U2V2tqDv9wkjyG2VQrs2VAG1TP1TOIyR4gyOtHfjotjPT5rFsbSso7X+dG9pEMPRFJ3jqnGmGJnydNh8Fq2wFkjAe5fUbNMM+keyeZEEhfnwWNeL9aMVdivjNwCVN9wEOypPUofGExsDOjm1sHWCt6Ozb3zJTc4vXyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=meQ/taVU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604a3d33c4dso32768047b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 08:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1707756967; x=1708361767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DrQ0oi16Omz8/LF8WStMJLbklBT90AZl3FVLXqxJxcQ=;
        b=meQ/taVUJ2PODmOiA9DwiVj7VIKFc15SoJiKKNTDn/gHcNdGO6qL0BJtd4rcwftqDZ
         PaBjvBhfw4tLeaptdUZww5FMBdGgCdpCHqNOkUvMTCY6G9X1c8NVLILveZJKWTp/hDuL
         34X/o1Zo8cA+16HsxW9h2cd4UnqCXMTkQfgZeDOqvMwEW/N90vBKcQ/8Kr8poWMz2P9X
         MfwjoJdaPmT4473sr7BDWwa9OU40tprL7I+FRoKPCe5KOkLydo+ujlPdR1kCAq8Ej/Wm
         41+ao158yF5jP6Mfea3bUvVJfd4Vz4OtDxqZdeXf1OZ9pHbIbhxnN0S0oU0CJGXHIDPd
         waZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756967; x=1708361767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrQ0oi16Omz8/LF8WStMJLbklBT90AZl3FVLXqxJxcQ=;
        b=XCbTmtEFw+Wel3+AXsR6+RnPQc5QGq+WjZ2KQkYCjdJScf78ZRRf4dRzm7S8y3b1VR
         Wx/oLzCvx1A/a6+M5yFbGUdjX09tyo0YGtIitSujMQ/vcx9i0a/ZLsrgGNNmTd4+g+4i
         uno84q1sohflf0t9GIGpY1GhR4SKMrZfXcku0Pfv+W3GgJBJ9qsnzDWIju+3Q5keVNvQ
         FgNocgHyerrI7k9S5qPgeHdAnRJtGb4E03whNkusW7gcOYccTWmMX5H+9XAsbEo1W4GG
         AcjQRR/C2vFATNfzIYPEuvVdMa9aOhsd51tJrHSSemA4jaThS+byy9jEiGKz5PzMEgQY
         /AUQ==
X-Gm-Message-State: AOJu0YzMr/P1YoUaaqTI5gf93mKnu760k7cmuvGSQHBgPumQ4oCXaPvN
	fStkrEuUmmuDkAyKZ2AG52UoD9uK6PiHfvOP8nZGVxZHOOEDK8Kfxx57iTlO9rG1aDhMfO6s6Sv
	f
X-Google-Smtp-Source: AGHT+IG1d7BUYJJjIshrJ2y3NfS1aiIB0ycuTaQri2CQqjCsvReEGJy5wqPog7xCJ21Qssufj6XbtQ==
X-Received: by 2002:a05:690c:2f88:b0:607:782e:fdf3 with SMTP id ew8-20020a05690c2f8800b00607782efdf3mr757257ywb.23.1707756967263;
        Mon, 12 Feb 2024 08:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXE35dYpWQW2Hux92FhQqdMKLmSqtbBXEB8QdwB3SnjHl8+rLOaJou9vWJ0r5t+kd3qqYoe3xrutWdktO9K3mqebjE=
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x81-20020a817c54000000b00604a5103629sm1241687ywc.76.2024.02.12.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:56:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: fix deadlock with fiemap and extent locking
Date: Mon, 12 Feb 2024 11:56:02 -0500
Message-ID: <49c34d4ede23d28d916eab4a22d4ec698f77f498.1707756893.git.josef@toxicpanda.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Fixed up the various formatting comments.
- Added a comment for the locking.

 fs/btrfs/extent_io.c | 62 ++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8648ea9b5fb5..dfcde1610b0a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2683,16 +2683,34 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 	 * it beyond i_size.
 	 */
 	while (cur_offset < end && cur_offset < i_size) {
+		struct extent_state *cached_state = NULL;
 		u64 delalloc_start;
 		u64 delalloc_end;
 		u64 prealloc_start;
+		u64 lockstart;
+		u64 lockend;
 		u64 prealloc_len = 0;
 		bool delalloc;
 
+		lockstart = round_down(cur_offset, inode->root->fs_info->sectorsize);
+		lockend = round_up(end, inode->root->fs_info->sectorsize);
+
+		/*
+		 * We are only locking for the delalloc range because that's the
+		 * only thing that can change here.  With fiemap we have a lock
+		 * on the inode, so no buffered or direct writes can happen.
+		 *
+		 * However mmaps and normal page writeback will cause this to
+		 * change arbitrarily.  We have to lock the extent lock here to
+		 * make sure that nobody messes with the tree while we're doing
+		 * btrfs_find_delalloc_in_range.
+		 */
+		lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
 							delalloc_cached_state,
 							&delalloc_start,
 							&delalloc_end);
+		unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		if (!delalloc)
 			break;
 
@@ -2860,15 +2878,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
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
+	u64 range_start;
+	u64 range_end;
+	const u64 sectorsize = inode->root->fs_info->sectorsize;
 	bool stopped = false;
 	int ret;
 
@@ -2879,12 +2897,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	lockstart = round_down(start, inode->root->fs_info->sectorsize);
-	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
-	prev_extent_end = lockstart;
+	range_start = round_down(start, sectorsize);
+	range_end = round_up(start + len, sectorsize);
+	prev_extent_end = range_start;
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
@@ -2892,7 +2909,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_release_path(path);
 
 	path->reada = READA_FORWARD;
-	ret = fiemap_search_slot(inode, path, lockstart);
+	ret = fiemap_search_slot(inode, path, range_start);
 	if (ret < 0) {
 		goto out_unlock;
 	} else if (ret > 0) {
@@ -2904,7 +2921,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto check_eof_delalloc;
 	}
 
-	while (prev_extent_end < lockend) {
+	while (prev_extent_end < range_end) {
 		struct extent_buffer *leaf = path->nodes[0];
 		struct btrfs_file_extent_item *ei;
 		struct btrfs_key key;
@@ -2927,19 +2944,19 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		 * The first iteration can leave us at an extent item that ends
 		 * before our range's start. Move to the next item.
 		 */
-		if (extent_end <= lockstart)
+		if (extent_end <= range_start)
 			goto next_item;
 
 		backref_ctx->curr_leaf_bytenr = leaf->start;
 
 		/* We have in implicit hole (NO_HOLES feature enabled). */
 		if (prev_extent_end < key.offset) {
-			const u64 range_end = min(key.offset, lockend) - 1;
+			const u64 hole_end = min(key.offset, range_end) - 1;
 
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  &delalloc_cached_state,
 						  backref_ctx, 0, 0, 0,
-						  prev_extent_end, range_end);
+						  prev_extent_end, hole_end);
 			if (ret < 0) {
 				goto out_unlock;
 			} else if (ret > 0) {
@@ -2949,7 +2966,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			}
 
 			/* We've reached the end of the fiemap range, stop. */
-			if (key.offset >= lockend) {
+			if (key.offset >= range_end) {
 				stopped = true;
 				break;
 			}
@@ -3043,29 +3060,41 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_free_path(path);
 	path = NULL;
 
-	if (!stopped && prev_extent_end < lockend) {
+	if (!stopped && prev_extent_end < range_end) {
 		ret = fiemap_process_hole(inode, fieinfo, &cache,
 					  &delalloc_cached_state, backref_ctx,
-					  0, 0, 0, prev_extent_end, lockend - 1);
+					  0, 0, 0, prev_extent_end, range_end - 1);
 		if (ret < 0)
 			goto out_unlock;
-		prev_extent_end = lockend;
+		prev_extent_end = range_end;
 	}
 
 	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
 		const u64 i_size = i_size_read(&inode->vfs_inode);
 
 		if (prev_extent_end < i_size) {
+			struct extent_state *cached_state = NULL;
 			u64 delalloc_start;
 			u64 delalloc_end;
+			u64 lockstart;
+			u64 lockend;
 			bool delalloc;
 
+			lockstart = round_down(prev_extent_end, sectorsize);
+			lockend = round_up(i_size, sectorsize);
+
+			/*
+			 * See the comment in fiemap_process_hole as to why
+			 * we're doing the locking here.
+			 */
+			lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			delalloc = btrfs_find_delalloc_in_range(inode,
 								prev_extent_end,
 								i_size - 1,
 								&delalloc_cached_state,
 								&delalloc_start,
 								&delalloc_end);
+			unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			if (!delalloc)
 				cache.flags |= FIEMAP_EXTENT_LAST;
 		} else {
@@ -3076,7 +3105,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 
 out_unlock:
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 out:
 	free_extent_state(delalloc_cached_state);
-- 
2.43.0


