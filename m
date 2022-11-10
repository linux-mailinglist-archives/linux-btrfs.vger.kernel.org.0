Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CBF623BD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 07:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiKJG13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 01:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiKJG1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 01:27:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673383054E
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 22:27:12 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA6PsUA020550
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=6+6n6x/uG+ZVenM8j/5ZfSafX/6mKSp3ZDfK35G5bic=;
 b=iftMG1qY4C3l+d2pDhz08G8RP9DVJVAwDFGyi3Op1xlk+40A21UcEDKruh5eLZw+ME+Z
 05kqDymwLvHhUckHDzgPZ8t8+BPuBV1fPgqmi5G0YQ/UT4VZNxsPrFbZKt8iAP9py7RM
 nIwCET/1Qzute/LfZzgLi+aRtkpK51SuKve1Dn2bqO1QOdTJq2zZVJ1tIgEBZyWOKEhJ
 8d2C0YSFc1wtRGOIFbb6LVfxvBZxweeX8tv0beyGeI6hhPliVgauZRfAhM00h4MrXjs2
 WJbP3YHD+9LrmpyPTubuTyE1YmMWNGAZjnu7dMCBXjxLu6fYuGYAJ4SHVuU6Z2ql3nbM 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krv11005c-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:27:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA5hgkJ040958
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsg1g43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgY7klxbJZX9lmjBAV0pARprq947I/AnJILFaBDEDTA4FQo7kDy4V0a9ojTxVe98Il92UiTJRhH1zheOX7zg/SUfeIvkWAkKUv/ThlCvDk3qTyxu4lwSu0UwzzESfQxLRD2EBcsA/IQtMnA3E8BxDhxLmrIB8zY5elb8qWkY6Rfr5H+tjxRbnEHvP06xUzG2vcGFdligue2FWB780aGhiZtmEoOqggy/yqd+anxWKVi8PvgbYtuYtqC2BoY1lDTr0BKCQ38YaflmPDaL++I0gQV/0nCtxpEy6bpSPm/TObsx5Mvcnjgkwi8JOb4tc8e/LM4ZV/kJqpW7Cte2uLPyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+6n6x/uG+ZVenM8j/5ZfSafX/6mKSp3ZDfK35G5bic=;
 b=FMQ3tmv0fwSYyNJv+10MovCw8m8FdqfYDjkXfexuuvU5u71w8X8vSr0tXq/d4letiWTTUtDCNWGko8MrdcN0h0AmygXKVQeyo4ruSFDRu/CJ2cJfZnRb/g8SDoZU/Xttt4yzBM6GOU0Ebi5FX6zS2ir6XViB8ym4CvT7kYt3PMpv+8sK7QoYFfIH1GaGIO+57y1PrqPxmOdPMr28Y2vEVFVqqTt4kAzmE1hhwwZXkLi83XhRk93drcp/mkCqXqHfj06t9TTmXcuUxiyKPzg8SEZICM47p6YWbSYlpMLVMQ0rgOzrhSc4oebs3IL/WeJEPhxo8BVO62UHQ7C+RmenZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+6n6x/uG+ZVenM8j/5ZfSafX/6mKSp3ZDfK35G5bic=;
 b=keSr3pE0raaqC686Ejq0ILp4+GT6K3tMafp6Sn+3aOTt8F3mMvsUjE+tk9y0nQbKbogJu1kp7ZrLUDI4RYTedE7CCapO0yaCxnRcxMqCr3BjceMuOzCiScw5PvguaHpvDkuJUzcYge5o9pFeCBKTmdtphc4XKYOSvTZTGnIcou4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:06:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 06:06:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: drop path before copying fspath to userspace
