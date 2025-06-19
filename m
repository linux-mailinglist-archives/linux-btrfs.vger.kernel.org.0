Return-Path: <linux-btrfs+bounces-14780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F407AAE0275
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 12:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B121BC4C11
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8152222AB;
	Thu, 19 Jun 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IovDCGP4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013020.outbound.protection.outlook.com [40.107.44.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D421FF3E;
	Thu, 19 Jun 2025 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328122; cv=fail; b=uB4xNogJK7fOCbdWcCvr1lQUoWTaVwGJeDsh5CRqxvC0jI0ugOYhkVfMFP83s8iyt14HcjCo+f4YBZod+JqAhgvkP8lKwDuxR23939HfmTVPuBBo+sGUBNPEOCM7pqiXrh1oOAQjFRaIm6SCLAyGaOiWFWz6o+3l8Y2NTeN+FqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328122; c=relaxed/simple;
	bh=Q+Ttq3LXVPpJUCSFS//DxMHh8LZXYhOCMmrQ3PRtCSw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hFPYWN+00zdhsOFRdb9CCzisgk6b87gHHzjsVGuXr8c9c4axIhONeNFR7VP60ZWM3JWZaP9p6IfMexKlHeYrmwgNCV0cXPSQAjjznxBF5nkHhyYYwkUynyOIUd80jcjtmjutqGkqcyFrc+2L3x1hLfbqzQkgy2J05Fm+5Dn+0+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IovDCGP4; arc=fail smtp.client-ip=40.107.44.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP96Tf4/6aazdnRmhc7F5LkwZUAEs4O5JPZ6Qmz4EweM5lB19wI8oWyfxmv/jZXd/z5nxzAb3T3fLFq6/6ynl00FrneTIhA8Dijn3CNBR2KFgUTLd/b+90HBrEfBqhcQqEVStuLfqw9wQI39ISlGOEUOKLjjJ+YwBbN+CLqincsiT9OPs+IP9ggQfB0PsWlcYofnVO1df+XcwSz0KM7+EAkB4Q9tmfHK27XngD7n3IWmkOicywGFXcrRCYj4L68A2xuYBMGTtZyRYs17QVt6A9OgZdvv3D+GqZAQfOlZqU4fWuNVnUDJuwv0FiyMkZ0hKacIxW+Eqa9VcLbqsIQZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRfk3As/WLJTQ/N9M0eGEVH/YrouWGAk9P9JfL9rYM8=;
 b=kbVasUW0qXwUmjSdwVheq+MWPOoU1lHU919Hr5P/8B+HaIR1e7/wksCkADctJlfFvi656Ovf1N98fcD7fNzOZjggWWKRUjjZJ21GsVTKTrkXrvJqdxtvz/wI7fbNLZhIwMC6c2VhbIflJ4wJORsCf/ZRfvUOv7snhK13UgJJ8BBRrncSGQ9sFMJCzfK6+FPA5MjCBD58vHcxbBsx1sp6ufyzi27kMQMM8dzsAdNMW16iS0Hz65xWHRfFWWIOBVPq+qViCLr4ecO7X242IWwdC6o3bUY66LkNdKgR/aD68NAv0d20KwFKow8TMJQm2p+vTsbcRuDZ/BsodnU2RVB/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRfk3As/WLJTQ/N9M0eGEVH/YrouWGAk9P9JfL9rYM8=;
 b=IovDCGP4ENSY6btU8ckCKJOSqmkNETdPcBMccXfe4vym2kb1d4BTEI4NZ5/Xm8Ccm7TRVafaEy390BCBfKJiHeiFbGPs+P/SGuRdc3TemsJXZXc3kXmuiodPMokjRKTERnhFk6F8yPUZPXTcv5U771RV5F7O6TRB9HmwDt5E9WpFZuYrmRKEMICPk7zgD+GjJGm8Q1nnhTP7nD/M8KJdnI+xMd7LQor75PA4iCWnd2Dez9PgiytZ1j30asKW8yDiYpBlbMGXy6ZAyryr5YNPgPDaDtdC5LcKGaTKpSUmMr5AlVmL9o9gZtnPlXgjXdHlTpKaTEqm4DR9nC3XCu3JUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6905.apcprd06.prod.outlook.com (2603:1096:820:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 10:15:13 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 10:15:13 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] btrfs: increase usage of folio_next_index() helper
Date: Thu, 19 Jun 2025 18:15:01 +0800
Message-Id: <20250619101501.139837-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9f156d-e2f7-4848-94bc-08ddaf1a2dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+jLwGYH52WLIN6+lfb1LBCAe0HVPkh+p3UvZRMrMWipztAVWpxi6QBYREiV?=
 =?us-ascii?Q?/w19AvVSFqKm9z9Yl9OxGccyzvW1+yqXIyDHl3gQwPsVQvh9RP/sFvvBKA7h?=
 =?us-ascii?Q?eNxqPSYP+gpCeQ5cqMUnWj/NtqfGNVxPdqJKJxteee86GJpI6w+zEoKXpo+E?=
 =?us-ascii?Q?Yz+vTHMSrAUnA+Me+IqeJPm5qkkPqypD3FSF1BFdAAKAamKSDCo1G51/LYnl?=
 =?us-ascii?Q?es9OnkDXWMWRvq1Vs7RHh7+gdiTVd5NONusLVey25SU48VGfuiEXnV52xabX?=
 =?us-ascii?Q?TCnytbZlRbDQvM/zlRDvv/CvPP3/9O3JScPiU6pUdnb2ZwWcZ7jQ0g8O3m0I?=
 =?us-ascii?Q?2CopF2VcuD13qZDLxBzT7aqfmPW2l82slBpurqf/EAGvI+omfXwZCgcZh8rL?=
 =?us-ascii?Q?7DR/ja4008ENSEBGl+j9BmakyZxsnm3gC+kqMX7O38OQl6Jrjv3fxUhFTJ+R?=
 =?us-ascii?Q?ZOeTA2a+vGOsw+HVUZPpWs22H0wSgbBaCAjrNBPKWHzQEmY81fzVIFhHjIAH?=
 =?us-ascii?Q?/rgGiOthGzKsOnjhQj9drWDirvCjBxNDD3mwfNNu7ffdQ0JeWHlUItZ45ZPz?=
 =?us-ascii?Q?cY3x47CdFbQmBgcWs8HAhEoOeUdikzOMQ3seuAZ1CawEhMfYTN23/WpbHOv2?=
 =?us-ascii?Q?Ksq8Zj2kWYUCaPKaKsQRDnZZ/fOYS+1esdgs6/jP2ihgR+CH/7KWWyW7mizF?=
 =?us-ascii?Q?xpQhPhi5Wlm5WimmXDtWrzMuXfSVWS31S2YxyrJtz0eNPDUcnKaaY3nGqfbF?=
 =?us-ascii?Q?QjDVrhVh0CZfEndHsupVEY2FuwBfhDLCzyOZP+ErPHMMMdAe9PVkPlG9/dvk?=
 =?us-ascii?Q?h+AeP24oRQ4JSezFXqzBQrt2J/7uTK5m8jbfp3aUBXrzljo06Vw2lkOmZFrw?=
 =?us-ascii?Q?vi8/TMwpl2TF8G8kh2GcZgPt7mOe4xPQyvHftuILJEo2PjijCjMGhSEI1L68?=
 =?us-ascii?Q?icSk07bNthBNmE7eYYrs7hArAax6ynPr9OvXeK05QvrWLNCkbBo7nHKldfAy?=
 =?us-ascii?Q?FUqUo/IcuZlteCP/ABhWKfJeZJ9xGR8fgBXd+XBBtUxj4/qpEeKfI8wC+hDS?=
 =?us-ascii?Q?OMUpBLFfGnbgerDWT5YW4kVUKnwPGHX/0cd4AfuRfpJrEUUoegHhGvNmpj0e?=
 =?us-ascii?Q?PW2oc11a7AJg3Vl6PhsZXArc7/0V6nm+MPPyfwO3hfj9IYD/s0/SPVCu5ToJ?=
 =?us-ascii?Q?0gRFY2tFMHnWCF9gEP5dEiMRVL3axRHEcEgp6AcjJthfxEXr81r0skufLRJZ?=
 =?us-ascii?Q?5hXmM8DQATG+FGwSy+r5xl7pfy7t0zadOtmnhInKR2SNoTqvKEdmSdNJAIfM?=
 =?us-ascii?Q?q1/gDfNGabLQXq12gSS+E11Yue/BoUU9mzmwJH2tT96Y6ic9aA1WecDrjbrI?=
 =?us-ascii?Q?jRufC3IdfB7FiS5JllbwuFxLBHTUp6Icidc66OKF0Eap29bbJ2XJP2DFy3ay?=
 =?us-ascii?Q?GiTu+hfE9Ivq2ZuP+hQJGJdUaf5yVss8c1TS09H0gjReDln9ZtTA5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?32KZMFq7h00x7Fc0nY5rGFANW+mV+ga9dFYO/kWN2Lyg4rfs4n6bOuqgH9qo?=
 =?us-ascii?Q?l9+c9IRWmcKl1WXEl7QNN1tFdNndZmtjUA5xsrGfp+jc6TfyvJGC2Nujwa8n?=
 =?us-ascii?Q?HYgf3Wti2Fh9NpiQ05AY5MeeLMBAZisdsaS/uXrmivg+kjjkT7hF8fEVj2MH?=
 =?us-ascii?Q?/Fk0aKjPle3jJo+XiebVI2jkTOXdx6qYd0XxF54qKvxDREs6myclAi/Gv1VF?=
 =?us-ascii?Q?pDtVpXGEMmF7WlrU96OerMX9Q85MmkrEEdvrTouVc1Rd32sHrnaHYb0JM2C9?=
 =?us-ascii?Q?j7LO5vKmR0o90g0UbQugNsCkcnBT6gbUxytM4V1CyCbuCzQq7c7q7AZcBs0p?=
 =?us-ascii?Q?GnCULutgU6mfIj7ouOc9Gunti9vx+EGTaaNwuOh7jYahwgD0dWdp/4hmBWV7?=
 =?us-ascii?Q?qvdy9q05nxpu+Dnd/LSjmNiFzxecQgUFd4Pn90fk2rCC/dtMfMDfE/fSzpaM?=
 =?us-ascii?Q?s40YLO+iOBQxTVxjCdnCRC+sOxwmUlidvG45Y5OUIvyJIYRxsVs4dKsRZ/e8?=
 =?us-ascii?Q?V+PY+FqFhdKTZ8DKmfWRXakGl4HOL4srw9+MdQct+5ehP1T8Q1S4Yc5gEEmR?=
 =?us-ascii?Q?M0CF4fCjFDm7dglgS93wXblKwbDdUBA+hQf1t9JYuPyGl1vkHSHrOKlBLaXl?=
 =?us-ascii?Q?/bgzz06Az5zqzHOYVt8Yiw9EJmVHtoEcXinFCnPfIh3G9T3wktoSfOU+aJS8?=
 =?us-ascii?Q?lEjS9JKJTbgcJE5NYBllW+twGDKoZBy5stjEs0mkELhzv7GTup5Dc8/ihneg?=
 =?us-ascii?Q?i8mxxkbyCKSZbtw/MlErMUfViii797QQot9KBru4RmbzaOobyNdSFIJAkver?=
 =?us-ascii?Q?8LpLPgaV9R/xwmiZ73XQGzMEhphpaTOmcOs7LdavWPp6ef5bgZVPsG8/Mwfp?=
 =?us-ascii?Q?1IgEHDshsRGLSCERR+b+zpZqsMoSCqwmCyK9yjNVYmZigNNVmtqbl5wNt7Z3?=
 =?us-ascii?Q?A8npryNAokDdkcBGJP0TbyP5ocvebr6zWr9W8uAmLBpSfcLms9USRlrsYc1m?=
 =?us-ascii?Q?isBaT8AgXEpklBUc5RD1i2+tPyF28YrnG09pBb69hn2KZOjd4p2PA28L1uuI?=
 =?us-ascii?Q?A7m69E0FBa+g2OsZj0IekizFxmORpPFPxdwVtVCS5liIYSs9kA9WJ7qTS9FX?=
 =?us-ascii?Q?xtuwb8qI3Tixubh1PabWYJfWqKQnm6/ED4IttfNa4UzxmuPizPtyndOT8inK?=
 =?us-ascii?Q?W7SkkAV8sk1g1Z8MIodfShKKdfRGGw+F2kMXa4Mta5JHmQUeP5VWRvxgQiQp?=
 =?us-ascii?Q?v7bWzfnRovyU9UrhgcPYltkzwbSUPQOE7tFwRF4BsGqLTcFvIrJocA/Ddjhh?=
 =?us-ascii?Q?Owc+9PTYLTU27nfASY1x0KM0Ja784KoQnaMPb9M0E/rcIb5u71Bq1exshgQ/?=
 =?us-ascii?Q?r+soSg4Nik1I4q4yjBK4T5yLSkRhP8Pneysvon7wqK6VxoJfQ6upkt6IbsE7?=
 =?us-ascii?Q?FFMefCes43kZntyfk2clK78mecCxC00J8d6DThuwgUSXiW1IyjUXjphSe0HB?=
 =?us-ascii?Q?XbOyCgSxT5yLBJAWCwzyTNLYzKwfZVz+wZwy7E6OMC1MASZCDzmAq3vSvLUU?=
 =?us-ascii?Q?dcEY1W+GlvVoO5lpT/5jx5gdlpGFWErjSVfIA2Vx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9f156d-e2f7-4848-94bc-08ddaf1a2dd7
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 10:15:13.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M8OE/MDJ4ke4hv/srs0l3XP7Abcl/q0npsWpz70/+XBr9oKiNruHRBCdZmo4Ab05gxajUAYJOW5wsGUFV/eYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6905

Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
the existing helper folio_next_index().

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2902de88dd1b..e7d080ef4d32 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2195,7 +2195,7 @@ static bool check_range_has_page(struct inode *inode, u64 start, u64 end)
 		if (folio->index < start_index)
 			continue;
 		/* A large folio extends beyond the end. Not a target. */
-		if (folio->index + folio_nr_pages(folio) > end_index)
+		if (folio_next_index(folio) > end_index)
 			continue;
 		/* A folio doesn't cover the head/tail index. Found a target. */
 		ret = true;
-- 
2.34.1


