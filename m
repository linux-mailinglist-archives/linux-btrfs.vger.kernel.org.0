Return-Path: <linux-btrfs+bounces-11523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D1A38FE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 01:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0F91890CD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D3BA4B;
	Tue, 18 Feb 2025 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XBuZrD4A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PXSlWKy6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC68F40;
	Tue, 18 Feb 2025 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838393; cv=fail; b=f8WkFbULLQL4yzAHKbtK1jnaKSnVHo/Fi6xPMun/Ey/KPEd97nZYjS+T0+eq+f1Hkr4RalyNab4h3sP7YEHlUQrQo1pnqAMIrOm9zgUOgmbvBUY6x8EEmW3+jsZnpwgdHqXuXXynTzM0il1hw3u7PKzxy39aYaHOqCyBbrIgrFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838393; c=relaxed/simple;
	bh=sDzTWUHxfc9njBAQkPrWAFNzdn0Q4L7pE1dg/PxWB7k=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aKIdoNfpWOfwftQKw5c/85IDv83pK9Jiz7zReAL2XDPFSosQftYuSrM4U2vdDKbqDJOtuL39ejR+f/Kych6xlw4Yf7vbTMv8Qq65+G1nX9tF7rPayMVbZg9ydsSkQBDnwDxKv4YHe6e115z9zcsnoLpw5Poikj+K9kYNsQsScQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XBuZrD4A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PXSlWKy6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HLtZ8o023718;
	Tue, 18 Feb 2025 00:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=T+7c79TlhtEnu6ztqZrqlRtseDWI4ydCbfG2NuqFo04=; b=
	XBuZrD4A7VaVDHvm98leBmrSkxKo7qAwUuJua4S9O0TarT2vBauYNUUr86UCVHf+
	HcI6nh6rw+FRULbO9Ww//qIUm/94Zl15YaZUSlQvr1adzr78bnZza60sPzRPUb1b
	O+yZXOoolfB8eVZoNH+Ssw8D0sffO3lNkV0Fl8iJbiaC7ko92anZfDVwdcAZHO35
	r0JSH6Qf3rngbRhlr7e9zEuFf9D499evuxAdM1UPX0J03tMo3qYJnPbXWOaALnGe
	usY/O01oKC4s42IeCVue5umq+Qc1Wkw3InJPVa06vNxktnMlOe5Bb6A/Cviz5g7u
	nTz9meoM8oVKcrAoFuWOSg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhsdahp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 00:26:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51HNW9qO027796;
	Tue, 18 Feb 2025 00:26:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thc868pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 00:26:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pm4GLJUSkPql5enOG8BUytt7z8o+RS8/rk/ZB6I7++9rwh4e5MENPGj8Pp4vAYjREQzMlCGLuIPbxCLMnNhlhE74i3wREXQuw1Bq+aOjT3t1Va1L+Axp3G/+myhkt9hOgkUDHY3UaIjtRZ59aTgxi8FHZsKHlWbpDgG5IgqX2vkb6XSLGDBvQtGpnculXFgRpmQa6mb/WbfmAgdxiINahAGwtvIWFboLHN4RYRZskWnkIqjpO/T3054u6Pu8vKmlyXWFM3nzcboSNl7pjFcdpLYcK7rPbXjdjbwiR6dSJ2ZUCqgATcol1IQ+g5E9D3rbxnSVLumqhYuyIe9FEmVAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+7c79TlhtEnu6ztqZrqlRtseDWI4ydCbfG2NuqFo04=;
 b=Vcanr6ookHjOniMY39lUgsJ5sb5NDwMPt2pSdZVIC2znAIXL1wqTuUouOK/7OgsrXUAbvIGwfZPmPrYzyzZ9UqnAmHoLCsklv/jhOlxKVHCx9BKbHftN7ZkyXagB4Nsj1rSyj16gTQ1rDZSS02m7Y5xG6BKGlaHnHrdiSGqyF9JY/T9c71gYQs9OeI4Iq5KMZ7O8JQg7XI9YfwuI4gY+1ybacP/NHhxnDJtJgxUcrLkzjdOmUF9qWYMyq1vACigaTScqjCgZoKnheE8GwTRxOyFAFVf8W6INyMvbe+qYAr7lwlk7rmZ/6nmFheb6GvsIFEWZkH+tzxlzKA4ubXupmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+7c79TlhtEnu6ztqZrqlRtseDWI4ydCbfG2NuqFo04=;
 b=PXSlWKy6iBpFj4cpcKlI+U4TPYgZshivGFXor/Y2tmbZwKzjp7+4vDqlhk3mWsj8MzK4us7tH0t4g9c9tuuqOw0ePMUfJp6H4U/IGqH6iyFIyw9bc9b80Nt1H8o9g5Jpf+Y5jCYs4GABWK8GGYCOnBb9UhLVbvn+EfBS7cOKu1s=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SN7PR10MB6956.namprd10.prod.outlook.com (2603:10b6:806:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 00:26:25 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8445.013; Tue, 18 Feb 2025
 00:26:25 +0000
Message-ID: <3b2a541f-da83-4658-a47b-8b8a1ea75b83@oracle.com>
Date: Tue, 18 Feb 2025 08:26:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for master and/or for-next
 v2025.02.14
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <20250214110521.40103-1-anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <20250214110521.40103-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SN7PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 01aca2bb-feea-448e-a756-08dd4fb2e0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVweXY5bU95czM1WE9hUFR2bjV1VHB1UnhxbnZHMlJsR01ueWdkZ1hXN0tN?=
 =?utf-8?B?VWw4MFNMNTZTc1JBRG10c3RNOVRFdGZpY2VFOU9UVkdyUFRVdW5nc0xzTm82?=
 =?utf-8?B?S09mdGZac2dzSW1NMlQwcW8ycjJZNmlETFRxRVJrblpsbFVVQnZHeHpHV1Er?=
 =?utf-8?B?TkZkREI4U1BXU1NpSEdFWG1LTjlKSy8rQ28waFFQWmhHY2N5dkVJUkR0WDJ3?=
 =?utf-8?B?OHZtMUJjN2ljcTVUbjdrRGlVNXl4NWpac2w3LzE3YWlWT25Cdm9Mb0FqR2Ex?=
 =?utf-8?B?bGN1S29oRUd0dGlmTnc1bXR1a1lCSkY4YUhOdEttUTUvcmJMMFZrWXlld1V3?=
 =?utf-8?B?M2RkRjcxODVzSEdTbm4wNVdiMDc1MGJwMHZKUXZ0akxxcExuKzdLcFBuQnZ2?=
 =?utf-8?B?bC9aNFMrWGdmTnROdFg4ZUF2dTkvWUdhNlpVZTJuMjFQWXB4UjB2SE9STmNw?=
 =?utf-8?B?alRjN3ZhN05pV3c2VUJpUHFmUE5NazRldTVJaWlXdEYvcEl5VXFUQmJJTmEw?=
 =?utf-8?B?bGZuZ0srMDF5bi95TGNhSTVIQSsyekJCY0svcWZ0dTNHL3hKYUJhdWFIZlg1?=
 =?utf-8?B?bVRVeDVUYTJRalhJWWFDRDcvN21GR2U4WERMQUpoTlNFNloxRTJjQzh3ZUcz?=
 =?utf-8?B?Q0xKc3o1Njg5Z2NjWnNxaG1VbnJyQUJPZDRJTitnVjFEUjdDMjN6WWVrWGVW?=
 =?utf-8?B?MlRwVDFpY0djMFNzSEp1c1Bjekw4OWZEVjluZWhkZ0c1RUMvSU0rWVJCRGJy?=
 =?utf-8?B?WElQNE9NYzdKNXFGMnhKNmJSQnVNSk9XdTNEaTZuR3FXUVJreDFxalNuMm1h?=
 =?utf-8?B?WnQ1QnZtQll6WTRZbkdBQ3ExOFVBTFU3MWordms0WUtnWmZTTkRLT2hCL050?=
 =?utf-8?B?cm5PazhXeThxeFhaaGRtWFdyemY4eEYwdjV6K1JybUV1UU9WK2dxczl4RVRv?=
 =?utf-8?B?M0JjZFAyaVlHZC9IZEpMSndBdTRBbkw2MlJ2ZjJ0RUQxUjY3MVpEWGRLYlRk?=
 =?utf-8?B?WkdGZG9zSHFZaEtzNlByc1QxaENwSERqbmpUVGpTbWFaUFRJSzV5MVJQd29r?=
 =?utf-8?B?Y3VNN1I4VHdKYzVGQ1hCdTNIVUNQS1Y5eE10eG5mMm5MeWpmYldjWWM0RVRq?=
 =?utf-8?B?dXhUNG0xSm5vRkFwa0plSHI5N09rcGphZW1HMnRoQjQ1Zk9OOFM5a1BYSjVF?=
 =?utf-8?B?aVBza0V1NTJiRjZ0NUczZFhkV0ZoRUVZc3BFUUlVL0dFRVB5YzJZVUI2MGdr?=
 =?utf-8?B?ampJcEJxa0JYM2x6UGt0cmt5L3hxYzhsSGY2d2VNYWxYTVdDa21jUEZIajIy?=
 =?utf-8?B?WmxlcXBxcitOLzlrdVROcmo3Vnk2TG5YNUdCYW5yTU9NTytSc29LRmtrNFFT?=
 =?utf-8?B?VzIxSWE3SFcvUWx3aGRrd3h4WUxKVmdIQkJ4M2M4bEpkYUUvQVlSNzdLbzhI?=
 =?utf-8?B?Rml1OU5ENzRLVHMxemdRTU1xQU94dEdYQmM1RElKT0V0WWlWSk9xTm1FMkU0?=
 =?utf-8?B?VHA4YkFyUlNLYVpIejhha21qSTBubThSSWltUUVYZXVxVEJncDV5YzJqeHVG?=
 =?utf-8?B?NWlHSm9uWlg5WDdYanBaT2dTOUVYZWFhL2lIYXlwakFxTFJQV1JnSmdYVTN6?=
 =?utf-8?B?YituSTVaZld3eFdxRlF4S1l0dXcwd1QrTVhTMDhPNWNSaUc3eU5RUWg4QzFK?=
 =?utf-8?B?TytQNU9ia0VTazczWDhZbXhmZXhWcE9Idmw5NGZ5VWVoenI2SEdQSldhdGF6?=
 =?utf-8?B?a2pLU3hLRldTZDNRaVE0bmQ1alZyb21pd1pDend4U3hIV0JVQ3AwVVd6YlJT?=
 =?utf-8?B?WExvaTJaVlcrWU5kam9FQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1k2UE1nTDNsTERyNEw1STBXalBINWxiNit4eGR5VGxtV1JqOHRBMTZqcEk4?=
 =?utf-8?B?NHExcE45ZHJEUXNES0lZZGZYbVhyTHZnWmpmL1ZwVTZMa1dKbWVPZlgxYzd0?=
 =?utf-8?B?b0RaaUpaTGhxUmU1NVJXV0I1RUh3M1lHQ3gySzhDUjNVVDBQeVJrNmJ6VHow?=
 =?utf-8?B?NGhTdVd0NkRhVUxLR2pTVjFrOTJ5VUV0OG1GR3hDUkMvYmN6cTljTVJvNFY1?=
 =?utf-8?B?ZG5EUDlDZmx1VWx5dFpNNE9ldkFJbVJPRTA0UG5VT01lOFQyQUFLdzJ6WThr?=
 =?utf-8?B?a1pUc1l5bTZyTHlDc3VpRW9iWm1uUWt6eE5FTkw3STQ4UTlmSWxPejdQcE9R?=
 =?utf-8?B?QWErTjZvS2FVaWloVUpyL3FhUE5VdnZCQmFtWXNza29GWE9VSVJZVTVNTTdu?=
 =?utf-8?B?bjFHTzJYK3ZqVzhQSEgwT3RnMTRpekVCYW5kb0xZWEl5SHUxZVlQUVFmRVpM?=
 =?utf-8?B?dUdHVWVGc2w3WCtVaFpWV0VxTW5qTXpxZWxtT3FpQXY2RENzQWxnbC94UnhJ?=
 =?utf-8?B?MXBBVVFPZHZCY3hYNlJ1UEhVY1dEUktqRjZDWUx3RmNOTUtvUzVob2hNd0Nt?=
 =?utf-8?B?VlhlZElMdFFWTFVld3ppSGpwNHZxRHBEblRLUVJtYVZhVVFyRnJIQmlFSzZx?=
 =?utf-8?B?cGgySFhKSldhYVpPU0p5ZHNJaE9JdkRWaHI2RzF1Y3FDYS9oSS9yUTByMk9r?=
 =?utf-8?B?MVkwQjJ0RGhVTmRJS1pkc2ZMRXFPSC9uNkZrNFhISXk1WkZzRndyak5IMHpk?=
 =?utf-8?B?NmhBd25OWEZDNWwrMDdjejRhSmIyZm41WXhjL3BKNm5xZmk5N3RMSlNiQjZN?=
 =?utf-8?B?U1B2ZVNzV3NlaW1ZRmE2ejVmMHUwcHB2ZFYyTFpQcGJBcC8rczUxK1NPa0NS?=
 =?utf-8?B?QkJTekdJSjhtR0VDNUNOSTlhK1lobXZxQm5UL1hmVXRPbmJvVUFzdlhkRThp?=
 =?utf-8?B?TXRYSW5jdkJKekdRSlplVDMwL2NYaVdGczh1QUZueHg5OXJXNTMvbElSNmts?=
 =?utf-8?B?eThsUnk1VVZ6ZUlUQ1VBMXVTMEVMaWoyOEcyVExPMUNFR2lveEJQMjJpVGJN?=
 =?utf-8?B?TFN2OUpEb3E1TVR3WGVHVmRmL2c5WkhpRk1OOTZDd21QemYwRXVTL1dzcWFU?=
 =?utf-8?B?aGtEM1YrR3FZOGNEL2xVSXhCUjNQanIxOGxZZ2VzN3FObmltQ3JWb2pwU2FC?=
 =?utf-8?B?UnFYWSs0RERtaTk3NDh4S3JQMzhEQitqbzBqeWtCeXJjczdOS2ZoOStRZnda?=
 =?utf-8?B?cEVlOWpGdmxYeUJvQmZNRUFYQytRUGh4V0w1NUhIU0t3eUtJRys4MzJPMmNR?=
 =?utf-8?B?eWZCQXZZNk5WZXVxL294TVFwTWhYdmZKeUpONHR4M1ZXakd3a1V0S3lsWktl?=
 =?utf-8?B?N0VBWnBKNm0vdStlL1dqR0c2Q1FVMjIvS1Nvb2MvTGxKb1U0R1ZNdVQyN1J0?=
 =?utf-8?B?L0FLbzBnQXZrWFhRSmowcmdmY3BYWlBZNUJRUzZQM29iRCtHQ1IzbkMzZWpt?=
 =?utf-8?B?NFBVaUlKanJGbHltYmw5RXRPL1IwaDM2RHR6STRpYTRST2NYaHBGQmgyRk1D?=
 =?utf-8?B?dTZvUHBTZWhPeDBuRk01ei9adE45eUZxRjl0Wnp0YkhEVVVGSUdiYTFHOU1p?=
 =?utf-8?B?UUY5Qkg5VjVNNDhESVMxbkQ2cnNxbnZhdXVnM1lMWDM3QlVWNTJhcUduYWEw?=
 =?utf-8?B?RkRDNDJ3OEtqWWRLbUpETkNaVnlGUzlUc1oxRzhMNlA3dUVEYzBURHdDZ1p0?=
 =?utf-8?B?Zy8vbTBiQ21IZzUrNUNkNDBLOHFDMEd1WERCeHBXcXp0WkRBdEhVM2dJazUz?=
 =?utf-8?B?S3NBQWl2NHhsWVg4eFQ3ZzlNanlFQ3FXaTVjelBhaldOb04xTmFuSWdiRENz?=
 =?utf-8?B?YjBzUGpaajltYWxnblF0ODFHWnlIL0x1MDV2N1BoT3FDQUVtTitmWGZSenNx?=
 =?utf-8?B?YXpDbVAwYXNtRVV0aHFsZWdlQXl5QmxoWFc5am9HZjRqZVBnSmZod3F3S2hT?=
 =?utf-8?B?Y0lwOWNWcjcyNVNOOXpDQXo4Sk0rSS95c2dZaVFUeHRKTDZtRnZjZnFnZzV6?=
 =?utf-8?B?V3FRTzB1RG1FM1QzNmI0ZU5XK1Q3SlpEYUJPNUpoZjBSY25INk5vV0FJUU9j?=
 =?utf-8?B?Z1k0K0tQSmFUUnJNVHVSMXV2YzJ0WUVYUGhobElHWTFyeHNLV3dvZS96WWho?=
 =?utf-8?B?Z0huSU1wUC9wZDU4OUdKYWNUY1YzR21TcWU5dGVYVVBFQjJ6MmtEK25zZXVl?=
 =?utf-8?B?eFdXb1h4N1RUY09zSjdPT0RaNmN3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	axsf1th8tOGqnseo7LBYpo4s/hb07/Wq0Fyca18hsesEdUR7vGAvWX8HqvMTlhfnkO6Dx/jd7g2bE1dikKRM0juM2h+lAYROL/R8EYaXpoAHkmMoiGoeW4vRUwCrjeeMEyTTCOGFtDVjBEJJPGmH6Lgq0DZQYXUBYL4PfZQsgjaayfLXxv8FITMsobWZtbHZiTO38MhdVeHLT6EPZjcXqD2NXEBAk3XICp2xxlEHkZEP4jkQWGGa2PKZGaRh+TTPiGl69bG9sFEg9ELmUUjHP1niwgnvHBgMtlGfKTG8AxLcUxPyp8jNZaHKTM1l2hdWOfrx+m2sc1IO9IsveILH0zw/mpZD5NpA+Kcts2Vff0+NKVbaQjaZk2mby8Eg6DxDJCrcphPCLjMFP4+FxI1eZSH8fc53dRB/475DxKAsfWQQ02Y1aK27WT/d2k3WPGxE0FMHAqLwqy8SYSZMkGsnp4nKOPArXAq4vhgBTclD528Xhb4AS762s4Jq8etTMRlxaq4CVaex1MlELzfVI6tQ309sEinXMImAvshcXggz6Mt0wA7g7HrUiN3sVkXQnvl2hbKNsC1KAQAteWiF51E12nYMrIZOwTFMDBaqZTt1AYA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aca2bb-feea-448e-a756-08dd4fb2e0a2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 00:26:25.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bE+KJIensIOb+c67iLGTLYn5tumaXxIrFbd0CFk8pIMW3RXck4DHmJhJHPct/XyViXnz8qgmj1AtHkmD9gd4uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180001
X-Proofpoint-GUID: ytJYg47oG1FP0So9996i0TUVa_YUYE0Z
X-Proofpoint-ORIG-GUID: ytJYg47oG1FP0So9996i0TUVa_YUYE0Z


Zorro,

I wonder if you've already pulled this?

The branches in the PR below also include nitpick suggestions
and fixes that didn’t go through the reroll.

For example, commit ("fstests: btrfs/226: use nodatasum mount
option to prevent false alerts") updates a comment that’s missing
from your for-next branch.

--------------
diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 359813c4f394..ce53b7d48c49 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -22,10 +22,8 @@ _require_xfs_io_command fpunch

  _scratch_mkfs >>$seqres.full 2>&1

-# This test involves RWF_NOWAIT direct IOs, but for inodes with data 
checksum,
-# btrfs will fall back to buffered IO unconditionally to prevent data 
checksum
-# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
-# So here we have to go with nodatasum mount option.
+# RWF_NOWAIT works only with direct I/O and requires an inode with 
nodatasum
+# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
  _scratch_mount -o nodatasum

  # Test a write against COW file/extent - should fail with -EAGAIN. 
Disable the
--------------


Thanks, Anand


On 14/2/25 19:05, Anand Jain wrote:
> Zorro,
> 
> Please pull these branches with the Btrfs test case changes.
> 
> 
>   [1]  https://github.com/asj/fstests.git staged-20250214-master_or_for-next
> 
> The branch [1] is good to merge directly into master. It’s been tested,
> doesn’t affect other file systems, and has RB from key Btrfs contributors.
> But if you feel we need to discuss it more before doing it, no problem—
> kindly help merge it into for-next. (It is based on the master).
> 
> After that, could you pull this branch [2] into your for-next only? as it
> depends on the btrfs/333 test case, which is not yet in the master.
> 
>    [2] https://github.com/asj/fstests.git staged-20250214-for-next
> 
> Thank you.
> 
> PR 1:
> ====
> 
> The following changes since commit 8467552f09e1672a02712653b532a84bd46ea10e:
> 
>    btrfs/327: add a test case to verify inline extent data read (2024-11-29 11:20:18 +0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/asj/fstests.git staged-20250214-master_or_for-next
> 
> for you to fetch changes up to 429ed656f99c06f8036eff1088d93059d782add4:
> 
>    btrfs: skip tests that exercise compression property when using nodatasum (2025-02-14 18:35:16 +0800)
> 
> ----------------------------------------------------------------
> Filipe Manana (7):
>        btrfs: skip tests incompatible with compression when compression is enabled
>        btrfs/290: skip test if we are running with nodatacow mount option
>        common/btrfs: add a _require_btrfs_no_nodatasum helper
>        btrfs/205: skip test when running with nodatasum mount option
>        btrfs: skip tests exercising data corruption and repair when using nodatasum
>        btrfs/281: skip test when running with nodatasum mount option
>        btrfs: skip tests that exercise compression property when using nodatasum
> 
> Qu Wenruo (1):
>        fstests: btrfs/226: use nodatasum mount option to prevent false alerts
> 
>   common/btrfs    |  7 +++++++
>   tests/btrfs/048 |  3 +++
>   tests/btrfs/059 |  3 +++
>   tests/btrfs/140 |  4 +++-
>   tests/btrfs/141 |  4 +++-
>   tests/btrfs/157 |  4 +++-
>   tests/btrfs/158 |  4 +++-
>   tests/btrfs/205 |  5 +++++
>   tests/btrfs/215 |  8 +++++++-
>   tests/btrfs/226 |  5 ++++-
>   tests/btrfs/265 |  7 ++++++-
>   tests/btrfs/266 |  7 ++++++-
>   tests/btrfs/267 |  7 ++++++-
>   tests/btrfs/268 |  7 ++++++-
>   tests/btrfs/269 |  7 ++++++-
>   tests/btrfs/281 |  2 ++
>   tests/btrfs/289 |  8 ++++++--
>   tests/btrfs/290 | 12 ++++++++++++
>   tests/btrfs/297 |  4 ++++
>   19 files changed, 95 insertions(+), 13 deletions(-)
> 
> PR 2:
> =====
> 
> The following changes since commit d1adf462e4b291547014212f0d602e3d2a7c7cef:
> 
>    check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE (2025-02-02 21:28:37 +0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/asj/fstests.git staged-20250214-for-next
> 
> for you to fetch changes up to dd2c1d2fa744aa305c88bd5910cce0e19dfb6f41:
> 
>    btrfs/333: skip the test when running with nodatacow or nodatasum (2025-02-14 18:37:09 +0800)
> 
> ----------------------------------------------------------------
> Filipe Manana (1):
>        btrfs/333: skip the test when running with nodatacow or nodatasum
> 
>   tests/btrfs/333 | 5 +++++
>   1 file changed, 5 insertions(+)


