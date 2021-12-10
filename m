Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8787B470848
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhLJSSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 13:18:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16458 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245329AbhLJSSh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 13:18:37 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAGI8lT006287;
        Fri, 10 Dec 2021 18:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8vv85XS+9ZPUgAV4ou/OUiIYMcV9cZ6A9w5YwzAzog4=;
 b=PC6vI2HknYq+ZUTKAz2TdwP1lYrzwEf5lom7aFp9ELqq1RBT7+XwEkC8EAqg9dD6vbtw
 s1pKuuZBKEKwtb/TMh+2eImZ60/0ZiAKosjCnA/pKd3pSr/nDzaXVtgDS8EUcjqqNrVa
 0qMWwByhlBWMnH5zrGhFtgvZKF3YNf0yzGFvmVmvY1BFll71n91hw1FPlH8SDYF+dOpf
 jsuKuT7pJS47QeuynPJxOMyum9dnx5ngzcz0sMLPvUsciQP+H50ZsG5aL2p+ClL3OG9V
 z6BeAqSiRh8eqJTzGL3YAmVuCJtYbB6FeHBedWgxsNE/Mt0XCCDWuB0nH28XD0/ZNmfk Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9y88pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:14:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAI4qVK042126;
        Fri, 10 Dec 2021 18:14:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3020.oracle.com with ESMTP id 3cr1sum5bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU1Filq1mA3YpJWQGHB07wCyRbhWTdahNuAZ/4wSB47s9kH2IWA9Jg9Vp1RCbzgw/e9tXzp27i3IjBnhV+INIl3DNmRQcofEFHm8wWn9LhDj958g7/Lnu/cystdSYtEzwGzjbYHu3Y2JLZhOFac/yV8douNYC+kpQox+1ltK5cM+wHtv2JKtdiQgJYtPY046wDyPmtOcRdWE0cHkyOEDzmrle8p/ctxJBSRvUGsepLSMa0kxfWOjvic7jSb8DNVXoL5HyUjQvr8NMsnawIDVmFlRmu4ienD2SyhZtZkJilt/JdKIW+OKv/Kit29ipZctKC2opn8f2rHHxir/itzy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vv85XS+9ZPUgAV4ou/OUiIYMcV9cZ6A9w5YwzAzog4=;
 b=IVQdI7prWWBihy2muDv1FXDgDxyhJnH9P0zGW+1H4BdVWywDaAsN9/6+hWu/d2aoAA/4WLC7qMS3YWZdTYyXH6dtRuNr1HYphev0bsRmPnS0OW1YEoNB69eQHTpriRbBd3wi6Ht/wkY/Ho74AiWbONe45C94ZM4ApvkXnbC/pqkrKNDLiPPUdsxdWe6gex6BajQ7pPnQEII3DOxJ9WKfnA43GIZUJuHHdjJx6OEgytOjtcHpnTvq448P01gOXvCKZabn46cmrHzzdW7pfV7rMwO35EVj9XBtYTUU4D6bYPks1h8aqjZtNQX52Z9mlavmnLBQ5JLuZOoDCFT9qD6hQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vv85XS+9ZPUgAV4ou/OUiIYMcV9cZ6A9w5YwzAzog4=;
 b=RA8LM//KnXWeOSfdbEskWgzGoRWyR8XDB7MN/jmiz7pCun1keXUQhWedKuAH1OHavKDdq8ctiEmkhdl24+bzybTggPz0WRRGjfz+lTjR1w57+6xoLsFXetH23ZXv6SQ0HgGNvYfe8TMlZHZ5LJPtTMBooUxKkQfHdwITmyfqjp0=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3025.namprd10.prod.outlook.com (2603:10b6:208:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 18:14:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 18:14:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH v2] btrfs/254: test cleaning up of the stale device
