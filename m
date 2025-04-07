Return-Path: <linux-btrfs+bounces-12825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5149A7D2A8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6195217075E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2E221DA6;
	Mon,  7 Apr 2025 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JBg1vZGv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ar2yzZiT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A2213257;
	Mon,  7 Apr 2025 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997768; cv=fail; b=qJsNxAjkLER/orMummP8u+fGSM8EQWS342UWVuTIC8kMLHgg9LeEvBRJhoWW+K7ZL/WnbXGrwNAVv58pN2ndZ5wrLJDQgQRbHAE3VyYgD2BTbBARRkdX0yAySKIy1eMaL55KZH28e9bEOHe/dhqM5Y9Z0okyS3piXod69oX6BZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997768; c=relaxed/simple;
	bh=8O+mOxwWoCZC/4TMt1LkcM915iCsPR7Vdndysx9ElIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjCLN8MdsTzH0dBKCFIoqTixp8Ul9hXQARCl8nVFQgVeM5fSqBRNf85dD5640yhAjg+p/ldsjqrgFWZ9KTNmVcFy61GLgALDRu1GOzrggNfJl197IKts/nghUftcke+LBltED/BWmz1KwvUA1lemPUQdLM6uTMh9XZ3uc8FTP3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JBg1vZGv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ar2yzZiT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371C3vC012899;
	Mon, 7 Apr 2025 03:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KAXYr+gRlvh7g0ktxqVdb+E70cIJJfCSDVGoA3Fwn/Q=; b=
	JBg1vZGvKNFVOUwHpXHx/SjuJrIwnsVlTuc8g9ec0hO30NW0i2l/EtPqsbTZuh9u
	QF2KoQF6Bpjm7iLN2dtGwve9hpKvwnR/B6OZTXUY++NAcBo+V/UZIsyTrgWj2NZO
	4rIMhK8XT97AySn1BQ7vApHYFtWzh+qg68B0PUPj1HYuUWHEdie2dNnvVyrs7kE1
	MFY43UzMCyw3ZN+c6X6+0Ng4SS4Rk9nSyttFXSHeiuPs7AxwRHFf+IylPrPNMm27
	sqgyOhlIEp2+yydzX/1Nre5YngbUwdLv21CdV16II66cgvwEhUvEToaLZ8Ze0QuY
	h7CqMRaV0GjyqapWZ4dopQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2thp3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5373QJpZ023888;
	Mon, 7 Apr 2025 03:49:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydevkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjrVz22YdL8R4eZ5CLcL1kUUubgBQO8DSf0Md4VobO9JnmyssKCz0ekUNspyZKbY0MxB5UFQkny7aIU2RHQSC3ljwOe21SzAGhu/pLb2U+kcVu4YjQwjYW6VY3Nvdpn24whKzmhk/l/gIxU+TmJEEKf8fs0OPt+tVhAH528jJOCXJ0nBOXm3F3BoPY1tTNFp4p0r5gbDSC9dl1tei9EjthrEKmSWFwznEMang8w5XivtV+jt4BiigZpDlOIt9uJO6eMnlOGSKNZK5tMzVpFgkcIjv3zyWDtwAOfb6Z2dmo16EvmA2HoFVHH8pk7AXytGzBahacNnifwbzXf8LhULLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAXYr+gRlvh7g0ktxqVdb+E70cIJJfCSDVGoA3Fwn/Q=;
 b=V8A4691yk9JOoe68R0r0ZM+SU26WdkFs1UBLtH6iPHiW2wpMkKJYXvOPpvqvp4O4p0AwsW/piC0rBHvg2OFRJ8TAyYZgQs2ZeLtmnq1tBc4k3ZhVCe5oy1EkZD2qCYIkZG2kFd4Ou0mHEUBal+ny5faMOe84mHsMIsGi61vsKnCVLCqluZPgS0ircswrmPGxmA+yUj5t7u+lsiDdrePGdZWg+fV5HjvyAEaWmFptCpLFrOz009OTQJNntxTMsCigC+YR51OXILgFLZ2bz8UnwRrvR8nlYuIysvM43D2JRD5bOpvDNarBu48V7dDR/peSjawbcCjL6408f3TaTHjzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAXYr+gRlvh7g0ktxqVdb+E70cIJJfCSDVGoA3Fwn/Q=;
 b=Ar2yzZiT+D5nczNhmWN+tu94yhQeU9/h6RisPrKp08DhAbz5c/nrXgypxeMoVMhNlEq8rVKUNr+Lao4XJBsHA0pt9EfRkAMRjVC7ZXW69x22SQoVcHhuS/fm6FID/PACKBFjIbEAo7u6upYm1Ebw01CbcncIRDEDpYvy0FtJDp0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 03:49:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 03:49:19 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v5 2/6] fstests: common/rc: fix unset seqres in _set_fs_sysfs_attr
