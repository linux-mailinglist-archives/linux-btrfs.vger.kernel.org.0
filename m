Return-Path: <linux-btrfs+bounces-11743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3EA41EB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 13:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E311891FC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BAF24BBEC;
	Mon, 24 Feb 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gi8O6mZm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iGdCnQTM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B44248876;
	Mon, 24 Feb 2025 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399344; cv=fail; b=jnx5Yku4K2fjv11c73r4KZFlmjxQvLNYHVtqegCfEwjA2l51/k7YribBQn84g8u3em+oMsq8kjL7eyJwQjv/dhWDReO+ihUqKT51TMSX1Vlk6a1DFt40ym9+LwqjfPhdJ4SZwXmynb/o5fwpeWazydn9UdTXkhRrrvxL7/4zZNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399344; c=relaxed/simple;
	bh=fNuKCh6WtUzCLp27y0ujrtKd7EkJgvzROWHVAeecqdg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d2UZjd91LxuFEsSBve6yW4bbNAghYwOIJrSfUVGA4FpXGlBes0RmE+BIBV6bRcYeJ4s7l75S2VsJNWC8ajDhFcffEb5wPRWSzE9A6LozGfWWjaVfekkqsANCU0ir7PgdgrfeMB2f9Jzj0RRIgnGWvui3yty6irAyr7lD4NTqpso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gi8O6mZm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iGdCnQTM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMZDm010007;
	Mon, 24 Feb 2025 12:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=0GGli2ZhX6RVjQCS
	evmY2V7dNtU01jeryum8uP0TGk0=; b=gi8O6mZmNDMi+PGn3T/23e2mKePnVMAm
	DwtQKaTz7nPB3hFbJvyANHe6ay5lOskG43HKYuBACoAoFPWWXAHRrahLARuprRFm
	iLYZfqNNFuHWY4sdDLURvnN4cwkazh6UAeA61yawa1fpHxklm99Fn/Gj1Rh9Fmfv
	QeisgDMwzdj++p9UUv4GNIh5d7OQ7qFwx2Mewym+mru6YC+bwHrWn+izDVx6doyB
	8uSIadje8iEBbMiQ0QmqfLNnBMHBFveYynxUHSHCsCSTks2gNprbM8mXEMD0/KIW
	hO4sVybLzlXcWpXZsXybeQdTCDY2MnbYTFtbqyV3F2IFdbUqJ3HyaQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbjejq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OAFOhX010108;
	Mon, 24 Feb 2025 12:15:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517aep5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxW3smM4Yv7zvTCfFZsCiGnhA6VMufPgdSBalmlmWPpjErZVOQRV1J5u78YMcU9zJ7q4jagatrnoMz+a5MxG4QNtfuDTl3oNrGSw+I5AEnBpAlM+c0wlEo/EuXa6z1E+xkruWPUCN54ZjIP4NHKFPofkgDvI/gE54M/wB0y/GBLhiNkAeQmQkNrY6tGwMjX3DpoqjgYkbRkTh27fOk83bdZWzIlkF1NGQNs3WGaJ6jWTI67YD3Uw14FLejiNrpdODC79W9wj44bRbNRtmiOIFtcGcYe2pPtVPNj1x8bZcIVbqve79YrvSSz2P4jm6ScLtXuHdh8P9LXGAQgUe1DEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GGli2ZhX6RVjQCSevmY2V7dNtU01jeryum8uP0TGk0=;
 b=q6Kfm5Y2UcXlpY5PW8egF7UWHL5sagvaSzJwsO/l/BGDcHqohVcCw2n3dYl8weBRTMkZSp7NxSs5qvDrmaFFpfw6SVDatuNKHmPEEwx6fucJsttvmS8FMaQljen2raYEq7kwbD3/gJ0VFiSzC3LObtgxvVApB3Ks/4JdHYJauUnG8IO2V6eNTzL4/pyA13gZCY47BCGxXBHprjQk9coLvhdKb9X8hw5s34Gj5JZPRQIIruxEEy0wCm4OpQT1UsILcas8NiU32+h6DDOJItAj+TeXs4ZrvAhuk+l5QsyCRyaCPy30JKT2ad9BBtOgTKfcZM3iMQqqIsactmXUuy4guQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GGli2ZhX6RVjQCSevmY2V7dNtU01jeryum8uP0TGk0=;
 b=iGdCnQTMHhnC/yFrQYadUm6A8RRkz85mHVUIv2rpMjw36VnAiFm3916Cujg1IR1KB16o1xvRiJ3LwiNyvKGE+7AB7SiEbGtnWkM8x7V8rBUcCpg2jQTURR1XKuQBfvacNX3dVHIcQp9A2y3OIBtLT81poNFI+h/E8ZOTNoCbTu4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:15:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:15:18 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v3 0/5] fstests: btrfs: add test case to validate sysfs input arguments
