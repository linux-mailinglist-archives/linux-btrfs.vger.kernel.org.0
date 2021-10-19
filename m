Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC234432B28
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 02:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhJSAYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 20:24:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30196 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhJSAYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 20:24:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19INEnmI004583;
        Tue, 19 Oct 2021 00:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=+/y7x8Ybw5l5XsjmZa1KhX/ZUCuGYcNATG7u3uXFr0c=;
 b=HpbIu2MRLTSBiStzx8CDI1rIXBBTwTpV0Et9B9ySFKXaAE4EVxMrm2sUyCWqWS3afDju
 E/2m1wkcF+ARPPaLzYWxipP7W9bfVUgJHmqptC7W0Qv9fcJ/x2lqTbo+OL/wkVGYQInV
 0PAyCD/5nl/eDkj7I72oO3/wD4zcwoHy13lvkAt9NnDOSEoBX0Ve0hJWBup78A5XE3e4
 ny2FtKxrRgGZxnKv41APWXO4wrkqJxGyjOUGHEGLSe23nrqC0MTC7C//6SwFMfElz3qt
 DO731UqvFhPtK4hcq4tHqStPuB/+aef70ev5cDJOJG588gRwT2z3pA4+Cni5MfHy9Eqv 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brnnnfe7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 00:22:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19J0FUNs102171;
        Tue, 19 Oct 2021 00:22:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 3br8grex26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 00:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1vX34D0UscIFgWMPQmEyW+z7ZiQh5jNEo3C3jz1pc3xZmRNM0goh5ZDOICfCvDVO3zN0II4AKSIH7/oY4zV5S/o4B1fv7lb+l500XTbNZI8xfK626fvF5rRwYgY4BVUHJxTgvKAzuzjwlZJtVL+JrlpBSFVGt4doItEZ7XBNW9mlNtfmM1pDgBIgUYTvwfB6SS/+PLS8j8X+BaQezulBCqNPwW96TWpec1X5CPBAWXwFAGsIHU+Xv35fkzvSa+yby1dLEZFVC065+s2Pu7cswhnJPhPzFwEzybNqQqHQts4QvLpJIXIaVAIzbYJyi3x+dtXGOBwhuilAf5hnPshMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/y7x8Ybw5l5XsjmZa1KhX/ZUCuGYcNATG7u3uXFr0c=;
 b=giwv29HPMwtTtV7IgUYnYzDPe3V21Uz1stmA6H5vIKhAalvp9kTvFIk5jFiATKYDRNyNKwJHGhQ8C99vfEaNU4AY/0vST0ja6leXfw6NFVQkx3meclTPeGodXiKEByi3AVg07BApqlw+PN+n4ZqY1oQkedHmi3DG+lJBkzvvqyxHhDbRNXFhD6bsEmgPPn3xnShUcNS0f1/7CYAgjCCextDJq1+fXQb4VzdZp4rPv66zAMpnUR/qL2vohez6fs0bCKSCG+0KqNTfgtEJh0HgmZSecLJqyZPpVyt0W6nDd+qbr5NsE9qsO5+KJgvKWWx59IATrMaffV5Vt8DJqUJ7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/y7x8Ybw5l5XsjmZa1KhX/ZUCuGYcNATG7u3uXFr0c=;
 b=qz6clV4snJ5hxCX0tHMxhYfgvjsEmCbJYIeZ3tQMLAAVJyXCwoPAXMZVeYPWRi/WQpLJbgZmmnCRIKC6kLpcuYkC2p/YzkfYGLly7zUjMx18hqfBsy3zMe55DPj8XRng4v7IpAn89c08e5glJSPqEIxIDmA21L1k6XryIP24d14=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3920.namprd10.prod.outlook.com (2603:10b6:208:1bc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 00:22:27 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 00:22:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH 0/2] provide fsid in sysfs devinfo
