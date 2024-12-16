Return-Path: <linux-btrfs+bounces-10431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF519F38C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A9189788E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7C206F22;
	Mon, 16 Dec 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gmXYOBFj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ciQ+ZsfU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F3206F19
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372890; cv=fail; b=Whk0PObMr3aW5r0R+sy/WNXXsl1mclo6YcyNxBkS2SAq9MeD0e76sQZeq1JRfsnMD66HfClVxken69TNKX08DknldCt2XyzvjRv3Hkm512WswoNE0Ds0sjnB/u8nzeunCbm7k8gRAFos9tmc5O9APZft007BqfCkcEDXA+VxgEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372890; c=relaxed/simple;
	bh=ldOPgLr/5Xo7nwhjGDIOQ0EvvsrL+y59D337Phc+ECs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mAHkfJaSs/RT69Hwh+JwkVyVUKmVK0cu1zouoCUads8s8d0rPcGc8w9wVeGQCFdyiVbdNuXyeZPXsF/hdA+xKggfD+UoXrkTeM9QBGVxssHRqB9MXyvIewfweViRSQrpwqWcWY+/fHYHnGYPb10QgXK8SXz9GCNYV1qLfSI7wYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gmXYOBFj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ciQ+ZsfU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQk3l015221;
	Mon, 16 Dec 2024 18:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6jFA3VJpjbDfj5Y+/+R8Z2f9p8a+t0min/dwJhv4/UM=; b=
	gmXYOBFj5A7caktphlEfmW2smTfsXWSpGYRwH94l45yiCsDMoTYS7tUdik+wJovb
	RDBLrPP9Bt35FMf7bE4JSoajCHodCnNBDdsMX8bpxPTnfuNxGVHwi69xaS+qFpYA
	vEJ+c+CMb/ylIPlnUhIuxCmO9nqoriQJTvwDs6DlkMos+gVvEHA8V/gD4oRNWuK5
	VD1cBxVpPATvw/e6UG/n6uirnOdD6uFo1JgCnufgXo4BpyuPEuUjdjHnaOs3VvEC
	KBF/PaXkGIWzub3fk0GZXG9deLzBY7NtIsxSi58/538EyQxFxSBQP/8gVVUGsU0h
	b8Kpxv38sawq8gDfPb+DMQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9bxda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHBQKd006433;
	Mon, 16 Dec 2024 18:14:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8bwjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ6dzQIxCysFs4JQhyjLPjzkKoGQdrXwUHjfE95IxgJ5XQRl5Xd/yfN636PooWldjfCiXOjKAiIWEXCmhAuCbH6meOhctVr1EynMtxCylljO53zMaxiKzo73OBJLncoj5y1po7oHAEM24meqCs0mhS3FbiBp1MZHOSzXC6V1FdVqSaBK7aPzJvJ7hIzPKgF14DW6o70h5/GOy9tUyYvbOMzkXp2RJQrAMHccs0IVkXN6S7th2tmlWpynuOLpqXrW9MY9ZDws7UFh20UwntvaZu2RCbDhLUBtL7ALG3nIolZdrtIX64k2CmCzUxdGPct3DKvaX/ILE/mRxO9KvHga8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jFA3VJpjbDfj5Y+/+R8Z2f9p8a+t0min/dwJhv4/UM=;
 b=sDj/YQE4ymuqGV9hmJ5lTWBkoS5ZdqSJ8ibGe2JYqWALR0LaGHMju7VOP9zSTFw7TEbIcEbGMKsrUsm68caTzOQvxLUpEuHbRZkRNV1EKuZVskiIEkeCN2oKY4oCkm2ODXYC9MqPs44kku8yszRxPvSBW5U1ToR6QpP9CnPc84o+mqC2KuxLNY3xHCnGKmvuFtRP9vrtZkSlyJOhwkGI9czB8mF8tIXelSsi8RX3MqBIWhnYOkhh/qmep35Z73OdjS/JAEeaWhDAjL1znyENS0xdHLyMS2m5yvbEyxbyOjHYsuy44f5wiMNYqphy8ClOMWPulZQBhGp1fEmQVV5+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jFA3VJpjbDfj5Y+/+R8Z2f9p8a+t0min/dwJhv4/UM=;
 b=ciQ+ZsfUaZbm2Q2xMjnJ6k+CrvEtl4bqnYYhX9F+7s83LXJNmPZSLhudWyOX5Wn3kQdYgLJglMMpgn+C50QzNsd0mmGD1I+N8ZhdsfTz/yE4zelZKzJa+IcysYFj2zlmidw1idF+I1XbnwVfOEs6BrsqptEum2CPO5ptry8Z0nc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB8220.namprd10.prod.outlook.com (2603:10b6:8:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Mon, 16 Dec
 2024 18:14:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:14:37 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 9/9] btrfs: modload to print RAID1 balancing status
