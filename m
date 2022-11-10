Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A3623BB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 07:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiKJGVa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 01:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKJGV3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 01:21:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088852B19B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 22:21:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA6Bxt5000533
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=fhOJSQri7JGY/7rm6SjJdPYikfy/XwLWmvwCNm4qcAo=;
 b=lZ4Jgdb9YsD+KpH5N8cQ61mBgh3G0EdFMRSQPwMd6RYqqXJ/kCVPv8KdnSsWf2jPYiI6
 zaOUodJyW2QCHd34J3AS0+B3QlilMkeQsRkpvQ3Ldl1yon09JzJWmUYzUhMmZwu8bfMo
 LKdE0yMyOP2aKYyQXM5CuWCr/N+OiIQguTkiFLEK5K7+CNY65zV/mvxGAK/r6e5iS8DZ
 NYj/xO5srn0cMj8fAQyfJhwX785LkKB1AYzuGWoP+BdcJl0HwuXPPwpDvBuiM1lQ40pI
 9Gbzk3gokoQEYaBtIVk1ZFE7FO2YmG/3fV/4s5S21HFwv4k3m0y7jMzOhfwG5G73GZ7a JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krutr80hb-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:21:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA5UpMU040065
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:07:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqjhufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:07:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp8+GIjkDga2gQEkB0O9mRs9O51t4jygmJhktjX9EDF4W4bCs2ijqlj1YkbenJMl1O1q1wKh0ZIST6/A6LT09WbbSz1ZjF+vWa6T52xKl7Hi8Vn9y0az8EBWPbrO7BboQfaks3AjCizgD/BNzWhzqXn4Inm6iqqhxbiYF9xC943UrOomkLUqyRZ5EBZVgAtubTHwJGjf3T7O5wW5h+ctqh8qM+tZBeSuZ5CZw+g2Y+quoo2ZA2HFZkAhGWDJjDZOdxaxoEx41IGBKQsJIF9BQUApAXn4hL17mK62jl1HENvfBVXYyeWy3+FAcDshkMrW1WeH73O4v/ZoksFSi3ejcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhOJSQri7JGY/7rm6SjJdPYikfy/XwLWmvwCNm4qcAo=;
 b=jnERAWcdNxqI2grfR9QAjF1Rx+5D0oioLwDomtVlx0CLshwGRCS0bop5Xl3PbjA4XvU694b7Y+cod2WBsseUiznVFJpnTmoDou46M0VbQDUNq3GhpBwM3bRDJHHX5QhKaq5KQJRER8cD2DK5TpTZ5xayaFbZrrenXTVrCXJ2F+DUOwJJGeQQ/cxSBBdC3vbnHwlw0VoqDBymg4vDFvVK5fEyIhZUK00ajyB/pGM9HjbcVdO+tLbD2LLX/kF0+5ipskLTBfb+zZfKXqeB6+IRiBrp2RyiqN1irj6iZDamCcCpV3NpHQW2wP8XujS9xzY4nxPyy1fEvX1vAWXo7nQ2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhOJSQri7JGY/7rm6SjJdPYikfy/XwLWmvwCNm4qcAo=;
 b=cR5TfQiCwWjz9zqMKFNOwFm06niT4MoFBh0VA7Ka5/rMMNRG6zv5VRQC+Qis0TVguXFS2GGV2ft4mHtnhPUxD49a+gSnMbSX5LgvZ/tIukvwxVqeCCg41faV/EKCN7Bq6+MGckLAGWr2abA8U7ObXqjwHnl95rNxrZfvXuE3Fxo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:07:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 06:07:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: drop path before copying subvol info to userspace
