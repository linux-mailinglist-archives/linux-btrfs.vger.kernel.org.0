Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238787B117A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 06:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjI1EXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 00:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjI1EXd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 00:23:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A437E1A5;
        Wed, 27 Sep 2023 21:23:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6G11001390;
        Thu, 28 Sep 2023 04:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=opH2OSueApPbjOu4j0qRKNkhr/lG+MQtAROVOdIkksY=;
 b=eGNPwXUTz3HaGR5pQi8unaiGWTK5aEz0y6DVU9VRz66dqJo9rL5zF9ZxNo44vpR4h6Fm
 pw6xa3wR5Vulf/Hs7PmkGxtBcKZN/m222sFAqifrJphTrtr64Zo+BzjFEzGwBd80/mDT
 ha/0J4PDLSJkMCN2sFLxvmyeEFSkLEBK5D0nI852qvGLBm1O79pkWKC5tCMaV5k35yOq
 i4yNGpAxnkTq+Rk1U4RsxX7SezTmbrYHhwhq2WhOKbUzRFvqbIRUeIF/X8B7g6qeAvix
 K8Pbkr3A/63jNHeCpxrB0hO7t+mzBUooYRV9+VQnuAV4DVdozo7sgaH24f7Xx1QSYiRT Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3u74v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 04:23:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S1STF5034915;
        Thu, 28 Sep 2023 04:23:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9b325-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 04:23:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFkvZEkcorsKTWJAL90Yp0gCWkavqy7QHkrW8Vp6xNwGtokkUn+Zck3K49U8JpuEaEHCWAs1GnEE/wq//4yRcbgMYjszghJ3mOdafbI5gQFFLEhihZDpqz/lhu69Cmsydtri0qK0DZ/iVdxt+D879vMoaGWVKXFnff0U7FlsFDg/5kMvEG9KeFrX8ptwQ3bojhrbHZS9qQApCOSfYnblhtOz9z0C+gLK9zfxDnY1+p8NKT/DZAIdaVqftcRWw1qgQ0A92PIKZQ8fsIwDFXf/1k8A7ymQ/Mqrxp4a6LDVpoSy3Xeye1HWfzjBkL9dUdAAB7MGj8vGF241y4Ku0zisfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opH2OSueApPbjOu4j0qRKNkhr/lG+MQtAROVOdIkksY=;
 b=llikG0fF08lcC7kbPhl8DfZEgnHi8aePXpAt7DMAlhSnzlxoVHNcBOmjfas0Rp2IsuLu5wlopOYMigpG5BUT3u4GnQPinHDd4VBTsGxrdCJ0xTGdprPGl1BLRhvLHSFlAnNzfaSvmdOOe0uZiAk4lVSiVQmyy1oZptYQS3mShb3jLVXAnr/fQNIC3w7GssAES+SJR8Jrsasdoo+76dnhE4vDSTpii/CFeDbpL2BbprMjPVnZXnCkbRfBJPnp+AX0cTUB9ZnsJv6lgp6mdOMJe4N2bcZBdeGQP2an/0k/uwgJTuSfEqBTQs2kDkQEfO+EBwJQrlAeKoDzF3JibD7U0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opH2OSueApPbjOu4j0qRKNkhr/lG+MQtAROVOdIkksY=;
 b=BthtM41wBNzj6XEjgsIaoeMznjbpKg+Dp0fQCnd3/dCVg5HH39ua0cZDRCdx5x/lDTt1xiX96oCs44QaqJ+zui32t3j75/f7S/KLe0gj1BpAkp3ga0wihs2YG8F7SXmL0xmaZvONWDUe5dl/M/PldsNT7NNRZf1kt4jpCug31LY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 04:23:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 04:23:21 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH 1/2] fstests: btrfs streamlining mkfs command for post-mkfs operations
