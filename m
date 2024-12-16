Return-Path: <linux-btrfs+bounces-10405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103AD9F2D1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896A5188332A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CC201269;
	Mon, 16 Dec 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mr+Fbw6g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ouax9EQe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD32200BB8
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341938; cv=fail; b=qQbAASHg3xNKpVGJmI/buFGEwEtxJnSdwT9V9JV1jyVrQ3h/dSXTsF9IF8uc5NmbIaFXJqHf5d9yRW0RVeOk9iYt0w4vOhQG4gLdT6kFxsKrJ2YM7LkE94SHS/cHXbYfFHa8FQa4O0gLZrlFn0b5W6dTquiWDSkknPBbwrBEZVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341938; c=relaxed/simple;
	bh=dQ2B5o1xEwBo8VvOYuCv/9qMFISQwPESbF9y0mzQZSg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RrzpSGNqYIjguYvMLnU56mWcRcicciQshEzAh7HcNm9UiwskjIg1O5dV5WE++NBHck69LYAU9fAGHLODebimcpF5Q/2VN0gPtR0jNM7lsBpsCGOFiBJo4wrcAVkeNk4WS+GTxFG6DtZsSLO8BTtGjJDHUB0voRyPW5RA8ZHcVdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mr+Fbw6g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ouax9EQe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MvJx020351;
	Mon, 16 Dec 2024 09:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zdE0YUviJVPL7twt/kQRxQ6jFEbGuxiu7NK1e89qjZo=; b=
	Mr+Fbw6gLv9geVY4rPFROqhQSRLa5DFtoD6IrBlbfPHI9QVLekulGUfMcCpwOKe4
	F6lheGCFWYy7FvDZLLO9MACFSenhXF7NAqpUnwduScAc91EprsHUfTn2WXjS3Jx8
	eZaPOm6cNxTKy2wBUjGQdlYHgelShEfGV7DxycUJYdR3PZUpF6XxZsM/wnroMcWO
	sGdx66yMhQbPRNd6cUqW57wXyofWjF5gWrEwEwYPjNIFsHSknqg5OwTqpQiHqS6v
	hRYXIKuR5ohkqIRjGqh4Rr1FNu2hjBDalcQENUb7Jgz5pVUp6/DWnwtaBhMirGSG
	j0evX+wjLFl4NmrBJK+KQA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9arhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:38:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG88gVt000562;
	Mon, 16 Dec 2024 09:38:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f724gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isOCFKFKegrpm7AaIM7YSSW0/RbEBKtzfjrz6S3v6PUh/JMw0Y7UD7Z63fqPhr0GujLtFMAINxDEVFpAKDtnA9iA9e3FdtO8GWEsmKOCrlhv5XQNi4PemR5y0TTM50JOU/zeFBIodGG6CsK0uojzYnNhdWBCkdhJQfOfE7BzGzE2XcJo93GSQHh+tXhI+DHKbzu9hcITSIQlmaWlegiilioifN3mJ35eOtBfKBMUXLTDZlvK4m4jOP9uo2bivnlSwlU02PBtdTSekmdLY25DaAJXysUXWIIqXSwmMa0VYyXqCOVDUA8vSHMNGMYGkjNg/N1cyCu2rYzw0fnZ4Ix00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdE0YUviJVPL7twt/kQRxQ6jFEbGuxiu7NK1e89qjZo=;
 b=oKSaab6+TERoeiwuZ968w5YNy3S2/vshPcdbYUeYxmiOivezUWZbpvYyvfLsGdUI8TVZmFxWH2Tr3NEqqAXkIbxyt0UrhQAKSnYsmbH3vsOJx2S0UbP9zB7gkLlwP81p5skSNawG1LW1lmmqI7azMv7p10B3W+qK3nBq7ZZiMFQm+krAcx6uIEh/JbM516PTDnbRI2lYI8rkBmL+drun1bxAh7+0pi385+Wo47s1mTfCwhcIL8ug++erRMdfR1oHxfynUvQZ+/6iPKELG6xQNiXsw6LjAfChs2Env63Jpy5+/k46bDoghX6u0RSXn60No5CfESlfrGXpmIqiwMYP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdE0YUviJVPL7twt/kQRxQ6jFEbGuxiu7NK1e89qjZo=;
 b=ouax9EQeFY1HpPWfsl68Fb9OenvyeDwfF2FlGjro1QcEypprRMddstMqqjs/1BYLHERpBYsMq6i/q7BPwvbrNKBsrl72WHWa6akZYcPlgh9PXiGlwvm98wS7wXmL9z/t2Y6YkMoXfKpKFS6uNBdWKfagR1SLk1gji7cnBWltxGw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4678.namprd10.prod.outlook.com (2603:10b6:510:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:38:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:38:41 +0000
Message-ID: <357c97cc-9492-44e9-b442-a8f8a3960178@oracle.com>
Date: Mon, 16 Dec 2024 15:08:36 +0530
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 04/10] btrfs: handle value associated with raid1
 balancing parameter
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
References: <cover.1731076425.git.anand.jain@oracle.com>
 <aab2735202ac9624d32d637f097df874fa217ebc.1731076425.git.anand.jain@oracle.com>
 <20241206165341.GG31418@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20241206165341.GG31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5011c9-010b-4515-f7b7-08dd1db56d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1dtRUo3MGRpOXp0SjQzWmJ2MUtxdWVDUkJUTWcxR2lkTDM3cXRmME8yM1lL?=
 =?utf-8?B?VWtOYWdtTjd1bERRTWJjVk1ZMFJ4ajZ5ZllsQ25XVmJDQWN3ZGVyWXhnNWpy?=
 =?utf-8?B?U1RGY3VWK1VVTDI4djRIT1VkMG16cEcxRlI3Vk1hY1NTMFNXekZFblZiWGd3?=
 =?utf-8?B?b0ZnVjB4ZnFVZ2dHQmkzOHhocHY2SHRKK0Q5b01DdVhLTEtQUExxc0pUNFkw?=
 =?utf-8?B?czdNM0pzTUlSOU5vY3dTMTBGQzIrbkxBR2ZXNVNWcDM3K0JHa25kRjBadCsz?=
 =?utf-8?B?eDhpQ1JVQmE1Si9jcFB2d0g4YmtKMkl4bGp4TEFxZExsYStEMEpVWVdjOTVY?=
 =?utf-8?B?Um5tSitWRHFRV2R5ejE2NC9QNEhOOGI2aTBIVWhUd2gwZ24rd0lrRG5HU1F3?=
 =?utf-8?B?ekJtOWxtY2xQL2ZHMHR1ZnFmVlZLRG9IczZ1Q0hjSUhsRmFBMHRPeC91czR0?=
 =?utf-8?B?eWRZeVc5UFQ3enkxWTBFVjgvZ1FWTGYrUDFIR0JtVDZCUllJaVhLSDlVSGlr?=
 =?utf-8?B?YzZ4M25ULzBzQWswU2JUUERDeFlEOUFnSDhzUGdjSHNRaWVreUxic3FTOVQr?=
 =?utf-8?B?STdqczdrVU1XVnRPeVA4ZUF0ekkrV1NsM3VZNDhmVEdqVDVVcWdndTZwUklG?=
 =?utf-8?B?U0RJcjdTWXV1ZU5jRVJqdVpXY3RmMDI3dFFFZHAwK09QdGIwRkdyQTYyU1hK?=
 =?utf-8?B?anB2cUt4S3BLRG55SFBRWitORG91MmMrU0p6MThOVW9tRytzM1kvZS9OY3ZM?=
 =?utf-8?B?ek5WbjRpQ2lMMFJGSWhaM1hnM0pTYlg3SEVrbm9JTU9VWXg3NlQ3RklIUFlM?=
 =?utf-8?B?aU5CWFBsQjZUN00vWDB0UFVzOFpqclNkNWVDZWlRK2JVdk93RVpUbFh4QkZZ?=
 =?utf-8?B?V3greDkwWXFkL3U5ek9uOGlZbXBZVzZJSlZ3Rzl2NU90VGp1VnNONEIxSTZS?=
 =?utf-8?B?MENjUUN6eU9VQ0wvejdESkgyVjNGTjVsUE1EWVVtdkFJSGJ0VWJodGFTYUpN?=
 =?utf-8?B?emNVR2JJZ1dhL0lwMnhaV2tXYU9KOHh3TXNnY1VNczVwR05rWGFzOWpNanpX?=
 =?utf-8?B?QlFRZmR2ZWtDZzhsbkJIcVhibW9iSm10MjA2eCthZ21CSEt4Y2ZrNjBWaDIv?=
 =?utf-8?B?d1ZpUVZZaVNBSzRNejJTQkZjd1Yvb1k4c0x5WUVVN0RNVmZyTm9DWFB3S0Rw?=
 =?utf-8?B?QWdWQ2JQQTE2cGRId1E5T0VJSU83alAxWG9nSWV2QzdaVWd1UGx2dlBIaU5p?=
 =?utf-8?B?RHo1T0lyL0NFTThXYXhNVmo0UitSTERPSnBtd3N3N2RnejlRczE5ZnozUWFC?=
 =?utf-8?B?TzZQaVRkZjVZcnNRZnJYaE1aa1BuUkNjSXdhTDJEQ0RHd0xqSElJcVVhcXZG?=
 =?utf-8?B?aUNCbEhkNWE5OGhvczBXM1V1SmdKOWQyUUsySDJPaVk2ZVhXZlJzMnJBdUEw?=
 =?utf-8?B?YkJXVUdxdGhPemtiUm11dkI2VXR4Z0JhaEt4blppWDFiZGYzRmNZWWRnSkNO?=
 =?utf-8?B?MFVkMFpUeGxjMGpLSVIwcUZuUTJrVUZOUlVKRkk1REVwVFBBNUJHOEw5LzlJ?=
 =?utf-8?B?NjRhMnptMHFFNjUvcnY1ODI5Q1lLRndRbm84ZEhpUnBydTM0K1pCcWxNODM0?=
 =?utf-8?B?TGNPOVpHRzh5dzN1RlFBMTJlYmJzWTFKNmdhK0Joa0RybHM3OFhPZDJLU1ZZ?=
 =?utf-8?B?N0drMzFQVXl5M25kVVhoRUFDTXVVUTZmeWRWOHMvL1A5Zi8vVjZtbCtrRzVp?=
 =?utf-8?B?K3VENURNbU04TnBsMlVYUzh4cTVGTVFtYmdBKzNIWlZrZ1hMM1k0YVlCUk4x?=
 =?utf-8?B?TmNOZkJyMTI5UGZPa2daS1ErdkFTcmVKVnY1N0puaDIrN0dwTlQreGRHMnlz?=
 =?utf-8?Q?AxZMjL7pQOMmI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1DWHU0YUdjR1RIelB2ZnIyR1V1TDRTWE9HWWxEdklicmx4UzJPZ1N5Qlcy?=
 =?utf-8?B?ZDRrNnRtM0Z0Sy9DVUI5aS9VVWtUdmNzbnY1YjluVjBZQUNZdjRwWmpMeGFF?=
 =?utf-8?B?SUM0QVRhb1JPaVR4T0N1clZxVUlHYnFmc1psaWFqaEcyS21Vdy83clJtSzdB?=
 =?utf-8?B?a0t3T21Mc3pKazFFMGRaZ0d6dEs3eW1jaDRrSlppMzUyQkdGR1prNjMySndY?=
 =?utf-8?B?Tm9TNXZGcFBJVGgzYlcrUENKa0pzb2xvUWZiWVplQkxocmxvMWdOblBkVWN4?=
 =?utf-8?B?VWo1YmpkNmN2MmxoMk1nVGpmUFpjSGNsSGQ4Zy9QelZENGloQkh0R0FRUHYz?=
 =?utf-8?B?RVVPNmNndmRyUW5pWWNrTHI1WUlNSVE1aVRGUnBkNU5IN1RTWjRhZGFDUnFE?=
 =?utf-8?B?QlBuVE5CK2xUK3I1bmhMSnI0U1E4K1Y5ajAwUGFiL2dGTFdqcVMrNThPVmRB?=
 =?utf-8?B?RUdPUmdUL3p4eVFJK2NoV05WSXQ2UUNQRklqTGtvMG9KRi9hcDR3L2VTbTZx?=
 =?utf-8?B?bUU0ZTZWYnpSd05DOEQ1MDFIZk4xSGVPV2ZHYjFJbmNvY0p6UnFPSjlmMzgz?=
 =?utf-8?B?dytURGx6ZTNxdkFERVZIcGM0ZTA2Wm9jcWZjU0MrY0FmQUxVYzkySGN5dy96?=
 =?utf-8?B?eW9FRDVWcWU5cjNac0I5WGMvWjZoOC9YVnd6RDhnR0o3OWxvdDd6VlVTZWJG?=
 =?utf-8?B?Y3M3bzA0SVJra0NsZUp0NVJwMFdZWEI3RW9FRkxrUGpVdnQycG5MUWhaYTVx?=
 =?utf-8?B?L2xudGNSYUtVQUp6UTVxdXNYYWNMM0tmYjhqM1RpNTVTRjh6QTB1dmk4MU1F?=
 =?utf-8?B?dWVPd2Jqd0RxdlZUYXNDQk1PQ3ZNM0NUVk50K1NsbUY3TWVDMHkrd3dEa01F?=
 =?utf-8?B?bWw2QXFibXlyQ2RSTmNSejRxS2hxdk9PWk5iQkdVcHZPc2xMRk9vVkdrRFI3?=
 =?utf-8?B?V29KaEM4S0lXMjBabzRmSHlGT1hDSzVSYzNNYkVGMkFHMmZTYm02YU42dGR0?=
 =?utf-8?B?ZGtFdnNvb0lHTlJDT2NMcGd4eWdSdUxQMUd3RnNTTjZaNS9MMDBwaTVMd0Fa?=
 =?utf-8?B?UUFqVFFUSVdsN2tQSWxSNjliM1dJZVFlVVJkNWQ1ZHc4eldLUWMwbGdyT0lQ?=
 =?utf-8?B?VHR4NGhyeHJYV0l4ZklYbVBpU3ZJT2RQNGlFSGVGU01ldm1UaEtEZWJaQVRD?=
 =?utf-8?B?T21lcS9UY2U2ZWhEZ0xhdkF6Y093WUVQNUhWNGlmaWFaUzZHb1ZBYVVtUHhk?=
 =?utf-8?B?RU9GZG5mNnpZVjI3VjBMb0lFZ3l0aDdDTlp1NUtDN3RCaTA1TklyNXByRnJZ?=
 =?utf-8?B?enF2SlJMYWJPVEg4S1NISTU4QmRPaWxqajU2eUpha01OMW9QYXJGdGorb3Ri?=
 =?utf-8?B?OVhQVkk5endjbTlrbkg4YkpiaUFwakpwcmM5WHp1bnVMWWpYNzN4b2dTWFBl?=
 =?utf-8?B?VzgzQU4zNHduQXNvQmRwWG1RVTYxa2psVkJySVpKZXE4Ym1iTUJsaUppcHV0?=
 =?utf-8?B?WHU2VTlyT3RsdkYwMjE4d3B5TnJVb3BJNUI5RWpVNE9SR0srMmZWanE1S2Zq?=
 =?utf-8?B?VjVSRHNIZ25NLzk5SW5HRzI3Znd1QlozN2tnSisrY28zZmZOeCsrYkxGdTd0?=
 =?utf-8?B?Vm1waXNIQUNnVklJdnBObnJjUER0VVdDYTdSSEVyVmJNc2lOb25Xa0tlRVVR?=
 =?utf-8?B?YUwvbUdnN3FXeTh4bjNPZ2prNWtlWXRqTHBSQzRZdHJDUUlhNHZwODRuNk1z?=
 =?utf-8?B?Smdpb1RUeVdhb3o5S1EwaXQxRzIvdkZNNUdndE9Ba2lHbnowSEVsTm5WZmFY?=
 =?utf-8?B?TTAxOHVVaWw3MnNIZDF1NnFMUDdpaDVMRTNYSi9UU2JxTlJ1MW1LYjVHSkhs?=
 =?utf-8?B?YUEwOThpdXdYdGxkNEJSZW9RN3RpdkQ1S0I4dU5laEg1c0lXV3Y1ZFhRZ0U5?=
 =?utf-8?B?WmFpSmVpalZObVExS1dNdm1rbGlDRDFXZllBQUR1VGRsRXZsK3FpWm5xeHBj?=
 =?utf-8?B?VmFmRG1IcGxDZjhLRGNOYzJZWlJhSVhoOGVVWkZNRG05czdYa3crZkNYZFRH?=
 =?utf-8?B?U3NsbTVwclY2MWxCQ2Nwa29WY2xPbkpsdjB3K01CMUZFY0ZaMXl5c3g3Z0hQ?=
 =?utf-8?B?ZmNGalVnbjMyNTNXc0x4UXBpalMyaXgxK09DRHNValJmY3ozc1NGcUpzRWU4?=
 =?utf-8?Q?1knwUyEunJh2HX6sVEF1ILzaWj1dUApzCAxdKuFEmZBw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l3WzhWIULtJRhrT/nP4gYDYyKa7d4trB4wpdFy4ytNnO6HRxpXyym9SoqvGI+0K4UIXQ3plqKoZQ4mnkvY9waLsp0V7NgyE+NQYWHYZF3sTXsgV086sKBWAQTplK7R5ozHdRATiGlmngCFbRlYEXxG/hs7cep4zBE6+koC+Xyha8ducXYmDHgGUe46UuFB3NCanxDPWC3ofU3nJCjhMQuZDEtvd+9jCrsRmpyWpt+iCmFM3BYNc7U1JNpWya/vB2Au1PKm9w1FGf6i32imelXAc1Eiq2A6CR2PWjjLQc5RGxbklYAHpWtpMJ3xdHGCHWsgmCWD1oo/YvR/FFd3kZg9ebxvEFannuCD/kSBfAHFtNTb2RtCuHi3EREsU2scrAlMI3x15uofvp+t7zMW4AmD9r1qmh3qox6lCxYTSiXscDU/6xQfYXkEi9IjAL6pGEV+0YkkzxbSiAl9pEplj1Btdf0qRuJ3pZ/urOtvC5wIX89B8dvk79JVWFAIhpE4huo0ta2Vcxi1EONWTZWsNiZtcy8zV2VpUrFhrs50+g88rU+DjfFFaVhxrJWnQh4x8ESl9iTE8jgdV4uH+NKvhaqbEUMc6ucACqFyJR2N5oJVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5011c9-010b-4515-f7b7-08dd1db56d03
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:38:41.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8rjtMBrrEmVVpv+I5tUAC+HBqwwU/XzJsMhgsdJysBTNICbkYSo0kXMPTiTdu3S+vZvCo0sLXPOobFKr2jeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_03,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160080
X-Proofpoint-GUID: rDBXaqDvWE7HucojMon_bVi1g4n8R_2F
X-Proofpoint-ORIG-GUID: rDBXaqDvWE7HucojMon_bVi1g4n8R_2F

