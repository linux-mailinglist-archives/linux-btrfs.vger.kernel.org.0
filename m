Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020AE125EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 03:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfECBI7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 21:08:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfECBI7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 May 2019 21:08:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA023AF11
        for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2019 01:08:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to prevent NOCOW write falling back to CoW without data reservation
Date:   Fri,  3 May 2019 09:08:52 +0800
Message-Id: <20190503010852.10342-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following command can lead to unexpected data COW:

  #!/bin/bash

  dev=/dev/test/test
  mnt=/mnt/btrfs

  mkfs.btrfs -f $dev -b 1G > /dev/null
  mount $dev $mnt -o nospace_cache

  xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
  xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
  umount $dev

The result extent will be

	item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
		generation 6 type 2 (prealloc)
		prealloc data disk byte 13631488 nr 28672
	item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
		generation 6 type 1 (regular)
		extent data disk byte 13660160 nr 12288 <<< COW
	item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
		generation 6 type 2 (prealloc)
		prealloc data disk byte 13631488 nr 28672

Currently we always reserve space even for NOCOW buffered write, thus
under most case it shouldn't cause anything wrong even we fall back to
COW.

However when we're out of data space, we fall back to skip data space if
we can do NOCOW write.

If such behavior happens under that case, we could hit the following
problems:
- data space bytes_may_use underflow
  This will cause kernel warning.

- ENOSPC at delalloc time
  This will lead to transaction abort and fs forced to RO.

[CAUSE]
This is due to the fact that btrfs can only do extent level share check.

Btrfs can only tell if an extent is shared, no matter if only part of the
extent is shared or not.

So for above script we have:
- fallocate
- buffered write
  If we don't have enough data space, we fall back to NOCOW check.
  At this timming, the extent is not shared, we can skip data
  reservation.
- reflink
  Now part of the large preallocated extent is shared.
- delalloc kicks in
  For the NOCOW range, as the preallocated extent is shared, we need
  to fall back to COW.

[WORKAROUND]
The workaround is to ensure any buffered write in the related extents
(not the reflink source range) get flushed before reflink.

However it's pretty expensive to do a comprehensive check.
In the reproducer, the reflink source is just a part of a larger
preallocated extent, we need to flush all buffered write of that extent
before reflink.
Such backward search can be complex and we may not get much benefit from
it.

So this patch will just try to flush the whole inode before reflink.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
Flushing an inode just because it's a reflink source is definitely
overkilling, but I don't have any better way to handle it.

Any comment on this is welcomed.
---
 fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7755b503b348..8caa0edb6fbf 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 			return ret;
 	}
 
+	/*
+	 * Workaround to make sure NOCOW buffered write reach disk as NOCOW.
+	 *
+	 * Due to the limit of btrfs extent tree design, we can only have
+	 * extent level share view. Any part of an extent is shared then the
+	 * whole extent is shared and any write into that extent needs to fall
+	 * back to COW.
+	 *
+	 * NOCOW buffered write without data space reserved could to lead to
+	 * either data space bytes_may_use underflow (kernel warning) or ENOSPC
+	 * at delalloc time (transaction abort).
+	 *
+	 * Here we take a shortcut by flush the whole inode. We could do better
+	 * by finding all extents in that range and flush the space referring
+	 * all those extents.
+	 * But that's too complex for such corner case.
+	 */
+	filemap_flush(src->i_mapping);
+	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+		     &BTRFS_I(src)->runtime_flags))
+		filemap_flush(src->i_mapping);
+
 	/*
 	 * Lock destination range to serialize with concurrent readpages() and
 	 * source range to serialize with relocation.
-- 
2.21.0

