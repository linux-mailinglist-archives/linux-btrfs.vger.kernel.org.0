Return-Path: <linux-btrfs+bounces-10672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2128F9FF4BD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58B33A2734
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AA1E2852;
	Wed,  1 Jan 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PYahCY59";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D0XBF4LD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896E1E25FF
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755042; cv=fail; b=nzwFKVgtDA6bZ15qyy7zA302uT2gBXoGY79xhQ8pZBaZRjtQ/W6rhqcEqQX3Spab157RwSB+E+f5GcBH+oMicj/9Bujg8G4bsXhDKfAby44is7G+PxL2h2rL6Ig/leSt9sezabP9JVpNVGPF5aHP3DiYlFxYm7RnNR044sbHrZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755042; c=relaxed/simple;
	bh=zHnC40sdg/DCZq/YO9ravc+0wue2FPI4sG7i4zMAG9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWzmc3U9V5uKtCVEnMYeRS+HhsDDhN8dFSxfRrpRndo/+JWwkedzKLA3jSTvba1DMO6mFRWYgZjhuKLcwIEMheDZO+2QvokO4As4kRUaue5LfLf/TCrhYKAE+XrrGgFz4DiVKtzEb06YFgGQ9Gh2wFByPzsNfy1R0Rkv+Edp5jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PYahCY59; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D0XBF4LD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501FloQu027566;
	Wed, 1 Jan 2025 18:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SW02jPUrx5fbRPrObS/OhhI/OKc6GkMfhEpB3xrJY4w=; b=
	PYahCY59WUTEqIOtRGudWCHZFpoaGNaQ5/6uUKsfB+oK7+knGZrBZnld28uFmh/d
	tSA4yaNNWlOgvwSIXf2b9xPJLqhTsY0LLvbIL7Fwq0oejYlx5mxy4SaYuFndQeqq
	d/ngsEay/pUSTb2nubSd2/1je7W1+zIn/d+EdrpF08plN4vld31UvCJAEFTqj04C
	6ln5Xv/4MlPHH9gpujKNLK//KB19lZ/oRAIh83ty/KB62BYl59tbS75Ei4XyzQkb
	umk/yir+djktIlA3JfsqQhNXI0xWqRLre6Kwp8LhvXs9mBLfGUTfm+5a1hNFZaYX
	Q7Zq1ZzlKyaMrP21v7UKlQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9chcggt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501I8f7o008823;
	Wed, 1 Jan 2025 18:10:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s7wvmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke4oeRboxrCtZmPuUNtPcY5iaUzOyIZJ2h9o/MYRDQlxnoR5jMQDOiTAUK1IcbZcvh+SaWo73AQNojThsIMhbJDCnd0xasFRQ85vQ2Y2YrX5sZ2Jz3N8UxmxI0XbHrCxRUvDBsPQJwwwIO7wLo7Rg6h2td0x2k+YtbzF86JtrFYJ3ypM8DweLaTqy+3VoKcwl9VWxp+H2AvhJ0STFxZco+YBMMlr0qtc18DcOwOro7+GKQsmUaAnrMOhrNWCTA4MultjYpGtN5ytqG402PJSaCmYr5bMKT6cX3dDs5+aF7o1rjuyti+S7Lzg8tXpih4qeawCzOlvYzGv+Lrw6CfTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW02jPUrx5fbRPrObS/OhhI/OKc6GkMfhEpB3xrJY4w=;
 b=qkcgz0lsKLbKm6JHzmXLELG29zC2hyehvqZoRmv2KQrJJXZKUk6ltY2NpuuMEB9KTsRmzzZSoh2FA+ore5SV653nacu6xVcal4cjT8CBkeSvcbewPzVPqtnkgpPI4DbMkgtUsJYEvgaKvZ79zSmNDGC8n6T7Uv7abNEnTV3mzWBU3z42mDtnyAmkQte66zM4E5VcF5p8EqW2uiQCv5G1bAJ/2/7AsKvYFenEUld8LgMMzqa+Kq0KMIHMczxaC/3jinSKkRN7RUv/kP7OIMJuFxTdUBE4fZZa0qcXd6MibBM3LTA2K6IpJQx9ntQ9U9ew9sC9zpz0nKjwsX1JaQB/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW02jPUrx5fbRPrObS/OhhI/OKc6GkMfhEpB3xrJY4w=;
 b=D0XBF4LDopUPBLhPDUIm9y9z6FAIoMPZdlKlspzSXmdvViPiWbiwIVsTzOAHcUGW9grKdK1tEOLKL/L58p1iEwr3PiXtL8TBsDLyG/snBK9LBDMRspBPVSZYdQ3hqQITJeoo907OFen39aJQU38/0HbphpMeMyDIVuOS87b8BhI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:10:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:10:24 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 10/10] btrfs: modload to print RAID1 balancing status
