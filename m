Return-Path: <linux-btrfs+bounces-3146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B887717C
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCDE1C20A9F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D564085B;
	Sat,  9 Mar 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q3SZznxs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R+jAB3iy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25116FF52
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991960; cv=fail; b=mYcWXM6IHfxllZTdlzg2SCDTcddRagDZF8i3d6q1gczsQbkxfE6j6Rl7w5g3QuwUqetRBRBs6rMu8Bf4nunvbIyEeUYCIU2MUhpOjOP/kZ9MAdajtTVl6fcNmD2swbrH0t0goJawhwSn6Gn1MZRDZTFh91f2SeYRWcfeVYRMMuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991960; c=relaxed/simple;
	bh=NKM4iJetmOS2edMdzWMxqDx6a7cFufJxQ/IXF7/ldpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B90eLmg0jhPOFSzEuB0ut+8dhQaC44/2e1GCNSkafBPzpkPh1Wa3X0LCE7nlYsaz2DgitmzHj+1BWBzxTiQox9jxzHH6mhzQssDNVYxffrwCz8DKoPz73CG2v8nCt+21Q9VTTlFuFAplnPJAlrwT1ZQuC0hU1l2zyYrhZN89D2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q3SZznxs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R+jAB3iy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 429Aaio1031378
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=pn0qMZFIxIVyPnMKADQ/6pUS1SP5ZFV9uLyunU91nM8=;
 b=Q3SZznxs8p0Ygvzhaj4J6Ih+iIcY4BffxnVcBi+YIoKgwdv2nYJ/DsPyOYvIX3LuU16H
 CgtROPujdrNx8GScedDbYfnAfdHeoaEP9zVM1GQnOKK7f62ClZlnjjoESFmTXz0N++Q6
 WDigNiOsA1HFUjAqKINvnA8IvfVL17hxmuMwLYjddoPUjc4wOWlyjZxiMdJUbkIew6i6
 3SZfMAaxu66JOPs413m/oCz/wmLeCgSpQr3vlmveFztrx+PNVwWNTwUj4I1muSaDFzpC
 /aDY8FO1p0f66drJG9R5cZzZPYVkW4SoeT0qDdVCW9ScDou/xT+NuOC3hOhQcuRAFWlA 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepcrk90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:45:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4299htb6038127
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:45:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7abfjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhmTljTQNO5QauBO6LGfs22p+0wYJlXwo9s/a0978jwOmNKSDLvOwIVx7D4xHbapVnzBcUr0K+wrI7+3oUc2M5AWGYx2MZ7EzSzTWq075RwsQaaVV3yqd2URW5ByH4Up7V67jyxDtkAOdBTOFu48cNKhdtVA09O6RGEfoT6oO1vz93NcGttZ+8sj7P0yPr5AnYDeJ4WDdjp2VabH2JHPCYERhOs01QFKMbwz+ODCRvb3RmRwcQYkxjUhdJEnuXfHf2EuGbLAj3wXnl80cFogy5zEPTcAxesgN8ZDxDGXvbiTk9FF4TWG7wdrrkw2MEMxRDEBTx5S/TqWNUf0h5DLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn0qMZFIxIVyPnMKADQ/6pUS1SP5ZFV9uLyunU91nM8=;
 b=f6a5qMFc79BQ6Se09AI0lCeg4q9JfBIh4iUyRIKQBrU7y4WmfbNpjwmjm+OA2auPaUq4RP1Ccya8qZACrgghTN+2/pS+VMYSBcrgGg+UFEZdIC1UeVtORrnBvFVAD0kzl5ZYR6aXWkZEtia5SD9FqDOeSmxTciLqO4/sjSCyaHLP4el2+EyV9/uiiGp6pa9mH0SCadxwnx4t/y2IRTvpqlVuZJnO8IrFHkbOMFQHxiGYa2tmDubF5lGiKwxsbjr1gkTXd8jPiQHZTN9E6fJLpjIzfBs9rOUzjKSyLzV/+2EfOCmk5FL/jc4w+11qFHU5G64HrxbG2OR1QImBzhN6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn0qMZFIxIVyPnMKADQ/6pUS1SP5ZFV9uLyunU91nM8=;
 b=R+jAB3iyDG/nZi7qgsT6qPuNuYEXbCn/yH+fxlvFjHr6q4m5voTBmDPPaNj1ROQY5GDnKfX1z1MrM2CZop6yG6ltJRS6mqoUUuKgUlwkoF0UlsCeuQkq7QRnPeLsxPtQL+ZqMVFizdpCXnZvB8ZWyHwNNZuwEU7P8ajxrwU6wRU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7509.namprd10.prod.outlook.com (2603:10b6:8:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 13:45:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 13:45:53 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/4] btrfs: declare btrfs_free_stale_devices non-static
