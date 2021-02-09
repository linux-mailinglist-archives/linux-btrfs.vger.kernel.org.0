Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6031588E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhBIVYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:24:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:51922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhBIUyV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 15:54:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 753BEB14C;
        Tue,  9 Feb 2021 20:31:23 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH RFC 3/6] btrfs: Add stripe_physical function
Date:   Tue,  9 Feb 2021 21:30:37 +0100
Message-Id: <20210209203041.21493-4-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209203041.21493-1-mrostecki@suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

Move the calculation of the physical address for a stripe to the new
function - stripe_physical(). It can be used by raid1 read policies to
calculate the offset and select mirrors based on I/O locality.

Signed-off-by: Michal Rostecki <mrostecki@suse.com>
---
 fs/btrfs/volumes.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 292175206873..1ac364a2f105 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5498,6 +5498,23 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+/*
+ * Calculates the physical location for the given stripe and I/O geometry.
+ *
+ * @map:           mapping containing the logical extent
+ * @stripe_index:  index of the stripe to make a calculation for
+ * @stripe_offset: offset of the block in its stripe
+ * @stripe_nr:     index of the stripe whete the block falls in
+ *
+ * Returns the physical location.
+ */
+static u64 stripe_physical(struct map_lookup *map, u32 stripe_index,
+			   u64 stripe_offset, u64 stripe_nr)
+{
+	return map->stripes[stripe_index].physical + stripe_offset +
+		stripe_nr * map->stripe_len;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -6216,8 +6233,9 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		bbio->stripes[i].physical = map->stripes[stripe_index].physical +
-			stripe_offset + stripe_nr * map->stripe_len;
+		bbio->stripes[i].physical = stripe_physical(map, stripe_index,
+							    stripe_offset,
+							    stripe_nr);
 		bbio->stripes[i].dev = map->stripes[stripe_index].dev;
 		stripe_index++;
 	}
-- 
2.30.0

