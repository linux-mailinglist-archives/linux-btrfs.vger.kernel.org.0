Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA251C166
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380241AbiEENy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380207AbiEENyw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 09:54:52 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F857110
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 06:51:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135110euoutp01a7d585ebdd01639795b4d202d0d84349~sOcJa8-S23116431164euoutp01z
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 13:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220505135110euoutp01a7d585ebdd01639795b4d202d0d84349~sOcJa8-S23116431164euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758670;
        bh=OUOs5yoREFPm133MftqN/52v0OJCiB1b6vGYcsnZpfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uw/z6ktZDEetNfF04XYyIz4VfwwvEUOgly6aTcV3WrahzMVh2n8A8Vzh6qc2r32uB
         /ctoSuUTS69txG46Bu2tEF3RvO4pXU+XF5n+wHwyhAty9kpI+aC9wAsR81RciIuBVv
         z+APW0xdtsBJurULIbie7N+tmWgN6zZipyVE8sHU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505135108eucas1p1f497195530c192725734360b68b241fd~sOcH5PivL0606806068eucas1p1V;
        Thu,  5 May 2022 13:51:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AD.FC.10009.C46D3726; Thu,  5
        May 2022 14:51:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220505135108eucas1p295ecfd1113baa72d7522416a761a983c~sOcHZVNdK3188131881eucas1p2o;
        Thu,  5 May 2022 13:51:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220505135108eusmtrp27da582a3255e196cafcfad4d7d6cfedc~sOcHYhC4I2662626626eusmtrp28;
        Thu,  5 May 2022 13:51:08 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-43-6273d64cf082
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.03.09522.B46D3726; Thu,  5
        May 2022 14:51:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135107eusmtip1ff787df647b476670b2a8f0579b4cd21~sOcHG4JsC2664626646eusmtip1h;
        Thu,  5 May 2022 13:51:07 +0000 (GMT)
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
Subject: [PATCH v2 08/11] btrfs: zoned: relax the alignment constraint for
 zoned devices
Date:   Thu,  5 May 2022 15:47:08 +0200
Message-Id: <20220505134710.132630-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7djP87o+14qTDBYelLdYfbefzWLah5/M
        FpP6Z7Bb/D57ntniwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxWJly0Nmiz8PDS0u
        PV7BbnF51xw2iwltX5ktbkx4ymjxeWkLu8Wam09ZHIQ8Ll/x9vh3Yg2bx8Tmd+weO2fdZfe4
        fLbUY9OqTjaPhQ1TmT1232xg89jZep/Vo2/LKkaP9VuusnhsPl3tMWHzRlaPz5vkPNoPdDMF
        8Edx2aSk5mSWpRbp2yVwZez7u4W54LFAxcYlt9kbGO/ydjFyckgImEismHWNvYuRi0NIYAWj
        xJuPC9hAEkICXxglnt2Tg0h8ZpQ4ceUDI0zH1gdnmSASyxklVrz8DdX+klFi9+oWoHYODjYB
        LYnGTrC4iEA3o8TZ5jcsIA6zwCkmicarv5lARgkLREksmDKHGcRmEVCVuPzsH1icV8BKYvb6
        h1Dr5CVmXvrODmJzClhLzOl8yApRIyhxcuYTFhCbGaimeetsZpAFEgLXOCWOPz/OCtHsIvG5
        9yjUIGGJV8e3sEPYMhL/d85ngrCrJZ7e+A3V3MIo0b9zPdgLEkDb+s7kgJjMApoS63fpQ5Q7
        Sqy90MkCUcEnceOtIMQJfBKTtk1nhgjzSnS0CUFUK0ns/PkEaqmExOWmOSwQtofEm9d3mSYw
        Ks5C8swsJM/MQti7gJF5FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmDSPP3v+KcdjHNf
        fdQ7xMjEwXiIUYKDWUmE13lpQZIQb0piZVVqUX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZ
        qakFqUUwWSYOTqkGpqS+2d3z165RWxK/mkPzYnqJDX9CVE+TmuyO/VnCbwJXPb+ibKuzbuHO
        c/eveZTuNZjtF/n9pf/EHmtVGdZ/z3xbLace7LJvm7kkUfN7zfRNkw+e+pHWLpYTvbHMaLn4
        /gCjzwWlby18xQs0j9hb5zIwXSz4cuWy0nbm+uPbreVbJk/6/6DuxfsVaU1u8S4Vth/96iuj
        Mnujrm2qbdHgmdh8w3xp1XmnyMS4eZlrnfPmlzXMzP2gn74jmbs1+r6C8d/yuez823a/bbWq
        6PqwQsDQ1y2Qd866kFluL1fmXtgtNq06dVWo7IHCStfIv5/dp0VlmDjYsN1lSFrY0p75xeHE
        4cWywSxm01YxL9dRYinOSDTUYi4qTgQASdkUTgkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7re14qTDO5/trZYfbefzWLah5/M
        FpP6Z7Bb/D57ntniwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxWJly0Nmiz8PDS0u
        PV7BbnF51xw2iwltX5ktbkx4ymjxeWkLu8Wam09ZHIQ8Ll/x9vh3Yg2bx8Tmd+weO2fdZfe4
        fLbUY9OqTjaPhQ1TmT1232xg89jZep/Vo2/LKkaP9VuusnhsPl3tMWHzRlaPz5vkPNoPdDMF
        8Efp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZez7
        u4W54LFAxcYlt9kbGO/ydjFyckgImEhsfXCWqYuRi0NIYCmjxJZVR5ghEhIStxc2MULYwhJ/
        rnWxQRQ9Z5S423qBpYuRg4NNQEuisZMdJC4iMJVR4sJ2kDgXB7PANSaJhoe72EC6hQUiJD48
        vcgCYrMIqEpcfvaPCcTmFbCSmL3+IdQGeYmZl76zg9icAtYSczofsoLYQkA1Ex++Y4OoF5Q4
        OfMJ2BxmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFpXrpecn7uJkZghG87
        9nPzDsZ5rz7qHWJk4mA8xCjBwawkwuu8tCBJiDclsbIqtSg/vqg0J7X4EKMp0N0TmaVEk/OB
        KSavJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFprVKvd0bIWktb
        vjuHixwuPJRKsP25/7fhAr3o0icMtuKljVXVy3oTal3cX0zcrVjP5bx012LDFdpe69Z8WC9e
        aH9YI2+vqsmFu4KXvnr/Umj68PKWd+P/xvPhnsnZ/8/V2nw883jvie7Gb7UGpx8/Lnt6OOl5
        dGxX9BzTyUtdYkOm3D0hUqBUvXv95SxVHYtJz8X01jbf0a53Kz9bbqqUIc/iGcx7yZfv3PTO
        ICZr7R0H/P4wbmB49jHq+1PR44tCTXRtzogZBN8RZHBVV/ff1Ni6pufAUTEJnT+Gh9zqDsam
        SarUi25Qz12ofedu7dtT6meMNr3fueL+qxf7mffsytsuY1TDsEOC8ajF0jIlluKMREMt5qLi
        RAC0jTRDeQMAAA==
