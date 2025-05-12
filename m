Return-Path: <linux-btrfs+bounces-13927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB23AB42BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D6F1B61DF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17385298CC9;
	Mon, 12 May 2025 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eEH8MNtB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dm9QLPfY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52677298CBC
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073320; cv=fail; b=GGH1bwksrto5C++SDJ8FUwKZE/IE3+5Ta8t8yuJSElm00COs7GBsh7yxzlUadAcBgKdCFLAbjeL4tNJ3dSXmoax3p7/ea41gcX3MfqVK+21o04X6D+WGNe4otoNe/sA80gZ/GrXo3alxpArE1YMia9ULXVtzbnOchU+JLQBkrLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073320; c=relaxed/simple;
	bh=A1e3BGE5mFutkmHqPzSWnOGbpSZ0FBQxf4456feK684=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMEURSUJQRvdCqkMr8iLdccC/Jn+7fq6zp3uInzGpAz/S2MJWR/XZImfZhIsJ1A+qAykX1SE43mb+bRwyWvX52p4UJWZM1JrDCGRgOkjld4T1gm9mrOIXZ13A7xC8h0vV00lGMP1XGG37aDWiBvZxftosrvNpcdGRQ7zl0/aOEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eEH8MNtB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dm9QLPfY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0tYL003938
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f4OQ1n5GlhRzg+A3VfXWxwyW1zTSCGi7t4Fm9cAa7pA=; b=
	eEH8MNtBSAX7it+K7rV4Ft3tBJjCyMGkisY39Ixgw6euTqQzutGAONJyHvBBgya5
	IypPFYWhIv7GljXc1Ye8dhwoTRoOkR7WeY5rQm8gf8OibNbuuvqWo9ZLs4y6UnfG
	olkS6GUq6J69obHLrh+pQXIxTHyw78AZDaeHqRDsV52jzi0KRVomp44RjP9Ri1EP
	Npqhfony43mkwyThHm6fk+kJy8o4IL0RheuVHll0whexY4HVUWmTmHuD1S/MX+DG
	KahL49YA0SeUrwqiiExD/YuwxjIStItTFKHh4EvxjXJCMoJSK49IDazLwt8zRuVn
	zgJ0NAZ6a7CC1XYEkpt34w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwk6r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHOKdG015429
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:35 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013059.outbound.protection.outlook.com [40.93.20.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87pyxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQTJ9enaR5PyHOPp6kOOJEk2qrTb6bBY+5DiwpDn4S7SZpPegTMqipuqv2i8XxRjrsd4yze0//P+VqgWE0IPi8iLJ49zMAuZrhUImkNXQN5hnKy0aT2XZwYqiiKFOz7llhBollCpXw6jaZmvK2PifRvNtSn0QslGFLu1EgFlg/BuegOStbH2JO6z9gxtrWcmrZ6MwRimH40fvOZjfKrMOoEPlVwe7gS82cmi1V1BrwfRnqNnuWvqgjvwAWFFO0iancPut6i7kRiB6yLVaksLKJYmNuoR3eZvofwm+HwAzDnpOQpJcEEJPwk7sLvFdq15Y7ffGZxdkZAzWi8pIUN2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4OQ1n5GlhRzg+A3VfXWxwyW1zTSCGi7t4Fm9cAa7pA=;
 b=lkgFMdw2x3uM9rY1kTP41efE9cV7KcES+rBVVEpQ7c0ped5+3HLqQzMFWRv1uXGAZC8l5o/WPoCRiSqm4r/+QEED4NLzAfzAkP0svSemCehEv1jFznFCrKom0t8hqJq9ySKOBuVRHno4jQTaFlTaHrtJBA2CFYSBiqMKf4s9z4aNOmuvEHB49j8Jx3neNtjon5wUqQk5F3r6KwENbeCzsts8MWZtLzXxWWbwCAzeahj4SzVs4CT/g6xVTN6iMjC4F4LpmBz8KEoVgdXERJjTJNDzDXRaZGFwBkkfKCMelBGZPktzAOyH9BPAV+YZsDczetmskTNlDsognNv0m75jlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4OQ1n5GlhRzg+A3VfXWxwyW1zTSCGi7t4Fm9cAa7pA=;
 b=dm9QLPfYzdv8A7Dd2HWdgdt+BT9REehgHr7SrflWdrDVwwM0qjWn1f6Y7lN5QfccmsU1bDKBFoTBOuqmxvhHZexurpf/BkrHcwkuvdtCastTsWLVd01ohwE9Sx5G4/hGjrd1uqut4ZpGpmiQj0TewXZ8d6vNJAMago5q1FH58yw=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:08:09 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:08:09 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: introduce ROLE_THEN_SPACE device allocation method
Date: Tue, 13 May 2025 02:07:15 +0800
Message-ID: <d03216808c6b06aa61563e84ccaf3cb4acaf2620.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: b26b4780-81d9-43f3-10de-08dd917ff3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K55ao9UgVAQGG08ZjSU/XyuktnnHLkS0gJgf2N0KDySMDeGpTEjUXP1lXabr?=
 =?us-ascii?Q?8SxwIsYkdaJBa2/ZqR3Qd9+gMJzb8rUd2lXU0MKtgrBbBjMB/w7tAZyiMjw4?=
 =?us-ascii?Q?mveeyCNF1IiYaOnyELc5DmqNnl4EkRxEQlvNV4KV+og4Os9eEso31w4aKkEl?=
 =?us-ascii?Q?m2WOb9EvFHlVieHBLRsqBVVyb8nqCbZkpVCrX1shzzHLCCEPrqJHkWdFmieq?=
 =?us-ascii?Q?yzrH/Biv3Djg+xTbmCYxsCDtsX7TnhwGGvxqWpsvSg47qLiPXn7NakyNZhtg?=
 =?us-ascii?Q?pMyZoDOKWVZiOepg6ULYcdziIp0Pe4fLQctb6AdpYi6YKgImwlwvM08AZtmQ?=
 =?us-ascii?Q?jEagDmKcgZzYW0ikQfyhg2T8wBu5/ag69fNtIHGflqNd8EBQqEzhG2GxaWCD?=
 =?us-ascii?Q?YJE1GvvwY3hmnjShWloSQ3xNubLC+yQFagVBijzHodVXpwyv4x43y8byznLz?=
 =?us-ascii?Q?LgvifceIGdufB7nk3rHVOcCqAje4mir37V5k4FxEquHbtCmn5aAnekp3YFJl?=
 =?us-ascii?Q?P+sEhGEUgcDyLgXA2VC2zVu/bqJBl4QK7GbMw0PCzlceWEcL0RWfmC5qdED7?=
 =?us-ascii?Q?56ErPRwgrKy304OkbKMyHMJrubIj6OZ7+KEALAKRB8sMlv4TqEwFK9gChNfo?=
 =?us-ascii?Q?J3goMlJkOw1q2c3FPxPr3VyR8VIEQFWro93mMhy08wWE7cgmRV3iup+kfhQf?=
 =?us-ascii?Q?LyLbSBTTIjoTr6r7eVHkYwQJz+e7X9VfjLCUPhoT8pTOMtYaJZxbNefHbv4/?=
 =?us-ascii?Q?UdvZ01hKYhxjN/rzECL4dSdnbKMB938BiliVlVzuKlbPOj/h96TfA9qVZWdS?=
 =?us-ascii?Q?jwyY4uZuwVI+60qkk+1dUVmvgCgYw63NCCpaeEF429OA8peyEQtoNCRilulJ?=
 =?us-ascii?Q?8v893q2iXGJNaHpmX/s0++sgSfdZP3uccez5eVk4g+joY7Y0HpeJnkylXrnk?=
 =?us-ascii?Q?QYtnm3YrMga1IRBJK4PL9/+bDQDyD1UZFZfhpPOfRP+lFB8beQTRLa6bWmlz?=
 =?us-ascii?Q?bCDFCqwLUnOxBIIIpjiXMkSu+wT06mF8eev31pX6qv5COiYKNr3eV60TFKyh?=
 =?us-ascii?Q?D7YoEgaOiLu2YxQaYaixDdqlQhvx2FWxu660FtZFVtR8ya+GihLIRYmquTwd?=
 =?us-ascii?Q?RgBbqbRY8PPXpMralxbBy22eTwFGR5j8fTq9BdCc96lnMjJYaF/FguJq137U?=
 =?us-ascii?Q?JlAsTPmpFifwHYp4Rv4I90zQZZg35qLFXbkR5HW1mX9DbhBisciPh5bc3OZC?=
 =?us-ascii?Q?DWcJOEzxV+nLvYeIV4w+H05KgNLM2u/NWtb5w3KJBQEY5oIrPCwqyOueqmxl?=
 =?us-ascii?Q?auegvroREWozN25WPSK/SmK4vQ/nLr4AHdZQE4uSm7xry8xYbEblDDwlducv?=
 =?us-ascii?Q?r3hcgpt76+2dhXHs9XHpEsosDQWDCtJ7E9JbggMnd8/3Jrj+NQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BG2ne9cl8sz+QYBvOY4OCCnuYCA5gf1bIiPJK6cqq2OwxB0ItCW0s5fQW62?=
 =?us-ascii?Q?9HUp546eBrNRrW9GNm8As5lWRgKPOvMJare1NEtjWGx79B16+BEAYGbPTXXS?=
 =?us-ascii?Q?LUd//Y/keE70geNxasBpW5j8Lm+V1wT4H1pLvYfBC4cv4Cl/jEaHxk/4a5hv?=
 =?us-ascii?Q?McSKK+OO9jOpmEYLXXtMoCOlo0hiz2OdapvzKFH3NCpQ+5F8oNZa70dUAVdX?=
 =?us-ascii?Q?4TaQrNSKOhO8y9WWqeAlmxWfxrv9NEoxiBr4JIF7CwMERG7G6pZFYly0Otjh?=
 =?us-ascii?Q?7HG2McPkYUsEEjLul82kAQ/7zbnbfc0iUbTjHcr2bkHtsS6FwuIEw+szIWBZ?=
 =?us-ascii?Q?3K7v1ycq9ISTiEpf1h9WvIVeZRP/PJdZks+zTwLkkqMBTctM1gSSJiS7hSxa?=
 =?us-ascii?Q?e+huy+0pRVZ9Wg5oS8AIEKX05HcsJjFShwZAGU7uudXzmI4Jj8e9DzSc6nw+?=
 =?us-ascii?Q?ObFzsRv2arepoeqDL86TUizDyBtRfiwoWSNqxe0ZOjUPGR6/KGTimw8dhaLR?=
 =?us-ascii?Q?STjkQpcRJtdR3ErmR1Wv3NIAfYKTZIVNsf36MbDbiAuj9rJqKVcVaGJFP3bT?=
 =?us-ascii?Q?abpqoniO7HmtHRxhqAvO82wyfGjDXHa4WShEFcR62d6/vsqqqnyTL501a4aH?=
 =?us-ascii?Q?eHFpm/FuStCCS53ahfHYvQEp1tc0s51bCoL2fIpe/e1EXTtNRQocJpwizPy3?=
 =?us-ascii?Q?fWDEreYRahSkYEJeRCm90oPW98F6i0Yc/MrDaeQ2Uu6XAGBFGq4YeGhQvhFI?=
 =?us-ascii?Q?16qaOEijFgNMC43PthBscNselMEqEYzrJBfY/tTqFsAEixwUFieMiNTCoY21?=
 =?us-ascii?Q?7FKiWUsVjl84w2w58PpuqRDZgyV1AGfBV2AEC/BhbYU58h5GpFaQokqtmDkP?=
 =?us-ascii?Q?9Z6DcxrfjHFq4+f/GlAfG/UvgQLr+xekJiIFcSLy5ipZFs0Tl3ykg1qhoLDk?=
 =?us-ascii?Q?VyBGjc+zZ/itAnajf3HZ6MuHEm9cnebyoQ2XBlUrpDtL1M77Ce4nQEe6j8tS?=
 =?us-ascii?Q?TT8gD0GKUFxtz4U6cnzUu2YfbfzzyjSceA9J6M6PF9i3DLP18JZkzmidI7DT?=
 =?us-ascii?Q?epy2T2OU18EOrGn3B7F4ILK+/tFwkQBtGCuKQBMQd8pZwkqRyrQWJqlzEQdU?=
 =?us-ascii?Q?3jhYPI3E9lSJGflBKQlfzGk3WQ/auaW+ct9ANHKiUN3xP+Ifh/XQshgGqDSt?=
 =?us-ascii?Q?i3vLFlHBzl5U1dbPK35FD/UWRckmFmN9ROmKwF9VxvWfKkro0izGgHKrxeGB?=
 =?us-ascii?Q?OCKMpeQSo1VL5jtw1X6C/N/CcSLH6Xj2nFBfouDkOvp2kxd++2zdtVqUksip?=
 =?us-ascii?Q?SpwWFUZDH8ciHMyTq6ztKDZtdyPhuWBlP5b+xvi7Yhi7r8LY1nkbE/yrxsis?=
 =?us-ascii?Q?pB8X01vZaZq6IBQVIUenk+3hUwHIBFEMGNb4tSwBUlAhsSysiZDaXSJTQrbt?=
 =?us-ascii?Q?a+e5aBfOWITbf8RBzFzflCkU7oKelNo3A4pZV/5uQtTb8Db84gBaZ1MyssV5?=
 =?us-ascii?Q?bRO0AZUW+8DRixcYk7r4BUejNkbMDaTUVihsEsYhtZcaK8AIpkYtkgUdAJEH?=
 =?us-ascii?Q?vxgb5GC3HM6BEBGkyyLzyEP/6fNQgl0yrqVJuubG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k88hvYxfgPbxW+bVBhRpHjvs2Wz9lE/3RDXMlwD9QVF7Aptdi32g0Q9D0D3/cJZqE5GygWEGtWMiHoAplOlLg6UOSwZFnfNeisSejfopIN6W5Crm455pe2esrVLPd2iuAyiR5WP67moLKh8YYPhK4X4hh1aZc1FYmeNiuZ7VBRAoiVTxd26hwpiFTOtMzIlNqvPUigQdH4t99aIKoc7QCBpXFT7G5Rfe2JWomYB8eizuAkxFR86yToG4GzEOg0USJqIMpRPhe5tF1sV2T52WFUAVq+A3QQLRa3V2ZJZ+VjJ5r2X7Pgis6rTGUa5Tg7480NYmkMJAysVNfMWBD1GaxeRxh27FXwu6chQFpNiCxCsE6Qx/SnmBpSt5Pd8whes0bDefH8Ex/Fvz+Su48hIgEWsahnITQC/mMl3riungllaUkGvUtzZ58Z/RHaAilhkfseRjU8+VPQP3H7lAUTHRhS0GxHndRiyOF2AXb/OehOZ3DfACEq9WwkxtiyFOfKbZFnFG+v0x8HolqRAaLxUSzPe8OpIBSInO9LrbNu8ZAURt3mlHA8u6X1t2JdxjChz3bSI6JV7p8q9c7Je1vmAxL3LM2Pm94nbEJqO63MGmuMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26b4780-81d9-43f3-10de-08dd917ff3f0
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:08:09.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugIWsPurzAdbShxb7ABnwq7wjjfzJwBD7wjsF36usGOFulbI/bJsL2zFlrzZ2z5av26S8AWl2YeB/nvlzQgFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=68223925 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QB_BQE_NPUGtjjfa-PMA:9
X-Proofpoint-GUID: dIi2Gq1XTpKSFlafbn6WbVsfNtwQc84s
X-Proofpoint-ORIG-GUID: dIi2Gq1XTpKSFlafbn6WbVsfNtwQc84s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfXx+FsWk8rbWgY i+Gm9biPc3oNV6EKK6TZKQw1lPf/zB4qsqEWZJgyQFLuyFdnd2qEG7JXK5tjjLYVW+oL+5AWnFi fBafwbZHHCcPdMAWSgo+11UNFQgHvDUw0RVnM8QWPyMqmS3fPOTQcO2IsbCTIXH9rDafkSOlxny
 wa+xqAB74/PvvKTTXIi/P4prK+1Pcyl+yoK/3x5J9bfCEw1VpEAbMivbeDjDH9uzAPIEc9N7cTQ fOiHXuAsqFa0bynDyH7N91mvNjF4zU8aHiMvThY91g7mLj4SiBg/PBY+SfWpi+0G55n1Jl80IdY SPfn0Gz6vgKyM/RhS/QLP+GUjMXlZh234v+DRyCD1GhbyMYoHBxAQlr2jwUci9l4VMfa3FmCLPb
 5/0WtiLHJLozdj9HGH4JjZeZMw1zKzPsYLu3wNvlmJmcxLs3n6FTejC9Ehp7wHAqfjZHqVEI

Introduce a new device allocation method, BTRFS_DEV_ALLOC_BY_ROLE_THEN_SPACE,
allowing chunk allocation to prioritize devices based on role suitability
before considering free space.

This patch adds:
- Filtering in gather_device_info() to skip devices whose role
  (e.g., DATA_ONLY, METADATA_ONLY) is incompatible with the current
  allocation type (DATA, METADATA, SYSTEM).
- A new comparator, btrfs_cmp_device_role(), to sort devices based on
  role suitability for the given allocation type.
- Logic in gather_device_info() for the new policy: first uses
  list_sort() with btrfs_cmp_device_role(), then sorts again within
  each role group using list_sort() with btrfs_cmp_device_space().

This allows for more granular control over chunk placement based on
defined device roles.

To check if 'role-then-space' is active for testing, updates the
previously added sysfs interface for role-then-space:

    $ cat /sys/fs/btrfs/UUID/device_allocation
	[space] role-then-space

Compatibility:
 - In older on-disk formats, dev_item::type:4 is zero. This implies
   BTRFS_DEVICE_ROLE_NONE in the newer kernel, which is acceptable.
   Although BTRFS_DEVICE_ROLE_NONE is not equal to 0, the kernel always
   writes it as 0, thus maintaining backward compatibility. Therefore,
   older on-disk formats will seamlessly work on newer kernels and
   vice versa if the device roles are not activated.

   However, if the on-disk format is newer and device roles are active
   (i.e., dev_item::type:4 != 0) and you want to mount it on an older
   it also works because the kernel or btrfs check never enforced that
   dev_item::type must be zero. However, when mounted on older kernel
   the chunks maybe allocated will be only based on the space avaialbe.

Compatibility:
 - In older on-disk formats, `dev_item::type:4` is zero. This implies
   `BTRFS_DEVICE_ROLE_NONE` in newer kernels, which is acceptable.
   Although `BTRFS_DEVICE_ROLE_NONE` is not equal to 0, the kernel always
   writes it as 0, thus maintaining backward compatibility (if needed).
   Therefore, older on-disk formats will seamlessly work on newer kernels
   and vice versa if device roles are not activated.

 - However, if the on-disk format is newer and device roles are active
   (i.e., `dev_item::type:4 != 0`), mounting on an older kernel also works
   because the kernel or btrfs checks never enforced that `dev_item::type`
   must be zero. Nevertheless, when mounted on an older kernel, chunk
   allocation will likely be based solely on available space.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   |  1 +
 fs/btrfs/volumes.c | 90 +++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d07c22e05088..db008a421450 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1525,6 +1525,7 @@ BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
  */
 static const char *btrfs_dev_alloc_name[] = {
 	"space",
+	"role-then-space"
 };
 
 static int btrfs_dev_alloc_name_to_enum(const char *str, s64 *value_ret)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a44749103410..fb86d5684454 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5097,21 +5097,61 @@ static int btrfs_cmp_device_space(void *priv, const struct list_head *a,
 {
 	const struct btrfs_device_info *di_a;
 	const struct btrfs_device_info *di_b;
+	enum btrfs_device_roles *role = priv;
 
 	di_a = list_entry(a, struct btrfs_device_info, list);
 	di_b = list_entry(b, struct btrfs_device_info, list);
 
-	if (di_a->max_avail > di_b->max_avail)
-		return -1;
-	if (di_a->max_avail < di_b->max_avail)
-		return 1;
-	if (di_a->total_avail > di_b->total_avail)
-		return -1;
-	if (di_a->total_avail < di_b->total_avail)
-		return 1;
+	if (!role || ((di_a->role == *role) && (di_b->role == *role))) {
+		if (di_a->max_avail > di_b->max_avail)
+			return -1;
+		if (di_a->max_avail < di_b->max_avail)
+			return 1;
+		if (di_a->total_avail > di_b->total_avail)
+			return -1;
+		if (di_a->total_avail < di_b->total_avail)
+			return 1;
+	}
+
 	return 0;
 }
 
+static int btrfs_cmp_role(enum btrfs_device_roles a, enum btrfs_device_roles b,
+			  bool assend)
+{
+	if (a == 0)
+		a = BTRFS_DEVICE_ROLE_NONE;
+
+	if (b == 0)
+		b = BTRFS_DEVICE_ROLE_NONE;
+
+	if (assend)
+		return a > b ? -1 : a < b ? 1 : 0;
+	else
+		return a < b ? -1 : a > b ? 1 : 0;
+}
+
+/* Sort the devices by their role to suit the allocation type. */
+static int btrfs_cmp_device_role(void *priv, const struct list_head *a,
+				 const struct list_head *b)
+{
+	const struct btrfs_device_info *di_a;
+	const struct btrfs_device_info *di_b;
+	u64 *type = (u64 *)priv;
+	enum btrfs_device_roles role_a;
+	enum btrfs_device_roles role_b;
+	bool assend;
+
+	di_a = list_entry(a, struct btrfs_device_info, list);
+	role_a = di_a->role;
+	di_b = list_entry(b, struct btrfs_device_info, list);
+	role_b = di_b->role;
+
+	assend = ((*type & BTRFS_BLOCK_GROUP_TYPE_MASK) == BTRFS_BLOCK_GROUP_DATA);
+
+	return btrfs_cmp_role(role_a, role_b, assend);
+}
+
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
@@ -5247,6 +5287,14 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
+static const enum btrfs_device_roles dev_roles[] = {
+	BTRFS_DEVICE_ROLE_METADATA_ONLY,
+	BTRFS_DEVICE_ROLE_METADATA,
+	BTRFS_DEVICE_ROLE_NONE,
+	BTRFS_DEVICE_ROLE_DATA,
+	BTRFS_DEVICE_ROLE_DATA_ONLY,
+};
+
 static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			      struct alloc_chunk_ctl *ctl,
 			      struct list_head *devices_info)
@@ -5256,6 +5304,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	u64 total_avail;
 	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
+	u64 alloc_type = ctl->type & BTRFS_BLOCK_GROUP_TYPE_MASK;
 	int ret;
 	int ndevs = 0;
 	u64 max_avail;
@@ -5266,6 +5315,11 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	 * about the available holes on each device.
 	 */
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
+		unsigned int dev_role = device->type & BTRFS_DEVICE_ROLE_MASK;
+
+		if (!dev_role)
+			dev_role = BTRFS_DEVICE_ROLE_NONE;
+
 		if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 			WARN(1, KERN_ERR
 			       "BTRFS: read-only device in alloc_list\n");
@@ -5277,6 +5331,14 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
 			continue;
 
+		if (alloc_type == BTRFS_BLOCK_GROUP_DATA) {
+			if (dev_role == BTRFS_DEVICE_ROLE_METADATA_ONLY)
+				continue;
+		} else {
+			if (dev_role == BTRFS_DEVICE_ROLE_DATA_ONLY)
+				continue;
+		}
+
 		if (device->total_bytes > device->bytes_used)
 			total_avail = device->total_bytes - device->bytes_used;
 		else
@@ -5323,6 +5385,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		device_info->max_avail = max_avail;
 		device_info->total_avail = total_avail;
 		device_info->dev = device;
+		device_info->role = dev_role;
 	}
 	ctl->ndevs = ndevs;
 
