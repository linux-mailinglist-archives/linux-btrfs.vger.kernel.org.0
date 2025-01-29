Return-Path: <linux-btrfs+bounces-11145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC7A22013
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2DD168A59
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F91DA0E0;
	Wed, 29 Jan 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AO8H3MaV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vYaCrkW0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D615B102;
	Wed, 29 Jan 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164024; cv=fail; b=UDNcfBGL/zLmE0cSgULaz+90gOm0oNV1jYI0exLZB0EdxFjkk6iVP5b8X0NT0013fFP+2Ao6uPkPyLRS+S8S05ArVjfziVuRTs1Yw3ODSSHpEvURflRqaC3pQtOPJupqMAvK3TEBhZ//OsZMo8eMjQAVFWSE4N3kzY0/Vw9fZDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164024; c=relaxed/simple;
	bh=bILavgwF83MohtVPJImtzPW2FVf2F+9lk7nVBQlAXB8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QQUmcgIkmbNb/M6eyNoPdlOd0iR2kvlDrJmOuX/6w5dymHAykJ2QwwwjCE83KisMzjO5CVcMznXpYOXQuuxmKImagLSXBYpGpL694gbJ6v4kyQJFNbqmgQ4Y44bLUk9m5j2su5xQKs+y5CT+NLXjgNAwqPgYTnSPxcm987o0iQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AO8H3MaV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vYaCrkW0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFHTJe001004;
	Wed, 29 Jan 2025 15:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=CxqNr2LcFVQcg25r
	oa5+CgG2SMFtmttTtVNaWIK7T7U=; b=AO8H3MaV/uxGlgfg15ZfylwZ0Qetjlgg
	EyXhA97s7asVdw2XkrnMLrhcUq/8IMZhzCWkOZ/xpPU7AMW8yZEzzJyOHHkUJ5DT
	Sdzp2gb+qrHMvPC00tX8hm7t+wLhpLjH4e9GMF2mFN1j51STz/wZhtqfYOurUywi
	kiMVUaDfUzbt0Ldr047UGgxyigr07RzK/ya7ZfhcYV4zV0h0yLy69Ql3LP0uYpaX
	72+2wRVpo1vU9MCVr/jaoFxyyb8DiZTRAbMbW1Nsi67/J2M/LWA4wqalLuSe7VIK
	NAocYzLVP7rygzML12bCsnsm04kA8Qal8JjEEYf/JYK54OFbz4XfBw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fn2ug8qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEk70I035875;
	Wed, 29 Jan 2025 15:20:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdfw2nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGLj2Munc7tsI0jI4aEMQlaohdjxpSogVnxQDyUkDmIIKWPkEBbipyWdOrgqbJ5IJCL3B4JZzKk8cYqCcb0T33yHMSxCsvOoPsnmbHs+mnH5Jv3GoNRulCxhzml//eseZkmVIch6tn+c+BJtVRhQT0lUeJY4jEK1n2a6YTHB0xgp42Fc0dzVNdZbaCCKVm0pYj6FjkaSt1ULUdCGwYT6CYKLo9D70D5fWP3i/kHbQGGXuhpDbQkl4kXf1OTTQgXxwt3RQBmI05o0sudoxvwCJwysXU1llWkhyotC7pGJMJkIEDQGnhz6X3ct+cU2avqewEy3CS1CjW31tuIrDhr1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxqNr2LcFVQcg25roa5+CgG2SMFtmttTtVNaWIK7T7U=;
 b=tVnnPPbv/EHvLDq+IpR4nE2xyVJ81/ba/Xv21eHyCHrTrcYRcAI4Ht3yPZ8sCg7s2hChn0uUn68GYSAbgU/xLEluR+2wNUumHzNhWClmCVZqQdbOwhOoqTeG0U/O5U2PSKKGzI2rCRTZ9fnm/J9SIZ4IlXgOoMbFyVTteyule9SuEMsUjueG0Lx5UMrKYe2uT30qbNppiVvNLG6R7yobw07NCEH4Tf9k7/1ZgCWJA62nuvByF7CCf9oCydbjkn1nFVVDdRsunmDXsGK36WCPkPaZq4QdUe5hIkxDYBf4gvQx8HCMQHyB+Xv5dvBofC3YhKkPlm9/OTOtNqde8cfDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxqNr2LcFVQcg25roa5+CgG2SMFtmttTtVNaWIK7T7U=;
 b=vYaCrkW0IA1Xbz18cpac1jaBI2OSBwceb72thxUaxNgJs7Me+wCKNiZvndv1dor07P3KsEDjZNM+Ixoo0gB2yB60nKAQ68Oy0f6hwqUHx+7ZIwBCx/9pGonVAPCXVHIphvSdZ2ECFn5DjkulQlwQhH491JolxH8uZ/1r3/AAnKI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 29 Jan
 2025 15:20:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:20:16 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] fstests: btrfs: add test case to validate sysfs input arguments
