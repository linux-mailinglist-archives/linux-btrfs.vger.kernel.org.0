Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88523484DE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 07:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiAEGDg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 01:03:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44518 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236299AbiAEGDe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 01:03:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204Nio7o008994;
        Wed, 5 Jan 2022 06:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pap8EWGye9Q18KMZV7/9Mqerz7iyqAm+MeDbeE+hbHI=;
 b=Wudt/76Rb7hQLg8SRIkfIMmhB/F/CUl1VcffcJawONabcuo2POzorF6F0DNB0BB5zqCv
 lGd5moirWIa9ZySUZyOWuBvxWTbDEC4WzyPTp+desWDursHpS2EccgTEuv9CEwwy9qsh
 ZB7prKSa5eOK7VyBmNlCxJ9xg8+/2FuGRQVYj6cree32SFkpAr79JkA+0YxI49jsSu3n
 UnBk+4TmyKtJ31c3EA892GD0gb7BquHNk3G4f2JwOvkz+b4/zyVjQvTsVr6zhPHSMmen
 /ZbZO6EmGuFQJgigiqyHN4CKc3vXYBwn8a0etOqk5iTGKDzHW5fIVUBdehl+c1j74Rwa Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc9d935ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 06:03:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20561kgq063936;
        Wed, 5 Jan 2022 06:03:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3030.oracle.com with ESMTP id 3dac2xr0jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 06:03:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1FRqvi+FgpSXH/XnCFxZguAN7STXtjLynfJXuxuQypluVDpPKTp7vSu5ncp13ny7hZT3auvQ/fk9aV9fDwal93Hgna3Hc+zSlC4eyGkh4rCgZPPASusRShc5F3atrvlL7iIZM+USxaNzX1kMHGevKahdLNFELGmGjpv4YZZMU9lQ9iCghBNfVvQxOXIZsC+Km6WvY7d0xJvNyvGHS2sHAeRMavB++UPHPGT02WHuR1IJRj+zyqFidoKrhaGkEK7ke9w7xLrG4lGMd/6vRUAltJyiyRtQoFD4V5yj1h/Fl9zMe8xU7DQ3UwqV2Zu/a/ISE2kDQde5SvTnvsTBUZpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pap8EWGye9Q18KMZV7/9Mqerz7iyqAm+MeDbeE+hbHI=;
 b=BHKVu/SgoKijf0JjawYMYJnP5IuCkNuUENsqXFTu/VvrghxHPKn+qrdB90S7O9yvizEfzA8sWzSF+TozKiOZOc5V60B/hcUNo7Dc2fPryTt0dBHUyzuMCz3YcZhm/iczDGju6WIWBpld5CUuKLMSw4vJhmhjHsw1sFOaQr+hhmQ+O0Z2Gk9kpJjP0F5b+e8MFA6Qz8xLmgcLVO2kZ7LdvmhPmzbybNl/sjBT6gflgJ9Byt2BuBfOobjK7pZk9p4jR9Gbi+t2VBvM21fcVIFiQbT4yNpdONa9EZ50bYO5ahDDZovvHzdmW7dgeFsSDFJjhybXPX6Zglt0KDC7JIRI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pap8EWGye9Q18KMZV7/9Mqerz7iyqAm+MeDbeE+hbHI=;
 b=pooBsEpmxLSmeI0kcIqqC4XmjrsX6fbbFqrA7GAbvbsYYETJTBQGkokW+CAVgrIjpyAvZZ1jK250GYv1biMk1L2RT7zfixipBtPa0ymfmGktFVi+GtKsLHAcVYtP7MSpwwOuAQzbny53fn5wagj/Ud7nXvT4yf90szXpVKemcvo=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 06:03:28 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 06:03:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     guan@eryu.me, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/254: fix non-unique fsid issue