On 6/12/24 22:23, David Sterba wrote:
> On Fri, Nov 15, 2024 at 10:54:04PM +0800, Anand Jain wrote:
>> This change enables specifying additional configuration values alongside
>> the raid1 balancing / read policy in a single input string.
>>
>> Updated btrfs_read_policy_to_enum() to parse and handle a value associated
>> with the policy in the format `policy:value`, the value part if present is
>> converted 64-bit integer. Update btrfs_read_policy_store() to accommodate
>> the new parameter.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 7506818ec45f..7907507b8ced 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1307,8 +1307,11 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>>   
>>   static const char * const btrfs_read_policy_name[] = { "pid" };
>>   
>> -static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
>> +static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)
> 
> Why is value signed type?
> 

  The signed type is intended for future enhancements..
  For the "Device" raid1-balancing method, we need to specify either
  the actual device ID (as of now) or a negative number (in future)
  representing a device with lowest generation number. Perhaps -1?
  I'm ok to make it u64, if there is a better way.


>>   {
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	char *value_str;
>> +#endif
> 
> Please keep the inline #ifdefs to minimum, with __maybe_unused there
> won't be any warning if experimental build is disabled.
> 

  Oh, right. Will fix.

>>   	bool found = false;
>>   	enum btrfs_read_policy index;
>>   	char *param;
>> @@ -1320,6 +1323,18 @@ static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
>>   	if (!param)
>>   		return -ENOMEM;
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	/* Separate value from input in policy:value format. */
>> +	if ((value_str = strchr(param, ':'))) {
>> +		*value_str = '\0';
>> +		value_str++;
>> +		if (value && kstrtou64(value_str, 10, value) != 0) {
> 
> You can assume that the 'value' is always non zero and assert it at the
> beginning of the function.
> 

  In v3 I had to check because patch 8/10 sends out arg with NULL.
  In v4 I have revised with a common helper in which the assert
  will help.

>> +			kfree(param);
>> +			return -EINVAL;
> 
> A negative errno in a function returning enum looks quite strange,
> either add an enum type for invalid value or use 'int'.
> 

now declared it is int. It was simpler to implement.

Thanks.

>> +		}
>> +	}
>> +#endif
>> +
>>   	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
>>   		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
>>   			found = true;
>> @@ -1367,8 +1382,9 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>>   {
>>   	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>>   	enum btrfs_read_policy index;
>> +	s64 value = -1;
>>   
>> -	index = btrfs_read_policy_to_enum(buf);
>> +	index = btrfs_read_policy_to_enum(buf, &value);
>>   	if (index == -EINVAL)
>>   		return -EINVAL;
>>   
>> -- 
>> 2.46.1
>>