Date:   Thu, 28 Sep 2023 12:23:04 +0800
Message-Id: <728cfa8f2ce67d2b260851e10d4922fd710364e2.1695543976.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695543976.git.anand.jain@oracle.com>
References: <cover.1695543976.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d39013-ada7-4c81-d8ea-08dbbfdaa5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7vzjwqSKZDk6KKpajGbEcbGMTvWvaQkkcre/7wxEOGO9T+XQ8P0fEv4kvUDHtXsV8hUS1YBZ1xXq6u45J9P/73DBK5JDVdRfF1gzV15fBQM9m6rPjS4I0yRx/U9D5AvppNvcWIuD6HdYLgPC0iMgHijYHruzTBtav1kTdko3fDalW8b25K8CO8eMekwt8AkweWnm0KVWyEH4yz4EpOLnX+BNi7K3w/3Xy9w08SgsoY+PnqO2ZIIwk/C7xDBcp+F9j7ofPRS4ykGTpzNNvgNSEFMo3ygaAgOcgu0IEpIvYoIPZGiI/vYXTH2+b2jcumtf0i3EuZvj15Bj1B033qGc2naNWmTWSJR7NNSYnmJKnd6D7lvLKvqgTWNeM+smF8Uej1bTwqisMkdkaRKU8F+71bTVimqBgBt+iCWy0EErNq1LJcvyK1xYODGuUxIVf9k8Mxpi5nqdeDHf3lEENKrOp6ivWYOtuwovxhffi7zLclcVxfUY4SdutNbcs2vnFNaG/dkErck21ps42dBOmvjOvg7SD7p/CoqpawV1heeKVE3Gx8Q7hBLLagURonoz32s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(26005)(6486002)(478600001)(2616005)(83380400001)(36756003)(86362001)(5660300002)(38100700002)(6506007)(8936002)(6512007)(6916009)(8676002)(41300700001)(316002)(2906002)(66556008)(66946007)(66476007)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7utKx8YLP8ynLx3J4VIDZ3jf87o3rEhvkYkR3VQGcdx9H/cwZ0uOmQ4kWx39?=
 =?us-ascii?Q?ktmCVNb/YtQtTzFQjI8aOobHK+dvGtFZQr/lIq8GYNAokv105QyF6IJ2IQp4?=
 =?us-ascii?Q?FeHgb5o/IcC77aBajoelLJcYDa+F2iLWSi5i5NsWH8aBEV6pDBP6nHMeH3er?=
 =?us-ascii?Q?GFYDipKqLdzS9OvATNHhjZ1ZnuTva9jSxGgPuj1euAzXYm2/InKiKdk2nh6B?=
 =?us-ascii?Q?PYm2EJ51+4VkcsYDq28On9rIpgCIjWOrYZSHy4w/jrauxoIokALlI5Wp+3nq?=
 =?us-ascii?Q?jo6vUAMGGc/l/bEe7m3yLtVVd0BNBkgXEV+Vb5rLKEShS98U6opkcAFh/YGX?=
 =?us-ascii?Q?32ZtGcwxvWCVh5pFaHtdQpJORHhbwcI8+vp11RKT95BW4il4cA9rdhgg5nom?=
 =?us-ascii?Q?yDYOaubUQW28xuFXbUkXzE9fuePhERp1lT7TIK+Q4VFer1Hqt7QLdVpJyrNB?=
 =?us-ascii?Q?oVipbXLMiuBj4h908mylh/4/dLHcgk5rlmhBlWpO5S625d7RtW+VUosUCh0n?=
 =?us-ascii?Q?2++x171INjkq1SAtrMPpljZVsO/ytDEP2OSPTKAolDUa5uCk+XjWObYAqUO/?=
 =?us-ascii?Q?3A+JDe7izewqdLAj8MyTO9Dag1mWmaqvDuUz9ckH2Nm84KoX2Hp2P5Xeo9Ox?=
 =?us-ascii?Q?3VjGkkoRXApq5tu3LzaL+DiCryigCHi8CHTyQPNYLIFYLZImckX4RO0rZfT5?=
 =?us-ascii?Q?ObsQbaiTRT+88rE+BzWpv5RlrbfoYdrfHD8x6m1m18FF90SHdfD+bSsBupdl?=
 =?us-ascii?Q?XzFbmTc3vjU+zaHWuEhb+jB9LdA3ojS3NUSaHQuS9V26XJQXRvF975fGFGXB?=
 =?us-ascii?Q?wHKAPX71I9dOzNhfUdXS/ZhmmcrVS58VUvUBqG2LPep+xg0y993PnzB7aaNI?=
 =?us-ascii?Q?i+lQL9/ID15NGALSd+ETlx73sk9HR8fFYsE29o5Fo5Pbdefi99TCsxpGhXNo?=
 =?us-ascii?Q?AneVqJF529wG6fwfcHzrt8Wl1ZsMm9RrR2HAAtzz2MyJnnNEXG/LWWvtd4W6?=
 =?us-ascii?Q?NCgf0uXYjFYs8EMunHKb/NUdVkIOS76ME+667tibk7qZGwYetMdzIIcVMzd5?=
 =?us-ascii?Q?AY6CpSUb468kOCQfs/qcOvErL4z1MDjdnGI5v/4BAOxlzzc4oT7yyopSuNSQ?=
 =?us-ascii?Q?83VvuAjcOh9byGwp/qIiNCNvhLba9omJu9/8DpogK83I58TYI4prrXV7ltC3?=
 =?us-ascii?Q?MkVnmgBl4GV03h02ENvrTQLZWZ4O/YQQTSQ6VpE/I9Hhh3doJnTLvRUmmdl2?=
 =?us-ascii?Q?w78JEvb7BHP2Z6QfeMgNbGPez68CtAmxV0YFEKFGTgSfOHMdJyhePttkw4rk?=
 =?us-ascii?Q?RxeFFH27jpbLtNvifAxt2359Q0KnOFYU1ckM48ftl+MbM6xPKpCbqKitvmK9?=
 =?us-ascii?Q?FQxz6zvl+82OsKRhsTHRI5n5FLnSbWtFq/NlZQSgjQvghQfu/gCEcwA9CE7R?=
 =?us-ascii?Q?64u678JUNOdZyjIjHYBcUSD2fF0tK+PhjdIzOpzdfxDqj0/TM/rXS4ZN2b3I?=
 =?us-ascii?Q?8YNAEdjrdtyBxeMfUReYiRMUf5MKb69yJ6PtLfmG10YhgBHFV5Ftdhe+ZGHN?=
 =?us-ascii?Q?R1uOUYPmRnyjUM6sjSOh5dczP4rrkSl0/Lrbl26hYtx2158AsBVRX/TiuafL?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aRlxrBUxLUa3uzVWv55gtcvHeOGJ8rFAir4wR0u8cNwvZI5RJ0aClVEkhCP5wV7z7urpDwIAycrLjHA7IZnavmmBDqnn1QlkfXCQNtYCEGyokuRqSRI/am34T3vV8dtsGefgulH45ppOAGwALKPxvyXQa9zkqimF/zBtbXkWUAgNUjRmPGxze8zrk14YEDp6s1dMaVgBnWieVoOI4t5iafI/UxWcY898CZ4bV8GMfnzkcurqbjMjuauyMKa0UZVCGd0/pXfeBLonyWr4tB1weAyAAcIrtOhKzJAle1uhggWLfasnJk6caGXcHwSlH8KI9qIdLtsYayu0ZPvTg4eio3ezHsdMpqVzj6Q+bdpJV+tEh2658ay8qpgjfilseB6mhSon7Cetu9spYvtG/BP1m0MbxF3cUMNpoHh8+RGlXUvHCdp1cEzQGTyhmosIJXzrmYqxD4tDWgFQn0rfvqMB/9SmTQGM0rBL9b7BH8UPH958Ohhr2vooC8H0PnUCqBk5ARL54+AVQIC7TKUy8cK0ZeD5j+k5sXqLdhrv3vWRJ4jmlDgPYU6DJTEsCpP9vpr5WbOBtMcB3tnfuOK8lxRZzJUcqc/UhGhJ/6bHBKOBRllHZr4jd08sXA6XMqNqM+QiSMhKyxCbzun+tZe6Rr8VSLWRXjbR9afcSZVPTAvc0rx94nhvgkNgvebU5z0BF4R2gyOxPG9S6mH1zbU7d+xC8/+XzxG8xfH9If+bbmFDB4ovL4ulnseSKZ6oTX+rcXzmnxV6RgtwjenhaUkOgndCvot7w7cXpSOouhwlCBtLEeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d39013-ada7-4c81-d8ea-08dbbfdaa5c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 04:23:20.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rg8Y7CfnWWYLZQlV8mT7lihshaCcWzcDBEJuMJlgneimf6Yjnv97wYosviwtq7Y8lsc4oJw28n2V2dc7IbvNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_01,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280039
