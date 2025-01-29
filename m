Return-Path: <linux-btrfs+bounces-11147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC60AA22016
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53BA168A17
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD251DE2AD;
	Wed, 29 Jan 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DkWYnevP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ATBW1ayE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5D1DDC29;
	Wed, 29 Jan 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164030; cv=fail; b=G8aBpwkxHhf5OEVd8tP6wiFA/JUvdyIlc6pOba+nRxvyz/5+eAabCTBG37gHfvGBN5US1Rd0SSllABy2a8CkYU0zuEdTfukDDutInpZKHXRwD933Ax3feYwbNeD2xfiHRSFJUAGu1hFeH57kQMVwxoreLXOzpK/wgV64Bo0sKWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164030; c=relaxed/simple;
	bh=wNgnh1TlVlfK8YTAThtyuwABLpVhzodaP1+aGxKdrH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBGEs0J691S65WEMBLbYYQbqlN8AnLoCOf23cXJ1xIVVJ5s4VEmMRWDpL+ASJuRvqPjA8LitIjSqFdlwxXuMKrCBaan0M/QZfiLCpeBu2hqD6ha/tGZt8GafDJHkUX14nnvYFuOnvU3g8JtUwYTAFWNqi+P9qj38pUIpgmNA/Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DkWYnevP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ATBW1ayE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFGwja016386;
	Wed, 29 Jan 2025 15:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Zp/feMNjLPWmsSRM7r0W2CGtz48S0m33rjG+bqIW/kA=; b=
	DkWYnevPrd6LFWouo3yvlJBERmuBML/BgOh5gHm4RjgY+VlGFHDJO4iOWJ++6fv4
	AZNxpJnkhrxDvPLUOn6+mhm8BNC8s6Yyx8d98ZflKMwwTOAhLc6WUHRb4sIVrZ8O
	K2eiNmNt1aH51L63P5P2bvv6rVNM90/HUijoZIgN1sfN1zzwoIVG/BAle/3JygLj
	2S/9IxlJrk1J9lpLJGdgB/yAegbchURirA2h8VmAfVeiCaMgknoJq2aTA5P59Sbf
	haAR83Tkhsp0gn13QOSA/b3v+Wc15qg2D1yJLwXwFkkYkxEBFnjzsGK9nY8byhql
	d238KPgHjzXGTnZVAbymQg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmf80c4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TE5xCq021979;
	Wed, 29 Jan 2025 15:20:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9vuwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYEX5OkvFtKpTag9fU3wjbFUJO96oyl8iShaOAIlbObAdr4byTN3dk0yLFo7f8+WBE7r88ws7j2w2vNLHGqCSNx01otykz/fH0ZKOZLr7FAeJkRREbA1dSAJMBgKIxwlmpd7fZ23u+FUY+ffyeGGVvGP/JubKhtgepre8DXuAsmHKB0HiWQ6UA6IOP4HRmXsuj6I/f9b0x/SbFvXEIauCXS+grNkd644O5Z5mr4kkbkRSL3Q2WKV4Dn16uplyK9rzyswG+/GJnR9ka+zCuzpmSqA9G7E7uPLMn8ix+0hzmp+QmgIqLcGiulMGnKnjGEREvcXDWHikRjXhZ7t9uFlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zp/feMNjLPWmsSRM7r0W2CGtz48S0m33rjG+bqIW/kA=;
 b=mY90aLFSuGoAY1ytiltQvJoeWV9JKoQLjfcWZc4rIu+Xvi6rp/6OEsPKqJduRASFYO60xMEClh1zPy96Ar+CjJ2wxom3u4GcIjVXgoYLZusjcmBcqWGephY9OSOjpa/CCc6ChhLC0ss0zKdBX9mBuPlm2lCxS/u7LX1fdNgETsR1g9zq/ItZMTLNY6pqEhtEZlMshlI5cfMCn1NaOINBpfUgc4J6Rj7qIkHgvyP9Gi7QDXk3nMLp5oQWGoQF+mO6GfB+4CU5E39RI9yng6r5SLYsiYCE/Tw/dMUkKKSsw4J6AM3dK3JWKvc9ryQQP4NFT3+sFitEgv+6x6wz5xH/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp/feMNjLPWmsSRM7r0W2CGtz48S0m33rjG+bqIW/kA=;
 b=ATBW1ayEo/m5aM8yISbcl1d/Kd0pw9JIEVLUItv/bOzXr0QQXSMcbOhCaCsPnNQa/JLpftjPZsa1Li2PR4pgZpClyXWGIFWNaNl8Iw5OmM5tCNJb+r6gn6h+UoaLRf6yquJUtilRuWQvN8EJWr3PZRjYrwGindmIl2C+Xfefw9o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 29 Jan
 2025 15:20:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:20:23 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] fstests: filter: helpers for sysfs error filtering
