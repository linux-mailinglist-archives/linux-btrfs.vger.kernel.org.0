Return-Path: <linux-btrfs+bounces-3147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60487717D
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC491F216B9
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3E4085F;
	Sat,  9 Mar 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nebLi3i1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ksIr21CN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B44085D
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991967; cv=fail; b=sMiaP5TsoVutYAMQDqY7V6pU09QEAW07vmZs1gA4CFwphASS11H0vMRLiXFNcsRuLigk4y2EeWowXJyWaMx6SmfcBURAN+o7kG8JYbtZYLF47hyMaxLD+ZOWsDNIEo3kHwLPkTQX0o0X3VQ7JVDMt9r3T2iOIT9pu+Bx35Xpwx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991967; c=relaxed/simple;
	bh=hOc9UQUdyzxQoY0f2lnMyrL2IRWnK+T3UFgjVqUaZEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQWAwuF0EpERKM3XIvDqIzQaqMwpq/UcN4JlW1TDUNLe1yAgtwRlMAnoPdL20XBtITgifHg9qIeLudAMN7kk2YNjjvh3yIdo4NsZ67yJnkd0Ehi6a5rO0baXn5xFi7Omr8kQ8znrg1ay2IDYgh68pkklSebzbvY/KthhHNat3V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nebLi3i1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ksIr21CN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4299i5Mc012667
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=n4MBTCZQ3UDs8nHLWgIisUSQ93/YDmhtulVDn2iKQtM=;
 b=nebLi3i1T8kCA4wZCNJj3s97BZGAqMLCZ4Bz3mA+LZFRYb4wzLH0jJ516TVNVcCq0o7o
 GJPsLk3CsOhikELk1M0FRd/TLF7LXfDCoUMZAr8rJmvc/1OaG21DIU7thM7LJcrJygaR
 wlc85aVglTjdRdF91AbumGChlbdvwIRC12KnJlJSecocAAPy7quCg/QpOTHWdqDUOyie
 RxYb/uNemtEEv8GdJJWshDoEkY2W1CCrJIr+8SCkBhAJXXOTgT9mrNudzvY+Xbvlhjy4
 ySONhgvebBEhi+ojGdzsLIKLPrGMxPPxXjoUELXvdT9uoUuXzN8U+6SjQzuC1UBaXiiN BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbghv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 429ABYxr037391
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7abfm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyNvOc43JI6c89sFeOvShSciniEKzBR7t5Uy+MWN4hnVkNCMWOGWj9Ckmsywk4P1cUDfP1isiUINaYNrMI9IvyUB2pAPC6OZ0rkASUM9OMzezl38llgr/qXwdjPyC1ntYU9Ab7aKHbfXP9Ar3slAoWuFhLRWLLUieUMVxltHRdR5/QNGzEfgSkefqr5Q0yvhfeSe1CWWXwwe2926+pcmI7O2djRACP5dZ9K7wHbgY578WIhu6H6QBjqDL9ROt5nws/GcWFB1ICoaphNZTzMkaQWu3Y0/24fnJfV+DDKKveBCzdlUmBye3dBv6HFn6Xg2Ts//C4hBNSVUS6Wd8Y+geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4MBTCZQ3UDs8nHLWgIisUSQ93/YDmhtulVDn2iKQtM=;
 b=EqkjGZFueBZP/RDErTu3vQT69Fd3lFHLDYW14ScME3VvHN+FCyq3tUqKD5EO0rWDSGy8P7UEObn+aVo/QQupV6Fj0DwjFR5Tnp/+ZQotXU7vacYJdl/WZKOAU/CC5OdagumQZcnR5dYY+kT7b48R5G6m2LcWgzIk+CwR3pI7b3D1A3YG9pzVtmx841PajndtAiJF20x4QHvsWibdY096ZfNTrfJwUQnsSsMxJ18UsJcayN2+rblzRFGqT4TdGMflDdcDxzoXJX9jf7EIvpU0sd9HPehZQByTXZA4VhLXH20NuJqttmnezd+RfNEQDLwmpktHJqGlIw36WwAs0p04yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4MBTCZQ3UDs8nHLWgIisUSQ93/YDmhtulVDn2iKQtM=;
 b=ksIr21CNQhmxEZoHFHoj3GFZIMi6UQ69Q7tTx+r2WJD2NiqyTnvk326eaIcEnLcpDUb4AZLinxQWn+Jw84u90QT8YYJTvIrom1V64JV4isargA3kZRh0m2wKXvOkB1XFqPN/XUDmZO6a+IXBO/cjtxnLrUVLryCgtbqjgOUwA2k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7509.namprd10.prod.outlook.com (2603:10b6:8:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 13:46:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 13:46:00 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/4] btrfs: forget stray device on failed open
