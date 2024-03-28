Return-Path: <linux-btrfs+bounces-3696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FB88F6FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 06:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB7F1F26D12
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 05:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B493FE2A;
	Thu, 28 Mar 2024 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="htiELj68";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rPKM2cK4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E215C0;
	Thu, 28 Mar 2024 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602457; cv=fail; b=juf7kQeMtI7ScY5i9KybFuNXse8xvDGIwrkIK2jFDoqgT1poi+3dXF5IeRgG4Z4NxBEEvhsyu9BNjmhHQwlMHmtbyI4gygEvRlkJfRCApvRQ59++6yRPpbQnT02DPpA9sNw7ZezxgRqL5rINBu/C6nsfAr776f6A+Gtdkjuac8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602457; c=relaxed/simple;
	bh=H40udhh2ZoPL4JNAj8QrWjngGxZJawVI9p4dmJKHG/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVpxrrQwcVJg5GE2LDhynWKMHb9ZfQyq11uUKIeElcxYCPDLgw5xu7s2V8dmwPjJuxTWFEFPnf+sRy/i8nDQcg7E6liQkzK8sA6KuDL6v38EvPsoYDXLCo0OEfDWCXQ3QqOSCDMdfeGui/N91igS5+iXcbo0oAvm0ljtxdAzQWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=htiELj68; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rPKM2cK4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RK9UJO027745;
	Thu, 28 Mar 2024 05:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+uDeKCuhW/q6JlIwYZbRjXN2mQSAImhX50bYbPHUBsg=;
 b=htiELj680jp9nENn7pCwM5cxUL7QiwGE21s+E0Yn0zq+/9uXreMaK0cqLe5Lf7F1O1TB
 jbScKVZbFq2esgZyguVqahdH9CQPJyJIVb0mvFmumPMbIWqvj+cBKwLFRddZlE5gkpKb
 9t9JD4juRMtPa9gGSKeWo/l2lhTWNT48RqUEJjO9PZbFO6/kB3029Gr8Z3YQ9tbO+Tu1
 sv0LCxYXUWjHzkXyzGhgTivjMBr27nhW4qswLt9SqtSalUY7+3GSwjFJ0X4AVLqEVH8j
 Rty54xJ+5I/WDlzXeARIIRtFiiF6jRIakbJLS0Ttp6dIanrltY2sXVaLr5j4YibHBnL/ Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9gycfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 05:07:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S47sSG015036;
	Thu, 28 Mar 2024 05:07:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhfrdqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 05:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdq6sZWekmqme+m9TcCmjr/fyjxgQ98b2tUjqR48OgXhTD9OSBP7LnPeYp5W6ONr+hF8AICZIpHY9pQ29hCIK3tXzAjywM1w71RGX+ZkFW+/CNJsAIxWDGmM2q3bF6Xgu8/hdmxij22Ci3LaaN0I8rNEvV4Z0j2JsBUxC0XYuhfxi1HZcEHk2YMlR9vwRzXvUBPxQoA7YzSntGcJlgNgFR2FJzIJpsEnKkC6nNisMrSGs8GpOSjsc3xhgEy0MTXpurGosvSU+Gub/e94bfN/WBSLii3gpQPfcd3rUvq/VX9gM4AuzUgzySxF/awuRK/Ej94n2XN6s1bPGu5D5KP+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uDeKCuhW/q6JlIwYZbRjXN2mQSAImhX50bYbPHUBsg=;
 b=Um53ZvbhEaaha31KCAxfyvSceFbY68ogTApjr8ukq/s7ZWN/AY5F8nTra/i6GUDAH9wera4hk5E4qix8ohjcOFnASahM9hsaf+ZHHDG9jZNMCfW1zttWoh5hIS0XjJK4VIXlrMJMaTbxhZQsV09Z9khrVJvHQKbka8Duegik2HXh2KXyN+e7JIzflfNQ2iGrss2JYQKYwzBWrGlLJS6WUNblpfYUr0fz33a57XtbhtIGIDCXEXNZaMxh3rGROo/U3WVG2E4jTCSfWsarOgylKWLV/efVrU0mVT0W8NNT79FxewTkIuc+3rk8Anq64btgsZf7KQ/q6vx1X92Z+ulVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uDeKCuhW/q6JlIwYZbRjXN2mQSAImhX50bYbPHUBsg=;
 b=rPKM2cK4thpe/wYchOLDAyvfQVe5lczxS5HQ7zki129z+uxl4gsG03M9opJEBmKNsXYaZeIksNq9hPCSnTqk7RGiHIKcEiO/OMVA04VW8y4BWczhMZYrtEsUfKAJUyHlS9YAo8apSKa0NzPKsqnDyqwOwCkMbCmXWfNwb7hetYg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 05:07:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 05:07:20 +0000
