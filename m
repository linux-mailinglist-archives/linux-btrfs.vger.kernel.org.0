Return-Path: <linux-btrfs+bounces-3336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3487DA6F
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF4DB213B1
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A051AAA5;
	Sat, 16 Mar 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gYRxdfwW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bvQ6y2WZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60D18E1D
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Mar 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710598421; cv=fail; b=PiaNFNCSnAXLwNIivUHayGxVm8Dbv6xWZbntqlc14Cnyngt4l/7ellAXzFScrPzOLKOm/luICnn3tchfSDAb2n/6/a77ktjcZ4LIsbH0ximGodHy7zF40UyqyzcJgnU6Fx3hDf3eXadvBFesISxZWOrrc1lK1M3UPUsw0vUq/W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710598421; c=relaxed/simple;
	bh=ldqSa4RSA4JOKvfkQFnMFtmQVkldf9AzP2e8gnEolzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ijoAuNYfYaL8TdxQb0NXJHWVL7RVkpXy8oEc1oSQbKO0WsbOTv45Spy3c7Wl3OkXyc1WxJXV+/u+SD3J94Y4cLIBbAIK1BEYrQn69mIpPdJlCO56pUicEjFflqBO3kzfdtZy+Je+dbAgQjOjKBxXj07t/xnvHjoZzZ6EB/caUyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gYRxdfwW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bvQ6y2WZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42G7q3RH026010;
	Sat, 16 Mar 2024 14:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=loiunZAvF2QTGbCvY9UP891C59kEGJ1TWGLOs2T2hLI=;
 b=gYRxdfwWgSr4tXqJjSQaeLqStT/QcN8lfK/oVrxD395mGlIBMig/xdGa6zdgyxrYsXat
 ZtkhynymkoOQSOapScNatM7x9Z/7qkxi36Lz8aKJ4WUczI/1QTBQ6Qdvu33wPAxYSdCF
 UM4bQ9KG8aaJR2kfDSINSNKEMHJ3YzrO7umP2XIbSAslzYUHsrLy2ik7kOyGQe+N9RKM
 cf6gqNAUQGcpzY2ngxiwPqrzf6F8VbCeuTB9xMnSW5r/wGthNtC8GMU2QTCcpRQnV2dI
 6ExCqvcj0WE5R8/Na1mZwYUOnjTmd6ys3x9XnAPQetqleu7aRPlr3y9K6JRzxgxl9tHO wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2110jwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 14:13:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42GDbPO2028730;
	Sat, 16 Mar 2024 14:13:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v35wkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 14:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oarm4q+ClP24iA+u6fkxoZjXEUhXUh4jwXpyFHFeoChImFK0aLrI+JH/vXf5Ifylh76h1rHVX1iVQcGZ2GrAolqWGXKY0I42sNV1xYoSIA+xI6upaIqqkKzzobHVXs8Nznz2caACQUS0trCLgK/SkOPNYO4cIltam5sD6NmHFp4wMZSGDbkubxOipKVl/TLfLMdpTCcLbPbgmAjgkiP2qEQoqoIApzIbXuy+y9k8iE+f637T25Ox9c2TVfo/VQaFFXdMkpPaVRE1SrD7nrozCsLIU/7+yOLVJi26zPCabNjFpuXEaa2//PvoSFzSHhrYs4Rq5eYOJ6AP2CV9f0phyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loiunZAvF2QTGbCvY9UP891C59kEGJ1TWGLOs2T2hLI=;
 b=LyMVUwaGyWI007p+1UXZI+GOi7zPwSz/oJ45IL5i1MxOtYtjXufxArxSC8DNreBr4LSbgwPergyv92TMMsWMZ6pWSbNuaNXM9CehQtjg+d2cAhdYVVVPBN0vJELYoYihhJfiL3kBDeJHTdFZJeKD/0uwFnV+icHTzWbiPmMH99VyyqXPr/JEPRKDh9ydrw6QysbwpO9wmvRuP6RATRJEtvxmvhl0y3c7VK0qKGgixWh/KgeDHemSNc8HAQKixZMYRB9IX5Wt9git/No+An/PzZcyfiF9VFmvssgNyj21eMa/eWUbB2MAoRVXgva8TCfdd6uLHht99VFir+iwpKhk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loiunZAvF2QTGbCvY9UP891C59kEGJ1TWGLOs2T2hLI=;
 b=bvQ6y2WZ4tgiqqJJJQoSVsU1Ot6lUHrsTITg1H49rrlvcnrrdiw7iOXHUAYZUzaC8l07HuT1mfSrVFt9arJaxoSFlGt3tMONt7TPECwPQy0tTzpHoSl8yYKT+FoLvOEs+MxsSKtqY/HpWsDHskVk/GlhSt4GUf6wbyn6UMV8P0Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sat, 16 Mar
 2024 14:13:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.022; Sat, 16 Mar 2024
 14:13:32 +0000
