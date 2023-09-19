Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F007A6180
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjISLlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Sep 2023 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISLlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Sep 2023 07:41:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6905BA
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 04:41:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6Tg2x027596;
        Tue, 19 Sep 2023 11:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=M7fwrVHxrH7MYT9htkk6yWIlE4wLaq0zJMI0ZOmfE50=;
 b=hWRz3mYSyt6PXZlW3/EV5FeMagHA9LzCIzvWpZCws7GxPC8msMGX7pW6dXJ1La8f6U3z
 2F8l00Xd0v+JdCHUakE0fG7UoNf3cTwgsxnYC1skFiksWY/jniz1w3r+9kvzJOMr33yx
 DeFUyTNdtO+ftNOJzDd5ZAZP9JNcABIOcY6sPP4+W0GA/ONjIOdyosQwLX6iUqJ3nUbx
 4jw/HTaLfDZChd2KQv8A3vpSCg91m23ytMXpUBexBHdTTyE1rqZHQinfm22Q5clYrEV2
 Otjg8TC8Nf2Npts9Dt4aLuOTiCZH0PeB3CFHvWbxJXBYw9teuXLhGdDRZNGZJFVL40NU tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bck4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 11:41:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JBKYWX015954;
        Tue, 19 Sep 2023 11:41:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t593c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 11:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4TNn43yYlYN0TeI5BAUuWhWFPrh7TIocz0gWdxvlXJft22hpKU/Xza+FRDJHzMGqMtulw9m4MFawfKrTAEsz8epz5t1d5tTwahyZsuR1wzdzZMbdQOxXgPAVUrn88dcrne91oIcytRORjTkvJgnd4E3rmn2jOLVu0sDIAJxKmOZoIJyD+pNm1rcOWbJehwZ2hfNpIGqJB6ogzhF80ETidMaplJfTWfrT54dnKUC8jyoThxq+bUI7ETF2UMDqKzPlL7VgXeaVnTGv0uemqxr1PABrnYX1sT8hdhA4EnI0oxIHu1+a7qEemv/0EVBkSX/NnDjD8MzLPyiSWi/hIZECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7fwrVHxrH7MYT9htkk6yWIlE4wLaq0zJMI0ZOmfE50=;
 b=AeJaN+Ff/3ufPDhwTMb769ljDRlYAJd2cIozMDbaKFfr2PWVWezxgkrO5NPbC7/QEUWTodBVdWEKnatTzN7dtWi51f/+FsVu4nZim1xg+798xaKYHrqfyOm9NneQI3BwWtD6wHOQLWcypaBK3Z82/DcLHbI4BmW3XRvlyh23I7pVeDfiGSmfKZwAuEN+EYB2x+GTtdKJO3wfxPucaHv7WnaRl3dpXuQf6UBV6S+xUN8QAIFyM60SNypizMzxpxquCSR4cl8XOIEcn8QB/MO/CTCUks+YeE11DcsIOfodrDosxJjBhxSCePnzWr14yx2xjH7bY6tmohOy7j9c1Zs/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7fwrVHxrH7MYT9htkk6yWIlE4wLaq0zJMI0ZOmfE50=;
 b=qrbDwKM6a9oEltfAM0xDDMZ4WNODBLL7t2Pk5FdO5+DDkR/1MzJ1pGrNbXZh7X5M24Vwit4E07wMnS4jev/OEpNS2b9s+nDQXLH7lauji79Q6lH3kqJPmckZtBRiZH8sNAWYZnqwqreagZn2o2+3QmwgHX8J9/nZ060WB265odw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 11:40:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Tue, 19 Sep 2023
 11:40:57 +0000