Message-ID: <2e3ed2fb-8b68-447e-9781-aa6f32a95c2e@oracle.com>
Date: Thu, 28 Mar 2024 13:07:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "btrfs: do not skip re-registration for the mounted
 device" failed to apply to 6.8-stable tree
To: dsterba@suse.cz
Cc: stable@vger.kernel.org, Alex Romosan <aromosan@gmail.com>,
        CHECK_1234543212345@protonmail.com, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
References: <20240327120640.2824671-1-sashal@kernel.org>
 <20240327213751.GW14596@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240327213751.GW14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3663a2da-7d46-45b9-2b29-08dc4ee4f20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PyNpOY5LN5W3kY9cihUCt3vPun0iKLHO2egbO211emFwSOjUtAA72rn/z3OV3haKgNKijeR9YjBRulh6vJMFw9h1yrf0jttu/XWQy1jySuBTOtNMKVB9S5bvfmoFXHD4B6kTHznkuIAnpVN93RJmB6PLCqedBSDiY1vHvnwc5DXZwz+0Vc5/YFdX/en5d4qlXoCfEx6kAX7itUe+1PSanRssxjUpZJD4sYB7SskeRFT2BUpKk4eYyMG1ZPydyrL4H8VgwBdH27RwBuzWgwcDfkApPcCnPH9jz1aYEvjWasq5sUe7y7mJGQl37mr26Lld+dpNuPN2D7ZyILeuWm9ZQeqPKJKrXivHQU7jdzLGRUnrWFSiHIk9psTt2oRyg9n4PfmWq/659sXxvsZkviREyHm8k/D3Qmsedt47DtwfbSagZp4iTrigoAywyvd7km3ouZSfickMdRoGyfEfrqxCvwRUVrvzb96RqSNgty2Iqyq6z4AcEEHOewT5A+u/IsmuGdXYENqN1njTfZdQ1kvXtU15X5tIgKjPA3LnzhClwaBxJEoa588rfEOUmSaKHnkhSevMPmK7aWLRorwx+DL8AD+YRNi4sE6HoFlgS6EURI0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzdUbzk1ZDBKQWpCci91NGoyR0hHZGo4UHphN1BkMFVkaXd1Z1NjN1VmTjEz?=
 =?utf-8?B?TDcreGFsQngwbDNTY0ZYVG1UM2xzMzdtbExseUtJOGhHYVlrREdLVjlBY05P?=
 =?utf-8?B?K3BhSTNqN1dvU2dTUGUvRDdQNEV4MGdncU1hTGRuZ0lobXp0b0J3NkMzSkpQ?=
 =?utf-8?B?YmdEZCtoS1J3R1k5d09HOXF1d3ZOZ21RWWU1QmNCeElRaEZYWXFGRy80QnFM?=
 =?utf-8?B?Tll6c25zd08vcVR2blhRY3BTSnkrWTJ2T3FPc2pDTCtVK1hWZk9yZW1vYnZS?=
 =?utf-8?B?ekV6NHlCWklHbVBGcjhSYmVNYlRCbzVlYzJoRHBSRitnUTBrSUo2UDFieFpB?=
 =?utf-8?B?Q3NNbldoWUdWK1R0eW5VZnhLNWhjN0ZCbXdXT1kyK0Z4K3o5RE9pSlE1dXVO?=
 =?utf-8?B?RW1SSE0vUXNuMG50NldPYTgvU3ZlSzhJOGRUa0MvelNtODFIQnRhM01MN2Fu?=
 =?utf-8?B?VTBqYUc0SEZZK1pBYXJuVHZSS2p6RXg4eUlrSHU4cHJwZVRBakxXbTV5ZkhQ?=
 =?utf-8?B?eWxRL1hoblpxM2RJdXhaWmJPZXZlcmNjeG85OXI4a09lWWVJUThueFNYQTVj?=
 =?utf-8?B?a0VwTU90SUVWb3RqQmlRWWF5bG9vbnZBdHFPSXN6QWxTbTJOenJUK2taYlNG?=
 =?utf-8?B?K1FucTRLUHlPUkF3UEZ4clc4NEVUeG1FbGsxQi9RU2JCNE82bnE1Y0xKREhY?=
 =?utf-8?B?VjFSanFvUnYrNVhmbkttWDIvaW1Nd0U5S1JPeVcrWExTdGRWM0EvSm5qZlFF?=
 =?utf-8?B?MVZCVGt2aUNxUWsyMmJuRitETC9SWFFWY3R4czhLUFMyczJKclRUdUhQMERj?=
 =?utf-8?B?SVRRY0Q5c1JsV3lVa0JoakR0aFhsS3k0MHdtNkRDMW54NmE4bFNQSG5vendY?=
 =?utf-8?B?QjMwVVQ3YU02TzB3eTNOd3RkYmVDb0lUYURWeXVtQWcwQzMzdWE4SHo4Zkd0?=
 =?utf-8?B?NlNqYTZOa2F6cTVBTXFzSWgyVnJYODRIUWN5TEwwNk1PVjFqUG8zYVUxRWt2?=
 =?utf-8?B?UmhSYWZHcWhoZE5uOWF3UGY0MVl3OE9tS1NuakpMYzVxb255SkJXdUYwck1K?=
 =?utf-8?B?MFlvemFNUEZhZVNmVEZoUjV4bUlUdGlUNmh1bWF4Wk1QSnZUdVpNWkNSendW?=
 =?utf-8?B?dXdPcGJaZUdJUndDalZXNEVjaHY5RUNNMElqU2U2bW54NGpCdkZLeXlqZVpT?=
 =?utf-8?B?ME5Id3lzZlF6MkZIVzA0Mkw4cGt2aXZ5dlJZWUQ4U2pwNnZNazBJSnB4a0pQ?=
 =?utf-8?B?WGR3V01OblhFc015a2s1NTIyM09WR1puTCtNV1lFclhEK0tzYnEzZmw1VXI1?=
 =?utf-8?B?aGU5cm5rb1did1NxY0Z3YjhkNEhYZGY2cVBBQzJCRUxMcVFVMWsxV1I4OHVE?=
 =?utf-8?B?Nmd3Q3ZhOUtHQ0Y1aUVacmNucFFSYS9TN0h0Qy9kQkNqRjZHbS9VaVo0Wjlr?=
 =?utf-8?B?amt1dmNMTXVCczEwTHVMTlRZcHVWTEF2NGNaUERNM3VyZ3MwT0psY2RndERy?=
 =?utf-8?B?ME5HRDQ1ay9aOGMvTkJuSFRTY1B1SUQrSUV2UlUyMDMvL1lna3pGeG1xVnI5?=
 =?utf-8?B?TW00QlpLQXZoSUVaSW5jU2htOUlLOUpuckZaZVV2cUFnbEQ0U1o4SENNN0sy?=
 =?utf-8?B?bFRBUUFZenRYYzBFRVRaRXdVZGk1bjM1VDBRbm1wMldTQWNBcUI4VXJxQVNP?=
 =?utf-8?B?VEJ1TG9LT3hnWW83eHRBdGQveCtvK0JlWEdFMkhWazNGcDROMWVMeEFielVG?=
 =?utf-8?B?OWFDT0FRcE1DTnpWOGFFQkJ2WXZScVFjelJFUjFjZ3RCVWE3a2ltdElDQ2wx?=
 =?utf-8?B?OXkwUFVlL0xSVjZkS000SEVjN1prVmZXOGpLYjhNODV5ZS9UZDBXNXNaSHJM?=
 =?utf-8?B?MFRRZDZOTHUyUjFaMyt3Yk80d0p5WnExM0s0UkRZSkJHQzlmL2l4VHJxYXI3?=
 =?utf-8?B?Qmg1NWlEUTMwOGpyWXJnTXIvMG5JdURLTVRmVkRiMDZuMlhxUlV2c1NyNVY5?=
 =?utf-8?B?Z2pQVGtHWVQrcEdGZXFmNnhOUlF6d1NjSTRuMWhPWmtNT0YvVWZYT09HSWRr?=
 =?utf-8?B?R0FpM2w3SnJLSjg2VERCejVMTy8yMjlxQ0pLeFFKaWNhalFQRWRwRnppOXBN?=
 =?utf-8?B?VGVaZDkvWWRDMzRiTks0NkIvV0FYcS9xSnJSaFhzYW5zSEhRaUY3OFo3MUdF?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uftHrfC0gDdBZXaHvDSdPgDyYnVlx/44sLlG3SKKHua+zVHXWVzf4ksgWIyaKt7n7xfJhjStJE7kIuh+AV3fN4NVnn+9xjS2JtbBJZi6FOyyKyAbItuaIslHUVrzUfy7xKlZy5Fm8amRceXtPYsZJUQxq1ScL9bruC0aFRlbk0eOrmYIRt3PeBq0F8c4RH6CRurqori57q3Ls+DRx12ozf3HvYkKsd7+Be5vxOcyFCiN/U3GEXZbYapKImlJps3VDzE4d4ZQXlhlr3WN64FIvdKVfn39QPz7TqPxujZUo2nHusvm/FxJMElSpxmTwuAOEfzwRgMl9CsQZ4lZHgijumtwXjFmabmIlm4CS63MXnDOI+KYZs8WxQoSj/4dA0iWLxFGFJBKbMWt1c1SdapZgs+qP0sim65Iz7pJvwHqsFAqEKtSj+nFjPmM+Jms7uMfLF+OQ+vs0ag4y05Ii8cOaYdXLThuqb0bZSUaYJjDr5LLd70v3KAz+vMm0RTEx4cOriG9Rh/kagdDUZ577tDFqLqFZ2+sGIwzdBdS0clqaKimhupzEF4lm4GBZtNleSMApjGHCkSghAVFiC3PFJ6vwSNtTpFxHo8qFdjAIBuABJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3663a2da-7d46-45b9-2b29-08dc4ee4f20f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 05:07:20.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSwKcpDAE3HohI1FIb9gage+/WOLJ4fUmvXG5/6/yxXZhK5aDoAnsTknU8UGCCTc2fzc3i8k2/oOENidlmE8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_04,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280029