Message-ID: <718c4aaa-6891-49e6-a513-0bb0e3ec8036@oracle.com>
Date: Sat, 16 Mar 2024 19:43:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: validate device_list at scan for stray free
Content-Language: en-US
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1709991203.git.anand.jain@oracle.com>
 <87d75575e16637a84b82326d5c53cb78cdf9a7e0.1709991203.git.anand.jain@oracle.com>
 <20240314171158.GD3483638@zen.localdomain>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240314171158.GD3483638@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ee05f8-bbb6-4a3e-e7fd-08dc45c34304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4d091TarQl9PdjP+lwoWvXNzPNKvEKtc5RIbOf5R6TChf//HgS/zkJHmeJxIQMg1RfF5ZqtnqwIWPEBWhci1dmfRN672UDbsrR9EkzR3ZCa92J1rPMixuy0WKPa+NurnhyeD9uVEZ+1Lws8/7jV6jB7EDVzmX82M5THBBSDtVTIC8z7+LJmVu39Mv9wZU0GzkwdCwQ7oYqpHp3Y4u9LjBWkoDajahcyJnn2ELnwUbSl5/s7OQeirqLbFnN/nEJnphLJPlWnQYHmC7QX+LS2QM4T1MUdYE4aVPTpr4qysWG/S94Vp++ohHOk4DqOpv7uZEcdikq6cWW/ySYxyQCXKixI3AQJhpRO7Q06K5Ti3DX1HIPwai5O5886DjIF+1qGtJsHuv8uURRS484Mm5U2x0JZd/V592XWykS3Cj059CEuqu33XKrnK8LuJHAWo+7tWQa+ZyN/RpaFOXt8M1SpTWvuwltM9EJKNRBiRWOxB1gDeweuQxHdumBZAArHDlQkiKUwi2KOPf/zwsyOq8D3QYWhJ1vNDtPafTUVjuhawZjGU8Q/Ycbjmkf3+Nn5hYna017KgEt2GNiFb/Lx+f1MHpPnuF4k7NfpbiDeLiM7iSvpzcCgJlLirbEPVdhXU4Dsw55KGFNgmIMyyXuxMyd+sEHdSV+1GJ6sSgFVz4inQCWA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlVrNGozWlZweHFobW5NMWZ4cHhqbWF0b1h2Z1R2VlJQRU9EWThWT093M3R5?=
 =?utf-8?B?bWRWeDdXUGQzbHJvRE9LWTVHNlhONEJVQVplOHl2UkxtcE8zeFIzeDlEUS9K?=
 =?utf-8?B?aVo4aGFjZnpqMXFIajIxN1NHQWVrN0JScE05bzdDeXZsSzZ5ZUNNaW4rZXls?=
 =?utf-8?B?d2wveVBkVTZvajRMZVZQTVFMR0RPU3BhYkd3Znp6RXdVcWxkSU5hV2FqZ05B?=
 =?utf-8?B?dDNwS0VEajdwRjJZRzVkZlJUNEZab3NFUXFUVEhRSXBmNHNMK3puNStLYUpB?=
 =?utf-8?B?N1UweUQrUis3ejRvamsveVg2aDFVRGZZczdyK3oxVFgvVDF6aFdmUmFIcEtF?=
 =?utf-8?B?aGw4b0lUSTEwVDNhTk43ZDVPeUNYRGo4ekhYVXVxVVgwdzRIWEFvYTBDbW42?=
 =?utf-8?B?ZFVCZG9jRXJGOEx6M0NyVC9ldVY4UGFxN1lJbXVKOU9IQUlQVngyemhZanNQ?=
 =?utf-8?B?U3RUQ3phNms2WjV1OWJEYklGMUZBVVN6MllSZU1DbGtva2V5T3F6Rm8wV2Q4?=
 =?utf-8?B?K3dla29rVVNVajRha2xaU2wvUTE0Sm95T2hpTWdNY1REQ2RuaUlwMlE1ZEpz?=
 =?utf-8?B?amRGS2dIeHBMN2w4WmllOWhmZENrNjk0cHdtbDhvNVBhTjFtUmducnM4aFBQ?=
 =?utf-8?B?NDVsdWlJcnNzc0hsdVpwNVZ2V2dYOERncU5ZMHl5WGUvU2E4K1lkeWJEL1Rr?=
 =?utf-8?B?TCtCdFJUVVJPYldGWGUrQm45NE90aG9IbmEraVVud3MrRGtMdEltL3VsVVpM?=
 =?utf-8?B?dXJBRjhjYUhoNURWcnZzVWhkMHd1SFB4b2ZtZWhQL01FcllJQ0NPWjQ3Uk9X?=
 =?utf-8?B?MkdEUWJJaWNJQjZPc0hldTVKU05lWU9uVkVYeEsyQ29mSnFjOG5ESmpyS08x?=
 =?utf-8?B?b3cxcXI2b2d4SCt4RDBoY25DK1RXUUxuUTRyN25tZWd6R2VtUFRZSnRmODdY?=
 =?utf-8?B?bkZoeEkxdGpMSm42QllLU3JidzZGU280Zm5MUnZOWVh0bm1Rd011SElYR0hU?=
 =?utf-8?B?aDRmb2c0ZU9SSE00UFdiNXZnZDk5NEJJQ3cxUXBGM3V2MkFzU2dVcXpVTUhV?=
 =?utf-8?B?QjJtNGNUU3phbU5EQ2dZcVVZenF1aFlBUVRBclJuYUVFMU43NFhxSTkxMS8x?=
 =?utf-8?B?azZ6eGlFMWdGWkxVYU5CeG94THg5Y043bm16RmpWTW5zdjhXQ0FmN3pCZENS?=
 =?utf-8?B?cTJHSm9DYVZxWnpuTVJFbmE5K2lQMExLL3o4Mm5NL2x6YXB0UXQ2MW9nZFR4?=
 =?utf-8?B?dExBYXpEaGlDU0VUaXlNa01YVytpWm1adzNnSnRXVXliUHk0a2RyVXVOWUlj?=
 =?utf-8?B?QlVxbWxRYVFGQ3ZNa1VaTmFGaWJaWldpUWcrMHZHcVU3UkVCR1h2dzZCVG4w?=
 =?utf-8?B?Z20zaG5Cc0NLNHBvbHFqOElycFZObDhrWkpyVkQxeE54TVQwR0NyN2tleHZ3?=
 =?utf-8?B?L1A5ZDI0QVNsaGxSU2VYbXh0TGFYdndqU1NNRERIM3hZK3VtenI3alVEUnAr?=
 =?utf-8?B?Sk5IcXBMd05DVkdOVUZ0Y2xDOUdPR0d1RWcvOG5US29YWFQ5UDNFK1NObmZq?=
 =?utf-8?B?OHJpU0lwVUR3Uzg5dkRTRks1dEJEVUgzK3AvdFdIZ2FwRmsrU2JPZ3hPMk4x?=
 =?utf-8?B?a2dXVHlYanZUcFBCNDFKUkZsWXp5UWpXNXpQVFB5SnJhZjFmOE1WVWNQbThO?=
 =?utf-8?B?eXVoeE1DUlNCMW81K21WTCtwWklXd3FqVmtGR2p2MlRNc1VJNVByOFhqVHhr?=
 =?utf-8?B?Y241bXkweVROcWxYSkZHL0dadVpqMkQxZi9veGxnNm1RK1prSVh4TGNVaWVS?=
 =?utf-8?B?cFNOMENWd0tpUXF3Tng3cFYrOUFxdmt3NE5QSE5hdERNR05HdC9mSm1BTW1B?=
 =?utf-8?B?YnRFWGxyR2NwUG51ZFVVQm9BeVd5WXVjV3k4eXJlcUdIN3QvWFZEZ3NNbTl5?=
 =?utf-8?B?b0ZGRXdOWEx4VkJSKzdtbHBRR2RsK0hFNG1WOHhyMmJQOGNTN3A3ZjNNV1d1?=
 =?utf-8?B?OEdSSWZQN0JyTmdRNmwyUVFlZVNnZmR1Z3pQUjNiZVpYb0ZTSVFKYUNxZFZX?=
 =?utf-8?B?c2R0V1hCUEhRVU13c01kWmVhNFM1TjRoaTNjeGRVTmRMVXBpREpDMVl0Sklk?=
 =?utf-8?Q?PKRiAkDv6/E5fU9DrfB3fG8Fw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aKdwpjG9lWhliDnErnwkJgMJkqa2okZfxNB7gZnMgCrCvs5oobGNIdHFECSnmP+oGYkR98pphpwpGEfZVVt1c96cs1uz/OCC7Mh+3SS+P65gd9d5nEpthYwouRp010+ltlJ5gMbVSuVTXS6MsK5luYuDYJcnxKaMR8MJQW2GplDSLRZnnHahy6BbuDfEZZY0NSH0aw42TUGKeYwJRl704nJHE/QwW1e9edDiBrrYRK4Vzd6qG1Lg3SeJMdYY7l+ThmndPCDmJEX1kGqHUH7qEW7uUiH3+B2hW3u+7k1uW5l6u7X386GW5xQ0c/vcHHyl5jdw6iEGcIh8Bcx7j7KLVGIzn7kiIcZ5qjs/4rrS1ATEFI7jPF8Kzz2n1IGJpvMkEZ09ncb+KQHTB5U8V+WeWeITmsrz2y9PkvWEyTC1fYKMq2Dx5aZPw9BtHj279uLKo7X1/6C4dLxhleO/cvgLkdZjjWAFV+pauHe4PeVG/sojaKN5wusiWBruZWPVvPVO8u9wwg2Z5pqNfipgbTNAVZ1xL4gnSZl32gyPDI9wA2E7rlIT3KT3edl9ICxV4feylzvx0AX8GpqpCc1t+m4AfCz+4lt70oHC9Q6f5BZ2iyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ee05f8-bbb6-4a3e-e7fd-08dc45c34304
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 14:13:32.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnECTGD2dflgl+xzmKIVc+BG4EgcUz3A8PDv4gLyzt6qAy7JUGYrge/bmkk2UYXAuxV0d258IxYQ540oHlaDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-16_13,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160112
X-Proofpoint-GUID: mlsgdfYxHu3OOvIqOaLguHgdmtQeSffa
X-Proofpoint-ORIG-GUID: mlsgdfYxHu3OOvIqOaLguHgdmtQeSffa

