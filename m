Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADCB7276FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjFHGBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHGBf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:01:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C821707
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:01:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Mk49s002003
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xNeufgm1uWcDz382UonOQFXhGOSOffKiPZT2XY2KMGQ=;
 b=LpIxHQTDAT2KsQ+1wR6AzqBQd4bkqrZWfFd4OWHZitcnSNsxXbkIa+fC2DyOmaMNKQLI
 oousAfJ2bSGYri03rprVl3ZXzvQn/lwLk7219lgaW/cv/sDFu95srzKb5mFENsLfC7FF
 rY4cXeu4/0z0LkitcIl9Gm6DNDgZwD0GIkUwCUeDRsQ+L/cfrCuZqxFHqERrZsGT+ET0
 P2HN5iQ5AZmsNx5vAxFqtGJhFCMG/BH+W/OJ0NvEgzCXrZoP9F1244lRKm0thkQxMS0m
 b+nAX8lPE+fyhkVha/dUlxizvQTsTRAnV2zzt/6zby8PbuC4osctJDgmUyvbu7AzQ+j/ Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u3e7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3585X48c003133
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6m674y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM3RrwjO1chNAF7KKGCIdUkvIs83swDKAHzCbnDExN460cyVDoxxCp/5uLL8INuiGaB9r3qrrfNgC1TThaey7JfWmtGjHHDbUzV+HavHdaF+EUsMXrNnjafFw5wCPz+o9KF6Q70NVHQ9Mt74Wt44zUlVu7U3EB5Ud3un94EH8X0mlbya++fbYKTFRn/iqcMIAT7NdA+vv+OQqB1GDatttWBbAUfdocfz+/ZqI/bRO6vh10Q5sFqKp5oqLTgEq7IX0Jp5fN2G3tAjXxJKT6CWsBuyVaemtK5K+FIs0w275nXXObOdlLMek8ddtrdQ3epkVXS+LOYvgeTfqhGDdRGtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNeufgm1uWcDz382UonOQFXhGOSOffKiPZT2XY2KMGQ=;
 b=Yx4nrYD/P5fQNNct2bOHYzCUr8sgCq2uLK0idFMxcZpe+yWEvPiTfoyGJ1XT/IZQ33jMmTteo9AueOW5v/C8hcfxaHayD6ZZybLcWMYA9HcGvW4pgEMOt+V88L2UJ3VXcys0SSIZjDvb60GD2K9FAZDQe0/pBWUEPn3c6eeWq+rrkpGXymnpCGWmhrKyhL8t6rOrsJ9nfF+o0+LoCpnQ0UrlAyGIVwFqKySICF9vSb0+EX9S8qWUR0MnFWIHhhBtc65Lqw98jAw0gP7s6CeqATDxkecgfYuzgJDd5/zFR8MPJ6Kq5DF/0fgn0o+n1zFqzSYuUUOOghBdYGej8XGoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNeufgm1uWcDz382UonOQFXhGOSOffKiPZT2XY2KMGQ=;
 b=GX2wQunr/790ccvFzPn/MnDpZrm92SwNoisPuViVMgrVftxrTBOn8LNpK1Sz4MNc9ftdiWrbMRVgUuVfRKZz1DomIl72sZliw3qTU07xEGyivFKIxPyD0HYGcK0km0KEpR1nMVSfgYK0wZXsswFIppZ36EXQsVmJa0U1v1cwaD4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:01:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:01:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/7] btrfs-progs: check_mounted_where: declare is_btrfs as bool
