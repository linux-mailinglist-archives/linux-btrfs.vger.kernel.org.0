Return-Path: <linux-btrfs+bounces-10848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B0A07B72
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25329188BC09
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365FE221D93;
	Thu,  9 Jan 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kK2IHSme";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SY0WzwCE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC221D598;
	Thu,  9 Jan 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435414; cv=fail; b=pHHX88Olhpsv/oevfziglIONdRtp0gCyRFsWoYdVTha6HqFKmTQyJu/VpQRBipApLQ2Ed3xUxVeqMUuUaue/qHTxSG7GAGai+q+xeEso0laLGTvFH2ryrhLF4drVWAphd5OEVVNB9ykjz4KhNfXOhZu2lsvHamTodQJ2TRuY2JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435414; c=relaxed/simple;
	bh=qdXNeWsJpqG8jL13ByOtbdQYSD8muh6kAZQdVxlW7eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qa6jnFx+p2cttISeGSLr2SAhuNfyJXYbBNMrb/UzNXghGxg7O455cOnrJOsVGWm50/999/FSmqBjyOjGZ5at3svaYssoY69zc/wFHyeG5DBcxqEDhN9lUWMrOu7vmUu4JiqfxWvJzevvs38OY9ZOI4D988IYPfg5hSbQaw0BuW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kK2IHSme; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SY0WzwCE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509CfnTi010936;
	Thu, 9 Jan 2025 15:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JwIWi8MdWnmlTGM899Oq75q/kuIGgGYF5Ri4kDYj5mY=; b=
	kK2IHSmeeQ9PNyeKXZxXLzxQSrhSncMLDrgXU6iXfTYAH4hD2/AE0wdrXkZJoODq
	ZrD2q3HJ/XZZNFj2+/LxJa9qZOXL6E//1fv+mfLCekiQSy/oHCyvEqpb6LAhy7Zi
	4O04ZPhygnMosLn+99SYVBaqGuZ8p7qAvAnObqJ7AUBkjNJWRSPwxYcZZqW0A/S2
	d/mTN/aKeof7RqZpWT5WNQ8ijWF7SLQNrc488mrPYmKY2HuCIn1Gmnr5WOgIejDM
	rXr73/Cmjw35l2zt++aC0c51pPnVcCAe7rcxLoV5J0xOmO0kajYl5f7mEymcvHZI
	emZINZbcEsg4uYALXZxB5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb9630-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 15:10:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509Ejch5022773;
	Thu, 9 Jan 2025 15:10:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueb6ekp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 15:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkWURx9VS4t9URFHn+VFGBr1e+7GgFFXFSjgbJ+MV6BKmYSLclHp1VgpkgXuU2NAia0cJaz3O8pmRAFoDbbshAPGtfWQIUv+r4DHmCPRfGojV+SGa6+ju6THVd+/Hbw6Vpkwh7iJUI1qvZtssK10otxmULGk+jvn9Eh16MdHTRbkv5oezDw4fwxJZw1fVLOIPg6q8IgMSTgtH2CeaX36ffXDEBf12CvWXqEqLLfp7xrmixtApQIliR8yB4a0teYP45LJqyErbhr+iuNlDjhFiFJyY/isP3KZPRmhgVBvMH1ZiFnxoAe347A1YcXOS3kE+X+ln1xY7I1OqyH0mD84GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwIWi8MdWnmlTGM899Oq75q/kuIGgGYF5Ri4kDYj5mY=;
 b=txj6bDC8YDewW1fkYsqz9658lyv2gElEDANbtDV1c01gRatdr0x7pPtGaS7gI95g4FHALPZfaZWVUE654K5SUMp1HiDyD8z2F70C8zPKgUo1tcrQ8ljBBfqy93FcZ+pz/ZeEN+kmJCbKflqTl9z48v5nuVeLHbnEnSiNP7zZrr3KdX+xvEDBENAobLH62EYcLc5qAX5kzWZEd6tqlVC4LLo7mWhuZR5qH2r453yTJrgejLrS9XxD5H8+r8u1R5cPr96Fy8YtsoG1yI2Db71HKHKFtm1vnXnebgW5iXCMEwV/tqwvZE4IfKONOfMjBc2eEx03Q4rCcY/9AFvBa+qdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwIWi8MdWnmlTGM899Oq75q/kuIGgGYF5Ri4kDYj5mY=;
 b=SY0WzwCEGUjRzEX9S4Gbw+Z7hvQIkuQecmAYPpqLZcDJmaHZynjvydhzgjKDBb6pTdmXGSnxF542Z9ehkZlfqKSOWV6EV91CgyfhDQ3E2RxspjynSLGDn/PWx2J5TvK6sykqvhllJ6pe/b6EM3vTPJg6nOkGH+FnxVhdExSmy5Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6830.namprd10.prod.outlook.com (2603:10b6:208:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 15:10:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 15:10:07 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes staged-20250109
Date: Thu,  9 Jan 2025 23:09:14 +0800
Message-ID: <20250109150955.109775-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
References: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 69510735-b8c4-4f56-e50a-08dd30bfb3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kbEOH0o665l4b5hg3tCI8bflow8/6AEsU5eK78ei3MnHB+ggweZ9040DurZg?=
 =?us-ascii?Q?c4gyuGJGFVgCK32HosGdFoGdEbz7GlGr5CPNlHfbCj+HvkL+GDzXDMl+DPRd?=
 =?us-ascii?Q?4lyVim6Ko6uxHvFwrSss/ue5/zdy5Qiq9rmOhi2vAAEQOaFI9ENOtKWJXh7U?=
 =?us-ascii?Q?XG/9qQk9Wwg6u4omSxm2uGX0XO42FjfNo2sIrQVl+XUvesd7Dn8VdSkotRix?=
 =?us-ascii?Q?DlIoNsO1mjF3nLnAxZnwl/2zKZjoBzI2M+wyaWmKGbCGk7UdYik3XM7DqKoC?=
 =?us-ascii?Q?Z8i1g5HyL29bQzyKacaqYysoWnEhxDmrLWOg+LqA1Hzrnp4DxTai1eeQ0S7o?=
 =?us-ascii?Q?qn9iA/K49yAiHB/iaHZOs/9PXSeZmPhkbUp2DYXGqXWh5SA7y4KPGEh7wqpE?=
 =?us-ascii?Q?je8dCO7+5nRjvvRFv2DOiSFUNVPWjM4ObmeY8tgflD41mk0ECsgKRiO+en66?=
 =?us-ascii?Q?s39959arA35BX412GQDtugY0hOiv48fZqYi29Cw2PrkaH20cGmn/1AmPksAJ?=
 =?us-ascii?Q?k6omA3Ke+ch/vlmstm1OZiZjKTgxk7G/4s7W93y2kMgQHqCXTRu1aNQi7UMa?=
 =?us-ascii?Q?h7bhnchHmX9FWZmj49zsbYPm56uuf1qcMkuee+oA/o6V6VvxhU2Rh+SjqhTg?=
 =?us-ascii?Q?N3fPdglhx6gmBrL5kXHNq+vIe1dPVZTYhOXU4JTuVIcYGBsB7vigAsy2tjiC?=
 =?us-ascii?Q?gwWSY/w1076RJKgRm3dloyK4Ql+31UQmvldSRosUMdWiufxn290yW7YR5wPY?=
 =?us-ascii?Q?ldfTYrrDlN29yknzh3MPfsT4l6NJpVbJZn7mL2qmusP8Vn1ppSbsShoGgTJW?=
 =?us-ascii?Q?GXk5CaweutjlUwk05jpCGUVzkSsgrOjwTZe6+DwgqEwwRu02dy1gDuIlXzwo?=
 =?us-ascii?Q?2xeZ9JQqA9vIe4IQKYHFMgNcJdM7dgtQTBGJx88HpzcWy9FXxjjZJvkIRJVZ?=
 =?us-ascii?Q?EqaOOsKHYeJtY9MBSN9g5DApIVjheYW+w81hBtjy1PaBFsnlhH5bdc0hyXDw?=
 =?us-ascii?Q?L1ux6fOTcVQUMI2tqc0+CPwM1gh4MqnB1qsTofmZja+T21vU32f9iRsn7lET?=
 =?us-ascii?Q?3rLAN4MWHQR2lGeqzi4hRkxNlUr07UIF2OF/bAZNVYDOfDYUFOiVZB8SCaoP?=
 =?us-ascii?Q?bNVusYy8wOlX3bFitmytwWiD6w3x7t24Z2n4MsDiEdgQUZe2rUi26uqyFLuG?=
 =?us-ascii?Q?iKrFazrnw1lA3wsaR4S23y3XvX2J21YUtN4XdNdu3LvsbaRV/hEB2JUlHfje?=
 =?us-ascii?Q?wmtDcac3l3T+XDvBTlwQuRCmLBE2TKdshZgjxE+36lbXWlnx7JiZBxidX6PO?=
 =?us-ascii?Q?xN1rLgYBjfK2QATqoYkvS/PKxKsXf/6bXy+yz0T9LDrLSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfb4ccpLz89JZtiaywVrBMMKpNqfB0QsnZsNaIoEvdLg4xs+xZqecYrD5bPt?=
 =?us-ascii?Q?1fzQ5zjlrCRei/cNJbN7TIPHyTXzhDItUqR9dwCgv+uolnhKtULU3WnzuTmi?=
 =?us-ascii?Q?BWPp/+Z+2jDogdDm1LIpBGERh4b9MbR6sazgd12D2kiNATeA7SHz4X1JPV0H?=
 =?us-ascii?Q?MVK9HXCP3KquRK8pbBwa4TrfLlayl+ddwD6nCvZ4CfoKbSRN7a5j+0pO/nYL?=
 =?us-ascii?Q?mhjEcdOHzTxT3DTZn3ooU+lRSf9YIuEXiMmslZ1StLKVkj3d9f6+H07LWZyk?=
 =?us-ascii?Q?3jJR5tf69kls0lDX70sW2DEkNnrAjsUFrRKvjjvGPb4qtnLBHRp1wMKx2M15?=
 =?us-ascii?Q?N+PTqqG3bMxmU4SSsHbla7wfcwI6JHzJ9QiActafgNvVyVNZSU71C5tA7Qx5?=
 =?us-ascii?Q?F3XxAvTzXAh3dWeaZ0UmAoqlo2651RQCjMNj7qDcbbUbF/PCTMhHGEVHBu3S?=
 =?us-ascii?Q?G2sXSgvwyh52ioMtxUTcJEEq7VjKEaueol4Jz0wd8yf4CnckYNt9ysHv2fts?=
 =?us-ascii?Q?a/dtk6K0s9rsqYc5dLF0tf8Dr2BGrteeuQ2wqn7nED2uWTnFc4RughPTHlgJ?=
 =?us-ascii?Q?rdx+gz8Na3YLHSlrVrNoyMVcLc4VjGwz6ybouqxWsLvCaLesrUW6mkw0FshT?=
 =?us-ascii?Q?9Sm6/teUtLQiAkF+E1b1cQit61wIVZuFeq7GeQ5PGfcJWPgYpF6P5qkKZR20?=
 =?us-ascii?Q?ApeJ2CUdn7rM4NsXRqReHhM4o6wNpZbokDCnIT6uQHVUJMzPsxSbcfrlgzCp?=
 =?us-ascii?Q?ZpWQwOkSzqyzn1+HQ5Pvptj/UMtOY5r4mP7fJS0OiV2DNXLrstpekzXvAvPA?=
 =?us-ascii?Q?IcMm2QPU6c2raiWc/GZ+wXJNLexVQclQVjnzljuZ3wn+u/VgiZPzgthzNgVa?=
 =?us-ascii?Q?kRe9zfag2A9JX/LTTGpRFSq5uStt2CPvKgXqGybHJdHEerbqB1ZLIyZqX1fd?=
 =?us-ascii?Q?KxdeLAD3ISbUu+Q/htsDrhjtokIidy//Ro622/ncJNWPOLvcdF05PJHP1I4E?=
 =?us-ascii?Q?oGAcre/nD2yLYc+NYm0uxNL5pHDXlXmwoWvXil3xi6P/q9XNXpUWunr6trhO?=
 =?us-ascii?Q?QhVVSbQ3RdjgtpVJtXMhcrexCltLjknzi6HkxO2Tb7H7qHz0m/mnYQ0/x414?=
 =?us-ascii?Q?AELjU7IKLuF5TuPbkJxeu7ZgQA7fg/6hF35KB3AUlbWWr5/4eVRtYD9z2LJl?=
 =?us-ascii?Q?G+ea/+iG4oMnuMoAEj3a8/D5AHFoaiLp/EASkg8dJUf4IB1nIxZIe1juq9mz?=
 =?us-ascii?Q?Ypr3KKyo2MPevHFX89m7eoBL+u8tiLwAn60io+SgcgnVRnJunAn9DOEZcGfF?=
 =?us-ascii?Q?4W/0BoUByOVk2pt0+08kEbviekmLBAtnWEsEBQIJS+CV6jA+5jzBTQ7D/4VM?=
 =?us-ascii?Q?fARDUmo5R/MCE/lPMmc0GlGvmfLoBGuCJszr+r9K2RlLci73F3jQrMA7T63L?=
 =?us-ascii?Q?A3TzKH/Pn2OeZwFbvWAQxOWmkgvz/bS4HJ2eR8lCHBbua3S7QaLAWgyiSSxA?=
 =?us-ascii?Q?5Ung2BHYfyrgOoghM7e2jCqiEwvpMr6s4uz7c4Hjfm8J28XJ1HVeId7hrdHu?=
 =?us-ascii?Q?gOalPZofsxF/LPALE3gEXqc7YkXm0OUT50jZWiJ7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zXS/4OhlvzoItV7SO1hFlJv54ZxHUnJkP2YwJl9w2zGJpo4k70Pso7IxLnWdawt/As+Bxv5glA5Pb3VdO9HD25JtkRoiwu5sWiHpw07tE2VKlsXJ99zagct14rz+tykVHb4gcuD8XC4v1nriInhOJA4LaXHtbB4d22naq3yHzAYPAmIf68M8AsvA2sAnTRKfEReZw3s7cUs/5A2ml/hRPdDfKlxSs7WS1Uz/BUnrNI19xnBW8YxUuIhvhtLycFGMh7dgKAf1BlSAvpgClmiZcvvxw3VjWYKtKC2GjNd1E/qEjwTuknmPivt+hgj0me0Q62FaT7lT6Bo7EK+FwSe5dXIdOjV6p9Dj+xIHv7UXqNzrj285J1QnA4DiJgRf+S4J3MLxRKqhcDj41RlLQeqPYnelzr/q/zdcu3lMl/VpfOg6tyf7VgLvRK9nNiLT3E4CFKbx86NrpXcqbGNrxMbA8uS5SJpwk20IYnb84agvNZCqTc4NXbo+OJtQLlnI2l/ADcl20LiysQ0n2y2P8qf/OQwntnKRRou3cEQf5MRGOeD7AOLlOAbwp7hIlJGHXW7mEcsncTV081ty9IDXsCxxZgS07XDD5WKf+K4diKQJQjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69510735-b8c4-4f56-e50a-08dd30bfb3b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:10:07.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jiSI93L/y+Cy5xmF9rW7dD5hg0boIHwx11F7vBC2BiY3p9S8dzZLbo3vwW5bs6Rz60Cp5gvakZFSDyemZZtSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_06,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090121
X-Proofpoint-GUID: 20WPyKAfKFAgTZZByDCix66nhrB16bbW
X-Proofpoint-ORIG-GUID: 20WPyKAfKFAgTZZByDCix66nhrB16bbW

(ml emailid fixed)

Zorro,
	Please pull these small changes; they have been reviewed and tested.

Thank you.
The following changes since commit d862cf27d1b44de3e3d0b8380d22ef43b308ca32:

  generic/530: only use xfs-specific mkfs options when testing on xfs (2024-12-19 18:18:47 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20250109

for you to fetch changes up to 73e44e1ba7bf072a9e4f77bc3ac6a60eebe0102a:

  btrfs: test cycle mounting a filesystem right after enabling simple quotas (2025-01-09 11:00:37 +0800)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: test cycle mounting a filesystem right after enabling simple quotas

Mark Harmstone (2):
      configure: use pkg-config to find liburing
      btrfs: add test for encoded reads

Qu Wenruo (1):
      btrfs/326: update _fixed_by_kernel_commit

 .gitignore                      |   2 +
 VERSION                         |   8 +-
 common/btrfs                    |  32 ++++++
 m4/package_globals.m4           |   4 +-
 m4/package_liburing.m4          |   8 +-
 release.sh                      |   2 +-
 src/Makefile                    |   1 +
 src/btrfs_encoded_read.c        | 195 +++++++++++++++++++++++++++++++++
 src/btrfs_encoded_write.c       | 226 ++++++++++++++++++++++++++++++++++++++
 src/feature.c                   |   4 +-
 src/vfs/idmapped-mounts.c       |   6 +-
 src/vfs/idmapped-mounts.h       |   2 +-
 src/vfs/tmpfs-idmapped-mounts.c |   6 +-
 src/vfs/utils.c                 |   4 +-
 src/vfs/utils.h                 |   6 +-
 src/vfs/vfstest.c               |   6 +-
 tests/btrfs/326                 |   7 +-
 tests/btrfs/328                 |  31 ++++++
 tests/btrfs/328.out             |   2 +
 tests/btrfs/333                 | 233 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/333.out             |   2 +
 21 files changed, 761 insertions(+), 26 deletions(-)
 create mode 100644 src/btrfs_encoded_read.c
 create mode 100644 src/btrfs_encoded_write.c
 create mode 100755 tests/btrfs/328
 create mode 100644 tests/btrfs/328.out
 create mode 100755 tests/btrfs/333
 create mode 100644 tests/btrfs/333.out

