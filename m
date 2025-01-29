Return-Path: <linux-btrfs+bounces-11149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF7A2201B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC1C7A3BA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A11D9346;
	Wed, 29 Jan 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZkCt7Vv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BjRn9o7w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240115B102
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164122; cv=fail; b=h+KftAP2THBBOjGTX+2GfGa/grJm+StjXVW5eMSk1GNpKvSI4PxQ2tTBh8kwIP0i4Ij3sJWTRyg0gWMVDmhxgNF7E3s1sSe2ac7xkfbNhdjOOOfQ1iBY83I7rfiZYlwuLRFKT7y6NnhIrw2TjuoDEUPbRM4mrKHm/qVRInRWe1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164122; c=relaxed/simple;
	bh=ytPk/GZvxf3CPeoyEDXfQ6ki7yq111mvj57OV7QO2RA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qt2WnNbS301d6pScr0aSYCFSHczjCdz5rFfR5T3WGw4rtIu5tme+CnTY6/DSjWubZmhgZisUlEVI/IHw+dko+gNUi6tLWtFMnKjNcS7JkgGvaWLxGVK3db6M0NAglpdvekML1bA1zgcUC1nYLFmqiZErP8Amnd0M1gkUfQKhi5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MZkCt7Vv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BjRn9o7w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFGxDH011580;
	Wed, 29 Jan 2025 15:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZoqfeEIYKSvcHDfTqptEFKI5g2DYVrY/64IOJc5ixAc=; b=
	MZkCt7VvPY6CZGg6KSbpIgHZxzCXexshWQxp3YUbClShXUQDCWwIrSwVOR/ofVho
	YmdHv7mX3vxozM8KetPll3NbUHrJkMxLCrMgGX9hxxCiRU9S1ocXl0U1+1yBgqUT
	YJaQU9J5333SyisflJtfqnK8EDowY2CD23TzluJ5rQJ0EwWCXNxI3u7er+qeRzHF
	Kvu/4K7yrfLSo0M4ZeI2tL+/TiIMOLYO4rT8hFFdy3G4taJV1yFGd2q/VBhyGbVv
	X2YyYgHSw4QMzqIKdLcDoVsGSFMC7VSx7RGncJ5YZMv2I6XW1AiJGqSYKc9cysRt
	Hdi2jNIUecVsLSom5vgixA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp8e04aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:21:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEKSch024257;
	Wed, 29 Jan 2025 15:21:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9vx4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8RgY6NIfGxP/dWtVo3fefZGX1vr7FmmwF+Znr5y6vISoR1uJoJekPzVdCBJKRi7+gKOkujRcAMOvXvkFxiZdHfejwexWXotFDFovU4NM+KoM5fLtH5zmaxtlo2kKqx0b/KS66HwXCMmed5n4B3he3WrDGPavSlWBRvj8PHq1ApbDuF9/69/hO8ht+q3w2DjMS40Vbl2IGkno7qHgEaZz3EGoK8+t5oUOXWnH9oP1ARfL2sOR3NVEx736xUjfy7W5VbURsdYG15puhUpOuWjPhRdIOLer7liVBKiwBZtjoHstc9NYfdooJKNzacc5lopdwNAIlyWc4iZ/95sK+akSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoqfeEIYKSvcHDfTqptEFKI5g2DYVrY/64IOJc5ixAc=;
 b=C70LLRp9C7YWKqL/w7M89/xIRe4qF2lDvHWtc7MwNYK8/D4356t1BPjvcai6ukrByocXnWitPcY0BmVCYy4m9CIpWxEiUpPXE5aWoHGzwIyag3lhc7fehc43231n4KfjTD11K0bnw6a2zlTlPGswW8tnMxVQpsqqcOeWTsO+sesMuRrIiPPjNKI4nnf4dTOX8iLSwiRulPw8pOTrb9Cp8b2JBbXbc2szkwcOooJEmAAcPCGPm6dBtuk0KZUi91l1JSOuEq2wJ8I2RL/QW5VKKTCHrJBCOeUaAREe+PCTbAmxp1U4J08CNNlkcBWKR/+8PvnfAQX5HdJLfflXJ9nxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoqfeEIYKSvcHDfTqptEFKI5g2DYVrY/64IOJc5ixAc=;
 b=BjRn9o7wG69dfHOoyaXWgNqu92W1u2uOZvZ/t03KHx29Z00pMSqRaPnjNkk34gX5quCh8/nOsZkdCWytQpXNAwTFpv8RSlqxJLrBFo0z1+yc4MHLBbZpEfJyE/iNlI5zLO5MnvOkkQFU8xTPxQ6fbFSo2rIE0KF+Rt+/Av2kNA4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 15:21:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:21:54 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH v2] btrfs: sysfs: accept size suffixes for read policy values
