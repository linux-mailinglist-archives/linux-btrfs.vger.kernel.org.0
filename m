Return-Path: <linux-btrfs+bounces-222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A637F2650
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 08:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297CC282A2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8268225D3;
	Tue, 21 Nov 2023 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kV4xcPSq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oPljUaKk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB024B9
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 23:28:24 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL6jbUs016716;
	Tue, 21 Nov 2023 07:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8OJGmisfKSml8iYcPvBcSs764xVFN7WyNgUAZ0xD1iA=;
 b=kV4xcPSqPIe2+fBFL1NoLktnFPPtF6pmevjI/a63Mm2abRSZ+lwteIZJlgNqe6L6h8nv
 V2Z6EOJZ5vcofJVXM0Dh6wHwNgbuGv/DINupQb8kKMS+cVSGoJQk8EJ9hkyKaDp4V0vM
 Rdm+SgswEpklZITBl3ex5bN5Z2Jhrbr1RIr3LH5d2bx48hH0uDX0rS9AhuUze5Ld/Gpk
 lMtDJAtFCc/9pm466EsmxyQPIdPtLqcyicP3Q/Evg+sx9FNauCae0X23PdeC2oax00X9
 waK4G5S0ccMENX3owLY+mvAmNWNlWQdt064UlpwNntiiesNqe5VkXe1gCKa1N5PWCp+F 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem6cce8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 07:28:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL78r3c037461;
	Tue, 21 Nov 2023 07:28:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6hers-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 07:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo+LY4WjCoNoFxBH/sDi/H9zktJDE/kgA3KynhssjPKrMbnyKoAeqqHSb8a39Ml7eDLMw6sFlD3uXtAY67Jnv+nTxGJmOsWX3pZtkOKHf91jzIrGBy+wk3T54pdNAIZTOo2DJ8aImHNBpFoyen8anwcK4nKbav8G23rBmT87WW0ARPRaNoeb9Q/q/R8yjrwKvzobVEK0gWL8Bu8whKNMCBT7eyc7vjHe/Y0YkEjnJBjNeboTisWvv/9bfZlj30itiFZ8AHtP+Nqh+aM2ccfQVmuB+YO3DtdMDRlDj7tYBH72eJnXNsbI7K0gW0LCaN9pPCcWXF2IfgGeeqghkSsZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OJGmisfKSml8iYcPvBcSs764xVFN7WyNgUAZ0xD1iA=;
 b=VhU0RFYGWD6soWE/VL6PUSfIb7ZCJNPtoxbpKXDLex3NVdRw+1bRVequls0z+mB9/qs9gx1t71b3jeljK9g1rkj/KMcWgwrSocQDi84yyLzaQ0ax3jwEqFk9OcilSTvsD77Bt8m6dpzKFEQiLDabotUDyrAdBZzIYCv6EkKwmQ0a6rJQGU87oEaaB+FE93qaERmTggUIupqZnIvQSGgxUaBR0B49nsuxt7MCDPofYPCjmSvobqXDCITd88xVUnrA9UawQlKDr14w1qY5qUC36AXhsMjKWyTyiGwD/1QAY6fqUejCX2E1o4MXzzYo8HJrjtqa73KnIpwl/FrlO3WY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OJGmisfKSml8iYcPvBcSs764xVFN7WyNgUAZ0xD1iA=;
 b=oPljUaKk9j6U69pshfWacbqH4YbAGMGJjHs/i4+xkrVWFZPAX8Cpkygf2t39FybzdXj7dLiUKtLBwQ3UxvaI9ReNgExkqB2QgjbaRh4aH4tPkiiFAqs8lfKMaIM0NHUaTouhTNwL+mnZ2+aadp2bb5tqjfDphKHzo9SGLmrHbDY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:27:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 07:27:49 +0000
