Return-Path: <linux-btrfs+bounces-2850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F8786AB6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 10:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B572830D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC632C92;
	Wed, 28 Feb 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nj/KcaA2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MYZfzPZF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06773770C;
	Wed, 28 Feb 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112997; cv=fail; b=JKdJx3JQj6WbMfrvF/jU8JhYwTW87cj6C02VusQWxc3jn2E2GbNhMK7EIDFQ/PxYJ5bVmx6ww/fr1sAOVVQcbVfKP6RE4r13W1Dv4PDDL1R/qfxRQtcDirX+xtPyevgIqLauORNu0GHikDuoyQnVKfJUsZ5KZHdw1W1IyZHlHaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112997; c=relaxed/simple;
	bh=/dLLCN7wIoFn8C82pfkukpxPILwPzYlrpXN8OkHTVaw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmtJRO8zjsFG+JV6nFnO5o6wv7jJU9uJW/k15urDP3q/hPVjNefCZRRmZ4IcEXQ+eSMudeLewB2iSN2ud+WSEnoSTUhNv9ghpOaqj2xBOoyQ2R54SYswjl8UjEVvWkaCNoL/7XW6x18BXSfZJFoBYPamCzQotFzNKZKRV4sRf/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nj/KcaA2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MYZfzPZF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S6irpj010251;
	Wed, 28 Feb 2024 09:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=k//5H0+HTYLPORY9UPDesT0yaGPmlxazwiCFgInjoo8=;
 b=nj/KcaA2TvwmdEfX1kXKSeTGCCLfacnhavNJETsdcgy0s2IWgQZ8WZDFxJku1iK9fDkr
 eLJdCOQvth32LvyzpuR4GaVxBL/vTF9CKq+sA786aReRUJE4OCTqOVruTAp3dWTsFj3h
 ivsFxZ0Dpxa9sU6joRyfWoaf39PuC6EeqJUL2etOZf8xyKef0vUA9GV6TdrJhyBuXkA/
 axHkOtWQnznk1ds6miF366t2dhfRoJ6zxKaci35MATGOAoUOK/c0j/rUFOm75C0JBBtU
 CBzayCqKqp6GRCWgDBPkOAQUicb5rgaNitJkFGPEMAfAxJ3pTEUJAvHbyqJe9M9VF2K7 iA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb9n5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 09:36:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41S98nBv001674;
	Wed, 28 Feb 2024 09:36:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w8n40a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 09:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvvH+gQa+hz54JFuDwAma4Ulqda8qE683HWIqnB0+i0S+kM6XeGe0ivZEFLs5nZXNdGRyz6SyHY9bMUfXdYnCaFIuUPDaiCNSMUOrn0dK411gqtKnNEWNm7c3MFh6oQdRAq/jgxEYtq4OnHFLyf2dQd+G7KgCGR6Xqw60fXHA3D8XQE94xmbzSQm87GQqHyoYqBwB9BkOES9qmiiaHE+QhimMnQiyICUDKKzXnAt3UmvafT7d2xUVxetGQjVBq0yYpYPg5Uag+3WiiL++4PFFJIv28nAwjhSJ2MF3/qCExyfwNnAvw1kiGzry64KC0qfxOwymTxczy/ZejrCSlaPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k//5H0+HTYLPORY9UPDesT0yaGPmlxazwiCFgInjoo8=;
 b=KC2UzKXmet8uL4768y4HHX3hrB91y19a1YL0G2P9LML29VLW4n9tJVtTMG3+OK7YcRDgI3PKHI+l5C8MPT7WaB3w4LiheLvWuNGsNeExXCcqx/LXgTuY1bbFkYp8Tko0PT9naJB+TuJl6aLquKq259MKvBfuhtbvRkYxId4X5DQD0PdvItOHOT7YsxPz7HjnfJT9hZXv1hJZyJHxrIy6VLcUYvoIrcBEWIeJvg/e3tIw5ZeQTyoEcBeKW+hpv0SuIX07+hzkFz1bR68iszOklMGZr9gE7onmDWgxoxyWziSHJ3+MbAfRbea98785EGkPTKc6TNP1daFEio55ogpThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k//5H0+HTYLPORY9UPDesT0yaGPmlxazwiCFgInjoo8=;
 b=MYZfzPZF76mDQ1Lnh+qJJwvkF7zLf6qrrwjpeWVuyvipYXxDzX1AwOudwIkAe56tDFkjjcQK0YqD/hKmTmMlRcYKceiWKBV/LAzuhcCn/pfbk5r9/O2CxWKipSWEaMSu6+ro7TGkqv+SLsHkUdWxcNidH1MypDnqAzTK5UstLuo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6893.namprd10.prod.outlook.com (2603:10b6:8:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 09:36:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 09:36:29 +0000
Message-ID: <e4416120-e682-4a43-b79e-a930838bb64e@oracle.com>
Date: Wed, 28 Feb 2024 15:06:22 +0530
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 03/10] btrfs: create a helper function, check_fsid(),
 to verify the tempfsid
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1708772619.git.anand.jain@oracle.com>
 <3fe54b69910e811ad63b2f0e37bd806e28752e8a.1708772619.git.anand.jain@oracle.com>
 <CAL3q7H4EdcvJm4jAD+5-zm-WVAoaHhyy-9Q_1-P5pOWk_f6m=w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL3q7H4EdcvJm4jAD+5-zm-WVAoaHhyy-9Q_1-P5pOWk_f6m=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a448d3c-9dd4-4c83-aa57-08dc3840bd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zwrKyqq0paGKh8huPbENe+KXSoirQ4cLZffru290vndSQZb4QVfGSFMJ80O352d7IQNXvuadpI3TBKpux0FWqWwaRWddqdJNjfXodtICmv6eIG6lqW1y3b4l6Coac6xog2Z2U5rQnIjw0hr0Ak+rdxe0i1XzuL/vIQdiCKnxUUPvgymrl6wqUstIM0E39rRdREYW6ykw7rnvElQC4R4LnGqxnKf6eN9RRLi5AJ489tbI9nnV/GAEVyXr1tX/rLeBQYdxdFPiNL+JrvVhJulrctWsSLkCFFMoE8pQQW6H05N0Tq663YEol3UUFBii2Rhrn5o58YNrfFpYvwzDpV4KuaoKkDgpARM0UumGY5ha5HX2bv/weqqNz6xrjhh3VeKWDILCszcVlQQ5simZZjex3XfuZ47CND0a7EPLmXzhLbs9sejpF+edb0/FUkw734A6uEphfHJMkJVbfxhF43DjOR6diO4xsM8IG75Tec9hUsdS5uV+5Yn5IOJpIkPjNdEVg1Kj3BA9fRBPfnUVpc0bNggBhcsNYXTvPJTIM+ORwzveH9SuNjwSlacFrHJsr1Wc7uqX6X4Cp+wq9/bVCec0zSOgdRJM/jq1kgks30LhDxpm1GtJfeDU9tEkoSzevouegmQ2jPSCx992LUu0rSbTeA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjFNa2E0MHY2UDMrNkd2eENPN3BuWHhyS1R5WE5ib0xjR245OExGODFCaGMx?=
 =?utf-8?B?RnpBWFl6blZRVjhDOGtVK3A5RmdkbGJobHoyT3hyNVlTbCs2akt0L2hmNXNL?=
 =?utf-8?B?azFIUGhpQ2d6d2drUlNBS2svQy9temNpZE1nTmVWM1U4NnhFQ0JJdGdpWjNW?=
 =?utf-8?B?bWE3N1lUWGVocWRNNDBhMWJRdVVWN0JWMEdzdTFDbHUyMDIzd2NkR1FyWVZP?=
 =?utf-8?B?Vi80dTNkSGlKNnlJeWtZMjZ5VU9Oc3RCdWEyL2dXM1FlenlFRWlCaGVJWHRX?=
 =?utf-8?B?eHlxTE4xZkJ1dGZZZk0xV04rcEMyaVFIT2tRT05aNmNrcXFML2ZxSzVRc2dp?=
 =?utf-8?B?bkcxdS9VZW1GbFFaa3ZZa1dJVzE3SlE4dmliM2Z2RlFySmZGa0tlbTJIZFgx?=
 =?utf-8?B?dUhuclBQakFQRnhRRVhqWjEvZjZYU1FpOE4relNhQk0zTG9UbXpua2UvVnk3?=
 =?utf-8?B?Q2s4WnN5aXZ5Y1VKYTZFdzd3QWI3N3F2UU1JUk5UZG1uVXdLaUNhUHdUeGZq?=
 =?utf-8?B?SEJnNFlpNThYdmVsUTRGejVMNjJ3cnZKTFpLV281RzJhZmF6ZGhYUWd0RmtQ?=
 =?utf-8?B?K3VZaU5kNGovbENlV2F2eWZtVnZVRHRZQnFaaCtBSFU4eXc0dTNCZ2ZpVEF3?=
 =?utf-8?B?RXpLY055STJSZjVVbHYxM0dyUW00emphRjhIR2k2U2xmTkdEdk1kd1pNMVE1?=
 =?utf-8?B?NDVBZGcrOWNBejNPT3d1ZC9STndWMy8yWDdkZktpNnpzYVhhdnEySSsyckQx?=
 =?utf-8?B?MHJSRFh0YnlHWXdEWGF2em1GVHZwOFhsNVlIWExBRUZlNTBSOGVpREx6NzFV?=
 =?utf-8?B?YmRob2d3ZDdoSTRyMkNBUGVJQWNJK3BxQTY2MXNWM0dyU0dmOHlJaWVNL09z?=
 =?utf-8?B?YnVjYUtlWWVMMk5DeUtsZmEydHNMUU4xT3haMFlhWEs1T3RVaFcyVDVnT1pr?=
 =?utf-8?B?VHUwSDZoL2VrWXp5ZGtJbEE3bnBDVnZOMmd0L3hGc1pKSHhLRFRManl2d00r?=
 =?utf-8?B?aHg3WVZsc2JlNEdQSE83NC95MlFqSy9icy9VeUJNYlRUR0pXdTgxM0ZTeWJE?=
 =?utf-8?B?cGRpT3c5TFY4eG4yaW9qVDJQTU1NL0JNNExHMmJqbHQwVTMzZGlkN09XR1Jw?=
 =?utf-8?B?TUcyelpxSmhqdXFScFF6V041S1J5dWVnVTVNY2N0eDdlbUgzcVZWUFFpNjUr?=
 =?utf-8?B?dkljc1NCeWh3YUMveXZta0QyeGVOUGdOd2RVUGI5OTN6d3lOdW1qbGRGdFFQ?=
 =?utf-8?B?SlVnSkVVWmtSUkZXeG1qb3R0azlZOHIrUFpydjQ5Y3pSQlF1Ti95aThRaUFj?=
 =?utf-8?B?eW04OCt4V1JnZFhxaWVwdDJIRWtmVEthU0VXUWVTdXJDRkc2aU1kUGpncStO?=
 =?utf-8?B?K2Qrdk15R2dnY2lCSFBtMnhpNEFLUlFvdDhtMisxUGlWWVhsM3hJVHpFa2JS?=
 =?utf-8?B?U0dEenhYMm12dGoxMU8wSEtrV0VIT1FUZnA3alNRbmRLQmE3THp1TUZPekZp?=
 =?utf-8?B?aVo4YUVOcjdYSk9yMFVkOFVRdDV3Vi9WZU9pTURNWmdUekpFWTFMbFVqU2hF?=
 =?utf-8?B?SUVXUFIycWJxUHZhZUVHdU00OG0zNlBsZXZyN0ZGUldBNFRpTmJkYVBoOTVy?=
 =?utf-8?B?OC9rMVFodmpJZWhPc2w0bExRazlGaFU0VlgxNTV6eXA0MWhtTlVLamdpYjZ1?=
 =?utf-8?B?ZXl6RGpxL3ltU2Rpa2NHYnF4RzR2dTR4dFhaVWZaUHFEOXBVc3c0b0Y2VTZL?=
 =?utf-8?B?ZGd3d1J5bm16c0poK1RKZmF1SUdtNlBLTDZzTXRkZTJUc3E0VFRzN1pjeXVm?=
 =?utf-8?B?QjlyQzVsbDVHcGxiSWV3NHRSWFlmRGU2VW05QW5EWDE1b2ppTmZybFZGeGhR?=
 =?utf-8?B?NkJUU09EUTJKdFhLWEE5ZzJrY203VUN2T2g0d3FIblYxbE1mYjBoY3pmN1A5?=
 =?utf-8?B?Q0NocmZsajB0V2RNSDBXU0s0bkhJWFhGZ0dGR2hEa0xhdk5qRWl0bmJRYmpt?=
 =?utf-8?B?NHZoakN5d0tTc2hZN0VFQzVwMGFqTUw4MS9pQWZUc0w0QW83dXFhd3AwU2lv?=
 =?utf-8?B?ME5mbmJrcFJsdU5NVzRxcDFqdWFvcE02Z3dmMzg0ZjhNbUFnbFpTRjlKa2tu?=
 =?utf-8?Q?uFGmTfe6NE21mlmSacdFNZWRX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BASTr4lo5NMZ13DU3f6vjrcs/pO/FOzsNUnGaDoBVxZZsWN4ZCQ8UxsDDB49DhrlNzLQnkYNmLbsLyukrGoZUaHITuRJFiW+gta3eG2aEUWGiGS/daV4f0F3Orym+VQc4vCyDMdRoOfmozGoRkt0450un0cI1YG6FxXvxtcdBSZon+jTKy+c2g4NK+0AwAMTJ8zbu8XsfAWRRKdqoXhVDj+i1DDxuzWIEOH1bGPigTCxmFqVhNe9gQX23mUYAKGfZz6smTui6doeiCcJ/UKQ9+HYL3y51iz0nIdOS8tijSYv1iyr0KvwxJmIe+Qk99efWb4qC2aWzemlU5VQqWzAhv3C2TkhOav1Sf8rsaIcFdInKiWVRDU8pKn47O8+uCMgleWgp4NGyqzBqq87o/C6vMJMQMXhqd5FSC9L0llKeB5i61U2iH61dskbmi9e/bXX9Fj1UnyXTxA8Vyt9H7e7zpI2Vr2WjNmTnIGBWD6xw7r1E7nyUVtkGqE+xZYurDhbWULDr2r0jUGoMbg/KMUfFJDk4YssKKvCmsyX8xTpvWV2pCZgBWZExo1f1iKDlDEXAANqw7Rc+PFoYGajhiVXDyXCHeFfGDPHCpOsLnPOnm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a448d3c-9dd4-4c83-aa57-08dc3840bd93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:36:29.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3xtTTkuOftsfiEHT8ZhVq00dAhvIIsWyJ44d/Eah9ksr1QAml0sYr51p8wsoXN0UPw/aRIssG8JJSYe/WQMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280075