Date: Thu,  2 Jan 2025 02:06:39 +0800
Message-ID: <247ada1a8d2d67be37916933ffa97ccafe96853c.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: a2072269-8cd3-4763-0699-08dd2a8f8ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YnLcsbHaVqCKBNUWh2DkMrZVNe/PP3vJ2UF4wSjWZxrgb9hlLe1PuoqSkC+Z?=
 =?us-ascii?Q?gVQi2q6NglG+xNm3TUU9M/FAEy0Y9n91UdHQkvYCErh6Q5Fy2UXt4KRMJCK1?=
 =?us-ascii?Q?uFQwJTjfdswVc3nCUuvlEKDMh1irR2wjECoq7IUBqat0+DSLmimH9mTkrX9b?=
 =?us-ascii?Q?MA0eWaCbiZpAhoIpw3rYRGogLZMux1u9UWmxsSepk8ZWTu+2azPtnlCnKbs4?=
 =?us-ascii?Q?F4HLjDKozXmWrkV+M3kqBKLDmuz0QGQZH0LkmgQDF4rCZU4tw18f6vw4/TRf?=
 =?us-ascii?Q?LuYYY1keyEA72Uafh0YoHZXpo7Zx2CeWgaBmlWE3ZBgSImCeec3xXHJ4s+K/?=
 =?us-ascii?Q?abeBs0zkKc62QFMxSxnF/A4RRDChEPLU+6ASGqI/8GrV63f56Oa4E4Nh2u5q?=
 =?us-ascii?Q?Zp4sEiNxyYRu/6HFcNPo36iei3dnYdVb6L836mi3EoKVPBrNASgKt+sNfttr?=
 =?us-ascii?Q?saf2+MMrr5m8fuQBboCTjLj1OITHm/xRaO2ndY9fOVpL1d71BkznfcnZ7+4y?=
 =?us-ascii?Q?NNeeK4zvDXqJduCYBlrvhVT6qCpr0W8z9DrnLnj69OdYx9Rlahi/SDp8R2A4?=
 =?us-ascii?Q?0ZEyC1JAkGm1gHNPB/SQJUE2l2JOJOvGLpo7/ZYXQrrbG4ZBi5/MOGGNHFqb?=
 =?us-ascii?Q?q7fxM2V7/pwEqq302MCpxszgHR0f8QD2DNz1WXOD03KcwIym5FPT1HsK7hhj?=
 =?us-ascii?Q?+wMqAUgcWqIUKZ3kdBtelHRGlQMjBhpnzNigMEqowEqjsfcR9xWFjXFdDfDv?=
 =?us-ascii?Q?xrDZ/fT5VAFZcyx+yHIzz6T8ftnRu12H5TEwl1P2fo1WjaaKKgSdTYMi2dJP?=
 =?us-ascii?Q?zNrOlF3f3V/LxF3uxegB1rl5VToFiIJbAzsrMm+xeKol8HPHLe9kb8Y5D0T7?=
 =?us-ascii?Q?p7ywcF57QuDaDz4NkqXh0KwLTAm6XHExcPjR9fc2cF2RXyf4GAGkhzaTqwOC?=
 =?us-ascii?Q?V5GqD9bxH/V0TAbVYH9V+uzY7+8zVFKPf0LzZGlZOUHMoOIfyLM1RXnOKlxp?=
 =?us-ascii?Q?HpR7yIlL3jXdbLop5nN+bHLnyTHHFgyuwzPuEMlzT7FXJKB0FovyMKhjV52P?=
 =?us-ascii?Q?xmsc2D83F+1Bb1EW4O1wmdqzlmArUtVAuJHdi24r8oL6J1uty6j+gXFkI5vX?=
 =?us-ascii?Q?dTMIl4keWPKS1+R4VERmeyudcOUw6tnj5BLs2tBpOa9EGOz+9nPEepgjXowF?=
 =?us-ascii?Q?7C3ZtD2ZwgWlgpqwRDfxlUftUA0rP7Vf2wzHrIcgnsrBL01arw+AZV1gtXRu?=
 =?us-ascii?Q?RykD8BLR1J/qCmBHzj6VqHBgd+Uk3c6TT4jsFkwxIfd22zLHJOSAtrwHMFng?=
 =?us-ascii?Q?HetYIwPYTKCHn1fNt0NPgYnrzeqRSHJimkUNeP53yeTckatebO59xxqGseCM?=
 =?us-ascii?Q?/g8MrZ/0rWkNrzrtJaFPzccO5vLE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rg4+334phfu7L0V1nc8QZJdNi6tFjW7BXpjx+oRXBX7loj2/beCLoGFqTFpT?=
 =?us-ascii?Q?pzriubW17PdsXD2qHjGqFyJMJJ896QO/3UG6tr64vDKvT0Q0AMhiPduDsk97?=
 =?us-ascii?Q?NoqdF/Ec5xtcqG7oPJWcebOGY9ZR9Os0tHOfXMIOu04uYMQepRXBkjoEG/Wc?=
 =?us-ascii?Q?pObyhwKCRZ19qkJ5g/HKPpkZM8Tl5lnEJnc+BBfrTAViy+YYJCN8BEvdsHVs?=
 =?us-ascii?Q?0dEKuGH4H85N3aLUwlr5MU2XbBgMZVWz/6Vl6fiG/C3vxsKEDgGbHRNuiEza?=
 =?us-ascii?Q?LCJuvg7jinqVCqBTTlx9oXFCRgM/oTKA/mksxkLSlXNHBZ2IxOIOz1jLUafz?=
 =?us-ascii?Q?A3wYiO2izPQJvZiSn+9PRjM38O35CJ86eXCSU+5qU0GM0X8hxHt115Ubc4qr?=
 =?us-ascii?Q?u5z1wQXuBKXFXQUpHfy6GGEAHAccWu9YLLhYTE3AVd9y00Y0TQ5kFUPmWqVF?=
 =?us-ascii?Q?LuyzjpV1lvIoNBD84l0i9t9VqCtlGcAuynbFYwoMnl/YGUJpDRVhZ5QJconi?=
 =?us-ascii?Q?FtBOPAiWZnXYQQizyXp0yGJyaErRRsyici0lwovYtQPXAYWmTcMhxzrf/rA6?=
 =?us-ascii?Q?WR5+DBh+mYSqjDnLMYLq6lpEfqt6PrW9XHqMBTrxvvsrayKCZhkcanWbOAG1?=
 =?us-ascii?Q?H1LJ+NOia45t71tDI1wuhdN2ze11o6pjDn1AxXah7IT3hti0Fzvo6q5xSrMv?=
 =?us-ascii?Q?TlCO2TWWpnECn1Q3J072VZOn3f0SzCQy+rVm9GNiGJ7dZYEEps8QLt26Zupk?=
 =?us-ascii?Q?0J9Q7Kxk0PkDK8DOrk5qBxwhi8R+xnh46sJ3d1uTVar1SiAOQnWn26K7fLJ2?=
 =?us-ascii?Q?sbnh1v7CLqlpeLG6v9/+OmTEaGrDdgLcOfsnZpygTujCv1A4cdnDAM6+yKCA?=
 =?us-ascii?Q?JcpYCoXZsScDntvhWde5XfdkWb7DX8G69Xaf07MPZlDohU6ilmCM8ytUAHdo?=
 =?us-ascii?Q?8peyAED/zih3tZs8GHxaQvKeu2hjoHxWkw0Z0mBKDcarxUZRc7QXJ2THfbnm?=
 =?us-ascii?Q?Cp8rV4oTgfQSvPAYU4nFdsVJI7AZuPXsnKARbra/uhqbsFS9eTp5+uO0qPCC?=
 =?us-ascii?Q?W7la/5zQWUIWT605nlqU8GWYJU39rQm5G2vWHn021KQVcgpBNCglGr7BPZ8M?=
 =?us-ascii?Q?yTh5HSzh80XjAh2WBhtl6akfhvi8R8JcSU/egShR1HQ8ZvdqeYmvkrq2SX7E?=
 =?us-ascii?Q?5Gnh/tSUPd1qMQ+v3A61SzJNcPMT48yueMEeUnd5qKNEj9LlvtRDpVY+uAsG?=
 =?us-ascii?Q?trJEKRjByJWhtay3jndXXEVaLoBzddo9i/PTqjxuND16Qo70diuChSsR57gq?=
 =?us-ascii?Q?AorEH1LDEBwbYNMQUrIVTiTEw5Kp25mrHmhNpNDmmivyikDqoeAFeC2ysOMW?=
 =?us-ascii?Q?kDoMxQMBMCl7Ts8XRU5jaA5AysIvbpefSDd+z9whkDlr/QefEjlaDBrG9J7L?=
 =?us-ascii?Q?RX58CB4HqXvy9OPkX77QkwTiO+FVNpNCSZloySCGVNXaAik5IvhTZZm7Hyty?=
 =?us-ascii?Q?mJnlkCChs/d8IOzfrpEcAzOplj/+qiBWqR/tomcmLyG1h1WNVpNEK5KvZQOV?=
 =?us-ascii?Q?LXKpslBwyL+BEI0dpo5eFXw8z5tTBHAFBrI9FoBp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IzMsygqGcBKy6/6aqjogBeZGdLu1Mdp2O7Hz2Bi6iNIkTo5FgnlQLsHvPz/LE/WTXQI98S2LRCR3KmZgLAHuh1O/Bra9edycZcSJ4YrxuluDrH+8g9liZSAjx74YfYzb6YJXluhIKdk8An9WKP/DttTpsvgbtcKeIsGPkwanil68IqA1mpmCZ/pKD+Gp+tsISCsa5H00my2RDq0JEmewp56dsDS5KltdKMQ5SO4YNfAoFeOBKDtwZYm8r+NYqAUmUAVJkm5GPnYsZn5JLxeBueWd3N5NXPhyaQwOQrJmjRI8WJwtwM6jLpyDiCvmvPTMVnzRfbzVGotc44+cNl/N1ojHB+gMfBVNQ1iW9Oo1bGLqSIHnnfmZRzChuyySFS2ck28N81s4GfOX1P++sP7ID/AhvkknvUKwYlaDnuTHSbyQzVzkHwDuJN9g6ZtMC3eZWOH3IyWS9NA4PkJEo2v27y3EvIXUHayzQ2I868aBjGvPct9fqmBkXl29PM8tTzT6MM1T0vHebBPJ/Jua6yqG/xBGuVT2enrFu7mwkbA+60tYQWUZ7BalWS16WIHhSv1i12VV1Di2vSBRZ4s7OaaJ/NOdAaln7d7wew34a40dRxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2072269-8cd3-4763-0699-08dd2a8f8ffe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:10:24.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcwi5r8ystggHfOb4puH5Il854dwCZGlSkUEEaly/jl9zDBioUpj5PTvp251dw2TpJWJURp1V+RPqkNzJfRkuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-GUID: T6xdw1GpOnjwp6Egwu1QHuzwoF7LvEnl
X-Proofpoint-ORIG-GUID: T6xdw1GpOnjwp6Egwu1QHuzwoF7LvEnl

Modified the Btrfs loading message to include the RAID1 balancing status
if the experimental feature is enabled.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 58190989a29d..236eec7c19cf 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2480,7 +2480,17 @@ static int __init btrfs_print_mod_info(void)
 			", fsverity=no"
 #endif
 			;
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (btrfs_get_raid1_balancing() == NULL)
+		pr_info("Btrfs loaded%s\n", options);
+	else
+		pr_info("Btrfs loaded%s, raid1_balancing=%s\n",
+			 options, btrfs_get_raid1_balancing());
+#else
 	pr_info("Btrfs loaded%s\n", options);
+#endif
+
 	return 0;
 }
 
-- 
2.47.0


