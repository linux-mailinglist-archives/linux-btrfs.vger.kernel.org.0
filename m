Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377F122F8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfETI63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 04:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbfETI63 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 04:58:29 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD50204FD
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342708;
        bh=jRHMOsEc0Vqg5geTc3XCGLh67WSoKMwqGwBYQSYMHEY=;
        h=From:To:Subject:Date:From;
        b=W29uJVnk7RFlYBw4eVxtqGZ/HzEGeD3Hqq/rWxkTwJn28cFcwJEB6a33eC8p4QQgi
         gsfqEzgmafnEcyX9XrlkoXqNtARqLGi/sFz3oHAkSNcz2JXGKj43+zOqm0Smr+DJfD
         veHfKKWz2/W+wHqoFLxuWBkNgAURsBeYo3n23wo8=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: incremental send, fix emission of invalid clone operations
Date:   Mon, 20 May 2019 09:57:00 +0100
Message-Id: <20190520085700.29424-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing an incremental send we can now issue clone operations with a
source range that ends at the source's file eof and with a destination
range that ends at an offset smaller then the destination's file eof.
If the eof of the source file is not aligned to the sector size of the
filesystem, the receiver will get a -EINVAL error when trying to do the
operation or, on older kernels, silently corrupt the destination file.
The corruption happens on kernels without commit ac765f83f1397646
("Btrfs: fix data corruption due to cloning of eof block"), while the
failure to clone happens on kernels with that commit.

Example reproducer:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt/sdb

  $ xfs_io -f -c "pwrite -S 0xb1 0 2M" /mnt/sdb/foo
  $ xfs_io -f -c "pwrite -S 0xc7 0 2M" /mnt/sdb/bar
  $ xfs_io -f -c "pwrite -S 0x4d 0 2M" /mnt/sdb/baz
  $ xfs_io -f -c "pwrite -S 0xe2 0 2M" /mnt/sdb/zoo

  $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base

  $ btrfs send -f /tmp/base.send /mnt/sdb/base

  $ xfs_io -c "reflink /mnt/sdb/bar 1560K 500K 100K" /mnt/sdb/bar
  $ xfs_io -c "reflink /mnt/sdb/bar 1560K 0 100K" /mnt/sdb/zoo
  $ xfs_io -c "truncate 550K" /mnt/sdb/bar

  $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr

  $ btrfs send -f /tmp/incr.send -p /mnt/sdb/base /mnt/sdb/incr

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt/sdc

  $ btrfs receive -f /tmp/base.send /mnt/sdc
  $ btrfs receive -vv -f /tmp/incr.send /mnt/sdc
  (...)
  truncate bar size=563200
  utimes bar
  clone zoo - source=bar source offset=512000 offset=0 length=51200
  ERROR: failed to clone extents to zoo
  Invalid argument

The failure happens because the clone source range ends at the eof of file
bar, 563200, which is not aligned to the filesystems sector size (4Kb in
this case), and the destination range ends at offset 0 + 51200, which is
less then the size of the file zoo (2Mb).

So fix this by detecting such case and instead of issuing a clone
operation for the whole range, do a clone operation for smaller range
that is sector size aligned followed by a write operation for the block
containing the eof. Here we will always be pessimistic and assume the
destination filesystem of the send stream has the largest possible sector
size (64Kb), since we have no way of determining it.

This fixes a recent regression introduced in kernel 5.2-rc1.

Fixes: 040ee6120cb6706 ("Btrfs: send, improve clone range")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 1549d0639b57..66db1271a3cb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5224,10 +5224,50 @@ static int clone_range(struct send_ctx *sctx,
 		clone_len = min_t(u64, ext_len, len);
 
 		if (btrfs_file_extent_disk_bytenr(leaf, ei) == disk_byte &&
-		    clone_data_offset == data_offset)
-			ret = send_clone(sctx, offset, clone_len, clone_root);
-		else
+		    clone_data_offset == data_offset) {
+			const u64 src_end = clone_root->offset + clone_len;
+			const u64 sectorsize = SZ_64K;
+
+			/*
+			 * We can't clone the last block, when its size is not
+			 * sector size aligned, into the middle of a file. If we
+			 * do so, the receiver will get a failure (-EINVAL) when
+			 * trying to clone or will silently corrupt the data in
+			 * the destination file if it's on a kernel without the
+			 * fix introduced by commit ac765f83f1397646
+			 * ("Btrfs: fix data corruption due to cloning of eof
+			 * block).
+			 *
+			 * So issue a clone of the aligned down range plus a
+			 * regular write for the eof block, if we hit that case.
+			 *
+			 * Also, we use the maximum possible sector size, 64K,
+			 * because we don't know what's the sector size of the
+			 * filesystem that receives the stream, so we have to
+			 * assume the largest possible sector size.
+			 */
+			if (src_end == clone_src_i_size &&
+			    !IS_ALIGNED(src_end, sectorsize) &&
+			    offset + clone_len < sctx->cur_inode_size) {
+				u64 slen;
+
+				slen = ALIGN_DOWN(src_end - clone_root->offset,
+						  sectorsize);
+				if (slen > 0) {
+					ret = send_clone(sctx, offset, slen,
+							 clone_root);
+					if (ret < 0)
+						goto out;
+				}
+				ret = send_extent_data(sctx, offset + slen,
+						       clone_len - slen);
+			} else {
+				ret = send_clone(sctx, offset, clone_len,
+						 clone_root);
+			}
+		} else {
 			ret = send_extent_data(sctx, offset, clone_len);
+		}
 
 		if (ret < 0)
 			goto out;
-- 
2.11.0

