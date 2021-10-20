Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5804345C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJTHT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 03:19:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10318 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhJTHTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 03:19:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K77Jlc018592;
        Wed, 20 Oct 2021 07:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=piOrrsspxOP2JId29Lq6xVrQopZe/DSk1F/PMEjxZN0=;
 b=buoXsC7Ysn3MTF4X0ffmNx2v0/U9QbPCxibLPM74n+hF8vI37yT+aDlDF7iyPf8Ar1cn
 JHEy2zSa6AcX69L5UYU0jXxxnlgYoKFK5sMOYad45MpkEYAM3ufDY3FbuTDQA7DpU/DI
 hUlAvhl0cj2JePLr74Y6LJcZPQIE8OQcpmXWrwuKP38YNoSS/hRvm+hTtbFzt+YBfHB6
 eQLtEgqCJE/0r+e3qULOUHAaZVw69QohDNcITjD9OA/UIaRoUbnyzX/DUfGUK4yiHNn3
 7wKErEQBBFXE5eA1ByDW383hVTSuUAv8klFSB4h4pkE0oJG74HfaYvtL96wucpAE2ASH Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsruc78m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K7BYVh022770;
        Wed, 20 Oct 2021 07:17:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 3br8gtpe7k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P77XoCnUaAWlzkDF6BTFIWqw0S8cWzQ2whgIo7E2o2H6M+UZTFPmR1aXX+vbP4VRW+HF4cd94w1cIGNZAGpmc3FqoRIKem1WcNVbEEdJBUeW3hhy1If0Jr2VIND1DYla093PMcp9kElSxc5g9TOTYVsrmEZ1DwlhVeue74xBKuJ1mBFaU5pHSLOW0Q1z1DVEosSCNimyUM5/ciPp6+RizADUm2S8stPQLfGJ49mn2Sp6dpwsrPHbZjD9DVUkSIiE7hdHRbQsghcxk70BQVKGB0jc4zLrXAWS5S9WeArFEDoqRoTI0Ayl6Y2Z1a4hRAoA5Ys0YafiO/8g9nDLI1Nowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piOrrsspxOP2JId29Lq6xVrQopZe/DSk1F/PMEjxZN0=;
 b=aQuF56uqDhZxbz/JKLulT5dBRSeyUosfOTidQv0Bw2c2ZUQme4dziDBdvEVisU4deLdjKHtVCNVR5DpnLmPYoa5cO7IrjO0uTSPKi0LrMBdRaH2+WrKJlVf52xw3pNJcFA5vSGn4j3fvE8z9hMdcVIft/k+BuHxys3NCEENM0SwDFO1oy3UEShwmdsnbM5Gbq82BmBtWHxt9RBNjJ8em35d0Sp+ticfyt4v+77WTGqCspWFenNlnmb/SVW/1ouome4oR3SQlao5Z1EHyLnUuWYDyceAylvG7f6flSrWAa4NyY6YBmEo3ec8MSWwhDj+wFyx2+3CkFp5qLF/7BqFWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piOrrsspxOP2JId29Lq6xVrQopZe/DSk1F/PMEjxZN0=;
 b=jQ1tUqAMZpctZFh6svaiTd+JF69Tn99qdE+6UtcNOrtIVDctHjPUHmlVWP1nWFOyJNDyacOgkFSIv/g8uNWTaH62VgiueOYs8vdQVdqz7v7eEuPDiEEDZlk/l+2AKjHcm5URWS+0dOcWSWlTqKsstG1cqzo0WXKPvrqebhRTw4k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 07:17:06 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:17:06 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH 3/3] btrfs/249: test btrfs filesystem usage command on missing seed device