X-Proofpoint-GUID: 4KT2fn45clYODAceHDnlmFchZ0fx-FAK
X-Proofpoint-ORIG-GUID: 4KT2fn45clYODAceHDnlmFchZ0fx-FAK



> function should do the require for everything it needs that may not be
> available.
> It's doing for the inspect-internal command, but it's missing a:
> 
> _require_btrfs_sysfs_fsid


Yes, it did. Actually, check_fsid() would need the following to
cover all the prerequisites.

  _require_btrfs_fs_sysfs
  _require_btrfs_fs_feature temp_fsid
  _require_btrfs_fs_feature metadata_uuid
  _require_btrfs_command inspect-internal dump-super


I already have v4 with what you just suggested, I am going to send it.


 > Instead this is being called for every test case that calls this new
 > helper function, when those requirements should be hidden from the
 > tests themselves.

However, I am a bit skeptical if we should move all prerequisites to
the helpers or only some major prerequisites.

Because returning _notrun() in the middle of the testcase is something
I am not sure is better than at the beginning of the testcase (I do not
have a specific example where it is not a good idea, though).

And, theoretically, figuring out if the test case would run/_notrun()
will be complicated.

Next, we shall end up checking the _require..() multiple times in
a test case, though one time is enough (the test cases 311, 312,
313 call check_fsid() two times).

Furthermore, it will inconsistent, as a lot of command wraps are
already missing such a requirement; I'm not sure if we shall ever
achieve consistency across fstests (For example: _cp_reflink()
missing _require_cp_reflink).

Lastly, if there are duplicating prerequisites across the helper
functions, then we call _require..() many more times (for example:
313 will call mkfs_clone() and check_fsid() two times, which
means we would verify the following three times in a testcase.

  _require_btrfs_fs_feature metadata_uuid
  _require_btrfs_command inspect-internal dump-super


So, how about prerequisites of the newer functions as comments
above the function to be copied into the test case?

Thanks, Anand