Date:   Wed,  5 Jan 2022 14:03:20 +0800
Message-Id: <71f90a1e3f89e2d22e3681cc8373bb08a814865d.1641356220.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1833962c-ec80-4107-08eb-08d9d01117f9
X-MS-TrafficTypeDiagnostic: MN2PR10MB4368:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB43689C25FA14C6D2580D8E50E54B9@MN2PR10MB4368.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDBR454+lqK3iZGtzVXQJq1Fr07SOeRAbglSiC7QCqzdYAfnUv6ve165W7igBvOgfghCYQTJhMNf3Onic/h/Y0FWiFbSZ/37Euxb5uHfA/4U+SDLyCArDYiDn+XcfdAewsIdrZOizOUDRRkff6IvHsGrLqqVzcTIQx6SNHjHBJnR0UJlnFBaKpfdeGJn+g4Kms7mgfKZUlgtgtJnwTK6bMje9gnz7iBUBS7m+HMocbI1ePcFExGNl7ixAB9FwmJLpMAx5dBWUCLROPXHcm+mwLmoBK4LV1XvMVR182H2WX0hCl/Rxhva2G9r977NlcJidZdUPDMRN6amQHxEp4X3nUIGex8WCPc5ymdfywUlKet1r2bogV08BwXexRWphgnQVXl3h3vhkOTrpvrxxUeRsg7QoPo1PUE6pgUPo6EG4LDOSz40+wiE5GIeB2Uwk0yncJEgpumpcP3AS+KJycJJFKDqmpVsvRuTqm88ECmRhNzk4G94Y/RWEqW3fwi31knIHhoIxzWrYfQfpaOBSHBe6NMQB5A+aDk5EC9DuLBY4pUOOu34dCz043ofhs1l7scuEFl+Ml2IJ1/JZe5KRVjVGtwveFqQsea2SZ1HxNC2yq+HckE1FkkVqkTDfJcjenOXCNChHSK2DGwZcEL61pYYjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66946007)(83380400001)(2906002)(6512007)(8676002)(6506007)(5660300002)(66556008)(6666004)(38100700002)(316002)(8936002)(2616005)(6486002)(186003)(36756003)(86362001)(44832011)(508600001)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qqdDlyRDUd6aJPm8aenpNOPxJot9OK+TDrplCGnX9O/6Ee5lZFeC27mCLbcY?=
 =?us-ascii?Q?hKM2d0doreojBvjdUFx7Ca4j4wntpy6OSpgF87XGiVJKEYoDUNBCFAW8bdcS?=
 =?us-ascii?Q?NynryaAsjjdftHJAmbF1RvtbS0s5qt/8xaE98cNm+cfhka8uDFkUtohKNxjm?=
 =?us-ascii?Q?dwX34olTZJ8VHbS39hiiUcDfeWuVBfnrpPSo9dlrQ8AU1bwW4Za2nCjNO5+s?=
 =?us-ascii?Q?y3YLl9jSBnClkhrCEBaEYpxtCU146zTZdUoOd7onDdVKq4371F8AhggfdlCs?=
 =?us-ascii?Q?X4VF680CX4y2uWhc+48nBA+BQ5yvkiZuw7A9Bz9+jxcdt3epqpLTeMnzeCt3?=
 =?us-ascii?Q?eOTJMDXpwgjMK3DwkYAeY076W9BYE3mk4txK+PXtjF69ZVXTqwZfizfGepfd?=
 =?us-ascii?Q?7zUHTYDGVWLWDXurIGZtg+SiYVgeUfzuZVTimi0EmTmV8GFFS1xxf3hpiLXU?=
 =?us-ascii?Q?Qcq7YABNZVa9/j2qlmXfgDYzqseAb5+fQNqpArRoomA8GTtg+pMFDZApDgGC?=
 =?us-ascii?Q?zb1s1CEdgi8BPvLeCf44FEhdMEWNgvymVLijf55ljIbVjliTMki8c+jFm4sa?=
 =?us-ascii?Q?6vVUcaTLlmhMDMTcftVnQdpQeZtjw/2NXMM+Y+usnz8Dn4+XaRljP/5RKks9?=
 =?us-ascii?Q?57VuRecc7lP7ZdAno9kwYyZGaqbNNgBAp23ydChTzVTsQN5tWJJBJD6snZkY?=
 =?us-ascii?Q?HYi6VdSGmYer7nWQR/JgHwgzLtD9QUirNMJjf7AMMsRa6IhkWF5Ksape635S?=
 =?us-ascii?Q?j1NBXkbh7C3gwxAMp0QNKZlapDU4pSibjwiwx1HYFsYJ6Tz+fnYtF2XUQj2U?=
 =?us-ascii?Q?7fLusZO8nna3r4/MWTrqdb3xIVO6+v8BKRl9GGR+OF1w5FL3F6aj4T1n+cYo?=
 =?us-ascii?Q?wie04o2wctXG8xQ4Ej223JXHB9BDB9TMBEXpXQFch0o4DVg50xMdHwZ5j2qb?=
 =?us-ascii?Q?mbW15IKkzQ8OtEFBdcKOzQRiv7zFF0yXIEWq14ilrJgqrhPozlNpNvNxPu2z?=
 =?us-ascii?Q?W+Cf444wP2N7VDL8KD79pS7wnqwL95gleqq94BLc+2wLBaDdA4jTGjkG0ccV?=
 =?us-ascii?Q?li9J8rKRbkCVHdr8M0uf8S0wxrWrel0hCjbZSzx0MukXYuxlx+uxYNOBajXO?=
 =?us-ascii?Q?vX4pppnvoBJyFF3P/QvTzOLvQ2UU+LdzgSHkWqYf6z1Vz2e1arCAVoENqM6k?=
 =?us-ascii?Q?ByG4/GHk3UpueAwgZSWOVk81SVqv54qsp2cgZ96vLnY3YrT8A3uzbr08I2BZ?=
 =?us-ascii?Q?unEczvhsNF2cmLwdyJpSEscqRyAoyjtL+rox+mkzKdTdoqu1Mm47V2kQ1O/y?=
 =?us-ascii?Q?pep9cDAIQr/oviuUOTcZwKGsHLumtV1F3AAHEF2OUegb0XNhugz3EoylpAOe?=
 =?us-ascii?Q?0Up7PADdFkkNauaopvMMfjgrPgzV5ezI5Py5h2GSA2Z6bAIMU7/6RWio6igq?=
 =?us-ascii?Q?33a8jeR9oWbINSBzVCe9oDleRxSwKqIEDbeGHes6U/CSBULoj9zTww4qtwsZ?=
 =?us-ascii?Q?MOJXtJDeahX5+jxRw2ETYAW+LqoTeQbEXid5xBk67XaHRt+ahCNGNaWSJ8VB?=
 =?us-ascii?Q?0LVSVrBOOt2F8C0RwR+afupKDW0d3J+pLIzjUb/YqmO/Gy3qIXrHLJF8I7qZ?=
 =?us-ascii?Q?CepXbEa07GK+rXJJ0j4JJsc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1833962c-ec80-4107-08eb-08d9d01117f9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 06:03:28.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQUOedzLT6Yq3dVR4p0o0LtNDZqb1JOoREMRK0WQpQrcQIWXGwf5iqAdbUI7Y5b7eBbqiZtxoi9n9aWj3igptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050041
