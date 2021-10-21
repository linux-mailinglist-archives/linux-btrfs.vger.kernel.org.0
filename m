Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36849435DC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhJUJTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 05:19:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41346 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbhJUJTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 05:19:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L96cIj016734;
        Thu, 21 Oct 2021 09:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=EnBKdfXauWGEHZwUL5r0si5r3q43xzKHEH4bUFfmYvo=;
 b=OPvGEdImacSwH4AW/Q3XkBb0x25fpGjddh0KQ+IGAMbf52ObBG+YwWadSqTRQqIfqrbq
 djJclwvClB5aN7092p8JFZtDYEaRI8SwsrBznIqDdE9yzlrelEJ9US1t796HdBqW+mRM
 w8tXgA9iXJKBY6rVxKWcIdNN1nsrp8W6IwHhqbHfUMbIh13w2RcBoWZOWp4Lc84T6hHk
 ygL0b8Zv1Z/Ho4XaVy/dFG8OsfpKaRZsQeNch2ZiIsN8P+mh2JK2S21GVIkOYr6KCJYY
 Jq1NRr8PxfFj5rFMSHAOivcil/loHE1vwl4sLlF3aVDYTzsDZiYdSfM1D9Y2cCDyGzix Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj55y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L9AsZA010094;
        Thu, 21 Oct 2021 09:17:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3030.oracle.com with ESMTP id 3bqmsht9ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N11PsmqT+6grJXNcig77QtZSAM013X+JhD22YBr7R7R7ivIwEkKjS2TrNtCNgiIAX/NfyTY4SBsmjTlymkoV6W27RISI6zLNV47TIvJs+TpMKtHPUEvrL2cYrTTyxYIPG/BAX7Ti8bp/gIxLGbGMFVjeHvrL7UsBXhHc7HWRUvESjn4ZD7/7n4rzOz41L5eP/JNDe5iYVAWhnaNrwzVC9XHN4y9wM6486DcvkSOZHOZCcBDRDb1gQt8eCSD55jOKk/9MatmJ3l9a7xBgb15oS96if+ThIIrJ63Q5qkCDzwsJrvNDbUs6VSN7XbKsTveG0i9ayQWiljazBCf6DXfhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnBKdfXauWGEHZwUL5r0si5r3q43xzKHEH4bUFfmYvo=;
 b=FtAEMxwiZ9W3/gdgkL8cGQHOKHun3O8mOmpK48SStbEQtzM2bXTdWJP2yG8U0GkhaxZ5yF7ZYJz4vI67jfHA3UilwU7HlH+9l94jj5fhsq/MFN3nmxyzQhTqSGuw1Gj2yAxM5SuYWiKV61upLhSJtZflR4cMXZ4seUSkeWhNNgINAeq3POPgo4AHRSfB1XQVU8WxUiH6lJ9fTt09fHUQbA65FVtGmoshxzBex6KvjC82JHyiNNSG7BuVilXZ22MLUzfNYbVd5y4L4vYbScPAscBoK72QC6c/llKm5nCgVEv7BMCwrFP7IBa/DXDOmb569KD0uVw6nBT3ScPp26qvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnBKdfXauWGEHZwUL5r0si5r3q43xzKHEH4bUFfmYvo=;
 b=qbVhOyN7cEErOeJO9Gs2yvzBOZC18/KfxtZdxtPLMjigX6/Y2IMbGnrvDzyP3FjclgTM+odRqV/a2KJ+333L7ejiBgR0o874Ck0CUgQAbxVglAN3Ew69dG7hfLEGQI9K7KJsh/aRxF+aA7Bur2GEcTUHfs573NgDkFYfg+jH8JU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 09:17:26 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 09:17:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH v2 2/3] btrfs/248: validate sysfs fsid
