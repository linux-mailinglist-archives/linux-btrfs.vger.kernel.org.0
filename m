Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B867A08A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 17:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbjINPIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbjINPIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 11:08:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F11FD7;
        Thu, 14 Sep 2023 08:08:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EEpCAe023418;
        Thu, 14 Sep 2023 15:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8Ih8B66qPTyNfjsFWi4s2XaMM/r00pNiBT9kOYU99JU=;
 b=H0TmaDLw+KOxK2qbeXei2T8NrKQ0iQYyKEuC22A+bUpIIwA3fM6APX5q79AwujQ6bEVB
 ucjDTmg0yJEbHo68D3AYkg0fr7T3Q+Zi3eMiQRaZgZP6hOw8jeEJWSXtO4pc9Dv3xl3V
 zmybGdqmgtIzCHz0XJV0Q3IBWEwtJ8UUaItkvZVZ70uA4twlMb8ygNl05vbfs7gn0KoB
 W6mz88SekkyHW1reYn6MNCVrdHGc1fGQzTP/sXfBciVt4LZ8oXbQt3XH7I+9x6znTfsA
 ghB9ZWN/ez+ckCsc8rt4Zs5Vbbzws2I9Tjjcu7S21TeDizevu5fFp9rAnbkVs6oAD6dy iQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7pnm5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 15:08:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EEo3ms030205;
        Thu, 14 Sep 2023 15:08:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkj451s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 15:08:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvLlvt+b9UTyN/5Oo1bqX5IcpdNHQclV/1ODGkTLjbYg+R3CK0vN1pS5KKNnHk0akKcZ+FHC5tINAq7Kpct+gXOzYyVoXfl1mQ6kqF1AtshnpvNttQzAMjb8SBwpWYrVqumdRPd4Ri26bTs1GLY1tX/XHlMeSO3H/+9w6ergc9JIyXtAVPCCmz60wT6fzyfuc3xKi0qUyGaEYVhLf4gF7KZrzjCoaCUKBfyK6x3RghcJkZ+chHqM68oCVv8sXwq3p3EdK40tObx7QwB8aruOSqZkdh0mrGCdhTnwo+SpENgyJfsrADv+y+MgK9eNZPn79uXqzUHmyKDf16PWwDBrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ih8B66qPTyNfjsFWi4s2XaMM/r00pNiBT9kOYU99JU=;
 b=hm9lbJBXRyLPyMnAD1MdN3r30TriMDobvCneHxGByEDgGYRxeFjJIPPsLzAu5AeFViR5mh26s8fj7s0EdCs34Srb6YgOP9KbY4xJb40tRvAMKu/O254/ArjNmlWatNq9KQlFcwLXT/OHGfgrsPcDlOPm7LCSYWbTShf+jyw+m36gQnOHYe8PHCK540/KPUovrXW0MhhlUV/G0E7SxNbFLD8Yc04i1LCSynWggx6lGOmPakiMK76X1zeAB6ra6WEcxA3PHEFX3JnGr25Cxd2yJzfSUdaz9r5jS/MX0fh/BJrRfBeXyTEgo+RhAtbZlRh6PK1gER2K9/MeE2wkGZFeyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ih8B66qPTyNfjsFWi4s2XaMM/r00pNiBT9kOYU99JU=;
 b=gxhL8n5UWqupkOYPP1vgIpOKL4EvzTsHjxLaICcIRU4lrinmB92QCWoh6yK86nHe9ExZvQpVmnqx/pSrwTJVIxsTeMXnyw3M6z4U/LGJX9l1g1qZTpf6ocdayH0sXnMSZxDzzJfoxAj5q+5lRLAoTqqvxTT6KlgQC3wtu46u9/4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7137.namprd10.prod.outlook.com (2603:10b6:610:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 15:07:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 15:07:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v1] fstests: add configuration option for executing post mkfs commands
