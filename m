Return-Path: <linux-btrfs+bounces-924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB928114F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1FE2827C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845682EB0E;
	Wed, 13 Dec 2023 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TnkfyvSy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21E124;
	Wed, 13 Dec 2023 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478588; x=1734014588;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fLhd1MyDh4ypvFhcwsIuuCtALl4S244wNQFfdcICrTg=;
  b=TnkfyvSyeA1/q3KeQOfhhAwE+wgaP92OoIltyfDnTByssZ5gjIy3h25L
   uvO6K+ktOEbb3awyY68/KlkNhXmsimTN5ijTgecgX+S2ncu1ycUSg3HKy
   Qq+jF6j5gXTVqjqG/ypIBtDpfUUKMx9tXeDJ8b2UDHKFyz9Qfq7bOKn9x
   Vnjq2RQNyjoevUO75flU2F5anIYVM7ujnevM4EBK6lwwOPi1rAbQZ5lkD
   4vIM9lJz9JEc8h3Fe8ZO7wwOYwLM27GDXjLRhnm17ovddDwh5JW5VUMwh
   QwmZQUTDaEPh+tjpIiRJOY/tsc0GeDjinCiPtgAoQ8brl76QJlN+D3nbM
   Q==;
X-CSE-ConnectionGUID: Q0HLwt5WQyaDShLA6+Wusg==
X-CSE-MsgGUID: SQicrwMvT6yJ0tCm29G4Xw==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802938"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:08 +0800
IronPort-SDR: /iXhflbgZ4L5W8cafBotModBWZbxixjgFWkRGvbVaMeO1VBbGOUfqIef2Vy46+y+27iF45zu91
 N4fOknyfYU+Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:20 -0800
IronPort-SDR: 3Aep+t61H4Om/uEMNGTfvo6ZNadHR51oXjbTWa4NG5rOF/mybzIYBSH4pOsgRX86BbnwI0WktF
 OS6Wue9ppxxA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:07 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:42:56 -0800
Subject: [PATCH v2 01/13] btrfs: factor out helper for single device IO
 check
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-1-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1998;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=fLhd1MyDh4ypvFhcwsIuuCtALl4S244wNQFfdcICrTg=;
 b=saGTUjHP3jWIxzIxSkKyDz3xz/OmV+KoocqSCfxxEIOuDJWVhwoNUXikb/s7rBbglCCsPfSnl
 yNM+B483/ppDSAVU0oIH9twkbNc07lWH9SFM1Bw+l/AldagqxAb3d52
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

The check in btrfs_map_block() deciding if a particular I/O is targeting a
single device is getting more and more convoluted.

Factor out the check conditions into a helper function, with no functional
change otherwise.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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


