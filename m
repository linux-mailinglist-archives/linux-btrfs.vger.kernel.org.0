Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBA727700
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjFHGCN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjFHGCM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:02:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1B1984
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:02:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357M8YRT001986
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NT0Mkltyxjhs+WiBu2arp+DNh30boxCweahITMuWCpw=;
 b=ELKLEP5HivWYqFX2LET8QXEpH9OfrQTPzh3cvQ98bk6Xzi2lRyf4CWDDaOiWKYSs1N0R
 xoUmgZ/AtuWLI+PSsLu/zNFDJ+zM02D9jvZ/IxPSmj5neYno5T5h/kzZIV2PqNSQVDdD
 uT9TPguswNO+RcMjyR0ttuIQXdggHjGu8gyl5ylYp7xZXpvkhI2tMh/Nb7jzTGuGCztG
 lS9AY9E2A/JiPCogJYrdWUMn4IvOpbfNRVfKwQqZ5VMrvWTgYjSrs7sWBAe9HdE9THAl
 0Otb33dxAFlfy9jAGE04xwTFTdErH6DuWkL4yfeOlVuYoA5T20YLkH4XqNyM6h0bzbMI qA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u3e8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:02:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3583M1Qk036875
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:02:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kntwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:02:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ad72i7urgtaAMpprQ1rTJpAYrKwlqlLFkh7PXOAu4bKG3LxdxVoYvxKHKExCmFJ09QbLLYW8uk27O8XFC555VZ38q/a3ifY/xnTIZzACSdt1G+7o3sX87H1SboGOI0VzhO0zBaULkHwjYoQEBR+oxJm0U5mR/rkwMcRAZhCLHbgXuuodijY5GzcvJSvmCrn9RRfZRYUYc3Lp5BaSS9KSTnl8KUN/VFkbk/Y772es3PF6mai0VLW4gB87UMJXfN/PkjPr8jJMsw5poacCwALh7XXbTc91AvkH71LzmXCZQ3Czxt/Ylpez14Y9mRErQQBEHyEycFT4Nk3s0w/ztIL4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT0Mkltyxjhs+WiBu2arp+DNh30boxCweahITMuWCpw=;
 b=QNEkJsEEYch1bEJkTzbZdfet0Vt33Ddqa5gZaTebShkdNYLahfd1pi2FG4h68ygPmew29y7xJ/9W3tnV3iy4ONYCKVaamH+oq+4Ep4D259KIKR6ShBOfycHol/5DPxnwKamsQFiKUyXhg3KScfGQ0CEzecyMERgcQQ4LgxBRQ14FxC64eUKgmZAYXF048VieBx2KB4Gy4pMCDkrrnVzveaJMLu0zFv0rsSGj6w7b5fbBD/tFmhqYfHCZ8V1S7m6bUE8w9ltXc02EUU8SCXV1goPedWwitYIHjD6Kf7nJXFRQsGCbonzA5hXEahWNEH2e50uxFvpsHk4/bd1tUKHq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT0Mkltyxjhs+WiBu2arp+DNh30boxCweahITMuWCpw=;
 b=qXl+B7+3vMYnDR44BlzBMEPUHBu1Ot3HDNj8u9ra0mo1eA2vf1JJ8fKS4NY+TOMUbq/E68pN03K7qLdy88YCqgFB3W27wjlyHyK6/MgyEy+PPajvYPNM5kW6GljRyYKEI+q4IYb8B1p1Ygm2ydZBEa1zogd088DHZLoZoR+p9Rs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:02:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:02:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 7/7] btrfs-progs: refactor check_where_mounted with noscan argument
