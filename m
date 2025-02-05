Return-Path: <linux-btrfs+bounces-11285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4EA288DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91ADE1684FF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19A22B5AA;
	Wed,  5 Feb 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AAftEt8p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v1uWGudi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF622B584;
	Wed,  5 Feb 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753621; cv=fail; b=bEPvhLGPFbCbPI56rW6yHwHSyJkfc3OUr3dEuQzmegthAbqE/nkAjEKrsHzFCbzNtD77cEYqOy6vLwOHP7xsYShUkK3NlsN7A7GHwj3z3ViwiUV2qpQ+KX73/nuvhKvqiYuFVXtuF7AvyIFu0LsZg+IsGWgmOYhGaxUrj1qCAkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753621; c=relaxed/simple;
	bh=0AhxpI3hbQGqSMzqffS+M+ZqFnJQ84lR8pkoMr+yh1M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PRqL0lcJBU/1s0hj7Y/t9w8XwPwCaHhCR9SL2dkumf8gWe0UcbrApauEXCBkhN8ys19TV0KxqP3egzDvP+ToR3vZct6f8i4gbCsUd5YPf78nCDDx8jMcBT60MPgDp+wDFHrkI5sSE/wuiO8Jud7fpB+0cMPy7QewGph5q1r8ph4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AAftEt8p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v1uWGudi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5158MofH025954;
	Wed, 5 Feb 2025 11:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=OF/uotoXMiqvTa4u
	biRu6eShffH8Zedn2nK+YwPXY3c=; b=AAftEt8pKRzq+O6PDPCnVFJk9si4dKE/
	b6hR+wAYBa75SZJEG62Wnz2Ek3Wl9TZiWtDWIYEj0JthMGpgy7ztHuKAwEEfOK8x
	DYlISXjU7rZrmdbD5lKWePuc5HO9WxYhZPz/41POznqPWdsjM0ZTdJtAcLQ5rshN
	6yafWbyXpoQmi/p4NoqwFNy4Ux5acdbgUQi3HP14bPLRS7med8kUxmHDEADN/xKh
	eT0alp0AqE5K+b29xHp2evWa98aWKg5wCexLfR2SWaRA0QKwZw/LJ3umYIYLFa6f
	lXbb8ORrkrNxqnFVI0CETEj8WxueNMMfSTiOgS00sZKrjGBJuXHYXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy86sqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:06:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5159HAFn029394;
	Wed, 5 Feb 2025 11:06:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dnh8kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOhB0qOSVFUIMgNyMqpKoWosdRAFA5ICv1WSPe/7m5Kn8X4xZNuCwfYZNiJc/JQNzhrpzPeG1nFSIltuvVXzDgrIlh/cuiknrYOAtw/LEurz4EtAYtDaLEXyUdcVhXDXwYtF/CDi0XCHP17zxlxthjJPuYjmJ5Iqsif/gBfetzoYWAS6KBKGDLqD7kAgdfxW3qdYySt4OzVuHVcf3RJF5zEfCHU1tKO2ZYrhd2zP/VFWA+LxTJfLC9o0C3XbZiWxpYTYYRl7nbDUspqNqQzgTiU232KBB/QHdufmerNNlWTXxFBHjk4UTzRwcMNv5diZVTezJKWY86jILnMcoKtxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF/uotoXMiqvTa4ubiRu6eShffH8Zedn2nK+YwPXY3c=;
 b=YiSRGTUMIeGNp8XyZbWNusbSOL/rSzwXCVG8y3UzPA5m813Gjzw8VVhw6RmqOGQnZ90vYsx93ohibsLx4cmIw01lRqB9iio1DZY5eEz7EAp2a4B8kuDDCnQSsV2yc8Zhst26WS4aLoPxr0QYmlvopE39ugAx7soHv6DAmF+PdNrTLPauUql29TAqav5JeiU0NVHsUKhiyesSAcAOO+BwIWE1FvgURseBCRVQHL8p4LMW6D8pml0HZ8iTONXcvwOafZuXm/bE8/5OEFYqcgv3N1G4UEWIF7pCAG7BC157cYfPJcPxwkZSjHK97E0C4Z5ESVWDydFGoNFdLuONhDU1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF/uotoXMiqvTa4ubiRu6eShffH8Zedn2nK+YwPXY3c=;
 b=v1uWGudip2Gjt9lb96ihwoCCWo4e9+HbvxOUKsjJgJhcgfB32DrIHm76WMf6j6193bt4+PctYXipgVt5cHTcRkD19DIcs7/nOIxMxc29y5BBkLRzM/DHvLYQTryt2BBZ9eS5T7a3+sCGhnxd9zTEWITYZrg4OtpOOH6C4pUTZ98=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6439.namprd10.prod.outlook.com (2603:10b6:303:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 11:06:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:06:55 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v2 0/5] fstests: btrfs: add test case to validate sysfs input arguments
