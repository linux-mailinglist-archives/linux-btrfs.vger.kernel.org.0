Return-Path: <linux-btrfs+bounces-863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA280EC1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0331EB20E17
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E016166C;
	Tue, 12 Dec 2023 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HpJqw8zq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDB1AE;
	Tue, 12 Dec 2023 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384716; x=1733920716;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=m+k8zZj7fOiwTsk10O7T+w0cafCSoG6d6aneRjaYfXI=;
  b=HpJqw8zqjpnIcr6+/FtBRwUNWkzc/ONLklWqRpLVv7gvMq75ktQzGZhD
   XrvAUHcEHZgswvBUWDKBrbHWLMgNYAspFAlD1u2QFL2zllRPkDRBSxRCM
   +KL4hx3y4KMvQc77sXJgu1EQeU2buOdAsk2nbRoTD8orqfTzzyHFj3pQ6
   vUz/zAJg4VATn8dlx5H8BAtYzjhdWCzt4GVCOy7qiVuUcTUHet/OG21og
   9VI8eGRuvss/aZSwcckhzEq0sMDxV0+KCy9Sd6ilqYs/g+AzC8ExEjhph
   5JNLhyU3JNtfFLiH3f/G+NV1iSC3Mo2gOHDsV7ETtM1YXU6Fwi09zm6GP
   A==;
X-CSE-ConnectionGUID: IOXfBpj9SzmwLK28ikQpeA==
X-CSE-MsgGUID: zlpYzwIKTPeDpf7laSGAUg==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629805"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:28 +0800
IronPort-SDR: EEZx+MTXO5/EPfiEE0Oqo3Y+V7UigsN4Syyf7I8P7QAy9DwuxGXUslS55HOyNj4viY/v4jWdYb
 Pj/lRF0LEBig==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:41 -0800
IronPort-SDR: fsU/wqkD+KVd+7gZJQZyM/42QDym7jl2WKEY8ZV6rVeYnw/77LWRt4Ax0M273k/kZL5F6hMNBT
 2pCl9aEMoPag==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:27 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:09 -0800
Subject: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1349;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=m+k8zZj7fOiwTsk10O7T+w0cafCSoG6d6aneRjaYfXI=;
 b=xbO8DGuIlP9LDF+dOqBn9tQlgUQ3uaT19PWrwV0MrDVeQCBR9suWMeo8QrFScmaHU0ztpPxSS
 q8Vd2PG2TF4Dgo7pmaOOJKF9oElSi9Vsvn0xWedCUaDzEeKjv3OAlu3
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Open code set_io_stripe() for RAID56, as it a) uses a different method to
calculate the stripe_index and b) doesn't need to go through raid-stripe-tree
mapping code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 946333c8c331..7df991a81c4b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6670,13 +6670,16 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			btrfs_stripe_nr_to_offset(io_geom.stripe_nr *
 							nr_data_stripes(map));
 		for (int i = 0; i < io_geom.num_stripes; i++) {
-			ret = set_io_stripe(fs_info, op, logical, length,
-					    &bioc->stripes[i], map,
-					    (i + io_geom.stripe_nr) % io_geom.num_stripes,
-					    io_geom.stripe_offset,
-					    io_geom.stripe_nr);
-			if (ret < 0)
-				break;
+			struct btrfs_io_stripe *dst = &bioc->stripes[i];
+			u32 stripe_index;
+
+			stripe_index =
+				(i + io_geom.stripe_nr) % io_geom.num_stripes;
+			dst->dev = map->stripes[stripe_index].dev;
+			dst->physical =
+				map->stripes[stripe_index].physical +
+				io_geom.stripe_offset +
+				btrfs_stripe_nr_to_offset(io_geom.stripe_nr);
 		}
 	} else {
 		/*

-- 
2.43.0


