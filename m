Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB951C167
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380210AbiEENyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380165AbiEENyt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 09:54:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7D57178
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 06:51:09 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135108euoutp011cf5908467b201799f81329332622c6b~sOcHdyQP43116431164euoutp01u
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 13:51:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220505135108euoutp011cf5908467b201799f81329332622c6b~sOcHdyQP43116431164euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758668;
        bh=LMzILViEYGl7DXa37dpeTA+tqVrqwK5EcVpc6Ix2yY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPGQ9j92/rr1enTM8W51HIe+iuZEr6A+pmjVyB7wTM9oQYKbiJDfLBmKJxgvr+u5d
         npf6DVf6mvZCT4debamywIdobwudx1L2C+Xeuk3k+NeDyd9YRWyd/NB7gcT9i76zY2
         PfUIAswbVhwRgza41F2Utlnk2O9/yPWlY5G3pKFM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505135105eucas1p1875318bd43e3622035711a71d689236f~sOcFcxcL70606606066eucas1p1W;
        Thu,  5 May 2022 13:51:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 60.BC.09887.946D3726; Thu,  5
        May 2022 14:51:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220505135105eucas1p1428258bde56a77a96d98509a2c0d5fe9~sOcFECa1e1070010700eucas1p1C;
        Thu,  5 May 2022 13:51:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220505135105eusmtrp19dbb21ab3bd151eb0520eaf17fcf130f~sOcFDNRxd1365913659eusmtrp1B;
        Thu,  5 May 2022 13:51:05 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-f7-6273d649daa6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.6A.09404.946D3726; Thu,  5
        May 2022 14:51:05 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135105eusmtip1f64a5a3601c119d85d57b328e28ec824~sOcEvSwAx2664626646eusmtip1f;
        Thu,  5 May 2022 13:51:05 +0000 (GMT)
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
Subject: [PATCH v2 06/11] btrfs: zoned: Make sb_zone_number function non
 power of 2 compatible
Date:   Thu,  5 May 2022 15:47:06 +0200
Message-Id: <20220505134710.132630-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7djP87qe14qTDJ4fM7dYfbefzWLah5/M
        FpP6Z7Bb/D57ntniwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxWJly0Nmiz8PDS0u
        PV7BbnF51xw2iwltX5ktbkx4ymjxeWkLu8Wam09ZHIQ8Ll/x9vh3Yg2bx8Tmd+weO2fdZfe4
        fLbUY9OqTjaPhQ1TmT1232xg89jZep/Vo2/LKkaP9VuusnhsPl3tMWHzRlaPz5vkPNoPdDMF
        8Edx2aSk5mSWpRbp2yVwZbz7vZWx4JBkxda7NxkbGD+JdDFyckgImEj83tfI0sXIxSEksIJR
        YvqRqWwQzhdGiQn3GpggnM+MEh+edDHBtDy9dgSqajmjxNOpB6D6XzJKrJ42C8jh4GAT0JJo
        7GQHiYsIdDNKnG1+A1bELHCKSaLx6m8mkCJhgQSJaauFQKayCKhKXPn5ghEkzCtgJXH4UDzE
        MnmJmZe+s4PYnALWEnM6H7KC2LwCghInZz5hAbGZgWqat85mBhkvIXCNU+Ldw43sEM0uEpOX
        PoSyhSVeHd8CZctInJ7cwwJhV0s8vfEbqrmFUaJ/53o2kCMkgLb1nckBMZkFNCXW79KHKHeU
        WPW7nRWigk/ixltBiBP4JCZtm84MEeaV6GgTgqhWktj58wnUUgmJy01zWCBKPCSe/ZebwKg4
        C8kvs5D8Mgth7QJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBCfP0v+NfdjAuf/VR
        7xAjEwfjIUYJDmYlEV7npQVJQrwpiZVVqUX58UWlOanFhxilOViUxHmTMzckCgmkJ5akZqem
        FqQWwWSZODilGpiS3r2UEZMXXphx7sB5tlsNtYumxq/R271kJaNBXH5rarqLxByhquUros2C
        n78UnysSZPlJ61SyufQOwS+Xi+VvM5r13v5aYuu59MPabRm/J5zV6Wbtvi063XzRmQs8f2L8
        HniE+59YKexp/1bZtl6l6ds9M0bt03dkd35R8XLd9fBf5tKZjC+1pz3v2DijYEYw70e2573O
        i5couPNOSbRke7jRytOZ6Wto/+8Zhp7vG+ov3voRuzhceM69iOTvh95efDwlaOnz0tQX742X
        8IcG2M9ue3O/s29XAWvVwVZPSebXywLeHmxhOzP/5lXN/YoBaien+Fwo/Gf8Is/u2Kdiy6l2
        z2/NZjhr8un+bWUpJZbijERDLeai4kQARM0GwgcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7qe14qTDE6vl7ZYfbefzWLah5/M
        FpP6Z7Bb/D57ntniwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxWJly0Nmiz8PDS0u
        PV7BbnF51xw2iwltX5ktbkx4ymjxeWkLu8Wam09ZHIQ8Ll/x9vh3Yg2bx8Tmd+weO2fdZfe4
        fLbUY9OqTjaPhQ1TmT1232xg89jZep/Vo2/LKkaP9VuusnhsPl3tMWHzRlaPz5vkPNoPdDMF
        8Efp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbz7
        vZWx4JBkxda7NxkbGD+JdDFyckgImEg8vXaErYuRi0NIYCmjxO8FO5khEhIStxc2MULYwhJ/
        rnVBFT1nlNj17w9rFyMHB5uAlkRjJztIXERgKqPEhe0XWEAcZoFrTBIND3exgXQLC8RJNNzc
        BjaJRUBV4srPF4wgzbwCVhKHD8VDLJCXmHnpOzuIzSlgLTGn8yEriC0EVDLx4TuwMbwCghIn
        Zz5hAbGZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucVGesWJucWleel6yfm5mxiB8b3t
        2M8tOxhXvvqod4iRiYPxEKMEB7OSCK/z0oIkId6UxMqq1KL8+KLSnNTiQ4ymQGdPZJYSTc4H
        Jpi8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmtTSvPQapMTFZ
        a80L1q2q63sTy3/SKfwQz5kn218+eL/j6X6ur7vurVx5SHnxfWsu8ykuJy9v2cp05+GUwu2c
        AS8+rU58sOBBivjKTK6e7zkW3ws+thX3KrCHBd9Pn+HGP+lwaYjex9zwKa9uuk4tXZBWdGBv
        764k1fncNwRfs11RnL+bX3LN1/OlqpVL+AKfr+ry6ChJ7WxpKhFesnTHs+lxyzL9wloETGK9
        Rc+bmj05v7omvWdL2WzfU9OXJSyZqKe4S1Pxc4XaJJbw46/XbQycxPmU+XjZz2USrJEs/80+
        MtRYSaY4+58QVjT2Wq3RKR5/x7nxi6fcqUjnzQl+Xh4rn+SriIUZHciILyhUYinOSDTUYi4q
        TgQAF6KNiXgDAAA=
