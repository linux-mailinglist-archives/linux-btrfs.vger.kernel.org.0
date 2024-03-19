Return-Path: <linux-btrfs+bounces-3412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 093C0880016
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637C2B2259A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B99651AB;
	Tue, 19 Mar 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RT6/7Zke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fib6z//j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619F54FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860307; cv=fail; b=oyuJLT0hb1AbiiZqfLF6axhm+axqOLDqH+CrgjvP0VcjwVu9QLRSfI93YT/2quwZ+0nXt8y5jVcZDKHML4KDILB/GQHvfC4vuG9h2VZ9fLKN1Ysy/sF+dvbFmhMUAKYkcF9KxN61YDQeBnZhAOHL2OdSTgpB2+6P4nsPDi/7tv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860307; c=relaxed/simple;
	bh=O0PfqLAiN8mhDEmlV+Cv9Axkg+ioowKe6X0l9THYhDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwU5abouFmSEmVe3DJS3G0/5pX1nYJ+X2koSA2au9CccArWXTAy8vGAmKQ4fBKGEykZGqCo4Yi9aCaJvovTv4d3moeNVt8wbCsoTUv0emXDopehW+STYRZbuo8yGIinCj192LK4XF1GnL/nTn1NRW7+bLkmKIZ2uD4TgDoeag/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RT6/7Zke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fib6z//j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHYnK010459
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=MpfA7dJ6B/OITJfrdltoSKFlc73U3EZFn3ltFSixZd8=;
 b=RT6/7ZkemnB6CHttOoxiDanlfGsiEXiA6Ws8MN19u3U4gEWDeG3R96U8kGygOGCV7rHu
 xagEDx8yMTpFVPCcDyeUV90s6AdAPbEHVM4uPXedXLNu4DoMpRaSQlPsUs/K2EcP6npQ
 w9BHW1dvg8OkZOjkLLQqBf6011h8rt+xI0YG286KgdGin4veiAU4QRNp7oYIbL9ky9IL
 uT3vMpn6uzYr9zawSQAY6uib4dUjXZX3hIfBQAEru6LLWhEwTGRTlPfx28hZaBrWzmSe
 RAsjC87txQsQuR+SD4oH62erfiBSVyjySsRWIwMfdZ3ZQvrGCTm6oeo8J8AcBz/NgVgG zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2115rds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDoDHS007468
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cp0x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApdWPUdD75FST2+IdI8hMUY/G8URVqj11YT3uqPH/R7jQ+O1ZKjxnNw5I+O5DZL7bHA7gHGi6ypU8pMv4ZqX8lF/QMSFz867MEq0cfTU6wvwmoVBx64UQZ+92GdXqukNVRpprf8x6dY/gnUVZiLhndbVJA8cDPLUIaA2jn4l5Fv2ZLOEqpXHpY7Tjki6jpzNfHtaBA7KCZqculu5cs8vP6+JWNG5ktlNBBzfpB5QD3McEf/Urdv5xnpHGvLShkgJu1BdhAv+0O+FKH1H3uwKjOFPMKEN/ymI4eoFwJp+Ey1abu6Rj7qTaSdPwjZMYL4usqxg+7X/bmtjHGXCeNmb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpfA7dJ6B/OITJfrdltoSKFlc73U3EZFn3ltFSixZd8=;
 b=WeWaa3toMRGRPUFUzPoGnuYpZ7DCDuQ2pHs//vMIf939l7G5Fem+/GyP45l0F3EQj4I/8P6KZhmZKa65NvZWMgCQ2KhOCtnzI4hLW221GoRVF/XIXp0SOU/l27FGKpQeStyP4INPpr2BSroSw08srfucBg29L4BMn7wO/fpAmxBskzbKssEuGtRveTL+DRuunPWfBne1+gfMyjK4B9V+UPt1GqFtBZst0UEDNjPkwgllSrDwn448CkX8He1bWywTUaO2ma0Fuu6i/yyU+8JUB24p3ugilPYQcTQByj7Y1aTZUI05l4mZGWylsNMaIcia5L+WVubC+1m81w8PM+fJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpfA7dJ6B/OITJfrdltoSKFlc73U3EZFn3ltFSixZd8=;
 b=Fib6z//jYT51Pe1kN15WfTyKv0gpnvN9ycKYlJXFCG8JxTPng+D4O9cwEsakvS6zY58kSzlIOpAc0wvKFd6j9TmFPvQUz91KDFqGDDBz4zeMLeM8CeKmsi0TCI++UyAjZFkocHY0wYdfoXICTBjAnGmLBkvG5qzx3MoqM2vpCsg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 19 Mar
 2024 14:58:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:04 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 18/29] btrfs: btrfs_relocate_block_group rename ret to ret2 and err ro ret
