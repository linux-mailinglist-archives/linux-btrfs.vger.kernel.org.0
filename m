Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4370D9E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjEWKF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbjEWKF1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:05:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F83102
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:05:22 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EqG0032516
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MI4O0++kGUCDzJZwGiXxHRy8CAtrtU4f0DQ4c4mChAk=;
 b=x7U3cfmvzcpocl5EzZDt0zagqsHut+HoO+qhutdpRn7svqkYvk8QHJF5DSxw8ROAf7Q3
 KsYiXTTepVFdQHDoGQEA4lCbYJfe6E59P2wQrqubRnNSA+N3jLEf+drt5u2Juyr7QJID
 oaDvnLoFpj6p2hTE8xZJvluWxaBuol9avU/Xc4lgJgH7HmbNdwWlf3VoWJ/Pz/h+Ucvd
 BZcpG9mxnnS+eR02BLA14mGW8nIs6n03zdlfqHi4GikwvjRDSmsuXVpLE97jc38xNULJ
 qpuRBalKVul6kucPz2ezqtiCX+lOX1CNUiPJfNxuPmR1M8aeTt2SarsXMEkUwlO3XhlM 5A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bmrjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N9Bx4A028711
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2quk5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDfHbqxDHY1KVzc8pSuazZVFFcQDhZQIwDbchaql6oRy15cW7AgWquactcZ5Y9y/+YLoWc3QGr7T2HGhwST0kpxsDSG5dQHby/hARQ7v4ZIca6gKB6+RxGi6GdPtW50v9a6SNRfk9TaJOO2SClxoGrEN4AELBu6WXUNZa1JGPwbNJBOGqx2+EtcLVxmFd2bdxpOTeQ47IBNjwcFdWylfNk1SiBZO1x2F+KTTtkZiaPdsQCQRnyJcFfigM+ycMgxl8dqXSqTgZj/UzzrevD56AOTqJj/kyw7zW6guxh2BcfTPFxGJZr+5zyj/+cJJSSm2VpRFZxAdoyWa6unAbdEqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MI4O0++kGUCDzJZwGiXxHRy8CAtrtU4f0DQ4c4mChAk=;
 b=mCKfZvaE0Km27QixQOtFJM0LXFu5XrV8ZFg10CYB9k8pivdWqF2emu0Q2pfTjTHoLyUaFu9sUVKQhMnleSnYXCodkgywYgrHvw6utlhVcRGHxHrAbf5T9ryOitAVsN9xJVhdXaDl6M28pKsR+w3/pRN9WwkbmC/KTI1GEUTI+veD3W6zs76a3AKus88psLHHpkpe3wt6fi+XYRzH3OfGFxP7ZMJt5lGfMhxSby/zoENHLWJDSxnJIzWcznfKM7tauacrSARfGpDB/OfhN0owiDEoOe7YOdl/7KMIsn71flfkvvtW1Buy4gsWXFd0UdqHk+sU+JltogYj/cW6ddjXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MI4O0++kGUCDzJZwGiXxHRy8CAtrtU4f0DQ4c4mChAk=;
 b=gqWOpbFLu8K2MxrbbbZFlA9SE8NPPskaWKJj4zBDJJWY1VflOyYHIribW5Wpivcd9v3BV0p2OczYCGtFF8ybQ3YzeJDqAeFkCtHVn9MduJrlZrGD3qYBh4loMpJM2r7vERcO4Z3jpddxXiNOyU3u5xcegtYJat69wRsFBUndz2E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:05:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:05:18 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 9/9] btrfs: fix source code style in find_fsid