X-Proofpoint-ORIG-GUID: tGRDxnH8SSkO2O-1DRvWbgWqt-eEqHJs
X-Proofpoint-GUID: tGRDxnH8SSkO2O-1DRvWbgWqt-eEqHJs
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To prepare for adding post-mkfs operations support for Btrfs, streamline
the mkfs command functions.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 21 +++++++++++++++++++++
 common/rc    | 13 ++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index c9903a413cb0..798c899f6233 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -689,3 +689,24 @@ _require_btrfs_scratch_logical_resolve_v2()
 	fi
 	_scratch_unmount
 }
+
+_scratch_mkfs_retry_btrfs()
+{
+	# _scratch_do_mkfs() may retry mkfs without $MKFS_OPTIONS
+	_scratch_do_mkfs "$MKFS_BTRFS_PROG" "cat" $*
+
+	return $?
+}
+
+_scratch_mkfs_btrfs()
+{
+	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
+	return $?
+}
+
+_scratch_pool_mkfs_btrfs()
+{
+	$MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL
+
+	return $?
+}
diff --git a/common/rc b/common/rc
index a438a8de1461..2e602caa2f3b 100644
--- a/common/rc
+++ b/common/rc
@@ -729,8 +729,8 @@ _scratch_mkfs()
 		mkfs_filter="cat"
 		;;
 	btrfs)
