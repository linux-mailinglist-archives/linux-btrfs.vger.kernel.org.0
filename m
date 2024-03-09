Return-Path: <linux-btrfs+bounces-3148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599D87717E
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792781C20A1C
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD564085E;
	Sat,  9 Mar 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7Ixyukr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y0qSSLWW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893316FF52
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991974; cv=fail; b=EpgFsL9Vusex2V+kNFf0OtEiEm18PRfN4f5CrMsFeadOculyIX432siVlswqcAogVdqVh2LsYhn/1kDYMDvYCKKwDql1dhtp3rqUbl7O+cHjgngFYng4wobPGoaQd4tcRCacqi1gn9oXBt3BfXY/kWK9YM9Czy1z5yE0rUu2/wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991974; c=relaxed/simple;
	bh=G/ofob3WN/6NR5zXFlxrJhe/Nc/U0+xvv+6tHcCzMRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XnO8kbfmrddSjiq0PhtZXHCI6Li0REnMZ+SghU9C12cj7niGM0inZlUZFEcLaVE2ZnzJbBJjc1KNPNG/vejowA5WTqNn5tqjy69kXa+oUYofyN6ZcnGQ0Jud7xYhG7iDQIgF0l4hTpNAVIIWjTb9YKaNwj+0EU9gbZ7r1qUXwH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7Ixyukr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y0qSSLWW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4299iIZS010367
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=gaVUagMAK4PcF0EIEzdkJflkhNeLO9lSGBcK/Fe67AU=;
 b=i7IxyukrfNOjTtaRIjpJ8BkODu+7nsjelGiZrUcokkBqS6e43m1FpgqzkUhsskTUlxz7
 RuSeT6Ai09er2BVuM7RkX7yyup3Swd9WtbUQyValZ7EI6tNp2tT3vFNpzWHsjeFE1PbP
 9CoOUjDXZBG5kRPut7+tsYr4PsEqIpOmyR8Uu8ybRczuk4CGfWfldYWV/wEexF+RgD1p
 f6EQ7YKdYwPBUzQGIyZlmyd3KzNH4jCkPzmeeDO3EqK2VtdBCoxQRhThVdfcFJf9wO2U
 K1jGlGSTIiq1g5Bg9Rfx+oINIxVjBS6pnxZVj4VvGGE9L1vVOjkCyJyvF/L3yydPWjtq jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec28kfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 429A0akp006065
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre74474v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VESDu81Y8J/m7vrJGOfxRQMlcPAHHqk8AaBJfm4M/emVzUqV8eOMLwI7V8J6Gcv6pKBE/OxvT51hpAaaa8S6J2kWBxrM+E0UWJIDHH70V7huYp/9buuVZ8/fTXwY1T67At8l+/yGvEpTYL6G3VBhtdhSYBFo1KIYA0juyMvH2zZ2LP9VzYXPZk1h/ewtZ4xzN3KtxFRUqRAlneeRVPGoMR6Fj1eZFID6VaEIoOEU1XQ1q78MZe/WToEmu3QifCZVEpY7bRnn2ckhCok9FtPDIaEJmG2bCXmCmGoLU/+Vm6oRzEHz7lOtAf2hr9c4BO1k9gh8qR15QUtC19LwoWfzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaVUagMAK4PcF0EIEzdkJflkhNeLO9lSGBcK/Fe67AU=;
 b=dh2/lglOI/euRNX9ciwFbh91chBzMCnjmEe9vVKPjBrl3X33WCOQ0TEDRzdlC8Xl3XXUvvWjTrL+zrv3HkXcqgE84CflF2xG6kZjmRiAw6Fw2a3SaCp+ryNmVTU4FgzkjvfIp5ZQi1fel6qCaeuaKOfebnk/cI0jDssCthcrn0UehXYIFB3DEgeYNNrOwc1d7n2XyNPZ3a+Xt2cQXRwXEjKRUD177SF7lk8iivC599tcpDi9PFZCv/pkkYWaiM98zJSO2OD+7rD2Ei4pzcZJ3judMWQuRZHVTj7BXhmlOrNFR1Hr/URt1Oe6EGhk66lt5cWAH+73+iTqgr7jUxqgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaVUagMAK4PcF0EIEzdkJflkhNeLO9lSGBcK/Fe67AU=;
 b=Y0qSSLWWkUVcBQUzsG1hcQxZA3YWM44CO1FjcENlb12gL7Rjg2+pN4sg2J4wTb3YPwwnOwURsvoFBBsADxjfG5qN1zOiFyEPUOfC5/5k7J9nWQ3Zb/mi1JYx2t5X3YQqVmuoUaTO6TSFbdLCbYcO4F4tTzXOyzX7ac/AavkdTpM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7509.namprd10.prod.outlook.com (2603:10b6:8:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 13:46:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 13:46:06 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/4] btrfs: refactor btrfs_free_stale_devices to free single stray device