Date:   Thu, 14 Sep 2023 23:07:43 +0800
Message-Id: <9c6d36835c04f18a59005a8994ba128970bac20a.1690446808.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: a219aac9-c864-434c-294c-08dbb5345d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxv5QHMcDH+SpqYekgRaMQSTovcKc/q1KO0r46DTlmdQe4zsTKM4NdLfD7ZjNsbMfkRj2M5mabtQa1kQqsvhwTpWxSGFUxbkfpyDlhQMU/Z0af4x0EsdOg5+/6k4kPOUz+PxCAS3oOgs28ssyHlpmOL4dyz+vexSwxpS6WdwwhrTsh1SIHC1UrVU6/46Zq6IRhFXd2FgT7r64+d8/6MBeWRXRmZ7qULUPl1wkm3JiZ/9jKCe20ZSQ2s0Ysdln3frQ5m30PuhbkBwhT5Gld8jiaZ2dP7RiEEOBx0wX5VvnjTmjLZugv6xqz5Lwe7PJyhQuTUmFHqw9wZysPvGb5kcsbiLnP+wX01Y11J+K+3QFD2/eNOjc96UQRoixdd1QVaMQj8kK2o//8kX4xfEHRJJL8iKZxlziyh/68Xgy7Cs2UvJPIWVNruGNTzsHqbKAI9DaF7IQPIO0mZLANTOprJ72ctO+9TH5n6Qmbfyh+4VnmnnML14wmxqqWGRU6DmHImG+N5rwH6w9UgDo9lHyAkQSrJwMO2BAPjqu09TDUdDPEg6rUzT0GSQwT7/8RCKYZPH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(6666004)(6486002)(66946007)(478600001)(6506007)(86362001)(36756003)(6512007)(26005)(83380400001)(8676002)(316002)(2616005)(38100700002)(6916009)(8936002)(41300700001)(4326008)(5660300002)(2906002)(66476007)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MIPh0FQNtSY3iVfh2zI5IBE2OmHUJPy061PPjXM93L63WuuOuL2N5GX1K0RQ?=
 =?us-ascii?Q?Kxha0LM98XWeQe60pDh96FCXAo8R2J9SoOgzmLzCl2QM9Kvv2DyDt+/1+bgH?=
 =?us-ascii?Q?V3+nKUgcwx+EfeW7Q1JDjS4Cr3icA/QMkaIcYHTPLDOTDcd5IfEXQan5hWQ2?=
 =?us-ascii?Q?43fmIpKQyZKcBMh22PTzmtqNG+VGZE8Ajkx1YCdLu4F9M+6LCljzX4q1HkDM?=
 =?us-ascii?Q?UcvLju9YGaDiM6ekjoPoIXdov3vJwIpHwAWUCI/5rL/Co49M2LdnFR/OUCNr?=
 =?us-ascii?Q?9JPs6n5Ca1POY4QDAgb3/JKkC4F2Rlf2+fnQDO7hbLU7KXjdyIg/CcEYBkCA?=
 =?us-ascii?Q?aDY12BY9Wc1p/BdNnnKJiyRg/xvsZVb9N1wJDM6TcRqXWfvLPF/P8J5MW5wV?=
 =?us-ascii?Q?liotnJpUeWhQVCFnz8/Ru1oC+QdOgLvQ5R4GxNb/ZXIVu6uAkQDixbkODXIh?=
 =?us-ascii?Q?D9p0G8CfZFqb307bGmHL5mOw4J8d1svRYuGcpcm8roZTTh/bti/Q/uPi0Vna?=
 =?us-ascii?Q?fg7896st7HSFrjRgdR6o/bdGCgepe49XvyF6pTrySjYXTgM5xYXx/DGbXbs/?=
 =?us-ascii?Q?ivz50utfOo9XrZDq0ijmxhSjOuBHvtp/aMSR2FayKBXhudojQ+WreK1RKZzu?=
 =?us-ascii?Q?o/skBHjAG+uQD2BrXbEqUnnvaKqiUj8/q4UiFm+Mi7OKoAbFQFrpH0qvu4Ts?=
 =?us-ascii?Q?3pccvOG3+9cEWSaM7HeQelThd5zQj2OPmpBZhQgRrNTksSQIpalncx0HM+Oc?=
 =?us-ascii?Q?DzqX5w6FSRTLdcF7N9ZX7qDTEjpe1Z0qonPLsGxUAs6A+mRPsEF+tzgKL+GH?=
 =?us-ascii?Q?zr/ch+Z0krIwSdntqW2d2VyY3ImEi1VsgayFYbYVF2vu8aZruQqXUKg4x4yT?=
 =?us-ascii?Q?YkBpj3+76DGpoR906t6+SWg9zsxCSUKoQMu4eDDOW1b6HQmoKBQ/LejrEVIZ?=
 =?us-ascii?Q?SVgw0LysQdAPcmpXDQLrUfgv4mvIcm4skQ/yEniu5ey8lGYj7OtSkkpAOzDr?=
 =?us-ascii?Q?ccZTsHQ+hqDYHRWLlEqW4HUbp4KeuTwqhZh4Hwgy38zLKv6DeF1hwTTMFiJo?=
 =?us-ascii?Q?b6Rbx1nhF2RmOM83BWjq+AysGyMakV8kF0aZb2qD7Q5/P90obO6Wue8Hqtok?=
 =?us-ascii?Q?zIS8aUZlNDStUyqntIXAPFGwQMtt4zroxJEHpq8yuWWdm4z/Lrn3BktQLU3O?=
 =?us-ascii?Q?43rU05y0b194+CbSlOh6MX+t8U+6GMZGIOwpPyPMKg9qxQEWa2hdkMuT1yRR?=
 =?us-ascii?Q?h9xjW5sEe3oJNFPrwikvlx05q/dEjYnVOT/U8sEJ8Ec7iXLaYs4yYRq2q3Xk?=
 =?us-ascii?Q?drKxA5MuRcMtDNk2kAA/eJCJoLVkxz26W2Nfn7q2kh/QuPn2vu8gYQVcBEIp?=
 =?us-ascii?Q?MXIhCqThI6xRFKszDjPPN6cv5xP8WfvAQ0fq+oEZ0Axc0XsAupaMTnRRik6G?=
 =?us-ascii?Q?9CqyrVSgIuBNirotnDRqYly/G4Dpm28GMGNSuOWZUBoV0+1MIS/dWixvAqtJ?=
 =?us-ascii?Q?ZSXRWsvk2KehKmKIfoNNd5X1ayryC16/nwgYfwA26B7Mn/PtGFKNQySM54nu?=
 =?us-ascii?Q?+hG9b575hI4bbWYZaKIXfX+Q+NCZe96OXKWccr8FV1drWcyqYhKbcSLI6ED/?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X0iuyCStoKkp1C+HnVmN1vozF6qP97RInALCAE8D7s2MHgtzKrkgwAsYe3fX/TFpULwQypJ6d1DuiI7huIhhvWI9lkBvujXzccGC7b4tElnAxcRSa/qt9lOrlT0ZpjF147QME0EvWwANFjEGYDxya+UOEkpBeL+9+qAtVEAFsWh+aomBxiSgsLJTx7uI5OQqSl87VWWeOJ+jAOIpW/Re6cxq3Ui8kJcalkn3Gh+Qoyj3stD5R4F31ZKd7bNW4qoKQ7rji/PzX1uru6BXEDW/VBezfZvcA4jVemYe18i/e79jVtRPyvYhEpof1G64ik/iZ6/7SpZIfBgLN7An18hMx3Bsh1ps61S5njKU7HrqfP86VsmdXkIQRoL1WkZh13ejKbx2x+J0VGHSauwhAB0Y2eYzN5egu7b+SEDutzea/6dJOkTkLwhqjqO7gOndLlf03M9Z6WW9+nk4AQFYykC8tNPRc3+iRLqx7Rmo57pfIX5kTkbtQbC5ZHMtX5I3AKpvnGBdLelwxYv7dmabgZf2ILPqs/EzrVf6JomNerdpuj6EWkG10EcKtRsUKj9r3iJajh+UbENUiik42uvKl9X7GTqkHUueGXXzVIsLqUVr73u1Md2vQJ6m7JcJgVPV8lrsSQwsEB+ZAoKghoa/Rs7qdAZwiPXYuc9e7J4r/sFE0qCrZ3YkPvA7+lg9eCG/5wc0GWpDGFfW0IXqT9W6BdVVJINgJePH4LOUQWlUILuW1qLu1a/6BN8BddFRMdVniHbpKIQUIgvjxvkUshGo9ncjUuQpcFZSLlRftXb+mWX1UH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a219aac9-c864-434c-294c-08dbb5345d02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:07:50.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJSOmkYuAEp43fFNliZ0WG3rv+s5RTS89Ea5ADXVi5WYX3GuVD9/Lmx+Lgs16eOLmr/4gnNe/MiDR3u6UOIVjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140131