Date: Wed,  5 Feb 2025 19:06:35 +0800
Message-ID: <cover.1738752716.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 653e7f6e-c159-4718-14a5-08dd45d53370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pUqpE5KEApYnOa6t5auHRPHEIvvibHCRnIyh7UV/0O8ZTNTy1g2CUeejSI4P?=
 =?us-ascii?Q?iR0X+6RZ9lTDdnQJAbLtShg4PN7KBjDF0wfoj4qyvRyk6Nxxbo8YoqmwsybA?=
 =?us-ascii?Q?e9W3LCfMSe5OhFbb3rAacKcH3bo93cNjgqUXrM/wD3tJnWXUkRGVSVqSxpSB?=
 =?us-ascii?Q?Khdww4aPqcIqfKugoRQ80FktzE0U4TByMYIIINrnv2SW1kfJBAm06Sx+9z/U?=
 =?us-ascii?Q?DDiXO89ysQR7dm77eo0XRBPwdO28SXbq+un8Xw7+o5feTeWGYQfSrJWF9DEm?=
 =?us-ascii?Q?VV51twmQ3l1fHCVRitvnovp8E4gyIEx83RUqixfRq2Zzcw6WkUtZmmScy7cD?=
 =?us-ascii?Q?tHVJbD/6zH9sSSpckpDrSQGNwWARHp8w+A79Mi4TjUnKmqlZ7CWV44RU8MuJ?=
 =?us-ascii?Q?G1Cy63pwVS2W8S9MBpFVI8zS5yh3oyyVxGsQlIoUZ/J4y/KG9efp8MLJI6lQ?=
 =?us-ascii?Q?Lo8LomJ33uMh9fKM61Wns+z8Vq+u8YBoeLoZ3B4No0CxEozsjgmvws7WrEBd?=
 =?us-ascii?Q?0ibUqy2766RzqlQZJBIYTlObU9DACKFVNaRKz/PL7ArsoVxslQ3/ZWyJTt1A?=
 =?us-ascii?Q?D88iS7A7s3tNsFK4Jm9r79kvXHdRvP+cc8jVAbPpAdfAkghCZqy7xocoz8fy?=
 =?us-ascii?Q?GzkQMY7BkKMMbT1DmThBcw2+G2nU1Aa8k2hsVL5wBw3dnvBqTtucSDrqcM09?=
 =?us-ascii?Q?cNy9spLr4OjrWv/uF2ldtjXbDbVGXCWUGAtlQNbzbV2AG/cGvRksasjFyc4u?=
 =?us-ascii?Q?iKhWnlH8h+txLifTIVJ1r0D6swx2F9IrX8VNk1UnE7G96uzySp4ssiQYZq0j?=
 =?us-ascii?Q?m7tSrINXulo83AHgA28lDQGlqMv8OJs9bA1r17K7HfTDHaJlNIukLIZsbVuB?=
 =?us-ascii?Q?goP1pw5dOHZwNXhtHKlomP0i22k0ZmNsvTC1kywKFoCnpRhT0yP7InZyD4g7?=
 =?us-ascii?Q?6uPI/9Na7B/G9qm2dQPDN7QFN2CZ1R4e44XS7wj9SVCXNlXSbVWwKdhoT/5e?=
 =?us-ascii?Q?jbEjtuU/vc6S7vWnGe8ZQxYSKmsDF1gm2k+UeV7Ldj27nwGZtnQXaTsvll60?=
 =?us-ascii?Q?cruen5gOhvKqHxxIdLSgEnzHcZBu4poZE6Fy5acoqoBCDLaAtIjz1QVPy8bP?=
 =?us-ascii?Q?KfIu1D7xTKongk1cR0WwmAkmssKY2UgTlbdHGk1cxyi7PRPD10s4xTj53ctM?=
 =?us-ascii?Q?9aTV2dnEmcIjl+Ye+jGaNp8TNKSy3FzZBZpzPFb4GJB5UnRRNUIBIT8HMFOt?=
 =?us-ascii?Q?j7pNLWItsQGfVmLXLy/eiocEZNmV4x4wVShZetVuGqkri7FUlsXhkirJhMxi?=
 =?us-ascii?Q?Tk7xVPzJYVZIuFpt9TZFKG0l3jXi7aJz7Hwqg8ANeRnH0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rp65zoKVK/ejP7kVdpW63dT/Q/NiDqWQi1LZBwPYr+YzhiuDEboWqhvxKiXZ?=
 =?us-ascii?Q?5tQCzS31w71bS/ns95cwIrzPsDSjLLbWZBfFQ3rC5UuIrjO3RjwnPWsaESHP?=
 =?us-ascii?Q?p2NHs0qe3EYkDgG5T6+2IlPe2CXoP2vMc4aAkPFmxuSBvvZ6aIlRREt55K+A?=
 =?us-ascii?Q?0Cv+cfmHHRc8eQSFpSB6i9GnbLvkE1uNNpe+AlJ8JytFWFj9EdUKmGxSg2x8?=
 =?us-ascii?Q?mBCRtXWHhq2nAWuAV++uetkrBDMI4zU9lK/M8Cz25/iXia73KvHCRSJGksnG?=
 =?us-ascii?Q?UexAfZb81CahVSUJp1j3l7THhQkID7sRlPFfkxjBr89w7oavwwcP0sbxtk3h?=
 =?us-ascii?Q?nhgma+5yyYipCQvMqfJIIhu9bUPNp5+SAXiEOdur7+bxy0ywCtN5/nmbRmul?=
 =?us-ascii?Q?axKOHlNLudP6HHmlL2HbID0YFqHxJdHA4lLnISYPufYlpsdlL9OIl2WSV1tI?=
 =?us-ascii?Q?lnmL2AB3O3lD2bHkep9F4CHpalDLpzSkRk2VGmdPtaP089MoBVxBQsHEFlVW?=
 =?us-ascii?Q?Vt9UCbo+pJtG90tmk8rrHBAEprLj5HQRz4QinkrXfmhtFmNgdeXwNx82MUIL?=
 =?us-ascii?Q?1IVTE+GuxeGn3byZA2fT16OX/Afhjufsq8x20NbTLqeuqjftVXP6gWiCvfSH?=
 =?us-ascii?Q?vtrj4MuMwg3Tzcpd9Ujp9eJzDA+0R57DddtfsAnsd1LArxQAGiXz0lHB63VV?=
 =?us-ascii?Q?xPHIipxTWHCQ298UYihj8oQd+jYnnE6qTMXKkHlXlz74/xXQPpMOJqwJcLdZ?=
 =?us-ascii?Q?xdYrgjUHGbUgtvhnniiilc9hDd9pIvpU+YSyDNegI/o24zo/qCD4SLTFayKJ?=
 =?us-ascii?Q?p7XK0Z7djNkWBnPHp4ileBm9s4XXINKDEZ90fUkPTSZJilLPS5lh9Jg7OXYl?=
 =?us-ascii?Q?eK3CUNgMN58FPHH/7X1++MA659qhIGuqZVpNjeMlIl7kF4SxpUUAXzFmQAKm?=
 =?us-ascii?Q?BXioKI5amf23B6B+b3VliSP7wYvFq46AI+69S7Z4ojsEsZ3SEZgIvau3v9Db?=
 =?us-ascii?Q?vOA+1hQmHclMJJWO6BBZAeDcIfoLRvVo6kD50FQZD+kNqjKOc2J4c5qfsDda?=
 =?us-ascii?Q?B/ZYcriOhKPsUMKvOu9daRc9ZN5PYVpPclktIHzXxydQ0ZMAl+m42KQdVl0V?=
 =?us-ascii?Q?nz3hPIrjsDj4sZS9aEsWD912itAqHjQ5IFvH8kb1x3Zlq64cDP4zoLb2ClNS?=
 =?us-ascii?Q?vId2ZAkqCoY033qLULUhLucoZjoHq/BxjU3nQy9bL5prYYHFWSy+FPnEpTTp?=
 =?us-ascii?Q?WTxEfwoBrG0UBytCRDkJXB4zeO7yyP/fuLJNztJtcWUGixBLGc7y6gQQl7jO?=
 =?us-ascii?Q?0OwkK2+RJieEEPoLvbFl9JA8xyO+DQoZJbB3P44mhWKmysMM4vNa0AuDiBAY?=
 =?us-ascii?Q?k+iQAGNcGadwi5CitRmzjGGcYY6shT1lhgdhMgAbrd6tnKJzyXrGEtaM0Hg9?=
 =?us-ascii?Q?9MIWIc0szAcG+AqfuSr8Q2RCw05AQr4nRWPhmw0E6aLNCdYIPz1hfRrm82t6?=
 =?us-ascii?Q?d4E8NTu9u9kxPFs93sHEq7SM5B56aay9dYymS61Srw/7UOaNsDxAM+kAFp5l?=
 =?us-ascii?Q?77LGQPXxdks+ZqmHfRFtvEslHR4EG+RT9evtrE+P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZCdokV6cNyKx2e/Lq/ubQ1JNZWJEAmRKEC2gcsGRbogE4d4a8BryGRR5DR5o7RK3ZwrLKbhYFrdi0NgOOG7portybhoRM01zEQ7T9wJqUDQvvL6G8Cbqg5+HM3+Q/ManBr+D1j+CDjTATrGW7f6OS67pyEhFCudnOHfoPiw5uhn/W9kahAO9Ysl81lVZKmPOW6/RVg5KKWA9sZKrrJBXSQxZWHYWgpZmolJlq9i0ipy0gTVEb/LFBiR+64HVpTIAiKIYYiH7V9wIL1dxAyRxbVowu4wuMwR2LEwqLyH4SCQcbh5jb3sg+NoUIyZzxp6O32SxDfxqhyF1I1F1/kUWsI++ikF4C+aYR0si3LE1rsb7ZXlLRoz+SgiuOSpjC0cqMKmFJLHVU9NRKtw9POYt2dmIuzfKKfan6epQjIC/OxNd2pmvjC9DmWZR6dD4psjDcjhNpCrXr6nv/rXIPb0+vUzcw+yFblemjVU3QPeccuJymRE1iOQDkZ8F0liVp2iMudl5ByhU9ax3tHLBNZeWSU14J2i7gQp7VK8oVIR4IwiJrKOVl2lL7cUGJKnlPAp7uZ6WpBUojY88qOPbZ78G7fblrnorpqrnRORIopzPrUY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653e7f6e-c159-4718-14a5-08dd45d53370
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:06:55.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhBaxPMwgMbW9+rYeMxX2nmkscS81MKZ0YaC7kHFLBMgjw/ZqwRICOS7eqOPcu6wlhPHc2I2HO9zBsmZGAsOsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=992 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050089
X-Proofpoint-GUID: uaF-p8iAeTtkTsmFmBzTOZKwVidfrysk
X-Proofpoint-ORIG-GUID: uaF-p8iAeTtkTsmFmBzTOZKwVidfrysk

v2:
Mainly adds a generic function to check if a sysfs attribute reports
invalid input.

v1:
https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/

Anand Jain (5):
  fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
  fstests: filter: helper for sysfs error filtering
  fstests: common/rc: add sysfs argument verification helpers
  fstests: btrfs: testcase for sysfs policy syntax verification
  fstests: btrfs: testcase for sysfs chunk_size attribute validation

 common/filter       |   9 +++
 common/rc           | 139 +++++++++++++++++++++++++++++++++++++++++++-
 tests/btrfs/329     |  18 ++++++
 tests/btrfs/329.out |  19 ++++++
 tests/btrfs/334     |  18 ++++++
 tests/btrfs/334.out |  14 +++++
 6 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

-- 
2.47.0