Date: Wed, 29 Jan 2025 23:19:51 +0800
Message-ID: <cover.1738161075.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 095323e6-bf54-477a-830d-08dd40786ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TkW3PmMBUbfECrnrgaR0nrF+nRayc9+FdPD5/1Yl+IVjqC7tQLIcJPR2VGeh?=
 =?us-ascii?Q?HatavwAVhgx3dAZJTS4dVyW5nsSbtdKZr48FYWDohK1cjV4Z5N2ZErWU8rpc?=
 =?us-ascii?Q?oPxQHNhHXTwWFKPPsNlD1OHdozQcBW+s/DS5MqNA+xF/4Td0yiUCxQj2jVSn?=
 =?us-ascii?Q?EmjZayfxVR07HHgITR3Q4Ntk9E9ov4gGsVgz2mpZ67ZTwFJduob3M5bkuS/+?=
 =?us-ascii?Q?cs8cJE6FEy+u6vCnb0MZstBTuY55ipvi99/Y/lJE/mPoClj2tXzmrJg+lifT?=
 =?us-ascii?Q?DDuO9frOMNiYfMj1T+oageaJKL7dFU7bORwtXhTTxLa8ylWeIhnJJ3YEx/vr?=
 =?us-ascii?Q?N9rI8SoohgDk8vkoZIlDRMzudC5zz2mavkXZL1RA+/Ufv+LidQYmN784sQt+?=
 =?us-ascii?Q?crUpdT4wPBx/huPCMcto7NkqXUMoIyK6TbdRBVHQdiB/mIoGTxm9YmbkS4lw?=
 =?us-ascii?Q?Lbt/ShINHoLWuDMZ8X1gwveOo0jGTEA5aTEd3JdrpqXsUxyS/kLhIsv39DYs?=
 =?us-ascii?Q?HByrmpSNJ4oaLJkI1fZ7KrUsuxOxrAedx2wjLPzF8au5HGPNf2n6inpIjUiB?=
 =?us-ascii?Q?eujfRQ/URt2cAMfcof2sqMK7iq9H89SUajBKdkiqCO6506DrJroT5H/tWVHr?=
 =?us-ascii?Q?G2ieEvwHisa4xWKwkSwfOTJC2uAO8AywcASpAf81nwkjYcxxZmEQHHPSeZaH?=
 =?us-ascii?Q?Cxs6X3jxdggIzypdU1FDKV4tjY4RIucakmczmpUtdTdJan6tJuj4ZHPhEi6X?=
 =?us-ascii?Q?O48JU4r3oMtmFQSdY31J3gGEBI49vBCtvkqGKi/pvV0r2p5L6I7WCT0vD4BU?=
 =?us-ascii?Q?drWgKkcU/gUy2TEtkO8KJ53iZelLQ8WDE6scU/hKOqe3MUy9glPni3KvzF+Y?=
 =?us-ascii?Q?cHti5H1n+1sk4XVQkC3rnWiT9/CuAFgEzqwddiv5sylVOH0B552DQ1tQu1lF?=
 =?us-ascii?Q?wp4vtFpJK+ZZMODtNA8t/N1z9mviKBgeR6AFJ9FQ3mpWCK+WVEUOfmdJI6pB?=
 =?us-ascii?Q?PNRCpWWNDKQJOrlDJ7ZNP7jlWt2Ph3sZmxLn6kRNDYujw5BwBAyMiidkkvYl?=
 =?us-ascii?Q?PdiFZef58SA2QMqLjtjchhHsSeNnWgJ/mJUc9Z1+B8Ao1i11dc2YvmdTYBzj?=
 =?us-ascii?Q?YEN4W20Ykr8Rd/iOkf5cDFrOVMHzRMb0MMCL90I2olRjONrHNpVjYy1ZCUx+?=
 =?us-ascii?Q?yjtFDBPWUIGZYLwUhClKhOkciCKb4iQmGrkOConCSsefhuhBm+1v5rNsLOZw?=
 =?us-ascii?Q?5H17yOIILY4p7JLLch2uYIJKQ9iPmP4DnjhWL5gTxXnAVLxrpC51x2lfkFGv?=
 =?us-ascii?Q?e6ndhuGjeDJUI0txn7uY5OZ+fCwMlhTxGGNvLO8Da0rsK5y0FyBrsh6zs6Ke?=
 =?us-ascii?Q?NgU7IUCk9nq2yvZTUPd3OS7TQNQT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKPxqMM43XBB9teL01QS0OG3+esFZIQuM5RaP4AbIdxkVVq2pX44O3gV4MiY?=
 =?us-ascii?Q?0HBij4X48uXw/DgfSN6Pu8VOYoCG0u48u61nL+fhkNlxndWZDOzFrNDZOsmd?=
 =?us-ascii?Q?vTLDB5lJOxxbX68eALKzX6TJeCPWlcA/C+w/QNwKKcJrxd3AwohkJ/+Rz3cC?=
 =?us-ascii?Q?UUEL5tqwzOpJmT/qHdDTGtuAgHSQf+iSSCYnMmt+iqtiokdxcdn2F89i2ETE?=
 =?us-ascii?Q?MiYDlSmc/zeInMfxa4pCIYEu5QX9zxn32jocoG6mlN8Z/0vGZ6dA+MtIoJcM?=
 =?us-ascii?Q?CTDimNPcRbkDuW1XjZOgSAVv6Ndyytyb9yT6JzOm8lH64mWghMXkstBlCc3G?=
 =?us-ascii?Q?kBZWrs92BwUVALKuoBQtCGDUq2dWwVzVbrn4m3Qp8erQjFkLQsKptu9reaE/?=
 =?us-ascii?Q?abDN8mGrEKN8esNVggN7j0Qs84w0LSZI8F3t0oXfc8JDAs2mDc2snKQVOSfy?=
 =?us-ascii?Q?C8rNW1jBxFjiyPOneO8Y01eqyZrs40VXG8FHjMVZE7lf2Ampukp8q7HMikCz?=
 =?us-ascii?Q?0vXuhQOrjwzJXfaEEuQur1MmLlM2DGyXd0PNlIJDpOFBr/DeswuHvq0sHFCt?=
 =?us-ascii?Q?XptFLTz7ihM+s8jX6QSHX5gnr+PoZ++I7+MgqteDTrSo8ozasn4MSdkXhYjv?=
 =?us-ascii?Q?F2i6vAYpLLWk+pLXCXwzRjEQLeahGIl1bAcxfssZlTuEZ5ByTsIacGKqV8hM?=
 =?us-ascii?Q?1+N8QK1eLm0y/42MySyNAj8be4pa4+Wgb8vPdkvSjv0afaWq2jYYGO8yrfe8?=
 =?us-ascii?Q?F4q9kfAn+pgY9A0+5J+mgv8tY3olBJVFr/reEKhsuXxBPgk+ptRsNdy0j6Zo?=
 =?us-ascii?Q?fFFIHVOWYvJkF5d3fy9GS7CmTjNR9v++DTPjLsgGvbbUpIJqN1i9h7fkiMMO?=
 =?us-ascii?Q?6OXEmv8Ugk3LJn0WeSdkZZl0vKph5UzxA5l8d84F8Y4EpiOULiMJqpnB5xAv?=
 =?us-ascii?Q?Gki2RWTblTkEFDAFoNvbzjfqONRelH4rk5hFLjmdhAfYSCmhYiCuUufNR6SN?=
 =?us-ascii?Q?LIxV4YhbwtKFCptpFLwZyZ/U0mA+ZhyaBJZdGe0tljkVPcdcF4unTzpsAcer?=
 =?us-ascii?Q?j/gife7yyGTlBjMS/wQtGBP/OCJEKnUHP0ieWDsyUjhLxE3TkJwuqpMECDjI?=
 =?us-ascii?Q?GiHsVD0RbzDMcgGk7SXWgj1maRAIKRQEXkoF8QK/0jDjSf9v57ZDsS+Kff4u?=
 =?us-ascii?Q?jyJB3qKCBVT1fWyZ4aG4BklpKPYNKCduAZNEaf5jzkzKv/GBDsJfqeQ7olMO?=
 =?us-ascii?Q?4iZylA3olb/X9fk2BvZJRAtr32tizSFZbqjD8WWW2+FpnqQX+5EYGIR28Kvj?=
 =?us-ascii?Q?XF/3QVKDUW7mtAob+XZh3EstS4Ua8Ja/IRgyzhqQikoseAzij66Vz8lypjso?=
 =?us-ascii?Q?tucFXbwC9CgciXqiMsGgBrtc35JQWIX/X0yRSry+PI1QHt9yv4ZvckqBd/2/?=
 =?us-ascii?Q?FZhRX+TTraKIE5CgT2TMu0JjElm5seBW4S79aQn/Qp1rxUJJCqh0inWc2a/S?=
 =?us-ascii?Q?OYQemYtZV3b4/CwO8yfubhciONM5aRlmsfN5oFKdFkkvq1F7Kzp+RNEsQoTK?=
 =?us-ascii?Q?rl7Uagq72yNJU5JiLwjAAttwHZd42juHWeH8TLTm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iAtJs8+z5UVbwwVljAO9zmboFACI5qF5v/zVqiFoUh+4pye1PJN8Z4OE8pwoCEF3WMFwt38WmKD2b6lESMbuOeHVMP2KuR6eyddxTiPbzToPp0VdIirwq+FVZX2lFnyTUyWc9nmYlm74456hgMzDVcHCiajTnWtXBjQI6Z1YIovrJohT5OOm8QcX/Vx8RLgVj95n971ektVom65nALMxydjkmYQsaYmUfsytd7bkxi3fIwOK4K29zRJ18y+OcsW6OBi0dET4hgC63bqmv8tvvQOeMMFq5qUIJ8K97bz5odma1iMnJhjJHaeOD7PzYMsRJdvYejhuzQb0RbhAy2wPqp06wR9/60qa4HGA/L/eHLcQzSDalqmzq+Ojrawv4Nh8t6zy+9IuoTILW7ACoL+2uMPogtyQoelMcMD+HYidmiAkGiGSsPUG1nTUaMlG867t5+ab4kFm+CjvMFbX/WsOfzwlPMrte9DktFJn0m0RQbABF7K6OjnIUbFXPMf4X9lz9KneDvaQE6qETxwDM4yGXpYum3Fh7ULKhtkWPqgNjJodsGKrNR2Rh2e+dF9EzoNYC2rROypbWcjEuhBYQA94CEQIkKwo7v6Lh0xjbdVwov4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095323e6-bf54-477a-830d-08dd40786ede
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:20:15.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SquMHNtUCkzJ/rDIvIVkyFZSmcRSTC5KT8sHJkD8VG394BprQgqx109U/UOVM+jtcywMaUNG06E1gOTARoLMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=768
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290123
X-Proofpoint-ORIG-GUID: Fhuwd7X6CgwOvfGM4USNgG-HKjpVH8lx
X-Proofpoint-GUID: Fhuwd7X6CgwOvfGM4USNgG-HKjpVH8lx

Patches 1/3 and 2/3 lay the groundwork for testing sysfs input validation.
Patch 3/3 introduces the actual test case.

Anand Jain (3):
  fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
  fstests: filter: helpers for sysfs error filtering
  fstests: btrfs: testcase for sysfs policy syntax verification

 common/filter       | 24 ++++++++++++
 common/rc           |  3 +-
 tests/btrfs/329     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out |  2 +
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

-- 
2.47.0


