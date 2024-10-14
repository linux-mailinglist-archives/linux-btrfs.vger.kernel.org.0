Return-Path: <linux-btrfs+bounces-8893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80899C8A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283BB1F23506
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683691A0726;
	Mon, 14 Oct 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c3VgtsRZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SPidrobZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935631A01C5
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904803; cv=fail; b=Ze3h8GonoArqCGtEqHEe3pdRucJ0EpUYGdDTpF9z7faBRMpAwIj1EQ4kjyFT++xvedcbL5WcUTtjaCRtZ4VmV0jmw41YH5k+ix+fYkCfMulKkqDLC6Dn9ht/A3n82+w11PB1e1WccxV5JCJVHIeBkiw0q6MgUXPX7ISgdBFQjW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904803; c=relaxed/simple;
	bh=5wd5OhjuimS2lqyTuvaCtEmbACiqAEwNxUGaH5m9mpI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+fmNBWoWCJ9OXHOJUwyI/W2CI76cnTHEPKOfZey5904DXW8Bu7HRIVJg+VnMqVIQGcW129IFt9ZKzG+WUyH8/YZn8km54hjJOvkSJUq2jXtFOO3aWylNKhNrXbb7L6EQdEEaR5njL4KxmvNpotZFIaIEq346iypv7L7UFSydIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c3VgtsRZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SPidrobZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9uFtT000803;
	Mon, 14 Oct 2024 11:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5wd5OhjuimS2lqyTuvaCtEmbACiqAEwNxUGaH5m9mpI=; b=
	c3VgtsRZ6fuGFTTxMPSwKX9BrOuiWcivWCDoP1vODy4Umi8rIwGvYCoPGMJXnn8N
	21thSf+M/Wf5HNs0BANDR59mN41szwUjarKLTnyMP8CJ6GLtvIntXzZJ8i0k8vhk
	bLcFMUdR8lxzmtC2npn2iWZ7btBncCG8gfe/8cPd7/TcWs3uIQffaXWhxYzLKDsC
	cm8wOwVWQPfqKbI3ojcLaT+dIQcr/fn591sfS/1AP0fbhwAa6AcWqk5DGYn8D4C+
	AjuD6+aFprR6UuXgbCkjKCPZVX2Tlar+9ki1o1zXFRakh6R6+OAmNNAI0MN/Ze5F
	6/qb/kV39eZMUBo2Gni67A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ae0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:19:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EA0O0b026193;
	Mon, 14 Oct 2024 11:19:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj5xy1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqGANB1UO+gKpDsViFdSWNxAPQ94NFHjvDwwOiJSO0SNVCy51VMTQ+s8QOmp2nLq4ialaEh9hCuL5a9eV2lPBIELKfOpHSG/MHTozdwrPmQGtmGIFVcX4t2SiOMknxtrLUOXXIUbNxNPxmtgK6y+EhCBj7A//BiiIS7vGDOI/msX341+aaktxnjfyvGSmZpU9llIntyfekM3PHq1ZW336indJXQ5Xad0DNTK8B3EPv2i5X86oRxH65Py3ADXmvNp9YhlIAl4w86F8kpkzThxRmTYjhdFqyZjq8R+rd3HoPLDnoVuPgyL2nPYjt59gg70xmrRhuyFB5dkXb5k4GutUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wd5OhjuimS2lqyTuvaCtEmbACiqAEwNxUGaH5m9mpI=;
 b=a8YipltasYFBbGJ7kjJF3qK4y5oMg6mtjEVWP3+LhRU7Y/ebn6x08VH4gsn2edsEcU/iy8I6uiQsHNNe5KizjdfxA2DlC4uSjMMj2MmggBE8xDGIc6xx8diBCXAT5VI9JfouREyVPmF38nQzAD7c9tNHqurOTVRIi3WFJCOduY8yDxhss1aLE0EbWR2rf6H7ROZ8kEHvjN5T6BcCQ0cSgCZStH2aX7sHh0zf/QDZ4XR3nX4vhDzUgA1LAOLDa7zfpaD7the1hVZ7fXbU/ITtGNQy9pD03m+qUxxUPieuU+Dq3rHGMKC2w5o36mpzr+XN78lmKO++nHzoWvO7gkas/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wd5OhjuimS2lqyTuvaCtEmbACiqAEwNxUGaH5m9mpI=;
 b=SPidrobZn5+QIJuVbp5s0u+6/oyapGvyDzuYehgVHGmKcCQq//J+MyUhNHZDxpUJcKn619dVMnRVBSlmGKLhSb09anLUZaTps4UsBTWCmV0bTLvCFpPE18/D8eF3cWImbl1/BLLwH43oIq0rDu2ktRezco5NckQbqJMkwcGL4/4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 11:19:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 11:19:42 +0000
