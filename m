Return-Path: <linux-btrfs+bounces-14356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89ECACA887
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 06:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47356189C980
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 04:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDD86334;
	Mon,  2 Jun 2025 04:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UoHeTsoa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MQJgXiu5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5F2E62C
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748838373; cv=fail; b=GC0vl7BrtWN0V20mC45FvVY4+v1R1tIDYEa+7oUbbTd55WUuJBxFWtIb9g0tiB+3Z1XvXg3xyJH8x/ddnBnlLCOqgTKQwkhXKf2DwWLZynMeQ9KMskstZYEGKTvGumBvYGJ9QaU+X5kumS0OxkUb4JN2fAV6MzQvCAcHP9ZLokE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748838373; c=relaxed/simple;
	bh=QoUn4q+6YNtKFoBfQB4EQ9AEI7gX6AWFxX4zzP+ohP4=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NbzBqA4tm3tENEXNShzvhk0rOoYoeE4y+QKRLzZDz9yhvkeIqDbtbFLZFt+o5Ww0EVwSlMMjVaSq9i/lnhHQezOlox4WE/m1HAm3p2YSVec+hWF2lEjhgLOEg3IZB1PU0cp5zeY4c6zFMrb/WMY+vRzXLkqMwNkYib77MVKMEvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UoHeTsoa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MQJgXiu5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551MnwRV000490;
	Mon, 2 Jun 2025 04:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BaW5+e2EmUuZE80sLM7rb4oC+PhDm+PNeSJjadYS3t8=; b=
	UoHeTsoaDbq+WbHLTCGdJnoZ6CcfzTRJpB1edhJpGjcUPDRrqm6U7XHXtov8+gws
	kuZysrmtNbb9O1N5Z6uyAdBkO5Dg+cgMj/xzBHWe/Fu/aPfHJBlGDvweZC1W0PoE
	91wSMQN0M01r7Q3NUZx+85BFE2/0q7poYhvDK7+5tlz2YDXzxQdlLHJBuevM5PDO
	LKd3a6kj23NuB5aufbX8EVKEjCl+/JQDrbTYbQ5KqXId88WJMmVlEGFLFvUiBy3H
	yEUipJDslhksJYc1Vfvvk48tHyKOv9ylUH84Ag5CRQ27cURphBLuULDItk/bSCpQ
	9u/I6T7AV3CGiCHKjCeJQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ytawhpj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:26:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55214BFP030637;
	Mon, 2 Jun 2025 04:26:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77fq23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:26:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShuIErrIjxHpNRmv+iSN5jN9ZjbxtcEZW+knJuRhGD17MhkiCwW/55MzYnM6SVROxbSinhTlDkDs2YMnqg3vPnXZriUzy6LTaLasLBKUsG533iZihgGM5wczXJwKu2ahhe1V/EiIerZiBYh7GzaeFcYjGi/GWnqvDtSaDPTwTC3ltSBFlq/JW8csTiR7wAPqd85loAeZJUQfvppql8UAkisixn8ctfRkpMK6Oa4AQCjdM7g1PErjxo6aJsYKg1KMYxLKzr/SLlFlqkvwQmV1k+fojFDcHdpQd0UH+FHlar+rL+4TEqxLc8pSwBw7zsCHjQJzNcFki5EiIghE2fB2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaW5+e2EmUuZE80sLM7rb4oC+PhDm+PNeSJjadYS3t8=;
 b=PniFRh2WGp4uheQPiPpDa5fFybToyn14SFZaZfreF2grtJPoMuM+bixE9AKdMl3NAckl6biJTL/cNCw7UKVjppbuq377CaZOakCuyMaSddMC9oX3HvVWLXrd+0J7U6UmuHl0FDS7NbqzB5KQm57tzSsund8h81MQj/VtWXrP5IswsKditCnCoYV3DJuRv1j3pWwD6eXOe2DAr0sjWBGba6DzoWGVKqMABeLBWtotEtPndZa5mhOmjhe9PS3GbofziYgZ6bKA7vr16o+d9rrpMKwGkriCD1syRN7nZQfZbHs0nl2QKmRXEOfil/hgFKNuOOwRYJ/0y4BF5/dgLaajxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaW5+e2EmUuZE80sLM7rb4oC+PhDm+PNeSJjadYS3t8=;
 b=MQJgXiu5ZvYogVoE7RpGXhd+tbElyBZiUdC4WLK/FJM1yD/wRPMW7rOg/QO5NFCthSNtTX+bPCKGsj9Z4CMRaNQg3n6e01lAHApu6aQvkvX/aVKlswwm3OQYzHNz8EY77L77bs79u8/zfUbmS0JPFbNM3JJilNvdnQoG2SOa7j0=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Mon, 2 Jun
 2025 04:25:58 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 04:25:58 +0000
