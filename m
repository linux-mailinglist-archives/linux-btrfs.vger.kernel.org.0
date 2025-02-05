Return-Path: <linux-btrfs+bounces-11289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B099BA288DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790CF18894DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2B1519AB;
	Wed,  5 Feb 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJrcx16n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xEmbaaSr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8422CBC8;
	Wed,  5 Feb 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753638; cv=fail; b=MI3LehzdSWuwQTNm2rktI1GO4Pf3VulkE45wR0R/fqTpXx/R6Grl/VqGHWJgFVic/Eu8gpfLHp0dzbmmYKgAHYtoKKURteuNeITLN95auS4SxT8bPJNE4HvE4COs57MSvlOdLTnCsN4Zk/FvUg1bCr5yzI1vzQ/2fWY/A07IlX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753638; c=relaxed/simple;
	bh=Q9rrW+q4KX/w4MkHL6sIaQmY0x5uHgUn9fVT0vJSJbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rz4aT9kP7brLRQYRTb5wva2iCOfPbJPydJzA4d0MmtQ/OqSvk5NsoH+KDutD6CD7RdhVdbIpjz7GZjLkKC8qHgIypMqS4u5gxwQJ6drEkAhgJ8e+i0lA9XC8MkeGEvZa3E7J9QcjD6SgShBAAFqBPnVoJER84XKIlndvdorrP7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JJrcx16n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xEmbaaSr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51592cs5027043;
	Wed, 5 Feb 2025 11:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p2+63TV7WixzPwa3u93nSOibH+LYWxZvYG4NFgQaNvs=; b=
	JJrcx16ndHDFRYRtyFYWu+PDkJNz5+6lD7WRQ7ZkCAPv6ON9kz1oVRluBB3cC190
	PsBeHCGYK3YKPz5gS02UKPR96TgqyyICGhsoAQvFq6lYBdaRCqtI92xmgze1BVCe
	HJZ7K5lu5hmhz0ynw9w3YqhYb363Mn2zIBM51OOLSTp7fXw+biamcxS7xnAVwMQ0
	hFdvq+MbgGU/pfTXeolTEPt2W1A/uWwzEWomW0N9I0VIpEVBRmGh0THFSkJ56PtO
	vSM99gOp6+1+gqGYxmDVRiQs+ciokTAgWeZTMxfn8VrmONqu2adTjEPgKP9eUgK5
	2YxdBK1XcgLXECdlIduPtA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u88aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515AWh4a036203;
	Wed, 5 Feb 2025 11:07:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fnevch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JefmCdAsrCCuvJx3WUyFvS/Nbi9f/K8ds3nuOOfI8e3GikIqFioEQjEIUgxneImDbLdzzUk+CSRGoS3S5ozasp/YZjNoxPaSOnX8qBtSiVTKgv7dU7VrqidBYrxIXQckPiCRG82QMl4bI+/p6UbSSP/KuxdEpzd4EMwqqxFIxVPSQzCLy0La5iuiMf3oIMCc5PDktEkbmnRyZRldRu7f6ZcdZ65G9jL53m/zACp4q9c0vpPCZzE2sIdaKKnMe2KZBgt6ig1EJdYvxf+pHCSoB0zl10w8yl5aHEihXFIlyaOfqyXGCt5X/ohYfAjbO0W1bWaByAMZswhUv1HfT6svgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2+63TV7WixzPwa3u93nSOibH+LYWxZvYG4NFgQaNvs=;
 b=KbuXprtVqNFs5/GDEiZvr/0jz4gOssEP1pBqNJ7nnpLnwCbGoRBQn4NYf3E8b7TD5/BkRx2w3FXuBG1h2KbWOGKOTHiVKA/eUQxSQJkPVEYyrEjCXY2NqZEtmokTNibiB8iIcWvM/y9j9g35zWOjEu3zwZteujFMHDEFpnWQtuvZX8oJsOvVL5Nl44LhP8fZ4vPGC7LYfDueKHxnW1i7c9pxqxbbXfpC0v01fyLXmlQ6cufv3xzMHNHy8lWYbHLs6y64MaqIgCilqxjtxd7zYXU0vjEqNY5mm3WDMjO4Oxr+bCj9G1zy9BnZychqfjwW9uNdIPw3T6e1KQs82bwQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2+63TV7WixzPwa3u93nSOibH+LYWxZvYG4NFgQaNvs=;
 b=xEmbaaSrP9RYWzOBXqjBpVNhWcq4xVscNvHC5qJG/2AYBlJEH8BItSJwzzYhcDa2oEq4Z/Cs8mtPbKVse7bR0zemNnEuCz38HC1Mrkn2SU23DKsDHULYPj8uKHwWngvNorrD6f0hVsK0qpyA1Ap/jidoCfEGB6I5NjrrNysrm0M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6476.namprd10.prod.outlook.com (2603:10b6:806:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 11:07:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:07:10 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v2 4/5] fstests: btrfs: testcase for sysfs policy syntax verification
