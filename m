Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37513F1922
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbhHSM1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbhHSM1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376033; x=1660912033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r50VGNZnDSTv3Op3HS5vNfZct0dafhEDRNdXuDHct28=;
  b=Az6ysMzd2NCC/j9fTUldrdEWmmuoIDFBOmg2Bjq0g213dO6oyu+UNJBE
   aZOaplVjSc7hYoBkO0EJjooUOfyVjXN1/GiO9w2+6ZgGxoV1jJk/rchqy
   VymupPV0X6NPWggyNFOOVh11Z5raPpLIxNvLX9OFkvxKUBEsDgFnyZyls
   TXkazC/TX3Mnfb2vzmOnO0kvTByMDLr+fVASeKbVK/eUqY7lQnBCY1k9O
   /gXxU8ECgBFPmDEwTP5OGEpQUYSGkaijpmmAhmeW3f2rlLeIoq3X868cj
   dxQA2zczZc/6+58D9yaDWqiz+G2bL1Qq0hp7UqyCDYJgmMffP61RXZMJ8
   g==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773559"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:13 +0800
IronPort-SDR: vpMy3wEt04JgyLMwNe6xPedJRcp8gK5uxTkv8GReBnwsnelAC0nA7OmHsWoaMnICojAsZz6Lwi
 mjxRv+Od9oANdmN9xnfZZ1ClxK1l7ppu/V6AzR3fOQBMJTUfT8mqLvJxRFKGYc78hmAp7j+jzk
 Xue5Zl5G+WRH3RQnX86hQ4oxfPj6+DJUYo+vrAo9nx+xG7eeV/Df1mi8C2H2rCnGBTZrctaI90
 EHmghgMT78lA8GG9ieNASrAlNeR6wuS9uvANCcE/nbTxb2Yu1ki3wWW9hsIgXOCJ/LgBMYotec
 xNLs9zOCrWNfQMSUI8iDc010
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:22 -0700
IronPort-SDR: FA519rt2vDcK+0MjzzDHZfkIyfgKVjKO43U6yuNi/MpIctSvyx0rznFa/820/0lmKUeRsiVZfD
 hKIpMuvaaJXaAGXmAgkLPDId07GxC6+3cupOsst13sXpCx4ibXR2mc/34cQ3bNGJtddF/wsFDU
 ntLPHCg5itTSxtxCh0Xda1N1F+9CSMZ7kDg97zMeU+o8nFOuJPibXLPrD34+lri+mxN99t9l7j
 4eEltewqwtEX9k+qN2dj5SHnovGXIp/ACzYpJmc/rROip68GZgsG6yw3QF4c9wWKQhJ0RO+iL1
 52k=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 06/17] btrfs: zoned: locate superblock position using zone capacity
Date:   Thu, 19 Aug 2021 21:19:13 +0900
Message-Id: <98720a3c02feebaaa8810ad3dbfde1717bd1acfa.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
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
2.33.0

