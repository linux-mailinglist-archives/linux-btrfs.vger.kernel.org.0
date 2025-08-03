Return-Path: <linux-btrfs+bounces-15817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58777B19588
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 23:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C2118935ED
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 21:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A32153EA;
	Sun,  3 Aug 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxWNObGC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993251FC0F0;
	Sun,  3 Aug 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754255882; cv=none; b=H9zL3dexc4zrKbQ44IeF4ObxiqOF2WA3qkt0y1HmMfT36IRoq8MexvQ7UL16huKXa4JixvIf9v/RGdbOLJp56QCs2iJanyi1CLvV4pjEtrzkymnOv8dFYrahN42MUwcpgv1Iej1o19xDTzz80OLcmiA2bML0w3w14mcsz+VP4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754255882; c=relaxed/simple;
	bh=zO1SJIgsdDjXqsBmIcmGPU93WITEO7f49l+qJhB1O8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXb7KrkCw7olwRXcp25X/U9BpaOQ2zFnaCGnTIlL5Dwdrr1q4TzxIlFDa33uS+wZ5h1io7LUTphH026hp+o1NwZi5IY8tCcqFOsZOHq2SiNKrCkmnalu9u+DyUJm6Uqc72xIaSOvq2upKfFJrbQ4/y2uAJOwS6nR6gURB1MPiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxWNObGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651D1C4CEEB;
	Sun,  3 Aug 2025 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754255882;
	bh=zO1SJIgsdDjXqsBmIcmGPU93WITEO7f49l+qJhB1O8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxWNObGCWVYXO8WFt2q0pwAuZypozEdF88diPuA5tN58Rd+FcfxA0eKs997a5QUOV
	 MGIOanezeoBBu5xAFxcolEFl8+XsviWMzSi/NgOfFPLLINVGPG6gPeGmu2/iHVTY9z
	 ViNjbTyNUiI46GqUoLJ275UcgvFRgqY7NX5Nk1wRrz1ZFcCPSwPtjI6YS+rDOW0ixa
	 BRpfTfLd6keSXh+m3G7iuMnYL8QcS/ufwLYqQ6urbB46j06lzHa0POn6pDxcHHpmLT
	 r6HN7IdZMKoStcrONjziGp66T3aEJDkl7ZZePfaiqawQYQymib30HT5QTGDIQ9C9eb
	 GuFAAmvmTsFzQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 10/35] btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
Date: Sun,  3 Aug 2025 17:17:10 -0400
Message-Id: <20250803211736.3545028-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803211736.3545028-1-sashal@kernel.org>
References: <20250803211736.3545028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 6599716de2d68ab7b3c0429221deca306dbda878 ]

If we attempt a mmap write into a NOCOW file or a prealloc extent when
there is no more available data space (or unallocated space to allocate a
new data block group) and we can do a NOCOW write (there are no reflinks
for the target extent or snapshots), we always fail due to -ENOSPC, unlike
for the regular buffered write and direct IO paths where we check that we
can do a NOCOW write in case we can't reserve data space.

Simple reproducer:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  umount $DEV &> /dev/null
  mkfs.btrfs -f -b $((512 * 1024 * 1024)) $DEV
  mount $DEV $MNT

  touch $MNT/foobar
  # Make it a NOCOW file.
  chattr +C $MNT/foobar

  # Add initial data to file.
  xfs_io -c "pwrite -S 0xab 0 1M" $MNT/foobar

  # Fill all the remaining data space and unallocated space with data.
  dd if=/dev/zero of=$MNT/filler bs=4K &> /dev/null

  # Overwrite the file with a mmap write. Should succeed.
  xfs_io -c "mmap -w 0 1M"        \
         -c "mwrite -S 0xcd 0 1M" \
         -c "munmap"              \
         $MNT/foobar

  # Unmount, mount again and verify the new data was persisted.
  umount $MNT
  mount $DEV $MNT

  od -A d -t x1 $MNT/foobar

  umount $MNT

Running this:

  $ ./test.sh
  (...)
  wrote 1048576/1048576 bytes at offset 0
  1 MiB, 256 ops; 0.0008 sec (1.188 GiB/sec and 311435.5231 ops/sec)
  ./test.sh: line 24: 234865 Bus error               xfs_io -c "mmap -w 0 1M" -c "mwrite -S 0xcd 0 1M" -c "munmap" $MNT/foobar
  0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
  *
  1048576

Fix this by not failing in case we can't allocate data space and we can
NOCOW into the target extent - reserving only metadata space in this case.

After this change the test passes:

  $ ./test.sh
  (...)
  wrote 1048576/1048576 bytes at offset 0
  1 MiB, 256 ops; 0.0007 sec (1.262 GiB/sec and 330749.3540 ops/sec)
  0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
  *
  1048576

