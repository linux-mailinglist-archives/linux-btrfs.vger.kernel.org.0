Return-Path: <linux-btrfs+bounces-9697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1439CEBEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32394B31E9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467F71D47B0;
	Fri, 15 Nov 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XVMtCqca";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HogQKoHW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A521CEACD
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682517; cv=fail; b=canMeRCgvnwsHj3FrCWjC/Xp+U8ACrLpkpxXpfvPItXZPO4vMks6rWBGV+Vf5Jo4pQcxKqyyEzwlqm09U/Nyh3MWDlkf/2UWXOyjQN/bqhyohZ1H/fNQj6pwR6y+owSLgf4oN6X9ycvquYc9XRZ9lDPMtJh2bpf4V0tkdzYwlGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682517; c=relaxed/simple;
	bh=8JKaPZTH1mUv/JrEh5EXL5Gt/+J9IUV9kaQke8M+igs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXHLb88UgP2TTCJrz7uClpG6zlnotBc7X+PAdm5mcbh7bbrUShKIA7e0NFwLCqCjmzEGanmnMK6kkJA0kAw+Jg5dgw6/V58vynxK3gWeTlCSuIgfuNz+GEyzWvTxM1bCI6OzNPEtSIsNqFH1tdRZkb/oHaXCKlWUIqhGUppFVGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XVMtCqca; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HogQKoHW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDCrp030573;
	Fri, 15 Nov 2024 14:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5/E/XWII8PMcrHTFDpNlIhRV/A4itS3xAggWc/T4S7A=; b=
	XVMtCqcaP/0JBSj8cIGXlL1w7CKpTvgL84bHR/0BXaN6plPua53x20h6GLESv4N8
	qst/v4MAWIpFvcfBDElY/f5M+G5bQd3Z+jkGmlkeYhRya4KtsUMcb1JONbsj1VFf
	D+yhI7ZaShfvLqyZ3IPsKnTHKV0L1O1k7nJ8nHIH7biSNWGGiqn/VspdPngGeZCI
	A2c8mOswamsZqUH09iLJiYd53SE7MUekp4wsda0f+2PJjskLgl01JNibxCQ2t65u
	WjGleD3Gf/yvmFN84kFHUomjojq8VkLR0ObuYQQ7ivI+5aC9yDfXL8qU0xMwd0Kc
	RpUlyjJE7lLWmiyTOefuiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwukb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCuEgi022800;
	Fri, 15 Nov 2024 14:55:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2s4s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2wK1YYbYehCWSlt1PWOB1Tv5dWB18BYjj5v+DOECDOo9ey2wLqNzF7nuluCIoCN8oOjxt0i/PlXMYvGQYnVOll9Csmnjxl97Dk4uJ3kJTeQe6X+yX+k97hkMBc/tKuy4UVNk5FGQQDD7Sf3czTmZKP28V/Zux14bEQl1XPcaDqAw8tjAZYf5NFwK6bh3WoHIHNGroiIb0mIqeaHZv3NsyBm3JBgPrCWFMlNGaRWs72eVkAsHO87mTV8MkDvM3ZwtmEBJ5r9JGfZpMTttYsDCCW98BaSPg6HpNJBb4uB3TZhTL2bvnsT8RQB3xtVgLl6tlDdBz0U8gJqRDMoiDY70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/E/XWII8PMcrHTFDpNlIhRV/A4itS3xAggWc/T4S7A=;
 b=TtlrmP7MVVmHKPP2lQCHjFhzIn5k3lu3FB2JnNxN+scnyLny3K3ReKYIMJcrPR3FhtXryEcKZFbkDMqRJf3JnfDkv8qDEZaIbiQbqAm5PVw5qGmuQt2RdC71wNbhLRgtXCVez41hOyetvy8GUvZG3nruSoiP5xYjHGkwCgXB8OMkflGzp2Oez2Wfl6mggCX16W1fhrAmNj1I9jUyP6jOH0HanU78Zn0DG/SOr+p7vS/tPuJyst6vnF5QsLEYtcXu0339eYYJx+HLvN0U4ALiiCuV/NES3iG/8AO2p0zoXDEwxt6gOQXd5cKdvHVGN7sRD1bH2BUlYynoKAds2xy9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/E/XWII8PMcrHTFDpNlIhRV/A4itS3xAggWc/T4S7A=;
 b=HogQKoHWp9T2Q6aIgra+aTs18SYoQKSay2svd2q3JaaD90fQHyG7tEgC7moU+awsBYxJIrhJW49uqryxq20KRkGDoY4bP59eHwFlcHwTcbWuFpJwWt24JKupB3qnuPP+os/J/hWSHS0FuIPR0TbSnKFejAgAMK2x80SmOtG/hYE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB8167.namprd10.prod.outlook.com (2603:10b6:208:4f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 14:55:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:55:01 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 06/10] btrfs: add RAID1 preferred read device
