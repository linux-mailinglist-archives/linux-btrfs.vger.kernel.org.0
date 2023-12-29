Return-Path: <linux-btrfs+bounces-1155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B40381FF61
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86492283C60
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238BC111AF;
	Fri, 29 Dec 2023 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i1J6FbIk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c8igmJrY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FB111A0;
	Fri, 29 Dec 2023 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8OTGT008999;
	Fri, 29 Dec 2023 12:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=b7ggi4FCh9E4tGxGfGXV3b0Nabx+FjqUDSfyS7aTaDo=;
 b=i1J6FbIkX/G0NnUReQvVm8MchwaCNEHqKVK5RxmR+Me6cxoESPRcpA55nIBpRAdS9dmN
 0ASwGc+UKF0XaoiBH8RDHTe75uwHbN4MbZnLZcj+Rxk6oLxjLsXOwdKVX0dsoVatt1kJ
 AKVXn+aNmwlA2Xry3mtcjVAaCeGE1twNmThl+9iOeQ1h0t4wYqHwpdvE6PxBW3VMDd9D
 CXfjJkC5uTMAnUdUVyhbbLywFBFazK3Z+UufWPrGrpSt5vjmPA6U+syVwRFph3PfoCk2
 7cWxjzpoNkneMMdkJBgqGTINwbwRp1ISeCXxgI5lEer0c0ukuk+u3mFwoESFomStDIuB iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5q5ufhb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT9CJJe011173;
	Fri, 29 Dec 2023 12:23:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v73ade3bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQQ9TXB3VMb0Nf3ecIU3GJDJeyUwunlP/1kOtXstgSNOKFB1ks7bbMsWKNij4vsHsHN8xzxr3Bur93uq1K9IEAZQ0RcXaAsgWR8OfPvii/afMlStnaEDUxliwJu2p6X/9a9zs3/BDtmzVZS9PvIKvWoTGXN6O8u3DXiG0gn1tsdphE2mx7actNgft9UfP01+JQht0HQeSWyJB05WOYAYG+6uHBE+r8XOF4oN7+E7yNTYIJ1hmJj1HUWpYfdl3LzfagoQ5ERn0aXo/DRtFdsKZR9sg4vKpxzABuazzGdxwxUJE0eeTqcBPel8q7s3v68nZ+fJLZRG7fqTVkT8j2KOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7ggi4FCh9E4tGxGfGXV3b0Nabx+FjqUDSfyS7aTaDo=;
 b=KLWbdKmghqUIN3H1R0iYVLAGmq2Z0aN3n8ZP9p9bqbPLn/cQxcJbQQ3DXoD3P4V9qkK7h7vKDJXI0UaGac2jszKMyLW8hTiPrhFp+ElXjr5AasykJhKLN5xGC3CJeVmOK0viNWDO0HiGGA0w1Yz9zEZudTH7j6jzMZFhjd2Yd1lPMZhyRxHYYeUQ7WnOxZQ3Uo37h+uijxrxJwwN4pXfay6PXi/6egaAFxurBdt11bE2PzIS5ua2+IeoJHSvbY//Q6c8cmG1rSPvUXy7cK5XinWlynLO0CqQqAzIlhMh5nqOggXqQYGk2uK22pJY+Lt5ZjnYWV8IuwSseWKwvy+h2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7ggi4FCh9E4tGxGfGXV3b0Nabx+FjqUDSfyS7aTaDo=;
 b=c8igmJrYxYbGLJW4kf5xnGPhU/tSj3v7JlTuaHq3TUNZ5LvLx2nxBhDNwABSF0+pPoXZOBsa9KMAmQFhgU3lialEiesDMJ2swe9uX6WnjuelI8I4mjMixvdVBUkuLOGBt+XyQegOUtPkXuou8z/f2Qi+3uAgsqk672c4xDpt3N4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:12 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 03/10] common: add _require_btrfs_no_nodatacow helper
