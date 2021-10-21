Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2E435DC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhJUJTs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 05:19:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35254 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhJUJTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 05:19:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L93ekc013134;
        Thu, 21 Oct 2021 09:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VCx+o4cEtpdyXBQQAtUbdF5IX6hl4POQ+/uhnUlxctw=;
 b=e8KVFCn12A9odC+8q3tEV/byvP2Q0OZoNGvf2BoQMC/IkJKWnkNarvKMn3f5zH1Noypo
 Td+9ofsZZkzb5AzgH1UEOH8s9U85afPsqXcHZiHcoS/le5f6PD90X1UyOhZq2hJAXjZ7
 chyj/UO1HWiAcQOpPb1ZIah+oNrpUlzvhEoJe4jUDFVIcZZXki2uqpILtGkk2XImPfUB
 Vs3QPKyyBLSdFB8Vly16s0KpAVgonVcfLQARagV0cNlcmHdbreKBz7A1lffmi0CqL86V
 ztw+iQE++/jvQKMM87pStnomOHdFL8nJFzU3DA1MesjEKuJ7UXVb7zvSd9UlmHZcPSWo Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkx9wkw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L9AsAi010104;
        Thu, 21 Oct 2021 09:17:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by aserp3030.oracle.com with ESMTP id 3bqmsht9qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc3DFkNtxxNt2/aPAat7Q9MBpgUCz7F/qgtHyDIUCtEL7FUyqxPt9Uo69pdZxmWSv9fmTGUuPIDjaaaTVk1TN+ddf0lxFku2TA+BctTc7HKQNcMbdAarNAYgdMK8VIyDsfczQtXhyxbVWWxH+r55OnrPXcbg+Awywo1xT0RhjjC+SQyb2GDntH5Hn1wixaeomc/MvtLeg9HzUMh+dmMb7eozVWUp9WIIbLSK9wYffiPCusOWLFx+6bIdPMC25ChtxV5HMFHSx84jKY8PFcZUpTYg8708sRttVEJZM0n73P/b5uMn9rlby0K4hnuUKv5k4QNHOiBTm2KhfRqvZDHBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCx+o4cEtpdyXBQQAtUbdF5IX6hl4POQ+/uhnUlxctw=;
 b=AvT6VriwLYBY4vFHB6N/GMIjOfg/QGPbrIFlePCg/0U06hhbKAAe5SAWkFpCxPg0ePSlPBd6b7iQcCAbVlYu28mNoN9EFqfxNK6cZ7dZsQuib/Dlat1+SNv8FF0wNyaMyvJHa/NKXhlW8NjKEI+tYM9USK6MnWJidG1s8IlT/lEVb9Jp8anoz0KR1NzXiAHex085U4nNdYKoXT/RSoi4QpAWwpUCxoFE67tbYJccdwm32FoODJ9PXQ7KQHbKeWqZVHI4TcrkvPxwBNQfvnov1Fl5Jlvu5BomRpdPaSI6p4/Q0THrpQf2wQ/KOVAf5UxOI1YfH1/3VCdPjggycn6bhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCx+o4cEtpdyXBQQAtUbdF5IX6hl4POQ+/uhnUlxctw=;
 b=aGABcoi8cbu4GONfgmmFz6Pv2nYHGrg6JbAXAu8/6SRwsEOhQmIsSFQXNvQ25BB3hwiokvzMcVfyBB/MyowyMoJzRbIDEZh4wdtT5xRVIbKyWX5AGFcPgcQH4v9+pdBkkBsmkz4WFbeQuHEJtyChbAb1QqGVco4vUAHjtzwq8ik=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 09:17:23 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 09:17:23 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH v2 0/3] fstests: btrfs validate sysfs fsid and usage
