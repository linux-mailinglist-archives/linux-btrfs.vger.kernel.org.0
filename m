Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACCC741092
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjF1L5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:57:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27122 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbjF1L5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:57:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTanu000846
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=jswYXeUi32MCzO8Sf609YkUl0ex5Y0mQGYAKQUyG2Bk=;
 b=0zHFlnm4yM8RlzjvQ82Ml/ig4WEZbDpXFYtVgKmwjS41nYgCxag+DAOks6xNEoEPjqjC
 m+XXwGt4hb+tpS2CouBQdH8SHHAwvPNxHPK5AmsGHiISI2U1SosloAadHC7E83UwRVN5
 hbRBQyNPRYEGuI1QVl0sihTaa+dm1Xr387AG7GBYhPQ1WPgvC2NxCp29NODVkB4zYBzK
 OZxvoZdvAnOOw8MiHnLsTTOk0QsVADwYJvByrlMSssiTMPox6Cd/55YXAvj1PNKdcl08
 V+iHkbQ8JlG8s5zY5Di392uKIcEzFRoR6Ph9DIJnwVeab1VGa26ISkskskTfUMywgmxA Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30ydt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBPDwt008684
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5wem0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnuPT/lPUVDn7iSOX9iHRVnHNQOOUKR+/Ew17SoVAR6LRbtVIEf8QePuPalcxm8fJKgNzp1zLny9ncfZbANzmxfMatrWFk2tIftmlM67+RqCRGdonVRkeyXBFlOel6zH+dDSMOHOM4r8ynnbgByWnl80YjEqCKMq6/4Sau3odTxPrf235Lesf4rwyDozefrkjO/HLL9kluHRe0yvjSe4CHuEfjuUrW6xu/JMT8zHQZVvLAW1UlfvvbY1N3/mXV+YMGEqQEHy2uzMZ/y0yNI4yWO9/OUEVI0DPk8e106JQk+B/rnsf5sv8Z8a3Iwlc4xbDzGoNPhAieGKw8uBBjRMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jswYXeUi32MCzO8Sf609YkUl0ex5Y0mQGYAKQUyG2Bk=;
 b=BJeCxLKj2O9XGRnk2LV4GTY9uft+Ay3QtrHHHXVj+u1O3S9HSyQCS61mAg2oZoY2SpynnWaRSyJrIt86njUmByGWDnzq1/0Tmwan9Oxj5LtQp+zKDZwObi+6WQgY5fQWn8g/ItdX4oFX6EgavzpckO1E1r8GRh96qa1dS2ihh4Mc/A7NAj49O61ESokMOJx9wPGFeoa3p1r9BvjvQxXg+ee/dy7exO/wChfEAM7So3uyuo4RoMID9euDjky0hAjp4tFtBDrz7O8S9B69ER38RY7iRLYTbHNQy2cvUM1DOmtGXej/iIRiVEhOLdxbnjHawJgAsk2YQJqVVKtKvzFq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jswYXeUi32MCzO8Sf609YkUl0ex5Y0mQGYAKQUyG2Bk=;
 b=deAccfCeH5Bcll98t3zz9OxsV+2DaHu71WczGVJp3zYc4h3YcePNMx9zQJuFseithhkVtL4C4iAcakSO+kj/geOF3DjvTetT9FBe6FTBnje6MfuxP1xYOu4isrXHy3FbbWRUWc8PePLrl+YgvaHqM8aJjFeALqeH2czZB1VNsmw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:57:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:57:06 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs-progs: docs: update btrfstune --noscan option
