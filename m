Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B41949B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 22:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgCZVDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 17:03:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZVDm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 17:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 26D0FAE83;
        Thu, 26 Mar 2020 21:03:41 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 9/9] btrfs: unlock extents in ->iomap_end() for DIO reads
Date:   Thu, 26 Mar 2020 16:02:54 -0500
Message-Id: <20200326210254.17647-10-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200326210254.17647-1-rgoldwyn@suse.de>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Simplify the locking and unlocking of extents and unlock the extents in
->iomap_end() instead of endio routine.

This makes sure we do not have locked extents in case of device error.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4ccd2a23b1b4..3e8e91d202d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7241,18 +7241,13 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		unlock_extents = true;
 		/* Recalc len in case the new em is smaller than requested */
 		len = min(len, em->len - (start - em->start));
-	} else if (em->block_start == EXTENT_MAP_HOLE ||
-			test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
-		/* Unlock in case of direct reading from a hole */
-		unlock_extents = true;
-	} else {
+	} else if (start + len < lockend) {
 		/*
 		 * We need to unlock only the end area that we aren't using.
 		 * The rest is going to be unlocked by the endio routine.
 		 */
 		lockstart = start + len;
-		if (lockstart < lockend)
-			unlock_extents = true;
+		unlock_extents = true;
 	}
 
 	if (unlock_extents)
@@ -7299,8 +7294,10 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	struct btrfs_iomap *btrfs_iomap = iomap->private;
 	int ret = 0;
 
-	if (!(flags & IOMAP_WRITE))
+	if (!(flags & IOMAP_WRITE)) {
+		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1);
 		return 0;
+	}
 
 	if (btrfs_iomap->submitted_bytes < length) {
 		__endio_write_update_ordered(inode,
@@ -7661,10 +7658,7 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	if (dip->flags & BTRFS_DIO_ORIG_BIO_SUBMITTED)
 		err = btrfs_subio_endio_read(inode, io_bio, err);
 
-	unlock_extent(&BTRFS_I(inode)->io_tree, dip->logical_offset,
-		      dip->logical_offset + dip->bytes - 1);
 	dio_bio = dip->dio_bio;
-
 	kfree(dip);
 
 	btrfs_io_bio_free_csum(io_bio);
-- 
2.25.0