Date: Wed, 29 Jan 2025 23:19:53 +0800
Message-ID: <274f52cbb8de26703ddad1672bcf9a8dd0a540a6.1738161075.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738161075.git.anand.jain@oracle.com>
References: <cover.1738161075.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: e06d3df2-3a36-4923-b9fe-08dd40787386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wtOkIXRrBj+bxiYyjKlf1etOQPWPRFTnt07Ry+zmSscBOGgwkWBir1vb+Nkx?=
 =?us-ascii?Q?Lcwd7O8UJGaf9AEXW8ZrV+5wkx90VtuusNS7HEq1Xv+/OlsXDpMzcJ6/scb5?=
 =?us-ascii?Q?ofiJLUlh6LVOyOLN9Z1EZuXF5LtLhi0IP/Kv1abuHxFopFiv5UqoosbR0DGx?=
 =?us-ascii?Q?uAUtf27q1kxzrgaxg+j5oFyHbr651oVHwCgEVRIG5XPW+gA9TYZbW+fkGfnV?=
 =?us-ascii?Q?XzHcbV3mUFwIkzP3OCphExfzW2QYYcOII9wu6upePYIhB9ipzhD2lrFY8dEV?=
 =?us-ascii?Q?5jt4ktMsyCzF+74+t8eAadw+cxq+DnW3vKCp0K5mB4Pru3u0/DrXDJQwq33i?=
 =?us-ascii?Q?doEAy7pDyKw5rpsQBZvSsi9bBAcsP4lj+Ye5iDxgWHbde/gxdVc0kUHdPOLE?=
 =?us-ascii?Q?YFNUiLv12iNqCwfNE4em4MOsM2ppOw1Te8AJv2LzhulpDFuBMqT5HOqySLtD?=
 =?us-ascii?Q?Sy9x0xsfcxpdGxh6aCQXwkWjlGM/G0cRG5g2sFikk111KC+59Cc9NR6a07tK?=
 =?us-ascii?Q?KMJxxEg/LGqagn5Cl+2FsMlISQlUPGlKpVA6/6vsczednL7J/UpHP/0WrJ01?=
 =?us-ascii?Q?r2pQRC+G9W8ij/o09dv+Ry55HvogF6T7QikfrK5ryP5otimbid5qkvFKuioX?=
 =?us-ascii?Q?2dutedWC7BQ+GT3dqQQ6bMLyzvCCMt48otasnUliFiRUr+jjUedlbzD/cGdt?=
 =?us-ascii?Q?VJdklT2agPt6S/oB//vpmKHalF2AFqihu68/v3pdv+Rdvuwl+Nw1OkSbrUqA?=
 =?us-ascii?Q?DgnZkX4iTdoJBb1CaIH5PTXT6sY4wPxNacUNOH5Hkbg41PsGShPSqfmXsGsU?=
 =?us-ascii?Q?E1Qqdl0GogWLBVj2BHQ9rd2r0kUH+z+SGez2zVqgn22evuMVETOf7NDVqLcy?=
 =?us-ascii?Q?0W986yX+MJX8B9TZV2msP64C1JW4tAi0lVhYsl8SuODzNzpKadgDDb0d5U8A?=
 =?us-ascii?Q?kpjSKvJ9tB9jVPGsUi8HCh8tfakS5atk3ufLH5hdaMaU9rPzu7yjZcHHRyZM?=
 =?us-ascii?Q?KKHMzkiCAJ3iU35cqs6nIOM+pYy6P0KGHu/LLOVgavfiFEK1otZVejxABzo8?=
 =?us-ascii?Q?Q1znYIAY8kCWvru3WGVjGpajg2E21nlVHT01ahDDLjAotAHwECstFOe94Oyz?=
 =?us-ascii?Q?qRYQV38cAzr3Bmp4KsjvaPhBD+kCn09SXV91Pu1kZoUfUqUuOjuskaPr/lii?=
 =?us-ascii?Q?GxRC9kSk9jfg3IWFm+eDHGgW22V6s/Nh/vJRJkNisisX6ZfikmbrzbegdjsV?=
 =?us-ascii?Q?6yxVkS5Meh6uQck2Bo0DEmNmWZAdxqHyZhHXfC2D19GqrZKI9U59A9WeAXWk?=
 =?us-ascii?Q?+u6WMQIJG+SLsyI3JksQjvmimRapPmmavkotPNj4FtEo1XpWbTDrcGU8iBXt?=
 =?us-ascii?Q?Ev0v2mir24aJODa7LJ42ILT6PVEu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UlbTYa/nSspZuLIuc8XQ/KfmTzIh15VNFcygfsiLGC/OgsskxQXVIIOi2o43?=
 =?us-ascii?Q?nsf/1ndCrzDENHN07i9FMfmt2ZDCyAJ0DCFnkmOXvOcgJrU5N77l/XcmrYr1?=
 =?us-ascii?Q?4jWkhScSY+TficxYWeKS7uvUGJ7mYdWe6NYt7wv0/RhCIL9j17vomZXGG52s?=
 =?us-ascii?Q?yoTR11eE13kzvoMed9aS+xCZsCDSmyU7jAr6ne5/OTIMe87MuvM+FBi7oX8W?=
 =?us-ascii?Q?zAC6Q1anxe+/upy7l0SirYOR5844DaUhsjfqaaPPmcQ3Q2cKF/AngVbqw4dh?=
 =?us-ascii?Q?gQXDnl8eAyRLnY0tAjmbEZwmfIE1HHjLwGxChcm4pdkJa8yEPQmzW8UL5fe6?=
 =?us-ascii?Q?la6nIZoYejEyirYdmmxXSYE2Wu0fyVBBPEE2MHIGLe35eNNmFjPWzHfO9ZsH?=
 =?us-ascii?Q?CyMSE1uC4q2UkUEHNPDkjo3KeUJo1LMe017N7GvCPlX6ruTTDV/1VXCyX3w1?=
 =?us-ascii?Q?ArfphIijqk/7mgMuFwweTzzusHGvB5EU6zze3irhl1R7os02AXYoM+WLBVv0?=
 =?us-ascii?Q?MUPPiFpnKWIgOzpSPUV00i2yI3K1VCRpn1dOKFzR+A7BYB8tph9PBy4pPYX9?=
 =?us-ascii?Q?6dFuBmpMeB0UTNbNmt9YiKjbRGH0Et6W9DtslkE3hqQ8y97ZEsaqnXaYGRpk?=
 =?us-ascii?Q?3/DFfTVHVVVTf3fhwa+yihtOpx2pTjbYUAq0YV8fjRrDhmbzFwn2FE7ma78H?=
 =?us-ascii?Q?e1nKAIgKsooe4FCsGFLoOEiZIbOzcs4v/MkpFN6CDAAiSGTcX6fBjXXlMdzV?=
 =?us-ascii?Q?7+TES0OIL+0zBZbs062Q1Wqpv39pbQLP4OwhkZBHj0g4qUCfzRHXW4sdCfb4?=
 =?us-ascii?Q?xVirivPKC7oHnNE0TCwkRqSoK9Fd4hszPCnodZ21WC7dHwTe7cwcfU2Be/53?=
 =?us-ascii?Q?wXVm70CRKcLwzJB7iwqRr1HXv0YEKahjFEBGqSEcSu1nmEC+FWjK+fCCTt/W?=
 =?us-ascii?Q?92UivF6We4R17tIsNHQCF5dZzX6GS7aBVCbgBi7HpJOuaGGHuw6jadvCNrSY?=
 =?us-ascii?Q?3ivZFvcl7dNPfw2F2CQdSBzqhFCmFTielSsaEUzT4mDEzca8ypXHFzns5nlt?=
 =?us-ascii?Q?tvhc/ATfm7zv2iRzdkWPMzDXFmB/0kYTme93UdFMkIsmavIh3SDhM7T5hjTp?=
 =?us-ascii?Q?9R0pRaAbC8r52YW7WfiNfn4AQPcqg+4MFfVdE5FzWvsTuoM1Kf1TKH37cPur?=
 =?us-ascii?Q?chaUL4OYyy7+KA/pnXZjKHVkLVSnYaKl52jXSQ3TI7zlnPuqqY7PqHZT6hKa?=
 =?us-ascii?Q?tgtRTro+mXS7l9+Fz5V3VLDVledf5xYQQAm7T1ySoqokNEcEwViRkDopCypm?=
 =?us-ascii?Q?fJ8ELtKXdpLzpvk0GE5x637dM8BMhu49SyjbCGQRaNYRYQxdKr0Q0Q5ggple?=
 =?us-ascii?Q?2w2/yj/EdhgGJg7r5Vd6BpDgSRa6UnAZcsGgxgxBwNSvDqwNZMzbFNOKWO0T?=
 =?us-ascii?Q?K9PAjcaUnrQUBrq+qJqcT5TaYWLQttyzkVayQz8Ep4ibODuyuTtCyk284Wd0?=
 =?us-ascii?Q?uELfIXmqgJoaj9eWxDPExd3A9CVNM1Wb4wa0RZfGtObnRP21XQh1MpleQAfJ?=
 =?us-ascii?Q?MB0W9HfF7euHuk7qQcJFGQPJ077atBVqPgLe7OXh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1nL5NF07b3QVf2ikJ3psDBntrlUy8e1N8Lb5K1lL1pVQ0UdftVr9yWEdt9YYuBVTlo/tgm5RINJ8HsN8Pca36Qvuu+LZgHKoVUwsyuYNCF/fkNjvdJXTphgCeb7FtnUFh3+lsafpy7jHeix5GGjWUrw9HUaufpLZnVmU56nQ7rp8kh0AjAhBuYncq64NqN8EQgCswksx3PTJKI9Mvp2BxiocmTKylhcWleGWd8gwEfTc3OpX/WZv8T/EhlCHjZFCzUD5nC1unw3ebG+vmDIOf/v1ncVGO+iy72mJex36iEOAD5DoFaRH3q2305pXG0tQ++iKNAs2O6qHsi065hVGJi93wT9XUO31qJ+rvUUtjG1Zyy/smKHb55EahEsRhSmTlX0AwybP7VSd9izbFG2turu67No4ud69I5fOIguvfgIpzPNrbZUjD/GkC1xsyCQhBrnnICLF7qUseP25xL31jNMfAQe9vU47v5PJwA5TkoM0Z6CFMxKJdZW6fJ6xQTya6wfrpnH4zBG8ACHnVoLIvyPmoi2D0V2rTGEjHHQI5xKy9cDHDyXc4ZmJEPPyDtpSk6hW8KW86sdZglqAxLVT3cVrijCxdFI0ctBUekAYU38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d3df2-3a36-4923-b9fe-08dd40787386
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:20:23.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xoixplyC4rB69QxRqSWSVJG/TVvlRui2qGlNuOv5oIr6hsUj9sl4ToNLQNOiBdo8N8kr3VvqNWE9tg8CVmIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501290123
X-Proofpoint-GUID: yE1jURJKO52G417eCBHoEKGY_6xh1w8C
X-Proofpoint-ORIG-GUID: yE1jURJKO52G417eCBHoEKGY_6xh1w8C

Added filter helpers to handle sysfs write errors, to ensure the sysfs
write command fails with an "invalid argument" error.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/common/filter b/common/filter
index 7e02ded377cc..30bb9161d620 100644
--- a/common/filter
+++ b/common/filter
@@ -671,5 +671,29 @@ _filter_flakey_EIO()
 	sed -e "s#.*: Input\/output error#$message#"
 }
 
+# Filters
+#      +./common/rc: line 5085: echo: write error: Invalid argument
+# to
+# 	Invalid argument
+_filter_sysfs_error()
+{
+	sed 's/.*: \(.*\)$/\1/'
+}
+
+_expect_error_invalid_argument()
+{
+	local line
+
+	read -r line || {
+		echo "ERROR: Expected 'Invalid argument' but got no input" >&2
+		return 1
+	}
+
+	if [[ $line != *"Invalid argument"* ]]; then
+		echo "ERROR: Expected 'Invalid argument' but got: $line" >&2
+		return 1
+	fi
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.47.0


