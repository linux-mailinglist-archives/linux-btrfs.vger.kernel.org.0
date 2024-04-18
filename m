Return-Path: <linux-btrfs+bounces-4400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090468A93BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754991F232C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900763BB22;
	Thu, 18 Apr 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gmkRxKi8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K05riQyf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399613A8EF
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424197; cv=fail; b=QttrDqQMsWy/VYjEduKyrH2RF6Jnc+YZrZWFFuVut+jrvV1n/LXyjvDUlZIsQvsShQK/ZsRas47KBdO+C38sxe2CzT5qISCln0HEU9uizfnRUn5n8e2p1hvr4SZGpHgmW3115AIrSTQ7zQ36KPFaBhyy19XDhlEaMkWenpo0zs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424197; c=relaxed/simple;
	bh=rA5m+NBPOATF7Mv7x5n8lbIRqj2ApMjG6+TjwBLP4co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXM6Eazlm1Wb3P7+3ZyvnJaCVaNG80JFeLxewSLkHa4c0dRJtWohJ9IGjw6Z7cjWPIqKCGKae3/TKwx0+o2dUDt5pK0r3C3dBmXbJRbVrEWxQYCt9+zR5LJ0CVaFSeQdBbLA6k64kX4pll6bWwiQDwf5vP88t3p85GHsFSQPsOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gmkRxKi8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K05riQyf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3xXZM009757
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=4KLa+tl+IaYSoMcUBxtRMDD90MahzhbzIu8AqicHbPE=;
 b=gmkRxKi8LlGj7Xv9RGPbrMA6B+Ke6u0xYj0bv9gsSrzXC2OdIa9MKNojSsutgMbA8gqo
 CkelzM+XeUGCZE4hkVoI0l1IEwCPCrlutUxslBpsWBmS/1zSqCOBCPNV4RAKSsOhzF7x
 di6dpDDzLyo8ckiZ9eS2ZKgQj9nHoHfgebAZIoE1hk3vBWAG8YHbTaEhWsQmdInbmP8n
 zpzFuC1JpM3E2+3zNfvxmAP58kXvUZ03QG3Fi6JwyiYWXZXhi+F6uurx/MViS7AgoYhD
 hhbpIvYtA9s4vn1PkfS8BnG9gHXY1Hymbl3nIdgzn3flJZdfXUuFi3g2bCE62MrwabTa zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbshfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I71PRT004349
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggg89g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWgWLKuxGsXD1MDNUjjm15djDRwIFzr0ALgStgsHdZWNlPimczBG9XXmHycrqnLVPbIdnnl0n8KYOBy2F24Qd+mI//JLAClj2m1Ct7LYOCE4f07AfLFNTowJGUkKa/RTWDaVlNE9nEolOz+o/88cCWRCtSDhqSz7PQOL4jCBMvCauNsv5PMImYqKgn/ZRU8iM3UdIQFUgVJkbqsIjmba1oHGQ+shHfC4Ghp4VVXZkcpC3nXt7NbKBCo9xR4/aAsVpZDQLg+sITog6WYRzfxek5z/nWSbaCmHa1hexdSpbWD2/WBa8BwJRMWzGFHsiRPuiM+0Rl+R5ggf1ObJMeWbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KLa+tl+IaYSoMcUBxtRMDD90MahzhbzIu8AqicHbPE=;
 b=JqWFtDFj+m/8rySQLg5Gc79G/g9T63LKX81vT22Q0uVN61BUqtYrKVsMdeUb9yFO0ih9nmRCyNHd/Efho7Nfs2mRFYetQWBwc7cQ16cB186We3PvvaO4NH+6Zdw02sHoxUYg4DhPlwU5J2s1Zsr+mqJSYiyVRz9/ZK2gjtJW0CSElY/19VdyNNdbCowOrfcJxZ2qCrX/uT3mAsTXw7VyBLdTsA8NiwT2eYqhA0JCw3J8zKYRzyNyQYvS32JJZQZUjmJLB7i3Di2iBsl25tBOjj+RBWCBOG4sqaXSAQpNKVnri1nweuUvK0hgZFddH8NaNCedZfC/EDWPoEmS2BKnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KLa+tl+IaYSoMcUBxtRMDD90MahzhbzIu8AqicHbPE=;
 b=K05riQyfDpp6TBphbijomJa1MO35EcmAJDgnHfH8PFVtltQHp6AtA65kSKLT8n0Bz8s4ceP0pnMiGdQdE6yZxnirLi6E1dGtFUNKHQCbrHlXYsdV8lrAgmcWrNPPgqIXtSLW8XW8DGOov8cfLC4aJHCmBOBQeB4XqjbSQDFYV/E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:09:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:09:51 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 04/11] btrfs: build_backref_tree rename err and ret to ret
