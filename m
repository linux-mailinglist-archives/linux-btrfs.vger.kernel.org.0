Return-Path: <linux-btrfs+bounces-2520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CCD85A47F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 14:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE622281B2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0E336126;
	Mon, 19 Feb 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kc6jpeVz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MM/ofB8f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B6F9F7;
	Mon, 19 Feb 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348706; cv=fail; b=I8InPuYXC2gfwOUYGK9F4G9ocahYFuYwATmKAuZqrqm2wgW+jEmiH2noYbYh/Hx0D1lUheVMe6/fhV4mgNyqLMQC0uSRxdMPXNiWxVJNX5tjMQ9IESh26D1brYJ0MRk0EfH0wckiaJ/pzHKIGaITr5Of00ErYwzPsx1AqWlzEMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348706; c=relaxed/simple;
	bh=RmpI9gh7ZjVbpohv276+4Zi7eOn2bw8sHd2bb44MeIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bkTmXiikTujVTK8/U0xSNLtfOBk6pz57S4doMYr/hzQ2BFm1soM5qPrWPpgjqudc6kI/1tyPnx8accX84e5lybR9uFlSxjlz/YX2QB11sGneLA0oDIGUWfg5ywikU7KR4O9UD9lKc4HgVuiYhg0yQsXNE5G9DagnhhIgoYNBz/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kc6jpeVz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MM/ofB8f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OIg6005582;
	Mon, 19 Feb 2024 13:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lsm0QYEnPCNeyot1dyXCTLu8Sxnf++Fb+0JNZ6hqOJI=;
 b=kc6jpeVz01JPT37ui/1nGSi+wzu9qfWewWr6PBTWj730cUXK+/+yHOCs4g0VfVn4fR0g
 8aY8puZFrH9JyObfk9+MlB2h4usJmlPx9hdRss2a+KITh1ufG+Z1zTHIUCjjG9N1Wy/w
 KMDVhVAqg4IfzTzPJL3NUu9JLrUgGpHMkCQgJDBrTznyPVPJw4knB8tvGweIxK2u/4lR
 LoCvnl6UX35HK5j0uhCymnpMMNpn+N8l7A/Auc6rqkdKnY/XGKRkau8Ya7koczfLJ0Ia
 MxYUAbNJJnZSF4zMEyPiTeM3AcDHLGQpDU0UBDEIYvDu3k01s0XlNb3eHLYTzvPGLBvg Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc45af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:18:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCP88j039807;
	Mon, 19 Feb 2024 13:18:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85wsxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTsabjnRHJ2RhtTVYkULODlIHEwDLLR4RU4ashTmD0pGrtk0x37Te1c9A6FkdDCq2s+YlXh7ikWUp/ZHtZCuQANy56ksrxaK88O2AwMGvPI8Pc9wI/01pF+O4R0oDPuTPreH8VGeTM163QbP6+olChyaacLtypjBD1ptDB67JUJIJXM44cvdScavkx9EcY5YcJVOt0SH8qZxOqJSZxk3MQAvta+S3mvuba/8ePc9XEtEGWfrnEkeXyrvxR2bbjbQLOxi4exjSXRbY85413EBRQYb+X1GfAcIL9o6hRFI705Ak/FCyRz66EnRV3EG/4OdbWIe8rb/KEoWb8A9xj9mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsm0QYEnPCNeyot1dyXCTLu8Sxnf++Fb+0JNZ6hqOJI=;
 b=etXpUpsk24iwjb6T3u2Jzt9MQUx5YUEPCjdp4GZftFQ0hHjtSMsjuSfpuV46JexCgK+ZTwyLp4zTWlbHa7JSJCl8zgJ9q+2fG/PffSRCBBir+BxFJJ1GQ4nxx8ozby+SuWSqPyDdmqzVYoxguaw+5ab6taCiAf0nnQ3YFYZEiLTNV4670onZmpm1Pj5hJUD1wI83iBEcRj7aAdcg3lBvZeiouAeCA0Y/ldwWpBMgABLL9jc+KNZ4zNjp3QhJ/i9YZAvenk02NCwULLx/5pkEXEuDVWSqFKRm3wsnAZh2ZGgeH45xyYu8UL1nd5N7DkdPKUR9nKRjeVphQVeTOGZFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsm0QYEnPCNeyot1dyXCTLu8Sxnf++Fb+0JNZ6hqOJI=;
 b=MM/ofB8fZi8H3STT1U7+VW1roGFxZQDDDY2o9I0P76U0WNutlTMkqv4nOJ1XSplQ8vUPuFd1VVmjos9X+NOv3tRB4Pd050bQF/lEFrs/pk9FeCsB5giEHjCsW5Ro8dwIMriM4o3Bgj7GK7DTRZuNAvx2d37XD5McTwtPNqNXPno=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5882.namprd10.prod.outlook.com (2603:10b6:303:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 13:18:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 13:18:10 +0000
Message-ID: <c754b3c6-040c-44bd-9e50-ce95f4c4c4c7@oracle.com>
Date: Mon, 19 Feb 2024 18:48:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] btrfs: test tempfsid with device add, seed, and
 balance
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707969354.git.anand.jain@oracle.com>
 <325a9476e06cebee3752d32fd06e75b2f478b8bc.1707969354.git.anand.jain@oracle.com>
 <CAL3q7H77SEYPongbHn9auS7jyvOetD-8gD3oyQ3e+7pJuPVbSQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H77SEYPongbHn9auS7jyvOetD-8gD3oyQ3e+7pJuPVbSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b396a8-33ab-41d5-d796-08dc314d3823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	A9obWeonDMxQrlABqUFJO9EeUAMfjYp6qsfU+Pn8r3HjWfioK+90G8+AFHrL/k+PO2lmy7UDKKHvzV6IhuMFCu3j2xACrtvVwI4A/HnjifnxMxZyrGV0K9SW/A0elItaBfB/8pwCk+WBgyID+S4AHneYQzAm6b7UhlLkKHkp/zQkj8DuBeDPOvLQuvsGNLoR3fY8WMl1Dk0exdBdhubHDUq3wUkHcnfRv1ijXQWvTRQhkZ2hQiEpfvu4ApNtTX94RnN9cnsIu1gQbB9LFdE0UYVJSI6tcKPi1UlQykYPocEoQ+wJ/G8tsvi4i56Y7qPVIqWbMhoLjP5AjVlet2nN+qDwl8d2hi6NUkiPt6zor4+FX28fdN+0qz3wi5ZPfYnKRz+AphHcoGQo64TR3kEcdAly7bpCL1vtMSm5Ps9dQLrHYNH6oOzdQoyHdfzTw9bc//AHoWpVeisseG0yO2bZbv+Em8x+cyQZoYcrWEgHQK4zbjCn0znTAjLqy6AQTaWRkuSydUyjENdvMJ/6O7zlLG7SMwXV4+9Mveq6bhTGVGIzRFrk6jVzr8x9xtE9Bm6j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjUxUStDNFNhdXNZb24vUDY4TjZQNEhKNjVTeVNEL2Jndzc1THBNTjdpT0hI?=
 =?utf-8?B?U1lxVzFXR3ozWDhFYnhCMzY1L1hMVUUvS3RXUnhJM2dMZG1hQ25KSWZUends?=
 =?utf-8?B?YldNeU51bEF0aC81VmxSUUlLQWRGUUtpYWh5cXgvNmZNVzlzS09uaEViMHRz?=
 =?utf-8?B?VWFQOGljRnhCUmZNN0kwNW0rZEtiS2NsWkIxd0NiRTRDTkJMUlZYTjVnYmlq?=
 =?utf-8?B?N09ZRTFIZURYWHRjd2U1QzVSSjZZZ2QvRVhESWdETlR0eWloOVNaT25kN09C?=
 =?utf-8?B?R1NCeHYyZ3plREU3NzBqaytkQ0NWQzhvYmpSSmN5QU1NMU05Q2NnN2dwdnI5?=
 =?utf-8?B?cDZ5WTZ2NW8xT1Rpb2lQVVpzb05RNGhGc3dxOStCcUtia21yQXVoeHpIVlVM?=
 =?utf-8?B?bUtVRDNKTk5sZTNpQncvK3NZU1ZCRy9ScGc5WnBrbHZJa1NFRVpQd2hGUnBl?=
 =?utf-8?B?ZWxCWDdlb0JIK3JaQ280d2M4SHk5VGc4eU5zbVRxK0xvYWJqdlZqK1FUYTla?=
 =?utf-8?B?RXZpdnBqNUZta1RlMDlpTWU1ZUtZMXpyVm9ZUnVscXFLQ3E3YzVGbC9aY1ZL?=
 =?utf-8?B?TVB4MTcyOTR6VWtEQnZ1Y0ZRc3VON2JsQ2s4ZkZaTjNvUlFJRGRhWlhpZVVB?=
 =?utf-8?B?TGdhWk5vNjg1VHNvdHRJbmJlcGw3bFJXeGJQckIzUmVuY1JIeEVxVmxtUlcr?=
 =?utf-8?B?b1pUMzMwd0lidjFrbFRxSEdnSjBreFY4alA3bEZOZURIaC9OL2gvMzJGWEN3?=
 =?utf-8?B?Vk1GK2drMnlTTWFFdWR2cHAzNXVoQ1JCblZzQVAzVWhjTjZiNFJVaUgwTnky?=
 =?utf-8?B?N014QlJsVWxXUHFvYUEyeGlsZ3VZRjBSNHpVZ2tZOXR3Y29jc2prcHRMVS91?=
 =?utf-8?B?MHM2QVZGYnpUQUdiM2lJNWpGcjZiUE1HODZzaWllRU1aMkhWWkE1dEdMLzRU?=
 =?utf-8?B?bUR5bC9LV3JZUTBZVTh1L2kvTVFuMDU3eG10d3gzeHcraWw2cFdSbFV2VGNH?=
 =?utf-8?B?Rk1SazFNd3NmRDNmUERodWs1SlNwRDFERkFycnRFY2lJRytVbkgwTkloWU45?=
 =?utf-8?B?eDloZWtHeUxDaXFYdWI1NzYrRjlJR3hybXdlVE9UZ1FhZEtiYitiL0YwMVdR?=
 =?utf-8?B?cjk5YzVQc0UydHJFdlAyaGVGU2NFSjV0eTdTcjJBa1Uwbjk4a3Y2b05RclBP?=
 =?utf-8?B?VlVXOWhxYlNOSmVqQXRhZDBpUkFoTkRFRnU4QmxyRE4vSUFmQ2NuNjMyNjhL?=
 =?utf-8?B?QTgzYUllbVdUamRaN25FRWRVT2xBL3ZGNVFSaGNiMmN5ZXFvTE13WEl3ZWNM?=
 =?utf-8?B?d3RialNsbkVFN29ldktCWGViQU0rOXdKOGZ5MC80Q08zb1ZZTE5BYkRhYzYx?=
 =?utf-8?B?aUR4QVJCQWs0Y2o5eGJId2dCZ2pNTEd3ekNRSTFIbW9zcFhmMitqSzVranNK?=
 =?utf-8?B?cXZobTd3K0E5SWQxTjdyUi9CQXRrYUxjVHpVWGNYdmdkbnFwZ2VOVzJlbTRt?=
 =?utf-8?B?UUU1TC9yYWplWHN4UThCS09aRDF1L3RQS01CaVpUN1hwbWdqV0FyQXhZSTRV?=
 =?utf-8?B?ZytyWVh6YXFacWx3bWFIamwzckdrRmQveXVUM3VuNk9IdWpvLzI5ZGJjVFNW?=
 =?utf-8?B?WUtVUCtSaU92N3k2NndMYlVXR01nd3NTbWp2ZHVNK0NUQU9GUU9KRmtyYkNB?=
 =?utf-8?B?VHB0ZGRVN0QveC9Xb0FsVjJwZHFhTW43emFXNnFpMU9BYXh4dG5DaEIrc0hW?=
 =?utf-8?B?M0lSNm96RDFmcGxxODEzUUcrcE4reHhncU5ISXpmcWx4NlBQSGlkVmtCK1p0?=
 =?utf-8?B?cktFYzF1TklvN01aZiszUE1JbVNZZlJhVVhaenQ3cnFYUmVMLzFyZzI3ajNt?=
 =?utf-8?B?cGh3VjlvSFk2U0R3cW1tdHBjUTlOQzA0bXZKRUhXZjF6MDBmbm9YY1Vqb1R3?=
 =?utf-8?B?YXBYNnlidjFaRFJWK00zaTJvVjNOWXg2c0EzWHYrUk05U2xMRUxJRklvV0FJ?=
 =?utf-8?B?emNKcXlsYm12Q3FreFkwczVWZElrVGw3YlBaYlNCQVkzMk9zazZicFZ1SDVP?=
 =?utf-8?B?eGpBNjl3MzgwSkwxTkM4a1cvU2cvdDdGMzNuT2dVRGQzemdHMFNSSkZGQk1k?=
 =?utf-8?Q?HqfdjVJlNv1EHFRGll4FxqZR7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tXNfc0xcaKSsD7ZmRF78woMuTGmoLQSfDzvF9q6UHbWK1Ksx7nG/Np4NmqyE4dZSWcEeCFIB7EhPBGCRCJB1GIeP+3bBd5Nz3C8PB0D0DDUss0woQEJ9K/iWExU/P7NMxRkoZ3swEAEYQMEv01c/aIpf6tGlaGX3D+GJ1INRyeAAKXA4ZAH7ymbFsJhBQMkuniePepixmm3LVVgqqIo1LaoTpEzbTwT/lJSqu6X8qmGI+rt9mtbpN2Hk41gBG8/6VGCaYpvHaEiIVwtFAZq2ZvvhLcyF6SyzG0oMQ0w44/UDW21QWYaf1NH8EnOJrDw2EbLp7PV0Bjm5WB1XjAuE9oUNoJNzM4tOqpXwTLV4OjXjGX6bROxCKU2fXXOlJxKen6tZZUZb0tPdhaIF9rocshLtNksWzfIuKqmaiTx2XOlKDZbXLG8HP3ARcK8OZeEy1J9nVzFeZu3jJra6edSMvw7ePShtBiYvwZirVSqbhYcys8g8tJRQohgEpd90VwmSovVLtj/TM5CxzWAdmehvFjuRrQfyIEmM2NmhhXZQ7nzZlSWEE0v6lH1KVQx64V/0UjMUQjkNCAmLmi1zAreTgCglK9ts6FFRZK6UwRZADGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b396a8-33ab-41d5-d796-08dc314d3823
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:18:10.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooHK1rreFQYl381shuME1L+8CJkaaZqbTO5Ud8MVdPjh9MTplgQGbn/Rh05QpeaRvHlkoudZSsIkYJg6EkeoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190099
X-Proofpoint-GUID: KSarDYwO_aZV0vi1vJCwCyNVKsX3L-qn
X-Proofpoint-ORIG-GUID: KSarDYwO_aZV0vi1vJCwCyNVKsX3L-qn

