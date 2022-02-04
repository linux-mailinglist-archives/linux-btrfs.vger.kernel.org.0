Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567F4A98D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiBDMA1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 07:00:27 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39444 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiBDMA1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 07:00:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220204120026euoutp02a0ea068c5e4b2236eee454a9517b8955~Qk3xLItrK0490404904euoutp02b
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 12:00:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220204120026euoutp02a0ea068c5e4b2236eee454a9517b8955~Qk3xLItrK0490404904euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643976026;
        bh=sHoZ1co+jSIzobPSZXDz6nBkT1ceV0cI94F6lPRU4DY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VkNVEwmmwy0lKyl3UM/n+P7fetchf2odSMZ9U8a0bVoB+8+TvnC0xUKSf/Myq+Iu8
         cU6ufI2P3HMDbg1w34nYODB+QK0HgZ+ef0I6ibJZuE6qcEQMWmsJ/Y5+709FwleGkx
         HlQYVKnfKQKHM6u+wYlDnJ/tg8XjyKujOIekrA6o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220204120025eucas1p1bf7aae447fc0f2b9e30ed9515cde7c5d~Qk3wpInvA2080720807eucas1p1I;
        Fri,  4 Feb 2022 12:00:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 28.76.09887.9551DF16; Fri,  4
        Feb 2022 12:00:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220204120024eucas1p24a253ca559b0ba10f6e1f2c72dbd06d8~Qk3wIXN5q0118501185eucas1p2P;
        Fri,  4 Feb 2022 12:00:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220204120024eusmtrp235fd97febe7d2ad81de0c2ac335ed3fe~Qk3wHpwwF0839108391eusmtrp22;
        Fri,  4 Feb 2022 12:00:24 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-15-61fd1559b90f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0F.5B.09404.8551DF16; Fri,  4
        Feb 2022 12:00:24 +0000 (GMT)
