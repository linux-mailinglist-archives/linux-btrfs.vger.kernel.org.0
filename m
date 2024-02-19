Return-Path: <linux-btrfs+bounces-2543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C6685AC76
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145001C22E1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879F524D8;
	Mon, 19 Feb 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cikr8sU8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TPkiONRO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A85A10A;
	Mon, 19 Feb 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372212; cv=fail; b=snyA+/CHvbKkz5h8eRSK+X/XfyijDitJRvIKIjzupUb6KdXWvSuTWXWR0du8vP4WWhkPwyoj6/+GNPt2vTeiZ8MwG8zvaiRU6QJYl1p+cJBmv6Rx/7IbnNUbKyBUj+GG0BJCNZ9NqpNsgXYYABTaxquzv5XF4hpJjyc6hnl7orM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372212; c=relaxed/simple;
	bh=rgmF3qDUPEutVCV1kJnsQ2iIdpHoti55nDu3oKf5DgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLRZbBoie86RCTuEl4Govw/mdylV7qF1Ngm0ZW0aBhynWFXj3+L90Ao9T+z5A4OEjuhBfxCqBfSBSZedTpVPhDMEdl52Q+jatK3H8Xf/iuZoqQR2MpZHZGw1MZtKNos44ypCmTFj4IL41rw0a6xsxIVgVjv1FeYEnygVlxJtt9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cikr8sU8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TPkiONRO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJ047007941;
	Mon, 19 Feb 2024 19:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Ldy/Nvhd0AZf00ID67s0cK/PJ6MXUppZpwua55dnjL8=;
 b=Cikr8sU8nF5YouOYKv96vur9BinkxpdQX3dYNFQLcVuRBLZ5wF6bUXeiIfGu6KfwcsiX
 GYJaNO43xA4JPjLAeUUv92KZ+vzP2o1xDN/9CIPEArgeyYPM+RF1EbGt7YHKmnOsCNtR
 41ZHKHVBKMry6mZQXK8jTyY0u0Hv9Z+WjpoTuqFOW9nrKSXZUCs18QSBsUEb+wCttA7G
 ZhE4hUyudAU+/MLFYx3US6T06qj/SVxNPDCCjzcTmTQDtsz4ZJcGDHbzELw/9Z2sAXbt
 OAm787wiFlqfjd49uPX0YRn+Co4zvF8CteuPl1VTYz4qwnUjUHDUbnJCFgKLFtVH+g6d yQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucw11r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:50:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JI8pis006608;
	Mon, 19 Feb 2024 19:50:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86j068-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:50:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=famkb3PRNBaHmESEdIzPFEB5lwA86vXlhtNceT3n75INsv/iukU6ae/OdhLSJOIepZQEIrhnKmuj/V8C0d8lYi+qr2ZLSG+wx7ba01G4reHIE8Nq21fxnSNUkxNhT68poxmn8SblXzq/I7T4ilP6XaImJgSuiG/+vdfTViBTbmEQp3L/ltN3huMiGqdKwhOQHsAs/XYt0WgvYMJdj/wenkx14K1kctZPGzG7oeAsCfnsGZxe5Ac37Qe8/8HUdbk5kD0fiW0JDKVkpxNiSj5drb7YiID9ejsQeT8KipBoK03i2zuy+OG/xEGH7uCZ74OLDWZSeATyv+cZf953Qap/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldy/Nvhd0AZf00ID67s0cK/PJ6MXUppZpwua55dnjL8=;
 b=Qsmd9S/jPTgCGOJQjqYi9duzzcoa76wS6BfPnxjGzzhrqcsy5eDcAsfiwSVefIUROyG5h2sNnQ/HTp81X+G4OMx3p7dKiZl0hNd+ezaeYRgjDkTqcYX55nbx1B5g6WTdyTKUwfSKbR0LbNQMUEmSRB1FlbpY/lf71MFOZpnucANQWxFPSz0v0id7+hGy3QZAy14Gad+1KGLNGsF6XHVZrk8ZN5yez+94P3pMhgsocexoUSltmbQzfdymmHvYl1W5J5Y0SXoLGA3Esefr85xk9laBauehzFTm33h2M0HAknx3MAoW42t3rH9itUhMJjJcGwV+zlr1xjlQtBpo7nKiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldy/Nvhd0AZf00ID67s0cK/PJ6MXUppZpwua55dnjL8=;
 b=TPkiONRO+QXHdjn0W2Kn0A3TB6NGKNPsFZMSvq1ruiz5R4el1uCvtt9N6sf/2sV/QIFbCOJ0QJP0lSKEtR0ATb5H1bp89k3D6hCKuLMOYv57M4BEUH92YY73FUMjHIlOhugzxTctEVfRGQoEhsIqF4NKRNsHqEBPPoRjDZrSLNg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 19:50:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:50:03 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 10/10] btrfs: test tempfsid with device add, seed, and balance
