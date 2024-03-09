Return-Path: <linux-btrfs+bounces-3141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D4F877038
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 11:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76911F2149A
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F038388;
	Sat,  9 Mar 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oWFjcyYP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jggOfjaI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00C23DB;
	Sat,  9 Mar 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709979096; cv=fail; b=Um0KLgOgSk0AbHeuUvngMhKRp/wDBmCU1wB8HLgzkuKGDzGeVCepWLrhWK8xIO5TIN5YUhroCRfXrmQoJMZzAtqJRQkpU+UnbPYxi6HH/yi92CEtbn+XssYtSYG5kwn27tGPs7VpO/GSmPY7zDOTJZfUS8l71A6TP1bERbGCM88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709979096; c=relaxed/simple;
	bh=VTh7aFh5lP2egBx3ga4ll8Es6ZAbuPe3StAcVxAmH2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9MUCANRN0R2S82j+2nvVNzRcOYz5mkYJPXgIZ/4TyM+7/bq23sEvFMU90tz0Xy7r0uPYaF4tiBFKgqvMEsgSIa8AsdYUfchQGOfdNCtsNr55KJZGr8KaYvHJ9jXC/lmB5+oFWaVDnBQXS3cHOxv0aUDcm23tzLbeQZMVBcIJIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oWFjcyYP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jggOfjaI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4299i37I012647;
	Sat, 9 Mar 2024 10:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xNl0F1Yu2pKiFNJ8QCurEFdMsNW9WPN/0T0Jo3RNW9A=;
 b=oWFjcyYPGTWQnEkRR40KnShML4ehvSXVK1DvfY+AXXEE6YK2b4EUo1nX0MBXRJAU3zog
 2MfLF63P+dMI7xpwTFkiWOwu6rUURlJ+TB08J3xev4ZhKZXGciDdesnay2gWtjQb8OLT
 7k2GSyBeUxTTIK3N+DZsGLMfkWirrAHIydiYPHQF3NK+s3l+nerfr9ti/tDSaCwNmMFm
 RlJxUOVNUlA6fFEA090Xoo8CcqEAUiMuMI35M22Miuz2984TnS+LG/9dWGpQSuAMfrWN
 Z+3Kfjb9566vI136M1YEhzEkQeNR5Qb3dy42OCsOKA2dBHeTT3VcdmmgvZ55swOdL+Nl yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbgdxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 10:11:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42963JeG020051;
	Sat, 9 Mar 2024 10:11:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre740jwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 10:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLMTQDOIi9occwViV6ZoAtlawZZKZIzPNbLtNZBuhYrQe0D6HzpARb1KH1c71Csj5gWKF9Upz0dBkJCrC/wBWy/4bzano8fky882XpabpzCfBYwP1OHsbw/KzP4E1YTOsxo8r9jvtGFR7rPyS8ugxu7abbzX7oAF0aIdPC5xcjvjaZN91sZXCH/yioObRX/ZFrxfrSbtB+FPnzVt3B259B0Vhme7ju59E1swCGJ6RwyJoIHc6QgYXvkZAuW6WiFmYoNZptbw3KtLzLZXkN04k+t3QUb1+aBKItQy+dQHIG7qYHD/FlL6R2+1tkinFMsBduGl3oKgNYb8In7nC/xdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNl0F1Yu2pKiFNJ8QCurEFdMsNW9WPN/0T0Jo3RNW9A=;
 b=MfSr0vy51wrT60MS/6VeCKlJ3V2lz3EZ8MdrvOPw8suwEBG28j+Ifw4wP98100IF9fY1Lc6qO1FkjTbPvGcnAGEsFs/wWOQptVi/lDJKZF2kxe0TyVP8FYg16NbpmvmGVRCa79pFFgQP8cVFDqHpqhSo6G6efeKU4n1tYpbqBCffpeR95OPO2FKQUh38zOEsPsLw3bfHjF6kOALUPBIVCO6lwe32vJCSr2pHaZ3eDih9T4f8gl/rkh3Mww86RPxuswoZN65cRXFppqG4FTrlDIOV52MM14qh3TJ6Zs84frWZhqnObuxGcj7/m7OB1NvMXxxo3/CHtecIGaO/T5aomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNl0F1Yu2pKiFNJ8QCurEFdMsNW9WPN/0T0Jo3RNW9A=;
 b=jggOfjaImjsp7H4DmCH8LvKBsDm/DrQvzDwhtBSm+hBzIO9y2rzzWR2BOqf+QKpH5BsP4dgVvnv8+KhmwDNXK+3m/yrZ9cxwOn/N7PIf80vnsPywoC693vUZBNRYVU2VKFvIIWUBePSO3vsN4+Gk+xNGFAjVqHXoL+hAXEWaopQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 10:11:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 10:11:29 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] generic: move btrfs clone device testcase to the generic group
