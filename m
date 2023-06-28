Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405A741094
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjF1L5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:57:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59542 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbjF1L5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:57:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTAus024981
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=zNXXvqI/MqsnclqwZ7JX6FDZ6qvjDup4EQLqPgNELRw=;
 b=gjOnWhi4Pm2dXqUZKJffm6v/MWA3hz926g5FfPMEayXYzMh4o31ImhiW3IVKu24S33dW
 bLZ92y+kImc82S8iZY0CqOPTrYwrMC6MQkzxL7IuUnFYz8l2fIKEkVcj957Ng8xYCCyl
 n6YcbHR1vL/e3JnoTgCz0hxSCpfVFn8vBxfV/9PznAnJ8/f6pmYqpMnZSY5yiClkYkzO
 UpHN6ztAcGMvIxJ0VF8S5epaYMSO1+usxULxr8qHiY7owbOfxE1mN0uDI639F4r8Dj5X
 HIzd03Fz4tll9XDEiiSuHIeWN/58Ine8lgBCeKI3anUcmiorQT1xXSgCwHEmEqyZ0ZKg Bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e5hy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBNNdt019935
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxbnyjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYOj5/a4kiS6VbctBasmWVRUX3FgpRQsm/2KO9Fl/mLN0gIUCPQm/1U5dd5Gi2t2pPa/8AY0xutAfuIy+O+iuljT3B2+NpSuB0bj746icY19vEJYiQ0ut0z2YFVJglGjtlBP2cspsRF+5u56zJiXr5VcJ49jpR26aWvHGPjuH/Lullhjd4AsHtmSGTtzbG2NQN2zR20SvXJPISuLFWrnySiGVpEp1vzNI+IB0oIsZyh2xXcrYRBvRvJDwiqqq8ozH6Jnm/zYr66ouaYWQQFYpoKhKOFLgZLfZ3yTzCDa3J6Z6o6bsdoBU6eHeKVRWqKiJKeXK7mpVgQipI8pNhxhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNXXvqI/MqsnclqwZ7JX6FDZ6qvjDup4EQLqPgNELRw=;
 b=feEadby3CP1KqHkr7RecINl8gRg35qNHpDiQxo6dIkx0FR80KtKa00LbfQqtk2dOG/yn7aM/F10d6aCbpKwoRz8Cm45jyTlQZ1uWHDs083OZtsFIUCwPDAXPcql0aVb/iaDl3b62jaO50epIaWv5EvnDyyKbT6wznwNJiFwERIce+ChUNtW6qZ6CBezsxpm7hs9pSFr2AiqLvk13rqshVpK6tFs+b5Es1oIiiBk/ycOb7xLHrPg26DUgqXxMdCM4aWq3izNqZCihaJMvCUgaaNvxLb0HxTakOeiukWAVj2lB+Qj3JyN0Q5ZEq64ZyuV5SBjHNoPkpVCwgKPrNiN+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNXXvqI/MqsnclqwZ7JX6FDZ6qvjDup4EQLqPgNELRw=;
 b=AtKInhmw0sWR5nxpNKTdhkdXB4oCOswKTnL8K6BoskYwmoMNH8he+h7RZwoL8SCqguP1Sb+z3cpTZlPEXOtMI1xtFYWBFuFRkOyWOmoZ5R22W36EB2PZ/E2/TCY2rmBv4yB5AKfR5LlR2RLF6BurvOT+pRGtoYw3PZzeqaQwWfA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:56:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:56:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs-progs: tune: introduce --noscan option
