Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C862732A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIUTTf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 15:19:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgIUTTf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 15:19:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D055BAC3F
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 19:20:09 +0000 (UTC)
Date:   Mon, 21 Sep 2020 14:19:30 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Increment i_size after dio write completes
Message-ID: <20200921191930.e7phg6zpw4v4snin@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

i_size is incremented when btrfs creates new extents during the start of
a DIO write. If there is a failure until the endio, we will have a file
with incremented filesize but no data. Increment the filesize after the
successful completion of a DIO write.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 18d171b2d544..0f297e9679eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7309,13 +7309,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	len = min(len, em->len - (start - em->start));
 
 skip_cow:
-	/*
-	 * Need to update the i_size under the extent lock so buffered
-	 * readers will get the updated i_size when we unlock.
-	 */
-	if (start + len > i_size_read(inode))
-		i_size_write(inode, start + len);
-
 	dio_data->reserve -= len;
 out:
 	return ret;
@@ -7542,10 +7535,16 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 		return;
 
 	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
-		__endio_write_update_ordered(BTRFS_I(dip->inode),
-					     dip->logical_offset,
-					     dip->bytes,
-					     !dip->dio_bio->bi_status);
+		u64 offset = dip->logical_offset;
+		u64 length = dip->bytes;
+		bool uptodate = !dip->dio_bio->bi_status;
+
+		/* Increment the filesize iff the DIO write is successful */
+		if (uptodate && i_size_read(dip->inode) < offset + length)
+			i_size_write(dip->inode, offset + length);
+
+		__endio_write_update_ordered(BTRFS_I(dip->inode), offset,
+				length, uptodate);
 	} else {
 		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
 			      dip->logical_offset,

-- 
Goldwyn