Date: Sat,  9 Mar 2024 19:14:29 +0530
Message-ID: <7abddd87a9b1be4b6da6173478f2ccbcd3117dba.1709991203.git.anand.jain@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: adc1e368-721b-4925-4082-08dc403f411b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LuzdNtqxcWY5fr8Y6xJv3Yr4BJUy+Gzlh3m68MxBYhBWNCE/IwHmu3Znt2AFTJWNQxYk135DtHc2ZWmaeaXCEcCYWh/oiDGZYpBffqfTqdQRtbbRmKuT6lxtd9rNJOlkUuIeq/IUIAC4DyTv1pU4CxejMN9UMZSwitEAizQBJ4fhdJmZhYbv5MOwzGvkkMsZnnJFoCNQVtcYvyWEt5kJFr5j+8wyiSETFIy5tbEmquHws4RG4AJnDYbT9fOH0qADY/Sq5CJSJzP0+hXzCPO3N1LAQVwPJEuD0ZUm83tT6zirXQPkf268ooO5nFf9vIxGMbxHNflyaD71eA+X7za9844J/2E7lSc5TbBjfIy92ADMBtunwUkKY3W2v425RzpCRtk/L/h0cl253484rnL3j3XSsS9oqKMCePq+SBDbfWwC0WLbl1gWeFnpsbgGDt7DmD7I+9upQO9yNavZS0JU1Rh/9NVSqyxltGFR8RcyWwaO4gj41E4oURiQCkjBNXpAxhF8OCCwgDwWPsnvwZgDjbuTdLgNQ2tE4f/+vpm1k5hWLlzti3G9HZROA1/YHbUb9dNDUwgtfW5wsmge2YaFEsUH8KiAYKv4EqX99V1udM6zXHLwOzsuu4ODqztTXpFPXHJ7mBvC6ARbA7jV3LGjymtcJgSJP3pb73rpL3W403I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wF+7XF5RAdexTvtrv4mOaQ0m+Kl4MXOB/9XSh8e574OrGNH6xyN+/LZMDGap?=
 =?us-ascii?Q?kYn8r89cMcjmWa3NX+ujpmBrDJTyfbSULqlkbff1aITckLf/3yx38dgq5Gke?=
 =?us-ascii?Q?X3s5MWcIl6g6HKuFupgt2GDKgRDqc3C0kJ9R5W9oqcbp7kxFVa6WxX/HWZ3P?=
 =?us-ascii?Q?/cw93cqerCC+fxnrJxH0zxII1Mn+089/4eRXS/Xt391og0cvoDlbe0Q8hmSS?=
 =?us-ascii?Q?Zz/eGkM1PSWJG9STa/2pRlu0JAZGl3LoZtfGh3FHOA/J4iPfynfpKCB2LepB?=
 =?us-ascii?Q?T05IIqr2RbBBWNNKm7rFSfUxJRpLmq4REDoTcFqI+V5MhV3NBdZm7v4A9qVl?=
 =?us-ascii?Q?CIqEkwvRMOXPa9DcrIfF/dle8vXMjeYMaAApUInVtF6FDrCvdp9/qPo2wRbN?=
 =?us-ascii?Q?MUQR7pWfxVvum2WrXFvFltUXkZ9Wmr8tD5toNjPixDhKdkDMtoBjsP/koQ81?=
 =?us-ascii?Q?4uuaQ08bZpvR8unIfo77I1E0ZETTNdbuSK2ItC44wRtYjUhpQo6vD26j7OGH?=
 =?us-ascii?Q?j8F7RQgGH+UOY0lKPfqcG6dYSDnEmNCk74JjP+KXzZP/MZiNb71GHzXT6CkF?=
 =?us-ascii?Q?EvXYVkdtjNW2ndrUaXKp0Nfxy20jyD2Z4Jmneb0wUN52/ZrkZVddkpg1sGaC?=
 =?us-ascii?Q?O1fs4e9i3FQsDZsOC1Iz4AYTvh86ikpjsL/rk7V7yrVwg2Z3vgyAYBbEfqUO?=
 =?us-ascii?Q?V1ydDXaNbejNVWPPbtgviz6627xuETbrCODsAuoI1iy6nvR4gLtGvR7uHMU7?=
 =?us-ascii?Q?Y7vaLOZI8i8mTaVNjmpkZw2mWqk9qztKU0LVlIj/ZwSQ16zY537TqXsv47OP?=
 =?us-ascii?Q?5inJv1zyGYQaMYuw48UOZ+AGbb22w39xQ+61lYNHW2T7jUIuMwpRBdeaInXM?=
 =?us-ascii?Q?uGBHQIMpNQvvNwdnP7GadOaGYowtkdcREFl9FrBCIDmgAK4+LuO4MatgVUrD?=
 =?us-ascii?Q?na2ZAaXrL4mJuI4xiBerDRCHKFywvwZh4pTVvS+GTYfTjkw2kVf047ma+vYr?=
 =?us-ascii?Q?crdeVXG0KVU9+xAkBo/Xra76CYTDhqLOSvZOZ923Lc3xQ0OuIDjumBsQDV31?=
 =?us-ascii?Q?LgKyZf5P1+BXbJHmBntO5PNpxNAt/Fn4nruw6K4OsGVVIvqCPMnjfBynGRBK?=
 =?us-ascii?Q?ROk6LACHmvngxWmww2mz4j70G6zRRkjtb0ZAieYu4YXGOdTgmY4yqB/c5uFH?=
 =?us-ascii?Q?eyIBqjJt90l+FXCyuN93LE3lFr0VNq06ngoP4i0oYreMh44D1GnoyTQjCpl/?=
 =?us-ascii?Q?I7jPrAug5trmqYbdkFELgal4sco+lMZgDQ0/lCjNQdYfRG26KebMT3LFUl5R?=
 =?us-ascii?Q?DiBheBbW5rHll+19keSfdYAGSpg8i/88GqWvSfA8EUjDQ77z0J/OOVnVGdhf?=
 =?us-ascii?Q?llj8PwdTfl0uDVT7IrJyflcIS1zTrHlRYowe/SPIKFoLdyBi4atfnntU2Rkj?=
 =?us-ascii?Q?sVXYsf78R7M6+qh5MfaN/h0jmQuvn8F2O0QY5gRlyHtUZJaLEOpmjdbLQbqh?=
 =?us-ascii?Q?PPZ9VewMdZgIQqIeaRSB3D2TQRlQ5a3gMUbvZVrBGOmPi8IT9+d5pb37Nn59?=
 =?us-ascii?Q?5rj+q24QOJ++JZJwAvSbhHCU2HNOkViVeeLJud+uY6GD4nQG4LX5L/6ErNis?=
 =?us-ascii?Q?Pxt2mkMbf3gk9kqFpKFWF84Gj5IrhnrfX98tdCa4CrW0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pekyHlyNse3xTOrpm/JP46rIgdLizXGppNHT6dZrhzv3MFyM8/Z02e306d6NDiS2gqtfnUYb/rRnl2KGMeUC+Y+bfPmPFv9kqbTv83HK21zpkP/NvX93868x+P0Dd88VUTJhNUTzWC3k7Byut5rWZ3F5hmPB1Tica0U5uUUdBagkykt0yXeVsRo5Dj4GzzgcjoaWQYIm2Wp8nm5GaYW8nMLeKjw7hId58NyA0bDKG//26etuo+wS+yejBMeie+oIWp1gEQm2kAYzQ1IOdBIGFiQozpV1z8wuWyu4ruBMC3c3fOAm2O76fnm/3isruCAcKZgQnmXLO8iO5N4cFFjzAtORhgy+CVwjm5s75cPTkMrB4vHQZKDf1WvSE6cjpUDmW2TO4hFMWaukhF0gy1N79U6sVfxc34VI4H31q/ZXxNMbqdDaaZVIWYatECPVKVG/sDLXudzEhP349eX+OCsacNkwuFe0oDDVt7W6dACZk/YOhYVQYI1ub7sQLRy7wvqxGysmKGwtk+9fkVA3l+O/6wyO1Mu0gYedoy6U/v/xLn/ICX5fnbo/q7wQllIhMQW84+lirvyfBFjL878v6x2556oZL2yAJshvvxpVU+7ffys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc1e368-721b-4925-4082-08dc403f411b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 13:45:59.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRjOY85cibJskYbE82gg9L0S4HIHipWct1wnzttsVzyGa+CtgfpxRyztz1OUriNuCpwIUpU6nS67hnH2xO4hQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090112
X-Proofpoint-GUID: fk8FjcU0jVJy3YInza1ZLBPkXRYh0HNp
X-Proofpoint-ORIG-GUID: fk8FjcU0jVJy3YInza1ZLBPkXRYh0HNp

If the physical device of a flakey dm device is tried mounting it fails
to open the device with handle, and leaves behind a stray single device
in the device list.

Remove it if the open fails and if it is a single device. As we don't
register a single device in the device list unless it is mounted.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 29fab56c8152..4b73c3a2d7ab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1820,6 +1820,9 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	fs_info->fs_devices = fs_devices;
 
 	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+	if (ret && fs_devices->total_devices == 1)
+		btrfs_free_stale_devices(device->devt, NULL);
+
 	mutex_unlock(&uuid_mutex);
 	if (ret)
 		return ret;
-- 
2.38.1


