Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DD646D540
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 15:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhLHOLp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 09:11:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30138 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234904AbhLHOLa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Dec 2021 09:11:30 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8CxWOW005888;
        Wed, 8 Dec 2021 14:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FUkaGlrn5C1D4dPc1QYjOJwxDGFn6eryTon7T7Zv/Ak=;
 b=LNITYii7Bu5ivKzFfn4edes+NXZWJS1sTDp/HhS8I+8yDw1vZSJ2cvYcJi2rD7UcYOTv
 0AB7iR4brwdM2uEd7ZJ8ticzOldKGMfLMj1SYyPOsQPmUfTK0g7V8Lh1i3eGVGIJMoFt
 CNzOJlXgEPiV6e+8gZlE3EYZPlqA+SM9rJxOM6dvaajKeqv1eL1802LW+OjXH+tM2S2O
 BxttIzpiAIhdofWrK7MiFOnzQLenEX/YKnWwUGvnb+qgr5g8DOny5kh0/aE12EroSTm2
 mbxGTkScYbYQmtYgDFszWnuyLH0WpnF462KDidrCYqOrFCvV8Kstw3TJlkobOo8nWTRs YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctrj2rtu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 14:07:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8E1NZw158396;
        Wed, 8 Dec 2021 14:07:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3030.oracle.com with ESMTP id 3csc4us00p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 14:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdKYKQckTWiJqELW0yiucqWfpWw6j0a6dn1n1YkzbkPhh38hLn5fB3fUXlR0HuiDIZ7AZDF42QaJAzqARGEUunoaw73WHSi62pmrSWWZ90anmrDvB+m18frg42jfH9YXjUeLXruYYTlsFo7zxfNSjm70PzAHo4NlYdoo6RRVun9QLaDexVp0CayC5Pl9I/AOQlM69mk0Boi4tHSmeQXQczhRSBwUa0ddKX1f42GbpokaznHCxewQ8lHo2yzIeptqtK6d+Kw69LwAEPSTckwmXa+QKkIntUBxIemrNX8cIWFllTZsFM+lvEV1cnhYhTRVhOXUXSYtW3kazsTwDM1p6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUkaGlrn5C1D4dPc1QYjOJwxDGFn6eryTon7T7Zv/Ak=;
 b=ZOa+rTP7bW5a1F48oyV/grVCHq73Qrm7p1H+NB6u9hSAvuWX3OGWFPsfFdWRuEPT27Juswl4aCBd9QpQdw2mUb5O9GxmSYgCtz77XK0p2AeTE+AOfCpbbOA3/423CxAm5wEwit4Cbz8fZsQPDCwrDur2US/qQ3V+PE+/xmfpdHHJNeTLaxnMT0sy79D2loJGdtxwZJr+nZ/upvrNfVtk2h6c/+fFmRp7xun9Ih70ciaGflFSx6w0BqkRMyQPlpEHPBrQrIankFKgLF77kilkKQ3rVxW7BjY6OVn5BD5QAPPj3LuhsLqyEuJjNwhey3To6AbvMcSRjDIe9zkI0kfPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUkaGlrn5C1D4dPc1QYjOJwxDGFn6eryTon7T7Zv/Ak=;
 b=djhECPqls1YA092MSY9h9gOtkqXtPhBe1/sSmw7rSIaTHFzl5MzjlRSh9iWdITWJ+nS4d3yZBMbwQSVQQJ/vnHoHyFh1qNsyb5EXWheKNDMw7dUAW+MZE/3wyXmhLFz+ASR39OGbUjUziacxJeJecmIMd5BpGtpcpcxQ5sdJEJc=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5187.namprd10.prod.outlook.com (2603:10b6:208:334::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 14:07:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 14:07:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH] btrfs/254: test cleaning up of the stale device
