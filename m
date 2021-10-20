Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433974345C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJTHTY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 03:19:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55064 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhJTHTX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 03:19:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5FCB6009325;
        Wed, 20 Oct 2021 07:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=M6EDMQ8h0sR70k453Fa51U3VtpfY+qmLPJ8kfb/ycV4=;
 b=Sg7EJWYqjlevUbyKC9uTDkIMA674BTkU5sf5AxUYhSE7H/QG9LlBqGB8LSw4mwrrfOs9
 hL9AdTrLcqGUnrWgA8oqhNY5DdjZLwjqvANv+07dQdS+JNyS70imFu/SSziK0R1V2hbe
 grNFLqSktPSRJIUmcJLtQccKwVtb9WNsHiY2jiKSSAAbBKwFcnpSkfr9LFRsK4mZuu2v
 8zhnJHqf3iwwqRMm9V0BRt8/EWSDlg0QHn6ZjPKAGrBLJjeJgUs8nynBCnqJb35B4BJR
 RFQAASD8i8LIwuz2p3TZjdTQ9KDYadRjQP11LYrHkr0iwpwVO6H9Ky5Ma/bNgKsbdhMw Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsr4576y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K7BYVe022770;
        Wed, 20 Oct 2021 07:17:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 3br8gtpe7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYXJm+/QZk5CkyeB1LnHEa9CpkRWdwmQSas5P3OPW4j0sr/TEnyBbec2mC2ByxrelaEeeoOTjqXPchreQT136RQSpDcIH0xAudi7w7kEV/wP9MSICjEC1e2emdRVT2URXakPS4S+ox4bX4qERyKEAMW5aOXoUiA3ykvvdxOjc98vMv1nBnNP1m4dwV681drRB2bjUwtuL++L9NpBJZmi0+FJ5Vnp6mw3brrBdH2RhyQ611Iyx1TvTr06FLKgCFL8DlUue/BNm9ttPuM4zoqIVKrjrfHnChkgF9VTJiHCJvmVPVRDCwXtg9DNaQBHPmB0UujXcWwaky+zm6b0Rby43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6EDMQ8h0sR70k453Fa51U3VtpfY+qmLPJ8kfb/ycV4=;
 b=ZQ500FjxllMebM+QcBhN7UXN9I3YU87IvknjY/cbyvmEzkD9GD7eH0zM/lQAolEaxpXoQtsOxjI8pTdydcns7EsU8yKolfoSCP0AXhRhwew0IIAYt3Wf9KVtzHrlBk0NT4R+dE4Cuy4u1mYNFMcR855VaM5XvtvDt2fnb9Ljf8mhXgeoKgOzEvyB5Qqq97Iu2Gz8M99nwNlGecCDfzN9CGY8Z3XVL9ceprnF4kCX5XiMn4mp2khiYovBP1kqaf+gp/1hr3JmTuw6xfJYTQ0XUzr78GM6FKjHJkGy43gSJBFGj7Q/zjMho/219Q5wkaV0m/nYwvnCJldPo/OP1SBSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6EDMQ8h0sR70k453Fa51U3VtpfY+qmLPJ8kfb/ycV4=;
 b=BT5Re0/+gH3ymvxycT0Kn7CHBFD5JG0eHXMguVnE/3aQmPvn+QLUdeGnceDzDNHW+SO1GJpLV5uLViE3+uChlzhCkg6FoCXK6jjh49Q1XX0HtNpQ9Ddr9IORXDRUlFAcmfxISWOMfpPggmEj6Wo7nEXvmF2NbFFPzH21hsZwf2E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 07:17:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:17:04 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH 2/3] btrfs/248: validate sysfs fsid