Date: Wed, 29 Jan 2025 23:21:46 +0800
Message-ID: <3c4582c2ab0ac2537ab70bce3ac3270f81468139.1738163840.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <8f77c6490a181cb0bb16c6b11131723e46c41108.1737566842.git.anand.jain@oracle.com>
References: <8f77c6490a181cb0bb16c6b11131723e46c41108.1737566842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c45e885-aeaf-4587-5dc1-08dd4078a9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s2MLwMobX9VaVoqhj+vbGsKe7xuolQuuqgG5H3v+SJepuhRI23UnB74IHHvS?=
 =?us-ascii?Q?775nJNGtwU3Qwu2OqU+7hMdRPd/wENPuTf3GEOu8HBYDnAcNWo4B2DXNaZlk?=
 =?us-ascii?Q?meFe2DlfP/XFfrAfrhrbppIc9lXu3K1hi+1jUgJ2TyDv8rTogMP9BlS2gqga?=
 =?us-ascii?Q?R+2MYqud6YSVMunBXr15O3NK7RfHAOmAhbIBRoe8JD5pIez+DgqqKFiVNp1B?=
 =?us-ascii?Q?9uqdBMIJb3i3kcxlNc2ZUCDHzd5FPcIFLPcLbI2n8hadbq2h76/aZeDoYEIs?=
 =?us-ascii?Q?2ERI8g/HGsF0uSSowFrEG3VVyNeiQ1pAbyYIoC1wQTi8gagtpVI4bG8oirdx?=
 =?us-ascii?Q?20C1ZEKCeHQVgcCbhr2XFgwDASB3ePAVx+Ld+v1agRsw4BSmaIqyhVr4Z1KR?=
 =?us-ascii?Q?V/n2DFYOFYoAXSPR1h/tuTABVohVpsctivzToE5P5XgemoDgaxJUvNDVOpqP?=
 =?us-ascii?Q?c02guBt7S0Di1rLbZuVZ440MaSqmX+cibWV9FyKqE9CdRnZ+G9jvtIH4EM4k?=
 =?us-ascii?Q?M+NqBJuEY2llHt4elXYzw9EDijXSZK9GWcP3/spc4Q41Ms7yNrsjDCIwB3z/?=
 =?us-ascii?Q?B54qVWHVCsl9ToRteB89U31K4Q2ICOA0AoUB8YMzJ6GRJiivIrZpR30vfxfU?=
 =?us-ascii?Q?yh1lEupqFEEfrhC/meqBY8A0H7/AFcHnxXxjL8AKckGZTsLsSlwTM/fH0oFO?=
 =?us-ascii?Q?ihKvf7zV5o5V5ElvRlSzS+vzNZmbGyq726FHlxw8cW44Yi8Usn/F6YgeuSB9?=
 =?us-ascii?Q?mP/2SeLG5o3A8lO5nDQ7bepl1QDKSiNc7A1a+hQJKZC+MuyaZQPzzODOz3Te?=
 =?us-ascii?Q?SjVxgg2h93uRKzrTDRxkzDzlZ9M1zJ5AIkjXEi22xhzZf/qjquTwF+6QNAMs?=
 =?us-ascii?Q?radnbORzSBh96oYT9Eh40LMVA4DwpnzhmNEMf7DCyTUv6FYtXhNOVB12e+3P?=
 =?us-ascii?Q?wM5zVLjU2utc64uRQay/2PdmPgD7/SIKP2jGSGC+vkTiL2AqNHxVYNC2xM9N?=
 =?us-ascii?Q?unPZXTovmzAqic/fivBjagcstHzHH66Smgkgkit1i5cDtyU6h3i/iPnl9o8z?=
 =?us-ascii?Q?Tm1cwg9vv4Eeu1kxtTGdgqR+libr9AN8rQh1/o0TqO5MnNbHtIahVmZKoE32?=
 =?us-ascii?Q?jp9qKcR/qigdYUb2TZCwUg7uCRKHBk8f2u+SyfWlDQKjYxzUe1/R0W9XvftB?=
 =?us-ascii?Q?p9LKys7uwyQN/Kv7iBR5jlS7IKNYEvY/MYP7d//geXl9gPqM9gP8OvcGh0X0?=
 =?us-ascii?Q?hUzFo4iBHOWrg0XaxQ6Ehx30DrySWv7t1qCz1oQSHHEdiLXqBFR6QVUWqPuJ?=
 =?us-ascii?Q?Nd7BT5tR0AT1Gbsu7s9O8xyQQD/8wdkmVjif0FDKNGTNcTDWhlDn0BvgAdxh?=
 =?us-ascii?Q?8wefTJ1JUiIZJMXQMM8wm2aIIVCU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/F3gX2tw0qIrdIXKBYgNWxL4pshnnsRGiR5QxYMn8xO37+2D2QxHMCT7GeeV?=
 =?us-ascii?Q?1Zf7qWXRwh7WSWPDkOWZrweKySHWtrkPw8TDmJoQVd3Gw43xh1QlCsyrYODe?=
 =?us-ascii?Q?MPm3/IXNBQXe9OMiGa3maEdK0qLzYl4C1weO5xI8UVnkxZk4BW42wab/kxLV?=
 =?us-ascii?Q?OhPdcGrq+jwR7yu+bF5jFUA5dr3kzJ8b/kijQOQwfa9b+X211d9kdXELtO+Z?=
 =?us-ascii?Q?SgYt0is1bJxgx/+oJWuiC+DmxkCbYb/u30aJnR3gMkV8heJ0q8fflrX+XSIp?=
 =?us-ascii?Q?o3bC5YgYdVTn5pilXIFLDry/sjLNVa/4w4PCz0vD+3Fw1klzLKHSuK7P9vHW?=
 =?us-ascii?Q?QZJSSGYjisbnLG5V9fCvctq7JmlXpHFUR9Jk320XQ0VcRyiSbk/0L/s0J2hN?=
 =?us-ascii?Q?Uv3k5xbK4aykBlEWnxtUSRAwTBejPgnjkp6J5uU8UXhTm4ZATrTrswRTtMoS?=
 =?us-ascii?Q?cI5Kj1heQwsQILoYahQFLU+thgYrQjOFKn2chapHJxZqqxGsm76xUqEVHqY1?=
 =?us-ascii?Q?SemKBauZSCDhs4rRM5ZF3viIzo/Bj1/s0/p0Dmr2XiiOnLUiuR1wypIZ+vLA?=
 =?us-ascii?Q?LTSZ2nAPLRXtIt93nxqzHYRTwOaFk2QRjQvXh3MZJKF/l8i9osBerR7C7C0R?=
 =?us-ascii?Q?usfdusFVZX6LhP8SYEaQlyk063b2nFRtQAZEOMIk4TCAWQhbl703qUvqG0pt?=
 =?us-ascii?Q?7IGFBCxWj77UXWLEJbI+dLc/15MPgnBcvrB0UkoQKn81YFms4DTMtm/pN72f?=
 =?us-ascii?Q?DQXze8aYPi4Y7YR17GMuLYtM7QVk2BeoXRCMmyXVODBZltpjSM2wpIgu7FuH?=
 =?us-ascii?Q?BjxIwZ86zq6vIMWyYnb/huUWiwHQc2jWfecoI5Pp83a+UgW8zfzF37vqXFsj?=
 =?us-ascii?Q?sYY7yYmORMFTUyCHU5lGP0gEyH+zManEYZd14iFHEz7o1SJH3ZjzyeAOH9f9?=
 =?us-ascii?Q?Mb36sbDmeQqWD6o3rJfreq0JNusZiiCdlmCsY3UA6GpWgSqphR0OtlIo1wRq?=
 =?us-ascii?Q?l++Y446abX0LWXPTzCEQ5MF+8xCignrF2D2vnDPGNHbmtJuhfxl/Bznpi4jA?=
 =?us-ascii?Q?hYGLvNhTqbLfyBv/B/mHTjVh8V/ypkj5Npw6HkvfFd55BrdFBVQo06DDW7Uz?=
 =?us-ascii?Q?JQ1fEyQJ80P9RhuC91YFJU0tdF4p8eO2xgQ9vt7ns3CfHtYi8wlYdjNAt8BN?=
 =?us-ascii?Q?a673QZJqyaJySFKWxpNMTEVu5RySG7H/Wxi5VPQfEPFnhWvudwYkC0mrOrgn?=
 =?us-ascii?Q?8g1D6bafQZ7fcGaZtfCPNObLMqQ8NyC9FxR5gtXi17t5TbKCRicriv0Ee8ct?=
 =?us-ascii?Q?4FU0w70e+72a2vMNw4z/yo6f32RQdfWmvNMQgmk68R49dT6oN0CyxjfR+bYK?=
 =?us-ascii?Q?uFRdRkgIUJU8TEqSJYr2wyRdyzy/eG3qzInLmsa00qP49AUT0G74n9/1ZAgg?=
 =?us-ascii?Q?TGOv2zYYwSErO2gnjYjEXI1NGkpLh6QFLRH434+Itsn5hc57l3Yk7Pw7Q2As?=
 =?us-ascii?Q?3/mubh6I+qkqWJNM/BmLEtlMfFGPkaceosVLDjmN3Yq6VFdIJkF7cpHovO8X?=
 =?us-ascii?Q?wBJLJhFuNmZ8yEExYsKk4UuI4Lhm8o1lom0pATGq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fiQs0X8ACqp2IRENrvAoyRUUv2Oq3NTr6+QN2P1aJhdTDYKREMCS91jN1Hpkn2KUuOpNiPWwt1Xh95gzjCT+idv0VyvO1dCZDmX1YV/7JWT9XlgMH0yujMkHrWPiS8AqAG1Yt7xyamW33y4iNqgvrePjR13yGvwKT6nZa/1a3dunMeFM6IzXR9giqKL0mezYAqE5kA+9H8PQNinFhKxRyD0O1GBvYgzTmI2eh9r7yXJMdb9OhCNcWysG1N3Pjl0AaqigjIjkk3EX/Z38i+N3KEVeHf2RcpUvOqDEqruqDPYoNTfx/lPV3pkMnvrmzGwc6zlNzIgoYhkc5+bkg4oBgMGj0bD7ipvd7+Otx2atNinO7a+q3rQghvvw6GRKcrlY4rDhucGOAoBgk1/Q6f1734QGFTu1AmU7SLYNV1o1VPl22g/3HvHGYLCv3WszWqUhtH74sOuqFLdT5WLpjMOlzGAhuUz+Z5qsCTCRGy43UX/dZrA7kPNEIJGoTRjY7KiQQU09MdsAVoSu6l8vehlJ1DZKK+AQRt+hhC0MDG65jebJUdLk1jEI4Sg7X/1TieR1ELGRA6B8pviUUacT0VvffTSRtoNIrbsjcTAU29LuzcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c45e885-aeaf-4587-5dc1-08dd4078a9d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:21:54.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We9l1PMKVIz5wVYD7T+9v3Dwe5fLn7+WUacZELrhY/fLihN7UhVfjqJ9Fhsmc4uVTsZcpRwRCYzxI7PZ6f7euA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501290123
X-Proofpoint-ORIG-GUID: _yriSMCtMIdKTlBYK8-MjRfQFeXiV6Cn
X-Proofpoint-GUID: _yriSMCtMIdKTlBYK8-MjRfQFeXiV6Cn

We now parse human-friendly size values (e.g. '1G', '2M') when setting
read policies.

Suggested-by: David Sterba <dsterba@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53b846d99ece..cb6af316fffd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1342,17 +1342,18 @@ int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
 	/* Separate value from input in policy:value format. */
 	value_str = strchr(param, ':');
 	if (value_str) {
-		int ret;
+		char *retptr;
 
 		*value_str = 0;
 		value_str++;
 		if (!value_ret)
 			return -EINVAL;
-		ret = kstrtos64(value_str, 10, value_ret);
-		if (ret)
+
+		*value_ret = memparse(value_str, &retptr);
+		/* There could be any trailing typos after the value. */
+		retptr = skip_spaces(retptr);
+		if (*retptr != 0 || *value_ret <= 0)
 			return -EINVAL;
-		if (*value_ret < 0)
-			return -ERANGE;
 	}
 #endif
 
-- 
2.47.0


