Return-Path: <linux-btrfs+bounces-2892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A7F86BE82
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C147281EC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31436AEC;
	Thu, 29 Feb 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M4itmRKi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WgFfHMwx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B935364A0;
	Thu, 29 Feb 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171458; cv=fail; b=JPVTkFPTBKzu1QhopGacIl72fzVMIFv0n4UkQQQ5AcLd/Fn1MXb7mMIMwDCG5x2pbVhz+R0v+2hKEHiL7oIFWthlE4eyGZhmhpm1G1qJk4qnydIyfsxhN/hztUFNG2QoNUc7kv3kdRjF00gincVCIQfZaucxVMAbwPY5N+9qaXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171458; c=relaxed/simple;
	bh=qtjpiAWd7r3zjFOm6VEriebIS6Pt0SvD2kt7jygLTx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlHa/CxxVWh08P4au4yvXwZowR0t9AcaxgU+UrW/d8rAsg3i49n7ttu2TaIEVs15H5LyETLlSsboZuQGu+Qidl5qKczHW8NEgUlNrBMacdKAHkZFeXspREWt2Mvrf4Vwcm+vZ+3WnZD/5ytPYCnCKjmIxLFDRUuNzGal0mJ6JPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M4itmRKi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WgFfHMwx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SK42Nu017707;
	Thu, 29 Feb 2024 01:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xwl5Pe9POUO0Vm5iZNSgZmIhbqQnvQLus571DNrqcPo=;
 b=M4itmRKi54nH2gee4xIr3fBaCVAXSPIJJns58I43eC0vQW4RRC9NnM8MmskqHxVCU3hV
 ww3MgYWxySlO7E8AMBjQuXxUQbpl4izeJktdgrte9MXUpxKl5rUW/DC7EohfiHKhLVaA
 0jHpONqgl/HbnUJr7+5AmR9kqO/HPobeij7hAeeqQjVHd6Wf/zMuHePj98mCDMeoWgme
 PunzBOEcRkemndkaG1GENbc1REp+Bi3FVJnHrz+ABAjQxWNWKmqArjkmn1uA+typybIx
 ov3b0LWRmp6MDNhTAKC7IzYo7/BBz+m4CItpwqlEAKymvp8lhNjMCrJscmndFoVELrhK LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdm724-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0ZlgI019390;
	Thu, 29 Feb 2024 01:50:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdnmen1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2D8cTscXrZX35xzeic4y8oZXl6EIVPHtaenNOZ9+Io+wYQbg2vA9RostBXAZOgEfHFUcquBm5DSACtMXmRPDvx2CsuXHlEK0QVAOrrBhHpdDksxHelS5NnSKX6cf6ROPIsKR4Yuq+TXP4HFEMJD4XUEqODXVArucbfd0t/32XbYZR9fl3/HommUxHFFw5aOs47fb6drNUUaOsyHudNflYP6eCyufKQZqxZbaCs1wnID8R5NldZrAVb6qomKn7BurOhRKe54FNS1G2/dgVQ2XERvuxp7vxs7tf8CHUhm5lV6Eyro/k487KJ7SU9bKdxEMkbsK47M342Y8v9qWVD0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwl5Pe9POUO0Vm5iZNSgZmIhbqQnvQLus571DNrqcPo=;
 b=Vql/H4XDRcY9/dmCOzT3pXU3Xsu9R2RjnJuagGA6be1mOIwa0Vzccqvyib37DFzjGtFkvRzLR728eU6hM8cs7YLODSiYcH4cN/B6DLZ8fAk2kjuH3PlV9jK1/SM5H0gKTfxVT5uGU6CK+ZXtUYmpxvlXr4URCkhMtlwKA+a3z3ThGVsf8KBtG6r2jnPcrgHds4doKRvJMp4sMBQzXAO90bNt8iXSuOXi7E00D3jyGSNRLDMJx9s8vhNsrPsFxKdInkUTbveAJMWY16/Xe3bRUCkQd2eNSQK/4Fny4DtO3tlBtwuhEvlggVwY5m0AfrLG8RuE1UL6SEuFhx1CTgDflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwl5Pe9POUO0Vm5iZNSgZmIhbqQnvQLus571DNrqcPo=;
 b=WgFfHMwxjniEwS+M5vUjdEWJI7hYdIt+lvs3XwlC+hoifOaFUcEMKfAIbPHQPFMbRDPlH8aJhUyzt/XnoeXtA4wEjtRRpvfY8Cl8WTsFpHOVVsYKH7UpzQGw9g4ktrkJ4pXJA7EJ7G7m5zENiRQz7AcJxezEe2rYYO9EY7N1wF4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:50:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:51 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 06/10] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
