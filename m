Return-Path: <linux-btrfs+bounces-10427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E269F38C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D62618935DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305B77111;
	Mon, 16 Dec 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6gxGUZM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L1YpnDyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FC2054E9
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372872; cv=fail; b=ABI5olcXItdW2tjqYJu1pwdVLIMkDsdzrWgOmyCoDG26PENpoyhG/pO6D5QlCpqsSZS7om5JFgjtXIzSeGICpI9cyr6ssytR+WSxQ8mKctkvDx3fdhg8kD8LGlr97QogvS508QtIxrBU7n2Ucw7HKAMlpI+FLRI1WSOuvT8MkqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372872; c=relaxed/simple;
	bh=SgcbRuYdkD3XMMt/ZiWy9OrxJsIVEFQmTotppzu9+KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZ09aHWuHEbmqCY4U8mirT38wiPbxFGunp2GMH/GPhIQ0P4marJsGe0QNrexvVrOiuPfzW0JevsFcY8UAZ83NQhPyx4Z8aR9b6e/d0mle/aJQF4mCmwo9g7zhSRrpa3M5AyS6vTJcv0hqJxlK07TCOl+bbJv6SIVmOIaZ6OUXAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6gxGUZM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L1YpnDyQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQiEZ017639;
	Mon, 16 Dec 2024 18:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MILC98Mrjy2KCnitCb/x8NaI95pCfbn4EPNY3As8Lew=; b=
	Z6gxGUZMuZdzwdygt6QnXf5EoH3pHJVCHHm37Sc7m7UxTsPDnXncbav9xu2s1I07
	DDR2ctbD/TwblWtJSVVE8650ZBIzu2fmT/V1zXduTNVLfs6aMJWbjehh+FAO1xzQ
	UkGWJqhMR0XbWxOkQFdEuLJfp5HMLPOHiOW8tnd1KsBcSujBNMuZjb7RPABtNfZt
	9zhtowVjwphYxFTHlTLpDi9z7BBOOC8Zos9dNBPg/CCFYcpo7tP+PgYeao9SPKSE
	xQmnm/oSDTKXEZcNn1eVo8BVWSPiToVChj/onntYmCUKmy2XzHydbERk3ZyCfttz
	O09j/uAkgQWN2q4TItQu2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22ckxts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHLoPi035378;
	Mon, 16 Dec 2024 18:14:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7dgck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLX60jYchc+IzDo4RQZu68wbFIcE75olqfIDpgWHtjS+Dc+dB4r7eNU5XcJUF+hW0fivDcqJcHtGkFjafEZq/+JWDLQGtBdsjkALuz4G8a15X2prv32FGDlpD5HoOqcqi+vanJDFhy0AL3o1z0WhTKV/eMNhzzxWM8cTR2PFRSzMlvLAcaPj/KqQlEqK9awtTaHs9dDFvANJOMrtLrr4yuevY4aguJeD/gtp0eg/tlpNlmr4ErvU4mVOSSdW1bkGY9ciUguUD+V20dEJOJezQm09ls9sf8SiUy100TpGP+2GFli87FY99Sey3qwMpxIVT7BN53xqtWW33kSRFWquUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MILC98Mrjy2KCnitCb/x8NaI95pCfbn4EPNY3As8Lew=;
 b=QB3y8a4xqeWkmxveeCWIAS/V2hYDk3Q2+XFOLjt4YbSUfInImAdHMAQufpIVJSTBLcrsyTQU4ab0zH7qXsk1RRYxi+FVKWz1Rotv2ezu5M+YgGsMMitJFhEDJzEvQgfGF0DjgyQz5Z6sIUUrQfR0H4NdWYmzXO/lR4/mALhz+UzoITkjzfpXyLyj7IY4y2FRMi8NYPDPCGtevlMxO4LKF4COMUYWdHs5clCtxTzKj6myTd5mEiGdWAOvlPeKqyIL8Jh82FJTTb7OeR77GEXAY4qiRvyQk95gDXcmu4VGHOyj8/gt6hInXF3Atw0CHp++58kB7mKPNJ3//0828MXDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MILC98Mrjy2KCnitCb/x8NaI95pCfbn4EPNY3As8Lew=;
 b=L1YpnDyQs7d4uO8sdxknrugbiXGUBqAokdAZXKygljnKBlIqpvrr/kR33ZbmrbuUk6Lv+UIT6o/9zMzIp5FxcYSqVWrvhxJudxjosYsLrzhJCmNh/gCHT2wa3OM5NpQgLsRWH6Nut/1PznW4zIjoh1BLOMxC70X7TZcO1HgAX7k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 16 Dec
 2024 18:14:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:14:18 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 5/9] btrfs: introduce RAID1 round-robin read balancing
