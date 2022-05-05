Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D051C17C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbiEENyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380158AbiEENyt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 09:54:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2167257154
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 06:51:08 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135106euoutp0293ae4cc5a844621ec56cfbd805652267~sOcGV5_s92896128961euoutp02g
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 13:51:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220505135106euoutp0293ae4cc5a844621ec56cfbd805652267~sOcGV5_s92896128961euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758666;
        bh=U9RzqUijJL5PmqUeIybgHDju5FpS85GPewMJfUjtd+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPWKeMJIpkJOy0x1P/dHwOmblPG0gu4RALHmksy8KWJiUQKERa2jZr8De2iG9PaUX
         2Y4BC+MztqPmwrd+NJX7pBw0Zw+G7hOcM5LLNTyy+nUZRLreB4B9FkD86i4TyWu480
         SF9ecUMc/bX2PZNjm3LWvjK9Lv5zDqmDLBRBxn5w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505135104eucas1p1f7413241441378ad3d8a2fcbfb72bd5d~sOcEh4oMU0188401884eucas1p1X;
        Thu,  5 May 2022 13:51:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 19.FC.10009.846D3726; Thu,  5
        May 2022 14:51:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220505135104eucas1p1bed3e1e47255518296b4cb15ec0c042b~sOcD8lxBw1068810688eucas1p1D;
        Thu,  5 May 2022 13:51:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220505135104eusmtrp1758e1912f2f38f38511d760a6d5554ac~sOcD7cTl01310613106eusmtrp1O;
        Thu,  5 May 2022 13:51:04 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-37-6273d6484bb4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.6A.09404.846D3726; Thu,  5
        May 2022 14:51:04 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135103eusmtip1f8faf002ab4e89d5bdd4994a68da949b~sOcDjxkyl0093500935eusmtip1H;
        Thu,  5 May 2022 13:51:03 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org,
        hare@suse.de
Cc:     jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] btrfs: zoned: Cache superblock location in
 btrfs_zoned_device_info
Date:   Thu,  5 May 2022 15:47:05 +0200
Message-Id: <20220505134710.132630-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTGfe+9vbdtqFxaEl5xbqMLJrgBEvfxjk7ncH/cxMRtMVnGyGBF
        b4BZSm2tOnCjjAJSCNSiTrrK2Ijho12KgIayZTTEKisirp0MxmjtBEQo+IENMpTNclnmf79z
        zvO8zznJy8fFIV4sP095iFUr5QopKSQuXl4aSmSGNdlb+z0IWcdrSXT63hKOTLVnKLQ8OISj
        649KMDTqdGDop+9NGGq1ujA0YTfjqNp5j0Ct+gCOHgdSkOdWC4W8PRYSGctDOBoxTgK0cE5P
        IdvoJLFTzHh/282s9NtI5kTpPMU4zOMU4x3UMh1tlSTzne4Uzvw4qiMZR5mfx9R0tQHG3nWD
        YDoHihhj53kes9DxPFPhrMLej/xY+NZ+VpF3mFUn7/hUmPvIN0SonDFH7fMGUgeaJAYg4EP6
        VTgVdJMGIOSL6RYAl275MK54CGCTq4viigUAG9zXgQHwVy2Lpte4fjOAM1VNvPBTYvoOgHWW
        3LCGpLfAkspVbzRdBeBgaZAIFzjtxmDJjWUsbJDQmXC2/T4ZZoKOh1PdvtW+iE6Flxr0gNvv
        BVjvWaTCLKBl0FIZ4HGaKPhL/QQRZvyppvTCN3g4ANLDArjw2I9x5nehP/Q3j2MJnLnSRXH8
        HByoqyY4LoKTI8trZj2AtQ47yZ0pgzVXFWHE6QRo70nm5O/AwK8VFKdYD0fmorgV1kPTxa9x
        ri2Cx8vFnFoKHUsTa6EQer+yrIUy8KytmzKCOPMzx5ifOcb8f24jwNtADKvV5OewmhQleyRJ
        I8/XaJU5SfsK8jvA0585sHLlQTc4O3M/qQ9gfNAHIB+XRot2nVNli0X75Z8XsuqCLLVWwWr6
        wEY+IY0R7ctrl4vpHPkh9gDLqlj1f1OML4jVYXtsBccSjkxFpEepei6kespkd2CWZTH2ZRTX
        2XhTmPx6wI9OGRLnyuRWyQeZ2VaZm93c/0dkb/Oid2+cRFmwzcyyXu+yaad02/RYS8ZejWu3
        +KTi/IsZvwdrXpquAzZj5J55kODemn4gmNZ88IEhq6JY5TlmDgzL7HDdpeLZXeb3BNX9bzcY
        bwa+OLwhOLdjMuL4l77QmCv0kFf8oS0xPm2TuP3o9NiJH64ND/7F9r6xPdN/0Hk3Q9c6p484
        U1n/JCl+dv6T8Uh8pTCeuazoTV33bUXhRp+16Pabd8dv//Pzyc3Rrwj1wavaP4Xo2meEKn36
        o6wNovLUiOy0xoHtrEtKaHLlKVtwtUb+LxISiIcIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7oe14qTDE5O5bNYfbefzWLah5/M
        FpP6Z7Bb/D57ntniwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxWJly0Nmiz8PDS0u
        PV7BbnF51xw2iwltX5ktbkx4ymjxeWkLu8Wam09ZHIQ8Ll/x9vh3Yg2bx8Tmd+weO2fdZfe4
        fLbUY9OqTjaPhQ1TmT1232xg89jZep/Vo2/LKkaP9VuusnhsPl3tMWHzRlaPz5vkPNoPdDMF
        8Efp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfy4
        d56l4IB4xfp3XWwNjIuFuxg5OCQETCS+TzLtYuTiEBJYyiixesNNpi5GTqC4hMTthU2MELaw
        xJ9rXWwQRc8ZJX5fbWUBaWYT0JJo7GQHiYsITGWUuLD9AguIwyxwjUmi4eEuNpBuYYEYiT/v
        FrKD2CwCqhLPdtwD28ArYCVxZF4L1AZ5iZmXvoPVcApYS8zpfMgKYgsB1Ux8+I4Nol5Q4uTM
        JywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzC+tx37
        uWUH48pXH/UOMTJxMB5ilOBgVhLhdV5akCTEm5JYWZValB9fVJqTWnyI0RTo7onMUqLJ+cAE
        k1cSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwFSZWqW8un+6uf/m
        7zvT2ri/vsq4tHHVtbt+n3PnCJiUGn1ZG/Zs3s6iv0dU9+9JMPJU7RB1yJn7wDt/JZ+dzGZn
        87N79v5J1HV9fFxS5QpT8Yf1x7Ttnhj6cB/W32/8drKhiXHn75SIXRa5D6Mmsbx9q9Z4Nqne
        vs6pVtxTfjfHnSAD9aO63CGsnX9Fz6Yk6d3xbVqbMPtFinCtnJXS3Vetj3l3aa09sq6meHL8
        NJ0qiUAzibyr73ua+Arfbtzmc+78f/FHSw41Zh66+maa47oDvQc+zRU5uXjaHtPKCa2ztvFn
        Lk05titzc5Jx2fefCzWOLdP7J3fg6sRVfO0cG0NP7VpXusDlV1jBoatHvScpsRRnJBpqMRcV
        JwIA3qSA/ngDAAA=