Date:   Wed, 20 Oct 2021 15:16:44 +0800
Message-Id: <599618f8698efc64ef8e25e0cf1d97541927d8ac.1634713680.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634713680.git.anand.jain@oracle.com>
References: <cover.1634713680.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0044.apcprd01.prod.exchangelabs.com (2603:1096:4:193::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 07:17:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa7be69c-5feb-43b5-14f1-08d993999f17
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB409453EA63ACFA4E4C9AE611E5BE9@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ngrb1dCQvxsM017aqJG+ueDVQYKnFKte/AyXfFI/Ve5shYuenR9JIohh/xGbElX6VduQRavJnrBKLATWuHgX2rXnDF6CR9QOspehz2P6POaBCZUIOYHH3/J4j7qV5c61JCKRG2Gvw1TH+sHw5aoVWGLLDiBmKyh4T10AcJB+775SlAgZYuPLE2sKBbLtDj3VGuFsE/SLdxP4yhwtf/46XjUcNx0l7/8I4ezlOXKHeC7sSsfH08mhJQcLFwOU9rQUmur0ueFruwySLOHIhdCBLrYDU9Tdqat0InYdtBztSE3J5jCNMtpSe6KG7J3khpDkXDJF/iWfse0Bt5uGMvV1QUx6pT064qgn6N2Nfg8Kbf9ws30O8QmuGA+Uo04HVnob4Z8ccRpqlNAYUMplSuL9re/4ML9u0O+mEVfRvneCOLbvBlyAlMv1t0UKN8Co70E5HpdMU2KZb0qUZmwqFK/jeAuvlISzMAKLa+E6SIyYxT4nS/2gg+Xy4lJMV/nhOb59pihgGBwEIHQLoe1Hw0fTpyoWr3223VgqlERBnWtTAPlulWCBROd53KonvfDabBNVdmNGywTqhs2DHdtpbcb4b8KrAewDGMVr0Cox9k9rmJ+lltnq4V9lNRz2ugU9XV9QsTZId6SdRLfzQQ2V+dDrp0nTkCBvw5XOUZDlvUyixJleLSubBxyN6A4jEAuRs5dnfmth4eZvgVkEEpF+x0dVAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6916009)(66476007)(86362001)(508600001)(38350700002)(26005)(83380400001)(6666004)(66556008)(2616005)(8936002)(44832011)(4326008)(36756003)(6512007)(38100700002)(5660300002)(956004)(6486002)(2906002)(316002)(52116002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8NHVdsn+MFhE+sWmPgmsF2Ycl5iJAOOHKKuablVAN4mT1VPxL1TdUMlDnY1?=
 =?us-ascii?Q?6GP1dULeNynd9B7W4ONydE0VZtP5gDws4lcjlcUKcikUFyYnVQKHs88M03nz?=
 =?us-ascii?Q?rQ6Od5lXRXZZ7xEnKXliWCIC4KgkjhBZPDggUCr3uGFWXF2QabUloG1UeG2o?=
 =?us-ascii?Q?73TW99Wu8sGpLDnCFb2QWFmeRFIUIaufdplcEaLMBoWwA6o9liooA7iu4jkO?=
 =?us-ascii?Q?gQe3Msh2KM50njyzcVQv7jM2zvIQ5Vp0dNTCQWGSLDocy4hSel6vwP9IglGl?=
 =?us-ascii?Q?S39ZcUhOmh5ce5URb66uzKzSvvM/3BYtf7dJVo4bmjpHEi8YHbkdLTAU8KSj?=
 =?us-ascii?Q?3pAp6q53pbCT/+F+NKv1AlSpEkYfo9pcfbPdmtw7d2FdatYMkkm8wZL0N6Mt?=
 =?us-ascii?Q?qPqHRnEQN8ma4CS8K1hXryubGXo0jjUF0AlRly5GrPPSjFA8YGlv2vSNRLys?=
 =?us-ascii?Q?cXrylagsRimw12urF9FDGI8IeNuZiKZ/sr5XeBlf6xLrmRjatID73nMLCPid?=
 =?us-ascii?Q?e6U34eNDMpkCPDfAqWYVwwxU5zqHY4K/0jnykNDyWkukfkf70zmgucd+S8o8?=
 =?us-ascii?Q?aY50dGyikSH2JBtM3ZEVDG1c/sMlnjsqnaybKjkv5ZtB0S3JypyBQvuYo1U2?=
 =?us-ascii?Q?uwkbIOCmykt/dJy2pVLBekjR1SrDCYJ+pHlPSBixQ+8cgN6RdGPFrVoDLOYz?=
 =?us-ascii?Q?X5OBGjg9LKYUYfVkiY1sdXZ63u6WIiK9ks/ZxJ4juhyRDqLNFCdcsBfIQKDA?=
 =?us-ascii?Q?ci79ESnxW95xSQ04TsempA67p0nWMwRdZyFcMVJ0xeUSgckDRkRoBdvnawmE?=
 =?us-ascii?Q?TCTCOy+9mzzTeroJ/6l/gqxLGyF7yfoI6IEdHxN+EUuGiaeil3iTyi9GNl/Z?=
 =?us-ascii?Q?o7Kp+OFJ96nk3dnQ/4eaSg5qq0s+2MFAFtDA4k+ukgaFJ0S86c3wmURVUGdQ?=
 =?us-ascii?Q?+UIop0NBf2705M8J2sd7cpCy7Kw5jw4pXYbWZqwRUEjTayKOSt2CqAfom87o?=
 =?us-ascii?Q?x3+1fryLJd80wBxWWZzycFHfQuqhcmmsLRq9acyzGtfL7rEc4kenntsiVrj7?=
 =?us-ascii?Q?9tnLqZGq7nneN+Pn9ZEYpATb4t5WnkVNjLTpyyA+cdUos1cMSUyyFoF9KrrQ?=
 =?us-ascii?Q?xJoeuQGvMExbhhFEZMxz6hs4yNF4xWlFgiQBkpNKdEEd12LWGFTvV6q0DnbT?=
 =?us-ascii?Q?kraF3BQfdahRGE7skryWQjVwACwcI4ivfHTPOfou666e9yPUXUR7/6MRA5w8?=
 =?us-ascii?Q?qrOzDpf1f2turc0F0MXJOILHen61jLM98k7z2NzfAtIYJuUArRAvAjCHl3CN?=
 =?us-ascii?Q?DOqMvXe1Fwp+HufiMiSlLoyN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7be69c-5feb-43b5-14f1-08d993999f17
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:17:05.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200039
X-Proofpoint-ORIG-GUID: -ySGzVK1Ykz8JKs17vvrPhx5Zub4DxT1
X-Proofpoint-GUID: -ySGzVK1Ykz8JKs17vvrPhx5Zub4DxT1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there is a missing seed device in a sprout, the btrfs filesystem usage
command fails, which is fixed by the following patches:

  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
  btrfs-progs: read fsid from the sysfs in device_is_seed

Test if it works now after these patches in the kernel and in the
btrfs-progs respectively.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/249     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/249.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/btrfs/249
 create mode 100644 tests/btrfs/249.out

diff --git a/tests/btrfs/249 b/tests/btrfs/249
new file mode 100755
index 000000000000..f8f2f07052c6
--- /dev/null
+++ b/tests/btrfs/249
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Anand Jain.  All Rights Reserved.
+# Copyright (c) 2021 Oracle.  All Rights Reserved.
+#
+# FS QA Test 249
+#
+# Validate if the command 'btrfs filesystem usage' works with missing seed
+# device
+# Steps:
+#  Create a degraded raid1 seed device
+#  Create a sprout filesystem (an rw device on top of a seed device)
+#  Dump 'btrfs filesystem usage', check it didn't fail
+#
+# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
+#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
+#   btrfs-progs: read fsid from the sysfs in device_is_seed
+
+. ./common/preamble
+_begin_fstest auto quick seed volume
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch_dev_pool 3
+_require_command "$WIPEFS_PROG" wipefs
+_require_btrfs_forget_or_module_loadable
+
+_scratch_dev_pool_get 2
+# use the scratch devices as seed devices
+seed_dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
+seed_dev2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $2 }')
+
+# use the spare device as a sprout device
+_spare_dev_get
+sprout_dev=$SPARE_DEV
+
+# create raid1 seed filesystem
+_scratch_pool_mkfs "-draid1 -mraid1" >> $seqres.full 2>&1
+$BTRFS_TUNE_PROG -S 1 $seed_dev1
+$WIPEFS_PROG -a $seed_dev1 >> $seqres.full 2>&1
+_btrfs_forget_or_module_reload
+_mount -o degraded $seed_dev2 $SCRATCH_MNT >> $seqres.full 2>&1
+
+# create a sprout device
+$BTRFS_UTIL_PROG device add -f $SPARE_DEV $SCRATCH_MNT >> $seqres.full 2>&1
+
+# dump filesystem usage if it fails error goes to the bad.out file
+$BTRFS_UTIL_PROG filesystem usage $SCRATCH_MNT >> $seqres.full
+# also check for the error code
+ret=$?
+if [ $ret != 0 ]; then
+	_fail "FAILED: btrfs filesystem usage, ret $ret"
+fi
+
+_scratch_unmount
+_spare_dev_put
+_scratch_dev_pool_put
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/249.out b/tests/btrfs/249.out
new file mode 100644
index 000000000000..b79a5dca8820
--- /dev/null
+++ b/tests/btrfs/249.out
@@ -0,0 +1,2 @@
+QA output created by 249
+Silence is golden
-- 
2.27.0

