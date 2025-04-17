Return-Path: <linux-btrfs+bounces-13140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA77A91E9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 15:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B671919E7582
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990E24339C;
	Thu, 17 Apr 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbfPLRVG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wTwbHzpV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3D86358;
	Thu, 17 Apr 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897724; cv=fail; b=qrTtHccoeN38OJeXlqy2/IVSsiDwcAa4KaDaVDD20VSEWTHZoPLaDUEKWJbPsQpXfAmXmu0B5XwJ1h5xF/I7mrF6KOpMis1tGeBjiK9l4xcn6sH7iOsQuJuwi4LhmFi613URQzc+DjWiK/UOuTu6niQn9bMnkIO6thCZgWudQr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897724; c=relaxed/simple;
	bh=DXVM7Hwi3NJ05MG2wRvbP1+cp9A488YTqd1IftMCtYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tIbLy/4eSLxTYOhTZCDslzVm8rUQJNi9WFOBzEgC00NUR78yQBXiTZpk0JiDsKchcsB+Hklivh54p/FiRO+I+p2djmbjzW2pnTwio2vhaaQgvZYyjNBmGbmIXC0EmnSLahwB1fq0UHmoggAlKSDc7p9D4atuRPUVPjbxc5E3Jbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbfPLRVG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wTwbHzpV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBqQRV029425;
	Thu, 17 Apr 2025 13:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=6WJP9GIYwUVVRdzo
	Isp3N5QdR3ia6mGoImSBoxTcVqY=; b=JbfPLRVGEnX8EZaP0LS2xT3b4P2I0T2Z
	Y6zEXRCaCBguwqFAqoG3V8oiEXGAga82wBcHThTTEmJCPqOVgMHjarl4mL1EJDz0
	gVTFTeDsMXV/5AYBcBnjOhjd2tUMOY1a1bTc9l29UI1TaVanqPXQXMrUGfH+wHJe
	Y5VxvLZylOKBz4mD/jjBrv3NeEZAwqnjF/VOeR9g6t5waeGzIsDAah9hpywEposk
	H3O6So9onYvWkJGwyd8RFQWMC9wN9YpezQvfI6sEIm5NbWZ4CGZ1/oqqlOfDi2u8
	dgcVlMA4rzFu91TSZndArbs8+r7qLbr5myOzQDCbPRBROl9ENVk5Nw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf6mv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:48:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HCUaOR038813;
	Thu, 17 Apr 2025 13:48:37 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4uj7e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRhpuoUu9XrSI/puSPSqRk8/fmaWaEBHlZDvYVQ2jEbpq3XecJdnsGcxxO9JKDkt0x6lh6pU4+1+H3rzwqUb6PbuBAICmuH36M+pmQjnAfPpHh9V3Z2A8xNyE3G7HilIKmJYBpT17r2+5gmzkjuCoq1BLVMhXNh5ubSN/QdL+uxjH8KAByQbZtNMgE4529whBE0LRaSQrrlusBM+w/a6E6h+aiKA/n5ph1Qk43WKPhudDRrME5P6srrK6vzTp/QnWwZmNKAIOusw5RQPTD4/+0DpBdD0gKurDSbqhPlol7GF4c5KQM9YZJVeoPYVP7IfugJqv6fDIR/JGNx3Qo5Lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WJP9GIYwUVVRdzoIsp3N5QdR3ia6mGoImSBoxTcVqY=;
 b=l7xG5+QzKmYME9UW8Ov6PRoEdvDb7e6YdEVTHacqnyOQlzh0Dpg4SQQqYZcuTsZyLa4wK6xEB3knkB49l3ssy55SBIsiS+lELcLUav8GP9Ug/PwU0BObkq1lEmv6tA/jjpHYJ+Jx1bR9BQNuQ+WVYXKdV+5I7kUhuVmnZalzSkY9nzTDO+N9SMKBdUN1w39RhxulZkyYOuMjkQVzz61F9B9HYNNiTpIvLLNdGmV5eQII8CLIgaL/zCW9XPLfQxS9n4n9W2xt6DUznZdoj7k6f+D5FGIH5CpzhSPGwrxvP+0X5rC4wCSw/CJSbjI3ScYvd4USIomHhP+fpm2iGgHMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WJP9GIYwUVVRdzoIsp3N5QdR3ia6mGoImSBoxTcVqY=;
 b=wTwbHzpVtHnUGgdmVy4Lfi0Eirw/k6WvSVAJTYbSd5o8esy1sjVLmBPIh9Qnt/Rd3pxrfjMC9N06zjAjU77KbzjpnxlvaHFXH3fn9Wv8fCe6qOE6LG5r2rn4ac4olKwszBEmR42RKfxNGGv40+cAM7EJcbBy94O3IN9Irym24LE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7759.namprd10.prod.outlook.com (2603:10b6:a03:578::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Thu, 17 Apr
 2025 13:48:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 13:48:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3] fstests default configuration for btrfs testing
