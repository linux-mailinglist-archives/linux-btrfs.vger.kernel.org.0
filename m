Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C578873CA5A
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jun 2023 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjFXKB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jun 2023 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjFXKB0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jun 2023 06:01:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B0BE41
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 03:01:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35O8sY7j013293
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 10:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JcrG39SuZWFBhuYauWbDs2Y7HYflPFCRuBOKLsdGQAs=;
 b=C5qLuUxcMKhWAT6dkhuAPqzixnKK4Iwwm7KtDsyHpV/98BOERHB7wbY5hOIKPeSJSdab
 24+ZDPBuDkLeiITbkIKJQo46ecIzTd6qj0xQHTZH2zxAL0MMkeFzVhec9N09Hgw0tCB9
 ByUYhCaDpBjPK91fm6GEVq5EnKtwY+B/VTXqn/DPevnMvV71IENmGmOAlzbhRDuhucZd
 Du0JIboY8TDY2cpx4ywaPNChpjuQhqNm2lqakTvbSzcmKIdEcfqJ6KMFAuRu+lg8J21+
 YwdChLm1a5hdWRJWAkyBQOSZSV0qIlVdr4fwk59sKQ22ADCk2xd8Y+vVmxWXpGJYCkMK DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca06aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 10:01:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35O8EVuP011149
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 10:01:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx1apr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 10:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY3XDSr36zT523lgfSRQptxOlDrcDst4FXRXyqeXzwQdtmx83tP5jEojs7732yyzCxUZNleIemOfBUTDi1Bg1/WS4Iy+fdA8vq5thVwrzNop1ZxsTySgJNxouS3G0NO8ckYDS/pHbxHhkvijDP/72b0FHiftuERq5J+T8qK7JV09qYZba+d5AnpHF3t2lDhjc7n/58a/wxM0rSAHa8XKQ0Pb/9SoLs5zXSRYVOGVxXkhdp5lgS3zTYkpNG8wOA/4tWD4Gbqrr04qKoIUqmcr1B2lQFlV6JD7m3g5poEqlwJaMNFhNNhGy2dqNNjirhbgs+GFrMcjc6yc5//I5Vm+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcrG39SuZWFBhuYauWbDs2Y7HYflPFCRuBOKLsdGQAs=;
 b=RhLJqmOm9a81YTCh0+++YSL+kqqqBbUkoJMCylT7oYfXrmcK2kYQ8FL7RIe6EGTB8Ebn68M47abQTVmFhuo99JfYMGRt1wYgYsV+LjHhdL78Kpr+5Kp+xoJ7zAaFJtL6GJFzh0GioIUNnXSipyRUqCOSeGPuY0o3RKuFg9eYgl2pZ5p/ubFQQPYetV8loX06Uk8R4Bq8LHB9lwsdOV6ZatwI3UdZ/nop6/i7oX4DGuPhu6Tp8VvdakzJzOTUFc5Z/bd7hE4AYBPqWIWVzXpypdIHZqKCz/JQhVCteZwwfq9eDGHnmQZgwX/rIbmUqQ4ZTrzJlY02oWl2Kh1yEj0fEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcrG39SuZWFBhuYauWbDs2Y7HYflPFCRuBOKLsdGQAs=;
 b=y+dW1PTsy3HBbwPiogAo6rrDgR1B04mb+yZIKSOxYsGVTZOIo2+EMSpD7CjHJGYflW3MOFYByKvX+P8BVMzcVI6BeilzXdF7/39oP8EShn0hs0GajIMjvrTk9r8eKdfRwSG5GiFf20NQXG1yjPfMwJ1C0ZudPLOacWaKi3ryn10=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sat, 24 Jun
 2023 10:01:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Sat, 24 Jun 2023
 10:01:18 +0000
Message-ID: <71c11d14-bb1f-48a3-c8ba-6f98b6d1be7a@oracle.com>
Date:   Sat, 24 Jun 2023 18:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs-progs: dump-super: fix read beyond device size
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1687361649.git.anand.jain@oracle.com>
 <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
