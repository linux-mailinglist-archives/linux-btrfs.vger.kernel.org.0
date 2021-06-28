Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3513B682B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhF1ST0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 14:19:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30707 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhF1STZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 14:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624904219; x=1656440219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g2T44wYnvNaikOM4Cwrz1M9UPoAlv39rBl1uiBr5pJM=;
  b=cLJDP6VMqpuGF4slVtukTyJKqapHHvRb4ik2ogK47S+K5IRagW8MlZNp
   roq07TSG+Z+QbRXUVgr4q99FrXV/NLRNRwvaFfNynLb07BEGhn9xCatqO
   fwHDf2HeOn1x5eNcnhBmQ8to9GdQgZ0BQ0L3HWoPhv9m79ZYs2BLzhrgV
   QBwYDWTDs86dhHPSCYyS7ndfptWf7O90KBcoQtZokhTrVFFDyTbQ7i1d+
   8k/0na+sNjcDmX1QJ6W6D+uVgePuzP0LZOleqIvmY3gPnzVJMEWO+ExU2
   pCYvYBfRHpECzjW/V2N5040Xixet5UMWVJQ2l9eQWpw7lUAiitWUDNY9p
   w==;
IronPort-SDR: gYM8wcrlvQcpRox3KD70zxhkaMsZahLIzwwZVYyi8uG1H8rwDgjmgno011JrXfDiqg0vQ0I/mz
 JhAW6MlLRtmJtDyxtyFxvjNoVtgJSPlFE8t7rXnMr3W1NPy/uw4vDzqwWasQIoAPRWN9uARxvJ
 Cu2pux+YYaz8MHM6694aYcxcPOMxlu2k3FqzVUpx7g9KM0BZhucKbtKsP/s+vEfI8wqZiG4TEe
 i84onMvVpfQGgYQf5TTaEASuyCi6fZjNXJgzB3q1gueBydNhv9p6tmmm/ssjAaqPAjm7mU8MRs
 l14=
X-IronPort-AV: E=Sophos;i="5.83,306,1616428800"; 
   d="scan'208";a="173119855"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2021 02:16:58 +0800
IronPort-SDR: blfdT5vmgNg3m8uwt7iqhEYOqyD/2BveECaY1hTMfFmBCsFx2CFbvIo2OfbUMUV8KixTPxn8C5
 z6DU3vP9hF+RDSWStY+fpHhLYLXj6VaHZrBoU5yuWkNgEg23GloR5pcilu9sPWsZ89yI8jiGky
 2v5h4JrzJEY53BUfN5lKQmdLdSwCcVvmEjCixaSSNWdK/L3NRhHwm2VP7rtdqkjnSVT52L/Ww9
 raujL1X68izbfs4A0jv/FB1JKrQanS4gn5gh5tjA3DN5S/7xPOIWByOsYvzLaZfOFpuctY7pXH
 xBAQ31PEwU5szoKfm2o23tdL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 10:55:28 -0700
IronPort-SDR: kEGxciTQPVV2fzOBSPXZ7UzR5um2dIqoz00IL6wGuVcoEwWnbxptj6opZFRl/A95dpBfdCoDFB
 O5eHmisFwiHUAjSpG5xoqhTBAZZsyfZO9X0DA/8qtffrZo4Tr920JnYvwtI6iITKKTPyiinMDv
 MisBzUIXv1glVERYwP42cBgaT8WmIolj/vUARgVa3skfa7ARaLWfkp/EhINBO2ykFwCpH6vRsp
 EDKDx0BlIZOATQts+g7qdGlng2Iowzb0oSlny6uI7g83PJEJGoCMZwbNbrioLSSyoQAb6ctCaq
 E1g=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2021 11:16:59 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: improve logging message for auto reclaim
Date:   Tue, 29 Jun 2021 03:16:46 +0900
Message-Id: <3786140da052ad5067bc6d2990325519c4abd1e0.1624904192.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we're automatically reclaiming a zone, because its zone_unusable
value is above the reclaim threshold, we're only logging how much percent
of the zone's capacity are used, but not how much of the capacity is unusable.

Also print the percentage of the unusable space in the block group before
we're reclaiming it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 38b127b9edfc..98296eef561e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1501,6 +1501,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	mutex_lock(&fs_info->reclaim_bgs_lock);
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
+		u64 zone_unusable;
 		int ret = 0;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
@@ -1534,13 +1535,22 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			goto next;
 		}
 
+		/*
+		 * Cache the zone_unusable value before tunring the block group
+		 * to read only. As soon as the blog group is read only it's
+		 * zone_unusable value gets moved to the block group's read-only
+		 * bytes and isn't available for calculations anymore.
+		 */
+		zone_unusable = bg->zone_unusable;
 		ret = inc_block_group_ro(bg, 0);
 		up_write(&space_info->groups_sem);
 		if (ret < 0)
 			goto next;
 
-		btrfs_info(fs_info, "reclaiming chunk %llu with %llu%% used",
-				bg->start, div_u64(bg->used * 100, bg->length));
+		btrfs_info(fs_info,
+		   "reclaiming chunk %llu with %llu%% used %llu%% unusable",
+				bg->start, div_u64(bg->used * 100, bg->length),
+				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
 		if (ret)
-- 
2.31.1

