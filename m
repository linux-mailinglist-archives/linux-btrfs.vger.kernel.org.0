Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E00C1F54E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgFJMdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgFJMd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792406; x=1623328406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qzzRJdE+MntvzoAexva4Z2kK9WR740g/z7oKcJNOyrc=;
  b=evwtSpgJh3c7pLhF1pda3Oq0nz8cdqvrLW1NaKPOsKoZ5IdS/VuL2Kaz
   AWLdEJIOGkrqts8ubh40/mC8MSNGZ52oNE8p5wUGGQOgqDwiLovN0Ul71
   Z/oSUdE33cSBL3j9kEWwJIflJnFzMx+OpKpvtXeW0+JS+LWd0x7hGWtzr
   E0YEZYxZtKuEIsNi8sBEmB9Rof+f5ITs5PFRGK50MkUEm0CwE/OX7kDqB
   bhkl4KbNh1dujOzzho9j3RIaFSBIyaK/2P2SKfOOUfd94H8RudthZIxvw
   loUQnN1Uc4llm+/ZeFqIwMMorD/cJye6EP1lvG9SKTH2lkVRehoHfilz3
   g==;
IronPort-SDR: uWF4OlQFe0DKQTGshn9122eoZvzaQo1nUdFg5zaA+xyZFAj54jCieMVmWtMlerZ3ZANFH3QPsr
 HWs9WGdvddi00Eu83LZfrQIW9foziYkKvLRqCr5aJQLBtk/sov2zUi14WYTvDKwVvIFhMfa4tz
 djZb3015IVZuxOqwvgoBn8QfMCjeATttfYmaUVFRqB3D4I4RRgf0SEhqtf0bN7speq6XapxWyW
 fxZwrLilkD3+GTmt0qCP5wVVucJLVubkPzKG9oTHdeMFyV+OiV9tktfhqzx/Brt4GM76O74GJA
 Mog=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632702"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:10 +0800
IronPort-SDR: XStrOIub+Z2hmHtR4C8TiwcAwPS4ori3WWbEqJMIuVdy1kjaCrXtwWp8jsGUPGZq+V68uOAfML
 TjvZU4UF4J8A7tOszfncnjCfbSIj9+TPw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:36 -0700
IronPort-SDR: 21O1i4L+j2WcdjZYbSEeFgg1UPRtwZBV7wpJ6ouJeAIpvzheyuKe6R2CbHJf4oWxZLvMl50+e9
 PVT9c+1NMSpQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:09 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/15] btrfs-progs: consolidate assignment of minimal stripe number
Date:   Wed, 10 Jun 2020 21:32:50 +0900
Message-Id: <20200610123258.12382-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a table holding the min_stripes value we can consolidate
all setting of alloc_chunk_ctl::min_stripes to a signle table lookup.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/volumes.c b/volumes.c
index fc14283db2bb..9076f055f6bd 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1102,7 +1102,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	ctl.type = btrfs_bg_flags_to_raid_index(type);
 	ctl.num_stripes = 1;
 	ctl.max_stripes = 0;
-	ctl.min_stripes = 1;
+	ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 	ctl.sub_stripes = 1;
 	ctl.stripe_len = BTRFS_STRIPE_LEN;
 	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
@@ -1149,7 +1149,6 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	if (ctl.type == BTRFS_RAID_DUP) {
 		ctl.num_stripes = 2;
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 	}
 	if (ctl.type == BTRFS_RAID_RAID0) {
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-- 
2.26.2

