Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1010435DC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhJUJTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 05:19:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39056 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231308AbhJUJTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 05:19:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L90dSn009088;
        Thu, 21 Oct 2021 09:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=pRsBeDPQ9BwQHs8LTTrzGOMQt44PZWvIB9jwecsNB54=;
 b=om9xUuzlZmyoxzvJaIvGaZrIXfkLMzD9FlvxyY1e0gbfxU/zSb/ql/NDcPkWB3zLkHC5
 ovnCMgIhKnT0fPmm8Li69A4zXmnFrVuCofRSW14fL9aA5F9CA+8QMSTh3VxTeJ0oNDMs
 +ys+jbDpdXS5dS8pIcrD6+st9l0t+JsVa+lo/78jOSv2fouQz4xd1zHltQWQEFStAj9v
 8TQVRpTqQsePBMlHL2KulQ/toNfmyDvedk5WHEIiL8Rfx8uw0ixNlGqpviIaiquPh7ih
 xxKzHGzeOuDxmb+vicv4hvOaVgm1XL+LYuGMtEPAHzz9r8F4nTv+awsRqxTJCoKC+rIw Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btqypkxd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L9BDKo124589;
        Thu, 21 Oct 2021 09:17:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3bqpj8eube-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+ZNmjLQU2MeqlyLV1VRQECdxmUkdW4Bkh+zJwH9vkaPPoTDd0oVul9ZqP1BIr7CzKJsp4D0D7ZW21NXgqru+ZHSays596Gs1sdxmvBUz0LGVsct9kRn9U9bI1V0djM/109iniTtnINd4vDk/lgQNqvdfaZsozdbeeSA9ruYn2bxK6I6DBvVL/0Yowi5PnxR1548dxqYQHrKMb2MVSDqeiXzFmOpwcDASOHqxxiFQeeblWYyy6yv75mAV08c0HqWmTRGrvsl4CejpFgY5CPF8QlfYttF40hRBY9iiJNT4TQwFWQWGDBzzJaEYkR/kTRaqXi98hmMz7/m2oqPlWFzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRsBeDPQ9BwQHs8LTTrzGOMQt44PZWvIB9jwecsNB54=;
 b=Wobt1A8450dLGFk/limzyLlUcQkQX7vLdjZ3nbsG7OU/0orm7JLeMaJ2nNkS3YJf2y6JuI2y2szY/RoBw0mFxgd1twnJw/9SpFjYpfKmkyeFtNy0cDcjCsG2op7XO3j/qi3C1M/rSy4wcc+rpkIOw6VcIOMsaGrT/VnPcp/8mNuLaZeXkQe0evRC2/1jgLmpBLdJki7AwrDq4ULv4N0pcKoCVzc8h7ecCWJ1NFS+vImqf499p7NVU912HfA+6/l+jWl4Lo2jWiEs5MtDzcB6BvH6NNFV5PRMuuOm6uC22N6AHfiiGbtX/Qqw4pDpGPaLUQh9HN6GSzmXmcz+529HIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRsBeDPQ9BwQHs8LTTrzGOMQt44PZWvIB9jwecsNB54=;
 b=a4XjHEXPNwcPUoyw7XVsPYFwR9Xu4pI3+ILK3BsNL1oyXYG6GhJuNCes2IZq5n2ZsFtxZ7MpJEW1oDKDihZJgpVHTM2P480o6O9qxXqtM0nyj+WvhG+jJN8Q7fu/h8GNMWVNndXDtRuncNogI5wU/u7RQJ61tWOQFXqLkr1X81Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 09:17:28 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 09:17:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH v2 3/3] btrfs/249: test btrfs filesystem usage command on missing seed device