Date:   Thu,  8 Jun 2023 14:01:04 +0800
Message-Id: <0a2e9bf9050a6fa5d24ef4a3dd7322c7f1d3a120.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686202417.git.anand.jain@oracle.com>
References: <cover.1686202417.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de79dbc-2f40-4987-d9f1-08db67e5e41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKf+6yXXsbSFHFTTZsnHhbEzCoC72sQnnv85B+K8li3T9xK+jTh0ydSWzgj/hKfa5LMlbviHeEk6TaU11VbocETgMNtQrorIm7sshEAE7EOWDg7uel2PBDksm4LsmTm+xxtgw6iIn1gqtzYstBaGad4BDQPNpIS0zsSmGKwymfiHZ7vFmlMjvUeiyxrvxuM9jj4AdLhmdzRCW86hgX3IKK6BxlwsdEB74lEQORyaaoKsrwKq+VtCGC8vqYd7ZcF0dtmHnWgz1VrzVVJ4Gf1OjoW9cTCFsy4GAy2rK9eDrA5MF1+oWSpsF2oy78+NChgNHiGm8gEtvAZ/JdGQuxVAUGdtNG48Tj4wMBDM8y6i7NZISpDcfvrZ9zMoBD8GrqzK2upgARccMh8LxiB9dXWyTUHtUkcS/2k8GH2nhJkQVI2LJG4rYr1Etf3mtpUDOTUPcvfTQGL3vJKCPfmEvsVKPf8xjqv+4dVdQG1YVvjD2qsWIneM9yFH3HGNtc17BKrLMWv3VvFh5/cxhvkhVZHjldGlFACo0yysjB9wHvK7EKQZ0eqZsr0zVbDbKAVB9VIr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IbB7gsj15YSI99sb7EfxT1vA5TAE7kL153emzbxp0ZEhEqcIiFNhxD8Mznhz?=
 =?us-ascii?Q?kFu0a/yKDH7mnPYhzkqKEpF+ARZjNcW855mQe6Cd3p0G8ljS7wxMCUOvgPXB?=
 =?us-ascii?Q?JJhzSrobX28PyORGvb8dK+3uMELdnrat2Vb+Z9ek1hE02eIF/W7xMLqu96Oo?=
 =?us-ascii?Q?RgSkWJOji9qfL07kTQ1UnEWEFxKKpNIhmT9kCqCdJDSbshC5jrnVS87G8dHC?=
 =?us-ascii?Q?3SdBUsA3roWVAm0057ZkMQIdoCtatAOsNffns1UKy9Iwi2Yzm9oAbQxxD83u?=
 =?us-ascii?Q?bLmeDN0ex/jvmDJ49EzzFG6VcblxhqMced1Yq+nYH0kdCSg48ij/t4430Rbd?=
 =?us-ascii?Q?9C+/OSO+YFmvQjA6BnN0ZXvreWuao9cisfIbgH8tsjeebr9lgBKm1Qkzr1/V?=
 =?us-ascii?Q?/DGEpP8/h3PSvMLlzgznye7nxQXACpeJCoTpLEbrm0amcLYdKIpYBEg9gOAv?=
 =?us-ascii?Q?hYq2eTJLGOPbpGTWFqu/dW98M82U0C5vf+pWHvtal1F4lGds0SO06eyQsIpM?=
 =?us-ascii?Q?u2EXnDiTNZ+AemLZDWwTSz7IL+I5AY8nyrQwGfMSYBHJMw/Tcf1RDYoBNsI5?=
 =?us-ascii?Q?pYCL4eFXPU4gRJwumLPsyYC4yLF7EmdYFe6BmJZQCiVT1nPsC/exXc7cu+Ra?=
 =?us-ascii?Q?tagjTl0DG3by6LtfVp16ooUvsCMReTauEyfPUwDz4rG134aoJcCfBY/SiOV2?=
 =?us-ascii?Q?CqcvdtVGa7rCYX50U+VnLDGz0Fgh/tZ12pzmGGJkM+lEB3x1FbeA/Gwsx6+P?=
 =?us-ascii?Q?p6rCP1D1/XkiJOW5BM/Gl2Sz4ruS+tyZc7QBKiihx6mO/C1gjrND2EfeKK6q?=
 =?us-ascii?Q?8DwYQRBvubRvkyb0h0lmiXX5tsPCZF+sp2zls55TcftDJ0kJ/var2f6Vh7ey?=
 =?us-ascii?Q?Sa+CbN5MPMM99JtBX6Vmrx4etmTs87XReb/9bqy80YN7WpmdGfiwlSYWhg+9?=
 =?us-ascii?Q?Xt8A+wJK+ViWw/OsIKViwuPnvKixpYDOIs/EP2c3cgjmEzwBmLqyeWIo/S/h?=
 =?us-ascii?Q?/t0AZGcDBiBXbUkOblhsAJykH01ekYeCG27rSbBvGYg7ak3PfHf2dxn18FXz?=
 =?us-ascii?Q?UC38YPitB0oB1PTxAPvXchBgXyY484kKH6LsXlRvaURIwj7B4SXYSAzh6aF2?=
 =?us-ascii?Q?SOC9sH4VzbG8ymziyntdT3H80cP+z5tJmQGwOFLLkdvRBVPKq6uVBRjdIqig?=
 =?us-ascii?Q?/juH39Faf3S3HkXTITGeh5WlhPf3wdxyrRv9GtKnOV75U238XXl6CauO3kz5?=
 =?us-ascii?Q?fYkoeR+P2iNuvO803pTQYObxtojMYS6L/lEjUeEWA3lY7DdvGaL+gKAsdbGi?=
 =?us-ascii?Q?nYqKlSu+NVq7bGOALWiDuRZ/RZUI903tUYcJt/BxaLD5a7+Uzo8kDYUNvm/o?=
 =?us-ascii?Q?j2X6ztZZPBEvnwASHF1mXHrm04dqbDZkmJ3/MGsXljmEUWelltkl7KvsnOS6?=
 =?us-ascii?Q?AFtPMDyrMpSfaLWElLQAYYf7r7mDJSxYBz+6rcBwsdnwHOApzyxhlieJAs/x?=
 =?us-ascii?Q?/IXBXhzvMASmheR7lWetE9Ep7QhoVTPyudIpDSLIxyaD4PazkcTzcgcukz1h?=
 =?us-ascii?Q?9thpTa/FQYaMXv4QDbKTtPWkWVoonfM1+gC7641LKjDijgYzQFpL85xnfGzt?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wvgbk4PCgPp3MhhPE4+dPC1fC1ebt/Gun/CPZ8m4l9E5XaKJA1/h/bDVPzDehseq/KMl4YUdY2Hg/OkouwpeUaZkznJXZe6xmj20CDViIW9z7M+e6c1m0rka8BKdlEE+06k0P8HQRyTNLXb6hJYuGg3kD8aqeKqh3RG+mYj2l/13xlHTIVWk91E0nCeBYcVch+56raDNK6i51qWOy49S9vGITSLFHiQVWd96ex+YuSF/TqbZhGCr3o+b+BNwqM4iVDhgwGIIYhCNSHAQOVj5Crh5AX/9nycHugYxpSidiDMzAGoQC2wW9ElTvboBlqOux787Mghuu46Ff2sWx7HNVyMFdurMFEH98kXgvrC0iRu17Qpjq3RMQYPAJW+hvWI8QjKd3005urtrz8E4M5Jq4G+Vi1PH2ZXyOXD6/z7R1upIPsR9O+J/vXm6/I4ya8WR4llzGZ8B3vtSe54aeTy4kXUjkQCTrjjSeAisRoKWuBwE434URFayRkZVmYJP62rDCawtI2JZQuaHevH3egV/9IkysvFnVPCEbWGONQCtBFZDw6zlsr95t/N+Rx5oHnGyaUVULVto8AhONomqHz8vye5aB74hmixUMv3FOYjsJJ8eeLZu61lnhFaFODA4p80ot1fl0T4aGe6q/v2jCLevClzM9ph3Nph6XwxORiSYLMZlvJubZ4MNTNbM8/AeV+MNrOipYqFaGrpYaebCcVIi5eqMnndYbmLsYIJaTh4FFKkBigPippstgLWxbjnEsCnN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de79dbc-2f40-4987-d9f1-08db67e5e41b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:02:07.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2AsSrYqs75Kmi3TdxZMhl+eHvBABshAunrz3TcblANWXBbvmwtAJvgkk0Z05hGO4d8dZCE/ey1uO5/zy0cvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-GUID: 7b_j1Eul72S0nW1SoXxd56Lf68JnUMEU