X-Proofpoint-GUID: 3JGomjIwh2Gjc-bdDU3z0eMsW3K_Fw3H
X-Proofpoint-ORIG-GUID: 3JGomjIwh2Gjc-bdDU3z0eMsW3K_Fw3H



On 3/28/24 05:37, David Sterba wrote:
> On Wed, Mar 27, 2024 at 08:06:40AM -0400, Sasha Levin wrote:
>> The patch below does not apply to the 6.8-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
> 
> Please use the version below, applies cleanly on 6.7.x and 6.8.x.
> 

  Thank You!
Anand

> ---
> 
> From: Anand Jain <anand.jain@oracle.com>
> Subject: [PATCH] btrfs: do not skip re-registration for the mounted device
> 
> [ Upstream commit d565fffa68560ac540bf3d62cc79719da50d5e7a ]
> 
> There are reports that since version 6.7 update-grub fails to find the
> device of the root on systems without initrd and on a single device.
> 
> This looks like the device name changed in the output of
> /proc/self/mountinfo:
> 
> 6.5-rc5 working
> 
>    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> 
> 6.7 not working:
> 
>    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> 
> and "update-grub" shows this error:
> 
>    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
> 
> This looks like it's related to the device name, but grub-probe
> recognizes the "/dev/root" path and tries to find the underlying device.
> However there's a special case for some filesystems, for btrfs in
> particular.
> 
> The generic root device detection heuristic is not done and it all
> relies on reading the device infos by a btrfs specific ioctl. This ioctl
> returns the device name as it was saved at the time of device scan (in
> this case it's /dev/root).
> 
> The change in 6.7 for temp_fsid to allow several single device
> filesystem to exist with the same fsid (and transparently generate a new
> UUID at mount time) was to skip caching/registering such devices.
> 
> This also skipped mounted device. One step of scanning is to check if
> the device name hasn't changed, and if yes then update the cached value.
> 
> This broke the grub-probe as it always read the device /dev/root and
> couldn't find it in the system. A temporary workaround is to create a
> symlink but this does not survive reboot.
> 
> The right fix is to allow updating the device path of a mounted
> filesystem even if this is a single device one.
> 
> In the fix, check if the device's major:minor number matches with the
> cached device. If they do, then we can allow the scan to happen so that
> device_list_add() can take care of updating the device path. The file
> descriptor remains unchanged.
> 
> This does not affect the temp_fsid feature, the UUID of the mounted
> filesystem remains the same and the matching is based on device major:minor
> which is unique per mounted filesystem.
> 
> This covers the path when the device (that exists for all mounted
> devices) name changes, updating /dev/root to /dev/sdx. Any other single
> device with filesystem and is not mounted is still skipped.
> 
> Note that if a system is booted and initial mount is done on the
> /dev/root device, this will be the cached name of the device. Only after
> the command "btrfs device scan" it will change as it triggers the
> rename.
> 
> The fix was verified by users whose systems were affected.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
> CC: stable@vger.kernel.org # 6.7+
> Tested-by: Alex Romosan <aromosan@gmail.com>
> Tested-by: CHECK_1234543212345@protonmail.com
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f627674b37db..6f4dd3ebbf7a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1290,6 +1290,47 @@ int btrfs_forget_devices(dev_t devt)
>   	return ret;
>   }
>   
> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
> +				    const char *path, dev_t devt,
> +				    bool mount_arg_dev)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +
> +	/*
> +	 * Do not skip device registration for mounted devices with matching
> +	 * maj:min but different paths. Booting without initrd relies on
> +	 * /dev/root initially, later replaced with the actual root device.
> +	 * A successful scan ensures grub2-probe selects the correct device.
> +	 */
> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +		struct btrfs_device *device;
> +
> +		mutex_lock(&fs_devices->device_list_mutex);
> +
> +		if (!fs_devices->opened) {
> +			mutex_unlock(&fs_devices->device_list_mutex);
> +			continue;
> +		}
> +
> +		list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +			if (device->bdev && (device->bdev->bd_dev == devt) &&
> +			    strcmp(device->name->str, path) != 0) {
> +				mutex_unlock(&fs_devices->device_list_mutex);
> +
> +				/* Do not skip registration. */
> +				return false;
> +			}
> +		}
> +		mutex_unlock(&fs_devices->device_list_mutex);
> +	}
> +
> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
> +		return true;
> +
> +	return false;
> +}
> +
>   /*
>    * Look for a btrfs signature on a device. This may be called out of the mount path
>    * and we are not allowed to call set_blocksize during the scan. The superblock
> @@ -1346,18 +1387,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   		goto error_bdev_put;
>   	}
>   
> -	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> -	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> -		dev_t devt;
> +	if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
> +				    mount_arg_dev)) {
> +		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
> +			  path, MAJOR(bdev_handle->bdev->bd_dev),
> +			  MINOR(bdev_handle->bdev->bd_dev));
>   
> -		ret = lookup_bdev(path, &devt);
> -		if (ret)
> -			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> -				   path, ret);
> -		else
> -			btrfs_free_stale_devices(devt, NULL);
> +		btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
>   
> -		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>   		device = NULL;
>   		goto free_disk_super;
>   	}

