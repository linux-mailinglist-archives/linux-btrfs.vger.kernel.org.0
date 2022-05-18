Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B752B61B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiERJRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 05:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiERJRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 05:17:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037C1A060
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652865444; x=1684401444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxQFsUJVGLomXi5JGfsV8Uj6ugKVdOX5yfiCfiBtgfQ=;
  b=fF9d7W8+lZCPukJF/dNgY9l2pDJhTJUeJrlZm9eeZvCdn9/Nao4j3olM
   CLmeHl9XISBeh+fLf7QrCbtT4Va7AENM4/kSXvcOXpvD5U4M/2ww0VAPK
   rMfiBAQbAhCDKgk4qwEhyPTRDmTwoE60VDMkr+BOxskXfMRgouOmIeoYq
   Ih6en4n85xwuimKaJM9opQht/25OcpqAQnBcUhPS6OPO5utNR3SjcdpT7
   ANDE9M4PLMofeEFEJh2wAdaN+zv53NwFMqHzd/XOwkL0dXibTLgqrsJrE
   ZHrfqzYnqs0b0YRk562RohlQjfx7E0Dy99rl6V6XYa5H2s6TTVDqD35fH
   g==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201514751"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 17:17:23 +0800
IronPort-SDR: URAzZu3+RbQzi0IvAsWz1QR/Xa7uXNLxPFro+TAEdVK5rQqV3u1RLxO3A3y0fRb1ETajv0kl4i
 qBoUbjKAxNT6HRuQd8Spb50c2vqKnA5Xof7VrAx0MGAZcADf+gvyhRyKQiIb4C+yMHuA3AELYh
 NiAZjE/fhVDwffPao312ARbvWEWfXsXR7A/J43q2p0VICuqJj0G3AeB3ZJ+r/7C8vWvSrUQuNe
 V51jSUyX13mwwPgLzu80pinGn2LG5BWCtrf/GO8P0oimi4gElB21Vz+IXMgSkrQ98LTLM8Zue1
 ug/LC6eSAbdbIXvceYu75IDo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 01:40:26 -0700
IronPort-SDR: 3FUHEx3PxsT9/vErL0uOZRpF3UZIXid/BNvrwfTrpFyZ9sr0+XJ0O/p1Eo+1lBC7Miv6sTXavp
 GbZ2cAUoiD6bLat5nbEWNJ/paHNmQwtLzGyW6LSiPUMxS5jk4f/iWYRqPmVs8PcXvzXoFjuvCR
 /8FQk68fT0rcNUjZhkT76riSpNguXJyi6OJh0TV+hhhyKkFmr3Dpk+wu4qZSlDOg9q+2N7OKof
 k/KMD0hLPu52z8SvPfqFdQcdzGMGsLxC3VhKO8s8pUeM6bxPIuTgsRX6U+tUkRBFzjoAIqj34M
 Xg0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2022 02:17:22 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 6/6] btrfs-progs: load zone info for all zoned devices
Date:   Wed, 18 May 2022 02:17:16 -0700
Message-Id: <20220518091716.786452-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
References: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mkfs/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 881de53b11fe..a43dae0ee253 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1638,6 +1638,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+
+	if (zoned)
+		btrfs_get_dev_zone_info_all_devices(fs_info);
+
 raid_groups:
 	ret = create_raid_groups(trans, root, data_profile,
 			 metadata_profile, mixed, &allocation);
-- 
2.35.3

