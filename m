Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A652B61A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiERJR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiERJRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 05:17:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF21CFF7
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652865442; x=1684401442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eic1LlmqxIbArYc8QtA8cTpQ9RBcvw/rCcmaEUkC+6U=;
  b=mEWTm5m9py/NnYup94xqAnPSrV+vkNjojNQQMLT9rD41Ls5FBjE/FC0G
   rx32eKi4ExA34d5Usx9plXdwO0/4PwecftddsvsFibBZFyFkkq6fHXNlM
   XVLXXyXbB+J9hw52B+2S612fCovhN+BhiOPIdXMuu9+1C+gEEn80mLgSh
   fNH5OAeHWhUeE5NX3O5/ystBw0LCkQ9SNablRpaypOvZ59S7ZiHl0wBld
   Koqfhsjj4v8lEpwri7HgNWs9ffUxNGFVF5EtEFjUMgIvaO4tKbE5Y3cbY
   2ZGBtQ54cgWKJSudE0opIX/CTWHLmhO4TsnFaTiWm9Jbt3UKZlFQcrxom
   w==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201514748"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 17:17:21 +0800
IronPort-SDR: umq04vpoRgwO65U459Z1QnJw7MA1+qFS4jUgqsi8jGHpj7/JRpUkQfhky9lR120f9x3/6ii2zw
 Og9j9vLSviuL/OVzLACGlYXFsXzLpcNHpHCY29ZbB85A/dwmGuD8dYin+AT108I0f7v1Qg2HX7
 KEs62QonDpef5HcL5X3ZDCKdPSPNC1F5BkVxR886srXpIzr52qVwg2iNAYsc0ysQZLIVtgj5+S
 3o9zDhmwYDEmDTsBQX91TmbyBzx+GP39rlT1iqzsPZM4kP3uExj1TIUqXqBZQCQzqH//QE8NnA
 nk4Li9UIk9ZJQlo5ogeR1/6l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 01:40:24 -0700
IronPort-SDR: C4G0NsdmP0zxw/m3uNoPV/lqzYIMUMeEMpj/fTb0qZky0B2LOfJ+eZ94DzxAhS9GCf1GKTOF6d
 3R9vjJn5vkZan8HUDpQlzIAhcrV18kBNdc8iZmgEbhjJCQ3+4CrruD7anqdABQFlSddtklLd6a
 7ujk8KXG9QIlMtcXxTD33HPcqxD4FyWh1rw0uK2z7efyIdUmMVtJc+pIsKO352bRvtuF+aRo8U
 tAsQfn2YkCEmGGb4ZXTrcs9SEdbxIgivWmPt4reFfdvIK0Lj3DjEeF5IM1cEHaGws3Q92U25GE
 qFM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2022 02:17:20 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 4/6] btrfs-progs: allow zoned RAID1
Date:   Wed, 18 May 2022 02:17:14 -0700
Message-Id: <20220518091716.786452-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
References: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/zoned.c | 20 +++++++++++++++-----
 kernel-shared/zoned.h |  4 ++--
 mkfs/main.c           |  4 ++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 396b74f0d906..7d6f4357ea9a 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -775,7 +775,7 @@ out:
 	return ret;
 }
 
-bool zoned_profile_supported(u64 map_type)
+bool zoned_profile_supported(u64 map_type, bool rst)
 {
 	bool data = (map_type & BTRFS_BLOCK_GROUP_DATA);
 	u64 flags = (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
@@ -784,9 +784,18 @@ bool zoned_profile_supported(u64 map_type)
 	if (flags == 0)
 		return true;
 
-	/* We can support DUP on metadata */
-	if (!data && (flags & BTRFS_BLOCK_GROUP_DUP))
-		return true;
+	if (data) {
+		/* Data RAID1 needs a raid-stripe-tree */
+		if ((flags & BTRFS_BLOCK_GROUP_RAID1_MASK) && rst)
+			return true;
+	} else {
+		/* We can support DUP on metadata/system */
+		if (flags & BTRFS_BLOCK_GROUP_DUP)
+			return true;
+		/* We can support RAID1 on metadata/system */
+		if (flags & BTRFS_BLOCK_GROUP_RAID1_MASK)
+			return true;
+	}
 
 	/* All other profiles are not supported yet */
 	return false;
@@ -903,7 +912,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	if (!zoned_profile_supported(map->type)) {
+	// XXX: not sure how to do yet
+	if (!zoned_profile_supported(map->type, true)) {
 		error("zoned: profile %s not yet supported",
 		      btrfs_group_profile_str(map->type));
 		ret = -EINVAL;
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index cc0d6b6f166d..c56788bcf07b 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -132,7 +132,7 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
 }
 
-bool zoned_profile_supported(u64 map_type);
+bool zoned_profile_supported(u64 map_type, bool rst);
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
@@ -213,7 +213,7 @@ static inline int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices)
 	return 0;
 }
 
-static inline bool zoned_profile_supported(u64 map_type)
+static inline bool zoned_profile_supported(u64 map_type, bool rst)
 {
 	return false;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index a603ec5896f3..46dbc4c0c363 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1424,8 +1424,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (ret)
 		goto error;
 
-	if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
-		      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile))) {
+	if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile, runtime_features & BTRFS_RUNTIME_FEATURE_RAID_STRIPE_TREE) ||
+		      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile, runtime_features & BTRFS_RUNTIME_FEATURE_RAID_STRIPE_TREE))) {
 		error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
 		goto error;
 	}
-- 
2.35.3