Date:   Thu,  8 Jun 2023 14:00:58 +0800
Message-Id: <baed95f39e04b46fba014509af5fced8b300e154.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686202417.git.anand.jain@oracle.com>
References: <cover.1686202417.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae29f12-d25c-47a5-0cd6-08db67e5cd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPRBZWQTh0ABiYeHfG3bRxr7Nve2JEPrZ3VPtkDHY9YTYDV40c6x9JIe3BzL/HC/UzGbD96KSjIxOH5UioS4O56dki6uyVbBgXNzZGqsBXbebIsmeQaIAOHTMZ/UNx6WxWO7rI//mWUEZ38eVKM/TnnXybfm97Cy6c2eehp67bnLNkzNobrNx31jqcBYxfR6Amh0viOglHSniNtwHv8YzfiKI2FhKbW00gbMRukdq7/+csk4kWgQQ3rsI0McRTDL1JxMWuUDB7DjQuH41LNGMh+hp+rg9Ty1vp5AWkkcGUZlO4Ro18Mt9mzYTiyRmoLyhOP3spLXgShOkfq9kc/dla9Th0V9qBodz3+bfK6m/ukXe6t+F+kRodS9NrFLaUmwYDgzmnvlPpCt9BE+bLX8uxsqKsIGeTmxgtllf6r3Jg5z2/8YlAIfEK3LyxVNDL3HILQysUkJdD+5QDFdethIlUmN5MjDZ+GIeUJ3rnEOxnpYLLHPpk+hc83rodnAPqrIBk5uDz9sjIohTiYlVWWpdu+ViqVqsHAorhvZvgYOqRf2pzUs8vniv2vkbYobXRu+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(4744005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cdaq3dsxVUc5AfNhUlhpCinXODfh4x3cKH2lCztNaS4jZ+8B3dua0UBSC1c?=
 =?us-ascii?Q?QKdQEjTbCugiEfEjBD/ofJShrg7bQsYEtYIj+N2sUj0HqnrbvddIqef8RQDs?=
 =?us-ascii?Q?+hHslp4beik/VGfwUoR2HXXYfWt05iDvArQLMUYhx2bJ8sLGMwTujZqDIcNA?=
 =?us-ascii?Q?Afmj0It6Jycal6TzE8aZj80UWW63Hgx6OR80BdoyK3KuAr9SyXrO+coBolxt?=
 =?us-ascii?Q?kXQHFu1nhc2Qq4SDyYvttMZgOr6Cgob9oQDfyxAoqxjcJY03HQTLUpinW1q7?=
 =?us-ascii?Q?XU19oWKjGc9BR4GucO3zdIpn8ZdkpzHlqhi83TyHw9lhU8RkyYJte0zfC1u3?=
 =?us-ascii?Q?RPVthRHwn1sRzuVOfHgZb1FmcMk/xckmY7Ykr9T/3j8pQwPju2nVjeQF0mim?=
 =?us-ascii?Q?tz3HZLG7yTEo8bBDnzvsl4ydM0XXWVDceVZIVw6D13ICE5OLEaSqdkgflurJ?=
 =?us-ascii?Q?DBsnfpugTStKcP/ZvJYTXVw+D6fMElayDrjZ8Fo90zLWo7HaJJGlDZn1fNvm?=
 =?us-ascii?Q?KrpXFNv2r0Gb2siedj+z/LJAk1V9t4d/d2nqVB6tAGoxb8DCU4ZlLZoJsM/q?=
 =?us-ascii?Q?/CkXH1gZ3VCN0JboNhsb5aTWOTD87iOc7ZIJg6CphxStFOSTaVcbR9bzhfly?=
 =?us-ascii?Q?K4eCpS+QPILAc/AxFiEJxRiiplpqoNfKKkGXphx3Flu5Wzo1ffW19AvZxh+L?=
 =?us-ascii?Q?US9VkHHjyVu7WE7XtImMrjnmEzvIWmMwxAjXv//VEDfi3zwbyDIvhqE2+NtS?=
 =?us-ascii?Q?Hp06wD8XAWmvSsvpe1ccDVGDvUR5eDI2SQmx9Q5n+woUvmXTkMVfASNnsrmo?=
 =?us-ascii?Q?My5orEH6BDAjsuxJf5nSGW5Di5HumzFLbDxbir69OfrE1++pEggSwAoQClZe?=
 =?us-ascii?Q?f9TIweGdyptb2AixSdySoJTgMCduGXxx9mn/B0g8w42XteZv0AQaes5L1vX3?=
 =?us-ascii?Q?2srQGiADvh6QrsGxXwSM1yCvFT/9MPTmZkulQihzs97ukzcf2agW5B/9gcUk?=
 =?us-ascii?Q?Ex5kRN6qv+xE6bOcn3E2CjSnohLiVTZ1yvnfkX2sFc30b/VvLJVFcdFcAxWA?=
 =?us-ascii?Q?KUesXO+TvbSBpGsbNEjwXS0ONDV7pIi2QE4RpjncHE05f9HFy6LnTdWgOI9h?=
 =?us-ascii?Q?iIJb6pGRkApkEg8/RYBFky6QERpMLHwk7+P07/CCkPbsDnORD1BOoxptPPbG?=
 =?us-ascii?Q?qB2AzwiFYJ5zIKPQUWAf7Kf61cB9wtgifN7o6eclEeHHYPn5vhwKdX7gFDwW?=
 =?us-ascii?Q?tYHZP021YAqtANi0kk3pj2z8882TseB8Z7PAGp7DmdmFKJGvxss8KtcnoVYO?=
 =?us-ascii?Q?4u4AEPVRlx/tVz/PYfH5gt5/2vvlX+z//Zz/OaaKnEZmuNE5p8ME4+f7MbY/?=
 =?us-ascii?Q?OWYNr2bfZhBF/6V855EQvAU4xOOPQSI0ejguvTia/kI5fB4SIDOIxmUNBZsm?=
 =?us-ascii?Q?B0vdQ/vqqWS99T1UF6rJ+aa0W+aSjhwKOfUcHnURLCFZkD+qtjt6DQGMdKIJ?=
 =?us-ascii?Q?Xkn/X/D/Xz0fhYZSO9yQaKrDgm65sZBDUfAp8G2opNI3PRNT2uVFX19qlKu0?=
 =?us-ascii?Q?zMimt3uAEHXECMBIt2/Qwz2wdvJREJYUpt6UFBpv8UAE2VcL1ZjSo1f73AYr?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XQDkFxLY+ZdlfOJthSuyxB+udAZv5yq9lJ28Da8DyzrfYjFhftb8Dxds31XWAZmXGmYSnkZ4c3gA0NEJEB1fldcvbunxGxvBQLx4hBvozUSbYcCe/mw418SisJCSdR9llRho2HHs2Ow8rwi5KXMaPxm7l6LSdM5vnugQBh2x6tqo/0ub7e6saFL+4MvIU0KywcNT2TaOpxf7Yo2d+G9t2nWWUkzy0XK7ov8IQusGScbnf2fLypyH8IXmh4b0JkCvLM0lsPahVGigWUDxLSXnKFi20pkfNsKxfsN79VgyGHyYW2eOmMM0G3yjuxuh92F0/XxBwVZiCdef34jAS1FnbfUtzjd90L4+KgaAcvNdLTj2cpFTjcx1S3CMkMgcabDK3bEXVFH6yDNkkVyTKIbNbYmmvh8ZqKtrfyeKpH2WmMOWjFq/Yli9C7WKlFdypomhfmYPfz/txshj9/VleKzyG7QZH5mMGJuy1mpg42GLTlYtkt64JrU2Bk1Z5j0V8XqsMBpgfZy+bB5AVXcoeK5bPJ4obCN4GQmQ5HAfjnXia1cdCOdXzJV6XToI93jjNcuitsstWmWfMmNJG4jYGjopRFfAo78KM6wcQL4H6gVmZp7XjIGxMGVr7vw+0pfNPJrOX8XImznJnu85jy5DBFmNaHeaappHUX5yd+W4ZTUYm/rV00JRjZazosq2o7Eofi/0bQ4fXUpXJ56YBiCXGRdP4WJ9sxf3TTDv8rjv1NbxeTwqym+U5YmmdKLQlNVfKKFp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae29f12-d25c-47a5-0cd6-08db67e5cd5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:01:29.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8DDOP+53yFR+SZ2rGEwVm3wa8FEsbISC7U6CRYSvITZ55B07yOxj65R1mY+FSTxyjxuxC0FkJH/cYL0t54aDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-GUID: 4j1Ef2Wr6RCSfHSwn6UVfzU0h-Eig5dM
X-Proofpoint-ORIG-GUID: 4j1Ef2Wr6RCSfHSwn6UVfzU0h-Eig5dM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable 'is_btrfs' is declared as an integer but could be a boolean
instead.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/open-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index d4fdb2b01c7f..01d747d8ac43 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -57,7 +57,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 {
 	int ret;
 	u64 total_devs = 1;
-	int is_btrfs;
+	bool is_btrfs;
 	struct btrfs_fs_devices *fs_devices_mnt = NULL;
 	FILE *f;
 	struct mntent *mnt;
-- 
2.38.1