Message-ID: <d4d89fac-20d5-4327-bf78-07be5894f1cf@oracle.com>
Date: Mon, 2 Jun 2025 12:25:55 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Jani Partanen <jiipee@sotapeli.fi>, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
 <8e02ce99-7968-4312-8526-8b8c0cfee225@sotapeli.fi>
Content-Language: en-US
In-Reply-To: <8e02ce99-7968-4312-8526-8b8c0cfee225@sotapeli.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|SJ0PR10MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: 245a31ad-c347-4dbf-f685-08dda18d92ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0ZGUHpYMmRxbXkzTmsvWFlxdDd2SFdZbWx2ZFlMSjZFOThkZXdQbzdnZy9n?=
 =?utf-8?B?WHl1czZQWVk5MitVSGRCUDlQamJBZGcwdDFpb2k4cGl4QzBrdmtmdTN6Wlc2?=
 =?utf-8?B?LzBVSTVia3RZYmo5QlFtZG9aekwzS3EyY0wrY082cVBla01IS2Y1WkFxTGhQ?=
 =?utf-8?B?THFzS1JuVnRUSlFaUlFnYThWekJuUGI5V1BXbm9hUDVKcjFTa2xBNDFVdUhR?=
 =?utf-8?B?TE1CVEpybFBTOFVUVkt2a2IvTzVVMTlOSElLME4wMkJIMlVOeFFMdEhRUFkx?=
 =?utf-8?B?RjRueVJQODd3ME5tWThUM0tWa3IvOU9DdHVPQUZkczRSa3RYZkxMVjBta05a?=
 =?utf-8?B?Z2JVWmg1SWFzSFJOQnExc3hNWU9VajNNaFJVcnZucTk2eElYc2tvdkJ5eFJE?=
 =?utf-8?B?WGlrZ3IyUklJUFlML2hvMEQrNG13T1FZYmNKeVJ5VytZWGYwTEpkVWkza2Nq?=
 =?utf-8?B?TW1wakhJMnNwdmlWQUxnMmtoclRZU20rQWxCZDVLT3lZdFdDWXdwekZheEpO?=
 =?utf-8?B?Z3V6b0JrQlZzMEdOS01mMUhYRi9wSE84Z3JxMmk3NUpDWURmTmpIWnVFdEYv?=
 =?utf-8?B?eVpQVEpram9oaEJ1WnBXOXdMdnN6ZWUxQ096OTBoK0F4RXkrV2Jkb3FZZE5v?=
 =?utf-8?B?MlpzMTlWbjNMeXNmU1J2QitYVzBVRXBVV2kwZEExbEcza3BYZGlreFZUQUFC?=
 =?utf-8?B?d05IY3BBMnVDK21Ja2ovU3MvckM2UkxYbE1xSkVUMVpYQStNUWNnYTAxM2Jy?=
 =?utf-8?B?OU1ZaTRnTWgwUDhsc0EzZGdZU3Z0TmsrM2JyMjVoTlVqMENTSXc1MjlidGhF?=
 =?utf-8?B?WlBwc2FMdUdETnZvUExtSGpFdjdPencwR1g0WTBQMDdjVWxYeHRrNE9LQytH?=
 =?utf-8?B?M2lGNFFiM3BwUUl6S1VhU0NZSEFwcVNBYVpvbTJOMGxUdk1IbFNFOTBtQUsw?=
 =?utf-8?B?NWc0N0QwQnRqWmY1TVI0OVVJeEdnTURlRWRROU5PdnhKNkF0anFwMWlWWmZ3?=
 =?utf-8?B?WXYvcHN4dzJhN0dleUJsS2FxQ1Y3SXB3eDJza0pWSGRQbU5zMDF1SGd4d3hv?=
 =?utf-8?B?OW1wRjBuZmVuQ21FN1hnOVRQMkMyV3o2L2ttRlpobXdWaHpRQWljVUdJSk5u?=
 =?utf-8?B?VUJjV3NqTEt6Y0p4QW1oVmRpR2cwQ29YdVg2UWN5RUxYczI5a08zQjFESy9V?=
 =?utf-8?B?VDZhc2VWZFhQYkU0S29BSnpQV2lFanBmRnVBQnMybzBrNHE3RXozWHBGOSt6?=
 =?utf-8?B?b3JPdGJ4ajUzWm9aUjFwYllkRFNYeGFKbnN4VCs1UzJjYlEvdVUzMFdzVmxZ?=
 =?utf-8?B?QlFkOVQvWFN4N25UUUd4ajdmY1ZyTjZLL1FuUlJoYlJNMmYxL3cwODE1WkVr?=
 =?utf-8?B?c0hXNUZCQkNXRmdwUVRGa1ZvN05XdVBjSVlRSjgrTU1YRXJZSE4xTUt2c0lI?=
 =?utf-8?B?TGozcUEvN2MyUU1GMk4rdmpZOGpNMGNxNkM0cnV3MEJzamgyS1dwdUZrN2J5?=
 =?utf-8?B?MERpeFVkU3IwV3FqSWMwOUJ5dTViRUU5NlZnWmQ4Z0VCQ3Y3cnQ0RzF6RkMw?=
 =?utf-8?B?RkYrOXlHYXFhNGlOVGFFQU9nUk1IZnZpUTBtTDlocUVMRkh4S2VGZXMyeHhu?=
 =?utf-8?B?cmVPZVVrMkttbmVQSGFITlB5cUNyeEZOcktiOWExVE1iZENZaVUyanRobXAy?=
 =?utf-8?B?K0hReVBBbXhEUXB2emZTNFRBUXVNYXUvZ0ZLc2wvcmRmcFlHVndDdmpNQU1n?=
 =?utf-8?B?NWx4R1B6NWVhTTR4TlJTbTlsdU8xSHJUWnBGWit3T2EvblhUdVBsZUdzTWUv?=
 =?utf-8?B?S2dWazd6S29PeUM0K0VJWlRyZDJqNVFCNUVmL3NKOWx0RGpKSGR5R2pJcVpF?=
 =?utf-8?B?RitEeHlWN2dJNWM4N3RIK1FZL2NzbFNlRTdEc3k1UG1KbEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2YwMDFMUXBDUHUxZzB1MlBZVGFKeHJ1V2pwS3BUL1FaUStVNDBJRjM1WVRD?=
 =?utf-8?B?M29rSFBMUzIrZDN0c3l4ZnNja01kRlZRNHVobzV6bDJBbEFXUWRJMkxrREhV?=
 =?utf-8?B?VDRpd3U5OUV6cDNDNFFsOU5rNThvOUk0Um40UzdPbnFQOFhiYXNzcm8vejdh?=
 =?utf-8?B?TDNVOUhmNlpKc05UTWhSNXlNZnZTZlZvbC9xZy9SS2dDUGdKYS9JSkJyY2Ra?=
 =?utf-8?B?VkZxQWNoekNPY2ZvaWFCaXpReHJIVXdWSHh3ZE5PdG1sZmJnNnN0ZFpmcHVh?=
 =?utf-8?B?RHV3dTdpQzVsMlNGeTVIelF5b1hBckxOMHZLLzFpNGNGaUtCNE5RbVpVVkg5?=
 =?utf-8?B?QVU2UmRTSmtnL3hvYThqOW9ldXR0clJyUlBWeVo3OW4wT1V6K25uWk9nWlBq?=
 =?utf-8?B?VFB4TkhoTHRSK2FtaFZpS254cEtoMlUycVVWWEc1OHFpYkFLQ2hYeEJKS2JM?=
 =?utf-8?B?dmc1a1BraHBseFVQT1A0MWNQUlF5aHlLNnlEcWE5eitCenVkc25nYVBkWDcv?=
 =?utf-8?B?Tm5JRVRSUGhqZ0cvVVpjeXB4ejl6NU40b1Q3T2NTOXVoemVTWE0xby9RZU5P?=
 =?utf-8?B?U3ZIOGxDUzhPQXFURFRXeFdFdGNoMk83TDQvQ1UxUVFIZmxSeXVrVTR0WEdj?=
 =?utf-8?B?VEovdHFJSks2TlVnZk5BS0M5K3FkUXIxdHoyR0wvNGhJaVB6UVpySjc1b2R4?=
 =?utf-8?B?U2VWNTU5NVFocVZzOEh0dmF6Wmp3V3NER0VIQjhneXR1ZVNzZEc4RExLbCt4?=
 =?utf-8?B?WUhIR0tyYWZyTnFwS0pJYWZES0VUeDcrS0FFOEpBS2ZlYjVLTHUvaVQ5NzYy?=
 =?utf-8?B?VGxaOGZBYi9QT3FvN3FHTFY3VDIvT05Cc2RQaTcyRjYwaFpFMThTc1lCVnlV?=
 =?utf-8?B?SlkxNjNPTGNuQzFyUy9FNzNtL1Y2NXNLNWhobmpJQVdCeHF3ZmozMWlxOEk2?=
 =?utf-8?B?WEk3V3FkMHZPdm1TYlV0K0pSRzZYdDY1bWxQOWVrMUtEcTdCOUxidmlnSCtL?=
 =?utf-8?B?WU4wZCtBbmpUVGVKZm8zY1NoZm5iSGY0N2pQRWZrckdDTDBkbDNIRTY1cU5Z?=
 =?utf-8?B?eXVjSnVxMEY5NXd1RXYySGxteDVBY2daTUhiUThCS2xtdi9mVkVZYmFrOFRl?=
 =?utf-8?B?SWxPN1pmbXIxY1dVaTc1M2dJWlhOQ2VDMm1VR3NtYURMK1RLM2RMYjNmUWth?=
 =?utf-8?B?V3RhWmhRaWg4UVo3ZmFBdHdVQ1cyNnh0SkMrclYxSldOSVN2K1JGZm83ZDBF?=
 =?utf-8?B?ajU5UG1TbmpXUDlnV25BRDRQQnQ3UUphaHJHckxvMHR6ZEZ5ZklTNysrWVdo?=
 =?utf-8?B?blpRSzU0YlV2ektPVHZqMGt5VDkxOFZVQ3Q3ZUhUVi9NSWlyMTJsMWYvVlFE?=
 =?utf-8?B?bWphSzJjczAzVnV2MHg5WnU5aDlrNU0vaXJVeUV3SnYvcVRKQlkva3NpWk5a?=
 =?utf-8?B?UHdyc0p5NE1HbVdQYThGTEVVRHRuTkFIL0pjRTJpT0N1R2VvaHZZZlVaRm5u?=
 =?utf-8?B?MWJNZGlZYm15b3VNWXhZaGQ1NXltOC9MS3NOajBJQmpYYTdCSXJ2dXhHOXZy?=
 =?utf-8?B?MDZkQ2pBem10N2wwSEpsaVQzaHVEa29xTTMwcjVrbk1mUlNPdlpXM2Q0cEhy?=
 =?utf-8?B?V3JKM2JsU1paczQ2SURmZG0xMHk4UkdoT2hJT25iQk1sVzRLeTZqSm5LVnFq?=
 =?utf-8?B?TVVnbDVLTU1seXBTcm5CSlRFbStsK0sxam5UYjJRSXRBa3NlMFZxbENQTkZP?=
 =?utf-8?B?dzkzUHlGV3p0NGFlTUdUTWRRbWdGMXZ2RmlFdTYvcmFGNERBNU9IUktSTEMy?=
 =?utf-8?B?WXJWZXY2c0tvWVJwZUd3RGpwek5zZUVkSHY5NGN4SUR4RHNpZytJZ3hXa1RZ?=
 =?utf-8?B?aTh3QmdpMk44dXNadWk5ZzJUUzYzSHJsNXFUZno1ZWI1OUt5c2w0WFcvaVdk?=
 =?utf-8?B?NjZRVHlpbks3K2VwWnBlSWhKNW05YXlJQnlWZ3B2dVVTZ1luVm0zTXI2U2tN?=
 =?utf-8?B?R21jVmRVZnBpYjdRY3l4dmR5NCsxdldvN0NmVmhnM3lUTkFlTnhIb3d5clBH?=
 =?utf-8?B?RG43VWtMclI5aktITnZvMG9BMmx1NUxNQUV3dUduT0FkbVdqeitSblI3N3Bh?=
 =?utf-8?Q?ya3cMYTGX0XbRHaMjWN5OmiGe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9bpPWcLVRkDpU62Jfyu798Z44jh2WoG2QAqIrGonry8n/ahOLVdU5QCpa4EdYNS8D2GfGy45hRmbciT+hLHtXQJEXE2GeYE/SBxkxG4+BKj6wuhkLAXOq+WMBkj0kD9D4JJCSdjpu5L87JLwMpf8pbtUG7SEIfeRACfeZLuwLABtgx+unywRely4Cr9IjAXDH6v5+7vRE9Qb81prHDDi6tgRSnhGdRiKj6h1U6yNiDi9MeHXzlYES7iwk+Hh5HbsobG+ncGyrynlo94CCgtrTOHMmwvTjXa6D8XHlv/QRnyprt7ByeUNXirzs02MM0tPP69fhotjjZXevEvAdsIWD5UryrqM0D85LlPdkoPGuzzEGLZdGnw7n5NmW1nrAEROZ3saaYLbatJ5vQiGBM5rP0abSVizphg9/nX3Pr24cQbXowJu1+m2O30SjPed/G1GtxqhDchl6a7ShOidlytkO2p2UodxZEfnw/e9J1eM3077AUVoMkWHSsNuzMwop4+2Enokd02ng22gzbk/Fg2daXDCK3tYgHvM+sOZ/72U7TBIhra68H0c9cdJWXXP/yBvPrzRAbL9DcX94hOkvOOCkfbmcfDGT25i6lWuGPTPnRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245a31ad-c347-4dbf-f685-08dda18d92ee
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 04:25:58.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHijl2wuEMAHVjyRIIExX7kIGJRWsktKjFMP3vgvh15xIVIEODrvrgi6hnLCv13kOhCpGL5TDrsc6gtGTFK2SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_01,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020034
X-Proofpoint-GUID: h39xLY-6MDm6r1D7L-bL_mfpWqHSg1h9
X-Proofpoint-ORIG-GUID: h39xLY-6MDm6r1D7L-bL_mfpWqHSg1h9
X-Authority-Analysis: v=2.4 cv=ctObk04i c=1 sm=1 tr=0 ts=683d27da b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pz277uOxTbUXYtKzSAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDAzNCBTYWx0ZWRfX/+zSWlf3S7/G D3KN9ELXWM7yQNt0OIP6StLD0c3jhcVYTXEhY0WkZ9cMUnMk9h6I7cytoZP69Lk8K7r0VXAxZEw fcnABvt1LK6gmt5v1LmnJOXEiUJS7/mwM3XXryBdShD4YxK5/gHoMQhD5UjHPhKR0bKY5GXGq3v
 pQEi+WRR4SLTKc9lvIm/TyRyEGlUYyn5vBSAE8A5I76uvTli0e0XOM5lningJR1aTMT3wxy2CEE P+qtJqC94VocTr/4xK1uQRNNNs3ipcXm8AQiTppjARsK15kPlf4+Miciq5YRZAPLN8hsj/kiUBY eXE3tZJqm+OUMOORHfthSfqeAFvJa+MyX6qrjHhAE9fyN8cE47hOZCvdz8NYziFTjQ7/2Iyq7Uc
 jgQ7eqZZYRLE7JCFiHU48HtWL+wEbL52rjtyTi3XmrLYMZHtAJvtgAtUKPuWwaB44TIH5+zm

