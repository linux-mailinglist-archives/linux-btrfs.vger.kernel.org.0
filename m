Return-Path: <linux-btrfs+bounces-7153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C594FADD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 02:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4717B1C217D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 00:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8364C8C;
	Tue, 13 Aug 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GP5wdip1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EC4YIcoY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB117FF
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723510338; cv=fail; b=uOk2EZ4fftfSZDvFyH30wMkvj71y1c6YaZp2kCCEQvBwOJ2WHbzHYuu8oWRlLDArPVKhlEe7ke9OYZL61kQZWr7J3ZVHfqNOr8aNXmGgYutdyH7Uh3tpRzsUWQTN2QehVZ10BRSHKvvVYuGmFzSiI7x8JV/IbEk6jGM8LHFYZ0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723510338; c=relaxed/simple;
	bh=p5p/YAMFEhzvxqCiXP7zm8v1xkIyl7zkajbUG/woB4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzMA1w4+CTVYCczOSPEuilXHV1jdqionKiwppGO3yJoiljjznkK8W043a0Fu0vjnbMp3Obt2HL/oIe4nXwhgaBEyn3Zmqh6QcVlyXTTfTdE2GhJxPcxIW9GhEWmr25hcdovBAYnMxiJMbFCRHrU+V6h3yEVUskBHm3yI6tRiTyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GP5wdip1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EC4YIcoY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CL7HHm022039;
	Tue, 13 Aug 2024 00:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=X0VnuNWUGD4oGsmJoVugy+dBaQDpK56YacCKO704qJI=; b=
	GP5wdip1reJ/hVyAmafZ7VBK0h1RXzeRjcStvQPrIu3C9cYjJhJWgB7ugslV2vLS
	fpyz9eMRXbZcmGzKueMEvqg3v8+obgUzBL2UxgnX06z0/Wwra0vwjjHxChN1NIms
	U/EjHvy710kVZO4FvintccPwpiDFQe22fIhWlh8S1wzaDuBMThD4dMuPpikcYP+a
	4ZEsRcQLLGiQc602d02e7zaGUyHxOnNULQ4VTujn/qyHH/zGQom9+9x4zSizZXbc
	iAOtO6n5hmVaRMPxsAIs0ZeuEgPE8VYHzDTGuhYCQAGq/EOhxhKpywe9qvisf1u0
	2E6Yx3KytGf70VakcWDYZg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x08cmyw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 00:52:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CNM6HR000704;
	Tue, 13 Aug 2024 00:52:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn7umhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 00:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/WPI+NQ0kApyKdxGzAOAdnlTSeTPm47G6KzmEaqX0897NO9v94LXlcRpWsdPIyczkTzjLTQZKZ9swsh1ZQ0aVO6rl3dxInJg5e5BEOVFO5PwdIcnyhqG258cDXOLycWmSAgjmy9GAP1p1z2v/9NL1/LNikAUTQSs3MsxesduLRW0ULUTZMpJ8ryeEENp8x9yWduAEOEGOuFZRxU1M/6Fz9hqKce8254dDQyNB1ppa5HPBGb/+KV7KTOvYuI7gQ4D4TKmxbuXpp7D1fevSQjGF2bZK/sz6tILpzGoS/LsmPpqPkcMWK+Z8PPmA3jqvYmKcNDjQ+92j0IR+65m47gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0VnuNWUGD4oGsmJoVugy+dBaQDpK56YacCKO704qJI=;
 b=G+tCFv7Hlquc+ZrJkSxh993X5m/Sc/pnHz0kFR/A2a3pEczCjW8mtfe9T2bmQHYlrknWOHYy+B+2ddbXZJxBWrTlawZxBEW+mxqaAr9KyONtvubgN+94CKv6MZ7FusHyTqhjrX6lOXvo/NpPJir9LBfhX6J8/O+TUj0hqeW+xppZTT09YPPVLxbVZR8pIUkptI62Z6/2yZVhbV9cZeDFq1Ac7rbNeooiyQoYU23IF4VG7leYK7hS/acsBAmtdL52rX8KZMuDpPkf7KxsflUn33YXi5c7a1VbtgOs1mE2VFE6IgxaXj3BWUv0UfM9DQ0ixfaoSnYF6r7Cirik5a1xnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0VnuNWUGD4oGsmJoVugy+dBaQDpK56YacCKO704qJI=;
 b=EC4YIcoY7zUBoshil6DSqcH9sZTT91Qyp6OTGb1B0fvddBuz+qYkiHg3XnVLT8GbJaKyqSrN1RsJKRNxmsgpvufuFHXcuw7t1C/qHL1iHpDVETScwKjT7PAJWLlaxreVhttzzE6erhv9e881lX8bWXUqPmCHplR0uKO08pI5UiA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYXPR10MB7921.namprd10.prod.outlook.com (2603:10b6:930:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 00:52:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7875.012; Tue, 13 Aug 2024
 00:52:08 +0000
Message-ID: <83f9b6b1-9027-41e5-b0ee-c667dd181fa4@oracle.com>
Date: Tue, 13 Aug 2024 08:52:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
To: dsterba@suse.cz, Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240809193112.GD25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYXPR10MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fc923e-3b8b-41e9-7034-08dcbb322871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1h3M0dLZFBtd1IzaVpBNGFvaTdIcGg5ZzU1V1YvYVRYbExDamJqRGVHc3cz?=
 =?utf-8?B?ck9qQS9UdmFCN1VMeHl4NXlBTFEvci92NUFLQmJtdy9PaWx0eUV4aWcwUFVw?=
 =?utf-8?B?clVCUzFwMTRITGdCOUVaM0NsbkhXbWI4N3YwVm5VaXpIVzg3M1NqazJzcjNP?=
 =?utf-8?B?WWVGc0k2bldIUEc5cEtDTkN2dnZWSWxiTWhuUDZ6RnlDc2NOS0xqR202OHZR?=
 =?utf-8?B?RUM4SU83ekJwN1lNbTAwQXQyaUh2L25tUElzZklwL2p1dEpjajNUZ09qdmJC?=
 =?utf-8?B?TU9xQ2tRRWljYng1aHV4K2FoenZodGRXRjJ4bHl5UzVZZDdNVlI1TDRjSjU2?=
 =?utf-8?B?Yk95aXNCZDNqamlDQ2RmUHBuTFdFcm14ODNQcXhKUlpsVThWdzFyMk5oRWRY?=
 =?utf-8?B?R2pFai9kS1BsTkpDMXk1ak0xOUVSOEg0T2xZeEs0MTZEckIyam8rYS9YQTNp?=
 =?utf-8?B?NTQ1RFdMRjBRVFpwRkU0dXlBYW1XR1Q3TWdmTVcrbUdkYkx0TWU2QmZvNmxX?=
 =?utf-8?B?Z01LMnlhVUxPeVNMallUNzdDQll0VDZrb0ZtUlU2RVdKOE9QeGd2ZUZnK0Nz?=
 =?utf-8?B?WVprWE9RODZCaFhrY05hOFl5YXRyeEZIVnlLUlVEazU2aVl4Um12R1QxVVdt?=
 =?utf-8?B?eHg2Z2pUcTYramN3Wk5URjFsbENsUUNIWVlBeSt4L2F2RkJFK1dyaEhFOTFH?=
 =?utf-8?B?VzQrNXZUakFHNnR0Q0xmL0J2S0orc2VHMW1tNGFkc3BuZzdwdjh2MkNreHla?=
 =?utf-8?B?Wk5DUUZqemFvOU1OaU1sR1ltUHhSTmhPN2lrak15ZjQ5cGd6azZ4aTVvaGUr?=
 =?utf-8?B?L3pwMEFMSVJLMi9WWWl1WVRSMGQ3enB5a1VIbFZGRlBXTjdDRXdHUzVnV1Fi?=
 =?utf-8?B?aXlHMWQ1d1Mva1p3d3BEQVYyYzZsS3doZzR6R1NLUXExU3ViL09SWjRwNU0v?=
 =?utf-8?B?VGgzN3hBZ0ViMklOOTkvcjZBejBKUk9YSEx4eHN2RDZDTmtKM1lxZks3eE9h?=
 =?utf-8?B?djNXQ1FDZVlvRFJianZPbDlIMjFuaU9CSlp4NlhtYWhUaGI5NHd2VmJMdHE0?=
 =?utf-8?B?T2orWmFlb3RSaWo3cE9xRXlJZUtvWkNLcG1TZTBxWGlUeHNKVm5mZHh4Mmcr?=
 =?utf-8?B?U3U5MHJJWXU3NS90NlgzekdKN3VzQ0dNa2ZlbE4zZ2VRV0s0T1pkWXIwUGp1?=
 =?utf-8?B?aVh6aW12RXVIbjVkNlp3SitSSmwzWG9XWGhHV0hiNGowZkZWbXdYbFRXUmhX?=
 =?utf-8?B?WjBaT25BMGh3TnpZbkk4TFBQZGw2L1hMU0EwTzFjRUpWdEZQa1Ayd2ZsU2hB?=
 =?utf-8?B?cDEwWlcwd1d0YWdycUUweldIT1lhM3dFbVZlNlIvaGgzU1VTSFlpdHdDQzdX?=
 =?utf-8?B?L3V3aU5vbDFSMGg0ZytGdC9kTzQvZDZ3dHJ6L09SaHB4VnJlVDZ6aHhoUWp4?=
 =?utf-8?B?Yi9EQU54NjluTnNJWDJlTzZBZWhnLzdnKzdodGc1cjV0TnZSWlJnR0RwMEsy?=
 =?utf-8?B?WG9nWm9oUWxFS3UxaVhGN3JJZ2didDQ5UDRmdVhSL2t4L2lMOVRDMHBxeXR4?=
 =?utf-8?B?a2o5TFVwQWJSVHMwMW9ON1JmU3NNeEpnV09JNVgwVmlqUU9lQk1qWk5DU0Rk?=
 =?utf-8?B?STRpNGszY1RLMGtsQmE0eDFEU1liQllSMnNvYmdHUlRLZU1qanZnUVF5TkdB?=
 =?utf-8?B?RGZ5TGl4TUFvL3oralBSN2tIazVvYTBiTHRqUTJmNjV3NXdaeVB4UWh3NmpS?=
 =?utf-8?B?Z2pBYW5kMXkvYnFVL3RHZ2wvOXlBRGdjNlpIQUx1RW1hSnJNTURidm5kbk5W?=
 =?utf-8?B?ZFoxY3g4cHdEODQ2SGJOUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm5SZ2ljM21FZjBLMzV6dkpLM21RQ0JuVlRTUXhxT1c3NC9lWXc2N1NPejFp?=
 =?utf-8?B?ZndYYkhFTHRyUE9jVk84bmxIRk9aUTgyR0oraWUrWTYxUC9YK1lsUjFQNVcy?=
 =?utf-8?B?WUkyR0dLdDFKU3UxWFNlSWszUUJOTWVjZ3dRbFBPYkRPNDVtVE83aU1vWkQ1?=
 =?utf-8?B?UnlKVW1xNDNhYitpNGZxTFFKaGpURjZXa3haaEx6b3pPVGd5dnpETkYyS1pJ?=
 =?utf-8?B?NFlPb3VWOWNtYVJxb3c4ZnRBZnFJNkJuYXBJUU41Z3NVWGhPdnpnWjlXbEo3?=
 =?utf-8?B?YXpmMUdPTXdPRlVKNUFsd3FmM3pneUhzMVkwZDl0Q21ObFZhY0VCajdhQjVM?=
 =?utf-8?B?ZldROFdmWThTMmcwR20ySjFKR25SZGxFcm92aTNvUXgvNlBCTUg5WXZRSmFD?=
 =?utf-8?B?UXZVY3c5bnpkUmVucTA4NklRVkRsL3IzdzdwY3BTaGpDeXl0Wm9iSHRXcHVE?=
 =?utf-8?B?WkJZYUdSaEdScGYycW5VMGZjVW5nODJxMWI4TnJwM1ZrY1J0bVlvRXcwNUh1?=
 =?utf-8?B?MG8zY21yS1ljbEVzZmE4dWtVWkU1dFRGZ1Nnd2FzcFNhQlorY00xSHlhSExh?=
 =?utf-8?B?R0g5SnZIekFxc2liVGN0WTBOT0VWd3pwTjlEWi96OU1JVlg0dkEzUm9UL3gx?=
 =?utf-8?B?MityY0IxVlljckpwVmRGNTZNRnlsNGtOTkxOL1UzUXUraWttSUErL2VidEs5?=
 =?utf-8?B?QisyWWdTaHhBbldXaktVblNEcHdjNjdSRENiYk45cnBzRkF5bGFOVi91SGpQ?=
 =?utf-8?B?SWlpSW84S1dYdHRYZzQ0VTY4TThUS1NZcEpGemVuQjNSRDdEdkpCYnUvVnNj?=
 =?utf-8?B?VU82eHRUcnNjWVY3azk1NG1UUDlud0QwT0lOdmJCZEw3Wk93WkJVdWdVVUZi?=
 =?utf-8?B?L1kzTndZTnRHeVhCUzBNa0VzeXpYM2oyRERqMlZDY3N6NU9oeC84MVZFa3M1?=
 =?utf-8?B?MWtZSzdvTnJEL3IxUCtoMm1sa0ZWL0J6czhXQ2N5S0RBVXQ2b28rSjNDU0dZ?=
 =?utf-8?B?ajFEWlIwZjZ3eDZtcWM2TUlvQlZEVlNFVjI3eWFqdmV5dUVGT01EQ21JR3hD?=
 =?utf-8?B?cVJGbW8vemFyRjFMT3JaVjQ5RUQ0N2dsaGRDS2VreUFjaldhZ1kxQWNwUmVP?=
 =?utf-8?B?c0o3SkxMVnpHcGlqMnBsUnI5bFk3Znh6T0RhY2FzVkpleGx5bGNCSklkSnFM?=
 =?utf-8?B?cG5tUG4wOTBTQ0Y2akFsNVphQmlzblloWFJpYVlkL052bGtBZVZEWTZIRzZw?=
 =?utf-8?B?blpOZnArT09aMTljSnlZMlkvUFJEVkx3ZTBLZXdNN3hNTHJGZTBxbjN3QmZv?=
 =?utf-8?B?ZDBkZ3luZkFvYUhBRS9jY3d6cXhac3hFLytSaWdSb0o2RTFaeFNFdWg2aExi?=
 =?utf-8?B?MlhWdzdxa1BRaS9sVzNjL1RiTUo4SmNEQWxDYkFTVmFJeXFHd0hvUExvS2lR?=
 =?utf-8?B?bUNtSVNCRTB4YWljYTRiS0UzVlZYVzI4RVBXck1XSDV4TTNybm8rM2xBTGY5?=
 =?utf-8?B?VGhuNWtOVDk2Q3c1Vk4wZEV3TGVmZVYydjJEVk5sNThKYjU2REYrTFk2OVpj?=
 =?utf-8?B?dEVRdG05Z29mWkthS3JHcjBMbzgzUFVZQ2QzOENrcDJPbERmQzEwaGExMmw5?=
 =?utf-8?B?eUFoeWVaQzlVajc1OElYNkl3ZElVRGFsTEIrZGY2bm4wTHgrVFhWSFVkbytM?=
 =?utf-8?B?d29EQjVSa1F0QzFrclpvRjBMMVFKR3pGdEdpbXcyY2tyeGMxMHZzR3JIalBm?=
 =?utf-8?B?Mm83SlZjaVNSVm5DeGppckk4MnpNSWR6WmV1Q1F1WnVXd3kyMmw5NG5UMlpw?=
 =?utf-8?B?dFZrTnZqcjdMdW1TTmoyRnhKSWFRUUdwdmwwTWkyaTdDWnZ6aWJPeG43by9z?=
 =?utf-8?B?UW1rcUxxbFNrQ05sSjlrWlJrN1ViYWx6eHFwallCOXhCaGxURE5uaEdPbTAz?=
 =?utf-8?B?K0ZYYnp0NXpqZzE4dUtyaXRWQUpyU250bHVoR2pCOGtVOGlxbEJJdEpqZ2Rk?=
 =?utf-8?B?MXdqZVZBSG9qaTRBbWc5Q0ZjNGxZeTB0dHArYjhmN09uMGdncGlwWmJlYWZ1?=
 =?utf-8?B?REx5RU1GTlpCbEsrUUNGTzVwL3RneTZMYmxobVh3N0Z6SE84UUJDL0lpWVpp?=
 =?utf-8?Q?R9wofuH5j7X3aDJtqZscC80jT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qJwc3nYSYz8WazQWl3rAYF9nAa6HkiI2koPtRlG+ZWsgFezLiFsFJxojdUBoYpAr2S2j3hUyy05L+VHc350tkSVo2vZB3YtLgZTMU3yKv34u7WCXVAxV6Gz0TlC1Z/vfCGLRDqnVdzSCk762JmYnTq7qR4CREVYUn1QZtzrcYYU8KuPn3Mpf8pySDEi5w75Mz5FiPKuFRlLH7ikXFaXKjOCGoRF8g5MqmJFs/ExRf0uLUKC9N/FtQgyGWmktdOM3uaUwdw6QukQuNPu5usV1+vsW/UWXXt9DQgnAFYwEv8NLsJGr5IYaxQ2EmYGOMx5ziZg3Dy5hWZIiLL98AJTZRHpu8yDfAgAE+FwKAdKJ0FDDU3KlFlqHgiQMcFhTZMNRZaBlmLo2aXMDhMSGWpoEtvEsYY8I9dfluE2zBD8DFOmUBoLj/swCs40kXai6NvADllolbIGuXG6h9TBDhZrshCo0qWLy2O+2a8CvwIGImX6f5kQ4JavwH1G0MvVLRlMiygQGdNGZoHUv4t8r8QqT/S68bmtzGKDzdZaTjqummNl59+0TB4gn2OdzvHff5BkQ+oDf9yBNTjm/Lz8jUyd+ghDP5Q5MsUjW1Esuowi82pk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fc923e-3b8b-41e9-7034-08dcbb322871
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 00:52:08.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdEnnYy0GZjDi7Mex9yVpAVapSiVKFYpX8UQSZdXIEXJC7JDu7npJ1qWcI8qH0Oupu/cL9sGagvhYZnN4ZFH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=927 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130003
X-Proofpoint-ORIG-GUID: lO8A1Og-EppW9OG9F_CxSRcOUud2Lr5A
X-Proofpoint-GUID: lO8A1Og-EppW9OG9F_CxSRcOUud2Lr5A


Nice feature.

>> +	OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as subvolume rather than normal directory"),
> 
> Please mention that it can be specified multiple times.

Nitpick..

Should '--subvol' be '--subvolume' for consistency? use the full names.

Thx.

