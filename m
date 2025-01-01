Return-Path: <linux-btrfs+bounces-10669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109ED9FF4BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B313A280E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A891E231E;
	Wed,  1 Jan 2025 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5tG+FPH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F0pjC48P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC333EC
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755022; cv=fail; b=nCeUN7k+AILd/+YccvjwkduLrWI6mhewVSbZzbrVn1UirBBW9iapQRZwZaX4nHjjuO5kbmDhHxkJKbnjiCQQLf7L0XNe/sZGZe3KrDmkyRfGiApO12toTBXI2018VYyLO/7vyUnDzVzEzO8q3U5VUCw/o4xssFo0X2gqLjou2rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755022; c=relaxed/simple;
	bh=YgNrPCtYZl3L7nsi7ImrjN7UogCKrJj7MJ7wQLbfNQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAulZztCWMFQ/VLCYcj7oMnftHHMdJhNql1txScNuKneH9XfH43iyrCRDDbkr+5SC3jGSNFssNKr5aGC0jIph1t7rkfvrw5BjaVejLmMmnicou83c0AZT013z7EvmEtldzrYqmTsH8fZEPTBhJCe1X7oW9VF0yiROxbZL1/q/lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5tG+FPH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F0pjC48P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501Fl6Jq025760;
	Wed, 1 Jan 2025 18:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QToNs/4UR0QdsnKtbIGEhbf3j6vzpiJgGKQeN14RD5k=; b=
	m5tG+FPHJ9VrU9yqoHBhCaNPed311cj3hqd0Ty/X4vw214ur9eOc11W2wjLC40fG
	6jXmYHKE3xMr25ni4SoSFDzKgLxkBqpMuWN1+QgeQIfupSht1OTh6KxRiatf+nc0
	5BSzxZJObBo4w7xreh02KnNFOd4m9nUUOND0p5Rql3KuWtuzV3b+Ts1SA1SKx2g7
	kji1CHFcHKTj59/WlKe2Kxsf/Dll4T4Ak9btghha6TBgl5bPtANHa74afVzia0nq
	bvN1taLkB3LT8RuPx1xQMYWnxVkg092s78ska/zEAL2lymyNbWgAbp9BBNrogYe6
	h3U08DEIBvu39CqJPUzPZw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7x04f4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501DUmkc034097;
	Wed, 1 Jan 2025 18:10:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s7pe59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjvyIOFwwQ1xgdN3HtyXbE/ccwNQX7WuF+XpL3GASDHaTVpM6Q/LlJHmikUX72rTes8bOgZ/0iaoM83sjkqnSl7U1JcRQxMr9OE2H5IJUbHT0l+L2eUC0NC9A3hV3qIhBR6XunVPsisIjImiKurmkh79ve9anJZ6dA6W4NSdQ7ZdGenUb4WIIYnZvyflxPdo8D5dB0Jqrnxg15s2alUO9lT/kZCoYj9XDbtJX8iKw2LrlfdCKU1TtuOd/JBOUch6m9WXGROqUALctAgCqri7CfpNBl3NW+HedLAztd4FUmSVPCFknI5RxQhivUip7w4NKSA7wUQ83tlIPL94c0KUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QToNs/4UR0QdsnKtbIGEhbf3j6vzpiJgGKQeN14RD5k=;
 b=jxJc7aljAEhq36+Gppz0d9OOhdVJlVs3DTfRMMHOcGRw/4DiP8GqeGIf3a7wsCMXpewsYyVVYrjxh10S+NWixD58NSQUuqo+H7jstOAA5KcVi/s/Mg80H+Ijf0mscXSTZHoW/yefEB+q14+NsBmWV8z98Jb/ZD1L3EoYwXuzkrMvaDc1js6NXSn+iDCachw21tUiU3I7d4sCDp+puCaPhwN5P1lBvRCm4VcM9/DAkLeeYP82Pj8H4+Q21v6kfRbxuTaKF3RaVtX9J0slUSgXs4O8871n8Pq2/uSvnHRg/IBSGD6rHjR1WWA6HAWsrq7JnwRHskgitRIhBg9ZlOJaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QToNs/4UR0QdsnKtbIGEhbf3j6vzpiJgGKQeN14RD5k=;
 b=F0pjC48PGRfvSHg1e1RW5LfSxP+rzsbyIarZY8mIZxyKh5ZEGU6aAfVCLFZOPBwSYPRYjbRz2q0UZ1Uh9jiJuz+WOoyy8fTdPHzITx9lU5cxfavNoAwQ8GsfvnCpfx9Eh9IxheHmjorYu5TvwPcLyTwIZIKldbwkj+vrgZUIeRI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:10:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:10:02 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 07/10] btrfs: add RAID1 preferred read device
