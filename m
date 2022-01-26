Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6E49C5A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 09:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiAZI7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 03:59:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42046 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbiAZI7q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 03:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187587; x=1674723587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1cUaiDcfbSiGq3krcKECh3PAsXKRPRXty879J9R5JQ=;
  b=SEBwxEjqBWPh0PurUoIrFfWI/o+z9k13iNK7Ln9YTE5lg9rkwqqNeSSD
   CM2i+StTN0m2aRZLJH0gOavMGbFUR9Uv9QcCNaDj4tTcVPxm5JPoKhgu2
   S/bkRvWnRJxQai7bxxMxkNdVd0vUZVCu5rQxqKMXdeL6t61T8JEG0Fhtb
   QAQPNjbOyF8wIlDuG6Pt1f657ezhfXzt4lezKTD88EQAkU6jgLzkyl9Is
   E6kqoBdKmuhvGYZQtj5Aaz9D0cCScrjXcvGcz6rl1KUz5nxjzoEUyZZU1
   ZDpjLclxo8DYTvc/nhwT+ZpvfivfazrcWEIOc6i0lDAmYd0vM3/NxD1xm
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="192406588"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 16:59:47 +0800
IronPort-SDR: pWUvseSmXN+/JmBpc6yQ7PN8mMHBG0eEbrg6HRuy9TtZqQtkJKtY3ns3Rv6inBBMhFGOwog4Ru
 QJnbzO9tDST1HGSKuSKVGeyENF5OVA1CvsOruQeqA6pncOro4MijOU7HtzcrpuDRjIkj5MrDx/
 o6bckMS9HBCanc6j6n19zrd22gLWb7lOdNfhVProNJEvv/AEcjVVR+nErGtGqcA6Jbd/499xwy
 nMJDmjzULgh2R7inoUnYitsHjdMalaBPZgVaX+YJaW3wUt6TqFLh/N9RZjaAhORGhj55OAaT96
 TRT1FigqkEf3lmgvbC06Y9Od
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:31:51 -0800
IronPort-SDR: luVsi5dmcqMkKxIPmk7t3pdHvrYwp+Qg43k+vPTErpu9Q0ek83xfTrqWMYJ0v2qc5v5yHfyDbx
 6jRkTPv8LdNldKq2HfdyTiifGfaPoMNYUY5LCgy3GaJpk+45nsFLmfikO0WD1ta8Mj2hcKPNL5
 k2nPwS8fqlyS4SBy4keeoGHjGSH2x0J6rZ80qZO8nevMfeodZ/zFs7LRma7YgTaAPTjGmVSDrn
 MBDaOjwxyj7/BQae69dZmiGAwAQvLs2ffBrrUc4bsLgudgSMqosR3ipTUhs7DcNYLkisuTr7zW
 0Vg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 00:59:46 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: zoned: allow DUP on meta-data block groups
Date:   Wed, 26 Jan 2022 00:59:33 -0800
Message-Id: <efd93259ab5d36c96e1064fa07e19033ae2157f4.1643185812.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643185812.git.johannes.thumshirn@wdc.com>
References: <cover.1643185812.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/zoned.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4f6f7afaa5a2..39fc5487e78c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1419,6 +1419,40 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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
+			btrfs_err(fs_info, "zoned: active zone mismatch");
+			ret = -EIO;
+			goto out;
+		}
+		cache->alloc_offset = alloc_offsets[0];
+		cache->zone_capacity = min(caps[0], caps[1]);
+		cache->zone_is_active = test_bit(0, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID0:
 	case BTRFS_BLOCK_GROUP_RAID10:
-- 
2.31.1