Date:   Wed, 20 Oct 2021 15:16:43 +0800
Message-Id: <ccfe946dd2177f25fe912a4679815d1e192a0de5.1634713680.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634713680.git.anand.jain@oracle.com>
References: <cover.1634713680.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0044.apcprd01.prod.exchangelabs.com (2603:1096:4:193::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 07:17:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 687a4a20-ec47-4a01-763f-08d993999e18
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40942DE5632EAF1D0023453CE5BE9@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWBW7fu8L0Upy1uJyQ0ScPQz0uNB94J0Xt5ApC4XCMMn40Xy0+VCMSo2FzcZEfB/QkEvSojxsxafMaXlv+AaMQYPuRuvD4LnFelQlWomR4RGAicTU3Dw6p0gRKsICab21Sb+aWaCvJWmCQ0wzY9A2LjkwzNNwcHrrSBGZthhoGuAbLzRrlAwAzNPVVxuvhJHl/bAwHIiTqYHGIW7nC7z2q+sHHaKhTgigElxe91hIwY3DgSUkwNTWU0KSTBTyI5CBykGTwzm6G18aHbakp+ZtBD5VbcIls4YcWS2DWj0iqvU7RSD49a/0tWpgMzqdnguTuBtMcrArKjD3tHNL3opcTtG3ZEbgsHwPNe5e4P4vrIsPIgSVRn3jJZ5KyN1yZns9dIx4fKOQzMLZ2LrND9AD8+DqFw+l6a//Ku0hFbGnuD5upugz3yOA8btgQmq1THTRAR3lXK+4VJD+rl/xH42bGZCE2zHiQPHA8n028B7IBZ1BL1HQYa6tiXDuVGFmVXzBoeq2MYygivM9x4mBTvzP7zCKCi7ZBPqjkPyKJps5wubOzutYjH3Hbh+Ee0qMSpR2ao4Nz14aIZB7tgz7/7+rjXf1UoktaOgMPIbD4UiLcK1Oma8XV1jpok0i++hOrqhtGQIk+IXmaImdzQD4cl7H+DVYcB/I+EqmV6ZXEYbtlxtFZaaq3JZFijA0zFuSgsW7/OZKQFPN6qaO/ZcMKt/zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6916009)(66476007)(86362001)(508600001)(38350700002)(26005)(83380400001)(6666004)(66556008)(2616005)(8936002)(15650500001)(44832011)(4326008)(36756003)(6512007)(38100700002)(5660300002)(956004)(6486002)(2906002)(316002)(52116002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrVr+xV3RzDEBnWmhwgoUGxLXhREV+RvYJ/vXtSrEdLbMFvkPcE7WxsF/UES?=
 =?us-ascii?Q?URY5xYbsmQAqbaGqxFcV+Un6y60KS3aVERY5nNpHg+69+sqt+hqpAZSzNv4C?=
 =?us-ascii?Q?IlCSz9nH3aXHSnin/ms84G6TWj7rdIXZYUSyc8oLeJqVFA31w2xfOpYiKuL0?=
 =?us-ascii?Q?6iSQWj4mBoz/gH+oIDhhRN8z94VhMp0ndvlbxGKxsLfnYVZNmykgzwDVYxct?=
 =?us-ascii?Q?KEKJRvjRulHoyqfKAJsdisiFnF2PTgZ5YHG/J6wsuKeux9s+6UQNduU80/3s?=
 =?us-ascii?Q?wuPPfYE5x4FxNvkN6moHP1p9Hyoje1GeEccfnGXRZ8K/1Ic7Kh90/spOm0N0?=
 =?us-ascii?Q?K8JBtc6Zh1wkyy/SEsTHA9QKwSIJ4VS8oxhKpkAZTHcw1zrfF4qBrx5ZWUQQ?=
 =?us-ascii?Q?GpGpLNqGLyTJYQaDDyGujXmoJhk8InE+cmNPmUaosa9VBsCUofKxfNvaIVLB?=
 =?us-ascii?Q?b5tuv4PTpDaEMxUPGF6LEjw7iKoRDQnDPp7+Bn5w+UfWEO5c8Y4U/gci7jXh?=
 =?us-ascii?Q?sniUMLWK7wm9QVmuqGOmu8NVLmFLZE456dLW8aq04h0qBoPhGwi8v9srur99?=
 =?us-ascii?Q?13NQZ2JXuevSxpLzKozTOb/iIlV+MuMywqAvI1LON9tg/1uw0XkUQbCLlkzi?=
 =?us-ascii?Q?9mppUAHOhUuO5iM9dRVFT9Ikj0p0TL4l8Dwu4PfgfFoFE39VJdyqwKVfVPeT?=
 =?us-ascii?Q?OAB//Jowyg/TknIubo+/lkvL/6+C2TWPdXGtgGjfxwJD/vrVvnRBZyZsrD+C?=
 =?us-ascii?Q?Q+dC6H9+N4RwZuDutfRDtwyHnys+j73vSDnlRQlqoeWxYgEBMLY600YT05tM?=
 =?us-ascii?Q?CZVKDcI6bSkxqCJBQHvX5RNbFMFvmpXJagMIgAIzxgFTiPkDJPR9JylWJvL3?=
 =?us-ascii?Q?imaU/o6lwsO/8rG1whtcM+lsHoYTKvBoCaa9gyT8gMH/mbSalIjWqWd5yG8w?=
 =?us-ascii?Q?zVwrqSIMLipfFNflTZh7uRwBYgcFXhJ05YBtoCD+lVY+1A1L7lW8c01EyT4N?=
 =?us-ascii?Q?l71ah7OUWAH8w3sKFhFNEobc+a4mtPKNqOZjC1DdUSUjFrNxcVRkAWwnTKuo?=
 =?us-ascii?Q?eq6Mt3rooSGuwWGkfuNWP0cVBkk10rJi7UGZgNqX+5B+LyT/UEn5U9/1IvD1?=
 =?us-ascii?Q?3RTxj3+qafpdbzUyFiGu3oy9GymgwdLgaTJu1C+zgAwZnOOP4JqPZWGXHTf3?=
 =?us-ascii?Q?Ll+2T1++qRw7g6ASTbE98t1YiRkalUSVroXGDN/dcxB4KpJYEyuAlBVr5KlB?=
 =?us-ascii?Q?ohw2T2xn8+cDx8Nfklc6wX8jzK7cZDbbBcyREKN/qYhr9oc6IgMVI/lpVYh0?=
 =?us-ascii?Q?v+DEywUM6OkL5QDSk+qm3oFI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687a4a20-ec47-4a01-763f-08d993999e18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:17:04.3190
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
X-Proofpoint-ORIG-GUID: VK8msfZJ7-ilh4CEN8mcujN48logXOwe
X-Proofpoint-GUID: VK8msfZJ7-ilh4CEN8mcujN48logXOwe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Validate if the sysfs fsid is the same as fsid as obtained from the
superblock.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
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
2.27.0

