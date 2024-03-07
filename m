Return-Path: <linux-btrfs+bounces-3061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0674A874F0D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA216B20D2B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0370112B148;
	Thu,  7 Mar 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KD3/7lST";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JPKRFcbr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0812A17B;
	Thu,  7 Mar 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814606; cv=fail; b=Ru7Z8nqLrKhqCrOLoMfouA60/pPu3zMk7S2fpEJxWIOjJDtB7FbOvPln51Qdz7TnoYl3+nbip7XM2JeYzK1UkkCmr2LFL8IcSkMrt2XmVmMX0zh1TwOsVXv/69O6TK56W9a7H2K0QqbXZ4PE6NYi1ZEZq1TViZFMPKZ6oCYCJss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814606; c=relaxed/simple;
	bh=WW2Z35UiXvP9IZDsQJc8AgUsn22J+KFZWMwiUJ9HGmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sJ1rnGqTX/IVqyzfekZP9Omd2pkwm9SD9mt6nOMcgu+Twdiq2/N1r8tGLMN7pylSz4yEtaMxdTAMhEP6P+JYyAYIdmQDmv25Y6QqFU+rQyiLAOs6OEV9LbVfClsNt22140l5vlT3huDt4t1w9C2HyCIiXUbkYgEIpT/KenshY3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KD3/7lST; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JPKRFcbr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nTJ5019333;
	Thu, 7 Mar 2024 12:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pnZIRSi+3oFdIABX9Snx66QFJEPleMmghS3D15Mteh0=;
 b=KD3/7lST2hSMhUvg2FH/DW1sNQA+aXL8rlEnX2Aklmvw1Y38pTsps7nGMvvSsN19XH+S
 hD/NfeVGh3IlJuSo2OFggeEmXV/appB0wQhPD48vNlTbb4mxFji2PN4HrXJHkPXNPKIP
 Rr5Nef/whYrexKkHqi4fmhhiYX0rtfATz01TC0Op96YTHZrbUVB4mfJqJ52Z/YRXA5UV
 X8BYkU/N4qCPEBS9tGlg3f3++M7+NuCjCdPrtenB9NsNe9CCQX0W6WE/Wj0srAuNpCLG
 giRhQnOF2GdyqitVB8jtslDJI1By5Zzm2gMlqjzO0WGL9c20DPGg7lwMF/kXnQ1QDNc/ 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dkyk3-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:30:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427B8aF8016033;
	Thu, 7 Mar 2024 12:28:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjb5rp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQD1LzRjewjBmqLJljIk75G5VfWjaT0Be6Fi83CdHi0IhH3/nx/ZsY7oh4c2Z42uPCS7ppMM9fpemkm0UFJqBLw3BHISd3qeaIZ0PCff9TkSZja/g9LxSwb+r/EGLPOf2Of+Zdt1ABaX01xwItGweoM9MsCOOis5KtJ3gC/IHXvQsnpc8cPgB364Cx1uFHLbnbSgIeQ43VPFNxemVrp/OjsSXTSl6aWheO3msJv+YKsfXKR7C9xr+GU5n/2J1CwKwb2nN0iZojRiKTbqzKSKnVPHQAh0o/opjGJcjKaLBAo4WpSPbQxdZQI8vY42PiglZ8/5rZUF/C1wMd8qX4RVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnZIRSi+3oFdIABX9Snx66QFJEPleMmghS3D15Mteh0=;
 b=TAFTMtZZAIGNCw1b0K85HxS4i1g+KHD47///9gMr64LFkwgxl2OnXKBJcxzmdiBzypCjUKo1hK4OopPXs/ftDijEnGQYFFQKyObEYDBWR1xoqqxp0rQQIso3NvyeGglQSBitwWK/xLFy8iDYXd3EPS6nkwOL5GDKR0/ymlak3mSJi31ShGnDSEznOoY4bOyieloO3OX63X6dkb1E9BuUKn8k0eOgwC+Uh57jNKZSTdr4Gb6974SSNRvjvJxK2cW8sxXqbLyO4WQqgJ0u50rR7KWXZ/gs6cNkFPO55s6hFhcH6JJNX0S+UaxtTmpfPaMpecmAoUB10m5YMPOUxTb5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnZIRSi+3oFdIABX9Snx66QFJEPleMmghS3D15Mteh0=;
 b=JPKRFcbrWQgTRAc8p20XGdwRLFzoETMxjawR92WMx35Rav/empBLOpfICfsMcb5Ps6KhixZZpO2FqapL5xusszJHB8CJyzexkPUsqRFbT0J8B1cmjjNYU3jnGgWjAh0+ITJiEdJ3DE1vgXZJfjjYPz7/902uC3v+zZCtx686u/Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 12:28:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:28:07 +0000