On 30/5/25 08:15, Jani Partanen wrote:
> On 12/05/2025 21.07, Anand Jain wrote:
>> In host hardware, devices can have different speeds. Generally, faster
>> devices come with lesser capacity while slower devices come with larger
>> capacity. A typical configuration would expect that:
>>
>>   - A filesystem's read/write performance is evenly distributed on 
>> average
>>   across the entire filesystem. This is not achievable with the current
>>   allocation method because chunks are allocated based only on device 
>> free
>>   space.
>>
>>   - Typically, faster devices are assigned to metadata chunk allocations
>>   while slower devices are assigned to data chunk allocations.
> 
> Now if this could be expanded to allow tagging fast drives as write- 
> cache, example I would add 256GB nvme drives or partitions as write- 
> cache so even with HDD's as main data storage, I would get very fast 
> writing.
> 
> Ofcourse cache would need some task to empty it after x time or it would 
> have not much use. This is currently issue with lvm caching. There is 2 
> type of caches, one is for read/write but when cache is full, it has not 
> much help for writes anymore because it filled with read cache. Another 
> is just write-cache.
>

Thanks for the feedback. A write-cache device is quite different from
data or metadata devices in the kernel. I’ll look into it once the chunk
allocation part is settled.

 From a UI point of view, write-cache could be treated as another role.
With the current mkfs.btrfs device option scheme, we could add it as an
additional role alongside metadata and data.

Thanks, Anand

