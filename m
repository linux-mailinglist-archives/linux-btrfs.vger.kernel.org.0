Return-Path: <linux-btrfs+bounces-926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A3811500
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3671C210F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C82F846;
	Wed, 13 Dec 2023 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ckNXms9r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63690E8;
	Wed, 13 Dec 2023 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478591; x=1734014591;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DqGz1rYplJkgJR0SxwKCAVGZlaVGnSqeh82zQn3mpYM=;
  b=ckNXms9rfHbHwDnRz6oXwqykHduw6xaxeKdEDbv+gix1sMhv0n5HGPHn
   4Y0dYVHBgK+FEWtaK2GZtf2Xi7blsPGO7tqVz0BPonqQGwa2XivYkmAFG
   7N2Tvm4yYjd9o9TLE+9Jt/2m0gtJgjWCgQmJkP0RzGNyB2lA1S1eh1Rwn
   7YIpd+SzlLTQ+A+VYUda1Ial5CPZidsyxXsFVVAHcs/+AKAyfuvo/iEMi
   bZaE7I9400Btkx+Se9unzpzf3LAjVuD0JGfC5K88Sgb/5gAVQZOxD5do8
   j+5t+gkAuCpS3rNmCCEpbAwI91X+TqiyDj4DPDMMRU9D89u8DpeG7LLLU
   A==;
X-CSE-ConnectionGUID: G3elwU++R5S2CLMLHtBxgQ==
X-CSE-MsgGUID: 9aZGGctJTzKQeoUe90wQvg==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802950"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:10 +0800
IronPort-SDR: 0ZLJys326bWtX5l6B2E3V467+WDcPbPFazSB5KndUOnuS2UDE0Vh2GHjNzAPvlfu1N9j2TerD0
 ZBgW9JkMlGXw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:23 -0800
IronPort-SDR: mH4/02Fv0lKDus5ePvVTMvCY4GcsQCIgXfl0a07nDa7OLM8yWYJN+BahVF5sUpqok9FeqqBFgI
 HZ7YOqg1H1NQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:10 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:42:58 -0800
Subject: [PATCH v2 03/13] btrfs: factor out block-mapping for RAID0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-3-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1489;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=DqGz1rYplJkgJR0SxwKCAVGZlaVGnSqeh82zQn3mpYM=;
 b=xlbEMd1j1Wu9P6eCyo6iBXspLF9f3x7tz0e67tYGzF/xVt1F9OourzYw6O4kTvg138QGFZQWZ
 ObmXHrFmD1vCbvc33JVGokDB9k2YSuo0Of+JU6nWruJWmgT2YaYcG7X
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of RAID0, factor out a helper calculating
this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ea830ff0c0e3..1d2e6fb7b9bf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6363,6 +6363,15 @@ static bool is_single_device_io(struct btrfs_fs_info *fs_info,
 	return true;
 }
 
+static void map_blocks_raid0(struct btrfs_chunk_map *map,
+			     struct btrfs_io_geometry *io_geom)
+{
+	io_geom->stripe_index = io_geom->stripe_nr % map->num_stripes;
+	io_geom->stripe_nr /= map->num_stripes;
+	if (io_geom->op == BTRFS_MAP_READ)
+		io_geom->mirror_num = 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6450,10 +6459,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		up_read(&dev_replace->rwsem);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		io_geom.stripe_index = io_geom.stripe_nr % map->num_stripes;
-		io_geom.stripe_nr /= map->num_stripes;
-		if (op == BTRFS_MAP_READ)
-			io_geom.mirror_num = 1;
+		map_blocks_raid0(map, &io_geom);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
 		if (op != BTRFS_MAP_READ) {
 			io_geom.num_stripes = map->num_stripes;

-- 
2.43.0