Message-ID: <ff65ce9b-c086-dc82-f316-756d9470b3f4@oracle.com>
Date:   Tue, 19 Sep 2023 19:40:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: reject device with CHANGING_FSID_V2
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
 <20230918224427.GS2747@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230918224427.GS2747@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a631b7-9515-41bb-71c6-08dbb9054a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrPvS8rEhrbN+0HTaRITcm+qk2ZeCNH0hImoEjh/g1XrKZz24hogaXvAt/9tIxkuU5x960rC2cg89PiczkF3M643aWOprwF2XV5koy/vgm11/CquOdazqKRGZFNcjYqRQztPOckreCVcqhERK6O1Sy4l071Y9XwIGMhUpbUnSFmiqgFlVwCqctQY46+MYv1MjU5WeVSH3DC4skgUltPBGBdd79hjGY8bIbZF827CFffhRQOScaijzSD/fx8nw4AWW5YhVUdJnFB3/LZnv7WvgkdhcrfrUN20ebf5ugfCKbEg+BgwIKbMLc78qAW4CF8BwrjDYoaSupgjkr9bWAPTuvWt9sUxqiT56JC3xNRz+XUflY36U+cmDnTVvgKDNDj1jpte09yn1vyUCxurVJPwZokIQmhByMHIgaUiVEUUFdyw3Ng9/g5d5PbaDlpR5Gn5CvzA7q/CcclH+MQ1p9KhN/PIr8DSrpu6Vr5O0XHaYwI4r+r+5P+t41GXDwmzgs+A/H6AOtHBNMNK9fAC451Zro0Y3RR9kP5rNAOCumE6MWycRgeUJjjxxURAR9l50QZ3WYOr8EW1WE1L/pyVxOnu2CHtBZkH0KAkv0rnT5+VBk5gtaGtVfXA5NGE3gMmV+kNl4gb+BRGa+Z0xLHW7LR2yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(1800799009)(186009)(451199024)(6506007)(6486002)(6512007)(53546011)(2906002)(26005)(2616005)(5660300002)(38100700002)(6916009)(4326008)(36756003)(66946007)(66476007)(316002)(8676002)(8936002)(66556008)(41300700001)(6666004)(44832011)(478600001)(83380400001)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTVFdkRVZm1WcVpYdjA0Z0d2WHFwbWJmU0czV1FOOWQwSnlzVytrTHNLVG9Z?=
 =?utf-8?B?SVNuRU5LbmFDNldoYy92RUtGY0JsVy92a0hiTkVvTllOLzJ3d0VKUGdtUmZo?=
 =?utf-8?B?aHlHQ0NLblBaOFIwb3A4a3dVMXpkY1h1aTZDWGk3SllCZ0Jwb2MrV1oxZ0lq?=
 =?utf-8?B?dXBWeHdwWGV3ekxhY1hUeVFTeUxrOUN1Ym5ac3lNWFBTT0RxcUJUUktlbFpC?=
 =?utf-8?B?K1RnRE5HOTVjbGIrU1FVS1NzUGtNQi9EQmdpRDd3LzVzdlBMdWtWTDJmQnd3?=
 =?utf-8?B?UndsMkUxWW5selloMW1mQWw3N1J5OWxMbkFBL0hpVmVBY2FVOVVSYzQwWmxw?=
 =?utf-8?B?cnVzMytjQzh6YXlLd2srOE1tUU5NaUdndnpYb1hMVWk5aVNiOGRvSnU0NTZF?=
 =?utf-8?B?N3loZGRSWEdBakh1djFnY3o5NzZ1OGJuWnEzYU5Ic0VHRjFUT3BNTXJVUnNx?=
 =?utf-8?B?UlY4WFBLQWlvNFFMdEJrcGRSODk4YmZuQzNDR2ZDSkxINTg3ZE9TcEc4UVhT?=
 =?utf-8?B?V0RNTVpKYStkbEtSS3NlblJtTTJhemJ6YjAzRjcyQy9rS3JoM2RJN0ViWFhT?=
 =?utf-8?B?aWdnbVNDQ2VlMU9hMFZMTkpERWExSS9SQldBaGYzZXRKQnZzUlVuelkxa1g2?=
 =?utf-8?B?NWV6bTVScVFNUlhRWnZZVmxYWGdsa3dtdjhxV0VoTUZ4N29KZGhZQnFFTFVw?=
 =?utf-8?B?VVhCZno3Q1poZ0ZZdTl5RGRvMXhPVkF2dW1sNi8rVkdsb1A5aUEramVpS2ZF?=
 =?utf-8?B?aDRqSEM1Q2xrbXBEU3EwRnVKM1cvd0NVNHV1OHp0N0dia3c4dGhxbFlFZk1C?=
 =?utf-8?B?OXhUSHRBT2U2RDUrNmN3eXE5bDJwb2NjRloyK0lyY0plNWthOFVIQ0EycVFR?=
 =?utf-8?B?dnZ4d0lpTFlxUyt1OTBzbHJ3OWNVT203V01ablFJQ2c0bmU1VnFsTWVqQWh0?=
 =?utf-8?B?N1lXQXBwcWNpRHlzb3QxL3NJcHRxR3NiaDNIZ3ZSdllWLzloRGp6VVlIMTZC?=
 =?utf-8?B?YzFZamo4MnpjVVI0a2xEb3hHaUkzajNxWWdVUVRxZkRiK1FEZjUrellUMlNR?=
 =?utf-8?B?MkZxb1RudUZXWEI3NmFCR282Ym00N2VGZ09GeWtpdmxISjdUQzRUMk5Cb2c0?=
 =?utf-8?B?bkJHUXBKcGdNVEpSbXIyR2NkZkVxZ2FDT1FWbXJUendRWVRGdExLY3pwQ3Qy?=
 =?utf-8?B?M0dTNkYvdVI2cDBpWHo0QkxVNGtHQThjSGNUT2J6RnMyckZJaFUrTU1oeUtq?=
 =?utf-8?B?K3RCRlpIVU0yZDFrZitXNFRuSGJVYzhDQWJFdDduZ3RRR3NPRUhNMm5oWTlB?=
 =?utf-8?B?dVJVcy9BeG1oRDZlLzB0dUJxS1loR2NuYkh1L1FLcTFHVk5MMmEyMVV2OFZM?=
 =?utf-8?B?YTRLY00zRjhNUDhqdFFzVDZNNm1XNjlMTGgrVFp0OVlTV01Yakw3NDBrb0lV?=
 =?utf-8?B?L1NYd3pDTHMvL2psT1JGemxpTTdvN2hYZHlCS1hRTm5ub0dFdktrempuclYw?=
 =?utf-8?B?U2dzaXhDMm5WNFAxdE9aU1JFL2VwMnZOalRWZ2JtRUdBczM5b1hYcmc5c3lm?=
 =?utf-8?B?b2RIUWhHYUlRVnM0SzUwM0VFNXlCTFdzbHp3ZEZSTFlCbTVNSEVsNEJvMktR?=
 =?utf-8?B?ZWl4cFQrRzI0cHdmci9oZ3p4bWw3V0ZMNzFiQmp6eDdHcDZuTXdEeGJHMllH?=
 =?utf-8?B?a1JFNUlKSEFodjd2M3ZreTFMd2NZOTR4dS8yS3JqSDBBblJsOEVYVDMybHdx?=
 =?utf-8?B?YjlJRCtLRnhJb21GU01aN3VGczN5RHM4Uk5PL3lXcUVYeWVpdE1Ebm1BQzVO?=
 =?utf-8?B?V1g2VHpXVWphSE55dG9kQTBKQm1xTkFFeGdzSWZSeUMxN2Z0SElSWFM3NXpm?=
 =?utf-8?B?bWcxQmdCUTM3NmhzY0ZPSkpsZHNjYjFrRWFNUHdXTkp4OW5VQmxObFQybCtt?=
 =?utf-8?B?SmJKMldFTThENUd2MkhIWnN6bDBORjdBSXJnMUlyU1JROWRCcnJ0bit4ZFJ2?=
 =?utf-8?B?bWhqcGFaWWRiM2EwVVhxZFFPL04xbHM3OG1DdGRLRFpBS3lNVm0zNjVZc3U2?=
 =?utf-8?B?ODFjcjM4c2lBL1JsQWRzRmJEczBEQXMvbzZjSzF1RU1rRUo0ZU5nTjVMV055?=
 =?utf-8?Q?20LMwAXTbgABvkpBTLHkomUjA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RIX9i91qiCPTMLBXTFPEGoW+15LLF0Gfp6D44bQpcppow6EgXcloHDndoNcVixrnPIbE+0dpOA9an9Z7UO1KfjCfnVfbY5ifyffhXrURhOu9TiyxNoJzI6KRJyobiTjIMlAlJRvYNYClBuaZr3umfaWcojYvDWJw7cSYjbfj5AbhN7/TqpVReUoCcB2/dqazdCYF8gp95JTPISH/OyZKqjC+lzszVQnpL3uxbiiuXHTDbWiQlVn9uSZucKc/yiSoq7Q95iVGBzYH5434of8FJOQ+rUtFjStnN/+dbdAnA5gR8+sKNHNXVjIbRgZR0TraZyF79hAaNPVJC8osTKBceNuQyLhfrpXinMA8D7mAZtOYYgJYdxFEzQLRLJLn4GWKOApUAiUIh3iTp13pWtEj2j2H+vBJMz/NisQ3YYSFmD3YKg/4kW8tR6N7jJagVHUpDThZp1UUeRA3uT9q/gzkNzoELIFrJuf9WKUGwSEQ3cfK49LZGu+c320aWqiT2Q0PR2du3ei9ONfoCQGOHP5WYpzAHXIcV7EOzZjODxSjF0NwGGoMcKXt5Vdc1zxR4mFWC/TV+Xa/CS9n6Qmukr64QG+0NZvtQz4aRlXWC+2HM0T8fuRxOoNvpxOaTZv9wP1y89lt3zm2pFEGl3c5tg4wPZQC+o7vjk2GGN9QXV8fTP/fKH/nt6fhooMsD7iiWYe2d4apjUDCeFUjVDe/i4XfNVu4q3MUEB2R7EcQDbW/8Thze8YToRYjbQmdMjs1vm0DuuezLts+anI5uNAmkTe1b1DIKy3glws28fjQ0UslH3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a631b7-9515-41bb-71c6-08dbb9054a0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:40:57.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0E1E7t9/5fK1BODva5dlt5eSqHFXJrekfV6THkYi/BRYTBxfw3afi9vXb7tBFgysFN9cYrG3+2QFztJfoZVvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190099