Date: Mon, 24 Feb 2025 20:15:03 +0800
Message-ID: <cover.1740395948.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: d2eebc79-f2eb-419d-f80f-08dd54cce751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6LSV/cQbstKa4yUvFQf+YFUQYpoAt4YnET+Sx4x5zKnwuZ1rgRrbavoPwnT7?=
 =?us-ascii?Q?FVsu7Eh+Y7kLWGaPm6dTr5mS/KQ1mal5Oif6tEcaX/xhi5WuHGCkIO9ztpmS?=
 =?us-ascii?Q?QFr8ymugIR2nN1PkBeK1Th9Li+PFHhAi6QYifX8P8jKeFLGrJyfD5B0XrwGX?=
 =?us-ascii?Q?e/SqNdSaT4jV40cBDeg7FHSokwqWeelCUBe+IIkHDpL5OojQK+KWJ8QoabD4?=
 =?us-ascii?Q?McQ0QZqf34xtYXjVedvV36SCO6CezyOh2jT67Mr6Ftvfal6d3uQDJOQ92mYs?=
 =?us-ascii?Q?mFUr99kaGN4beECEF244mZHM/udexDNzBeTfLBq17D6ZibwMv0TupMq+k3u1?=
 =?us-ascii?Q?3JKgF0an1f0DpvJ4FefYrhEbjPx5v+NVOTWaoPtr4MzEc0B1zdInaVbdtwCg?=
 =?us-ascii?Q?m8BK97+U1ZMgm5uqu7JNyKFhnlvnOQje6ZFrlQRt1sWI+Ih2xLnr9I05IhXS?=
 =?us-ascii?Q?/0/AyJYhhp8zGt3GdSumvOmGLJN3ieNFQCIYZ5QGeSzzFFQJ6a0dsQ7Wfn5+?=
 =?us-ascii?Q?tCcLQfWC3ci/ZKvlwVG5Px21+pFk9t4I/OieykiqtTxkv+lTghffHKAhMHtt?=
 =?us-ascii?Q?W+5N9r2TM4MuVcXTLr5Mjx6WZr2+ei6y2W9ExIqV6qLJzBtXvLuXb1ub7GWO?=
 =?us-ascii?Q?AhdCuEnibiaNXfsHnt1660a43kUqp0U/yAKDXgSgXda/nlEQVHlTxPCTkWTp?=
 =?us-ascii?Q?/7LVMv0UQZmGTaZZ+1/nAtsmpowSN7FZtMr7sEUQqDXDfkhGxNNA6iV8XKTj?=
 =?us-ascii?Q?j1a1FQBA5x/vQjJXqIg2r7oBCi2SCPWGlFcqoB/oo1Mybo1bQKDRsr5bv0l4?=
 =?us-ascii?Q?O/JkVDlMM34QTDR7pXDQV5tG09c1KAcB5ED+e5vCa9z6W7wPB1PhDoTvk7q7?=
 =?us-ascii?Q?/a5PWrIrURmCXPNIxOLMzRtObAMP8rHT5l+UkPUINv+gA1cySRuCyq6ERZ47?=
 =?us-ascii?Q?gjcFG286nsV9OrWr+a1rxM5kV3JdwCJWQV1w64RxAlsjAljjQOZI8wbtThni?=
 =?us-ascii?Q?2RKBprHSNxllFvEjtyHgulvg16eeS6EnFHJonqoxEKti6757hVVV89Zewqfy?=
 =?us-ascii?Q?u0k8XTaSIn5A1ZQZhU3Ia3NujiNvQJ8pj0OcOJ9VuRHWODtK+LXwp368oXOc?=
 =?us-ascii?Q?3eXIJXZl0KeiHRQQtaun78VTGJA117eG9gzH7FFJDZMyvbKJlDSoPrwIRBGy?=
 =?us-ascii?Q?zB2rSBD6Y+nBmqmVXLRrY7sFbBowAHKg1ZWinKFsRmb7JTL4TqnPYvfyzD5f?=
 =?us-ascii?Q?zq2W3QdPf3QzNOEfpaI1aktY7ntEm0z6OAgFZmhI1qhuYu7B4IAqa+u2Adht?=
 =?us-ascii?Q?MFmv9i6KtN7rjp41xhxFqfakqL0vD2t+Ig7jLoj+3xoB4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4x83eSxzM4PJqzzkMs7EPMa58/OH6wO1mLGsYp2DQIhlk4/gRfoEGqRXVjh?=
 =?us-ascii?Q?BpSeGQw6ogcH9F+CtOOEt24mWPV0OiQpZvyUS39m4Jzo/ubozEdWxN0ovLSh?=
 =?us-ascii?Q?bDra1Csurh38qN8hkOutVrctmx8TvYlc54OyHRG61P96nI4eHCnVui38k+o+?=
 =?us-ascii?Q?oQt5imbOHz9xm+irHwYhsh94IU5jmz5N6uCNM3VcMhbTgpyew4Ji4Wn1ilyU?=
 =?us-ascii?Q?mYjh5J+/34LtjE6ziHZtRwPvV9B33aKBCxRP5gW3Iw7yRDEn0vxmyQZM+RdP?=
 =?us-ascii?Q?6F/mh5afrO9hN5r8DDwXmdI9voxuU3wy8g7/QoNrmdlPZeTgAZk18pp8NsVw?=
 =?us-ascii?Q?sV0G9uCMI+Ev7R3gpiC/YSkQmM2m/Vciqf7RTe9wx7GPxC2rBTp2vxzlcXkd?=
 =?us-ascii?Q?xn3naAKV5ZfS9HlDOdYbJwTx/ypQgw5ScJDxhIrSCutGzkzE67xgXeWo5ID/?=
 =?us-ascii?Q?pbnieSBIJCFj0ki0H4/UHDGmQv5dMCW6qnjGMFPIZyDdbd6BK0K8TEFj2Pqj?=
 =?us-ascii?Q?9kOd8S9SlZLpiYSpXpCiM3sZG25jkc+MukfNo7Ici6eEf4K/ZQ9OmnXAybly?=
 =?us-ascii?Q?vPpZ/lStG0HZ0fzpbJuqtoMItRC/Naf1GM0qNB9uo8aZbiPdh+Marso8pJfy?=
 =?us-ascii?Q?TDGKAaOrossK7il79kFsiKEjwKZQhn5LS1SuVlX8inYL6DhS7KmLvWZci1od?=
 =?us-ascii?Q?/ypWUz1ejkVwXKKXKCiYaPZrvcAZ/Eg2LzB7r4bK6ToBzbwogWd+QQz9K0wc?=
 =?us-ascii?Q?8ooMQ3J0BcFGLetW8WDMD8I5a7yjcSdHUf31f5jcX8DIeXF4YbNmTiiXknZE?=
 =?us-ascii?Q?qFbXS5Lv9/ytreOOmH4kg9BBn2xaDMCswvztubvHgJv4CdWhR8kwI6apGDmU?=
 =?us-ascii?Q?xnZKqQZaHfSBHXDiyxuLWllbHkZH2fMSHL66ZetLWAQB1Nu0uYtjzHQrqaq5?=
 =?us-ascii?Q?S88qO0gX25J9vx6eVnVwPA7NrUurKwOE1nqyP4TRneH4bj971ARq7Qc6F5mR?=
 =?us-ascii?Q?iIZt8edEbYXrH79CcsbwGPRGyepHRe2KvW+JIshgPvRu6y4lH6F1I4iBFxi8?=
 =?us-ascii?Q?IR94K95KSukk6Z3JmAFs60B9u53hp+Hp/o5QdUIoahwZdtIWA8VKwj+4e+eb?=
 =?us-ascii?Q?oMu6ND6mMBL8ySJ+zuJkfMKwjUkxrXWGoggYTu/mh/ARHB/TWAzVyAoHfWGm?=
 =?us-ascii?Q?hRF0xLX1LA1teeMKOu91HgQybUmz8lrG9qiNYdIzzYXnHmlR3TuUMPQ/VtEq?=
 =?us-ascii?Q?Z0I7eHmo6vuub71SEwnsxO1DwrIi5rpu9zYZe+1wioquXuhnYiJf0cPsTrwb?=
 =?us-ascii?Q?5j1XiHt42IdHMtKBv++K2a3zBIlcN12Fm34BJOyTKBjh0i7ta2upMmxSENkk?=
 =?us-ascii?Q?EU1XJ+MXSLr0Q/5I/lLL7LfXPDvMsXL8LtBfodpD8FG6QkCFKR7t8JzRAsn4?=
 =?us-ascii?Q?ImHMwQs90495ZnnWYplTStZFn9PuYlnsIhbzys+C8yoob00pbADDQcczbEFS?=
 =?us-ascii?Q?v09qU/B7uy4UuHyysRL/KFM4vSX5z+HZG6DucjIyDUwnUQP34A6VY0fZJpYV?=
 =?us-ascii?Q?bBsxTO6R8bNjpJPqlq6F35SbFJYyOI3hHe+TE1YX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+j2QzD8UOyHJL+gr0TxaPcBJYaclViZlOOBT0K6EXQuAIAYAkfNrXHhno9p4+oQN/XgHbwMX+lTdxPxPsTs7odZN/8iCHMvvT/gj3gB2zSoj3DTYTnaFJNQhPhZRXGOs+drQXPza22knQppQsCmS73BBPc6a/RqPkaSrapO2RkHgtKWaoVMt66LvNUsgHjBSEvd0+KM98Hl1+c6ZzMGJ2ow7LRH7KGRNKj97me9EW2ax18SgMBgQcOczH1afcTl+T/yRWgdUyUWg84ukXhBrXzIiSgjOIZTHvfjPjtfPsad55Asr8caqQqzSGwJ+VGd0TsulRkI8UbwAG6sQQOhGF9LVnikE/gyvf0Q72/fumWmpntcXDKQje0nrPD1yTQfJY+dKv2CNMda0qwBkPKl9T1qtSPG+0nlz3wThNoZ6w8TudFkRWpLH3oCCEHP4rY67G8CDCvQ9M/8gRtGe15eTit8av1Xjo/teyhtrY0FNMVOmy8Cn+B6GNHQcNqLscQJW6kdrOUildYWx5rbKbXj6IQwgmt/9HJrsgFx487DijLvELO9vHzqKAx8P44bYcHvFwNW+O4HACzfJbHPF60N3iBLsuSInlgYiurd/POu8K60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eebc79-f2eb-419d-f80f-08dd54cce751
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:15:18.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3+Ndw4JRSEyxjaxRAANaOEZfAgJ7dGRAzO0ybRXqtQbyvEXcbC7qaZVE7AVqINiiMFgp78eggnDu0Bh2qgJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=912 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240089
X-Proofpoint-ORIG-GUID: RtWbsOEk1IXoNkf47SqADRnyoTv-sgO8
X-Proofpoint-GUID: RtWbsOEk1IXoNkf47SqADRnyoTv-sgO8

v3:
Move sysfs functions from common/rc to common/sysfs
btrfs/329: use 4096 instead of 4k

v2:
https://lore.kernel.org/fstests/cover.1738752716.git.anand.jain@oracle.com/

v1:
https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/

Anand Jain (5):
  fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
  fstests: filter: helper for sysfs error filtering
  fstests: common/rc: add sysfs argument verification helpers
  fstests: btrfs: testcase for sysfs policy syntax verification
  fstests: btrfs: testcase for sysfs chunk_size attribute validation

 common/filter       |   9 +++
 common/rc           |   3 +-
 common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329     |  19 ++++++
 tests/btrfs/329.out |  19 ++++++
 tests/btrfs/334     |  19 ++++++
 tests/btrfs/334.out |  14 +++++
 7 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 common/sysfs
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

-- 
2.43.5