Date:   Wed, 28 Jun 2023 19:56:12 +0800
Message-Id: <503a67d396da4ed4385b3851f06c64203d1aafd0.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 34630b5e-14f6-4638-5b1d-08db77cec6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voC/VtK8A4JRm3G98u0loLxQ35is4Z50DXG9ul//Cd29cRl+oaDby4CZaMyB8q7fQYl0wRXtbISsbGP7s54smMffcO+9HJXknIycMVHNMmrHkmC8DFzgqRfY4IvviKNfnZcyWh9eGLxgZgoSo/K07acclyG0BT5l7ZjBCxDhDxuzzBOEp3l3mnf3uRH+WkhURu3jccTGB44C4a9Mwc+a0qoElnJI6sPEVkImpu+xkfmhUKXf/1oLCHZFp0I+xPxJhwxe8LWa+RmZeD3KNprr7zJD9tAJMOT+EmWhjIEhZFCgA9hNMp8x0KBkBhIRMRyAJi0ZyztHy5RywPDoql0RQzwkIx8geAUKVytQVcaiQYM9EZ1xi08D6opyHOeBLnIzAs/QG/u1xuLnihoRTAPI/vu7IeWp3BhLtIDIlRzhMj1mEta9t9v3r1cZvPXp5OGIEec7/0EHdnvS7ll8UOTydDwFZxf55oWRw3ugNZ47Yo5FfV80FirNIGDDk9aQgJJvnYabM8Wh5EKmmxqug84ZvSo2XqlThDMpyuIKunJJtUycK0eZ/bh+66LBKYIb6BVGHMYuhXxwYSvr388O7EFgj+d8X6eWNGXAw/WcbvLkwJL4sT9A7jLOdFXtFBR92K/M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(6512007)(26005)(2906002)(83380400001)(6666004)(2616005)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X7nXUJAVouWIeY4UdwMD2Mj0CBectNEFve2KC6nunfoQa8pwGbdnZXLxqxp9?=
 =?us-ascii?Q?97frKFlAQuEbbIbZqSbvQyT9Nd3Ma7GE078nj8YqIfG4E/8l2EiyPGQ8VUvv?=
 =?us-ascii?Q?f3b9n7TdcqO7VmMQClFu1Ds9selN3959vaAuoeDPOl/f6ywy79jo+P+9roRI?=
 =?us-ascii?Q?6rJ13WGd7gSq3fgoh70UuH3qtFukzkCn+7u2moBlcPkPhZTM96JoqH8nOkr4?=
 =?us-ascii?Q?6kfOzmbdkmU94h9fxoAT+uAjSKNVDcVAhtuYMsAXi2v7Kj+8Csz7z5TVAaMi?=
 =?us-ascii?Q?ld7kTUmDPWlFpA81+ksF2xUt9JQKGP6mnwxA9X50WyukBPlLOzw0RKbvUWQV?=
 =?us-ascii?Q?w+Sw6kpAwNBwoNkQZhgEtzzlTpYYTFR0F3eayyTIPbFLhvi25Wx+OcgzDadL?=
 =?us-ascii?Q?pQ7pBz4ayOxyxZeuFXtnY///FYbEJH9Gme5BziskU9/LSSgpITLaxV6pGgQz?=
 =?us-ascii?Q?p4IdK/fz7tZOL0zrfCpelXL9F0JJPfKkoSlZKw+tWW1P16zVkez6+OgTQVfb?=
 =?us-ascii?Q?PwlXj4qBg19QY6E0TrcL6xzV1wSjn0gGcCkVCmwoTtqf1vGKmZpXBzwgg8el?=
 =?us-ascii?Q?35D7rXMFY9sEVw3cdgxROGOTUEO1ld08aZiq32348DREPbgmsbluBJ+/+xmg?=
 =?us-ascii?Q?lhF8/bb8+jeNYPmm5/VfhqFZBchDnn6bt0bzCEOqLpgx+Pj/782kvncNNqdi?=
 =?us-ascii?Q?EBf2DrbApuBxdu4GgmOHkKqcENQS9/dxOPLsJ1mKOS5zmhmPJVchgjaCuamD?=
 =?us-ascii?Q?imfJ1cWGLMc0QdYhAYUMW9vj6JbnAhn9tNw+1BTQk0f6R928p/mtP/ElqpeH?=
 =?us-ascii?Q?ApIJdWJcpgGy6/MUDH7oJYbysLOid/G1LZ6nIQw/PXQO6tqd61SxNckn6kWZ?=
 =?us-ascii?Q?punAXsrMsCQK+PSvwq1x/Iv21vc4kboCJJEGH4JQMv6KK9f3ccrSctTukaop?=
 =?us-ascii?Q?1xbjM5r0yGJSEUTltvdeYji19d8Pqm6EqktWPpMK/wl8bWlrEMRyr+Qv3iSz?=
 =?us-ascii?Q?diMVQ1dOZQVPVBNgRdlWW8WVvM0iGsII8xe3bk7ga05nsARJVwQHNTAzlB3Z?=
 =?us-ascii?Q?GOfG5Vc9s6Naey9fDWEfMBH2KnmOqlUATloTsXC2HUVyVcjQjI+2/xqS0IJ9?=
 =?us-ascii?Q?PekXD6qHiOOMstVEjkZEOIWoMcLjZkxSlHvvJOubVOR7jc/YrovpGRX0DsO/?=
 =?us-ascii?Q?rLsItcpydjO8X2TjJTtlgG8yXMvbHUFwx+MZelHshBT0lkGhhzPUq/nSdv8o?=
 =?us-ascii?Q?y7bLdLEXN55eJ8Orqdw8eRfA9U6DqMiLsldzdNrOExzF/CqpB9p2F2CAuG/4?=
 =?us-ascii?Q?skFrXQffcG2teBA/QtCQXbKV/R4JRksygtQBtX8ZIkI47xm1qvtSKfipt8bI?=
 =?us-ascii?Q?Smz0jAMyrzVEUypww9+kR6jVrHPyND8w6HELTYeL9uMmcWMRyj1RCkN+xJgJ?=
 =?us-ascii?Q?WoFgmbnqZL7Q3o3CpK09kC5T6NsBCg6bvZcFFTK4YwNMMZp15J09eeip2LO1?=
 =?us-ascii?Q?L4jYOUkceVOcaKCMACfl0HoblUZZeuoSdfT93+M4nk3vCccjeu/lDWLx3gC1?=
 =?us-ascii?Q?bovaGNalb0YOGqMJwWy6LAMVl86q/kpaaB3cQ+du?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MIzkZpAomZpdNA9HN94/e3mQ7ZS/mks7Gj7/CiCGq23sGVJgBKTgMUfS6qJEDIaF78ybP0NIOQvS25n2DidmcxsqMC1GYsVGx6O7OFRH/jlnEgSXVcWnNgFQzVlXNGo5p+lyfA8TgA2chX0s2DqjOyUXZ+4UzPBUCOfRrINh7ePVhYfiaJ99eNVD3niM+F14uqQK6xMjJdZioc/n1adTCW34SL4g7TMCj2Lz4iuv6joTe4i8qgNfyrBjRE5wYNp+jC5uG8AiMXA4XOaExbC24u7n1WjRVVW11VX61Zrfxx59XO2o7Rm7v3cnT6tfubjj9dLKbVIzqaMipOgIQWRxU7VZKSHSoQMyLS6Qk+Y0FY0SmecUnXNoqp0aex2M0aC1yJmXvlCwTbZTM06HKyZ9doZ/zlkdn2I6eYeKzAysuqLpARvUpnSTLRFc411C6i3TwQqTgGsou83pp4z7x8NNTVRRr9c/wGMOTePDg/LVQJq6mtNwUm0uVP+WHImMfVDfrdqjFT940PhOdN/H2knSgV97CHZN4iONtXl4Lo++YI6MSzs/WtqORs4c5U3V7Z/eTpSOLATVZgO00kgizn+zC+PS4JNJ8ZztQKrQeEGLbWq74ejERwyVKqdTpb3n0PCGUmd7su3no9DRegR8ujNSzGkj+Fbuenrck2mVp3taOC9l90Pmci+HgxG0wLn2Un0gJyH0xZHHpz10qlo2khnFypWiE/RBoadLS0ObgM1SeOwIw7iT7xuEKHJLvHK1kbt54QG2HtyRBaTZe+wDpfvVBw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34630b5e-14f6-4638-5b1d-08db77cec6d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:56:58.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPK7H2FuZu83JWWw2pAA7JRP2qO+8Znn7iLbBL2sO6yAbY0Zm3B7o6NtS/va3YMFmwRJ95rYUrGKvw4Yn/0sqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-GUID: SHVjkZcbSmDFW9pnOgtEYtqFVIRhN1Yv
