Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776E74345C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTHTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 03:19:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54218 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhJTHTX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 03:19:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5Z00j024884;
        Wed, 20 Oct 2021 07:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mQHyrjrv9ML87p9rfN6q+U4rYdWbsZgjBLd9W9kBnYA=;
 b=Pw/NePFWbCiSR5owEiQcnjYrsfJatxpF7+fOoB72PBHyHbA8rY2jycmgHzrC8knfzPkw
 A4ytY5ot4DhjPO0kU2LtZdRU6mXnE5jSiVoMJABgveGNjINYrmGnd0eDuCaVOXIFb0or
 gWHxW4ztDY7DaRn06rJTNUKTiSbF3AFhCCK6YwpWyzHFXZeQv/SupSjUSH0b6xZ30eD1
 tFC4cK+BDr2lA8uDZKa5DCtHZ9wfNTdf+F/ou6/w/rlkTKfee+NYsIqhZU3r8zzByHTj
 WxoOC/b+KqfnsT9L3ZH6VqzzSjDJsh1TzejkLlv/dLYLOP7qxumsquqJBZUYfHSy3uzu Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsn7kq81c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K7BB2c102202;
        Wed, 20 Oct 2021 07:17:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3020.oracle.com with ESMTP id 3bqpj6mpwu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocso/ByjMTVhwF1UndjgIXVyuRSMweDedL1UeISaxSnOiKVKRDDdqeJKS8QmadVVe3MvLZJnV6mqKmxVXeaQzx6FL1FCZXISUpGdfMAbzUvVhgIvF7gexi/xHCrZaqM8RQ9iXqajYYIQC3DLJ15C9qSgBDoeAPAoieoluqPnHWjNHMukMD4Cis2V1b2vx6HzBWxVrxIZ6y8tmWw8rroaVYowdZq5wm6d5wPOkCzy2u4TZIAjCHQx5zpl17ViYoMUijBRPDV5J5xdfEyGzGmgiL/eUe2VS1GFNnfk12/+fLhk8L2dncvNlbNplg5dKxpmPrt6NymMQaQ7eS6lMM1faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQHyrjrv9ML87p9rfN6q+U4rYdWbsZgjBLd9W9kBnYA=;
 b=antANQfu47T0evxEuWdaO3qO68NnuZ7spkBSRTaavq0zqADkY/QqlCNxXKzQHEUDM7mSDlTCDZnPOoG8ktIHu4pLnp3EJWIBJMQhwyNtYxLNbKM9gBkyFjfrXsFYVBkhKcRhmQszQEMW6HQRtlGQeiFeW/ldtXD+AYEf9xGBpQpWG2609ZqNjRNJiJ5QzpdmfdwSvmbefe1raCkURNvVQxgsPvfyhqzZ45clRt1FI3FGOZUmbql4QPww7mFeujxK0u9skZ7M5CLACFM00RNqL0PiKzP+SBYXC7I/r3nrI6snYXYhRbhZ72Y1T5gBxdR9q+8pOBsra2YmjQFdtxHYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQHyrjrv9ML87p9rfN6q+U4rYdWbsZgjBLd9W9kBnYA=;
 b=OWH+gVOCi1JBN0rrqfeRpZzyXiAPxAU+Tc6cMSILxAiH8CrCDIALcVz8OqYagsEKuSSEwiVid+zJXskr2P1CB7kdbfuPTczrzeiwCSO/GBspiCTQl6CkEjP9PVnCYWwdkcnMePD1zArPWjzzIjZRedfWOgBS6khpNeuCXqnUPi4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 07:17:02 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:17:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH 1/3] common/btrfs: add _require_btrfs_sysfs_fsid helper
