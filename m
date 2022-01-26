Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B769449CB3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiAZNqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 08:46:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46304 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbiAZNq3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 08:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643204789; x=1674740789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UPbNbk6XbOAxMUR6I7dXmX0UY6SHbv19zSTb0V2fBQ=;
  b=PQdudgH44RO33P+OzyVN+AEkGrqMVTGxukxp0iHvvPvtTasx3hBdQ4bN
   UwJZtUxqDWy8opuBOuzrkXgrSOIJst+/m35IXmwH/4U5h1xwa3CCvhMxs
   +41tKmrnOfsg5ymDdGfYfBd7uuPOlH6kPJ3ItCdua2S7KuSHoygMGERYk
   gR4KMQTJiUekxIc/TRWzLHT1lqaRnjvqsKpVWTa5++fWxmcJmBX+v8qGf
   UZL1U6jj+aoGnwtlnrDybv6jDftUxF9nFPq39e6z0FgETvQlP1UKQxLxC
   aDlGqMFKqNFFya/Nozu2yG81VOOzIPJD/4jmGuVHoYEQk2Z214ewW3G6b
   g==;
X-IronPort-AV: E=Sophos;i="5.88,318,1635177600"; 
   d="scan'208";a="190373110"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 21:46:29 +0800
IronPort-SDR: XXMcqI1OTnnRX/0r1PnsFhdobQJwvhFvzuJ6KAo91pVtyQ6a/Zkv2cJZK00uaO59svxF7tHfoB
 iC5Z/yQLvyF+Vn5ZuquBHf/Sx83iSXP/e4Fazuu13fAB9tJLW89CymnxaceojkTDHc54U+JHzS
 g/sgVW+uNOisv8/lP9pAsTphiwXd/OvsdtVYaZ6TD2knDqkhKuPOgj2bxd+QldZ/eEbJFWANoF
 iij4dcWNWLGPbMQRL2FyuF7w3HgFvbxTg1tsq6GvxmCLNtEtsTughIAIOPUStuV1Mf1+35H6ys
 u/AquL2pMARNblJr+RR774FI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:19:49 -0800
IronPort-SDR: ufe1au6SYi7Bd/dco99rnDEAG7rRNMzc1DNpyN2xoKV+RHYkNZ1TBoOWek6yn0CqNzO8cELVq0
 hn2MzpGr+zGOqCd6Gi4BLmc/cpo90SvUglAK8hZWpEJLYUyDL9lzt23/ygRnLnKSCYEN1eE1MF
 wmvrTsYraNzHo/R7cWIP1EX2qKAzetyhEm+wn6iavEBndZwbpKwVWEgswAyVmtC+cjEcXA1VHj
 EgPn5rE0i4G/haJ33RQ+aP1SrgAZoS92ksgEkKVaFHuRk05y+PQsWUCi1n9b8OTS2Y//FFw5Ug
 co0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 05:46:29 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: zoned: allow DUP on meta-data block groups
Date:   Wed, 26 Jan 2022 05:46:23 -0800
Message-Id: <971408f1ca16bdfd0af937b2fe7d8fcac6e61372.1643204608.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643204608.git.johannes.thumshirn@wdc.com>
References: <cover.1643204608.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Allow creating or reading block-groups on a zoned device with DUP as a
meta-data profile.

This works because we're using the zoned_meta_io_lock and REQ_OP_WRITE
operations for meta-data on zoned btrfs, so all writes to meta-data zones
are aligned to the zone's write-pointer.

Upon loading of the block-group, it is ensured both zones do have the same
zone capacity and write-pointer offsets, so no extra machinery is needed
to keep the write-pointers in sync for the meta-data zones. If this
prerequisite is not met, loading of the block-group is refused.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4f6f7afaa5a2..3aad1970ee43 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1419,6 +1419,42 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->zone_is_active = test_bit(0, active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
+			btrfs_err(fs_info, "zoned: profile DUP not yet supported on data bg");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (alloc_offsets[0] == WP_MISSING_DEV) {
+			btrfs_err(fs_info,
+			"zoned: cannot recover write pointer for zone %llu",
+				physical[0]);
+			ret = -EIO;
+			goto out;
+		}
+		if (alloc_offsets[1] == WP_MISSING_DEV) {
+			btrfs_err(fs_info,
+			"zoned: cannot recover write pointer for zone %llu",
+				physical[1]);
+			ret = -EIO;
+			goto out;
+		}
+		if (alloc_offsets[0] != alloc_offsets[1]) {
+			btrfs_err(fs_info,
+			"zoned: write pointer offset mismatch of zones in DUP profile");
+			ret = -EIO;
+			goto out;
+		}
+		if (test_bit(0, active) != test_bit(1, active)) {
+			if (!btrfs_zone_activate(cache)) {
+				ret = -EIO;
+				goto out;
+			}
+		} else {
+			cache->zone_is_active = test_bit(0, active);
+		}
+		cache->alloc_offset = alloc_offsets[0];
+		cache->zone_capacity = min(caps[0], caps[1]);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID0:
 	case BTRFS_BLOCK_GROUP_RAID10:
-- 
2.31.1

