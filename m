Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7DB3BACD7
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Jul 2021 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGDLXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 07:23:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24932 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhGDLXg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 07:23:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164BCW2u017413;
        Sun, 4 Jul 2021 11:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=zqtJKa3hdOUKZ2i49qFXPQkcpMjqQDD9wQsBf2ZJSJE=;
 b=asC9bUjq4mvzgI6AfxtumOlchXqv8yF7U5JZLfIuLTKfV8UYpB4gFlugqw7Hbf2lACZ6
 pmTTcL/b1nAGnftT/9NQJkwc1PWlDkFXJIKpAtLYDv1VFgs+w8J1YN008trwLX4Gsf0Z
 hEGCKP4au6u+N/NZdX/einRjKa/5h/Fn7kojwip752g4QlYSjlobskRfNmFJWwCkkfDp
 AAHBK1yXGD8aqRgzxklLZkOzl/YBwTtjWv7Z0Yflhb/YFLx6Q43zHTbdhzhIcVwLxxut
 LMXeW6PSw6TH/p0r94iOIbMCTmZgulfyHT9XAH/YlnMfhOAu45q+DGhZT6UHFLOkblYx Yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jges935p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Jul 2021 11:21:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 164BALfD058655;
        Sun, 4 Jul 2021 11:21:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 39jdxd3nu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Jul 2021 11:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEUIEcLEE1EGe39JqgDrRr5c5S/YymLOCPrMvXGtgjoz5sooh2XkgefN7WSgIug4AWKRNK6tCjAbhVaXFVV27m//uAdqEk/2lXUNb1MnO8SDn2XRVFYenJTl21VTaKlg5kohK28JzDec1O58pHWaI5E44eTWPIlSi4ADKfe2zyfqzs9xrdctGZa6LL6pSwPg7rk7DQdTfWvbJhfJaKPt+zpFN5QpuyLGGzDC5jt45FEmHR2DZ9PFKBIr3Z+gfgQj88r1OBWkW8HUusL1DcfJBKviVQRNvhGotVzCibcuPqcpZPxJ4ktzSeXOCsQ4kxjZlnDUuS8kKdc1cBuRLNPA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqtJKa3hdOUKZ2i49qFXPQkcpMjqQDD9wQsBf2ZJSJE=;
 b=DdAGOBn1+gcfeSXsOmdt18/lqObqaS29lO9L5KkzJFmpcI/WH85MOS4GNMgmK8LPyvwhAGQ7pIoFGAwLpd/ITrRqEWDjMSg5jz/VeSMjQkiTg8s0JPSbH0eObsHkHUbeQ+sop4ZSqOo3e9aGEGjACFrHAX1cD+JzyzSTF8l66heZ51UmfhsEwY/ObuIQJqFpcjSxOf65WOhW6uhjuFS8Vgmp4bg4Yd6NrbV2MP/ua6NBMwMdw03X6Ly8SXn4XGAbMEL4S5qhODBwKY+/Ux6HS48cIRItpBE/gFSfgujf0qIQ0OG9sh1Np66uU8rvjDloUszc0ESqSW7kG3fnEDt66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqtJKa3hdOUKZ2i49qFXPQkcpMjqQDD9wQsBf2ZJSJE=;
 b=QxYMKkCL5KdxTFbu8zQRpYn1p+sLakMKFCUb16JSSyxfbPUAWXJMwlYwnQq9+hq+BIUTidegfV9bdLLItd0j69B3+wJgvYgbCYb7DMgzWS/KSeAltvilumdZtlfBjK0OsqdgiHta/umPxrNm+qslt/LOC+avvZM3smXr3AkX3qY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Sun, 4 Jul
 2021 11:20:57 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Sun, 4 Jul 2021
 11:20:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/242: test case to fstrim on a degraded filesystem