On 3/14/24 22:41, Boris Burkov wrote:
> On Sat, Mar 09, 2024 at 07:14:31PM +0530, Anand Jain wrote:
>> Tempfsid assumes all registered single devices in the fs_devicies list are
>> to be mounted; otherwise, they won't be in the btrfs_device list.
>>
>> We recently fixed a related bug caused by leaving failed-open device in
>> the list. This triggered tempfsid activation upon subsequent mounts of the
>> same fsid wrongly.
>>
>> To prevent this, scan the entire device list at mount for any stray
>> device and free them in btrfs_scan_one_device().
> 
> Is this an additional precaution on top of maintaining an invariant on
> every umount/failed mount that we have freed stale devices of single
> device fs-es? Or is it fundamentally impossible for us to enforce that
> invariant?
> 

Hmm. That's the ultimate goal: maintaining such an invariant. However,
there are bugs. So, this is the place where we can detect whether we
are successful. If we aren't, then we can work around it by freeing
the stale device and avoiding bad consequences.
I think I should also include a warning message when we detect and
free, so that it can be reviewed for the proper fix.
Does that seem reasonable?

> It feels like overkill to hack up free_stale_devices in this way,
> compared to just ensuring that we manage cleaning up single devices
> fs-es correctly when we are in a cleanup context. If this is practically
> the best way to ensure we don't get caught with our pants down by a
> random stale device, then I suppose it's fine.
> 
> A total aside I just thought of:
> I think it might also make sense to consider adding logic to look for
> single device fs-es with a device->bdev that is stale from the block
> layer's perspective, and somehow marking those in a way that tempfsid
> cares about. 


How would we know if the block layer considers a certain device's
block device (device->bdev) as stale?

If you mention a Write IO failure, we already put the filesystem
in read-only mode if that happens. But, we can't close the device
due to the pending write. (Some operating systems have an option
to call panic, which dumps the memory to the coredump device and
reboots.).

> That would help with things that like that case where we
> delete the block dev out from under a mounted fs and mount it a second
> time with tempfsid after it's recreated. Not a huge deal, as we've
> already discussed, though.

Yeah, thanks for brainstorming. Basically, we need a way to distinguish 
between the same physical-device with multiple nodes and different 
physical-devices with the same filesystem.

Thanks, Anand

> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 60d848392cd0..bb0857cfbef2 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1382,6 +1382,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>   
>>   	lockdep_assert_held(&uuid_mutex);
>>   
>> +	btrfs_free_stale_devices(0, NULL, true);
>> +
>>   	/*
>>   	 * we would like to check all the supers, but that would make
>>   	 * a btrfs mount succeed after a mkfs from a different FS.
>> -- 
>> 2.38.1
>>


