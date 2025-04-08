Return-Path: <linux-btrfs+bounces-12876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5CA811C7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AC51883F45
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5223BD15;
	Tue,  8 Apr 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lpr9iG4U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yXRlh1nH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14722FE13;
	Tue,  8 Apr 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128333; cv=fail; b=Y4tvq9dhFA6uPo2MRTn50vTUMOgBAsxX5EAOmwDaHWcSZeeRb+Dm5DqttHbzbkiwwEkLCgZ6eNp0Na0Mdmk3QS/iJ8f010ot6yiynt7JhoNitUpfWLfDyv3UMGVCjHLYE++5BSA937f/2MYbnzS660ChMg9jVfjcJlbSBh8v/Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128333; c=relaxed/simple;
	bh=iv8tUdubpJqzMdwqSJ/21mRZ9v90cExm1paE1fa+BoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JvcAWgqRD4ec70Am5962fSiy3rGz0ZKWg7t5NoUsKaY/PrrRQ7UJYdwYs8wLfF6APK6mW/tqbm7Yda7CAam0UJ7zQalQAAKjlGvhBHhAi2KUZJNE+cHHZPeJEdi/jaUk/LqWZgJsiiFUksNgnEUVqVRttTI7XrmCGAv/0i+Dxdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lpr9iG4U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yXRlh1nH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538G5CsQ014546;
	Tue, 8 Apr 2025 16:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V4sOPKxTto4SbrNHoI6B0Wo/hSNUeMBNXtLhNI6NJ7Y=; b=
	Lpr9iG4Utx/wabHZI/H2CftPP1V28dOU7Rdwu60WQrGYX8jjEcl86vzSxs8UZmxm
	KaxNaIFYv8LOcaS7kfr/ysFo4LiD+sw8BS+u7DcwSUdcr5BqjBYc7zSyYdF/KzxM
	exh1dv6uDdRTgvUV3S3gMmswjC3RWKWpucL9Y+604xuEihXoAAHQSr36qv8jAyCI
	qZDznJWz20xTwXiJhQPBRFbc7DUKzw1fG1gVd6uMyxbgA9PlGbwFO2Rl0VjvhUAB
	iimey0qErPuYmmcGWt/pkgrnnNSgVaq/cVjgbpFxD0YE/ZMED738w5a7YVurPmlp
	a7QKen3NtSXIVAqSvkRCdQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41d6w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 16:05:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538FpeGK015897;
	Tue, 8 Apr 2025 16:05:19 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfta8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 16:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JF/sokLuCJnICHdVkNyFDOseGrgvR+6Rz3Gb17yxCdRsDmCaVDGTRUaJqNv/EIrwNk91tB95ybEB2dWre8cFdUX+TFbhUYQuu2W8U+92ss3hXmLAaO3VbBs1adXSB2SrXVfEogaLyfmDfNC+IWnBT5AUppk/1A/YtajfIOWVdPmZ2aAkWxC7IgNgS5hmRZp9JkIS8dwqubuK7Vm7LCbO4TWRBwqZ51O7eCNil6f9Uafpur7MYtTyfadxTJsKn56gqK0lUy23WdMwhiGWsP5zITJ1vw5h5qoiPnyfv1YkGO7gizHUaNP9iYeB2PdIWMewtj/fWVG/476bjmbRUwIybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4sOPKxTto4SbrNHoI6B0Wo/hSNUeMBNXtLhNI6NJ7Y=;
 b=UJDV8aVZd35ajSkquGKFh0i1AmvmMth7lU5dmqHjhWN/USdF4xM1l4wiu8jw9q4jDXs0w/CcrKH7t4YOssnFMZ2/QYvki1//blebNn7ndfBKn7DLkAnQJEs9TJP0LKrob7Obb7JKADCWuirsDZBi3HFUAMAbJqOu4hDOntZCR0LsSWsXl8nlENfRCy5+9YZu0DVzBRjz8lHN5LqmJ8fceCSmOrmqmQd/almMVuXa6ADaAoPOJjhP3aDYKIQCyY2HETdXr+AhN61BVdQHenfJLaNcmN/E7/yk6i4h4+GLOu/9al/bJCgB/OgrevPM7cQQrZ29VeTnqWj8VAdiXcAiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4sOPKxTto4SbrNHoI6B0Wo/hSNUeMBNXtLhNI6NJ7Y=;
 b=yXRlh1nHm6mlNn081xacIQWGESIhCAOVgwT7EWj6QDaQwZr0/GR58NUfC9qJM7gJFR5EfdJLn2MH816cER1OqSiS4dmDanZTynQxwsRVCg9BBrJxaO9kcqvvYr5HoI1ed0HO7eDmN46DavQ7H8txNhHDH0nk/G8+WMEHlrwIapg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 16:05:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 16:05:15 +0000
