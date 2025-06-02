Return-Path: <linux-btrfs+bounces-14355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC68ACA885
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 06:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1508C17973A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 04:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138986334;
	Mon,  2 Jun 2025 04:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eavW1LJ5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lCQuOrYa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B9F9EC
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748838331; cv=fail; b=KScKRZVXO81CarDRv3qT3ves82wBIbOXjghkvB3QNfZK914DWHKNUBoIdVdJB0Sm6ReHm4458YjkuNt/m3kAGfFIiUhNEn7A1LHPS8aErjAbp7RFKBie1STc0IKP2qiaKd4RQRqx8akLv5vqBO8Jt6gDG+IEG01bq/9AkxqjAHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748838331; c=relaxed/simple;
	bh=nsP+atzDhnGo9dccgiHBtxygXhejqdq/PcjmQ177hx8=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mwu/In/2249BLkYXbJF9/IqeLebeNrRM0qsCVzyKVEtFQIIkzge5De4dct8SqaxY5T/KWxHAz6+X7Mf/XBrt75tm1Oj67BYk0xS/gtdSjpj36Hcuww/E8rTJsbAyNfGsEHH7sYbSH/1uQYnsZ/8wjy900i/w0WwtHmzu1looKqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eavW1LJ5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lCQuOrYa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551MqGr5003078;
	Mon, 2 Jun 2025 04:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9F7VksFtjxXEfYo0NIyLWAuRjB71g4QXxHNyI/5gUC0=; b=
	eavW1LJ5tWoDQQVwvn5A0sCWDZhRRjnu3/HVbBPWU7HNmoPKCiRFLojcDCUbpkzE
	NVIXpUigg6+7ixfEPM8tFDu9bC1IykjQ3EdJzt3H3shfb0D+LYxT3+15c+vaPaLR
	lNCrqRlJrjRyVjVejKqnjBhNNoslXG+VOju5X65+zozDTDabEFZEKaoDOvP8Y5im
	TaYQS47Dmz2Vvw9b5YNFaoUDGjNdJLy8RftI9NQSisAh/qb23u96bOjBS322+MGp
	+ewLDfRTrwML2/sGJm6hncPMSaQq02kZQHp7F63qVuSJFrleAbQ77pT5Dmvs46BS
	Gkv360Xx7YA6QSp4e1dDbw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ystesr7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:25:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5522Jifc016199;
	Mon, 2 Jun 2025 04:25:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77fu6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3cGLhw6jd02e168r4V3U6TovSmULMetCeJ6vWXV2s0Ws2TTPTzOSrdF8T7Gfl4WFwIZXSu7sx4wIaJIUYctY8l5Wnfbv0hVwp5t+79H0gexds5Nc7H58rKGzm3c7tlS1FUt2K5re74kqsLUDKCeNpiLTbaE3U/cn1gE6mL9hazC473JPoa22kEw0sAKC0WWAlqsbTgdReenuXDrySi0JqWrKnrG+xPZLAf762OfWJZ51z2rFWX6IZO2YjjgAzYKCgZRc4Tv7Yj0IeSutyvDOdqjNedUpVigJQrOSVwRBI3C1/yKgZ8tnZi20FQSwjbWXMJ30gSuHXzcvUEogmX+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F7VksFtjxXEfYo0NIyLWAuRjB71g4QXxHNyI/5gUC0=;
 b=obuWonm3EnOjxqDPEqbtrnte0Y/19ies0LMSuRics6MPUDNVUVp7e/z5Zrz+t6qOOgnZhOWKRwe0blXs4DRPIZqKmMDaS5KhySbqjdz3TMH9AdMAIiJp3+I67GCQvNdyBpqABVQGuGyU2EY6Ceu4Svdw28+m52BHfgUevEt1UsgWyS+fcfNxfElm09nY1MjSyNXNbbxnzqA/+F0oueUhrIJa6zyUANd0Pw71zW2WXHPrDkXnmBkGYVfJ3sCn/wE/+Q3Dg2Xj/hD/80mvzmJW5DSyqmvPgJdd9Uqwe6/UniX2ATaImlbRExpjmADp8nTvTWXDLKNG8Ra1nRZnfehfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F7VksFtjxXEfYo0NIyLWAuRjB71g4QXxHNyI/5gUC0=;
 b=lCQuOrYaUVtv0GoILD4ax8J2TjH/iWI6QgwWpTVpadQrCjSbKu1d+/m/xRKtjqM4YpvdbvA8yLDugNOnnFBMyy6zx9h/L0Q+w9uNGFDoPsc/tt+++jyO/5cu5s4kzthML1sJN6E+8lqesKzAUTV0an1vpnTnLzF0QTVqdnd94FU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Mon, 2 Jun
 2025 04:25:19 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 04:25:19 +0000
