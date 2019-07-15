Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D723D68A4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfGONQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 09:16:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730012AbfGONQS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 09:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4247AF7E
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 13:16:17 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] btrfs: don't leak extent_map in btrfs_get_io_geometry()
Date:   Mon, 15 Jul 2019 15:16:12 +0200
Message-Id: <20190715131612.14040-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_get_io_geometry() calls btrfs_get_chunk_map() to acquire a reference
on a extent_map, but on normal operation it does not drop this reference
anymore.

This leads to excessive kmemleak reports.

Always call free_extent_map(), not just in the error case.

Fixes: 5f1411265e16 ("btrfs: Introduce btrfs_io_geometry infrastructure")
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a13ddba1ebc3..d74b74ca07af 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5941,6 +5941,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	u64 stripe_len;
 	u64 raid56_full_stripe_start = (u64)-1;
 	int data_stripes;
+	int ret = 0;
 
 	ASSERT(op != BTRFS_MAP_DISCARD);
 
@@ -5961,8 +5962,8 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		btrfs_crit(fs_info,
 "stripe math has gone wrong, stripe_offset=%llu offset=%llu start=%llu logical=%llu stripe_len=%llu",
 			stripe_offset, offset, em->start, logical, stripe_len);
-		free_extent_map(em);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* stripe_offset is the offset of this block in its stripe */
@@ -6009,7 +6010,10 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	io_geom->stripe_offset = stripe_offset;
 	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
 
-	return 0;
+out:
+	/* once for us */
+	free_extent_map(em);
+	return ret;
 }
 
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-- 
2.16.4

