Return-Path: <linux-btrfs+bounces-3711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48DB88FB52
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06261F2A17F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879F605A4;
	Thu, 28 Mar 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GnU8GJ4l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ztgadRxf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172E41C62;
	Thu, 28 Mar 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617912; cv=fail; b=riHm/fsZ/3w+Mjcg6t4/2LOfso+JoB984CKelCT3wDsTZwbqGNkxNmMl4KvGaWpe87LPwUNtUaQMlJ0fJbDLN/RxtLONboXd4ek4/5UJYBvl2hwYgFSuDLgY9c5UW0d9sg4UyUNGuk2B9fCUiv5/e7TtdjsHSKW9Byu0ktJDlU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617912; c=relaxed/simple;
	bh=QyGyU0kicMcvN+EApFnKWdGACJpoMkghTPZtGHadrxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTRKfGzYLTC1ZW9Tc8ee0ohH1d1Y/Ehk+65pyiIIi0aboGZXmK4MncEMhVt+Hy+y2CYoKLQEGwqOhe/k8mabeQBRfncMaYdP4zlIvQA1QxHRq62ceQ8Zy/IeQ3LWx1kW4EYidKf2bYx4tCslPUJAGsEEJluWxIrSkitJJk6fGGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GnU8GJ4l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ztgadRxf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8xAjj016426;
	Thu, 28 Mar 2024 09:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RA/+6laeuwIjd+ShhsQ+BnCtJJeN3/wUxUoBEWS5/d0=;
 b=GnU8GJ4lylLdR2R8qk3ADsWPgwwdi0FwYk+9NwYX1Dc+z9JRt/9gq4eo77yshPig5lb0
 VocvPf5ldl1ceOXtoVBYM90GHjFPHLgn+uMNJ1TDzg5JXMp/8ytV2dVvI3fuZn3UgDyg
 29MSkMyxNfnw1vM986bcfijU2kx81Vw34THhRjYXMO6SC6RqqU1t8baW1oknUv3LRAEn
 DQFYcKOJHw8HTOBWPlhBP7D5CNlmPuHA1v5JUHUXNbsNJ5pKNCkmksKNRygi5LhcjxTv
 PZDSd0Jbpm9UStWigMBMk+RKADsUAdFywrrqIHV46vAM7Ij5vWsE0Aen4irBbJ9M7R2Z Fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppus6cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:25:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S9LMtR013154;
	Thu, 28 Mar 2024 09:25:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9ppuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:25:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+cK0hvXGozUMn/sVMNCG6LVTmv0XWbEHf4uwf8jaZymarbQpUcAe8bHmQdS1Y6KwQHynXnYGDMuUuwWU3zW0pWPxGTyok+TEl406FLczgaIp7w/Fco/c7XHLpf9a18pEyb+5eDKAIW1kroqyTjxyT3ncJ0mY0DY9qxykLKYEgw44ExsMWNs4Dg9ZLozDXZjZdOQIyBy05q22dZh4cH6tbsl0YosJz37j/Rb26gOpKTvT2KntjO9/DAan3PSQMqqf1O30KElb7ULW+dHCLPgJhpY7gt4vXtlM6cAgaKGPAx1nlovyslzNUoDDmwB8sJbsFHqq7uRdk0Z7wInhNnklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA/+6laeuwIjd+ShhsQ+BnCtJJeN3/wUxUoBEWS5/d0=;
 b=AlQzh0acoNH670gs8Yt0klNnARN1Q3VgNmQS6aImahRdvcpyMmHGd1JOSKBLLYW7jmywRvo80lUxoRhMOwcCW0pssT5sjqltfn67yaW5n/YeV34obDirjmsG1uoOPd50JSS6o/Fkj6WlL8uKTGPXphdWUI13maWvy+EebrPBD8CIkTWIIQp9h2l35OVSXo8s60KaHTwctjtg9L8m62UiWHHxLf1zfCZyGo5M8Qoavzq9cllhNyWcjl8iQ4WsAcdMQ2CV8kR/TDHEAncFLdSB400aBMr7rsla3KC4bDJ5tfyO05fJPZVSzAg6PFo2K5r+jkyDC2keDG9/QxA0uvrFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA/+6laeuwIjd+ShhsQ+BnCtJJeN3/wUxUoBEWS5/d0=;
 b=ztgadRxfFI8ZfDikk/J/cGcdr+hxXdF9mmbLvUAr3Yr9/CR4/X08QBTOjk3SBKdzGrbiKIYj4RGXYPQwHjzqUJIEBKDtJ1ovvGrXhJIBn2FJGVGHb/GHASAM4bMM2Y+abrCTe64YpabYYxwAbTfycVJBtKIeAC+dAZfdRVtAC14=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7145.namprd10.prod.outlook.com (2603:10b6:930:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:25:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:25:01 +0000
Message-ID: <9383298f-a74b-4e2e-8f62-f1359ae68bc8@oracle.com>
Date: Thu, 28 Mar 2024 17:24:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] btrfs: add helper to kill background process
 running _btrfs_stress_remount_compress
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <0689a969e9834f4c2e694404f41f0bf8b7a34a2f.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0689a969e9834f4c2e694404f41f0bf8b7a34a2f.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbaa0d4-dd94-4d79-d586-08dc4f08f1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l6QWcP2f0QUBpC12tn1DSEegttl5amNHzqLjbZki6ECXrxs7MQJ8KNvdUrejMhHhEVWuoiAiJ0QrMdoKOVH/NSPQ+5fci4vTVDZY/aWpcG7rT9VtzCuoS5k1uij1ZWN0SDalUhHeLPJ7jcn3Wkz1PXRk5TmImsetXk/m+3zHtsvD2PmbjmNQROAdPVYHtSWXtQoVEnY3/g3Eh2sj0FgLxY2ZHngnnuiZ0Ldw1oWKz5b3hlXByiYcp7tuVIoiSZMUuV/ZmRc+c/2SOEZK3jKAxrUssM05SqM7SZNFikPYfeCUSV7Jvph37/WQmEHLusVIjMpQ7ej8hEK2BbFwfhHJ5Beg7KGNhp71Mq+0B5O6efyTsxXtL284XuN2uWJhBsYwgF3IHtfJt16tSX12UYl6yOJxFxqUKasp0S3H2BKfIBDLFqFhWJbTsRYIZn9UqUAfvwsYByy1V4I8JeOslDT8spdjhZ69F3sBaOafZio5fhWveuKkeEoSjAQ+zXLhd9SIfIngoZGGqVe1oBHlSV0UirhkrGKquEWlMAHrTNiPt6c+34/R4iKwBTo0I9m0rrPPT0KNYjj3xyC7/LzIf8c+N/yKphUthrS86MgrCmjpj7kdxzEMHTpnLmvpspo2fdwRiF31tM+eAD5/9gAN5m1w54AHqt98v69rPe0bwqVAsnI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0wyZ2ZMT2JNajB0dGV6d0I4akxXbEdlMVV3ZjRmTi9GSHZmOWx1VGp0NVNS?=
 =?utf-8?B?cUM1ZGRmU09lU3dEQkpscS9qVG16Z1M5b0hmR3llalBVY2RVcGRGeXAxclg3?=
 =?utf-8?B?Q2xlRDI2cnV3NmUvMUMwcWRmZEFVMXBObktFN3k5bjhiMDFSMFNKZ284dnFQ?=
 =?utf-8?B?R3dLLzRwVHpHUHhsbEVvTkYyWU10NE4rQzhPVy9UQ2JXNE9PTEtPZ2wxa1Bs?=
 =?utf-8?B?OHhGUDd2TjI2Z2VTVjJpWnFuS1gxVzJ4c3ZxYmtpenNQbnd6dWszNTFQQzBk?=
 =?utf-8?B?ZFlRampSZ3FWUVNxcmZzSTBXMER1WmcraXR5MmVrc0JlNzVpazdGTmlZeTNp?=
 =?utf-8?B?a2RVK3E3ZjN6MVZoeDJMSzBlTmdZM1hWR3BTcEhaVzFRRWlNUjZMOTAwQW81?=
 =?utf-8?B?Z0lnUjd1dHJEN0FyakFMOTdOOVB1R0dSYkRpMzkrQ29JTnE4MEVXZy9COTIr?=
 =?utf-8?B?eDBGbWF3Z25wbzNtNWVHaFBZaUZiZGQ0SnlQMnJQa2R2M3JvVGNpNXFGZDRY?=
 =?utf-8?B?WnJZamJ5YjFZa25TbklSdHBZS2grcUtlNVB4clQyay9SUjMvdkJBWi92aVNx?=
 =?utf-8?B?UERwTkRuUmJuWmZnTU55U1o1NEphM2tWbmtEdHp3c3k1YytCV0UzTml3V255?=
 =?utf-8?B?aTQ4YWE0QlZKZDJuMUJzbW4xMzhFNUlXWWJYbU9RM3gyQlQxUWVxSGdVZTRo?=
 =?utf-8?B?WjdxeWl4NHQ2MUF5ZGJSZzF0WUpPeXB1S3VLMzIyNm1yekFPbjVKT3hURWNF?=
 =?utf-8?B?WTNzOUEvWUltaGZJUFNOcWNyQ21GUmpmdTh3V0NGUDVHbUVZOVY3b21BY3A0?=
 =?utf-8?B?eWVKVUE1SG9Sd3BMZjVJTFpWY2tGeURtUldGVjFwRnluQk1FYmh1bEV4cmIy?=
 =?utf-8?B?OXVkQnc5bkwrcFQzVERwSGYrS3RzUkJ4YkFxanhCVC9iVTdDdElZQnVJNDdO?=
 =?utf-8?B?akppRVFsWXp1d1hPM1hTWHdNcTlzT1BVQXlRWFM1dEtSTW1ZNGp1eWJMdjlX?=
 =?utf-8?B?czY2WHBTaHdZb3liUTJkZnAvbHhIdWE0SDllbUsxdW8rSkVvNEkyNmJJT2xK?=
 =?utf-8?B?WkNOT3V6QnFmVm5lazNQeVRkdnkwdmVIYnRDL3J1MUQyUm5OeEV4SVgzeEJa?=
 =?utf-8?B?L0VjWFZNVmIvUTlnTUpYWHpKNHNvWlNpdk9MR1JZRURJYU16YzlPTlUwN1hQ?=
 =?utf-8?B?bjREVDdsVENOWFdZQlpnajl6NytxTVBZVVdOdDhpbUpIdjUwWlFrSlltZUM0?=
 =?utf-8?B?RGtzZ0pqNWJYdjNOd3FnUnVaaWtKRG5yczNIMkMxbWd4ak1CR3VzUTJXbjcy?=
 =?utf-8?B?WkxSV3dSZUlqVDgxTHkvRTZ5VjdqV0JZcHh3bmpKdjRsZWZxTXVNN241WTdT?=
 =?utf-8?B?Ujl2RDlNUGJtWmVyZm5FSHM0WitObi8xcitiTzVQZllJQ1d0K0xJVE1NeWJ2?=
 =?utf-8?B?aE5jTVl2K0h3WERQa1ZzL1ZwTFl2R1MvZkg4T0lQSXJXK2hxbXcrWjFXSXpW?=
 =?utf-8?B?RGFrNFFVOWJhRVZtb0JIRlJSMHluVkNrdGhYeWlQeDBBdmVGWlFyUlVCUk1B?=
 =?utf-8?B?ay9FRjFESkxwR1VWa1B4OFJPZVh2aWZpcnpjS0hOeFJsWW1Nekk2aUVNZ09B?=
 =?utf-8?B?eTVtb2dGbFRiRU5VcElha3F1a3dZVTI4RGZWRGJRL0ZrWWl4SXp6eTVNVHdo?=
 =?utf-8?B?OHNJUDFRN1RSTUM1M2FXd1QrQnVtN0h2clllUWdQT1A2UTJXS0dQQkVTd0R6?=
 =?utf-8?B?SDczRDU1VVdjU3hnRnBDaGR5UlJwWHhneW42S3NYS0pCSFlmNzg1SFlFTkRU?=
 =?utf-8?B?bWRpS1gwWmNnekNob1hlTHZOcG5pTW1Vckw4d1ptQXUrbnk5SjhuSEp5SWRL?=
 =?utf-8?B?cjQwRENVL1dYbUp1SnJIcGlMRE15NFFHajdmK051aC96cU1yZzNUSUFHS3Iy?=
 =?utf-8?B?SEFLWGRwdU1oWnZLaE40VHp1cVMrUGlvTUpnSEl2MWZxUExTVjZIbWl2SVBC?=
 =?utf-8?B?Uk90S3RNSUwxTzNUWHFVYlI3aXcyUnE3a05WOVUydFJKQ3Y0WkJGMWFaZ21m?=
 =?utf-8?B?eDN4bzkrRU5SaWgwTko0UFlUcUdRNnZpRDdyMXN1eGhTSFlqbUsramV0M0lC?=
 =?utf-8?B?eVM1UTRzS0FsZXphNlNNVW9HS0s3SEhmOTNjMW1YRFJ3TjBnT3VlNWlGaVhZ?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Uz2P+mjg9ngdInQW+Om/9dZi04qzlfMVsTMu/Y4kfNAZDAZNh0461dYhAAYZKDakvtBat9QGzo4PXryefGNsDhcDKk8CDcgECYOSF7IEWnw3Ul0si1Cht8j2CQZhjDG/bl2pMvQeEgpYXKf5K+bmjBsKfIhE80xQq0hE30oudmSKwofAM3027/sQObtxt/+LavzFDzB0jQtaL8skhPS+KA+St/6HN9p0uda79ccQfPQd2ccZUAmCaFPmYFKQ+L0JA3gocrM8rLts1d4oEbSgQe0TTzJoBhEXBOIjGORVLp9NelyrHtzyvFMK5QnxGtoXK0D+hz5hwCAHFp5Mcu6e/uhiufCqxxAauZ6clH2NbVQFkgYkNpau6EC96GTlWK6pd5RW8krVjFmCLQL4UcRU5xEWmmQqz5jT4nuLEwIZQ40oL4T1jwtgsovfI43lyLvBvdy1zR+HdI/TE+RWH7HMSbxHIwQi/5WBeZT35tq/iLkjvALO3MKGXuq+uJ3YMNcubcBQVgWntt6tzPjnCiz3j3FYRLKuzAN4qYcqbX/82m9au4IGfPSIX/JoE+lIXs4Lvu4JuX7sIdjK1Cp8vSKj8fr3qQYSUmeMdqM2r8EP6uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbaa0d4-dd94-4d79-d586-08dc4f08f1c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:25:01.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziYy9vPTYDf3BIS4jEAd6luEtqqOgHVMn9qZs7lBeBfzdAIe2CZMpNReuX4mpulBZdYqAgl7mDcx+eQi1KIuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280062
