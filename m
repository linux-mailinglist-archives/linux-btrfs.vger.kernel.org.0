Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982E245314E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 12:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhKPLyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 06:54:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35176 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235566AbhKPLxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 06:53:55 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGBE4x6010322;
        Tue, 16 Nov 2021 11:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3o+Me+Z24bKy8rsesYIidVa/W0fg0Lz8f7dwUzEIZXk=;
 b=J4O61fcb37e8ki5C3AkAL+Qk+nVcdSSpYDUEyVynBSd+sXPOcm79y1o5lGHe6DQfOcWk
 MDIHFUG0tlWO6rnX5zHPuN+sDY6XD3dfmSgH40jDzWI3vXdlGPgYiwbtPb/5E3kR5eWN
 udNtRqfm6tqYlc9KzBrv5tQfEErZSZCYBEQDeXuRXdyUW/CsL4grF9/9SDztxctZi5wf
 gbxLe5zaZUibqNcPXSqBDdT5Cq06LfzJ090j79jGbpiNIOU61kliqNlCc12Fpe73pU2h
 xVfl/7UkcSn6H3p6ea5qnKggQTalok9OJXpusWM1ndLAUhH/45P8DjD6v75trmPBAlgo UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbfjxs926-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 11:50:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGBkCMJ167045;
        Tue, 16 Nov 2021 11:50:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3ca2fw2fnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 11:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzUFg6/qA994exAEiWbmHOCx0xGXShVDNP/UAKfTiU7gQcd/LrZNUHJSlwpuLPV/T8VvAGsxQdbkIYUChqflv9ifgvv75OiCRe/Yv8vz840cGG8F1s3YByy8p16qMhkonWGgDiQanWSmM9Y79jq7CDw6L7E3KeDF4cbas1vmcIWqVnqW/HPhZrxy+W8dIAqVInUZjkBWfViLlyT/G1PfFURDTgMZq+lS8PAs3MjFyvzrSeCO7AACS0MwDRiy6eZNhvvlaXz8aBzv9WxDgYcSMwLvJGbQ4hkHYg7ABRO47tm9cPddbhLcJ/57ooni1GMlFdTWnRtT3V8Ud7sTs+0HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o+Me+Z24bKy8rsesYIidVa/W0fg0Lz8f7dwUzEIZXk=;
 b=J66Uh3fcXOPvcXRJROBM8UHoKmeToLGw1Q46mtlFMflrUrqKs2kc1QqKZDU/Lv83NohCjImN/Ane+G0Sutz8mSMqmnzOXUC9+d18xA3Krzs4D88lNlyte/rOrn4PdmT1gLaD5hnB6wXvTCKJrvGR+iLrzLmdRJ5t65cnyBMxRbEPuwELCWWLGa5WldpC/rYkAXuME9Zke6+lIqGwJcjql3TFLizwPMIMkMPIJ2aKwzkaRknE32n47inSI4iTntvyAKVuXU8PC8lFqG/Nvn6rTDdeQ7+8dBMhlW1+K/8c0Wx79gyWgrhQRvAJo019ZBXMvy6jN8zs63rKbNCiHe2L0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o+Me+Z24bKy8rsesYIidVa/W0fg0Lz8f7dwUzEIZXk=;
 b=xLj49G2dzY/IwUzOr3HSqh6RiyjIi4LVzeDauTTfK2N3QYMF6wCIcjM2MR9RBAV/sEgmkrrgBduxAVO6vMpWjzHSdaQMEE6fe9DDFYDyieRmzyMEM0V4u2zMr87sSTdcCGJYaC66QPzyDuYN4FPSNZ5wYxI1Fllr2Nya3okZp68=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5851.namprd10.prod.outlook.com
 (2603:10b6:303:19b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 11:50:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 11:50:37 +0000
Date:   Tue, 16 Nov 2021 14:50:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: fix error pointer dereference in
 btrfs_ioctl_rm_dev_v2()
Message-ID: <20211116115025.GC11936@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0164.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:45::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 11:50:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b54bf5e-6632-4376-c769-08d9a8f74e7c
X-MS-TrafficTypeDiagnostic: MW5PR10MB5851:
X-Microsoft-Antispam-PRVS: <MW5PR10MB5851D28D7CE610047DE4247E8E999@MW5PR10MB5851.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpE6FjzeCIyjiOXZ9t0QLVFwDjaH0IroeBvxuyVGDyXWcoTQ8xE52TILp8nN6bVJCue/25vI7OtAFi4BaWwtC3RtW8CjKzZd8rmgCIZVu/uVHD1nbbwLnA5vzNP19ZzRhi1YBfHboeuBFhSPdLMixht5urTBhH5ker1nbMSKaVIrAIulubPzEYahC/N4wV+mWIpz18Y7i3+J8N2TNEr8Pjla53XmtFuI3Q9ZZFr5Tem/+duNHm4S0SlaqblKBRYCfV6qXVncn4Re+C3hkcYZonel2A70b/XtDHw6qTe5km/I1jCHiWIynvi9lbCVJDxf5OFvdTBzu5TtyHD5rVtCr68hDBZiRFtdzweh1+LMn/WaTWH6xdtpv618EWWsLprLOkuKzJT5Yzs+vtvK8ogH37cnt9rS+pXaQpZsku835wqOSBxOtfKg4AtAbhIOUTEhq2FHg1IiGW6r1nElWFXy7v+GPUdPZk1RBbi1yf6OjNe4VkqwklnjL1ZUJbiYwfp+hHXLyRMDbEvk5KBuip9PPd8fmExs4px8c+OVDHGf1BhgJPtkYB/bzSU3rH8Okcm5hkTdm63sYeXgg1EURq/0Z2A/LRIbQiOLLzzih/bYHZnhmYHN1saTLedK2LZSgyfeWoIfvE7feD2RH/nkyQ8f0WuGRTVKNUbOBKgGuPufxSCZdTstXj3nLoJ4i8i+KB6VuFh8bULiFstsden4aSGYcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(55016002)(508600001)(26005)(110136005)(4326008)(66946007)(86362001)(66476007)(66556008)(83380400001)(38100700002)(38350700002)(5660300002)(33656002)(6496006)(52116002)(9686003)(6666004)(8676002)(44832011)(2906002)(4744005)(33716001)(1076003)(8936002)(9576002)(316002)(54906003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wn3XSAmcpyxX4/PvlqM6Y3qtf0RPBsSbAkMoga6A00xuOCio8/ssBu3yi2OS?=
 =?us-ascii?Q?Y1eyYurVBxmHcPDlhTho/moSuN0E2QPy2NySrOEZq48KQDDFkITtnwhRMiTI?=
 =?us-ascii?Q?Ep7Um83KgQ/rPX19qzGZWpTYq+gJWcgCzS8qNjlRBJpJcRMCDw8Kcn54t0rg?=
 =?us-ascii?Q?RXp4clvGeWNV+nW6EMQOHuP00sip2HKUlcE7NfqF3mPHrd4EijAIiElWKKg6?=
 =?us-ascii?Q?BVvh0jOfYU95IzGWtlNU2e6YTuCLFF11jjuvNu/NaUzbauz/OscyHB8PkQpC?=
 =?us-ascii?Q?LIQqnjPiGMu7VAKr4SuGClFL8AhjFJgsScKygjnmn7saIVI0m5+qJjtCIJHx?=
 =?us-ascii?Q?NCgeYBRuqtOq8/qCfWI8LOSnJfYY0q/LvvopsPCGlpNIT4NAHicZA107EJNB?=
 =?us-ascii?Q?rbXpSYkeTEoF8QjBww0pHvMFXxf3iKw6RvTdUYjvgiqa2xg+RotlwVunVzRr?=
 =?us-ascii?Q?4TiHSZnxDa8oNRUYk4fXfBOR0RtVGJtHWyRTbFvUBe9LGUkBPmAnRrS11bUG?=
 =?us-ascii?Q?C9Kmt9CybvIU6Pvpp5EOLifaCpU/jB/HUo4oB81yJOh84pPlommOlZasQmeE?=
 =?us-ascii?Q?ag332TdPLakDo/+TDxcNwhaWps6xT/YNnwVbV+2YixaNNLEQJX6PdhmA3518?=
 =?us-ascii?Q?Y1uD2Bnc5BlprTKh6tz7k7P8Ab5GYJ4Mc8HCJX7Ptqw3H5n7EQW8KIFNour4?=
 =?us-ascii?Q?5nHcUmUS7pd60d1gHpWv2C6qjbbodFC/vhb04dWEjymt1bKqQy/r8hJyTK4s?=
 =?us-ascii?Q?l85qPFzSmOb4z31F2ge19/+fcmpqZqLAcfuIMPvRTbUsPvvPVcvXazF2yuTV?=
 =?us-ascii?Q?8ZayuPFody96kqloRpEFPN4CoZ8db5ExG5TMwtUy7MNyg8jAw5XkuHeQ2vig?=
 =?us-ascii?Q?SA0NcpjHV0N/GW9yil/TNvNCi8uaa83S/L/j4MmbM399Gk3TTY34jFPgWwHD?=
 =?us-ascii?Q?AZ7POkwNDdtkb8rZxGD/ZH7rgHjP7l8B9O8aDpagagNHuIEQjMFndeEXrvY2?=
 =?us-ascii?Q?LNhWgttLeG4ofnVfxnbMQo54vkIkjY8Pyt7zG0YLuJhKTzPRJbBi4jfP1NHo?=
 =?us-ascii?Q?SXs7ToGjxowzK2t3r+kJ2DzHrYo8uAzhWajIkRRY01DT3DhvfQesk5pNBewl?=
 =?us-ascii?Q?qrFA184JGQZn0szUKvY8R9arzcstUxrOLOPabj3P0yB62wUyrEUJmiUwVSkO?=
 =?us-ascii?Q?hCu7h5EgQYqYvFgi3p2TjJymhx++04hUDc+hotn4PSwRt7VYfRoRJ8t+QJmw?=
 =?us-ascii?Q?DqfCt6xNU76vupim2zUh51I8qs7vupODxCvMZzSvCdrfkjgoIUwSgGVt/gYN?=
 =?us-ascii?Q?jgtZ17L0+pEXYf59j+89anw01P/3/OSRgYRm7AQSOyU9unfSXPhwhPag7Sfx?=
 =?us-ascii?Q?JytwxkbIMGDhGueXeWwawx6+Pq6M4KuDILo50B07BkdVaS3kQAErdVE6PN+6?=
 =?us-ascii?Q?DUHfjR4tJ0IRSfu7DnAvYnuDAGeN+9kpbsZEcvv3aycRZbo2eXCPGr2pduep?=
 =?us-ascii?Q?Im7n8NpMTyuJ190zPnlyqGAgPvTiFXvVq/u//QklXR6Ed9fazEnzxiQEiHHr?=
 =?us-ascii?Q?9bwecfa346998Pd0A7qyFksuInL6ZrIpVak0lbcsYpgiSkFB/Se5shDaVchD?=
 =?us-ascii?Q?KpbOkv+iI17c3x9lLcdGItUF3nTYBoiO98bNVJhPec0upHkkJ7ed0SCpTCcj?=
 =?us-ascii?Q?5ECd0os7pXU359eUApdOgKFxu2A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b54bf5e-6632-4376-c769-08d9a8f74e7c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 11:50:37.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOwHg67YHbPgqFfpoLWB0q+gheaP1Gar7HK5/s0qIRCVwbEPcE1PtqdBB4KQNpnYu2ElWeb1emaaTR1u8TjoKyKCr7dSy1bEykv/Qu37ckY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5851
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160060
X-Proofpoint-ORIG-GUID: RJFi2VLF7dZm6lcQWWU66l7n467wysUW
X-Proofpoint-GUID: RJFi2VLF7dZm6lcQWWU66l7n467wysUW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If memdup_user() fails the error handing will crash when it tries
to kfree() an error pointer.  Just return directly because there is
no cleanup required.

Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/ioctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fb8cc9642ac4..32df384b40c8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3187,10 +3187,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		return -EPERM;
 
 	vol_args = memdup_user(arg, sizeof(*vol_args));
-	if (IS_ERR(vol_args)) {
-		ret = PTR_ERR(vol_args);
-		goto out;
-	}
+	if (IS_ERR(vol_args))
+		return PTR_ERR(vol_args);
 
 	if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
 		ret = -EOPNOTSUPP;
-- 
2.20.1