X-Proofpoint-GUID: G6Px1lNIrOEZ-wrC_SyoRWJb93TbAo4Z
X-Proofpoint-ORIG-GUID: G6Px1lNIrOEZ-wrC_SyoRWJb93TbAo4Z
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/09/2023 06:44, David Sterba wrote:
> On Wed, Aug 16, 2023 at 08:30:40PM +0800, Anand Jain wrote:
>> The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
>> where the device in the userspace btrfstune -m|-M operation failed to
>> complete changing the fsid.
>>
>> This flag makes the kernel to automatically determine the other
>> partner devices to which a given device can be associated, based on the
>> fsid, metadata_uuid and generation values.
>>
>> btrfstune -m|M feature is especially useful in virtual cloud setups, where
>> compute instances (disk images) are quickly copied, fsid changed, and
>> launched. Given numerous disk images with the same metadata_uuid but
>> different fsid, there's no clear way a device can be correctly assembled
>> with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
>> disk could be assembled incorrectly, as in the example below:
>>
>> Before this patch:
>>
>> Consider the following two filesystems:
>>     /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the btrsftune -m
>> operation fails.
>>
>> In this scenario, as the /dev/loop0's fsid change is interrupted, and the
>> CHANGING_FSID_V2 flag is set as shown below.
>>
>>    $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"
>>
>>    $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop0
>>    flags			0x1000000001
>>    fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		9
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	1
>>
>>    $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop1
>>    flags			0x1
>>    fsid			11d2af4d-1b71-45a9-83f6-f2100766939d
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		10
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	2
>>
>>    $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop2
>>    flags			0x1
>>    fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		8
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	1
>>
>>    $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
>>    superblock: bytenr=65536, device=/dev/loop3
>>    flags			0x1
>>    fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>    metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>>    generation		8
>>    num_devices		2
>>    incompat_flags	0x741
>>    dev_item.devid	2
>>
>>
>> It is normal that some devices aren't instantly discovered during
>> system boot or iSCSI discovery. The controlled scan below demonstrates
>> this.
>>
>>    $ btrfs device scan --forget
>>    $ btrfs device scan /dev/loop0
>>    Scanning for btrfs filesystems on '/dev/loop0'
>>    $ mount /dev/loop3 /btrfs
>>    $ btrfs filesystem show -m
>>    Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>> 	Total devices 2 FS bytes used 144.00KiB
>> 	devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
>> 	devid    2 size 300.00MiB used 40.00MiB path /dev/loop3
>>
>> /dev/loop0 and /dev/loop3 are incorrectly partnered.
>>
>> This kernel patch removes functions and code connected to the
>> CHANGING_FSID_V2 flag.
>>
>> With this patch, now devices with the CHANGING_FSID_V2 flag are rejected.
>> And its partner will fail to mount with the extra -o degraded option.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> Moreover, a btrfs-progs patch (below) has eliminated the use of the
>> CHANGING_FSID_V2 flag entirely:
>>
>>     [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
>>
>> And we solve the compatability concerns as below:
>>
>>    New-kernel new-progs - has no CHANGING_FSID_V2 flag.
>>    Old-kernel new-progs - has no CHANGING_FSID_V2 flag, kernel code unused.
>>    Old-kernel old-progs - bug may occur.
>>    New-kernel old-progs - Should use host with the newer btrfs-progs to fix.
>>
>> For legacy systems to help fix such a condition in the userspace instead
>> we have the below patchset which ports of kernel's CHANGING_FSID_V2 code.
>>
>>     [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
>>
>> And if it couldn't fix in some cases, users can use manually reunite,
>> with the patchset:
>>
>>     [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options
>>
>>   fs/btrfs/disk-io.c |  10 ---
>>   fs/btrfs/volumes.c | 166 ++++-----------------------------------------
>>   fs/btrfs/volumes.h |   1 -
>>   3 files changed, 13 insertions(+), 164 deletions(-)
> 
> Please split the kernel patch in two, one rejecting the CHANGING_FSID_V2
> bit and then removing the unused code.

Yep. Will do.

> I think the scanning code still
> has to recognize the bit and skip the device, I haven't checked if
> remains like that after this patch.

Right. This patch does it. We only have to do it at device_list_add()
because mount, device-scan, and device-ready all rely on
device_list_add() to scan.

Thanks, Anand


