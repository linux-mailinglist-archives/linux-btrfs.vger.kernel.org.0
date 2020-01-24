Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869C41484B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 12:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgAXLwJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 06:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgAXLwJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 06:52:09 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F89206D5
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579866728;
        bh=qsH4c0XsMTo793oQcmZKGvJHs6+jJWPDqCSlwXIAROM=;
        h=From:To:Subject:Date:From;
        b=mHSceWReOTaKfZMpK0lWGU1v1CTFDRL5uGjvJHV9T+244/+9omrD1U4f/JGLaVIht
         ZyMjRei4W8PTcu0HoWJZOM/yxwKfem42yQwc1ebyInJeEGJk65uVV5wH3MtPe8DD7Z
         PNRiL3f5fcXGkTxtwmFtYTEOOfU2l1WE/MkGrAHE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: send, fix emission of invalid clone operations within the same file
Date:   Fri, 24 Jan 2020 11:52:04 +0000
Message-Id: <20200124115204.4086-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing an incremental send and a file has extents shared with itself
at different file offsets, it's possible for send to emit clone operations
that will fail at the destination because the source range goes beyond the
file's current size. This happens when the file size has increased in the
send snapshot, there is a hole between the shared extents and both shared
extents are at file offsets which are greater the file's size in the
parent snapshot.

Example:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt/sdb

  $ xfs_io -f -c "pwrite -S 0xf1 0 64K" /mnt/sdb/foobar
  $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base
  $ btrfs send -f /tmp/1.snap /mnt/sdb/base

  # Create a 320K extent at file offset 512K.
  $ xfs_io -c "pwrite -S 0xab 512K 64K" /mnt/sdb/foobar
  $ xfs_io -c "pwrite -S 0xcd 576K 64K" /mnt/sdb/foobar
  $ xfs_io -c "pwrite -S 0xef 640K 64K" /mnt/sdb/foobar
  $ xfs_io -c "pwrite -S 0x64 704K 64K" /mnt/sdb/foobar
  $ xfs_io -c "pwrite -S 0x73 768K 64K" /mnt/sdb/foobar

  # Clone part of that 320K extent into a lower file offset (192K).
  # This file offset is greater than the file's size in the parent
  # snapshot (64K). Also the clone range is a bit behind the offset of
  # the 320K extent so that we leave a hole between the shared extents.
  $ xfs_io -c "reflink /mnt/sdb/foobar 448K 192K 192K" /mnt/sdb/foobar

  $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr
  $ btrfs send -p /mnt/sdb/base -f /tmp/2.snap /mnt/sdb/incr

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt/sdc

  $ btrfs receive -f /tmp/1.snap /mnt/sdc
  $ btrfs receive -f /tmp/2.snap /mnt/sdc
  ERROR: failed to clone extents to foobar: Invalid argument

The problem is that after processing the extent at file offset 192K, send
does not issue a write operation full of zeroes for the hole between that
extent and the extent starting at file offset 520K (hole range from 384K
to 512K), this is because the hole is at an offset larger the size of the
file in the parent snapshot (384K > 64K). As a consequence the field
'cur_inode_next_write_offset' of the send context remains with a value of
384K when we start to process the extent at file offset 512K, which is the
value set after processing the extent at offset 192K.

This screws up the lookup of possible extents to clone because due to an
incorrect value of 'cur_inode_next_write_offset' we can now consider
extents for cloning, in the same inode, that lie beyond the current size
of the file in the receiver of the send stream. Also, when checking if
an extent in the same file can be used for cloning, we must also check
that not only its start offset doesn't start at or beyond the current eof
of the file in the receiver but that the source range doesn't go beyond
current eof, that is we must check offset + length does not cross the
current eof, as that makes clone operations fail with -EINVAL.

So fix this by updating 'cur_inode_next_write_offset' whenever we start
processing an extent and checking an extent's offset and length when
considering it for cloning operations.

A test case for fstests follows soon.

Fixes: 11f2069c113e02 ("Btrfs: send, allow clone operations within the same file")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 091e5bc8c7ea..0b42dac8a35f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1269,7 +1269,8 @@ static int __iterate_backrefs(u64 ino, u64 offset, u64 root, void *ctx_)
 		 * destination of the stream.
 		 */
 		if (ino == bctx->cur_objectid &&
-		    offset >= bctx->sctx->cur_inode_next_write_offset)
+		    offset + bctx->extent_len >
+		    bctx->sctx->cur_inode_next_write_offset)
 			return 0;
 	}
 
@@ -5804,6 +5805,18 @@ static int process_extent(struct send_ctx *sctx,
 		}
 	}
 
+	/*
+	 * There might be a hole between the end of the last processed extent
+	 * and this extent, and we may have not sent a write operation for that
+	 * hole because it was not needed (range is beyond eof in the parent
+	 * snapshot). So adjust the next write offset to the offset of this
+	 * extent, as we want to make sure we don't do mistakes when checking if
+	 * we can clone this extent from some other offset in this inode or when
+	 * detecting if we need to issue a truncate operation when finishing the
+	 * processing this inode.
+	 */
+	sctx->cur_inode_next_write_offset = key->offset;
+
 	ret = find_extent_clone(sctx, path, key->objectid, key->offset,
 			sctx->cur_inode_size, &found_clone);
 	if (ret != -ENOENT && ret < 0)
-- 
2.11.0