Date: Fri, 15 Nov 2024 22:54:06 +0800
Message-ID: <8a076d890d2b76fa869fe282f2f53eafa692d503.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd62253-0c7b-4d4d-7ab8-08dd05857b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vawiFmyJdey2+MvJEtamDIw3MAw281X1dC8d/jy86niSLzCmySDrI4Dg1UZb?=
 =?us-ascii?Q?HGDRtmVelJvW+cn91T/Vr7j+pTCMkSmQ4SnjGbufZOt+GoOgEWUYMsWbueET?=
 =?us-ascii?Q?5XvuvlcwiRNzeMWoCgDNwkwOjybHuJYQHqrsI7ZmEBG1ALW31azz81bwBH8j?=
 =?us-ascii?Q?hnsqT1YsdaI8bWzQ95xBzxVyL8tZHCQKllXIsN4/1zfPZSE6PWoc4ggy52/x?=
 =?us-ascii?Q?1GJp4fknJz7M3wZHEPj/v3LK4g1m4w48asEuegnCewY63Qqlfr79rJHDA3P4?=
 =?us-ascii?Q?ieETbOI+c3cwzQSllD9+/3x6NBA/LtP2VH9j7LSt0kX/ozcGmrqefg3IfJQ8?=
 =?us-ascii?Q?gpeCr0f5Is/1xSnPIztVVBdHs0Lavsvqfoh0f1VCsW4pEWdy0NcKjxLD4G7J?=
 =?us-ascii?Q?fKciKOiwB4XJJUXEpPxmsVeDxup84gOMoDAhuaYttB5y6YLQjVISXbU2rcYj?=
 =?us-ascii?Q?dSRTACXuM9Ebz1yWhHtl/2b4wMa5BSE2pistkDjBtysNyk8p8SUwRkzlSPeM?=
 =?us-ascii?Q?AO1RIAkh4jPCEHTZ+jpLlcT2rLIPwaFOLejAybBnHoaRhsEL6VvQXBXrqnfb?=
 =?us-ascii?Q?/G4+wsxGO+kutA+bP8u7aRP2gR1YC34P717vNMpSPJ485oGpCW2v/Sx5jnRZ?=
 =?us-ascii?Q?45ZOaJe4/PYGRkaKpzTnsUsFdclZYcRrl8IbicO+ri8XFt9TrU8gCWQD9it1?=
 =?us-ascii?Q?5uWkeie5ysiTLRP8achdc0QzgI6ae5i2gW0p4KEPQm3Uwjq1bfqueFPjH+8q?=
 =?us-ascii?Q?Co0T3OAC0E7HcHrAFf72t38uJSdpQIAbizNyuPm8FPZP9gWxCfM88dvJe60l?=
 =?us-ascii?Q?m00O8YghUPW9jzTux0X6HqpNjKEYkTQMXQ/1f92y3QJjKZ5gITgojnOy6IUg?=
 =?us-ascii?Q?j0LI2dZxfGwLwks/UtY/tLSip0YBdkrU7AqxBNEd3oHJkCRCxe34v231zPD9?=
 =?us-ascii?Q?C88KSBBXl/m5TaVTHGqe4djXQAt7Zteo7Tc7D63fbqAIAslrTXBthQZgJzbY?=
 =?us-ascii?Q?9O/GG8KiPlwCjbDYDH8z3we4Pefi1k9hvQoTQYS0pLV38zhnDBgEiyFxkm0v?=
 =?us-ascii?Q?KMvSa+5OzhBAXnk6//dpx/2ehJtqnw5goTKv5YwhROc6/RxTE9MwJfJkOC6K?=
 =?us-ascii?Q?bQWUBWnmxsiosWFJbrgEhz3iaCQy7RZN2xay0y9gCMrJ/SUcXL0gpxD4IPS3?=
 =?us-ascii?Q?Ua3iCJNDOYseQA+ORGgafokhzz/2aU4I9HLv/NrZLdWLSVVhE8wzdFrEjPhJ?=
 =?us-ascii?Q?vorvDuljP/FzRpl1/LEoHeSrFup/bXH8YL8qOvs0hC/aiMltVxZQ7gaCudML?=
 =?us-ascii?Q?h4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3oqqwDtQ2E3U9MyPRluTcypEoo2zdlQ0N/+LKCK/apOjrB55ys9YaK9/Ljyx?=
 =?us-ascii?Q?SEJ2pZnRoZYOYOIBGck2ZIBNCJqdI8Ma9PV6UTgHC7YWt2vnI8OHLo3x6015?=
 =?us-ascii?Q?puNral894qFeYaRuBlZ+I+ijUqKFRTGxPpLIvDihgjKIPm++pa/9minji7WP?=
 =?us-ascii?Q?SS9X3NnMSlJPzrh0KpiKqMzRzPdUjGoct1LvIhz47lCrucT4/NJZ5N9M3t2V?=
 =?us-ascii?Q?T1GVotmdRPhh5ixaLOuYei56Vtw3HHQbRmP3j68CD8I1CzbGSJ2p23fogX3g?=
 =?us-ascii?Q?lF1lSAWnco4FrDT+kAL/30bBokwHfXT+9fg3ugYczRbaO7jncRpfBGn1qwRR?=
 =?us-ascii?Q?SKuOOCKYoRMhEJioMFXm0yp3RERavs5YDLi13Y5b8kNiCBf45CxMdRRPzmHP?=
 =?us-ascii?Q?ZpMcV3sMqpLQn9TFHmGJkuYnsxG0oSVSl0+Gfm/KxcX/PEip7O1Dae14R1uK?=
 =?us-ascii?Q?WtbOBDpBX32YKX8SqTAc0yHNPSPk9wbgSy8J7BLtnZyT/TukaiN4SuaGD3ih?=
 =?us-ascii?Q?LBz6YV1RSoSdVK9j5JH5dcF7atwSDrli07h2IpR6cgndDPfYMfQYVhwX16Ix?=
 =?us-ascii?Q?x+FikAMlWyJvL6F0z2GHrMEbI4EyHdxDEpOZHktJCF7gzDgrepvudUu3w2yp?=
 =?us-ascii?Q?mH95UqJSnCE6NhyM7dpWXtpP65RZWJdw80zK9KfsJ8rDtixllCKFbGUMUP3l?=
 =?us-ascii?Q?QInzQBTsffAfr7pY8GZKCpl1PWSdJAnQ02rywvZSwraXne2ZDCcOhNUiJIcr?=
 =?us-ascii?Q?SPTX14Hm8JvyMoRvC0KiA8R2PYZiPcP02mxl9vxcg6JzHS2H73MEukc6vXAr?=
 =?us-ascii?Q?k2d1cwxheBmvnqv3fZS/j/jOZMv+gnWNbya+OKdf5c+Jm/ANgn2T0j9wZ+RB?=
 =?us-ascii?Q?aXrgKxDKtyV0Ei7J9O6s0C6yY3YUUOTwCzmAKytme3SA0E19lH64JQ/0bLnY?=
 =?us-ascii?Q?F+GgOltQROz/NchCgcHgKCoNvcEN1dvv6rKGaBAkMWGGYqcM4YSJLRFxGSaP?=
 =?us-ascii?Q?JWx9hzHrkpN8pR072z9KHiWlMcroq/FZjBT9bS1b/dI13vdd3e+FeKkQqF3N?=
 =?us-ascii?Q?1VLr3Ln2yIxy2ObP21nRam8kRwe6vaTT1n7FfMfjLT8ttPTYvdxerZOSZHiO?=
 =?us-ascii?Q?eXPHJ6nlpQpTNAOJXcde7OkGNx6mnYKfj7TiDjaTJf7sy+6YAkgMms4P46mM?=
 =?us-ascii?Q?jcyJCL1nClWN7qKzQIF0cUshz6CBSlLGY5f952pvGUM56WOm/vF3GPbrjKaO?=
 =?us-ascii?Q?2S0c4KnGZTsECRYkYYXEh/cwTr6sb78NuYOlQHJYmoezG5dDSYFe+YkGkaAb?=
 =?us-ascii?Q?YnYGh+Upmapd7MDK9tsx/QCQLQO6Wyn84aSItVZD4RKHXOsgypCOcI5BLGLI?=
 =?us-ascii?Q?ZoEO9zM59KnyoxFQ2SAtuvdKF7oI/o/EKhKO+RW2h1hgBzoI2PdWjt7tfLXA?=
 =?us-ascii?Q?qyKDAaT3tvligauwqfaCaBg9BBEYyZsoF0fYZsmnzhV4lg5K/0YxAyEMiNXa?=
 =?us-ascii?Q?VY0qJJaJrOfu3aiou3oY8ZgKE4J484m3n3rYcb6Hs0Z/7LdAJYaHIWvTVvBB?=
 =?us-ascii?Q?N1xhLjTS42m9qqdMc7eGnOVaU6yEwGc+LiVrAu4w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MlVwC5jUjlEGQ5jv4FcQRFcwDZ+3NbH0eaBEwtIX226+GsBMEVY/nTMCWC98KFemeo0n5aQjEwlHOGbK5BMOL3VWAnCgPSuvx5jn+NkQD/8aGlmukNTgiuyJ7p+nsWZTPwZ6ogcT0oIXog2yunaLd9lkFZK1PqzFmb69qOV1sMzS8ptk0qwa81Uun4uAiiIfht42kmYBmROJTubEDRlcy80UB/xfMJvMBQj/JM2fkb8gb23GGSHuoA0bKTiT1a6aD6lum7gOTcgMjPkPm0yJ0q3T9AKGxPqHt9DinaFU+o+joRLzP4+JJmzMvjZYegpOCOJtqiv3VJfwEsZbh3eJQcM5vcUI6JFI/A6oxiLDpVdL+B9he9e+QO032GJS3Q5GX571jLkEtquP/QT612oPGz4Ob7DoEFO5x/8w5K1DRY2gr2CgAc2BJasX4YC2GysBkutEFjCTkkvxvJa38DVH+GqQj7Ktu97Kp9xCZTAjzRs3UTbbtQd5GvWMJVOGDsk+SZxI97fOq0f++zn2YQFwyBVKzsdra1vtGYusvhl3hI4gkoLNfL5OPpvkFNsAiqi1TeLxGy2cpS662lhfmqL3sUqb7PQ+tVdO14IKQkhdvrk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd62253-0c7b-4d4d-7ab8-08dd05857b48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:55:01.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZgYgJb4VviM7J9ujFo5gZETJf5SVuO0fac30wwsSLUk3RxzKLCqYwmR3qj+TGUxqTU7e18OYpfPweWp3y+AFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150127