Date: Tue, 17 Dec 2024 02:13:13 +0800
Message-ID: <90934f391bc1c9772f9e3a7902cf9d04f3b0d14a.1734370092.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: c76f4be5-1471-46db-36b1-08dd1dfd74dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kQivxDvJQDJXBvTxWrxMuRMTZ3TbXEsWmIVnhgmYGhKbhbsXMYB0SkDapAvl?=
 =?us-ascii?Q?JVrS1KvT0zxQ/tZM4lhlX1IZc5lqIgxuO6UXR8i/QG8rW0lVECebuB15jMeq?=
 =?us-ascii?Q?vNTI9A/b+svSNBigvr3klC4JyCNs+nefNi+iX5IAb83pWy9++rBxG5UMrwYa?=
 =?us-ascii?Q?7r5vpSgDxPQi02X/e5H04ZBay7H9Z+88PqLscphHPY9u74n+hZFtSZ7qFPg7?=
 =?us-ascii?Q?ov2FvYs5NUcK6IYjM91vFaz/hX8N000eALiF0speE5Nua2+MqX0Bmm1bdcZG?=
 =?us-ascii?Q?qrr3BIZjij6t24TK4kHsmgtsm0X8iOtYmE5tluJ+UDNrGQJlqyz7IAORcCjt?=
 =?us-ascii?Q?AIhs4kziZq9q8ui30u9Di8FC+X/sbxTrZlf60ZKoEsjhd/yFvGCWCsEiDlAE?=
 =?us-ascii?Q?BuSR3iJ9NYHItdmbU/USjdQd24lezxrT4jyAawiBRqpt+LL0VJFGgFybPdgF?=
 =?us-ascii?Q?82pStqE1unppbZFcn4lxbcB69/TbC39S4E1/Vd5mr0g2UU0KGTeZOucHgHr6?=
 =?us-ascii?Q?NkaDoI3luYfCDbS/q7nHVvBXeoBen4MzEtiqX3Ufn2n+jQZc0DY5cdPaQ2GH?=
 =?us-ascii?Q?b+NmM+yeCyic941KdYBDVDdaYUXtkpNodTgpO+Py+ipKJTc6XJec4U9oDvwK?=
 =?us-ascii?Q?JB1GgKQtjkVIfFItj4KKJpg6hVWJbwTxxuA+a1oNc3Jnk1/EX3laSHIwpRVb?=
 =?us-ascii?Q?XcyhdSlMQD6TFMdVXvMWwZGOvnuNGRVM+nIn2uJdVbiQlaeHBwSviZ6ICtd3?=
 =?us-ascii?Q?3tJ4nVlPJ4HGGGZqcvOHUL7pkVBwUfalOzpdC0Zs8TWRJMCNZ92V/KsJLO2L?=
 =?us-ascii?Q?cpkWDpuEcJdWL/vi6vXmDbspDqBSULlATCb6bMiTL+9Aq+pPoHy+xNWMKPHx?=
 =?us-ascii?Q?VemcRPbpV9xDuMvJADgHQtehiuvdB5gxRP6C2F0tJOI9by5tH7N1lLDf1pEc?=
 =?us-ascii?Q?yaU5mKrHFBZCNKAbS2pEcs6oHdVNPj1gWm+dWlgAHowptKsJxOY0l2U9laf8?=
 =?us-ascii?Q?jhrkbNdTR5MTlB5yMd9B1DQGwhdrgTSwgtOP3FCa5RaLXOU6JMON+Q1eYYUO?=
 =?us-ascii?Q?Z2tQEPVijy7tnkYQjk1iGOkafXMRPZhUePztR1FRl6o/oebkiUTNU6D7ybAm?=
 =?us-ascii?Q?txg8tnMAEkZCnBPMH+p0UDOHxwoH/YWfvZamMOjd7F3Fc1g7Jk9dvni9l/zy?=
 =?us-ascii?Q?Qqe3HSoM1YERhsnCe5+msRUobaBXSwK6zrKgZKF3p05eBbW33516yhSTCcoa?=
 =?us-ascii?Q?HFmYHkkVCReb8wpAk5y3q8L6C2e+vLJxGJcpjOeTm13h6jDkkxEKk9iMNGqN?=
 =?us-ascii?Q?hutJXKFOg8yoWEop1YAzmvfrkGANVE21DZvb5oHTC4mTA0Scqpy4UxnU5YUV?=
 =?us-ascii?Q?t56Kj1oPSZOeENhDkP7xirlgMqcx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U6dvWVxZb+TEkvGmlXvUCoA1JsSJTRQFtAmAlMCdINdkQMLhgcKOeYf8VPo8?=
 =?us-ascii?Q?lxjuxQkL8URuNJTYZOnRpFvwCmPCEotb/W4AR0PvUiSIJ6cOoJ4G3JWgaBPE?=
 =?us-ascii?Q?os63OX1dOc9RZ7VtWCL9FIrkj1985o0GYfb1aWAkZJKHTDxavAqelDQDEWF8?=
 =?us-ascii?Q?URGxGdujai75i6HFn0K34ffPZq5G5cG92uB2P6s/fqwJFR1GSNXSdoJNiT1N?=
 =?us-ascii?Q?3eKjgo39SExGu184ipoGCzJb7PRgz+Kl1LgXSUca+9RGYKjODn6rKUMYU/UP?=
 =?us-ascii?Q?sTMBt7aGnzOi0Y3bkIn/xftjA9m0YnVFX5S3mbdWBHevQh70koFpYBh3/+gq?=
 =?us-ascii?Q?hZpqcRAgwGAdIpbNIVRDgp8dozZ0+qULkF1f/kCQLDhbg+pvMRV9i3Ssh9VK?=
 =?us-ascii?Q?rOWKlnWG3tPXKgQcrTe4oUVHxV9hVzP6NCzWBAOKZQL2lH6V+Wdv+PxXxla2?=
 =?us-ascii?Q?jkePmV0En36NIGUNs1Xl8elvBwHcw0O55KkSnP9AQepnmxVViAlZ8QiIa6kC?=
 =?us-ascii?Q?zQS+yuBYRg6U91H4Ni+EsaFCgtDi8edzMkvr5feq9XTE7V6DO/Zh/4wPp8yE?=
 =?us-ascii?Q?8hAdEA5+WGPa3L2Xy21PA/rUAMmYMYngU9YfV5sHO35HCDC1N60krhqjETNU?=
 =?us-ascii?Q?XRI2UQvtHBD2kck8SeVDJc/47zDtNrqmWe2V3AQXACgd66u8X4E4cjw3DVUs?=
 =?us-ascii?Q?Mo6iBAYfIb9OyPi68dIEtBHVXmPuzUuYV6O/DvgmywkQX4WFEEYk4RwH9rcp?=
 =?us-ascii?Q?RefJx13O/ljm0qrn2GPMERqarSz/LnFc8DIxrvFXUvoHR763Y1M3GZF+G2Av?=
 =?us-ascii?Q?CAvGESIKyUz6pgCA/g9R0wuVjbX/HU/wz3sXARwcVa+Pmpz6J+luHt9KYqr0?=
 =?us-ascii?Q?SQ5nMbkJC9EMEgEfbFC0PZPRjF2GlLXLV0XMYKF/yzTU1hCSikYaLh2M7tEI?=
 =?us-ascii?Q?iXrT4H3/egGqRy1sFvwMoo1t5CKwHa4rdSYY/9TwvvldQCGdaidoLmuKrn9v?=
 =?us-ascii?Q?ZsTkDkehpY7L2eCnXWGd5bzo2/NzLWbyGylRYsAGtgh6cj99LhQPgpgBwp3B?=
 =?us-ascii?Q?1x8N70sQcVzitAHNZJTKhUKlyio2wRKA8mmQyt+fKBthul+Af5O2OSw9qsYJ?=
 =?us-ascii?Q?M/ALEvv2V2rLgExOXihAg7Ok/IN+t+2OyfNthJRwdtsp74YpCn70Fp3QxnhF?=
 =?us-ascii?Q?VMaEBcusKJSV+JBTxf0dZnDFBWQz6C6NRs0D4IvVwtoL2wHluLmO5cZa391H?=
 =?us-ascii?Q?7Bzyja8nSS/74laXG17+kUHGfkjNbjJwJMWGqR+jgwXxkag7EI3S0GrZu8I3?=
 =?us-ascii?Q?ae6jryyo9wC7iH0Ku9fkaZlthUpc4QY18CMK1wAOC991PzeB1Yj3Hytqp78z?=
 =?us-ascii?Q?TvR0bHzf44VtmEqrnleBYpe7YAFdLaRFzgR2oZIWboxb9xrGPDW7SkGBpR/n?=
 =?us-ascii?Q?oFBCfVgGBsa3mpyF+xRp2qr5P9pWHEkN9BLp2/bqJHxGA3bxOIzleiHM+CFx?=
 =?us-ascii?Q?QskUODGeoUkhajEjmHrmmCrjohIpCXyoploiyu2R+8ACDB3/Bvmbf2OO+XCl?=
 =?us-ascii?Q?9m1xtVHJYQ1GUaeXWvZg/Mu79AmjW7arMjmLBOTa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XllfljLc8VKg+BSatcZydtkbiZCBXi4nUyuLYkvJeWLmAAPX9m453kxcRgNKcPWG7cOt5Uwcx8/6Y52D75yYzqCKyEgrx/UCupxUp/zR8zETF2RBbCOea0e2WZKrQX++GsqtO9SoH9fso5z5sBeOs61GJqPtWT8YYPHqsrzrFjq5GavPQTMQiLk1RnFKWy5STZCosrv5P3ra/8KLUh0tGYckudjrMjxxVlshEjnogFZ3jI98RpI2QTTFm0mUq5DB0y02UBmKllEWl7HTs8D0Zh3j1y//dREK0rVTRETCzQzX+lI7yl3RvZ97LWoQGgITjo9SDoYSfXHCnpSqtwiZFhvw/pypor0XMPkoKrrbcy6/vOzg/LYLoSpuZF3oOMcwgteE+E9ebsFxL6xcf9NIGI1o7BpdMXjmDfWPZBzFRCqJO29LAF6Maobit2MHJlm/AaXx/GLTzS0Ia8t3VaygyD5n8UPaUxO3yVKAmRL16lmBfVSIZqDzl5oSLKYSDG58NlQXjuI4C2DSkOiC0KfDkchO4Qe8CHyklAs0thQSg2u20Zj5BdB2tLjOVkcEThvnvHtACfIJFJ/6UTkQvKHRwnEmtyBeYwlVBsibw2O0eGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76f4be5-1471-46db-36b1-08dd1dfd74dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:14:18.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvNbDuVI5rBiDMIt5VTCJrXMjA3YL+0rhMQAl8PbyIThuc8BOUyF5Lz9//vhSiOn++4DN84PbZoS6u3CfywHFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160152