Received: from localhost (unknown [106.210.248.224]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220204120024eusmtip151b947b332a2f35fee419eabde60ba1c~Qk3vuREL70762607626eusmtip1S;
        Fri,  4 Feb 2022 12:00:24 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Pankaj Raghav <pankydev8@gmail.com>, linux-btrfs@vger.kernel.org,
        joshiiitr@gmail.com, Johannes.Thumshirn@wdc.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Date:   Fri,  4 Feb 2022 13:00:22 +0100
Message-Id: <20220204120022.101289-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRj2nXN2zymzOa2afeU6O8MMxiK3MzHImLEzjdFgmGXC0R5t2jaz
        21J+lS3VWqWltCtJLiWxqTYV41ImJemGSW5Fy0Ry2VIpYTsZ/j3vc5n3eb/5KFycJfChQjWR
        nFbDqqVCd6K0erBhnsL7J7ug7JknY07JIJnGgViM+Wl8hTHDHQuZhk9VGNP8No9knBfiSKbg
        mYNYTclTDT2kvNz6kpQnl+Qjua3kCSE/VnxNIHcWTZMn3DmCBZLb3FcoOXXofk47f+Uud1X6
        u8to33FhVHXzABmDDAIjcqOAXgwPnO9wI3KnxHQeAvtZ09jQi+B921eMH5wI4iwJwr+RjNS3
        JC/kInhjuo67BDHdhaCqSWtEFCWk50BsEumivehg+OiIF7j8OH0GgbnCTriEibQCsr4dHe1B
        0DOhL/vu6AIR7QdFPUNj/aaDpbmf5HlPqLV0jmbxP7zBfmq0KtBlFFQbOoWuxUCvhXsDej47
        ET7cLyF5PAV+lZ/BeH8KgrS44bEhA4Gpqhjjw8sh+aHaBXF6Ntgq5vNZf+i724F4hwe0fvLk
        K3iAufQkztMiSDws5t1SKB/sHNsK0HIok+CxHNrSOgT8SwXB0ZbbxDE0w/rfYdb/DrP+65CN
        8Hwk4fS68BBO56vhDsh0bLhOrwmRBUeEF6E/X6hu5H5vGcr98FVWiTAKVSKgcKmXKCx9iBWL
        lGz0QU4bsVOrV3O6SjSZIqQSUXBoISumQ9hILozj9nHavypGufnEYLsvdE8+Mu/GsvrC+pmz
        iLmb1yteHdh+5UXa66Clz3NP1DkKbJL+9qYcZ8BnzGTytAyvjc9emYApNZZx3v6L7TsTA2+d
        jPaKH/pl608dvNR9vaot30eyRZKZLGP2dO8t9suipXkTVv24+nR1kq9kY1i68tFL6ZoZYYd/
        GIztij6PjOiGpK5VT2K/jDStW+at/95yOrC1bvyiIP/zm1SOS73TGqfeK7wdUDOp4nFUY/pg
        9PL2izE3a4TGVntB1NZzFaU3zcKuRUW++MaanGFVvTpJZrySuAMxdUv6L9t6FNaGNlUEnRbu
        MC/dIEg5VFtYrGxXRdqyfVtucDnqkS1+dlPALCmhU7EL5+BaHfsbC65cE7EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7oRon8TDXp3a1pM6p/BbnHhRyOT
        xd+ue0wWfx4aWpx/e5jJ4tLjFewWn5e2sFusufmUxYHDY2LzO3aPnbPusnv0bVnF6LF+y1UW
        jwmbN7J6fN4k59F+oJspgD1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL2Pas9WMBZPZKo5d+sHewNjM2sXIySEhYCIxY+JjdhBbSGApo8S1kxoQ
        cQmJ2wubGCFsYYk/17rYuhi5gGqeM0rM27eUpYuRg4NNQEuisROsV0QgVWLR0+ssIDXMAosZ
        JWYcng3WLCwQLnH88nFmEJtFQFXi64KDbCA2r4CVxKZ3v6GOkJeYeek7O0RcUOLkzCcsIDYz
        ULx562zmCYx8s5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREY/tuO/dyyg3Hl
        q496hxiZOBgPMUpwMCuJ8GZP+50oxJuSWFmVWpQfX1Sak1p8iNEU6L6JzFKiyfnACMwriTc0
        MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDavNTQ5vfUHz+m7c83utU7
        7++E3NvFVgsn7Fl2/envL1WXFbsPqF7PDStd4b5tgeI0nS0nnvU0fTwYb2O8XtMsplzoDyuf
        oO7c1WUHTGzE7r26d2hf4Jav0uzyW5OKjhyffcx3d0Ts5WiHJVt1Sgw+37BdERK15sLxcPWY
        FOXSdIE371zPyAtscXZ33WQUKnG1M0GF9f0XX2e9M5V8LyoNpbr3bhXfxlF7IXqFd1Tu1KJl
        cX4ezjumm3ZtSfqQEc+f/GvWsfMRRYpnwm6te/TYrNv/WfiyjWHH2C/2zDigm5Bl73La5dyl
        xwm7FJd1CDYWO77+xC7i6r/3k9vkyZyFk31yQ2Z6+71cM/ksg8I8JZbijERDLeai4kQAb1Ny
        4QgDAAA=
X-CMS-MailID: 20220204120024eucas1p24a253ca559b0ba10f6e1f2c72dbd06d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220204120024eucas1p24a253ca559b0ba10f6e1f2c72dbd06d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220204120024eucas1p24a253ca559b0ba10f6e1f2c72dbd06d8
References: <CGME20220204120024eucas1p24a253ca559b0ba10f6e1f2c72dbd06d8@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove the redundant assignment to zone_info variable in
btrfs_check_zoned_mode function.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3aad1970ee43..b7b5fac1c779 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -652,8 +652,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		if (model == BLK_ZONED_HM ||
 		    (model == BLK_ZONED_HA && incompat_zoned) ||
 		    (model == BLK_ZONED_NONE && incompat_zoned)) {
-			struct btrfs_zoned_device_info *zone_info =
-				device->zone_info;
+			struct btrfs_zoned_device_info *zone_info;
 
 			zone_info = device->zone_info;
 			zoned_devices++;
-- 
2.25.1

