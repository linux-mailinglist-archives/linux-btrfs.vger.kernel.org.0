Return-Path: <linux-btrfs+bounces-3716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940F88FBBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC37C29EF65
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FD43ACD;
	Thu, 28 Mar 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N8tyKWhB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PZC+wdnD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D611DDFF;
	Thu, 28 Mar 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618623; cv=fail; b=o814mbvkDvtqfbcylCKV4/i1lAjo7wqU8OiZ8tJwlkaFw4KF3MBRiApxqzP+wWZY3r/Xh2MTDxf0VLfScgobOVeg8FB2+Fa8bdEgryyjCqi67XrIrRgnVEfZDXAW04c/Vo9KMP6bXGs74yjj1LR7/VCu5uXnS99nIQq/8Whl/TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618623; c=relaxed/simple;
	bh=J/EfyB6YkNtSYiNGKOiX4czBSZJVe1kxGoJsGeuzSz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TNNqApQR6G8C0knr3VRW21v34SpxgZStHvkhBdF3JfKzrOwGRvg9QuM9JIImjF9P77MSrPV8c2hSTmXOQCxXEhNzoQBgku7Kyg773xbTFU1cbs9sAcrD3nZKEKJY8pcGpZ1BpI6It7KfxSFqs9SOvS4VFdl5+TfChquELrwUYBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N8tyKWhB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PZC+wdnD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S90rMH006835;
	Thu, 28 Mar 2024 09:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=o9i3pmRDNJ187d2mz26rZs81ToqNOtluOgYSCfvwTkE=;
 b=N8tyKWhBRtnhieclRAvVlCbeVHgrXRHeMgq50ww/yJxCKOFAnE5Od2bWTXGiQAmi6uBb
 HQTXGIZ14+weK4i1Ax77UyF+Rdli0zAJN6ZamOAv+bkztngcgBXJaOMcC+EKeShhhEZU
 jdoMErUWoT9YBgQqEUm/ml3uKz1LPtmXolpqX7X7mQImCUWyPgvIFjZOLVKsMjGe87Pm
 5WYW3vJlJ6WDNwWtyIUrEqaH24cYsRDt9m6ZdSaqKpx+ZhyQVqJDy25aDK+c1p3Y726R
 Dg6PPsdSt3o4z68X0K0BBybg1zl/XW5L9KAEkDXIN4CURMzHBlGcWQYqBaOWkwxhiuyz eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct8mjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:36:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8a8cg014381;
	Thu, 28 Mar 2024 09:36:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9ryn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhQtKLzU4tpu6FOoLTJG8kZ0L8tyyNKHRa4cy5Ip1MEK6jlW5gUeh+lEHUHAs08EHoftHDypzTZgSgoM1QYc7K6jNvLJ7OmeSM18Cp4liN1pCRd/ahu5HRrLXI9OOU3sFpuaq8M8tWvI0Kl6kYC1cEAwDIBpEWPM842wRYleZB1MHC/IQmwgZQF58inBYpHNO0NDZDhWVVWOufDYHoAz0OHYHhTeSsDHbgPeoQJKZoMkdhrPTxyMSN1mthM+ytbVGUxsgTTBNKFLe/QlDL8TtVPv6Kpc49aI0w1EJoGmjO7pUBuQ6Ex9M38gMvCoSahFHlOOT501wxSnK787VIA0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9i3pmRDNJ187d2mz26rZs81ToqNOtluOgYSCfvwTkE=;
 b=X8POHzWwsCyiDO60nbvsMlJxwwzNhwZaFk6Fhr8rnFXlj/oWEjGC1gZGBJ3LrZF+akuqTJfyrERxB0gZSfuz+LmCxSwMnWRaXZy5qY/fuzHMTsXEACBhSZ7pPNHuAjFzcXMFV4ogvxuvZEL2PbXehXQcF4FpWKT1aoAazq4AFCdbHCad2rkc4iYvhVEIp0Er8dpEV2daVzoBQnpwT8kNHyZTm2Vs9CzF4v/ZZqnyv75Vb+ytSpByJVYKOEaVhXmOHpVSo1Zr6LiW1OuAtqG2cfztDnqGo+ZWWgCNnCx0F2JTHZ9xX+9O8c2TIK3XSacgRcG+3J0cb5RfuGEH/vULZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9i3pmRDNJ187d2mz26rZs81ToqNOtluOgYSCfvwTkE=;
 b=PZC+wdnDRPzXwZ3k4bAYhHyP+ycJKh9jeZUPF5DJO+5G5N3IcLyM21hO+aM7cFaLlsuXTHtIo9Cvjr8/y7r6zjmem1bLTzNTKDlumyhV0ASIGdOobymXrkqqeUPzSn8YY0KsgU925IW3LfgX89Mfy8j7QGBVyz6WKupbd9wQDzc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7220.namprd10.prod.outlook.com (2603:10b6:930:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:36:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:36:53 +0000
Message-ID: <b57bed53-dca5-4e98-bae4-5840afbe7bfd@oracle.com>
Date: Thu, 28 Mar 2024 17:36:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] btrfs: add helper to stop background process
 running _btrfs_stress_subvolume
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <478d09248cf2a98a59853718197104735edd52c7.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <478d09248cf2a98a59853718197104735edd52c7.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:4:7c::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: e180b28d-9d04-40c6-9f9c-08dc4f0a9a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gomOBMrtXF6dqq3O4VE6nv2RK+Vt1DEAB6ndexQa67MaeFPdbp94D9/U1dG0xBxD3WMcVTZ8PvjVAxvf6TaDDCe7SXBYpPMzvJRvQyJDex5RROhjMYToQxjT4yuqsD/iNPVG1lS9P6PGlNjmRxYZfOnjs0wHPTcdxLo93BJaCRvsNJU/ZAQz3fAAMQGN6IXVvlHIS8DELN3GLoBifn6Q34i0m74Hw/SY9XkKMXWDu3mRRtkTrm/izoVIuOwlIpLsUlHmwGx77RXjfgHML7lOLExfTqyupDD6hMNIICHq/6F9EDmQN48EFH+U1JU5B/ssPbIfcdx0CgUHMJiAIRQFoI10ayIRX+e5u2QZqPuhUPatUUoJRAbqYS/NiBuJkOVjH99eZC7faR5I29cLRZRyzvEuL7iDpZUPlHUT1UUvgJwTQ5cRpr6YpyyupQ9swr9px2AZORpdt/Xh6/FQxIiCMiwcdfaQT8SA3TZVObJam1MrRhDAhJOIsUNzC/WdXGkEMfa1+f1CsahrvdTlrYbWVfW2M1twNAI/HE03xNJCUJt3YVwQJ1PRJXJORrDwBT+ZRrQ2UIpifXTnVpUrOF1fCW+YW4Obx0stLGK9VMll+KA8SEOr785l3J4IjVs1kiSl00VE5cX0vapZ0qPN213GcRiFSfpGW856dotigc2S5oA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M0dueHJwQVIvSTd6UWsreWcwVDFaZFZVckFFRFNpaW9uZHVCcHlUWDNlam5N?=
 =?utf-8?B?NCtpNFpYaXBIdzVpT0pEdHpBNGl1ZHEwSXdDWndkTzFRaWtOcW5sRmtqbXFB?=
 =?utf-8?B?MDdVRFUrQWZwd3ppc1JucGFqOVBqRk5PeTMrL3pQZDhXSDE2b0F4REN1Vlo2?=
 =?utf-8?B?cTRVQWNZQkRxZlBGNzJoZi82T0w5NTJnOXpOUWxYL3Y5MVhrWFNNdTRZSkY1?=
 =?utf-8?B?UnFGb2lJMFdBd1JRSmtaUzVSS000djBQSHRKZ0Q1WlpXSDlwSnZIWUZNNGpV?=
 =?utf-8?B?TGI3RG8zY2llZTFKMFJpWnlYSEp6c09qTVVaWUpxYmZmWGl1YW9GTVhVaSt5?=
 =?utf-8?B?akN3dzQxQmtzMUp4ODF6TnIvTHRGdDRVbVpvUXB5OStXaDdBMDl0YWZUVUZp?=
 =?utf-8?B?SURyUnErUkdLTDNhTXUyQ3pHMU9SUFpqZ3duRElKYzFlaHF4L0pxZVdLSldW?=
 =?utf-8?B?R29ZMk1uZ0VmWWZrcndNZ1g4Rm1NdXZMUVE1Tlk5Q3VTa1R5YWxEMFQ0WVNl?=
 =?utf-8?B?QmMrRjRPYlh6S3JCMEFlVWc4MHVteVdLUWZNREw2clhvRDlYS1lHakQzamtj?=
 =?utf-8?B?Qi82V2VRV3ZaSkMwSDQwRTZidTNLeSttbzc1RWZnaW51SFpPdWJJYVNBdnZH?=
 =?utf-8?B?b1l6eldVbVZ0VU5yVEZxVlFpc3dqRWQ5Y2FsQm4ybFFGNzAwekY1WUcrcUxD?=
 =?utf-8?B?VG5iNStRcGpGc1hzYXRrTTkxTllxY1g3b2xXVkdoSlZqNEZXRFA0UFJVRFpH?=
 =?utf-8?B?enBKSmY4bFcrNjcvQkc3T2YxQlQ2NDhkb25yRE5Bd0xERmVVcUZFYmYvekZR?=
 =?utf-8?B?eHRoVWtPeVVWcEw5Z0hlUk5JOGQxd3BGRC9oZFJRV0ZwMzVsSzZPYVRFWmFh?=
 =?utf-8?B?YlNzbm0vRGhpRVVodWVFY1V0Z0JPcS9Ca3dUQ2NWOHpWUXFheHRkOFU4THBq?=
 =?utf-8?B?Mm05d0FiaE1sRk5YL2pnbEllNDBlKzVWMGRUcnBwVWF3Z1lvRDZyRlFmdDQz?=
 =?utf-8?B?L3p2a2J2K1JLWmlqQmViTjRMNDN0TG1uOFgzbng4M3ZWdER5ZWc2bEQ2dHJU?=
 =?utf-8?B?ZlZaZEczWnF5dndZaDAzZTllVGFCTzBtenNlbmxHY2VOV29ramlDTGx6RmhP?=
 =?utf-8?B?SlpzaGpVUHhpZWR3b1Z3bWMwNlFsLzkyb0RHUEFaMy93bTU2MkpwZlJXRElv?=
 =?utf-8?B?L2FJMmFuSWZSbmhwc05NdVMvL1JId3liWWYvV2pqR2RiMWtSMEY5NmthWlZl?=
 =?utf-8?B?bTFZQURrbWRSbGpGVVFNZzhUWU1rTmRMU2ZqZDc3bWhTblZCVFV5LzVZMGZL?=
 =?utf-8?B?b2ZYWXhLUkIyRUpXcks2T0RoUzc5MXhDbTFiTW42bTdGMmRETHhrTndXcFVw?=
 =?utf-8?B?Vnh5djYzSVZqakxQZVNPbUhFTTM0RzZpbysyZVdkbm1MTXd4andJVkFtNjZx?=
 =?utf-8?B?V2dBN1lZbWh1eFVSYUhVMmoyWWhzd2lZZU4rdG9zSXhMcldQT3gxM0htSkEz?=
 =?utf-8?B?cVlmL01oNVVHdlkyU2lLa3R1Si9oWVlRR0dWR0tGalpGVkFyL3BITnBzR3ZJ?=
 =?utf-8?B?Y0lSZkNrNjB5SXllblV3QTlwYlpwY3VwRW9aR3hyRFlGSEVubk93cGdUMlZN?=
 =?utf-8?B?elNTdENkckNBM2Nsb1ZsZm1PZ1I4NjM3S2lLUkVPS2RLdFdONjRucWI4ZzRy?=
 =?utf-8?B?Nlk4K0lnR21GT2xMYmlHMlVSSlQ0V3pxNE1ESnA0TWpFQjZMVjlGNmE3ZnVi?=
 =?utf-8?B?UWZ2ZGlsWWVwQmlXN1lSL2M4c2hmMjZSbnFLNUkrR3lzQllHMGhpcWNMR3lZ?=
 =?utf-8?B?UDR4NStKWktMUmlHaTk3S29uNE45blFaRXM2SnozUnhjbk1hRGR6ek5Hc0Fz?=
 =?utf-8?B?aENoelAvS2ZWSWFhdGFaOFB2ZmxPS0RyQUlLTjN3S3h5akJDdDNGSngwU005?=
 =?utf-8?B?bVJKYXc0MXIxdXJzUDlhcmF4bUJ1YUROTTFGZElvWktnMHBEWEpaNmU4Y3hM?=
 =?utf-8?B?alJ0aldGMWhnY1VQakFOY1MzLzlsZWJmMzdMTU5xRkgwaFJ1OWY0RzZleEFi?=
 =?utf-8?B?eFpGU3Z0UU9MNEI3eEJiblk4QUdCemVvWXZhdi9xSi84TFhtaFNYWStGYzFO?=
 =?utf-8?B?cmtOVTh0UUtRdkJPWUlNRjMxMERvNnowSFJZWC9HZmZwOFdrOWw5bHh2LzNv?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aErAkr+joF8Qx/oe+6670Qj45HfGRt08G1Shl4yTsgUx182k/WyYuwrlDqtGyK5lPphCU1nFRdghUxOh18xDqwuRBpcB7iUpq47GnqH/JGgTuXO5yy9lSxPWD+NTrs5xJz8P7KlEPmaDKduRxhT2Ikq19DoNwzRrGfMukqvG8mwT0NNR0F0vpA8hmOBHLJG6SvI+/At9i1OcPwLBz05Hf4PaPLYucEver5ZH/hSRpgY5Vjsg/LxJdKZLDwSywVpcZRQFSK0Lx0pZ5dV1oGOmgFJEMOlmRQe7KWmzd0Tg6GBhMOqbq3nxHaLM3sC6+4qrVqLrQVpERnn0ZB5l56aBvTo3d0U+bH/jfsZF45TwqXFuCNxoB/NQAgPnnFcj2ZzavpkDmabGRpL1vTztpJe8R1Ux0e0ZMBQZihfqqGtXrQt7EbdhwrQ/4coCtTCkbk7ZzHmJLw1KBZSVhE6LEnbI8YeC8NhW1xYZAMNT1ONNvDFD0ANg4MJshqNG8wzgLeZokT7DilXmLRyVG6mWSkQ3GwAJW4HStod6axD8GbMCYKd6CvRqjNthljVE7w610yKqFYO8N1dLr6wb6pLCd/b1UypDbz65yeCqGBv8OrOYjVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e180b28d-9d04-40c6-9f9c-08dc4f0a9a1a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:36:53.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5aFWM4eTDG/z5+EtZbbRz1oO7fhXerVEUKByA5kPTTSyJ9DQ8P3XGTe35z8JrBkExJ0bGvoYXna4+BWS/Txcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280063