Date: Thu, 18 Apr 2024 15:08:36 +0800
Message-ID: <172d0454803abb487a5c075ceeaec450a233694f.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 06289db1-3acc-4025-fe2a-08dc5f768a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F1p1OtE9ynPEOhLS6g5NUcoBsZCMBhnat7U+RHzltiUGfJUZU7qDfFTO0SLepOQ6oeJ0HKMz8h/QrQC/oE/rsFwFGGNhJcKZB3XjWvWh7JnAlmCpdEjHC/IhfXOVJpJIQzH/cQ+e4cDx6/gvzQswuID5fmfoGXv2ZVExLhPfeAFn3jhVqXVHUICj6l/+0b5tZCWFdk6znjXTbeV5E0oZiUN2S+A4OK207afrF5aDgJMoWXsK5ftD3ST3DEthxku5qMsO54vhCs1Z59D71FA6me22fSTWdpkpe7pVw4QVbJZB7shBiEMqrtRPVKFnylMOe817eNW2kkg3RgatV9xzO/52JPeloX5GPzUTgalpu+Jz+dP50926Jj1tTwiYtz8wSmKcoJvhjfnBXCrv8k/jGcUz07NzBa24LGnGR6aNtBEneDLUj+29zbG+vUV10sK64c7KD38aKcVCH5u7w86m0sHw1c+Z1GP4iCUPs46Pw75RUfLnPcf8oJgSYWbCHbzDIlBd16A4WeMP0J4dVEMHszlnYTPY5Wk51uPohafszGmc6y0OJIspq8LB9ON7aJnNVeelmh9ob8uiRfK+GqKBQ/qYAf0qnBo+A6eZuTlZFpNqAPR0sMAtwdjOcvWj8T5aMiRKOkivf8RXVRVNstmQtX5r86s1SYcmofceTB7QjB0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OoQanCcmPjMUKf2tE3MvPtr06t7r+Dx8NWIA3zBCs4yZleJP3eD8PyAOHGeq?=
 =?us-ascii?Q?sawwX8mDpkXdu8E+Ir/TciI3nwi14MtQMrd6Sy30ZN3W4cHYdUoZv5AW4XBO?=
 =?us-ascii?Q?3aRvuJlaVLqPsXQLyw5ahJSxnkfu9GFKn9PZjWOAV2AgnoQEeId9s4hPCeKL?=
 =?us-ascii?Q?6JEgVwBTv2K+V3IHDmUo67dBqEox/zRevMGJGc96P8rryOrEcW+QWGpRjAge?=
 =?us-ascii?Q?K4IWgt12NQIIYbj6WZ/uVZ6EY1kze9nLLV5xAufT8cBmMGurnHq4JmuPemGa?=
 =?us-ascii?Q?6IlLKDEN6t7k4pb5hLlb0hKMrNd8/BOqgqN6qFAN1nGG06c5VL+0R2XrOOLG?=
 =?us-ascii?Q?J32MwppmvzKfF4oBLYIqr4DLWRf7lWCkrxdxKJyzld27oQ+KU/5UQ02zAX7Y?=
 =?us-ascii?Q?nxLWN/sSAliNBhEWhdXS1WdZgFST+B5U8qUr9juLD8IC9XQfP3w5jcOcYPZ6?=
 =?us-ascii?Q?HBaqC8XpV8zER0Xjrmb/D7bewxT8Y/u6N8HlFBNUi3PKnDcIGDzU4u4iTcLe?=
 =?us-ascii?Q?U8fvm3U+4mvrj4RAqDwy3UhPp60TjfBSoa+NiRYOAbXLyaGAoufJvLKvCHnz?=
 =?us-ascii?Q?AXnd0rIHKd8VYBtIiX/9x4veOOcDwel4cC55REMMDRzugpeIIvgB6bRI86vN?=
 =?us-ascii?Q?NyYySS1vdlx5ASAuX8F0KiGcx3c5pGnEi5TSaossddawA2+lx0gP9vY/pCGB?=
 =?us-ascii?Q?dNBnKEht0N+ib+0/GvcNoAFdPgKw+JZ0qCGVTIUn4YYuEjN+0Tc+/xgSrBtB?=
 =?us-ascii?Q?8uC0TvykqHnM14sr9++Vw7OYbVND4LUFQtq6aO5xLIJzFdwNFoPxiAbc9ERV?=
 =?us-ascii?Q?1DvRmjByJykRTSBzoEik76bipLSVD18AhC+csm1vamSHYPlHtrZBis135tB9?=
 =?us-ascii?Q?dY5jKfdVuQ259JFR0E4tDaQrerc7Uetf6TOM3slxBKybSEmnNV2WCHe+AiLQ?=
 =?us-ascii?Q?dHJSuPnrX56lN4Z5mJMRI9INVHMifH+wK8yqSvH+cTd/uUkDlf0O+kgMiCIO?=
 =?us-ascii?Q?15/RxrRfmpcdRI0vW4NHW1fi5nflJ9rrxLnyOgVEcFG17GI6+26kgqmErLfP?=
 =?us-ascii?Q?z6Xy4sfnDMEdO3XBkY2Di+41khkU76i3WXoIBkNSy9NIEyMKQGMmKrYzn5fC?=
 =?us-ascii?Q?9I/dOkpn3zSyJS/LvWrZ9AohWYCQgaCIDs6Nut6vYlEjA/qj+kLsJwtd4Ju3?=
 =?us-ascii?Q?mfBOCqEMEZfgtQftugqKRuIXNmZMDnJJOCf7fRoj+vBv0DCz+50GlCnUxKW/?=
 =?us-ascii?Q?9hsaViuxUulDfdgSjSp8x8SxnHnCgeioRofWe6MSibn0+nYb/yZjPAyedYBM?=
 =?us-ascii?Q?ZdaTjeU7EZ4ZA9qHfNN2ELPkdKp8w+Cpc1e2XR4U3WPDUdrpXb/SkwqT4TUC?=
 =?us-ascii?Q?XqBHxOHolZGrV4pNzXlfhadGAHs13jozrP8Emfv3NQEJTRwztCKDl/BFZcWv?=
 =?us-ascii?Q?0u6XkV8H0Wr72CiDGu6KgE2eafd0OrnC07qfNruFXrHGjBX7jRxVltwRhVvw?=
 =?us-ascii?Q?G9tl8XMZaPCOaoQXXutqgJrimjIPzL/SYAW4gqXF48ZdboT2Mev+Xd4Pk79Y?=
 =?us-ascii?Q?0KX28g2WsT4voJN2LblYvh1jb34p5anbniw+8PRm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GrPQ/tWg8DNjN8uXVANNdhnEQxQSpLNQTBlazgg/gkawWJvqyVaMwCfRYTFx6DSrj0y2Oo7rUXESRxNLJCxRjDTLRlJYl3rNihYlyj5jtSxSwYCvF6qF7876+Ifc/q9fOeDjGghNE7tLUWBdh6PW4wd9D9707nIT3H2lmEK2BYnv40kbg4P6MQVPd7s5zt5HZExlibQYgak4+YrL1/Jibm6i4NrbO/KfHnE3smA3b9yd1lcVxwy8P6reGHSs0Jrv5llBIF/J+tLaivM2lY9K2vGIs0Rn9tt5+7uTqpJfwno0WJs82Gg/wO4t6sRTIAcQCtmKT0Fem0Zvw0OOZ3xG/WgEU8buCaQMtygGKCQkFCTDJOGrIhkOZtM1rR4dA2/Lpx7Urzgf2AuxSgOylYWbagxgR/ozg028wImy4WEJtlsDXafru6kKmrMw3m2d4IixpatPDPtEuKHbL646uxNxVP8fAfSuzdrt9vUiEhkw1MrfT3dAEi5AWfGuB0GfSoCMxymRZUFzMkZZxE/TQutbrhoLhJQ7pQeA/Ruy1Gg4pQS8cgQP3s2brB5PVptZ5vjuBbh98k6wKEoLe5mKY8Zkkh7whGzjX1uKkqcb7cs++9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06289db1-3acc-4025-fe2a-08dc5f768a6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:09:51.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+5kVFynxvVTSXT/QYjKL471NFVoGCMbwC8c41TVFms1ooXGoIQRPrwr+xT/5vc4TxlRyPdgYCZSSoLMvQYBhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: wBMD4uCc0SorRmgyGwMc4hc7dSUWcx3y
