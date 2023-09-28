Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195E57B16CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjI1JBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjI1JBo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 05:01:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC896B7;
        Thu, 28 Sep 2023 02:01:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8q7Gr004245;
        Thu, 28 Sep 2023 09:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=nfU1ebqCVybjSkinkaI3kZhi8w5wJiHd1S9mdZ8CqKA=;
 b=zVOHu1c1KM+6TJAV65BX/Cp9Z6P5uPh9QkCAhKyfa6bgqXfp6vSADIkZSTqmMsZvf/Sk
 TARkTNl99nVff+246AW/pNQ+yVMumiYb6y4j5n9s3TmfwwFpRekDGjeL5Nm35YXEIp3r
 pKXd1QGqVPNSle+sndwKjrujjESzK7OLVbjp+KOTuIhsZoUDOpbgzwLXsRl3uWYjcjjL
 zQ4Js+F5JcvoT6ELER30xUdbo5kuuYtOA3zHWBmwaOTNRpt4ajWtSQRa3ZvxtszE0/lC
 /hX3LxpKLm4mD6xIqQXv7IUpCmGH/mNpfBcujnuf3YKJriO0u9eF1GWX7iMLn6PiZPR0 gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dkx1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 09:01:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8s8c0032715;
        Thu, 28 Sep 2023 09:01:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9d5yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 09:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9/S54n6/PZ2Y1L5gVCBd8pEiZpK7rDmtnn/BteNTnh6cvJTes4VEh8nn2Qonj3wYAPUVV6o7YJZwOJdBmjDR66z2+03QSECSnJWGj/hbq1nt7k/+gqPefsn3pwHgnIocXc8yka4Ok1Oicf9i5w8Az+NwtIDiQz2w+2ximODG61yyV3nO+GQOysP9yL0AuQmVdNDkZ+NEgoNsGA+q0YtxJHzsYuDcQA9Q2e36r5rf+3IUjYk/eGS+TxA2Ob6V6gvr7dENAh02p2TjBK5cad0yL7jJHj9p4zuUIGHTH4y8B22VkZZ/2NKGnkSo6Et2UmeN+H04WpjBiBpBAhw2U97rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfU1ebqCVybjSkinkaI3kZhi8w5wJiHd1S9mdZ8CqKA=;
 b=lk9hF3cbdfVZq+jAF5P5cJaBUCkto/rq91ru5TwVoJE8dyBSgqX+qXCyEKUwVFXEQVQqeZerH8ibwFT5ZLxZHZjY0W0dEqwt8AcvN9z+qkLt0Wdv/jcRyajpqB56TJJiQ6spUTr7woQjDv2eXLVuoOTkhJhC3CvTuL0DDA8jT+3fNqSkRHssCxUmzpF9E2MI08vE/0J1aqYgBuqIRjJP+UzaVfbDkjCqz69TXruFvsLsH0HE7gPvp244mb2KqgnWhz6L0ani3L/uU1fT9NlxB9omux8/SU7NrloieCnZu+na39LcOs/IMwAxYvMDwelZP5vdntdIHpZ0QuT7VqQc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfU1ebqCVybjSkinkaI3kZhi8w5wJiHd1S9mdZ8CqKA=;
 b=xiw6uDArJYmG9bOCqAQbF2qH1iPXUY9hriR69GKar4jZMYVLefS1dKk97B2JaftomAaGrs4VFq3x1FZbUiDOGrpBm+7FJTgQ4+X4TartZ5oJ2ZdETbld3NmrgYJwSGkfGtjkt6Ijxykj2y21f5I1ABWeKZScZuIEwf+EvTG901s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4498.namprd10.prod.outlook.com (2603:10b6:303:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 09:01:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 09:01:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs test scan but not register the single device fs
Date:   Thu, 28 Sep 2023 17:01:30 +0800
Message-Id: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b8b632-be04-4343-2a43-08dbc001856c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYD5WUx+CZs50EVmzAAe5G1RASOVe/j774qtZbDg16Lb+6vIYDFvQ6HaOk5gW3e5NyR8TR+mjBC/YA9JPPH/fGLZagkYViJeEJRzcbfFTqTibEfGpm8VtzcYyj0vNtMjVwCVY+2tlkS7wnK3jTEGosoLncFjtpilTZVAZ3llMEyQnst+/HzZAlIjCeboTUn7UHoz98gwWkUkjUMVhoo7n1RBTi5ZsURO9kLhnoVEh4ClAj/aji9Vqe5D3+17GPImxprmRrd74aV9iJ6hLY39YlwaSxjawH2AregnC+es3GMUiY71zKADQeR2zIghXjQdgrS7xWdH6HtEpwLXKEW6DonDUjERzNsCE3FAtHREWaNvLBfM2tiEWvqLlFTxb0Q1NH/DDDYug/13C9+klr9Mns3luVbUZlbtpc7XtxMaq+Z15Um+GdPmz62xpEpo+NfUqq5qg+0Ank+ue29gkmSJkT3egLmMvXVgUBrPUGkBB1BcIBfim5waByxKUtGwCdKKYTVrD4c/lE3JghfaV8JBHjAqsV+q+gOOHv6GYkuh574v8GQF5eAGWcEF0sofwxZw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(44832011)(6512007)(8676002)(83380400001)(478600001)(66476007)(66556008)(6506007)(66946007)(6486002)(6666004)(6916009)(8936002)(316002)(41300700001)(5660300002)(450100002)(38100700002)(4326008)(2906002)(86362001)(2616005)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1H3QqRCgyzzGUQHvht92Hj9b/pnm+J6q6egkDA5WKvnOetXSTjvyh/Oh2CdM?=
 =?us-ascii?Q?0SsRmwcACgDA0vCKkVUmNaFk56wXNsPFJYbHMhhhjP7biW0X/0hTWQmI8q4U?=
 =?us-ascii?Q?p7QPXUnDlXeHLvMfoBkbvmP2N50Jp4AK/r0/XreZjZgIdBbG7wv5vdegyQMW?=
 =?us-ascii?Q?L1/5JXAJhU7vZcgz3uJ2Y/n7iuTRkzSDoSJjCW5kxsiJtWq66hpKPI/zjL18?=
 =?us-ascii?Q?Q2/P1z/hEr6S1Cmq4u5sqmb3XuLBLMoPXWBajNOWW4W5mnyp3aRupYfyAJkR?=
 =?us-ascii?Q?q9i0Q3rBaPz3btuHOCjbQL5geQIlyz8JwyByNFGH/fVKCbmIUNZLliCfQyeR?=
 =?us-ascii?Q?kJwSM5Dsx/mEtrwK62KF+P756L1J0yE5xRLcgPKbehfs6O2yStPwA0aj/MGp?=
 =?us-ascii?Q?g1MIgWQZulnKgWExfsbE3TBCTOsN6XzI3EvvTSq75mR5c3e6wEQUe1+Aophl?=
 =?us-ascii?Q?v7uxbHn5gLv//PyFQ+HMj7e00g9CkoNUMLIeWB5h7lsXhFTkaBSHBPrErSEU?=
 =?us-ascii?Q?OkIqLs1w8Y1CXjkjtORXZ3p5Z497Nq2x6hULUtUEPod/l3JF4fSiy9dmtxUV?=
 =?us-ascii?Q?+Vt762eH+IZLwbqaN9WhL2SimX2QAdnJpYjji8QoZClKNh2s33taLopFx3FI?=
 =?us-ascii?Q?+II5Ra5jI0PqdUzief0U74OK1Jg+RroCNixVbr/MEY13TKneLqdOwokCs7li?=
 =?us-ascii?Q?LZ9F+luN5qolPJZuhWQGlvjcg43PprCZwhrGPdX0/GxTRkps1SRe4867TRQP?=
 =?us-ascii?Q?OO9rTH8RT8n3GqpFeEJtiq7XRwGSL//+Cfzv4VRcRJJ7euosvbt10ExSrG4a?=
 =?us-ascii?Q?cOgahX/GcogQzmtSsGRO1iQRW1M/mSNELfefd0NrVNUC5fxHvZ504DCSwqps?=
 =?us-ascii?Q?t+srZcCgbUpsXH9wgEMZWMuI0/ycD1tUWQWjpIwuZO8eykSzkE2SQUoxWu5c?=
 =?us-ascii?Q?nGebpTf2akuvraX7OydmV/d1uZQf3+fywR8ZMJHBB/yjBRqUqmN/Z96vmwtZ?=
 =?us-ascii?Q?p6oKiT7gNM3qR5jVzXki5xFHaeeuGEUcZV9hP1WEIUWWTUFcqkJrGwnI7Ynp?=
 =?us-ascii?Q?JwI3CGI95nu9jlC+q0NvGOz86AyCtSBZhNNtbBxleaM+37LFlKDSE7SLVNSd?=
 =?us-ascii?Q?DL+vkUFzoborGC8oZa+V75pV9BwSrOAq3pOSzJTnas4yUOGxej+TApsPvMIR?=
 =?us-ascii?Q?yCLs1SQGEj/wmO43r6XCGQ7/+AClMmwAiVN3REAFPrW7Z/ZpIN9epiE+G5SH?=
 =?us-ascii?Q?wma1vTAcAGqAZI1JZPVbVJvPeZBxps+2G1mzcl4/jzD6jIQ/K9x3z1a78rPW?=
 =?us-ascii?Q?yiI9z+6knJXL3A+XVd4jCOLxYqQVL2c3kPpiVcZmmD/iFlmFSCV+XwSTNUS/?=
 =?us-ascii?Q?+MIwXE6fzUoycnkOolfP4fPZIacI3uVbvsIEVPPPTjb9qrL/iKGx7dw7HKlq?=
 =?us-ascii?Q?/0TLPYJKOePwDv5i93Z2cXX3U7TZBNtdkvOXEvCx2PI3uy4vaIjX/rK8i19W?=
 =?us-ascii?Q?bx+wpxh5oHQ0UWMFv2mBMEdqkY8kxE/oXmDX9VLIQ+a9ORYx3LaVSYDGQv74?=
 =?us-ascii?Q?13l/Bk5B2wG3z7ogb0cK+x0BC9OKzmIwQqrkPSxiq5eWxFLXG/jPDtsR0LE4?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vodi9HER84tDKl1E/InWdX7i6gfl2bqed41crmq5vbGwRMvXiUgSMCYrXNPWGri76VjYgkU/CNASmOmBiKmKFHKsHuo0m5GeuC/ZGxkyjm4zGgVbXhxH18oFzV2d4Yvjvx61cmf1pftazNFsjuf5ev17FJy0KN+xkcyRmmf91MEc3j2lSzAJMDk/JYCSGg6GazK9pMBeL5V9xazKjC4euYENg+rp7+FOhettCX/AY32fP3tsUzhiqBYy4ZFDCZ0gQfJgFlLXDU3mv1NrMc/C8KXP0r66t4aHb3mrvJQrYhpZllcWcQgIqgEMlkV24IpToAu3Oi5eUWhArXQEX9/ZfpR5r3tNF3CbG7kQpETqfXlffH8m5clrYwxnjlr8zzuJn+whzEgw1kBJSBalbnSOC/4CvcAa5rYr8w3cXaUnaYbqkSYfFDoDFlazSSqPh6q7ICoAZ1aVuov/qkxbRjBuQoitpVpKMRC12dqWdY3O2ju7pi+ZkGu/TNsHhWRiAUg7T8eDW8epFOOXPeN5C1UwAgusV5iI1OHixwmPS1Gq68BS7t8sfZWfxesZPP/ZNU3HrEjfreqkoFld8GRvKltv0abj2ZyM/hzjgwJEoPzawBoi6AcN3XjxaE833bpUudls5cNB8ws9HjiGtxlSJRNVHexljkS81RZRhcCn9DUk4fk7mdPKDRTu6a4LMJ0R5C8cfQHZNMrPuyrDrxomsJEo/GU8XmMQz2i62h7Udeg1xdeNQ950KO8a0XSOnqrOrSN2nKmGw7FRmXqntxA7QaaTcQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b8b632-be04-4343-2a43-08dbc001856c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:01:37.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW8GHj5G7dQwt4f7mJ1xkEwAte9CwWrM8ADhMaQRzSkE+8lELXf1p+I08xSTX6+DXwsoWpwVLzql/dALPo2UwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280077
X-Proofpoint-GUID: YWj28Mz3FxEqDvHtAipUhHO2KC7rNruA
X-Proofpoint-ORIG-GUID: YWj28Mz3FxEqDvHtAipUhHO2KC7rNruA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently, in the kernel commit 0d9436739af2 ("btrfs: scan but don't
register device on single device filesystem"), we adopted an approach
where we scan the device to validate it. However, we do not register
it in the kernel memory since it is not required to be remembered.

However, the seed device should continue to be registered because
otherwise, the mount operation for the sprout device will fail.

This patch ensures that we honor the mount requirements and do not break
anything while making changes in this part of the code.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/298     | 53 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/298.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/btrfs/298
 create mode 100644 tests/btrfs/298.out

diff --git a/tests/btrfs/298 b/tests/btrfs/298
new file mode 100755
index 000000000000..1d10d27c1354
--- /dev/null
+++ b/tests/btrfs/298
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Oracle.  All Rights Reserved.
+#
+# FS QA Test 298
+#
+#   Check if the device scan registers for a single-device seed and drops
+#  it from the kernel if it is eventually marked as non-seed.
+#
+. ./common/preamble
+_begin_fstest auto quick seed
+
+_supported_fs btrfs
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 1
+_spare_dev_get
+
+$WIPEFS_PROG -a $SCRATCH_DEV
+$WIPEFS_PROG -a $SPARE_DEV
+
+echo "#setup seed sprout device" >> $seqres.full
+_scratch_mkfs "-b 300M" >> $seqres.full 2>&1
+$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
+_scratch_mount >> $seqres.full 2>&1
+$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT
+_scratch_unmount
+$BTRFS_UTIL_PROG device scan --forget
+
+echo "#Scan seed device and check using mount" >> $seqres.full
+$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
+_mount $SPARE_DEV $SCRATCH_MNT
+umount $SCRATCH_MNT
+
+echo "#check again, ensures seed device still in kernel" >> $seqres.full
+_mount $SPARE_DEV $SCRATCH_MNT
+umount $SCRATCH_MNT
+
+echo "#Now scan of non-seed device makes kernel forget" >> $seqres.full
+$BTRFS_TUNE_PROG -f -S 0 $SCRATCH_DEV >> $seqres.full 2>&1
+$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
+
+echo "#Sprout mount must fail for missing seed device" >> $seqres.full
+_mount $SPARE_DEV $SCRATCH_MNT > /dev/null 2>&1
+[[ $? == 32 ]] || _fail "mount failed to fail"
+
+_spare_dev_put
+_scratch_dev_pool_put
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/btrfs/298.out b/tests/btrfs/298.out
new file mode 100644
index 000000000000..634342678f11
--- /dev/null
+++ b/tests/btrfs/298.out
@@ -0,0 +1,2 @@
+QA output created by 298
+Silence is golden
-- 
2.39.3

