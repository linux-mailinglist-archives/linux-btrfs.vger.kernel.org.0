Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7108C782603
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjHUJFh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjHUJFf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 05:05:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5037CE;
        Mon, 21 Aug 2023 02:05:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KMaSH7023930;
        Mon, 21 Aug 2023 09:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=U/bYBpHeKIdkCZg5Z0kgdk8Z/Pp1jAxmtK15nfhP5hg=;
 b=VTlZPokTWq/76f+dG1QUYKPeIwCrnwWlORg4w8ywX66BC85mELGvn1RW9rigyV5XPYpc
 bjCzL2irHvO56cWrYH/DeAPlSW1H0YrK2wl933RdtFOe5/OanEM9T1mMw+8RyLBMQNJi
 fThwOnM2+JmDtMrmXnZeAVLuplx3EAHx3HEwpzSASEieH9yzu5fXphic8o6A03jDX6cS
 F48eo1WSbVUacJ16VauAFBH8w1AVTknUVUUopp54iOEmq+8jSJics5FRCmFEYf1mlBY5
 N2BMKwMvp6mL6RHjMhIoR2xz90Q6JhGmQ0lrFchX6V0emXihFHg4jgjfvsPJiA+y//R+ vA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjp9uabx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:05:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L8Ak7O026733;
        Mon, 21 Aug 2023 09:05:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm63er71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKPQXn83adi0t4H232f9iUe5ky2Mjcy2qdV8QPdHVJWlLC56hDD9RTYg92mKJQbO5fHIpCwd+9vPOOA399P2DaXZmjlI4GRk/zZcysKUn3T1kmW2dfZsQ2bQxrVD93nKj+xovSAZ3/Fxjf4EkL5Q+L7/t+lc3WvWXwerehqzGTS6vD+ORbkGzhxij46IYU4Oe2vXStvUNpPQsJ2CsWd6Lt9GM+1SPQPURhtz2c8ehrO7ScbVUfdSzgYtKLuf0gZdUnDeOv+2J5i9WwFeARKlS20CeNF72nRFDveyaoq8KQfUMne9e0R+EO3c6xwTAD4otd+dnYdj2wrwLBmJX6jlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/bYBpHeKIdkCZg5Z0kgdk8Z/Pp1jAxmtK15nfhP5hg=;
 b=d9NHO6ee7qq8JgfCQrPhRxCGwAxQyh7RAy4sCVvSRMd4WAZg8+NOc50XeLKf6PA7BHN0ndWMoh0Fz0kdKj9aX7DttpRt3hIKJwPelzKfomcYGxnqQoKDvWZY3NLzUyzVXb4ix6F63eziqEOmp55l7cH2G3zxI4YQG5taB2b78Hc6hbl/NJ2PxK9+andMxoADnNRdxiSwPZmK72dPfAv6zownomudWfJ3nIAAFhrZn0HNlElvVaxPN0K6JQ31Hu66/Q4kKW4kMN2JW9DjYeLq4/NHwpMj2p/64sH3zD1JfLOzqaxwka9RGlzTnWPrxvu0cfZatu4IEH3Rr+658q8PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/bYBpHeKIdkCZg5Z0kgdk8Z/Pp1jAxmtK15nfhP5hg=;
 b=Ew8JfoyNsOoEZ6ARoK7d1tk0CYE4cU97D4wcdmh2RwKviV/3ELQx+T1NLU/DZtu6bkHF5x8PoMX4pNUC4G0YF+1z4pcUbdNtfqg9qxa0FZn07OIySNZUNT86YIVee1QPubyXv8zJ6fKv2BzycDqulaJNlzb4KRH26s55oTOT3G4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4987.namprd10.prod.outlook.com (2603:10b6:610:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:05:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 09:05:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: use btrfs check repair for repairing btrfs filesystems
Date:   Mon, 21 Aug 2023 17:05:09 +0800
Message-Id: <28de98f456031353d34be71fe7b71937d3ef3e4b.1692600778.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <2c89e68e7a34f1d0545f19e9e178e258f777c027.1692286458.git.anand.jain@oracle.com>
References: <2c89e68e7a34f1d0545f19e9e178e258f777c027.1692286458.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4987:EE_
X-MS-Office365-Filtering-Correlation-Id: 7483d55b-811a-4a69-f191-08dba225c25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeF3KDX3pVSIcmWkQBZ8Tj8rVv/hnc/3t3d8CCG1Rnxyb/sMDaOMmmhaI0lsw00CTelmN0HVm89lfK2MjizKQDQbqY8/WyxIbrSmIgHEVsliX0buAIIBb81Xolnoqa9GMYa39CC4dlVw2VswrC5TDVCxDKUCt6gv+/7auUD6NgQq8MWbjAUf/gokOAZXewcefExEEsZ0PiyYVeF0Ph6/RceSKdnlydCn03EX8SmY8olFGmR+1dLe+9SPgnupDEgi5BaWus84JJ7T18ExwizQeh+FX7XpkUWqaj9ffq5w5gwALeICkBEoFu9si6djEsYld2a3K2ME6tazcN+1Jpg0/D2M4PyHNcV0VKj0BeDEDL/4JdeBqiKxg3TYXNoZxSKGeL/gSLsAnfOuek09YarZBPmjEt6vXc8JNAQAw/1m/ttU76anI2UdgOU5HRxkexG3CNac6qf5+8dOdC3R+F0+olp2p8zdEHw8A90kHxWu5aaV78mT9zEDr9fm62nt3q1N085YajpkV8XDG06WOtoTtB72lq5YeWSLlMlGb2DRYsZQRUdvdiv9DvojOB/iHunz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(83380400001)(38100700002)(6506007)(6486002)(5660300002)(44832011)(26005)(86362001)(8676002)(450100002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6MorunJkS9FtHCxG80+AhRFopHhAqJm2qce2Kcjsoj9sHx/xM6hHPdUeCcv?=
 =?us-ascii?Q?m9ZYtNlL4Kz0zh+347TMqnaG3R5rKuPIYN6uXTiZWSf/jW5rrc7I8lZ+cPgL?=
 =?us-ascii?Q?8ZOJV+4VvxAcuPWvh27WKIg5L5RoEMwKbTY+kkPOa7Wyvv+hFpUSw0Xrs1EQ?=
 =?us-ascii?Q?ByfWnUPIDo/+/2I6nqpsNQk7c/kMTLHKi2xYWVV+U90RwhrOoxhufBkFXZpN?=
 =?us-ascii?Q?x1DrIu1wryHEwlZTb1mrL4dK9OYUROG+UN2iLk4kHCF8zlJXbugV58XPdkyS?=
 =?us-ascii?Q?3hMaXVbgAs/Hod/M2ENVY5xZc/Rts5ThXImlXh+vxK8Z8nouqeE7oFx8U7jn?=
 =?us-ascii?Q?FSCdkUdevPPBhmJmg12kmBy06HVk2TPl26A6jJtJ45jxrkkq7i5azAtTuy6P?=
 =?us-ascii?Q?NXXJTs18Lk7hv4GX/WF89P9JYeanaI2K15hb1/OI60C6v8QIdVA2wqqaeNlk?=
 =?us-ascii?Q?+gPW2OkfnUJERzWUISRW/cvsKe2/SVJa+weY9Af/EpKC58qzIzYlPYHvSzzZ?=
 =?us-ascii?Q?kh6izN1Ax2jyGHnKFQFEiCCpmV3qt8cRZa2gyn42o8bln3x3r6pHhoIMFjuY?=
 =?us-ascii?Q?c3cH5fady781QaQKUeJCVu7/E0/dlqzbjIo+bHF52c+3abDJZ0htN1R0qwdu?=
 =?us-ascii?Q?2NxyUQsmbF5kcsIszemRx0icFnFTgRHuQWp2fFz1cD1gUs0LHEC3loMIHTyY?=
 =?us-ascii?Q?SMZkInIH9gz4BLdhk88+MvWt+A7tua+C/XrGgcMcHPIZcj7+Fe6YH2e6GUUN?=
 =?us-ascii?Q?NIdEXjjUdN9HPZvY8/atAG7uud1cetd5yeozRX+QtEcrKTC6B+WK4jC+bnIb?=
 =?us-ascii?Q?YR4UmbV74InCkOzQsh06BntQu2M5T6LJ55hnY1rXtWuhdWEzcWlzKT6cfrjd?=
 =?us-ascii?Q?MbhRvxRtOyGeFwCDxb+I2jeVZwqg8331D+rqQXvOaI1fXE7SfLZ8kHbsrDma?=
 =?us-ascii?Q?5tphLdilFPn9J4ZEBvgD5Js+oVzgRaT1MlPcdnAcwmxtEqa+/GHOpwFsfg3X?=
 =?us-ascii?Q?BMJCHFymlq8JmYFGJzbjWxcVHEuH4viAAGEdV66PF2mi0t8DP1B84tG7d9w2?=
 =?us-ascii?Q?JkW8hXns1i7dVdFl+WS1uMRRUIys8OPASKrtDnB4cjJjEcts66i2mMg67iVZ?=
 =?us-ascii?Q?AeRm/wUWxSi1mTAPCzwtrBdOM7XyUBrVkZV9Fbf/BnfarioUtZ+f7ylEOLkG?=
 =?us-ascii?Q?OV9JGOpN1cqexh51B9iGdRUee8bOAX8vIgrmu+3b5V/emIjmnRNIIayAB7AK?=
 =?us-ascii?Q?couLMoIx0buzLSHOMk0Khc+exiKbrmOtw3R1jB8VZIcxwk4tqcvOZaebDi55?=
 =?us-ascii?Q?QVCaovHlljE7JTsxoiyppiHWVTOn9jEWFrBRo4DJVfMVq0NsEunjMCQ/Cn7J?=
 =?us-ascii?Q?VpRD4Var1Ijf9baDK6JqCfb3oXJrNlbExYgTEc02onmOUUi1NI84ahbtTbVw?=
 =?us-ascii?Q?FFdnifmk7HoViX6fAHn3X5f+SY5n9wlfXu6MiqrU2hVa9qhd1FmfJglT+wId?=
 =?us-ascii?Q?9FZ4Ha674dwL+Ve9iQlKqNHOQXiozOHH7o0NxxOOk6zB+YdnlrQbyozXxd0j?=
 =?us-ascii?Q?PbHOVgUmHr8fsh9cI+cqvPxiBz1wjY9x0HGiTinYMwQVxwZNYXqesPPaHees?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AAHUyRQfBpnt7p8gGOiRq/ygvu26Lp37nkFSFdYxIP36+2C8Rqwzj+Yip5x+5Rtsl9thqO44IzB7XGAPglbCeV6He2fX4r8qjwYJCONCD/xDLwl/hLjQK/b+7Ti03xNl5TeXLZCunGBqmJHRa7eNBWbj/H1RCSWsDszH147vlES/7qVyi7e5YIhnq8f0lKIdcxlN0WADPrv+fU1NihZNLMC5Etz3ek6sACTBUf/qBCSaPghdxWkuBzCB6qri+V/+gSnWo9gq0BDo7EnS581287qOqBAHV/4Ug2IwwGWHJSyVciH4yJtpjVyf9z7dp00lTWuzBJQoleY5Phrj0VK27NymjUJZWE3fX0UoBcyc54lpleaEES7R5GiNz+0hgM3DTznlNrHpfzdKB0iEkCC3HpC4xSm+fAYqiwi/PWzylTxR4e9dpQ6g/GYkosVOjH2g80f4VS/+a8vUOy/F/EOJrp9byO6jJxQb2O7bsgRmKk3UsxzYxUpyAhV76lejbD6/2dp0N1DmaiJhetK3dUWEYI2IPLclK/EJFqMUUUUcXl6Q3cdjQYkDQsSC2HUdWXVhneo94ssR+NGFtFHNEXiXzGCfGkphKF4EnJuGncoD/hEie+GWDsOrt7C0fNz7rf1bYYRG4vDqbK72pKm5H9skuKsOxNTqqx2+ogVJC3N4hP7/rNlwiLFi1E9ZRO87kqvEGzlfnVaFVQPw0fJnfWNdZwWreCYVVhUdaoywo+c1nkZPJAgvPYppC/BVFbFGeANwjXy/PxWUPGgGbQZnuks18g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7483d55b-811a-4a69-f191-08dba225c25c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:05:26.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgfy7Ek6NltZhEhweGl2eTZdzNTVtCrBy1y6olGwPSNZH/N2Dde4jiGqCjAlBH6gLt4S4FT4uB7xGqPFtrV2zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210083
X-Proofpoint-ORIG-GUID: mjNxsvP0bxPX4ZJohOhrhjRd98N-gDec
X-Proofpoint-GUID: mjNxsvP0bxPX4ZJohOhrhjRd98N-gDec
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two repair functions: _repair_scratch_fs() and
_repair_test_fs(). As the names suggest, these functions are designed to
repair the filesystems SCRATCH_DEV and TEST_DEV, respectively. However,
these functions never called proper comamnd for the filesystem type btrfs.
This patch fixes it. Thx.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:

When I reran the tests, they hung because 'btrfs check --repair' was
waiting for confirmation to fix the tree, despite using the '--force'
option. This is a bug. However, we still need to support the older
btrfs-progs. So, pass in a 'yes' response.

Uses BTRFS_UTIL_PROG instead of btrfs.

 common/rc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/rc b/common/rc
index 5002369b9b34..45cb56816c05 100644
--- a/common/rc
+++ b/common/rc
@@ -1187,6 +1187,15 @@ _repair_scratch_fs()
 	fi
 	return $res
         ;;
+    btrfs)
+	echo "yes|$BTRFS_UTIL_PROG check --repair --force $SCRATCH_DEV"
+	yes | $BTRFS_UTIL_PROG check --repair --force $SCRATCH_DEV 2>&1
+	local res=$?
+	if [ $res -ne 0 ]; then
+		_dump_err2 "btrfs repair failed, err=$res"
+	fi
+	return $res
+	;;
     bcachefs)
 	# With bcachefs, if fsck detects any errors we consider it a bug and we
 	# want the test to fail:
@@ -1239,6 +1248,13 @@ _repair_test_fs()
 			res=$?
 		fi
 		;;
+	btrfs)
+	echo 'yes|$BTRFS_UTIL_PROG check --repair --force "$TEST_DEV"' > \
+								/tmp.repair 2>&1
+	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
+								/tmp.repair 2>&1
+		res=$?
+		;;
 	*)
 		# Let's hope fsck -y suffices...
 		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
-- 
2.38.1

