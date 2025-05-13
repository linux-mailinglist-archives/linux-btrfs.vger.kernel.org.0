Return-Path: <linux-btrfs+bounces-13981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F000DAB5FFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA946377D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BD2153EA;
	Tue, 13 May 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D8x2ph2i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CeQ3M+6Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847414F121;
	Tue, 13 May 2025 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747180474; cv=fail; b=DS35TmWoq0BuC7+QgWw3cuUfQzs8SDbpUTRAKB2cYQLdWFcWNk05RIwd5Ay2NJSazbhURnoAapYEGpNsc0m4SAgFRJGqq03gr1FMdZCtMJpS/RcL4EYIy17Qmq0BUUrV7YGNvWYAIt4w3y71QU6fHn9Wx3nr3BEEf4mksjfrTjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747180474; c=relaxed/simple;
	bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FhYRHJRsEPeMaH6mvFk/f0fQ1qKIgeWtoJmpAx1FhodTpMk3tMFhgPlnoQF8HtVs0EJ8R9lDbwZqi0bbJULFbTEQxfrFLii6nNsuMo59FBcA6jN6g5lvMjnzDklYkO/2BKFheTyXHE0WHTg+q7LeXKZGoqJPa+/BVCbW+RIv0hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D8x2ph2i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CeQ3M+6Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DL0nEF010322;
	Tue, 13 May 2025 23:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=; b=
	D8x2ph2iS0Zi7yNthGOhJVf+GwZRyLFqEKZMrOjZ1eRsvoQ7fTQLGXVCjPPJtZYi
	aJSbAvz5Mrn5TS9U7h3T6tUWrZudcftocqkz315ofZi60iMwR/a8mHg2Jab8jXAU
	2P45y8rC8USOho2afw7DnL9wTqHKj29cJUnVpRi+IlyjE3MPltTkYOU7NxyjnGF3
	esz7FkJoKTqMhLrarJUnJspnHgubbJ0PHbskNqYQ6fiwrPdJRYpHPBIwMgHgHf0k
	IIxOPwQ/B/cAY9Z6PUirj1hWEoYZd+VfHxW2Uz/C3LyKpiNnDU5eZwqHKiM2fyXp
	zP2DTIEYxTPxmklM+3YKOA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchresj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 23:54:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNoShT001894;
	Tue, 13 May 2025 23:54:29 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc4yysu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 23:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIDx8HCs/jwmA9qXpZkRobpjWMTXQ5EQSdhqQhmMIYJuvWx882ABHymhl4JwoDCiLNgXhaAxODT1sO8tFRJILhCxA97K+wPHQLdAz3BUvG/yecOeIaCulcgFAZNyiAaWTfZc6YdDjvBfaiiHmL3gl5m3CTbwO2ZUu0JsDpPB5J1BCShYiRm5bxChpvlsWe+0ZToKwAUzvAqsnBK0hVSf79CHK0kS+k1DB0NDpjJ6j4kguF8oozV6osTXm42QbLCcW+KQtJKSA+64qQ8yrVWVRZ2EtsnMnliXrVhPPOB2O03wel3Pb5FDizefXVUu8WPwI4eaUO/BdJJaC85L9+Nn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=;
 b=iToff9adZwoJJSHn04Etk8BvefmSNl3IXfpBLEm36Fdm5NmnLUoZZ5C54dDg/wMcRCp9/V1O9OsW+77sDylgymEW12aWVm+pV5MTjYIPRqfo8reybbPHAKMDbp8It+MpSak+6cN3GhqAcQQ9/0JTL7buwVHLLRCOCumqyHE+H1ewe4ANoopvydo6imi+jX96ghQ4ve4rPCJ4kCGU7hZZ7O28BkeSklezOoaTOAW7SSR4VM/pFipRxn2Eu9ltpCBhy/0Z5/tJNcBefFXzOotyF9HYEo0oHltu3mUcqGvokaTWBGYrIaO3XBhokSa+Fx/dS4QCqbgoWuEPt8zr0ipmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=;
 b=CeQ3M+6YNsi5+ptpjXyOwnfOrsuJc0+FeY98Dd5kJXZngoGgZEMYO6g6YVrH52NIy8WDkh7jNkurdiy+LMIuNcZf97JMbOFYHYDqE4+hFB4+8gbe3IY34U+3hMrxSC9PYTJNMf9GFuoXwu3RrQvXylFGxF3/YRHS7R8oyM4yrhw=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DM4PR10MB8220.namprd10.prod.outlook.com (2603:10b6:8:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 13 May
 2025 23:54:27 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 23:54:27 +0000
Message-ID: <171e871c-c0c2-4d60-9b3e-5843f95afdb0@oracle.com>
Date: Wed, 14 May 2025 07:54:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250513070749.265519-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250513070749.265519-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DM4PR10MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1573983b-c9a3-4870-67ca-08dd92797ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzFHZ2ZKaWlFTTVTVWJLL3ppZ2UxSENDSFZlTUViS0JJOGZuUnpvWXBRS0o5?=
 =?utf-8?B?WUpoSUJWUEFLVmNtUTZJd3hLOGw0aXZKZnlaUTZFYzkrM1dyakxjUmcycjcw?=
 =?utf-8?B?cWRPZmdBckpMeWtXOUs3bzROb0htRzVtdlBSRjI5VHZwek5Ub01Vb29vMmcv?=
 =?utf-8?B?cUZxLzFyUzc5bmMrRmwwd3QrMnNpUkZacitmRXpRd0oySGRVVUREeE1FREov?=
 =?utf-8?B?a0xBZytjUHJwUGR4TG05L3FqaXFGQmZpQVpYWlhZMUUzQ21XZVI5TjR0eHZ2?=
 =?utf-8?B?WmorNkVPbFBRRENLYjVubUNmOU1PSjArT0FTZVBwTGhPRFNKakhwWGRZWVNr?=
 =?utf-8?B?YmlMZ1BUVU52TnU1SUlkYzB3ditzM2dNT0pPMGozeEtaVjFKUHVxeDZ4OENv?=
 =?utf-8?B?OTVWdDBiTXJKRzIyRVJ4RVhwSHZNTUdTcHp4SEZqQVFHL3BWMU9UYi9EVFpQ?=
 =?utf-8?B?R3VaU3NyeW1NaEU3MFByY0g5MG1yS2dncXhULzB5elMvR1paWXZzdVY1Y0Yr?=
 =?utf-8?B?dStZNkZrUDJuN0prYUQxQjFOTGtWVTZBaS9uUDhycks4K3ZsTnl1dEx0dVY3?=
 =?utf-8?B?WklZTE9QSnZhVDFwMnY3RytYYVhnbzFVRHU1WmNVN1BkRCtyMXNXbklMUVRj?=
 =?utf-8?B?RmM0cU16NVdzTWpxbUVOVTZpS2pYeW0vREZLcjNVOUhDNWR1ZmhEcWdqWTdV?=
 =?utf-8?B?a2ttclQzZTYxMWZIZzZHdFJteUV6bDB3WGI5ZXIyeUljRW1xM1BqZjh1Tmxy?=
 =?utf-8?B?b3ZEQ2VtQWdJUWdhNWxaVkpWVWF1VnFjQ2g1WlJ6NldhVXoyWGdQWjVvbmFn?=
 =?utf-8?B?cUdVV0oxVEJuZ2Jqb3Zyb1RBWWcrbHlmemxBbnhxZ2NDZ0Z4bG11UGhNZUpo?=
 =?utf-8?B?YnFTb0d1dW9PTnQ2MGJDbTBzeEp5WVM4MFJvSHdhdyttVDltREg5dVlhVmln?=
 =?utf-8?B?cmZSeGR1b29GZmxCeWhPQXVqOWJ3YkVtTm5FL1kweHgrU0FMbk9lMXFaNHRa?=
 =?utf-8?B?TUgvT3h2Z0IxdUtrRExHTW1xa1NReFVtcThBblowUmdCWVRDREFUL250aDlO?=
 =?utf-8?B?T2FCLzdORTNQNHU4akhBNjBqRUIrVEM2VytwaTdkaHU4UzlORzUyeVAxd2Vk?=
 =?utf-8?B?UDU1QzVUOXdIaytmOEU4Y29DZGtsVW9hVlZ2ck1Ydjd1cjJuS2tEWmVJR0oy?=
 =?utf-8?B?ZU8vQzJTa3VWQ0FxaDZHTEgzVUFVL08vSUpLRnpaWXJONDFmaG5iak80WEJq?=
 =?utf-8?B?UWtaMnlERjVEcXpMcU1XRFhvMEhkekhBY1pUUnhMMzZZOXJFNmdmczduQWFG?=
 =?utf-8?B?dXdPdEtoaEU5TDhsVTR6SkpGeFQzYlA3ZVAyUEo5RkY5WHk0NjJjMXBJNEtk?=
 =?utf-8?B?QitKNEFpdWdrVkdzYy85ZkFvRE9OSzNuSEdYMFc3cDZFNlVJVXBOTmNCdVkr?=
 =?utf-8?B?ZWhNTndkcVhYNGF4Y2w2dDVWY0s4SzNSMkJkWmNPTWdKVXBkV0hWSzhpb1R5?=
 =?utf-8?B?anh3QkovYUJMN3hIeGgzTkdVaXNaNUQ5YlVpWDhNdWk2U3g5dTdTbjU0NHVi?=
 =?utf-8?B?YkNaT2FzZ0FmM3BSeElTVHIxUVh1T2xyeDZuOGtwaE5HcjJiYmhqUEN1TFVp?=
 =?utf-8?B?Y3BMa3pDRXNWbzBWN1dmeXZMY2ZGYTg3M2QvOHJVcTRpUEJ3L0xtZk5nVEt6?=
 =?utf-8?B?RkNlNk5JU1RJcktQQ2JSRHE0NUthZVJHTW0yYjhYZTBEcWlKa1RsajlmZ2pQ?=
 =?utf-8?B?N2RIbmJPWFRDY1MyWEYwQk5kVDhXdXJlYjIvbGhRZGJUQUE1WU1OWUJORWdB?=
 =?utf-8?B?cnBjdWJXWlR5RlJHMy9vVEZ6cDlaUnpzVmFVN2JlWlNqQzlZeHlJek1ja3RJ?=
 =?utf-8?B?ZXJJUSswbmRBOTVTc2dZV2tabDNXUnZaUisyaXFWcXZNU0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHRMOVVHSEVoQlZ4RHNuSXQrenJrV3BpNERCcnVrdVlJQkZ4MHpEZUozN2hx?=
 =?utf-8?B?Mjc2Rzk2QzN4Y1BzYkdvMlMxZEVTeUZsNG1IZUQ0cnlKbG90a3l3RzZyVmdF?=
 =?utf-8?B?bEYzY203TmtuZktuWkNqcUhuTWhrWDRZbThVSTg2cGRqbnovMDJVMnM4SUk0?=
 =?utf-8?B?Y0wzQnNXempQcGh0MExyNlA4R1dZQXhwT21qN0hNSnFYYmg5b2k0RWl3ZjNI?=
 =?utf-8?B?MkdRNmZXZGF0Q1R1dDlGdEJOUEYvdFJaY2drK0R0OEtxNXNtakJrS3ppVmpB?=
 =?utf-8?B?ck1UZWtXOW5XWEpEN2J2UjBZczBuT2lqa25sSGQyanZld28wZ3RtMUFNTWZ1?=
 =?utf-8?B?NmRxTzM4YnRrWnkrRHhMREc4bGQzTFd6SDVaTVVNUDhXOFUrcUp0TFlDREUv?=
 =?utf-8?B?U054bHdqMEFYM0dDS1ZVRTZhUkF0RnBrNmxZTDVFd0JxWmk3ejJqZkpQdW1F?=
 =?utf-8?B?dERRSG9zRGZYOCtESldBazlwcm9PM0YyOWpKQUFOaDFUQmE5NXFqQVhtbUVV?=
 =?utf-8?B?Z0JuWmNxa01XeXh3MHJCRGwwWEpXMCtVNjUrRXloOE1tU0dJTGZxQWFZcTl1?=
 =?utf-8?B?OXNmaDFkQzZwWTVHenF3M1FLdDlTVHV6YWE0ZW1MMlNlZFB0NXhCUUQ0a2VJ?=
 =?utf-8?B?UDkvMHZSTnYvbmZLSjJvZGthK28rcGx6NWVkRDJlMnlzQ29WQ3M3SW5LQTFl?=
 =?utf-8?B?ODRRYTJ3dEIxbzlrZXZrV0puZGxnTjVuSHBGWE9RRFBDTU9JY0M4T0E0SHZ2?=
 =?utf-8?B?VDRmK3ZYWnFyZ1dUcTJRbkM4TzVQYlNmTVZUY09KM0M4M0VnOElLTCsrYWJI?=
 =?utf-8?B?R1lEY3kvWFJuUXFUOTRtRzdwZzRNYzN1em1FUkZqaTNMVHZGdkJ4ak1YTU96?=
 =?utf-8?B?RUhwdmZHQU4vb25vOEpNOE1XWGY3R0c4RUVpSGVVR3BxS3RFY2JOb21LSUtJ?=
 =?utf-8?B?Q1ZzMllsTVNaeHpiUWRqLzdabDN1cG9BRHJEaXVXcGtzZkZIdE5XQnBPdmdm?=
 =?utf-8?B?cjBNdDRob25oS0EzZGZ3MDBsSmk1R2haMTh5cVFUQjRmRm5sWXZaYWJiYjRy?=
 =?utf-8?B?d0U5c3VaeFg4WURZaVBrdnFqbm5Eam9oV0RCVWFNWHpRTkxJL3Y0RFpta3pn?=
 =?utf-8?B?WHd6WEpjZm5vT1Z6ang3b3Q3cnpORUlKS2VmVjNqcUlreWx2VHF0Wk1rYzRK?=
 =?utf-8?B?UnJMZFFIbmozS2xsSWxRZzkxUDluMzdNY2FqNTZMcitiVFRpRkRNblJnL0N4?=
 =?utf-8?B?eVpXSEVHQ3FlK3dXb25jN1E0WTMyemFSVkRqYTNVYmVNOWxOT1BNTVM1OFJk?=
 =?utf-8?B?ZHFSRW1yUVMvdkdXYzJHdVZTWUw1ZnlvaSt6L1ErZUM5cnlRcEtMNVRrWUdy?=
 =?utf-8?B?MHNJVXRQMkxPY0tydUt5MW4rZVN3c0VOMlp0MUVIWjR2aFRlc010SmJVNEJm?=
 =?utf-8?B?Rjk4ZzlqOVdQMFNPYjJPaHVLeGNPNjJFS2k3dks0UzJSa1E5ZFlhUWgwZmdV?=
 =?utf-8?B?Q2kwZWtSb1Ivbm45cjE2T2M5eEF2SDJ4NzBVRkFENVlXa1RSNEg5Z0hKdHZL?=
 =?utf-8?B?dHlVUldYeWkzSStDRCs2NW9vUlVzUDJudTg1cmw2eE1WSVJRRTd6eTcrOUUy?=
 =?utf-8?B?TEZVcXFtaFduSFFUZzRyRXB5bzM4ZGxoMWlsQ21qRDlibVVjdEZGbWozU1A3?=
 =?utf-8?B?Tnp3K0czakk0cUJBN1VYYmc4bDJadjlzZWxTNXY3VXkrY1dVNXlRQ09PQTA2?=
 =?utf-8?B?Q0RrM0JqVnNGQm14eEYrbHJHemRMeTJqUEFrSHVWWXpPOFFoUkczeFpQUHJk?=
 =?utf-8?B?VlA0TVUxVlFQdDdLOTBRTVpNT0JkSU1kTlFXOTgzSDBtbEdJWjdFNDhiYlNJ?=
 =?utf-8?B?TCtHU3N1QUoxUzgvdFpUT0RWSDVLRmZWMWwrUUZYTHdvR1IxYU11THJhYisx?=
 =?utf-8?B?dmNzK3NlUURyTU1RU1prY1lxMDF0em5pTWpmS3lrckRUWXJCaGhRT0FVTzMy?=
 =?utf-8?B?V0hrcm5heTVqU2pUV3ZJazloOWtteCtRbDZvUGpNa1J5VFI2U2lQSUREbzlB?=
 =?utf-8?B?VVUrKzBlRFZLSHpubWVCYWFsQTZ3NmgxcVdVaWQzUjRreHdBZkE3anNBNFJz?=
 =?utf-8?Q?hLxMhXqc3CBcSUFyf6fMXhin9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ov+hk6OvV97liV0hvwWZXjNo0h9fLys+EMvRbCosEbnojY5IR6nylitzZefPI1R8W0UZpm1IfJ1CniBIO4y3wwhoLpOaJACK71WK7OR3qUHBMEen6a5KMYYswhF1O1IlLCT9wGDtrO0aqKEEHRuAxiWGPdqxo8vd/08712j7LFwmoDpBSB0HMK8pIQm/zcewhtLQKTrLxw0MLJsb7/cvCkpVLcm86mSl2ZC8/quNeRZT0yC5ZJPwhcumDXPeIiQldts7vlujV9Vwv5ZPVVdjQk9PLmIWS1VEEjOCH6XzOdfnuFBwABavQ9Yl0UaUMhdxzBSY8TfPP+CrTPvFg6pADKAvr9xCL+VcJF+n7FbWhnJ1zy9dQt2xk5J0AeyTr0vFL1Oe0yt4ZtO79qpi5Oa2MVSdK+/6CRI4AE4gakwKoTG1JplXHodFfei6kx4dQmNtTUuT0/BigTBDIye1NATWUHj61woFN0YyM0hEFW1RFTBw0I9CJ1JKPoIGr4op/fgb5o9er1DytjepkjsTvdrIsoq7X8oYv9LKuLLNgJEW/YyJ6aFlsL/e5hCn7SYsorqEm/zaR6QMA7byVKZ6cE8t633WFexzawL+bYcE1d1g/ko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1573983b-c9a3-4870-67ca-08dd92797ec7
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 23:54:27.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDQpTOgSCCSbQ55usFYa9bJ9D1LPvs4wHYMcfXNs7X2SgzUWNu0HEiDOUQiUw/cBTKRW/VnNjCr+ivZrwB5oTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130225
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDIyNCBTYWx0ZWRfX68ln5w0wqRDG KCZQ/jnyr6L+oXXY2YBD4CtmNC10WHmrNeDQUC07vyrZgRb0dyVKnMlnC2UWFcHb703pssFRhfa 0Won3oMOxrgxyAvocKeFPf0Lcxv/w1OrE1bqn0x15Z2PMfgWeUnS87Y4mk2o3o/2D+ygX3JMK3l
 vZWXQHZz3pnuD1Ae0IFs94roQLNtHacBtGuy9Rp+g6s9ulREBRwGFF+GMEWweZRuiSzWfHur2V6 A7RH710hYH43mxua8Dsfrux2Qk05OBUZ/xlZ4v/P3xBsuXwANs7Wi8g/kui8AsD4Ai5lH29lz6M WDgUXEgNitlnVQidW2mnp21h5EJcxvKH3YMm4wsaysvkamRA1q5h/Q6FiOK3D74VDEAGnYRyYDo
 wFi6Txd9HxwdfI2tn11auNQ8YKv16mS9etQpXeTgT1RjAp9rukl4oXHeTgpAbE1ZFtHBgDWR
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=6823dbb6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BGF_fdTIUcW3nsKGlJwA:9 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10
X-Proofpoint-ORIG-GUID: ZL-0yKDoH9N96uf9-utvtzhgkVoTKhov
X-Proofpoint-GUID: ZL-0yKDoH9N96uf9-utvtzhgkVoTKhov



Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks.