Message-ID: <7c26f258-f110-4997-b809-c5f239ed0db0@oracle.com>
Date: Thu, 7 Mar 2024 17:58:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Btrfs fstests fixups
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1709664047.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1709664047.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: d19e7da9-2853-4b95-49f7-08dc3ea20afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Cn3GAaclEM9rLCb0KB2BR/6pq4GoAw4VI7zEKRikeT6tQciBwROoLVKzU4cYtowjc8u88iQJepSbZT7oAMBxO9vakM0WOPtXxbwES/vBZ8FNxkKjVTK2Qg2SiiIzZVJlK6hmbpadvrufuYsFalWkVvxon7F2B7i68tEkQtoARz8kA0U9kSvWPn9zLE+I6Y3cOt4V/z/1aW1gT0RV863V6rbuWrUrN6UBHg283+nfLPV1HKfyPydyuCuzogT1bHSqUTp+veONYD6V+/53YzJwOnn2dotPlwbFK0zOODTo8CP1Xp9KoVxZtPbyTj1uWtKTK0zUaFv1VjWsHYco2+OAXea2780jO/5tgMepIrimgwRGI2MPHN3AKzG5ib5rGAcls3o7QznEI1RrYNDp2kridKEwgDojCJGVuvp5SR83Z+27uRj+Bl94HgKU1uYNxzzZItBJ1zL4tL5jrC6y9hndZnlFPxJZkQtWcbhpKoACYDDXS+lELHpS7Thc7IZ/MArskDp8m02+xz1NarRt+dliobrgydK4rjpv3RvB2AXFzq7G+5PacdG0XHcxnLBCHSy/2d9xqVRW+Bm9HxRWQ37j+MmRlLLZv+f91k2yuZjCdPAFJM2GI0/3DZfjf1/fLaseLLakyN4OoLk3WVKwmeFt33sNu8VnRsRU9xRM+hIMMgA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3hRUnhmZmhBa3MvSWJIR0pUUjZQZUhGSDByUHd3L1JIWXpEbzc3MldEbEw5?=
 =?utf-8?B?L1hBcGlYWWZ6SzlRR2hzMkJNOUdvR1BNbGdCWW5Bck84aXBCQ2RIZmZtcTJX?=
 =?utf-8?B?L1BxOWVSeHN4d3FIRWo2U3ZsZ1E2Q3VaUURQZVUzZU53d2ZTYmhsclI2OXRG?=
 =?utf-8?B?ZHhjSzRVYXluSk9leTVNTHloaDZBQkJjWW8vN1VvQXdJUHg3NkkwYkI5NVJa?=
 =?utf-8?B?anhuZlFMaFk3emRNd3VpVSt6c0gyUWFyZmZmMlNTK01OcDhKeWdJb3RaTmZJ?=
 =?utf-8?B?U1hxVlptY1hDNFo3QUw5aEdGRVJEWUU1c3NjU0xkU0ZXMEkrUmY1NTFEZGV3?=
 =?utf-8?B?a1hHUUhQZkxjMXZoUmp4UUE3UFRVQzVxNVV3WjVlRmZISTBQT0JVdXozUnJQ?=
 =?utf-8?B?aUJSNngwcTl3TVBpR08wQlF5Z2NkUURhTUNhNXpWNjljVWhmRDRkM29kU3pQ?=
 =?utf-8?B?eE5jL2VtT1ZVZkorcTgxRUtrVXkzSllzVndVNm9LMlU1WTJtSU5hVWt1MXdw?=
 =?utf-8?B?VFI4N2RkUlpNaXhiRGpUVGJZYjdiZ0dyRGs0UnpOdG5xRHJVY0QrdEkvZWZv?=
 =?utf-8?B?NmFSemk0eDd2WlFPRkl3WXFINGJkdHJWM3FlbkhGWWtFdHFYMGxhZWwrOUs5?=
 =?utf-8?B?VnBLSTZaNXNOK1FCdDhNVWFWVkJjUGdNOUIvOUsxLzBYVFRWT05ieHNldnZN?=
 =?utf-8?B?MEUxdVhkUGlJN0dMRCs4QXExS0dJcktxMHNEeHVJY3M4a0tCVi9CbzVuaklm?=
 =?utf-8?B?aUxtdUVjSGRiRzdVMEt0QnBNelo0aW5OdFdiYytheUFtWFFsTml5S1pkejRa?=
 =?utf-8?B?VVpxTlplRGM0am5hNVRlWTkvY0d0ODJCS2RlMjdLd1FEWG44eFYxZmdLZ1lx?=
 =?utf-8?B?OU8wTU15UlFuL2JnbnZpN3lCdDJybFFyNnhyWmh6c0ZlTGQwaHRKYzYwQVJh?=
 =?utf-8?B?Mk5HMjZFbk55K3JFK2RibXJGNmM0WGhOaFh3VWozMW9hWEYxbmwydy91akdS?=
 =?utf-8?B?S3ZOc0xZemd0UGlOMkpwbzVWcVlkVG5SY0RrTDFVSGprb3MreDB1cXZnaU85?=
 =?utf-8?B?d282d1BXQ1JQb0tySEg2Y29QeWx3MkE4eFlHeTZmL2ZFMHhrazBTSE5PUy9t?=
 =?utf-8?B?ck14VTVmaDFoQVBQalB0dUhyRUhkQXNUZnlnVDJobGphaEZnZ3hjK25WL2t5?=
 =?utf-8?B?bFF4RUZEdDhZekZ0dSsxNEh6YURRbS9wSkpBTW5jOFdFbWlvemFHUWJRTU1E?=
 =?utf-8?B?YTBHUCtmYUM3bTVqUVRlZ3ZidU1QcDk1SVoxNmJJWnVHQjMxUUZlQzRhWXJC?=
 =?utf-8?B?NCt4WUV0TGt4WS9oK3ptcGdRVE9HTzRtemliOVBXYm1ScExUQk9LTUs4aGh6?=
 =?utf-8?B?OTNDQktSVDlVSE1YRGNPei9PTmxSMDZFQ3J4b3FtakdMS29xN0NVN3pBSG1V?=
 =?utf-8?B?NWtPSHFmZWFnUEhVVWtiQ2RFSXF6aTlWVHdDUW14WHY2S1JBVHdsK3dzRTlB?=
 =?utf-8?B?TXBwcUtYNlYyNG1DNnp2eHZPeW5vNXhoUGVWVE4rbCtvL3hBTGhCbmMwMi9O?=
 =?utf-8?B?NWQvY3g1b2ZWVmx5MEJYQyt0dUxkUG5XYldoVUxndldRbkJaWFdFYSs2UG9P?=
 =?utf-8?B?cmRKUnoxQTA0bHFscFptY25qd0xMbTdkbEtsS01EYi9XcDdhdTRvOU01dEdy?=
 =?utf-8?B?VHB6dGRpYjdSQm9reFNWTTVVbXBhOXd1Qk1sR0VlRlN5dkNKTjhXOEJuam5r?=
 =?utf-8?B?UDVFalg4VEtxQVFGNHR2dzZkVUcyYklxaW5IbkRySCtxdTYwc0hyM1p2eVVB?=
 =?utf-8?B?dXhqYnBRcXRwS1VsRXJsQ1pSdG5tN2xkaWxmdVZQUk5OdmtVbEFmbXB2ZkNa?=
 =?utf-8?B?RDFIdExhV0ppeGp1dHMwSzBHQVAzUFhwdW9BOEVpbnBUWEN4NURYdWtNdFpP?=
 =?utf-8?B?Z2dQMnJTSUFaQzVqcXQ0SjRSYnR4RHcrZHhsOHorNnp0ajRjUWJFUjlZaWxL?=
 =?utf-8?B?V1J0K1AxWHplZXl0SGV1YkttdkdpT2RMeDNTcVdZYWpuWFJFc2E1RlZySk5O?=
 =?utf-8?B?V2ZsRUZuL1lydFlPMkRucHFQOG5MTFY1eWZ1K2xJb0dvUzhlNGYyQUxNaEla?=
 =?utf-8?Q?fpmVEeTwNzJupgJbgaMZLTf+u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	shpo8iURG/ulrNXRglbWK95ZPJuHo+6SMy5p8ZNny204avQuHrF+L20j/4tZFUaMknQbG1CjeNDX5nYfmxRn0a4VGW3/NqnHo1dRvkoKNLrP4ZSBqREHropvVo78eABXmopDolPUuj/xECbYU7iKTIZzdEposY2QP8vq+B8+2siKjAQdFfwwvhOEy+F7G+S2OzCnW8Y7Oi/lSKWwtpvpfqKdZ11YTXvWjOMAlWOhzumJTpGZjIcEJBxeVE8GuIUUisPmgdF5oJ9rBPFQb6rQH3hF5PP0e2ru8v/VF+W8JhDgdVEeHTNyEFTYNXXcFhvxOyQGZ+TU5FBpzh5BGNe2NTB/HjCc3P23h45p+2Bq3vE4W+gsA4glsG6hMUq8Ztlh4CM/C+yBGAMygvDWHJhhLXBhcJNtJ6ENFdkSXRsCjE4lWc7wVcarGoBNi5RYo8PySlOgDgDzQbaxWzv7U22RiUtqzaFbTwQXXjlpC56ZZICG2MVWlycMw/MHOpsCBqAW1de/VDq4CyDAjGMzAeIxEKmNab5KPcqxW4o9hWq/822TYH01cTPSO1o7LS8n9mQV1Y4P4bz/rA4zkFoW9R8LIlFH9fcIk3GD7WnuIWq58NA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19e7da9-2853-4b95-49f7-08dc3ea20afb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:28:07.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RitTkyOMKIa8TlccfBICp5mm9WzeKHJE0sbOw11Qex9DtK5BtD7VxIObM6DvaGFd3g1iveXd+IZi+JpE6yp0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-GUID: IDPYH-NRlKuPwSwDM6TodyhK9fNX5BUr