@@ -5339,6 +5402,17 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	case BTRFS_DEV_ALLOC_BY_SPACE:
 		list_sort(NULL, devices_info, btrfs_cmp_device_space);
 		break;
+	case BTRFS_DEV_ALLOC_BY_ROLE_THEN_SPACE:
+		/* First, Sort by device roles for the given allocation type */
+		list_sort((void *)&ctl->type, devices_info, btrfs_cmp_device_role);
+
+		/* Next, for each device role, sort the devices by free space */
+		for (int i = 0; i < ARRAY_SIZE(dev_roles); i++) {
+			enum btrfs_device_roles role = dev_roles[i];
+
+			list_sort((void *)&role, devices_info, btrfs_cmp_device_space);
+		}
+		break;
 	}
 
 	return 0;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7dbdfe502481..73e26bcb19f5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -317,6 +317,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 /* Btrfs on disk chunk allocation methods. */
 enum btrfs_device_allocation_method {
 	BTRFS_DEV_ALLOC_BY_SPACE,
+	BTRFS_DEV_ALLOC_BY_ROLE_THEN_SPACE,
 	BTRFS_DEV_ALLOC_NR,
 };
 
@@ -618,6 +619,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	enum btrfs_device_roles role;
 };
 
 struct btrfs_raid_attr {
-- 
2.49.0