Date: Tue, 19 Mar 2024 20:25:26 +0530
Message-ID: <2af7ad0bfb1d016f4e5668d96cfc7d41c185cce7.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MtA5srfyfhSnXAH34j51CltK/tc++HV/fAMN7kluueZ/ZenpxoazkXYV/rETsFIr19qv9Ntziiit8CfMvadGQ8c+VaSxs1y8bZhsOKuyP4/l5dUycqvgjlYctjyUOr7mO8RajVV8euSCTypgkjknQgExM0rfYSECjBKiPqQ2T4X33hO/xkCBydkUTuDah1XZYodPi4MRfOKnlhFQhjAt5MvOomSWyig5M+gosmZ8kWuFlLr5Tkml0ccnAzDelhet3CqQVUO/gxD+ovQmsFWIybA0ECfgs0vvCVAc65hCb890qk7K8yUZfmTGT5MDJ/5fbpdHWaU675ejXJo/xkhicK9EGrRPixQdNoTjBDBAtgbo/dnd41QSw5reQIfktzyyT3bXRgLFlJ6Tde815rGlkDiq3tQzI96wTv0yHDHk4EJV67uhCeKlU2+f2UQEE+vYRc/6jyoXaWcm++EfJsvDNTahaunLcM3dt+7LkYbw7WohSlhBQWcsq+ISOp+yKdGva/h6Erg75U46ClWBl+DO6mOuzkRru59vsesiQkcFmWdN9gwgp3JHdMW0QDMGg/3ny3LUYzm36YWv9NfQ7eIjS80P3qLrN0ED9UHun+SFYsN6wQsBoKVQvI4CC25obEIQh7lODiqejOC1kSACocHbJg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V5EpzxLug+QkZXOIbYsz75DFTR6wTeNox/B1TUFNYGAVTcZQGiPilLlPB3bI?=
 =?us-ascii?Q?wCuUXBMWaHOCPcr58R258gPc/L8+LNlgDBoG6Rs4zKo1LijAa2LdKm6QF+P0?=
 =?us-ascii?Q?F93VLUMgAKQUIGQeMREUOgwlwXlkZxvF9XpNcSHFYjW4OhpXHPQyn4s+WQU0?=
 =?us-ascii?Q?RaOt2LfNilZbzwwCXCAukUoG78eQwKTlSIg6HHdJ/kn1ubv2M+vQgslTMtsk?=
 =?us-ascii?Q?ByvlQ5H8QJZZfpbUK5WSGZN8Yagwnk0qRv70d6q5q2dg5KuMJBqbHRjn0LY7?=
 =?us-ascii?Q?BsJngf6GK06sDMEQwXaMkUq3Ii9iWnLcr1oBO5hF0/SnNEJWaUwcxsPx9Dn7?=
 =?us-ascii?Q?9U/Uu6t9zeK8YeXI6Xne+NAzG/bDEVQd3M1qyQJoYZK0sw34AjEOGZ1K3c6r?=
 =?us-ascii?Q?KGU5iuqobafwCVkFdnFJOfdJCYEeThLHxBxBhZLB2BzJaKN0jo2CTOyJV8az?=
 =?us-ascii?Q?1a2VMvjxtuN9DZNzWQtRjsiQ6XUDMweMz2kN5kvF7xUoNz3qfH0lu8OQ4yV1?=
 =?us-ascii?Q?YpRxPxrodvLjKxGwRD2frWTcQGBpTMyoQHgshvxKso0QlZFSBUvBIr/jFlYT?=
 =?us-ascii?Q?PMCTCX+TWXulLx1hCTTNgtMK/6fADinGqfBYIld3nNUVIfoxQy2kaQ0RZdTS?=
 =?us-ascii?Q?00SjjtLglUtLFO6eOPOnnmzZvlY7aothE2hzkcYQIxiN1i1GTm7ve6MX6qBi?=
 =?us-ascii?Q?rgiBJwsA1PodX8oIQTG6CZ9ICtcYNSC1aYCBOqnItvFNO1knlgbl9XfEmBi1?=
 =?us-ascii?Q?Hsk5BmembgEL8SlWtaCmIgBVI6OmWM2j9DLL4+8WuAJ9DPiQ5YxR4f0Qe/yM?=
 =?us-ascii?Q?b5HE0Pvbn+S4ABjj/xtyIF2DEUYi0Hsv7guIUshpoQJuMHHbijVio5+/A3OQ?=
 =?us-ascii?Q?i3jkMewFB8v2bJWUkrk1Wkmw5oD1DeNP/MPdyodRvNKrZUX8+JgZoKITUr+J?=
 =?us-ascii?Q?TV3/GkNP2kNJIZfTziqgLN8TKeCb0ni1EMFnHi13YC/FBz4MCAxgQkYEDTA/?=
 =?us-ascii?Q?If0t05j5qBe+lqDaJpVhul7SEJ3t8r/0qoRVZbFpd0aHvsxq99HvVtt4To4w?=
 =?us-ascii?Q?8yPBpIGS/5HDgIlXlu1P5//qRrvp1WEU4XcvrKVyKt2hHL2uuIhy1P9kIWK1?=
 =?us-ascii?Q?rtwL62N0ohDhNs9e3LTUbIXFK93E67Z+reT6OipJAQSpFTzC0HRa3ECJ8jn2?=
 =?us-ascii?Q?1AMAzBBlxEr7lGrw0/MLUQBcCYu0yi+vv+HOfXP2LwV7gSnvNLCLaDf/TeJG?=
 =?us-ascii?Q?pcb6DLFXLr9C+ZpMTaV5zCtIIyrfn/TdogCuKONxETbPTICgWJo+N69cvZTN?=
 =?us-ascii?Q?/GayuL1881KnojKbRQiHBczMORhonLi5uEAcp4SSl6qTokn+eV2ClxwiPqlF?=
 =?us-ascii?Q?39vaGygYPI7WCuLbXG1VpPAUza8OHtqUPZpxMc8NO5zlVoD1pWKjWRK6///R?=
 =?us-ascii?Q?3U7TPrOI0pKKKpb562eQFW/7GhyZGDFA2ukENwsKYfTgl8XbNmlAQSS4jYxp?=
 =?us-ascii?Q?+t7V5wh8E84xnBQhwAq/JOGPxw2gdl0rr/7onLxmAGR+PJT6vFKJ9GzAgRpQ?=
 =?us-ascii?Q?mqxc5yBWL7wN8ZFg0Wg0uXrhW3GeEq6+5ogh/tPMsihE9y7dqOQNIq3t6w6l?=
 =?us-ascii?Q?y/6aws1zDfddC24YDRz2jnV/Wv7krICSD4hul1N+VDNN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	so86voWKlNrs6treco40jWxaEuuxVrFT6zVNWGp+gAQNMCg2UIC+1BLE4sSoFRmlbW3llmLZ1bH6FpQTqo/SfKy/1I10uPLORG1VsgWOGV2sHcBAyboHh5mSRolINd5/gCWJbxpS+rITqqfQsJ33HBSlsacuYgPwrLWu5j8ZKlhEXPNhWARkuKZPqVxlXY9EJzXpD3zDXbzqJ6KOY/gUxkEQS63HALcJ5UxePL7r1fPjUOrYqKl7uaPK0hzhlI7pLORAVe6or4M/eNSj8rkDlBxD5V9dg9mE7o2YKp7+3B2/2A8H5qCTP8+yLHqvTsYT72n/y+Nmp/wdctkJRoeYH2zG77tqWEejyKPbqshIjJfDopfPEnahzfVLde7uX7Ub+1Qu41JKUoiB9Q78lHcdgISZVcZosBAe7bIPOyQQ2IivsNPj/yy1nx9wAnyxeZn0tLAvPESO9YYyVyk8mC8vMafskbEERBnO1xGLhPgXNxPztTkfPi2wp9gOBnnEjQ4KvtiUVdk3nfXRZxP9ByaB3sy9+H6oDxq7aEYW1UifIs+nVNag3WqCNQGwoJcXmKxLK2S/UdH9io82a8RqrOJtJrCbXHWka9URqcbDNrRzte0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25bdd9f-e211-4421-7b46-08dc4824faf7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:04.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF3afwZLZPk/S324C84Cuo+DX1gg73ghtV7R5tmWSr1lhQa2APiUwnUsurPaIiI2ilA5Tmttvfg5tHDK1Fb9ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: JPdAcQ990TmUdaWFPnr3LUflruDP5VbR