X-Proofpoint-GUID: wBMD4uCc0SorRmgyGwMc4hc7dSUWcx3y

Code sytle fix in the function build_backref_tree().
Drop the ret initialization 0, as we don't need it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: drop ret2 (Josef).

 fs/btrfs/relocation.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7e7799b4560b..aef7d286252b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -473,20 +473,19 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	struct btrfs_backref_node *node = NULL;
 	struct btrfs_backref_edge *edge;
 	int ret;
-	int err = 0;
 
 	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info);
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
 	node = btrfs_backref_alloc_node(cache, bytenr, level);
 	if (!node) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -497,10 +496,9 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	do {
 		ret = btrfs_backref_add_tree_node(trans, cache, path, iter,
 						  node_key, cur);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out;
-		}
+
 		edge = list_first_entry_or_null(&cache->pending_edge,
 				struct btrfs_backref_edge, list[UPPER]);
 		/*
@@ -515,10 +513,8 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 
 	/* Finish the upper linkage of newly added edges/nodes */
 	ret = btrfs_backref_finish_upper_links(cache, node);
-	if (ret < 0) {
-		err = ret;
+	if (ret < 0)
 		goto out;
-	}
 
 	if (handle_useless_nodes(rc, node))
 		node = NULL;
@@ -526,9 +522,9 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	btrfs_free_path(iter->path);
 	kfree(iter);
 	btrfs_free_path(path);
-	if (err) {
+	if (ret) {
 		btrfs_backref_error_cleanup(cache, node);
-		return ERR_PTR(err);
+		return ERR_PTR(ret);
 	}
 	ASSERT(!node || !node->detached);
 	ASSERT(list_empty(&cache->useless_node) &&
-- 
2.41.0


