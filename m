Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946EC1F54E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgFJMda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12387 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgFJMd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792407; x=1623328407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9E6tK44PGKIni2Q6yn3QbbsKzgzvGhWgKp3QaiFbMk=;
  b=BUJswjB9H/M38tCqHcLIUDUZk4PpHwAPL0vCeUDdRQ7f/oNaf4B2MzJO
   BpMT6pATVVX5UIhYF+FzzcVnR/nRWjEMK+Gm4oRprQ6fyIbRlfvDRt6i1
   ym0TOL/BRjcbgeucIXU5NmzrsOz5K8Ie+r4C+K6/x2FRrUGkq7OjMcat1
   7egqmOPJcH0v6/s81TDrZZT946UV1CR3T0ypSBEFKtU1UDv38oqoXn4LW
   wQLr5ojj9AGFxDH2AHXi2a0/roJV72EOWn2pswhmhWoxnzrizQituzDWg
   thFAs2SyE/aHissa2Qvs+p+TNefVwP46LV8L6cG03Mso/WhQ2FPa7LK0w
   g==;
IronPort-SDR: I5e3+wMF7OCuYP8pNedjo67rA5Qx9ZluIB33dQm22hmvIH78nsu9K7C32E6U56D/pl+VSCfBfP
 55skP+1b1d7Xfi/B8y+0JcadOBEH22qxRKDkhUica04h6L6Xm7hdXhcKTKonQ9+f/NKR2FalVf
 nwvpgpSIBIkeMEBYTl/rtbQC005PyGrYw1RZHSbSTnCLhPeS7RazbnChXPkmPsn0pWvf8BxfSV
 yXX6Q1koiYmZau7crxP/th/zAAXV3zjfjIu53RZaNqVjVVnlWNKi6YCliYM0oad6MDxDm9q5aj
 xvU=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632707"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:12 +0800
IronPort-SDR: RQYvr3YgX/35mAIx2hU7x7vR3dKVETfqF5O2Xnn14GjGBi/TdAEtn2agkpePsSD7LI0K5sZ28Z
 xItpmb2poAhytjqbKF/GOE082xz0ganRo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:39 -0700
IronPort-SDR: V9oL1899rhMWZ42nAlKmVWuG+bR38ipg8fiB8BH28nVxfgV5Qa1TVoYxgCWIWeOd2o8X54wQ+j
 deVQ8/MOysqw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/15] btrfs-progs: do table lookup for simple RAID profiles' num_stripes
Date:   Wed, 10 Jun 2020 21:32:53 +0900
Message-Id: <20200610123258.12382-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the two simple "RAID" profiles single and dup, we can simply fallback
to a table lookup to get num_stripes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/volumes.c b/volumes.c
index 24e6d151c313..80b4b373f012 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1100,7 +1100,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 
 	ctl.type = btrfs_bg_flags_to_raid_index(type);
-	ctl.num_stripes = 1;
+	ctl.num_stripes = btrfs_raid_profile_table[ctl.type].num_stripes;
 	ctl.max_stripes = 0;
 	ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 	ctl.sub_stripes = btrfs_raid_profile_table[ctl.type].sub_stripes;
@@ -1136,9 +1136,6 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
-	if (ctl.type == BTRFS_RAID_DUP) {
-		ctl.num_stripes = 2;
-	}
 	if (ctl.type == BTRFS_RAID_RAID0) {
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
-- 
2.26.2