-		mkfs_cmd="$MKFS_BTRFS_PROG"
-		mkfs_filter="cat"
+		_scratch_mkfs_retry_btrfs $*
+		return $?
 		;;
 	ext3)
 		mkfs_cmd="$MKFS_PROG -t $FSTYP -- -F"
@@ -881,7 +881,7 @@ _scratch_pool_mkfs()
 {
     case $FSTYP in
     btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
+	_scratch_pool_mkfs_btrfs $*
         ;;
     *)
         echo "_scratch_pool_mkfs is not implemented for $FSTYP" 1>&2
@@ -1018,7 +1018,10 @@ _scratch_mkfs_sized()
 		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
 		(( fssize < $((256 * 1024 * 1024)) )) &&
 			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
-		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
+
+		# _scratch_mkfs_btrfs appends $MKFS_OPTIONS and ends with
+		# $SCRATCH_DEV
+		_scratch_mkfs_btrfs $mixed_opt -b $fssize
 		;;
 	jfs)
 		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS $SCRATCH_DEV $blocks
@@ -1112,7 +1115,7 @@ _scratch_mkfs_blocksized()
 		grep -wq $blocksize /sys/fs/btrfs/features/supported_sectorsizes || \
 		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
 
-		_scratch_mkfs --sectorsize=$blocksize
+		_scratch_mkfs_retry_btrfs --sectorsize=$blocksize
 		;;
 	xfs)
 		_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
-- 
2.39.3

