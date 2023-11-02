Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAA7DF133
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjKBLbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKBLbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:31:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D7130;
        Thu,  2 Nov 2023 04:31:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A282r1J015422;
        Thu, 2 Nov 2023 11:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=eeeG1OqACfPu8tmMjPO0rbn6e7yWyy6LovRTeHjGZ/c=;
 b=dgN6quGvJNHAWauMFc/1ZzHqgnFRczqf3GTwh8XiAklURoYxA4fbzf2j4c9C69BFreaV
 0QBBUjLIewfdVF5KXR6XBWFFtuWIdWNF6apt8WrUuMLoij7KFWr6VEUp+p/5XTbPH0SF
 WOw6wq+Yc/nQbBLyhr9yFR5cnmo6lJ5lCfJsZ5vFcc+uH1jhpcN8ypLm+yZ8EIzFzEPj
 Z+Lw19h6A154uEB+8LVxdkt2stfFoMXuQgLprhCvYRk6hct1WQVAcV4CxIRJtXVdPW+D
 jCvCefnIfiMJUzHc2gfJHL0j8JPRB2TGu6dNq99hPzbHSCSBkNvUgpXtyvlaCTllwg3k jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c1fyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2BFmbs020100;
        Thu, 2 Nov 2023 11:31:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rren4uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9JQ7Q+0EvwhcVgg7xblJHTSQgbOaRENR3iGXSqav4ofp/vjONdvxzNkoMmH3rcWOqNt2Ppk2yEs5gH+bkihp3MofCABtTK6Kj3El162qmeUFMU+4UnQpS9JHSuvuYkt78NyGts10YTYo/ojcfh890IEqOF4gSMf0/o4LojmgPYIdj0ppvv2teHBpuKPC97skbgojYz9OtnpL5bZsFaMTLfR6/TG6p3GPMC4uR3iOj+/JwG1EuO1fe+IBvVO0AEnhbfbCKyoVqr/Pmo4EYZCywM8AiZsK5aT1PZFxg+QOsHqutG1GIxPigUyYCPeg2kHCEp3j8DEIHGgWQgF2YcXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeeG1OqACfPu8tmMjPO0rbn6e7yWyy6LovRTeHjGZ/c=;
 b=mIP+VsuHEz/yElfOiftgJxSFUeGwzguXObupRflFlHQ6U+QjCw9yiqS2s9uqeWNeQojuClTPd6me/OG4a+MrE4BcqzdGW96N1WXTbAEtVD6d64OxB2/knCaabP0H6JaS1gRAoAj9Mk7AUm3Flog44wqfgcZ3aXJd+jP+AC/Z8h2hq+NxoIFZE201YzQiidmbtHjyJ5hlU120oPivu0Dj1vCnm2FnS1qA/EegKiObzr4xLLXizS4qONs9+F2nabuzxl9RNaygYRq0fRQB9ER7Ls8UnCJGgWXGhtIz8qUVYWVYIHp0+/U0RTzNzg8AaX0hmqwXHD6SOtosVwN/EXoRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeeG1OqACfPu8tmMjPO0rbn6e7yWyy6LovRTeHjGZ/c=;
 b=iscGMGaf8oB0E2dQi906GsbtLMQZXMUXkSYmgZnGSqWb+rRkDOtIjYoRpgUAbIQX2ttWRUgqTQFa2rBkcM0zgIxWR9CRbMzxURm2xuJOF1Tu0hSetxVv+R8EddJVQD0GxFpu59HBYGVtLLmmbtaYclzsi/M1SQmwYmeq9srP8Sc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:31:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:31:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v4 2/5] common/btrfs: add helper _has_btrfs_sysfs_feature_attr