Date: Sat,  9 Mar 2024 15:40:34 +0530
Message-ID: <dd10c332377f315cd17abc46e08f296b87aed31c.1709970025.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709970025.git.anand.jain@oracle.com>
References: <cover.1709970025.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: e00868fc-3026-4849-ce74-08dc402149cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AOqDR+JywcV70VchjLzibkzZ+frd6qapHH6Ze+V6KbE0Fh19aK3flcVgktKRideOWKyyvHmgZSX2DAYA6vFr1ttdl8aa3LwWbxs+hfh0PhDJUHRN1CsP2x+8vWZb2d3bWL6dKq+dlQ0rszOYj7XzIjlhadQKpz+Ynk9Gv7RQDBxdpsWOTx74QkutXscnYfr5ZQzmUXQ5H7Iq7X+V9nYFXdNtV7o0bUZR4QtkSV/XFkBEK+oZykPqdTwLWVD8JMI8jlzCANa3Pu/wkUInOdy6JH6uoZ9h10B9Gf5kPOTnLAbu+Np7ZlayJQCtYjsPrdwTS5AHzNdgUg9mXcjJc56Hv8ggVNQVvofVviDfy1Jr3RjBNO0D2oEEGaD5BU9Do3ISskiqBBFUxX9mpD1kJw7X6EzuuNLeCV2IaORFyM/hYinuPhkFuxo9W33dfHn9eIhyvRHvZZL5+fsth0D85ijE8Jxk6donhpQkvUHXguVXjcwld+IiuE/p/XtKEhseO+PHZk3sHLlRPzUB1xBorg5RnR/RBkzszYkU46gEO6OzCdFo91p5Ccod1w0/CmAkmFTxW/cOZfWyiVIxJfHtOq5IMbP/EEm/lOxkD01bVCqM1qqmK5j6CGLmn4sXZz79+N0N2gue50FPRiQJJTpA4+h9OM1grQzH2uLPhqktqwYVUdE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iKNUaAIgMf0BDHCBPThpGgxU32jNYeJqaZUIMF3Lxy/tEpfNJvuTTRX+64VX?=
 =?us-ascii?Q?wlShX5PgyzrhQXUOLD7Sy3jRJtU/DatFSNNh3wyShk6e2bNYJaHVEHvdtruj?=
 =?us-ascii?Q?8IbFfIEVZih2ONc55mMGU8U1xiou/jVAyyJi3RpXTZp/vxcud/O+k9spaGyg?=
 =?us-ascii?Q?9gqNFyTw52rbtYRGpOKQHrmHrOV8bETb8rJoR0NRquITEuqa4wslxzTwipnk?=
 =?us-ascii?Q?dO1ED23blzEeLzAZ5wiU6mZre6u4bLhkIIbMD6scp68UsOWpZw2dJIk5Bw89?=
 =?us-ascii?Q?XyeS6qYOTimNifRaE2VvU86lVe9gh/RIjpdcMoa3BTrC2R/f5gQdzQcE+RaP?=
 =?us-ascii?Q?ycTgdNOif8WS3PCQA1P71VrMk2Ty9zMMQaBUTvgdnxz5tnLqTesE7XZhAMJ1?=
 =?us-ascii?Q?/FcdWIwjIQi+c7tHKX2lqmxbR4Uaely0XC1LxsP4yNj9VNmjNFPcLDCDQ9GH?=
 =?us-ascii?Q?j3jNMXvHyswU2DOH4OvJmJd+TvUohA3KrOs+Mj4WEY6MC7Az7Sinofz+Fafd?=
 =?us-ascii?Q?xSCQZZajfao8m2oTlADgGahsPUO7IGHS99+Ps5XA7cG3vv7cEPGny3Zugp/C?=
 =?us-ascii?Q?cqGbnQkWdoSKN7+tdwhCu/hWTT+Rv0ITEHOhQL3ZbNWZYBdjHnyplnkAspOu?=
 =?us-ascii?Q?x/EY0DqfxTsVivRFiaw2tXubAI4Z/8ExunNvIORkCensrDk8n99czA//GDG+?=
 =?us-ascii?Q?IACH+2iDRKW6tYmSEqv3piXGawZDBWxR05TWR37lO6PicGAJtMTfPfvd09MP?=
 =?us-ascii?Q?fOYz8pb64IJLBvxpKxiq4g1ixmkNgtX0nxSGoCWJ2OHNOnDMdRRaK5O2Qi8c?=
 =?us-ascii?Q?varCxRgWroG9Y7IYD4PAODFo7ACDFXaYxCzWXzjVZEpsOXLRHVt434ySOaH2?=
 =?us-ascii?Q?hBjyw29iFltOBjVS+JGKMkh/43WiE4gkWCuBtieBD78NkXPrquxFcsMLXg1R?=
 =?us-ascii?Q?n3Q7TD51zS77+zW/93qZvXoCaxYK6/Hlyz82P1XK8UAU7s95oQf2xYhWDyYN?=
 =?us-ascii?Q?lVZbj4Y7960N2BUpV6Xb4c0fAJn5pZid/weERa/HoUehiKr33AyxQGpx3O45?=
 =?us-ascii?Q?7TkXB3PkTFtvDiPdxJsK7iOApjIAvkQD8wQs1SOo6xslyDYbitHV7eLuOgwq?=
 =?us-ascii?Q?OnpHC9U+oTn6HVtT8aXZ05A7OtwXwQItoFwkGu5xhXgKVzVEZxAaicGzVy/Y?=
 =?us-ascii?Q?2zKyS7R081E1SPVMYNo5EQzRUZZ2LcPwyz6hzEdobWnGxchEL5ZcGcFz4vAa?=
 =?us-ascii?Q?378Ne2YkH9DwCmvwRCppX6fusfsoZ5yKwR4DoQCso+HS0xLt6F2dmXrcR77d?=
 =?us-ascii?Q?rpWTkHNBfdpBrQrCwMjS5nae5RZRRspkZ/n4TQgGh2Gz8KGIXz2otNqBY7HK?=
 =?us-ascii?Q?S4KLAPkmL+ZGQAo4mC4JLf1EbB+W0v1++jBER8SizWfHuWGL0h4VYuBZYGsf?=
 =?us-ascii?Q?4QKUpF8c4buo0TLQ6IFFoMBz/7yIz0TX2nZs7nZ0TZO63SYFOJLiPJA42mAO?=
 =?us-ascii?Q?7zrZyM+CYkkUNh+/RGTV6l1vmtekONXiGu5wbxsyNAvZcC8mSdBUpSATiA/Y?=
 =?us-ascii?Q?HcHXZAgaG8gHf/jhaqehvUMeYHuttW6EdX3TW/W645iO54r0Nx1Cb002r45X?=
 =?us-ascii?Q?cylKK0MqR/Fn7ztcOy9x5r/RjTY9ACmzPKBYROlwW3dz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bmUqr0IhvzCpXua36nxOYU9UvbyFCGMnVsveMY2p3wVW6tLoKUQe52rM0SsC8VaPjLxnvGusVMrsY3tQQpfGiJMIJ2tr5iJnZCMuHpceBJmJekbhdZbQYEeiKV4YpYHlUN4kjaoM/FHhvWzz3ocYgn6FnoFDeHRK+KV7rh39KP3zWa2kXzQqS9EeUn45utddD717lWByM7saC6iOZs206W0IACicTSXqNNB7n98vOQ6SpTCWi5NBRSufEWnf2IRczkyqVSaB1lg4icSlJl/pZ2dS6LcXqvU3+BKBttKdH6UX1dzHnLk3yCzudd8oaFh2JZOeE+0eIfHlp6YFSgUzk17m6m1klTUwXZU0rL9ZIr/+wHQ9H/Rqx3F72R2zW4YGmeY/aY6kcYESlAxRru3wMfYjPQW1jsbrbG7BIWLAhSImZSO61iP1d00Sq+6/iUmj/RMnugxx/JHSWACTxU8t+hVGLexkOya8GYbzHu4nl/gwo/NEn/PdlshhK+yaTKLG4JbnkFJU2+SNvKBogZiJAy7zzbJV/04TISVpXrcegfttUKzvdmKMY0TrjRt9g8XJ8w998xvVRnLJdgQXHdmu1pZzzbnZCop3/mEh0WpPpJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00868fc-3026-4849-ce74-08dc402149cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 10:11:29.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vacDYS+aYM3chTZqG8iD0KYfmjl99rkfbF+7xqD2v8ZFt3UvwR4XR4yl7I5caYJ/DbsvobDBIOIVjk6CSsEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090081
