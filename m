Return-Path: <linux-btrfs+bounces-7789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2198969DFD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90802858DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2201D0958;
	Tue,  3 Sep 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDXfBAi2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aWtvt0Gf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506391CDFA3;
	Tue,  3 Sep 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367417; cv=fail; b=aTQnOA3EI4jo6tpKFbv6ilnaGVVikw/HSa/rYBzR+fE8vPJvPqXe5oh1b+oB59gKB/eI03L/vLx3sGNBB0emIxsWTwlbgOaUqL7/XnA77U6+o07mtDUAFEB20y7s/5JYz7tmoFbvs9oKDSMm8GPBORQUlylCcE02WrWhvQdSX2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367417; c=relaxed/simple;
	bh=CpR7As/oysFBn1IeMYaFYJqqFxgmOy1bgV/XFcyVSwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DOHJE8umVk1pgUi3NLB9S9q1HLQmVmL04YhNM0+XsCu+SGYRnrpYwy/aq1GrHtfsysKc35IayLVi+rUB/Aqrf+LiGQSTGLZDCbwnaOe2eRIwX7sirhiS8XHevNOrIsrRKRj7ZXvgHlO7ODRpYvp50TtJR1YYlGX9z46/f05NvOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZDXfBAi2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aWtvt0Gf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fTZI008139;
	Tue, 3 Sep 2024 12:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=MpwldNn6YrpZTQOQ6ynQB+GmC0nf2xLZin7RxlxrDRc=; b=
	ZDXfBAi2wOMnYgZxeo66iktL34wLzOlXUyCD7TM6Ge/6eYNcdd5NI72UwHrZc5Jm
	sJmk3pKJDYwRABRp6LNiEXeKLMYChFHPkr2t1H9k3l/qvZBQBoa3GhCrpdJSAG7n
	lgnj8UQmJT4Ma/wVhOkuDX12uff7lN0RULyWfHXJpTot867MnvWML3p3RNTNNbI5
	j8vYv6Ctw/QVB6X+AYFcgQggxRZoOvnAp70bDNVLi+1Fxq57XmiUZgaR46tKO/kJ
	zLQPXJrdHLXmAjR4ipvyksX8hjS/YMzp3QPPdUGayGq0IRMRSzgOHPAeyDNdxDyN
	sF5Abr5TN8BirUisTPqcbg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duyj0t2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 12:43:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483AehD9018516;
	Tue, 3 Sep 2024 12:43:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmencpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 12:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7KhWk27CdfiMBbXF7rHSi6mDB8xGvq2Kb/54L+ix7Hyow8Iyf8qZ1WDtuTo4KmKI0AzxgWsVXIyFgVAjQZuCZCiz3ugj8W5I9Np4kXRjBF4UtDPk4fxnURsotvb3kNG5E7QkPC+OV+uqkl9XUIO9zW4XwoKr2W4XGi0RvlpzoYEThahxROd3KqW1woHJ20geCJ+n933UJaJsV1JepVjMgkQB6Ux7tzRwa+fzovu95rKjts/gvsVLo/0lgCbyp+IMXpheEO+Jl7kjH1nFNddRQDTRJuJ9wNLdRbFW/8gfJSjVtjo8NTnaz9521PrwoK7RyAoRoxA1TY6I1beqS6YMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpwldNn6YrpZTQOQ6ynQB+GmC0nf2xLZin7RxlxrDRc=;
 b=yX0/U2jY60QXi3gdUBBd72Q61AUdF1MXK+IDDl4uFpOAB2nEhTCTwn9io9X0eWOAtgI37RlProa9XSSRDlomBn3BUcpJR01QlmqsFHEY1twmcrfRmvXRI4/ma6l1HkxPEVGKDGYKJu38M7z42rNvMJMA6kk5F6zABJwEwL7Me4VLFKCTI5EAFobPf+WSQbeImvJW1lk1kQFe8oCrwZ8GMHdGq6sybrYNGyUckr43Ko1aRj92RVpK08zWYlx9m8MAw6o8k0D2VsnXH+oNOgSFcsI1a3TpVCTkMiL9yQabNSPm2vV3PNqV1a8adkqwlZx7vPt4Uf0cpJmtxmG66bRnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpwldNn6YrpZTQOQ6ynQB+GmC0nf2xLZin7RxlxrDRc=;
 b=aWtvt0GfDOaKo76WoQEht4d0z3ANqzFI+gRz/jnHipktIm5FKheGAZK4KKrHIqX6cgCso587gXfIZ+e5RBBoPJb/em+f8YitDZoFJjpCcI54XqI9AQLlTBFqPziTocgH3ON12Iy9LjIVkzF6mCIu/iyx3QMiOStAp9USq98f9qg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6443.namprd10.prod.outlook.com (2603:10b6:930:61::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13; Tue, 3 Sep
 2024 12:42:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 12:42:57 +0000
Message-ID: <99345f2f-250a-4717-863c-d61d573b08cb@oracle.com>
Date: Tue, 3 Sep 2024 20:42:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test concurrent direct IO writes and fsync using
 same fd
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: f504ab5d-c157-4a3c-c1b3-08dccc15eff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWdNZFBJbW9YNktLUzdMSVFhaHR4NHFndUI2WUlDdEgxZnFNY0RWME45N1Fj?=
 =?utf-8?B?M0E1VGp0QWxQUlIybmNJQzlyandMRlpXR1llbzJSUVMyME9ZcUhXbnlEQ0lT?=
 =?utf-8?B?RFJoUlBhVlgvenZ4azBsb0YxSnVWanVEWmNjMWpQM2NHTGd1RExJM0ZpVUpr?=
 =?utf-8?B?dmxKU2JLRy9qUXJFdlNZeXlNOWxuTndwU1FCd2x0QmJYUHZwbGJMN042ZDBS?=
 =?utf-8?B?RnBYNDZnQ0JoYXBCK04ybkRaNDdWUCtWVWw2OGVwV3VWSFZUbW5aNTljZ2Z6?=
 =?utf-8?B?MEJiRW1HRWt4YlFxVHJSMkNCSlhraUlTeU9RdWZnQjdBUHZiM0orSnFGRDFz?=
 =?utf-8?B?ZGZ0eUJWa3dQQUNuZkY2eXl0c3RxZS80K0RXY2NnRCtOTlp2WkpneU9WWFpE?=
 =?utf-8?B?Z3Zhc3BhM3hjS3Vkc2ltMXJYS3BUUVB5V2xkd1ZBT212a1NHejNXVnJsZWYx?=
 =?utf-8?B?UERWQmE4a3JPZkVnbmg1dW4weUgyWGlucEpWSCtKTEV6NEJROXBEUkpNZmNo?=
 =?utf-8?B?L202WEpUMSsrSlRqZU03MXhyOXBTQWlGRnJyYWthc2MwTTFaRGpUMGdlRmpH?=
 =?utf-8?B?SXdWOVFJRlprYWpvMGdLZHd2cWk5bnNxcWt4dzJ2T01EY3BuYjdOMThMRGVU?=
 =?utf-8?B?Wm53Tm0vQmZOcVZhVHBRNlY3RXM4R2t3QXF6cmtvVmw3ZUxmdGhnZEJFa2VE?=
 =?utf-8?B?c0lxbXJVdmwybWFVNk8wU0lvWVFZaVpQSWFxTkhBN3BHUWNnNzdHUi9VT09H?=
 =?utf-8?B?b1FRblhobnRPaW9DVUNCeGMzak5wMjRZOWNmU1o3cWxHZVFiZm9BR0JMWmFp?=
 =?utf-8?B?eTE1UHhzL2I4WS8zVDVyd2JET1JCVWVlcmllMjFPeU9NQncrZlpLb0NrY2NC?=
 =?utf-8?B?c2hvOEFPRHJLQWcvTlMvbEtTdy9vK1JWZ29Ha1hseE1sbzlvWkRLNlFZaHVo?=
 =?utf-8?B?VTN6czNNOHlqaXh1NkhRNlhjdHBTYXhZUWZqTTJqcEgxTzBhZHp6eVlnemFX?=
 =?utf-8?B?RTNXTjJEdHJjMXVtK045TnI3VDMvOHE2TGdUUEpjOC9ubnhYYzhDZ2hrUkxN?=
 =?utf-8?B?QW5XWkFoZW5QdThMVW1tSUNQanY1VjQ2cTViNVQwNFZwdzd6RGhLWUFzYjha?=
 =?utf-8?B?Z0tKcGdLazJsWlExTWJGZjlGZGVjWDlMY0plRlBFLzYxQjFxbEZubUp6bWhI?=
 =?utf-8?B?Z3dBd3ZydlpjcCtXNlJxVlllMVhDQkRLbmY3M1MxUXR3UE9TNngvVXVJMHRS?=
 =?utf-8?B?ZFVBeG9YTVNVWi9KRWRVMUJHN244ZG1aRnd4Y3h4MnRKSHlMZDZTZS91K0Yx?=
 =?utf-8?B?SVhTc0ZZMFh6QWRVMTBWdEFTNGFRM1dkL1BwU1JZNm5vQmV6eTVCMEF6VEtY?=
 =?utf-8?B?d00zQW10aWYrSDhKQnViNXpMV0o1YWFaVkVSYk0xSGNvckZJTjh4Ni9xVWM5?=
 =?utf-8?B?Y242UWV1UXdpaEpXOURyWkFPYzdpd2RnY1dCUFRlYmQ4djA5SFUrSjZReHRk?=
 =?utf-8?B?bjVERWZrMUwvWWJyZnVJVExYVGJiWmVUaWRwcThTMnBqYlhUSld1aDlYQWh4?=
 =?utf-8?B?WGZPZUZja2UxbHZ2ZEI2Q096dlFQOG9PSWhic2t1VUpQRDZrYnd1bFJPakpG?=
 =?utf-8?B?TVN0L1o2cjVvelRaSnBndk1lZVg5UUxKeXZHTGx0RzY0RmFPRVF3SEhIUFhp?=
 =?utf-8?B?anVYaExJckk4UjgwWC9seXlnTnZseldsRkZMZWlXUFR4cnNrbGE3R1dmY1pR?=
 =?utf-8?B?d01TdWhLV3VXb2lwU0RHbi9TNjV3ejlMUUZRbzdQemsxdlRuQThEQU5MMnY4?=
 =?utf-8?B?aDZUb2hIV2lpd3lvaGVYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnVKZlZQaHhhMDgwL0JiOU1WcmkxMjY1YUFyMERQWHA3OHdEZ2M5b2ZXL2Zs?=
 =?utf-8?B?YU4vSXVXajJIbG1TcFN4TkxvR0tQK0VQYjZidW1ISTdZTXhzcWp2bEpuZkVu?=
 =?utf-8?B?MWExRkRzNjJXN0I5MDBvQVpPTVgzbUgyNUFVR1A5dHNIZVlVajM3Yk5oZUl4?=
 =?utf-8?B?ZmxFUmRSYjNxdGxSQW5EOWE1NzdQcC85QkdTcTBCY29HcFZCTW9HemJhY29P?=
 =?utf-8?B?ZlBPcGU4b1U3Wno2Wmx6MEcrdE1CbkZ6LzJXMWdWNkw1Y3VzZFBmK1RTcTBG?=
 =?utf-8?B?NDVob2xORjdHc1lHYmhwTnRzSEJSSWt3YXBzSkZPUFhFaWVlN1Z0Y2dGTFR3?=
 =?utf-8?B?SW50RzNNVG13V3BzSEZ2OGRpMEdHWERMaFpiNnRsMDZCZkV4dTBEbks0Ynk0?=
 =?utf-8?B?QTdTbXJ3RitjSkJIVWg1TnB4T0FTRC9IZ1RraFkyZjNaRXFiTDNWZWFtYnFY?=
 =?utf-8?B?NUp3Y0RTSFRjMndKRU81Y3p6cytIemh3R244eUFTZU1zaHJ0U1Zra1ZGVU0z?=
 =?utf-8?B?bDRsMXgrc0N6Y3d3ckZNajlnb2FFTEVmb2g3ZHpaTHVVLy9IWmhjTUFwaXhE?=
 =?utf-8?B?TkZ4MGU0M2pROCthTnZLd3crcXdTY2kwZmFZMG1XMDNhWjBUWXdKMkFoRWc4?=
 =?utf-8?B?VXZaeHo5YlhBRWZzUXVJSkgyNmZKeTZIdFRnZVhSVDRsbGx3M2lUeGZETGFp?=
 =?utf-8?B?SE1aTk9lbnRQQURLaVpVL1VqZ3pvemxZVzdYc3Z6L0V6VG1MTEdHSXZSU3NE?=
 =?utf-8?B?K3o2bk9MRzM1RzZDeHhkMjB3ZmE0S0QzYVJHSmNVNTlRSG5ONk1FYWd3UUMz?=
 =?utf-8?B?OEErZEVmQ3ZpY3ZzV0FzbGpQNWZtMWQwSnBsdWlzNVZRZjk0UWU4NFVkSGg5?=
 =?utf-8?B?TEJSU1hOU0ZTdXJzTm5EazJZeWZlcDBpUmZocWVjVXhLaDBUZ0U1WExvd2RR?=
 =?utf-8?B?RjIweUJWdXVPcW5nQUk5b0h2QjM4bCs4ZlgwWHlrNDVIa1FEU2ZDYXpldlNB?=
 =?utf-8?B?YUZ4M1h1d1RUU3pGaVFoMjZIMzYyRTA4VnhtUGNadVBZR28rL2hYSFNRTFcr?=
 =?utf-8?B?YUtQb211MS9zdUpXYzd6QlpHcDJMUStDdGc5UnhSMnQzMVlIUXFIa3Z2aGJm?=
 =?utf-8?B?c3FpRWNlMHBxQXYrSHN0SnZVaHZDMmV5dnJGdUhXeEZySlJwYW9Ga0FDRmJh?=
 =?utf-8?B?VEh0Zi9JVWJNNVN0bUJoam9pNXdVNFE5TnBzeHA5TmsvR1VLblpxRUYyTDUv?=
 =?utf-8?B?WW1ySFVFUVR3OTAzN1V5K2ZTMzlwUmJjMFc0TmJibmk0OXRkL2NyRyt2Skw4?=
 =?utf-8?B?VmlqOEtxWk16Tm9nbEMweVBSWDVDOW5pcXhDNW5sSGQ1eks4RGRNYzR4Mkdy?=
 =?utf-8?B?RkJ1dlhPUWdHMTBjMTl2R25Dc0hDc1ErcTBhWUZzcmFTQzZoeHNzMHpIMFdt?=
 =?utf-8?B?dlBaeERTczJmV3orUDVwRm5zTmlXd0tCUDRQbXh3andwQXJlUXNHMUJ5Y3lm?=
 =?utf-8?B?d0JISGVNNHBaczBhRk80N3c1dkJVZENZMU03NDJ0aGxMRnBMNW4rdTB2V1RE?=
 =?utf-8?B?NVRLWEh0czJTS1kzenpvYy9sa0hNbVpPaGNidkpXbDUrL2J1T2x6bmtIaDUy?=
 =?utf-8?B?bjNxSnJycUllRTl5Ylo3TW1oN3Y0bHdNdGp6NVFTeGJ4K0F3SjAva2ZWVGZI?=
 =?utf-8?B?MzFibWQ2TXRSUTYySzFpZW5sUVpPMmJxR09rcUZXMzJ2b05pRkMrNXl1VEt6?=
 =?utf-8?B?ZS9xYU9XMXJob3hucFgxaEwzaTA3NHZIWVJXYjA3bEg3THl6L3NSUlIrSkg0?=
 =?utf-8?B?R2duZytoTmNsOFBlVHcwY1dXbzU1MlNBWEk2UDRaZnJXeW9BbWVjL29hckhj?=
 =?utf-8?B?YmNSMHowakk0MmJxazdkOTFkbUhVQ2dya0hXTnJIbFU0bHl1Wk1IMUNNRFVx?=
 =?utf-8?B?Uy9OZmRtN2E1KzJWUkZyV2kzcEszc0lCZ3h3aE45UkZ5RHA0SVlGVXhLcm5w?=
 =?utf-8?B?OGp1d2pJRnFSeHJDTFNTUTYzbXBadFA0T0FQN0tnbGNEM0cvTlFHeTg3TUdC?=
 =?utf-8?B?c0Nmd1JsRU5mSVNLb2lGZG15SGUxZDNiVkRHY3FXSEJvSHBGTmYxdXFXZnJa?=
 =?utf-8?Q?x3ABmpnZB6fzXw/Eqi1K02fT7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6Td80OojcJUo8CqX/j98mnmML4aeZI15I56FdwEN33byb5Y5ErN0rkTL8g5y7vOSnfJ37eyz41CQP5wpXUZPkGBm2DhHAhEF36Gvp0HM83FweuqiF98OmhVaiM+36IgjX6fLSRgFMYo0gxfXzobv/K2i/zDgUQZ4GgrKu8w0xgY1OK6HPxVFbPKMfYOD77sdvtlIWfii0q8plqwAT+68JQXTfbXpmaSaKdZpktfdrZi8VWbknZ8JKI6QmnU9wJ/DFT5lPolvDXn2o1Pd+izd+LfvWaaCsgdNVHhNlHSLjDxMVIJyQ0yyq7kRWym/iYGYijDLcHla2sCGF+5K8ZBlEqz6uq3EQ8Bc2xVlvaPszQnjMAnR2RYnHtoobXwwYQxwp2tue/dDYw7noxmZ+/Jtj32xLlsf5EclP00deq8/lnpVHfIRH24BsmHQCy47G9RY3R9cwLn12GD+Go5Y7H0tXFvJfljom8d9n4Zz8TDb88Y8ZnKl1v2cRBkZVCH1ZhrTpGfasmSuMNGZAEUA9ECmsYI0ISl1qi+4Qla5/6O8hWODhRq21qmBE0VAItC0ATReCWLAKG/utJfQc+Jtb+f30dSmvqxXs9UD2emJV4d6h+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f504ab5d-c157-4a3c-c1b3-08dccc15eff4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:42:57.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAFnwUyJ3xaNSntpIQdbsFXxNNOfZQ9qi9vXWrHImJQNbDlSiZecK5/R3o85paLMN2/HO1+lIbo38oeDvBjIJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030103
X-Proofpoint-GUID: mtXMmOkM8uR7MALtzQjzgT_YBon1vPg1
X-Proofpoint-ORIG-GUID: mtXMmOkM8uR7MALtzQjzgT_YBon1vPg1

On 30/8/24 7:10 am, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that a program that has 2 threads using the same file descriptor and
> concurrently doing direct IO writes and fsync doesn't trigger any crash
> or deadlock.
> 
> This is motivated by a bug found in btrfs fixed by the following patch:
> 
>    "btrfs: fix race between direct IO write and fsync when using same fd"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

-----------------------------
FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 dev2 6.11.0-rc5+ #7 SMP PREEMPT_DYNAMIC 
Mon Sep  2 18:46:19 +08 2024
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/363 10s ... umount: /mnt/test: target is busy.
_check_btrfs_filesystem: filesystem on /dev/loop0 is inconsistent
(see /Volumes/work/ws/fstests/results//generic/363.full for details)
Trying to repair broken TEST_DEV file system
_check_dmesg: something found in dmesg (see 
/Volumes/work/ws/fstests/results//generic/363.dmesg)
-----------------------------


I managed to reproduce it in two iterations.

For now, the test case is fine as it is without the require_debug part,
since it doesn’t always reproduce every time even with it.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand



>   .gitignore                    |   1 +
>   src/Makefile                  |   2 +-
>   src/dio-write-fsync-same-fd.c | 106 ++++++++++++++++++++++++++++++++++
>   tests/generic/363             |  30 ++++++++++
>   tests/generic/363.out         |   2 +
>   5 files changed, 140 insertions(+), 1 deletion(-)
>   create mode 100644 src/dio-write-fsync-same-fd.c
>   create mode 100755 tests/generic/363
>   create mode 100644 tests/generic/363.out
> 
> diff --git a/.gitignore b/.gitignore
> index 36083e9d..57519263 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -76,6 +76,7 @@ tags
>   /src/dio-buf-fault
>   /src/dio-interleaved
>   /src/dio-invalidate-cache
> +/src/dio-write-fsync-same-fd
>   /src/dirhash_collide
>   /src/dirperf
>   /src/dirstress
> diff --git a/src/Makefile b/src/Makefile
> index b3da59a0..b9ad6b5f 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>   	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>   	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>   	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> -	readdir-while-renames dio-append-buf-fault
> +	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd
>   
>   LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>   	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-write-fsync-same-fd.c b/src/dio-write-fsync-same-fd.c
> new file mode 100644
> index 00000000..79472a9e
> --- /dev/null
> +++ b/src/dio-write-fsync-same-fd.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> + */
> +
> +/*
> + * Test two threads working with the same file descriptor, one doing direct IO
> + * writes into the file and the other just doing fsync calls. We want to verify
> + * that there are no crashes or deadlocks.
> + *
> + * This program never finishes, it starts two infinite loops to write and fsync
> + * the file. It's meant to be called with the 'timeout' program from coreutils.
> + */
> +
> +/* Get the O_DIRECT definition. */
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +static int fd;
> +
> +static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
> +{
> +        while (count > 0) {
> +		ssize_t ret;
> +
> +		ret = pwrite(fd, buf, count, offset);
> +		if (ret < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			return ret;
> +		}
> +		count -= ret;
> +		buf += ret;
> +	}
> +	return 0;
> +}
> +
> +static void *fsync_loop(void *arg)
> +{
> +	while (1) {
> +		int ret;
> +
> +		ret = fsync(fd);
> +		if (ret != 0) {
> +			perror("Fsync failed");
> +			exit(6);
> +		}
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	long pagesize;
> +	void *write_buf;
> +	pthread_t fsyncer;
> +	int ret;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0666);
> +	if (fd == -1) {
> +		perror("Failed to open/create file");
> +		return 1;
> +	}
> +
> +	pagesize = sysconf(_SC_PAGE_SIZE);
> +	if (pagesize == -1) {
> +		perror("Failed to get page size");
> +		return 2;
> +	}
> +
> +	ret = posix_memalign(&write_buf, pagesize, pagesize);
> +	if (ret) {
> +		perror("Failed to allocate buffer");
> +		return 3;
> +	}
> +
> +	ret = pthread_create(&fsyncer, NULL, fsync_loop, NULL);
> +	if (ret != 0) {
> +		fprintf(stderr, "Failed to create writer thread: %d\n", ret);
> +		return 4;
> +	}
> +
> +	while (1) {
> +		ret = do_write(fd, write_buf, pagesize, 0);
> +		if (ret != 0) {
> +			perror("Write failed");
> +			exit(5);
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/generic/363 b/tests/generic/363
> new file mode 100755
> index 00000000..21159e24
> --- /dev/null
> +++ b/tests/generic/363
> @@ -0,0 +1,30 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 363
> +#
> +# Test that a program that has 2 threads using the same file descriptor and
> +# concurrently doing direct IO writes and fsync doesn't trigger any crash or
> +# deadlock.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_test
> +_require_odirect
> +_require_test_program dio-write-fsync-same-fd
> +_require_command "$TIMEOUT_PROG" timeout
> +
> +[ $FSTYP == "btrfs" ] && \
> +	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix race between direct IO write and fsync when using same fd"
> +
> +# On error the test program writes messages to stderr, causing a golden output
> +# mismatch and making the test fail.
> +$TIMEOUT_PROG 10s $here/src/dio-write-fsync-same-fd $TEST_DIR/dio-write-fsync-same-fd
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/363.out b/tests/generic/363.out
> new file mode 100644
> index 00000000..d03d2dc2
> --- /dev/null
> +++ b/tests/generic/363.out
> @@ -0,0 +1,2 @@
> +QA output created by 363
> +Silence is golden


