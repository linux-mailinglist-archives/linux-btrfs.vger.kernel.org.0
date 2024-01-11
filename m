Return-Path: <linux-btrfs+bounces-1390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A7A82AA1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE871F23ADE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3891156F9;
	Thu, 11 Jan 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NktJjYSd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gvJ6bPL4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B90156F0
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B8Znm6003006;
	Thu, 11 Jan 2024 08:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uccKdvyYD6sEfip9KR85nPMIFAReb958ljcmqNy39Io=;
 b=NktJjYSd550cnPE5IZEanWm3eS/y3vs5VvpYXXFR2BlIJjOTWgezEIRZVNDt0ajE8YQy
 7WeFLUVw+PUp68s5GmQr/giGLmdLcz2w+7WziuvFSpDd3RkTswI0R9X88/Y6ljcmUyde
 Jkzx+V+ERe8FzIAgbJRezIh5CejE1tQeTH49aLMkCU5UDWq68WHwxx2kcorxitQ924s2
 sLHcnzENq4AIi7B+V9u3BWe0D9Fsegwf8pS27+50RWXn/IapUyXZ+kmxsXjT/guWDE4u
 I2fF5GggSJTU/o94RxvjkGN6bDDg09sVkaSdFBEBE2fuIVxKnel+lHbgWANOOIWrXoXg Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcnv02j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 08:59:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B6rWBo012173;
	Thu, 11 Jan 2024 08:59:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwkn1ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 08:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksqBD1zW+Xox6fu4epNaMkv+LeP3EsAs3eNyhk+mko+Nf7bIXFiY6DYJH4SnrCsqxWnLASJ6UkrkQKYV7+tG6/oLjjt7FBdIDp2I5Y3vIg4Nkd0S5zmf3mI2pilWw04V/cyv6dT8FOU6Rwgp4Vi9peNGN2zpAlymLYgYijY1mxNDfU7OwvwQgtLV3H6ICRF3gEpcxkFRhVFcfWndEut/1CIYEtwm5G2UZ9SK4uKk7ZWO56q9BlcwaqHL0q5o6Q5fDm3ba6yNfhogmY4icXYzeHoJs1ToPekvITcMBA2ybrnZOL5iphs3CmzxpzLIBxZbwR5zdSmS3z2fKpgiqGjQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uccKdvyYD6sEfip9KR85nPMIFAReb958ljcmqNy39Io=;
 b=XICzwM3DDxKV39rqGu8LmWkLajSPHIgAs+qXsNn3XA+7J1SEX/1JH3tXLu9fSFmLPj6g0a/+/AW++Bx0RrdHxGS5+2SPKLn8h6Jv5n6c7KmrCh6DEqV9BYDEWcisrFPSbyGamrcO6G+rcxbq3lEM4zoOA1iykIIbOa8jan3EmqUKDRWDVXGkmRVUfrU8XDyz2s9Av00WkGC+D7dZ0CEYyxvSeB3M7SAksj0bMp2TU0FUzJ0bcqKG4MkNcHNO3zXMHk6L5wmQu4ZcVQVMlaCaU/wAoaN8PqUaK2jBS/1dA8hcGmgGSkq3OqI9nvjCfIIr5m7GhalbcwJ+ELRNhm8D0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uccKdvyYD6sEfip9KR85nPMIFAReb958ljcmqNy39Io=;
 b=gvJ6bPL4zhGkCWvvtTj6YwMxkCwwj53EvmgUYiItid1X7JsrkJysWFdHaT7JIZ9WRNX2XKVFe+DuoPFj9ZigT2hLvHqFUnk+ZlhjzQAjthkgAZZpsRtyV9AG4VvgqdB5fXgLUo7/vHs+pMJ/7+GT7FrXbWZvGbr/B16vcP53Bno=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6260.namprd10.prod.outlook.com (2603:10b6:208:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 08:59:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 08:59:06 +0000
Message-ID: <2878378f-358c-46ca-bc3b-d819f78658f4@oracle.com>
Date: Thu, 11 Jan 2024 16:59:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not restrict writes to devices
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: af2760c3-bee4-4c85-2767-08dc1283912d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jc4jJe+ZQhrOac6FfHt2yLk2v+So+qNw7mbiYtRwSWy4P8F15DFMXmWz/wz+Z1YwoKvRTrmlhTI8DUlJENfVBIb4HSyQN4idRMGMd31wDNpguVEZz3IttPfm1xBa6GyI3qTTxRS3nGzGxPBxpPtsgT610FiaV14ybS5s2BgcRR5YKLHlrCitnrKQvEEtsECFjXkFetGu3ysqg2HqFenvWZWlE5pYIp74lVkSODAwwn1JJRjVh/YVXlH4KT9OgUu4ixKhxSreuJlQDIGLOEjnSfwW2oYhJod2cjvpz7rMBZnJo3IPPrR9GNCAWTiOJbzkitAcARKYbtMsg8gC2p0bl8eIGVxzQKOTpw14LqZ1WSzdursTKUdHp3wZQo7nY3Zm0rrbni/ZNfJlnWdF6/47Fva/MzZZEqbdXIbEWDr79uNjyO0P30TFzruKSXNb80MCoabJLyrOjy55iqkwOI/YIipEVYsgT1rfPIOI/0gs3ynP031C2glFH+cZwdcIJgQaPZk7zT/fk/J1vTzLu3zd0JmV2+5D3aOPA6P/KmmFwHlAFYJtLiOPxAqQozHWDb6eJ2h4rv+vZAla/Q06scaLTc5RypSMUhnPMuuZAaX8yacaylcn/9TaYm8sr9f810uQ0kO0VaZq5WGAfprMy1HFJg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(8676002)(8936002)(2906002)(31686004)(44832011)(66946007)(66476007)(66556008)(316002)(6666004)(6506007)(6512007)(6486002)(478600001)(83380400001)(53546011)(36756003)(26005)(2616005)(31696002)(41300700001)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODMwWDRxUkpMWXdWWHRyODRhdGFhdFRtODdLdUQrT200MkQrYTE5RmRYM01q?=
 =?utf-8?B?eEExODBpdG5nbUdpdGhaNHFiWGJpSlZJbVVmajY1MGJ5bEtILzNFMS9STlE4?=
 =?utf-8?B?UlpRa0pvTkVVeko3alhCU2p4dHNPSTVVUlhXNEZxMTU0TmFtWFpzdFZJYlhi?=
 =?utf-8?B?dU10akpSWFNNcGxHd1JId2xIVXk0YnZyeW11MWthNGZ4UnJjMmhnOHcwZUh0?=
 =?utf-8?B?VFZRdjRaTWViODJDeVhtRkZEYmlwQXhHcDRnUENGdFZDazVMRWJ2TkkxS3Bq?=
 =?utf-8?B?dmVpMHFwdUp1UEtCNnJiZkNvOXBUeUcxZkQ4cjJUK21Fdi9yR0dTMzdZNFYw?=
 =?utf-8?B?bkxORitBSmJ5YkJ4K3B6ZkJTTFBoS3V3Y1VKSzJqbWVtNTBxMWJzT3RTeDJ5?=
 =?utf-8?B?SzRsWUYyYkNCSmNVZW9zdG14cTd6ZHJYejcrRVRJcW5ocXY2ZEwyK2s5dnIr?=
 =?utf-8?B?WTIxTVFNKzN1alJyWGduNUgrYmd4T3E1eHpaZGZZampwcjk0czhsRFRxdlQ0?=
 =?utf-8?B?RDdDd0NJWTJmWHkzbk9zRVd5WjRPVW5uU2JVak80eG5PR0JPOHhTUGdvMWFv?=
 =?utf-8?B?QTBTUmFYOG9MMlJ0bnNnU2RlZVZ0UVNOZWFwTFc0NWt1a3B1UTNwK2NCeTds?=
 =?utf-8?B?c1MrWmF1SkFJSmhDMHhLRyt6TWIzN1VNU0dQVjN5VmRWcjhEaTFEZ2MwRVBn?=
 =?utf-8?B?bkV1K09rbEx2QzlSTzlEbEk0UFlrMUpSNEV2SDB2QSt3Ulp1QStPUXNxcDV6?=
 =?utf-8?B?REdrNVhxbmFBZVk0ZGFrZXNtVG8wZFF3TGJVNDhtV0RWZUh1UnRaemF0NnRu?=
 =?utf-8?B?Rk1oTWJNczRybnBST21mUHV6WXBvbnROMEZLSVgxbkNpZ1FZQklINjVlc3px?=
 =?utf-8?B?ZTFzRnBEOTJZS2pyT2F4d2FTMHdRanpnRWNDcGV3VHdMZ1lRanJPQ0IxREh0?=
 =?utf-8?B?MHdtVzZGdTNuZHhBRktlTHpERTUzMUZXRWppU1JJWTlqekoxSWRTa0hpVTZO?=
 =?utf-8?B?R2lRNkkxQlp1Zks2eFNpcUVWbllhZVVkSW1uNUpBS2ZLY2Jkams4R0FMZFB3?=
 =?utf-8?B?bnhMNmlTYlFyenVia1JmK3NnUWtPZkhMMGliclkwMWplVlNxR0t3TTU3VHVw?=
 =?utf-8?B?cDdRaE5EbnIrSkI0c2psbGtYSllOOGFUVjJRK3RGNjkrUVF1YjRWOFBtMktt?=
 =?utf-8?B?cVdQb2RIaVFzK0dCcEpUcTM0QjlZbzEzbWVMMnMzNllJS1pYUHBiV2xheDJs?=
 =?utf-8?B?MDVhOUptS2J1WDFJQmdpNzhYU29FaXNGaVBqMzNxVkJRUGRiQmVhWFB5dTcv?=
 =?utf-8?B?VWNEMktLOU01Q1Vqd2pzaGtFRlNBbjJHUlZMdnRndkYrSkZPbzNjTEtlV0ZG?=
 =?utf-8?B?RUdmR2lkdDRmNzVkdVdBVTV2ZE9Qc1lWWTZTeTQ4alJ6eEFYNXYzL0tOTm9O?=
 =?utf-8?B?a2g0bFJLN2dTNHQ5MkdCWTVOYVNQb3Nyd0JTOWk5YmxlZGJLMitSMnB4M01r?=
 =?utf-8?B?d1B5aloybktmOUhycTBuQnViNXo2OW1EV3RqcG1TR0wxTmlyblJ5WVdxbXdZ?=
 =?utf-8?B?WCszWDFqK2J5dU8yWHZSbG9xeHY4VXhDSWpKbkRNSWRXSEVtNmlUOGtkQ3hO?=
 =?utf-8?B?a1BXOUFmWFRCSEdYZXlJa3BXL0dyUGVLZTYzR3ZjL1BFSzhjL1ZRbms1WG5N?=
 =?utf-8?B?YnBWeDZiclB6U1NKMFVkek04NVNyNTBIcmZPMlRaNHZkNTgyQmlaZVdGRHNN?=
 =?utf-8?B?ZjRnUy9SczVLWGhVYzAvc0Z3TFZRM2QxWXFJRUhQLzVzRkZMU09kLzVMRXdF?=
 =?utf-8?B?bFVBcnFCRGtVRWNzQUk4VlhtT0RkYXpQeDcxcnVpYk1VUDk3c3BGYnBXT0Rt?=
 =?utf-8?B?SDJJa0NUOVVUak5jU1Z4T0dHNVdOSkNUY1F4OWRnbHJneWdVbnF2ZDNnRDAr?=
 =?utf-8?B?SWZtMERtSnJ2YVRndnhKZUtNSjcvMDVnL2VEMnliUndzeHpWWW5ySUh1d0R3?=
 =?utf-8?B?bVRudkhoajdKY2ZrUW5pYXB4OTVWRmFtUWVrK2pEc3RCU3hjZWlzZFN4ZkRq?=
 =?utf-8?B?SEVSeTg3c1lHSlBmcytZMHNYRDIvTEFtYVJBMTYyMHAwanhaUEFsb3V4Vk43?=
 =?utf-8?Q?V3Ss0+Jz6E2c7UPCfbayYtZSj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G2lCDqtPA9aHwchyoxtNrIccJgXI6Bimvt7lwfzzN/O732G4gAz8PCOmPzmsTio+zAztUiEqyLWTOh7QoplrSp1U9JI5VUTPEq8tLgu6HURSLJ8W/na2zrBmsUYnYFL9LkoYAL63UBdFuZxPz97Mwix62F/SN5j52QESE2mvLYlwysOl2RtEx0d8MHFeeNJfksylL39s38FZsrjkSb4LISovGYw7LYffrXDX9ip1gFutY6MKZlCTP85r7eDX49Ke5Ms2WM46aDuyuRfxY6r13594U+t0EvlcwcWFLmxzVrXBGUn7FHVi+mqvswZZafZmKejkykmMNkHIGdw0JGrcqXRq46oL2vntm89cQQpGzvZeYKzATciBrs0+rclqFDNeSNxTvcIMugYAsD89ONFp1EGTYeuZHd00r8gmX2HR3u9qdakZDCmD5z+19u/b1QtqSKgWzF5Dxvhvpc8pZVflhSdvN+AOfwDUDLS6q+EJU21fCjWgaXQQsYV2vudHtWUZwDw57YHYPRuNRnn6re1Rpbfq8wHZCD6hDjcLeajZhcn4W1jyXWhthn43sEmJ1It6HAmsmNXZV5nH6gI8VY0NHGzOJq9HkEBIW8c3LDJfyw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2760c3-bee4-4c85-2767-08dc1283912d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:59:06.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/Ld5KRdI/mHgSigu4E5Sj6Pp9I6XwiqCJ1R0NGzYiv/M9sT4ox6NOmfHY4cDvXY8MQ7Q8Day8Isg+46Ai8JnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_04,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110072
X-Proofpoint-GUID: lXw-8DdVKjMTF66D3zCIP7hJx46UepjF
X-Proofpoint-ORIG-GUID: lXw-8DdVKjMTF66D3zCIP7hJx46UepjF

On 1/11/24 04:16, Josef Bacik wrote:
> This is a version of ead622674df5 ("btrfs: Do not restrict writes to
> btrfs devices"), which pushes this restriction closer to where we use
> bdev_open_by_path.


> This was in the mount path, and changed when we
> switched to the new mount api,

  New mount api patchset [1]:
      [1]  [PATCH v3 00/19] btrfs: convert to the new mount API

Do you have a specific patch here for me to understand the changes 
you're talking about?


> and with that loss we suddenly weren't
> able to mount.

With the patchset [1] already in the mainline, I am able to mount.
It looks like I'm missing something. What is the failing test case?


Thanks, Anand


> Move this closer to where we use bdev_open_by_path so
> changes on the upper layers don't mess anything up, and then we can
> remove this when we merge the bdev holder patches.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - This needs to go in before the new mount API patches when we rebase onto
>    linus/master for the merge request, otherwise we won't be able to mount file
>    systems.  I've put this at the beginning of the for-next branch in the github
>    linux tree, which is rebased onto recent linus.
> 
>   fs/btrfs/volumes.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d67785be2c77..9c8de7fad86e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -474,6 +474,9 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
>   	struct block_device *bdev;
>   	int ret;
>   
> +	/* No support for restricting writes to btrfs devices yet... */
> +	flags &= ~BLK_OPEN_RESTRICT_WRITES;
> +
>   	*bdev_handle = bdev_open_by_path(device_path, flags, holder, NULL);
>   
>   	if (IS_ERR(*bdev_handle)) {
> @@ -1322,6 +1325,9 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   
>   	lockdep_assert_held(&uuid_mutex);
>   
> +	/* No support for restricting writes to btrfs devices yet... */
> +	flags &= ~BLK_OPEN_RESTRICT_WRITES;
> +
>   	/*
>   	 * we would like to check all the supers, but that would make
>   	 * a btrfs mount succeed after a mkfs from a different FS.