Date:   Wed, 28 Jun 2023 19:56:13 +0800
Message-Id: <9cb7c73724b98b8055b7908bcfd1400fcb3dcd0d.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb2cb26-f2ee-4377-b0d9-08db77cecb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJMwCqeqjh9UdZdud/SjdEsG/Xmwmk9/sEQ8dMbaLBF1UzF1BUTYHoaKu24gSnhH/lKub8SpBT66W0+Ss355oKZ+KHNPFDBLaVTEAg9pLf2l9c1B1C2njablTceFHVgaBpZZI4IrxN+2mzg1S1Z1RNkvZlhpQuWP8rnK1faXg4elByJ+zkXa8z+4j5bN3ByIvn0vDHZ+7wwJtF00MXoDhH8mCzMzaeC3kB1bG7J3JJRBiJK8F2YE/wXoDFTq3zn0YMnzwPJ0IhA+Mu531NL5/S9KvnYpvrTTAZZVjXlV1e7Z+pWwMAZHKoWAk9paD1TN40q2CYW3VreQlH3DwvqHNjHJEAGo+g1Ydi75XwFohDxyOy8B/skWcBvMOZgKohhYk5xbf+nRORnkMIE/pabR1qRIcizOTdVZox7CEgrdHIDz3zPoVObscoJEtpLIK7J1GEuoanp3rqpVI3m4JLiaZKA+7EeYYjP5rkuyKqzeNNrHCo9zvP2h4sdhJJcgnRZ4pX1uI5xg6httCeQ3kL+8GwV+LF9xmAKgKdkCA6830DDAkiADdlib//VyaomDIrlQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(15650500001)(6512007)(4744005)(26005)(2906002)(83380400001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MbvvEBE8/XXBVYStODnZzB2SFSS70ucnxAB4PhhjyV4ECLBy1q4PVDDGn9Qv?=
 =?us-ascii?Q?36WlM722FxvcGLraA/b7Og2V2f3nDYPLyUIBj99vBvrZkYrCaX/5Vml38pwK?=
 =?us-ascii?Q?+7kgpb83lqZj/bBZz9jFHgbzHkg0VIE391RlJY0RArywRhC079h2/nUKLVMb?=
 =?us-ascii?Q?wq6ymAuHs9lYHa8gW7PKSd9wxcNK+JWLz0CnVHFwkXsvcsSDFxx7aaDlPRDR?=
 =?us-ascii?Q?vMSCxF5Z502ClhWIrBNJq3O393xnk4r5eWmnW/DhrokXz4ihryGN5XYzQRgK?=
 =?us-ascii?Q?ucMG7ZArxWOZi4y3hJyKohG44nIOssEenAAhuAbuhxA3PTxSEwV9FL2C1W6M?=
 =?us-ascii?Q?PwQFZuoZcdzlxCKdvRYuSq3TK0Zhrjk08ZBfruhqbxGgV0gPHwJ5sTI39fJS?=
 =?us-ascii?Q?GFhC6J6uXaax4fBu/2sXLEqZ5yVMYmNGS63g6oKEYwUE3aeMen8AcwizO9L5?=
 =?us-ascii?Q?dXjG4O+gQvhx/kmlzGZYSgVjIGU4DlLpqx+KVFC49Jf1wOT4iTRQBFENLhpr?=
 =?us-ascii?Q?SuIYHrNgkD03pLZUIqhM6p3TcHxUY0raissmbqTI2MSXpuJl2AxSlnslfe9i?=
 =?us-ascii?Q?XFZ7VDuvCP6Nv+woB9LgCYx0fpMuWopExrCadej6KX0xnrRzNlllds4khGGc?=
 =?us-ascii?Q?7nZhJ+03zyp8C/JJLql9k9pH0wME2mogrWWhR3ne0fM+tomoJiiocMvbL49c?=
 =?us-ascii?Q?EEGm5BGofz5TyaWTTFCUHNWxnbLeayEpHzW701H4xHpL7t0d1gGfxS7HW1ZB?=
 =?us-ascii?Q?O5Jn2KKCDBVdVqnwBRnp9GVsqRZpcpxwDwGRp3ycxLPJDtzGMxw+mMEJ55VU?=
 =?us-ascii?Q?I+mi2u5CG2pcKBg+eRCLLbN2GOWvEG/YCm/nf1YD9wUuAn4sCj9rMpsEB5bA?=
 =?us-ascii?Q?ZGwbEYXhUc/KequUqKnv/KabO2rgZmE3bM6JZ1rkyHLYOuQLK/cEC6gtEd2T?=
 =?us-ascii?Q?IACRS+M5wV8s70lyZ+DqMR3p7UOq4RhVgIa/nqWHK8jNQ5w7dRo2aGLJBtwm?=
 =?us-ascii?Q?z9Up4Es0JHlPQ6tqQXvLLtSXfD+Tg0xwykPNAGKGNixgjn6Pr1VPzKqqjN89?=
 =?us-ascii?Q?tS75Zpy4X3UdlADQa3GwZ1dQoNGrQorqAGCu+wQ3FugyqJLKVd93R2ZAYYyL?=
 =?us-ascii?Q?yig7fb+QYaNHsjM6P9e4tE8/Szudvx0m5GJ443A7qPCHEO8IQZ2dSWOhGgp3?=
 =?us-ascii?Q?Fm6zEzMEv3aSKfVFFcq6F9BX77/NJdExSENQ3XSAcRlq9GgYSS7Q7cYYEfKe?=
 =?us-ascii?Q?2KinVkwuQ3OPGpbC149cSfXmDXvGXTnxzzzEyI9B7Sk2S6i1XPf/eG8cOeaf?=
 =?us-ascii?Q?U23lgQw4qgX1+zyqKNrBHBHi3axtOTjL1UpBtCGk2cMCMFIdvu8xqs59mEa6?=
 =?us-ascii?Q?OPTA/jlH3BuzHboErVHEr+69qlHUhYm0x6cwOYURutvW42yVOPcQaHIgelRw?=
 =?us-ascii?Q?y4Ax3pJBFE8eEuHRzIHVxrwMU0W2RmP6RuJBROhDJZRxPyiogDHQH2rNZl3E?=
 =?us-ascii?Q?GZCWU84Lk7SWn+AVPu8ySvVEVWGv9afrb6HdeGeWukwV5bPNeP8tgbY2En9P?=
 =?us-ascii?Q?KElTne8zCMffTtc/h+ucJHMf+jVMi7+qmb+FPmVy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gQXod/70QkCqAH2rITe2b2FPVD8NvqFKD+PZYe6iDRyO+3AdPRD/57/ZMArQfN0rE7ivLmPyeewAWhYrzA9MLtl5F5lFQUNwOi9OljBcLVJ3PHCRP5rw8V9i8WVJKFsQRum+b5hfeBBmZ9oFuS0pRuo9YimTBgwktxv093b7+QSaeHvFkahH+MKPqJpFVJ8q4NLi5NioboQj37CDE2nir+Zly435LV17XUKWm4yU8NxEDIy6Jwjr2Jz2xam+RQiT42k7y4kFQteMZLjbY8ci/IFfejLAyyKtR7G5+iWoFXYtzthW87r0RAC+GrBzFuHNXIlROxhqkVVQA6q7C6Xr8Dg3lE88sWUEdiUU5UvYAlSuyJp7UiPcK4hAWJObluJa+2MXl4FOiYtzNN0rXdHM+rvg2vNkj11xTDqbHmknk0BWB3A4jfFDiTp69cpG5Xcb8jfS8fQea5LSM9MLcPVWDEg6waPedxLPkmMftWiKdGeG61+0sOJ7SE/ed85Auo46Ui70yneukpJ0x1ZlLQ/Jx0M1PYjwiau5/koxiFtMOXlLufL5Q6taxJTu1bq34yJOfke+v8fZ7UL++OZ09Fx/xpxNeIu0485m3PX4nMsg5CMH96E2n1ZGSQHzABZViBOkMtqW1uUViEJhnGds9nwETHNJFvGxsDlLE0sg4K/jESm53z7TSjsTPmcvlJ3YQWX21juTOdLV8HU1x6L5AaMMEJKnEqc0+PNjGEQZli3yZtcQSCbn8i0fwJ5GzutCVJd6W8gxcVKZ6F3xzPGZKkygnQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb2cb26-f2ee-4377-b0d9-08db77cecb54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:57:06.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAbG+dMlwjtnYkeG/CXEH8JA2j4aK3fFkeb7A92Bf215GdPuJdzT/g4LCe4GiABXRzIfRn4CwPxtgzrAaM5tPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-ORIG-GUID: iHhl0vC5pDiUyHluUpY788NW-085RVQw
X-Proofpoint-GUID: iHhl0vC5pDiUyHluUpY788NW-085RVQw
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the Documentation/btrfstune.rst to carry the new --noscan
option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/btrfstune.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index 89f4494bbaf0..71a05506ab13 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -49,6 +49,10 @@ OPTIONS
 --device
         List of block devices or regular files that are part of the filesystem.
 
+--noscan
+        Do not automatically scan the system for other devices of the same
+        filesystem, only use the devices provided as the arguments.
+
 -m
         (since kernel: 5.0)
 
-- 
2.31.1

