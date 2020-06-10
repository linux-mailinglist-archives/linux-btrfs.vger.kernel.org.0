Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E501F54F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgFJMdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgFJMdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792410; x=1623328410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUoazRuMF0oKCxTYEC1yElCPHbLq/WobG1xmOBAUBBg=;
  b=dUpXwU8Z2xldkgVOHN2C0oMcy9k3zp2Ol5JU7Pdkc/MzNmnze1uNbuxA
   g3P5LkxQJ6f3s7Kkbyfo5teoL5JQ4mDWKJmB01oMSx1aCbBN4s4WONaaN
   G8dIzXyIMBxzQw+M0RohQ+Duit1Jk/Sy9F/ZsxJ8GiY9+JvKDMbUuGDHN
   /4SarupW6bg91D7GNOT/14uANB7I/5VKcUA1WMh80w+o/x3j7FBhGZ1OG
   SGfbVKLWBOFWMMz8JBA0Xi7bWrDrT7RrRzsrDrLWTI5ACpNBN5YfLrWo2
   o2gE88efRv8TIuiY8rBNvMPJHwWkHEuu86J0toNZPgT4mzC/Ve65yWbhw
   w==;
IronPort-SDR: T4DvCzm9mjCRGOnmiQ0gB6gUqgtq3EuFN+gHz721GMJ52FdW0bXFzF1eOQev0LO9pcU0i4JJtg
 S7jPSzNtKFdrLKCujHYCM+0ou1PizBTGSWCGf5JdHFguIXgUgwoIKn4jY7ycvD0i95F+YP1ciX
 gwNiJQHbA2B+wvBAFdJ2FJdpCAjXpkxDJsHM0gsgHilEnXvh8qRI8Zoqcj/tTI+ROsoYmBrTpI
 7CrBAbVyGxvXSYNpnSicRfs7wqHXJtrcWG0T2yvnR1BSbVvWi2KkkVytXQGdlfXO5G5fqQQtR5
 FpM=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632715"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:15 +0800
IronPort-SDR: JOoWqAVlWxzvmG8sd/xk9KMOM4KOB2yOlNj74+3bBNEzRtH2VnQZ4Rl+PBg/s8flN1GeQ8QcB+
 eFloJ+9WgJXMDUBgaIQ1xxqi/6SDQMcTM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:42 -0700
IronPort-SDR: shEmx+lrmPHWaLh0s1A18kjLeCyf9qWopJaM4J3kX5feLni5dVI5QEPiDMKiDD1EcmRxwGN2Tw
 pKoBambZKC1w==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 14/15] btrfs-progs: don't pretend RAID56 has a different stripe length
Date:   Wed, 10 Jun 2020 21:32:57 +0900
Message-Id: <20200610123258.12382-15-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since it's addition in 2009 BTRFS RAID5/6 uses a constant stripe length
and we're lacking the meta-data to define a per stripe length, so it's
unlikely to change in the near future for RAID5/6.

So let's not pretend something we don't do and remove the RAID5/6 stripe
length special casing.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/volumes.c b/volumes.c
index aacff6e0656b..ec31acd57aa7 100644
--- a/volumes.c
+++ b/volumes.c
@@ -900,13 +900,6 @@ static u64 chunk_bytes_by_type(u64 type, u64 calc_size,
 		return calc_size * ctl->num_stripes;
 }
 
-
-static u32 find_raid56_stripe_len(u32 data_devices, u32 dev_stripe_target)
-{
-	/* TODO, add a way to store the preferred stripe size */
-	return BTRFS_STRIPE_LEN;
-}
-
 /*
  * btrfs_device_avail_bytes - count bytes available for alloc_chunk
  *
@@ -1092,13 +1085,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 		break;
 	case BTRFS_RAID_RAID5:
 		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
-		ctl->stripe_len = find_raid56_stripe_len(ctl->num_stripes - 1,
-				    btrfs_super_stripesize(info->super_copy));
 		break;
 	case BTRFS_RAID_RAID6:
 		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
-		ctl->stripe_len = find_raid56_stripe_len(ctl->num_stripes - 2,
-				    btrfs_super_stripesize(info->super_copy));
 		break;
 	default:
 		break;
-- 
2.26.2

