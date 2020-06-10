Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F231F54EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgFJMdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12387 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgFJMdc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792411; x=1623328411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fX+wAGF/flCqZTft6Sun+GAf9y+9j55/jeOZA8h5m80=;
  b=VZll1u8l/PIAyi65nBol9ByC2GMtWfPZzDViDcJUczzQy4Mr78VsPMUl
   kvZmETs1UP7ZwoxzmsD2imqTcYTiWY1B/6+bFO5j9nkO3u4T0hpnM9F7C
   sDSvL4bUZ5X92SPcP75JZWrxKrS79a1XNH7YAIUijdNlPRH14c6E0pHDa
   DYFvCE1zBxLR0dc37TATZ3yUHwByQMYicS889sZCNhP/TrQZtBS027oze
   XIKe3FnmPLA+8hUT2uw0uMnGUEWE+niD6XCeSvnkrSPK9D5+pf2g1i4gR
   pJ5Z2Y2jjbwYMWtjFklY6Ko4YKRXrSmFpgFdQ+EPFWffmKsyXQegpdAJv
   A==;
IronPort-SDR: DjyHi/AJJ0qdM+8NkPEgwL1Wa0L/3FGmG9Ik3yF7JVqEoVy7+tqzPCFgqmVsyD6fd3jRrH1U/G
 EfgSrpwu48b5UmROWXnbSJalF2baAlIa3MwRHnN7YazcyibbRU0qKrhOQTsZl78edD/CrWIVBn
 OcYYRRDR74G4Oqe/n1oDoE08IhGBrhDZOmAeNzKF5cXk3o28Z/xU2q6idlKt2ZxKQnvdtpNazm
 QLPZ1LYEma7bD2sn59uM8LxBIqSr4MKnz0KXL6NGYFMTI6HwefKrVXrxCvmiRj5yQ48KuJzv4E
 cKc=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632716"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:16 +0800
IronPort-SDR: 8yV5AVAJmLh9cqPowWxnoPj0MSCDRR4O/qNNFe1xI6lme/4xPYsreZijHFUd/4v2UwIRuu1lwv
 BhSUFZ94x/yZC52iv6r8G2LyjmjYBrlFM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:43 -0700
IronPort-SDR: 52YHrzPfgsVIRqb3mHNwWis8Cq+4ODR2hiJDlfasJnrFbmVlLm8JrqtjUHeqgEknpcoDop3NAm
 GszWp4+MGCKw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 15/15] btrfs-progs: consolidate num_stripes setting for striping RAID levels
Date:   Wed, 10 Jun 2020 21:32:58 +0900
Message-Id: <20200610123258.12382-16-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All striping RAID Levels use the same method to set the number of RAID
stripes, so consolidate it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/volumes.c b/volumes.c
index ec31acd57aa7..7c57d6cb376e 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1077,17 +1077,12 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 		ctl->num_stripes = min(ctl->min_stripes, ctl->total_devs);
 		break;
 	case BTRFS_RAID_RAID0:
-		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
-		break;
 	case BTRFS_RAID_RAID10:
-		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
-		ctl->num_stripes &= ~(u32)1;
-		break;
 	case BTRFS_RAID_RAID5:
-		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
-		break;
 	case BTRFS_RAID_RAID6:
 		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
+		if (type == BTRFS_RAID_RAID10)
+			ctl->num_stripes &= ~(u32)1;
 		break;
 	default:
 		break;
-- 
2.26.2