Date: Sat,  9 Mar 2024 19:14:30 +0530
Message-ID: <a3b28db087e92ef21bf9303efb2e2209a18018f9.1709991203.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709991203.git.anand.jain@oracle.com>
References: <cover.1709991203.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c327bc-701c-47aa-cb50-08dc403f44c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sjrvb6YM2tRScQiwWJHN3e34dFIZuquBMhRYO8Re/zG+rImHEPAaPUDHVEd3/yGZyDALXbbSD+LiQKc1TrrA+i2hKEC8vVoOE5CNj+5dbc/DndzdokeYkwFbBD0CTjCejKIVZAlTarVEn2VCkQWZkckRuBXO/o4sgDcYQwo5YoxJk561DxlwIC4z69CcV93cw2tiZ3EUzfr4XucSqKyi+eDCrGBYO4J1GUmpboRnv6pWP4u9RNFC/4mtAM2JnMQa0L2NkF+/q5s5uAqzPJju35/M43V3CkevsGOn8ZwEj79qA+5VHgNBaaSiqA+GQnu9cLAY9Yw5Lz0ZWp7InglIc1WzZB8Kl00qvJAiG80qCnC7B76/M2Lu8ufJUwIH3QCazjk5nApdb7EOulVLpk0VQDT6lldoquUQMsLzWrUo0evO43JNkqJ5eLhQQ90Pwx86mFgP6T1yZdAMXtvDYUFh6WW2/PGrBHNtU24Gtr31kwx704u2+fWuxxASk1iJ3seUDzArQRlzzoHfuVW7UnBqnBoKuyeAUxg33CtfVqJrJ8PFQ0/LKdVd4khKHnO3eqZBPCt6/6uWS3zxEPNf0v+2CTipVNFx2kzy7DyIGwh108st44AlQTyrhpD3OL9dAHLaftM3VET0nUsaukNZXutbSeNTL/th9PiUBRQ/ixgPVX8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I5FH1nUQABjNU9/Pb4ysZPW5LxFP4I4up2qnN6Nya14UD/nfVJe/DyrdAh0z?=
 =?us-ascii?Q?vt1Y4KNyq1XtXYULx/urFXGbfbLgOs7ntkTnX4N3PAqVw+a3i++B4vXygiOm?=
 =?us-ascii?Q?aJ/j5stUDRgg9I7TtBqFHBaZyf7tEuJ9HYTiahM/vfTw+DIjdvBQrQArIOsE?=
 =?us-ascii?Q?ndwAO2g+X3LeYCULBEWFs6mmJGBA+dKrd5trTgUyWCGM1ePga9GpwrfvG+2o?=
 =?us-ascii?Q?AtUxizLWCNUd5UhzjiucoMYkOUpuIE6c0RyluWBAS9VTqtF/bGTWaNEG696U?=
 =?us-ascii?Q?Bj6Why/HlXxzOZlJxW+uKAPuw9LZux1fI7nvTQhVQlau/9Vc+3S4cFiC35ZF?=
 =?us-ascii?Q?V8bxeuQMYmfFLARd+yZQgZbSPnQXxA72IzsdA9HB608MNIU4nj5NEp2wVDA+?=
 =?us-ascii?Q?0/Qcrtt6kMpl+PaUi5+sFVJzJxS/9HGBdouw9Woyo8SL1TToqJEQyO13AYw+?=
 =?us-ascii?Q?yZhJDfWWE1l1ZM7ZbvHUUeX/HUImRjX+6MGm/eZ3CPzoA1fw3tA/E7XfdL9g?=
 =?us-ascii?Q?hPxw+ruislCo6UirATgQa9ZbJDsUd8wujFufDmKeRApnNFMRGETdCMEcOXln?=
 =?us-ascii?Q?aP3meeB1kr5WXz+DvqvnUyq6tt7jfj/EAHdDRDI0wNHzrDfTMOWxcK/cQujO?=
 =?us-ascii?Q?UmWecegjyc3jiTOsUtEtnwE3ZzbWAfxbvZp3JTkwVNBXOqx8Ogj4GYiKg8dW?=
 =?us-ascii?Q?VIMecL5jm9sZ7sZD1lpeBFdNAQtauWl0/s3od3tX2fKBJm8AsWIn2w6Hswd0?=
 =?us-ascii?Q?8eVNp2iQUsxqd9zntaj/yeekovPF8phW9UuaiIbcs7hsIQjo8pvuZ1X93Wex?=
 =?us-ascii?Q?/yOc52SssdD6gvMAxgNK+poUfKEmEvCU4Rq1VyRnp4VbN+0bvEIwjJ6gWSwr?=
 =?us-ascii?Q?uIbjjCCOBIyM/EhKSjGQ8CAqMRe/EZIfrhhLiIkxX15wKx6aNuUudQnSSH+k?=
 =?us-ascii?Q?IctirjUcuHKI2Bj+u0IKLf7r6MOzIntlCH+YveAOSUM0aRKCbwN1ViwHzlke?=
 =?us-ascii?Q?Hg8qIugBcGcf7aT+EO5geoRXublFHXPVhUfbwz/LAqelSUyJunw+DyYp5iHV?=
 =?us-ascii?Q?XoacOpYQCY1UqWe5CCSY3s2ZznFsOS2aMuPXY3lvcPCNjzggYJsQb1bpTObr?=
 =?us-ascii?Q?EmD3twqVw8Z46E6Kk5o8VDfEC1Ingb9LfZECG0dxHduAGHJ+732+cuDINUbQ?=
 =?us-ascii?Q?yNSiwdBVUg9X5PaKYer91l0ADQaDwdED+G2NUqyhUrTRawfJpMsbQHZOgVPp?=
 =?us-ascii?Q?MsN5Icvquf5XxlfPw3uKVY2FNxi8eXDtm27UUtvVmkXVnswSPLqz5442p6Yq?=
 =?us-ascii?Q?ZQMGhSIrRKfzsnXauq3tW7ywPWMBpmhGg8NjcKX2rVUXpp9HunbZ0SnsjH2P?=
 =?us-ascii?Q?iKXJHgyQ/ICatcHaOZmhK+MBQRsRQfowpW/sF9mYTqjpmlitz5mfph9g1Jpg?=
 =?us-ascii?Q?QlgJRU8og3NJzCRNaCapdkAToZfkuSbzSOoTSeIqurAtbKNNGNAPB6JJIWfy?=
 =?us-ascii?Q?No8TMTJP0hfDS8mEhDoNGVeeGSOCNjx5xmwtURy+3A2gYEwFiaGfzQeqGK6I?=
 =?us-ascii?Q?6g7q1WxOtHcDPG+n5x3oCo20aSqf5eWEfpffy9ta+Sj02cedNwijnO9PctZe?=
 =?us-ascii?Q?B+jkYrJ2vdTdHdICqcQ5nTevEJToTdi5S9uXmdhsV+8d1q2bgz5D/pQYa9rO?=
 =?us-ascii?Q?Hcr/HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zGhE9GoU+faYzeHp5uhOa8moabX8H+htcTvNsV5sXKUUYC44Z7tTXwWHBlq5k/5459+zBii2gFw99ZGHZfdPGjuBOdYJ27Si3MihdPmKovsKIGvU5+ijQ7bTfcvbud/qO6koJrxX4rRyewIUbrNGQYcASl5r5P6AgYeijzELiK9KiCvv2SB2NN0YnfEbssoKfBHCnOkL/pGa7k9sA7SZBo9VFCq/KUWEuHCemZDf/+B8WZCVpE3hgTK+UJeqLPrwEQbBAzpETv8ms6xUBH/yeqnLUH0G2ZTddlrq5iUL7GfPGA4BGpcvM/QuW/hBQ56BbN7RoAWVUfOVn4awWV6vR+q/6KbQX2bawkcZms3BY6PXoSpBvN3pr1yHF2xBCikHXUVaBrbOSGXK8j6mcK3aF58ha1um+B7j9pfRtANuw45Hu4eR65qhsks/XM8CXAErsjbIiQUWH6Mx6Hpg/dCPeMxHUD3qXm8zLfeGLMxUsEGm1CQcY5x5yp87kLaQureY8hN3wgdsl3FrtCzSekZquOmD6kCeVdxrjb353E0FinOwZBBfPYGyNMgnaLk1daOTkQ6Qlp5J9YNvNUMR2eeVFPrFfA3AmEZ6sYAZk/58Ndg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c327bc-701c-47aa-cb50-08dc403f44c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 13:46:06.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxoqJr4FLUBG96qwOEjvqbkA5UHs1dRNjtaejIhd8zdxlXYDzO53Rttw2d1FSkZDPaN9QX8vwVVy5+sZQ2ttgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403090112
