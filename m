Return-Path: <linux-btrfs+bounces-13965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F20AB4E92
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BC317B86F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE220F080;
	Tue, 13 May 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k73/HKxa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aSHpfiFE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F01F0E37;
	Tue, 13 May 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126479; cv=fail; b=Xzzme3NWbBYpELQM8ra1W2Bp/+ivb+MA3vAlqGXE9IdAeFX8l4WihgvXLJNSQJ4aTQetW558wPAd3N5ExwPbCmUD+Rmi3MKhPCMCmm6R9PR7VL0PKI7K09QlwPHafE5I9nqnf1yfpfcIH2KO4chqbVawg6SlmY2Nvwizzr7rHAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126479; c=relaxed/simple;
	bh=fU3sOKEC4cljy4LvZVSirY40FwsVBeIuv8LHdlWrEys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qvwSoafyNSDmyk0EFsCkdlItksHOpsEf8L6jEdf4RgAhOV6zGSvD2tGZ9mWOskDg/emijjFsptDKAM15vM+WFODvIxtsZeoglFuE/OBiLGObXWcan+NpzknZEhGl9LjSNjx2j5OyGDCmnN951z6/pMWY9zlIOxldUS97jDFzDic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k73/HKxa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aSHpfiFE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1CIv4008533;
	Tue, 13 May 2025 08:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wQQwm5b8Y7Z16DCnIsfsJxHP40jPU0tbwcuWp+DzPiM=; b=
	k73/HKxaHyZawTrEF5mWYezW0s7/CyzXDCOqg1Ajm5DdK8ZwhqB7W+bh9WLlWBCx
	/FRxWdmy4lL2ezV4Y1zT6qHgA0G8V4oszxkHUqaDA43T7JSuL70eQ5LYr+tA9obq
	I38wR1gpTDwv8YlaViu58JqM5vry1xy8CKbrbzEM+J6ZFQ1Llof3lOn9+9VDzxWY
	LzV1e0QqXtIdOXvRQvK6Zqs4XDrR0CoMGZshBurH0YPvNmNhnbWujR4rQQ1xWuna
	WKPNfw+SYHGW9YZLXrY13wuEEeFYjkxZH49mxUBwyr+O3OjyXQJiPwUglHuEk96w
	2w6eQSr7CBtjn1+yXK/4OA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1664bej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 08:54:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8LKga022366;
	Tue, 13 May 2025 08:54:32 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw89d21e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 08:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSC9kixteby5aBPp1GIVkV+O51nTj8QT7nNuVlcQJKSFgnqkkriyqKRheE+ZRsfUfk2hV1fGwHnOmZPyhRHPIXZ4IgeYa1Ce3DIBZJFC63Z40/mVdi614Rq9N6NLMjFElZYsuZR9+Rx4Udz8cyFKaTF8Y6z+9WuaClTekaBDR8vnejGuXq0mb8TNHrGvVOHVMEEuo/6LsrMGUkmYjQv6JNNeibPCaPyvBdYYUe+8tOwwXJ84qZpE2QkjjtCZmjw+eKChL2NSHxygsrNDCCibpzHhUfJO0PQWuiPQCuWOkpfMbn8062WZaKvLV0q5lb/4uG03iQtqhjYdKxXP8u3r8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQQwm5b8Y7Z16DCnIsfsJxHP40jPU0tbwcuWp+DzPiM=;
 b=Yk800FG613ZYpukbOGmXKp4/ZcMRSs6bDSTXQPaznfmMWIhwEmdHO+Vqkm3xhun5wNz3m6UJK173SbHOVsUPC5r6ic5sQZRuun3gvnRjogxcMMDwvol5d81LcbyU5IsL2oLJRB2fQJoOQeaQYznj+owXlPKtx98OdEH+05JFLj7v+dDiP8Y0f9gBXsO3ROlmLnJ3dq8/uakd4Xc++koyfN/cWgC3cH2JdeNWQmTuodiVP5gDtN9Vq3ldWw1N1HzK045E+kWC4aj+zYxgXMQ7bm32pIhDutESdrkGLFQxNv6LWZOA7Za1J3dhp6lHkOH5Bn6nkPpPOocLlnUCW3LFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQQwm5b8Y7Z16DCnIsfsJxHP40jPU0tbwcuWp+DzPiM=;
 b=aSHpfiFE5usFqL7oz8UZ4CaQBKHLdxl3C1NBldEsTGFYxH5JexJcAL0HMiy1SAsOgFSD+KCthVGpgE0Ed15LNu00R62aqA7RBsoHE3IJ31dYMJgWCQftXQs10gVG+DjuIxw54iQ8wsHTbHPM4xkYALX1dpW8XMK3d5Xsfs06fm0=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CH3PR10MB7284.namprd10.prod.outlook.com (2603:10b6:610:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:54:30 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 08:54:30 +0000
Message-ID: <4208096e-459c-4379-99a5-6bf1defc65ac@oracle.com>
Date: Tue, 13 May 2025 16:54:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and
 rescue=idatacsums
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250512052551.236243-1-wqu@suse.com>
 <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
 <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
 <CAL3q7H4dxAGTK9XBe2Yeoywy7-HTktwt_Jcp=FE0yNYnrU8H0A@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4dxAGTK9XBe2Yeoywy7-HTktwt_Jcp=FE0yNYnrU8H0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CH3PR10MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f94a5e-f12f-4a9a-25f9-08dd91fbc5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnNOb1A0OHY2UkpkYTJuaUl5N0VtQnN0V2ptK213RXkxa1pWZXJPS2R2a2FN?=
 =?utf-8?B?ZkJzblgrMWg2SmtoNmJkZkpmZkJOa1piWmRjOUZhVm5WT2lOZ3VadTNMakZN?=
 =?utf-8?B?KzdLVjNGUzZNakxla1V3T2NqSG1QMm9PVHpxVzJWdDdmREdtWmN3M2ZpQXNU?=
 =?utf-8?B?TlZwbDZtY2x3cVZySEN4QmVxNWxSR25kY3lRTWZhK2pvNk9UTWFXbTRWcGY3?=
 =?utf-8?B?Y0NMSkt3OTRsSHJXNEtlcHh4dXJhQk5yUDVDL0V5MXo5emIvQkxOUnlxblZS?=
 =?utf-8?B?bXpjKzlzTkxsZmlyWnpUMHVtVkNic29keFVRb042UVozMkNYWGpoUHFlcFJM?=
 =?utf-8?B?NTRBcFVXVmJMYkZkMlpMN1JQRzFneDF3ZEVGWHpvYzhIYm8vSlBKdG9EbUIw?=
 =?utf-8?B?Tm52SGVnZURKeHJ6RWJCTUgzTktBdmowMkJsWStYZU9xSGZmcjZJZjArd01u?=
 =?utf-8?B?ZGRGaFVMVHBiZXNlaFJlbVhsQ0NSRjFOM2dPdDhIcEgwRllrRm9kZUJERFZx?=
 =?utf-8?B?SnlkVzB0L25UeWdSWGFNOUE0YXZFZ2xkWWplNHh3aGVRMXF3REs0TEZzd1dK?=
 =?utf-8?B?NzkwU0VLejl2aGp5L0svK0Ztcno2TnI1SmJJaHlpUGRBNFZ4VjJMZEdYbHZa?=
 =?utf-8?B?UDlaTG5KcTVzQmhjeEYyWnBlRHltVng5V2Q4V2VORW9JbXpGR0l0SVVSaXc1?=
 =?utf-8?B?T080akVuUy9sU3pOekVBaG8ydDRsNHhKZ3Q1Wm1iUmlVVVQzbG5hMGtZeWZz?=
 =?utf-8?B?eXJWVGROLzd5NHBnWEZjYTlZVVBRZUxxbi9KTWJiMEdaR091dHlHODQrc0FQ?=
 =?utf-8?B?TUpJbWFuS0tQMzYrOFVaa1c5M0NoZ0U3c0hCdGs0S0ZSeWJCTW9vZHluMkNY?=
 =?utf-8?B?bmttbERCa1BiK0FUdHNEbWhmNjdGYm1NTXR6SWFITXFQWXVJdHRmNkh1N2VJ?=
 =?utf-8?B?cHhZSW1iaEZ4eVloZWRYajVyaTU4aVpGSHNJejVwVWp4US9QTkVLbmVkbU9V?=
 =?utf-8?B?TEtoaVhJckt0Z0kwVFVZN29veGhYNHdKNjRENk80aUNCTzl2dGlCYUpaeWxT?=
 =?utf-8?B?SHpNTHFsM0ZqL3NLY05CMEtWcHRDU1RaMWQxT09ZaUUyWEtCaU1qZW5qQXZG?=
 =?utf-8?B?TTRhaVVVS1JNWGJZWTRRenZ5N1ZOa29YaUJ3WlZkU0dST2taVm1lNWFrSGt3?=
 =?utf-8?B?OGNwcDQ3Vk8yOTcyUGU3OEFTZ1A0M1BxTnZjTHdBM1pqVzNjTXdDem5YZ2Zt?=
 =?utf-8?B?SlJvdE1uY1VKeUs1OFMzWnFXOHZQQVVSUFhUVm9BV2VKTFJJWHh4dXJORHlp?=
 =?utf-8?B?TEhtbU8xZ1VwTUZkcHVPQzN0RW1sRGVHaFhVRmp6c2dieFk0dmUyUW00UTNt?=
 =?utf-8?B?eWNIb05OWTJTNi9WTVpxZWN4cmNyMFRFdjNGV2RLeDlEVHY5bnNja2x5QkI2?=
 =?utf-8?B?VnFYR0kzWWVmUFlPSFpBbjhCSDIxNUxBbFR0Q3QyVXMyNXVPUTFybHI4a2Rj?=
 =?utf-8?B?VVpIOFJSRG1NVEJnNDRvMkVQdmlCMzhxdUZaOTFZWEhwTHFDeEVZbFQ2b0pr?=
 =?utf-8?B?YllvL3hzYjFBQXl1N1FZcVFsYkp4OW1TekFyV3k5NzFkUm1VTFRiWk83ZTBG?=
 =?utf-8?B?VkdHbEZPSElmcGV3bUdST2VSdU5KdEYxS3RsZi91NjlGVWI3WEk2UStvZHlK?=
 =?utf-8?B?OHp5NHBhUCt4Q1dScVlTRUJibFF0Q29tMzRackZyQ1ZrQnpxVjJFNFJKaE9z?=
 =?utf-8?B?OWJDTkIwaEJlVStianY4eHFqUjNKOWJxZTFzQzZOOXhrSDZUc2VDRVpaQjgw?=
 =?utf-8?B?L016dEFmL0Z1SFR2MmpLM3BLbHhPYVJUR2x5d3J3ZGt0ei9vbVVibGdydmlH?=
 =?utf-8?B?RCtVWHllV1NJRlZRcTN6a055MXVwLy9WQTFpM09OMXlBTVN5UHpXVnZScjlo?=
 =?utf-8?Q?EafzfqvReuM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtYOFlQaFVnZEMvckR1RTlLUDJvWlRkUDNEdjRiY1hxanMwUm9XUlI0MXFp?=
 =?utf-8?B?blhSK0cxQ1FDUXVJYTl5TGdydlIySzZWbStRK3N1a1dBNW1HVXdjU2ZNVWcy?=
 =?utf-8?B?d3ltK0VLV2JXK0JGOFlOSVJ4a0cwQkQ5UEtZNGVjd2o1U2JzVEVud3dkaVRP?=
 =?utf-8?B?M0gxYk9FMFhXRUxjc3NZeFNzQjN3SnlINTQ5WUN5a2RUcnczaHdPZks2blc5?=
 =?utf-8?B?NzExRmwzUkM3SHAxWDhXcnhEZ3pVMk5JakZvUjAzdk1OQVpNOFJkd3ZkZFpu?=
 =?utf-8?B?eU43a3dzRU4xalhvSmdVcTJyR0Zha3Ezc1QwV3JWejdUVjh1ZHJTMWltRER0?=
 =?utf-8?B?SjYxNlNyZHBKdVNzck5uM2hyaGJLODk4V0RZeHp0QUtwQisrd0Qzanc1QWti?=
 =?utf-8?B?U1BJWjhHL2Z4OE5Idzlxek4rdWdUMUFMa2MzSlNIbVpSSkM0cVVMdHducWNH?=
 =?utf-8?B?blZDU01BRzJxdHlZRFhYWTF6bWg2MlF1Tlh5OCtYR1FRdGhwSHc3NEQ0RVhu?=
 =?utf-8?B?YWpxb2o4cEV2MUdEMVd6RGRubmQ1TDIvUEp0T2tYaFppbGtXcWVnYTFnbWcv?=
 =?utf-8?B?OEUxK29WYW0zYWYvWFhjRWhobWo3cDJpR1JHWFBRZ0lLOVhaZzAvV2J3MmhV?=
 =?utf-8?B?YzdFc2svVnM5OUlaNUJWQ0NYMjRUWnd1eDlCblRKM2F0Q09VUmwrLzAvOVVF?=
 =?utf-8?B?NklUSlFRNkdaeTl5TTBKMC9wRlRoVnZKUXdjVVRJeFpsYnF1UXhsUW0zMnJT?=
 =?utf-8?B?a2F4TE9UT2dzSlBPdFdTcGs3VlBWOXIvSEJnTytHT0U3ZGNQTUJVdTJhMjA4?=
 =?utf-8?B?RU1kdGM5aE5tNlRVazRiYzJkVTc1aU1mYW9veE1yYjd2aWhrWUxhWUNjS2p0?=
 =?utf-8?B?UFdGVERzZ2FtWkpXbzBUYXFxZ3FTQnJHbFN0ZkdoZTFCNVhFVmdjNWF3TFF4?=
 =?utf-8?B?RGxFLzA2MklrQ09meTdENDRoMlNxTDV4Ymk3c2lkcFpTZ1FlOXNOOWxBeUNQ?=
 =?utf-8?B?RFN1VEpoU28vTkZLOUdwTFVHOXp3QXJvazFKR3JpeWk5VjdlSitPZUNQbWpC?=
 =?utf-8?B?WE40ZW5YZ3dXNXhseGRpeFJlVk9ZOGNUN2tlYStaZ0g1L2pmZHFBcEtTUzdS?=
 =?utf-8?B?bnB1L0xKZXpLT0k3dkc5SlNYSGtlZjJ4VTdweTZsWE5lOE41UzNxdDlBMHl0?=
 =?utf-8?B?RHhJY3VqUDg2b3VLWFBBbUZseFQ0YjFuN1NnSmRIM1gyU1hjcjQrdmxKM2Nt?=
 =?utf-8?B?WHp1bEh1V0Z1OHQrRW9ZZ0FBeS9Ia2JjbjBpREZYbmpDSmcxc0crcU4wUi91?=
 =?utf-8?B?Wk5LYmV5dk53OTY2bndubDF5OTI2QUkwbmw4eXAvSk9VbkFDSGplTmZRTUhI?=
 =?utf-8?B?MytRVnBhUUk3c1FmQkMxL2d3blhrVXFmSTN5TjhzcXhoRjRtS2dxM0QyM3Yx?=
 =?utf-8?B?aE51aGdkOGdxcHNmbS9QcC9rbmhYVkhualBjQVcxLzh5d3RFZEQvSTFrQkxt?=
 =?utf-8?B?L09JWThLREM4K3lkUmtBYjQxakNOY0RJM0owUmJiMkFFeXVjdjE3WHBPa1l4?=
 =?utf-8?B?N1FnbVNkaFIwSlcrNyswMzY3MCtIZkFPaW9hVlh6VDZwQkVwam5JZDBKdHVD?=
 =?utf-8?B?VFhTUmsySlR3YWhyYVdydGhIWUl3SGE0M1lsNjBORkZiVkFTRHBmcUtHa1F2?=
 =?utf-8?B?T25qanhOVmRaOGRCSGM3UmRBT21DTzl5dzNYc0QvdG9JSXd4Wi9zeVhmdUJH?=
 =?utf-8?B?Y0lvS0ZyVlpoVUlFN295UVVJcFFSWjlQOHBtSzZMOTZRU2Fmdk5KT2VGckto?=
 =?utf-8?B?YjNOL01QcmxyTmVVMVRwRE5tVHFSakJoVUhWRjQ0TDJxWmc5akQ4WUx0ODFX?=
 =?utf-8?B?aDVVVDV5UWNEejJ3SHpmbWxwNXN6QWIvTUJ5L1ZsZmozRU0zejVBbkdyMlRK?=
 =?utf-8?B?Yi95ZnZJMktIWnQxQkdDek4rOTBIRHNRTE5kUHZvQzlsWVZmYzAwVzNnRjBW?=
 =?utf-8?B?OUZ3TVJ3MmlJU2Y4SXBnU25jMDJWYmo1TnlyZVZ2YlNjaG54NkV6akRwMnBD?=
 =?utf-8?B?K3N2MUJZeEQzaDJaYkplbnl4anVLOEV4V2Q2RFY0ajA3MzhMZWQ1K1lITXBK?=
 =?utf-8?Q?CiEcU0w1BQ496vqQqzrK8QKB8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OQrel3ModkWlNQnWlW0YAaXl8bPZ34ljPr5DAsX0mvSHjuq8yLEXUYUkjtu37xI3OhqDau2Sr8vUJmTmhi9lPBvt+rFNKzUnZwpTBqcrpmXck/ZvwmjjiLXfB/4bJ5Pzu64dpUSCGdA3o99beMwSvdYnlcsInX2kdLb7Nx5MNoG0uj4C9L1Rg5S8gMmT4qdf+D4XBgu01yWBDYplv6rzDGO5NLWxhPwuXx5E6+cRthIsmcxh9JiRtZak+raUAqj0/iHy2sY4plkI0NaoFfYpQWebKWwlovYTxajGIEDlwKh53YP6o/mXO9uso2oE3rX/IAJjYbwdTbLEdGmYhFgn4ste7lT3nEI5/Vz1vvqftP7UfZPDfKsDAb5A16gnsggi2mC7MUmt7iuH/Vs8GDlUszSVZSc+c9U1RTNfsGxhkGSmaomipmksxYHKCgsIwKmOl0Nck9PQEPbLiOEAnJKvVDViPMDuCv6TC05YCbh54uObZcNJVwnNIbZIP0nBojCZqvntPCmdaQ5sxWyvn6Yo5E9Qi0syYTSjAwffFrmNrveniPF9pdoYDOfh+hrYw3Q4TPZh3zI6QTdRhwA5GAwl7sOp86GWq7t6lZU87LaW4Z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f94a5e-f12f-4a9a-25f9-08dd91fbc5ab
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:54:29.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mkemwYwUVLlfnDkHEQQZ8xHUcmqMFlPuKt7iGyUCrFMFfgor04yFO5k3dkceFnJXeMmhyMOtWnurM4X2XyjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4MyBTYWx0ZWRfX6lQOGFd97a9o AAB+H8aVAxHf+sujKGIKtbc2iNuUyqoUYKad9a3EZd8AgdFE8Y2IZKClLbeCl18ajOSz0jSNUzu KTS2kDip6Wb7EZLNwuYZ6924e8buia19R0MSkJGe5m5uT3eulzRT+Pgde/ltRRSowyPi2exZMfX
 NF6LUDGJdMveszxeVNZM9Hwcz6Ik7p7e5rcg2shFG6WiRS3V/ehoykx7JD47zTBKCTE169bNloc GYfcWgj4x0lUvPWe4X5coODHHMdqT9mA5zvwVxph7+oqUOwAgu680wwTpToqGQwb0c9O06+NiEj Hr2dq63zEqJtP7wMuEMQ9F3vvx2ycTJ9n1T4FqXCH9BfI32pF30k1fJH/0KmxdZigMstJ4YHa6a
 leEd3dtm95JwH9NdEi+lTJLiywHRUizLsPLURfef7VvXg8suuE3a5upWvE6M4nfH5ZuxhU4f
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682308c9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=7FWShdAf4frMSrkkT9EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: tKdA3r9n7aWbTuFWPxacziOoQ9fU9tpx
X-Proofpoint-GUID: tKdA3r9n7aWbTuFWPxacziOoQ9fU9tpx

On 12/5/25 15:54, Filipe Manana wrote:
> On Mon, May 12, 2025 at 8:51 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2025/5/12 17:14, Filipe Manana 写道:
>>> On Mon, May 12, 2025 at 6:26 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> There is a kernel bug report that scrub will trigger a NULL pointer
>>>> dereference when rescue=idatacsums mount option is provided.
>>>>
>>>> Add a test case for such situation, to verify kernel can gracefully
>>>> reject scrub when  there is no csum tree.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    tests/btrfs/336     | 32 ++++++++++++++++++++++++++++++++
>>>>    tests/btrfs/336.out |  2 ++
>>>>    2 files changed, 34 insertions(+)
>>>>    create mode 100755 tests/btrfs/336
>>>>    create mode 100644 tests/btrfs/336.out
>>>>
>>>> diff --git a/tests/btrfs/336 b/tests/btrfs/336
>>>> new file mode 100755
>>>> index 00000000..f76a8e21
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/336
>>>> @@ -0,0 +1,32 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 336
>>>> +#
>>>> +# Make sure read-only scrub won't cause NULL pointer dereference with
>>>> +# rescue=idatacsums mount option
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest auto scrub quick
>>>> +
>>>> +_fixed_by_kernel_commit 6aecd91a5c5b \
>>>> +       "btrfs: avoid NULL pointer dereference if no valid extent tree"
>>>> +
>>>> +_require_scratch
>>>> +_scratch_mkfs >> $seqres.full
>>>> +
>>>> +_try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
>>>> +       _notrun "rescue=ignoredatacsums mount option not supported"
>>>> +
>>>> +# For unpatched kernel this will cause NULL pointer dereference and crash the kernel.
>>>> +# For patched kernel scrub will be gracefully rejected.
>>>> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
>>>
>>> If the scrub is supposed to fail, as the comment says, then we should
>>> check that it fails.
>>> Right now we're ignoring whether it succeeds or fails.
>>
>> Currently it indeed fails for patched kernel, but I'm not sure if it
>> will keep so in the future.
>>
>> E.g. we can still properly scrub metadata chunks, and for data chunks we
>> may even delayed the csum tree lookup so that if we got an empty data
>> block group, we just do an early exit.
>>
>> Or should I do the failure check, and update the test case when the
>> kernel behavior changes in the future?
> 
> It should check the current expected behaviour, and if that changes
> one day, then update it.
> 
> I always find it terribly confusing when something is called and we
> ignore its stdout/stderr and exit status - it makes one wonder why the
> command is being called, if the author forgot about checking what's
> supposed to happen.

Makes sense.

As there is no way to check if the kernel has commit fix 6aecd91a5c5b
testcase will crash the system. That's a bit concerning.

Thanks, Anand