Date: Thu, 17 Apr 2025 21:48:14 +0800
Message-ID: <0f088e8a83ee7bc0bd290cd9d8a8b830c74bb870.1744896454.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3c0e6b-c52e-4f01-0319-08dd7db68be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHVhU2pXR0xqVHBOTXhJZ0o2VURRdmVTTGpjK3A0YXlJY2hoSUlaeGhZRzhp?=
 =?utf-8?B?dHB4Zm4xdlgxSXIwR1hUOVRGU0kvcE16RnJYUmlmLzVYK1g3eCt6d0svdTlR?=
 =?utf-8?B?UlN5bXNQZTUvelFxNEFxc2dYc0U1c0RnczRpUlZ6cVd2M2NBeU5QdUtZUFc4?=
 =?utf-8?B?TkxmNy9kM3VkME1HZVVDMmt4K1FhMktyRVpJS0hNMERxaDI2cGxpZHE0dkU0?=
 =?utf-8?B?bkY3SE12MEhGOStjT0ZXYVZoYzd0cGUxTk45MjVEYWtZYlRZQUlVQVFyKzRa?=
 =?utf-8?B?ME1SRlJ3ajh2cFlaOTluNWQwYndzK2c5Z3NIWVMySzJUbW5MZFU5aVhTeUk0?=
 =?utf-8?B?R0pseTlrR2VPZUdBMUxKeC9aK2VudEtjWUdpQXRSdHV2S1hvVnRzd1hBMGRG?=
 =?utf-8?B?UVVDdENCWjZkN0JSZGVEMmt6QVlHSldjblVEUmZLdGtSbnFUVm5IeEQ2cS9M?=
 =?utf-8?B?VUh4cWh1NTh4TnpkTXE5WGU0Z1pvZUt2eGhLV1hYT2o1TlQ2d1FhM3dsTXBE?=
 =?utf-8?B?Qlh6ODMzcXFvUlV4UlV0UUcxc2ZUSzkya3doRUxNQ2d5NnFFYTNjd3FWeWly?=
 =?utf-8?B?OUFoalFXYTYxQ0VTV1d1elBBb2Y4OUtZQlpYZGVYalVzZDNoVGxXUFQ2ZVlo?=
 =?utf-8?B?alVaeW12cW5YeFIrN05mb3pnNUROK3JpQndJOUJrYWd2a1E1Mmg3UFk1dDBF?=
 =?utf-8?B?SkVLMXkxOWliTjkydUpvRG5xY0U4TDdXelRjK21CUnVzOG9CQWc2R1NJQmpP?=
 =?utf-8?B?ZUVpcWM1ZWZvMHlLQXRoaWNMc0RyV21BMm5wQkxrbzRic0FDNUp4OHBWTHli?=
 =?utf-8?B?bHFCemZCbUdaS01pdFp2K2g3YmNJQnNjN0xuVGZ5QmYxMFFiRU9UNzd4OW5H?=
 =?utf-8?B?QWdOenpVYmR6cGxySmhVa1IzSjRFNTh6cnBnSE8xUktNV0ZROFowVWpiNU9s?=
 =?utf-8?B?aWRCcVYyNFJxRkxFRVd4blpvUmxEbzZXVWVwZTNlY2FrMy8zMmpYVWpIOStz?=
 =?utf-8?B?MHZMOWpadkkzaEZUWm9tSkNIZFdkQTR5cFdlY2dtb0xpcW5sVk1XZTh3dTNG?=
 =?utf-8?B?UkczM09UalptZzQ4aXllYk5OUk1TcjJ3Rk1nTVRPbWxEeHYwT3BnSEo0VWZo?=
 =?utf-8?B?SElxaVd3a20yY2tOQXNMY2FDT1ZtQTd2SkZlOXpyb051OWQ2SkYraHdDVEpJ?=
 =?utf-8?B?R0xvd3hIU2NxZkF1L1QxZk9qWHFHcXFqbUVmSktaR25lQTV5QTZwbjhuRU1P?=
 =?utf-8?B?UHFxNStIbVBHZnczd2ZRVDNOSnFGMXZPVmZMWXZjdzlnYk53bVJwZ3M5MTQ4?=
 =?utf-8?B?S2UvNCtWb2krS1ZPaGtyOUJBRTZoYStxdVpWQWVEUGh2YjBSZGw4QU9jN21j?=
 =?utf-8?B?Z2tlM1k4NStLWHNPQnBBZE1lTCsrRGZsNEN2UXR3TEVxWkpRcHRSVlViOXVU?=
 =?utf-8?B?b1Vtd3ZSZVpZbXFLck5NRFQ4U1YrRFhEeWlFSkY5ckcya2JmMi8xMVdnckM0?=
 =?utf-8?B?dENIell5d0Vab21McjR2RGNFallxcVREWXpMTW9kcjEwMURIeVhGTlV4UmRM?=
 =?utf-8?B?RzBlMzVUa1pUR3hmeXdVZzdYTzJnVG8yRkZrdmQvQm9IZVl2WVF3alBCeEdB?=
 =?utf-8?B?dGlIdWZublU0Qmw1QVZjNjlBUFVIN0JndWNrTnJlajdkcWpYczVBT1d4UUJF?=
 =?utf-8?B?cGlGTGJudWdnUExadUxTcmlnWmR3SWxzcFdySUp3ZTd1dHhQdUNEMjVwY1Uz?=
 =?utf-8?B?dWZmcXZEaGhmSlMwUHM2Ky9paEloaWd2NUxYa092WUZzSWd4NXA0SjgrYW16?=
 =?utf-8?B?anl5ZU9odDdXakxpMThEM0hJS2lwMk0wdHZSR3krNGVpVGtXaE1PV3NLYlFD?=
 =?utf-8?B?N3ZCdVZULzVhTkxNNExZcGY2Nmc3WithVndjbHg2RkZJTEpwMFFQOUxlblBZ?=
 =?utf-8?Q?P1dqu6pxLoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWRCQkpYUmFCZ2xpbEdQclN5QnlxZ3FiS3o5dXBoYVduVVQ1SzFZSXBkQTlo?=
 =?utf-8?B?NU16U2UyRFJGekdGNXlsSitDckNUNVpJRUlleXJSemlwbFhLVGZ6YTFhZFR0?=
 =?utf-8?B?cEsrT1lXUmloM1VFU1pWVllMMGdGck5tVExlWjR4VHM2Z3p1bnJ1R2Z1ckM3?=
 =?utf-8?B?eVNRNkl1RmJKSkJrSkVXN1FRVEx5WU8rS1J0eU9rQnNZOXU4OWZUem5hSVVF?=
 =?utf-8?B?OTBCSTRTY0F3RUpCYXJqYnF5ckE5bjVQZzNwZUlyVkg1RHBndUtaajQwQXZL?=
 =?utf-8?B?aWM2ZUVFVk9wQ1VMWTVnbm9BbnVGRjlURHg5K3VFYUhKTlN2Z0dFZFVxalBp?=
 =?utf-8?B?b0ZrTUUvSWpqSGhPZlRkZlVuNEZwTDcrKzZOT3ZUb3lwKy96Qmd4RnJCNnBy?=
 =?utf-8?B?M2lWQXkwalBOK2RyNzZ3a3Z0clZEUGpRT25mMFBxTEp6emZPWXBZT29PVmo0?=
 =?utf-8?B?ck1IK3VNSzRnRnhmcS9wVVNoakpFbUxESFB4ZHJUN0tBajFKOHczUUhKYXBR?=
 =?utf-8?B?RGM2L3VSZE5QS213cUhPU2xwZTJUcTJ5RWhOQkxucW5mckVrb1ZEdnpDTjRw?=
 =?utf-8?B?cjIvVnZnZ2I1MDFXeFUwalloNWptYkFEYkFBeW8vT1FyQXVCc1VGdkhtdGRN?=
 =?utf-8?B?cFhEeU9IVmFKd0dyRFc4TWpSYTlZYUhiWkRuVUhhL0xuQlRxL2ZQbGdXbDVt?=
 =?utf-8?B?d0RmNG1LVC9wbkhmVXBZMWtXTDIzd3kzemorc3haRGp0ZmljWFJ6UXcrWGFm?=
 =?utf-8?B?enl6dFlENHc1QmV6UEpPb1FVdTI1QVg4NXNNVUFRb0M5S1huNUYzSUtyRUp5?=
 =?utf-8?B?TVd2QmZrYVN6VDlTNVlQVjNGSkVkS3hEcTdsMlU2cVV4UTJYR1ZHeGFVQ2hO?=
 =?utf-8?B?VXJlTStIUWJLSlB2UXNLL3ZXSnkvV2FVQno1SGpjQ1RQK0s4dk1wVDZrbitq?=
 =?utf-8?B?c3QvajZNQUcwbGZYdWZFdDZVOFZjalVBZFpENHJLRXZMR3pHcjRoRHoxcFFN?=
 =?utf-8?B?MWVmdUZad1lqWGZ0azZTOGdZVVZ2eHFvSVNiM0pUWC96MG5GOEUrSWVMZ00v?=
 =?utf-8?B?TDBHemJhRjJYY3F1MExwdThacm5hWnlpMTFpK0hPVUdhVmhtQXlLTjhUSjZi?=
 =?utf-8?B?NGRabW0xTGtraC9pTHRZL295bkFYdEU5VSs0djBiRmxQSktVTEkvR2JkZTVD?=
 =?utf-8?B?dVQ3Ni9yczhTQkppR1MxK21CUmxmeFlNKzFnSThiU0lLSko5K1AyZjZlRUZC?=
 =?utf-8?B?REdMSFJwa0pmOWN1K3VXV2hjdDNVdTRtd1A3U1pQb21wQWV4S1FGcVRPdE9W?=
 =?utf-8?B?R0lpZ1ZIcTJxbnd1NXErM1hqRFdra0wzdUpmY0JsVTd3NkZsNm96VW9ZTHFI?=
 =?utf-8?B?L1A4eksvZm5pSW51RlZwUU5qYlpySHlDcnpyaFBBQXVTeENhS0QweVF2OWx0?=
 =?utf-8?B?V0JtUmw5UUlOY3FuWldXNUlyem5ZRzVwTlJ5YVg5RjdONVBlT0N0dnhmcm5Y?=
 =?utf-8?B?dUFEYXpYZ01jQlVLdVNmWUJqTklabVlna0dNM0NPdkZmV2JXMDFIN05zNk9I?=
 =?utf-8?B?VWlnWHYzV21hNlYyWTBHNEZJSGcvNFM3RzJ0eThsRTNIUWtBcW9yOE1hQVp2?=
 =?utf-8?B?cm1ScVZoVkNwL1M2UGdvMmppcjBTbXhSUE5EWkdkSFI4QnIrZlU4ZlNqMDBR?=
 =?utf-8?B?SGQvTmxaa0hUNUZ1cGI3S3FydzVBdElLWVp6eHJ6NHFYbzlqSW5ISHQzc1lK?=
 =?utf-8?B?SXpzem5sU2VGdkhBYitGRGFRR2xSRkE0R0FNck1PdkdoVXpqb2dmckNnOTBs?=
 =?utf-8?B?MWtaR2pWZEhMS3p5NVk5Zjk1NTBmSzJENDF0bVl3eExnQlEwQ3VFRGIrak5Z?=
 =?utf-8?B?VGNDOVRQRlB3cmVaVHFQZnVPSUFHVnZlVFBXZTRuTG0wL2lsejY1bXBWYXdl?=
 =?utf-8?B?TUtXUkZ4Slp1RUVGVU8yUlZ4YXVwaDd5M2pEOFZ4RWVqOGxoQzNRYXpQaHh2?=
 =?utf-8?B?MUl1QVdIOE1ycFRMKzBVaFJsd1J0NHczNEJreWplVWd6REVsTUl3V2hUL3R3?=
 =?utf-8?B?VlNJTFN5aSthVXEyOFZCbDJWVGlJYU84RjhKaWgxWVB5S3lueWhGdHRWYVFM?=
 =?utf-8?Q?n4MCcV4eBasPNSLTAvlS8drQI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DAwl60EqH6WAH/86zyjKXPYC/8uDbRnI2HDwhPKXnnypytaJ7kj/WLhhLod1Gro/HAIjGJxAoseNHwMLi76YzU1nxz9CCYnNGE0/jOadyXoVVQaUkh0xozk1Fg7Cbf9CrZwvzp0ZsYoU6hXKLDHuP8Po4z05bIR4/sLIFfjjQGG5EMiaZKJ1EneWWbTEhD30txqQ2rx3dUrFZJrWRqwSFiR0XmlR6hWDGBT4JsaQ9UINw/LoqLp3RUco83TLUPb85U01qRn44cSEpgXLA87EyTBPSxVnwAwifv2UYUu3EAuY0vI4mtXL8dbbpSQ+qusBfUsUsS6wXgHkKdOWSb/vzmuLaulNmvAvREzeNJKz/87cL7Vm/GmwV9e9X6UTQaAIVTFgI/uvfF2j9cUyheY1CxhG5cjIfgJMRNMo0aRi3/mgRjYHqh8ezg6ScJ7JseozQ2faHag2AG33A25oDpqIjuVEote329vgOKQoANaUUUAt1/iEX0NzvyDtetQA8YWokDj2kNkzyTONUhlu/PT/JE9o9uBpg3cojh2MJeXdkjydlLCMpMjg095Izq/Ie6KmV36McFJ70fg+EQkL7ZQRSSzT7EbigMeM5xlNUHhnHAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3c0e6b-c52e-4f01-0319-08dd7db68be9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:48:34.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4kTxkQZb6y42nDv6roOC/4m1rdrkSL3Q5Uw1ikqD8M4GvA9SweC3twORJJLDAi3nYDuxwzMz/O8q9DadmcMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170103
