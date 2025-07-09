Return-Path: <linux-btrfs+bounces-15373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE396AFE33A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C17BA7B7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB39280330;
	Wed,  9 Jul 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6680x5U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122E280305
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051205; cv=none; b=WvflwbYUiQxk0Epm48osrhiHdrfBzdUJTpkkjYja+AGYqDNMURaC85a5wiNGYnReHadBwkDqlwTNoGz81QMrwIEg0Th2lDt8653OHdvu+WVhkJFUEMznp7cTDbWPtfjpQYc/jA6BtTdXRXONLqQJiwuQehnW94uv2kAQI4OtJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051205; c=relaxed/simple;
	bh=/gLo0vHMLddadDXuHhtQ0zEBBIJ+bO1spcYYcFhbuK0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0iwHCUpvlUmrhD5bDPb0pnj6s7fYicjUjuzz5/lYgck9xTJLy4kSlTXvFha+fRIkk7fayt1vi0K18XbWNbVlc9rTasTcakEI88GogFyAmVJQoBaJnueZ9dY25HMyO/umLW99IZjJeaQFb0K4CMGiywtmQ/f4l96Nr25z1hooYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6680x5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089B0C4CEF0
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051204;
	bh=/gLo0vHMLddadDXuHhtQ0zEBBIJ+bO1spcYYcFhbuK0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P6680x5UtG5IMpvIWABydTly2U47tYlblYNNpwY5Q/7chLCaixUFsKRKPd975gHxF
	 YeBTfhyaLWJS8T0liUB5elCHORx+CysSiNfPYivpjfbgkhDv3n1h/7TnNnlNDGCZe2
	 B6VLoPFI9two5PVNnQMazwB0jYHydVgCTdDVGvWHK8AOJ6EAK0GIGTUYo4IuctFZDI
	 AwEh8QHmuJdkJszpgnzSkFN4vAHFZ6OG+pVueC9FuxkYqVUi5ImUGjUoTh+SDeZlZ+
	 cTfE3PbSXHNuQg7MkKzwSXbWJ31XCVWc2yhINJxC1rwzjkyKZbg3tXq5Icd9w8rNaQ
	 HGt50dXvlCc+A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
Date: Wed,  9 Jul 2025 09:53:18 +0100
Message-ID: <91b4d80da9b7938b6f7b0c628a6c0cf896f97061.1752050704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752050704.git.fdmanana@suse.com>
References: <cover.1752050704.git.fdmanana@suse.com>
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

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 05b046c6806f..f08c72dbb530 100644
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
@@ -1861,10 +1862,28 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
+		if (write_bytes < reserved_space)
+			goto out_noreserve;
+
+		only_release_metadata = true;
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
@@ -1906,9 +1925,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		reserved_space = round_up(size - page_start, fs_info->sectorsize);
 		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved, end + 1,
-					fsize - reserved_space, true);
+			if (!only_release_metadata)
+				btrfs_delalloc_release_space(BTRFS_I(inode),
+							     data_reserved, end + 1,
+							     fsize - reserved_space,
+							     true);
 		}
 	}
 
@@ -1945,10 +1966,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
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
@@ -1958,10 +1985,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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