Date:   Wed, 20 Oct 2021 15:16:42 +0800
Message-Id: <a256725f520c555f3b6295e09f70ceabddd69288.1634713680.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634713680.git.anand.jain@oracle.com>
References: <cover.1634713680.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0044.apcprd01.prod.exchangelabs.com (2603:1096:4:193::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 07:17:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4036fc17-6028-4a7e-0664-08d993999ced
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40945297E5EB2751C63BA99BE5BE9@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zshVAPFKgG2Yu0EQiztYfAO5036RFPSsjcNn1QvhpLHBJi4PN0XKbhPh2DJx17nxjzFgMHD1oM86FYJLCcvhXhAdfzN2IFjoNiHYhhRs/thjDSbKWVM3VAgFNu7y6HpP9KrI6/DGv72/tvXYzQI8B/r6YIPeQ5TVxXEVFxUHQMDNaiAs31u14VngPL7Xujs4IAUNVoAturtOqU/X+DNM1gwn0IpH4cyIQ3amTCrbIbq/Cky78uiY0uWyq2QiZveIjF0VwveQ7BLfn6EmfsIhIGnVjCFuG2ResrHZuRONpBjfga6/s+uWeisnKI8yG4YJF3DTl9nFz/Axr54RtH/L098Udjdf9VyuJKf0sCndcFwYv3E7tl72zXyISmNQglObTRuTAzKb9Pk7tNX9LYGT4zZsCv639FwNgk8iuR2NeYA2xvP3DUErvuh2uTS6ofcPu3yo81zNz/+Kb1PJLEGJ1GsUFINJTGSUvS2JuEbaSk7kewL+7dbQU9N7dSnwFNLMLouNM5NyTBCzekSSwgXvx3yp3H/y5FSAIV/06Lp8LkvP9k/GpR1beOoikjF0OA+XT6OvO+6tJlO08svw2xwbplKDiFKFsfAVaWU+fH/7CqghJzLHmYjuLwGb42yIEvwf4b88I1fRYyKzhJ7TekqvIhKRz6eqNEU3xeIoKbmFnP0UZavfoi57al7f9t0Hq2Xd4IgV0CXFOg27J0VFx4733g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6916009)(66476007)(86362001)(508600001)(38350700002)(26005)(6666004)(66556008)(2616005)(8936002)(4744005)(44832011)(4326008)(36756003)(6512007)(38100700002)(5660300002)(956004)(6486002)(2906002)(316002)(52116002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrf2AKkjsZ4jQge2Zp8k+cQ8k8ZMWFwYu0mwQ9/hxqF8oWMkwZIJw2rxUQo7?=
 =?us-ascii?Q?yhfWrYxQDl8M07cWVLNZw5zgk8i8xaZNzw3JEnjNXZUk3jkVETeE1y0dAIkm?=
 =?us-ascii?Q?WIiUOlQk/3Q+QkJ4mYAx0CpZ2app1pQbmgvUFTyY8B8tsgx/HhGH9lOlxuga?=
 =?us-ascii?Q?4EshvIGZBRJ24C0wk3H1P7ihOgtcigX1SYgFgDXYhse9axs7TRknikQimxkE?=
 =?us-ascii?Q?TCZyLyWwPccg1bDOvHRt7T3VadAFzn02aY1FdTDtVPoCayhAS4rzAoCxN4ct?=
 =?us-ascii?Q?+mZH3QO6jDqNE5unuVo3km44i6fxarHQGJ4YXwtBeRRuXbuq9PKRwDRQOpcO?=
 =?us-ascii?Q?P8U2Ie0VwrFb0KYqYBD1fnYPKGk8FqeD/OHCdAhsyTjG/rZvBINulJ1elFTC?=
 =?us-ascii?Q?qERMKxy+jEH/jjCgN4MGCiVu5+WBE6SR90HSAuoaR4RQfziizdMlsJ18hNcF?=
 =?us-ascii?Q?2d+1jhnC2YDyupzxEKs9v5qlpULQwaQba2QCMvFORni82qh7AfNKIU038POZ?=
 =?us-ascii?Q?8aMxpQ+BnhJ4acsLuncjmLNQgjG1zIJFf96LnSXnWC5zkc76dpZqTAxQkWC7?=
 =?us-ascii?Q?MfLZuuYGdxATEqybgb1xWVq4eumw0su8bc6Z09gnKmUlnFeEStNOxIS+xSOp?=
 =?us-ascii?Q?4bv2DfPh65mhxozYoFy0PKm06F/am+FtlBFKSAxxDeJ0p/ZNBKCC+gpMl9n5?=
 =?us-ascii?Q?lcxBxFu+7Q1c8cwePMCMB0zrVt46HxOD6xllP19OI2P7CVFJbapB1qKsRapq?=
 =?us-ascii?Q?MyAYgiQ2T3U2UW0qAVfcD4/HyIFknj12SHyJ9BPmbHrMWnpABBfmXgHwM7Xf?=
 =?us-ascii?Q?/WinnInBWc6NkV6i6eQTxu9zNwz7w7440H8M/Ep2LiEoAz/0iyW3ZC1CwbRi?=
 =?us-ascii?Q?qhF6jXEP62X+NzS826dbpRH69eWgqSIMk+8CU34JEMdQ/ehfiWkK7uYsh7ow?=
 =?us-ascii?Q?z6y/81IkmxqZKTwGPC8STDyxkMBhpqU/8yFHMxX6tcJf5nvhiessMiyGWtIm?=
 =?us-ascii?Q?GIvYCh5R40DL0z2esVIvrbJqzMEheO4pV4jRlwc+050EFksT0H0lt7YbKqN3?=
 =?us-ascii?Q?7bjw94aMNkCp4fKP1OCsvQJexd5l91DFb8WY58v86wP+gbF+XgTIRcXJNaLe?=
 =?us-ascii?Q?nOfo20sVL6Bf6Vy4nEUwvWaDixTnuVc+4a11rT1YNTVUO1zUVJLxzROUtg3c?=
 =?us-ascii?Q?QRhAoO5huNnozIDHyhsuOmfMorbhjRDInei/CWayB5hD10PkkrvVoM3S5A13?=
 =?us-ascii?Q?Lwknvk0WQeYKBQuJIhfPixODpaOlYSJ7X0J9+H+zDgu8J5QZnzcKHq+ad3Io?=
 =?us-ascii?Q?QaOaWUYHpzN3Ef9evWBS7W90?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4036fc17-6028-4a7e-0664-08d993999ced
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:17:02.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200039
X-Proofpoint-ORIG-GUID: 7Q9BYZvRazvvExmzIjI1BeD3wvkFY8CO
X-Proofpoint-GUID: 7Q9BYZvRazvvExmzIjI1BeD3wvkFY8CO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It checks if the kernel has the following patch
 btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
that added sysfs interface to get fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index ac880bddf524..5d938c19b56a 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -445,3 +445,17 @@ _scratch_btrfs_is_zoned()
 	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
 	return 1
 }
+
+_require_btrfs_sysfs_fsid()
+{
+	local fsid
+
+	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR |grep uuid: |\
+	       awk '{print $NF}')
+
+	# Check if the kernel has sysfs fsid support.
+	# Following kernel patch adds it:
+	#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
+	test -f /sys/fs/btrfs/$fsid/devinfo/1/fsid ||\
+		_notrun "Need btrfs sysfs fsid support"
+}
-- 
2.27.0