X-Proofpoint-GUID: 8WNE5ruDZDZu6WpRWV8iy5sQ2HR_QDKD
X-Proofpoint-ORIG-GUID: 8WNE5ruDZDZu6WpRWV8iy5sQ2HR_QDKD

Add a commonly used Btrfs configuration file for quick and repeated test
runs during development. This helps streamline local testing with various
mkfs and mount option combinations.

Also update .gitignore to keep btrfs-devel.config under version control.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
Thanks for the feedback. Here's v3:
Title: Replaced standard with default for clarity.
nodiscard: Dropped this option — QEMU and VMware don't benefit much from
  it.
RECREATE_TEST_DEV: Decided to keep it; it's useful for catching bugs
  of the previous testcase.

v2:
https://lore.kernel.org/all/cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com/

v1:
https://lore.kernel.org/fstests/2223e599a760bb1a9e7b7aeb47961e970d4cccf7.1740757274.git.anand.jain@oracle.com/

 .gitignore                 |  2 ++
 configs/btrfs-devel.config | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 configs/btrfs-devel.config

diff --git a/.gitignore b/.gitignore
index 4fd817243dca..9a9351644278 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,8 @@ tags
 
 # custom config files
 /configs/*.config
+# Do not ignore the btrfs devel config for testing
+!/configs/btrfs-devel.config
 
 # ltp/ binaries
 /ltp/aio-stress
diff --git a/configs/btrfs-devel.config b/configs/btrfs-devel.config
new file mode 100644
index 000000000000..ffd641da3750
--- /dev/null
+++ b/configs/btrfs-devel.config
@@ -0,0 +1,38 @@
+# Modify as required
+[generic-config]
+TEST_DIR=/mnt/test
+TEST_DEV=/dev/sda
+SCRATCH_MNT=/mnt/scratch
+SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi"
+LOGWRITES_DEV=/dev/sdj
+
+[btrfs-compress]
+MOUNT_OPTIONS="-o compress"
+
+[btrfs-holes-spacecache]
+MKFS_OPTIONS="-O ^no-holes,^free-space-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs-holes-spacecache-compress]
+MKFS_OPTIONS="-O ^no-holes,^free-space-tree"
+MOUNT_OPTIONS="-o compress"
+
+[btrfs-block-group-tree]
+MKFS_OPTIONS="-O block-group-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs-raid-stripe-tree]
+MKFS_OPTIONS="-O raid-stripe-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs-squota]
+MKFS_OPTIONS="-O squota"
+MOUNT_OPTIONS=" "
+
+[btrfs-subpage-normal]
+MKFS_OPTIONS="--nodesize 4k --sectorsize 4k"
+MOUNT_OPTIONS=" "
+
+[btrfs-subpage-compress]
+MKFS_OPTIONS="--nodesize 4k --sectorsize 4k"
+MOUNT_OPTIONS="-o compress"
-- 
2.47.0