X-Proofpoint-GUID: oRfsE6BWkqg3viYL8IxI-DTCuW1ZfZ1G
X-Proofpoint-ORIG-GUID: oRfsE6BWkqg3viYL8IxI-DTCuW1ZfZ1G

Given that ext4 also allows mounting of a cloned filesystem, the btrfs
test case btrfs/312, which assesses the functionality of cloned filesystem
support, can be refactored to be under the generic group.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/312       | 78 --------------------------------------
 tests/btrfs/312.out   | 19 ----------
 tests/generic/740     | 88 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/740.out |  4 ++
 4 files changed, 92 insertions(+), 97 deletions(-)
 delete mode 100755 tests/btrfs/312
 delete mode 100644 tests/btrfs/312.out
 create mode 100755 tests/generic/740
 create mode 100644 tests/generic/740.out

diff --git a/tests/btrfs/312 b/tests/btrfs/312
deleted file mode 100755
index eedcf11a2308..000000000000
--- a/tests/btrfs/312
+++ /dev/null
@@ -1,78 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2024 Oracle.  All Rights Reserved.
-#
-# FS QA Test 312
-#
-# On a clone a device check to see if tempfsid is activated.
-#
-. ./common/preamble
-_begin_fstest auto quick clone tempfsid
-
-_cleanup()
-{
-	cd /
-	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
-	rm -r -f $tmp.*
-	rm -r -f $mnt1
-}
-
-. ./common/filter.btrfs
-. ./common/reflink
-
-_supported_fs btrfs
-_require_scratch_dev_pool 2
-_scratch_dev_pool_get 2
-_require_btrfs_fs_feature temp_fsid
-
-mnt1=$TEST_DIR/$seq/mnt1
-mkdir -p $mnt1
-
-create_cloned_devices()
-{
-	local dev1=$1
-	local dev2=$2
-
-	echo -n Creating cloned device...
-	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
-
-	_mount $dev1 $SCRATCH_MNT
-
-	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
-								_filter_xfs_io
-	$UMOUNT_PROG $SCRATCH_MNT
-	# device dump of $dev1 to $dev2
-	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
-							_fail "dd failed: $?"
-	echo done
-}
-
-mount_cloned_device()
-{
-	echo ---- $FUNCNAME ----
-	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
-
-	echo Mounting original device
-	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
-	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
-								_filter_xfs_io
-	check_fsid ${SCRATCH_DEV_NAME[0]}
-
-	echo Mounting cloned device
-	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
-				_fail "mount failed, tempfsid didn't work"
-
-	echo cp reflink must fail
-	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
-						_filter_testdir_and_scratch
-
-	check_fsid ${SCRATCH_DEV_NAME[1]}
-}
-
-mount_cloned_device
-
-_scratch_dev_pool_put
-
-# success, all done
-status=0
-exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
deleted file mode 100644
index b7de6ce3cc6e..000000000000
--- a/tests/btrfs/312.out
+++ /dev/null
@@ -1,19 +0,0 @@
-QA output created by 312
----- mount_cloned_device ----
-Creating cloned device...wrote 9000/9000 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-done
-Mounting original device
-wrote 9000/9000 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-On disk fsid:		FSID
-Metadata uuid:		FSID
-Temp fsid:		FSID
-Tempfsid status:	0
-Mounting cloned device
-cp reflink must fail
-cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
-On disk fsid:		FSID
-Metadata uuid:		FSID
-Temp fsid:		TEMPFSID
-Tempfsid status:	1
diff --git a/tests/generic/740 b/tests/generic/740
new file mode 100755
index 000000000000..2b2bff96b8ec
--- /dev/null
+++ b/tests/generic/740
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 740
+#
+# Set up a filesystem, create a clone, mount both, and verify if the cp reflink
+# operation between these two mounts fails.
+#
+. ./common/preamble
+_begin_fstest auto quick clone volume tempfsid
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+
+	$UMOUNT_PROG $mnt2 &> /dev/null
+	rm -r -f $mnt2
+	_destroy_loop_device $loop_dev2 &> /dev/null
+	rm -r -f $loop_file2
+
+	$UMOUNT_PROG $mnt1 &> /dev/null
+	rm -r -f $mnt1
+	_destroy_loop_device $loop_dev1 &> /dev/null
+	rm -r -f $loop_file1
+
+}
+
+. ./common/filter
+. ./common/reflink
+
+# Modify as appropriate.
+_supported_fs btrfs ext4
+_require_cp_reflink
+_require_test
+_require_loop
+
+[[ $FSTYP == "btrfs" ]] && _require_btrfs_fs_feature temp_fsid
+
+clone_filesystem()
+{
+	local dev1=$1
+	local dev2=$2
+
+	_mkfs_dev $dev1
+
+	_mount $dev1 $mnt1
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
+	$UMOUNT_PROG $mnt1
+
+	# device dump of $dev1 to $dev2
+	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
+}
+
+mnt1=$TEST_DIR/$seq/mnt1
+rm -r -f $mnt1
+mkdir -p $mnt1
+
+mnt2=$TEST_DIR/$seq/mnt2
+rm -r -f $mnt2
+mkdir -p $mnt2
+
+loop_file1="$TEST_DIR/$seq/image1"
+rm -r -f $loop_file1
+truncate -s 300m "$loop_file1"
+loop_dev1=$(_create_loop_device "$loop_file1")
+
+loop_file2="$TEST_DIR/$seq/image2"
+rm -r -f $loop_file2
+truncate -s 300m "$loop_file2"
+loop_dev2=$(_create_loop_device "$loop_file2")
+
+clone_filesystem ${loop_dev1} ${loop_dev2}
+
+# Mounting original device
+_mount $loop_dev1 $mnt1
+$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
+
+# Mounting cloned device
+_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
+
+# cp reflink across two different filesystems must fail
+_cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/740.out b/tests/generic/740.out
new file mode 100644
index 000000000000..6ca8bb7e1b21
--- /dev/null
+++ b/tests/generic/740.out
@@ -0,0 +1,4 @@
+QA output created by 740
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+cp: failed to clone 'TEST_DIR/740/mnt2/bar' from 'TEST_DIR/740/mnt1/foo': Invalid cross-device link
-- 
2.39.3


