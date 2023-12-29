Return-Path: <linux-btrfs+bounces-1150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB8B81FF00
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422C92829DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C210A3B;
	Fri, 29 Dec 2023 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBJxC10t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I0CN9diD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955310A2B;
	Fri, 29 Dec 2023 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8OLlr017923;
	Fri, 29 Dec 2023 11:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=YDQqw5EPL65V+zNf06K5m8JXQWlDxOzeEKkb2ClMt7c=;
 b=HBJxC10tF0akw70RJ4N5MuXIKfj33VJxfdnkSYmUUWBlH/7BdWWtLEuzcTF9eOOcWFvL
 U3XUBGcyFREkSprd/N+tkUeIz1mxYUNB8n24xb67FnkB1M3DgGCAv66eTLYTE/hHc/7Q
 ChAoIGUSmSKFPzqjuCDD4DBgyfW8AncYXEgVHDabyNlbbnNEpPDE7GzZh663/7PVgDL0
 Qx24pZMYVZvxCKsTz/G0ebKN1SQ/HYrmHiafJt/ucPuTuIajwOvmBKhnFICc4Fo73UzC
 42xBnA4bttDCrcR5tfabTXDTRD+cZbnFnIeuVFe7LtIYH2zN8xo8d4W8BmDcPpt6gobR nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5r3v7e9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 11:01:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTAPpMb008085;
	Fri, 29 Dec 2023 11:01:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0ddqqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 11:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAJMIwVIk6YNa7iR17C/sm7Z+Bqo/wzT33CtGq8aWC546+0gJJKVLDYeHncQuDw6aTfXBiP4B++1CeKhTa04ccc4751vnTMy+yIWMD3tb8Kf7VQKozMG5belLgtIC6sR2rqhFcSPi6KkJDiYmD4m4blE92VULpfYrdmOwU10L0XPQ0Nd+F/H+CLKNa/fwRkYeZ7b6fPn4r8B/QhDKyPhwvwML7Q7OeTBx8VZ2fPWMOtv39+tZa3i7sCDassR6dA+p6M9PAB/CCN0WArlo0bqDau4oYdwnyuNK1T8xSQvsvOW9s1nmLf3bIAjFsDqTmgPt/nDJC7WG2Ojc737dGe0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDQqw5EPL65V+zNf06K5m8JXQWlDxOzeEKkb2ClMt7c=;
 b=R45DDHqgciVDKxGJhAhC18hrwHlHsaxifzYbQxoPfrCf+RlDM8Jc+3ddj6M3omyCsfZyUq/bvEkQqHP+Wg8VMuLGA1cKENOJ6dtlHX0Z2zgAAO3P0P9GyUCPFjE4eWlHszX9cXosUS/006daMSyaGb00JuXZ30WXLgcCHQziunVNc8dFw/yofgxOZnB4/OePYzFqWGFBy7EhlJADK8Hq3z/G2pwrlu5IlxG2QTzgWCWk1y+d0SmGL+yYOylRQB0UUbbTgTTHCpfYIheJyLczR+8A1AZQCTSDeoMu1ilyKeuwGaxXw0Mm7Nkhw3VwX+NNtZw5IFxM360j4wdUna8sWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDQqw5EPL65V+zNf06K5m8JXQWlDxOzeEKkb2ClMt7c=;
 b=I0CN9diD84TRaNPgN19Z3LTs7BNmFanmzOzAxlri2g2Bfvpl6crH6gJ0bV4C3a8GtVOF6WCXl3u3WHVn4GmmyhdOrjb/BeFlVCabSnTcO5hn6KVv/D2EztdIlgX52m7iRjfE0cgO8/pexcOBDzGPhXiI+UTPsnVE73K8OhFENcU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 11:01:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 11:01:54 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] common: add _filter_trailing_whitespace