On 2/15/24 18:33, Filipe Manana wrote:
> On Thu, Feb 15, 2024 at 6:35 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Make sure that basic functions such as seeding and device add fail,
>> while balance runs successfully with tempfsid.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/filter.btrfs |  6 ++++
>>   tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/315.out | 11 +++++++
>>   3 files changed, 96 insertions(+)
>>   create mode 100755 tests/btrfs/315
>>   create mode 100644 tests/btrfs/315.out
>>
>> diff --git a/common/filter.btrfs b/common/filter.btrfs
>> index 8ab76fcb193a..d48e96c6f66b 100644
>> --- a/common/filter.btrfs
>> +++ b/common/filter.btrfs
>> @@ -68,6 +68,12 @@ _filter_btrfs_device_stats()
>>          sed -e "s/ *$NUMDEVS /<NUMDEVS> /g"
>>   }
>>
>> +_filter_btrfs_device_add()
>> +{
>> +       _filter_scratch_pool | \
>> +               sed -E 's/\(([0-9]+(\.[0-9]+)?)[a-zA-Z]+B\)/\(NUM\)/'
> 
> Why do we need this new filter?
> We are testing for a failure, where none of this is relevant except
> filtering device names.
> 

2nd part filters out the size part as seen in the raw
btrfs device add output below.

$ btrfs device add /dev/sdb2 /btrfs
Performing full device TRIM /dev/sdb2 (731.00MiB) ...

I will add a comment.

> The test can just filter with  _filter_scratch_pool only.
> 
>> +}
>> +
>>   _filter_transaction_commit() {
>>          sed -e "/Transaction commit: none (default)/d" \
>>              -e "s/Delete subvolume [0-9]\+ (.*commit):/Delete subvolume/g" \
>> diff --git a/tests/btrfs/315 b/tests/btrfs/315
>> new file mode 100755
>> index 000000000000..7ad0dfbc9c32
>> --- /dev/null
>> +++ b/tests/btrfs/315
>> @@ -0,0 +1,79 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
>> +#
>> +# FS QA Test 315
>> +#
>> +# Verify if the seed and device add to a tempfsid filesystem fails.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick volume seed tempfsid
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       umount $tempfsid_mnt 2>/dev/null
> 
> $UMOUNT_PROG
> 

got it.

>> +       rm -r -f $tmp.*
>> +       rm -r -f $tempfsid_mnt
>> +}
>> +
>> +. ./common/filter.btrfs
>> +
>> +_supported_fs btrfs
>> +_require_btrfs_sysfs_fsid
>> +_require_scratch_dev_pool 3
>> +_require_btrfs_fs_feature temp_fsid
>> +_require_btrfs_command inspect-internal dump-super
>> +_require_btrfs_mkfs_uuid_option
>> +
>> +_scratch_dev_pool_get 3
>> +
>> +# mount point for the tempfsid device
>> +tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>> +
>> +seed_device_must_fail()
>> +{
>> +       echo ---- $FUNCNAME ----
>> +
>> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +
>> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
>> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
>> +
>> +       _scratch_mount 2>&1 | _filter_scratch
>> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test_dir
>> +}
>> +
>> +device_add_must_fail()
>> +{
>> +       echo ---- $FUNCNAME ----
>> +
>> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +       _scratch_mount
>> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>> +
>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>> +                                                       _filter_xfs_io
>> +
>> +$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 2>&1 |\
>> +                                                       _filter_btrfs_device_add
> 
> We are testing for failure, so no need for the new filter
> _filter_btrfs_device_add.
> Just filter through  _filter_scratch_pool here and nothing more.
> 

As shown above, we need to filter out the size part too.

Thanks, Anand

> Thanks.
> 
>> +
>> +       echo Balance must be successful
>> +       _run_btrfs_balance_start ${tempfsid_mnt}
>> +}
>> +
>> +mkdir -p $tempfsid_mnt
>> +
>> +seed_device_must_fail
>> +
>> +_scratch_unmount
>> +_cleanup
>> +mkdir -p $tempfsid_mnt
>> +
>> +device_add_must_fail
>> +
>> +_scratch_dev_pool_put
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
>> new file mode 100644
>> index 000000000000..32149972beb4
>> --- /dev/null
>> +++ b/tests/btrfs/315.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 315
>> +---- seed_device_must_fail ----
>> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>> +mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exists.
>> +---- device_add_must_fail ----
>> +wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +ERROR: error adding device 'SCRATCH_DEV': Invalid argument
>> +Performing full device TRIM SCRATCH_DEV (NUM) ...
>> +Balance must be successful
>> +Done, had to relocate 3 out of 3 chunks
>> --
>> 2.39.3
>>
>>


