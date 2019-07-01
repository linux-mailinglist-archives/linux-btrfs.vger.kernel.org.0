Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89A11763C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEHKuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 06:50:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:35704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfEHKuG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 May 2019 06:50:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B621AE4B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2019 10:50:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: Flush before reflinking any extent to prevent NOCOW write falling back to CoW without data reservation
Date:   Wed,  8 May 2019 18:49:58 +0800
Message-Id: <20190508104958.18363-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script can cause unexpected fsync failure:

  #!/bin/bash

  dev=/dev/test/test
  mnt=/mnt/btrfs

  mkfs.btrfs -f $dev -b 512M > /dev/null
  mount $dev $mnt -o nospace_cache

  # Prealloc one extent
  xfs_io -f -c "falloc 8k 64m" $mnt/file1
  # Fill the remaining data space
  xfs_io -f -c "pwrite 0 -b 4k 512M" $mnt/padding
  sync

  # Write into the prealloc extent
  xfs_io -c "pwrite 1m 16m" $mnt/file1

  # Reflink then fsync, fsync would fail due to ENOSPC
  xfs_io -c "reflink $mnt/file1 8k 0 4k" -c "fsync" $mnt/file1
  umount $dev

The fsync fails with ENOSPC, and the last page of the buffered write is
lost.

[CAUSE]
This is caused by:
- Btrfs' back reference only has extent level granularity
  So write into shared extent must be CoWed even only part of the extent
  is shared.

So for above script we have:
- fallocate
  Create a preallocated extent where we can do NOCOW write.

- fill all the remaining data and unallocated space

- buffered write into preallocated space
  As we have not enough space available for data and the extent is not
  shared (yet) we fall into NOCOW mode.

- reflink
  Now part of the large preallocated extent is shared, later write
  into that extent must be CoWed.

- fsync triggers writeback
  But now the extent is shared and therefore we must fallback into COW
  mode, which fails with ENOSPC since there's not enough space to
  allocate data extents.

[WORKAROUND]
The workaround is to ensure any buffered write in the related extents
(not just the reflink source range) get flushed before reflink/dedupe,
so that NOCOW writes succeed that happened before reflinking succeed.

The workaround is expensive, we could do it better by only flushing
NOCOW range, but that needs extra accounting for NOCOW range.
For now, fix the possible data loss first.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog:
RFC->v1:
- Use better words for commit message and comment.
- Move the whole inode flushing to btrfs_remap_file_range_prep().
  This also covers dedupe.
- Update the reproducer to fail explicitly.
- Remove false statement on transaction abort.

v1->v2:
- Extra comment and commit message refine.
- Don't wait ordered extent, only flush (starts delalloc)
  Single filemap_flush() should be enough. The async extent part will
  never be NOCOWed, thus no need to worry.
---
 fs/btrfs/ioctl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6dafa857bbb9..0e35bef2ec59 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4001,6 +4001,27 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (!same_inode)
 		inode_dio_wait(inode_out);
 
+	/*
+	 * Workaround to make sure NOCOW buffered write reach disk as NOCOW.
+	 *
+	 * Btrfs' back references do not have a block level granularity, they
+	 * work at the whole extent level.
+	 * NOCOW buffered write without data space reserved may not be able
+	 * to fall back to CoW due to lack of data space, thus could cause
+	 * data loss.
+	 *
+	 * Here we take a shortcut by flushing the whole inode, so that all
+	 * nocow write should reach disk as nocow before we increase the
+	 * reference of the extent. We could do better by only flushing NOCOW
+	 * data, but that needs extra accounting.
+	 *
+	 * Also we don't need to check ASYNC_EXTENT, as async extent will be
+	 * CoWed anyway, not affecting nocow part.
+	 */
+	ret = filemap_flush(inode_in->i_mapping);
+	if (ret < 0)
+		return ret;
+
 	ret = btrfs_wait_ordered_range(inode_in, ALIGN_DOWN(pos_in, bs),
 				       wb_len);
 	if (ret < 0)
-- 
2.21.0