Date: Thu,  2 Jan 2025 02:06:36 +0800
Message-ID: <9b31f8f7142203dbdfe833fc87aa325dd74ff535.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: d550165e-80d1-431c-b212-08dd2a8f832c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KF3YdbVVg2sxOnfJGSJrP0V2dfSoxSsqSKWam17k681thv5VU4RbpsL02Sl8?=
 =?us-ascii?Q?+1ebGsd4vagvaDXf8BaIj/z5E+q6kEYLDQsmSIPMFhpASAHVv/6pMKGdjw1D?=
 =?us-ascii?Q?mzpr+hcMPJTmb1wVTggG1qswTKLpnSFfl1JL6uLj0Sc9BGCTZSYDMHX8Dh15?=
 =?us-ascii?Q?leJeH6i7CNxfwEpHWUnL0ZmaJr6OObIHekmeU04Fz0kyrU78ptdkKKAbS2zk?=
 =?us-ascii?Q?z5ALxXb2eTR7aDe+Nrm9q2PZ9HRxKQEKn+vzwAj87mzsH3PeNXPCfh2fJ76i?=
 =?us-ascii?Q?C0Y4mb4BlfDU2jttg9rkMdMCww/p8t0ih9BdH+Gl1SpoHpkube83iZBwGPip?=
 =?us-ascii?Q?YS6Qy8+NxrC83XGgA9AAEkO+fADdAW9HkSma7ecwYJmuDgGcojIflVBkUqXC?=
 =?us-ascii?Q?JSlYmXBIB8q9/2cxwwWhbYRF98cuOQoEtC5zXMg+Zjil8DjrWVMfjNIJ0MsV?=
 =?us-ascii?Q?L+pxxrYv5XoKDokZr7cdP79jN9u/1t0nivs8moTA+/WAoEJjANxJOld1QQj3?=
 =?us-ascii?Q?nW+N3LejlfPPu7x4DNkF2ahKHtaev2e1OFzAoizo1NDsnM82Lym3xtR0EqhT?=
 =?us-ascii?Q?Dj0UmIG4H1TR/tcTJ48cdaodkhBbJEsz1IYYFRQWTd7SMTGoR7jnpLl3r/+r?=
 =?us-ascii?Q?0ZDstYteNWFe2kZHu7+z0ABQvJSrZZwJNPAuELbh9W08ySwQ5ZOs/sfN+2BT?=
 =?us-ascii?Q?v+afxZ2UFB+y9YIqOv8zo7lHvo0kY6QWcBowaQrXqMOvZQHtgYbKmPCbNK9s?=
 =?us-ascii?Q?CnfvvJLgE4hXgrIydYOjjnoTcxOY0szeJezoJ+9ccrPSNKAV71GTNMw1wAL+?=
 =?us-ascii?Q?lXkUzgbNseEfD4sh70FZOoQHNNEILD3L+uNhoRH0h6UriaS2E6odzB7H8DuY?=
 =?us-ascii?Q?kbEiZWIZhBocwaD2LFky+mJcj3S3LnZLwSoSatnEMGwNV/6c8MCycNf/Q0/G?=
 =?us-ascii?Q?5EUiVGzis5fkzLRjqCeUq+yHT5yWCCblXCO7ZyccTCK8oZf4WgXKINpr8bFX?=
 =?us-ascii?Q?rT3ypjJoYhY1l5WzMvFcG+immxe7FYDEcgA5Tm6jS0ljF/MQmsNlB6LU5T3R?=
 =?us-ascii?Q?lpGfZDwuDbgMOlBJPuSe1rXmV7aNsLmB1bfwIBCVH7CtKqLgWe5miA94tDs1?=
 =?us-ascii?Q?IiXxoR9GH04iG1rzzV0vKV3amRyw8e4Ei2/4ll8HN1og3LYSSGbqlMdd40AP?=
 =?us-ascii?Q?BqQA2lkdui9gx8iZSiyNFiq2sZlW2OaPqCQB/QcMHMKJXk8AT89qfzdbG2cO?=
 =?us-ascii?Q?MmhEB4Ipw99UkOSB6PAeAVCni/HQR7X4p4cJwo9GskrFl7QPnouTDsUYsvaO?=
 =?us-ascii?Q?ydnBSeXe91egsLEpu4Z/WpwhRPI3JoCCfMMvFITenpuaEFWoO8Yls5ofgrH/?=
 =?us-ascii?Q?F9kFsPKSOwyO9nUu3H3cnqwgvSnb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2bW957n4btDrsrqaGS8O6HXtfzUkHOWukJxrO4uQp9gKSmNqhCKMX1HNiN/?=
 =?us-ascii?Q?hzngVtmj/PnqE09zAwEYCLm48vahbr1bd8/ToW/5OhMc3/eWrRdwG1urU/hp?=
 =?us-ascii?Q?SwDBhA6iC17VPiRtMmLf+Qy+rDgMLswM+KIwdIrATXC5MO5LLfvJVJaK2NV4?=
 =?us-ascii?Q?52xVrC1VjaVabJP2ikyu2c+pfCHt15+pIRt9xyecpnbHXWA/zdEvh0QcDqUr?=
 =?us-ascii?Q?y1EHShPwG9Sght/fdC9eadNqChQ0YRM1mOkD0SlpkeuyahG0y4+H2GCFDKYo?=
 =?us-ascii?Q?+W1QPm4xKZTu/Pgoy5vkpsFcU7gyu4JPzEGO+g5KHsBmC+uTx5M9P9Krwdoo?=
 =?us-ascii?Q?kPezhRSfCEi0V8g4CY7JqCedsqwUpO03Zf9Ob9XzmJG/ACnfUDoOY7/21Jb8?=
 =?us-ascii?Q?7Q96n7qOxBfQoq8IGnugOUb1kkpTuPO3KX/1FDwfG+ps/DMkWMg1fW5vrw2/?=
 =?us-ascii?Q?TbtIOJXOGu4M7XNW0qGxuCOJDTIxXC5JgGBQc6JHs6Q5+57j0UEdK7uf3J5M?=
 =?us-ascii?Q?yCyCfg99ozOMLK2XjOHsf3yINV54U+VxL6NsWAJnxB5qcZDOVbr2x93hjUPF?=
 =?us-ascii?Q?Ma1in/sJn9wY8RlHf+BtjRJ5v++RtkX0JJgJNlZiadLD68tWts5cBvQeMCTM?=
 =?us-ascii?Q?bLzQfbwwMqVLiw+9bmtgD1DuGjxxmFVJN1qCod46f1/dCKmFtbPyPmbv+d2R?=
 =?us-ascii?Q?vlWejcQnv8cR/A05RBJGyNUkINxGgTuIpAQ/MO5b3G+3vzsaYAJ//4JoGW8u?=
 =?us-ascii?Q?vhP+bKtRcXGgeMtj2g5mqmxLkwmnNlGP0y0XDi6bnencaRSSyZrArJo5WETQ?=
 =?us-ascii?Q?9sx138dSa0CYo3kpK3891eSL8kzwgbfUHp6Ct9i3y7yoA5LpBoNLhmclnBc0?=
 =?us-ascii?Q?eA1qsOWmgO4SiwIeGQZ86EOKEVJe5K/ydZ32eD+y5NSOzD2ZkZQZwk+N65XO?=
 =?us-ascii?Q?aOL0OE38udnHoVhuuSBMOFsrCrNbB6hlFVms7vMvJRCx8c7YEWg3wK/4h7QC?=
 =?us-ascii?Q?rM37ZHvn7t79CETEU5WyVGHpRyZLMO5iSqQzrGOPBIAuHO0E3XfW/IVyF2/K?=
 =?us-ascii?Q?VISrwKW5QXA103GSDaunH4lry772ho5BKXwolP1o+hfnEHmSfsfQ/iwBjv5x?=
 =?us-ascii?Q?hKWLZ0p658njQaRM5Pom6xIQKMw6pSfWyqOVkESisIEaXpj7AhH1H7faAyq2?=
 =?us-ascii?Q?v3FyFCwZWJ2lORFXlfphA1e5ViWeDd6iUA5lYDOJG/IC4n/r3GwGBzH6mk6k?=
 =?us-ascii?Q?OQEdb5Nj3jhaGK6GzbY9iHA/votZ0lOY2bLBwVsszc8pdYxmCTstLJSRuRzH?=
 =?us-ascii?Q?v+9Q2Y7e+vKKMCV/KQR7Nh/4Tf8b9YcbFYPZr6KfsCVs1FydzgY+fTnhkd5r?=
 =?us-ascii?Q?a/e/uHfvTmD3k5sRaeayIhgithpHo0NwNE2DOtLNf7GT60FAhyqTqWbc4ERc?=
 =?us-ascii?Q?anJ0+vDCS0ovMxdl102sxoeCwcR+HONmb4G5Gp6pmk9c6eoBFHyCKOM1HzAg?=
 =?us-ascii?Q?EWybK862cu8zj8OousIppvNGX1u6wlwTVUaTWdw3RezoDpMA9omLw7lkbEkB?=
 =?us-ascii?Q?i7ivPreLexe1pcNo8Lo5ffuvjjKdLMxQf+eqYR6U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gNW66SV29CZwsIJz5m6cR2rdZgB02rhmYvHyEpqay8r6Uf5LFxvGZfGl3fz/KP7yeHKX7CuLEhKNs4nsGyyRMj3ZMRVxkGtHIVy6zjG8z1fj5QP+JWw/5BUfcfBJSP5uHiZ7lJ6fajrNeyYfYkZiEJkX2JOcqFdw929bwOtyGIQOasDbl4x68jQI+KH6MuKhtO1/S2iNwoeQs7wxFd4OMRIxfg/lqjrRDSETGD7Z3oBOf/Y52LpNA1a7g3dEsxdatuuSDFGd9haVjrr1/FFd3EN7uTVdHmOYKg6FExruRkiM4IihC2jCYqS7Tdfq3+hXP+kOb2yDIy9mO00BZ88KCkA5FHrlG4JWhQldX9Y/ohj0awiqhSnVae1u+Xj+z06n0HEgXfDeZiDZ6pF3tTDMcXWK4NCAAnnOfz67tovb/ZPV/OMmW202Kh8qIJrGCow8KuT0YLVYJAdhVZM/lQrHCKrqnXbsztJJYrVLgS+oxDEENkW335yleg//obi9uKrLH3foCRGmB3bVH/K3WLE9Kd10wDjht5LTTJe+bpjgRlg82KEJV+FxQXkjqjiex/i+L3H11GLDDJI5ZXZzq0AWvt62axytQmeaELG8p620NJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d550165e-80d1-431c-b212-08dd2a8f832c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:10:02.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRnGhv5NrYse3hFYm8EZhdT3NwrXhxqt7YD+p9dI4OxYUhZbePHt9Zyj8HAln16us8PUFllxsbxsqoFpEsoxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-ORIG-GUID: 8mamMy91bMM2wjBdHrmlyV19qnsjC7wj
