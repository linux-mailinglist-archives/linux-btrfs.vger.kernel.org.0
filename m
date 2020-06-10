Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B3A1F54EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgFJMdg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12387 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbgFJMda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792409; x=1623328409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+wYOK9PdQ86NW6Tz668h2RFa7WrtjJbcYjd1zVmH5e4=;
  b=ClT8BpeqKVKl/wIK/ryqFok4id9I2pIUrT4k5oLpIThxMujlnRZlBQs1
   aA9hmC5hPqohXVEVn5CoxOnxxFBsfB7ADzUoge9+SWQFrXlC6y6zKPrHn
   uZ7t3/EGY5aqKcJc4dlX44kr47celfPMTY+40HmdadhDbB+qJKTMtN9V4
   q9GUY192TBHQ52acajmkOOgW+ijJFVy/+fGJe23E2k+cRt4jMUyzuYtwL
   xkI1IoRxkbJ6guT2SzA3B1sN9aC12JWgvgIZeTxJQGBiXVN4Aawg41r9I
   JIaXxIJ2GACq4ES9FJwLzenSTI6l0Gcvf23p1KCdPJ0foZz4sWCJ9nUgn
   A==;
IronPort-SDR: rzAOltaFBZgxZhZ3qLYFbKUoJsbrBi39cewUR7dY5ItWSYepo9yLITeRVemmPt/VW0+owCkM0V
 JupYKeLnFJTJ+oPWQ2mBw3B3XisDN8ZR79KZ169IpWflccvVGEdWOfbqpqirntof65CHv+mGaV
 2gS2enah24jZ1ULGFK9ooaT1oEswgpQM+Q/0Crwgz1Q5V9UYkoU4Xy6Wse0jvXRqdMII8wf1bG
 Vx6MXxIMkcd6Dxbo5rxxHDv+FERuPqYrG3oZEr5QhIUYlA7vkPszaI1OLZ46pT0pZxZJ8cdAqk
 xvM=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632705"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:11 +0800
IronPort-SDR: HO3BKIaBpmwE0SM/SNbCFuzgF2Ov4FJ9TkRi9pbYfwfD1BNrd5vGeQTbgJQS5jm4XkXbZH4sJb
 G2O2pdcpdJF2/2KScPHNEL1M8uQgkNMoU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:38 -0700
IronPort-SDR: bd0YcKy+Y1lYOtmxB2nbnN+3QTCQBoCuynLt8gQhJrJlKXV4YifkSHu7H4LKQVtBYfsnOPAd95
 jIFiq36H1lsQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/15] btrfs-progs: consolidate setting of RAID1 stripes
Date:   Wed, 10 Jun 2020 21:32:52 +0900
Message-Id: <20200610123258.12382-10-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All 3 different RAID1 profiles use the same calculation mehod for the
number of used stripes.

Now that we do table lookups fo rmost of the allocation control
parameters, we can consolidate all 3 RAID1 profiles into a single branch
for the calculation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/volumes.c b/volumes.c
index 32d3dfe0decd..24e6d151c313 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1129,20 +1129,9 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			ctl.max_stripes = BTRFS_MAX_DEVS(info);
 		}
 	}
-	if (ctl.type == BTRFS_RAID_RAID1) {
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
-		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
-		if (ctl.num_stripes < ctl.min_stripes)
-			return -ENOSPC;
-	}
-	if (ctl.type == BTRFS_RAID_RAID1C3) {
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
-		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
-		if (ctl.num_stripes < ctl.min_stripes)
-			return -ENOSPC;
-	}
-	if (ctl.type == BTRFS_RAID_RAID1C4) {
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
+	if (ctl.type == BTRFS_RAID_RAID1 ||
+	    ctl.type == BTRFS_RAID_RAID1C3 ||
+	    ctl.type == BTRFS_RAID_RAID1C4) {
 		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
-- 
2.26.2

