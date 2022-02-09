Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071284AF595
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiBIPm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 10:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiBIPmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 10:42:25 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D5DC0613CA
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644421347; x=1675957347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bnp+OYoN4Ldbqq1PGct3hiFAjvME22Z3lnMNx7DFNas=;
  b=Fhps7ZEBolNK0aE5RCwWybbsp5P8w8RCgNU15zrrLuFpfwh39ZVqyYUq
   F0UJLEvVBpHbBwGOO6LBU054tAoeah2/Y7tvLiN317Cggb3g6kXz+ohyO
   cret5cgx90JdlPKNdQO334pb9wCop3LgudMrDPJ4C8gTEpOB5rw9gnJSa
   hBpQjm8QX9M8G9FSbV8bmAFsTPZoP3cS7mgxsftgPusQpvaRfkaKwuv8i
   c6ici5kLxwgHpPAaveHsngJ4I5d412rNS4cINKie5XSseXxLRqOIYHEB/
   MGGynr6jwRI/35iJvj88pSlUQXDorfdxa/gV0VonFonXAPk5yGFdf9TdY
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,356,1635177600"; 
   d="scan'208";a="197334818"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 23:42:27 +0800
IronPort-SDR: axV/SOmuhuTJMSu/vtabQaoKI1M8sr7HNyTIMggQ9qqr6RVwUtQVCLrGGxSzZjgEcYo0AUhS+h
 VO7UNyE4M6jYoARjubU/JLHfgtznVYtoqmGY/QG5n11NyKxChdMgK1bBhNVnidWkUDQ7ZDEhOB
 aS1OjOyH6/eo2Tq45LxI4v7OI+s0L6dtS8HxLlpBp+6EgqWgu0U1cA/GhmNDkWJZNRZsT+VXlw
 B1kojTRW/rC2c9M3dOJqoTBKFzuC70yMQChP3cfngFd4z+0m3J+wN9Q7M1la1qjV+/V5GN4HPU
 9h1+0D4cuQ3REtVbmUxQ8CWj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:14:16 -0800
IronPort-SDR: dBqvdmzloRgxjwSQQJrd2qtxAsd5ZzyHiJVudNWK7Xd2NUFgSG1KflQy9ov8rRcoKIEWdUOWaj
 9ZZgrYAlU2kLkBeUmdt+PDr6Mn8hYeEIAGR7+k/M/Jk/dhRduPhfYeNWqlSQXNId1KnROWj3hY
 RmsWHSX0EYVS4xPcpYdcC45xCJEBbmhkE2vKjLb89GDnO4MkYnieNrotklOURnoEHbL0NnABPs
 RyiTKlnGPCs9OE3oH1xa8CE24NPUKNQan/DnwQDlgJ2Zf+5MlLzgta5hrWcCIsiI8GUY0rPzny
 ulg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 07:42:27 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: pass in block-group type to zoned_profile_supported
Date:   Wed,  9 Feb 2022 07:42:18 -0800
Message-Id: <20220209154218.181569-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pass BTRFS_BLOCK_GROUP_DATA and BTRFS_BLOCK_GROUP_METADATA to
zoned_profile_supported(), so we can actually distinguish if it is a data
or a meta-data block group.

Fixes: 8f914d518a46 ("btrfs-progs: zoned support DUP on metadata block groups")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/zoned.h | 2 +-
 mkfs/main.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index ebd6dc34c619..db7567d02742 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -118,7 +118,7 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
 }
 
-bool zoned_profile_supported(u64 flags);
+bool zoned_profile_supported(u64 map_type);
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
diff --git a/mkfs/main.c b/mkfs/main.c
index e6c4eb1f9b93..f9e8be748c5a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1349,8 +1349,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (ret)
 		goto error;
 
-	if (zoned && (!zoned_profile_supported(metadata_profile) ||
-		      !zoned_profile_supported(data_profile))) {
+	if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
+		      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile))) {
 		error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
 		goto error;
 	}
-- 
2.34.1

