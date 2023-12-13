Return-Path: <linux-btrfs+bounces-933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C60811510
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2211C2114A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2330F8B;
	Wed, 13 Dec 2023 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hxjbiCxM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7EBE8;
	Wed, 13 Dec 2023 06:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478601; x=1734014601;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ah3Vw4nWYJIAnXcNelLMdrcDtyNCiNo5U8kP1u49x0w=;
  b=hxjbiCxMrofXuH7CTxI7TfIP5cxi9L0pOTEAnPrZAsJGllASRlhk/L0m
   JaDRB7aZrXlDxSdoZPCPNsJFAqZu7suUXZufRYa/0irtJYKwcH1r0J9yq
   nhu5Sd2RN3h+TOdZeoboBE4E+Sj0EyRfx5h1BUxkbKyHzB9nJCeNChDR6
   kTSvj+wEUiv1KKMHR817bCgfkGQKp/nfhVkHi7TcPuqtW/kFZPjZX3RZw
   byrak2dIkTnoyA728mbHfq5w5lm9nH8V27tlEtqz0ld4Eh+hYyiU6b4HS
   RF4JWh9HKf8C3VHfL+1Gr9D+O9r1MGGBb//DzVYFLdtfjps3f/WG65nM+
   w==;
X-CSE-ConnectionGUID: 6RG5a2QoQbSVfa9bIkD+2Q==
X-CSE-MsgGUID: Lp4CYsTAQHC565vYKhi2JA==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4580766"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:21 +0800
IronPort-SDR: hTgQ5HwwCuP+Wz6gDtS3ZsRJvMDAwZbkgHhw2LA2R59wHV9Czqb8OkS5fek++3435UM57mr5t5
 KpitkyOWO2FA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:54:13 -0800
IronPort-SDR: VvVdq1CnJZr2JfFT6DnT7dtllm1H9tFvlOJzi52jo7n6yXsIW8fPcKV7HRkmW4vRrZOOuGCU4s
 KFJTrQHrfg4Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:20 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:43:06 -0800
Subject: [PATCH v2 11/13] btrfs: open code set_io_stripe for RAID56
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-11-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1394;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Ah3Vw4nWYJIAnXcNelLMdrcDtyNCiNo5U8kP1u49x0w=;
 b=JdXIZ2jgKTDsilTL8y0X1wiwgQYzp3eVnaq/e99QhWGLgO4/80TcF+4a8jehziRY38V4XiH9L
 WWBcyX0g4I1A/YdBXoqzPYZRosQJR4mU5mYMDBe2orIFftkhZkbM4VZ
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Open code set_io_stripe() for RAID56, as it a) uses a different method to
calculate the stripe_index and b) doesn't need to go through raid-stripe-tree
mapping code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index efb31c3005b7..5e4885a01796 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6675,13 +6675,16 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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