Date: Tue, 17 Dec 2024 02:13:17 +0800
Message-ID: <c7a0deccadcc474bc85ec3393fcb4d5908b4986e.1734370093.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 92426d84-851a-4600-7f3b-08dd1dfd8015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMZ+d7uBoROn6VTQ/87yH3E2VVcBUcG237MF4n1QaV6MZfCgllLKvOUXSPrZ?=
 =?us-ascii?Q?zGwr1v0cl70H1HgShhvQ+fWIGRxn0ec6sGc7rshjDk5y9u8t77tLFKA7PZTK?=
 =?us-ascii?Q?7sNQQkBxQGDqz6QquwKr0/LJwijD8HXwEN5oR+/3wInU7dFHOU1HIgEGfc8s?=
 =?us-ascii?Q?fk1SR0wfQiFqH9JMskErudnx2OcKsmdkTxWTdg63LnvN6f3Mrsaf7mVfe+wz?=
 =?us-ascii?Q?Y1/VwRZ+u4TvNrPHMnPVj6doimit92cPd5oDoJ0aprHaj8WP/inuafIfaQV8?=
 =?us-ascii?Q?Z8mAqqQCVPeK1ZAbYT75/Wwb0byRVSl9QjMCjyaV3+StplwA8sHfD7tAo4Bk?=
 =?us-ascii?Q?ZoXgeAr9vsC03UtsIJJC8L2nesfTd69HwvS38VsKeVJQHPmUk/l0d+wdm/38?=
 =?us-ascii?Q?H/WRqAH9IkktiSVQ20oRsozWmqC0RjUTAp5c6MzDl5wTqeskUXP+yXOKfL4L?=
 =?us-ascii?Q?7y8a9xYmajIVxnbzmq3G/pnOyIs/fNlZwC5FK/9jA4bH0Al4AEWq1smKI/ti?=
 =?us-ascii?Q?fLM20ssK9wXPLyCljHGFI/Ro1BiDrrxJ35ULmY+qNxLUb4St4EmhQD69m+28?=
 =?us-ascii?Q?dPfCKCfaIEEg0NPfhLAskswP4T3RS77URlW8TnmdvzfOh8621BTK+ETrc0t+?=
 =?us-ascii?Q?Xd4AZYqkZfJOGFDy0BRrBilUVcs0m+9R/ZE58wHBw6caoHHjsXVF0KjwEMDY?=
 =?us-ascii?Q?Hyx/JJxzFsMDTn4kvy5ZshkRo5tQbuetLLt0eUmIihiajLxBCrinQazEEi+H?=
 =?us-ascii?Q?IPs3zLTjLEropsWV8Su4wWhecFibUNGVM0srxVcKhbbOkMlSQB2FUTsP8HeJ?=
 =?us-ascii?Q?7VktoaN53yhoTnLSyNq424uO/V+ptGbr51LI/XfpelLUuKfRJVco3nOql4dq?=
 =?us-ascii?Q?ge8EWr+f1J1q5bOeLJ5a8YPhlCFKbaAv936idf4puHBp1mb3V5tYMrp5jWev?=
 =?us-ascii?Q?17adzRI3L6liJHopExqfte/36Whfvlm4PdQPWJB2WZH8oY5NoKRy0vMhLWEM?=
 =?us-ascii?Q?KkwuKEmunnam5vw7Cj92s/87Twt7BB1QrMlDsZoo7aKTSnjneuCVEUIJgyW9?=
 =?us-ascii?Q?U5CexGM9UzlKE0DAVUMEIgqLQpLecJp15tOYXP/fbOQMR1PZ6VoFpQTdX64R?=
 =?us-ascii?Q?ABe2roVEGSsZa2fN2wCUObQH0py6YaX+i4cIdwASeNP0uspT7YqC/vwxzXUd?=
 =?us-ascii?Q?WqCEncSQBBpuSgLl/la64yktb3T79qan2WkX3MlX/nztJsnnCGLRWj2L2Nd1?=
 =?us-ascii?Q?++Arxb1EZkCYKVMmE4ETyuY43abkRgjbCDlew24b8iQlivSZzlxBdWAGw9rT?=
 =?us-ascii?Q?L0H0wos7vpe+mVcpvONhzc8kt1AA4Y/rqQKnugZ9XoU/CyWmNsaJqnoqj0ZL?=
 =?us-ascii?Q?Qj8enj8Jr9IQ/H+9SzGrv51UBgx0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDDXra99aOlv9AJ2lNs1/JSjlbQSPGsjzaPKAuVmFZpdOP1ohgCeg4ElQuR5?=
 =?us-ascii?Q?r7oSeRTW+S/NE+YNgC9l6rKJ3MlGXtqxu4+RcPhpF62m/2Xsvrg+MapuET0J?=
 =?us-ascii?Q?EmLrejioNspSC1pQSINBtgaozRTYF1jZOEynsU0b/VtQB9IYuN3EHXSdMuhu?=
 =?us-ascii?Q?T0LmSDYos8f3LhOc4bpqOXwSnwqJ5LAjDyBZP30SnkME7XSeNlywYGUVHS05?=
 =?us-ascii?Q?SQaR7JWdsQl8+dRwNviGkBYE97xViZBPqw9SwwcRN4HUDbJ7pwiZ0mhjmi1O?=
 =?us-ascii?Q?QEY1ZqofKxZcxayDYfwsMFdRcljIN9I1CWwzQ98sCIzd/RDj4uCSm6GsPwpk?=
 =?us-ascii?Q?knnqzvIXnZOQNj4valjZJd8BixLu9dPOOzJGmtN9ocFvd/yLSMJm2OQCd0BW?=
 =?us-ascii?Q?6I+bLCk2dcW5Vn8FSDClJ2Dx/WL7N3cKvtUEA4iJjqMg9o6w+NRO0au0e3W5?=
 =?us-ascii?Q?u1XVxTbUXjL04JuFVrNuGxGpveqrb6zIT/ZAtNEf+libpkmj8/lOP9RkMb6y?=
 =?us-ascii?Q?2l+2uYIf1O+g0jw+DYVQpg/sFgiUhjpP8JdKbIUbw0BbjjYLgsIqTTlq1sWa?=
 =?us-ascii?Q?ESSQ8/r9PzYYfXklrlIMAWiVkh3AfhjhsFNxCjZnTqByPEMAewuuI0rAhP7W?=
 =?us-ascii?Q?H7Pd5daDWUGaky1wXQO6ulMjk5ZutBe8j45z25pgkNIWncgEa8WJTAWQ12de?=
 =?us-ascii?Q?oyujynTgDT0l0kFdwft8eWOuXVWO5vufZr6oiVRKg49ZAA9NDz9cBfWk/D7k?=
 =?us-ascii?Q?noicjnXrvbz1Lkl6jDGj7WSLiqAJ2PfFw/eh8x/NhxzwyMCLwp1Di6g4KsMj?=
 =?us-ascii?Q?E82e8mh1fjE41SGcb9BdMGNvOW14PaM8BIp8/D6R8/AZqnjK5iNGO4MX1Z+K?=
 =?us-ascii?Q?SukP8MR+oCtojwlnJyrADToZEHgn1sCRp0NeVZRMJ8E9wk/ueZPlmu7DQu/a?=
 =?us-ascii?Q?+vIR9gImu9UUTjGYcwv2i09QkqcjM8N/TXFPX9c0oLyKHGvHnl8OLHgzcv59?=
 =?us-ascii?Q?0C5uXbH+dxfBBZD95GsBgTS+R6D+lbUBzYUZ+7O6ppC88LLAP91irkEYPiRL?=
 =?us-ascii?Q?peJrUAXU2DVPvwq0D5+iH23X25xug1uAuv0/DttZgXLGGCbgrr68yFF7h2ZD?=
 =?us-ascii?Q?C6T5OLXKfX98T3lbHph8IwjKQiy9RyLoxVp8Wod9LDWFV7nz/D62J7GAL+jN?=
 =?us-ascii?Q?dYg+nSGGB3J33PoPe5Zxxom268ri00voZADIQ0yUsVEvlcTUIzWxrZJHgJW8?=
 =?us-ascii?Q?7hZYjiS8dzdsDTW2tGTmtU2t1BJgkyQj9EV9Xsal2H97uw0129wxjXAgNeTq?=
 =?us-ascii?Q?kHIS7CwkrZp1z8q/+Ka6oSIj9I8tZAxJCYTcD0FO4plJqmcC8iuK8twqd2sG?=
 =?us-ascii?Q?XOY4r4Fv0U/+5jPFcLvBlhN28HBJlEJQbsRvDVuI2Duzg+kOHzkIJr0m+8p5?=
 =?us-ascii?Q?vgiMGuyGs0CAYwLRrPPsN85XqkOKdTfUAmOtISRDzLSVia0rD7HMnvidsbg4?=
 =?us-ascii?Q?M6/OrK2qsnxMIhJUewLqfUIL7+eO/ymrM+bOXR1CjyKrVOIFdUFzYg2UmJZQ?=
 =?us-ascii?Q?oqoBQqlgRUQBotI6N90uTgoFevQQvjf6nZYdfjL0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JEuGgDWmK+lt46RbWRRPLw/fDsEreDGlNq1TFH9Cc+chofKpokr1aVTgWTxTDvC2rYJ7Pu3zuH50DX/V0ouNZeYSKfiw6gWE5NO7eemYmp0KwReFx47quAWt2PT8NbEBl9tEd/+CrB9YBYBEHbTLBa/kE3GxIVQAd/CzbCib+6QjQlion3FTUurYOkV03irFBDY71+7FeWYKhZUQYPw3xu/EZIwsR+Mx+vQlxgSKesoamSztgLKvUS9U4vBHM8X2qZdL6HlKNLwvGeUOjcDyMjFbGB3qYdkSNSqwlp9YCYdw5dJqv/5+2M1Uz6DP3NzwQHfLKpHjZGQ2PFvfH3Mt3YqxgTYUou6DxR16rH9B8pTIXGHLRf+MHOsXUE3WnwtePA0q0tCR8SSIkpDiPi5aWjekrx2CbQAeBRd8Z8H0NGGybOc6rhhs5nVn4KEOfQdyUohOXC47EpURyZqQ5duoGWevq8wyxIXSDNaQdjDHQoJoSM0cBOOxpfwA7Kl6NbgdZZBuJLAnFjSKiFH/ebvXWZ6VNAOodsT0hY4Ar5iW+FkTcU2bHfgObbhJJ1X+ydKhVno1x6a7LYlBzKChlrzwWn8AFxfNoY/uARhqU9X5wuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92426d84-851a-4600-7f3b-08dd1dfd8015
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:14:37.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVI0nfx8ESTGpzRtzKafBUrm2lJ1KWgZczMsRWNvVZ6aI9n/ZqVDri4fx72PzyHVdBvtWTF2AsOyK+bzVSSu9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160152
X-Proofpoint-GUID: _HjeNDIJUhBfe3elEcWlryI8PSY7P9J0
X-Proofpoint-ORIG-GUID: _HjeNDIJUhBfe3elEcWlryI8PSY7P9J0

Modified the Btrfs loading message to include the RAID1 balancing status
if the experimental feature is enabled.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 58190989a29d..573e8e1a2b24 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2480,7 +2480,17 @@ static int __init btrfs_print_mod_info(void)
 			", fsverity=no"
 #endif
 			;
-	pr_info("Btrfs loaded%s\n", options);
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (btrfs_get_raid1_balancing() == NULL)
+		pr_info("Btrfs loaded%s\n", options);
+	else
+		pr_info("Btrfs loaded%s, raid1_balancing=%s\n",
+			 options, btrfs_get_raid1_balancing());
+#else
+		pr_info("Btrfs loaded%s\n", options);
+#endif
+
 	return 0;
 }
 
-- 
2.47.0