X-CMS-MailID: 20220505135104eucas1p1bed3e1e47255518296b4cb15ec0c042b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135104eucas1p1bed3e1e47255518296b4cb15ec0c042b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135104eucas1p1bed3e1e47255518296b4cb15ec0c042b
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135104eucas1p1bed3e1e47255518296b4cb15ec0c042b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of calculating the superblock location every time, cache the
superblock zone location in btrfs_zoned_device_info struct and use it to
locate the zone index.

The functions such as btrfs_sb_log_location_bdev() and
btrfs_reset_sb_log_zones() which work directly on block_device shall
continue to use the sb_zone_number because btrfs_zoned_device_info
struct might not have been initialized at that point.

This patch will enable non power-of-2 zoned devices to not perform
division to lookup superblock and its mirror location.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 13 +++++++++----
 fs/btrfs/zoned.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 06f22c021..e8c7cebb2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -511,6 +511,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 			   max_active_zones - nactive);
 	}
 
+	/* Cache the sb zone number */
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
+		zone_info->sb_zone_location[i] =
+			sb_zone_number(zone_info->zone_size_shift, i);
+	}
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
@@ -518,7 +523,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		u64 sb_wp;
 		int sb_pos = BTRFS_NR_SB_LOG_ZONES * i;
 
-		sb_zone = sb_zone_number(zone_info->zone_size_shift, i);
+		sb_zone = zone_info->sb_zone_location[i];
 		if (sb_zone + 1 >= zone_info->nr_zones)
 			continue;
 
@@ -866,7 +871,7 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 		return 0;
 	}
 
-	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	zone_num = zinfo->sb_zone_location[mirror];
 	if (zone_num + 1 >= zinfo->nr_zones)
 		return -ENOENT;
 
@@ -883,7 +888,7 @@ static inline bool is_sb_log_zone(struct btrfs_zoned_device_info *zinfo,
 	if (!zinfo)
 		return false;
 
-	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	zone_num = zinfo->sb_zone_location[mirror];
 	if (zone_num + 1 >= zinfo->nr_zones)
 		return false;
 
@@ -1011,7 +1016,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 			u32 sb_zone;
 			u64 sb_pos;
 
-			sb_zone = sb_zone_number(shift, i);
+			sb_zone = zinfo->sb_zone_location[i];
 			if (!(end <= sb_zone ||
 			      sb_zone + BTRFS_NR_SB_LOG_ZONES <= begin)) {
 				have_sb = true;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 10f31d1c8..694ab6d1e 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -27,6 +27,7 @@ struct btrfs_zoned_device_info {
 	unsigned long *active_zones;
 	struct blk_zone *zone_cache;
 	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
+	u32 sb_zone_location[BTRFS_SUPER_MIRROR_MAX];
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.25.1

