Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5079049C5BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiAZJEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 04:04:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42199 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiAZJEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 04:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187849; x=1674723849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rouKWkkQcl8ZIGdzy28HeaX/ROOskNgeXm0BKf5wDOE=;
  b=CzQXr4QamOExjemmu/rDz7nt4LecWz/f6ADySmn5jsKFK/Xj5wCO/eHU
   /6gW/8M2N6ykwVprVZTXGGlM8zRrgTb4VvWeOdLtbO99FxFOnfHh9HJJR
   tl4cvsZTp9lGmmgh7HKLxP0k0Wr34GOLYXGHNop5pxw0hW7ohgsj+iyz1
   7zW0HnyHWC6c6yfgliNOdLay3WkYZCsec6+8a1xT6nbTMAs1MIDaBZBRn
   7uyhczpffqPv2spWLiu2Lz+pELiayEidMcZxiMsompbAIJWU32OaDsgaO
   M4yFpuppwhEnfP1z2l9ev2byg5vMYuV1zvHSI66obBpkkBiJwAwZEoMMF
   w==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="190359871"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 17:04:09 +0800
IronPort-SDR: Pe+PpOLVz9YZ8EFNdJGNb2BXWxnV5gMcCiLwAqgQa0HQKRtiRCNTZCdOwROZcOAflxVwgRIb6q
 9arTXHFV2IvQbw157seH8LmFbXj2YhQfgaz89QJkGq1dYADN2bvb6GoIpt2vnsaT6Si8G2styO
 L40K/V2rkLsJ1Ldm4Ch/WbbwGDFtL0iDxo4u0if5GDb4jG38ocaUHQbxJSm2TdxdaYaw14YzQG
 N4xPeuJMFe5sz4QNn4OATl1efnQIrjMWgYnwzEdye3AFlwXTAzgmZsmvIcAw8B2FuPbwO6IjGv
 /VVthHicy+vh6dGlZXlOjMtA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:36:14 -0800
IronPort-SDR: b6o7RyzFnhUYFPtr06yBmAsdW570Q+AngvsuxMXHnzmrSjuYxvdIYRsjRBeOkXJQE6NeD8Lvfj
 1y+KCwbnm47FeeYaf6ao2yeINBmoum+JOjm0MGgAYlocXSG3pA4AvD/N6gr6p85bmc+5h7w+TS
 eTnirfwAeNuHkuLNoOvA+pKvk2zfx1ffm/eYoO9QkEcRn+TMVm7vRuznWrGtQ0efDHkn9QGzmR
 Qo3Cii4nJP9BxqcanHuiu0IAyln3LIPkXBNTGO4JeysB5chz45HDDFoxdne2URG24BbrGbTqxi
 zIo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 01:04:07 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: use profile_supported in mkfs as well
Date:   Wed, 26 Jan 2022 01:04:02 -0800
Message-Id: <20220126090403.57672-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
References: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we have two places checking if a block-group profile is
supported on a zoned device, one in mkfs/main.c and one in
kernel-shared/zoned.c.

Use the one from kernel-shared/zoned.c in mkfs as well, unifying all
checks.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/zoned.c | 2 +-
 kernel-shared/zoned.h | 1 +
 mkfs/main.c           | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 776576bc6c77..e6fd4b31b9d6 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -808,7 +808,7 @@ out:
 	return ret;
 }
 
-static bool profile_supported(u64 flags)
+bool profile_supported(u64 flags)
 {
 	flags &= BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index fbe9df8d9506..eedf20a79a6b 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -118,6 +118,7 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
 }
 
+bool profile_supported(u64 flags);
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
diff --git a/mkfs/main.c b/mkfs/main.c
index ce86a0dbdf42..78a5e8a0888f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1334,8 +1334,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (ret)
 		goto error;
 
-	if (zoned && ((metadata_profile | data_profile) &
-		      BTRFS_BLOCK_GROUP_PROFILE_MASK)) {
+	if (zoned && (!profile_supported(metadata_profile) ||
+		      !profile_supported(data_profile))) {
 		error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
 		goto error;
 	}
-- 
2.31.1