Date:   Thu, 21 Oct 2021 17:17:05 +0800
Message-Id: <7098e26341837e377d1e67fc9db28fd291ad8d5c.1634807378.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634807378.git.anand.jain@oracle.com>
References: <cover.1634807378.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend Transport; Thu, 21 Oct 2021 09:17:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a26f49-b2bf-4de2-cde2-08d99473998c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4287:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42877C405534FDF4A10EA163E5BF9@MN2PR10MB4287.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGXHWAUroqenmcoaL798nnMUBltD3kF64aA28cubf9bD7pl2Zy8sk0Imxy1gcugf8gC3U41IRrlG58RDwzZFNbb68fsoJjVPZ/xlG0nDKk5UGGbEQTlrEoLQIOmb0Ua5XP4dMu8MiQF0h0MvnooI0U3aQtznxkovtsGPXcQ/JLdixiPwTgI1+ejg+OkqT1S1Q0oyV1/efd31APscV6wevkzRaaS63HVTF1r4U0jlKQ1OWp5oxP74yMR2iqgWKmJuj0JwSQ9Z6abxb5edEyqPGs7F0zgMW4b1jQC/W9eM0DbegVD0CiFf9ldJ8R8GXJOC3TyAXC4vK2RwAoz4e6e8tjNAAE/QzSLw7veFatND/EuzfTRNwOm5YCi4HUtJb9Oe1YXtGVlJYQ7mQl/z0w0LKMx6fy0BvJOne8CD0NK43e67IvNGOV0tidipvtIa+urxj/zhNiMRkTPQ7ZFHG4b9U2MnpIS6UcLhSOQdb46mgQ7sw+l9cFilDxMnzphomndbsi0XktzLVMyXoCl9OJQ/Pb8d+8TW/yqzhRvrOZM4L/cffJHr4Nfx9gvQSA6wF/4OZXGUa+bwo6EgrwTNy2uSUWGYFExw2SVBZ0KJEq9qAtZc/MOrDlOS7nIwjnWwDzMnYCTssywW+bek1wLBOFK61dQk4fbA0P2aL/C6yojixWvr7ibn6ZLv+AX1nDpuaO2CYjozQssEjDAjVfukh8+lpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(66946007)(508600001)(66476007)(38350700002)(186003)(36756003)(83380400001)(66556008)(15650500001)(5660300002)(8676002)(86362001)(6506007)(2906002)(4326008)(8936002)(6666004)(6512007)(316002)(2616005)(38100700002)(44832011)(26005)(6486002)(6916009)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3CnRTraMfRXQv3+yMRGayrhIS5Sf4+HptKxbV1QDFXT46eVityFzlrZqONh?=
 =?us-ascii?Q?kI2cwvKj6U2nlMJMabV/c556isCaFZlfrkT5HPwv5URZe/XUdxEt2m523uEs?=
 =?us-ascii?Q?CK7tCGEbvlj3w00MHu0jx3shhv7zrQuSYC5ygT/d65sDLxWs1LiAKeBnG3Du?=
 =?us-ascii?Q?YGviLggKReNxYvTKU0WCMVUHpk0qK7I/hIB0B0SXbuloyP6NDEMAzi6NeZ1q?=
 =?us-ascii?Q?sdWIHKppuhMYqy5vXqWEvcTFzKURu6gPhqSMLjHdP6sZ+rJY8QL4HJ7TTKXY?=
 =?us-ascii?Q?1CGAd41KujtAoAIlMbhODwCwULguQEKuZ8YzzD9PR0XtE/EUEX+jP7QhxAnY?=
 =?us-ascii?Q?6VotBXpNvl2a3Yyl5MKOsRORWaNg5CcLDd0Bf2cgJ5d5QJa/hXQ/TaVqFttg?=
 =?us-ascii?Q?Vl5XQstGDhsDtNSaUKpAuqpX3ITiVPmRfHMkaNfm7Rd477uMV5J6eEXTT5LE?=
 =?us-ascii?Q?4Qeum1MM7gjkznFoNb2auybBvJKPFeMZ6xrGm0doLGFogq5ls+7M1/PkT++1?=
 =?us-ascii?Q?cUulANIg45oTE1KlIrEl+WzZicx303OjdoxoKTAGxJQyjgq30uuLxp4+N2gk?=
 =?us-ascii?Q?mwupjnd1uC40ppZ48tob5dnWTV3zlA5FSBj7vMkBOeaQv8vmsLK2IZLOvGu/?=
 =?us-ascii?Q?oTRPUh3snt6jbOXDR8ubG7UTykOkhCnchIROv54WPdhVza4pPUfNO+wrZqob?=
 =?us-ascii?Q?wsbeflmo6zn1/oCXrs53vuZKHz2tdEBEdFFimuNmJmmUSbiV9b6ZpObIeehH?=
 =?us-ascii?Q?GlVZHQy59aYRUxA1RVsynF7oZRUPk7fFtxEFDTNQ/MzTAGpq2doSWEcDomiL?=
 =?us-ascii?Q?w/6KmxSUlE4ZDeAyz5PgsArU0ACqMj90SGKjUXkncV5xe9OZQaiDlDiT5o7f?=
 =?us-ascii?Q?VQcfU26bVopiCL47gT8ORyabCe5JfW4IP1pWSecb+5G9o7ShkRIWZ5MigJoN?=
 =?us-ascii?Q?QJQzOvPnSHr0Up5X6r2N9qIp+b0ClbsKf+NXVswCfFypTfOEogJy6SSKEKZ3?=
 =?us-ascii?Q?mmdyqlv3VtkAId5SnzdEgspQ48n9+lNEfxyWhHPqmKLj56le3g+11ke6KCgT?=
 =?us-ascii?Q?tTQK1w6RvWDSfRPzI3g0BV3VOR7N1xpA+fX2eL4lhjAflqaUtM+uFIRchejP?=
 =?us-ascii?Q?OObBPlJMKvWDpPp/KesEN+pMjE9yoErmJjWEPM0wxgBaEMz1nyUw1a/hImra?=
 =?us-ascii?Q?wgfLHCwp2/+i+H4c77+Xhyf2nFX9BB5vBpEmht3dHnnpsfpeJe44fzdZKJcZ?=
 =?us-ascii?Q?GIseoIMh4vJOxXn2/hygBNYU80Z/xsK8Pv+lnqqNEfBdgml65FYXRGPKmdhM?=
 =?us-ascii?Q?2g569qAQWUnLpEv7bcv8C0oqWOgPqzXia7RhrhdjSUVWRXkx5IyMscOpg83a?=
 =?us-ascii?Q?uso56Dct3+08J3AtqI0GEbYLZq0XLbdib6+wysddnzC2gEvGqV5U7bkIL57j?=
 =?us-ascii?Q?sYoCB8tEGHg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a26f49-b2bf-4de2-cde2-08d99473998c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:17:26.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210046
