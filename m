Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8A6975E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 06:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjBOFhj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 00:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBOFhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 00:37:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1C2A9A5;
        Tue, 14 Feb 2023 21:37:36 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL3wen015338;
        Wed, 15 Feb 2023 05:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=PDvlD7zf9XAz0TyPxptFXU8YEPeRhYC9wDXyKirz8sY=;
 b=S294Ro+PIo6Lp93wXvmH+eN/JOYf3xYIZVDuO1zR8xyJacKtcsC6NS6wSlxCYALojUVq
 tTM1q5Xx4+/ojH7X6QOub6aT31WE7HxpK3djhyNJ58Yl8BYjXEgSFW/C9WqSL1zzO9GY
 bxyktGDPqZhMKvpNYrvst2tS3hOg71ngo+Xjy43fZEZCYjyM2tZzsQfOEaYdHVzDppaq
 GQMXsiWHGG/gmBdGtUDcHGzZd1lv91nIM2Cj3+HXq1aaqb6lOrorFYCgParn+lPYw1Bp
 SP6tPPeVi13njjGf8I4/YOBCmIAvB6BI9XKa0xZ3GSWE4COP7FV3hzjbgmbhF8GIqdSJ mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtfau7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 05:37:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31F31jqw003608;
        Wed, 15 Feb 2023 05:37:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f6n0rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 05:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA6d466pNfKizBhV5ZSPX2pYA1/kBzOXEzbjhJunXMT9pkuCF3f0+zAItOUYy3OTtcCBw2VuPD6HnRTJinRi5bbJFNATzOTVFAxWoRvpfJOTr92ltJyGwYrCnm2xRv3VzcUNLCr/I+9YVsLaUAgIwRro3xueVxIlgheInBQ3zA//ezYwUuFses7tyCrVPcALydSrxN3ZDqup5puNX6s7w/pNMBAMUKMG4NjQICKCQ3W8qx83LKv2nBsieBkdJI1b3Fpu9VIAc04LKTaO/8PmS9xSQQ6o7xzim6OOECJyVH4eU5ebUp00GAtCxByd7bC6z1LRl7jl7qoU2qra3CdRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDvlD7zf9XAz0TyPxptFXU8YEPeRhYC9wDXyKirz8sY=;
 b=KtkswMoXvG9VNyj4ZMaOUGy6aukFKW95xsCx6yVyzpL+mqrbhv4ZlEzWdom8eC5upDiCKvqpnrVNOwWReEKzF9Zt5q7EkIuweHizPJKSKC84TJwCSYzJhJwk4OuEkv6z3WaKJytXsRTYLEM5NPvffoe4ipaBCsVm6as+ngU8qzy7ing0/fLbhoZMbRp8/nUe0nQq7m1FVaOEIp9YoEH7JfPoUUlJF4RJpDMyo5i8k/8/pvS4WFQW5G0Tkv3nBd7hBGWG7X9fmvll89eHkwyD8igraNAGrg4EZH+HXx2uqRA6pnJQ1+NKXoMuKYHYx/Yxvo58PGKpagvBDbxp49w9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDvlD7zf9XAz0TyPxptFXU8YEPeRhYC9wDXyKirz8sY=;
 b=NKRRJBw33HG9DuUuyhvBjDS68zjriqNkdtAwhAjQb9X2gd/eeCQCRRgCM2PrWugKtYCnytYxoSptviRXg5X+b4/WOcpH/x60ah5A2TdrVuzyKaAshv4RCYA8FRaYPiM0otRnpSHjZqyOC/zIrSRyV2YqLM7crYUm8dIsYLnfGTg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6651.namprd10.prod.outlook.com (2603:10b6:510:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Wed, 15 Feb
 2023 05:37:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Wed, 15 Feb 2023
 05:37:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/219, add _fixed_by_kernel_commit
Date:   Wed, 15 Feb 2023 13:37:23 +0800
Message-Id: <18edf205dbcef57bb1ae69408a502ee1a411802a.1676438498.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <9c696ea007fbadac5aa4d18ecdd1702cbe6e7742.1676034764.git.anand.jain@oracle.com>
References: <9c696ea007fbadac5aa4d18ecdd1702cbe6e7742.1676034764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 60657786-327e-4218-06bf-08db0f16bb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4EvL6PvI7xwo80wYhRgCjCR1m5Vo8Xjs5CBF7q8Xe9bMt2BFDHAf4q8tu9DXDA0Pnbg5I1mpa2eDQ90yCkSV69gPq/qSCEq7PDH08m9CBSvG31TWo0Mx3GDNFA+JT+rRLNH3fNXk17YgXzJj6kr8EGYYGEJ/uqODnDBSzVycfIM7Pt71RB7pZpj/yoYudJvp0Sv8r/C7F+kkEvVgDdH1r/tYOOAG1HKDpRgYljx9LAwbJaXc5W1QdjeQfh/g3ipzj3X0b5+PixMbf6ztT1zMP/4JfVcYoWkAEQCT8KG2UMDGPkuHnuJRYtBe+MOI6z8yGTgt6Tvm5Rkox4MmCudu9pjs9uBhUXOeKEv3ka0iv3/kKImt/5wsCU36BMJPEh6WFS3ZKxMLqhyE4kg4TEDLnjM3Mucn7mGARrn3Ykhc4ARUS1TKGtAko8XqmiSkE2k+Y+Oa3kQfbGoJxQwyvOg6tKlKK14Ljrl9EAQ2Dc4DbkGiz+Ld/p7/a/zuMxvPjDQd/IHAcBFtVw3Xov70XU6xQ4lJCpj9f02tDcll3CFR9B3Rfpismy8g8OemjiV8vbO2SQE7zl4asyPi1zPcZpnXIbCaIM2BLr/Bv2BHJS4K4w6UvKAEkkkrD6OTRq8BxceX60+cpEsu6ruS0l/H7yq3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199018)(6506007)(5660300002)(44832011)(2616005)(478600001)(186003)(8936002)(6512007)(6666004)(83380400001)(66556008)(6916009)(36756003)(4326008)(8676002)(66946007)(66476007)(316002)(38100700002)(41300700001)(6486002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLWQN9NpzwOr7EiaxWsE7CVZeSj37yQRI7Tug4DdyG8F4EDSpOuPayBq5AQM?=
 =?us-ascii?Q?K5PURnyScGaOO8s2a9XTq5aAX/nJXWks5pfPSc9Yabwbbwrjif3dLqZRJPoL?=
 =?us-ascii?Q?XTOEB22Pb/DitxMn7hIIgCW4O9BFX+KGxsLZmQ+Qz8ftkh8yrjinMWUyz/aZ?=
 =?us-ascii?Q?y2MHMTZATTcZHwCvrtQVIugEf6lRl3BcC8C1nFpTwsBsxytrv2+YdDWMnHnx?=
 =?us-ascii?Q?pNpdWO9oehtGiG2UAsdAXVNGlBKmApYZuPdW5+6VJYlAQl8d2eLaAeqySzbg?=
 =?us-ascii?Q?+eCkvq7/kxSJGIH7cRFsPk7VDFOMTq/ph5bClfNxyn3AFaHUM0etqEhqqeHs?=
 =?us-ascii?Q?vfz0OK3AFk6NOOIU847x5v2xLrxiVYqruVl93wZp5oho4YWW488dXWqh5bwK?=
 =?us-ascii?Q?zMeBwZLjHbCf767c2ltail5/LVbfJTDDmqY947nAWHX+PKL74eDXXPrfEqX4?=
 =?us-ascii?Q?hiDy4zat1jTqB4sygFEo+dzGmkRAXnkO7jTVk7LJsoQuPAU+4GATZanq1jr2?=
 =?us-ascii?Q?MdvUA5fYpEX+2y0Drp+5aC/AVCwl2MGfEPbI6BLrlVtkUnGDrLveqyIlTW4G?=
 =?us-ascii?Q?Gm6rabIJUmoZsROTxkJoG5yGVKAf+JjP05N0Lbi+rQwgSWkcB+19Lx/h83+g?=
 =?us-ascii?Q?xc1ZTgw9mvENn3jMwpeK/xm4fajFGgw2FiNVpsw2YMdQZFmN7ld13VuokMc6?=
 =?us-ascii?Q?F850xT764Z+W+Lao4/kDXYv0W3cmcR9885inXmyCXhslPMbfoYq2XN3FgqSz?=
 =?us-ascii?Q?AXf9OS4UjxHMC3ZCn09ilvbUjZWeB/Zh5FsAtTLBIqpRskvO+9YDmw8vk/3g?=
 =?us-ascii?Q?kGUBnGguA9LuMoM049UB9dYLWeBRSGg0ITH1GZ9Y7PYk/3nD/OPPgMFcALEM?=
 =?us-ascii?Q?r8Yo7iq0zWMwMdIIuKMeDmfYO5cFMPC7NZsCb2/h1ePBaBtLgDUNDMerhNk3?=
 =?us-ascii?Q?2wtwkPvtf3wHZQ6wE4hvM6+PsvxMYF8wuq03WkdtDFATGMB/bDhaStcfYC6v?=
 =?us-ascii?Q?BpRg7kv5QXUy0fW1zZ9Y3TZl6dgIm+uOt4+0c3bCcHoZ3gjwYVGAqSXQcAg4?=
 =?us-ascii?Q?GmuFyrhTnGOJOtBHJ6OLi3M2MHgyfL+mG9wJfOD6u896wUT/C7EQrrBjwmPd?=
 =?us-ascii?Q?4PVHrXGVFJ0JNFGqFDNGDP4m2DaJhtLQfWN/Fq3Q3v36Cs2ypt5v0VS6nJpc?=
 =?us-ascii?Q?DzvWmsvzzVxFk2RLHpgXPPtutl1xtcVAyPyRBNuUYBGjus8YcTNqBNb/t7Dc?=
 =?us-ascii?Q?tkMEzt3jjO0FR8y9DXa3KNWwzLONG1j+KraO94mIoWoc3nnHC+WdVxoEMTb/?=
 =?us-ascii?Q?eOeJt/6pN4ChQ+a87uCEUKSxY5o258kVRjciXmO7ylXoOOYqgcsudj7wxHex?=
 =?us-ascii?Q?+Cb7IMsICyZY9cSeYwPIb2x5/5DXn1MtEG/Bqpxyab1VDYe5XiXQxD63lf33?=
 =?us-ascii?Q?w6eB9SduzykqSJXhq8fwBBgNjsdf9/ElKM/S9S6NsXUvvuDFbNIBGrHqKLne?=
 =?us-ascii?Q?scXeN05X6+lKknCrFCBz1KUzFhg7ui8W9e0wWlKHuhKCXU/XqZpOvuhL7jjC?=
 =?us-ascii?Q?YiA9o2qIhEjRVOf/P3QxbyeHXfpcuLJ84GJMVzMVTuRXxfVhwGhqyyI/n57h?=
 =?us-ascii?Q?aV6DSAUni0QeEy1q3YIsBco=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AfW1hGOp3d/TnbI9K6FrD/A6Mq9wXomTEwZCRIPNI7VrvVlh5F+ZUUoXI0tkcaUIEZ7Oal1umDdTFGNkFlaf1IFEFirLpSG3xald4gm3hT7IAXMiMEGn/W0L4A032I3C7C7++aIw33WY4jT+xsqaZ6vclN8sSZBhPG127KhSJTWkuS1FoHY8ooyS5ohynWR1xKDj85BwY2WBbAlgFfNw6Vt/7oHzTvsjrutFWx/Qv2CZVr3DsXctMgiXel44yfo2QD4YDLu/fxwZbE1rM5QciDJHOWrNc2jWzC/OpfRidGoBLx2cxuAl4Dxa297IhMYucZgbZpNMj5QFh/wCJvm6AivkGqXRB31Dh1Udlcycrcjf2i7jUfo0RlwZAzDYooRTD0hhZ+rbFxp6MyLPGBC+kpmP24aLSJAsZ36IJAE5R9GbgndHR+v3a9YNKEkAFpK85iG0dD4mii2QlQls1aHprXA1s8p/BDzooRCXJ5zQKjWGiunkmZev4kMAp815UEkn8beim3Sc0Of4YatVZgOe4vObGxvVtkEH7LBq1xkcGaOUJtt5ErK6KQkKm5/cPcacM929X7Wnr7Eiv8qdm96BBWbLT7W7X5DxbVF/h6bC6o2bs7YpAAAjlGwQtoCLnb8QBkvS5NAd9IXFrEis9Ft0fkSu6MoQy26inXKMK4YPm3985NwDl+bS3E49veW77/CFWQZyU1Kz0swkGx2FiTbMzCmXKjlTh7bhK1jvszz3MZOemZ7b5de6TF6lHgfsb2GZCygyLvie+DNMswNec1J52T5muiyyiqbqWMobByZryns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60657786-327e-4218-06bf-08db0f16bb91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:37:31.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZasJc9hejqnAWm83B+T3N0M+UdcF4RCqh/l2IzJFA2i16U0KX4uWFZXA6HzbOaPsjtJsbdrCwSdauvAXEv0g5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150049
X-Proofpoint-GUID: KfWoMsstkzAo6Fl8rmIJnO0gbIXQLrsO
X-Proofpoint-ORIG-GUID: KfWoMsstkzAo6Fl8rmIJnO0gbIXQLrsO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/219 is in the auto group so add the _fixed_by_kernel_commit
tag for the benifit of the older kernels.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: _fixed_by_kernel_commit: Substitute the placeholder with the commit id.

 tests/btrfs/219 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index d69e6ac918ae..b747ce34fcc4 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -6,11 +6,8 @@
 #
 # Test a variety of stale device usecases.  We cache the device and generation
 # to make sure we do not allow stale devices, which can end up with some wonky
-# behavior for loop back devices.  This was changed with
-#
-#   btrfs: allow single disk devices to mount with older generations
-#
-# But I've added a few other test cases so it's clear what we expect to happen
+# behavior for loop back devices.
+# And, added a few other test cases so it's clear what we expect to happen
 # currently.
 #
 
@@ -42,6 +39,8 @@ _supported_fs btrfs
 _require_test
 _require_loop
 _require_btrfs_forget_or_module_loadable
+_fixed_by_kernel_commit 5f58d783fd78 \
+	"btrfs: free device in btrfs_close_devices for a single device filesystem"
 
 loop_mnt=$TEST_DIR/$seq.mnt
 loop_mnt1=$TEST_DIR/$seq.mnt1
-- 
2.38.1

