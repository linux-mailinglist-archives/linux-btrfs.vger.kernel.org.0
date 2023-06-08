Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E597276FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjFHGCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHGCF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:02:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDC1707
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:02:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Ma8qg002221
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fkI/rQCb+tTR95bzQXIn02vemslrIl26hP4yAXTNTpo=;
 b=2p1FLCegVTpN7jdJbu6FyQWhzp5CN8l3CI1yPQlQ09St48iZuKswGKQLiIRGsmWKVLuK
 KMfvVOnsyiRf73Sh5BtGxHzVFB7IGPM0JFdJBWc9qxZ0FmhfLfd6+Qu7s1iw2+O7ofXe
 siFyyK0HeFxH6EK9lw1oMfyyBuSIBFyWBgBzirNnzqORzTqL69Zfn75Qo54fqofOx+J2
 9ExGgmzvXEtRsZ8Ulk66FJDPi/sCSGkx24I7LDDSPbztmynKYvXGMiIyTkZievWns37D
 uEile+QLtHZEdWQN8goJrptThk/E6Ys8PcdCaXJiqxCW4cO9xouCvdfrGKnnrNL0p+MM Xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u3e88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:02:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3585AIhE015848
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:02:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6mp30f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0Yu/cib0Tp6Zz5Hs7y/LJ42P+LeEZq5Wg5Ify/FT9rGmxr0Ts21i7lP5IBGBoDgJ95IllAaG9yBIeD3dmlGSlGli3J9yrEpLipuxX9Dk1vj8huybt2Zny8/E963klNl3OI+FddILODgkAfGtAMrp5D1SL/Bxd56ILQI+J3HjOzyV0TQxJ2yd1TAgVXdaCaO1E9TBDOFEQIWF3ODt5hDPwuJFj4/+hvHir+0vjQz0qebEWbMjLeeESwU5keIy+BMDsIs0BbJiJYz7Nwd09rlCmJUY3znci4A6m+OVJJb4KAyE4dIRVbeiKUIoB2uT7wjVWTym5OUIP7aLLiWVsbu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkI/rQCb+tTR95bzQXIn02vemslrIl26hP4yAXTNTpo=;
 b=Hy/dFHrX272CQHbtt7jo8MW3fXPWN/XcWPwfM8SRP16wGU81GRyTa9mA7MtXyqYv/XEVfe+x8isjNoI/4xnxXIb7DyMfdVYq+nOARJK+vFepm9xp4QJ+O7hQbSNPAoZwxCiSFZ3v49fZU+2QHXau2P3F91R24VbS8hyWUHNnn0iajqfvdbMAYhWSGZClETo6O/RLT7j6K1mBlXlDoIwu/vMzCEnDy8CbsX4jfaA/TmNjOxBhFVweRpgpO7rcK1CqXz24GEmqukK8ijUgGJYfTh0AK8fRhPvCk1CgDbB6Q0gPkygV6Oj3+/Ctq7yYOucfLhP0RpIW1yaIpewiAfEhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkI/rQCb+tTR95bzQXIn02vemslrIl26hP4yAXTNTpo=;
 b=m8qA3bmgc3WW9hE0KCg/QCemN5D+zGnD87s2MBTgHrquxIN7FJTbyHNH6drBNqzwVngj4d4Y+G9KDCXy6sB5hEj02TfEubDT5WRPcj6cKofhCWzXKG9KyBqR13cQqa3Z4v2BKNj5Ae5TRKHEmdyb4qAqGOijeI9up0Aht8Ftres=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:02:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:02:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 6/7] btrfs-progs: factor out btrfs_scan_stdin_devices