In-Reply-To: <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 6893255e-5f5d-4d3e-f594-08db7499f46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0KriJdmPZHKG7v8FrA/ff4Qd8d22M7AxF26lE5b2VW8GNvG6KwvY3qZH0JtKLUB3dnE/nfOmgn1yNOK0Q2xam4AXe8lczDBbZ89QGMJHAvLKedN8qDFJ9m6Pn2oYNZheMZxolPLf6lm3ixWYibZMZJ8BHPU12sRZl9b6V5TMlKV5PhayaxWiP+bMaDUX9kgQ7Bl5zFAB4+jpHTTPz919LFoSuLBLrIWRcTIk2ilQhcS+mgeHaJPbkz7/8oiBpBNn//1sl6zjeJfrBMD6EiV8joOHU1OdufaetJ668T9lpnsDHjVj8qUZa+BLaFualTm7bgszrk0zZ89A/2PyXl4K1ORv31l+QlPVKjbpTHN2HZ1mcB9EYRokgOxyYTImyllVRL6HndssP0tOqsu3OEjnkII0Eg+TKeIY/USKMRnC4N1l11dZXJUWfp1VNWiscLLHINSzQyNpQlESHP4JUJmEKbCDUBnwLJPAMHeSNkCvdsLeoXEUASCyxf+ptPKZvVaqA/TuFyUI23TojJgt6vU40ABIEBCIpIMjQif7HXw0w53ggPbYzNqVEgvpmBAr7XH5sfzPyEyGQyL8PaOOccZol19Nq7JzWDPYicjCWSXngBJRNKJg/UQc4pCmPJGVRNpEQ+oQOxy/F1E8FldDfD+sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(8676002)(8936002)(66946007)(66556008)(41300700001)(316002)(66476007)(6916009)(53546011)(6506007)(26005)(186003)(6512007)(2616005)(478600001)(6666004)(6486002)(2906002)(5660300002)(44832011)(38100700002)(36756003)(31696002)(86362001)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bms3NGkyeEtxa3Q1aTRuY0RhUDhFMEdCNUt0ZjZyOHlrVXpsZ1FyQXhDUkZy?=
 =?utf-8?B?YUg2czM3OXAxeXQyWSt4SGF5L2pNUzFtTWVtMmNTNUgvcVZOSlJBZGtaOVVy?=
 =?utf-8?B?STNWUkdXb082d0dDZXVGemdTSURvSmUvdStTRXVGOFZlUm44ZnQ3L1JCWTlZ?=
 =?utf-8?B?ejVhRWlDbzRaK0FTTVVMenFnR0Zndjd6ZzBNMHhSMDU5Q2RNWWxhNUZTak9Y?=
 =?utf-8?B?THZ2VjZpT1M2OWRSTGxGUnYyd2pJV1NNTUFYT1ZRWmFmK3dPdzhYNWhWVWRy?=
 =?utf-8?B?Ri95L2o3S3QzTmVhTEVZQnVyRmpDUGFwcmJpUDhtcHNlZzU0aVpzOXA1L3o4?=
 =?utf-8?B?eDk0Z01iUEl4QmV2OFJpTjk3cmtiY0VEblU4eHpYTDhYKzV6RHd0djk2MThY?=
 =?utf-8?B?MmhMM1Zwa3pPL1laN1JaSnkyOTZlUmtWSG4vK28zVWdVM1h6bHBEaytndTdk?=
 =?utf-8?B?b2t6OXhSVjdHNC9xcTJ1RFFQbEh4MFhpRUkxWEhFdDlMUFNmNlJwRi9pRWI3?=
 =?utf-8?B?V1U3VlBsaEtXYnlMZEIwMzByaUNOTVZWZzRKZGxLWm9KaTJacThUVGFDWXQ0?=
 =?utf-8?B?eWVFWTZuaTZlZ3YxaFdwQXVmT0xYWEtQVU4xZWIwaGRLK1N1dHVBQ1ZxejhV?=
 =?utf-8?B?aC9CMzhMYlE2bzF1eE93Yy9tdUVZNmJrVmxuY0FtYUs1TCtzQ0hJcU9Hd1Rx?=
 =?utf-8?B?ejdrMUFJRU9SSmtUdWpsVllPSlk3LzlCOFVGYWhrWklzdGxiV0lmZVR1N1RZ?=
 =?utf-8?B?cnJsTHB3Q0VHbWs5UFBKbW44Z3p4VHVacHM2NVNHdEM0ZGhQY2ZMSXhCR3lz?=
 =?utf-8?B?anJuMXdQOVRGL1ZMUEU3K3lNLzIySllmOENaMkwvZXQ1Z3JoM09GT2NZQXVs?=
 =?utf-8?B?SUZJWEh6WHhmaEZDQVN0Y1F6SlhqaFZ6bzFCMXliNXF0MGFXSDZSb2s0Nkk2?=
 =?utf-8?B?VzkwS2tHU241d3ltN0lhdUFzRGRNQjNGSWRYL29wdm9aUDJXZGMrb1RUYjV1?=
 =?utf-8?B?YWNvc0o5dHd4RjA0dkRWNStXcFFYdkE2QThNYzl4c3pmRkpleHFZdmppVWox?=
 =?utf-8?B?L2JXTXkybEtQNmRmUGtFeE9TRUFqYnF2d3ZoZnVNK2xLUC9aeGk3OUVlR1VI?=
 =?utf-8?B?aUNHaDFKZUpIVldJc3Yzb0N4Sldtekw1WmtnQ1RVaWxoSUc2elRiYVRvUmpS?=
 =?utf-8?B?WndNUElTT3J4ZHlmZzZtVFl1WkMxaEdnZDZ0alBLTlMvTEVvNE9EbzZpRUpS?=
 =?utf-8?B?QnhUdnIrZXJMc3VNVEJxZ01PdWFWNGZTcHBRTlFoZWpsQmJyYWI4WkczNHZN?=
 =?utf-8?B?OTNOalRNYlU0R2kyNEtseldnckZLZDdGM0VYNTdEOFVvVTBYZlVBMDE2anEr?=
 =?utf-8?B?VXl3NFJ1VmNZV1g5ZU5WS1lvY3lwNER6ZXl6OWpSK2JqbkNQR0FxdzZtT2Rw?=
 =?utf-8?B?NkZTNHhJQzBlQW4waGcrTjFmOXdYcjh5MjRwVkJySGtxMjBNYkZxd28yZ0ZT?=
 =?utf-8?B?MzBLWkQ5ZExVQm9mU1NQMmdOK1JYNVFTMU42TGdSQ1Uvalg2Rk5xRWF2c0ls?=
 =?utf-8?B?RDh3dDFnOUNlWDMzaGQyM2pBaksrRWFNQlNvUlFhYXdKbXErNko4Wmp1Z1RR?=
 =?utf-8?B?R3BWMUNOa20zbmdud21CV0tmVWJ4TVpZRm9yQUd6aXV2MCtNdDl4Q2Y1QjZx?=
 =?utf-8?B?R2Z2bG42WVMxVm15NUYwSjRBa0M1anpNR2M2Zk1wK2JRS1pyUUZ0bDM3ZzMr?=
 =?utf-8?B?VzhZR2hKZ2l6Z2dDL1dacE9sbWV0dGtwWWJ5MUpXUXJ5Y2toME8vU3RyajdJ?=
 =?utf-8?B?NU9nekVhTXNuM1RtcU93ajhIVXQ1Y3U4aWhDSFFuSEhVdVRseVZHUHVEZWQ5?=
 =?utf-8?B?b3BHVzBRMFNhdzJOWEUvekxBc0ppMXdUVVQ2Ty82K1VTaFVJRDVwWEJ6Ni9r?=
 =?utf-8?B?THUzN1BmZ1p6eTFCc1Y0VHZsbitTcXc3cUVrM3ZoNHY4K3E0MnBORmNXUDVV?=
 =?utf-8?B?b1FlRVZNSFRpTDBEckV0eGpZditMdVJmVThUR1oxQVhTR1lqUEFYcDU4TFNy?=
 =?utf-8?B?TkVwNjQ4aXB6dkEwdWRUejNONWZwbk1xcFduWFRvUjBtblpSZ3hOL2p6MXJP?=
 =?utf-8?Q?TyT2Gcmrk7PmX+oapZqGsy63V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bdgsYNk+EuPYiS/y2D2zobtolXsUTSF5GGkjgnKMVXDRhi9R+ZTIYRD+PrFrWF4Jhz1y9D3Hi+CL/vUkRf11kuO2v9WoI1xz7U0+ri959vRoCg137XBsEfK1oLPzV9MSnCxz80SQLg+NNk9hMfLU3INK4628XSLuUc4xLCdY8fQ2OxFBd6twVM/OuTS1Z1lKmBfBD2d0dERI+5fHuntZKxT+G1rWUQyMWW7Zre04ApAgW5/ANhelkyQtp0A7vlnAmibZCK+6pq+i4gwxInfMKMdChRqlUom0k5swcsOnqSP+qeR+/iixyRLpa9YzD+ZGL1CJSEYt2gDSv5eG1RF2L3qOSeyfMXQUURyU4WTe+rEVDDxJmcCMFtNGnu6tksZVhQJVuux6IeKZo3oJW5CdkRjbRWVxrysz+xganghyW903uT9OuEk34zdAAfNY7SoUiHb8HhMw6V5ZHXZ/p9sFaVDjQEHMbSkXEymDjsiNW5oJa+UDXvpx4k5RQ6Wtiq46frZtwVF7rIZZyvr6t1UkWt/Og6XSaf/ryUg9mj8+co3Tje06n2jMKNlc5NxsgPP8GAzhJ+ZuJVFaQALjsrXcbUKFFteQG7Sjn9b47p6BHqxc5rq6Y7/o3Fi+rcasr0LysUo2UVyFCJq159mSy86Qqd0BVFzKb3NxM7GPZBzYQQwyVdsTGWc3BKSi7dcnqNh1k1d7o010YkT+HzvEdrL7aa3UVGld6UYRG2mewpmYyC7rHnnLYRnqAeCZ8gjD9lBIAIl+MNMRJkTbOXY2rA21Sg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6893255e-5f5d-4d3e-f594-08db7499f46e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 10:01:18.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyuxtFsBBn92+cIC5kUN+F6JCop7ohZklQBO+nWXQvLjd24sCqqNV3L7RoI/eEMa/TVnicD9X4Q3EAeAtEifAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-24_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306240093