Message-ID: <132c19b5-ecc6-4b89-b308-7b94b32940be@oracle.com>
Date: Tue, 21 Nov 2023 15:27:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <794136af-bb59-42f4-a5b2-8c760c4abd88@oracle.com>
In-Reply-To: <794136af-bb59-42f4-a5b2-8c760c4abd88@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: c80591be-8461-4ea3-4d9b-08dbea635cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e/iAqggTQ1bsztfzyOM0FPlUEdIyoq2N7dUS43kd7LWwu9Qfqrpf3iiL8K2D+WCYj2n7Qje291IOSGsS/fIpBh8aJ+aHVx5XZvmpFk4BZilkKoabxpvSDSZwefI0gCYMB6eTZPuE3e9tQdgRMoP53cIoIN6pqBBjgZrtMWJBFtZDTFhQAJMog0ERzUEPPuzZnuw641b3isYCq3Dm4XcwRa4JqGyIttnTKFF9MSY9rbu6qU5n4euCxxliEF+V1fffFMhxbKNoBDYzvyBUCzOyBf4TwyYCYV8h1nbcFPy4Wdj0LR0Z3EPkIzDYHU8Ewusq7OuTpT1LtLyV8ggEsoTCBM2EcM1i8YdeTMzDAwqmcxmDyaj0BKFxla15ZNk9nb4Js6YKl95MMbW9c7AL64myfhwHWdAZvCZWlwmWOYbBQ+vWrs0/hLypnZusTI8JxzxxIE1ihV7IY23upDg6JHoNI7CYEDMshOAPr7pPUi6Q5SsMOUfnVQoRfP2lSA5AkwOJPmxdxZzPUrZakWJRKx+2KpIxNpsHSFyFPtZdJZkI5ilgAE3SekMHr1IhsVjgOp/9Z7FJkkfyLdX5om0VQlKk7fwy1O1ZS+itWEyxJgR4Xau6cS8zjDyc1B3tm/B2fO6UIaW4NFEnFmjhn6aCYRxLFw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(53546011)(6512007)(26005)(8676002)(38100700002)(8936002)(2906002)(44832011)(5660300002)(478600001)(41300700001)(6486002)(6506007)(6666004)(66476007)(66556008)(66946007)(316002)(36756003)(558084003)(31696002)(86362001)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVB0K01FZmRKWXlNckxDRHV0cGU0QkxvSjV3bktWUkIybWtRcnI1T040R0lq?=
 =?utf-8?B?cDhNUnhTT1Q3RCtWZCtjWE90U1doOE42QWllNXNTaXpleWtKVUo3Qk10Y2E5?=
 =?utf-8?B?UW9hbjI1bFFJcTB0aTFhMHpqRW5FRktHdmNhaFRaSTJ6SW42UEt1MFM3NlF0?=
 =?utf-8?B?eXErR3BacktWeW94ZWVWdmtqZGcxd25QM0ZzZFJubzVEVnNJMWgvOUUxVWkw?=
 =?utf-8?B?NDFJemlZSW9YVXd0aTJuUlY1SjhFL0pFbzc2UW01a1YweVVoUmtsc2ZnRStR?=
 =?utf-8?B?OFdBaXdRWmVSZTJZbHB6M1FFNnF0SkVwbHhNRVVWeXFYME5aem53SnUrK2lK?=
 =?utf-8?B?dzZjL3JsZmk2dnVubkp5c2lXcGJxWmtRRXpERjVrWGY4SHoxbnFEK294UjA0?=
 =?utf-8?B?dFJpay85QVNQM1Q1bHZXSG9MeW9Xd3JTVlBielNGdE1Idmlwdm56alJzaFR4?=
 =?utf-8?B?UDh1eHRlemxUcEJIN25RR0Urb0xRcUdhRzMxNHM3dStHbXRDTlQ4UGpUWXBI?=
 =?utf-8?B?RTM5aGNRNXVDVEoxWG5jMklmQ1pJbWkzb0hGSktxUGRmNnpyb2NSaTNGL2Yz?=
 =?utf-8?B?b3p0Mms2R2tNeUZiQVRUT1hlSVRELzE2WUJsa2hiZW1uOXVQelYrY1BYREgr?=
 =?utf-8?B?RGR2TU0vaHpFY2NtQisreWNWeHlKL25waVJEMGlvL1NBUFYyWkFSS3lZZitu?=
 =?utf-8?B?Nmg3OXgwUnVUZlNQNmtQRVFFWVhHUFBTUjJVSHdUeFZIbGg0bk9vejZ2a3k0?=
 =?utf-8?B?OWpYQ1U1YWFqMzMyVXZFZEhVbXl6YnJxTWZLVjNzNWQzQ2VxWEQyTWV4ejg4?=
 =?utf-8?B?M2JvWWRNdVpxY3QrWW5haDRoeThvVjhNNzRxUU9NWW04ZTZPVVB0a0xhMHMw?=
 =?utf-8?B?YlQvVXZFUmdYUTArV044NWRSMnlxR29WMUphckNZbkYxMjNjSFR1VFdxQTNz?=
 =?utf-8?B?dDZkNmd3QWJncGpBSTdxNnp0STN3U0Z5TkhyR2pubFpoNGY0UEcva1FLS2x2?=
 =?utf-8?B?bmlFSm1vd0VXSCt6VVVGUXJBRlA4M0V1K2lrUHl6eVRvUW5zMUsxdFhNemNk?=
 =?utf-8?B?V2pWNmxhalNzU094bE1lWWhNTGNVdGsvZ1ljb0NCQnozNUlNbkVZRVN0TG94?=
 =?utf-8?B?KzNHK2M2dmxzWDVNcFpOTWNlOVM5ejBENXJ3UldSRzRRaXkyNisrU1RqK1c4?=
 =?utf-8?B?Y2lZSStrbit3czRhWS9mWlYyaWxodkNyQS9TYWgzV0NzWVVyK1h3cFBqUVo1?=
 =?utf-8?B?aVNnR3ZpQlV1S1I2SStUUkF0RDRRUnFXa21tL1F5MmhhVk9qZnlBR3BDWWFL?=
 =?utf-8?B?Rzc1c0FXN2NkZjF6Y3ZkWFNyanBEWHhXMUdyTEd5QjNmL2JsQWhRTEdmZ2JL?=
 =?utf-8?B?L1gzUGJTQkpNUGJIS1BTNzRnekl1VEJ1NWI4WjlINmJjSG4yY3BtMk9vNnJT?=
 =?utf-8?B?NGRRdjJJVytCcGE1dVhyd0JWU3lkbHRMR0EyOWRwbkF0VEsrTkZDMDZwVWVQ?=
 =?utf-8?B?aEJpTWh4NmpmTTEza0cyRVQrc1pBTHlRZGdaWVFlWTBwNUdlY1VEVlBVT0Rv?=
 =?utf-8?B?L2lyS0RLQ0VHZkxBTDZkZFRJTExnek5PL0wyV0ptYlBTTCtLNmJJY2FteCsw?=
 =?utf-8?B?bkoxNGNiakRYNHZSQ081djk1Rzgzcy9mQ29kQ1NUS0U3MUZFOWUrZkNyaU9h?=
 =?utf-8?B?WFBUL3ZSTUJlYUhCREFYNkZzZ21SNVdvK1EvMVQvUERlQVZyZXc3RmlmNUN1?=
 =?utf-8?B?WXRaQm9MbnpCYkEwQnVVNDJycStkRHlQZEZ5MzZkQ3lIaElESElENXU1UTQz?=
 =?utf-8?B?bU5vaFVseThjb3o5bUlrb3QzUkoyK0hWZ3gyanoxQ01DVHJ0NVFqU2RrZmkz?=
 =?utf-8?B?MGFOVUQ1OWNENkVHUkcybXBCeFQyeTFzQ2cwMkphdy9VVXY4QWNJdmltVVVw?=
 =?utf-8?B?ZDFua0N3STk4M3F6Wms4T2pEdEphY2ZpTWdtaWF5TXBHcmgxZEw0QnRFSHpp?=
 =?utf-8?B?TFZ4RVdPWGZpa0F4VkxPZWlJRmRpZGVCQUVaNFZUQzBhZDhSMzd6YUJhbEtK?=
 =?utf-8?B?TklQVU9rZkFHdWoyWmx6Zm1MY3U0eHczN0toOXhlQ0ppaTBiaTFHZzB6WktM?=
 =?utf-8?Q?QVjphc0AA+9/8OwNUmKSI/5o5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AWfJWMnFOYo7ENp2y1d8iKzMLYc4I+ojKIREckLNlgi3yUv6pCuxUeI/nlJGupY7hE2HIC3j3gGbEJJiqa8ulEHMHT6XijryzBSyAnxQV9pkK5hrx7e3aQibMZDZWyMNtGAdhoqGIhhropHUdoGZquRkZGj6zDAxTXuf6FRneFsojvK1t7jHqVfEGdQ6/lg4a0SC358aOl8DIKWhN9RPzkzlhVgbBy5fY6Dt1V+hS2+wI/3cdGDoQqdu8GDQ7yeULqcIFi9WL0U/7avvlTPnr5esnSQlck+In0kEXrEwYk9SXMX4tPoqlLNXwzL5yYvrU19Z7jzSBzCWHdY5HdLfV/GEjHCV0S7CECJzFW72/rOZoIscOqsATGYndPBg4C8RMhrigo7E84coIXoXg6RC6xSK/D6GJkxvRbWU0G+7Sv1LnUx3Ef/wTREuQLYioeECLl+sVsw+k71XqtZJBh0GW2H7jm5TIUbVK9JEUzSKcpVBQuMZ+TpuP4cIFO3+1AEgSHqBN+ElejtaOa8HN7DCvxbE8s1bXDbRKAPOylbYeOd4Hjel2j7yAlqRi/Q54jsXMGhjuYog3/HHDiItNsTnLqkvTws0gmGe9VuB1WwemI/HBtYvWyBz6SVP2sEOTBtekXz9MYtVg586uFthmgyQP5Cpux/cw2S6+MpO9nCiaHMH9o/bUO+Bn5kEfC5SHzH7qZtedFp3GveN0H0KZF+wGdRJYAQCGj8pDU2NZYmsLQUIgCi/2X5gtttKqWuPh2bEaJDhOprmvbStUFdgCXWoj3guuaz/zJQv1J3eaJ9jKnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80591be-8461-4ea3-4d9b-08dbea635cfe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:27:49.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yexr8jHld+CMMhr7Y4OCXiCnZPecU1PmNn4hx5reaeV37hDVEg32Z0qwC3lz1ewBSiNJAu+l/AQ5fwuppA/n+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=906 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210057
X-Proofpoint-ORIG-GUID: oBhy-W_CJQOabu2F6l2oZ6bKcqcMTv53
X-Proofpoint-GUID: oBhy-W_CJQOabu2F6l2oZ6bKcqcMTv53

Starting from v5.4?

On 11/21/23 13:18, Anand Jain wrote:
> Also, is it possible to CC the stable kernel? It's not a bug fix but a 
> debug essential patch.
> 
> Thx, Anand
> 