X-CMS-MailID: 20220505135108eucas1p295ecfd1113baa72d7522416a761a983c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135108eucas1p295ecfd1113baa72d7522416a761a983c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135108eucas1p295ecfd1113baa72d7522416a761a983c
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135108eucas1p295ecfd1113baa72d7522416a761a983c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Checks were in place to return error when a non power-of-2 zoned devices
is detected. Remove those checks as non power-of-2 zoned devices are
now supported.

Relax the zone size constraint to align with a sane default of 1MB.
This 1M default has been chosen as the minimum alignment requirement
for zone sizes to make sure zones align with sectorsize in different
architectures.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3023c871e..a6b15fbe1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -54,6 +54,13 @@
  */
 #define BTRFS_MAX_ZONE_SIZE		SZ_8G
 
+/*
+ * A minimum alignment of 1MB is chosen for zoned devices as their zone sizes
+ * can be non power of 2. This is to make sure the zones correctly align to the
+ * sectorsize.
+ */
+#define BTRFS_ZONED_MIN_ALIGN_SECTORS       ((u64)SZ_1M >> SECTOR_SHIFT)
+
 #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
 
 static inline bool sb_zone_is_full(const struct blk_zone *zone)
@@ -394,8 +401,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		zone_sectors = bdev_zone_sectors(bdev);
 	}
 
-	/* Check if it's power of 2 (see is_power_of_2) */
-	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
+	ASSERT(zone_sectors != 0 &&
+	       IS_ALIGNED(zone_sectors, BTRFS_ZONED_MIN_ALIGN_SECTORS));
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
 
 	/* We reject devices with a zone size larger than 8GB */
@@ -834,9 +841,11 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 
 	ASSERT(rw == READ || rw == WRITE);
 
-	if (!is_power_of_2(bdev_zone_sectors(bdev)))
-		return -EINVAL;
 	nr_sectors = bdev_nr_sectors(bdev);
+
+	if (!IS_ALIGNED(nr_sectors, BTRFS_ZONED_MIN_ALIGN_SECTORS))
+		return -EINVAL;
+
 	nr_zones = bdev_zone_no(bdev, nr_sectors);
 
 	sb_zone = sb_zone_number(bdev, mirror);
-- 
2.25.1