Date: Sat,  9 Mar 2024 19:14:28 +0530
Message-ID: <a3e49aae49adb8ff39f0803dc296d6b25c7eab6c.1709991203.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709991203.git.anand.jain@oracle.com>
References: <cover.1709991203.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: fc24f297-7d2b-40d8-415e-08dc403f3d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dluk2tiCV9yuaJpR57h23ecgr2hOoCCsjJuvjvqxm1yPZUFpj48xMiHKKhi+xfk4p3a0WFSGvJfvxiJgmWt2YMu5kzH5SuebLwomEu2pbk6BYi/NouxferOHLOQMP8rgddjIYdHXcv6T698bSVGtHttD8UmMZpb0Jn9s9hmqpoAGAJUSLGM6L715aEtKMumNStU2SilHjjDVC/z7Q0M/zKvZYouReIPII0Wx7ZxMDwURKDnl5TGIqSvUcH4z95+9b/J2/GhSvsACFtOdWTNOlLQhZTi5jnB3RXbOahNeR+cEej7kHJcHvqvEyIcPfmBLkk/AulbypZ/NuzC6OzBORUG7qrCipssLCdL9e5tzuh2OoBIGN5ZNjU71sya55k4n62b/ILH6Jwu+9QE0aaz5/2sZVSDEK6WnbiygKFToHZntuaBiSTLMzyD8eHcF/iiIHBez61gIUwfnJqAEOsz4Xtgu/leFXccVKti6b6pJaBIJ9X5uOBlyEKW6q+rQ16b45rIrysPh7Vy7+4Sq9C508v/kTFwed319SiZ2fNP+lC4srElfS7Fd23WtyonGaNEjBjcqRNSy4rev4PzyZnJuOHDE9CrXEZnguajusa59hNFvYc6QFWvCC4PSt5NEkt4kMpjlgQiZf4/OTX2+EFWEJ6JTDY3C6OO/c3STSX379NQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4R/iqKyyv228r6CluTWTOclAmrqLEkkCvLY82TeyVCHEbZI0kz1N2CYHyXjJ?=
 =?us-ascii?Q?IsDrxPdJ9kT6iI1U3IhDcO4nCYhIIYpfqvzcP4scafcwyksF7Q9yxnLMb9zN?=
 =?us-ascii?Q?oA+WT9IlSAiIJvojuugLwMEZrFYxU5UHwrIGTPnhtY8WsleM0E6jwN+NnWQ5?=
 =?us-ascii?Q?pvtzctddCTqePDjgtsH24Ve5g16jgTRDtJwibei65fu8VxxuT7jLizBIe7v7?=
 =?us-ascii?Q?VZVJa8H9jxqzfOipbyGCzWiljOvM6Co3xYnK64zr1E33xmTgDQa25eRJARz+?=
 =?us-ascii?Q?9Pyhe+pggTkej3Ywy26EpPMNWYdsDJdp1Kvs/FINt6FkZLNEmx1eJkE91yh9?=
 =?us-ascii?Q?VCyYVyVPPAd4dck0+ZBtx4ObdTXmW48GAsxGptm8rHdX9aBX214vccd7DL//?=
 =?us-ascii?Q?z9XAr2aZpel26J+owPwMpCTnLaXRWYTHjITNtd30b0yh0gDNM37iilTuoGtK?=
 =?us-ascii?Q?HpxfKXD5mclwX2PaAi79PVAE6LYkM92qxdNtNeVC3AhqIZGPKZR1aY84WV5h?=
 =?us-ascii?Q?xvQDeZeOXQwmP6FwhQx0L4xveb1haasdJilfL8qfQDMmMkUPnFXMnncrKAsq?=
 =?us-ascii?Q?tnCtux/38Ij/1SAPQgejziVi12pR8iB+7AfDCKOuXDzMH8OHhqs7Gd2IajzM?=
 =?us-ascii?Q?qUCFdbCYhrnZW8GFhc3yfKmIKXS1ECXQTnVduIMX4mpUtEQB/P28fiPAg8p+?=
 =?us-ascii?Q?pn7r1fM0WRMasjMPrd7RZ+aF5O5I0ZAbaUV61h62wTLwj1V+RBZrAUX0vfgm?=
 =?us-ascii?Q?Gm9Y9JSXhTs0E5diy8aYQTMv/4XVpSg3Dr6jPXqT0A5qdAcBxYqEs3NuVG7R?=
 =?us-ascii?Q?enDVWPXJaYNCO0uWet05uF+VTwcs7jxkHrq2+YIuDCDadiijpvMukOY/cQB8?=
 =?us-ascii?Q?Zvinv87ic/KSvDhB7isqlaZAEE0kBVmq0sMXkPqLxMV1QzpqSe3zb4gicDxN?=
 =?us-ascii?Q?6hYsyfQeByukAjLaxgtGK6mRjaUiBAFT3qLgh42EowHdi9MB08lWgf+lfkBe?=
 =?us-ascii?Q?4mfV02WGkNz2XPb+ERFxdGCe/MHk0MJkSM8UioC+f97Nnkhk4HZSXMeM7MT+?=
 =?us-ascii?Q?eqz438Ic3ysPPFCdwiKULpb8+nmqLJVj5hR0cDSkgxjPvNJZnHJSiPH8mjMs?=
 =?us-ascii?Q?b02AYRVzietXEr/FwDzVMaw2xFs4ozFIi1CdjC9LQqxDf7p5qUeVvT6B9TLW?=
 =?us-ascii?Q?8YXHZGpS+k3UtRT9cCbcIRy3GTQhjnBJRz2goOJMs6EdrpbH6AFT53t3uADR?=
 =?us-ascii?Q?ueu2q+l9PhHsLQnCpqGkET7cWDJmWORVcY6Yt46or4yAMrupCJZKOv+JswP+?=
 =?us-ascii?Q?NJiBSCFe4tWab3NGU0nrZrYObzRNuefbLk5b2iOH6hTxkUb8op6GwiVTlLFf?=
 =?us-ascii?Q?At/9Wz7epUvHolao/yPvbB7gZUVwYg9cTOQuGu+wZU5Fc8RPb/1hB0jsnSyw?=
 =?us-ascii?Q?r0uMWJQ9OiuPN0TKOUzq/InRolPvbmDfs0ESZKB7PaI1DyNpaAy2GjU0mvYx?=
 =?us-ascii?Q?NENTha3iNiCTrm0LYX/IMJVSTzajbdfoClpMPF/oFHg2Bn5g5Heu67kE42VH?=
 =?us-ascii?Q?CAyIROeOULKph+vVDL8sn9YLJD0dNoOGV6ghgHJPPzrdr7/rH6ZiARVzINeC?=
 =?us-ascii?Q?QVfE+7cdBaL1PtFubjVflJh7uGzdE+nUzpi/dUKkXuHg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ko+bstazHt/+3lEAjbUNqpQolYhHkYWpnQHlHuSc3SGFQiqUhKsOgDvhFfqEZSP0RRviT3q3dYtftJCTLQuKk3nEYpz3Z7xVNkpD6bTjpQvMh/tUQgYYXKA0ci1QHTFSR0eMMVE9SraRhAIGAKBnUPZWmlRq0FoJ/IGuK6TJj3DJnEsrim/wi4N/cOCIKOgx5eBw3cRopsYTmqzWeNLYYC5bYkzzST2IInChzjGUlzpUegtetna4MNU2HKkD68eIawGSN0hEIw3bZK90TtCf0QJY+zsqMlIMPyJoAR1TOFVOb/ryv2DtcW5XIbrDnlHP9Sebl+h3LTq1mzwCRNx/qbtvTGyt3ef3ZrJIFm68zD+wTcTHbJBzPstUn7gSxdHtiJIC+z2tQfYBl7d+C3MCmkXtQvzO7ylwHd2i73trUXTMpRPGXi3PLc6WZA17LhF5LSpzy2ZKqcxSphUUeaG6QKb4SKU3af+4tBkJYzCnH0dWwyZh6dDjZGaieBRqk8clVNOvQqKg7Ovqll+LVx/fL0CuujDDe9E54GOSK3Yr7NRXR66IC/aVK5BYqnn+WkIXf50SJ5s6ALvGZbPrqiXSXoFwC0R29C5RVtsMT8VsUjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc24f297-7d2b-40d8-415e-08dc403f3d30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 13:45:53.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDZj9Vo3MnEAot8h4fIsQGY6FKQWJGTX+08yHX8gOzk4uoypdLXG6BvzJdC9VIyxa7LmfY8gHFZVRya3YzmoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090112
X-Proofpoint-ORIG-GUID: _nnph_7hwyaqCvP16fBdrVL3RLSco_qR
X-Proofpoint-GUID: _nnph_7hwyaqCvP16fBdrVL3RLSco_qR

When the open fails, to remove the stray device, we need
btrfs_free_stale_devices() function. Make it non-static.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/volumes.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2dc926ac9137..7821c152d956 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -515,7 +515,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
  *		-EBUSY if @devt is a mounted device.
  *		-ENOENT if @devt does not match any device in the list.
  */
-static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device)
+int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device)
 {
 	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
 	struct btrfs_device *device, *tmp_device;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index feba8d53526c..44942b7b36b8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -681,6 +681,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 					   bool mount_arg_dev);
+int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
-- 
2.38.1