Date:   Wed,  8 Dec 2021 22:07:46 +0800
Message-Id: <c1c22a67c90f1b0b94ea3f99d6d6fd4a4d5d5473.1638953165.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost (39.109.140.76) by SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 14:07:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d30a33-e353-4955-66d7-08d9ba542128
X-MS-TrafficTypeDiagnostic: BLAPR10MB5187:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5187DE0F584D7EBE977C6510E56F9@BLAPR10MB5187.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RO0NyF23VcqV4p6eD1xLZoS35etS4S960P7HvsbZbN5MQOUAPRuXCXKZwQyAFvxveKtYk0naKQCU3aweBw8B4XZmrDFXwFnch5qv5UYkvahi0tbvZp4P1rz1YUqZTW/3JVyL9fhkdCnLzRnG5MaWl8rH43U3D7UkHMgiGuzbvfQpigIV70KXBfxz/vxRuLUZADPjNqd6ICqqhh7eHqnjDHGg/7izG6liJcCjmhjHY2LcQqUraw1Oq65mBGl27uqqZNGqmFKvpMabN/argequ+MLaPLT9YqGoff3wM9y4Y4J6/MFTn5/sZKr3iOOHWMi6xbdcCogUUZs28JFiFBjts4GcTm00Lgn85VFiGph1wwTLeo/6zOp3vj4v8btc6Gd7SU0p+Cjn2Fd6cUXHP6yU+2tUA9KucjvkVEoKbLYUQDUyZGo3ROi2pmwGdnPMWQwSAynUz3fJWqEOzBMcOop/7kVRaIgMLjjSSK4/sXsZARKwO79zIRaD896obp2SUNTsQ57MZGMwN2u+g5hNFg1/F9J7llbpPGUTRt2dYcswNo2VqpjdfRKisJ2WLUWCp2i8jdD2x+pIkBcOq0DX9QU/YGlqlKOpv66ef+3IMa2VLxBGMn3quUcBlYFZAUDkvq1eX0OMXy3mFLvC1Tn/Dnnm1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(83380400001)(8936002)(508600001)(2906002)(26005)(44832011)(66556008)(36756003)(316002)(4326008)(86362001)(6666004)(956004)(6496006)(66476007)(186003)(6916009)(2616005)(8676002)(5660300002)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?050Ai9bCMZrao8vnoLcHBuKFE50eXJnRDslOuSR44ZfMwSYwaURkRo2dJZe0?=
 =?us-ascii?Q?SI+9y+thDYMCUTTLH70HD8AvKvcqh/Zl4ikFYei/Cgr5JUgemLdgdLOcJ63l?=
 =?us-ascii?Q?I2pcW/6GdOn4O4JlTb3wyryEgCS4ZcEBExz5UEyP1VMAM30qtJW5Gy4XGoNu?=
 =?us-ascii?Q?zy37cVzAFA4vWZDOS2XQK4eEt768g32kJbTX/zZrn2GDPCQkJ6cY6F9oiy23?=
 =?us-ascii?Q?rZ9z7bMlfESquoGTcfhtH/oEWFS2plcivvvGciN26FPIaFmbZD59xnOs74Fr?=
 =?us-ascii?Q?n7bUTbGhFaiu2LSm9y/gfDObxzogbFIq4Arq9Qkpvv+1okCpPjbD74INROr3?=
 =?us-ascii?Q?ei5mM9Je4THj2d63rTpaPYjEfORz1zw82Vz8itbSPh9WlNGdffHzr/D8HMte?=
 =?us-ascii?Q?W+oZjEqeSFacbUa+Hbqy+CcNn28rx+eRLoI5DhkELyS3U2B49uX4HdndQpLa?=
 =?us-ascii?Q?MMIE43K/fhqpEmSejPCOjIUN7CMz6liwHSRwnjDGTYxuY6soW0SAgdh0WB8R?=
 =?us-ascii?Q?eLNwlKY7qtgkOEi8mD64fYIi7FT4aSzXRuvZzJh78k9yfVXlcX8OvfM48KUb?=
 =?us-ascii?Q?IweYDtMWOYVOmEKkX3djsWuF8qnl/W4KSXudFgzKHnULE+dG6twA5QiW79WV?=
 =?us-ascii?Q?P7hpfJ21illq1Wc+oCnbMOHza1rKJy7c/8AbfqFvvhGjsX02sjV2A2MLJPGo?=
 =?us-ascii?Q?b439KzmYN2Rx7mkiTb+AuidX/GS0DH2zeLbqRdFMnoTbObrcrPtSH9g073sV?=
 =?us-ascii?Q?t2Qrr6HnYI0H0qrMgoB0oQCC2MfDGgUCVBKZ1/Rxvi/YC/snZM1DOa3fCi75?=
 =?us-ascii?Q?GvywCllMnI04YMJgz+Q13VYg/ySp2GYD4JK35YajGhzhDz157HiIjWJRH4Fm?=
 =?us-ascii?Q?GF9yQk9Sx4S1jdOhlimCqUcTCC0szDbS4Z4mGme168+1olghWAkWRUajfZeF?=
 =?us-ascii?Q?kJDQPlqhbBOtJDY7vRfnz1UtmCLaVcinEHqCF+C5UBaziWPIbc9bfiKXrUYB?=
 =?us-ascii?Q?6hzZ+BOWK6LK5Gm7I2XIJe/1ynsTSeYoo2jsDqHLssD6sfE3iq1AN71EM+KE?=
 =?us-ascii?Q?Nrr8vHl+00P7kdwKNl5m16GhRg6KxpfPVo1a2zyqIEtpW2wWq+hm87srotKi?=
 =?us-ascii?Q?gwZxqlZej+DqYR/Mglj2VcSdgdUTw/+33jU6GGwBxtB2neMsWNKsF89aA4xJ?=
 =?us-ascii?Q?yzBkHCbnrHOWQvgCQNjotneBmGODQHs+IqqPccC99w223lx97uiEaIGsF3lj?=
 =?us-ascii?Q?neJl/L7rv1jfjLNNGPviDbSumVhGURzWaQbGgcri9rtyPVVSQCHcGqyWNCRJ?=
 =?us-ascii?Q?JzOdW/eya4rop7Gupm/+J4J4LVd/EwmFgW/dmdgmsyjdflOYe76UfswbpdFU?=
 =?us-ascii?Q?2SwBZJR28uxPd9Xa9vPt1ORuVdduTmWTfY+UqpN01EfPp9Ds3sXLJrzDUyih?=
 =?us-ascii?Q?DjLpOAm4fgC/tieFsBhe7awX90JwPw3G8wdPZMLAYfPJRUSJoPvvf6pPbCjz?=
 =?us-ascii?Q?SVGvzWCqVv067tDEVeAFkfTjoyb49OqIdlUpb+74al3F30wBkJaeMcNYYtHL?=
 =?us-ascii?Q?vOIVHXjI3n1/ydt6FrQaqyRejctTU4f34cJgwJ5LERjFfe9Lb2TB/kO4HvPh?=
 =?us-ascii?Q?XW6edep3CpepYIm0G7h/Qgg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d30a33-e353-4955-66d7-08d9ba542128
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 14:07:54.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLVXhje28+EKi2i6HJr7E3QlrssgtGqz7aVVPqUDH5lUAbSF8yAAZdsDMbkXe9eldjsgWo4uWBT39+Ws6bFSpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5187
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080089
X-Proofpoint-ORIG-GUID: ddsed7t4c64YYoxd5slxXMo-CU2K1vaZ
X-Proofpoint-GUID: ddsed7t4c64YYoxd5slxXMo-CU2K1vaZ
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
 tests/btrfs/254     | 110 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/254.out |   6 +++
 2 files changed, 116 insertions(+)
 create mode 100755 tests/btrfs/254
 create mode 100644 tests/btrfs/254.out

diff --git a/tests/btrfs/254 b/tests/btrfs/254
new file mode 100755
index 000000000000..6c3414f73d15
--- /dev/null
+++ b/tests/btrfs/254
@@ -0,0 +1,110 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Anand Jain. All Rights Reserved.
+# Copyright (c) 2021 Oracle. All Rights Reserved.
+#
+# FS QA Test No. 254
+#
+# Test if the kernel can free the stale device entries.
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
+	_mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
+
+	# Add device should free the device under $uuid in the kernel.
+	$BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt
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

