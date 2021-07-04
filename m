Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201993BACD0
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Jul 2021 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhGDLRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 07:17:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24294 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGDLRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 07:17:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164BBXh5023176
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 11:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=x60uvfBipJALuEUlGRUwfPDiyi3qyS+lShdHyx3junI=;
 b=e4sW0antsfWVnyNnCdOXReCdExxkbqAQTINhY+U1yJgb13exbFPIe7Pd3C9ELYGMHKgH
 ZSmHGgjZW0pjgfrOxOyEume3SDpdVwXj17Qp6z3FeAZB506nWrlaXe2ZboA2ot58EiiD
 T5q45Yg2ImGp2Fmn8534R9HjEQ7hNCvZWgCUX0UTQipmlhxGzG99YG+wJbW6gTMCSbN8
 J883aIFZAFjM1wP0XMYAeYNHDOkuHR28b90QJCwPxGvmabyc6+SlEtk7zBXTN8u4XghA
 0RSOmU5jpxpO+3xAH0pWG/RR0vg+smOne3DeGYZWC8qmAzMnfmfVR5DDaHzwBYRCrASS YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeg1h4k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 11:14:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 164BAL61058662
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 11:14:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 39jdxd3dkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 11:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+JSR/ttfec6D8wl9cmFXXYDuVqI6au9bMJ5SXMyfhBzkQLqzesauIIKEYH9BG1YFpt/+kn4BjxuuMf3Yu2uvtKZf73/GCCx5Pwx8t0vaObvfUMP0u0wjnOD8hD0HYRwXdB5y26c+diVeHORB5FiSEC+XywAXKgaibOFcT68/iZFRwcQWPsJke5uqE/cEqm8bR4LKYaBOEBsso6UDbL7eH+WFih44bBF7CIvSRn+6vRvqQks9kBckR+qarPEE0z8y0LnYhT8/EnRgv4L3CEXf7KQPhhIaXn4gQ+c0ZK4I2GGmhxyCR6ulCsNpDIQLkJXDOtNC0X8QA770nZ3qxSZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x60uvfBipJALuEUlGRUwfPDiyi3qyS+lShdHyx3junI=;
 b=ZTQi9JQCEXMc8wILg6EqVIfUR1hDslJCwYBbDIKzbYiXoiqGeBGzehYTg7WaDqoGZ761XM0o3IbHup1HYNBJmrHaHvxg3S4v+cB65phOpB+yLiGPi/ydxNzlZax6Az6Y94BZcTEya8KhLlRuCZHdiHivydg4vT4NOMHs1JvsatprLVvGcTi8hkVUEFsjeRo02IJi8LtpnkvXLVwNcMI+r/Fg+8kDGxmln/P4PuaLViuJx3WWSd3+9sucrYKS5TtAy4eLgL1wTKbEVICWfJKcf4FOsU6E+sarrUyQ6ZtIU16oKlO2HGXTQABuzqxHnxu3zqrgIhyHXp32YdX1UmXOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x60uvfBipJALuEUlGRUwfPDiyi3qyS+lShdHyx3junI=;
 b=OapGVgBP7pKQjP0BXUI1ELIsCukWox6hlbBQwi8dJLqEbNCxscTAff03brXxS2i3ajE+nrAZEAAu7QVGGHAB5Jy2qNw02ifaE7p6Z4+rRY3JHGSsbeWZvOUASiluqq56WAyojBbSld82DjMiSb4aksC+sKUG5OjOYtq5f1Y504Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4240.namprd10.prod.outlook.com (2603:10b6:208:1d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Sun, 4 Jul
 2021 11:14:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Sun, 4 Jul 2021
 11:14:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: check for missing device in btrfs_trim_fs
Date:   Sun,  4 Jul 2021 19:14:39 +0800
Message-Id: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0078.apcprd02.prod.outlook.com (2603:1096:4:90::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Sun, 4 Jul 2021 11:14:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce464255-263d-4dfd-accc-08d93edcf399
X-MS-TrafficTypeDiagnostic: MN2PR10MB4240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB42406EF8A76925C92807B3ECE51D9@MN2PR10MB4240.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPswNm6OxwKzUn3Cz0wwCF7VrxGShGLt3pGWaqcLeZLcZddgsWZ7YP6T/U/pi2faaN885bOHIANmp7Fd4L9F22YBHd0X1X/YJR5+FK18nr7LOGJaQtCx+VgEK9QQ3PxfUO1dHVBPze2+Xnw0w29xdtZJE8i/qN0fBjfSaB+3tiYaVFXlBzGt34eyrSLwVKBiTTQTEOxXTPuDMdlTS6Qhz/a15j0YpfPHGzagAzOzdLD68wCBErP+P5zLu1GdVKk9IFia+ilMUTLBevx92nYyEm+YkU2CPDQY5C7p0R9+HRhxlpUfkOsVfhuupMfeKUzZaQy137kUMEYim+GYmbd48fxIFmceAL97pyvcpld58DAJ0l0fLwlrvWLUb2H71/5LhsLGrtm0DKk+FG8g8Ig/dpMSAlYPMZfXKjpjwAjjcfzjyQVCdpeps1I8oVtjSNYOx+fy+4GdXbDOF1QP2IN5mvHvgwO29eat67BxgOipHzBHCvaelhlAN+1WgplX/3tE9/SNEDzE2EDENOyYp3+EyXTIPlqyCQFabk9Fvb33JYJ79iv+alxU3yloiAF2vZxkVWkgHLzMGiUvgEbokB0Duz4sWq0O/twrHnTUpOd0kh79Amgeg/6mN9jlCNRPB1Qr0LqHsdpoZX6aiuAWaPSp4+MSLSiH0IlrSI9o5LSc+DMUbFpInYN3EXh12L481+eGisBiQFsUIw71hgc0KT8xzsF7+HLMIcStsiCiC9BkSfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(6666004)(38350700002)(44832011)(2906002)(16526019)(38100700002)(66556008)(66476007)(66946007)(186003)(36756003)(86362001)(8676002)(478600001)(83380400001)(52116002)(6506007)(5660300002)(6512007)(6916009)(316002)(26005)(4326008)(6486002)(2616005)(8936002)(956004)(107886003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cD1clGnKP7oKyYORt1V0iNIB3EJuHQHfBmxgkc6CB1d028yaHnF+vlQeoGNO?=
 =?us-ascii?Q?JXKAb2femHcCw/z4mwpvBXbsOxeiW+Q1MugguVKshZnjiLNUcSMUhIU1oElS?=
 =?us-ascii?Q?1OB1hSIkBUb2SW2L+1VXAQyAl9YnRxStqpevKxj8qaKTRigcp10/rxBFf4Ls?=
 =?us-ascii?Q?mreLbdiJuX9Hori5+MytOPYC2ad/bE2WaEQzwlgAgDtwjkx+lKFXr3TWDCBX?=
 =?us-ascii?Q?dlK/UK/noMzds79CB4LM1Votv/Y3hU9H00jaLd1ffywAGWI4kem/Vxc7O397?=
 =?us-ascii?Q?WbJkW5d4/XX3B+ogP9agZp1ioayxsqf9x3bWsYm8HSzdVpLTwEkuW8+SzSh6?=
 =?us-ascii?Q?ehaW5ISb7gap556trlHqXsdqA6Q+sJFHFINg9RXusM6SLSkrVNsRgi4Sfj/M?=
 =?us-ascii?Q?l+ZGyB3XgLd7FlcO/Zn/niDUt7J+G5VdlL5SIINVzmuooOyG8XJWjJMaCxrR?=
 =?us-ascii?Q?senIL1PmtUQM2p2WkN1p/C4tzcbfVCMBaCWZKhOI7Fm76jtFNGCd63Y/Kg26?=
 =?us-ascii?Q?oBGV69P5FmZYMUFKrM47Q9QT9sMY9E42htkySDZD53X6jq5i8BkhtZwSU7M6?=
 =?us-ascii?Q?oKH0DtubbsmAv46hHknKtZX4BLUAqUMAxHa6L1WL1hrZLUOyG236F0CdSvbo?=
 =?us-ascii?Q?tZOQmm3woG9Cn3cVepKkYBeRkZdmm5zJTIXN7XpLmXgpSXp/heGi6h9QaDbl?=
 =?us-ascii?Q?4IMa+LoOJstYP7trm+nXWJcqhVlX2TC10Mvp2ChOYMc0Du4C6ZHwaPSolmoW?=
 =?us-ascii?Q?9+gp2R8W4t9H14YfkFdPF2JDHsdxpe612WjR9kGHoHf29gaCTg1izaoWioiv?=
 =?us-ascii?Q?Tp/TLf/G+y0wVT5lAkFRBRDDn1ZKW79DGlLG6YVXTMLBRN2R5LyC8kStV8Ct?=
 =?us-ascii?Q?KbmmCvoMFMXVswrfTamuH3OH91tMzKW4+KgguOIYAus3gydw8wvrfJ7E1YKB?=
 =?us-ascii?Q?OE9DV1uhbYA+UvbdaSoAjPFl87EPi/Z7cJZeb5zxljTfXKPQwFSDpCZJlknG?=
 =?us-ascii?Q?7q0O1FlU5aw+6IKdeRsIsaWam6dB2FwpJTOokEJwOAno7UiT7q29OdzVcpdm?=
 =?us-ascii?Q?pKTHS86rOQhwyYKPPK+5cpwMDCBgWFxylQ7+lAwOeLXkCJmL1HCVUxdEuvsO?=
 =?us-ascii?Q?GOh8rjco2HMmGd9q/XNFBmjGj6fQAeelmRTMWU3V/c5JuE2FnMD21BUsjkGu?=
 =?us-ascii?Q?cY7vHSwfZ0Gwg9Xea7iyJfuI+4CdqEgfmPQCeJIRIELlE7+FEDlsMHxQe9dB?=
 =?us-ascii?Q?Sv+ycsXo1/dIe8KDyEKFtUEew0yTuXHP0Z6Xiet7nmQoM72dQ6xxACbGaBol?=
 =?us-ascii?Q?JXPlsEvmy+z+eZbG/FFEBVRr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce464255-263d-4dfd-accc-08d93edcf399
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2021 11:14:55.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqcJASGPAcmRh0inuZ96VavwFpIRsL6XDzGR6CG1VOYGTOZHxfXvauwvsDMXOeYR/64E789SFdjP4aAuUZGzPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4240
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10034 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040071
X-Proofpoint-GUID: 5VzalR5Vhn12ap57IXBeEXMKCXKYw2oH
X-Proofpoint-ORIG-GUID: 5VzalR5Vhn12ap57IXBeEXMKCXKYw2oH
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A fstrim on a degraded raid1 can trigger the following null pointer
dereference:

BTRFS info (device loop0): allowing degraded mounts
BTRFS info (device loop0): disk space caching is enabled
BTRFS info (device loop0): has skinny extents
BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
BTRFS info (device loop0): enabling ssd optimizations
BUG: kernel NULL pointer dereference, address: 0000000000000620
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 4574 Comm: fstrim Not tainted 5.13.0-rc7+ #31
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
RIP: 0010:btrfs_trim_fs+0x199/0x4a0 [btrfs]
Code: 24 10 65 4c 8b 34 25 00 70 01 00 48 c7 44 24 38 00 00 10 00 48 8b 45 50 48 c7 44 24 40 00 00 00 00 48 c7 44 24 30 00 00 00 00 <48> 8b 80 20 06 00 00 48 8b 80 90 00 00 00 48 8b 40 68 f6 c4 01 0f
RSP: 0018:ffff959541797d28 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff946f84eca508 RCX: a7a67937adff8608
RDX: ffff946e8122d000 RSI: 0000000000000000 RDI: ffffffffc02fdbf0
RBP: ffff946ea4615000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffff946e8122d960 R12: 0000000000000000
R13: ffff959541797db8 R14: ffff946e8122d000 R15: ffff959541797db8
FS:  00007f55917a5080(0000) GS:ffff946f9bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000620 CR3: 000000002d2c8001 CR4: 00000000000706f0
Call Trace:
btrfs_ioctl_fitrim+0x167/0x260 [btrfs]
btrfs_ioctl+0x1c00/0x2fe0 [btrfs]
? selinux_file_ioctl+0x140/0x240
? syscall_trace_enter.constprop.0+0x188/0x240
? __x64_sys_ioctl+0x83/0xb0
__x64_sys_ioctl+0x83/0xb0
do_syscall_64+0x40/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xae

Reproducer:

  Create raid1 btrfs:
	mkfs.btrfs -fq -draid1 -mraid1 /dev/loop0 /dev/loop1
	mount /dev/loop0 /btrfs

  Create some data:
	_sysbench prepare /btrfs 10 2g 6

  Mount with one the device missing:
	umount /btrfs
	btrfs dev scan --forget
	mount -o degraded /dev/loop0 /btrfs

  Run fstrim:
	fstrim /btrfs

The reason is we call btrfs_trim_free_extents() for the missing device,
which uses device->bdev (NULL for missing device) to find if the device
supports discard.

Fix is to check if the device is missing before calling
btrfs_trim_free_extents().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d296483d148f..268ce58d4569 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6019,6 +6019,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	devices = &fs_info->fs_devices->devices;
 	list_for_each_entry(device, devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+			continue;
+
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
 		if (ret) {
 			dev_failed++;
-- 
2.31.1