X-CMS-MailID: 20220505135105eucas1p1428258bde56a77a96d98509a2c0d5fe9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135105eucas1p1428258bde56a77a96d98509a2c0d5fe9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135105eucas1p1428258bde56a77a96d98509a2c0d5fe9
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135105eucas1p1428258bde56a77a96d98509a2c0d5fe9@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make the calculation in sb_zone_number function to be generic and work
for both power-of-2 and non power-of-2 zone sizes.

The function signature has been modified to take block device and mirror
as input as this function is only invoked from callers that have access
to the block device. This enables to use the generic bdev_zone_no
function provided by the block layer to calculate the zone number.

Even though division is used to calculate the zone index for non
power-of-2 zone sizes, this function will not be used in the fast path as
the sb_zone_location cache is used for the superblock zone location.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e8c7cebb2..5be2ef7bb 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -34,9 +34,6 @@
 #define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
 #define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
 
-#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
-#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
-
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
@@ -153,15 +150,23 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 /*
  * Get the first zone number of the superblock mirror
  */
-static inline u32 sb_zone_number(int shift, int mirror)
+static inline u32 sb_zone_number(struct block_device *bdev, int mirror)
 {
 	u64 zone;
 
 	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
 	switch (mirror) {
-	case 0: zone = 0; break;
-	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
-	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
+	case 0:
+		zone = 0;
+		break;
+	case 1:
+		zone = bdev_zone_no(bdev,
+				    BTRFS_SB_LOG_FIRST_OFFSET >> SECTOR_SHIFT);
+		break;
+	case 2:
+		zone = bdev_zone_no(bdev,
+				    BTRFS_SB_LOG_SECOND_OFFSET >> SECTOR_SHIFT);
+		break;
 	}
 
 	ASSERT(zone <= U32_MAX);
@@ -514,7 +519,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	/* Cache the sb zone number */
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
 		zone_info->sb_zone_location[i] =
-			sb_zone_number(zone_info->zone_size_shift, i);
+			sb_zone_number(bdev, i);
 	}
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
@@ -839,7 +844,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
@@ -963,7 +968,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
-- 
2.25.1