Date:   Tue, 23 May 2023 18:03:25 +0800
Message-Id: <cf801647e5f9dde29711a97453ff73641adec787.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: dc09cc4b-19d4-4ab0-84ac-08db5b7535fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46ONQ1LzhgrVFyeqk2i68QkjtvDsi3MVND2EC866XMnt3ESxi3ljs9Z8GjUgmBcd9G+wjxmNDf4XO8Yuurnm2AEKomuI8tjwf6/YkLTWZpOAFL258nJ4LFzrBpQNaW/+7pkY/DOS6KROnl+CNxruj/3N/zN70//5bOcAWYclUw6/jj+muRKDfOSURKeIpOMvqAvdINxdQHbT2oJXzDhN9Faew+bx8HpwtHgTK3MiVbWvchywnlfiXsM3T0ycOoGef0LeWxFeWxxgSRmkSrujm/webN8ZhNE74JojinxlizF2k+GlVP+UcBoWcd4mbjkAr3JCByRGBxWt13hhN5zt+ZPvRgMPIfKuMky56piFo6kX2h6WiM+0JARnoKvgklb8p9XsFOPBmLe0iA34krWAcLqXp//jQxY3bZpxVCsoEl5hXV/FRzW3AgpL4rd0lWLm0jWya3bE72kPsbk+LCuhpkA02BowrlFnqK7M+RNC8uoo5bTbGwdkS+AkqGGg9DbPeoZfHODHZ/Ho9k6q81Wk2Tbf6D0kIlW80+19FZ4ymRtnP1Eq2DiJbZpD8DDqCPY5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(107886003)(6506007)(26005)(6512007)(316002)(6666004)(41300700001)(6486002)(66556008)(6916009)(4326008)(66476007)(66946007)(5660300002)(38100700002)(83380400001)(44832011)(86362001)(2616005)(8676002)(36756003)(2906002)(4744005)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/QQsmarwafpkrhG22RchfLvZN69d/NK2swP13ew+OeqvQrzAg2+5+KHwWeRg?=
 =?us-ascii?Q?OITvXXZALWyTyYTqWLd0qbhjK2WDNdLHM7FQ1HRG5TY16KkcX6VFxp83rAB2?=
 =?us-ascii?Q?UGtAY4thcmdXHcj2aSq0g9v0IkDPmeRWxSyONQ6etEbQ0gUZVoQDkxd3FqmX?=
 =?us-ascii?Q?SQJ0N60AjPOZnL0Tbshd2WQvUbhNMs00vvTXgKFg1ECrUGYmW2BpuS1EtnLp?=
 =?us-ascii?Q?CwSAwUeSWrgRI+bKaDdzwKlQEVANyooN1Zg9i4iXlJRuvUpYNrx8yS1m/lnw?=
 =?us-ascii?Q?uPz5PBy1JcrnwEwFuKXVVqzIdSKGtz4khj/CkSOpC/k8dqXLa7saweTthJJT?=
 =?us-ascii?Q?+F58zUnvaO8F7cIN+TC6kCAem5jkmDcYRm/6DzE01fS3nGmM3ptDvArQMJdM?=
 =?us-ascii?Q?iaxeWzRoG+IYrvVJvSUEmkFrpEyTH3hILhwbyTOtqcckT0GyhB0zObeNlp8S?=
 =?us-ascii?Q?lPPAkkuppW3muMIgGDhEp6oyjfM9rOU842FQeJ8Ue275NqMaNXon2M2RkCbh?=
 =?us-ascii?Q?TrPa1NAogbvBSuxvWP/ZNT/n8JocM2GceSC7I9tL8kew0/WZ1FEcK6Ry9EjD?=
 =?us-ascii?Q?51WXpenam2YO1D+826Vz8ZhpccKuHIqP/MyKrR9JgqkV1BfZq666OhISgebn?=
 =?us-ascii?Q?FXQ0YCLJVJ8CSxNOC3+011iqp3+RVIHfVI4YfCJKDlkl1ubWArNjfHhDXJpm?=
 =?us-ascii?Q?7Fub0vmIpWUpazWcRMYC2Aoqj+vzTQbv8+VJNhN3zGym+zUQLiOVo7NrAikq?=
 =?us-ascii?Q?rCXwU2sU/mw2Zu70wSB2PoVUmRwx7X22O3fEj0fN8/bA5Q52pyRD5HCXO+nv?=
 =?us-ascii?Q?RA0s+5VwNf7itgl45BTf7ISJz/f1DTR60Rlv1VVDOFV0zvf0wjUKyLzNx+c0?=
 =?us-ascii?Q?HIwPsQ6HPesl9kjpW5H4i+KsqrkIpDnjZ6mSfI+eKo4TohaWtE+VFM+CrSG9?=
 =?us-ascii?Q?lPIdNodrEu9vAU2fJIDfhhSpvYYRSWDp/9cKeHDeVul9iKecFmoRWHWtBEOG?=
 =?us-ascii?Q?obm45GnGmcMJoGbLQINO9ed50Fvz6C3fmEWuJPmoFLp7vIwT5hb7BFLKSnsY?=
 =?us-ascii?Q?6o7L1PLTJvFKzgf44T6FZ/SuW4qLgZLOTsig683FuL8pXEJkmTTWpMpQYfoJ?=
 =?us-ascii?Q?xdYtwnyQ84ip6UcCfLPQ/UVXDExpuC5NB1BXtXKuc6lK01K/I1IpITMlo1Yr?=
 =?us-ascii?Q?QE7uge1FaR89I+q/YzWNfqdJYmsnpSLC/ZM4yCxlTgBqr7A0ZPxq91btffQ9?=
 =?us-ascii?Q?eY88S/6ZMD2Rj8IDFxZ60nQ4Q7Pe5HQ2Q9CYWVAV2k01B7BV6PkWrpv15hVZ?=
 =?us-ascii?Q?U3YSpMKU2BpOxrxmYp2rRgIUmZTQ55dba2LTa5wwLaIrdaZiNQIc9ewZK3MW?=
 =?us-ascii?Q?URcGEgx7j2y3TKGIKTbsLwxfUpg+NfMHWwrsd+8CQ7e8PAIrsfQZ8hUpcGy9?=
 =?us-ascii?Q?xKYZeRmQIRl/29UJTxq7DbD4tgg5Ch3OTqkUfB1GV/6JImtJ4uo9Meyd2gGT?=
 =?us-ascii?Q?wQB7uXZ6GbE1R80JYcyU0LlT4nylTutNfzkM3hZ7cwQDnT/0xPAn8ssBHNg8?=
 =?us-ascii?Q?I5Shw8GzT3tNfPKIlZxQfmAVCNZsrhbvHeDC37qBjeLCvt0v+p+SVOUPWLAu?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fiLPq82cgQNPP767xoasrVF7L8/wS8slYFyMuLokDVo36iZIhRNQZPS9/KJy7QeahQG6iJx+tfj9ZTb6xjq+zknbLh85kJwCzejYgGfDB2gSrxacvmw3dYxnW4PI5J2GGGtz4HT6s+LlmecYdLOMaNEjAvjF2XazI0jaepxKmD2vCAo/y2G3RKTF34qerkFfGXFGycWoQB2Q2WiHYQM5bMAHYFLvd49KEKFlVxbVk+zQMih0chgiZ5lnwZ4kD4FKuIuCK1XRZwDdMtCX3w1tMrUGO5oBoxkWyWhQgKxP8SKjFv7c96coEdBgdrIXBsyd44VGvpBNU8kE6X68gfBZYIQBBdaJz92Tuf9zoBOr51e6JPQVP6EL+iGRKR9jv9Z5wUw1JNA+Ts80U/stHM0efgB/Yj4lINWC8zVWvhOnFwUFOnHirSLoi+XW88Rbmeb3fVvAvusmRhf6ek3i64wROdNucfYf7WHrVASEekDqunRhRxhsiWbT5i7AiVVQuIYvp9qPtEhO2G9i65r9beIDxJTCYoL6goUGDJ2xcwpLs5a66HfQog4gAFTZxONTsUxadSKJQtY44QBELY3xfPrmxhAqZza7FvCG2QU4pJ8Rpbekb4FcZfNJm/xCnmcY+Bmh5l8ORYabRCt4ou3zqLAvauSSLxBTP4hnYz3tzooWRMn5/OxsR/pLsmHPtR0rRAEod/PUTjBeiP+/xboyTIruaUYumwr9qnLPabv5M+kfH1hXptVyoT+ohuihyA0wiNUXGnqUw9DdNZ2RUXjciWiTFg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc09cc4b-19d4-4ab0-84ac-08db5b7535fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:05:17.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNwQqLrXa1wLCp6uGB04ayD5+kmuhHNs2/+21LpQZsN/oyKj3qwE3IhCYyB7AHbp9qQcrRGzNf2Zo0KjQUdNqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: SKZIaJ3AedFZdneBGKRRSoygEV8aAn1e
X-Proofpoint-ORIG-GUID: SKZIaJ3AedFZdneBGKRRSoygEV8aAn1e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 730fc723524e..db46df2f8fb2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -443,8 +443,8 @@ static bool memcmp_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
 	return true;
 }
 
-static noinline struct btrfs_fs_devices *find_fsid(
-		const u8 *fsid, const u8 *metadata_fsid)
+static noinline struct btrfs_fs_devices *find_fsid(const u8 *fsid,
+						   const u8 *metadata_fsid)
 {
 	struct btrfs_fs_devices *fs_devices;
 
-- 
2.39.2

