Return-Path: <linux-btrfs+bounces-4777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA618BCF58
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC40B1F21ECD
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECDC78C69;
	Mon,  6 May 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tw5Y4atx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Maiib7L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1678C63
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003011; cv=fail; b=AAiR1YVP6+LCm+4JfswEEH3o5yyzCybG4zwEpQfFFEBZHGG3KsCmm2MTVrbcx4Qj2JIZ0DhYbGtaxamHzl04wunzQy5hwg7wDwvN9wTTA6srT2JrfyBldQ+H0IedEkXMfaYkoKyxKnA+h1uvZtAFMCAcUhLcgg/XLUrrKBPvmGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003011; c=relaxed/simple;
	bh=fzHMttRRHVMHtmtnqF2gonhvIJtWxSj7bZFLVK6Xlrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmaSajoejYFhXY/BigDOLQaZVqOFmutUrV4upIQUMw5HokZtgHb0mF0RgmcCIQ2NrAi1aueLC6qN63w33HnZYD1ZF+muf+tEekrZo2KhJZKgy/d40uGKEqm1hVC1aYOw5loo8wZzNEfGOQNr2vB6IWPDoM8SwZmiLAWaRfPg8XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tw5Y4atx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Maiib7L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApKBr003272;
	Mon, 6 May 2024 13:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8xdV6YmRgxqj4syNYgxc0Jlfnj0DDcPYboz+3UTRLkA=;
 b=Tw5Y4atxLg1g9SqHqOgQPB4wSvTSwTkhmrFNzkZxwEjTwf/rbWgdJXtFWatb/kSPlf70
 +gysapYppKot0pOexfxMLun7nwjwO2CbfYFIgha/LcMnl+3fkANkZ8fUz9SmTttrJ3MZ
 7p4Pcaje39ER/rcOb3FgpEGITWb0k3iWobZt+Zmzv6P0vs3YwaPJPjU42lX4dUm+sOfR
 SWGxvz9cfg5Czeva4RSyUkfjX9UyqWN7/Zr48zQSyP0H/xUxqNzuyBNXmsnXuZQSoMXs
 +tc0wLtubZLbgbU8YjiIlM6nlcoYaTB6Yl/R7osYb9Fi9jiQMjW9KoSLS5dWVaMWkara bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwdjutjpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 13:43:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446CgvsL039393;
	Mon, 6 May 2024 13:43:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5n21q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 13:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqWTyidRZsZ4JZbpJxWlxxb8ZWuSfqJj9BHltG2QHnwnHQvWqsPCUaeNSV3LUjfJ0GylqEM5DruevzhtxiB5CrM+Kc2+RQGygNLxif2SjRyNr+gDwOWy2xfHBosj1GNVWhDWzaiTlM/d2kTupgTrGra5uJEPEX6eWPJZEA8ESrZCMew7cWdsLAVwJDWUjKTIo3XB1ClYKyzRFTcshX2Up5CvZso+/z5LhXiN92iY89s2F6oyoRZZzAoDjAKYll59/aPvhCcRtvfPc/aQmqLahVX3M4INtlfH8sXeOvUzhGAt58BQTGFbWvmeTT5Ue8iIagauoYKuTqvcctCAwnOLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xdV6YmRgxqj4syNYgxc0Jlfnj0DDcPYboz+3UTRLkA=;
 b=iMw8S6BzsLB3ycM+cNyUXG1pvzRp/DSniMwhL6rLME1c1DfmCtPFgtMycrbh2ETbfFyK0W2+ssbM2rT0PDQ1rfXRUlqg+Lt7PjKkydj94/YcafD84hwCLivcChNBaduKjeS2ojY5sfev6tuJuDzQzGTFBveziE8W4LK23e44mI0Yu4i1Pt9n0ZQOA9m56ZGl2yLbdEpi/sLoesdwUi9qoCPN9z0MvWfZg9ek1hL1T6vJAIcKdsKsr1RWWcH+llJBppVIGebK5Zxhv0U0uQiQ65/FXxL/DV23DFAddkyPyh3kXG73y169YtB7RxCK+xSfdBjHraK87GzYBxZ5XXfDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xdV6YmRgxqj4syNYgxc0Jlfnj0DDcPYboz+3UTRLkA=;
 b=0Maiib7LIRkgstZ+iWgJqFWP7gcqbH/gdbSf3NwksqB790X5m+2tYkI+EBNiGbYBpykiSLiC/KWAaFfKW2S5KECRFtvzIzD5gEJMdpR6JqMLMPXiMMdlI6KEn12YoyG4nDOXiJO6pztO+JXZ7oe8KhW0aKeFLBIE/Ak9mbWPkBI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6066.namprd10.prod.outlook.com (2603:10b6:208:3b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 13:43:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:43:18 +0000
Message-ID: <0f97e260-bb17-48fb-898a-a71cdcf68ba7@oracle.com>
Date: Mon, 6 May 2024 21:43:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: Yordan <y16267966@gmail.com>
Cc: quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org
References: <CAE0VrXJhJT98yucUDDvWTbcdXczTM4Mhy2XCqZtp+H00FYJfkg@mail.gmail.com>
 <CAE0VrXJ_8ZYjnKs+DQo1bmh7PxkQ=J6cWss3Fci0L2__mZbxxg@mail.gmail.com>
 <2bcc9d83-2442-4b06-92e8-2006eb980c83@oracle.com>
 <CAE0VrXJksFYCHr_JscryWS1TYT9+QX9opmZ9Y_2Lanc_=oybzA@mail.gmail.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <CAE0VrXJksFYCHr_JscryWS1TYT9+QX9opmZ9Y_2Lanc_=oybzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e47b67-9bb6-4fba-bc98-08dc6dd27ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEs4c3B4K2tUSzZnWDlZUW5CVjN4UTdwYWMyWWJCeTUvRXh3RkhHVStSSmNu?=
 =?utf-8?B?Vk5TVkE2WFZNMkZ5b21tTkJoalhzc0ZhaXFiYldSRU5odmlHcThVMWpGMElk?=
 =?utf-8?B?TDFObURCWStZQ0Fja3BWRTg3U2NsT09TQ2l2T0xMMzVtc01TWGJtek8wOVps?=
 =?utf-8?B?MURYemNxQjlGamljMUp4KzVzalpEbUk2Z3k3Q25pVHM1bkhZMForN291ckpp?=
 =?utf-8?B?R3ZEd1EvSHRrRGZuY3dRZ3ltRVpQOHJwUDBvMm5SejFWd3lseGZjRm51UTd0?=
 =?utf-8?B?b0JCTC93VWhyMDhkNUdpaUVKMjNQRWdXR0Y4MHdxQ2p5Q2IrRUVzMmhLYStv?=
 =?utf-8?B?Q1pOSVJQL2hmbDB4WWhxcWtnUjFjM3VTRU51NmMxMVRtakl4L0FmNDh3QjBQ?=
 =?utf-8?B?SDVRRHlYUHQxdlRIdUkwRW1UQldhOUV0SGYxSFV1N3Q3K0xoN1gxeWZwNXN6?=
 =?utf-8?B?SVdhQTJzWU4xaCtseS9VU1ZISmtpSzBkMmt1RnhVN1IxSUZiZWxEUnh1Uldh?=
 =?utf-8?B?V1ZYVTNqVk1uTVN4SGVzK2s3bEVva0NHWWFzSUV4WlRRamlkTHM5UVpzZFJa?=
 =?utf-8?B?dDd4TUp5UUNFbkc3dER0aFVVRWNWalhZY000V3FnY05hbkh5WlJXam0zeldS?=
 =?utf-8?B?VDAwOGlnQVFMR2l2MVkzRVVqa2NrdnRHOW9PSWtoYkREUFhhVzQ5Mytlckgx?=
 =?utf-8?B?U1ZyQlFVaEpyZEhvNW43UjNBRGVvSFo0cXFxMGlHbFZ6ODc0TmYydnVYaVNW?=
 =?utf-8?B?YkRpa0tjRWVIeWpzdnJyUklqa3NDTWs0cS80MXBLRzcvZWhwQk14Und0Mlp0?=
 =?utf-8?B?TldFOUJnTFlnOTVtOFZaTGFYOFdpTXRDWCt1WVgvYmZyTUF4Y2R2RFNYZmp1?=
 =?utf-8?B?SWRYZEwwZThBZUQ0YUxicVIrb3BTTURzZ0JtKzVHR0ZSTS9Xckp0NVh1enRF?=
 =?utf-8?B?WDRUWi9lQjIrTHZYUmVYQU54ODlDNklCZHdlY1pUeS9SSFJYb0xaWmZsR2gr?=
 =?utf-8?B?Mm9IS21Yelc3dnVZSUZ2TjB5bkY4QUtPUXYrRHRURXBoQjN5Qk0yODBMb05O?=
 =?utf-8?B?RC95RTh5ejl1YktpUnZkNlpuREIxQ3QxVUFsamFmdkpGWDNUcC9oM0hydlcv?=
 =?utf-8?B?WFd1VllvS2ExZnh2UU50MFdsQ2MrUWczRDFjTU9xTEtlNjJidUo2UkJ2SjFs?=
 =?utf-8?B?bFFjdkFmb2t3SkJjcVFmaHFPNThYOTVEdWZjcEdJWVpWR3cvWHlkMEdQdVZv?=
 =?utf-8?B?RmVQUXdHaldqcjF0TlZVREtwY1NzZGs3SWFaSmw0Wm5Ea3JzSzRIcnpIZ2t2?=
 =?utf-8?B?OEZ3ZEkwYVB1T0RLVld2ak5CUk1IL3JqMVRQbDVYZ3BhTFhTK2p3cnlEQ05y?=
 =?utf-8?B?MmRTS2MvdkgrOCt4bDdjbDdvYU1sQVZtanB2dnBIOTZwWmZCNWFGZDNqdmYr?=
 =?utf-8?B?bjhkTmxtVUtWdFU5dFB4U05YMVFDdFVpNkpPM0oxcVNpckUrOFZMWS9WZXk1?=
 =?utf-8?B?UG1YQVNyZUloM0JuRFZ3VTc2ODlxZTlKWGVmaGV2M2FsVitTdDhRVlMyQlpG?=
 =?utf-8?B?enBXb2JNZXg1K1pYaHIvdEVMSjRvbGFzMkJhVEdGbnVjWXhadXplcUx0aWVp?=
 =?utf-8?B?a1l4aHkwMG9hRFpiVW5pSDZlZWNZZE02dVpYRXFRR1NvKzQ3OHdXM3ZISGh0?=
 =?utf-8?B?aXlHVWM0YTljL3dUM0pBa2REVk8xbzEwYWVrdFlaWWJUMFA5R2hUV3VBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTJXVWpnUkRlMzZoQXNPcW9SZzVGOXVaMEY4OW1VTU52U2o3ZXg2d2pUUWdS?=
 =?utf-8?B?M0hIdlZzNXBTdTBhSWtkemtkcW9wSUFCemMrS2RKWFBkYzRCSy9TaTJoNHZM?=
 =?utf-8?B?ZFZhSXlkdkRVL1ovdUd0ZGxpQzIzZUtjdDB4bFN6UEhJUyt6dkt5amE0RnZC?=
 =?utf-8?B?Wlc3SHJqNW1MeWozWGFnUUJ1V1hmUmNDekZDMXRycXR4YjlGQ043bk1Bc2tH?=
 =?utf-8?B?WDgwWXFRMnZ0RVdiZmQ5eW9MNUg3eTZsSTlLTmhMYkNwcUxmQlN3VmE3Vmdv?=
 =?utf-8?B?UWg3Q2VuNGUzNHlHZXM2Uko4Um9uZFJRV1FETmc1TlBSM0p5c2oyRWFvdzh5?=
 =?utf-8?B?VlFaTms3clA2M0hnWTgwYzVud1FSK20ydDV2c2NuMUpGMDNGR01kWUozcXRl?=
 =?utf-8?B?TjM4YXhEcFd2YWcvZnV6RTBQTTJ0enNKbW9kTXNlSGt6VDdUL1YrWlBvQWxw?=
 =?utf-8?B?OGRsOWNCNVdYdzJ1Nkg5MEd1UFl3UWNscVRHRTFPQm8yWnlhU08rOVl4aFo0?=
 =?utf-8?B?bkFKZmhUSE9QNnpRbUpoZWlPOVNsVEVHY2pmMENDYWZ2S1lhVTdqc3QyNjg0?=
 =?utf-8?B?cVdtbDFhV0FRWG05VzE0QWdvTzU5V0JjRW56M01WMDdZVGZSSGM3MW9BcTk3?=
 =?utf-8?B?RW1rS1pVWE5VUXRVQUFuY09lbC84VlpadHZVZGdoOEs2OHc3YmZzNDBDTFJ0?=
 =?utf-8?B?MzZNclBVNzJsMHBlQ01sY2NsYXpCNVlnL2Q0TDI4RkxPOXlPTVdXRUxFS0dM?=
 =?utf-8?B?dFVGdG5oejRMelFJbGVZZ0ZBOWUrWlVvbzJaaC8raTl1WWszSEQ2cE1ZRzVx?=
 =?utf-8?B?dmkxOHdxUWJVUTM5dEI5eThWRTNHcEpKbzBINFdwK2F3ZUdkWXBjbEJ6Wnpn?=
 =?utf-8?B?L2lLcUtnQjZWbFFMeEZidDBSMzFxRFVYdDYxWm5UaVJ6ZUhFeXJOelVHWXor?=
 =?utf-8?B?ZzZ3Sk1ucjdpdjhodFpZZUJpTmc0K2M5K2Zpa3d2SENUTTRjZ3NMU2hTNFEx?=
 =?utf-8?B?Y1IzVmR0WWhsVW5ZWnJIaTVua256U0lFRDRDZHcyTlhqZDlGdVgzMFVXU1k4?=
 =?utf-8?B?Q09WKzl1NTlDM1grZTlyVTJyaW5TTk81VEEwcnphMzJiWW5FNFFvaElMd2E1?=
 =?utf-8?B?UCs5SkJVaElteXJEdlBzYkVuQmk5RmVjUmk5SHRWdFBBTjdDc1lCamo2YkRY?=
 =?utf-8?B?RXdneEpSc2ViTzNmQTRBWGVDVXVBNmZ4S2RFakpJc1NkZ1EveXhQdElnZW1o?=
 =?utf-8?B?OCtEdXdDWWVoNXV0VUtzdTR2UXpWU015aVI4N253RU9VNHVXZUxSaVc2dVV3?=
 =?utf-8?B?WnBPYlE0dGhNeUk3UGlMdTNkL3NYVEZJYzlDSDhpQUFxWWNUeC8xc2Q3WmZv?=
 =?utf-8?B?Ynh6cUU5TVl0bEtBZ1dPZ1ljckwwYklvRTBmWWIrZHhmdUhZUVBIbjgyZWFG?=
 =?utf-8?B?YmE4UkFOT21NcUs3M09EckFBWEV5TjdRQmZ3TzBLUmZ1djZiMkFrZ2kvZHVz?=
 =?utf-8?B?Nk9rSE9QaVdTcnlyMUxZai9PNDNmOWVhT2MvdXR5RUVwSmRJOVdFWGNCWDFq?=
 =?utf-8?B?MG9pNUdnWHR4Y2hNSGV5TVlGN1VNUVVHdU5pL1hjOXNNSFk5azdvNjQyQ09w?=
 =?utf-8?B?dG53SWw0c1NOeFJLZi9WSUZlQUNXMFFmYXFBN2JxcmRNUGxCb3R6c0JqdkQy?=
 =?utf-8?B?WFlsYzVOR09kR2pIaWxGQ0wrRzFyeEU0QVByeXhPOFptU1JaWFlCWXQ3alJu?=
 =?utf-8?B?dVNIZCtUZW0wWDRNNksyaTZpTC9xVDM5M0lJZFdWSUdqODRsaWJpbzUydE9a?=
 =?utf-8?B?dVFZdFJDOXNXOHRlVVpoSkVtYWhQY1VMLzF4NjR0Tkx0Y0xadzV4VHU4dWNI?=
 =?utf-8?B?SzdlbUhVeGdlMVhnbUx1eXIzbkQ0WEdnNjA3REs2enJTYzFnb2pXMjN1OTNj?=
 =?utf-8?B?ZmhZZklxSjJ2S3U3bkVJQWEvUFRDMlFEbTFpd2pydUtCNTBEZjdZcVNNTFZW?=
 =?utf-8?B?ZVBjalN1TlpJMWhWZEhIWkNxY1o5OWJXOHhtZ3B2YjI0YUhaQ2p1YU1rZDRk?=
 =?utf-8?B?Z2xmZW9QODc2ZjhMQlB0bnYxZG9xdThtV3phSW1ydXBvejVycHBHNTA4Y0xZ?=
 =?utf-8?B?VFNqYjEzeTYvYzlFdzN2YklLTURpaitBNG1teFJsRTdYNWdRc3ZSR1N2R3Iz?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	37ou1qbn3MQDeeesOxzWB3oWlp3q8f99vAUJoLHbib5V5RR+eeDpfGazWHwHFGNA8v+tsqamUQSr4ly1tMr7OtQ3GoQ3kukV0GItDbDyYIiV/T8wQb6xfdtLRxTNIfJPHID6swxldZZGYqaQeH0tEfahmPkB22tSveFLJzcBkHlBh7bJ1003MUYetKbESZUfMzXrXGZqxvH5p1J3ZDWT99vdxczAq3Wubx3xB2x18PIMOgTzfuzqWkuZ77BBQpLiVHDxFXzJa2riylvg/dp69vcU4dHEGQCaynJET7YH+w4tJzPafXoer5vg0U6zgoocBhAYI7ZXcKSk42zUtcXrtWrYoz8aZFCRh91aSv+Sn4IqhD5cB7VaWojKAIfn4mMd4y1FvAFuvBlG/8/qWxRKrJbwKiJ7acQ+CDvJZNbovMinZvHw4kRjcDa53kkIsyUtNUItceVB2353yNb6WEcdjkt/uBlUm/F7ajltY+lf/itrQ0fhizeXiU4atcVv2YsR6ntllZX7pjhErh0WVF1JInuh3bLME4UJxkpxOc4/Gszsnkq/xWjdiYUMlx3J4azdrwkqU0mo+OeMjkETj+WgtG2DKIgdhTL/YpXXnC37v1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e47b67-9bb6-4fba-bc98-08dc6dd27ce8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:43:18.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bMHdf/GB8QyoFYksBD6gLxjH+dJIXQKZbfc7F1dAnJtaznUGSPyMTdlVBdHnC6J+XU3wgDucSjXsLMdGxr0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060095
X-Proofpoint-ORIG-GUID: Do2j1o3xz6nuVmPQkZ8AGs36ZSGEqDPU
X-Proofpoint-GUID: Do2j1o3xz6nuVmPQkZ8AGs36ZSGEqDPU


It is meant to be applied on latest devel branch.


With the v2 patches:

$ ./btrfs-convert ~/sda3.img
btrfs-convert from btrfs-progs v6.8

Source filesystem:
   Type:           ext2
   Label:
   Blocksize:      4096
   UUID:           b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
Target filesystem:
   Label:
   Blocksize:      4096
   Nodesize:       16384
   UUID:           d8c61c42-1b2c-478d-8ae6-bf45213e8df4
   Checksum:       crc32c
   Features:       extref, skinny-metadata, no-holes, free-space-tree 
(default)
     Data csum:    yes
     Inline data:  yes
     Copy xattr:   yes
Reported stats:
   Total space:       536870912
   Free space:        326238208 (60.77%)
   Inode count:           32768
   Free inodes:           32743
   Block count:          131072
Create initial btrfs filesystem
Create ext2 image file
Create btrfs metadata
ERROR: inode 20 index 0: identified unsupported merged block length 1 
wanted 12
ERROR: failed to copy ext2 inode 20: -22
ERROR: error during copy_inodes -22
WARNING: error during conversion, the original filesystem is not modified





On 5/6/24 21:35, Yordan wrote:
> NO, I have problems applying patch4, so its unpatchet
> 
> error: patch failed: convert/source-fs.c:316
> error: convert/source-fs.c: patch does not apply
> 
> I just sent you a small problematic image so you can test it yourself.
> 
> On Mon, May 6, 2024 at 4:17 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>> On 5/6/24 18:53, Yordan wrote:
>>> The attached file which is a reduced version of the problematic image,
>>> produced by removing all files and directories, except 5 of the
>>> problematic files and their path. Then its filesystem filled with zero
>>> file, shrinked with "resize2fs" to 512M and compressed to 7M.
>>>
>>> md5sum sda3.img.zst
>>> 9eec41fee47e3db555edeaba5d8d2e9a  sda3.img.zst
>>>
>>> (chroot) livecd / # zstd -d sda3.img.zst -o sda3.img
>>> sda3.img.zst        : 536870912 bytes
>>> (chroot) livecd / # mount -o ro sda3.img k
>>> (chroot) livecd / # find k/ -type f | xargs md5sum >files.md5
>>> (chroot) livecd / # md5sum -c files.md5 | grep -v OK
>>>
>>> (chroot) livecd / # umount k
>>> (chroot) livecd / # B/btrfs-progs/btrfs-convert sda3.img
>>> btrfs-convert from btrfs-progs v6.8.1
>>>   > Source filesystem:
>>>     Type:           ext2
>>>     Label:
>>>     Blocksize:      4096
>>>     UUID:           b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
>>> Target filesystem:
>>>     Label:
>>>     Blocksize:      4096
>>>     Nodesize:       16384
>>>     UUID:           d7c77d2f-d470-450a-ba0e-b6567ad3f4b3
>>>     Checksum:       crc32c
>>>     Features:       extref, skinny-metadata, no-holes, free-space-tree (default)
>>>       Data csum:    yes
>>>       Inline data:  yes
>>>       Copy xattr:   yes
>>> Reported stats:
>>>     Total space:       536870912
>>>     Free space:        326238208 (60.77%)
>>>     Inode count:           32768
>>>     Free inodes:           32743
>>>     Block count:          131072
>>> Create initial btrfs filesystem
>>> Create ext2 image file
>>> Create btrfs metadata
>>> Copy inodes [o] [         1/        25]
>>> Free space cache cleared
>>> Conversion complete
>>>
>>> (chroot) livecd / # mount -o ro sda3.img k
>>> (chroot) livecd / # md5sum -c files.md5
>>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite:
>>> FAILED
>>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite:
>>> FAILED
>>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite:
>>> FAILED
>>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite:
>>> FAILED
>>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3870112724rsegmnoittet-es.sqlite:
>>> OK
>>> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite:
>>> FAILED
>>> md5sum: WARNING: 5 computed checksums did NOT match
>>>
>>
>>
>> Are these test results with the v2 patchset? Thanks, Anand.
>>
>>
>>> Regards, Jordan.