Date: Thu, 29 Feb 2024 07:19:23 +0530
Message-ID: <773b7278b53dce51f6d0a797f9ffa1b3efdefe50.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 45969a73-6ffd-4940-3099-08dc38c8db9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eqgd6uKM6SRbcetcW0jyihSt8WlH7kCZLrDFArIq/ZO47F3CiQNF7wFXvYTskPX9CEVRgQhHRztGUoenQFzUnHTJVxUn7vimqlWltAke+hTid8EjcrxGoowzIledinWwDypVs0pwIK3YOTaxqX2mZc2YUMSCf8gbfriG7aVNUoh+Sy2lYQ1bsMTzyfNQIjCSAqKHghI8yZlWfFr0S7cikAj7BxWVSUVjtTvwqgzHS2iExrTIE4y/LtxSH0VCbGp5yZD9Am1VjugiDHwt33rocXPmfuTJiQ02yEmxPj8NWUyzBCyjl3gYAV6pJsnslTQISEc04T8qh1tjpF9t8wQ2No5ySa91rmEgHpHOn/U+/v/mAyR5c2zikORpmpIOidwpAXOMefQGXeAQzO1R5zyx7Ocmchdf0ec2DxAoJZ/IxMeXny5i2YvIs4K/ZfW176BnKrBNEpABUmlzMt+Lf5k8MS3QRmBKbs8k09YXhSp0B1vm6xLHXopeY+kv+GcjUhMWE4vTtcmrJaZusl0bkJlM3w5RQ3SIT5hyYrgY3Q4VtcyQPG2krGV3kxL1/nVy9z4/0XH7HckkbyYNRj2K7rW634Z+XTgHXmhIqL1qYEy6SSwtm4smVToujts3LlzdWe0+rWIuI0I6omi31kTCughF1g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HyuQcG64V5HVCLPKWeoLx+D69aroMMLi0+iYByr9HqTbWCDVEsLvivIwRgcD?=
 =?us-ascii?Q?Uv3osAiIzePyPfJGX93zS6yTJ/VQnJDJ9j45EL2wyFZlBnGQ6tl95pCyvDIc?=
 =?us-ascii?Q?zfWxZVPlz5hhsX3ydlzcxU5y1cF/GpQacO/MnXC4/hdBNZwqyNVbv7jdQ65H?=
 =?us-ascii?Q?3/KkB/S4NojkbmbRfZmk3AeQ/YDsxXpJsto+8Qjtp3gcjxp8ZXz0BqXxEiM3?=
 =?us-ascii?Q?KKjiFKz5Sgine2fYQIJqFABFuLiE5u6XxaO77Lt3w96sU3gAMFiPa7JEy1uq?=
 =?us-ascii?Q?5WQS35rkS0snKjQlz/sAoA8YACn3aBkI1we1aGgcmg154Z0ewW28vSYydrOn?=
 =?us-ascii?Q?crWYoafoayQIgXag9pY9Xgo/8gk6WvwAhu37Kl36EQ6SU/+7yZio2rTJR6Ct?=
 =?us-ascii?Q?YsjOyrYeEt3BNavnKUMRSV3c5aOKTo0kWOWdY8Oz0ZWg3VwAXloUPbBvQfZ7?=
 =?us-ascii?Q?bbaly27ZkM6awosJJ6B/9B4zDXchIbZyo8FzYrShZ/nA18D5hrbD3ok/JpPD?=
 =?us-ascii?Q?bFmnLzZIFQyzHNwuKAO9cNV/77Rgp/3KAmjY/2YkBSq0C+etqQ+AajY1BRML?=
 =?us-ascii?Q?/k69LLwWILnbeeAensRvGm0O4qEd1sPd6VKGE59jQZ8k1nV/MhC/LTxqftd4?=
 =?us-ascii?Q?lwjNEj5TrZqmyfmTdtKaZL1Sd3A+8yVxYu2XkJy4P8lR9X5Qw1QAOHK+g04r?=
 =?us-ascii?Q?yMsxyKCu6ZO9lBWbSa5ppx/rfP6BXZ+VTbMDlHobkLMb+ne8ZbN+RnzqAUSB?=
 =?us-ascii?Q?Qov6C8FuaVAoI91gZhzmm4pIPG/AI+7evQTyjXnXhK1E5EFoYd9sdclG9Wsd?=
 =?us-ascii?Q?lsErrXkFDCVigWfqvCPRkfIGP2+oz0HNSZV/47T4g6XAGm7l0DbJnc0szZKu?=
 =?us-ascii?Q?j3QKapZ96xP/EqCN9h9CgFt7/s3pesLQ+LdTFWPG5K8tKVNiIXLEq6D/t3vV?=
 =?us-ascii?Q?m/cpiJwOnLvfjeoelN52rlTNZC0vZVcpSMcLvAzv0ZMJYs5gAHFPSCcQKzDk?=
 =?us-ascii?Q?m2Hsk0xt39zql3XTTmjlc9rhOj4tOomrHNiDRk5ZDRCWg2KsQ8WAKoJLNplf?=
 =?us-ascii?Q?MER1Xt9Eu/VI+fQRCMS+uH6BzuPML2zi+D8dUFxVK3dvFVRSsQQT6APx4Yp6?=
 =?us-ascii?Q?MI4ELyWt9HKLL8VE8gVjg1znAl63WpMpbFN22uWS0Fmvd3w51TwLbLPRnLu4?=
 =?us-ascii?Q?/ndh7fuFtZF3CsjvTgj2WqQbZijZ6MPamQjSfGQYzuuiecRG/MGqTXlKXj/e?=
 =?us-ascii?Q?mSL6BBbPgSPKIHYh3nWDXKTWlvmzVn0danbDJB6D82XpsfvXO0LD+ycpJXZP?=
 =?us-ascii?Q?fxt343R3ilhcX4DtbOSYvcBctzWFErxk6Qmm8ABDqEH9vYwO5aJ7ndY0JOxU?=
 =?us-ascii?Q?8mKS2ifnyVAIhRG1HRGRZWnpD8727A1SA7l3W7aEd82dBJoJVIZ/FihE/MX0?=
 =?us-ascii?Q?Ifd27+D2dMS8rtmxSJOUUV4sRCDE7mTMgsO6KP8S9QPG/8DTSe/cU2d2dtlv?=
 =?us-ascii?Q?J4Nt905kMCWishl7eYhg/yeXiHQUQlf3lN89ht3pYfQUzI5QMYmE6qvsfHR4?=
 =?us-ascii?Q?6Ir3R+umq1PCQPPoC3zNOvgHShufoJrebFgeX5pb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WhCF27/CuRb8TJPOQs57iWfYhDo3ClzbnLimZOKTnkSq+QMgXAl14LRzq3a8v+uzFZuKOkK9YmqDmy1wo12WRkke0g7TnL9qvVwpq8BXH7A+EDFD8WxFDhj5CfHBMEAgIJ3B1ZCP1emciTer8722fdq0IWJPbJPOSycT+KLlvPxsIV0Z0DhGTwXmt477pzmDjxhw9BzqWRqEs7tmtpcyqWbxPruvmU3ZD1r+46gp4PDEDk4f7b/wvL1096jdZg63X7wC7BK9IeU2tFwyFBdSjLRm6gQxW7Cr/gykLSRccm324rxonFKhXWY/rgl2gLRbuDjmPnBLNq3PXgUP7pRZ+stCkJ987juSdVolWslaIxsGWEJsBq/l5EZmYf4H9QYot1nIKnez1v414C9zyIjqcoie0EoK6JtfDRpvBaMlEGf+m0o0zAy7M/Stksqdc/qW/jOe0CBA7+5jC/icNhWr7Hzm/OplpngEA8oXKW0ReiKrXxXEfTIbgaK3To7D9tPcZWbFIA5BlIT1+FSi5VoX0fJ/XMezG0N7+0h57SMQRaVmkFo6J2TPoQy9GLSaa89nJZTL8o9xBxuZqWDBKCKIB/6uRDhj1t48ZLNKmP6SICc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45969a73-6ffd-4940-3099-08dc38c8db9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:50.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FL23pwhnH9hqDIwHZ3Cs9Nu5A1lG2lSTakHFURCiSXmjSsnGN324k2RhG/BjW7uA85fo44zvISS48/bQpu1f2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290013
X-Proofpoint-ORIG-GUID: WPfQOI95quOJ6VaYEM8NoPtduPW6Y7qS
X-Proofpoint-GUID: WPfQOI95quOJ6VaYEM8NoPtduPW6Y7qS

For easier and more effective testing of btrfs tempfsid, newer versions
of mkfs.btrfs contain options such as --device-uuid. Check if the
currently running mkfs.btrfs contains this option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 5dd0f705fd90..fe6fc2196e68 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -88,6 +88,17 @@ _require_btrfs_mkfs_feature()
 		_notrun "Feature $feat not supported in the available version of mkfs.btrfs"
 }
 
+_require_btrfs_mkfs_uuid_option()
+{
+	local cnt
+
+	cnt=$($MKFS_BTRFS_PROG --help 2>&1 | \
+				grep -E --count "\-\-uuid|\-\-device-uuid")
+	if [ $cnt != 2 ]; then
+		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid options"
+	fi
+}
+
 _require_btrfs_fs_feature()
 {
 	if [ -z $1 ]; then
-- 
2.39.3


