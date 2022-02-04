Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB34A95D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 10:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiBDJPt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 04:15:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:20064 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbiBDJPs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 04:15:48 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220204091547euoutp02c1f67bbc1bc38fec2b92931b5f327311~QioAx-YQa1911019110euoutp02T
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 09:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220204091547euoutp02c1f67bbc1bc38fec2b92931b5f327311~QioAx-YQa1911019110euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643966147;
        bh=57FhaSA3qXc674wdsEhFOmOw/bENLrQvbnGtIQ1/58w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=k3Q/bAnC71ci9yM0mdMCDUtYIAui0mXx3H/7Aeqg/hVF0hHGJ95f12l2SqqWxfVUY
         T5cUv4y2Jji3NTU/C5VXhhI9yZjVf9Kw2deDDpnVEVWjJuoIlleuuMj2lITsR2iF2M
         iaax/ptUIrkDCUHretMxW6ypxXJbO1taup82mQU4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220204091546eucas1p1ca4ee711552169c18fc755a4d3a52b05~QioAMQxhN1567615676eucas1p1f;
        Fri,  4 Feb 2022 09:15:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.60.10260.2CEECF16; Fri,  4
        Feb 2022 09:15:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220204091546eucas1p178596598790b945cb5033dd3938ef505~Qin-v6JTO0439804398eucas1p1_;
        Fri,  4 Feb 2022 09:15:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220204091546eusmtrp22d85ea88263dfa943a331fd6abc01595~Qin-vC7Jl0796307963eusmtrp2s;
        Fri,  4 Feb 2022 09:15:46 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-ed-61fceec2dc3f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D7.3F.09404.1CEECF16; Fri,  4
        Feb 2022 09:15:45 +0000 (GMT)
Received: from localhost (unknown [106.210.248.224]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220204091545eusmtip164a196d531ab200ab3d239e43cf56b77~Qin-ehfmU0903609036eusmtip1o;
        Fri,  4 Feb 2022 09:15:45 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Pankaj Raghav <pankydev8@gmail.com>, linux-btrfs@vger.kernel.org,
        joshiiitr@gmail.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Date:   Fri,  4 Feb 2022 10:15:42 +0100
Message-Id: <20220204091542.78118-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87qH3v1JNNi0R9hiUv8MdosLPxqZ
        LP48NLQ4//Ywk8WlxyvYLT4vbWG3WHPzKYsDu8fE5nfsHjtn3WX36NuyitFj/ZarLB4TNm9k
        9fi8SS6ALYrLJiU1J7MstUjfLoErY83862wFTawVJ/feZGxg7GPpYuTkkBAwkZjf2cvYxcjF
        ISSwglFiVU87K4TzhVHiyN2DUM5nRomVs+cDORxgLXPfF0LElzNK3Dt9G6r9JaPEjq6ZYEVs
        AloSjZ3sICtEBJIlXj9tZQWxmQUaGSW+HXAAsYUFwiT2f5gCVsMioCrxsucQmM0rYCmxbcMh
        Nojz5CVmXvoOFReUODnzCQvEHHmJ5q2zmUH2Sggs5ZD42f+aGaLBRWLx7g9QtrDEq+Nb2CFs
        GYn/O+czQTT0M0pMbfkD5cxglOg5vJkJ4jVrib4zOSAms4CmxPpd+hC9jhIT5i9jh6jgk7jx
        VhDiBj6JSdumM0OEeSU62oQgqpUkdv58ArVVQuJy0xxoSHtIvLu1B8wWEoiVmHzyJusERoVZ
        SD6bheSzWQg3LGBkXsUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYcE7/O/51B+OKVx/1
        DjEycTAeYpTgYFYS4c2e9jtRiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTU
        gtQimCwTB6dUA5Pgtxt2C6bN1c30W1msaGG6pK1jwrfCqW+/6AZeLeq0zlTQc6x5l8jQdyKU
        iV/0k/msrg0XSzP5PJxnFmivDTj5vlCvav6JGTaxVp8SGice/vZxUcHf/85/A9XKmW8t9z+z
        IjL0znI5vmezeFYmTTgWe9ftjnyP8tenyvEdhgq80XsV9ZJlEg4bnGHdEBrw6Fdx2Rvv3XPi
        xJuvdRm2B5vMyrZeNmmbmRP7/4+HK2oq2wLmf361sOjZwle84gUKzRYu2q5pYmZ/bQ4Fvzl+
        fsJ9STYxXo+ZPB8Cv3I9Ftdi683KLHjDy1XbMeeSma/DkbhTX+ZM95uzuMVdMOK9VZiMl1a7
        ToDBrwS1A2ELlViKMxINtZiLihMBDPG6JqcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xu7oH3/1JNOg/aGwxqX8Gu8WFH41M
        Fn8eGlqcf3uYyeLS4xXsFp+XtrBbrLn5lMWB3WNi8zt2j52z7rJ79G1ZxeixfstVFo8Jmzey
        enzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CXsWb+dbaCJtaKk3tvMjYw9rF0MXJwSAiYSMx9X9jFyMUhJLCUUeL5tB7WLkZOoLiExO2F
        TYwQtrDEn2tdbBBFzxkltl/fxgrSzCagJdHYyQ5SIyKQKrHo6XUWkBpmgVZGibmvroAlhAVC
        JFrfzGcDsVkEVCVe9hwCi/MKWEps23CIDWKBvMTMS9+h4oISJ2c+YQGxmYHizVtnM09g5JuF
        JDULSWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwFDfduznlh2MK1991DvEyMTBeIhR
        goNZSYQ3e9rvRCHelMTKqtSi/Pii0pzU4kOMpkD3TWSWEk3OB0ZbXkm8oZmBqaGJmaWBqaWZ
        sZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDE6foMb17yXeyqiyjbTxSBJRbKjbM9OYXmar5
        5Lrd7q8CwftXuE1X8TyRF3vI/vARiUhHqXeh1/x/iWxN1/7McPuRxX1/QQ6zN7qP5RssTnX2
        7K1Y1xyf/FqzTXfvybRVIk282UIxd1TVJGPTkiuu1opt4Xu1LrZK3FTUSW2jKsMsOU/hLY4W
        gfOjhWwXWm5q3f4vwTu+NWVn/ONoo8iHO94FPonW//em4PKdhKBl3ZNnSJtFB3syr9lR132C
        Oz/n0Cnf+iPndjyS9gy+/MrhQOUakfiP3Qv1FebMNbodpicqcHoyy8fHi4QzOaV3LH0bflbs
        22tGNXm3v4/mn5Zzlj3vc7B6tqvezzh77odKLMUZiYZazEXFiQADROUC/gIAAA==
X-CMS-MailID: 20220204091546eucas1p178596598790b945cb5033dd3938ef505
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220204091546eucas1p178596598790b945cb5033dd3938ef505
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220204091546eucas1p178596598790b945cb5033dd3938ef505
References: <CGME20220204091546eucas1p178596598790b945cb5033dd3938ef505@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove the redundant assignment to zone_info variable in
btrfs_check_zoned_mode function.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3aad1970ee43..e3f6f24718d2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -655,7 +655,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 			struct btrfs_zoned_device_info *zone_info =
 				device->zone_info;
 
-			zone_info = device->zone_info;
 			zoned_devices++;
 			if (!zone_size) {
 				zone_size = zone_info->zone_size;
-- 
2.25.1

