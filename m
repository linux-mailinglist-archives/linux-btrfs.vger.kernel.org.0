Return-Path: <linux-btrfs+bounces-932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A21281150F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD211C2116A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7972730CEC;
	Wed, 13 Dec 2023 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rsq3ow2e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D95DD;
	Wed, 13 Dec 2023 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478599; x=1734014599;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qN9uFU57GBna2r1afgLudejpCt6oeNpZ8RYEEAbqQXg=;
  b=rsq3ow2eWmjEgFeyR0jpq8WGVr3aVBbipVvjQfs8g+QM/jxxDkmNYsun
   dchscET/rroFcnDmjXZ3CnM4PpCkoGtbe/zc327lsmXszDShDt0F+NY87
   rUMQWE75TNobHNp5N3R+O9jnCvOkBk7EiMM2/zDOesmFFhtr57vqPnvbY
   Saz6MPtaL5uEAsMAsH3Sap6UTrsBjpOBAP1PMPzCewoVsNXPDIur8u4jU
   aN+2JEmbXxoy2fQRU5iaIQx4+PhacXxIIK74rqZf4oGzmvgB/EiYvdFYS
   wH9hLOQulVExhrQuKs53KDKuYaofX7ADa2iZBFXYrbbyBNgNo4sN9aBbD
   w==;
X-CSE-ConnectionGUID: FSnTn6JcTaaJEa7Na8rxyg==
X-CSE-MsgGUID: LInRM9QtT9iKNuNtPYzxhQ==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4580759"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:18 +0800
IronPort-SDR: lyt6xR+vykByqf1jWQA8GMQ/ft12tNXRgi7Z25mb2GJxiDgjA8doJhOOYCg+DgKQaPcQEHb3Ub
 TmQl6n7JXF2w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:30 -0800
IronPort-SDR: J2ayBnMfsZEDf/vIc07aK+WYzQeCZ/WpAJqHvaNHjQ2NotY1+NOxfWGl/LoOA44EUhCMHF8yW/
 EwbcbU+id01g==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:17 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:43:04 -0800
Subject: [PATCH v2 09/13] btrfs: factor out block mapping for single
 profiles
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-9-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1479;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=qN9uFU57GBna2r1afgLudejpCt6oeNpZ8RYEEAbqQXg=;
 b=GNdQPNmiHfgl1oXaJa/IVRS0l3ajkT51NLCGozaz/MHqjMXwZZ1CW6t4MH4Jx3fi4CkpD97Ym
 g4JV3WNQke0Ce8JBP4/pBhcFu5cxQp3j3hu7Trc+B1uQk/QkogCGigQ
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of SINGLE profiles, factor out a helper
calculating this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 55614a9eb8a5..e23c7d2842a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6487,6 +6487,14 @@ static void map_blocks_raid56_read(struct btrfs_chunk_map *map,
 		io_geom->mirror_num = 1;
 }
 
+static void map_blocks_single(struct btrfs_chunk_map *map,
+			      struct btrfs_io_geometry *io_geom)
+{
+	io_geom->stripe_index = io_geom->stripe_nr % map->num_stripes;
+	io_geom->stripe_nr /= map->num_stripes;
+	io_geom->mirror_num = io_geom->stripe_index + 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6591,9 +6599,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * device we have to walk to find the data, and stripe_index is
 		 * the number of our device in the stripe array
 		 */
-		io_geom.stripe_index = io_geom.stripe_nr % map->num_stripes;
-		io_geom.stripe_nr /= map->num_stripes;
-		io_geom.mirror_num = io_geom.stripe_index + 1;
+		map_blocks_single(map, &io_geom);
 	}
 	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,

-- 
2.43.0