Message-ID: <ff900cdc-2e43-4929-aff7-a59b0185d628@oracle.com>
Date: Wed, 9 Apr 2025 00:05:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] fstests: common/sysfs: add new file sysfs and
 helpers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1743996408.git.anand.jain@oracle.com>
 <ae857de1a41a1b2946c6ca83165308a13c043bba.1743996408.git.anand.jain@oracle.com>
 <20250407172249.GA6274@frogsfrogsfrogs>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250407172249.GA6274@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: d02843c1-3eb8-4a42-bc9b-08dd76b7266b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXBjNWZ3VUhtMlhRTEl2YUYydWthVzZudzZmNHZpUGVKRkw0Q3hVbzNjRFI4?=
 =?utf-8?B?WGRvWXNPZUplV0syNTlEYVN6UWNMVjFSbTYrYWZtcjZiQmluZFFFSUJtSThO?=
 =?utf-8?B?Zm9KZmxDTTBheno1RVpNb29mUlN3MjZGenlLTzFGdjVKem1xVDdjYjh0ZnVX?=
 =?utf-8?B?NlNpS0Iwekd2QkhveDVuSmhtdlB3MEQzc09lRENzQXJ3VE1Od0ZyRnBKellG?=
 =?utf-8?B?N2JWcTRPT3NCa3hSS1A2V05WZ2YySGhHZC85TndIeTRiYkh2VzMvWXRMWDNk?=
 =?utf-8?B?WHUvUEtJaTVTdnpheGZkSS9jd3JSdHhNVjZmRThUWWdtVVV4KzAvTzhybGpY?=
 =?utf-8?B?bzJtb1JIWlJEOWNIVWZFejAxRzFUeVBwazgzMG9iUWhUbW5NSmdWRnpKWloz?=
 =?utf-8?B?ZzNtNGtPa1lSZUl5cUVXcDBvTkVtS3RkSzNBYUNhc2FRVWdJWDhoQ2JPZTlY?=
 =?utf-8?B?YWp1NTZWc05CKzNlM1NYOXNiZGhxT29EeUpGa3BrUHRzcmlUODRiQm1kczcr?=
 =?utf-8?B?VGl2TTUrUDh6ZmttS2FOV2dDOTJVclk0WXRYdnFOeE9xNlJYR094Qkc3VEVF?=
 =?utf-8?B?MWhlcXVqek9yZk1YS2Y4aTJTS1hENDVsSkhPcjl4eTZPRC9QaituWGp3MVhD?=
 =?utf-8?B?T1hyVFM2a0hGWlZCZWd5U09ERE1ZSmhidGlJUi9Ma3J3TDQyZ3RIRWZpdGdp?=
 =?utf-8?B?TVBndXdSeEF6MUhJMmk2dzEzSHpGNitVQUEwV2VCUTZIc1NabXBpYklndXdU?=
 =?utf-8?B?dE53TGdYWCtFNHl3SXMwZnZXYUNFMm1LSWU3YW5zT1EzanhGTnZiN0NnL0Vy?=
 =?utf-8?B?c1pFa0xteXlRSkpHbTlJZnV4SjU4SHB0SWVHZjR0b3RNN3hpc0tvUjQ3UXpR?=
 =?utf-8?B?cU0vdGduQmo2VllXd2hsOEx6dlhOaHMxTWNoTG9SVmZHUGQ3bkMxdEdjeGd3?=
 =?utf-8?B?MDk0UFNDcWdoaWpjbWdnV2tLeDFGb25yaHlTZXI3eHpucnZXMFpiUWpTSDlm?=
 =?utf-8?B?SG9NM3hOZUc3dnJINDZ4bnRONWUyVmEvNFJGb2xvekRCVUp4S3pXb1VOdGNH?=
 =?utf-8?B?ZXhycXBmcTR3QzNXbU83KzFQK3JqOXVlSmVwZThEbE1raS9HREpwZkZFa0M3?=
 =?utf-8?B?VkNyODhMaFVWQzc1aFA3RVBNWUtaZU9rc2RDbmdYZFNwU2F5NUxnZ1Z6QzhT?=
 =?utf-8?B?TDFMMVA0VXc3b05jcVcvOG9UaTF3S2tFWEVvalg0SXVpNHJxMW1tZGEyeWRZ?=
 =?utf-8?B?TUZvdC9aVWdDM2NLaXN1bnlxNlFwTzhmT0k4ZnI4eDBiTVJDc1ljc1dlcTJy?=
 =?utf-8?B?aWtBWVpNL1ZrcE1lMVpkaGdLc0FaanJldk9xTGtUSndMZTdtYjRLMzBvbDlU?=
 =?utf-8?B?VlBuQUEzR21GNTYvTE9TVS91aTlqR1dBOUMzeTA4RVRySUUyL21MQ0JpZ1pu?=
 =?utf-8?B?UDhaL1J0UFdYRzFrMlR2cXpmdVdnNmtzc2IxdFZ3ajNHamsrZEZFbUR1L0la?=
 =?utf-8?B?eEFoVUJEWGd3bDNoTzNNWEJ0OVRmM21Obmw3OTBVUERsSlRlZlhET0ZpUUlR?=
 =?utf-8?B?dk9RNC9rbCszY1F0aUFKTTQ2dWdmYVRJUTl0WGYwN0VaSkRVWm5XeCtpUWc1?=
 =?utf-8?B?NzNHZ1NOdk9QOWZwekgxNEtUQy9TVlFzMnh5WHZ5SUhWQTd0QTQ1azJ6YWVE?=
 =?utf-8?B?YjNWeWxyUUZ0ZkdGODVNd3pwRVg5OStTME9PZUZmYUlhR0dJS1JhN1FBNlJM?=
 =?utf-8?B?b2hRTzBkazR0Y2NzeUpLNmp1TXEwZmNXZnVqNmlGUkRBc3pXV1NwaUVuUm1E?=
 =?utf-8?B?L0s5MVMrNnF4YVgxdWl5S05uSmE4dDZSWVQ5cDJ1ZXB3bkZpeE91KzUzbktE?=
 =?utf-8?B?bGV4ZnV0eDBFUitWTmxIY0EwOFMrVWhsWllobm1IY29GM0V2WDEycjNXMEow?=
 =?utf-8?Q?P6W5ARRgcfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2JLSGMyVlI4RGY4YkhqKzhib0Zwbk5pSVRxM2xEUXpDWGJXb2Y5djRhbEg4?=
 =?utf-8?B?QUVlZkRQdjFLUGNBNlp3ZzUxNTRybG10RXB4cytaNThSRmUxQTd5QXhNU0N5?=
 =?utf-8?B?anZwQTUyNU1QSzlvZG9oSjdNUEZzcEY4eGI5NmhCdGV0TUUvbXdGcTdndVR0?=
 =?utf-8?B?M1U1aFhHUnlTZWh6UFFmV3dYUHU2Vm43Wkp0bStwaW9YSnlhWWlJWkNtQzMy?=
 =?utf-8?B?MklQWW52QXFSL2FOZThDZnFjNEMyeUllTTBteVhpalowSjlYTHVvWldKL1dL?=
 =?utf-8?B?WEcxSFA4NitiRTh0MjRnVXlKYzNoSDc2bHRtZEludjk2TXN4SG5oeUN4VGhy?=
 =?utf-8?B?Q29EcWdUdDBJa2JQeFRnNDZ3V0Qyc2NTdS9VQnhTdDNVUElIdG94TmNuWm5w?=
 =?utf-8?B?N0EzaEpISFJPS3IvdHBVSHdvSFVjSGVOU3ZuTTREY1BaNlMvTE81UWNGME51?=
 =?utf-8?B?eHNJeVNxbHNjQ3V4UGVXZitxUzd2MlI0RE1QSmxEN3VHcHpPZTMyUWlQWGRR?=
 =?utf-8?B?dmh4VFIwQ2FBRzZRTlc2d1JSSjJSYnd3dENlWG9rWHpjUVdVREdqQkF5VGVh?=
 =?utf-8?B?REZBaUFEY3NFTVI2TlRaWWhyRDg5NjRKWlJuWnJRRlhmUHovejVFVmZWSjNX?=
 =?utf-8?B?VU5tcmhGZ1ZmaXA5WXlYejkxbTlZeVdFNlcxaytlaXNrd05FcmtWaUlzc3R1?=
 =?utf-8?B?aEZiV0lKL2g5aWVESldSMlpPY1VuNVJhQmRvRXloOVowZmd1d0F6UzRWeXpD?=
 =?utf-8?B?VjkwUVBYejRDbmFJeFo3S1NiaHpjQWt2WFUyUHJpYTJQbGlRVkp1M1EzZHRV?=
 =?utf-8?B?QTc1MzFOeG5LazlyVW1vOURaWWdNNWUwcDNsZkF0K2NaNnFXNG41emdlY1Rz?=
 =?utf-8?B?SXdYSzlmaGNWaWFmSmNpRHZrT09sUmFaMisrQnE3U3F6cjgxTDBHbDJTejN3?=
 =?utf-8?B?cXJuWVJTN09TNGxTSVVENTVhdTRpbmY5ODNKMitFZ2NWQTBLYTB3RHdFQjRS?=
 =?utf-8?B?V1NXVHZvc25tNUwzMGttUFh0Um5VRjZHMjZzbEdJbno3MDlLamtnTUIrVnd1?=
 =?utf-8?B?aEpiNktqb3VabWZjTVNjbFVwRlp1bEU5K2dzYTZHY3NaTm5RUC95Q3hwUEoz?=
 =?utf-8?B?WUhoa1ovVGZZUmJSRnJtd21ZZWM0NlVyMHJrNXpSRG1nalNiUkljaXB3bEVh?=
 =?utf-8?B?NUhmWnVIa1BlRStLMWhRN21BWWxwWWNtbSt3Tm04Qk1zLzU2QVM2U1FRd1dS?=
 =?utf-8?B?Y3FBUTZ1b2pWZ0QvaEN1SHZkRzljNS92M0cyNEFwT2hFOXUwMldjR3FVMVYv?=
 =?utf-8?B?Y0kzVWF6TWpBZEI3VWt1S0tNWGVzUXNDWWhINU1iRGEzNXF5OXQrb2wzUG1Y?=
 =?utf-8?B?UE9MTE9Sa0srT0hmaS9RTEZtNWZKM1pabGlUc0hvNHAvUGhkUlhCdE1qYmhJ?=
 =?utf-8?B?ay9UQ1RvbGhWa0p0d2I0ZEE2cVQwUDVZbGltYkVySHRZd3p3Vmd5YkRHN0F5?=
 =?utf-8?B?dWV0ZlkvT1lHWGpOb1dtelpCeWlOU0E4cGxudUFoWUk1YTE0bFZwNFVoQ0hl?=
 =?utf-8?B?U0d1SnRBUmQ1aU0vQysrb3RkMlFOWGlXVThBRHFuVFRiOUJYamlDTkNaT2dM?=
 =?utf-8?B?V2R1d1hFYmFuS0VhazF0Yk5qUmEydFhML0RnNlh3ZS9BVDB1b0t4SHprTUVW?=
 =?utf-8?B?OU93M1E5RTVweGVLQ1ZPbGlVUHZ5emt5ejBRbXVGWmlaZFdtTXkweEZaK0RN?=
 =?utf-8?B?K3ZRTEtxa2Y4VDJtamVHVVNTTWxaS04xZStoRURBaFZESEQ5VWVRMEJoVnhK?=
 =?utf-8?B?WVl1dHUwWnBxUWJUZVNrQjN2YndYa2lOVWNXRjRMSWxVVWxIYW5SbTRMa1lT?=
 =?utf-8?B?NDVzajNWYmNqbXVMbjYwUVhGdjc5UkZGSmVZMmgrOHBTNE0zZTRsY0V5TGJU?=
 =?utf-8?B?eC9aYmZQYmVReElGanF0VFZqYUZPUDE1bjFEcmZhQ25CTjhvY0YrWHg2VEZ2?=
 =?utf-8?B?cDZkRzRUVVNPeDVtR0NzbitjNUdIZjlhVHRUNDlVVUlla3hmM2tpdk9vakVF?=
 =?utf-8?B?aHJhRUR1UW1YODl4N0NWajl2YzI0a0Jpd3ArS2VKZ2JPY0tpOXNXNUtjR0ZZ?=
 =?utf-8?Q?HS6nR8ghoWgRrOidYaP/x+v9p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hUbpk3KY4y90Hl0vujhkr40u4Z/MXZ9GCUau7EM/bUNPLw7J8ABrVJ3Gf05YFvhd2iTroHhAXA7uhTpkvNUF9atji7yMEt4yUH5TlfAYI4/yL8hBq3ILxOW+h+oGIN0wfBwOh7daCIczZ4ULA5hb+l39jBHTTrnaDXQoRAUryrN4Agd2Eu3HOUkN//Pnl47Qt+XUlTHsHAeKfc+EpMAz/nBu/LDMlV3xysQ3bTAwobqVxZt8beC8js04JL0tW0GS0G5fMMuTD04Pp7CvOynQnrq3UfL3dLDxuAXmXAkfT5I7wf5PgkvrM4wnUCkgAAbV6IXC4u8ytx1RrvH1ZkC7qycnWfxm6SR280J360kfCNRkk5BzlC7mLmwsXqRwM2sqgM7QYeiB3IHJ3Lpj8Zq0x+CkLxgSWzZsjZrtU/ouRHEhfNR2qtkCXeqhmZxw329gut9OI8wxQ0IDL9c8GsxJh5y+RarZU7/7/qp+gFsxPQL03+/qRRDXi3WsaUhvN9Iq57HiGyvr4nzoHuxOdc4ExgBTflrSVh29Fe8NiViAIrh9hAv7U9EYBR2X3QGJIANwmuFkSAqz05B6u4fHjKK0DtOO9diSs6Pawj0eCWElwFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02843c1-3eb8-4a42-bc9b-08dd76b7266b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:05:15.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNeoXPGdeDd84AvEQo4ofx3kY4d+7yUK+WNBRz8nlmF6KtT2w7NcJ+ua8ROQeaL6z/m0BT4YmgZwjY+jVH6a9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080111