Date:   Sat, 11 Dec 2021 02:14:41 +0800
Message-Id: <61c0bd3a345d8cb64f1117da58c63c2cd08a8a2c.1639156699.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0094.apcprd06.prod.outlook.com
 (2603:1096:3:14::20) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost (39.109.140.76) by SG2PR06CA0094.apcprd06.prod.outlook.com (2603:1096:3:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 18:14:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf954fe9-ba90-4842-78a5-08d9bc08f7ff
X-MS-TrafficTypeDiagnostic: BL0PR10MB3025:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB30256214C984AA0767FC69A5E5719@BL0PR10MB3025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l11yQvFAQh80TO1UNXMGFtXIpJQblbM/QmwFMPRg5s4RrUm/E3TySwYl0sWYuUVjmd8dGLmhp4TlVb5hm/bUOFQIpbSHaXgTVnzuZvjPGoqIojnn5dZr3x+7LUD3ZdIX0lSS+ryoukly6jGFbqShbwtpStUoaHqCNNhaelfdE6cPJfMcrb3qt8BDT/5ialuqw2Rsxs/Rir0oYdV2rcSd4r+SprJdI6aMT7rcPGAgSaaKST8YJy7K9Tq8hpgDNUcdJ3aD5TqC/w1uAg3afBmp2RJNwCQp/4OBJw9n+MTcPzjj9jps0Ti/rl+m8tNabpflK3V7o4MBqsdy0s+3ArIerIoSzuGHY0Qv6nTVDHq5xtW54NIsYl+q07SUX5sAddap/Wdru7jOpbg84MF+ZLuqsV8JrN9Y2eWGAAKrfpVCzzqkfmCvLkzS2zO5SMC766iPPKQDL3bEXv8oPrAEgYR3wjPnYeyybpuG0jr/W+0XhCVZTUbiwNvBJoBzMpWHZygU0KvSE1hHZIot0NVXUQx/aM+zPEBNqg+1dKCWdfAfTIyBo3OF8ADV0IyqTHEwfE2Wset2DST0XagTsq+hlEMzwIxAZHNDQtB5w77k7DgoXc9ph9GFKrdK1df4t2HEogY7YFxQ2IhKs2NlSoi2S/iIAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(186003)(44832011)(6496006)(8676002)(83380400001)(4326008)(8936002)(5660300002)(316002)(956004)(508600001)(2616005)(2906002)(38100700002)(6486002)(26005)(6666004)(36756003)(6916009)(66476007)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37OrOAb+Dee2PSmHEoykV/6rcDwbjG9SHuKFVNw/p6zhjdU2b+q9jIQKBRfu?=
 =?us-ascii?Q?IZbx3UoXDY3AyZHAHPjFJ/s1ztIMneiptr0kb14H71Nunn75VpIqBpvw42Y5?=
 =?us-ascii?Q?ByfsRI57ObC9+wYUd0Bpa8k2UEpSZ+YZ1LohC3RZimOBLpflEb22g3jGiBEM?=
 =?us-ascii?Q?17WCbYYZ3UmxH/wAVMXEQrMsd9eNfkwATFVy3PSyp2kbXTn2z+IVeT1vE9Fn?=
 =?us-ascii?Q?Ur1UnY0kWd2t5HNrjN0WwUw13j28pDE+0D9cf2iz2dUTGBfcCGv2KPQE5EPO?=
 =?us-ascii?Q?xxMROLVnPhBniOuLb0mHmeNn57thH2n0btLkp6Hf4LTZOJ1njdkIXBT/N3Hi?=
 =?us-ascii?Q?NnosKlNESvth3VM0KqJW+JEqDFOGEvW/ZISRnBU4d1eaRUEqhm5IdWj/wAev?=
 =?us-ascii?Q?fZAJqETEbcqgTvy0wf3FpWAzjwffQKtH6W2CtPO3YMZ/zRFOlQJMbsqpwuAe?=
 =?us-ascii?Q?HeEumYBgE7DrgoyGzq+9m2D8GjYBXfjh76SylCHW+FJIhtmbLaoeizIdRy9O?=
 =?us-ascii?Q?t9jOKFGnoKOQtpoVcyRklIxD4l4X5H/ydFU4+/2da82QWJkVzR4plUHuykmD?=
 =?us-ascii?Q?S9KEQvuG7OtdjIvUkBNT5MbVVjUXF6kySbAGQpqbQXZL6ilVXfKdQo6z2kpm?=
 =?us-ascii?Q?IBYFL4Nf/HTgB76Fjyj2NhOESQnnlOCnUdsykU0R8VyZV7mCd12U9kBYKj3T?=
 =?us-ascii?Q?69TjpkPUFMj9v8uTFt6Hkiy4xNf0/zhfBDrvWJBlqeBQ7d2mnGZVDNr5J+6s?=
 =?us-ascii?Q?YpoVbEy9Vp3cZ23n+92e+/L0diWyGpmH7+FC4OgCct5mDTVTYSnpvourVmKa?=
 =?us-ascii?Q?gfp+vwX5+URo0TD7Wt77cgV+jpFSPCFIXOeKshPmR2tDxlEi3LHobJbIGngP?=
 =?us-ascii?Q?yKgzK5P9LyuU9abNav5QcNhksyZgsyuRyVAnyWFDd5OCtJkKMJfO4TCENQsg?=
 =?us-ascii?Q?+RK7x9ncarY/7lG1VQGoorpRIwCr2I6qbA3B5xU0IvkHF0S3wDrqb7mF9M8W?=
 =?us-ascii?Q?MtBSUW1pqn6fvsCy0i43x9dj/kA9sJeQaR0FngRFweElmb/Ur0V7JIWX8SCU?=
 =?us-ascii?Q?pMjA8tiBTII+oSPcOKckJBRuprEcDir/6+cPkta40lV2QrGMgHpFdpaaFeWc?=
 =?us-ascii?Q?6uHVm0owpnpjxoN4043szAaGpwyU+jR9iksBduGuv0pifVvBJm3IElk8drn/?=
 =?us-ascii?Q?tQ5lJvtDr1pgl6gUILuJVZkNjxDsrbymHbsm0p21eqFZtOadpwu+ZtgK+1F8?=
 =?us-ascii?Q?i8QYeX18FgdGfdHDWEnvNCDG3xMGnA0g90CX7MTK/hu6eQVHGGK2Hx9JRxUd?=
 =?us-ascii?Q?rhqqduSg30ZBxGJ73rvCmcgZs1cMQqRMPwdB3M/Px0jwVSmY3ewkeF1r2EmI?=
 =?us-ascii?Q?TmgdTxxPUdyRHsMWTMqSC/BsmNrXBKzp3f9tL8Skl5t3dq10eJwzM5pWW4uN?=
 =?us-ascii?Q?TnfZEO3q6HzPm548vCTW6BdP6HHJSEA/5V/ENYfEBtkybiTyQhhkFbMBaxrZ?=
 =?us-ascii?Q?PNU/tCCRXj+d2FbACYBImt14ot+BVY1DgQd8C2yCS7LUzqBlE7pN3thqHg28?=
 =?us-ascii?Q?RzuKfGCbP4sibZ4SyCO3qrv6goL3Zz8I60O7S5ybr+EaCRRMQoMYIB1oTv6M?=
 =?us-ascii?Q?7gmnlPedOVJeYEsrIqWm3Vc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf954fe9-ba90-4842-78a5-08d9bc08f7ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 18:14:55.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p45gw2H1MkQkZBNtpYp+1GTngsjWVUJUWfygFiaHeqBL4E3DRqeyQketGfsdT9em02/3FJL44sbXoZm7H92dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3025
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100102
X-Proofpoint-GUID: Uae4eACV3hcwFG8OoAOrkieKZa5DlLO8
X-Proofpoint-ORIG-GUID: Uae4eACV3hcwFG8OoAOrkieKZa5DlLO8
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recreating a new filesystem or adding a device to a mounted the filesystem
should remove the device entries under its previous fsid even when
confused with different device paths to the same device.

Fixed by the kernel patch (in the ml):
  btrfs: harden identification of the stale device

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Add kernel patch title in the test case
    Redirect device add output to /dev/null (avoids tirm message)
    Use the lv path for mkfs and the dm path for the device add
     so that now path used in udev scan should match with what
     we already have in the kernel memory.

-       _mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
+       _mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
 
        # Add device should free the device under $uuid in the kernel.
-       $BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt > /dev/null 2>&1
+       $BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1


 tests/btrfs/254     | 113 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/254.out |   6 +++
 2 files changed, 119 insertions(+)
 create mode 100755 tests/btrfs/254
 create mode 100644 tests/btrfs/254.out

diff --git a/tests/btrfs/254 b/tests/btrfs/254
new file mode 100755
index 000000000000..b70b9d165897
--- /dev/null
+++ b/tests/btrfs/254
@@ -0,0 +1,113 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Anand Jain. All Rights Reserved.
+# Copyright (c) 2021 Oracle. All Rights Reserved.
+#
+# FS QA Test No. 254
+#
+# Test if the kernel can free the stale device entries.
+#
+# Tests bug fixed by the kernel patch:
+#	btrfs: harden identification of the stale device
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Override the default cleanup function.
+node=$seq-test
+cleanup_dmdev()
+{
+	_dmsetup_remove $node
+}
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	rm -rf $seq_mnt > /dev/null 2>&1
+	cleanup_dmdev
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch_dev_pool 3
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_btrfs_forget_or_module_loadable
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+
+_scratch_dev_pool_get 3
+
+setup_dmdev()
+{
+	# Some small size.
+	size=$((1024 * 1024 * 1024))
+	size_in_sector=$((size / 512))
+
+	table="0 $size_in_sector linear $SCRATCH_DEV 0"
+	_dmsetup_create $node --table "$table" || \
+		_fail "setup dm device failed"
+}
+
+# Use a known it is much easier to debug.
+uuid="--uuid 12345678-1234-1234-1234-123456789abc"
+lvdev=/dev/mapper/$node
+
+seq_mnt=$TEST_DIR/$seq.mnt
+mkdir -p $seq_mnt
+
+test_forget()
+{
+	setup_dmdev
+	dmdev=$(realpath $lvdev)
+
+	_mkfs_dev $uuid $dmdev
+
+	# Check if we can un-scan using the mapper device path.
+	$BTRFS_UTIL_PROG device scan --forget $lvdev
+
+	# Cleanup
+	$WIPEFS_PROG -a $lvdev > /dev/null 2>&1
+	$BTRFS_UTIL_PROG device scan --forget
+
+	cleanup_dmdev
+}
+
+test_add_device()
+{
+	setup_dmdev
+	dmdev=$(realpath $lvdev)
+	scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+	scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
+
+	_mkfs_dev $scratch_dev3
+	_mount $scratch_dev3 $seq_mnt
+
+	_mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
+
+	# Add device should free the device under $uuid in the kernel.
+	$BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
+
+	_mount -o degraded $scratch_dev2 $SCRATCH_MNT
+
+	# Check if the missing device is shown.
+	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
+					_filter_btrfs_filesystem_show
+
+	$UMOUNT_PROG $seq_mnt
+	_scratch_unmount
+	cleanup_dmdev
+}
+
+test_forget
+test_add_device
+
+_scratch_dev_pool_put
+
+status=0
+exit
diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
new file mode 100644
index 000000000000..20819cf5140c
--- /dev/null
+++ b/tests/btrfs/254.out
@@ -0,0 +1,6 @@
+QA output created by 254
+Label: none  uuid: <UUID>
+	Total devices <NUM> FS bytes used <SIZE>
+	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
+	*** Some devices missing
+
-- 
2.27.0

