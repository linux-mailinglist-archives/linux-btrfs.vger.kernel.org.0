Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD2314CF52
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgA2RJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 12:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgA2RJ5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 12:09:57 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC99206F0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580317796;
        bh=+XrxArOMAHADrLo8smWuYhr0tMMcrcE+SoppvnPmR9I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SOPaPekNJLjfurQ75MTf5UvnWcd2DRM0+Eqvy+PMYjAF1n4NFEDoCn7G+nKw6ClRE
         ab5XdbPlyf+RwcgGr5Y4MPPY3jK+qN43tsEq7NfE8UrIbJfl1aeMnxdy5V+zbaNzoM
         GpTOxmLMwdncYB+QTDWyAi67DX71iu6WLHnp6i1M=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] Btrfs: send, fix emission of invalid clone operations within the same file
Date:   Wed, 29 Jan 2020 17:09:53 +0000
Message-Id: <20200129170953.13945-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124115204.4086-1-fdmanana@kernel.org>
References: <20200124115204.4086-1-fdmanana@kernel.org>
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

The problem is that after processing the extent at file offset 256K, which
refers to the first 128K of the 320K extent created by the buffered write
operations, we have 'cur_inode_next_write_offset' set to 384K, which
corresponds to the end offset of the partially shared extent (256K + 128K)
and to the current file size in the receiver. Then when we process the
extent at offset 512K, we do extent backreference iteration to figure out
if we can clone the extent from some other inode or from the same inode,
and we consider the extent at offset 256K of the same inode as a valid
source for a clone operation, which is not correct because at that point
the current file size in the receiver is 384K, which corresponds to the
end of last processed extent (at file offset 256K), so using a clone
source range from 256K to 256K + 320K is invalid because that goes past
the current size of the file (384K) - this makes the receiver get an
-EINVAL error when attempting the clone operation.

So fix this by excluding clone sources that have a range that goes beyond
the current file size in the receiver when iterating extent backreferences.

A test case for fstests follows soon.

Fixes: 11f2069c113e02 ("Btrfs: send, allow clone operations within the same file")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

v2: Removed unncessary hunk, which sey sctx->cur_inode_next_write_offset, not
    because it's not necessary to fix this issue, but also caused problems
    for files that got a prealloc extents beyond their size in the send
    snapshot, got their size increased and have a trailing hole (ending at
    the new file size).

 fs/btrfs/send.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 091e5bc8c7ea..a055b657cb85 100644
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
 
-- 
2.11.0