Date: Fri, 29 Dec 2023 17:52:43 +0530
Message-Id: <877c3d18e5e3356570e77801212b83dde7ab41e4.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: b2326122-2026-42c7-6d6c-08dc0868ecee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CWfbp6ansUrT7V3oGQ3easB5aVy9BDAKrnaqIaaaZbsGkZOaSvkpaWZ84GJI43z5YhYHF0ZmXfY+OO4Y+boscZ93xdysCsKrNFPn5YK4fMoOB65WZhWwpEbqtYHO14rO4s66IHY1gKWVeuxM+85HRUI34tr2tGfCe8zUP99qTYBmF8z9sk6qEaLmIFwOJhDrn9REcYoaYhpwkqqOU9BODj5JtDsZlgeSGFXZL6s7Uh9qpd0xbuvMHLN06c7NnfuYHIuI6BhD6KdZdIpk2gCK8pX4DRdsQNTyr7H0JWYbGrhgI0s7RZXcuiU6/wfTSKWJRMuSvccRnN/eVy4AmUbgjDWpKZP7KkMQ9EQ/DLF8tUdf2AMQzKY7W/grIQILyANSrVvX7Bg78ibeHT94LFEDoOnvl/T5ZL4U1zdSc/s5U7kJ0kezQLB/nlBOYSHOct1Mb4mnrEqzVK0D/Mu/TpEWsL4NP36aJkbczMxeMVytfnnmT77eDMj/U4Pva6eEaTUAs5n6GFdcbtX7MnZDbwN8E51dM4wAHcfyfMOXPmDCWA8DxOxZh1/+ibdBncTlyW2A
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(4744005)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zmN/ZWbqXzX1+14zKS7yP1dPFKomAmwjc1zyz5Kjd3SlqiAYRZBDE02iVKsu?=
 =?us-ascii?Q?aIob92thZnvrvFOd9GDTshi6PmHwzjVqOGnbroO0Zk+NxMg7kbs9uuxYRnoL?=
 =?us-ascii?Q?GOtK5NxbAUyWXad/wtpHayVJgj5gosp2AMGXWXprKaG1yXIQYLSwQKghgMY7?=
 =?us-ascii?Q?0D5yK6xKLGdAByfsCz3DAWAqiGq+QKIubWkZVkSh95KY3Y+UU7ofNfMy4D57?=
 =?us-ascii?Q?qV/rX/OXDFZolM3t2UbN8stEbMAKrygvpVGyrhERT3nGd5ChwAR5s8PNGDMl?=
 =?us-ascii?Q?WP7pxGhK+JmG6aFnuyyJ6VHNr/QJnHw+9I7IGeeAIMutRkxlj2wdkckOMwg1?=
 =?us-ascii?Q?L5Ez/HxW+xQhpDdsrmjWCI4KueRmoh52JQbl4//Senwd3HhlChhuGJhlLS9f?=
 =?us-ascii?Q?xDXdJmD1QMjSEpJPIQS/APuzPv/wiJSkNTQ6RdvaoXo6hdz//HHyxVEbu+lV?=
 =?us-ascii?Q?4JbDcqQST5Oy7eLpnq2hFmquT1rAuwtJB9BR3o5F4KDPdt6r3Tt0zLUq0CtE?=
 =?us-ascii?Q?aipSzI6GR0FRpsZUmaGpbxr7IX3qY5irLY2Pt2Dll3rCQraPrIbi/XAhtBQ0?=
 =?us-ascii?Q?1/WOXokF5VErXHRVllls80WLYVRuJORclcSvuIvORclU+8JhB6REu8JwPL3h?=
 =?us-ascii?Q?EGit7HRfsA1K+cGaZUQ9K3XD2jQiHVg22Wfp25gZofYiyFyE2jfVquc+/eV7?=
 =?us-ascii?Q?OWGi2rEsXLROJeUYrkokkzHplcnweRLV8JTgIHTH/pmhv+Z1QatpajYFmY4B?=
 =?us-ascii?Q?Mz4BqEoso4TZdk3rzWsRai/k/3OuCvHwF1C1EKHL3czBk4YItxjLCiRiMxVF?=
 =?us-ascii?Q?qMu0eEifybOA4vS2g4iGNYNodWisz52fRQ6BIkhrs2z6hsplBeRwJz4ayJEO?=
 =?us-ascii?Q?QfqUnoy/1a3ifVvm7vNCOwON1G4Tr0KdxQf8E5rJtCidzEjAO/ASVEmmHyPf?=
 =?us-ascii?Q?9dQPL4/pTkR/hn3NkRu74euYQiEmAcYf2qslQIzjRTadLkrxgQXB6q5uQl3I?=
 =?us-ascii?Q?Xg3WgmEsv6hc4G7aU9wriuo9WrYM/NovoNnWHhkO7Z5WvTMB6HpIWAVJokUc?=
 =?us-ascii?Q?6dzhyaX6kJCmhki/3A4PTWI9X31T/7khd9kFjNwe+ZJfcdaqKB8vNfNyu9kF?=
 =?us-ascii?Q?8FSFDffTy7X9IzI7cedG/r6sxkz76h2HiBax1lLeAG0g/sQAnIFAIRASfjeT?=
 =?us-ascii?Q?Cg+xb21j4ayOi5MFROCoveJBm3zy310d/yfri6tkQZqV+XiV/FOerPpgV2HC?=
 =?us-ascii?Q?l/1yWUixhZYgMRcgiTzT9wkVY0VtQg7DNbD/N7gzBpJwN0yA1wp88jdUtn1n?=
 =?us-ascii?Q?sZbUMrBIOf32PfZ7RifY7jT21yAg8i8IwwSD/EvYCoS7Y0uK5dg07oZfZy/T?=
 =?us-ascii?Q?chz5qGPQ4s3dbedyjIHA0n5wLfQhViXYqGy0zynXyVOURkIujr9bVOsa2uyH?=
 =?us-ascii?Q?dhOECkx8e03LMbeHYark96kKEx55XEpdJTr1I4/SUqgnx4pZQOfxttvFDYqC?=
 =?us-ascii?Q?8U7rEz33/z60fu85D40pCVmDTO7QEKCyFDuX8pCzJVP8YAVmth9n8Yo9r4VV?=
 =?us-ascii?Q?JYaaqjDOg1qpWxQr32+W+Ee1RdY7ZowcVaUwwWqA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Op7x8oVmlt6RovapLc1LnR5r4fg0KiBKrACE/EvhzvrAFKv0cz4Lrdk+XKi18jiSHRiFj4sG/ALGUgnqvPq5LnQK1kxJF+lyXcjW8VtLXwUlfQjtQaP0UZw3K+PleWpwP5uf/FDVjj1rZEGikCm6F1e0nJBlGWKRDqZ4cl9pYKsWMe0FMO8O36vbV4Y+ekoDTrIswUvNpjfDVpaywwA03z6NH/lfthhwcVBBgxOq70EDDTqcizXkyQ4C7+dzBu8UGU17BD/WPjlcEamzj3kTNN40fM1jA9gdvPZ8f0qmG4HSseO197Uaw/XFB/Yda5fiO/1loZ9mTGDSh69mi+ExuOiKxmF9heBWpmolLM5Zwqv8P94BGdOGuYDZPlleN+r0357psguFrxP/SW/ZqZiXD6+g2z9bBG++iHOnlyMjSLmjkU+p9HR0LdtLF7BI1JViV5F0YC3g4XgkpvlC4siR4O7LA38feYmrWvbEcRk11+3HYa4+1P/phVnm2kZloXmqb7obX0UkDgkaEbEQYLbu8KWyXGpAVPKbPhvc0lr575WIcq/YbO6JEBp1q9gW8s8e7iR4cpt5DiVQszo4c1+wC9gVS0Tszc6+7eS1+38pb2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2326122-2026-42c7-6d6c-08dc0868ecee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:12.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwXffuRgkNISopCf0a0GbjZTxTVqAs7Y049Gv6vwkkAxtr6H1eaAemC4j+rRBZdtdSndJIjLLI0oE6sF3UAENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290098
X-Proofpoint-GUID: JjpzF-2GTyijMduD7OAuno25fMfe1fjK
X-Proofpoint-ORIG-GUID: JjpzF-2GTyijMduD7OAuno25fMfe1fjK

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index f91f8dd869a1..9dd2a7f49e16 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -120,6 +120,13 @@ _require_btrfs_no_compress()
 	fi
 }
 
+_require_btrfs_no_nodatacow()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatacow"; then
+		_notrun "This test requires no nodatacow enabled"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
-- 
2.39.3


