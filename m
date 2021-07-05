Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C413BBB6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 12:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGEKqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 06:46:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11518 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhGEKqa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 06:46:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165AZMV5021856;
        Mon, 5 Jul 2021 10:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=ro2AgNWGGRRCz3fqNezm+NVfTMrevqM/MwZlKkPlYdc=;
 b=Gj55X6tsWRgUsGVSb0ALA+8xjthQH5NOxh1RyG5p1pMTrqFXOv0KdeEG5X8Yu1BZ0IBm
 4zAye6eG/vv36ZJz2bGUKXAlxQ0UCUbwux2JhWjCzotUQqPosvHLEd4kpFHKht3ipjfk
 24OJKPV+CmrkIQ0O1frKUTtdggEv31l/h26TjssDLzJ3dTVD6k3+uYLtB9a9bOM4sqdb
 lDe1i8X51sptoWoVyfkYX/NUaW/xwxIdB8RQDcDqr4i4oe6Zz3hpQ2K3CTEH5WcnZrXW
 EpxOywbj1xzY9qfop1aaMPz96d4ugL6I9XEVe49+DCbI5MNVRGPZTyLs2daax0kw8yWC Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8e8ty7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:43:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165AaQ4h040995;
        Mon, 5 Jul 2021 10:43:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 39jdxf62rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkb7eyHtToxexcaQHiKrrQrQzLZCnuv+lmXJmC0iBmiKfibNu1C53/p+zfYhkCt1OOe3ZNmLlR8r9s2G8L7OSqpZWGQv7uW2BdDpZhTyDUfNcC+67TZcDoG37rNUlYnCzFsT6W2IfjiwsxFMepDuTpgjkY1v1rvcjKQl/FAt5wsIo88sHfZrMQnlcWqVsS2B8d9u4wIBk1HiaBHsFTYCI9ZxpCH6yPndXjc6i1AgJx3XO/0KcWD3hYLoyTBrVm22zrjHYza4w29UgZ4JR1+RRPCQcduEEACChJI5uh7NurT1vPMiMT6n+JgvvG7Prvsu8zo11S6UaOPmktw94NOl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro2AgNWGGRRCz3fqNezm+NVfTMrevqM/MwZlKkPlYdc=;
 b=QmY0dXQtyOecutx5HVvARl1JBrbwkBbpU0IH8C7ywegzObyvDuCn/hV61eNgvOIgQbJ7DaJG54KsEGthIE42xYAW3U9LnlU3D6TISgWfg/WlnWI9F6ZXhPaWNOtnnkFCPE18JMG8K5SUjnXkC+W9GxyFxPGyf7NkPKVFxnHq9K8Cl3YdjKdYCdO/GtM+081NBhnC6YL8W/96qmFsNMtZD8OcgGMKqezu3cPCvzkZaVDrhC8XXfLMeyho/rqC/lOD6rRNEIgCFjOWSuByfzVoHZ/tjAAKHgxsqqpSgunzoreG6wU4Tv6ZXrCCsZOQNgqOdxgGRlg8KV4H75QW7JpMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro2AgNWGGRRCz3fqNezm+NVfTMrevqM/MwZlKkPlYdc=;
 b=a6mNK/nDLqJgwf4dAbR75kR2QD5HJrFr2OOL0KWWXfB3VVMhE0qowpOgjK7w6no1PeJOfmjTEWcZ069DKgGhn2dVbZ7k4UfBOmZsqaD8WtZDfBArWYPpm0y5xSUwpqCs08JcYpOFxXRUpDPn1mV221Q9UQY6bSRMrxPttGNgXgc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2914.namprd10.prod.outlook.com (2603:10b6:208:79::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Mon, 5 Jul
 2021 10:43:47 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:43:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com,
        fdmanana@gmail.com
Subject: [PATCH v3] btrfs/242: test case to fstrim on a degraded filesystem
Date:   Mon,  5 Jul 2021 18:43:31 +0800
Message-Id: <cae6a7e7836949a0407cf6859d7f9102636bab8f.1625481473.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0024.apcprd02.prod.outlook.com (2603:1096:3:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 10:43:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fa6f5cd-d621-4dcf-4260-08d93fa1c4b0
X-MS-TrafficTypeDiagnostic: BL0PR10MB2914:
X-Microsoft-Antispam-PRVS: <BL0PR10MB291443F26D8451FD5C251389E51C9@BL0PR10MB2914.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLu6ZBuE7Y7JR7wZbeV8QZYqoF83DlpeSx6uv5sRiKX1sAh44uBihwS2n9MpSFK4Dc8k3/pWtWzZaeQTVMIS3ycsDi1AygZ70I3osnq7citUxzOaYuu2uch5f/W6Hz8SfgLXVQ74G8kGZdhclWIcUm16NIBjd3c4doG7tYzIFSZPpjYu8x6f5vMIqvwt5GK9dvU5V2LqeL8ij9Td1GM6SvExtPB11rXlWdUunnimoazSRQ9iqVhyMxNc8iXeeRXjvXMDfdAFgxS1ASIfPoPGtEuldRGP+5xwuxFgW9Uk/NdRPrSi6TwihRZ0zI8HHRPQ8kageCG0TqB4EQY89dytGmeyJtcaJoLXyiAk2eNjbNnNEJKK+USytfWjq7j2D159VV1tdA6g1Dwmu+QcHEhTT8ndRykXOLhwSHT52r7favYiCqlmdRcJKmks6X5vEXwdz+O8TYIXXJUje6g+eKQNian7jcOdDgzv+MDill11DWKhaqyyMp7hjAVsZeo27OhEMu+i8njSpZ6FKP1n4BQTs37kBcsYmF32lON0tDtWePxnAYy7yIidlKCKNnxmydgoaK/nLYy32r+Xa9WZab3JTM99Pa1x/Py3wT5A0MKcuIuiZVOiksRzADeONtYYQgDvfWLYRgZq/HwaZWSJA/jr/JoQ6rkSTWN8ittffgwmkdq6ejPK6ORNKFl7DfMf8VysJWDSA1cshsdVHTdIrCe1yfVCr8lVSNOEXpjg/SJijkY4BG9FhfWCfOjvnzViUjyLENswQw6pwOLWrI+2uoOMNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(376002)(136003)(6506007)(8676002)(6916009)(86362001)(38350700002)(38100700002)(5660300002)(83380400001)(66556008)(66946007)(52116002)(66476007)(4326008)(8936002)(478600001)(6512007)(16526019)(44832011)(6666004)(6486002)(2906002)(36756003)(956004)(26005)(186003)(2616005)(316002)(69590400013)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TbfLyOv2cSTkMJrO01yQnPUF43v+rFMh1zmiP08lzCmSAEAHfn5NTR2MyM+l?=
 =?us-ascii?Q?arVu2Q0W1kyZRRuJ7VqxUWYe1utZ1Q2BX60z3AdUwOcYGBTcGEhhhLvf7oqY?=
 =?us-ascii?Q?Bq0lGUVKJ8GPxRmVvqQiJvYp4JQA8tEh7E6EcGBa8pmlVqX39Md3BxbUXdEf?=
 =?us-ascii?Q?guFb7zZsC2LFi7/XdpKa1AmMY+QHZpEElMChCHnNWO/7pxo6A0xsqx7qpBFX?=
 =?us-ascii?Q?I/V/v4oeCcvhG5AUYh7nvwBAG2+sTHrJdnxmYiRKUhJpSv9VPQw5xC3qWLPr?=
 =?us-ascii?Q?5GOs8OnGLAmjHHKCc0fwUoIUMRbqfp7/BNn8gFvNIP4muAVMwdSKhwJ3fGYc?=
 =?us-ascii?Q?6wBBA/d3PMPAHuD+WHCw1oGAmT1cb+KmY+xDo4XdIVILnxvmZUD1uy5R7abM?=
 =?us-ascii?Q?6R7r9l4xTIBRc431KfBndqbuV+L9XC8fvRuL6WP3oa0HjRsNYPF3xgbloJ3v?=
 =?us-ascii?Q?d/j5tUAAuQAit2v2+m5UqB80yAmJ1B8YL5BFTGoerDOWtUBpMDlUhy2V8uVj?=
 =?us-ascii?Q?hV9+QF1vzC77D1ngWL1FXMv1YG9bb1qw8ugHEyWeYnNgn9lNv210LWmzsuzh?=
 =?us-ascii?Q?yry2t1CM/XgzN13CGFeC5fOqlW9oww0ydVkdtbAReGOidU2g5XhLEN0cvUh5?=
 =?us-ascii?Q?7waBkKvvYEjIh2OPWTviWW99GxVz1Cin51mFexGVodzE6MpVKTO0MXQvAXiS?=
 =?us-ascii?Q?qudaWQpz3t0x65E272AYuSwuz4VFu1a5mUXIe7LSRZ0bi2vBHUxnd48XCym3?=
 =?us-ascii?Q?9sT47kc3lgH9neCJH9C2MrOp6d20StssW2vf5nLXJf4u0rQ42tyo4kVvqZ1Q?=
 =?us-ascii?Q?8FVBsUtkTacY1wBuz6AFjCE4wMbCA6oMu95UCOXk3oVVgyT86BFuLgTAGsvJ?=
 =?us-ascii?Q?sy7eB6urI8CTUuhXZlbYz448r8U68fA/1GSKQTEy7KJCQ7WHt5BFckzddJVy?=
 =?us-ascii?Q?KokPlTfVGEPNVBo0oM6vxfc66eoH79ULlPufSZgo73Yb7q0LBYgIC96RhQxQ?=
 =?us-ascii?Q?6h6pq6GtGPzInXId8n+IdO07mcrY88aeJ55DJMwwnEBjzxumhxIWhzyla/47?=
 =?us-ascii?Q?cohG+itJZcxIiAGk3KSvfPEboHGGPoce6xU/DaVtD8Os8eEduDh7Xui+cPpw?=
 =?us-ascii?Q?XltFBwtmQ9D9LOdG0uKBqDYmsRf81rEFNzjaPnnNkHbWBtN3dA8OWTqwU/7U?=
 =?us-ascii?Q?QYo3smJ3u5bcGOP191WjgaFPFpgjPlV3uruHpuHBvt/LH+61rq4VinGbZm4+?=
 =?us-ascii?Q?Q90+eDzUbXZ4e0ejO2Q0+B1iX2fCyQ7PaKyIvc+YJen9cB8c9KLGXLrbvj+X?=
 =?us-ascii?Q?YTGfleUsEUhgFEdyCgUF/sXZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa6f5cd-d621-4dcf-4260-08d93fa1c4b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:43:47.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mb4kSerp6qHUn5MVaZ8ldiSbvSVEIJEzCNleNsf03FCMw1wL1yKhIl8+ZO9nu8qhj6gX5VxST0PffQWRvNncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2914
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050056
X-Proofpoint-GUID: Dr_otMs9BqwHdnlRaCsenpnDYfehRyGc
X-Proofpoint-ORIG-GUID: Dr_otMs9BqwHdnlRaCsenpnDYfehRyGc
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a degraded btrfs filesystem and run fstrim on it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Remove from replace-group.
    Add to the volume-group.
    Check for the data integrity.
v2: Remove the commented #_require_command "$WIPEFS_PROG" wipefs
    which I forgot to remove earlier.
 tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/242.out |  7 +++++++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/btrfs/242
 create mode 100644 tests/btrfs/242.out

diff --git a/tests/btrfs/242 b/tests/btrfs/242
new file mode 100755
index 000000000000..da787c1ef91f
--- /dev/null
+++ b/tests/btrfs/242
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Oracle. All Rights Reserved.
+#
+# FS QA Test 242
+#
+# Test that fstrim can run on the degraded filesystem
+#   Kernel requires fix for the null pointer deref in btrfs_trim_fs()
+#     [patch] btrfs: check for missing device in btrfs_trim_fs
+
+. ./common/preamble
+_begin_fstest auto quick volume trim
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_btrfs_forget_or_module_loadable
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
+
+_scratch_pool_mkfs "-m raid1 -d raid1"
+_scratch_mount
+_require_batched_discard $SCRATCH_MNT
+
+# Add a test file with some data.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Unmount the filesystem.
+_scratch_unmount
+
+# Mount the filesystem in degraded mode 
+_btrfs_forget_or_module_reload
+_mount -o degraded $dev1 $SCRATCH_MNT
+
+# Run fstrim, it should skip on the missing device.
+$FSTRIM_PROG $SCRATCH_MNT
+
+# Verify data integrity as in the golden output.
+echo "File foo data:"
+od -A d -t x1 $SCRATCH_MNT/foo
+
+_scratch_dev_pool_put
+
+status=0
+exit
diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
new file mode 100644
index 000000000000..0f478fc93db7
--- /dev/null
+++ b/tests/btrfs/242.out
@@ -0,0 +1,7 @@
+QA output created by 242
+wrote 10485760/10485760 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File foo data:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+10485760
-- 
2.27.0

