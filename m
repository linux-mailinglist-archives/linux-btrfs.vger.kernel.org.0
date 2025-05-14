Return-Path: <linux-btrfs+bounces-13993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E0AB617A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 06:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E275A864573
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 04:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD421E9B1C;
	Wed, 14 May 2025 04:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NlCv7TRR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aO/1p4Gs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ADA19D07A
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747196887; cv=fail; b=JBLwpijooDnxQSJPtMYlEE6CyNYIgoMQiu4PNn/KBVgrNPlMLwN383DjqoNKIURbU2NKvbNhAhaQSDNJ6pJg/FFkHt+OSQUER/as6l6vyhjnh9U591kMKAXRHRalbKUpaxy6UjBm/RAHNFtNNcAJP0fgGx8XGXnjykTFbZI1JrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747196887; c=relaxed/simple;
	bh=aPAdF8B3q89SqW6bcqTJqH6YfjCQuRHhMAGnKpmwxrE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UQOmE08T2Mk05B/bqjqYeCGmpV8uXPX2CSugdAJAhx/NnaHCH4cW3cNeFyCdCRvzFmnAYFxbpaWOtIshWtbql3sQIjzGrMsTg745N/f71LMujDt9Yqesqvg9R0zGjYEdyZu7je3YoJaoBtwGgqFg6uwe4SsIPtFVD1A3TWDcSaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NlCv7TRR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aO/1p4Gs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0ftC7027890;
	Wed, 14 May 2025 04:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DG/HDN7a2OhCHVbIKotfKSv/Tql4ULiI+WABYtQyYBo=; b=
	NlCv7TRRoXn4QDNNGVSvfPdmGBYBy3YMwpK/k+txBiv7g8Y4xocI39B6pRjl7CoO
	8F8wuEekRX2ABUZ/bbNSeoSXypaqyN0G9G1WtoxUgUBgtrBfI2Fa7eyOS2Xm4Po5
	wzdx0hiZT0KqT1kM86wQ3oViGweZNiOZD7/KQYFhBHhZvvaA7upi5bfrEC1M5gaG
	/Z6KMxmGeQ98/zQmod4iBEYaJjLKiLdPJpoxFmPQ02CahovOVc2pTY0bgifRUlKC
	o/4P9ytMF7YjVVtm3aRycdIFVltpflWpVs+LKbDAx5ozrnisv73McdfA5QSqpupX
	lLYpPuWwTvaQoMQw6Xfigw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmgq0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 04:27:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E2UWDu009056;
	Wed, 14 May 2025 04:27:57 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011028.outbound.protection.outlook.com [40.93.14.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc6w5hr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 04:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG4c96SDfLsfPVbRqvdwyqsFyKB+FHoK5VDvkhTOoKmaGkvP2VWnQuLRqa98pH/2Mn+A9PTgju8k6UOk8ZR74H3kRxQ92vGLucmY/0g11d0waMM17eHtny1XiK3HI24n14JebRj4II8dpKerse8EqGRxmDInu4aNDGyjI70k0hZ6y1EM+4//3AY1C5Twp8O3cy/b8AG1t9z59HqtgJz2BvM5ien+hKc464+0gpENATksRsGryWUd6hX7qO76NHcxc8uaMC/oUutGS1bOghmUXB1YdkpKq+B8n76Q+daAK0l7iaB3tYeQhOus4nefbULjECwccE6cZ6uPqOG2zWzujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG/HDN7a2OhCHVbIKotfKSv/Tql4ULiI+WABYtQyYBo=;
 b=QXPnzoLTxEqX/ujPsbvzzTKE9XXx3+T5xJ8vhMZeri63Fh/OhWur3fXGQb4PrfpQK9zu4X/ETmLEj0+MsyMzeyG5kS/HBk2/ppBIhC/F42aI/qJ3Uxq+B4wnwnUcRCNPgDwQkHHggiamNv2YVOz9oeq1NiQxUnY6f46If9A3TJizpCwn71p1ozRD+UKUvnt/Um1ML+4a4nC48jMdTlstqWJafDq6/GlIygNNvsi4F1lCMPaWz8DwpLk+7WC8FHcX2kgwe1EvGFogiU+4BdO4KmP17EqWZWy+ZO/FXGscjFiTVO8w6dAKbgOIDyR8OmNIdfyNZy+kPLyXrSFic3se2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG/HDN7a2OhCHVbIKotfKSv/Tql4ULiI+WABYtQyYBo=;
 b=aO/1p4GsHZVa4gVhh4fUsN6LUtV50PCeaMeOcqUQIOENJ8qoZ6VF+2QM2LQStcxsraY6zUg3D9/v6vfODoTeuVuRkqKUBBTixjby0uCiHM55ChiTudce4ILft0qO2PB82Vq/3DYA7IQ7XZuZwOpvmNJtRbLldyDh3MDSY+efUWI=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by SJ0PR10MB5720.namprd10.prod.outlook.com (2603:10b6:a03:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 04:27:53 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 04:27:53 +0000
Message-ID: <8630908b-2bdd-4726-889f-b9496d947c4d@oracle.com>
Date: Wed, 14 May 2025 12:27:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add prefix for the scrub error message
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
 <9ba1fc52-38b2-43f6-9c29-df924d8045a4@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9ba1fc52-38b2-43f6-9c29-df924d8045a4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|SJ0PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 760727cd-e6fa-4a4a-18b8-08dd929fb181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NIQ2Q5akJZZ2pLc2xSdU1RNlFrZzBNWS9xeHdzU3hDS0VRSERlZXlwWGpL?=
 =?utf-8?B?UVpRQkNXWGU5ck9BU0ZyOG5HeEtWbmNOb09SQllwQWNQakhlaklqMld5VHBz?=
 =?utf-8?B?NTVXUVNrLzhLQzIzYWRRU0t0QmpMZTlSbFltUExlbXpBck96N0U2R2oxZy9H?=
 =?utf-8?B?VTZIamlVbVRPVGhJRXlPdEh2Sys5SW9IVjBnczAxVlVDdmczUFV4UGNlNHJo?=
 =?utf-8?B?Y2hYSTlJOUg0R3oxWnNhK0hDM1lkOTd4dFNFZWtHZkU5Q2FZeGZhekVWNjE0?=
 =?utf-8?B?UlY2QVduMy9KeWE3dnlMbGhDRHRmeTlNTW96SmdzaW9tdGprdGpNZHlaOFNm?=
 =?utf-8?B?NloxMVJpL0pFMWYvNXR2c3F3QXNINm9xaUoyazZKTUpRdGxXODFtWjNac0I1?=
 =?utf-8?B?UENwc0xLd0s2TU1nTmdLQjZQeUhMWnRlbER2ZkJSVFdLcTFiUUJKaHloTmNs?=
 =?utf-8?B?bHp1VHBOMjkxSVFqQUJuaDB5SFg5Z2krOEs1SHpXdUhaSEdobCthRGIvbEwx?=
 =?utf-8?B?UUIrL0dzZTVJNUNXSDdzeENKRkFNc2lUbzY0SUdSeGpONEh0UWRFUHU5TGdC?=
 =?utf-8?B?YUJqU2VURmJnNVpUWDkrSG5IN1dKT0NGWldNZGJFMjMxSXRjVzVCSDJaVHpU?=
 =?utf-8?B?RTBtL2xCU3F4WCtGbkNnbnIvcFhmd25ZTjd6Rll1TE92SzBnY2c1ajQvTmVN?=
 =?utf-8?B?ekhCWGsvazZNWkNFSzlqM3IwZDZsVzZUTUxqeWFOY0tFZHNQL1ViQjNGaElO?=
 =?utf-8?B?SW5ucmQrRTVoa002azZsekpEMGhYWjIvSzlwanhWREFRLzV0ak1jbGFCOU5V?=
 =?utf-8?B?eFFHYXdxQlM2WlcrcVZZcWlzYitGWnF0RFhIYWFEbWNNRDBHeStTcVdqWmpp?=
 =?utf-8?B?MFltbVVCYUZyWHBFMXJPRzU5eFVmOGN2ZXVWUHRzQ2ZxNkorT0NVWVBvL0xO?=
 =?utf-8?B?MGM5WlZIemc4SW95NGxzejZrWEhUdDE4OHNBY3o2L3d6YjZzYVorbjducTgz?=
 =?utf-8?B?Qk50dTNkbFprVEhmelJWbHpCeUZHRGNLdFYrVVFMLzJnek1hcVFwTlZ1Uldo?=
 =?utf-8?B?NDdsK0RxdnF0RVhLVDNnTTVqWE9HbE5wQXptYXVzZ1lvQWNEV0JGUVFTUUlQ?=
 =?utf-8?B?VDZsSjNsL2ZIUVR5ZTBFS2U0YTM3aWh5TEI2OThxNlB3UDgwSkhORFJtODRz?=
 =?utf-8?B?OWZBdlVpblZ4NDdpNmNjcURoTy9tSUxpc0N5cFZlSUJJVHRtbXBRVXA4dnNo?=
 =?utf-8?B?dDk5azVvTktOZXd5N0QzVE1NTmhOM0t4Z3N0UjlIZHpaMGZZbHVjaHVDYUlD?=
 =?utf-8?B?VkwzNVFrbDhKdjNtdUxWK1lPVlJYNFZwc1F1Q0xWZVRRaEw3cDJWTGhNc25W?=
 =?utf-8?B?V1Rjajg2MWpPamMvU3NsUnFuVUVsSE5ZcHN1TVVkU2dYSWp2N2Zmem9GYWZY?=
 =?utf-8?B?TXNoWHQyalREcXpERW5zZkczWHNrS3pGNlB0dVlQSWhrVVlTMHFnSXFGOUh6?=
 =?utf-8?B?RFN4b1h1aVpxbnRyNjk1YnVxVXZIYTdhNHJNbUFTcU5yRFBGZHRwV1JQS2Zl?=
 =?utf-8?B?ZEJUNmRFQ3pja2hGRHc4c1FvQjE0VlJ3N1FIM25TT2VYRDJjVzhVNGhVcUFr?=
 =?utf-8?B?SGVPUmhsMXlRSWtBL1cvMzJtME5QVmYrWGxVNDU3U2ZMZWhhc1Z5b1JoQzlU?=
 =?utf-8?B?dmhpVXNLWll0NzFLQUJ2M3FxRVhuL29lWlJjQzV2Unl1YVJJenBtbTkyenMr?=
 =?utf-8?B?NVY3YnA3QUtzYVl1bThxOEw3alUzZkpadXZhTEsyVWJDTjZJOUQzRnovcVNv?=
 =?utf-8?B?OGpMRjd0b0VsdEdpN1pjUWxHWXJ2aG4zblBlQkRLOVVOZ2dRbzVTamx3dGpW?=
 =?utf-8?B?ZlFkV2wzbElRVDNBUTR1RlJFOVkrK05MT011b042NFdIYWNMZjl4UC9LZ2tG?=
 =?utf-8?Q?//JbiccPQoY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTZVRXhxMTJzc3BnK0U3d25aYnorUEduakF2aWdqYVd6SUxUZzBWTjVTQWR2?=
 =?utf-8?B?ZXJyYTE0em5vN3gxNThtYkR6ZjU4Q1lHRE9lUXlrUFBITnR2WkJhekRSNS9U?=
 =?utf-8?B?K1JEN3U0Y3VQdmg2dytEZkV0OW5tZDFDek9udlN5bEZpcTY2ek0rcTlVN2V0?=
 =?utf-8?B?L0F2QUQvR3hWRFRucW9aWDNoRFZrTExCbHdxSk5JbFVhWEJ1UDE2bkhUbjM5?=
 =?utf-8?B?NG1LYzVwQzJVS0V0QTRQZWlFcE9KNUxMb1JHRndzRUJIT09YdnhOcUN2K3hs?=
 =?utf-8?B?ZFc0SzF6aENTTld3K0xyeGhkUHJMVytuM0tXZHQyc3pYNGZwVnpib3g3aDRv?=
 =?utf-8?B?dEpmeVdCamgyYkFCS05IZ3d4MmZ1V0E4eG5RS1A1RjJ0VnFDSHluQkx6U2F2?=
 =?utf-8?B?N2YyK2M0YkJPeXBSTXJvZFN5UmZianVFUUYvM3FzQVo5dlhScFJzSEo1VUhQ?=
 =?utf-8?B?bjdZMEhUR0s3Z2Y3bytkenlSNHArb0piN05XQXJ6YzUzWlF1czNIZkRyd0o2?=
 =?utf-8?B?emRVZFk1L05ySUp5ekZXdmFPQTNKclROOHV2TDh5S1VLc3RqVDgya1l0Kytm?=
 =?utf-8?B?Q0VKUzg4T2NxZFJiNVNCUjdsMFAxMlJjbm1uaEtwRXNZTkZKNjhQMDhZRFpa?=
 =?utf-8?B?MG83NTFwbWdaZ2Fxcm13SmltelRQQWhQQTQ1UW5VUGRqZnd2VG5RcFFPTUpE?=
 =?utf-8?B?TDduVDZ4STlGbGhyb0ZpMTM1OU1GN2E2K0syNDZ1SDFwZVMrdElLNG9PaFAr?=
 =?utf-8?B?c1RJOFdab0tCVWRnYmpoNDc5aEtDL3pHREZXdGpRWVBKZWtEcHE3c1pBYjQ4?=
 =?utf-8?B?MC80WkN6emdwNUgyVnk4UWF1d3Z2dWJxV05jUFB0Mkhrd1NEZHVkU0tLWHNx?=
 =?utf-8?B?VTRjUnNVTXhISzdZWXFIS29HcnpadDFWQ2FPeHBDZzhjVDhISWl2S3V5VWs0?=
 =?utf-8?B?UytnaUppNVM1cHJFemhYYkU0alB0UWJIK0QrVmU1TkFFdHZOR3RBQXJPY1pa?=
 =?utf-8?B?R3pqdTQ1MXFDbDhuMWxlZzRhUUFxNG9WSHhEZlBLVGZ4TGlNeVRic1ZhOFR2?=
 =?utf-8?B?cW1vWWxIdHlzY0NFTEVsU2RmdklIckJXVHhRRTJOTGE2ZCtwak9lRDZ1SlM3?=
 =?utf-8?B?Ulg1S0kxU1JScWV2cFozdVR1cnYwUGNjdTZIMjZidE0rNmkyQzRMNDNabVg5?=
 =?utf-8?B?NUo1QjZreFVKcmIrWFVoQjZnNXExT1dremNXMUQ1Z2RpRDdKV0Rhc1h6Tk1r?=
 =?utf-8?B?MFZUUUxPQ0psUUIyRUJKQm91NUZ1TnR4c0NtcmxPK21FVUQwY28xRTlLWkM3?=
 =?utf-8?B?WCtjazl1eHZYdFFJMFFYc1JzbHdSdTJhT0V1TDc3R3pITmExSmFVS1lDcFk0?=
 =?utf-8?B?L1hTMlV4T3hwOVZBYTB5aUlRbXVSdS9MRGNodUtWK20wL2R2TjUzcEhwV2N5?=
 =?utf-8?B?ZEE2QU5ac2xRTHNBVW9PWUxMMkRkYVo5dkc2N3F6eDFTVFF6VHVzSnlISER6?=
 =?utf-8?B?R0tlcS9ERGZsWklOZnVydmN4TmdWUFlqUjd4SUFmNURhSGNSU0tNY2FsWWg0?=
 =?utf-8?B?ckRRbzBNN3NDZk5yMGFidDNKNUhINTVQNmxrU0o2MEgzMDlJdVdpdklDVCtU?=
 =?utf-8?B?TGt2NnRsY3Rxb0xlb1MxRCtjS0haV2tWYk5jTmpWRkZvblk1dUVHRy9rQWtH?=
 =?utf-8?B?M3pDUVdUdEhjRXNjV1pEdkI1amRNenlFdjFVbVRLY0ZMclJIa3AyV1cwVEta?=
 =?utf-8?B?VGc5clJxZUdrUHk1NzM3Vk52Mi80cUNpR3o4amJpVFNoQnhZQk9wYXBzalM3?=
 =?utf-8?B?SGZ6dlNGZWswbzZtemY2MEorbWorcWFhN1VlS0p2T3d1ajRyNWhVNVdzQSt1?=
 =?utf-8?B?cUxtOW9jOFJVMElNTWNmK0hzajdZdllDaVJRZVRrSzJjaU9SZlhkU1Jpcmt2?=
 =?utf-8?B?cVZqZ0IzRkNyWEVNUkdoWHV3TjBMaWNBWkVoVnNXWmFqUFFHLzhoT2JEUmdZ?=
 =?utf-8?B?T0tDRnRuZE9rUFYrRVlkVGRmQUpYb21xWDRVK29NRFI0L24ybEV2bTNzMUZM?=
 =?utf-8?B?TXlqT3N3Z3FRcVliT1htUSt3NXdSWnB3bzZmL2tkUVRzNnkzZjZrVndHQW41?=
 =?utf-8?Q?u7+JJDokCdhlewoVcWff6YicG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UVYqBM/kdwnlcy8l5F/LcUn+sr5oTPcBFlKteS2zr8ADqqBMvcd5/RzmNIf7vqUwg5Q21wROqf8vC0/gyoagvWCgOHZ5LrRIeldKF34XBC+OXQY6cybkBnjw0SH7BRjWvcMRzPepnbftqVSP9KTazINxfPgZ32/6M32U4RWsDp3T52hewTDN1nV59UhRgNVzNVXAJ4ni6LNKajvSmH4tdOV/XQ4qARLBhrghmowB45FdthU8Vwjhefp+/bBOQqNMsnHg1fNWkhdCZhL7VpxxRG4LGszsUB0U/Xm5/TvkAKN99GmhF8JX9UXF9pftzzQecFhX9qHKyZxPJA5SQ/CdzOcv7GtWi01VDSj4IIna8QmpPoPuTUmY690rlEmzLpIASL/KlQHlzpb6GnKepm9CuptADceQNG2llKXwc1JuunceQ52xII1wjghio1StfkTVPoOMTAIFBlebFSFqx3Kav2sPDR/fuFoRhyTb++eew2Zh3jTsqG0iBQ97SaVjBHRUKPfjAdVtP1mTMkes5mTBMmsq4YN1bSzkBWFCE9KoDOuKkbOCOJJKQucF8q0uAVrkQVyCnZheN9lzJ+f5LS77DYTt86Q3E5uuV0UKCSX5i4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760727cd-e6fa-4a4a-18b8-08dd929fb181
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 04:27:53.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCzFpAebnMOHAQ/07FVVcLo4L37F+qGIPoC8GDONxLh1766uHNX7lX4Z8dpHFXdwF+Qx9f+g/+SHMdKf2B7M3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140036
X-Proofpoint-ORIG-GUID: xXdT2VwaZkhsHxKMXEGNEehjrxYwA9XA
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=68241bce cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=4VQ_qQG3UCTGu9O5JToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzNiBTYWx0ZWRfX+XvN2jvZV2Vw spFnOrIkVcuIdfO4N0hfJu1ZH6crD3j2WleexJs0CJqkM/XYIKk0BHr0UVHFKKjA4gFpe1EUNtu S7RLvpCumhCjab2e2q22Ygy3riM6vbXaUbHeSVcg65WTixBAX1ZtSoUSV/vlEiEqiLQ0L2RrIj7
 wohvxTYmDc055pjfQ6zo0K44FsE+oJ9b0UrzyYXuFj5SJD391eBIAYiSfKRHm8XG+/NSdnSKUD/ cZDLrlENPqhVZNKQhMjl65x4YvTGLiv6QrNFW9ktcwIxqN7oo+USfpzzojOerw2+aGpzO7MCS7r X/vhc3Q+aFBEa051f8b1SJ5YFzFMPQj+5hSdQuO5rq0wb2p74xkdqJZg5QnnyVGU/yFOmBK5HcZ
 +Qg5WmH5n+OzlbDndOXogClWLCqJDtFYZococ/1XPxJIuphLJVvAPF/lOg68dSZlw7cuRNhb
X-Proofpoint-GUID: xXdT2VwaZkhsHxKMXEGNEehjrxYwA9XA



On 14/5/25 11:37, Qu Wenruo wrote:
> 
> 
> 在 2025/5/14 11:15, Anand Jain 写道:
>> Below is the dmesg output for the failing scrub. Since scrub messages are
>> prefixed with "scrub:", please add this to the missing error as well.
>> It helps dmesg grep for monitoring and debug.
>>
>> [ 5948.614757] BTRFS info (device sda state C): scrub: started on devid 1
>> [ 5948.615141] BTRFS error (device sda state C): no valid extent or 
>> csum root for scrub
>> [ 5948.615144] BTRFS info (device sda state C): scrub: not finished on 
>> devid 1 with status: -117
>>
>> Fixes: f95d186255b3 ("btrfs: avoid NULL pointer dereference if no 
>> valid csum tree")
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/scrub.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index ed120621021b..521c977b6c87 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -1658,7 +1658,8 @@ static int scrub_find_fill_first_stripe(struct 
>> btrfs_block_group *bg,
>>       int ret;
>>       if (unlikely(!extent_root || !csum_root)) {
>> -        btrfs_err(fs_info, "no valid extent or csum root for scrub");
>> +        btrfs_err(fs_info,
>> +              "scrub: no valid extent or csum root for scrub");
> 
> In that case we can remove the phrase of "for scrub".
> 

Done.

-----------------------------------------------------
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 521c977b6c87..fe64cde14170 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1659,7 +1659,7 @@ static int scrub_find_fill_first_stripe(struct 
btrfs_block_group *bg,

         if (unlikely(!extent_root || !csum_root)) {
                 btrfs_err(fs_info,
-                         "scrub: no valid extent or csum root for scrub");
+                         "scrub: no valid extent or csum root found");
                 return -EUCLEAN;
         }
         memset(stripe->sectors, 0, sizeof(struct 
scrub_sector_verification) *
-----------------------------------------------------


Rvb?

Thanks, Anand



> Thanks,
> Qu>           return -EUCLEAN;
>>       }
>>       memset(stripe->sectors, 0, sizeof(struct 
>> scrub_sector_verification) *
> 