Date:   Thu,  8 Jun 2023 14:01:03 +0800
Message-Id: <3c660a0d48f5e8d50fb932dee473fc1d86c0838e.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686202417.git.anand.jain@oracle.com>
References: <cover.1686202417.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7f8b79-f0a2-471b-4e8a-08db67e5e030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/L94NDELP2wuaLhdVnBOCEC/b+8JVK5LHjmAeg8jnRzQ/sTuWyTW2+7irbZ0NC6xgtWn3RmAmtagfCE9YVyevhRbPqYP75t0PVdjq8TVr3Mp0UWUo86s9vX7fpQSE/0kclqIiSzx6eu35/OAmF3ianEzHFVLiOPgQWLCBwSI5bXcOwBM7vMSFTHMrQ5BLL2Gkk9XR/iSyxfLvA8qD0Nec53QyAIr09aL1DaHr7Tv0YEgoirXra+c5fG0ocq+BaxZcnZebqGSKonJXfGAE9ERLL9PI2Wq4NTD/e5ea+/DyF+fAAIu5kWJo5zWUMA8T/3xKC3tGiMgXc1HAo57jlGxzQVRx2504Z6IsaaQO5Bg+44/RyENo3rf4dtuC8ocBkKysTFNfCjXpguJmv3s6fRTUy51bSFJ1DZKeWt+uig9pazV531gmrFuPk29MZ5djd7NOeQhH2Q+yZFKoHRsxNY08vxOQjamfpC52hmMNYMeJ1KQbhNTny61nQG5sc/OBFCwurLnbaJ8/y7eVDVfnFYgcsAHKctMW9cHa8D1SReWrnjoYNpLj/0X+M8fLBNSO2+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1yYSD+foSwIPzj9ck/tLU4QDJNoa9EVfOHkdqcsUZUm/qsrESKLpQc3iW/sd?=
 =?us-ascii?Q?G7o10oJi/IkhgEyOlwMCmTmJSd9Pv0FniiHw9zpMqTrH29i7Hzgqth6lITDL?=
 =?us-ascii?Q?HOG8j5kxul0O4+Ai1XeC92J61QW7DWoh+UIOV0FqbbJ6IwqW5pvgxJTvHU0m?=
 =?us-ascii?Q?jF8GNBtzpOq/hgjay2S16HU0RJ+aTQAp4KnGZrqZE09nU/2RIWbH0wzvERbo?=
 =?us-ascii?Q?VXvH6cjVeCHOiSa83JBE0avSE6Ztfg3IDJA97LMGa3ycg97/HZ7fvTCaJRWJ?=
 =?us-ascii?Q?3LK8tkwMPytq9jh1OzVzgIlGDz0R5wtXXlcOwLohEXo9xu8360Mud6hlTnxc?=
 =?us-ascii?Q?xTHIudmlaE/opdrzWwaKdKdkM03S+bd86cSb/FpoQ8AuHyQO5Id9EAuZMbtf?=
 =?us-ascii?Q?qiZxn56QeI8+oWfIM564llvxcQHdBAb0Scann4GquWloEDwfSF2PicaY7Pnk?=
 =?us-ascii?Q?JHmmhj6tkNVBAznswemVoklyUxtnndyauDl1OOHi5aWTCIRhk+IGYwwfloVk?=
 =?us-ascii?Q?hRwpv62qYc3bOLQE+mOhmnWlGRpP3XPzFdBQov1/o8qceqXh16br8XcZQGBf?=
 =?us-ascii?Q?6dHn+mEv6bkAIi/W3B2+1rI9Qn6Qr7GZ9UeKW3hwf/nTX+rURc/WjLmAeifl?=
 =?us-ascii?Q?vuwwfOp8Kk7CQSlsTeWQJtj9WenP0wgtpC/9xpqx597mMRVZIvPcEKZGFW6t?=
 =?us-ascii?Q?v6Weh+Zc9YW6JISzc0GXBoln0CULSwM+RYyQst43wPTH8CuZK7aTfK8W+RNf?=
 =?us-ascii?Q?XAY/d57xCNqtyf1u/UdYQzK8fvNkpd86yCESbr6jWoPKXN6nh7L3FJszZusf?=
 =?us-ascii?Q?IF0CmYKhyicFPMY1f72ZHj9RK+mysWYZ7yv/mBe/cggVunwLZG+QGUEqSAYB?=
 =?us-ascii?Q?SQ+K5v4TcwCZKlOf8MHoER5pCEx0M/xPQLnQYQGOcWTMd+1KtdhMRGPgZ+pM?=
 =?us-ascii?Q?o6xCHv+X1UO1CspAjmQB84CrX2f+Z/aZ6hmjn8yH5dmt6JFzIt0VTH7FkPPF?=
 =?us-ascii?Q?QZV+3UL6QvMmt7dIQD2wVlpNMlnRVtWy/+kjRolPIXf7ISt0LIxSIR1CzgWG?=
 =?us-ascii?Q?lvWKU/idSbC7XXwgJIDN5ufmp+Kp6eb5xSh62tHsFtwTLd8+oAcXXsyLPxcP?=
 =?us-ascii?Q?/HLXrTgM/GU5JRWFLawEwe555qH0X9lpIoPxN++48rVU0o4R65bQMdo1jdjX?=
 =?us-ascii?Q?UEKHNRc8T4P8+6noDGC7/tyyK9PrikoDuwgCaaI4II36B2goWY5C04pBdQXj?=
 =?us-ascii?Q?W5zQTp/StT59GqVjFKrKnTPGIGhEjt6H58GOHajDr49/a/IHstR/IO13kUp3?=
 =?us-ascii?Q?DKgmKMs2wcze9pES9lozjzgX2Qb8rCWffttM02sxa3KXTwRXOiN48+3bPqo/?=
 =?us-ascii?Q?m643DRt+yAPx1pMC7ifTbZ2DZfjUSFpbs4TVYhkBfl3LqBp9sv7yu9hYycof?=
 =?us-ascii?Q?s7QoQZn+2I6OaHrj1jkdgm2F0YYkoMIOabLyTbLfPTEJVLNWonXKuFs/238U?=
 =?us-ascii?Q?s/QkrAr+4CqbQOzfFYnPp9VKfz+zH57rg4IzDebv/xxYb8E5PCPP8zKrZauL?=
 =?us-ascii?Q?Eo+4YMBsFU7QcHL5lwNyllO4GsufKDdkBTnzyXzHOFIGFFWX7sa8HEsEZFUP?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nc7uzLXRnEhZlrmVVkv/FvS0Zt9GD/Zfpj/VUYd0VphfkvRRbwTiUfpdQ1sHblvxMW5pTuVaedIJtLdPTsIE8eX6UYpfOkufjiQ5qL8e05XeVMBxjJwwHd6FUI1b3XhpTyB/9m31O8kc9YpH9+LqdVBDMLOn3RmvptycZPNwsyc2v/WXaCoX0mMzuZpY1jRDjakWc6XnbQqxP9Fq8Xw6/qGB3Kb8JLEBwf1oKenj6TAebJIhR7n1spodVQTYDROlaHKSvw9fntc5OCB9Ry5pwLdtPs/T0tQIV+gNF4+bzwu9oVItw5Rr7RkArq2WrDDVaw7ndM6hS2+DUMMpmYFqZnmFNV+aSjbEKuQMoLEiIPz+UARxOWGxsUmcRYCvgr6aw+F7Rji0YJVcHzDpsGW/QZc38MGovwRQ03AvDo9pW1P2qV1weN1FjToYFDh1SsR9fNnQkuduXFmVi6+X2S9OTg1eQZVPgnbW9EsvmHvl0AirKng2rJwMvqctYaL6shO/3HwwleN1Ft5IkCb6BeRTuWH/mc840VOq6ajg3aqSZmAAVBFuSEKFpojI95WecvxqgSHjADh1meTfdnhVnwYbAYaHqIIyV0jPBlIeLtKarHLy2va7HxqvFCULrbMEiOHHI8doQgYB3m4A1u1z6Fl2cLC9yK32NMlemsHIek6e6lGaVy+Kq/LOP+nBT0IGt9SIdYv9HtDLJ+KneX9P2aVCVQv7ecP/oFDzUNDuZZbe3PkYOARE4PTCazMw9SdZS1vo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7f8b79-f0a2-471b-4e8a-08db67e5e030
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:02:01.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjqVjmoHurP0m3pGLySxay9QshGbXirqVqurgIrugQ1ZpU4c9uCHTvqBGD/jCPms+t0ZcpaY4UkApC2ayPiXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-GUID: hecCkzhbKhmJ-uh1D5IH5fJSKv5L6zm-
X-Proofpoint-ORIG-GUID: hecCkzhbKhmJ-uh1D5IH5fJSKv5L6zm-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To prepare for handling command line given devices factor out
btrfs_scan_stdin_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-tree.c | 37 +++----------------------------------
 common/device-scan.c     | 39 +++++++++++++++++++++++++++++++++++++++
 common/device-scan.h     |  1 +
 3 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 35920d14b7e9..311dfbfddab6 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -327,7 +327,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	bool roots_only = false;
 	bool root_backups = false;
 	int traverse = BTRFS_PRINT_TREE_DEFAULT;