X-Proofpoint-GUID: -U1epDoeEbssN2G4i-CzROw7Wm8zQT1B
X-Proofpoint-ORIG-GUID: -U1epDoeEbssN2G4i-CzROw7Wm8zQT1B

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have this logic to stop a process running _btrfs_stress_subvolume()
> spread in several test cases:
> 
>     touch $stop_file
>     wait $subvol_pid
> 
> Add a helper to encapsulate that logic and also remove the stop file after
> the process terminated as there's no point having it around anymore.
> 
> This will help to avoid repeating the same code again several times in
> upcoming changes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   common/btrfs    | 12 ++++++++++++
>   tests/btrfs/060 |  3 +--
>   tests/btrfs/065 |  3 +--
>   tests/btrfs/066 |  3 +--
>   tests/btrfs/067 |  3 +--
>   tests/btrfs/068 |  3 +--
>   6 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 6d7e7a68..e19a6ad1 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -340,6 +340,18 @@ _btrfs_stress_subvolume()
>   	done
>   }
>   
> +# Kill a background process running _btrfs_stress_subvolume()
> +_btrfs_kill_stress_subvolume_pid()
> +{
> +	local subvol_pid=$1
> +	local stop_file=$2
> +
> +	touch $stop_file
> +	# Ignore if process already died.
> +	wait $subvol_pid &> /dev/null
> +	rm -f $stop_file
> +}
> +
>   # stress btrfs by running scrub in a loop
>   _btrfs_stress_scrub()
>   {
> diff --git a/tests/btrfs/060 b/tests/btrfs/060
> index 58167cc6..87823aba 100755
> --- a/tests/btrfs/060
> +++ b/tests/btrfs/060
> @@ -56,8 +56,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   
> -	touch $stop_file
> -	wait $subvol_pid
> +	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
>   	_btrfs_kill_stress_balance_pid $balance_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
> diff --git a/tests/btrfs/065 b/tests/btrfs/065
> index d2b04178..ddc28616 100755
> --- a/tests/btrfs/065
> +++ b/tests/btrfs/065
> @@ -64,8 +64,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   
> -	touch $stop_file
> -	wait $subvol_pid
> +	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
>   	_btrfs_kill_stress_replace_pid $replace_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
> diff --git a/tests/btrfs/066 b/tests/btrfs/066
> index 29821fdd..c7488602 100755
> --- a/tests/btrfs/066
> +++ b/tests/btrfs/066
> @@ -56,8 +56,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   
> -	touch $stop_file
> -	wait $subvol_pid
> +	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
> diff --git a/tests/btrfs/067 b/tests/btrfs/067
> index 2bb00b87..ebbec1be 100755
> --- a/tests/btrfs/067
> +++ b/tests/btrfs/067
> @@ -57,8 +57,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   
> -	touch $stop_file
> -	wait $subvol_pid
> +	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
> diff --git a/tests/btrfs/068 b/tests/btrfs/068
> index db53254a..5f41fb74 100755
> --- a/tests/btrfs/068
> +++ b/tests/btrfs/068
> @@ -57,8 +57,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   
> -	touch $stop_file
> -	wait $subvol_pid
> +	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
>   	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>   
>   	echo "Scrub the filesystem" >>$seqres.full


