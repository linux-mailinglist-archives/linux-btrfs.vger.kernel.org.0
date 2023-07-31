Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104CE76948C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGaLSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjGaLSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:18:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21938171F
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:18:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAiB7M010014
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5rjWS9RLQoa5H6P0yodfjw2oQZcgeBdcjbNxjDstWyo=;
 b=svCljszuw27aOpphc3BCCoUK1CfDzkY9rsUN3LMHvVqswOpNgnxBdXgOdHY90x0aIU1k
 gOXw4QeaeplD+xSzcG27PDrZk/b2Bfv+/6mnm5Jb9bcE1kjIYe7hgB2lj0/qcqC9istS
 rg/XuS9w+8kmwQrmUhuYvvlTvJqDCoOhsdyBgOwhuTc1ydB2mJ2LHm1grgVuMcAjI0If
 LkWW0F3RRv97CaA0iMpnmVfMkUgtu8kPlFJRnM8cUxiFP9crHOvama8pQvLV8LYRwwDa
 T4bp1usOujkWWPJlzCV05ynJC4yjQgKtKuJQKpMgRit09ANQg4ftwizY3Du9vawvKBm8 Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd2bnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9TGJ1008623
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7aw2sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsVbeWMamMW6D83OJ5/emFpBES9CV6RuvmWieXmwBpN/aXA7bZ7cq6auhjQaUeP07MvFKN4vbG0WDBiGFIFpVkrbPNLKquafgH7qurdkTo62cSW98cef1TCStQoNMmiRgJLeqDmCre8bHpif8eX7zr7BCTSprNBdhAmf1Vuk6ErOBn4whP7rr+wyU1lqwgCoiP4GG9ROxkmIgGivLoqNNe3Hdk5GQ2BeBx93H1gpdfkIyIRR2Nmh11LIQLB13U1ej9S7X9dI36lulY/514RJKiWwFAXHLlX9JUr5MWpQbgGbl5Fa4xsAtKCC+RZ0Y5qW6SLcLFgdD7QJrmKp0a2gyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rjWS9RLQoa5H6P0yodfjw2oQZcgeBdcjbNxjDstWyo=;
 b=MlYpnY4ePYFmJNdj2j0EPwg4PHKSDhjnDfQsVWGSKxX9iCKHo1qDpENhozuEqhhQJfUqkmX+NAhqkeRZSayE9MysaHY4flFCKNvjy3QehJs8vF5J9VqJHuV6SVFvdbH/k8F3NYYbfVv5bl9y7wsmcXUyQwFCMwqX2ZS1ouAZooDVjC3prFD7ZckpkAsJPxpfcm1KCai6cMadCRej+4bBJ6NLYBuMq2YOGvpBKlNCTsz9ly5zZCSa3NJYUchfdAOV9SMv6dcurKW9m/JEFHsPs2Eko6KLYpxPSFLZHBEIONlMMyuG0RpRMFAsFA9nb451jln6I/YhRm2DxEzPFP/0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rjWS9RLQoa5H6P0yodfjw2oQZcgeBdcjbNxjDstWyo=;
 b=qeJtfpLwjrCx+/+f3ZCZL0bPLYUxo99V/2MeEG4EHIUXlzdJkcTTnaPw/EtJZqF497sVmgAc5MrNNEVJFMIK1N4LtFXYqzvDpGVzDrpmQNdj5+upDbXbjA87qj76Ee157Hfg5/RplbpNUqSUUc4mRmozjnSLizTMgb0tGqWgExE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 11:18:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:18:21 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 7/7] btrfs: use btrfs_sb_metadata_uuid_or_null