X-Proofpoint-ORIG-GUID: SHVjkZcbSmDFW9pnOgtEYtqFVIRhN1Yv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function check_where_mounted() scans the system for other btrfs
devices, but in certain cases, we may need a way to instruct
btrfstune not to perform the system scan and instead only work on the
devices provided through the command line. And so, add an option
--noscan.

For example:

  $ mkfs.btrfs -fq -draid0 -mraid0 ./td1 ./td2

  $ btrfstune -m ./td1
	  warning, device 2 is missing
	  ERROR: could not setup extent tree
	  ERROR: open ctree failed

  $ losetup --find --show ./td2
	/dev/loop4
  $ btrfstune -m ./td1

	Or just
  $ btrfstune -m --device ./td1 ./td2

  The 'noscan' option is optional because there may be scenarios where we
  have a copy that we don't want to modify the fsid. In the following
  scenario, we keep 'td2' out of the metadata_uuid changes, even though
  its loop device is created.

  $ cp td2 td3
  $ btrsftune --noscan --device ./td3 -m ./td1

Thanks

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index 63e3ecc934cc..570e3908ef8a 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -119,6 +119,7 @@ static const char * const tune_usage[] = {
 	"General:",
 	OPTLINE("-f", "allow dangerous operations, make sure that you are aware of the dangers"),
 	OPTLINE("--device", "devices or regular-files of the filesystem to be scanned"),
+	OPTLINE("--noscan", "do not scan the devices from the system, use only the listed ones"),
 	OPTLINE("--help", "print this help"),
 #if EXPERIMENTAL
 	"",
@@ -145,6 +146,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	bool to_extent_tree = false;
 	bool to_bg_tree = false;
 	bool to_fst = false;
+	bool noscan = false;
 	int csum_type = -1;
 	int argc_devices = 0;
 	char **argv_devices = NULL;
@@ -160,7 +162,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
-		       GETOPT_VAL_DEVICE };
+		       GETOPT_VAL_DEVICE, GETOPT_VAL_NOSCAN };
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ "convert-to-block-group-tree", no_argument, NULL,
@@ -173,6 +175,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
 			{ "device", required_argument, NULL, GETOPT_VAL_DEVICE },
+			{ "noscan", no_argument, NULL, GETOPT_VAL_NOSCAN },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
@@ -245,6 +248,10 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			csum_type = parse_csum_type(optarg);
 			break;
 #endif
+		case GETOPT_VAL_NOSCAN:
+			ctree_flags |= OPEN_CTREE_NO_DEVICES;
+			noscan = true;
+			break;
 		case GETOPT_VAL_HELP:
 		default:
 			usage(&tune_cmd, c != GETOPT_VAL_HELP);
@@ -292,7 +299,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	ret = check_mounted_where(fd, device, NULL, 0, NULL,
-				  SBREAD_IGNORE_FSID_MISMATCH, false);
+				  SBREAD_IGNORE_FSID_MISMATCH, noscan);
 	if (ret < 0) {
 		errno = -ret;
 		error("could not check mount status of %s: %m", device);
@@ -317,7 +324,6 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
-
 	if (!root) {
 		error("open ctree failed");
 		ret = 1;
-- 
2.31.1

