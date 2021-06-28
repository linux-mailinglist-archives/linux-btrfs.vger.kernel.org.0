Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE33B6891
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhF1SjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 14:39:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31228 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhF1SjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 14:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624905416; x=1656441416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TBDDAC9ue6mAL81DnuVSFJCLwtpckIJp3QGjZ4MudEk=;
  b=hcClAi2rq53qmzqMzUKRrBfogEyDzHjPYitz/zRuMHJi3PMzTtKa/Gr4
   qlLvr08brU++SkVPjC9y6FDBVXa3PNkLhiUtMG/TL9pDKo4k9oOzn/Bjs
   OmkINKRREjUTCsJmj7u37EAsEcTIdd5FW5ajZXpR8mCKxQpR9RyA5KCgX
   W/DLmMyKWcnpvC764B05h52sn6HY8aNUFck9jCvMCAYWx4CgkdPNBHjVm
   bYq/Tl6U9VXRplxPWUX0XVndawBgXFeWEANF3SBcNI2708jl5TqiqLQh1
   e9rQh5UrZqq1NJenlhzIu6wb8NxNtD3tzS7X+d51KfgVmN1OCcMNF5au8
   Q==;
IronPort-SDR: ZdgNUWJQ1c4ujEqDXfwQJe0+2tcA5qfmiQ2GDyr9JX7Fooe8+oaR+ylWCyBL1Y8ikG2NxpZieW
 tOfcML/UEHLdVdjhWRBUFtAmvoKn5R0+HG+edhZOo++JFONre82Jmtv17Tb2TY8o+x6v3No5i4
 KvquDQ6quazyIeJijC1yNH7J/91tQV+bD+a6HlT0FKtwnCIzzm6ExBIwiCtEMbMNyvCE29+OVh
 t8eFdirQMiekOk70GzYBk9wm9YU0zTp3vh05w4xnnRMdm1mI0+Xv2dwY2wCZZPKWDfO4U2Lcx/
 53s=
X-IronPort-AV: E=Sophos;i="5.83,306,1616428800"; 
   d="scan'208";a="173692933"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2021 02:36:55 +0800
IronPort-SDR: 8pNB1SA9TsWjW/1BzEVWYCBxaz7Jgwe6PcbePLAYBg7BNlR257cj5mmdEofcllq847FcIEYoGi
 kW1OufvE2+ZBkx/jxyY6/bHk5gRCOcjVxWZOTfBcl3E8E+6nykyhiRvUIsm75oV0YvGtkCRrdu
 mU9v1pGKEpiH2C9slcYCZZXO/p9oH76nhTYE4b5BXFBgmWpjM34khOQ/03jT+iofy8hMbMZGby
 fFm3Fd3t1l6Uu+XWz5EmeeYlorRdS/EiYE5EGdzQSALCqG0PNY6gxlnTTgItMySpSfm3AkFJhZ
 P5/3Ig1Bj4lhgzc5T9A6fT/Y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 11:15:23 -0700
IronPort-SDR: kzzJiwK52X8DFBVMrCcptiV/bFjcjKTioxJqKbsLPCQnn5jCT9TdWzCPkPAsCwvQR9MkWTQEFP
 SkvwFOxKuuGibWPj5E+5ysdtkHrqpiuHnR3x0R19lsvAEBBNSEUzXSFtikTQPImfKSm2Xza1yp
 mhxpqNYcdK6grupwt5QKSb42+5hVY+XyeLsyBzK7kzoP9BZ2ygS9qMKvr++8clRATUniLrZgDS
 FP0UBVkyODKy3lkjSxmrhNtQzGEXNLMlnyWpN+ptyNo0G68Tx2X+D3PfxRQMGGj9uXDJDOtdvs
 6wc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2021 11:36:54 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Date:   Tue, 29 Jun 2021 03:36:45 +0900
Message-Id: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove fs_info->max_zone_append_size, it doesn't serve any purpose.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
- also remove the local max_zone_append_size variable in
  btrfs_check_zoned_mode() (Anand)
---
 fs/btrfs/ctree.h     |  2 --
 fs/btrfs/extent_io.c |  1 -
 fs/btrfs/zoned.c     | 10 ----------
 3 files changed, 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d7ef4d7d2c1a..7a9cf4d12157 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1014,8 +1014,6 @@ struct btrfs_fs_info {
 		u64 zoned;
 	};
 
-	/* Max size to emit ZONE_APPEND write command */
-	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e81d25dea70..1f947e24091a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3266,7 +3266,6 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 		return 0;
 	}
 
-	ASSERT(fs_info->max_zone_append_size > 0);
 	/* Ordered extent not yet created, so we're good */
 	ordered = btrfs_lookup_ordered_extent(inode, logical);
 	if (!ordered) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 297c0b1c0634..76754e441e20 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -529,7 +529,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
-	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
@@ -565,11 +564,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				ret = -EINVAL;
 				goto out;
 			}
-			if (!max_zone_append_size ||
-			    (zone_info->max_zone_append_size &&
-			     zone_info->max_zone_append_size < max_zone_append_size))
-				max_zone_append_size =
-					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
@@ -619,7 +613,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
-	fs_info->max_zone_append_size = max_zone_append_size;
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 	/*
@@ -1318,9 +1311,6 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	if (!btrfs_is_zoned(fs_info))
 		return false;
 
-	if (!fs_info->max_zone_append_size)
-		return false;
-
 	if (!is_data_inode(&inode->vfs_inode))
 		return false;
 
-- 
2.31.1