X-Proofpoint-ORIG-GUID: 7kiKKjGsuW4wyy4lvXMIJ6KKH-ZU2iix
X-Proofpoint-GUID: 7kiKKjGsuW4wyy4lvXMIJ6KKH-ZU2iix



On 8/4/25 01:22, Darrick J. Wong wrote:
> On Mon, Apr 07, 2025 at 11:48:18AM +0800, Anand Jain wrote:
>> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()`
>> to verify whether a sysfs attribute rejects invalid input arguments
>> during writes.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/sysfs | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>   create mode 100644 common/sysfs
>>
>> diff --git a/common/sysfs b/common/sysfs
>> new file mode 100644
>> index 000000000000..9f2d77c6b1f5
>> --- /dev/null
>> +++ b/common/sysfs
>> @@ -0,0 +1,141 @@
>> +##/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0+
>> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
>> +#
>> +# Common/sysfs file for the sysfs related helper functions.
>> +
>> +# Test for the existence of a policy at /sys/fs/$FSTYP/$DEV/$ATTR
>> +#
>> +# All arguments are necessary, and in this order:
>> +#  - dev: device name, e.g. $SCRATCH_DEV
>> +#  - attr: path name under /sys/fs/$FSTYP/$dev
>> +#  - policy: policy within /sys/fs/$FSTYP/$dev
>> +#
>> +# Usage example:
>> +#   _has_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
>> +_has_fs_sysfs_attr_policy()
>> +{
>> +	local dev=$1
>> +	local attr=$2
>> +	local policy=$3
>> +
>> +	if [ ! -b "$dev" -o -z "$attr" -o -z "$policy" ]; then
>> +		_fail \
>> +	     "Usage: _has_fs_sysfs_attr_policy <mounted_device> <attr> <policy>"
>> +	fi
> 
> Shouldn't this return 1 if the parameters are not fully specified?
> 

Do you mean, instead of using _fail, just echo "Usage" and return 1?

>> +
>> +	local dname=$(_fs_sysfs_dname $dev)
>> +	test -e /sys/fs/${FSTYP}/${dname}/${attr}
> 
> What is the point of testing path existence here if the function doesn't
> actually change its behavior?
> 


Ah, I missed the `if`—updated it locally now.

@@ -25,7 +25,9 @@ _has_fs_sysfs_attr_policy()
         fi

         local dname=$(_fs_sysfs_dname $dev)
-       test -e /sys/fs/${FSTYP}/${dname}/${attr}
+       if test -e /sys/fs/${FSTYP}/${dname}/${attr}; then
+               return 1
+       fi

         cat /sys/fs/${FSTYP}/${dname}/${attr} | grep -q ${policy}
  }


>> +
>> +	cat /sys/fs/${FSTYP}/${dname}/${attr} | grep -q ${policy}
>> +}
>> +
>> +# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
>> +# and value in it contains $policy
>> +# All arguments are necessary, and in this order:
>> +#  - dev: device name, e.g. $SCRATCH_DEV
>> +#  - attr: path name under /sys/fs/$FSTYP/$dev
>> +#  - policy: mentioned in /sys/fs/$FSTYP/$dev/$attr
>> +#
>> +# Usage example:
>> +#   _require_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
>> +_require_fs_sysfs_attr_policy()
>> +{
>> +	_has_fs_sysfs_attr_policy "$@" && return
>> +
>> +	local dev=$1
>> +	local attr=$2
>> +	local policy=$3
>> +	local dname=$(_fs_sysfs_dname $dev)
>> +
>> +	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr} ${policy}"
>> +}
>> +
>> +_set_sysfs_policy()
>> +{
>> +	local dev=$1
>> +	local attr=$2
>> +	shift
>> +	shift
>> +	local policy=$@
>> +
>> +	_set_fs_sysfs_attr $dev $attr ${policy}
>> +
>> +	case "$FSTYP" in
>> +	btrfs)
>> +		_get_fs_sysfs_attr $dev $attr | grep -q "[${policy}]"
>> +		if [[ $? != 0 ]]; then
>> +			echo "Setting sysfs $attr $policy failed"
>> +		fi
>> +		;;
>> +	*)
>> +		_fail \
>> +"sysfs syntax verification for '${attr}' '${policy}' for '${FSTYP}' is not implemented"
>> +		;;
>> +	esac
>> +}
>> +
>> +_set_sysfs_policy_must_fail()
>> +{
>> +	local dev=$1
>> +	local attr=$2
>> +	shift
>> +	shift
>> +	local policy=$@
>> +
>> +	_set_fs_sysfs_attr $dev $attr ${policy} | _filter_sysfs_error \
>> +							   | tee -a $seqres.full
>> +}
>> +
>> +# Verify sysfs attribute rejects invalid input.
>> +# Usage syntax:
>> +#   _verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
>> +# Examples:
>> +#   _verify_sysfs_syntax $TEST_DEV read_policy pid
>> +#   _verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
>> +# Note:
>> +#  Process must call . ./common/filter
>> +_verify_sysfs_syntax()
>> +{
>> +	local dev=$1
>> +	local attr=$2
>> +	local policy=$3
>> +	local value=$4
>> +
>> +	# Do this in the test case so that we know its prerequisites.
>> +	# '_require_fs_sysfs_attr_policy $TEST_DEV $attr $policy'
> 
> But it's commented out ... ?

Yeah, I commented it out since it's just an example.
I think I need to rephrase the comment.

Thanks, Anand

> 
> --D
> 
>> +
>> +	# Test policy specified wrongly. Must fail.
>> +	_set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
>> +	_set_sysfs_policy_must_fail $dev $attr "'$policy t'"
>> +	_set_sysfs_policy_must_fail $dev $attr "' '"
>> +	_set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
>> +	_set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
>> +	_set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
>> +	_set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
>> +	_set_sysfs_policy_must_fail $dev $attr "'${policy} '"
>> +	_set_sysfs_policy_must_fail $dev $attr _${policy}
>> +	_set_sysfs_policy_must_fail $dev $attr ${policy}_
>> +	_set_sysfs_policy_must_fail $dev $attr _${policy}_
>> +	_set_sysfs_policy_must_fail $dev $attr ${policy}:
>> +	# Test policy longer than 32 chars fails stable.
>> +	_set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
>> +
>> +	# Test policy specified correctly. Must pass.
>> +	_set_sysfs_policy $dev $attr $policy
>> +
>> +	# If the policy has no value return
>> +	if [[ -z $value ]]; then
>> +		return
>> +	fi
>> +
>> +	# Test value specified wrongly. Must fail.
>> +	_set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
>> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
>> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
>> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
>> +	_set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
>> +
>> +	# Test policy and value all specified correctly. Must pass.
>> +	_set_sysfs_policy $dev $attr $policy:$value
>> +}
>> -- 
>> 2.47.0
>>
>>