X-Proofpoint-ORIG-GUID: 7b_j1Eul72S0nW1SoXxd56Lf68JnUMEU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function check_where_mounted() scans the system for all other btrfs
devices, which is necessary for its operation.

However, in certain cases, devices remained in the scanned state is
undesirable.

So introduces the 'noscan' argument to make devices unscanned before
return.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/open-utils.c | 9 ++++++---
 common/open-utils.h | 3 ++-
 common/utils.c      | 3 ++-
 tune/main.c         | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index 1e18fa905b51..e34abee97f60 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -53,7 +53,8 @@ static int blk_file_in_dev_list(struct btrfs_fs_devices* fs_devices,
 }
 
 int check_mounted_where(int fd, const char *file, char *where, int size,
-			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags)
+			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags,
+			bool noscan)
 {
 	struct btrfs_fs_devices *fs_devices_mnt = NULL;
 	struct mntent *mnt;
@@ -108,6 +109,8 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 	}
 	if (fs_dev_ret)
 		*fs_dev_ret = fs_devices_mnt;
+	else if (noscan)
+		btrfs_close_all_devices();
 
 	ret = (mnt != NULL);
 
@@ -132,7 +135,7 @@ int check_mounted(const char* file)
 		return -errno;
 	}
 
-	ret =  check_mounted_where(fd, file, NULL, 0, NULL, SBREAD_DEFAULT);
+	ret =  check_mounted_where(fd, file, NULL, 0, NULL, SBREAD_DEFAULT, false);
 	close(fd);
 
 	return ret;