X-Proofpoint-ORIG-GUID: _GKW3oFHpSDFV0iYG69zzYdbASyOz34W
X-Proofpoint-GUID: _GKW3oFHpSDFV0iYG69zzYdbASyOz34W

Refactor the function btrfs_free_stale_devices() to search for devices
with a single device and unmounted, freeing it.

This a preparation harden the reliance of tempfsid on a stray-free single
device, allowing temp fsid activation on a device.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c   |  2 +-
 fs/btrfs/volumes.c | 16 ++++++++++++----
 fs/btrfs/volumes.h |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4b73c3a2d7ab..d381abb275d1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1821,7 +1821,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
 	if (ret && fs_devices->total_devices == 1)
-		btrfs_free_stale_devices(device->devt, NULL);
+		btrfs_free_stale_devices(device->devt, NULL, false);
 
 	mutex_unlock(&uuid_mutex);
 	if (ret)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7821c152d956..60d848392cd0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -515,7 +515,8 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
  *		-EBUSY if @devt is a mounted device.
  *		-ENOENT if @devt does not match any device in the list.
  */
-int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device)
+int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device,
+			     bool free_stray_single)
 {
 	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
 	struct btrfs_device *device, *tmp_device;
@@ -529,6 +530,12 @@ int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device)
 	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
 
 		mutex_lock(&fs_devices->device_list_mutex);
+
+		if (free_stray_single && fs_devices->total_devices != 1) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			continue;
+		}
+
 		list_for_each_entry_safe(device, tmp_device,
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
@@ -1307,7 +1314,7 @@ int btrfs_forget_devices(dev_t devt)
 	int ret;
 
 	mutex_lock(&uuid_mutex);
-	ret = btrfs_free_stale_devices(devt, NULL);
+	ret = btrfs_free_stale_devices(devt, NULL, false);
 	mutex_unlock(&uuid_mutex);
 
 	return ret;
@@ -1416,7 +1423,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 			  path, MAJOR(bdev_handle->bdev->bd_dev),
 			  MINOR(bdev_handle->bdev->bd_dev));
 
-		btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
+		btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL,
+					 false);
 
 		device = NULL;
 		goto free_disk_super;
@@ -1424,7 +1432,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
-		btrfs_free_stale_devices(device->devt, device);
+		btrfs_free_stale_devices(device->devt, device, false);
 
 free_disk_super:
 	btrfs_release_disk_super(disk_super);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 44942b7b36b8..0ac25ccde96e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -681,7 +681,8 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 					   bool mount_arg_dev);
-int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device);
+int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device,
+			     bool free_stray_single);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
-- 
2.38.1