X-Proofpoint-ORIG-GUID: JPdAcQ990TmUdaWFPnr3LUflruDP5VbR

Renaem the existing ret variable is renamed to ret2.
Since the variable err is the return variable of the function,
rename it to ret. 

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/relocation.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 16a3882a4a7c..030262943190 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4070,18 +4070,18 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	struct reloc_control *rc;
 	struct inode *inode;
 	struct btrfs_path *path;
-	int ret;
+	int ret2;
 	int rw = 0;
-	int err = 0;
+	int ret = 0;
 
 	/*
 	 * This only gets set if we had a half-deleted snapshot on mount.  We
 	 * cannot allow relocation to start while we're still trying to clean up
 	 * these pending deletions.
 	 */
-	ret = wait_on_bit(&fs_info->flags, BTRFS_FS_UNFINISHED_DROPS, TASK_INTERRUPTIBLE);
-	if (ret)
-		return ret;
+	ret2 = wait_on_bit(&fs_info->flags, BTRFS_FS_UNFINISHED_DROPS, TASK_INTERRUPTIBLE);
+	if (ret2)
+		return ret2;
 
 	/* We may have been woken up by close_ctree, so bail if we're closing. */
 	if (btrfs_fs_closing(fs_info))
@@ -4113,25 +4113,25 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		return -ENOMEM;
 	}
 