Date: Tue, 20 Feb 2024 03:48:50 +0800
Message-Id: <bd72599f2b44e4062262421ca52f83c3dedca1c8.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 2451fc3d-a2e5-4fba-da75-08dc3183f6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RY+ENs+AHbE9JCoCbQksqSO+zl7ysinILT2KuiPvDKc+fJijajSUGhderS3Z/WBjJjiCeFkhOjgLS6jFKfjn3JfvF6Sl9/6m1ipVatzU4HCtryAZv4lt0k8dGwgJiUhcMI2n3RE+W7FqY0EBwIsSBmi4TlKvhpJ3bKF4aGLTwmaXdu5WhmUlhIfRanUVkDp4RPdaEhRyY1voeVun4Cwj75t3m2IDiV1GJjcBYljZBBPMh8EKgT0eWxMDzqjj1ZemD6v2L4MA+Q/vM5cHdDiGkDsmLB9Bsita+DbwKNyEewXyCMeHqoZfL5g+zLUU/G4D5NdX7UTtt7hQX86QDZUiSnvd/tx7MI+TBWsqd8MJ0SiZZKJtJs0e3RHfKHTj/OSkYPjKdTRYhoAG3mV5PKdvfyqHeUI+tXy5WakVbl3lF8R3zRiFlX0PMZASEhHt5wAZtA2q+ukaSDXs+LX/QwZlWovXWbuGQz5r7Bapn9g+ZYiL/ols63TgMTRGTlLZEPVMXpsx/6fWDB6nGafO37XLzGG/cMa153Rts1ZhEXrQBJS1y1negH3ecswPaNBFllw9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eYvidHU11pSwAfq/zzgoSEEfl4lHfSfbv8I3OPDEsKa+EJiHIP2r/tSI1sXY?=
 =?us-ascii?Q?hXSTsIa22KSv2HABJnuNNNQD/Ljmd+IekTnuo6cw7aj2UDkskQnVkrzzW5Oz?=
 =?us-ascii?Q?+wD4l6tGpOTJdiicw/EhQRjYIc7gA0Mct7jV0B0dVHUin3GpgsBIHA/y9D3T?=
 =?us-ascii?Q?EpJGw0MMZdx+nRRCRhrWXN6CjY3DAVfitxxd2bxgcCn9K/hmHRLoCwnSZ7Ie?=
 =?us-ascii?Q?PkmWTsQwkArzqT5db7JbPAofl5d7hjzvf8TGg6qI3xIVs0IVskfzejOYBKc2?=
 =?us-ascii?Q?/EhwsmF/YpoHcqC/OQ/6WbgBi54qfTaDrFFbLv80Aso6pVaFxs2bt8YxlvjV?=
 =?us-ascii?Q?BfvjRgnmoYaVyDpSOHoYF5xGv4FBB+0Imhkilmng1h81XkEUkPcEJGG58O/i?=
 =?us-ascii?Q?hkRtqdWaGRTWtQ1uX4xZloxG0KEhOO5Sg0IFBVmRBKjHdLfGfbk1LKRU3IFJ?=
 =?us-ascii?Q?QX8tozmDGhQN3yVSz0LiqBnLYW+H2hTEaPHDpaRqX3pYpMIcZdA6rAtAgt9G?=
 =?us-ascii?Q?o2Mt1oDzUSaJ3PMhr8TiUWOarIzw0vGbO2sPpbTRazQgpp9EKyfu5+Omo5kd?=
 =?us-ascii?Q?BVfBI7Ucx+uoPBeSmx+mLEHtxSgF4on/uYNJOM15EDu85Xx5UI3ZdGeC12pC?=
 =?us-ascii?Q?NblvABui2unSF7WasSNWbMQjemreCYsFzxdiPwIpHH27fjNa396D1n0JC8S/?=
 =?us-ascii?Q?C9I04OqlPQkD7Ba6euRHaGc2ySgQwL+rW/7HTY3xwTlmOwciy+tOkFVqCC35?=
 =?us-ascii?Q?upMxH8c6n7qxC7Kt+aA+8WE/lLoLmcdBgiXoJVwveJgubwoxuDCTzp1fPZlQ?=
 =?us-ascii?Q?jR8J2XRpBJintvM9WO2hSgJoV9SeqSN6NkYAABjYunQQWNjmEVVQrm/7VaOR?=
 =?us-ascii?Q?5rPxzCXKQCeL/GKeLspN30PGYpcasB8Cj0aCD3WztRWWApq7v5J6f6Ksg6gt?=
 =?us-ascii?Q?BUGP/g+AVqqgLRo/MiiIMfGkzNBK4MY+/TZ4547tXDrIoerghpl0iDbQqWE3?=
 =?us-ascii?Q?ZAC2elsC2Kr3x97a2/kGRpMdci5AE51oRAovE7KnnKUfZ0XLiqwhr2EwjWI7?=
 =?us-ascii?Q?2LcK33y7j2PRfIKOVPEpt8QbyZultvlW9VMk2Sj4gKCN4vHUD+bAoAXWFug+?=
 =?us-ascii?Q?LAwRed2DXaE0KacyYpUFtYIQKaNVpq7cOInuR12vlyXRnFID0NtCr9205KqC?=
 =?us-ascii?Q?w+nIrc7hoTyDJLy1C9Aj0fKM52+M+bRDk1ft9MLGDXOmybzhN9Bg0zblHTJB?=
 =?us-ascii?Q?ldsGZZIHYOKwQzjyByzT+iM9C99EyL4weTS+o2Mv2MTJ4E2bQuxglNv4ndSB?=
 =?us-ascii?Q?meRq1AB2zw3QazPp41WdDBuY5NiKbBaIysH8GAJ2Q54Cx5fjuxypWYUfb+GP?=
 =?us-ascii?Q?pY4rNQ52sFVE8VCDabDevO8UDDn+9KMlGqQCmeq97L/Kj6Vet4MHqpLelqIg?=
 =?us-ascii?Q?jJp+Lld1ZhrweGvX7H3ukhwU78MODCRLIl5FT7cdUirv2oRbNHhqE48r6YCV?=
 =?us-ascii?Q?jZsoqC4zqVfLZuM2Dcbp73+KhewWg3RqpbVp+aOL6mskKM18fc+dJ5Xiy6EA?=
 =?us-ascii?Q?nb3ObqqqqkiBoxlmePRtuD+3KTtEeGmN3bB5DEAj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cZPID6HQ11s1z9dDt+xCl7kA9MRMNB9SAJMUgtFKMr5HMdryZeXcFDDtJz5rdIvXIC3fqrE6Ytt8fw5L/fzIF4v59gOEnU7rUZ24Z9jeOKMIdQjlBFEB7/z3lzLaETyyR9gUZhSf1pfTFSBAP0YJnAFXaPijV+AlZ2/C+1Mpf+lHKSd15oHEokkSzl6bfr2ZWC68R1hIcUE0iqki/UgduE6/sMyQiT5cEFEtv5I55xkJMnzJ19I3OFVPLy5gkwiw6MM8psXY6N5DnUBSkI+5Z/2hKPq901WY7k/arXKQ8yeS4nSkNR7/zR/RuUZrWLjQnraGZL3PwL/vTcUwoxXhqv71/JziRiFrjUgGshmFk+TNM3Hqt+rRkEOemHim1FqR9tHflm5g62XCWX3nTob5LVhxLdcfGbzCMRPe4mEL7VVt/erozpVCwT23Y7uHmK0LyQrsKCCK7wByxyEFDuVG7ITLgm2dKxpDiwmNvh3MbWGgZ0S64o7+VK18UHAKwEDXXUYhyDSylQUBwv2v8PRpin5RwOn0RYfEgnVqJHSEDKqUA4olSrcXmbbNQu4Stzurn+EMp7tBYRYTDcGVy8lVwDn8jBTkA0iGEVbq9njYCyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2451fc3d-a2e5-4fba-da75-08dc3183f6dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:50:03.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N1DmmRbk15cjJyPinGMW63nG1b1BuNdLrxSXumncBUVbWhkOmtEzOM6YDL644sL/T7+0NJuYIf5GKarzYoK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-GUID: CivbLhzb1MdgXnD8vFEaMvdPecEFddnZ