X-Proofpoint-ORIG-GUID: ACl7wdQNXAEul8maLQ_XXhhmION2y08X
X-Proofpoint-GUID: ACl7wdQNXAEul8maLQ_XXhhmION2y08X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Validate if the sysfs fsid is the same as fsid as obtained from the
superblock.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/248     | 66 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/248.out |  2 ++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/btrfs/248
 create mode 100644 tests/btrfs/248.out

diff --git a/tests/btrfs/248 b/tests/btrfs/248
new file mode 100755
index 000000000000..856cd489d4e4
--- /dev/null
+++ b/tests/btrfs/248
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Anand Jain.  All Rights Reserved.
+# Copyright (c) 2021 Oracle.  All Rights Reserved.
+#
+# FS QA Test 248
+#
+# Validate if the sysfs devinfo/<devid>/fsid behaves properly
+# Steps:
+#  Create a sprout filesystem (an rw device on top of a seed device)
+#  Read the seed and sprout devices fsid from the superblock
+#  Validate with the sysfs fsid
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
+_require_test
+_require_scratch_dev_pool 2
+_require_btrfs_forget_or_module_loadable
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_sysfs_fsid
+
+_scratch_dev_pool_get 1
+# use the scratch device as a seed device
+seed_dev=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
+
+# use the spare device as a sprout device
+_spare_dev_get
+
+# create seed device
+_scratch_pool_mkfs >> $seqres.full 2>&1
+$BTRFS_TUNE_PROG -S 1 $seed_dev
+_scratch_mount >> $seqres.full 2>&1
+
+# create a sprout device
+$BTRFS_UTIL_PROG device add -f $SPARE_DEV $SCRATCH_MNT >> $seqres.full 2>&1
+_scratch_unmount
+
+# record the fsid of both seed and sprout devices
+seedfsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $seed_dev |grep ^fsid |\
+	   $AWK_PROG '{print $2}')
+sproutfsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $SPARE_DEV |\
+	     grep ^fsid |$AWK_PROG '{print $2}')
+
+# validate it with the fsid as shown in the sysfs
+_mount -o device=$seed_dev $SPARE_DEV $SCRATCH_MNT
+
+cat /sys/fs/btrfs/$sproutfsid/devinfo/2/fsid | grep -v $sproutfsid
+cat /sys/fs/btrfs/$sproutfsid/devinfo/1/fsid | grep -v $seedfsid
+
+_scratch_unmount
+_spare_dev_put
+_scratch_dev_pool_put
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/248.out b/tests/btrfs/248.out
new file mode 100644
index 000000000000..58af9173bea3
--- /dev/null
+++ b/tests/btrfs/248.out
@@ -0,0 +1,2 @@
+QA output created by 248
+Silence is golden
-- 
2.31.1