Date:   Thu, 10 Nov 2022 11:36:31 +0530
Message-Id: <55751bdd305f45c046c9fd1d11a29565bbdbb790.1668056532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1668056532.git.anand.jain@oracle.com>
References: <cover.1668056532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: bebbbc95-e1a3-42cd-8a9e-08dac2e1cac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UzV+3pkzMqIv+lOUg3fSf7qcvqLF+ghWm7xiqT8h8fIG+ysYzkmISwdAGjOa32cbKrqjE0EGGsc/IhGzF73uo1NJ3YTQcpSw1OeLGdRnEiSEfBP9bM7URa2L27DbNMOAocJenSMmbiCuYAY9DBJXAIGOTy9MkbUJ0oj7QYQQU9wQhSJv1wBccP7f3mu6Lroa288k4x/2/ivW424LFD79eZcL2mC5CmLh7Pxp2uui6frudwD2O2CUGR3bTYhLxz/Rg2g8BwuevlraHCvXxJVHS9LnKdKVNED2tBXQm+2wizQufJxu2GWR752WEn76VrHOQ46/NlL6dHmRBUGCd81McNaH39AyBQB+Q+kgGkf+J13DW5LZMCOszarwQe/V2tyDFPO3cG6mfwqUURgY3thNQIGx6gaREL3dyMRRhlU6KCQGnebd1MSxzvV3+6DJSLo9JKJRh26hz88w3wl2mkaQgNoYRVYecE1nZTNZvUt7JYSAU52Zq4pmIEfGKGpvnDsoqpAiESyk+m7xt8GA9EaPs4y91RFC1Gc0atBjUm8hOOLOLB4DGMIEh0d21tAS4utLDEpx5lTT7NIRYYzhuydl9GABJZhNdsXYRBBpX7rHsJrpP9MeCzpP/UxyvEuG44Ehz284quoeX32fgeNZbbQXuYfyXJhE/ksgI+B1shZBl/65Y8Jb0RBtMgwXqjyEHJmlTSxCluQpGzu4NXSeGT7Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(83380400001)(6666004)(6486002)(44832011)(36756003)(6506007)(4744005)(478600001)(38100700002)(2906002)(86362001)(26005)(2616005)(186003)(6512007)(66556008)(8676002)(66946007)(6916009)(41300700001)(66476007)(8936002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+w8U+gMGyba7nMtU1pWCuEkcw24VfD/R/TNSkzuy5yJAz4fCHuP21V2QZLzw?=
 =?us-ascii?Q?SEVrOWMmewCuJiNkE60aRW7ZrN2nZ4S3PTYt6iOLdcKSvByA90eAW+2MkzKm?=
 =?us-ascii?Q?c99X5Cr2rPAjM7JB4jBJmzEN3Q8vVUnBIysqzbyJn6fikHY9klxu8/6zn0VN?=
 =?us-ascii?Q?W7na8rS3Bjw8y4zoUEsrSDNk6RXWS9K+UgHCXbAcEZfmWdkCLcQDqKcLW9Si?=
 =?us-ascii?Q?YKvtoZrsQoabXYn+uVYQMNxRst7R3GKHhNVuTX2HyVAidZqLBTwW/onbzlDd?=
 =?us-ascii?Q?TJF26w+WpW0XVQCGIyfL7oBCuuTRLHROWUZI2gYKV13uyz18c1soL2iGwJLf?=
 =?us-ascii?Q?mXABuXi6rCAU0tE8TtbTLXfh9JBDw2I1PszQ9CNtC5WwSmQLs7UEldTpddDC?=
 =?us-ascii?Q?FjWmpipeUfSYhLTeMAbrOO7kHvo2KoJ+33jHgQyG4VazD9MNevQZJxPz+9vg?=
 =?us-ascii?Q?pVbTHHydqm9JTmE7nsIqwcgOYp/P8ylm4n2QRsDPUe9yXbwdaI8nT35YEOWk?=
 =?us-ascii?Q?yVAcvSv6EmUfdNcdg7hVTvpR1cnrYNDJGxilHS0cBIKW+9DBmLub9zJy6Cmv?=
 =?us-ascii?Q?7cXXQArtlKcApoLRfYMBTQvL5r9l3B17OaZaKpf0gYTtLxjNlXZQnqfvG0rf?=
 =?us-ascii?Q?dsnKhVaUcAoB01LHQcZ38fOtJ1hHpHlt3jfjXairkwFC41Ynp9FJIesxZQpd?=
 =?us-ascii?Q?3WOuxEbxe2X7X1tNqtqv86XkvylLjJns9IzPhMJfcoSpOs+SDUbtsqRQdkaJ?=
 =?us-ascii?Q?NFGdAtmvsr4h4UvEFdpDBbW7ejhrJ3pA8WSVhe0a4LRHWglEJYXiWSI5aIew?=
 =?us-ascii?Q?hne0Rc2bMcugyb3+DO8xWaGUY3YDx8VIF9S7LdZfjG0zsBT3wMNBOAWKlzbj?=
 =?us-ascii?Q?lMqdutuo64jfZuw/b6FRwbkEdSrm8VuPthSohYacWL2jdsBMEwYjudu7LK/T?=
 =?us-ascii?Q?w6qFOMTQskFIy0KV9WP79QHyIdDVZeBh6qOeOTIV9tzCquXkTF3xyOW0wLZ7?=
 =?us-ascii?Q?jZVZGE8cUFfmuTRMCWuNDt/ZEnAVVucXPbrE9bmYEBl3wLJ/4ASyrVPN7Vst?=
 =?us-ascii?Q?YO8tQi0W7w63T6M5r45UCZdozEnZFcqLomToPSYSDQ3GSEaforvmB7cawfWO?=
 =?us-ascii?Q?BuirIU8KQB5rO9DKAO8k80hm51Xk1Mu6kqEWLBLUyj0d+ateJegSAPcqypp5?=
 =?us-ascii?Q?wZnY7JsaTuCNoNQTAPwOkmzCmmYJFXjNPoC8bOHSuraTv0g2dp3HQKnzYvDI?=
 =?us-ascii?Q?h02mgEDJ9q9kMvoY0cIBjFhPNTr8v1hyc5AA0yXwgxv1WgtrF++I17/d9GfU?=
 =?us-ascii?Q?eN8FjkJWJ7MIODkuV+JEjTFbs9SvErybX3ryVWQjDAi8O0k4QeUMD9VhPpKN?=
 =?us-ascii?Q?/GYZg9PWa8ItbBlcdFjYZuQ21Z/6gaE4IK4O742j9SoutGtypD8KIxkXbnZh?=
 =?us-ascii?Q?W5dRB+EmHiTjNnGceN2bJTS4DU68fi8LJOxdsU/a+wTG5vZQR0bGCJ8T76hG?=
 =?us-ascii?Q?VJA6Ziii+aH6YwKBO+7eRjEWVSCQB+8Iw2Bqc+Zm+k0CzrO4mfupioS1nFCE?=
 =?us-ascii?Q?nkjgbIXaDJ0RZGAxJV7bH/bGGaJOw9tUq5MqNUNsStft7N4IwUi52B7nKa5R?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebbbc95-e1a3-42cd-8a9e-08dac2e1cac3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:07:05.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99EiQ3C2mKisH2/CyelIKpNb9SOZfsE3lIGH5wcabUhvstEo/FazB0Ggk+Dzzcx5HfTbRmlHHtM+2t//mfFDdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100044
X-Proofpoint-GUID: peJ_z3o7e_Kd2jgc2JDXkgy5-Xo7GLpZ
X-Proofpoint-ORIG-GUID: peJ_z3o7e_Kd2jgc2JDXkgy5-Xo7GLpZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_ioctl_get_subvol_info() frees the search path after the userspace
copy from the temp buffer %subvol_info. This can lead to a lock splat
warning.

Fix this by freeing the path before we copy it to userspace.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ec310868591c..18be82a4d01b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2214,6 +2214,8 @@ static int btrfs_ioctl_get_subvol_info(struct inode *inode, void __user *argp)
 		}
 	}
 
+	btrfs_free_path(path);
+	path = NULL;
 	if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
 		ret = -EFAULT;
 
-- 
2.31.1

