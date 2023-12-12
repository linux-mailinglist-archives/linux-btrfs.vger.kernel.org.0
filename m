Return-Path: <linux-btrfs+bounces-853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD06880EC0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD0BB20CFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0615FF12;
	Tue, 12 Dec 2023 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gbbt9rz3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800A10C;
	Tue, 12 Dec 2023 04:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384696; x=1733920696;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Poy7kvGZE2juSHXFRnwi+t2LcQTptZvXl+fIR2CJQao=;
  b=Gbbt9rz3hmobQgifqcHxPpqzLrCjwXCAfrUmiKVuEIIxpmfbiHxa1H15
   amCQuOHNLwVHYf69T+LBof0YupLyHME3St6RFW/A1WkUN2JuxW0iNptIH
   JBB0P7biZwTs3oBi3vRxWSXM0mWwiom9jUzn4xI/F+odiZsJpm0HQO6zP
   Txs7WmBGjQPtm0K3Kk6Wjj3MMzrNMgcB7pO4EUBNXHsv4xEjA1YRFZt61
   +Qs/7OdYDwZ/rQSeOvYXrfG8y9tJm/+AoaE+X0u/PmZxZ763jlTlMpoih
   nmFQQVDBxfP/Nzxmh46Y+XwqvJCHifxs+Mkum90XTUDQXKAeba/FORC5N
   Q==;
X-CSE-ConnectionGUID: Dc1luYC5TPqbW69VnjGZtQ==
X-CSE-MsgGUID: C7rufPamS+2oUgir46Oy4g==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629786"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:14 +0800
IronPort-SDR: fWB3rHOB2x8AJctoYVrruqCvm/BR9kOPdTw2sd8gRak3RfUxwAwWH0q4m56BLJ5HClB7fZNVfl
 M05RYLG8OhCQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:27 -0800
IronPort-SDR: fhUeR6/hDirl0xmEVTtn/EHzTfiTR86jI28zwK+5PBLCGZOwqHoY3FFu5+SoxSo4cedD4YNxZD
 ZV0FNzkfl19w==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:13 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:37:59 -0800
Subject: [PATCH 01/13] btrfs: factor out helper for single device IO check
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-1-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1953;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Poy7kvGZE2juSHXFRnwi+t2LcQTptZvXl+fIR2CJQao=;
 b=tdbqfIMC7FsCjaWlWYQTNAYg00mwmNnZLJZ1jukrQz3iG8+Ly1UxlQnl/aQRsgJrOyEUYMdWv
 RcMUrLxBT9yAGBTzKHf34GVMLDNvUUXlpOKg2HY7GlEk7vG9VY7ErE9
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

The check in btrfs_map_block() deciding if a particular I/O is targeting a
single device is getting more and more convoluted.

Factor out the check conditions into a helper function, with no functional
change otherwise.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cc6b5d5eb61..1011178a244c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6330,6 +6330,28 @@ static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return 0;
 }
 
+static bool is_single_device_io(struct btrfs_fs_info *fs_info,
+			      struct btrfs_io_stripe *smap,
+			      struct btrfs_chunk_map *map,
+			      int num_alloc_stripes,
+			      enum btrfs_map_op op, int mirror_num)
+{
+	if (!smap)
+		return false;
+
+	if (num_alloc_stripes != 1)
+		return false;
+
+	if (btrfs_need_stripe_tree_update(fs_info, map->type) &&
+	    op != BTRFS_MAP_READ)
+		return false;
+
+	if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)
+		return false;
+
+	return true;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6532,10 +6554,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * physical block information on the stack instead of allocating an
 	 * I/O context structure.
 	 */
-	if (smap && num_alloc_stripes == 1 &&
-	    !(btrfs_need_stripe_tree_update(fs_info, map->type) &&
-	      op != BTRFS_MAP_READ) &&
-	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
+	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op,
+			      mirror_num)) {
 		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
 				    stripe_index, stripe_offset, stripe_nr);
 		if (mirror_num_ret)

-- 
2.43.0