Date: Fri, 29 Dec 2023 16:31:48 +0530
Message-Id: <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 647da750-0c3a-4cbf-5a60-08dc085d9147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VUsobeOn7IDMM8IjeJL6Te9Vr58Yecv+hSlgW6S81kvV1Po/DdJFBlN0Ta8/DjO2IYGbgl0QGKO0yedDvSS/CJGAEX8huzGuExKiSeX/RURK3K7kohZ0VrEGfTsH+t0C161pmORMLpVm4AGce7/JckHhiVJnEd2qVy0fPj0LdkO5wQtZlVlRxuO4KSvflBK6RH92Hz7IOIm9XNczaqvqK2HS/t6bnNDQUDU3iKvYiQj55Rp695alnXMmVZpm2vKnRfjBpLuPOZwcbDkgGHPrtEfYWl+lmcJWIh/dqxz/NuAsTWzmvkooGvriMCkDO3dpwqknQ36WLJU8Ydj4HdYwi794KGRrkV9Ej2SEjtPGVV3kdtb+GyTWQ8vUmmOJj6Ym9AfBXUnLoGYHe6weqMdpzW/wRGxjCy95W2jdJJg2Idx2PXICG91tDg3UIs1sY9YRFcoIMOpt+5NJ+c6NxMWmB8DwrS6+Xl/D0ZS3bnxB80zpR6TsKEK2OCSwwRwrt9PhoB8Ae63dE2U1DEn+d1n2xqsqbzBMY80VVSj2X8zWsB3a/r5VoQ5RblT0VyY+U2h3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(6512007)(6666004)(66476007)(66556008)(6916009)(6486002)(316002)(66946007)(478600001)(4326008)(8936002)(8676002)(44832011)(450100002)(5660300002)(86362001)(36756003)(26005)(38100700002)(2616005)(2906002)(4744005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ACx/wvugMROGZG+mAZJrjcI+PCFsZscjEOz3IaRo+AnQqTTlxCiXF3ath8qK?=
 =?us-ascii?Q?ah3i9tUMepdTgK74pJTlJ8XBxEZovdCZ6QZYM46mg7n4maTPM2Y23FUODotX?=
 =?us-ascii?Q?aEW2IXu9XGISB7kCjhd63ZEOJs8ixppdMPi2sctryvgu2RMexhiGGMeAsiuu?=
 =?us-ascii?Q?c+ncw8geFgwQ5QaoToNrMQJqTmpdj2j50qeGYL+qMR3Q+655YUQsbes1rl7R?=
 =?us-ascii?Q?dx4gkFb3V0Rhu7HN4z4p4Jt+inedKoCR3ZI7r7E8lXlAKg3VKNkUjg80pjys?=
 =?us-ascii?Q?nDa4zM6JDUkdt94cx0JSY2qxWL2r4cQMbYn6pMiJRAi/xj/EeZiAKHNuSQ80?=
 =?us-ascii?Q?C5K18BUavhNblbh4M4sikf3FpPL/DD3h1XLlQ2JM0RToFKhoDeY47Nev3m+W?=
 =?us-ascii?Q?z35F+Af+EIDidcRPnGM+UeuixNbgVmwG1U4G1Aner+/J8kjLdMU0/T/JXQWV?=
 =?us-ascii?Q?JExasZaDLO22K9s80+RRDJc2rdHcQ91cyb9mERsRyO/GPZjFB6Y7260anjxR?=
 =?us-ascii?Q?W8JldEMrmM2rdhb9Hj2hHx0KiaWsDIw12NnDsrrmAVcRj4+ZpEBPV38L0QxL?=
 =?us-ascii?Q?Vm/7HrkROxC9n5m+wHBVkBfCyzw5qmmSdG5kCnT6EA4UCVp4RP9qK9r9tYyW?=
 =?us-ascii?Q?eMnbUqPS9D4M+Df2A5LQ4eHeV7wYwmiFv9SUitP4V9krgv+g5NOqpXBieYQ2?=
 =?us-ascii?Q?75iiR9qT4jA/a0/0JqxEXVtTD6nYVQnDU8r83ZVpMtAfIUu1QrRKhGw2vnMA?=
 =?us-ascii?Q?bl9AXRY7YXxGt86eW5SSWGeJpnG20bJLaoJqtwtWuNk4Bo+gWABiY/IzXMo5?=
 =?us-ascii?Q?1tWzPm/o0/7vpUV0RjsowtQ9jBkj2FpTHTQCv6wBkJ8O+Nnlr4RtiUaGGv4l?=
 =?us-ascii?Q?rezIVF7+ldLPX5S06y5aluvdJVeD2hTuHUrxr2iWHauIp3NjZb9kK6G6dsqj?=
 =?us-ascii?Q?xXKc5Sp++0YZKXMnZc0RDYB0CCc3Pf3sf4uOlq+MoJsPydLNDxKlwLHck/+w?=
 =?us-ascii?Q?SuAqXIdAyHd3PQNQa+aOxuuVITeFrV2DTEtJ9LZit5wOmWeKbXMIzhM928zA?=
 =?us-ascii?Q?qEfmCsSZHW/9kqcMmyKOK2pPg7PWbUZnFl22Y7DVSDOBdsVamEgt4z0g/GNz?=
 =?us-ascii?Q?GQB9m43+9usKxEFj9CsWNP4ox5c7tqugvsk2mX/Z2j5KUqru2N0Zc47PG/HW?=
 =?us-ascii?Q?/UyPgGVCdq0F/xcfWNYEWDjz7qVg+26f+mL2JXKYxM2KTakfU9QhI2aRVHwU?=
 =?us-ascii?Q?LrevMJQ4fMqt3Hbj5O02ylv9845FrhqDzZyXkOHtu1gUf5iaRTT2my3KrtQn?=
 =?us-ascii?Q?NZqg5Odc1dOX5uaSxq/yRG1XaGN2L1LJeJbdpHU6Px+bX9we51KzanrV38nk?=
 =?us-ascii?Q?mpcH7b7ep6IM+FYbGMKFmd9dYMApsCwYc6Z8HFKDeLFPoQOYjLebmj2NMjLO?=
 =?us-ascii?Q?lG/iVbbpBGcUhaL8T9BlwkWKwOlbAYIsygWCJh/sfXaz/oa8rorOOISFwFlk?=
 =?us-ascii?Q?Ga3wgwY54YKDgj8f45ZmsqLADwyLQnegubmFOCSr1SJ63cliPs9awFYLBTlS?=
 =?us-ascii?Q?T5HdeWIX2z6S4o2s2S6J8Jk/DUYTXF9TDYEfxv7j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T9nyJcjSeBZUqeevymdzhqfhiqPQ54esapsc3HrQxa32gaImwk/Nz1JhTGPt2hqLPY5HdiC3kp8cHn0XXjHWHOaecmsIiNsBeoEbHl0AkQklS0fSL1UvXrK0vng99eOT9BLeskSkQYDpzf5dB3t57g377wt02Lhqtq2zzQntV9fZKxDUKu0XPUnC68evmhiZsJX7cBy9VKgEpxf5Mgitl9NDL93sXvh0IhGFDQMx7VOPGrC2m6BmnGG1Ow95eZ0el2BHZ+B8If9ry3sI7Cd/dUPgfwMNj7ED8CSMn2+uDJOWGo3a8xHtD/HQKGu2YgLo62Xh20yeEOABTujyuzSi6EaXrPJGiI8Q5JChSQjAJtgO97w/Gcsh5F7Hkp1riZ0EkVYbOjKyumEzCa8XmkD6lEz3g19EWg7eeYVFSPiJe0tc1dNyCB9aSpQpjGeFHNmozx1z678iD42tfiUAw8Sh3Dtk1/se4RXkoO74EbP4NxojH8ubrkSn6fEwd/e62d99EyjY5kJ0udTQryCCfCl03u/jttSsNnjjfU0SGgCMTBo3/BcAGg3A7lo7Rscz1Idq2tsm+wqsajdmRNAfHXiMLMcH4o9dDt7yCg2U0Mgh2YE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647da750-0c3a-4cbf-5a60-08dc085d9147
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 11:01:54.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwueNnxHgEA30lxZoV5P8kn6uJsUfZN7qRC01ij+6oakk+3FQ1GVMW3vy4akMk/ClyT0Gcr3PhPLa1HTDmI6rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_02,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290087
X-Proofpoint-GUID: Z6MvBnwi3GodGX-cHFJhHcft5lqw-QEF
X-Proofpoint-ORIG-GUID: Z6MvBnwi3GodGX-cHFJhHcft5lqw-QEF

The command 'btrfs inspect-internal dump-tree -t raid_stripe'
introduces trailing whitespace in its output.
Apply a filter to remove it. Used in btrfs/30[4-8][.out].

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/filter b/common/filter
index 509ee95039ac..016d213b8bee 100644
--- a/common/filter
+++ b/common/filter
@@ -651,5 +651,10 @@ _filter_bash()
 	sed -e "s/^bash: line 1: /bash: /"
 }
 
+_filter_trailing_whitespace()
+{
+	sed -e "s/ $//"
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.39.3