Message-ID: <0643837b-5a64-483a-9cab-8c127bcf4b30@oracle.com>
Date: Mon, 2 Jun 2025 12:25:16 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
 <d513c850-c3cf-f570-247a-7b29c6376234@dirtcellar.net>
Content-Language: en-US
In-Reply-To: <d513c850-c3cf-f570-247a-7b29c6376234@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|SJ0PR10MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: f588eb98-a3e8-48b3-cf14-08dda18d7ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?My94eVBVclc0em41M25OTkhoWVBPUzB6WVRxWWRmU3p2T2pIT0t4d1ZXREh5?=
 =?utf-8?B?VTRuRW9EVWdhdnZYVm9OcWNKQ1NjVElxUUloY2dOU1VRYkp4MGQvZG1RTkhK?=
 =?utf-8?B?YzdxZmN3ZnRSRHJHZ0dmVnpwSE41ejB5YVB4U0U3dzBTQUdrcEhEQS9Oa0hC?=
 =?utf-8?B?NEt4cXdKR3hTa3F3M1hqa3JIUGs2ajRMNXM0QmZaZmg0VnhSMlJXa3RyM2NL?=
 =?utf-8?B?aEluOFMyZjZLUERCc0lJZGV3eUtRb0w0ZWlxSHQ2RE9LVjVUeFVMWmtZcXB5?=
 =?utf-8?B?OEIrMVpNV3N5Q1A4UjJadGtERVN0UFlDNEJTS25YODZQeVFNcitmS2dGWUZl?=
 =?utf-8?B?V3RseGkxQkFEelpySGZ5NXVBSFBuNkhwV2RVbCtOalBDRFhNNjVxbTcyeW9i?=
 =?utf-8?B?a212b2EzZ3NxUlZoenFCOHZOeTUyN3UyMGJJM0hUNGpDV2ljd1lXdjdrU2JC?=
 =?utf-8?B?MStYYVZaa0lka1FDRHJNL0o2WCszbzVqZzR6YVFOQ1pUWXAraE1GS3J3VmFn?=
 =?utf-8?B?YlFqTldWVmhsTXpZaGhqaDY2aW5BNW9YZzlkd1NTUTg3R3pWQ1RROVB5TVd1?=
 =?utf-8?B?bWJENWpSdjFnY3p1UkJsN1NjbVhOOEF3dFJ6dnRnSWg2bDZPNUwreGFzdXpL?=
 =?utf-8?B?VGdSSUdPVzdrNndMWE4rS3B1bW8xWFp2TGNwOUkrTGFMaXpCNmRVdnlabjIx?=
 =?utf-8?B?NWMwTEM1a0o3ODg0LzM2bnpvWWhySnQzMzc0L0NqVU4vUVl0U2RESmhyakRT?=
 =?utf-8?B?QWphZTNyV2ZvY3Jpd1BmNm04dUt6Ym5jNlhTbWJSYVI0VEVFdWw5WE51UHN3?=
 =?utf-8?B?SVBMSVhjMGFVYWc5R3RncEo5N1NKS2Y2S2FXajQ5Z3BRUmNrSGphbUhRUlpt?=
 =?utf-8?B?c3FzVkVGM2pMQnlrT2p3MVNxRllza0ZmZitKUjJVelkzQzBSejRTQ3doQ0xO?=
 =?utf-8?B?aDlOUWpOV0owMk5YeFptY01IRnZTR0NZcklOWks3VzMrMnlqd2RDRU9yWVJs?=
 =?utf-8?B?ZDRJTWtZYjF1ZExOVzJQTk9yUmhCUjd2RW0zelpBZ1AwOGtHcUtqcjVqOWVU?=
 =?utf-8?B?RGxPYS8vaHljZWZsOHVydHI0a1FjMzh0QjdpRzAvZWM4Nm53SVhLSlRpOFFx?=
 =?utf-8?B?bzgwbzhvaUwzdy96aEtYbXVITGVyZjBOU3ZnYnA2Zk55cXgzSGQ0bUpmSXkv?=
 =?utf-8?B?SzZjSjlld2xGNWJISzd3S04wUFBEUXY4NHJPaWVrdUNlNWhOZlJ1c3VoNm1R?=
 =?utf-8?B?WHB0NWg3cXZnTEVQMmhRdWJyQlArYW5MTkNCbDZZWmNzUG0raHcyNk5WbUsw?=
 =?utf-8?B?MXJWTHVGNEhuK3ZVdWRpL3FpM3ZXOThpR0F2U2hOU1NEK0s5WUc5R3BkY2tT?=
 =?utf-8?B?ZTRRRXROUDV3RWtaRWJ1Z1BEYU5hYXcxa3RsMDNuOWR0ZXRERmcxcHpNaUsr?=
 =?utf-8?B?NzlubU91Wkx6QlE2Q2thRWRBRUhyNlVER09zTTIwNzFUSGF2NmZxbGNuMFRF?=
 =?utf-8?B?aC9LdEliTHdiVlYyKzhxUnk1NW5XTnNKYmkxY1FMdlFpTWRaS0ZiSkxxV3I4?=
 =?utf-8?B?OWIxdVJxZWc3THplb0FVK3AyTzcxaVUwdFFXKzY4RVllVzVWM0Z6bkx5aGJi?=
 =?utf-8?B?dUNiRHYreUtwNUQrakZJNUF1ZXlzNkI3c2hLWE1UcitmSmZiazd6THZJYTlZ?=
 =?utf-8?B?YTZIWVljak4wYXh1WEFyTkE4VlJYbGtMaXhKUU9BQU1QbGFFRVhXTzNWeWJa?=
 =?utf-8?B?V0dRVGlwMGYzRXJhSDNsbGhkWCswdnBwd2lZQko0NzVWYTFqWVEyVlB0eHoz?=
 =?utf-8?Q?R0LiAFATXnTXDAJIrbl9Y3T7cxt7j7PK/yGf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW93b0pGdFFsaHpuNjhaVlFOaS9ub1RBVkwrTXc1MVJsa2x5amNjUVRTVVVx?=
 =?utf-8?B?bS9OZCttR3l0WmZkZkpYSmtBY0Y1WHV5OXFveGdCU080TkUwZGdWcmliMnRN?=
 =?utf-8?B?SHVHK25kVUxnNGN5MnFSZXRSQXQ4NjZYR0p3bXZaaU92WG1UZks4THNlQUNr?=
 =?utf-8?B?MXVvYUx6RDhRcjFINHRUMFBkL0xjbGk0S2hWNTBNZ3Z2TXVwU1FTMkZ0YWxH?=
 =?utf-8?B?S0kvNnJ2SGJqb0VmVmRFRlNxTFhGUnk5cGJ6d1hJdVloZWNxSHhybWsvVkNK?=
 =?utf-8?B?RHdnQVkxRGw3VWVEVk1HYnZ2OVQ4K0x1UTF4c1hZbjF0UzJKaGdQTGQxak90?=
 =?utf-8?B?OVRnR0lxelZwcjlldkNGVFJ0SC9CdU85UWlHVnpaaEZUQ3lFcytqZE0zc0ZF?=
 =?utf-8?B?MTB5WVQxNjVGSXVSVlNMbzhlNXNZSFIxVHNqc2lzNTcxUmlEa0NVWHhySFBY?=
 =?utf-8?B?TE1ac2k3ZFNiZW1hc1ovTGgyS1VnMXFTTVFsTlowbWZmZ0pOSEFna3VVRGtZ?=
 =?utf-8?B?eHdaN1VpL2dDNE54VHFDUDVscWhHV2xKZCtJb1NSYjlvcE9DRGhRYXl3aE9W?=
 =?utf-8?B?dDBsMkJDSE5hSnBTODYvTE96ZkExMTZ0Ti9HQk1QaGFBMCtwbzhwZzF0ZE93?=
 =?utf-8?B?dXErdVRUVkJvZ2pKMEdtellVd3dYSTBnQkpwS2FqSEg1c3hIVWF0UzV6dUcw?=
 =?utf-8?B?ZzBwWWp5aWQxVjhzMEJPcDUrYWh1RUxMU2ZnQXFWWnVZUUVXMCtGcmp4NENO?=
 =?utf-8?B?eWxGVVJ4TkxRVEVrd0I1SFhvUjVoazR4Ukc0T2l3ZStsQkhQV1BoVVIxNHBm?=
 =?utf-8?B?UVAza2hwV0xtZGhwSG9lN0t1ZFlVcEdzUnVRdHd2THJBSW9RbjVVbXg1Ullr?=
 =?utf-8?B?azRaRlpKYTNyd2Y1ZVZXOHk2K3h4bkMrTkRyektTQnJuei9Wd2p0ZE1uUFRN?=
 =?utf-8?B?OG9kM2x1SERTUWN1UVdxN1ZybkJKSnE3QjhSSEErQWRDS29ncWdkYlpUQ2ZU?=
 =?utf-8?B?NTZLSGVRK2RJaUlEaDhaK2NJTlF0SnlqWW1VK3drMUhnbC82NWJoVDBMclp5?=
 =?utf-8?B?ZE80YzgzaTlkOE1saElMazRFN2hlOEk3aGgreUdYY0Y4dUEyODJzcnF3REJW?=
 =?utf-8?B?dVR0bjNjcUI3anFPNnEzbW9adnpkV2dhbitkMkdkbkJnRUVqR0U1L25scXEz?=
 =?utf-8?B?aWtqQVdRQVRkVzF4TDlwYS9ydFJpWThycFpxU0FOblJZeHVIUkFIa1V2TDh6?=
 =?utf-8?B?NjEwbkJteGltT1o3MzI3R1FkUG9teFkxSXlYNXVDUkFmY0V4ZGdFNi9Tc2Vm?=
 =?utf-8?B?c2VxUTFnN0FLdDA5NEdmQmtEcnp1MUROdHFxcldtbXBtM256T2ducXIxVTk4?=
 =?utf-8?B?Z3BZcURHMmxrTEk5c2tFUm1EOFZCRlo4ZG9sb28yVzVBQVdENnNMRXl1YlE1?=
 =?utf-8?B?eno5L29oTnE5QkNaTlgvSmpUZkxxTmZtNVV3OWNpNkFjZ2NPUUtzZzl0TkRh?=
 =?utf-8?B?cEZiQnJFaEJjZXBBbnJ0K3ZpNytPbDZsc3NtTmkvZEtsZ25GQ2I1Q3dPd3hC?=
 =?utf-8?B?RWZuellYTlIzUHE1YVh5YUxJNENjdjRWRWZIWEorTUJxNUVHZDJIcFZzNXlk?=
 =?utf-8?B?QkQzWHhRNmEwM0h0OXVjSDRFQXNPTVowSlRYS1NlUklkNWk2MVhqcnRhS1hk?=
 =?utf-8?B?eFhFRFJGV0gycUhiVWdXakxBZWxsSWhVS1NSRDF0REVYZjlVbXErYmF4SzJz?=
 =?utf-8?B?bUJuL2pkblRRKzQwR1lZTWFtNjF1c29TY1VDcUF4NytDaXF1eStkclp6UVVp?=
 =?utf-8?B?OFhSbXo0QnlXM0MwY2oydWFHblU0MkRjUDFsTlJFWnBoY092U1pVM1NWeTUr?=
 =?utf-8?B?RFZySE1LVmR6UU03TmUvcUVFR082UnZseHpXTDFZZDhCdmJXRHhKbDhITGpp?=
 =?utf-8?B?SFhBcG1jbEtxOE9hY1ZlaVdDWXFTRzYyU29UWERtUnVSZUVKVzdUM3N1TjVP?=
 =?utf-8?B?bnowTFdaSXJ4SkdPOWsrUFFaVkRIOEJKZmswV3FHQjRPeUlrWWp2MEVza3hP?=
 =?utf-8?B?R2paVTkrNEVmMDNwTGtTSEFoWnlxNUxEODB0VHBHOTNLMFN2K0tneVkrd0J2?=
 =?utf-8?Q?kUvNpA+DO2thfLxjM2lHsaIe4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MnsmYSrSa3reWI51raMdxBwGMmeIheQYkrMKM696hy3KidmPA+569DRT4/iX7iZaX4EHwU5jAZt1aC6Dak89edZQQGCTd64T3vuE4ODWZr9yk+TAyp01GcuiGtI8pF9SxrOWQ5tlfz5dFaMv3zrvMCDxWi0aZdJFYvtROKCNhYNuUjMNHqCAOU5mNixgNUuP1WzjKEOtgN33UBM9ag7lnVb9O4iYHb6NRl3mWLqmx/Y0oOh8yCGJ7K9G19mzOh4VbGqevJnEjk01WINVkKtE9xiHDqLpmzObwO9M2qCnheJeiSinmcXKjH8zezztvudnKSjg4Zm32berQOyHQDSCVo2Rak9uFvSjic4SaWqp6aMzMGSw7nBRDCwcFf5UYsujT5+WHGtmDG1tIzsgaNz9mbmSMkGPebijoTbVAvJ3QeIaLgScM99X6K9+YYULhOmscUhfJOy+hHYqIgOc2mG1X14W8bsxah90b/74JmcGTFSYu9g0/whj0BcN1JWXhmDj4FUGcpUDoiNtp0eadp598yqo6T/MsbRQpJy9LyN/NC1IWJ6lnzt76gucZEF56SkjUzfcThhmoRRGg8unHGdmWHPwSBNNDCJXqmsHWOLg83Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f588eb98-a3e8-48b3-cf14-08dda18d7ba3
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 04:25:19.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4CYpdas0b0F1a2YQpkqZImEEQexOL3fwu/sKqO16V/z0a+vYQcVi5TGCvqUZ3NishPWaD1ClL/umM7Y51OZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_01,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020034
X-Proofpoint-ORIG-GUID: P_CmXGfFKq1b3z4EF5OBjfNV8zb6Gg15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDAzNCBTYWx0ZWRfXyAUqq2lfFGWs 5PDgGL/05HIXExWFhQ/Mug6hn+VCYwEb0yRg+D4jgPHTcxY1Z6EVJeAk+ITg4/IDo92v3NHRCf8 v7ClU8GnNf0hdyhMUi7dEMfChQ6t2SnPhy3LCjZX4ygQgAUs5YE/eMk2jRSuw9NT2wetySrNinZ
 j3cs26Kb3KO4zTGB49rsqJOw49L0wJASuPHp1AQSLpXTlfYHyvOCfl3L4wy/yfd/uS7tOfmSy2W Cw5suP06C9T1BuLZi/s/FRvPnKfxQwBiUKdxo61+1ZWesgrvAQlq/FRiWxETJZxyeth6A9Ifg+H 8rJku7QIQpZyHwI90eXp1ukf1c6Mq+sxivmnz9m9GMq5vEsN65zAHBpOdqujnXXSd6JkrOv5eUc
 l+fB20WtxEUqfSfHrWGJiysZ7Y8S4TH9zsIQ/0e4j3eCp9UbXgoEiGWtZAgi+BBUqEmkaQjJ