@@ -168,7 +171,7 @@ int get_btrfs_mount(const char *dev, char *mp, size_t mp_size)
 		goto out;
 	}
 
-	ret = check_mounted_where(fd, dev, mp, mp_size, NULL, SBREAD_DEFAULT);
+	ret = check_mounted_where(fd, dev, mp, mp_size, NULL, SBREAD_DEFAULT, false);
 	if (!ret) {
 		ret = -EINVAL;
 	} else { /* mounted, all good */
diff --git a/common/open-utils.h b/common/open-utils.h
index 3924be36e2ea..27000cdbd626 100644
--- a/common/open-utils.h
+++ b/common/open-utils.h
@@ -23,7 +23,8 @@
 struct btrfs_fs_devices;
 
 int check_mounted_where(int fd, const char *file, char *where, int size,
-			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags);
+			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags,
+			bool noscan);
 int check_mounted(const char* file);
 int get_btrfs_mount(const char *dev, char *mp, size_t mp_size);
 int open_path_or_dev_mnt(const char *path, DIR **dirstream, int verbose);
diff --git a/common/utils.c b/common/utils.c
index 436ff8c2a827..b62f9f04ad5a 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -230,7 +230,8 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 			goto out;
 		}
 		ret = check_mounted_where(fd, path, mp, sizeof(mp),
-					  &fs_devices_mnt, SBREAD_DEFAULT);
+					  &fs_devices_mnt, SBREAD_DEFAULT,
+					  false);
 		if (!ret) {
 			ret = -EINVAL;
 			goto out;
diff --git a/tune/main.c b/tune/main.c
index e38c1f6d3729..0ca1e01282c9 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -268,7 +268,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	ret = check_mounted_where(fd, device, NULL, 0, NULL,
-			SBREAD_IGNORE_FSID_MISMATCH);
+				  SBREAD_IGNORE_FSID_MISMATCH, false);
 	if (ret < 0) {
 		errno = -ret;
 		error("could not check mount status of %s: %m", device);
-- 
2.38.1