Date:   Thu,  2 Nov 2023 19:28:19 +0800
Message-ID: <e524e2e3f45fe34836110dba588af7dc1cc66d22.1698712764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698712764.git.anand.jain@oracle.com>
References: <cover.1698712764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: aafe3f8e-1ae5-4a24-cb91-08dbdb973060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPmenXBY92Cr4KIwIq1Z2WSbv0x7zUtlpu5hkHDgKD1owBphuwW0Jz09QyZIV8HYLcFBy4m/M/v/lP0xuzoAntIPrpfhfzZjlgYWiF/QBxSVZo0TnGYDN4uJflSfzbqiWRCURfWogNTurIpzfYuDYHAdfjbcNauGFHf9UlyzsM7e/rnvPuPCSITdO1bw+UMWtts8PzrWmnMv7BrFpvFIu4BzddCS7tIB/DVzVqrfugsbL79IywPfPE5gNegkzyAXbLaaDKv6Wc8Y1pXwdn8ZWBjOSzbx/nWfGp/KQBbBECoUArsghnzYNJwhUAYm+Z3pspzZMq31uIEdMzjv9f68dQsALra8PMTJxi9sr7te+bZbYIUqquZdP+9N1T/i57ktzoAR8B3xflICTo1RE6naflIFlpGOnnS/TiXICJsC5cF2J8g4lbc48HiDw35WjZ6k8Fs9flj36J8yis3CZP8hczm95MYm6TYPjnI5jPhuQAOJ1PViKFZyZMtkleXMiz1KD/xRkM0q5YP/OzZVabpY8iasQK/pLh1UdJz+heLMiq5OLcJFZ5d1dBkQA4kbnr6j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(36756003)(86362001)(4744005)(2616005)(478600001)(2906002)(316002)(41300700001)(44832011)(8676002)(4326008)(6666004)(6512007)(8936002)(6506007)(83380400001)(26005)(6486002)(5660300002)(66946007)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xeEgDIYFbzmOUKoEAclSTzcGsyqq6bc7gK0jZvLgN14BRQqJ5+MxRPwCBjN6?=
 =?us-ascii?Q?dxmNNQWo+bXcsUYmN8Xd7OEEz93GuOEiYZfZgZU5CWh/95BXfyXFrYEBwgPg?=
 =?us-ascii?Q?SWF09mxIDObB1fQUy7DE5jzHdjrwdISo/wa9WCUfR+iiou0f3HL9RJsYcHt2?=
 =?us-ascii?Q?uBu2DCPPn0jA/OKiGiNF10aKpDxJFBYyGdq6754n8NurACWZ9mpopj4R2vmg?=
 =?us-ascii?Q?/fBXmf6hR5Oy8ahSZSeJQdgsFLbuPf1FbmNPJaFoFqPNJl6aUznWgxY8K6uf?=
 =?us-ascii?Q?iVxXVDzXY4rKDK6V1IZKhT4TpqTSsQkza3Szk+HwIoQMPX6KoiC4f330g90u?=
 =?us-ascii?Q?pbt1646roMVtyA1/JBo6l0YPVeI3FUq5gJKE6SixwCFj+JXXNhNN07IzXbY1?=
 =?us-ascii?Q?R68DgOij6W+b1PGKYCiFzBh/FfK1Hs3II8WEj3HZs46JJZ6QAvJUNWJUG6ue?=
 =?us-ascii?Q?C2InUDfrjN5rQlk5fw4yJdAPLiHAyCjM6lKmEmIZjR63k363MZrKt4y3V8lS?=
 =?us-ascii?Q?aNyehTIQ0jnQ/TxXUpV6GxkbjHlUhTOhFXw/TWwunhwmC93mcnSPyV9415AY?=
 =?us-ascii?Q?HWT9xTNKxACHcI/Z4VGVOO3bHQmn08kgWTPBAAI6TOMnDEIdY3eMs0DmrKId?=
 =?us-ascii?Q?4NWXLptEI9ftGd7NHg+ZqXz1ev4TT8bfrzdTNViHC1DyJj8SfWpxO1jYwsC7?=
 =?us-ascii?Q?rebw0PFgJXom8sKHieSJAuiqT3ANO3zIRBLlOsy8IQdwl/a0OvYczRe/Lz3s?=
 =?us-ascii?Q?DwcG2apDYqoug9LSE3Vvzq16o+EWJg3uZl4LMOxveL6MulGHk+uPzdVZ5/dD?=
 =?us-ascii?Q?RInKiu3+aVjQcpyTUs61Dd3T795iFlT38mp5SN/WYysHeQpyuEkcKs5XQ6Rv?=
 =?us-ascii?Q?opQK5VlRetGlChcV/zj5GnBpIOR1yzPn4Erzv95cRhNNmSV887xoPCPR6w29?=
 =?us-ascii?Q?+FqSsViaRp5j1zJoq7QDbr/JgyGFuYKOdg/lEefXOwQCi6KMIKlJS6Ku2TbI?=
 =?us-ascii?Q?GnXZQ5BOetKTWRDUpNYEt+dWebfYS/zXrYkkOVstbbIHnB+v2n8zmLE2ULT8?=
 =?us-ascii?Q?lR7wKU6sk/nXwcyaCRO+H1pOz+i+UbCPDi2078h38POB6g3+rmjwU0sNjjGP?=
 =?us-ascii?Q?/vISyC7Kzq4JF7K1RKjoP42D3lcXIY5LR/ci0xU+5b51gQ0lSlBkYMH82SrJ?=
 =?us-ascii?Q?9d0Nd7cW6t0gZf4uoeNC96CAyPVw63p8CCZMt+peNceTj6c01xPh42XjZ638?=
 =?us-ascii?Q?8f1QSNN5MIj0hoDT4wQSVSthpir0LXNqP/XJhe8SFdZZBMmwP2WmcIjJvQ5H?=
 =?us-ascii?Q?6ngeFQl3nAyRagxCZepIsJCr0N7nAFTiRi8pKW8tC1V3YDmZmm94u/MXyC8l?=
 =?us-ascii?Q?FMte8RViUj7hM8inbQTqrYJcIbOyVYOV8wF3cf5Z2tim1O0tab1LyuKuuirb?=
 =?us-ascii?Q?iVK1isqpxhqS1KZ1EQLW6vuZMYqDUsR+O7YLLBR4MKqyy84TW320OogCYokM?=
 =?us-ascii?Q?ZwjAQKtNYP/aRg6KMSZVGJnUkc7q+/DOmRyajIsRzymQxnw9S27De3HzuaMA?=
 =?us-ascii?Q?BaK3evTqeyy1cp5GqJe1i9VAtxIXsTM1A3lpsPG2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yBA1HSzkQG27zna9mccjmJMlQK6e/7U4xZc5vWKmBSb+obUtrZnYzi1Uc8zU/crMJwH50JN0U5NpMgl1xIlhd5CbM//NPx/3fgoW4PcL07mbqI8Es9if2c/76UzX7xVLGCdfG4QRH3TA1rcK4dT8HSgOv+HuLwst+/Nt5zCFW9fT/Ic3v9q2zSDfMq5hC+OFUh3osmjsxzZpumpTZ9nxBPgPzxZYdk5MEhQaVGPEpUztcHR9FNSyIonFvVpnBF3CAcDcdn7GavzJQ2iJN50EYOuCgvHU7SSNudLILTSqgrqvCRcqpZw2v2BbQEHoLhhMGCJ9y/Xs6gl/ou6IBHh7nXZAJ71uo4KzrMwrubAlNqibBkMIdFK3kXKTTmcg3vfadDqKYAjxXr2J0PRXPcSkpKAtLl7Xy8Khgu+aolh8UrVOobbou8gXyCAVkPhm8+EDr2K/QUXks5w/mSodbz8ODDitxf83bT3+qhEDFh7AIr8nb3J4mcZ7BUGEHWiOh7eSaz7pqAo462/xgXAklr7DxYfFsToDdnZGx67BpwROiGma0yZmQYwbvB6w5rapKRJVUH551DIQQz6OKQqICTc55U9bwUkMEdnxkljKMYm5xUrrIg0rzffrl6X6ebMtvipf2000SqzR3fRMP7uKl9DhySr+s1GC6G7Pc8itUHp/JP6vqu1P79nH30/oBd0SLYqvRBwQ5dxhpg0NNPFCiPIqaoWEqH9VV2AjJM9eMq2+y80eI1KxjllTnLQ/8MM3s2wXTweBm2fmsV5anQnBSQ2WQ5gALR7+59HmhI1m0UwnQwW+0q5oWKdmrbEpsqXESr2/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafe3f8e-1ae5-4a24-cb91-08dbdb973060
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:31:00.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9ossHcmsiDy5R7BH1QTsn/mVqPiT25/Tq//UUdeiL3olZCoOdpYAl7o3PWDqkCt5MrPcqtVjBqFdI/ca00L2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020092
X-Proofpoint-GUID: 8y69YSuNpEkNYTatB9SmKBjV8EwESiLT
X-Proofpoint-ORIG-GUID: 8y69YSuNpEkNYTatB9SmKBjV8EwESiLT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With this helper, btrfs test cases can now check if a particular feature
is implemented in the kernel.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index c3bffd2ae3f7..fbc26181f7bc 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -753,3 +753,15 @@ _require_scratch_enable_simple_quota()
 					_notrun "simple quotas not available"
 	_scratch_unmount
 }
+
+_has_btrfs_sysfs_feature_attr()
+{
+	local feature_attr=$1
+
+	[ -z $feature_attr ] && \
+		_fail "Missing feature name argument for _has_btrfs_sysfs_attr"
+
+	modprobe btrfs &> /dev/null
+
+	test -e /sys/fs/btrfs/features/$feature_attr
+}
-- 
2.31.1