X-Proofpoint-ORIG-GUID: HcZr5MKpQEXsBUYFwOiC5U7agWykiqLv
X-Proofpoint-GUID: HcZr5MKpQEXsBUYFwOiC5U7agWykiqLv

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Killing a background process running _btrfs_stress_remount_compress() is
> not as simple as sending a signal to the process and waiting for it to
> die. Therefore we have the following logic to terminate such process:
> 
>      kill $pid
>      wait $pid
>      while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
>          sleep 1
>      done
> 
> Since this is repeated in several test cases, move this logic to a common
> helper and use it in all affected test cases. This will help to avoid
> repeating the same code again several times in upcoming changes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks, Anand

> ---
>   common/btrfs    | 15 +++++++++++++++
>   tests/btrfs/063 |  7 +------
>   tests/btrfs/068 |  8 ++------
>   tests/btrfs/071 | 12 +++++-------
>   tests/btrfs/073 |  8 +-------
>   tests/btrfs/074 |  8 +-------
>   6 files changed, 25 insertions(+), 33 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 46056d4a..66a3a347 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -411,6 +411,21 @@ _btrfs_stress_remount_compress()
>   	done
>   }
>   
> +# Kill a background process running _btrfs_stress_remount_compress()
> +_btrfs_kill_stress_remount_compress_pid()
> +{
> +	local remount_pid=$1
> +	local btrfs_mnt=$2
> +
> +	# Ignore if process already died.
> +	kill $remount_pid &> /dev/null
> +	wait $remount_pid &> /dev/null
> +	# Wait for the remount loop to finish.
> +	while ps aux | grep "mount.*${btrfs_mnt}" | grep -qv grep; do
> +		sleep 1
> +	done
> +}
> +
>   # stress btrfs by replacing devices in a loop
>   # Note that at least 3 devices are needed in SCRATCH_DEV_POOL and the last
>   # device should be free(not used by btrfs)
> diff --git a/tests/btrfs/063 b/tests/btrfs/063
> index baf0c356..5ee2837f 100755
> --- a/tests/btrfs/063
> +++ b/tests/btrfs/063
> @@ -52,12 +52,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> -	kill $remount_pid
> -	wait $remount_pid
> -	# wait for the remount loop to finish
> -	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/068 b/tests/btrfs/068
> index 15fd41db..db53254a 100755
> --- a/tests/btrfs/068
> +++ b/tests/btrfs/068
> @@ -58,12 +58,8 @@ run_test()
>   	wait $fsstress_pid
>   
>   	touch $stop_file
> -	kill $remount_pid
> -	wait
> -	# wait for the remount loop process to finish
> -	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> -		sleep 1
> -	done
> +	wait $subvol_pid
> +	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/071 b/tests/btrfs/071
> index 6ebbd8cc..7ba15390 100755
> --- a/tests/btrfs/071
> +++ b/tests/btrfs/071
> @@ -58,17 +58,15 @@ run_test()
>   	echo "$remount_pid" >>$seqres.full
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	wait $fsstress_pid
> -	kill $replace_pid $remount_pid
> -	wait
> +	kill $replace_pid
> +	wait $fsstress_pid $replace_pid
>   
> -	# wait for the remount and replace operations to finish
> +	# wait for the replace operationss to finish
>   	while ps aux | grep "replace start" | grep -qv grep; do
>   		sleep 1
>   	done
> -	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> -		sleep 1
> -	done
> +
> +	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/073 b/tests/btrfs/073
> index 49a4abd1..50358286 100755
> --- a/tests/btrfs/073
> +++ b/tests/btrfs/073
> @@ -51,13 +51,7 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $remount_pid
> -	wait $remount_pid
> -	# wait for the remount operation to finish
> -	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> -		sleep 1
> -	done
> -
> +	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
> diff --git a/tests/btrfs/074 b/tests/btrfs/074
> index d51922d0..6e93b36a 100755
> --- a/tests/btrfs/074
> +++ b/tests/btrfs/074
> @@ -52,13 +52,7 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $remount_pid
> -	wait $remount_pid
> -	# wait for the remount operation to finish
> -	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> -		sleep 1
> -	done
> -
> +	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full


