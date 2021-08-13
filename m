Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA9C3EAE57
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 04:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhHMCA1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 22:00:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45244 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHMCA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 22:00:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D1vCOk029145;
        Fri, 13 Aug 2021 02:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=pEWgkQQxspOqOT2IFRP1+xn5SeVExSH2gGUyDKsSxJw=;
 b=RQv6P0QgCGCRkm2CaHvOUsBQBdDGT+y1LT11KMcVR53Ab6DdHsUCFpyP5yFLqI7GLXxZ
 7xo2LDKgnQ/MNr0iINym2OTb+oQ3/xNIYjOTJLYdVgQ7Uopf16RXv9JY2gtbBRVNim2r
 H3fYIy805A/AckBlN6tsa1T0FEFfiF8nMgcSb/jKYI8FQDQ3DWUgdsYhArtNcM4Y8epn
 tUPg3pAQK630gm7/lTvrltMG48Mw3mnxy+zanZPLPxVqYkkcPY/NmVNNGfOduG4ezsAT
 Hlb1rnf/ZMXFBB7cnKBx435HtVzTK+xSAOsUS9KWMnkSFQ8e7CBkPgonPVnEiV9BJeRR 0w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=pEWgkQQxspOqOT2IFRP1+xn5SeVExSH2gGUyDKsSxJw=;
 b=YF1jsd5Tq5Ag04Li2iYGQMDtraKPkbbgMk8as8I1ybajAXp1RDsOzZFtu+Zhecd9Mirc
 zZr6ZtKrKbqMAf3RsHHwpFGrhCEOjEMY6phwf6/YBGGf4XJzWlnaLWqKqGkpupmfGhkB
 WcbWYmGj03yXg63Rnkpy0rFCb0BAKQ9nmDZJ2spN1malO/0UzyoACatp7ufH0pBwchzC
 szEe72RK+jX06J8492dCKv60/gMlExDyUBciAOuRXUEZpGc+fXl9HJ6AuCIlQzXyF3OD
 AHd5KZVCsRKCL/1da7GERNX2teTfZQMcHa/Q55gJhDCC1kXuqFX7OL04TMj064UdMUl9 KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd64cbtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 02:00:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D1uXGW128927;
        Fri, 13 Aug 2021 01:59:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3accrd5ys1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI6lCcJr2OM0vFAbOyoCMh44KMpLkJrl3E7f7wvn+jtCOxp9vvFs+X/v031Q+2b8Zu007RqHcC38fR6qtsKtKGK36ztETJ8r3yJm7G5wEBPswDkXI/OqMxHt4tnyD3bnnCc3rrPyju2loaglAWfnPZ+Ittm50dMrjaiqBBxbyK6o35Xj9k/Rc+2Zhvna0Mp3mzVeSFOH9yHjae8+TwpMWtJR2HLBqERHlmvS+vsHPX3ElU2S8xjF8FJvbwDyr8JAU6o6l3rsbD1avCW2/pgnkgkpOX6N9kQ5t1pBdo4IraRAB26h4s0SOnZVLtmo3qAqw08B3O4Jri2fhkw0WEdc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEWgkQQxspOqOT2IFRP1+xn5SeVExSH2gGUyDKsSxJw=;
 b=Yk0Gdj+xFP2N/PdpV+lt6YeS+J+PqNHVtJATakkaWe6mEkI+C8FwP81JuVKdhoh9NeQi4S6wOtyWGw7uawst/KEcie7NB/25CWUN+FhnxGD1jP+2B+SMaM6pzdK+eKAg6sIkVzpERwhT2WNZWo4tZrAUVurGh7M6vCVUpCc25uO2GOe93gMtj0pDDDz9aUxDZQPcvWR7Aa8mmwjz2wyOw2xSVWZBSHk5hjvvSJesSF4d2+ZReXN2XqDyRT+2tz2szryPvIniKvm7i6M/n6eL90fm2pV2G41lWpG1sg3KUf12xjJXuW+ZG1q2kLPiiNDX1uHT4o8lT7ze/TiHqhSMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEWgkQQxspOqOT2IFRP1+xn5SeVExSH2gGUyDKsSxJw=;
 b=V8p51+t1myGGy2EATQAPxshvlGZq7ITXmFmnTpwxK8KlnFH+NrzvrcmgedN2FyAOiXUr2t95tbUP/qzAw10nq9V3obg/nT1AkwrCjEkjl4XqHVAB+wlbN6tlhlyWXesikNZ+z7BO2Y/ZtB1uxyERqTgfeYn/GlyHO9VAz5h3roc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2804.namprd10.prod.outlook.com (2603:10b6:208:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 01:59:57 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.025; Fri, 13 Aug 2021
 01:59:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs/220: clear_cache fix for older kernel
Date:   Fri, 13 Aug 2021 09:59:35 +0800
Message-Id: <6b714b7e0fcff9d89098b15246e58fcdf8e2b681.1628818510.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628818510.git.anand.jain@oracle.com>
References: <cover.1628818510.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 01:59:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9807654d-9237-44f4-e471-08d95dfe0d59
X-MS-TrafficTypeDiagnostic: BL0PR10MB2804:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2804370D5ADA6679C95F032CE5FA9@BL0PR10MB2804.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvtDbrJxKannYUJRRIbRS1S7SC25oHj4tHVdVF88Vj+X4d7ZKdiNg5PuVarOylSyK82j/Avb+EMscnezLP3rfyLipua5MstvqTWRk8xHM66PrXILZFPn4Liq0abMyWJ42H8Tayhrrae9PRy+qHyFX65YmdXJyRDYqRtdx8lKeXe+Y5I/4DO8j4fr507F0CK7fmq+d70CM72yrWXw0AQAtHWz/mRA8+qlWUa1AR5TrPUQ/iMYVqHXpBVkpQSHThCRf4t5hsrs6g0Wlt68pY3aPEysGvSCttAXSIWKqrgMPxTc3fD0kf6zcvrnxOsoAwC+6NOqv5PE2BF27jtU33O2OxS8NVg1MWP735wTB5hSsYZbbUhG/DSUgSJEj0vDT5dt5Zxfkcg8FdP8orRKAFE0ZTe4aWAiThTY8ot7c/UJi6u9EkzX3rxViZWcScwGTjZaG4D0Cc2eHcYgAiNI4fiPuvgRoNiQJ3wBnKFbnqqAqnlj31tbdYg4XLa9n14+RCvkSDKSaRfa5n4JyaKNT+CGXluUlnlNMVf7EeXQBDOtk7gLbZ/YGmS/O+qjqi4z7mplWwR7USbOZBjxdfu/A5e1sn1K0gcoXv2tpUgaX3vAOUfU4ewFE+8UwpYPop3kN9oEMp9KgBb00wRlxLgczKsRqcBvhHO1tw4KYz5MGiDDi64zmHvlm6mMu0Lflru5RvdMnbAtWWjVYYhCp2eGNJ/szw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(376002)(136003)(396003)(38100700002)(44832011)(6916009)(38350700002)(6486002)(6666004)(5660300002)(52116002)(2616005)(316002)(478600001)(86362001)(4326008)(8676002)(83380400001)(186003)(450100002)(956004)(26005)(66476007)(66556008)(66946007)(2906002)(8936002)(36756003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rTNWuRjZeAbfFosxRSvpsQ+6w9dyDGngBOrLBx69qSptJaIQ3aeKbxALhrz?=
 =?us-ascii?Q?I6OL6v8ePjQec6imdSdrr4NwVRA+hhnxuPYd3lCgoVMRoG/5Wjkjx4jCVe9i?=
 =?us-ascii?Q?mCpTUMoWOPWUOwwhOb2deuGD6LiqmLYrh33fAOdAnOTz9N08TlU8ci92q2Od?=
 =?us-ascii?Q?fujnYE3v0xfFlvelruwhpMjunKoM4yF7hZQCIHTddV6b4gyF8q87f6dwNquI?=
 =?us-ascii?Q?bffYfcCM77ONnp9pD1zKr9v3wKFwR3GtZDLIuGLKq9dD3q1GbSmu72/xuA0M?=
 =?us-ascii?Q?aYiZ5l66vGMa0U5zhdqBRmwYLWolhq/e9mJaUPa9KMtCdFhykyXUiJm1EWHv?=
 =?us-ascii?Q?vU4Z00Bvn/9AzYi10rW+hg6F7aNJnTVwnE5Ho/vcPCMZkihxPHFCm1BxttmN?=
 =?us-ascii?Q?9vmR+BnYia/EaoW/zJ66GFOp3HQ27d6C6zqMYd84cSIDRoUABvg69Qvdssxb?=
 =?us-ascii?Q?9mmv/mb1Qmv6C4L5Ug+kW6cg/oQefHaOT5PWjUUZ4rAQvD7QkOjJuQzJsJE4?=
 =?us-ascii?Q?oU+s7IvwpzufWC5RF+b+fQDqxa1CFxPFKlhidHyfImWQTmyBxJ4vx/4hY7J6?=
 =?us-ascii?Q?QSX9heUDE7I3th7F0+h/d/xfG7Y8issogQKD7S5PpV9xAoluxyZSZ2hJid5V?=
 =?us-ascii?Q?xJLiwCWuvfSMuDGOtRFF08FLCKg0wbBLJJp/+iUsRR9e0iHpzPFfUfHq1Wbs?=
 =?us-ascii?Q?c1L6zLcyxhatPIPCV4xx9iOMCy+GkCqQyi9tTkBiArnMb67yvxy7CiJ+xMEp?=
 =?us-ascii?Q?ZhBxleWnD5bszmtcl3SJFh2mflmZU+2TrGUKsjq9hCKrI2YrSALGX9sdaE6l?=
 =?us-ascii?Q?D5qpRtVHrss6qW2kQLKF8x5/wHYXKv+rT8G7FlfM474oAv6zfnL+h5KfbzDm?=
 =?us-ascii?Q?PVc/XJDGll2rLETw6QlX/RS5aEFK3W8WygVdN5XsXyRUzwuBNiq4MQYqczWg?=
 =?us-ascii?Q?b/tfrQWzHnLPtygFg07DIFrqwYDEAbzDuVs030+EQQNGOHZowRO3rL1Lvxu8?=
 =?us-ascii?Q?2KMp+9ixp+PIF/oA3RzpNoXjHVzo7jRm4mAfqga1hR8fuy3hZsU0xiXoQlW2?=
 =?us-ascii?Q?rbibyDqJGXoudVd9+ZLkiXAOQYae1/CPENVjASXo4NN7nYex60DjhMzQYoSC?=
 =?us-ascii?Q?93EuHFvkeH1RGu0+U0k2bzPuXiJKSC+AHYWK+Ol2/DepF4bUqkvIvFqSCmGx?=
 =?us-ascii?Q?zzEPhzf/KZBrREfu/qIV2d5mSjm0J4+4uRnbZardB0F2ZoAhMRPKuvdB4n4U?=
 =?us-ascii?Q?aDjnYBGhchNspuuHcdJTVq7p3i2UdrUatui83Ad/yVpJ9ECBFI82+Q331+Tz?=
 =?us-ascii?Q?w51wNan5BmY09WnDPCn8nHgy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9807654d-9237-44f4-e471-08d95dfe0d59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 01:59:57.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BD/H7Old/+E2Fj3K5z4PgvxL5yeHN8ylFzp8QHPK6px9ppV4F5XTSgYxyY3I+dndN/jRnsw5iNawCxh0o9BX5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2804
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130010
X-Proofpoint-GUID: OqzA6sLHkpbeZ6nTWhuAY3va027Mzdml
X-Proofpoint-ORIG-GUID: OqzA6sLHkpbeZ6nTWhuAY3va027Mzdml
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

mount option -o clear_cache shown in /proc/self/mounts isn't supported
in the newer kernel, make this test case older kernel compatible by
checking if clear_cache is shown in the /proc/self/mounts.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/220 | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index 9f2f07d723c4..fa91a38493af 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -237,7 +237,11 @@ test_non_revertible_options()
 
 test_one_shot_options()
 {
-	test_mount_opt "clear_cache" ""
+	if [ "$enable_clear_cache_shown" = true ]; then
+		test_mount_opt "clear_cache" "clear_cache"
+	else
+		test_mount_opt "clear_cache" ""
+	fi
 }
 
 # All these options can be reverted (with their "no" counterpart), or can have
@@ -316,6 +320,13 @@ enable_rescue_nologreplay=false
 _try_scratch_mount "-o ro,rescue=nologreplay" > /dev/null 2>&1 && \
 	{ enable_rescue_nologreplay=true; _scratch_unmount; }
 
+enable_clear_cache_shown=false
+_try_scratch_mount "-o clear_cache" > /dev/null 2>&1 && \
+	{ shown_opts=$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
+		       $AWK_PROG '{ print $4 }')
+	  echo $shown_opts | grep -q clear_cache && enable_clear_cache_shown=true
+	  _scratch_unmount; }
+
 # real QA test starts here
 _scratch_mkfs >/dev/null
 
-- 
2.27.0

