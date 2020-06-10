Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698851F54EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgFJMdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12382 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgFJMda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792409; x=1623328409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSbU88BxRVzAR6Lx9GsMNeT0Ej/jclkKY5xRxSd8v0Q=;
  b=jj48q9xwNEkGm4rFcNAJ5BqI0cI1Q/AQXigHoDwRyLsZcOgLIlWg9pfr
   gNhA+womChzUTpAFhU6AwMUGrOIR1U0IuSjz0Gwsh0b9ty3zMAiaY0BIK
   eFIS6JoA2TlR0ZhP/ND2b8Sew1+bLMhsuu+H8DFeyLvboDvzOyDcQlxlV
   UVl48tKXNb6/V4Fv4kZmsBunG9PeY6rGilOleEKDwMQ8pXkAUc/h3zDt/
   4zBIll/jp73x39AqIfZNHUxn3Ew64IWPKYHREwPQ0+FHeSbDGVGxy7esw
   TdvUFETBUMRLnp3wyocHZ5Wok5wQV0KKVcHyet8jCtUiRwgedOds2VtXa
   Q==;
IronPort-SDR: CaPg0IfP3IggowjlnadT7QaLUTscdsaUfsth3IYJ39by3FRIFnkfmlfPS/EYegNjYYiFS0hw6d
 Ysk4JElF9QYxZspIcyzB9f2/J1x02otD0Abohpx/BF47q3EEej2cKMWGWeYLt0MaxjzRHJ2DZU
 Lhb6bVN5LHEKiFqDJQSmOyElwB8fIscbtYTjTRj1xV/VgDYVNQkf8MbO7IRnVhr60G/h+hNx6m
 Ixr5itZ0g7Y/jB65bq4ZaqQ62sb0+d3rEJ9clqiFA1T/zrtxc8SRQSWMexgrwzzU7edQW66py6
 opM=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632711"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:14 +0800
IronPort-SDR: 2Hhz4QqM3sRXOkJYn7ZCinjapLXNRynH54WdO56it/tRx014qe8WLqoNmvFXC7eUpVkZQBBpMx
 7yKStunlz/W+82T6FGvA41PBIpysW8rTg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:40 -0700
IronPort-SDR: ZAeCQ6IQFtWsUryKfJdfll4n4v+R+eN2DNpiC074nbErL+uGyxLosDw7qA/JePEWewDF77+nBY
 P6nHWZtoDElw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/15] btrfs-progs: compactify num_stripe setting in btrfs_alloc_chunk
Date:   Wed, 10 Jun 2020 21:32:55 +0900
Message-Id: <20200610123258.12382-13-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that most of the RAID profile dependent chunk allocation parameters
have been converted to table lookus and moved out of the if-statement
maze, all that remains is the actual calculation of the number of stripes.

Compact the 5 if statements into a single switch statemnt to make the code
a bit more compact and more intuitive to follow.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/volumes.c b/volumes.c
index 80144a763b72..57d0db5463ef 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1129,28 +1129,31 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			ctl.max_stripes = BTRFS_MAX_DEVS(info);
 		}
 	}
-	if (ctl.type == BTRFS_RAID_RAID1 ||
-	    ctl.type == BTRFS_RAID_RAID1C3 ||
-	    ctl.type == BTRFS_RAID_RAID1C4) {
+	switch (ctl.type) {
+	case BTRFS_RAID_RAID1:
+	case BTRFS_RAID_RAID1C3:
+	case BTRFS_RAID_RAID1C4:
 		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
-	}
-	if (ctl.type == BTRFS_RAID_RAID0) {
+		break;
+	case BTRFS_RAID_RAID0:
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
-	}
-	if (ctl.type == BTRFS_RAID_RAID10) {
+		break;
+	case BTRFS_RAID_RAID10:
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		ctl.num_stripes &= ~(u32)1;
-	}
-	if (ctl.type == BTRFS_RAID_RAID5) {
+		break;
+	case BTRFS_RAID_RAID5:
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 1,
 				    btrfs_super_stripesize(info->super_copy));
-	}
-	if (ctl.type == BTRFS_RAID_RAID6) {
+		break;
+	case BTRFS_RAID_RAID6:
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 2,
 				    btrfs_super_stripesize(info->super_copy));
+		break;
+	default:
+		break;
 	}
 	if (ctl.num_stripes < ctl.min_stripes)
 		return -ENOSPC;
-- 
2.26.2