X-Proofpoint-GUID: x9IVo_lq78uiWlzBcZyR7Z1qXOzpiRhe
X-Proofpoint-ORIG-GUID: x9IVo_lq78uiWlzBcZyR7Z1qXOzpiRhe

This feature balances I/O across the striped devices when reading from
RAID1 blocks.

   echo round-robin[:min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

The min_contiguous_read parameter defines the minimum read size before
switching to the next mirrored device. This setting is optional, with a
default value of 256 KiB.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 44 +++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h | 11 +++++++
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9c7bedf974d2..b0e1fb787ce6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1305,7 +1305,12 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+static const char *btrfs_read_policy_name[] = {
+	"pid",
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	"round-robin",
+#endif
+};
 
 static int btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
@@ -1359,6 +1364,12 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 
 		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+		if (i == BTRFS_READ_POLICY_RR)
+			ret += sysfs_emit_at(buf, ret, ":%d",
+					     fs_devices->rr_min_contiguous_read);
+#endif
+
 		if (i == policy)
 			ret += sysfs_emit_at(buf, ret, "]");
 	}
@@ -1380,6 +1391,37 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 	if (index == -EINVAL)
 		return -EINVAL;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (index == BTRFS_READ_POLICY_RR) {
+		if (value != -1) {
+			u32 sectorsize = fs_devices->fs_info->sectorsize;
+
+			if (!IS_ALIGNED(value, sectorsize)) {
+				u64 temp_value = round_up(value, sectorsize);
+
+				btrfs_warn(fs_devices->fs_info,
+"read_policy: min contiguous read %lld should be multiples of the sectorsize %u, rounded to %llu",
+					  value, sectorsize, temp_value);
+				value = temp_value;
+			}
+		} else {
+			value = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
+		}
+
+		if (index != READ_ONCE(fs_devices->read_policy) ||
+		    value != READ_ONCE(fs_devices->rr_min_contiguous_read)) {
+			WRITE_ONCE(fs_devices->read_policy, index);
+			WRITE_ONCE(fs_devices->rr_min_contiguous_read, value);
+			atomic_set(&fs_devices->total_reads, 0);
+
+			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%lld'",
+				   btrfs_read_policy_name[index], value);
+
+		}
+
+		return len;
+	}
+#endif
 	if (index != READ_ONCE(fs_devices->read_policy)) {
 		WRITE_ONCE(fs_devices->read_policy, index);
 		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fe5ceea2ba0b..77c3b66d56a0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1328,6 +1328,9 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
+#endif
 
 	return 0;
 }
