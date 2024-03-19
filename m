Return-Path: <linux-btrfs+bounces-3383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762EB87F587
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 03:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5F2282461
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 02:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3F7BAFE;
	Tue, 19 Mar 2024 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jY6ph+Li";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WNWFuHRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135447B3EB
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816196; cv=fail; b=Uy+1yzb2dgysJEDtXwl3r7p0IFQlQCOy5HH/yXnw8IS7FQBxlqJ9ubS1MjS9l3OH+gIzoVJdBucc1upvNAUQQ8RhzhF2Ul5x4rfHgImNYu4h3jqveN5LDGrpftq3px3ie1pEZw5CUUgzfaeGl+hOhu4NowMRbAE4nzxGeh9F6lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816196; c=relaxed/simple;
	bh=xF6YVL9kQNBms8C3/2BUot4JUkR4qZ9snrdk0xX4bjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dpQmnbeKGSGbT0C39v2CKbW8gifQSAXKMVUdqnHkxmIWkn/4ycdrkYQgcaqHf1ZqtEs0r+HHD2M/Z0Oj8yUH6nmm1qYkCYzLgPDhibSPddsMxRS7TTF0d2aTWyVEWeN0+7GE4sAsktgKQD5iFekxL/ap6qgpt0xuyk/7qaaT3T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jY6ph+Li; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WNWFuHRR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J1EFxd030568;
	Tue, 19 Mar 2024 02:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oBf6Wfyo+fxU0q7B+K6bmIiP7x0KZIb+/FC5v4dbpEQ=;
 b=jY6ph+Lix30h50IoR6OfsVl8s9hLmqN0Pl81IUPGW/SKQN5wff1cdxQxVIjIJ/EYj2vF
 XNaNb2hdzp02OZKrG4f1mK4X08CJ+T6Pydw+wjBTxP277V7l73c4PfSFi47Y9MJwrx9l
 F9Q5YJrgwW2YaUpOH5KH2lD7BZUgNTaxZaYSDmF+FNNqzHOgwQDaTRFhabwkVTfawPiP
 lFeIjqzlP+XynsIOBsV2+aB3EEqvAbyId58y826okI6s/WTgFdCn/HnUn3gLdGLdFCbx
 T9XrC8f2c3jsgG1e9w3KmqbamCo1vm+lrzff1MdTQ/vYLOy3Ty5PF4AsiKeJWPTeWtyr QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu481q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 02:43:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42INWOiH003846;
	Tue, 19 Mar 2024 02:43:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v5m942-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 02:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg9qrU01Wmtd5rG+/8xxy1y/4gXtk47QP74UzUsgsiiJl3krCJLouq3miEWLlD+hy69L0JM7HJWMQ03x8pYKZXJzkiaULYo7R4NBT01FC7SuS3IoS1s0Mo9w5S4PQstKWIph0x+QTP2eh14ODghwnGZVQAbk3Sab2xH6oW467R4S3L3Gr65AsxkPqQBhVfSGZ4v1uB9MaRx8lAkEw5w4VBcnv8NXhQfBRlqjPqbUgVIrQy8ut4hbhOQ054i8uotwJtjwnVI3DR/oYwhzgiAZSKjq66ymM9d0pBKbOJXjS42xLFHhKIruU2fRb8TP20JZYwIgszR17Eoal//tVI5L+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBf6Wfyo+fxU0q7B+K6bmIiP7x0KZIb+/FC5v4dbpEQ=;
 b=Nxuvdo4xO/1g8gfhCqJJanN4so8M/18IfGsya/W9snI+6O5FIDd7Zf9pYtcSYOLopGAhrvtskEeZyz0CfBavL5RuBPUdjqPun2f/ufc2hcEzAKFsA70f0Y/scPsmqlAmDeTkthiDXffMxbHcaFMtu6Q2TCtg4BJM1gu+ZRdiHylZ1+4vS8AcCCfkBzpwTZK6HMuZsylgqfNYYyNL8RP3TzbJYs5oxraJ9Cjn7Jo4rS/jba5WgKJs24fUIGBxMFkh3mYGBPeL/fSqnvqpp6QI7WDu+4CzuSOodbrbTN3euu0lhUOD2X91n/v0AVoHktoj82N2OxjFYmoWWSyx44Sw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBf6Wfyo+fxU0q7B+K6bmIiP7x0KZIb+/FC5v4dbpEQ=;
 b=WNWFuHRRk+1vZQK6nuRwrJwvPgvyvyp8w2y4BHAcZY0CGVVe+xRNg4V8fNg9qJ1UUgWnDjHn1/yox7PWLVC1iMTh5ym/InvamS2N7AUZQf7AncK+HwpKVjY9hZNnAQZLFGr3eE8vZRJoZvPqy6OkRMulaOZkzb3EDWEl6U7uxDM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 02:43:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 02:43:07 +0000