X-Proofpoint-ORIG-GUID: juLqfG46_ERk_Rb8y2tHPDYt8NDASKfu
X-Proofpoint-GUID: juLqfG46_ERk_Rb8y2tHPDYt8NDASKfu
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Just a note:

This patch fixes the following xfstests btrfs/184 failure on aarch64.

$ ./check btrfs/184
FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 a4k 6.4.0-rc7+ #7 SMP PREEMPT Sat Jun 24 
02:47:24 EDT 2023
MKFS_OPTIONS  -- /dev/vdb2
MOUNT_OPTIONS -- /dev/vdb2 /mnt/scratch

btrfs/184 1s ... [failed, exit status 1]- output mismatch (see 
/Volumes/ws/xfstests-dev/results//btrfs/184.out.bad)
     --- tests/btrfs/184.out	2020-03-03 00:26:40.172081468 -0500
     +++ /Volumes/ws/xfstests-dev/results//btrfs/184.out.bad	2023-06-24 
05:54:40.868210737 -0400
     @@ -1,2 +1,3 @@
      QA output created by 184
     -Silence is golden
     +Deleted dev superblocks not scratched
     +(see /Volumes/ws/xfstests-dev/results//btrfs/184.full for details)
     ...
     (Run 'diff -u /Volumes/ws/xfstests-dev/tests/btrfs/184.out 
/Volumes/ws/xfstests-dev/results//btrfs/184.out.bad'  to see the entire 
diff)
Ran: btrfs/184
Failures: btrfs/184
Failed 1 of 1 tests



On 21/06/2023 23:41, Anand Jain wrote:
> On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
> failing because the command 'btrfs inspect dump-super -a <dev>' reports
> an error when it attempts to read beyond the disk/file-image size.
> 
>    $ btrfs inspect dump-super /dev/vdb12
>    <snap>
>    ERROR: Failed to read the superblock on /dev/vdb12 at 274877906944
>    ERROR: Error = 'No such file or directory', errno = 2
> 
> This is because `pread()` behaves differently on aarch64 and sets
> `errno = 2` instead of the usual `errno = 0`.
> 
> To fix include `errno = 2` as the expected error and return success.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   cmds/inspect-dump-super.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index 4529b2308d7e..1121d9af93b9 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -37,8 +37,12 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>   
>   	ret = sbread(fd, &sb, sb_bytenr);
>   	if (ret != BTRFS_SUPER_INFO_SIZE) {
> -		/* check if the disk if too short for further superblock */
> -		if (ret == 0 && errno == 0)
> +		/*
> +		 * Check if the disk if too short for further superblock.
> +		 * On aarch64 glibc 2.28, pread() would set errno = 2 if read
> +		 * beyond the disk size.
> +		 */
> +		if (ret == 0 && (errno == 0 || errno == 2))
>   			return 0;
>   
>   		error("Failed to read the superblock on %s at %llu read %llu/%d bytes",
