Return-Path: <linux-btrfs+bounces-4774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9A8BCEC8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11FFB268FE
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83C76408;
	Mon,  6 May 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cyylEQbJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="llgUGnI9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89254EB45
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001470; cv=fail; b=sttqxXNyGYT0syrHstoZbUG+lEAUHpyY/CSWlxi7BSsn1D7qZxizxsxza/CPRBw9OnMFTLXveN+zJWnUcxBxjMmg19LIlHsovE3M4c2WU+55u58ovb5TCmdCKSlND1rNpvmWgwDBnJrLqpD4IpCV/RQg9nkTXfLFNd4c0YPBTYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001470; c=relaxed/simple;
	bh=OX6f8zlT3pI0CWJZyL7JeMmQqB4IztLjSPiWUnK/+RI=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=cIfpOkiqx5ZvBnYAKapcJXN+j1DtgqNr8TYVqufoWr7piJx3NyRwF60naLzmtAIW9/+IyTaEgoFB/feAzxtv/sa8JPgmHPSAVNH5JtYd1X4wXUPI8E9iyl1Q5aHiwNGdAG6WvgwhWgZvZjZ4wekkXnD2NUCVKQPrlJYyNblLTfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cyylEQbJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=llgUGnI9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApcrN018813;
	Mon, 6 May 2024 13:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dWjABWbH5KSBHW3zNlWUcPyUMai/+zUWDBpaggqdyfw=;
 b=cyylEQbJb904TPFb7/xehO3eoaKq0afxm+KAbhNGV3QLejBlZPg1c44kPBrALseNZQR5
 gkg8rnes/FWOUGJWLfXOW9g/9FfIRGPQgK4BGAdXbl5mBk6FcROTbAuO4WwaWAS3tV5J
 TGSCBw5/2EhAS9lD2k7m83Sc9jJ1e3BQBqIsUyMtFgCqvEKuVMaFMqLlIgveiDn4vOh2
 wVP/hJ0IO8PMCt7DH15RYZT3eMOZk2xc3iR1My/aAmv3hgDzfjLiySd5M96A6v9YjRs6
 9BUh6ArBmYqzJ9UF0Cwf2i8e064+z6sY7LKSZN1FhDwVGzb6hWFmd80A7WaHPRp5Dmfu ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5jk2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 13:17:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446C6iZF029264;
	Mon, 6 May 2024 13:17:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfbup2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 13:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8W/ILC5NTGLl/aTW8UiU5p4T0KVOZQykZ+qsL6oeHtPHznPxm/epQNvKCsIAxs+KBX0eaYN/Aru8ZSX7pNs+uaZ0KnEFBeW2/XPa1yRPDq0Y+z/yzdsFVy3y5krPd3Hn+iNFnCq4Q9xp1rAstRW/5aDDmx+aVI0vKTOScqw/qpm7Y7CIDgcuXif1QaZEPPDRkU0HDtgRaksCWG+dr5ugil6YH3/rZ4UhckpY3VGBXTofyi70niUhneyXVrfMmZV8eqj+3PlO4UaZc1Snt0xfKMpRqwxfRC5diEaDWcBGVYwtDXz4dkHqpxAoNviIA17nC1VADdG1DBZ+0/voPlp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWjABWbH5KSBHW3zNlWUcPyUMai/+zUWDBpaggqdyfw=;
 b=PPq2QLSH0WLLjj9IKaaWGFW37RWBdi5gzJjFit/c3TDFHiXgDff3wEYMw55FHx0SXn9cMKo51T5kXPNwafRpAdHDCzluca7oyB0zIvixhPeByFBeVVIk9AyGrdI57szV6R6//6DreUpSmBNVlYpjuiaUNW+eUBFHTE9fpunk76ONis/lGKVsImnaRTgoQMnFvLjG6Qrle9T0XZY6UZCrfoKLpc82C7lJDusBr5XiVNd/eQZSBpg/teyE6tUcQONEaG6nbg9wcet1cgD/le5WB9uBOqCNpIOXPjqkI99m/S81MDOchHBgIhJekKTJl5g01Dh7uZYgVNa74uy8/gycgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWjABWbH5KSBHW3zNlWUcPyUMai/+zUWDBpaggqdyfw=;
 b=llgUGnI9SQZsWS1uRE7VE3nQkLLaq463jJYn/mEmGgF8jDozqgeUbGNLsvGcvV2H3Rz0ohtXbHDeTJsN7ueAx/IY95LzIw3fghL2LoIK8n5gxBIR3fMrQkNpJKWb9Ldeo/7HfjI4JuLfV3rxuRzbvadieicnO4pn4taT/bQwILI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN4PR10MB5576.namprd10.prod.outlook.com (2603:10b6:806:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 13:17:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:17:39 +0000
Message-ID: <2bcc9d83-2442-4b06-92e8-2006eb980c83@oracle.com>
Date: Mon, 6 May 2024 21:17:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: Yordan <y16267966@gmail.com>
References: <CAE0VrXJhJT98yucUDDvWTbcdXczTM4Mhy2XCqZtp+H00FYJfkg@mail.gmail.com>
 <CAE0VrXJ_8ZYjnKs+DQo1bmh7PxkQ=J6cWss3Fci0L2__mZbxxg@mail.gmail.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
Cc: quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org
In-Reply-To: <CAE0VrXJ_8ZYjnKs+DQo1bmh7PxkQ=J6cWss3Fci0L2__mZbxxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN4PR10MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8a7546-6f9e-4b73-1c31-08dc6dcee75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZGg0cGozaVFzcnQzY0dWWmRscDNUd1g5Y3hLbHN3bHNZQlBLaEd1QXZvTUh5?=
 =?utf-8?B?RjA3c3UzVk9aMFJhK3g0MlpkS0RUTlZLbjNFMlJuWUFSN3BXUDYyYU9XaU9x?=
 =?utf-8?B?b250OVpSbFU5Lzdua1J4bVJadUlzeXRmOG1MblpVdUYyS2tVQm5memtKRjFz?=
 =?utf-8?B?Zi9TYjd0VTNldS9ZUTZlTm1MSUl5cVNGYjdUaDRjbnBTRGEram1icWhIeStR?=
 =?utf-8?B?aXg0c0VYTGppeFNkTnpqaDhYK2ZlN2ppNGZUNFFHbHpnekRqdkwrZTZnVnF5?=
 =?utf-8?B?Mkt6THlLYW91US9nSUkwSWQzZGNmTGlxL2dMV2Z4UnBpeFdwYzI5Y3RVOGFE?=
 =?utf-8?B?L28wb3NNL0dMOFluWjhGcE5lRHdzVS9VVkRRYTUydjdSR0JuZHhpNFdSdGM4?=
 =?utf-8?B?VEVQSHkyOEZGczdmckRCVURmR2xKRXFQcmhJdjl4NC9uMnVxckFRU2dWQlhV?=
 =?utf-8?B?a0EwUHFzQmlnU3BjYUVrVk04VGlzRnRJQkJhZ09QWGcxTERZZjBicVpSd0Rt?=
 =?utf-8?B?aXVWdFZGRnl1ZE5CeGhBQ1FHZW1zWXhWN2Y0MGpyUE9ESG9HbEpoa1JqdmZ4?=
 =?utf-8?B?UG9qVFBrYlo0YUdlRDdCSDZSMjlRb2gwVGZBMG1SOTdrdUxzS0VCRHFKTGRC?=
 =?utf-8?B?QTNseWpqV1FkRXJCOVdNN0YvNnM1bTl0OFZNcXNadlUrblEyOTc3cDhBaWRW?=
 =?utf-8?B?Z0VCeDU1OStnTSt3YzFMUlBmNktGLzFRM25tSEd4YXhPT0VuRVltZUpXeVRn?=
 =?utf-8?B?L1BEYWwzdTlMVVh1ZnlnaWQyU0FTYUFiVTZISjdqRVk0L0RTaTJKNWdwWnRJ?=
 =?utf-8?B?a2huaUFMa2MwSDMxbGJzbWZsejZkYWJGdnYrV2lNQWQvakxLRXpoL05jc3R1?=
 =?utf-8?B?ZGJmeis4c3Y2a2NwWWZOSkt3ZHlYNkpqcSsrd0c0VTltSDgwV2xQNDNMTDR5?=
 =?utf-8?B?ek1CMGNTUndKS0ZGa1dydk5FUDlZTHh1bU5wWmY4R0s1VjdWYTUwTlRUZGly?=
 =?utf-8?B?UXBSQTgxZ3FqWVNoVCtqbkNzLzM2WUdMQnp5QXcvRzBjUWdmU09OTUNpMXRF?=
 =?utf-8?B?N1AxZmtYMXJ6bGl1R25udzhjcGJ3aXJuR2FYemNUM0swdnRTZWs0a3YvRll6?=
 =?utf-8?B?SGVjS2M5VUtRYkxLNU9Ia2huWFAxanUxdjlVOWYwR2JxakxGdVp5eGJIcjR5?=
 =?utf-8?B?ajRWejdNbzI1cEFqRzlXbnpQbU5jMWkyaW9NelVnSlcrcHRCRnR6NnhBR2NC?=
 =?utf-8?B?eStWcTZVYWJtOGorMjNVQ29id2l4Vno1UDI3VWpMSERGR1dzNVVRL25oREZK?=
 =?utf-8?B?ZU1MYWR3aTRyMXIraC8wWjBoQkpHLysyYjE2Uk5qb3I3cFRwVEN0VkRtcko3?=
 =?utf-8?B?bXp1bDZFY0VUbEN3WWdGc3NucGRDbENncTR0djNLVzFIZzN3dlB5SHlYMWw2?=
 =?utf-8?B?SUlMcnh6R0I5T3FJMy9pYTNOZXBLR0lob0N2dWE2QzBLbHlDRCt6ZFk4ZzAy?=
 =?utf-8?B?TEFlT1B5bDFyMDFCR2pjNlZXVDkwalVHbkROaTZtZ0VrWnFnNmlPNm5jSmNx?=
 =?utf-8?B?ZTVRUEtlL0xBSm1ITTZaZC9qamJ0UUhVNXVMY0l1UnZyQXEwTjZpNEd6WmM0?=
 =?utf-8?B?R0Q2ZUhtakUwN1dSR2ZNWWFkQUgyY2FBbHdqeTVtSDk1bE1BQThiNjh6bThv?=
 =?utf-8?B?dU5XWFNvSW5rbmUzQnlxbytoc1FIZGd5OERKMXBkOTNpUVlFeVd5UTF3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUpwUmJCaVFiOTQ1ZEVQdDBBTFc2WHVPMnJuNTV2ZmJ6L2JxbXlTcmRpNi9U?=
 =?utf-8?B?OE1uMkU0Y2lzb09HcTJhNXFXZTN3YitpZWNsMFQ5UXQzUGY0UkZEMlNwT3pQ?=
 =?utf-8?B?bnBsN0RaNTBTMjVLTUsrYUVzUzlpcFQvcGhBZS92QTlFYlVoMVRNTGo3TEwx?=
 =?utf-8?B?OFE1bWFjUUZlenFXVElaNTRZWUJzbHR1M1ZPM3F1cE43Y1o5ejh6NzlScVRV?=
 =?utf-8?B?N3gxYk4rMjh3ZXVwem02MHFDUEs1UWRBaHpGVVpVKzNtNVZqcFpjMHJkMHdV?=
 =?utf-8?B?RTZjQXFoZTJCUmxaaEVRQWlDaEJWTSsvMTE3dDJEbXNZVXFaUWJReEkxQk1U?=
 =?utf-8?B?VndlRnpVRk8xOVEzQ1JxYWNsZGxUb2EreDM0em1PTCt0Q3NHWmttM2ZFbmUy?=
 =?utf-8?B?L0pjVU1SVkZKR3lUQ3c2ZHRobEhHRDBXaUVUTUwzdmZick9yUlBiMFBjSC8v?=
 =?utf-8?B?L3FTWEVFclpjSjJ5TjFGbjVMem1VNjI2ODJMOTJJUFNWUTNibmxhMjZnUmR0?=
 =?utf-8?B?aGVJVjNWZzh2M0lpaHhMT2dDZ2pSdnR2MWk1VHVlUEJTZDk2elJ0c3pJMjlk?=
 =?utf-8?B?dE1udnQvUFVQVXg5VW1KSW12SzNTTDRtVkJBWTROUUI4MWlxVTEwcWNoVS9q?=
 =?utf-8?B?Zm1QUVVaeENRQ2RxbzlWcy9qQTZldE5yVG16dFhxMmlSR3JCdks3ZzI5Tmt3?=
 =?utf-8?B?TUJOa01lS1BJNERUVmk0b2duSFRWYnZhdDNWRkYva0JQbzVXZDlnNEZITnJK?=
 =?utf-8?B?NW0xbnh6YVVLTDZMSk9RUUlwV1cwNHIvT3dabE9ldGhJRlJ6OFlRaDZYb3hn?=
 =?utf-8?B?NzlaQVhpalNhZWlEWC92YTBBTzZqU3R6aXBOSGkybkNSdjhPMjRtcEsxL2Vn?=
 =?utf-8?B?OGxxVE5nZDdxSGNzc0gxUERmZWZCaVd5WFc5MjVYQmpyaUU3N25TY0d6dEVF?=
 =?utf-8?B?TUNPblloME5zbExUQXFraklPOWEyY3VDYXRoQmQyOTlLWHFTd3cvcFJ4bXVG?=
 =?utf-8?B?SFREV3Z6VGxFclVuVlZrOG9RaG0wZ002NzlLS28vbDUxVVRBdzRkbFRKWGZz?=
 =?utf-8?B?OFRtbk9wZmNuT2xFTWpoakwxOFVhS051YXRuTnpJb3NwYm9CQU9UTE5ueWlk?=
 =?utf-8?B?dGhSOEJPeGRkVm0xbDNEMzFlUm9MYkZXTDVkQjhUN0FOaVVTRUdjWm8zNHUy?=
 =?utf-8?B?WVRnY3I5TldFN1JUNmFiMEhTQjhiU25jMmFFQU1MZGZ1cWROQm9vRGNOSDdD?=
 =?utf-8?B?R2NIMnQwN3FQWFRwcVVZSGhYUHdVZ2Y2YWw2WXNLaFpKQ2RNT2FiQmsrMHhL?=
 =?utf-8?B?aGR1Wng0OXh4clZsUDFZaVpLOHlLMGdkQnc2WG1ucEthbEpGT1NPMFdlTHYz?=
 =?utf-8?B?MVJpSituRGt0QUllclRSL29yTkJDeFRoSXNvSkY3MHpNeXk0Y3RCckFOYVFQ?=
 =?utf-8?B?YjFHTW4vT2hxSmZPWEFEaG42YjJRUHVUWXpsQTZXOXFkVnBybW84UXNKZHBj?=
 =?utf-8?B?OXdwUDB3TW1IdnVJRFp4eVdQS1hRZTJYQWhiK3BVU2FyazIvVUZlK1lQSk1a?=
 =?utf-8?B?QzFiajdBY2FCQTlHLzF1K1NPeVBYNkkvZVRUMkZ3VFYybWlNVnd5R1g1Ny96?=
 =?utf-8?B?RkZTT1BCWG5iUC8xanl0cnVjR3ZkUEpFY3RWaU44STA1a0xqSXZwS0UxYzNE?=
 =?utf-8?B?YS83bmttYUpya2Q5cHF5WEV6RVczSWhxVzdhNVZ5UzkrRUJaSTRsUmIvalhF?=
 =?utf-8?B?cVphZVQ3SXpMTDFyZmxrZ3RWblB0cXM1OFo0QkF1YmVpYU1lc0NZaWMvcE11?=
 =?utf-8?B?cEcxRDZMTUorRWR1aGxSb1J2WGZxM1J3TE9lNDFBVE1SOXdnd3AwRVZtOWZW?=
 =?utf-8?B?TDJXUHcreVA1bkJ5Zlg5VHJVc2NHVTlXOU05ZzIrQ2orUnNpTGFYL3VQNzg3?=
 =?utf-8?B?dnN1U0RnY0xJOHNYUFNOKzIvNlJlVG1iTWRXa0pNTzN6U1FYR0F1Z0xhclda?=
 =?utf-8?B?cEgzakhFNjdVVyt2b0YwdWJ0azU2OWl0SlVGcUFKQjZpRkVMZHQvOHIwa3Zh?=
 =?utf-8?B?RDlaSWdESWREL3RpTGw0TXdNNWUvZ1dQUERadGV4d3VUVzVhWHhtSmtmQkVq?=
 =?utf-8?B?dUx4ZTc1M21CalE4cVhXZmIzd2thRWtocVBudDV1Q3lpNnJVVDMxcG50NVVD?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yEYeKXiNCQ4zeFUIvwXz76y8uE27QQFhX1Yqbztj6gAt8JHdjjdrJkirIDV/qEgi2DLzP2OypuNwZoUFEy9OnpNYQHAFxkF1e+Vl8/s5QvzwF9ZQfLXXATPjh9keuqMmNoCTYeDpK6GeYKOXZGeFFTeTP36wOn4VrVAi2IjtFQpfeg15iH+Tq+le+YwmbxrBhPXOQvozjFFjEHKv8GRCqZBf9MQjye05ZTuKASaiH3WuteJdwz/38FZyNZt6vmY3acmMf1+wIRGB5N3fmOxHk+bMZicQC0UO5OAfoCJZXzI1FV7eUnQwI/MH37hkz9rVoMilCmN7GkC4739un4nCkb71e7zaKIMVJcCAvBGxe9RYU6G4GPoHSQ+gXNNsQRd+zxOV/Wk7qOtN+bRexvbcDv2qn1tpJhfGiYj8La1yLXuOeC4KeVgAAoA53/gGTDWQj9W8cHX0dO8f9fr6E7GC3zo3C0JxPahIfHvolV3Jwt5SSV0KaaPSnVG+OK5PDfkD8cfZnvIdXtjXlIeWZCFhrF7A0Z4QLRKmMi3TfWOZj51+1vLmWpU4kSI+hYB3fyrLn3sMbrpB0UGGFMPZUlW9MJ9lpUMNQAK+qZXopSlngCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8a7546-6f9e-4b73-1c31-08dc6dcee75f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:17:39.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91MIKjdeYxl2yd1jSus2WIZU9y7sgltFM5KOJunyqiR+3MMxTh26+52H6McrJn99nY41882VsSBMjq9DvAGH0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060092
X-Proofpoint-GUID: gYt9SrRY867pD9eEP7wJrVIVlWrbrha3
X-Proofpoint-ORIG-GUID: gYt9SrRY867pD9eEP7wJrVIVlWrbrha3



On 5/6/24 18:53, Yordan wrote:
> The attached file which is a reduced version of the problematic image,
> produced by removing all files and directories, except 5 of the
> problematic files and their path. Then its filesystem filled with zero
> file, shrinked with "resize2fs" to 512M and compressed to 7M.
> 
> md5sum sda3.img.zst
> 9eec41fee47e3db555edeaba5d8d2e9a  sda3.img.zst
> 
> (chroot) livecd / # zstd -d sda3.img.zst -o sda3.img
> sda3.img.zst        : 536870912 bytes
> (chroot) livecd / # mount -o ro sda3.img k
> (chroot) livecd / # find k/ -type f | xargs md5sum >files.md5
> (chroot) livecd / # md5sum -c files.md5 | grep -v OK
> 
> (chroot) livecd / # umount k
> (chroot) livecd / # B/btrfs-progs/btrfs-convert sda3.img
> btrfs-convert from btrfs-progs v6.8.1
>  > Source filesystem:
>    Type:           ext2
>    Label:
>    Blocksize:      4096
>    UUID:           b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
> Target filesystem:
>    Label:
>    Blocksize:      4096
>    Nodesize:       16384
>    UUID:           d7c77d2f-d470-450a-ba0e-b6567ad3f4b3
>    Checksum:       crc32c
>    Features:       extref, skinny-metadata, no-holes, free-space-tree (default)
>      Data csum:    yes
>      Inline data:  yes
>      Copy xattr:   yes
> Reported stats:
>    Total space:       536870912
>    Free space:        326238208 (60.77%)
>    Inode count:           32768
>    Free inodes:           32743
>    Block count:          131072
> Create initial btrfs filesystem
> Create ext2 image file
> Create btrfs metadata
> Copy inodes [o] [         1/        25]
> Free space cache cleared
> Conversion complete
> 
> (chroot) livecd / # mount -o ro sda3.img k
> (chroot) livecd / # md5sum -c files.md5
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite:
> FAILED
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite:
> FAILED
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite:
> FAILED
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite:
> FAILED
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3870112724rsegmnoittet-es.sqlite:
> OK
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite:
> FAILED
> md5sum: WARNING: 5 computed checksums did NOT match
> 


Are these test results with the v2 patchset? Thanks, Anand.


> Regards, Jordan.

