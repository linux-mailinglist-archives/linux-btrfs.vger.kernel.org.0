Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B227B6AC130
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCFNdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 08:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjCFNcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 08:32:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE1301A6
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 05:32:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Cwq4j002528
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Mar 2023 13:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=PxbAMY8qYOlVyh5SFakQxw97ewFwHEE8eSVoJfCTHwo=;
 b=gfsAGiXJ4i3Ye0Ge8M6xUvlXZ6uDBRJVM6UaPHC1RYVi8iGwEvbOIwkrALjscPQcu9bX
 0lZB9qMtesHwT1ExAy9vvflXne8IlncQUSOqWTvTDsPWnxyrueXh2rNBe67jp5T3vvgm
 qrPKabzuJmnxbMdrlsCA6K0TiP4QDMq9OLYCZEWHh3ZCtkZQqYtzDxhY6d3FASLkgVWN
 MCadF4SYQ9IJTt2SDXBqIWHjV0kb0/Je8hE3/pkUhm78VXP/7OajSYq551VPytmmdTo8
 Xr0aOFGV+7WPRxe4ex0KO3upzJGiWDSDjHT58FMtx6SI7jH1QtcwoeKYrxo9BMFrWNF5 Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cav91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Mar 2023 13:32:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326BjKpi025119
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Mar 2023 13:32:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4tthftse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Mar 2023 13:32:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZIor5ZAXPPXTdwFedrFG1oDWbx2VqhHY7l2PqiBtJf8ZFa8QMcBpvN0Ca1eqwstUt7/jjL5iivi4e2nIGbGXbBvnph1ajZiY6lXX9+vpO7DCKgoAX4zIlWnKZRtzDV/Qq1Spi/JdawAsQ6wnsZ/p6O3xgBLR4aUS9HmmdhNfoyKOzy79zzc8gkxnmbi1jot+m+wvpPJoVjw7fAZPb1tBprkOi3a0YWCT4sbme0x5asNwpkzZaKGLeVlUm1uoLlDoQBW4zCAy8F1uf8+qYwj1U2i6zLt53v74nb3Kw9u/ICczFkvffXfNuHHJjafqUKxMqknOBNem2vi2sqNJN3QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxbAMY8qYOlVyh5SFakQxw97ewFwHEE8eSVoJfCTHwo=;
 b=OVt3TbIJYMPnyav8BY71wAP35UHxe3Amx3+/AAHPj8YDzDEn+GVCE6BCE/PAz8x3NrJT77eCjgc7YRNNjvcaTcJYkXe41ORKm9sYMl7oa/YRaHDQP15Ou7nz41f5qbbnaCNXPYbHQg4nP4BN6GPgbjH6jX3cmRoTRIgEEvLUjZQxThb8s0760qFPFmk9Sm+eAhXoVGuwIuvAXGAIihp9vWt0CzyW18aEqyweP9fxEp9H5mY1voOhTph+/dXPOV+TakYc2jMh9yNJ4clsLZndqYMLSKIgGDRDTS+nL4VOSRWk45jrupPEnEViFhucVjq5366wXMFzB6GPOTuILyE47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxbAMY8qYOlVyh5SFakQxw97ewFwHEE8eSVoJfCTHwo=;
 b=Q00/4wm2Rgn5E+9xJUO8IEMPAnuR1wF+EfkSPoohwHyI0GG633mwj/EMeO2e2V88JPjJUTQHoINrPW5wSyzCFBSZvFX7CawKdxuD2knZn/d3VdFnjoHUdR0RMrlc1vL6Pw1ujLv5oDqpWQaQt5Am/ROBk8HmieN+ORxaFD4ALNw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7157.namprd10.prod.outlook.com (2603:10b6:208:400::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 13:32:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.026; Mon, 6 Mar 2023
 13:32:15 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid repetitive define BTRFS_FEATURE_INCOMPAT_SUPP
Date:   Mon,  6 Mar 2023 21:28:09 +0800
Message-Id: <ab23cf2ea306080a7d2be5e67bd22b6f7a9105d7.1678091761.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: f9099500-cb26-40d7-ce89-08db1e4732e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAmv1bgnWrPMyI1rLwCSjO2JAgrX4aCOZwAeTI9I6OhbO1STdJWJ6QvahEScJC2h+GWFwn+/XAXF9ParG+xU6qVQAPi8qyqWYgHXQ89WwNhq50OTmimrHS4gUndvSWdwmdE0KiRFkYTinbtdVmDpyg2Eim50K9hd7CZaFhu1nI84tRIC5A30gSIbhHJT9BWJsw+2CtMTlJxteyaUZ7Yrb/Qajx8REH8wBNkiRdDVHjuLr9o8loTpyYg873feaHpqEU9uRBJ5XfGsAWI5UbXbFJRtYr/iDGj2POBcKElwW4+9ymZow6l+BYioVQDz4Ny02ijO7W1yKgrYl93yeEsfiZxvSLc4kgf/TsBF3QlF17DB4X1fjJFy7ZK0W7TwITrM09u9sovpGqoirO+7dTXZnjg1MmW/Bstg0u7VnTSpmnyeYrBqhLPoyDawovEjFA6n0R8+XhnXQUMaLFLMCUmJRPAwONDrjz7HUq9u5E+vW1OrZ0m1V5LyEuA2BD+tdUM9RKKlG60emzghh+gn8UGQ3hLSyslGfSVKSpqNpzOjtFO97Ln59wbLFhdQPDGuMrm1lSnnsVLiaad2TBVk1sojtQ/jmm6FgcuJ6QYdMVANqb5BTwF8mlMBSle9zpuKY5FyPc+EXpxRkqMXgRdjjFuz5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(6506007)(6512007)(6486002)(6666004)(36756003)(83380400001)(86362001)(38100700002)(186003)(26005)(2616005)(41300700001)(66946007)(66556008)(6916009)(8676002)(2906002)(66476007)(8936002)(44832011)(5660300002)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cmGzCkQ1XuAdhbjsvdjRYYndyAg0UhS0PZuy06yfJTxPAjhswBTr7avzEtw?=
 =?us-ascii?Q?MVAqghRiR+0HdbVWTIgbhToWWqS7hAfWSwewXXcAs2ivPUzSZ0WqQUIrnHgs?=
 =?us-ascii?Q?SnYDbfQuRd7ZDiwQ17fTFaPFftg6YOJH+RfzHOenU0oYOQafi6QBVY5hi/jl?=
 =?us-ascii?Q?0j1aWBtedPM2grpRC/Q9VKcRK5l4FSOgLh63j7Gr7TzMhw+cPZFNFpuNBizT?=
 =?us-ascii?Q?LO68NLfN4KiyC4eY5rvIt6qv4VHAArbqD5SkIDerVuH+nz3ap/j1fGDm++P3?=
 =?us-ascii?Q?eFcUiSG5lGh3/8Q7t3xq2ma0Q6CDlLNUX3kGbqbyI8oZ1M9FhOQ8ZCsn30EJ?=
 =?us-ascii?Q?HWjTKBql+Yw90Nr54mq/dfJhv+n6xviiJf5evzk7vFuWz7Tf6ElfUu5REw9j?=
 =?us-ascii?Q?wu+9n/XpDmXqAwn5hCialjj6qAi7cqhxg69GLJDvunjLJdBUzxl2KXyzYu+Q?=
 =?us-ascii?Q?wj2UgxA1gws51//m77n7lJS+DHTJWJBJgtjJjkGRskQysiiptx2DwadTmE1I?=
 =?us-ascii?Q?+wUE81tW66cI7vpyqK/6VK2KoeVFoJ2fI8RvDt9m1zq+XOsz7AmHwb4yhiHc?=
 =?us-ascii?Q?K9zw5eWDhyAuyBYfuH2VtchxiVt0rS295KRqnzHmvfP5HuMzrsaETsoN+YGv?=
 =?us-ascii?Q?DO/PUeAF57iQ15fQ75VqLHsttli/iSTv8L9kR6CgWtakkkG8GqVcleWzyydQ?=
 =?us-ascii?Q?RRrX2we7jz3rkvais1jkuLOybN70ASVd+qTBR/Q9rEySCxhssAblXQr4HhhP?=
 =?us-ascii?Q?kxK0Crx5S2IswXNFnydb6AdNuLUVV80q9qJGe+adspiwFOlnTvecyLDI3tRg?=
 =?us-ascii?Q?zlPsKfWmjz1fhPYfVTZUGzkA1/wOCbs1L7jHMhVFm73+EDJRXTFh5WpvaX/f?=
 =?us-ascii?Q?UJ3D7pthDWf9ILhdNbPo3SW/oyh1EhtoeeQoA2EfY7xeuJEqHkljmFDhn11Y?=
 =?us-ascii?Q?c3Vdmn+Jwibuh++1HDaoYPdkDnd1Z5GWoyu5ZMYurQyMjVEyr6eUCDZvEbnR?=
 =?us-ascii?Q?rzFfJzR0/83Qjv5tgKNFjJLm5WEcQ5QoHxkhLju/VIpkw3DtGB4F3nBT/eHk?=
 =?us-ascii?Q?+WtWm/NkVweKg0gtNz+YXIAUgceRcJmtNGX91w/opVhTDhqkuiFDm0AAOPX0?=
 =?us-ascii?Q?RUVawKlBZmoIUXIRAJcb1Thzp/8RbDYre5US6NInrmaV/q/+nrReyGdKwY5g?=
 =?us-ascii?Q?pDXLwE2AoUFVr5vnLMCX6JAAVtrivSSVpE840SKAsSFwZXb6ZeaNGSoXuM32?=
 =?us-ascii?Q?ctLLLcmpUtk6Bq/VgoYb4knMc2HohJv4AK9e1Q0MGlnKAluqko3V6tIusaIP?=
 =?us-ascii?Q?39d/s8ZTIeNsEuf26d8Hmk/TGci9+rqQ5SQvrqS78WYA2xOHAxBEczMWRxhu?=
 =?us-ascii?Q?nf/2rdkkcyaarcwGsSJU/gzul0SXgF/FQihpfnEFmbixUEyzcEvO4fmqmGIe?=
 =?us-ascii?Q?xXOjfcjohj4Pnv/CYRqu3AO5hZuzUzcC/duPEP3EAM4nGXRIeJhgm9CKdrn6?=
 =?us-ascii?Q?gZ4pGD3BOjGGrOUMn9d9U6w2v8qPYQKlGG+zUunW6+CFDcPhNnphcYx8bfnY?=
 =?us-ascii?Q?KVGWY+a6LwumgU1bIJ58YpVhOXSrpX2JXjewfr1g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cI0NdwM+T7zb2h7w8aJM0hOvxBJ0XQdnLIdHimX9/SuhVvSAa51JumvoRyYGvL/yc2AA8zFYNY0haQ5yvxylw9HfsgjAO+aNNZtE07MAjQA3ydWjMgFnvyNzl0nYhwzuBlkp+xvihfNg5Kec4uhJv4PbH22wyCn3N8GSzU8MTaf8IV5JLbFL8E/d4PfAdfrGiSeD91/Q+c9kmUJWHn1wU0SsRHz+2x4Usl00h1hyxvEp5bHQOCNKuVg9cGBKE3pU98JmwdodmsMevixw6SRH0r5F6slsy1AnrmJfa62xCHuFViS/nsA0v/0a0CjmXFdG2QGzBg+gg4Q/pv4f2M66pgC9OYNcVpYL3W5Z4b+XRwOdp+Pug6Vhg5eWQxQSVgJ6TnwSpd0TIlhX8tXNVMtBKAS6GUKJ2JHYiJP1L//syfeX0JuMZEJy5ktFDvdXQRSXW+jEqjHno+zPJw7SwilJlx5M1x1XZGniNIKlrhAapv1CzAP11h1jQ3sPqWRLtHcoMzagbPx2jVY50NmCmV5F5eXRL+WXppwsmEVIt83JME56ckSpb4ko41idyi02+YIWmfjXoNEv4sTNPRg5rEIbPKrXw2bTa0hkGzG+GzpB/UWKdgQHA36mR7lRXY/tmN8/yKpV6wC7EZr3CgjTWD5/l01+f08s6aDs0FKTHEU9Fm0bnMLeHq1NABgZuuYU6jbidbHPVsDcujZwrV5/nUjqjasCz5k0YSm0HKJvbLDvSia/H1mLph70Nu6yiH1NGs90
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9099500-cb26-40d7-ce89-08db1e4732e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 13:32:15.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9lqKu/LZF7R1g0Jg0nksnfUOlh4QMse5ticDyAPMkXn1nVYL37KGLqy/I4gWrL/hLIBcCEsRoN067fX+rPnrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_05,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060119
X-Proofpoint-GUID: lcsAYk26BBn0d8YHFxwh50Ietnj7bDJg
X-Proofpoint-ORIG-GUID: lcsAYk26BBn0d8YHFxwh50Ietnj7bDJg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS_FEATURE_INCOMPAT_SUPP is defined twice, once under
CONFIG_BTRFS_DEBUG and once without it, resulting in repetitive code. The
reason for this is to add experimental features under CONFIG_BTRFS_DEBUG.

To avoid repetitive code, add a common list BTRFS_FEATURE_INCOMPAT_SUPP_STABLE,
and append experimental features only under CONFIG_BTRFS_DEBUG.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Also,
Would it be advisable to add a new Kconfig define labeled as EXPERIMENTAL?
I don't believe it is, since if no new features are introduced, removing
the Kconfig would not be a viable option.

 fs/btrfs/fs.h | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 4c477eae6891..b7c815bb7fdf 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -196,27 +196,7 @@ enum {
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
 
-#ifdef CONFIG_BTRFS_DEBUG
-/*
- * Extent tree v2 supported only with CONFIG_BTRFS_DEBUG
- */
-#define BTRFS_FEATURE_INCOMPAT_SUPP			\
-	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
-	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
-	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
-	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
-	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
-	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
-	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
-	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
-	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
-#else
-#define BTRFS_FEATURE_INCOMPAT_SUPP			\
+#define BTRFS_FEATURE_INCOMPAT_SUPP_STABLE		\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
 	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
 	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
@@ -230,6 +210,20 @@ enum {
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
 	 BTRFS_FEATURE_INCOMPAT_ZONED)
+
+#ifdef CONFIG_BTRFS_DEBUG
+	/*
+	 * Developing features like
+	 * 	Extent tree v2 support
+	 * is enabled only under CONFIG_BTRFS_DEBUG
+	 */
+	#define BTRFS_FEATURE_INCOMPAT_SUPP		\
+		(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
+		 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+
+#else
+	#define BTRFS_FEATURE_INCOMPAT_SUPP		\
+		(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE)
 #endif
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
-- 
2.31.1

