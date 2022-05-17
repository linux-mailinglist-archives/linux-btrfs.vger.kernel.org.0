Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9446952AB2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352349AbiEQSpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiEQSpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 14:45:46 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB937393E4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 11:45:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220517184535euoutp01d09837279b2f70696cc7f0651fd67234~v_MoYk1Kx2662926629euoutp01U
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 18:45:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220517184535euoutp01d09837279b2f70696cc7f0651fd67234~v_MoYk1Kx2662926629euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652813135;
        bh=tZhwbyCvRPTngIIoL/l728enE0IkPda42BnC51sT+nM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LDPbJ9xXOV6Gv/C9OVh6khIR3mHREFkvaJ8Uw557Gn8p8vv43yQrwjz1Ji8A3Zj12
         mA0zt0cfW/YVn781qau2G9e3bT2bvaZM2LQJ34xNciRjmmesL1VCJkZSTe3gFVy8y4
         +1bjMh4F5SLt7BsWy151PX/qrw3z972WDOyoeeI0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220517184534eucas1p2c71d457d3acc73fa6e91342eb10a6245~v_Mn29R7H1305413054eucas1p2t;
        Tue, 17 May 2022 18:45:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.D8.09887.E4DE3826; Tue, 17
        May 2022 19:45:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517184533eucas1p289b49362dc7697534f7243115758951e~v_MnOL6s21104711047eucas1p2y;
        Tue, 17 May 2022 18:45:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517184533eusmtrp25e54a31bb22f47b76efaf7b72376700b~v_MnNRuWn1550615506eusmtrp2H;
        Tue, 17 May 2022 18:45:33 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-7f-6283ed4e1811
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.25.09404.D4DE3826; Tue, 17
        May 2022 19:45:33 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220517184533eusmtip10f30f399583ee9d48f40e5cb85cf3ba4~v_Mm35DLB0747107471eusmtip1K;
        Tue, 17 May 2022 18:45:33 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     naohiro.aota@wdc.com, dsterba@suse.com, Johannes.Thumshirn@wdc.com
Cc:     linux-btrfs@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs:zoned: fix comment description for
 sb_write_pointer logic
