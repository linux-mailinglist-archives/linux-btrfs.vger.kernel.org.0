Return-Path: <linux-btrfs+bounces-15384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F0AFE76C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9250A5A208D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0273295501;
	Wed,  9 Jul 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXPAjfhN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F52951D4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059639; cv=none; b=PO8cS5gIdm/e8l1kPWJdTEJl9cBonzgV1MvRbMHx9OTafWO5mXEvU18uxp2M0zU/ud8u5syBCVdGcwuB9us6Vd8uWAWCVDVJbAs7WNii3QAoKqMvdn2kAulr0lUmpfjVf3UjoKgtjxFCL7UFOiQUxzWHbCNFP4D5xxKBWcfq58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059639; c=relaxed/simple;
	bh=9G56cmYtbaugoPdeutaGXULWA1TqubAeq6EQjqfhYwU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm9YQfKbFIrHY0TMauFpAVqYlssbL8Pbp8oIf2QSXDRIh2A3JHHi/xz4ix3DwNL/lroNlIIdhLXBdjXx2Utlim7toOuejxlHzApT/mmdXaUBGqSl4XoIzhzl3CFcNiaFMwzQ9heYXtx2rdt9bWqxiTbuYrpGEvVPsbz3ZC+0gTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXPAjfhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910CC4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752059638;
	bh=9G56cmYtbaugoPdeutaGXULWA1TqubAeq6EQjqfhYwU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MXPAjfhNfM7vX4ZXq/j3VILOzpifrref/mTkzqOtjomtngE4h3zWfkahQDFdx4r+d
	 OFOwe72nsjBxiFAjbRIiCa8AF8UcXGa6Uj5ybXL2/n05eRgN3L8brPKoJY3fjw2wXt
	 B8Z1luHf2/EBn7CEAA9Lcru+yn2ygC8BzYDBlqe0PhrpPM+NZbX/WxUOajK58x5a6K
	 s+gpp89K6Zrdh2YT1RAOzVtZwpe3vgFeia7nSVmf/7iDBy8D0TaKJl+ReuryNCQBDe
	 kJr1UQpFkOCwXiaFA+8phoGqlrGltJuOjDMog8w8qEhRxPiaK8X2vsdLgaLTUjPTSU
	 vxIdHoXxLGmFg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
Date: Wed,  9 Jul 2025 12:13:51 +0100
Message-ID: <b4f268f22d166e1c794d3a1dfb6f98d0ab6ea06d.1752058855.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752058855.git.fdmanana@suse.com>
References: <cover.1752058855.git.fdmanana@suse.com>
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
 fs/btrfs/file.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 05b046c6806f..9ea3b4d47f81 100644
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
@@ -1906,9 +1931,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
 
@@ -1945,10 +1972,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
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
@@ -1958,10 +1991,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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