Date:   Sun,  4 Jul 2021 19:20:41 +0800
Message-Id: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Sun, 4 Jul 2021 11:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 403eca98-468c-445b-f32a-08d93eddcb2c
X-MS-TrafficTypeDiagnostic: BLAPR10MB4851:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48517BAEB8F94386029B0450E51D9@BLAPR10MB4851.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmg8BTUinFmmiwc224f6zL8Mbw5Y90aoPEw0F52rVk74k3vro4l2qZAnGCe8njH5nG8K0sna5/ESc2X3RGOR9/YjEolDqINIZA/asqD2CMR7q/6Zp29ahDoxj+s48IOvp38cBX4WiCX7RbNICKumYTex8EV0K5v5kfGPl1Flhvkj1XBdJs37bFwaBqU6XWsCG2HO7OyaAx7DeJfIokjkJ1I0uaBs19QkTYqrd4J4+1M+7SwPvAHWBL2NpxtYjf1WmKN9Rc6vU3ZwWijiQy5e1lLXqt/w+KhuNchVKDE2UrHZAALsDCa10l5Sikga5aEY3vf/KZxr9Tvyncy89xvwqdxlIz8k/oiVeM9DTSccNNXtwy/IMzJ9A2kRuNMtIG6aKKVUl+7BbQeMTbSAj+rj3I9YBxMTn/r/PbyhLv4i3blp1HjjzIVhdvu7vWohYxF7v4EkEduV4Q1t40sy7GyRV10fEYjxlHMSWQQXR7I0oH4KB5QM2zhpvzuqTiYXY0/kJBxca0gkjAJwZlvvWgihRCBi0bFALFwt2zyTM/jFQBWs0EilkdTs3gqbw2UHXF7OUJrdQDhCmKMQVs8f4sBCrwDJIUSKXDVIn0C8jPJVQ7DzNBIyz5QAcGauygt6qWRJxdjqfQzbSEUzpYV7V8F2C+NF6bj/3WQAC+PyPpr9kJpwxOPHqSD3bLaqDcTbW63J0SjcvORfDsBtOELrg799iIuzizHC3g69nefidsm5YqRupg/UNecZweI1ccNemfvX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(396003)(376002)(6666004)(478600001)(38100700002)(38350700002)(66476007)(66946007)(6486002)(66556008)(26005)(8676002)(8936002)(52116002)(186003)(86362001)(2616005)(44832011)(5660300002)(6916009)(956004)(6506007)(6512007)(4326008)(450100002)(16526019)(2906002)(36756003)(316002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ftoH6PLoMPubs1zjrFggyoxMRKYDv+u5JG3MVIcU9HKM22qhsMyrqbtB/Re+?=
 =?us-ascii?Q?jAHsqoFQ+0+CutSaGvCto9EAlApM2qazQ9NOPg+OMRg00x4F2UGFWWMkYFPA?=
 =?us-ascii?Q?M77OV6oUNv0q8SAAasnbbH8Bth2ZgL1RYJFqc5qYXYdxDfpUenzbb6xVnF6m?=
 =?us-ascii?Q?fEtpsPnGcuGePBKGy3UEBdg1ERt9YMazoAYX8n5d+q6OxIEcxD2gRT82nsbE?=
 =?us-ascii?Q?5r6J/q+DbFs3SiGvhNy4jjf+xYt1yyblvAz3ayrB9oWicKwtxMH1txVdGnXS?=
 =?us-ascii?Q?JCGpI/w7hHfyrtq1FKEw7NujIA9dSzp2nnBv1L9HZA0POEFMWPXwaRioGVfg?=
 =?us-ascii?Q?dgQFtn9LavizQ7q7MPgLBXp6wPqMWVT8oxUgpxlLh28PQs+lNHs6rXLW7CGV?=
 =?us-ascii?Q?mceso+oNmCpDCpsdSo8WS0yVpiM2wJvsxbPdzzpCMD98vz6I7nV0aiQ/E9iV?=
 =?us-ascii?Q?8wkNX5xP+oiblNr57FVXfFO+X5XKl65xZvDo69wWM+Nm8i19N2r5DrZ6rS8m?=
 =?us-ascii?Q?wjIzoaSCSIy6oTir/uLY4RNqHcOE6lfAXHG4FjDzlsOuMzt1dvr1TyXSdx6Q?=
 =?us-ascii?Q?HfkNIIxi7hvi5rypusEdD7AYVWpvlzxdbfWyj88oc2hBtCRFQExHBVNgyioE?=
 =?us-ascii?Q?evgY/2rxvdoUl7rFGQcOT3i5uqlyDHf1TJy9PMbNMb6uO4/3sI3siW4X+zm7?=
 =?us-ascii?Q?dGkHsCBSeHKpSe8OA105vzkJJ4EOkMECYkaJkETIpLOxxEG94B0MDcuNFPG+?=
 =?us-ascii?Q?PG1Q/a0uoI5Sv/zKLGqdk6IEK8FRK+/aeKGWX4Cgh1HxdPdK9l/a8U4Gba/I?=
 =?us-ascii?Q?Bp7xWcpvIO8ih/8AEGeq/Np/2QAEpa6OVWbxGg+0kYyumtPCRFC600tXBydh?=
 =?us-ascii?Q?NessqcgyMw7+e0avCtYd8hbLkSWQhDmrdfcv+9UTYr5NsrRUR154qPXh4OUJ?=
 =?us-ascii?Q?ycer4D5BmPwby8GYDhkYVd9REI8XYCXNMDLN4cQzqt57WGA76gsf75Uyo3PT?=
 =?us-ascii?Q?cmQApB7qCfTvGiTobhiG/XQHM5XqKXTocCaczkLkhawF7DdvNX9HvRF+SUWX?=
 =?us-ascii?Q?6KkTYLmF29jx0hjcHjd/AIaEs6OgCJndxN5lvIOKZlEXDzOiX1hyZdiShTki?=
 =?us-ascii?Q?QFWpawV3WTkN2XhaPzgKb/ECJ8DqekR8OSIeNVgR4NcXFeUTHC6N/Z6ztVc8?=
 =?us-ascii?Q?mvuZ27xPNXWP0J+jLVEzvVz+af2Vwvirt26Zs8TSpO1MZ5OVTsRrUzJ0fJQB?=
 =?us-ascii?Q?pCpdgr4YubyT2O4YZhCtblZFEVFinMJauzGhX7XW8e/PUUEq0Dr60Xy6xV5B?=
 =?us-ascii?Q?/URm750p5kFsyBAaCpklqzmw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403eca98-468c-445b-f32a-08d93eddcb2c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2021 11:20:57.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77YGVyRoVWlZwerQx8KYXRoZbgqu0EtefvS1joJNRjCFQHmPSkDg/sfxupWNQF7IwWO2LkHoZnP27Ow0oqIhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10034 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040071
X-Proofpoint-ORIG-GUID: uJlzFNK8hcTTZ3xcd-K723hCGfOexYyC
X-Proofpoint-GUID: uJlzFNK8hcTTZ3xcd-K723hCGfOexYyC
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a degraded btrfs filesystem and run fstrim on it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/242.out |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/btrfs/242
 create mode 100644 tests/btrfs/242.out

diff --git a/tests/btrfs/242 b/tests/btrfs/242
new file mode 100755
index 000000000000..e946ee6ac7c2
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
+
+. ./common/preamble
+_begin_fstest auto quick replace trim
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_btrfs_forget_or_module_loadable
+_require_scratch_dev_pool 2
+#_require_command "$WIPEFS_PROG" wipefs
+
+_scratch_dev_pool_get 2
+dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
+
+_scratch_pool_mkfs "-m raid1 -d raid1"
+_scratch_mount
+_require_batched_discard $SCRATCH_MNT
+
+# Add a test file with some data.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo > /dev/null
+
+# Unmount the filesystem.
+_scratch_unmount
+
+# Mount the filesystem in degraded mode 
+_btrfs_forget_or_module_reload
+_mount -o degraded $dev1 $SCRATCH_MNT
+
+# Run fstrim
+$FSTRIM_PROG $SCRATCH_MNT
+
+_scratch_dev_pool_put
+
+echo Silence is golden
+
+status=0
+exit
diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
new file mode 100644
index 000000000000..a46d77702f23
--- /dev/null
+++ b/tests/btrfs/242.out
@@ -0,0 +1,2 @@
+QA output created by 242
+Silence is golden
-- 
2.27.0