Date: Mon,  7 Apr 2025 11:48:16 +0800
Message-ID: <5e081252abdcf7253ad83d2b5eda49a8818305ad.1743996408.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1743996408.git.anand.jain@oracle.com>
References: <cover.1743996408.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df8f2cd-5f2f-4e8d-a81c-08dd75872d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzUwYXpRUkhPaE5mV3NSQTllL0x3cDRTZmtqUUN4QmU1c3NxWmFQS0VTRm1W?=
 =?utf-8?B?ZVUxc3hkdEJoMXF3R0VzcXlaUlJaQU5OMnlLWEhaOUdGdDJSc2FVWm5oZlJj?=
 =?utf-8?B?SWgzRDZzaDNsS2tCMDhaTWpqdFpic0ZpZ202eTduNWJNQUJIclA0c01sYWR4?=
 =?utf-8?B?MjNOSWRWbEZYWThZV2I1T0c0WmRqTmw2UE1jckNxZHF1c1hIY0FyREUrY3Nv?=
 =?utf-8?B?R0lhZ1pRL3U4UzM3N2QzR2xuSUlPT2ZUL3pESUIwbXBQd2YwQ0NSOUtuQll5?=
 =?utf-8?B?aWRBQ0RwQXRMZzQ5VGd2MnJLTUxBcFdvWGRWcHh2TytPeHNaNUpOV1IrY2p5?=
 =?utf-8?B?UWJJWXNqaGRGVEFLMytwOUZYbmFQbFlQQ1VYZ2RNS25kTmlzVFNPb05OVk1E?=
 =?utf-8?B?VldML2dwdUxQV2NYOVZwdUoxb1d1M2taMHUrcDUydzRZUzYxSy9mOUJCRjhY?=
 =?utf-8?B?bnFOK28xOW5XQS9EMkIrTmJ6QlN2SHppbEI3cjlFM3VQcnMvcFQ2Q3FVdmp6?=
 =?utf-8?B?R2xERzJleklCMFZramoyU0w5ZmUxcHFJcU0xR0cyaGlhK1dMbmVSZWFQN0JV?=
 =?utf-8?B?YUJiMmZqSG9lYW1nSy9CNVVEMFpBQXc4dGd2MzByZ2wyR1FzY1R2UW9JK3ZP?=
 =?utf-8?B?ekd0RnhPbVB4bStXYkxFVjJHeDhrQnd2bG5nWXdsTi9BeS80MGZoMVVRY3NR?=
 =?utf-8?B?cVEyWlRFZlBhSkxsUDZzWm1hcVVKVzl6aEVtRk9EeXlFQUNRSkg4T09Bb21M?=
 =?utf-8?B?dFpKRTFDdEp4ZXV3N0MrclZ0d1o4NVFqRWZHV21nem9PL3BFL2FHL3J4bkMw?=
 =?utf-8?B?V0R5TDkvMmQ4Nkt4M3hscTRpb3VIaFdndkJUc2tYNEtTK0Z4M1BaTzZma2V1?=
 =?utf-8?B?NmJXTm1ER0J4T2xVZnFYV1F6YVhSbVlSc1N5TTdQMEwzZXRaNFZ3eEIrSXFE?=
 =?utf-8?B?K29QSzh6TVUxV0g5VjBObmN3TzZoU2ZPZ2xTNE1CelU2YnRwWTNTL25PUEJ1?=
 =?utf-8?B?RW9XdmNiSU1zMEdVZ3ZaWWYxVytlV3paQmNSNTJiTktoajVNTlB3NVlTMTlz?=
 =?utf-8?B?ajNwU2dZMVZjSHg5QTBYakpXd2NjNkdGZEs4d2pHVUlneGlBbXR4OG9BTGFC?=
 =?utf-8?B?RTV1YVRpM0kyM1pMZXZJbjhCdzgwOUNvaGg4WEpUZGVWVVRwa1BNL2tudnBT?=
 =?utf-8?B?YWIrMS9IY2VXd3VxclJxa096NnVIc2QyTWtCVEZZZ0hLeFBuam4yUnN0VkdW?=
 =?utf-8?B?RVp1cVpiS2Fxa050ejV2L3h6RHRabzlPbERFSUQ1Zis5dmM2T2JWSGE2MU5j?=
 =?utf-8?B?TXc3bnloYnc3ZHgwZEdmRGo3NEhrNU8rQ0x4K1pCcWFHWWFUZ05pSVRLay9Z?=
 =?utf-8?B?QmRGcGRXZXlxd25FK1oweDd5NnV6eEJvREsxUmdxQkJRUFlJQXVoMVhyVjcv?=
 =?utf-8?B?Y3laOFEvMjdNdU82L1hvemVsSHJZRjF5QUFXOHhRK1ZJTlRxM2g3NkQ4WDdU?=
 =?utf-8?B?MDhXaXpwSTc0ZkQ5MGt5OEFYczdOa2YzWVJKQ3MrQ0V1dzA0UlI1QkRZSHho?=
 =?utf-8?B?NFJRNUdxWXVoQ0Q1azdpSG00S3Fnb2RBMzQ1TFhsVHhWL3l2cVZmWWFZT1Rw?=
 =?utf-8?B?M2RJWGRYY3BvQWVkMk9FSytEcmNsaDhSYU1NOHdNSC9sYWFpS3B2N0RnRHZk?=
 =?utf-8?B?MWltVW9qd1FVaXY1TU5RcFRYSThJS3RBNTBLK1F2OWJ4dTNBYXRmMzFGMzNh?=
 =?utf-8?B?MjFIOHZ0RjRyZTVZUkZGMEdFWUVkSzcvYkhzMlF3ZExuWnVkK2piNW95R0hB?=
 =?utf-8?B?Zk1yaHd0MTJVTmhTYnVqMzZmcXlxQTUrM05qTnJHNkNPQ2p2ako2R3FZdDk3?=
 =?utf-8?Q?xra98wHsf9Vs7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGc3UTQxMFNCaC9qKzNVTlZOa1hwb2pySGowWXk4dGdGazNsS2FnWGZWNFBj?=
 =?utf-8?B?dStoQkc5eWdLWThrRE1ZcXk4Ri9PZ3ZNZHJHVnI2SmJ4djFlZHZhN1FWVHFM?=
 =?utf-8?B?cmdkaFZ3OFNaemZXanpkY2lqR0VzdDMvSmxxbjNHL052dEFnWVJVMTBqN21z?=
 =?utf-8?B?UWtveThCUjF2dTdibzJZcGYrbnM3VGlONlNla0xQVGtERHJjZWMzcHpTM0tj?=
 =?utf-8?B?VlB1S0NnZ2NiSUVVQ2RuRDdnQ2Vla3R0YXZHVFFUbUt0SVZ3N1Vtd01YUzVN?=
 =?utf-8?B?SDVHTSszTlhaakhYd2hTVVlYOGVrOVlwYldzQUFEMmpOOTYvbzAxWWMvUlYw?=
 =?utf-8?B?NmpWL1pNaUJZd2xLaEdueWRWUEJsNHZPL1p5ditDT3A4WEFmNUIxSVdwTTVs?=
 =?utf-8?B?U1MrY0N6SHZ5NXk4RXRNc2tMK0lhdkM0VVllNjRaa3M4UXlsamJyVVFVVlFV?=
 =?utf-8?B?U0FybTRNODcvMzRXbGk5d05hRkF0RU5RYjIzc2dvc2RzTEJKdjlVL1Q4TDhv?=
 =?utf-8?B?V2ZLZ2F5aFVReGhwSjJhRjNPQ1B3OG5lUHJxU3BKRStiNWVhUXJTOER4YnNS?=
 =?utf-8?B?UWpZYStnWXRTMmQrNE9oMEdYejBKb2QxRXk4OEh5cWVPdUNJNTFCZEpYYlZP?=
 =?utf-8?B?STE4aVJVWGFFeWdJZjM0dk0yZitkeFZ6RytFUjdoZTcvbW1rekhyMjE1OGpM?=
 =?utf-8?B?eU5WY0tpK2ZLSXFNSWlSd2NpS3VESjVIU2x3WlZkTDZWK1N4KzROS01mWk5C?=
 =?utf-8?B?OTVkYk5yQ2c4bGJYN1EzM0UrUTdIQlpsUHZ3YnJxazBNV3FRSlN5MVlrQ2g1?=
 =?utf-8?B?Nk5RQWlKd3EycS9TRVVqck9WUkEyMkM5WkVTa0FqRmdDRUlXOGwySXZFb2ds?=
 =?utf-8?B?OWxnNll6aXVDa2JkTmNNM1U1bnRaU2pid2hYUHA0Qjl0VGtSNno4RjFPYm95?=
 =?utf-8?B?WDlaSGwveG1wZmRVS1FEZ0w2d3UvWFFzUTBtdTFMdlo1NStkdEdzUGQyUG5D?=
 =?utf-8?B?aktMcllZMnJNK1VIOFNXR1I4aU9CbWsxa1FzOVA4RzhGZXV6SnlEYmIxWHEv?=
 =?utf-8?B?aUI3SGNrNGJZdHlKY2lCekZWaTRXVXdTSlJNWDF2akU4OExmZU15MnhWSExJ?=
 =?utf-8?B?bTJTc2lnVzhteWMxaTNrN3dMcEZnbFhOV0hXQURYMEZ5WVE4MW9ObkE0Y0sz?=
 =?utf-8?B?bzZjemVlSzJ1dGJOMkE2SytSU1dQL0ZHamtOcnUvcm1YTkRyZnBHUkJtNlcx?=
 =?utf-8?B?ditjdEZ3TEVHbk9JZ3VSenBuckdjTVF3NzRMOVdGSmVPbTA2VS9aaWp2cWpZ?=
 =?utf-8?B?UitLenJKeFNaZTRuWnI1UE40NGJNOXl0b1dCcHVIUE1WVW5kbVBvNU5LbEtV?=
 =?utf-8?B?d3JQeVZoYzR5RWxpY3dEYmYxTngvZzZuUFZHdmRMS3ZVako5OCttSDU1OHM1?=
 =?utf-8?B?QUdHWStXRnJDRDRqRmJyQnVZa09FZW9JaWIvUDNpNUJ4aHNRa0ZUK2taU2Zi?=
 =?utf-8?B?Tnp1TWNDM0I1dTB5eE4vV0o2bHhqRkZCalZ5bTlvL0tqYUVRMTNnakNjSm5E?=
 =?utf-8?B?dVNhM1BxYnY3dFNIYkZVdHBPTDNOaC95eExlV3hIVHlITnc1akgrWEFXZS8r?=
 =?utf-8?B?YitibzBsYTNFZFdlUnB4dk1yZVZMN3ZhM2tzOW1QcFNZWTZGdDFyNUlPRXRK?=
 =?utf-8?B?aGhoNDFXNUJLUU9POWtwT3hyM0pTZjJuS3VNUDNMZEZ6VTNpMGY2UkkyRXhi?=
 =?utf-8?B?TFU0clRKRnFlT1pvVzRqMTd5WktKQWRvV0FDMklnbFlraU9kdFkyQkF0N1hu?=
 =?utf-8?B?cUgzUVl0U0F0TXY4SEgrcFh5OExWN3huR1k2K3pXdFg1OEZwRE5YWERMOGdK?=
 =?utf-8?B?czNhbjFpK0t5SWxidjZpY3diZXIvdFVtd04vN2k4TUJrSS9KUWZHeU5SdWtB?=
 =?utf-8?B?S00yNWhBZFgwNXppbFJNZnJGeWVlUTRHTDVGRE5ndVFqZzZWTjI2MzljWVRL?=
 =?utf-8?B?Zkw2KzhDbFluTzMvQXcvSDMvMmtleDkxd2k1QVJUdmdHL0txQzRCZFVXVXZZ?=
 =?utf-8?B?aVBvTll1Z0FsOG5LUmw4UVpGazVuL04xYURKOFhlblJkRTNVZFdYY1BaaFlu?=
 =?utf-8?Q?6f4KlQbVYrEhyv+8Oxvmh0xMC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sdkS1P26EHILIRsPLZzflzcaXE7aBFG5DeuYm8Y+tHXk7jqlyMN+NM0xCXjej+QiW6SG3orI1utfnobw+yO7sPnf6JUdzk2iniieuW+re+nqdh+OJp6WC23eDBpRAg8SrOKT2k1ifE1jMhxIgR5T6KgmDYEuYnnUnWriPWzJCw6Y/JtEEVJ8bo9gJfUh1AJc62oYsQOCmrolgC47WkQKPoE/VL1uSedTCZEO9oZyrDc6znpkedYEmzGsg78yBax6m6gmhaNp4jiCX2bS09MTn4lGtt1vPai6CjvsyjxeLa3Xn6CnjduZjcAtdOHqreOMxn5p4UXW2AOvhxgu6FKQ0IeNBSzeac2mkWprAQ2l7nPRxLbtWrkf3AUZC5u724hIMFt5XbQZJByEBpXqQ153i4fEuz2OkS15WVP1zmJtTg0MeOCg9Y3r9RR+K3L+aa7sDnjuFT7yovEQHsWvdwpagP3uhl5kMq8h2pFVb0peU2xIaDqc5qna6Z2+5Kv/A5GwD/i3taJqp5I1nETbysrMwLQeLH1H5ulGdptSBGD0/jLl6jvldTtzVhEsKufvi8hjh/1HjysbCjQ+szi68a1YlAUJAP6TPYnUnwShb7MbcEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df8f2cd-5f2f-4e8d-a81c-08dd75872d2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:49:19.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKnRKJAV51yTJGOZfksSZylczeDG7ym8uPJF3vSaLcU8UD2yjyhLUCAvGR16LKvATAtVp8H4p66eeCQ51pvIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504070025
X-Proofpoint-ORIG-GUID: TOUCimtFV2RxSH6RnAznmLbIv2ksdZD1
X-Proofpoint-GUID: TOUCimtFV2RxSH6RnAznmLbIv2ksdZD1

Ensure logs don’t write to a `.full` file when `_set_fs_sysfs_attr()`
is called during setup (before a testcase) in XFS due to unset seqres.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index e89eee5de840..ca1d13ca1f0b 100644
--- a/common/rc
+++ b/common/rc
@@ -5201,6 +5201,13 @@ _set_fs_sysfs_attr()
 	local attr=$1
 	shift
 	local content="$*"
+	local logfile="/dev/null"
+
+	# This function may be called outside a testcase during setup,
+	# so seqres might not be set.
+	if [[ -v seqres ]]; then
+		logfile="$seqres.full"
+	fi
 
 	if [ ! -b "$dev" -o -z "$attr" -o -z "$content" ];then
 		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
@@ -5208,8 +5215,8 @@ _set_fs_sysfs_attr()
 
 	local dname=$(_fs_sysfs_dname $dev)
 
-	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
-	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
+	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $logfile
+	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $logfile
 }
 
 # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
-- 
2.47.0