Date:   Tue, 17 May 2022 20:45:32 +0200
Message-Id: <20220517184532.76400-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV2/t81JBv8bFC0u/Ghksrh5YCeT
        xd+ue0wWlx6vYLeYeHwzq8XnpS3sDmwefVtWMXqs33KVxePzJjmP9gPdTAEsUVw2Kak5mWWp
        Rfp2CVwZS34lFyzhqVg5cxdjA+Mpji5GTg4JAROJGf3rWbsYuTiEBFYwSuzuvc0C4XxhlDjd
        3AuV+cwoMe3GZBaYll/LdjJCJJYzSix7tguq5TmjxMGf55m7GDk42AS0JBo72UEaRATcJCZN
        72EGqWEW6GOUWD95NliNsECoxLJd7iA1LAKqEn/f32cGsXkFLCW6p1xihVgmLzHz0nd2iLig
        xMmZT8COYAaKN2+dDTZTQmAih8SW7T3sEA0uEhv2r2GCsIUlXh3fAhWXkfi/cz5UvFri6Y3f
        UM0tjBL9O9ezgRwkIWAt0XcmB8RkFtCUWL9LH6LcUeLpnb3MEBV8EjfeCkKcwCcxadt0qDCv
        REebEES1ksTOn0+glkpIXG6aAw02D4l73xeAxYUEYiWmd99lmsCoMAvJY7OQPDYL4YYFjMyr
        GMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAlPK6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8
        BhUNSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFkmTg4pRqYwpWZ
        ZkRyXv9kdWRV8aSmPMlTszf8EJZn2F9lcUGzecYUXiXve3Y21aUTePanL1rL3Hmp9cW7G4IP
        F0eHTLnXzLGo2zu1ckXEz3eefw/6HIx2fmfC1MV0abnlOcHGUx/ibvw6f92p4cn2hVmbD03l
        eCt5rtXhfFbIq7uBfa3hB7SvBzVcds5n5azuVGDb38Hn7P2u4NTTmS6tuncfSi5kmH5VmlWE
        43j2HpH8S/P3T596apOZD/edwMIlzquOnr/EftyOP1v2jj5baZd8PYtTiGWOX5FLbcvMJ0Kn
        HxXJveZ63FXQd1RkwuSZTgabG7JuGhuFlnt4ZZyTsj/lzWMRt8O0/uH02zV7b4bU37VUYinO
        SDTUYi4qTgQAfCXuIJgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xu7q+b5uTDGbf17e48KORyeLmgZ1M
        Fn+77jFZXHq8gt1i4vHNrBafl7awO7B59G1ZxeixfstVFo/Pm+Q82g90MwWwROnZFOWXlqQq
        ZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlLPmVXLCEp2LlzF2M
        DYynOLoYOTkkBEwkfi3bydjFyMUhJLCUUeLm1JlMEAkJidsLmxghbGGJP9e62CCKnjJK7Jv/
        hqWLkYODTUBLorGTHaRGRMBL4sLFNcwgNcwCkxgleveeYgFJCAsESyyYvxHMZhFQlfj7/j4z
        iM0rYCnRPeUSK8QCeYmZl76zQ8QFJU7OfAJWzwwUb946m3kCI98sJKlZSFILGJlWMYqklhbn
        pucWG+kVJ+YWl+al6yXn525iBIbztmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8BhUNSUK8KYmV
        ValF+fFFpTmpxYcYTYHum8gsJZqcD4yovJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs
        1NSC1CKYPiYOTqkGJsHzb5sfHfbcrjDr24WjRu28Gzvi+Hc/EnXacbtlZlbekfl9rht8jRmX
        8gl6FAttYghr5ygr/jnD7e6ys77/JDJS/7/ayHjJLqrq7ORc9xcMdw6qL+N7xieYcPl3e+mz
        PX7MRkwzT38o5OW5yvOqyDb98N9+qcLuUO/nXzd+zhSuttWd07KuaIuKm4GmPHPFchvZyK3y
        +5yaFjpkv94m5nCbS9B3323t39ODNt229va8t2N515sY/UBmub3H7sgmLX0XPU+4KlJi/7YP
        D602e3266vPkY8LSpL21l6K+fHp7RqUmSX3rzJC6rZv5XdcnO12bapZ6xt7+xgPdd5OWLegL
        dj5SKLJl3cSoVOGta5RYijMSDbWYi4oTAXMDHxfwAgAA
X-CMS-MailID: 20220517184533eucas1p289b49362dc7697534f7243115758951e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220517184533eucas1p289b49362dc7697534f7243115758951e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220517184533eucas1p289b49362dc7697534f7243115758951e
References: <CGME20220517184533eucas1p289b49362dc7697534f7243115758951e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

- Empty[0] && In use[1] should be an invalid state instead of returning
  zone 0 wp
- Empty[0] && Full[1] should be returning zone 0 wp instead of zone 1 wp
- In use[0] && Empty[1] should be returning zone 0 wp instead of being an
  invalid state
- In use[0] && Full[1] should be returning zone 0 wp instead of returning
  zone 1 wp
- Full[0] && Empty[1] should be returning zone 1 wp instead of returning
  zone 0 wp
- Full[0] && In use[1] should be returning zone 1 wp instead of returning
  zone 0 wp

Fix the comments to represent the actual logic used for sb_write_pointer
as indicated above.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes since v1:
- Explain the changes in commit log(David)

 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 057babaa3e05..c09b1b0208c4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -94,9 +94,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 	 * Possible states of log buffer zones
 	 *
 	 *           Empty[0]  In use[0]  Full[0]
-	 * Empty[1]         *          x        0
-	 * In use[1]        0          x        0
-	 * Full[1]          1          1        C
+	 * Empty[1]         *          0        1
+	 * In use[1]        x          x        1
+	 * Full[1]          0          0        C
 	 *
 	 * Log position:
 	 *   *: Special case, no superblock is written
-- 
2.25.1

