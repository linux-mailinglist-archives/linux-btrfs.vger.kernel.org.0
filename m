Return-Path: <linux-btrfs+bounces-934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACED6811511
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513251F20FBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491EC3158C;
	Wed, 13 Dec 2023 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YEFxn6+6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C26111;
	Wed, 13 Dec 2023 06:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478603; x=1734014603;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e/guiXA3HBcKLNpRnItMMeCwjZTheHhEwP/jrp5atmY=;
  b=YEFxn6+6IlKeT0YQC4cpeK0ELg1lr/xsOgW5A3XgKFt09X+KbQfDre3h
   xVWfQTm+rFqSJ2aVK82dExss7co5KFERtMAECGzPm5K25+HTzIpWeQ/pp
   0g2pi890oR/fcoNYUoTHktKX3eoN/iBqMRvapkoiV3sPcKZO7Tu6AztTP
   B+J2DbjRLSR8OJh7imXZ78Pr4sX8DKRNpckvjFcty0N5vi6wafhP3ZqkE
   VqvQRPG7gI1nCNxA90Jfn434o/vNV652rADDF/nuXAJG/LpdOmo2NNcWI
   0akP7X7C+YR1BWxIeg8WQNSkJWqURufHbCnIhiPOSoU+ApwL3vv8ovO2x
   w==;
X-CSE-ConnectionGUID: 3Rfrop7cQL+I8pt+OZDsgg==
X-CSE-MsgGUID: NtmwwGUHSf+D2X5YTBQt0w==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4580767"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:22 +0800
IronPort-SDR: E3ko+KObtmN9TWOk2pjWdNbkx8lZGuD4z2YPFejS1loJAazcKfeP+3OJ0AtdU1lPoeKRM6ci/G
 VKdnn5BS/XuQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:31 -0800
IronPort-SDR: GdIZ5OuzcBMxPNwuIsC7fpMODao02c7yFLhY+nG/WPXU5q3TmOAJNaJaxsiCANvkOcy6gqcF+c
 nfFvpZLHs1LA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:19 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:43:05 -0800
Subject: [PATCH v2 10/13] btrfs: btrfs: untagle if else maze in
 btrfs_map_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-10-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=2122;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=e/guiXA3HBcKLNpRnItMMeCwjZTheHhEwP/jrp5atmY=;
 b=4lWlvPgsM4isrIKCCNY0se1/2neTvCtcmnMZFfFbAQn0bacYYcdj2A4V6CHCxVwmCbEM8RHZG
 jvkhaRP43FxA3v5CAJstrbh3wAgHkxCOhW6ID2+ovZJHFPnZg22Pr1D
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Untangle the if-else maze in btrfs_map_block into a switch statement,
checking the different block-group profile types and call out into the
per-profile block mapping helpers.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e23c7d2842a6..efb31c3005b7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6578,28 +6578,38 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (!dev_replace_is_ongoing)
 		up_read(&dev_replace->rwsem);
 
-	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case BTRFS_BLOCK_GROUP_RAID0:
 		map_blocks_raid0(map, &io_geom);
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
+		break;
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 		map_blocks_raid1(fs_info, map, &io_geom,
 				 dev_replace_is_ongoing);
-	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
+		break;
+	case BTRFS_BLOCK_GROUP_DUP:
 		map_blocks_dup(map, &io_geom);
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
 		map_blocks_raid10(fs_info, map, &io_geom,
 				  dev_replace_is_ongoing);
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
 		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1)
 			map_blocks_raid56_write(map, &io_geom, logical, length);
 		else
 			map_blocks_raid56_read(map, &io_geom);
-	} else {
+		break;
+	default:
 		/*
 		 * After this, stripe_nr is the number of stripes on this
 		 * device we have to walk to find the data, and stripe_index is
 		 * the number of our device in the stripe array
 		 */
 		map_blocks_single(map, &io_geom);
+		break;
 	}
 	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,

-- 
2.43.0