Date:   Thu, 21 Oct 2021 17:17:06 +0800
Message-Id: <56e053b9a4bacaa7d46ac24506a186602f0bcce8.1634807378.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634807378.git.anand.jain@oracle.com>
References: <cover.1634807378.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend Transport; Thu, 21 Oct 2021 09:17:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb8823b-fbbf-4832-d9e4-08d994739a81
X-MS-TrafficTypeDiagnostic: MN2PR10MB4287:
X-Microsoft-Antispam-PRVS: <MN2PR10MB428741B2FDA157B4F9D6C065E5BF9@MN2PR10MB4287.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOU6eKIEDqhcexa2LmXu7lAHTBAWvesM4oyvsCE6HsKepQHDAROTjPl8uywkVd7BU2STd3Tbk6Ksb9m33Rvm/nA406TK09GeUNpGgQt3jHDXx4aVyc9pNWx8l1YYv7sSd3onQgISt/TxlQ/82+CFDKukdZfWzAFsTyONbltycZvvCBkQEjn6a/Gs32yzKCovQgDBMf8AlVNBSX90ZabuCWiFyz6T8/mjTYvuNNLas37ndiNtXn76O/JwJj1MSOOGk1sk86JzujUez2CuwjGNmFJsS3IkRsze+OodSMY85zlBxISx9q0vA4j1gxUl2KbVoA5ZN25FZud8AIV22j4l0jPiUVYmniEmBRwGobQ4aWOEpasdCDcFZgCUyYxw5ghyVxEe45J/lbzvVve4uAJ5kwRoxGQSwkEKNtFe/KqQ1UJyZn9gpZScGm2EEqyyXkJkXahHEXW71y5m51rlFYWd+b7G+2yHVhIApr8t06H3VU0j7mxehTmEc/ddoL00RRkdI1r8ogoEAKJbM2bug/uqvPX7ENOT6TIAyF7W2VUX0gg8DsKdjVXPY+WJsz4Tu+kI/iMc6MJeS/zsn1yfvcA6j+kffCNfoXls+paxWs2d0GaIv42k/58QLZgCC5NsJ580usyloZLGGTxCwLcvI/JxsCs9JkDJWtNNEsnXUERqiE+WaYyhHoY0pqT3qJbQV+pL78fdCP3xY+bZ93GaT89qgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(66946007)(508600001)(66476007)(38350700002)(186003)(36756003)(83380400001)(66556008)(5660300002)(8676002)(86362001)(6506007)(2906002)(4326008)(8936002)(6666004)(6512007)(316002)(2616005)(38100700002)(44832011)(26005)(6486002)(6916009)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fvv1CqImI1wPEe3pe9jV0fYguNoVVmjxZpHyzxxnVDIsKHNeeEPU+xczEdft?=
 =?us-ascii?Q?/QK3LFcrbo8nbVIx2i/UGXkh8KCRmGc7ddaxJVNzTJrBm9iFXPq4CQ9OckCt?=
 =?us-ascii?Q?VWFBmVDq7Gu5M1VXwiV+u7//QX0pvy21qJ1Y04Y8kjndVaT9wa7RKK0eZreK?=
 =?us-ascii?Q?Sctr2Yp9G44EzICMuI6qLEOdIHNzuffMfRUgooRMf+u/pnOzQfr5zL8PYkqB?=
 =?us-ascii?Q?MNDchtMTIj5ZqokqruvsP88RGpnhYzlgvkbzjHzjM4EDcp9c9GjhBa8tS7h1?=
 =?us-ascii?Q?GiJ43wPQzWlLlnXgS+/5ts60Au2Kf4cJ3OsLWOVd3OC3WZzWTq1phHv4/Don?=
 =?us-ascii?Q?TwI9BB4qDCKHSBPe0oFS4X1I4DG8wmOXkLXoLI5CV+YilBtOfhTrWTiMjZbH?=
 =?us-ascii?Q?VcLgq2y6jWAUSrEG3M2SL2+q1ivK0iFiVH068rP6ix14lDRnxRl8c/ME/dCW?=
 =?us-ascii?Q?4VXZ8IE4yJ++IbSYmbF5g2rLzoG5SCFJMhauQHglcd1eN+vqeSAZ5BiqQWNU?=
 =?us-ascii?Q?FTwqZN7l7W0xe2uved9+7R6LDXSnGADKzP9hadbz6ZwBgprjgQ7vGELQpePE?=
 =?us-ascii?Q?XIPXUyvOJODQttwB+Euye2+TX6Yz9hNEAqgvcopeYrlH73YDUf7MyZNga4gq?=
 =?us-ascii?Q?Z2WcA61oqJULvDMIxZvNfvmjnfWFMT1O82mIkPEG0G9eBf8JqEJ/478cJ2qq?=
 =?us-ascii?Q?A9OCbFxlHlwD/77KqxI3NQZIWqPzo9xGaYY0nyhv9L4x7dx3JOhLpMZxPa5x?=
 =?us-ascii?Q?iRpDGsbGnMaRfXO7rFRVj+kRi65GoYx+E+M5VO7ywLZ3XVTMEVvyN8i7+r24?=
 =?us-ascii?Q?5u/vNjSzoBog+1adzDwzKKTqnCgY3RcKzSJU1sJpnaQzVDPMJrS4ikhz3Gli?=
 =?us-ascii?Q?Sl6RZvImitUj1Ya9rUJdiyk0/IapWDx0J1GR1CgeYmOY/hcWhafdqCVvFqNB?=
 =?us-ascii?Q?7vlZYsRSY3s9I4XZl7TykMqr8fwZnsWSaM2SCSdHm32OLEof67ptowyxMww0?=
 =?us-ascii?Q?uFTPstGTgU2lDmaNGnaAMBo3KwJZ9BkLKVTLU/OfHNc95IrVIUx1Ny38mOTJ?=
 =?us-ascii?Q?YT9f2NbfNddtW/e6d8bRiW77SVc5Sj974WWhcDITngYiyqftBTDvVjjIyjjh?=
 =?us-ascii?Q?B/m3OUgomLsxuj6yvCL2lLrBEsYKaqzziN6C8LM44YewbSiZjHLwWqFhPgFu?=
 =?us-ascii?Q?eb68W92bwhOsCZL1xgdt7mL6n6NtK47DsjzYDVzdpt4a6MS9FmFIyQ2nSj9M?=
 =?us-ascii?Q?HrCz5wDUb+zKdcg6ug/aJK3zFqCzXApOHkwkrs1hKjMxcBBkvSvdjMgdEOuO?=
 =?us-ascii?Q?O/AhpxQXor48hI0g1PSDloixYgtrgdwmi00shHWkSRrjXx6j6IbIWsUHNcd/?=
 =?us-ascii?Q?StoKxfE5odmFo8l+poDbA4Uj0w4LvR6RfTVQPzZd7nUlIn1rkSZJMNua4FbC?=
 =?us-ascii?Q?UXeyQ7l5yN4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb8823b-fbbf-4832-d9e4-08d994739a81
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:17:28.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210046
X-Proofpoint-ORIG-GUID: VYU95l-o2Je0XuVVmYMtvySwLutfLgMI
X-Proofpoint-GUID: VYU95l-o2Je0XuVVmYMtvySwLutfLgMI
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/249     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/249.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/btrfs/249
 create mode 100644 tests/btrfs/249.out

diff --git a/tests/btrfs/249 b/tests/btrfs/249
new file mode 100755
index 000000000000..7cc4996e387b
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
+_fail "FAILED: btrfs filesystem usage, ret $ret. Check btrfs.ko and btrfs-progs version."
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
2.31.1