-	int dev_optind;
 	unsigned open_ctree_flags;
 	u64 block_bytenr;
 	struct btrfs_root *tree_root_scan;
@@ -456,39 +455,9 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	dev_optind = optind;
-	while (dev_optind < argc) {
-		int fd;
-		struct btrfs_fs_devices *fs_devices;
-		u64 num_devices;
-
-		ret = check_arg_type(argv[optind]);
-		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
-			if (ret < 0) {
-				errno = -ret;
-				error("invalid argument %s: %m", argv[dev_optind]);
-			} else {
-				error("not a block device or regular file: %s",
-				       argv[dev_optind]);
-			}
-		}
-		fd = open(argv[dev_optind], O_RDONLY);
-		if (fd < 0) {
-			error("cannot open %s: %m", argv[dev_optind]);
-			return -EINVAL;
-		}
-		ret = btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
-					    &num_devices,
-					    BTRFS_SUPER_INFO_OFFSET,
-					    SBREAD_DEFAULT);
-		close(fd);
-		if (ret < 0) {
-			errno = -ret;
-			error("device scan %s: %m", argv[dev_optind]);
-			return ret;
-		}
-		dev_optind++;
-	}
+	ret = btrfs_scan_stdin_devices(optind, argc, argv);
+	if (ret)
+		return ret;
 
 	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
 