Message-ID: <2f5bef6f-bfad-4df9-b431-b58d03bd8a5b@oracle.com>
Date: Mon, 14 Oct 2024 19:19:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: fb260fd5-304a-4af8-eb66-08dcec4219a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1psUEFsTWRNbXRHUjdONHI3blpqVm9HUWY4RjU0UWJ4aHBsK2t2NGxvU250?=
 =?utf-8?B?dHc4cFQyemM1dVd4aWJMYTNtUTFJNG02RXk5VEFPT1orK0ppTENjQ2dhcXZq?=
 =?utf-8?B?c1E5VThFa0RsUW5pUTlaOWthVUgzVVFkejVkSVd5SHdES1E3bjMzdHZDeXJp?=
 =?utf-8?B?U0o2NWdCTXFHdTFvM1FOcm5jMHRncmZuWHFSTzRHYit1d3J5a0p0d3dvdDZ6?=
 =?utf-8?B?REc4a3BId01PS0lYd2p6NVJ2aDErdkg0Vi9QeGNMd3JncjQreHZ2eXFqZFFV?=
 =?utf-8?B?NTBocU5weDZmTjhRZnhCdlNPZmpyRzJyRHRFcDg5ejVBWGxYUUJpQWNiN3hH?=
 =?utf-8?B?V1RWVnZYSFdVV3FZUzkrQTZLUkZoempodmtrNEVGYjA4eVlZSzBHczA4RGV1?=
 =?utf-8?B?ZTMxY1dldjBTYTd3ZmZDKzdtWHYxN1FKdkZvQlVyVFF5Mmg2ZGwvMGxJTXNq?=
 =?utf-8?B?UEd6TTR3ejFzaFkrQitQZHdEZW1taU5oQ1NiRzZiM0ZjUGpWS3BxZU1DRTlB?=
 =?utf-8?B?dkRzcDlkcXB3Tzdha0tsR1NPNGlXRkxydmV3bVYzTmx2VHFaaW5UTXhlTFNJ?=
 =?utf-8?B?STNGcUZjbDYxeWhWeFZBYUUrenNFZHFrUnV1NmJielpCRmFEaGRqRWliNzR3?=
 =?utf-8?B?cGdGYTdkZWE1L2twdWJ2QmdvN3NCSFNreDFkbG5xZDdMQ1pReUtXbzNWL3JJ?=
 =?utf-8?B?cjAxVnNLRkE3cTV4QlV6RS9pR3ZHVzE1T0h0a2w1cHg5ZG9SOGJTTTRZNzhi?=
 =?utf-8?B?RVlwakV3djU0NktLR3JsVUNXQUhCZWI4TWxxQlJycnpiemJ6NVJIZTkxVHBy?=
 =?utf-8?B?cEw3UUkrYWZsUGEvMWI1Wk1oNUYyNUVHTklBd1RCbDFFNzc2c3FCc0xNYkYv?=
 =?utf-8?B?Q2lBdjc4b3g3Z0dTV1NXMUtGQUg1bHdwVE4xTkRHKytOeERWMzVseVpnYUtO?=
 =?utf-8?B?RGF6RTZheXFBMWxmRkk0UVVjU0lJR3creVk5SmJ3cFlWc2U3eXBBQi9udEc5?=
 =?utf-8?B?d2doKytHNGcwY25rSFJheUMvZndvcUIzcGd4b3FrajMvdzQ1OW1NMHBYVjZE?=
 =?utf-8?B?N3kyQSs4TkdPUGttZmRuY0hIcEorTmJLc2V4a0FEaDdkZ0NIVzBjNHZMRUVi?=
 =?utf-8?B?MmFFUVVjM0VwSEVlNHVMVmJDZWt6OEJ1cnBvMXpSWndRQi9HdGZjNGl0MzMx?=
 =?utf-8?B?TC9ObDUrWGQ0Rk0valo0dFIzZ2w5OTNjRHY0Q1JYdnFleUQ1QkFoUU5reFpX?=
 =?utf-8?B?Z3oyeGluY1RQRVNGS2hBVTBrTDJPWHZNZzFyMS9NdWhucVhLNmRZMnpYY2g3?=
 =?utf-8?B?dHkwTkFQbVVQMVlNT1RXS1gzVk5GcGtVVENWQTllWnpTaDkyUVYyaWl6akxy?=
 =?utf-8?B?V2UxTUJBVXpjRlUrY0ttYTc5UjJwRjZlNkNxeWpQNG9QRXV5R1Y1T1ZiNElJ?=
 =?utf-8?B?OEwrRkNZZmV6WENWN1N5eTJoMjUwK3ZBS3JOUWlTUGFSR3RaOGptdit4aHNQ?=
 =?utf-8?B?WjBNa2JCVitHRkhQL2NKZ0R5ajI2QWV5V1NXTDFCbkI3V1A4MGR2bUp0UEJy?=
 =?utf-8?B?Mk9JVDVoU3BhVnZRdE9iMXVoK0RGMVVlc1dBMUFFL0l3K3FKUnBsZU5HY0dD?=
 =?utf-8?B?UFhXYjZlM3hxem1NaGdwNEkzb2FPRStDWjB4MS95SFI4Rk1PeXBOalRUZ0l0?=
 =?utf-8?B?eVBMUnBGb0trQmQ5dWMvSngxK2hqNFY2OHFSNzVHUjFuSVIwd3VuRkpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1kwTjlnQUJnT2k1em5aUXdqZXA3dDI1czh2QjJpQXpvb0ZBd1FSbE0vSmFL?=
 =?utf-8?B?SjN3ZVp5aHlhajZJTmw5eGxwRllWbTVBVFZXNXpEZmdUVWJUVzFpMVE2Q0NS?=
 =?utf-8?B?VmNmUnVmNUFiZHFnMWZpaURWU3VLbVRKbDJyc2VsbkJWb0V3LzJsNDNMQVpp?=
 =?utf-8?B?RlFkMWdQYTNCTHlRc0hURWFMcnNIUUpJVDdBMUNPQXRDVDU1blBEUVdVWVFV?=
 =?utf-8?B?NkE3ci9sdFZ3VmRheG5TVDRkd0diaWhTVGJuSWRIWTBjNWU3K0libnpBcHJL?=
 =?utf-8?B?cWNJZHJVbEpVTWxYQ3ZFTUFkNlA0SmI5KzAycmhST1duQVBLaTZ5djZNTmti?=
 =?utf-8?B?MTcwek5iWVZQYVBCMWtyd253dms3SkY3Z2hJNlZNN1J4T3hEM3NhL3F3Qnpq?=
 =?utf-8?B?N2M3SnRGZVlJemgwWlBMTXo1NERjRDlGYWI3YUxVeVRRSXJuVHhEamFuMTRi?=
 =?utf-8?B?N1F3b0RmdEExSUdKeXNNbmd5Nlk0RS9lMmFmMkpWRTIrK0lKQTRJQ25aQTRm?=
 =?utf-8?B?TDc1eXdwSUd5cG1MR05RYXl4aitnYUxrVWV5VmgzOTMzanlYTGFYTDE4Z1p0?=
 =?utf-8?B?WTRBQ0FqYng5TzRsZWxyM1dsZTk0enROd3lpVHFyZjR2bEpicUN2K1BnREtm?=
 =?utf-8?B?Sm5vV3dOVnVJbFJOVVJnYUtLb1A3NGsyanNRTEpCT0hNWkFKNmFBdmdUYmdR?=
 =?utf-8?B?ck9EQ1BuRzlpVUhZdUxPS0ZLd3h2TU5qL1VJRW16c083NkJaMUg5TnhtWWZi?=
 =?utf-8?B?RDNMb0RHWm5LdVY0c0xLUjViV0R3ZDhWNWExWHp5RU15ekVtSnNkRisrL2tO?=
 =?utf-8?B?czljb3NlOVFLN25Cd09QV3hFZTVKM2Vpbzkya1FRUTJwcFc3ZFppU1d3NTFF?=
 =?utf-8?B?Q0NrTDhzK09lL3V6aThqWEFqYmpoMkhCanZuYkhYZVJIZXF6dWpSWGY3L1FM?=
 =?utf-8?B?bmJuKzRSZzQ1M2tIM0NKazJyR0Z2V0hRaE5QK1IvakJOTDd2T09TRUw5cXdU?=
 =?utf-8?B?VkEyWEd5UjdKTjBtblpGY3VXcHJJRVE5MUYrZUlkam9qZmhkY3ZCOGwyVk9z?=
 =?utf-8?B?Z2RDYnZrb0p0Q3pZSmNXaFFBdHYvTkJsKytpeFlFS0lYRjNVVkxyR2xvcmdn?=
 =?utf-8?B?WTFyc0FocVFkZlVUMHZRT2h1ZUJ5dmhLTzVzSFBXK25ucW05ckFKV3FIbEJw?=
 =?utf-8?B?YzRmOXJpdHJXRDVxSTJLdm80U1JtNGV3d2xqYjNTWURFbzNaV1JmOWo2NGZ1?=
 =?utf-8?B?ajk2MVNuTE5va2FVTEp1YmovaktLL1NIajZKTE5Rb0YzRFE2ZG9paU04dE5o?=
 =?utf-8?B?YXNaUEY0cWlITXpQdVZJNjhxdWg2ako2UHdSODh2VmlPNnFSZkNjRTJaZ3VT?=
 =?utf-8?B?YUFXcXZXTWhCZVFKSm9zUEhnTFJvd1VGR1FHY3RNa3l5VHFwN0ExYTE0Z1pF?=
 =?utf-8?B?ZyswMTNPZ2FCRWdEYUxuTTRsTndkV2NqNTJsbDRTVUdaS0dyb2VzWUNLc1Ar?=
 =?utf-8?B?RjM2WjVsclgrOXEzRUFESHo0RXk0ek1HZ2lyTEM0M3hSQWxVT3JYOHpCY0RB?=
 =?utf-8?B?Vmk4a0V4bkdSbE9YRnMrNDhWSWFjSk5uaVlRdDhwOG9hNFlFSVA1UlJzZXZT?=
 =?utf-8?B?NHRqVGlHZ2lNbWgyN2pIdG9ZQ2hpeXRUcEpUTW5FSlZzZTlTUUhyc2ZIajk2?=
 =?utf-8?B?U25zV3p6L1R2eGhQa1BEN0t6SXUxMW5iaTBkN08vcVJTcmZIN3l0c3RrT2t5?=
 =?utf-8?B?MHIrejFXbmpKQ1BteldEOFJSbjJwTm52ek1NbFIxcTJobVFSdnBUUUg4YlhW?=
 =?utf-8?B?YkpyR0oxaU5hUTJxOEhhVmxVMlowdFdmWkVTWUZqUmtna1pOYlRDNzdhVWNH?=
 =?utf-8?B?cmdrT0VkdlA5cjB1bFliOVM0ckhTU2JZNGtFQ3hraldmaU5JaG8wR3ZWOWlI?=
 =?utf-8?B?VzNYUTd5ZVdGVXZYWldIN2E1cE45dENyR2RHVmhhSHZIMVAxYWpzQWZZNFBG?=
 =?utf-8?B?dW96NjR1dGtwcDVGRkZ1WFNyajViTUpDcVVTWGM2SXgyYlFTazdkNG1XbHUz?=
 =?utf-8?B?V3RNcGZDaHFGc0k0bFZhWlpvL3hHQWZUQTA2MVBlbFM0L3ZBOENsL0ZrY295?=
 =?utf-8?B?ZlJ3bHJLUzBpT3ArcTR1MGxIbWt0dS9hNkd0YVpSZXVNV09lSDhrS2Q1S3Nq?=
 =?utf-8?Q?M4VAgswvGMWTP1LPWo2CoOX1CZYvrO6Shcelp9XL54UV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+KMa35QqQN6uunpLMqKdJfhZhvUHe14wFJY1Lmx1lMk9Dj5clgso5903x2khje+dUiHj2nx0R9pQ3oPNHm7iuNnn2OrRlvc7WpYn9hPGA1oAvR3g82NPeWYTegEeLcPiusEIJs2kZFfDuR+W6wl6hZpDZ+BKT5Lsp3gVb31xRgx1P75saqxd/J+jMdBy6WZGiz9/CmB9r1rxtH/E+rPAiMC2mdosAqqjVSaIyOWoJkcDiaOwK8cH52NxLOgWOc9+/jOK9UymMiQi5nb03a6nbZI38mgGrDzdxR2vYMqOE3BuHJjH5asDXQD/SFjyzjn25858u2HLoT/UD82JzDx7rrcoJRjp1HHDyIoO4DtDGYVamJB0GjkwbHtW/BrnVz+uiHrbWhS21s/GlLad4QRwB/+desmNFAikb9tD26d3saNiFbBg7J7C6rtRbLCbEDOHf8p1NWYEvdqfVzuL2gHpbWEHkAzJJCqC2A160bg231ynenSsbm1LT680mrQDoCufGrZBsW7hUWoR8s7eVMBC7j5r4TQol4jD3PRsRRbB9XfmYPxtJBHju7yFT3A9q0PuRTmCa30eHxHhI4uwZP8sVyOEG/6R9hFjoNtlg1+CpQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb260fd5-304a-4af8-eb66-08dcec4219a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 11:19:42.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /U9vJcblUcsohk8B0f8IDCudde3letwM2BwJ956sBekV+IgN98eOxR995PqoBAFZ7XDwmeOkojc3QkMzN8FpIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140078
X-Proofpoint-GUID: A1V5FSBxPccdlXRRjmq6e2yV_htVH-od
X-Proofpoint-ORIG-GUID: A1V5FSBxPccdlXRRjmq6e2yV_htVH-od

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx


