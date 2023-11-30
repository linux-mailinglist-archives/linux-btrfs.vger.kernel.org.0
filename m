Return-Path: <linux-btrfs+bounces-466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC97FFFC4
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 00:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F261C20BE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F77584C2;
	Thu, 30 Nov 2023 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ke988vQO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W0HRexoj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2227B10D1
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 15:57:09 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUN9vFm011174;
	Thu, 30 Nov 2023 23:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wMGjYyYIf8sWgrewTrZ5AzzQNCnZ9DN2OqnTlGZGK5o=;
 b=Ke988vQOtVhq/ri/xLsDBvGCVAGqUO2xiJxsz7HTkjaUTkyksyT2dajmc6BGiG/QZDbq
 mpOw2WScDD6PlltDFJhstlStMj5rMvYCo0p1jkyg5fXpBWG75zTrjTPxcXtGqCbt8/nZ
 RTAOoXY1SqgMsyUiTYba81yxlIQVLClvPf8FZAb6V2cXCrZX3kWa2xcPldBQ91mjxDt8
 hQDYbI54X736HCEhXSajhbrFzT+Som2ddRnzMiVGicvRzY9pwWyqY4gIGUC6Fs3CC6+0
 qgBe+eA7J9bJckLRYhInO694l54KCYGHG6BfWKNjO90NxQ0sgGqjD+1+9c2JgIH4LZ2t nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq3n0r2vr-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 23:57:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AULbpYD027190;
	Thu, 30 Nov 2023 23:45:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7caxm3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 23:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doR7/J2rtAIeLUvNKrxDlV37CJ0uMsRSc1S2jYlQ5z4sXeIW31/GKBdE0JWJEebMiZbkdD4f0c1CSdCrslY52FMWQtlldkO7XGeAWwjFWRrarSZZnfZWSu5bxXNBBhXMGn7FkR3mQSOPkKJ6sZ+FjgX2+xJ/ydjhyybOk56ohbbMsxaox5GLN73t4MIc+zWFscCObFH7wt8H8ksvLwq6pBYOIRfBNw3kOMGZb7cr0R6J5EXKLtWLeyToBGFwPohHgc9BsmHkdaZJBIi2+hYjOQn8qBNynf0g3ZYlKKpMyzpNbXfi3JlIuJqPPSyYYVrjDQ8T403KDdt/Allv9BprvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMGjYyYIf8sWgrewTrZ5AzzQNCnZ9DN2OqnTlGZGK5o=;
 b=Pe4m8TcV44E22bbLpPp6SRsSt3V14J97MEjsNooUFPwa+tssm10uXK6puWSaOi82G3wgnzOVAF61GHMflvQmSW67F6V+0piL9BW62f8AUDCtneG1OxCmgEmwUOrtSMru8MqXV+FnqtOF+q3M3f2jq+2bEBzuIfmD3MLO2v7hf35x85lHBZT3mmwCsb4AkLWx2Pld2KP2Swx8oZzp8NGejg6wuMK1iBPHn8Lz79p2yTIAtEmRA9MUP2tVFa0M8tpNmWKNq6n/YXUwFIfVp2D6WI7abPPRhDHZ+2CbCaTdS7DVoQ+rpZsjP/CanFr7VMhViNhJRVx4uZnqE2SUMzfI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMGjYyYIf8sWgrewTrZ5AzzQNCnZ9DN2OqnTlGZGK5o=;
 b=W0HRexojniHJPvTyiiPHOABep6QVyYhEb/BQgT70pTpyLGCXi3M0odTIHZLuJc/7uj4LB99GfCcKX6+yzjy4+JbK6vKp0uSz97dyAremwnBSVDcb9KU5RRo3iazahQyxN9qHrBTeg6aeLxP1HBhKMkhcImvw7oHH+b6KANIGe44=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6101.namprd10.prod.outlook.com (2603:10b6:8:ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 23:45:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 23:45:45 +0000
Message-ID: <e21cbbc5-0038-8bbb-d657-268a955cc26a@oracle.com>
Date: Fri, 1 Dec 2023 07:45:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] btrfs: allocate btrfs_inode::file_extent_tree only
 without NO_HOLES
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231130224201.29933-1-dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231130224201.29933-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: ece94c0a-7185-469e-2083-08dbf1fe7885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b8fbY7lhYuDq5o6My4pXsAijmyFD6H5vCpoje/ES/L6CNY1zad7NHnzHxqmLdcM2p5v62qxym+SczKCWZthkyAm25224g8BI3tAegCfNnpZx4b7tk+YREPL0a9Y5C02DXe3ImLJ5njcJrHz5wB0lo9YminrKjRXzhuOmUT/FHqb3Rtz/2QNNn28qfaAR/79UHR4rdkPDTWNZtYbk+PWE3EGtaMjjcnbgJNjpPExI38cTA6ip1PLVtCeNqv2xp9qNV+yQHfbgy+SX71DPaGHVD/THyP/IvtMirV52vKxzZD/pFZcGsjLwRn9DLl9xBW1x3y+bcQD2/QJ4p6EH/qfB18wWbmKSuvqLtudCKBi5rxk5AUI4ZkAUMrFDC6tau5j+5llDGzxvwioUHXwlgFrchvgE1NzMnRAed6btuAnHIoy1w+Dub/ySoZO3yo7L1m/bWB0XjGxIk4xY6kbLPmo3+3boYXiLbIz2hb6EYgX4DlEfaA5EkqwmAV41I/fSIrpp/YPonNWISWJXkduqrCWf9HzFbOADB7g0y6dkU0E4M2FHul6jotCiCY1scKDKSslvuv0XrEL0A/NLi9mt2eO3TdMKFSCWZYUnYbFdyu9jiTwtxDHVOKl2S14KE/1k6IOp6ODjLKVrRVKzAM7+oP5VLg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(83380400001)(6506007)(26005)(6666004)(53546011)(6512007)(2616005)(6486002)(478600001)(44832011)(8936002)(5660300002)(8676002)(41300700001)(4744005)(2906002)(66556008)(316002)(66946007)(66476007)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bng3aktXR005NGpTb1I5RTlpQlJUYkpYVEVSdWJ2cW1USU5NSnNmTHJnYWRi?=
 =?utf-8?B?WjZ1Yy9JK1pQM0Z3ZStQbmJpNmV4NHhzTm9lQk9ZWDRzQ1BKNXF5cndaMk9S?=
 =?utf-8?B?SlpMdlhvOXZzNkZERjQwYzh2RW1iMEIrK2RyeUY1dm8vUEdINkREbk01SnlK?=
 =?utf-8?B?WngyOVl2Zk5sVG90WXNMNUFIWXdGN0tzRnpqOTByTTFIZnRISVhpZERnSExD?=
 =?utf-8?B?c0lVNktYbURrQlVVajQva3ZNbGMyU05UVm84Wm11bzRDZm5ZL2NoRU1pdnZK?=
 =?utf-8?B?dUpVakR5QTg1NE03Qjg2T2d3c0h5SWpicFRyeE1BS1BqNmE0QlUyY0RNNE5J?=
 =?utf-8?B?OUp3cXJwQi9TazRFazBBZm1yeG5FcWp2cnhMNnR5NnJmWnhtVlFrYXpNaWd1?=
 =?utf-8?B?YVNqd2FGc3dCRTBDV2V3dTZLWE9kU1FKajZZSExjNkpreloweUNITTQyN0sw?=
 =?utf-8?B?bkJQR1dkMkZrUU9lOU1OcEg5MG83Q3lFcU13cTlCSHo2bVVMbFFpc3VaVU1y?=
 =?utf-8?B?NWRTZkI4VVdyeWtnYmVDOHljZm9OWXkwUmN2NVNCcHhuRGdwS2FGNmJiNkhU?=
 =?utf-8?B?WkJYQ2xOc09XZzA0T0M1R2Q3T3E5cjBkR2NMSlRjMlh4MXRDYkk4KzBzRE5M?=
 =?utf-8?B?MEtkamdDb2kveGt3S0p5MkZhOExoY2lUVTdBMFRIeWlidDlxTXkxdGYraFNa?=
 =?utf-8?B?SHRiRi9FSm1YUmxBSGlUcGtUamZpNFJ1UXA2eHhvL3pZNWdTbVYrUXVmUGVP?=
 =?utf-8?B?YXluZGFvV2kzclBwWlJMUFMvb0VNZ3ExS1hiWHNyR2ZYVGN1aXJKenFyRm5B?=
 =?utf-8?B?Qkg5NGY1bTEwMmdiNGpPdHltSTJOakpBcnVIOVRwTVFUYnRKOGU4MGdZeGNu?=
 =?utf-8?B?SEFPb1NBRDNGL0Z0QmtxaG42ZThnanFoOHZmdmlOYWJpcDkwRUk1ZWRmVzNm?=
 =?utf-8?B?SXZwYkpqMkxrYmYrUU1ZZmZMUmk3OCtUaWtFbno5TmVQcFUxZ3ptSWhVblgz?=
 =?utf-8?B?eDR5SzNVRE1MUFNSdXZxRi9YczZvL2ZSMS96R0V5ZG5JdTBoakJZc1FhUmtj?=
 =?utf-8?B?dllRakFzK3Qvd3J5UE15dVhXZTBYdTRwZkxXWUI5QmRybzVtVTh0ZTJ5Q25F?=
 =?utf-8?B?YllidE5ONXFldWlqN2JWZzRJaWhIWUI2d0RVMnl0Y0pXYm9oMmh1RmpjeTVm?=
 =?utf-8?B?MW5HUnZCM1lYWTYrdnAyRldUYkdsdGl1TDBZUFRjcVI2Zy9zcXNVQ1YzZTl2?=
 =?utf-8?B?bmVFdVRFUmF4c3lwS2lyS09qK2xoejZKVkkwM3gwQVVTa1BKWTNIL2E0WFhK?=
 =?utf-8?B?QTd6Y05WSzlvUkRDTHE4VTR0eGUrNnY5VmhMSGJNMUVMRlg4cFBNYlp1R1h3?=
 =?utf-8?B?N0w0TzM2MlNkWmtsejVDV2lWN2ZnUlliT2dvRUxGZ1ZSMWlKeFMwUGYwb2Na?=
 =?utf-8?B?VEphbUcxZ0t2dkNXTTczdTFaelVwQVVhVVV3NkNQcTlSbVZjWjBkV2hGUmgw?=
 =?utf-8?B?S1lpNEQ0enpzNjI5WXZ1UzNKREd6Q3EwbHVGeHhoeTE3dFp1VkQ5RUZ4WW5Q?=
 =?utf-8?B?cjdxZFJKWHFWMnA3aGsxNlhpdTNmUWd3bzdjczJWTXZ4Sjh6SDZrVllkRHJl?=
 =?utf-8?B?WjRGYzE0MUtkQ3B3aURqa082ZlpCUmFhSTR4cE9uTjBNMmNsNnF3Z2NNcjFm?=
 =?utf-8?B?ZDdEME4xeVZZelpwV1JUbzlCd1g4UCtKLzVORDRNLy9MUkZQOEo5NUU5UC9C?=
 =?utf-8?B?YnI3UlJiZUt3Z3dFdys1Q1o5bGVGZ290V3E1c0RUeWhCZ09UM2ZGQ2xMNHd5?=
 =?utf-8?B?SVJRZG1MT3RXdnRzQ2dydGo1WUZ0bWc4aE5BdUZ0c1I4a0d0eGNnUUpOcnQ2?=
 =?utf-8?B?Z1REUVNRdktNbUNhallyZ1dvWUZQQVQwa1M4RHhMbi9DZVZxRjgrVmZHaDdB?=
 =?utf-8?B?TTRqcnh3UDQzclFXR3J3QUxrY2lSNzN6ZkJJdHZMQ1FwQTI3WTN0MU5ILzhQ?=
 =?utf-8?B?SmdDTUdxRU5uY2FzOUcwdlVBV2hlK3c1SC9sdU9zckV4YjRqZ1p3MXRvNWR6?=
 =?utf-8?B?c3c5bDViOWVuTnU0dHNYUXAxb3p2Z2RaU0JWVkYyK0xkc2xxV3hTOVpUQTJn?=
 =?utf-8?Q?PE98JCMIC9103oXZifE2k4Y5X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	maXSKdQlWzmCCwbQ6MxnmXtOYg8i0HNoprbw/Ka1aTdUFuXUbTst+K+Vp2pVJkKRH8UjneGQ1+f0vbAhhX7wugO9LBXacQt0KY2pynEU5eMsr7jyIwiVujBc67RBXFgQrdd/IrAJquMpm2JOZxDjtN1c5J0OqJHNILGfSHVpMKZajVJ+IRZdQn104GczTuR+Aktzjy/Wd1GBRrXxMnN0Nuahf+6Avj+3UaQcMPdLIvfmYuwWIq19N5gSMXua6AIkoQdt6Curtn7ueLeWvHZ9Mu1K+HqXxcylj5PanwSNTUbD+OhLRJghwlZwlBxBTJioFVYa+lCcopWoTz4XDZRZphlzi466+6ULDjt/2baFWP2NQ52tVvRFZhpHAtfORLV0/t6GoQBbExgLmgivTgYuCL7lbGJs6Tlb0l8GeAOz5iK98/cltiE91xCdu1EhTcDTPAUq0+TBX/yGOxQxA1splLdT6ZRzTFZsO0T8Y5WmpVMtxKIdFS2zTdv7HEtVUaXBfFkr4XvaxMvvKkminWce5fRefIzE5KW9WG9scf8aRQJjVf9mVZvj8lWkQzm4MrHDpkjlGlGHoZ180rRbQESojsh1YOenNb1O5Hu8He2Vhfg+UWqg2RjSst0eSZey2gEQgLNbGIpyFrTcGFbwr6O5fpsOAjc5bk1Uyddcl6DFVF7zWQ+4xWTIOiDxiHR9+XCW1vT4rpeinnInuNtfNY1h+qSQ28Rf4gFmriXGfvU/vWB88AdFI+R9bhyuZDrYluS3/kd5kVng4GAXHRStStyRLB+NTknrqBcLOe4lYBrQCLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece94c0a-7185-469e-2083-08dbf1fe7885
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 23:45:45.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqK8AqKaT/Tdezd5FPPMkq+amwCngPE/04hYZXXhvj6P2zWm6bN75J/gdARkxRsXuTURo4vMFm1/NGDdvIaGNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300176
X-Proofpoint-ORIG-GUID: KcxIGJDovr2sahsWU2lPfz1KQFg6dI4P
X-Proofpoint-GUID: KcxIGJDovr2sahsWU2lPfz1KQFg6dI4P



On 01/12/2023 06:42, David Sterba wrote:
> The file_extent_tree was added in 41a2ee75aab0 ("btrfs: introduce
> per-inode file extent tree") so we have an explicit mapping of the file
> extents to know where it is safe to update i_size. When the feature
> NO_HOLES is enabled, and it's been a mkfs default since 5.15, the tree
> is not necessary.
> 
> To save some space in the inode, allocate the tree only when necessary.
> This reduces size by 16 bytes from 1096 to 1080 on a x86_64 release
> config.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> v2:
> - add missing kfree() to btrfs_free_inode() and
>    btrfs_test_destroy_inode()
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