Date:   Mon, 31 Jul 2023 19:16:38 +0800
Message-Id: <69a45acb12680df22a7c7052e788450e7f780d91.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0350.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: eb84f7ed-d6e5-425d-c173-08db91b7d8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pc6yvVaXF8tivcMGzOCYBqug8URop7dIsxsTWAj+Ht5gYn1O3ho5adch8SyW081TpHoHw0Wxvc5K6ITlI1ZotWnJi2/yP8E+egRW1AoMIKlyXQra06qYmIHrAsUw3Xmf62GFBd0KQaccxwDLC6XyyynvvQXoQDjCuTc3UnXyFAh/Pr/Kotf/oSsAJ/EJdXk5LTXmNp6MZlXIYWTK1tQXhK+m4hMCF5vSQ1z+6IL6MTn4rcBsmvhB6PPd/ZP9835HJLZjxP5n15qQyN+l//qVD1WHIfEb4qqW6FIJa60Sk/wuaiQ0tZCbc/ApMEw4XA8KYunyN70niWE6KbfdmecHczlPzgelSoItYuTBEd3hs1sk2F74+1I0hX+uelRwY/hImi6Rh0fZa4uKE15vijyBIWGwf7H/XHo253UALAY7taF4FHjeiGTOEBWiPFkLlA+ilcBA0o+z6iUOjoczRLPZLuSqiC2OyWPYRRjsz9MR7LW8g6LPFqakaJKGowao/AwoBZY+rdCTLqAX74AvEd0pSwXQYpr8C8aLNkawCZE+iX3oNSwbxxeK9m7ih3dGG3Y7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHxoh1bWdsZW4pN1+ZJGA/2MlRA7g1ZRv2Q/mVSRcRh5aJaywKtZQUkAk/nR?=
 =?us-ascii?Q?ax17QnhyYN7O55xd+AzkDThdcFprAURzQV9sScDZ7DRo4NA5oRt3jyGnsLSS?=
 =?us-ascii?Q?f3hcNZhboOHqBnxgcChFq409yqJeaa7wG8cl7s3803IkUIE2yhP/m8OZlSs8?=
 =?us-ascii?Q?a7XPqhpHcSasTVjsFRTsAt273FX0GLxyk+EA5CFmItPTibrbxslRBrGg12gi?=
 =?us-ascii?Q?gTpe+DIWJVCdwXlcfWmL9yQgl9MnSjwXU9xql6IxsMvcPgejeeh47HJotT2u?=
 =?us-ascii?Q?+svxZvUYAXAxYVwPbtjit0vtj2s37Vq7W6zD/qAo7QDMK498oyMwIfPMztXu?=
 =?us-ascii?Q?jiZgx42woiH33dg0uFRNOhsdd+izBHzjtBMiA6ITIYGR5vvsxKs7YLBAFj6i?=
 =?us-ascii?Q?vmu4Z6mQwbkT9A4zWH3OqMUBaiE/AyhXALbwvbWFe9Z1AzkwNvo/mug5thzR?=
 =?us-ascii?Q?pSUjToWUtu2JbDdSsOlW9KwVMQKZEsa/LOkvGIfmXbfwZ/IOxqVrxoywENUb?=
 =?us-ascii?Q?WuKETtX+sA756WnwzNnugBoBitKpDS4VrXZmHCOr2iI9iIYutpHgAurc+og2?=
 =?us-ascii?Q?aGO1RJjpdNqZEQ/V15KsO5lDD6/SPnBHqdZeg+3g/CpKkn/+OKXueLT8zpia?=
 =?us-ascii?Q?lauBYqrqDgv7YHOcMoON+dsHuoYUisNsMAFS2RTPtAewQvIygGVNegvgZcuk?=
 =?us-ascii?Q?jds0Qzx/oInVN9pL45De6nmmOO0DMm50oyEjPnd0RAsHHEsRZ4pN4+kQpQ0u?=
 =?us-ascii?Q?VZfo9ZqupIwrRGFNin7U1jQCWt2B5ovaWa6qdv4KmAel/f8rLAin5SOsYSUD?=
 =?us-ascii?Q?RYyn5KvLoCyJ90COSq1NAKDsR0hTttJrqqiX8KcJKnJ6mqaJkU9IhmGYbTbS?=
 =?us-ascii?Q?VluuHORCFjj+zHOP3XxYK5wwetcV90z0OZSC9tsnuLsS0aBJF73DNYClawPM?=
 =?us-ascii?Q?Url8MRJSji0oUSJOvYOFmRMcZBa4TNaROBWvjjTb4AgQ/1OdQXQdgpnmjLDo?=
 =?us-ascii?Q?x1QSpHoCfbCMA0Ow8+kC5Y4r3H6v/RVNAnCCtYugdjSVpV1kRBQw4azb73/O?=
 =?us-ascii?Q?LUlrH5P90ZHqQ4A4xYF33Ac9+I0r4h/uRuo+YevbELBuexW5xn92vn9G7S/E?=
 =?us-ascii?Q?Z3kZBekg4bLQSIgB23nCkzzTlBh4+rdcimV8fHSwhH0K1TXu2TMUHP+CSUjo?=
 =?us-ascii?Q?vi8kmEgXDcS8kkMEisF66NAkgp/rE4JsXdGXJla0SOGOxvM/19HV5SDDpML5?=
 =?us-ascii?Q?GSZcEgBkNFBDSTRUB8bW3St8NS7G0E8leIeJRSstgbx83cZENGKd9REpa1Qd?=
 =?us-ascii?Q?ZXK7IqWq/7yz/nqy7mN42wHg2/0v0NJwyEYpSinKxfp1cFe/p9Z9zDaDxHfv?=
 =?us-ascii?Q?H1iN+R8T+ErlJ+JPe3VHqCqIBCmndb8Jrvg7cGI+xnJmkc50fvV2ds9vJQFg?=
 =?us-ascii?Q?DGZSalHlBJW1x0iHc9fTSvGBb9UuvDnr7thiZQsyVDpTsuEpxoDIZd0687gx?=
 =?us-ascii?Q?5rJt6v7fEUHF1b90r82gqV6A3r3Tzz7ATFUnmzmc9B2Mv5G54+KGzJrbfLrL?=
 =?us-ascii?Q?a2CHtn3BX3bOE7DpcOb4lPOOUSacZP1C0gPIQWJS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WsnrkTPEbTQ/nRKK7fQSkN8PxjINn42x+rj//wcbxDqHhtknRZY8K2Sovno3N2xTXQyZ2xjDAcN5d1zh7jPlfdQCTAGeITt5pATCVh3sc71a5kRNaYHupCOm2qZQGa/OUrx9zYFx80JVoGgJsLw5r5DSDchT9qM5bc3bUGJpyW1qWAAizMOjWimELAao4kAuR5jwOk5t1VDKI7B40g4SGBA1YduyfFHok0R3QTdzMbcwgOWvGKj70Lv+IYwCaEnTUUCp475Wt/ydgrOb/rf9EN7IvD8TPIs/OmBZCvZM/snOlWVU2MYsDxUVmkHqtA4+34Hf2fDLQ7PtPGjqAiShGY2Li6SrlOg1L9uVwd3VIJqjY9DYdcNYxiig7PRmtaLUlbvKc69EokLvmZats3wHwtja9jmWmP/imvtd9ylPASU3Jset/1Vk7GgYYG0hqNincfA5vawHEW1acUeza2YLM91+NUB3T4RhMtJqmCa13PGapfdd/hhdsowYhjsMcknw9hbbEf7csgPnUrRUW5Y8jnMWixElos1cDaMzv25xgwCByixiUlHsQhT4n+cCgnWtviQWWqNLnmSpZl4LiGn83q9vIk3QXKlH+KblnESbo3yt3MiFk0u3ptTMwnpz1yAw8RajBTP7pvH3TK7IQWSjEI/f1NlmGH3TsiyhuEtKdHQocx0iXlIquX7uIxDMdlVvlFQWSXE2mK/Yuis2+cIIX3nzyh/SC2FdIPOqNGZdSzHY8Rc/tiLtcdpqMWmzlTTgzWe8TYwjce5X7fpX2sdEEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb84f7ed-d6e5-425d-c173-08db91b7d8f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:18:21.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFOfL731MDPCDEKIzmWT5r3UEC9T115lkOvsDM8Zh/3reFDkgRkNMSrjposTU6lJl0ExqGZ4Ju/k9WxIlJclaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310101
X-Proofpoint-GUID: WJdNihAtsNZadUtODvBhnOplCvKz5LEE
X-Proofpoint-ORIG-GUID: WJdNihAtsNZadUtODvBhnOplCvKz5LEE
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 661dc69543eb..316839d2aecc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -821,7 +821,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid,
-				has_metadata_uuid ? disk_super->metadata_uuid : NULL);
+				btrfs_sb_metadata_uuid_or_null(disk_super));
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
-- 
2.39.2