Date: Wed,  5 Feb 2025 19:06:39 +0800
Message-ID: <80dd9092f59cd423906b7812e2c14a752c50c05a.1738752716.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738752716.git.anand.jain@oracle.com>
References: <cover.1738752716.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3042cd75-4ab2-47b5-8172-08dd45d53c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2beSZ9jvgvA1TdJkEZpkCiskSy/i9arjR3DPnXJ4h3DXwS+VX/Xat1EsLFZ?=
 =?us-ascii?Q?cXx1Ari6KlrekYpL5W9FBQL6xL60dMmlDmSt5M0+43BhWn/SREGWhNF8i1vg?=
 =?us-ascii?Q?6qsB581lDSkBIf+zAaUdVNs0VDIYO88G5b1wCxNHN9C/g4bQbU+77l5TjLt3?=
 =?us-ascii?Q?9pYX8tYLnqCsENFH0XfdvvvJdhOpS9VgIMmyq3GzpkVSAJkul93PNj+pP9eu?=
 =?us-ascii?Q?8Wgp57Z4xDjfAwDAdTLrSepGg96YfRcGYbXTrJEKr6eTUOIB0I9vuYOMDq8s?=
 =?us-ascii?Q?1qkmsXq7+1/Hnn0atfHQKOHR4FNxFSI4/jvAexR/Fk1JcIU0BdoZ0YWU/+4k?=
 =?us-ascii?Q?+AGRcpu62pbYFSWkBhA1lQovYfOx7/k7eBAwu65poVNfzOo8XZ71nKgs8GaR?=
 =?us-ascii?Q?oTV2pwQHRaZHa9r9PQvKAm3H+n8tgUZ1UYHhFT3Z2YH+Mw+1TgkxAL3UFMwm?=
 =?us-ascii?Q?HeUKOsVXlVmm8iJlAicm9HL9wQP+5R0Pkm5xVYQlnEAntcgIutVJ0II38+GW?=
 =?us-ascii?Q?A+sWRn9x5oI+HXNFxnl/wdNDG4UekeKHB61FGvXCOgoFClXNOGa4KVhKwm+J?=
 =?us-ascii?Q?cpwGpuFOGCrG6zevlpFwwEawOX3Liy64/u02vMdBFCbYCjfUvtyREcLUYHZF?=
 =?us-ascii?Q?mLhrMgmhc3Tupo/CqCw842C/5iHeLwpe2W6VclsVY6v8Y1qLvDr7Et9Du/yE?=
 =?us-ascii?Q?78tSLNAXCTVWtb89QFKda9A13BOmkyr8Uq2dADWAAxo7fq6eKxQuPYIQk7FZ?=
 =?us-ascii?Q?uFjeGNliGkAZDa7TWwJdcQMzgP+XPVeDSBNXG+pKuJ9KLc4T/j8cCToOv/4T?=
 =?us-ascii?Q?Cp9hgjaPo4Dahw49ALzwGqPLDvwNsLmecVjawe8INY8QCvQEPI21wDq/p4e4?=
 =?us-ascii?Q?IQ0FmJu0Bcg/KIanZ6t3z8tr6MIVC5ZlGrvmMLpnMsMWCnqG6/jvCRMjV1Ev?=
 =?us-ascii?Q?ZYhj0cZMh6dIdh9c529JdsryJi22ALH7b4X2AyMFrnGCEfNHVR19kbmPMTWJ?=
 =?us-ascii?Q?F3/CHKHnkOTdc9KAGyChrapKYQkY10YsE8/0PmhkUfVpVFBC35Y2T1Wrl3S4?=
 =?us-ascii?Q?EexSlXr0NTGQQzTj/0YAdjgCFykHNySmGRTnCNqOzKpKY70muOIpl05jHdqh?=
 =?us-ascii?Q?Id+9HO8i2Q8V3jHpeTDW6J1AxJiMZvPmLAAq+BB60IMpgm23D8xuf0Hqz+8I?=
 =?us-ascii?Q?FZ1kxsdT1Sa12qx1aWtYjglkcMfesnmmXZhfGqADcLnB80KMnNWUcCPrgRz7?=
 =?us-ascii?Q?90CoeZoXVJkSnzQR7lYK0yq3njyIiArivhPZkE6j4/Vw/1WI6mYJIyF/NLnf?=
 =?us-ascii?Q?Zev4bNe31agYWWMP/9eYe3GrWnd5WjXYU0TW87+9z8zbv+UqJPG7gztN9b+C?=
 =?us-ascii?Q?VNkpt25h/8M1D89V1Cx2Cfnb8YXI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ta0t9VWbM7VAwyyWs8yjzwH2zdBeZGNLzQdJXZx1O4X8c2Tndij1JFf1juEt?=
 =?us-ascii?Q?1vW6HKPYlCF0d3kX/2/TlSfptp5Pz8LIoCXDZN9C5WtNfLCDyB+ohxFscmMx?=
 =?us-ascii?Q?J+mH0uUjTyAvsgMn0B+t0T81F8iAK458a+Fc3NbPQJg3EPYo3xChO+TwHuCy?=
 =?us-ascii?Q?qSj1VSjR8z9zbEjdHOiq5YoiyXezPYV7oilQ1z4UTUsa28atxQ6QYhkRB+vw?=
 =?us-ascii?Q?Ogorz822Vv+PSQCt7KawN/+H+x0HNiKbuOymoPReLf70jfphLACExMaeMxZf?=
 =?us-ascii?Q?z+fLRaicofl2t9x3aAhlzLhm3OgLqm3/ahI6oINT7EAE02IHITr5xUtxwjlr?=
 =?us-ascii?Q?E08VGTN0nha0qGYhrhfUA6w/BW8wQjj0VlDbX7M8RDgwLhNuQczPaa3+uU3H?=
 =?us-ascii?Q?5/TF7NAgSbUIToCqE8zbbdlPysxIpUJ3+Iuq4ywdz4V4/1Rkow2dPJC67g0K?=
 =?us-ascii?Q?+CXFO0I5zv6mYIspdUxyoRu8whWhN8DsgPZ+gmn5NOvcQjHl0Vq/H/6RIaLF?=
 =?us-ascii?Q?yAGrOETgsw3lweDOY8hNFNeTn8etP0p17WZ41xgOEymolw/Wjndmkcduu25F?=
 =?us-ascii?Q?Ydq6m490IdOfCiCAjrDUsve2eeM3cuGhVgAuL9OdDny20No6kEgeBULaDLwb?=
 =?us-ascii?Q?xhK1pn9xLix9jlOB8ssbdE7TqECNMWZITeawvOPibj+jr/mrp57e+KFe4BK8?=
 =?us-ascii?Q?2rBw+gKzqF3kamB1fzCjcukdZaHYFWdtmIvqt6tkAfkA9HdnFPny3h+OKRa7?=
 =?us-ascii?Q?8gJlxk9o+7tEj3R4sakegj8DyE2VueQDdjscemJDKlydfF0z4Zh/9XSR9oC3?=
 =?us-ascii?Q?JoNIs77YkypmrpzI2mpF0SfxETUwKwePBzHPZ+rgJkEYKAfuW7fXOmAAYylh?=
 =?us-ascii?Q?eV5G1+E3MT4mQtTXS/SzMirOZwfp1Zc/Z3Q8om/7NhJuIi3uDp798XOhizSx?=
 =?us-ascii?Q?T9gl2jHFHb6G+LOLZQkAZQElknv4w9e4d5I4EtKpvxRmWXurCftQNjHdKucJ?=
 =?us-ascii?Q?7PKhVcvsCKM3/0BH0uetuK3zFjobYKtuwWO00cUsOdFL0bt3Lx4HRq/pmzz2?=
 =?us-ascii?Q?nDVpiBYltpZ/KhrDH+1p2JvDGsT9EcWwNw8LL2KOHj9vbMLmsEoxVaiW0OGb?=
 =?us-ascii?Q?kcxA3yFm03WA76OiNYZNvJk0EIbAS5a3nXCwlDPLlg/PLa2IehQsDM+F4lPr?=
 =?us-ascii?Q?D8TLoWMAdTSw5r23YUjJzXmPgfQySGgokkSJOPbDmX3e62tT7TWy/+TVG5Yh?=
 =?us-ascii?Q?k3vhHzD3Wc1mIGuPKtF0eJYWjnMoo4dh3UEav9aPJ7zJQA61kN0sFFUNZgtM?=
 =?us-ascii?Q?PgvOaIdQZagpYK7+d907MTwpZoh1dxkdrYnqVsFvJseSf1J4U57jJ7ggAcd8?=
 =?us-ascii?Q?DPL64I90KabcQW5YJWPUeN/VknJOh4jC5ON5eXf8c6S8vNSb1fW4Ky/h8wnf?=
 =?us-ascii?Q?/b8/HzDSHknpnEaz6gfg9/aKkUSBM3jix1pWu5FIk5KULcqNSJ8cxF1NdKCI?=
 =?us-ascii?Q?6jJdk7qlUBDJq0egKkSB414tW+kd1VOHquhtCaWwGJx76KxCgah7RAl17OcO?=
 =?us-ascii?Q?44CDHEQpk8BOUGQD/5P1BU9N0oDgwAjPn0Ky3pCS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CIbUQzLHLytkpDIjgSe7hO/KAm/Xzvyn6sjY20yb3v0Vsi/g77Y5ayr4mEnOvyW8qZiMuE401DQnojH8mPvM+kpo9pjULueaxuA0u/8iYHukk+a/49ThQIUlE5QOfQBNnKsEOAsCKlOuw0CvaLHXr9hITfRfXW3TQZbK/ZiEGKMweRI8HRMaDDiMmh7OkRnUaOuDLuBw1ZbB4gpwAtGK3TO0zqHABpBeH3JHx+MpMtIHDerq7L1lJtWvduQoaGMrOAauucS+v6+F7WoTjyeTyGMQKn53IxAxqLPtZx1lo/5qhlwjUhC8fpgRZIL696OiwdiRWsQeBLeFOQtexQ+bBwvIiegTRUF/IRFjh9eJKkNMxNsJLi6Ws+VvQYHqU8odTx6WBVMDzy3fiAYjAd53/zFTeqlUDURxiowhZtTW7b2EO5hOkj9GWdhymdG3maq0sL2KyuYCN4Nb/S42RfWKKOmhW+RTo+PGwiOIleXmCYX2EZXrTYj04RhjrgTUpI4sjey9FmZ2IpG2vV+w/I7owy0kTrpLG5vk95u+QJ1h2cLkVWsABa22jmNPqNXlSZ5FVUd50Uv/sw7Px8eKEeAb3XHoVGgeRpdzp62uMHCgfzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3042cd75-4ab2-47b5-8172-08dd45d53c32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:07:09.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M85IiRvv6nmuytiPYB5AO2K+O1n/0+tPIkCIO4eLStS/OHjGOWpV5ICrnthJQ2qBA9xu8Wae7y9YCr+UgOlYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050089
X-Proofpoint-GUID: wMCTYwawXcAr9YxPekHTCgmncZNIXXfb
X-Proofpoint-ORIG-GUID: wMCTYwawXcAr9YxPekHTCgmncZNIXXfb

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/329     | 18 ++++++++++++++++++
 tests/btrfs/329.out | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..3b52d51bb477
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,18 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# Verify sysfs knob input syntax for read_policy round-robin
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/filter
+
+_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
+verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
+
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..eff7573adb6a
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,19 @@
+QA output created by 329
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
-- 
2.47.0


