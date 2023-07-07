Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD374B4B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGGPye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjGGPyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:54:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53071BF4
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:54:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FmRQZ032027
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=na+cArjD9VuESPBUAnkvnGmVnnuhhVZyZCBwJMoHG2M=;
 b=iKN3t80pmNSdd0Ei1BgvedjWVnKMHTczPp7uaaXHb+3Y2O7K05YBABJCJBlc5aPRSuoD
 I8Jy2Mje+8Ry+ZtINk0S8czhkounwH+bxPCvYcg4Jjg9+i8pZulkQZh52gHCtT544+bm
 34PeHa/ag+IDkgvvzwG1syZ8klz+8MuD5JkdE74PfxPbJ7dlCTfoBGbwgKu7OiZGecC6
 wFSYtI6lweRSUXc5ot2z1NyRJz4yQmUxj2LyexR8kWpRzE5chpqggqCINLILIC8AQUzv
 k2/lkfhusdXFbbX+D9+jcbVvS4SRbU9bfn/ysO/Dc0NYGyWa6nbOGTBgO0wYriS3njav 2g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpb4xh72u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:54:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FadZa013466
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:54:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8mtf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR5slazWa49WH9zEn82QjteSk4IBTo8hPU2Xvcze+Rf9DRjbDoPXTlw8XiFfczwDiXnUec9WRggnym7YNWG+oNegER1df7+7jtxrxTZyju6R/cKgHIXHdnFDXEVygTdcAIXTanFBUYVXCAgbBoBMXxBqZD8kv5s+/puZA8ow8AlEDmZr1ykCQmujhT1wNa89nIVn5jK1t6pqVr6pav+2cXKx7y3FFV/zSvYfqFoVk8mdqZlGE00QiHv7qec1I42b+Pip6d6mTbiDRSzocdlpk8BnI5bMUY/72kM6nu1MxJ1iozjd98/X+uNIH45xg8OWbfkrrE9N7/IYfIwQxv+9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na+cArjD9VuESPBUAnkvnGmVnnuhhVZyZCBwJMoHG2M=;
 b=D4uaczDWum74FgIdP8HCyex0jw7mYDj+ZVZ/2auxiz4u6C3wuZT8hsp1GnYMDOvgACA2VyugdUUZ0nITi5vnya38gIenUecF8ovd8nsjhO8nyOrhNoFK8jzLabN4jWtCI4BuGmGpuzCbj9oeZZiA+N++ChGJW3dO6n6f2Nt49dUnV5mIqLq7Brym79aKrKKhv+NoWe/WUfvWDLu1k9RQ8TMr7tuN9D7HisyjpShJQGxZgCC+JzP2q/3QdR3UM0YwgGMV+gVLnlxiCvvjjdGPqS4zeNxs6RHouG4a0L2z5VPb0FWS4PaDXI39nAQH7yahg7SbF6EuA0mgWpc2qE7xtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na+cArjD9VuESPBUAnkvnGmVnnuhhVZyZCBwJMoHG2M=;
 b=dslvCoHk/QzGky765PzHAC7p89ox39O+W87Y8lGu5Y8tJTROr+vX+ursYq3gjcM/dpxGil/FP2juVfKOUwAsg4QwtbxNqiH4jx+/+GVI7Xu/U66R8hMmrVx1faJuFghISOS9SN7EClXwRUFyIrhD7aOjGJgQRdphnvDIYK0bDSo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:54:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:54:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs-progs: tune: fix incomplete fsid_change
