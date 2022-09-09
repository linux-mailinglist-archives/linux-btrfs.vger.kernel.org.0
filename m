Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36745B2F65
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 09:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIIHAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 03:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiIIHAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 03:00:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E474E62B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662706798; x=1694242798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b+BLFJo3eXe4ERVer1gRzU2SMpFb/OSRYLumEBHE1VI=;
  b=npe8ncPA8MjSaKNCojSz5BCaKUxWH/lI+a6Y4iQopSPenVO+9d0NRpui
   peeNlo3JalkEKO76Y3dGl0/CS9UVNoHi92/G8A6ywUBZ7RZ/92r/dnaxk
   1h6dtlEsCbT/vWXKF/WWd0Wyf6qEdBJcdyLHfsJtVFZ80qHOz+hzpfBOT
   Nvk9jpvPyU0RS/hP9Q8V6ykT9o4MjC7NEWmSEpjv6nd5eFTZCtkODv+JQ
   366t1oso+RBIexzMIkFDUVBLNAuSO+14Po/Tsi+AkEnTCNp0EUeNNhM/Q
   v2WRDLWZzsv6ioN3LSEFY5yXAvTd3/NMAwdgO8mPlrt8M7FR9/qfOYn1o
   g==;
X-IronPort-AV: E=Sophos;i="5.93,302,1654531200"; 
   d="scan'208";a="216084411"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2022 14:59:57 +0800
IronPort-SDR: qHsnkB0h1vbbhkPonXp/UEjLdGD/hLaFuCy/861kV+SzLr8vkkpigF813rL/4j9SySLwnrHoGS
 xDL34iuNQ50qpM9e3ajxTjiBwLYTgUyxdJ+rOOlk/SOwWqXCP8sSxAkB19thL2hHVgwbL+UxpW
 AnLetDyUGMujkG4aC5dsn7RS0qdLisJt6ToXjB6I9hLB5gDZiuOgaUb6ryBkeXyBghWi+Mr5IA
 xpK9FUV5ppaevaGab/CkhonTbKJHRdr7TLB+PFK9uOx8NeWK8pQAMFGe3nDFUMeJYMoIhG5NuB
 rffFOcskdhPTNXDzrZ2Jltoa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2022 23:14:52 -0700
IronPort-SDR: WzaEIgYlicDfVdL4E7IzHLB6jCAYLIEikvWaXurIkv/1E2vd8FL4Tu7pkDMoYmhxKfhdp5DRDG
 YlX/LxhNAbGRj2nHNSC21XwQAzdhPog6oUr6znOch5sqFgTOt74GpXEeN7h598fbRCn0NSvCv6
 H42QY0jYLAzKeybXEnh2XNHyh8UpsnoPWC2t2AGB+cd5x6cc3kGvjELwA15dOq4WmF3hryA9Y2
 erHIXoPP6qw3h5eREJBjdIwkvL50psjmcG3nTnbiWJuX4dpqcoP1m8qSHP5L8/AabPAgS+FaKY
 xko=
WDCIronportException: Internal
Received: from 29dy1z2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.59.193])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2022 23:59:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: wait extent buffer IOs before finishing a zone
Date:   Fri,  9 Sep 2022 15:59:55 +0900
Message-Id: <3c6d8c45b61b6977f3bb2e5f8534ca844e291d90.1662706550.git.naohiro.aota@wdc.com>
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
v2: Added __rcu mark to fix build warning.
    https://lore.kernel.org/linux-btrfs/202209080826.AuNlP9ys-lkp@intel.com/
---
 fs/btrfs/zoned.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e12c0ca509fb..e8cf30def51a 100644
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
+	void __rcu **slot;
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

