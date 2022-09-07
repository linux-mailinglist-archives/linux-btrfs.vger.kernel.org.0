Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C435B074F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 16:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIGOoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGOnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 10:43:52 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059F98A7D9
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662561830; x=1694097830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EUQ6y/wB554nlEJglIX44NAecHINnVjkz24AIdxFng0=;
  b=b9qKCCR9Wi8379hxRMVgSGR8zHhfQEqcakTg9QMreWQwn6imjGT69Ntz
   R+ZVBHTnpIUpWpfErz2GWpYdB6y+OJkwgSux1PNRF6c0kuBzRQPwsEJX3
   KbzauIq0ahC/2jR3IG1M9/3scHS2Qz85ET5rCnY7nI2oJhuzyRaDUhZsl
   D8hxKi2M27o8F7L4KSzQ67KLkjmxq3A0eikduzM23AKH+ACGHUgddLjKP
   VIY4H8rB6jW8jrBOhdpxegDBBAGpB1z7KFjhWnu8HGj+A4EKi2tepsZqZ
   ThhDRk+E6D8zGMB4fVqjPT46v4UN3BbOn8umYJUv7pnbEzwN5htLWWl3x
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654531200"; 
   d="scan'208";a="209163334"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2022 22:43:49 +0800
IronPort-SDR: zilbuS6wd96IBdXkX3UsZvHuZD4FmzksIJ2jOSe8eLEz4P66EpRWvHyeaQVbDPEBub0hI92ohW
 en6ZA5J5105iQwi03trN3smUfaOGtjJwn01kCAkh8EDjL6gXr/b68et4sYjc0VX4tGVaAs9TRF
 z42KZXC6NaFn0ZOssoS3Ry5u2gXYfYOXCHoTESC9ekErNHI5sbcBlePf6S10ROT3PfWeQkdaku
 OoTH3CIGYZBkBS7BnlTmv0U6pKQlIasjZHL0PqgPgCKbx1X1bVeo4//HJw7NSe1ZGdOyno8IJR
 TPzFTquNJOz+yQju+2laPzWU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2022 07:04:10 -0700
IronPort-SDR: kA1FfjMjntYZQCfmH8il0BzjMHvpufp19oSK3Zk0eoo/BemB1Y6+iSEAFC94h9l2bH/OdTJOgh
 Hj5z5HCRMuOnOqQ0NUR8pza3KGKPNK4EHI3UErHdqSsvHypH9zFi2VfE96rs9X2yy+5/s7QNAz
 rnmwIRJKxHrJHGd7xJluHWXIyMe3xNmkavWnqxfsDriwWcWxwrj/RJVyliUMGsvL4MhPlz1dXH
 JR3e/IMohpiAqAS8nQEUEY+47S75EegNzbwS8+LPPC+4hVPsCRqTCHUziH4xRF0R0KaZxYf3RF
 RPY=
WDCIronportException: Internal
Received: from 4f6fp13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.210])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Sep 2022 07:43:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: wait extent buffer IOs before finishing a zone
Date:   Wed,  7 Sep 2022 23:43:38 +0900
Message-Id: <6ea8d3e9d0165f6ff37a1d12aad93ba279acfd93.1662561769.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before sending REQ_OP_ZONE_FINISH to a zone, we need to ensure that ongoing
IOs already finished. Or, we will see a "Zone Is Full" error for the IOs,
as the ZONE_FINISH command makes the zone full.

We ensure that with btrfs_wait_block_group_reservations() and
btrfs_wait_ordered_roots() for a data block group. And, for a metadata
block group, the comparison of alloc_offset vs meta_write_pointer mostly
ensures IOs for the allocated region already sent. However, there still can
be a little time-frame where the IOs are sent but not yet completed.

Introduce wait_eb_writebacks() to ensure such IOs are completed for a
metadata block group. It walks the buffer_radix to find extent buffers in
the block group and wait_on_extent_buffer_writeback() on them.

Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
CC: stable@vger.kernel.org # 5.19+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e12c0ca509fb..c8315fe16214 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1921,10 +1921,44 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	return ret;
 }
 
+static void wait_eb_writebacks(struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	const u64 end = block_group->start + block_group->length;
+	struct radix_tree_iter iter;
+	struct extent_buffer *eb;
+	void **slot;
+
+	rcu_read_lock();
+	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
+				 block_group->start >> fs_info->sectorsize_bits) {
+		eb = radix_tree_deref_slot(slot);
+		if (!eb)
+			continue;
+		if (radix_tree_deref_retry(eb)) {
+			slot = radix_tree_iter_retry(&iter);
+			continue;
+		}
+
+		if (eb->start < block_group->start)
+			continue;
+		if (eb->start >= end)
+			break;
+
+		slot = radix_tree_iter_resume(slot, &iter);
+		rcu_read_unlock();
+		wait_on_extent_buffer_writeback(eb);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+}
+
 static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct map_lookup *map;
+	const bool is_metadata = block_group->flags &
+		(BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM);
 	int ret = 0;
 	int i;
 
@@ -1935,8 +1969,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	}
 
 	/* Check if we have unwritten allocated space */
-	if ((block_group->flags &
-	     (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) &&
+	if (is_metadata &&
 	    block_group->start + block_group->alloc_offset > block_group->meta_write_pointer) {
 		spin_unlock(&block_group->lock);
 		return -EAGAIN;
@@ -1961,6 +1994,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		/* No need to wait for NOCOW writers. Zoned mode does not allow that */
 		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
 					 block_group->length);
+		/* Wait for extent buffers to be written. */
+		if (is_metadata)
+			wait_eb_writebacks(block_group);
 
 		spin_lock(&block_group->lock);
 
-- 
2.37.3