diff --git a/common/device-scan.c b/common/device-scan.c
index 515481a6efa9..38f986df810f 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -500,3 +500,42 @@ int btrfs_scan_devices(int verbose)
 	return 0;
 }
 
+int btrfs_scan_stdin_devices(int dev_optind, int argc, char **argv)
+{
+	int ret;
+
+	while (dev_optind < argc) {
+		int fd;
+		u64 num_devices;
+		struct btrfs_fs_devices *fs_devices;
+
+		ret = check_arg_type(argv[optind]);
+		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
+			if (ret < 0) {
+				errno = -ret;
+				error("invalid argument %s: %m", argv[dev_optind]);
+			} else {
+				error("not a block device or regular file: %s",
+				       argv[dev_optind]);
+			}
+		}
+		fd = open(argv[dev_optind], O_RDONLY);
+		if (fd < 0) {
+			error("cannot open %s: %m", argv[dev_optind]);
+			return -EINVAL;
+		}
+		ret = btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
+					    &num_devices,
+					    BTRFS_SUPER_INFO_OFFSET,
+					    SBREAD_DEFAULT);
+		close(fd);
+		if (ret < 0) {
+			errno = -ret;
+			error("device scan %s: %m", argv[dev_optind]);
+			return ret;
+		}
+		dev_optind++;
+	}
+
+	return 0;
+}
diff --git a/common/device-scan.h b/common/device-scan.h
index f805b489f595..e2480d3eb168 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -58,5 +58,6 @@ int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[],
 		int fd, DIR *dirstream);
 void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
 int test_uuid_unique(const char *uuid_str);
+int btrfs_scan_stdin_devices(int dev_optind, int argc, char **argv);
 
 #endif
-- 
2.38.1