Date:   Fri,  7 Jul 2023 23:52:41 +0800
Message-Id: <24bef15af8c65da69ab8a3b574e0da7b71295008.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2a8b3a-d5a0-41e1-6bc0-08db7f02653b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /uJLPargDbNvi+Jf9EDVyebXgWDu7e6Dp9KvvPH57yJrSz3d5oLwuZjLf7E7zPHPXhOWgmKCz6qgNOKaXSBmRWi22VbFag+hqSOwbpEI/v1LHyQTAHe6h/OilsRhggkt44zTv0fVTHI3xHUz7zwI7J26NhrYUpx1EdB0NcI0Q/KMAxmtzrYmdCvG1iQsecO+CIEF8gKnOuUonHij2K+osMhDValEswu7eAmhFK3XGwSW3EUcyQ1wSopxGCR/U28nU4gKRWvrl+O2pBXTcCzDOp+jHwpUADggey8LShpUOMkvc7OQWOqXjz22r1GnISIAxTpnG55VXZe5Ud3uG8PtnwiyhdsUTcF2Kc+gUY9P4BZfKt3a07pjKfpBQ8cctwFEpfhxvdPMMdfIeik+C3J799Uv0PG8dc/4YeT3AKJlyxtjoVSRx5FOPYbWut7y7wYOiUByD1kHRHUMCUjszySGgHdatcV3s/pYiIdeVR7ndVxCheF6ISx2N08mk6Klk5lgIKt08coFfs25cL0WYVB22eXhDcyN3fib0sNjhmA07Nn+F4/XLeKPGuTMiH81eh5U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(8936002)(83380400001)(2616005)(2906002)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(44832011)(6506007)(41300700001)(38100700002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nAeMQ7Rc+JiCrEZlhm19qXd5lMXxIr5iqSAjEAS116MKZ1fg57BLwBfapAZ0?=
 =?us-ascii?Q?1zvORHMU6Pkt3AbKUDHD0bMSPHrYcEsEBpB6itsfEIuCxt08JAXbCcaoBk1J?=
 =?us-ascii?Q?UrUWTEhhAVVk/jRaLQw3j2X9IPZzWIiLTP3i/dhBdNUQ4s1OZiwCAEickVRe?=
 =?us-ascii?Q?bBRN69Nf+Fk98A06bK694kF1k85CvW0EgZqX9v0RG0vMryQ0aamO3UAa2VbU?=
 =?us-ascii?Q?JWFGOr/2LPBxI2xYkpFTAJ0Wxxev1QSXFEVUKRUJk5810ZcUwThntkctmixd?=
 =?us-ascii?Q?5+d05RK7wROpm4sRTlDc+oUV8jRtl1k536znPAM48cFAZ1S0hfI76JyMwlTU?=
 =?us-ascii?Q?dudvLZtKz98gdMh8+qiwE5V167alE0WnHQDpqNBXDYqxeeO84wxe3iyWINLH?=
 =?us-ascii?Q?DjtoxkQB7WIk1J8HZecocOCP2sN+2NVx21WXOjsXXeq3mzVmV9XIoHvElinu?=
 =?us-ascii?Q?rYgyR4wVIXX+b46llECX3wGlHhkvS9y1/3nLXnoJk50Uig21ZxmJfTtAZoDK?=
 =?us-ascii?Q?kjlyRturawwNYZ63RCNtZgJCFCD5bjBLWYT62RNy7r+eGB4450YkCcaFzl2K?=
 =?us-ascii?Q?dWRc9LTccW+WJeAoxNI26ffqNma6VBIGJPtpsYKC/070ruLAco0KExg7vYl8?=
 =?us-ascii?Q?KykCCJDgO4QJgFbK/B3KdXZtpW8Ksd5bVKTwGnshxcA2Ibm3NdiqDruV8HhR?=
 =?us-ascii?Q?WbImW2k9C/pEtYVolr/ARAHy+0Q0LyohX3jvvn9JTkJM5VZas6MdPqmNKCOv?=
 =?us-ascii?Q?78GDFabgHaDAQsdlonb8Sj+oEU8+fJxYVgD9/Kl4J8y1tmCJzCP02FTg0K6h?=
 =?us-ascii?Q?wVD5b5v+TSC6pipFewRsTigTqI6pIdKZ22+wZIBxk405tPl13W0uij5r1e2G?=
 =?us-ascii?Q?IV1pFX5smKhHbueDQ/BhvKO2V4TpYowIh6rtfcalYouxZyCOkklT5dXKYj7N?=
 =?us-ascii?Q?Y8vVjsDFzCF8ZHfNNw/LcLDsbe+TCIdthz6jm7llpF2Qw+/iv55T/B2msCU+?=
 =?us-ascii?Q?AEOeAKusKFquMoAhP9n5ryms/Z3lB6ITwKWSBVbc1awttcnADbGykb1mJZtj?=
 =?us-ascii?Q?JJlhNYz1CG53LzT6exNfsnHfK7cpUYlpqjTYt/lVRvWZ6DTrRdLhKuewj1vn?=
 =?us-ascii?Q?HLLCHyoCY7fnrqs+Zh15ITjmtOxUlevWWbf3JLnLOG7/F46ehvY2WFBhhfcK?=
 =?us-ascii?Q?yON4BkjCl21aiBD3O9VFkspm8HWYEHzxZncDJOxFl7do4Lu1pBFe0su/NzQx?=
 =?us-ascii?Q?Tq7qeS8vv3+SG8vF/5UYQe89/TGzXWXMj9ZqQM2HH1EOg8z0dd7Het9CBJXE?=
 =?us-ascii?Q?bW4zpKm9qmMsyCWE6lTaYkuGKXOn9HpjScWlCdXjFdcBklDQmZ4mM2EF5ID3?=
 =?us-ascii?Q?Dx1tpxbx63NlOjjQSnUJgDX4RvQiR0zk5uaJ8P7+NLo2XLvqqMdVqYrzX1s5?=
 =?us-ascii?Q?Nor5MP3h0JbhKYu/UvHuSi3KZc9zIQlVNOnO7ugXQgGQFUUY+haJMew09AgU?=
 =?us-ascii?Q?UXgCTuMRPt8f6xLGSkholwjgnNyjNk++WYENC7P/2q9ZYbC4JENP61emoYul?=
 =?us-ascii?Q?eBTSQaimT96kPFUKXIV8kzgwiF52vWoqdLRhz7hBQsnvHX8MJmETcNQZeVDu?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2CctbPiyi575f7YdineNpN1isF1kOSVIb6EqowXO8NprGlhZSuMt4XLPhd8qmVuuuJ2lCUj65gjYrXfSSbXVgQmKpPp239VjEc2qdIyhu/KyF2ZvkB+HVi5wx4B5jRwR8MegaquSUoGouoo6AAzAeWg2l+MqZo6TxMHaOaquJ56zbHnp2aygWQhQCLznQ49GtPcCs0rC6nnnk5ziwcApgI/uPCCydMhP5EcfNz6+skztAgDJEj0OkZYULecbLojHUrRfCSTDNI3JcEtUCTqvCO7cxoBghDnArfpRv7NtfgtDFQpf75yuTJ/pzNaP5W+zLjig5EJAztlPvgcUr4KORHz7SM5dLltee9Vxz6u26L3naKpxoykk+mH0PHaXCP5dmo2JpC6FTooJJ4mHakyBLfaCkGEEPCCzIyEGFBX5km+V3PfcB/bCQVzac5ddVdTGjexRFx+gERWeSVGatXycecEnMTYI+8HBRFLRSdZOsAIbq737g81gc3ksICcQVQuE041Pa5loKyyzBF2OpbEf/G8BjgQUdm6B3BwXPrAdWYrIW5RBtQdWYRFKrrVUelaJGsd3/14Hg4IMYD9egKTAZXO6rmvzO7omtTl0PWiY9Ckc+rDCz1sUF7mnW9EynTyP2W7/R/pG/mWX02zv/qSW3USHx8v+T3TGge4MUQMUQFV9xEZhUBFZwqgYD195asIwK4XRRQamyHU6h4sIXpFBPB/iEoce9IEYSdlsJtdzPiyjWmfvgzMJfcot0fojFKwH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2a8b3a-d5a0-41e1-6bc0-08db7f02653b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:54:07.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKua3YQgKXAzEMLp0gySWUT/mfYuvnrYsRBBf2drxsFXeLtmEleazbYQn2UtEVFHCKsMYGsin12c1HYxccWiwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070147
X-Proofpoint-GUID: NM17ys2DHoYEa13vKCUFB-6hnx8hS418
X-Proofpoint-ORIG-GUID: NM17ys2DHoYEa13vKCUFB-6hnx8hS418
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

An incomplete fsid state occurs when devices have two or more fsids
associated with the same metadata_uuid. As it can be confusing to
determine which devices should be assembled together, the fix only
works when both the --noscan and --device options are used. This means
the user will have to manually select and assemble the devices with the
same metadata_uuids.

With this fix, the fsid can continue to be changed in the user-spce using
either a new fsid or a user-provided fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 4 +++-
 tune/main.c                 | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 295308f299aa..c291324ca4c4 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -21,6 +21,7 @@
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/volumes.h"
 #include "common/messages.h"
 #include "tune/tune.h"
 
@@ -45,7 +46,8 @@ int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string)
 		return 1;
 	}
 
-	if (check_unfinished_fsid_change(root->fs_info, unused1, unused2)) {
+	if (!root->fs_info->fs_devices->sanitized &&
+	    check_unfinished_fsid_change(root->fs_info, unused1, unused2)) {
 		error("UUID rewrite in progress, cannot change metadata_uuid");
 		return 1;
 	}
diff --git a/tune/main.c b/tune/main.c
index 3ca9c5716573..f6d56af80dbf 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -323,6 +323,12 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			goto free_out;
 	}
 
+	if (argv_devices != NULL && noscan) {
+		ret = scan_reunite_fs_devices(device);
+		if (ret)
+			goto free_out;
+	}
+
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 	if (!root) {
 		error("open ctree failed");
-- 
2.39.3