Date:   Thu, 21 Oct 2021 17:17:03 +0800
Message-Id: <cover.1634807378.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend Transport; Thu, 21 Oct 2021 09:17:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1868097c-34b1-400c-f6cf-08d99473974b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4287:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4287AEDEEAE7A777EE09F407E5BF9@MN2PR10MB4287.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFodMVKdP8RbGugTAgodG3XYBAcB5y2ApLwdErjdGF8Wcb3NENq79mNBr9UG3E1BpjNHm7tXXdBCbrR0u9oxYzDppx0gIqdyBiOqB8eBjsLTwUJIgQQJyD2fgwLnp3Qo+m4B3j66M2XVaW0s9gCesgnmFOPSYKLYGslGGZSm7AJUyXxSbQF6+DtvZHDIrSsetBYdC7cG+fCSXeFYxU4aZAudy+iLCtzmY0Bn99bsoENaUIRopV8NE0U4F4h4YIVkkkIzdd+AOe6sHQfpRvwEnmrJIGVgnpW6X7QKFOcFr2LnffuJNS4SrB248GY0nJF0ChShgRZNVxTivDyiH8Ica2gABDnTSgVYwUR8gE14LAjHW6rjIOfo7lBNzB0wuPULpAKevLizGmXP2OO1LRYGKe7bWGUuO2rr4tmFfCD9qJbTGd8151VmLs69Bnqv01pq2HdOU+R+mZGrOjvzihyh1fhZZB0b686cyoIyEOCC+aHPbB91XA3TUnc50E2iXr0foqdZgawflTewhNkQ++b/fW2KQ8yVLludqahn+kA5UYq5/zAGlfbPXcuS7zvqM1bWOo/KywaCAWqJ5/BVP5Wr8y0jFaNPkqBKr03EZoqWB0ZEA3ytSs4LP/YBJsQur7vtA8e5iuf5936AUToaopzqisyFMdBzCp/1q79TnjeaB44xPhDEJxXU4gE21zEXWoMO/Uaqq7A37Vla6Ahy5DLXAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(66946007)(508600001)(66476007)(38350700002)(186003)(36756003)(83380400001)(66556008)(15650500001)(5660300002)(8676002)(86362001)(6506007)(2906002)(4326008)(8936002)(6666004)(6512007)(316002)(2616005)(38100700002)(44832011)(26005)(6486002)(6916009)(4744005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ooi3kcNbFpWXwAJW1kut4zAATKAccrOYKj2+DvV5ZYgmmKFCRi+Nx9CT4c8i?=
 =?us-ascii?Q?He1Rsi9uSgXNAdHXByJuYFN+Llh24o2oFls8eiTPGPdbNKEfs0tmIh9IhjMx?=
 =?us-ascii?Q?i49zoRlkaYIWFrXxpSxSl4Gxh7LLa+ijmsrGiAq4PmIFJDxrC+8r0TIyAOsY?=
 =?us-ascii?Q?c7ZhVtLFBi16kOFLQvjAoiBY3VlQVsP6QHknSFKV7Zexsp88sW4SRkBrXRym?=
 =?us-ascii?Q?mdllqQzN2lgC3ZPniSgMDsx8oYMNZohwJPH8VS3tVJhiozGLTPmSUcECOkUe?=
 =?us-ascii?Q?18hHkHKDhj+/AdDpYT8vTIp8jApoXU2G0h4isYZqB6JCsIt5VD9iEg28F/42?=
 =?us-ascii?Q?YwIG/1oZP1GjNC1bx3gz5qFDXy8PtVnFXyeDHQn00trgovcPUKF01auSbmX+?=
 =?us-ascii?Q?iIHl2+aSCBj+FT+vS3sB2Ii214nZ2MUtQTr+W9VDLKSfwMXWfCWaJ4/F94sC?=
 =?us-ascii?Q?K/emagoDJ/I4UVW0NUGMYbP/ucNNYHzVxRpO8YHQsm8JQrnHJtBb1rn5amo+?=
 =?us-ascii?Q?GKHooxltR4nV0k7az2R+r381Q2fQH1eksTOPhTWxazqKMGIgbysAQ4GlZ5XW?=
 =?us-ascii?Q?58D6vaAPtzvBeLxuGpC1DvSZ+BiDkU15a9RePi9NdHWfZOw5nh/Ea9TUvn4J?=
 =?us-ascii?Q?H8fq9lovhkHO4P+8WWtmfDTU0NgG0y8QoA6m/49G8XwtjiSushXl7xpI106K?=
 =?us-ascii?Q?SsoIOKpIKxG5xKe094yH3H8m2ijbXBBkwA7xjT/OUoapyZixjdhe/c2BX0RS?=
 =?us-ascii?Q?aXJy0qbmZHTRU1DRS3ciXeDyWCwE1bV7GqCJYSuCvnXrUR9ICdvbqGY5zcf9?=
 =?us-ascii?Q?ejzV9uMBfcVEm3KkBIhIp534cwwaImP7kkFTJaoj97iG0Xm6NlIzXkOcnr2R?=
 =?us-ascii?Q?o6S7yjMrGGeJAegfk4KE3gkerdQDqzY4Rmna6xtRN5Hu+y3s8cI0ixNzMGaV?=
 =?us-ascii?Q?3XfOrwQHETL1eOWe0eFbTRjnB3kCn5+ckgICoEcyvoJHnOXWE86bUrVsfq4j?=
 =?us-ascii?Q?ZVJjT6ec3EgxiVQhtU2qvfyXGwz8N50cqvDKS6cMS7JOL4SvrIlUWoZk8oQ4?=
 =?us-ascii?Q?4vPJ0oT9KjiNZNQocbMKoYsUESDR97VrGg8OpL9y95i/bF/fYNpokldM/rJd?=
 =?us-ascii?Q?FPG3tOssiIEtiq7pD/xqhpzxwh9mRieSVQesFjsq5qjpVSaQ8rk/yXoA2jcM?=
 =?us-ascii?Q?sCacysXITsth3Esce2BN+U85MNbivHjv6dt9tj/tE9OZC4110yDBxinr6mFF?=
 =?us-ascii?Q?GLP8ZTPUglqjXtU+eYc75BChflBQHyDaBWqxpZ/sZTWwv6t5URl0OqNFl9OE?=
 =?us-ascii?Q?5EhoNUjpalExyTXKgNa8mukY/xgnxP4ZGnn1it/6UKwa1KaIIHcvLlwmAQgt?=
 =?us-ascii?Q?E39+jLii23bQ/on7O3DnBW6NUvphH1vG9PCTXu1B1z/7IGNQEMMAP/KLmwQP?=
 =?us-ascii?Q?k76FQ6rh+PR75svFGzs4clUiMgxSSH0/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1868097c-34b1-400c-f6cf-08d99473974b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:17:23.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=673 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210046
X-Proofpoint-ORIG-GUID: qG8-s5geI4QgR5mYbcfGHyJDeRsfG9u_
X-Proofpoint-GUID: qG8-s5geI4QgR5mYbcfGHyJDeRsfG9u_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
Add more debug log to the _fail per Josef's comment in patch 3.
Add Josef RB to all patches.

---- original cover letter ----
Patch 1 adds a helper to check if the kernel is latest enough to provide
the fsid from the sysfs.
Patch 2 validates the sysfs fsid against the fsid from the sb
Patch 3 is a test case to make sure if the btrfs filesystem usage is
successful on a sprout filesystem with a seed device missing.

Anand Jain (3):
  common/btrfs: add _require_btrfs_sysfs_fsid helper
  btrfs/248: validate sysfs fsid
  btrfs/249: test btrfs filesystem usage command on missing seed device

 common/btrfs        | 14 ++++++++++
 tests/btrfs/248     | 66 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/248.out |  2 ++
 tests/btrfs/249     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/249.out |  2 ++
 5 files changed, 151 insertions(+)
 create mode 100755 tests/btrfs/248
 create mode 100644 tests/btrfs/248.out
 create mode 100755 tests/btrfs/249
 create mode 100644 tests/btrfs/249.out

-- 
2.31.1