X-Proofpoint-ORIG-GUID: J0J2UChLXaGxcZwGoXssaHiR6gAjn6MH
X-Proofpoint-GUID: J0J2UChLXaGxcZwGoXssaHiR6gAjn6MH
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case needs two scratch fs. For debugging purposes, a fsid is
kept known. However, mkfs-btrfs has a stringent and inconsistent
approach, to check if that fsid is already present on any of the other
disks in the system. (This does not apply to the virtual devices in the
system).

To avoid running into the non-unique fsid found error, remove the known
fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/254 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/254 b/tests/btrfs/254
index b70b9d165897..2f3ae50f2e3e 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -11,7 +11,7 @@
 #	btrfs: harden identification of the stale device
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick volume
 
 # Override the default cleanup function.
 node=$seq-test
@@ -55,7 +55,6 @@ setup_dmdev()
 }
 
 # Use a known it is much easier to debug.
-uuid="--uuid 12345678-1234-1234-1234-123456789abc"
 lvdev=/dev/mapper/$node
 
 seq_mnt=$TEST_DIR/$seq.mnt
@@ -66,7 +65,7 @@ test_forget()
 	setup_dmdev
 	dmdev=$(realpath $lvdev)
 
-	_mkfs_dev $uuid $dmdev
+	_mkfs_dev $dmdev
 
 	# Check if we can un-scan using the mapper device path.
 	$BTRFS_UTIL_PROG device scan --forget $lvdev
@@ -88,9 +87,9 @@ test_add_device()
 	_mkfs_dev $scratch_dev3
 	_mount $scratch_dev3 $seq_mnt
 
-	_mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
+	_mkfs_dev -draid1 -mraid1 $lvdev $scratch_dev2
 
-	# Add device should free the device under $uuid in the kernel.
+	# Added device should free the stale device in the kernel.
 	$BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
 
 	_mount -o degraded $scratch_dev2 $SCRATCH_MNT
-- 
2.33.1