Date:   Tue, 19 Oct 2021 08:22:08 +0800
Message-Id: <cover.1634598572.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:196::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 00:22:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e256637f-b9b0-4a95-7aca-08d992968786
X-MS-TrafficTypeDiagnostic: MN2PR10MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39205D80908CF4E4AFF8C9A3E5BD9@MN2PR10MB3920.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tndmrwFHnXNO+tktcL9/RIkh1zQVcl7GhSbQ0x/AhAD+g31227litkJTIRt2B5OXvnCnCFRZdfwa3YOM/kzAFMSUFLyXByPlh9pZFYqAaQSvOZdKtt8/x2LeKo39Q1gUQPIuX7F6kmTKeGLDajsEF9AoQJsj+klBK8F4+TYIR6wcsSlvJSXj2DU7LEiJnU3hrqGR8cU3nGPmcfPtFMp2bDnnr1lsqatOIHFRmg5Xdd3PA7dnImCq4SfbKKcimPnYO8K+OfnkinVEukKKZwGU57pGJtYKM1UNN1jSaDQIfJwGLLUEnWaQWujO0eHcLSzGD6Qir/UKNPxp46cfsqKVcSiSPi10lAhTt5e6pt5xW9+w72+JReXbGg7+BmCN9aWcmhz2q6I/0DPIfUDD5+iDfFwVl5IuJJsgByYoRYokMOc3Prl7a4lOooZ2r62M1/2vtuXqDsCLoJuUepBrXSNU7J/oL8PlXpyJuntErBNS+BNss3Z4CvjEjJlap4faIhAd/pFR7j4Hv2X/a/DuPaIkhyEUWxGPshgJoEWClIPWNAFTEN5FBIhFiGJVfuBTFoMu8+/mP7UrNyEpn6FeqSwIs6N3Zne4ItphqS/olVnaTPqle7toCf9xf/74/n8phbiOBUneq7t+LyFbpJT/sbd5pcEnWi/H/Eh9LWJed0BhI8gl8pPLi6kgwapPuDBSKxHX6ho8HnOJPZUU2SWO9Mblg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66946007)(26005)(508600001)(86362001)(66556008)(52116002)(6486002)(6506007)(186003)(8676002)(66476007)(83380400001)(36756003)(2906002)(6666004)(316002)(6512007)(38350700002)(2616005)(38100700002)(5660300002)(44832011)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QxeMVyE1kqnhLth686LGsgADUpSQqbTGBESNmMnoOTM4vG+O36MV+rs82ZsQ?=
 =?us-ascii?Q?hO/5jED51BWiew1BkMNVF6NnGAwp+zz0V3mEXZRH2xT9EKYzx84Hij6bTKgY?=
 =?us-ascii?Q?uOw5/Q/0YEoXD3AL0BwKiNmAZOUxhWNpWCV/uSJs0vZs9twVw4evCVcmxrYp?=
 =?us-ascii?Q?W9ohbSUaQJQbudyIuwujMxkkrPCVqOxKr+NnlYL6XTQePLbfab1bu9ee9tmy?=
 =?us-ascii?Q?gJjeJ5LZMu1Kf8K+mGIAMfxhlEi+4O0PzhhhZxnUfzzruEdcaMHuLw9dTQKA?=
 =?us-ascii?Q?Qks2+fAFbIRr+aX8FJWzEu3Rj9m+NvabbjFvxprsHtAdv4YXkrE99RaxevA8?=
 =?us-ascii?Q?nfnEMG52lV222pTODrpBEo0JqJiSoZb8ZSwcYGaTNFYvoSX/krd2kCS/2mhL?=
 =?us-ascii?Q?PPY/wfMEEozGJ9Hf++T1CwMCX1lTBteOjLs+/ctSfjvusr+uPip1GJTrS1DT?=
 =?us-ascii?Q?Ik6rTkEpKruiQeRjZa1PZ+Rhw+BxsELb9TmcedHf1AaLzuBUltJtwUX7WSX2?=
 =?us-ascii?Q?3n+loUjGXUhTYa8xREul2cii6OoTeJ5mYUJRqUQAAFEy1ePXWBRmiqg2JDOk?=
 =?us-ascii?Q?TkMYAnle5TJ+td3DczQXofKUr/bHPr3QPQincyljMEJWNQO/3Zml9rRz/2vO?=
 =?us-ascii?Q?DpBKrVZxpnKkzyg7Zkgsj/j1TELdLL4Ja5w8yU8OS3G3y58LrCbGEXyZziOz?=
 =?us-ascii?Q?Pj8ClEboHS7+RbIv4k/RWrGhB8EzBVgj41fGMEQ0YSs64/VS4/PWbfi3e67Y?=
 =?us-ascii?Q?1dmps6BM/AktoyRPcW/P1MrIRL+KYig/m0sqf9hPnIIOdKjRCNV9jceET2ZM?=
 =?us-ascii?Q?1JeBEXuh22KfYOk8ZFqcZodY5zMZfmhX40UYQvbFsSMX9J2AkQ1KYzBOt+Pm?=
 =?us-ascii?Q?ACU0jIzhYiXvZ4vSegal7DyfVptGUq6MKm8NJrP9FdGEvQCwbTbXMGbZQWnC?=
 =?us-ascii?Q?xLmonsa6Srnd8l/XAz2nzmGSHj+jTaefdvJfcRhzI6ZADoRbVVg6d5pUoDjf?=
 =?us-ascii?Q?E1S3Vsmf+HTGbnsLYmT1t5HUNFqXJMZYXoxvtQteamKgymJRp2U/gKSeC9JB?=
 =?us-ascii?Q?WHXlSUHQ+umEwEPQ8eNoFY0gs7XGYn0WneC8REaO4DVnzwWeU2eRKE3LyYQt?=
 =?us-ascii?Q?dYWPp5zZVaTUaBXlQGA83BRHKlGfnmlUeUKFeVUC/4ewbLAPK6C2szaNraEg?=
 =?us-ascii?Q?c/t77xxeWL7EjpQ6LxzMnmmZEt8NVMnwkNuGVsa702DydtkOU/jEfu5ptBjd?=
 =?us-ascii?Q?oFgGCOBzLufDLIohZxduR0UJsoXjfS3IjDGDXd6po7as1osPDsyrissJ02WC?=
 =?us-ascii?Q?B1kiC6Acwc/9AOuUIczf5Vtg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e256637f-b9b0-4a95-7aca-08d992968786
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 00:22:26.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMxLhXlf9WJ+2egRdOHOtdAFvURA6SWN7HtLWw7GA7CY21L9UlZumXWsj4p6l/2CKneLkW1irZ6GbWKCEyY2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=777 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190000
X-Proofpoint-ORIG-GUID: rhWvGcV02LCqRr-gpomHui_Zu7axs-_N
X-Proofpoint-GUID: rhWvGcV02LCqRr-gpomHui_Zu7axs-_N
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs tries to read the fsid from the super-block for a missing
device and, it fails. It needs to find out if the device is a seed
device. It does it by comparing the device's fsid with the fsid of the
mounted filesystem. To help this scenario introduce a new sysfs file to
read the fsid from the kernel.
     /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid

Patch 1 is a cleanup converts scnprtin()f and snprintf() to sysfs_emit()
Patch 2 introduces the new sysfs interface as above

The other implementation choice is to add another parameter to the
struct btrfs_ioctl_dev_info_args and use BTRFS_IOC_DEV_INFO ioctl. But
then backward kernel compatibility with the newer btrfs-progs is more
complicated. If needed, we can add that too.

Related btrfs-progs patches:
  btrfs-progs: prepare helper device_is_seed
  btrfs-progs: read fsid from the sysfs in device_is_seed

Anand Jain (2):
  btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit
  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device

 fs/btrfs/sysfs.c | 113 +++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 53 deletions(-)

-- 
2.31.1

