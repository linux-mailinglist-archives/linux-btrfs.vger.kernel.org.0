Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8404A3E9387
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhHKOVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35974 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhHKOVP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691652; x=1660227652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Px+itNgdnBz6vWpI7MNAb57rRUL1XvG1mQkAplwfIk=;
  b=FaQjXDEk1z4gQVjDxoNeq2lUh098zOIjfXCoA2VSWVnquYNKfxu9wDV8
   rS7XNmWc1W5nqq7WdJAF3Y+5EJsAaYZ699m2D4JrsxTBeY0NYzFw3tY1c
   /Oe4yNQbPQkefTrP6jUcL29W1A/MqqEl9M59xFYoXkLh1oHvSJLD+LrPB
   tQ6gQPeZNONQ2hvVdrZB6unq5RE7RdJN/UnjoAxemSov1ay9iRdQOAn9r
   OIwT8EQpr/AKFbbdpr+woOPOYENADrSvlB0+noZdKp66RCUndriE+gVbJ
   byTxHsXm49nYqdvs+vhdIc9uiHVQoUPp55OaRYwAx+JBfukBTdTwzbkwy
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937880"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:51 +0800
IronPort-SDR: j6AybjEhhf6UckAN9Oh/Dw7ZSLHXSGagFXju1dGG/BTpNti2YoadHWOr2x5mA5+FsvAHmit9Ux
 G/BgHghNAxorfiLLo1LQCfoqSG3xoYh2hCfQVBux+1J8slPASVL62O3yBwZIygzHcATgDAkZqv
 XJ5gJ3p/bbYnccmIOjP5vy4LosDg3udkf/ZCZuE79/5VzaDczJ6QeAezmrZZbOGXuBhMR0t2Kw
 ng0IFzQ3i5kIk95EZP9Y24YsDuAtgArcCEXVkJz354o2IKbpu6Gbgzl0XqufGUl7egzuUkrEyw
 f161SZDL8YTmdAqd1OUDRuLQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:22 -0700
IronPort-SDR: cgcJEn2c7ueGDNwiZ0oOlJ4YV15DYc8BkS1KdQR11CxoCOlaY/Zlddyxx6JkpVfyi2Rd/DjyII
 kqf4TPVn85bBCEmY8a+cFs7Yag1c3OriNpv1GVtbNCizva3/laS17/N+lKFeU64mwTGwGpNtyv
 5vwIMLMzcNRRTsuG+6PKPCCzpQQpju0+RDxDWFP6NdYazlnyKJsG9iVOXPVPVQjKPzEuXiQ+Fv
 nQogs9iBMdcal9PzpSYzJzZkNd3UWJdx1G7fGJiVdSpspv4xmjzZUBXKx6LumUfMsycFoWy59L
 q5E=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 06/17] btrfs: zoned: locate superblock position using zone capacity
Date:   Wed, 11 Aug 2021 23:16:30 +0900
Message-Id: <f52c1203594a751a9e0a5f3fdeefc83f84b7e308.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sb_write_pointer() returns the write position of next superblock. For READ,
we need a previous location. When the pointer is at the head, the previous
one is the last one of the other zone. Calculate the last one's position
from zone capacity.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d20c97395a70..188a4ebefe59 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -683,9 +683,20 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 			reset->wp = reset->start;
 		}
 	} else if (ret != -ENOENT) {
-		/* For READ, we want the precious one */
+		/*
+		 * For READ, we want the previous one. Move write pointer
+		 * to the end of a zone, if it is at the head of a zone.
+		 */
+		u64 zone_end = 0;
+
 		if (wp == zones[0].start << SECTOR_SHIFT)
-			wp = (zones[1].start + zones[1].len) << SECTOR_SHIFT;
+			zone_end = zones[1].start + zones[1].capacity;
+		else if (wp == zones[1].start << SECTOR_SHIFT)
+			zone_end = zones[0].start + zones[0].capacity;
+		if (zone_end)
+			wp = ALIGN_DOWN(zone_end << SECTOR_SHIFT,
+					BTRFS_SUPER_INFO_SIZE);
+
 		wp -= BTRFS_SUPER_INFO_SIZE;
 	}
 
-- 
2.32.0