@@ -5959,6 +5962,71 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	return len;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+struct stripe_mirror {
+	u64 devid;
+	int num;
+};
+
+static int btrfs_cmp_devid(const void *a, const void *b)
+{
+	const struct stripe_mirror *s1 = (struct stripe_mirror *)a;
+	const struct stripe_mirror *s2 = (struct stripe_mirror *)b;
+
+	if (s1->devid < s2->devid)
+		return -1;
+	if (s1->devid > s2->devid)
+		return 1;
+	return 0;
+}
+
+/*
+ * btrfs_read_rr.
+ *
+ * Select a stripe for reading using a round-robin algorithm:
+ *
+ *  1. Compute the read cycle as the total sectors read divided by the minimum
+ *  sectors per device.
+ *  2. Determine the stripe number for the current read by taking the modulus
+ *  of the read cycle with the total number of stripes:
+ *
+ *      stripe index = (total sectors / min sectors per dev) % num stripes
+ *
+ * The calculated stripe index is then used to select the corresponding device
+ * from the list of devices, which is ordered by devid.
+ */
+static int btrfs_read_rr(struct btrfs_chunk_map *map, int first, int num_stripe)
+{
+	struct stripe_mirror stripes[BTRFS_RAID1_MAX_MIRRORS] = {0};
+	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_device *device;
+	int read_cycle;
+	int index;
+	int ret_stripe;
+	int total_reads;
+	int reads_per_dev = 0;
+
+	device = map->stripes[first].dev;
+
+	fs_devices = device->fs_devices;
+	reads_per_dev = fs_devices->rr_min_contiguous_read >> SECTOR_SHIFT;
+	index = 0;
+	for (int i = first; i < first + num_stripe; i++) {
+		stripes[index].devid = map->stripes[i].dev->devid;
+		stripes[index].num = i;
+		index++;
+	}
+	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
+
+	total_reads = atomic_inc_return(&fs_devices->total_reads);
+	read_cycle = total_reads / reads_per_dev;
+	ret_stripe = stripes[read_cycle % num_stripe].num;
+
+	return ret_stripe;
+}
+#endif
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5988,6 +6056,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	case BTRFS_READ_POLICY_RR:
+		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
+		break;
+#endif
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3a416b1bc24c..b7b130ce0b10 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -296,6 +296,8 @@ enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
+#define BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ	(SZ_256K)
+#define BTRFS_RAID1_MAX_MIRRORS			(4)
 /*
  * Read policies for mirrored block group profiles, read picks the stripe based
  * on these policies.
@@ -303,6 +305,10 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Balancing raid1 reads across all striped devices (round-robin) */
+	BTRFS_READ_POLICY_RR,
+#endif
 	BTRFS_NR_READ_POLICY,
 };
 
@@ -431,6 +437,11 @@ struct btrfs_fs_devices {
 	enum btrfs_read_policy read_policy;
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* IO stat, read counter. */
+	atomic_t total_reads;
+	/* Min contiguous reads before switching to next device. */
+	int rr_min_contiguous_read;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.47.0


