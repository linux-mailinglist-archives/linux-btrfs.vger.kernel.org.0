Return-Path: <linux-btrfs+bounces-15388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EECAFE80A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A73BF446
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E32D8368;
	Wed,  9 Jul 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i377L951"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EED2D9793
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061546; cv=none; b=QbZe41sDlrNXIFD2Nz4gRUB+Iop2a4rTS/SHwHCjiQxuGv7JlfLeUUu0BEFCefj+UoGVzCkE+Vo4EI1MZnpeveCG6fnb/xL1I4AAr4+qM7EZNf5cpES704QpEclKdB807W1HARlTMSRRAJ4x1fqXiPFOT5XGhsKsKJmQttjtuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061546; c=relaxed/simple;
	bh=adDKmrXWLC7LxC0zQ4sg8sWLY3Ftt/bXFkoEzlx5y5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3hTwt6Ci0VSSVGV+6qal59PO1cF9b4toPIRLomJrAIxEPGuyvwsoHP3c0Ns29ONtCy6DJ5QFUVliLBANn5L3KfJn6PTcTni+Q+nkxd1PPHeUTNAqd5OYAiIUwsE2A9w/YYMhmTrBZByK0ODkK2ycPUkJ595CnzqNwrmc4JhzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i377L951; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C3FC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061545;
	bh=adDKmrXWLC7LxC0zQ4sg8sWLY3Ftt/bXFkoEzlx5y5A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i377L951hHmIx7HNGGg57ovqqPTM0CFIxqgwAaaswRbECk5Hz07EmGI+y83xdD5fR
	 ZCaDB+MN+u0efISsMHsR0YaquVP+IkCT59vYnKxq1Pt7gm5PIocKARDboEfgtm8Mvh
	 Y3QLUktvCORO1cIu1UrufJD/WxqmwMqmPBwNxEkbYz3lsu/9hy0KFjkwoVhOB5tsvR
	 dxxtpqGpFULURzGlMAC6TFmZxSmqnVL2yl51HZu7/GS4fh1QDJhyMRAlKndacihKMV
	 Yfwqo0CMYP1XmZYnCCQpkyE5r+rNhED3VwOqAQpSzxWvUO3hFbdMEJLJKQUTl2Zcat
	 yF8jGfnn17anA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
Date: Wed,  9 Jul 2025 12:45:39 +0100
Message-ID: <20aebb0c3603bea37273a13afebecab28ec74157.1752061083.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752061083.git.fdmanana@suse.com>
References: <cover.1752061083.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

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
---
 fs/btrfs/file.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 05b046c6806f..cb07274d4126 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1841,6 +1841,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	loff_t size;
 	size_t fsize = folio_size(folio);
 	int ret;
+	bool only_release_metadata = false;
 	u64 reserved_space;
 	u64 page_start;
 	u64 page_end;
@@ -1861,10 +1862,34 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
@@ -1905,10 +1930,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
 
@@ -1945,10 +1976,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
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
@@ -1958,10 +1995,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
2.47.2