A test case for fstests will be added soon.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of this commit, here is my determination:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real user-visible bug**: The commit fixes a clear
   functional regression where mmap writes to NOCOW files fail with
   -ENOSPC even when they shouldn't. The bug causes legitimate write
   operations to fail when the filesystem is nearly full, even though
   NOCOW writes should succeed without requiring new data space
   allocation.

2. **Contains a simple reproducer**: The commit message includes a clear
   test case that demonstrates the problem, showing it's a reproducible
   issue that users can encounter in normal usage scenarios.

3. **Limited scope and risk**: The fix is confined to the
   `btrfs_page_mkwrite()` function in fs/btrfs/file.c. It doesn't touch
   multiple subsystems or introduce architectural changes. The
   modification follows the same pattern already used in buffered write
   and direct IO paths.

4. **Follows existing patterns**: The fix applies the same NOCOW
   handling logic that already exists for regular buffered writes and
   direct IO. It's essentially fixing an inconsistency where mmap writes
   didn't have the same NOCOW fallback logic.

5. **Clear fix with minimal changes**: The patch adds proper NOCOW
   checking when data space reservation fails, similar to what's done in
   other write paths. It uses existing functions like
   `btrfs_check_nocow_lock()` and `btrfs_check_nocow_unlock()`.

6. **No new features**: This is purely a bug fix that restores expected
   behavior. It doesn't add any new functionality or APIs.


The code changes show a straightforward fix that:
- Adds `only_release_metadata` flag to track NOCOW write scenarios
- When data space reservation fails, checks if NOCOW write is possible
- If NOCOW is possible, only reserves metadata space instead of failing
- Properly releases resources in error paths based on whether it's a
  NOCOW operation

This is exactly the type of bug fix that stable kernels should receive -
it fixes a specific functional problem without introducing new risks or
complexity.

 fs/btrfs/file.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8ce6f45f45e0..0a468bbfe015 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1842,6 +1842,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	loff_t size;
 	size_t fsize = folio_size(folio);
 	int ret;
+	bool only_release_metadata = false;
 	u64 reserved_space;
 	u64 page_start;
 	u64 page_end;
@@ -1862,10 +1863,34 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * end up waiting indefinitely to get a lock on the page currently
 	 * being processed by btrfs_page_mkwrite() function.
 	 */
-	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
-					   page_start, reserved_space);
-	if (ret < 0)
+	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved,
+					  page_start, reserved_space, false);
+	if (ret < 0) {
+		size_t write_bytes = reserved_space;
+
+		if (btrfs_check_nocow_lock(BTRFS_I(inode), page_start,
+					   &write_bytes, false) <= 0)
+			goto out_noreserve;
+
+		only_release_metadata = true;
+
+		/*
+		 * Can't write the whole range, there may be shared extents or
+		 * holes in the range, bail out with @only_release_metadata set
+		 * to true so that we unlock the nocow lock before returning the
+		 * error.
+		 */
+		if (write_bytes < reserved_space)
+			goto out_noreserve;
+	}
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), reserved_space,
+					      reserved_space, false);
+	if (ret < 0) {
+		if (!only_release_metadata)
+			btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
+						       page_start, reserved_space);
 		goto out_noreserve;
+	}
 
 	ret = file_update_time(vmf->vma->vm_file);
 	if (ret < 0)
@@ -1906,10 +1931,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	if (folio_contains(folio, (size - 1) >> PAGE_SHIFT)) {
 		reserved_space = round_up(size - page_start, fs_info->sectorsize);
 		if (reserved_space < fsize) {
+			const u64 to_free = fsize - reserved_space;
+
 			end = page_start + reserved_space - 1;
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved, end + 1,
-					fsize - reserved_space, true);
+			if (only_release_metadata)
+				btrfs_delalloc_release_metadata(BTRFS_I(inode),
+								to_free, true);
+			else
+				btrfs_delalloc_release_space(BTRFS_I(inode),
+							     data_reserved, end + 1,
+							     to_free, true);
 		}
 	}
 
@@ -1946,10 +1977,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
+	if (only_release_metadata)
+		btrfs_set_extent_bit(io_tree, page_start, end, EXTENT_NORESERVE,
+				     &cached_state);
+
 	btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
+	if (only_release_metadata)
+		btrfs_check_nocow_unlock(BTRFS_I(inode));
 	sb_end_pagefault(inode->i_sb);
 	extent_changeset_free(data_reserved);
 	return VM_FAULT_LOCKED;
@@ -1959,10 +1996,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 out:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
-	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
-				     reserved_space, true);
+	if (only_release_metadata)
+		btrfs_delalloc_release_metadata(BTRFS_I(inode), reserved_space, true);
+	else
+		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
+					     page_start, reserved_space, true);
 	extent_changeset_free(data_reserved);
 out_noreserve:
+	if (only_release_metadata)
+		btrfs_check_nocow_unlock(BTRFS_I(inode));
+
 	sb_end_pagefault(inode->i_sb);
 
 	if (ret < 0)
-- 
2.39.5