X-Proofpoint-GUID: 8mamMy91bMM2wjBdHrmlyV19qnsjC7wj

When there's stale data on a mirrored device, this feature lets you choose
which device to read from. Mainly used for testing.

echo "devid:<devid-value>" > /sys/fs/btrfs/<UUID>/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 33 ++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 21 +++++++++++++++++++++
 fs/btrfs/volumes.h |  5 +++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 70f89d1adfbc..eb23f29995e4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1309,6 +1309,7 @@ static const char *btrfs_read_policy_name[] = {
 	"pid",
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	"round-robin",
+	"devid",
 #endif
 };
 
@@ -1356,8 +1357,11 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 		if (i == BTRFS_READ_POLICY_RR)
 			ret += sysfs_emit_at(buf, ret, ":%d",
 				 READ_ONCE(fs_devices->rr_min_contiguous_read));
-#endif
 
+		if (i == BTRFS_READ_POLICY_DEVID)
+			ret += sysfs_emit_at(buf, ret, ":%llu",
+					     READ_ONCE(fs_devices->read_devid));
+#endif
 		if (i == policy)
 			ret += sysfs_emit_at(buf, ret, "]");
 	}
@@ -1414,6 +1418,33 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 
 		return len;
 	}
+
+	if (index == BTRFS_READ_POLICY_DEVID) {
+
+		if (value != -1) {
+			BTRFS_DEV_LOOKUP_ARGS(args);
+
+			/* Validate input devid */
+			args.devid = value;
+			if (btrfs_find_device(fs_devices, &args) == NULL)
+				return -EINVAL;
+		} else {
+			/* Set default devid to the devid of the latest device */
+			value = fs_devices->latest_dev->devid;
+		}
+
+		if (index != READ_ONCE(fs_devices->read_policy) ||
+		    (value != READ_ONCE(fs_devices->read_devid))) {
+			WRITE_ONCE(fs_devices->read_policy, index);
+			WRITE_ONCE(fs_devices->read_devid, value);
+
+			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%llu'",
+				   btrfs_read_policy_name[index], value);
+
+		}
+
+		return len;
+	}
 #endif
 	if (index != READ_ONCE(fs_devices->read_policy)) {
 		WRITE_ONCE(fs_devices->read_policy, index);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ab2e970dd6bf..e8cccfad6ad3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1336,6 +1336,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
+	fs_devices->read_devid = latest_dev->devid;
 #endif
 
 	return 0;
@@ -5969,6 +5970,23 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 }
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_read_preferred(struct btrfs_chunk_map *map, int first,
+				int num_stripe)
+{
+	int last = first + num_stripe;
+	int stripe_index;
+
+	for (stripe_index = first; stripe_index < last; stripe_index++) {
+		struct btrfs_device *device = map->stripes[stripe_index].dev;
+
+		if (device->devid == READ_ONCE(device->fs_devices->read_devid))
+			return stripe_index;
+	}
+
+	/* If no read-preferred device, use first stripe */
+	return first;
+}
+
 struct stripe_mirror {
 	u64 devid;
 	int num;
@@ -6065,6 +6083,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_RR:
 		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVID:
+		preferred_mirror = btrfs_read_preferred(map, first, num_stripes);
+		break;
 #endif
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5728b8717317..18521aebc484 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -309,6 +309,8 @@ enum btrfs_read_policy {
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Balancing raid1 reads across all striped devices (round-robin) */
 	BTRFS_READ_POLICY_RR,
+	/* Read from the specific device */
+	BTRFS_READ_POLICY_DEVID,
 #endif
 	BTRFS_NR_READ_POLICY,
 };
@@ -446,6 +448,9 @@ struct btrfs_fs_devices {
 	/* Min contiguous reads before switching to next device. */
 	int rr_min_contiguous_read;
 
+	/* Device to be used for reading in case of RAID1. */
+	u64 read_devid;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.47.0