X-Proofpoint-GUID: cSk4ND68x8ABu8fmIX5l2zPH1f8zJtC2
X-Proofpoint-ORIG-GUID: cSk4ND68x8ABu8fmIX5l2zPH1f8zJtC2

When there's stale data on a mirrored device, this feature lets you choose
which device to read from. Mainly used for testing.

echo "devid:<devid-value>" > /sys/fs/btrfs/<UUID>/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 34 ++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.c | 21 +++++++++++++++++++++
 fs/btrfs/volumes.h |  5 +++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 092a78298d1a..96d0480d1b9e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,7 +1306,7 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-static const char * const btrfs_read_policy_name[] = { "pid", "round-robin" };
+static const char * const btrfs_read_policy_name[] = { "pid", "round-robin", "devid" };
 #else
 static const char * const btrfs_read_policy_name[] = { "pid" };
 #endif
@@ -1375,8 +1375,11 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 		if (i == BTRFS_READ_POLICY_RR)
 			ret += sysfs_emit_at(buf, ret, ":%d",
 					     fs_devices->min_contiguous_read);
-#endif
 
+		if (i == BTRFS_READ_POLICY_DEVID)
+			ret += sysfs_emit_at(buf, ret, ":%llu",
+							fs_devices->read_devid);
+#endif
 		if (i == policy)
 			ret += sysfs_emit_at(buf, ret, "]");
 	}
@@ -1425,6 +1428,33 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 
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
index 97576a715191..90d84fb664aa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1331,6 +1331,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Set min_contiguous_read to a default 256kib */
 	fs_devices->min_contiguous_read = 256 * 1024;
+	fs_devices->read_devid = latest_dev->devid;
 #endif
 
 	return 0;
@@ -5964,6 +5965,23 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
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
@@ -6047,6 +6065,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_RR:
 		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVID:
+		preferred_mirror = btrfs_read_preferred(map, first, num_stripes);
+		break;
 #endif
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 05778361c270..3b7ba202b169 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -306,6 +306,8 @@ enum btrfs_read_policy {
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Balancing raid1 reads across all striped devices (round-robin) */
 	BTRFS_READ_POLICY_RR,
+	/* Read from the specific device */
+	BTRFS_READ_POLICY_DEVID,
 #endif
 	BTRFS_NR_READ_POLICY,
 };
@@ -440,6 +442,9 @@ struct btrfs_fs_devices {
 	/* Min contiguous reads before switching to next device. */
 	int min_contiguous_read;
 
+	/* Device to be used for reading in case of RAID1. */
+	u64 read_devid;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.46.1


