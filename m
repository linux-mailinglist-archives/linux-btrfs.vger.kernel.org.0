Return-Path: <linux-btrfs+bounces-220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35297F24D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 05:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C217E1C21877
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 04:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630B818651;
	Tue, 21 Nov 2023 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rirr3JUu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HkTw3guY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68623ED
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 20:32:02 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL43kML001196;
	Tue, 21 Nov 2023 04:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AdsnxHuKOQE/gcFRXrPFH6ovdPKVU7kOVwVoBRk4jrA=;
 b=Rirr3JUuoVbQUmvO9OUUVj/jYGTxIBURBsGkLkZjwqF7h83A2DSF8my/3321I/MXv0Z8
 hqnzSXPLGLrciVGBAKrlYcb85n/QfOmmWVSF8zXwQOPnLRoonssQtUHROB35ahbb4oBi
 vox3xJgeE3xSNAYu/BCbvOlyyM+ZmgjfJSp5Ax3uQJPnP7lyeRQi5e7/rFfpt5HqMtKV
 hBJ3UJPAKt7Klcqs5PEZ6q3NRpvS1MZf+eKLlvgMQVVenC01Ibv9PuBmhs8XqIREepVf
 2XovkWS4YK4ilKpPhLTphtB/tSWg3+gmQdhAjzIaUNbxmLTXbq8BpT1Rm3wawHHpZ/B3 yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpem5f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 04:31:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL3IhCZ037503;
	Tue, 21 Nov 2023 04:31:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6bbpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 04:31:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2+LWVh5p0ZdqjSoi/nnBu9BLy2L8ISVtE93+TT4NY7JyxkCubXypgXHpbQfs9KGrOxUqbZqs978/PeROpmD2AmR1fRcetPLmlK9Ydcsy9p9p/ojrsT5dp+J9Sa4QiSeXvDwQxTY2yMPTPWbuzVaLpDfWiSyD60Fy5I35o8e7n8wHhw3Fx/KkTG+tSeGOSjkHVeHbyB9OQk8EPpKy2k37ysydLNL/WK8BphLYb+QxKYPHY21Abut1eIstK4tvAJgad/TaxSOfhqgDljh39dBNGcc8akcjVWrbOSKT9G+JMZx6gzq1eC3hVerGxeivP4QkuLqgVzoisoEbRW5UKzk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdsnxHuKOQE/gcFRXrPFH6ovdPKVU7kOVwVoBRk4jrA=;
 b=CBoFsINl8KwA5k48Fc3Hk2SQBnmICpFMwcCTywQ28QO7C+xE+RhZPa6FHNoaa5fHY2HEjDr73vZoBFC1Fyn+XP5Cl50iD2IabXMliUKu7QwvsoZOZr19ujb0sq7NcnF304yV0rVrSOjPt/egrGwj+6clNX4RKm6L7sM/iFB3IgrVeGCr+lYvPdOOP1c3nJe3Rrd0ifmLZEHH3QLE2A/WSHRowmQpQq3tme9ledN/OA/y0j8X9tCLZPbnISCS9nJPRmJkBDoEOBmiJot4UTC+It5Sm5nNx21OWYlkMT3e6JA9bO2nHfSgb4nlK9tIETCh0ORKIFNM7jwkZ4XloGL34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdsnxHuKOQE/gcFRXrPFH6ovdPKVU7kOVwVoBRk4jrA=;
 b=HkTw3guYolpwQF3di2zwdh6CxxgE4zT7HEBbO8JZlP8BJ7ctjCDuqfSMPfGIwHR+M2/gUsNkoUgBMTAyBld25fTk7TnUMqApGZhQS++OJuPdKYsaBRkAKplEKGp4cXzNpj/BxwX6CHoiZSFEjlktwZNgwcCZGd6uAEuY1l7wOU8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7713.namprd10.prod.outlook.com (2603:10b6:610:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 04:31:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 04:31:53 +0000
Message-ID: <07278cac-69dc-4b73-abb3-9badf1cbf9aa@oracle.com>
Date: Tue, 21 Nov 2023 12:31:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Remove some unused struct members
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: jirislaby@kernel.org
References: <cover.1700531088.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1700531088.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c3a9f1-14e4-4f96-d159-08dbea4ac923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZVRo9pQ2D9icZbveyXNCdT66Nn9mRxKctFhRyPbJdDKeHT+tkd8rQXJfOaVetuuZzXlc/rP90pm3Ta0MiZXPpijX5kAoS9C07HU27LxF0XGqKgXnghWKUpp89NsH53TRVrK0IoZIC2lHM2tkRNfoMqVLAtypAF8SgW5WlZwNmUieOGkeS8kyUbCss+Qmy6jvQtbLx8XhcYjyTiLCtfRFdNhF001IaihZOxFKnwE5lalT9CwWUwVrFTBWz02LQ2e5VplbvrrRfo2iyDOvJ4BzJ10IuzXMbir9OXwcdi6aj5aEgnFNEOY9xNkT5WbBPFtSEU3kYtSYM61T/1QttVKZee2TSfihqXW+iPmaPIkgRbjL8Yq2NUYC9ZRqlJ0Pdy7IP/VLyT1XX0X/qE+HYuMirqXsW1zqJZsoyRCOqVWLqgpQh3lIcYtOhPTaqg/qpgB1Bh9684JDRfXoGNVMX1r6UwzBEHNweYXgnlQB8PZobnCUcQ8bSOB4j1pSLXbn3yk01HDhJtmO1zOlqjxsnVNWyINhNkplawmZzV4FhCLS0w6jw2igV3ESo9r8RhvD/5J5L+SEt69MqxPoG+XOr5uMwR3Bwi7hmV1Rud3UVZ0j8ohNFyn5ymG4RUcGmKYfttiLZVR5729l0X+wVyt+C75BRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(2906002)(44832011)(4326008)(19618925003)(6486002)(38100700002)(6512007)(6506007)(86362001)(558084003)(31696002)(36756003)(4270600006)(26005)(2616005)(478600001)(6666004)(41300700001)(8676002)(8936002)(66556008)(66946007)(316002)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akQweDUvOEVWOVlvUDlzRU1XcHlES1dkSVhxOXo4bnhTanBlcW9pVFZwSXh0?=
 =?utf-8?B?azN4Y0ZBM3RGbytYUWxqOWFLcHZ0aHJFTWJKWEtCeEd4NlRTd2g1Nk5SaVhM?=
 =?utf-8?B?ZHowSkxudkxQckYrZjhBbUxQa0FSK1lnR0VIWGVhaWczcjgyOU1RSjk1YlRU?=
 =?utf-8?B?OTU5bnJTNllkemhydzR4ZHNBOFZQYXRsZjNOOUlUUG9lWk50MEhqbXhjZWdZ?=
 =?utf-8?B?djkzZ2cvYjBSNWZPNDdFRHVTeS91L09Bb0E1R3d2bjVPT25Pc3VtS2FlUFpu?=
 =?utf-8?B?ZHZORERxU3h1MVJ5N1ZTVTdKU01MMEpnOS9HQUpBUmtOWjdocTRiOENKRWhq?=
 =?utf-8?B?R1JMcE83WFp1LzJSckJkZEJsRnl6Um9VUlkveEJIMFRuSEVhbmFUTkxTdVMx?=
 =?utf-8?B?Ry9wa3d6aU9FenRvbWVqNHlXSC9FNUUwTjRXVkdHZWhDSEMxVTJvUXRhS2ND?=
 =?utf-8?B?aG9vcS9QVUd6YzZ0aWU0cnZYeXE2MnQwU3U1Ykcwc2wzd3IzYzFncXpzQVlF?=
 =?utf-8?B?SnFaMGxOYUJ5QUtvaGhiYjZQNzJGQkVXVTJ5RFh0djFUejdHeUNZUHh2UkM2?=
 =?utf-8?B?RXA1VUpNWUpENlQyQk1abjB3US9BVDJNcjN2aXBtbk1hbFpqZnNERVN5NUk0?=
 =?utf-8?B?RFpQTDdFS0MraWhEMnl5WDdaZ3V0bUpQKzZhVWlqSjF1dGhyRURLRGFlMHZ6?=
 =?utf-8?B?b3ZJbENkR0Joa3M3UlpJeGduUTFQaXZQMEROYnRhZ3d3Rm9WQjhmaERZMWtI?=
 =?utf-8?B?QXZJWnpoRGw0d0k1UnBpQ2ErWldkYUd1ZXpBcWhDejhmWHBNc3NiVVU5YzZm?=
 =?utf-8?B?c1gvMkdZVXJDeVh0bGRpeUF0V0w4eGtWbGJvNk5vWVJGZVUzei9FSEFlckNL?=
 =?utf-8?B?Y0FISHk4UWRWaDYrRzRRTmt3cGtwWFo3YjR2djZDQmIycEJoMFRMem1MSU9G?=
 =?utf-8?B?N0hCSmpxQmdITzFvM01IT2xtYkhaVmREbU1VYXZQQkFENEs1OUQ3RkVzK0xp?=
 =?utf-8?B?cFdkWUZNZk1rZU04YlBIc256SW5Vb1E5ZWpzelR4M0NiY1BGanc5MENVM01t?=
 =?utf-8?B?eitrQzdGNXp2Z0Z0NkF6NGRaVnV2dnZ6bXpwYi8zUmdVeFFYa2RnYVJXRjhn?=
 =?utf-8?B?VEhhUTltY1hMV2xOUVk1VFdUTDVHYU11QjdCR3c2ZlZ3QjVNOWR6bWsrdkha?=
 =?utf-8?B?YU9SNS9zWnY5NktaRFBKNVhJQ2RaRXJxaVFmYjBvUC9hMEM1VDgrLzJzdDlP?=
 =?utf-8?B?UHJ4VVRHb3VnNTZuSUdIUm93aTVTRnZxNml3TlR6Z1RDNlJmcjhtSEpqSFJS?=
 =?utf-8?B?cnkzenRSbDUvWjFJTHo3WW4yQTF5aURQaGRsdXdTcW9ZUG1KaTFZek1FakZM?=
 =?utf-8?B?WnVtdTVGalovNVFyQlNobXJFVWNKdU5KWERwSmhEYlFMU3haM3RoTXdIUUkr?=
 =?utf-8?B?YlZ0UnQ2WDMxWXlURUxHTWtqMlhBcEJqU1N6WGhHa2tKVmwwOTEyYk5LWGZJ?=
 =?utf-8?B?TjZ3ZEptaHRkZFFaWkFPekEzM1dES0x2MWVBK3Q3RlpLdUJXTEFGMkgxRkF2?=
 =?utf-8?B?YnBNQUFoUGtocWk4dXhMUDNBaFhZZi90QjlROUIyZHRiU3pQNzZDdEJmN1o5?=
 =?utf-8?B?MXFJMkJsa0tmZWZCZUNsak5KRXdYYTgyRDZpLzg0RVNIUkpNSmIvUEdYWGUv?=
 =?utf-8?B?dXZoY0FueDdVRUlQSUp6QVdDSFFnVUg3bWxNWXQvY0xpL1Q2V005TThQdkVz?=
 =?utf-8?B?QzJIUjdwa2s5YmdKSnNoNTdJV3dRUzNXRi9Dclh6eFFXRDhUV2RNeXJWUlRC?=
 =?utf-8?B?UmZYVXowWkxCaG41L2tQbHpsL2RKU3RNZGtnQWkyQTJkQm9EM0ZHbkYwa3Bh?=
 =?utf-8?B?bnhrZjNid0ZyWE4wUTNjRG00ZWZESjVJODZ2ZjdQUnBJaTlRd1ZrSlFoeXAr?=
 =?utf-8?B?aEt5N2l6My96b0hWdDF0dW0xdGFVdmlNc3RmWVk5SmZGOVpycWI0YnpwTDdl?=
 =?utf-8?B?UmRNYnR1aVhjK3BTTXBsb29kdExiRU9ZTEpYaGxDaEFpR0JXWW9PSVJ6UkYx?=
 =?utf-8?B?bXpBQ1Z6N1Z3cWFpQmVKVDYrcUlRY0ltMEI0aElLWlZmclZXV0RtVzVISkFW?=
 =?utf-8?Q?ItjIB4bre93esvv6yFzgxsYUX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pTze94XrRcWUvQzwXbATY4smKXLDGDtw3EgyHJv4bB58PcoaMqyhf75RtqVWzkl5O6MCCXw6QtDlZCMJ5IbroDvKxlXvveJpPsRXyxLt0yWVMW+L41fdtWRwES8mrzWA2L/kSiw7XvaP4Om10kjtjihcoqsusmTFEl4KAP5Qt2GUqXkj53gL/mHdF5J+ebpaGl8stJPBzseiNXChjm9KWzay5yBslDvJi+lRIzDe0yrJadPPbJ7PTuEFfqUcNXkeHdGeIoM4ujXDWioPTTYhWSXTUiNnuPRct+Qtii2X50SqKmuZugf/lUq1edug/dD06Ghw21zQJ5oR/PYyG097PAkXZHtgf4LJQZ4IFqcw7z7XxIxjdlKqsvv6rGZtbgAvNF71TZtFIpptHWiO9mI32rpGkvk1ji5lb6ORiypHkE4NG/l7WpvkQujUyiZR//ymUHfbOOHtPfqCgA4bNA44saT0rmaKmS0htiZxZG5iHb289a6k5oCH3hDrwhOsxf+wExI1glHo5NdxsK/7gIAnYnVtin6Dk/yMjXsHvYp6yKvpaTJi7SZZX/AnuCCnVrO8NbXhBLZtFaj4g26WimLRcrpgxfuyhm0NpAsjAp+XE4Rh/KUD+jAQz6+bfnynsH8ukfPgyY/ECw41WUxB+5khYoNH1a4ijPerWpSf7L+6dld5xWRPNsCseJzSN90YVwUiN8vmg5ZWkSsNNnbua9qe8mZLZBnhgLipsldbuyrjEpIek8Y+QTeORcYRwmFQtUtaw+bnCb9FUgwVQ16Idb9i/mZhQnyu2qwFsKgJY++nwzTofW9ZBs21w8HuLCBCoWvg
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c3a9f1-14e4-4f96-d159-08dbea4ac923
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 04:31:53.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0w9ph6SUORgDKzLIc38dWarObKPqs44RZPtj2HEL2UIH9MEDyQXtyHUWUMrDT4NMLb/ZUHn9VsCmBn/Ipn01A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_02,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210034
X-Proofpoint-GUID: xchvr7ST6CjHQVeDckiU-Xf7_wSYqgx8
X-Proofpoint-ORIG-GUID: xchvr7ST6CjHQVeDckiU-Xf7_wSYqgx8

For the patchset.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