X-Proofpoint-ORIG-GUID: IDPYH-NRlKuPwSwDM6TodyhK9fNX5BUr


Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

for the whole series.

Staged for the PR

Thanks, Anand

On 3/6/24 00:21, David Sterba wrote:
> Hi,
> 
> I'm sending first batch of fixups on behalf of Josef.  I think most of
> them have been sent to fstests@ at some point.  They have been in our CI
> branch and consider them tested and working for our needs. All of them
> are btrfs-specific and will not affect other filesystems.  (The change
> in common/rc only moves a helper.) The last patch is a new test split
> from another one.
> 
> Josef Bacik (8):
>    btrfs/011: increase the runtime for replace cancel
>    btrfs/012: adjust how we populate the fs to convert
>    btrfs/131: don't run with subpage blocksizes
>    btrfs/213: make the test more reliable
>    btrfs/271: adjust failure condition
>    btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
>    btrfs/291: remove image file after teardown
>    btrfs/400: test normal qgroup operations in a compress friendly way
> 
>   check               |   6 ---
>   common/rc           |   5 +++
>   tests/btrfs/011     |   9 +++-
>   tests/btrfs/012     |  14 +++---
>   tests/btrfs/022     |  86 ++---------------------------------
>   tests/btrfs/131     |   4 ++
>   tests/btrfs/213     |  20 ++++-----
>   tests/btrfs/271     |  11 ++---
>   tests/btrfs/287     |   4 +-
>   tests/btrfs/287.out |   2 +-
>   tests/btrfs/291     |   2 +-
>   tests/btrfs/293     |   6 +--
>   tests/btrfs/293.out |   4 +-
>   tests/btrfs/400     | 107 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/400.out |   2 +
>   15 files changed, 161 insertions(+), 121 deletions(-)
>   create mode 100755 tests/btrfs/400
>   create mode 100644 tests/btrfs/400.out
> 