X-Proofpoint-GUID: GjBRPCJntKo9SC496655Jkw6nAiD91NL
X-Proofpoint-ORIG-GUID: GjBRPCJntKo9SC496655Jkw6nAiD91NL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces a new configuration file parameter, POST_MKFS_CMD,
which, when set, will run immediately it after the mkfs command for the
FSTYP btrfs.

	For example:
	POST_MKFS_CMD="btrfstune -m"

Currently, only btrfstune's '-m' option is tested. However, there may be
more btrfstune options, so having this parameter as a config makes sense.
Additionally, there can be other commands besides btrfstune.

The mkfs helper functions in common/rc passes the SCRATCH_DEV as an argument
to the set POST_MKFS_CMD, which may not be compatible with other configurable
commands in the future. However, as of now, since those usecases are still
unknown, we can modify it later.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC -> v1:
 No code changes, only commit log updated.
 This feature has been a great help in spotting new bugs, and it's set to
 be really handy for testing the upcoming feature. So, I'd like to bump it
 up to v1. I'm open to feedback if any. Thanks
 
 common/rc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 5c4429ed0425..3e3c84259f38 100644
--- a/common/rc
+++ b/common/rc
@@ -667,6 +667,9 @@ _mkfs_dev()
 	exit 1
     fi
     rm -f $tmp.mkfserr $tmp.mkfsstd
+    if [[ -v POST_MKFS_CMD ]]; then
+	$POST_MKFS_CMD $(echo $* | $AWK_PROG '{print $1}')
+    fi
 }
 
 # remove all files in $SCRATCH_MNT, useful when testing on NFS/AFS/CIFS
@@ -757,6 +760,9 @@ _scratch_mkfs()
 	esac
 
 	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $*
+	if [[ -v POST_MKFS_CMD ]]; then
+		$POST_MKFS_CMD $SCRATCH_DEV
+	fi
 	return $?
 }
 
@@ -878,7 +884,11 @@ _scratch_pool_mkfs()
 {
     case $FSTYP in
     btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
+        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL
+	if [[ -v POST_MKFS_CMD ]]; then
+		$POST_MKFS_CMD $(echo $SCRATCH_DEV_POOL |\
+						$AWK_PROG '{print $1}')
+	fi
         ;;
     *)
         echo "_scratch_pool_mkfs is not implemented for $FSTYP" 1>&2
-- 
2.39.3