X-Proofpoint-ORIG-GUID: CivbLhzb1MdgXnD8vFEaMvdPecEFddnZ

Make sure that basic functions such as seeding and device add fail,
while balance runs successfully with tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Remove unnecessary function.
 Add clone group
 use $UMOUNT_PROG
 Let _cp_reflink fail on the stdout.

 tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out |  9 ++++++
 2 files changed, 88 insertions(+)
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out

diff --git a/tests/btrfs/315 b/tests/btrfs/315
new file mode 100755
index 000000000000..4376c7f1849c
--- /dev/null
+++ b/tests/btrfs/315
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 315
+#
+# Verify if the seed and device add to a tempfsid filesystem fails.
+#
+. ./common/preamble
+_begin_fstest auto quick volume seed tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $tempfsid_mnt 2>/dev/null
+	rm -r -f $tmp.*
+	rm -r -f $tempfsid_mnt
+}
+
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 3
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_mkfs_uuid_option
+
+_scratch_dev_pool_get 3
+
+# mount point for the tempfsid device
+tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
+
+seed_device_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
+
+	_scratch_mount 2>&1 | _filter_scratch
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test_dir
+}
+
+device_add_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_scratch_mount
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+							_filter_xfs_io
+
+$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} >> \
+			$seqres.full 2>&1 && _fail "Failed to file device add"
+
+	echo Balance must be successful
+	_run_btrfs_balance_start ${tempfsid_mnt}
+}
+
+mkdir -p $tempfsid_mnt
+
+seed_device_must_fail
+
+_scratch_unmount
+_cleanup
+mkdir -p $tempfsid_mnt
+
+device_add_must_fail
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
new file mode 100644
index 000000000000..e882fe41146d
--- /dev/null
+++ b/tests/btrfs/315.out
@@ -0,0 +1,9 @@
+QA output created by 315
+---- seed_device_must_fail ----
+mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
+mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exists.
+---- device_add_must_fail ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Balance must be successful
+Done, had to relocate 3 out of 3 chunks
-- 
2.39.3