Message-ID: <75b4f336-5db0-4cc2-826e-17f4110830a5@oracle.com>
Date: Tue, 19 Mar 2024 08:13:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: return accurate error code on open failure
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
 <20240318223635.GM16737@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240318223635.GM16737@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4914:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S9StqkdQJO4qbg6gxJWEDEXMiC54oHw3SoNq/5pYv586zoeBQH4h4Ihtn6gDyKP4ZcY+GSCXD+jcK1hH3hYFoV4aDWplXhC0dVDHAd9XUpX3tpeCodHIZBrbAyQv2288MbC1ch4KrpWmHx5OgbpOxlU8vIGr2zzwfUqglf0SPxjGhVC5ZxzRszszCI5IMfRzPg9he0el9/esmxXVvc6TrWY/GQAjTPNRvcW2PCtZoXaYz6mtvGmsl3gsrF2DWqxS7BP3AbHs1rqEqEdC40HXgiFTdYytrBcJ23MUOGRsKT+dZ3HfpStYpkguvxOK+nQ2zxZcy2raO6YNvh/AKeE510dtWu7v0OzZ3vPS0gEWKcTwtfHG7LTtyJVbiY7J1PM90BDRQb7moTokL74kN3oILRy8AjFan3LLke3YYxoJjK/d7Y97WeN9U09kNSsc+/TiVrKhnFhnVT2P4G+c6gB2iTtOikIDhUQm5aWJALbEwdF2SnlPPPvMkDUM6pPGySmRPJXX2wX7VDVHNx7PBZu+HP+fb6LJcF9/A6mY7E4C04d4VDW0MlXiuIa3AHiej9F4IrEejsUe4MWCqnwWgpST1zyYhbqAhKZpPZEsVrV3UPd+Kl8yYux+8QCwMOtTq5R3DExX6YRWX+p3jUEGeDO8qUXkaoZRzXLIDnWnXNHwCNk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjFCR2hIcTJMN2JEcVJPMTd0VGVtdzdTZmRUOThaNHFNdXpaUUEwOGcxbEds?=
 =?utf-8?B?eTAyKzJoNUhLcG9WVXAzZkNpZ2hrck4vRFJlTlkwR3hXN1VkN2lqOXRoU1U0?=
 =?utf-8?B?UTFUR1ZmL1Naa3FTLzNUNFhuWkRPUU9OM2g3Z2lMd0tzRUtZaUpjMjA1SVdu?=
 =?utf-8?B?aC9VREJpRnZOYUZOdHpaSTdEOS9CbWJNcEhFQ05VUXgwd3FIUjhrTERnMFBB?=
 =?utf-8?B?a3dJTXBBZEkxYXhtRElVaTQwUUY3K3NxZU9CVnVyWC9jeVRscGl0QW9ONXRp?=
 =?utf-8?B?RmpvY29DNWdxUmNIaG5Hb1BIOGRmWU5McWlGNi95MDBoQ1RIa01YaEU2MW9V?=
 =?utf-8?B?aWt2dDlUTVpCZWR5ZVFkN1MydmgwWlFsUmFOYWJjZmR4U3ZYQkhQVDkxYkpa?=
 =?utf-8?B?YUVSU0RydzRZempPcy82dDdvYk9SR3NxZzJsOGJYeHZ3TzNtelVydW02VHFi?=
 =?utf-8?B?MXlMaE5TcWxCUExlN0dhbEhzekxQL2svbW5ZMTJGYkUxUDcvaytONDBSa3Ba?=
 =?utf-8?B?TmdvdlVDd1ZPN0pRTzloaHZ6bUpCSDY5TmtoZ252c0g1NFgzd3MzRUtrc1lD?=
 =?utf-8?B?SDdyc282a1RmMjJBSHg5aUlpUzQzck5Sd2xubGhFWThCTVNYZW1RVUVOZUV3?=
 =?utf-8?B?a3hZRS95THNDbi9uUWlNKzQxd1FxS3ZOTE9wa3ZiNFZLc05jejdBQVpoQWpY?=
 =?utf-8?B?MEpzQ09kK0VsdjNFTm0vU05ybVVBMFlsVjdVYzRNU2VFTFVPQVBxZ2p4MDR1?=
 =?utf-8?B?bXNyanpIeWM4b3U2ajZUbTVVK25SczYvVUYwNmFEY1h4azZOWlRxcVJXWVVM?=
 =?utf-8?B?enQ2S0hEK0dDbVBNRGFacjJMRW5GdkFQRVY3REdpbzB2dXBLdTMyVUxUN3Vy?=
 =?utf-8?B?N25YcTQrUDdXeUNmOURsb2VGVkVZWk1aczVEdERKaGljUk5ySVVUbktreVVO?=
 =?utf-8?B?b0xPVERwTXAxcWZOOVBDZHpqODltS2JkaE0xcTI0Z2dqWHFSSFQ5bGFraXpV?=
 =?utf-8?B?MkxZU2tnLzY0YU9NNkVGQXUxZkNUL1RSTVhHZVNMM2FFRU9RZ2NnVk9uV2tP?=
 =?utf-8?B?a2JUY0k3R2ROV29CVXY1cFFVMWFYOFRkTUNxQ2FSNG05Qjc2THlmL2tocUdB?=
 =?utf-8?B?VU5QY0lPUWVqbm94eTJvRzhhN2RpMHZlVHRHVkp2QU9adXltaStvTFlIcy9E?=
 =?utf-8?B?WEEyeUdJZm1HNlhwY3VObzJTRTBER0pzZzNPdXlTOHVucmVOdGRjbllKZDMy?=
 =?utf-8?B?UG9ZQ1NPdEt5c3JXaVJWcnk1Und6ZVVnbkVDamFrVDhsVUdORE1VWFNVcGtR?=
 =?utf-8?B?Wkc0d0dFOVlMQjZ6NWh4bVpubGFuVHhaQjZoa09tMzR1QU9TYzIzZi80YXlV?=
 =?utf-8?B?clJDeDU1OWlUTHkzVkszMWJXYTY1NVk3cjZkNkliaGk5WTdnUHNFcG91OEJL?=
 =?utf-8?B?aG4zcjNxYndhM3hJajBZdHBRUE9lWUtGMEUxQjB5cmh2dmhhMDZPeUFoMkpp?=
 =?utf-8?B?ODVpdURQa0k3S1FhNy8yWVpDeElPOThSWTJXN0g4b3lmcDNLSjh5TmJUVkpm?=
 =?utf-8?B?VkZBVXU3UzlhRzRqcGFWODVmbFB3MTZrU0FVMHk1eWREVHlkTnlCUWpydkRX?=
 =?utf-8?B?a0JGSlhXNzRIRndoVnJmV1gvTzBoWEU5TjgvWjFZdjBwZkZLYldidDlXNTY1?=
 =?utf-8?B?cm5iM3dqelZNblEyTjlKbEs0YTZMNThZZTA5SUd2enVGR21NU09hMzYvd0pN?=
 =?utf-8?B?a2lFQ09WeENOMzFlTlI5bXg3SGlCOVgyM3Q4OWhjZ3RtYUNqSEdXdTVvUTE5?=
 =?utf-8?B?MTZwaDJZbk1Rb3MwVmhDT3llUkJrMnFIa1cyL1RqN1Z5TVBwRG4wamRLemh5?=
 =?utf-8?B?MmNldnlFN1NlWUFQbXRzSUJUTytSNTZscjJOT3pqRllhSWZ5N2tVMUd2aURS?=
 =?utf-8?B?QXpNck9RRVZJeFhHcWgzZjBna3hxZmNOMjBCekF0Wk1pdXpFdHRUMWZQbHRE?=
 =?utf-8?B?VVNyVWd5ZWpKYVRuYXZqZVZaNkpSY1hNRHg0T2pPM1J5NDVqeTFPNUIrdzlM?=
 =?utf-8?B?b0lPa2U5S2k2d09wT1BzMm1nQjNPd1lmSVoyM3RZRlJtemFwZzVPSUtYTEls?=
 =?utf-8?Q?j+2q+kdOHrgbcR/M6zO54KNdl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ytOhqKzGyMO5OoFWzKMfhIX+8VKWfCMFn7bofoXK6EHk78vPjzWXV5osn2mIOo743J/Qi7L3iUv7rqgGb5+36qEg7DXDRNFV3mN8eC1Setm2lM0btzzXs2lgeId/J/FHw6EspNOb+uoqE1la+dBp/8ENvy7+xlBvyP2hQ2lLi35wC8zLRDTBRkIu/Y6MJA9p4Zaix8qS6/VGKOdsVbOTZIkpX9LuA9lL0nzwpXygySvCFbY7fCggfXjz2k4qbsTUfxvjdBA5OxGJRX2haPbpWsybRGv8MLius2vvEYoSW/pJWcBQL8gO0NlglGsYVBbgnZ7YKvlaJeeq3suiQZV9LB6LxeRnCGsWlYbiDtJahkup59oDPdQX9Z7ICVCZKlEG6kqImEJU7Eazm9q0GemJ3RAUxuzG3Pjm3B/3MDFoZ5HViphU4EirPga6lmOqbeHma9lhz2ru/4rQwllhsvVFJgQC+mjkGNgkAFXbrymDNjqBz/qf1geHGRkyLz9/ld2K218Ro84Gt2YrTrYLLjys9NV+W3OufNfifuEG9uPaF979lvPoGzMGnDuZKedLKmJqILZJ3d53cG0i4XAGax+eVEQ4RETaHp9zaCt6d6XO5HQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d614a325-6d4d-4738-d136-08dc47be4e9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 02:43:07.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssmETJ6pNqIspucg/dBDP6iQ9js3YgqP5WsywRqDariZNy97VBto6wMqoFqPyU8OMI3u10m/OWyB/FyJuvxTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190019