-	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	ret2 = reloc_chunk_start(fs_info);
+	if (ret2 < 0) {
+		ret = ret2;
 		goto out_put_bg;
 	}
 
 	rc->extent_root = extent_root;
 	rc->block_group = bg;
 
-	ret = btrfs_inc_block_group_ro(rc->block_group, true);
-	if (ret) {
-		err = ret;
+	ret2 = btrfs_inc_block_group_ro(rc->block_group, true);
+	if (ret2) {
+		ret = ret2;
 		goto out;
 	}
 	rw = 1;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -4139,18 +4139,18 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	btrfs_free_path(path);
 
 	if (!IS_ERR(inode))
-		ret = delete_block_group_cache(fs_info, rc->block_group, inode, 0);
+		ret2 = delete_block_group_cache(fs_info, rc->block_group, inode, 0);
 	else
-		ret = PTR_ERR(inode);
+		ret2 = PTR_ERR(inode);
 
-	if (ret && ret != -ENOENT) {
-		err = ret;
+	if (ret2 && ret2 != -ENOENT) {
+		ret = ret2;
 		goto out;
 	}
 
 	rc->data_inode = create_reloc_inode(fs_info, rc->block_group);
 	if (IS_ERR(rc->data_inode)) {
-		err = PTR_ERR(rc->data_inode);
+		ret = PTR_ERR(rc->data_inode);
 		rc->data_inode = NULL;
 		goto out;
 	}
@@ -4163,17 +4163,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 				 rc->block_group->start,
 				 rc->block_group->length);
 
-	ret = btrfs_zone_finish(rc->block_group);
-	WARN_ON(ret && ret != -EAGAIN);
+	ret2 = btrfs_zone_finish(rc->block_group);
+	WARN_ON(ret2 && ret2 != -EAGAIN);
 
 	while (1) {
 		enum reloc_stage finishes_stage;
 
 		mutex_lock(&fs_info->cleaner_mutex);
-		ret = relocate_block_group(rc);
+		ret2 = relocate_block_group(rc);
 		mutex_unlock(&fs_info->cleaner_mutex);
-		if (ret < 0)
-			err = ret;
+		if (ret2 < 0)
+			ret = ret2;
 
 		finishes_stage = rc->stage;
 		/*
@@ -4186,16 +4186,16 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		 * out of the loop if we hit an error.
 		 */
 		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
-			ret = btrfs_wait_ordered_range(rc->data_inode, 0,
+			ret2 = btrfs_wait_ordered_range(rc->data_inode, 0,
 						       (u64)-1);
-			if (ret)
-				err = ret;
+			if (ret2)
+				ret = ret2;
 			invalidate_mapping_pages(rc->data_inode->i_mapping,
 						 0, -1);
 			rc->stage = UPDATE_DATA_PTRS;
 		}
 
-		if (err < 0)
+		if (ret < 0)
 			goto out;
 
 		if (rc->extents_found == 0)
@@ -4209,14 +4209,14 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	WARN_ON(rc->block_group->reserved > 0);
 	WARN_ON(rc->block_group->used > 0);
 out:
-	if (err && rw)
+	if (ret && rw)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
 out_put_bg:
 	btrfs_put_block_group(bg);
 	reloc_chunk_end(fs_info);
 	free_reloc_control(rc);
-	return err;
+	return ret;
 }
 
 static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
-- 
2.38.1