X-Proofpoint-GUID: P_CmXGfFKq1b3z4EF5OBjfNV8zb6Gg15
X-Authority-Analysis: v=2.4 cv=XpX6OUF9 c=1 sm=1 tr=0 ts=683d27b3 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=h-CwbLocAAAA:8 a=zPcFtWzhv26JnujTR5IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=jt8RqQJvuDcA:10 a=qB-ckWXWHtAsDaNONmv4:22

On 23/5/25 02:19, waxhead wrote:
> Anand Jain wrote:
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
>>
>> Introducing Device Roles:
>>
>>   Here I define 5 device roles in a specific order for metadata and in 
>> the
>>   reverse order for data: metadata_only, metadata, none, data, data_only.
>>   One or more devices may have the same role.
>>
>>   The metadata and data roles indicate preference but not exclusivity for
>>   that role, whereas data_only and metadata_only are exclusive roles.
> 
> As a BTRFS user I would like to comment a bit on this. I have earlier 
> mentioned that I think that BTRFS should allow for device groups. E.g. 
> assigning a storage device to one or more groups (or vice versa).
> 
> I really like what is being introduced here, but I would like to suggest 
> to take this a step further. Instead of assigning a role to the storage 
> device itself then maybe it would have been wiser to follow a scheme 
> like this:
> 
> DeviceID -> Group(s) -> Group properties
> 
> In this case what is being introduced here could easily be dealt with as 
> a simple group property like (meta)data_weight=0...128 for example.
> 
> Personally I think that would have been a much cleaner interface.
> 
> Setting a metadata/data roles as originally suggested here would be fine 
> on a low number of devices, but on larger storage arrays with many 
> devices it sounds (to me) like it would quickly become difficult to keep 
> track of.
> 
> With the scheme I suggest you would simply list the properties of a 
> group and see what DeviceID's that belong in that group... perhaps even 
> in a nice table if you where lucky.
> 
> (And just for the record: other properties I can from the top of my head 
> imagine that would be useful would be read/write weight that could 
> (automatically) be set higher and higher if a device starts to throw 
> errors, or group_exclusive=1|0 (to prevent other groups owning that 
> DeviceID etc... etc...)
> 
> And this would of course require another step after mkfs, but personally 
> I do not understand why setting these roles (or the scheme I suggest) 
> would be very useful at mkfs time. It might as well be done at first 
> mount before the filesystem gets put to use.
> 
> Great to see progress for BTRFS for things like this , but please do 
> consider another scheme for setting the roles.


Thanks for the feedback.

The question is: which approach handles large numbers of devices
better, Mode Groups or Direct Modes?

Let’s try to break it down.

Both approaches need to manage the following:

Five role types (preferences):
    metadata_only, metadata, none (any), data, data_only

Fault tolerance (FT) groups:
    2 to n device groups

Four allocation strategies:
    linear-devid, linear-priority, round-robin, free-space

Pros and Cons:
Direct Modes are simpler and work well for small setups. As things
scale, complexity grows, but scripts or tooling can manage that.

Mode Groups are better organized for large setups, but may be overkill
for small ones. They also require managing an extra btrfs key, which
adds some overhead.

Did I miss anything?

So far, I'm leaning toward Direct Modes. But if there's enough interest
in Mode Groups, we can explore that too. Alternatively, we could start
with Direct Modes and add Mode Groups later if needed.
Does that sound reasonable?

I’ve put up a draft work in progress version of the proposal here:

   https://asj.github.io/chunk-alloc-enhancement.html

Thanks, Anand