X-Proofpoint-GUID: Yhy_TzCifoJyeoiNtrMzRxNbAy6TvcfK
X-Proofpoint-ORIG-GUID: Yhy_TzCifoJyeoiNtrMzRxNbAy6TvcfK



On 3/19/24 04:06, David Sterba wrote:
> On Sat, Mar 09, 2024 at 07:16:35PM +0530, Anand Jain wrote:
>> When attempting to exclusive open a device which has no exclusive open
>> permission, such as a physical device associated with the flakey dm
>> device, the open operation will fail, resulting in a mount failure.
>>
>> In this particular scenario, we erroneously return -EINVAL instead of the
>> correct error code provided by the bdev_open_by_path() function, which is
>> -EBUSY.
>>
>> Fix this, by returning error code from the bdev_open_by_path() function.
>> With this correction, the mount error message will align with that of
>> ext4 and xfs.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index bb0857cfbef2..8a35605822bf 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1191,6 +1191,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>>   	struct btrfs_device *device;
>>   	struct btrfs_device *latest_dev = NULL;
>>   	struct btrfs_device *tmp_device;
>> +	int ret_err = 0;
> 
> Please use 'ret' here
> 
>>   
>>   	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
>>   				 dev_list) {
>> @@ -1205,9 +1206,15 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>>   			list_del(&device->dev_list);
>>   			btrfs_free_device(device);
>>   		}
>> +		if (ret_err == 0 && ret != 0)
> 
> and rename the original 'ret' used in the scope as 'ret2', this is the
> preferred pattern. For simple changes within one function it's ok to do
> it in one patch.

Yep. Done.

Thanks, Anand