Date:   Thu, 10 Nov 2022 11:36:29 +0530
Message-Id: <0a751cf247ca9f9dff01357e6c29af999949bfd8.1668056532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1668056532.git.anand.jain@oracle.com>
References: <cover.1668056532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 00223c5a-d1a0-4c5e-540b-08dac2e1c2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jruYZObTx252+4eniPxxKAQsNUQXtzcwTrzPjOcAB52ZANWZ9MDXYxXDGQrj+RVzlSNJyqa3yAmVlbmWJAu/rbqsVndICyJxZyUMId/ObwKrRZA2PDTRwus5gO8Xcz0IUsxQVVPK5QBySWkNeokEHGXdyP50GFT0x25r8djratCYj2aqieNXCRCH+sW5smkkW5MvGXqloq3ra8d6hdOMckLiMU7lHos5hStsiLpyrPrEbYYdbr5dOVIyEK4X+C5G7I/wJw2yyxRQGoBXNfn4FYUlfZfbptIc5lRTGimpK5ALbhFxt5z+vb08c5MPKTtjP8kmpeeQsongDIZITtIYOe3HjOQW2V2KKvhT/Y2VRX0B5dlO24HeyOccxn43xPzlmzjikJK2tD0LdnlQjVPXjU1cxzkVxINhIOqs73zwllLud89IPouaq+YPJ5hSApaU12RtQRDr0xHgL2B3oasZPpwGSbfBLrsqa8KJrAws7CSJIN4oyRfPNK/Ny0ac2Dl9us9187rSDaOTihKkjC8cNODDsB0Otta0dCG4l+nsIHl7MmuSeeJ3ySY8NoinHCrQaTgZGTwST6m/mSx/5ixjnsqRkkOLn0JhmSfEWn9925bW7017BXFetjVaZ7kXZM48lUvU2+U2zMpvBIXTLYPp/3IU2Ae7iQ5B2semk1/ubP4tUizdABff5hsfUcsse2FLx6ySVyU+UidfWkBISGZ0gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(83380400001)(6666004)(6486002)(44832011)(36756003)(6506007)(4744005)(478600001)(38100700002)(2906002)(86362001)(26005)(2616005)(186003)(6512007)(66556008)(8676002)(66946007)(6916009)(41300700001)(66476007)(8936002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ujxLKHolfzBsIh1+dm+cu0iq1FlBMkz1F8sxKUs0ZRgsOxoNqlMrbMY+zgyz?=
 =?us-ascii?Q?SLbpJqTNE3e0cxK2fY5fhmoF3JM91Xmdb0HgiVidXGIMJluK7VFG6SszKJm2?=
 =?us-ascii?Q?Ut54KHyrpWXCrZCr1HsHayjrZFeROG3vfHWssfjUMeSvwXEyEk3V63Mzgy4I?=
 =?us-ascii?Q?PZmeytdud5ilvTg2Es+eRzU6KQYwnSo9Xham5S2UD1KcnQ8zxKVhKMkEwrCt?=
 =?us-ascii?Q?fLUzkhl6llPVnjnlFX3k6VO4NI92JrHt8BH2OcDgUxSOyyotIknqwlvnVwFS?=
 =?us-ascii?Q?P3YiVbKtfi8kfICJAbPm/6Aor/BTy/k3J1aPGWWlKUaTZf0c/xAg2pfOD1hb?=
 =?us-ascii?Q?A5Jtm/70wX71GhD7C8U0Gw7IU4zS9vfPSfAAulS95JS9O63HheczVZuUqRb/?=
 =?us-ascii?Q?0FsWe3LZPUQQCP2dv98NZhSqjmMcgXm2Lwq2zh6a5FFRUooAuOZgb3e9RTQ1?=
 =?us-ascii?Q?+yZNvWhHt8KPeHSgORDeZVtRN3aZzBvI811SJ7t2XCCsehj9JsATKwccIpc6?=
 =?us-ascii?Q?TtQ9Ozhpf0C35PsMJ7Zn8h0Obt8ooA6G9RKyQU45/ZMprM8FqZ4qsjwl1aZn?=
 =?us-ascii?Q?hE12ArozT2MjvByVqae4haek6c0PELMWw2X8KaF24rJjIUVolpG9XnknFuD7?=
 =?us-ascii?Q?vyeXwZ+JEZorVvw6+Eh4gvpWqoopuKM92LyptFtfF26MfG7KeIseI2l9QBdu?=
 =?us-ascii?Q?6tEW3snMFyTaFFNGx3Ssan7iyg0MSz01NrQC1iRg79h+zbPbagq/BtfDjEf7?=
 =?us-ascii?Q?SJS1C/xLPu7Tjhf5cqmqI2zVnVWhkNyBe094tyZ/kjFijiqwrCDdccP7s5xY?=
 =?us-ascii?Q?ki/Zr8uZ2Ga4z7X8RjYN2GsA/IhaCBYRFMzq+ObMCDZjILjUS8u9ybC78/JM?=
 =?us-ascii?Q?aAUC+x7W2/6wAuzsAal8XTUN/2KOTULBbJN/9TGmqx4NseoqNAwFgShws2lI?=
 =?us-ascii?Q?XcA4bAhbQDamjux8dhZ4UW/FVd1d2yRY2RznaHEjpCC4DGvpQy3USQTOSNu1?=
 =?us-ascii?Q?ks+WuC51CZAmncC6+0YBEM0sLSVoo9Ka1BVWNhLiJwmZ6XLoNZUf3CPX5K/r?=
 =?us-ascii?Q?j3KK8sheGBMSMsEE/0lDYiJVvCAuDX5KUagaDsqHqqRw84QL/49uPH6vMDwu?=
 =?us-ascii?Q?zMn9Qx9aAFvy7Q6dEocv25QRyKoVWEsA1Un7bZoiZl5pLvmqO71TIQPIU6vC?=
 =?us-ascii?Q?ne/c8FSW6AgPlgddI6rVxW4Cq12ypx/lHzXLzFO4traUM5BqmImxLeC5qHaX?=
 =?us-ascii?Q?1UFNXlnCFF4vjBK9IzC1ngnbUSKoXoPxGA54vKp++r8PCqCA/PJSMGa7cz3q?=
 =?us-ascii?Q?N3KPMFaucArF7S3ixNJEqtqgYEGtVXyfHGqHi0piN5huwxk8vgRVGllbYoCB?=
 =?us-ascii?Q?+O+T8kk7i41HCww2JUTEGEva84cAEZjficBkMhlEjmP3xmSE6YXpcgFFZV2f?=
 =?us-ascii?Q?TvPG+tRL39O7nsuOYu5RNBW29tfXYsaLNXo/W9DKm6t2OTN4c2rgmkA6q2fE?=
 =?us-ascii?Q?sF1TVZ76fye1qxjDl2ZySMAe69+FI/caYFB5ZIXm566ysB5Q7voCuBANhQo2?=
 =?us-ascii?Q?e86PEpPQiGlFwkF6LXmh5uZX+dOhBQCmocWONzANpbhdpIQ84VYFZf/XIeqG?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00223c5a-d1a0-4c5e-540b-08dac2e1c2a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:06:51.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lieMmHXgnRYWAQl27NfQ5ZsZHfkIuLh3xQiD0mG12FUIX75n2fSFrESRHQ5CU7GfLgWoalt2DNMvzu9EKrGgYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100044
X-Proofpoint-ORIG-GUID: FWjQOtl_m-hId_dNMPvjajUWpaUp03vC
X-Proofpoint-GUID: FWjQOtl_m-hId_dNMPvjajUWpaUp03vC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_ioctl_ino_to_path() frees the search path after the userspace copy
from the temp buffer %ipath->fspath. Which potentially can lead to a lock
splat warning.

Fix this by freeing the path before we copy it to userspace.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 76198c7203f1..707b2321c8db 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3341,6 +3341,8 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
 		ipath->fspath->val[i] = rel_ptr;
 	}
 
+	btrfs_free_path(path);
+	path = NULL;
 	ret = copy_to_user((void __user *)(unsigned long)ipa->fspath,
 			   ipath->fspath, size);
 	if (ret) {
-- 
2.31.1

