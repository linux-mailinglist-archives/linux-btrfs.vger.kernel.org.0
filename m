Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59C7720034
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjFBLQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjFBLQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 07:16:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B913D;
        Fri,  2 Jun 2023 04:16:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3520NsMO022248;
        Fri, 2 Jun 2023 11:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lq7ylwAqN98PUAo99qZ5pbNxgDls7mCLvzvDFRGzHhE=;
 b=i/Vh8N3b8QRWitdMzIaHeOgkvHeJZUkgXXzfj7+7ac4z+QQY5K0Y4VtWHqnwHlq4ix+a
 wPVtCFUsbyeSddvJDMHbPgb9CqmkkcTRVcuDH/3jIONbSjAywoi1xL0Vuzlz/rPTr10V
 XEkxAkk042dPdBMgRn9n4z+1k/iL26+CrBFHYjwc9E0vx7iieZonsK/4UNNvC5UJ10ee
 gmvgqJATmfK/Uq+HO/Uu3Ak8HxpEMTr1e4gC7H8EZ4S+gscJiFVcjdAuERgLUhxGHqpp
 DQxotbi1Imoyf/FkU5jnmUz9a0Ej8o2jJwGpBPe/aK8EqEGqO2qjW0GCafYCLPtBS9qx Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb9aq4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 11:16:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352B9cet019789;
        Fri, 2 Jun 2023 11:16:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a8ppu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 11:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2qycqQV7JXmbotVpuJB2BpgZ7b7fHkzV5QMJv09huZCwfa3rM/ulhtLrj0vjyIQhVhKQ50l+bzIoCvC6gBbgjLHJy2d1+doc4bEMuVZdYtCXLwwDbQQvBGCGI9Z1r8hGTkyKxV/tFQWnnAc+KoLt+EKDGEKpaXghrZQ4u+4Znugr4PZw9nbOozDcNJolkr/CK8cqKsUnFERht2iwBVvow1R+W8Qc7gjIdtzSAkkKKGcQpijJ3WwPBaWycTzgNDjO40JsXMhl0XgSQvE0tTjqG3zH4bDOmTNM3EGVsrJ5+QAItUe5VtSRSdnLx8U8kPCuGxbFplpkL9LEmn/ac+iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq7ylwAqN98PUAo99qZ5pbNxgDls7mCLvzvDFRGzHhE=;
 b=BhM0GuBqXybtoZ5lowvafdGWjAQgt0UG3M5ZxXiSu0w2z4+wkBgKVUDkYQXCIL4YN/iqPM5J6Kxyc0ZyhJe9m9D/zTIQ2GqCf6ZFmrNaVzB7Tf2ILJOz8YEVLcr175TDuXpDHGLHtQZYx5BGW6C/00PaPQcxunuDvFayls+9oCciFttgAawIVM/XAZ6fkSz+2Sxru09usLSXaMcPIUTnn5T8ImdbLEL3cLFVt1rVS1d9PRG4WyPH3iv91shn4RzthkT+3obaw8aDxn/HyMKL7aoF3Yqm8RdfHLZsPJwdoliS9OpyDFxtsnpNXSa0i6exuI5JQvrxv0ug0rtpgP4Urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq7ylwAqN98PUAo99qZ5pbNxgDls7mCLvzvDFRGzHhE=;
 b=jlFpi0Y4ZogSrA2BCQ/bj5bBXUCLfHOrb4ZNRGSYbNi0PetN9pScqaK65hs9F4dWAr6SfHhiU2kPg6u1nqPz4Uh8WlSftbhGSskwgbNdlrkm/4N2YHrzKBtbC3ji0X7Pud/Ioxk4SbivdN+ID+1qiQlBWpcxtWcq4Lptgz2CqFU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5691.namprd10.prod.outlook.com (2603:10b6:303:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 11:15:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 11:15:57 +0000
Message-ID: <171dc93d-3d5b-81e4-d126-611468cb2404@oracle.com>
Date:   Fri, 2 Jun 2023 19:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] btrfs/122: adjust nodesize to match pagesize
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
 <20230601093257.d7q3mdfliwly4o77@zlang-mailbox>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230601093257.d7q3mdfliwly4o77@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e254dc-e220-4416-0320-08db635abca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8mICCpywqfWvczvdhApKI2wtojPn9LVqnvSEl7sp5R3/+rdINVKtuNbF0ezvejseMMKcNydIFKux9QVxImGEbq92CTmZn5jXCoY8ZPeJkuJNdBxLYnAb6Ms68gG8TBTI1yZYCDVPPqyMd+TbQkAVOoP51EOvp9jA4N00q7z3tMMAGpemiX8xtzBSLdMxWe6yCE6BC2MK2Z8iuh/ThA1U1GjuaSQ/rLQFyjZt1UVbI0vMRyf8cWO/qtXrI7CAUK7FXWIt51FkzhS9eYYn6RAwJNYxQeYPp2zG2N59dcilNenqmYDBn6xxzM4fR8AuHMvd55wGooujgsZblvND8G3a2HXFY/bA6Mb8rCw9rWiyeyqNGokU3A9xgP7dhjuVaJ/TWvf6bx+qIKP/OLTRcm5VOuC1CZxWxc/2K5PEEYwWfdmK+FZjVioTJ1uD0O76O+NqAdtLLNbREOEzgMKWTlCbjiLdhMNqm+zF9Aze42pa6dMb6aDetBObtg+TKpKNgA/Bad/ppAkDSdRgqrU5hKr2Y5kXQZ5D8pfbUwsqpy/psUQu5pBSkFiyfrQMTO5YAPHDD2oESQP5uQWTvOMm+OjQk0DlRADQ7ZE9mOk7fjE9JJR+pFNVIQ7x3HjIewmw6Qtm06Y3zoRjgp2ZNyhkKWk+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(316002)(8936002)(8676002)(2906002)(4326008)(66556008)(6916009)(66476007)(66946007)(41300700001)(31686004)(44832011)(5660300002)(478600001)(6666004)(6486002)(53546011)(6506007)(6512007)(186003)(26005)(2616005)(83380400001)(86362001)(36756003)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cERTRmJYN1BabmlnbTZUdjQ3blNLZ1FaRHlpcHpqOGZEckx2ODFwS0duTlFL?=
 =?utf-8?B?UldmY2xHaUlIRXpxcUFQb0xiOTRxcm9OeVlUWGFYUGZ1RjZCV1dRM0Q1QUxq?=
 =?utf-8?B?RDI0SHo2ellRcmFWa2FpRC82ejh3NXdvQjg4VHhtVS80dGx1eWZmWlRGQkM5?=
 =?utf-8?B?NU5OTU9uNzQ0RWRkZzdqS2dFZ0lsRmhCS3BWcnRXREtidE81YWFWMDdPTHN6?=
 =?utf-8?B?QW9ITm1NSUdZUnlDODM3WDFabzBYV0hIYjl2bTUycUdXcmR4VTZDZm5udnNH?=
 =?utf-8?B?dEhUWEpQNWdORDBwOHFQOCtrdVlCdllzVXR1SDZrVmdVZGxjbGpyTkZ4ODlu?=
 =?utf-8?B?Q2dJOFM4V1p1K05Bb1RWVS9KYnl5eVNscDlvV0ZZTy96OHhXcFFOMi9kUkZ6?=
 =?utf-8?B?ME0zdUkvcDR4ZkhCQ2N2QXJIUUFXNWNqclJxSmpzT0o4eGkvWWU2TU9IdEdQ?=
 =?utf-8?B?RWF0SmRicE5PaUVncGtQWEdtTUx0Q3F6OFJuZUwwK0FwMktVcU4xYlFLbmJQ?=
 =?utf-8?B?d1oyT0FwNlJ0aGhOcEtSM2YyL2luSzd5cjlrVTU2Ykx3SEk5amloRU1McUJC?=
 =?utf-8?B?WlB1UFg3L0tQbndweGxlaFdxUEY1RVVwdDBmSTBFemFWUVE5bGdCMTZFNVV6?=
 =?utf-8?B?SStqWHNYMDUyOW9JNU5qNzZNaStSUm9lK1c1WDVGc3NoaGNXakRzalFaOWNL?=
 =?utf-8?B?bG9IVU1CekFQYmxkOUU5bk53VklrYXdrWGhDQVVzMkdZbEFkQlpoS3psd3E2?=
 =?utf-8?B?RXdrblNNQXk1bGg3bStodnB1b0tMQXJLdytQb3FKSXMxTzZKcmVSL1VNVEVr?=
 =?utf-8?B?K2xhSzIySVJEOTlpK0Z4OFRTdUtUQlhRRHZUaTNSNGVpUk5TUVFCVk9NOUR0?=
 =?utf-8?B?MGFtelZIRnQ2MXJ4YTFHWFZMMmlDN000d2xJTkFUWjQ4WldxNU5HUnNVWCtx?=
 =?utf-8?B?NmZRZml3SkZKaEtKb281ZEJQZzlxM1NUSm5FSGErd2N1MTJoMTN4Y3F3UEZ6?=
 =?utf-8?B?UVFuQWhYbmtiazBTdFF2ZWpobHJoZHpaUEV3ZUJYaEt4dmJiTU5PZnpDa1lp?=
 =?utf-8?B?TXFnSGtvc3o5MXhpMVk2NzRpRVN6eUVuZkJzMjBUcjdYbVQ4UC9CbTJuTzYz?=
 =?utf-8?B?S3FrUllOUHZ4Q21kcUNvRkZScS83YW8xeWZqRmViQ0JZYlBPWU0rOVk5UjN3?=
 =?utf-8?B?c1RzenY5cWE3aEhTL2taTnVHQXpvWW9YNEhMQ1hkQVZjVVVQc2c5YWtvOXQx?=
 =?utf-8?B?REY0c2xpNFIzbUZ3d3pJb1FXcGdkMGx2aUNoWEcyK0JmSkhyY2t1SnRPTlhD?=
 =?utf-8?B?V2gybVA0d05MTDdnYVNNd0hWU2VGYjFWeXFlMEwrRG5scTJweUp3QTRxTndX?=
 =?utf-8?B?ZVFPMWlhQmtwU3dYdk9kV2U1R25oSCtKcW5lbElobHgvR2gxTDRVWjhTbTdP?=
 =?utf-8?B?ZklmZ3ZwOUFVaTNTYStiUFkzOFlybkRLc1dUODA0MDgxSnYyQlJtZlNRMVhz?=
 =?utf-8?B?OHNlVjJGTTRGMGtwMWNBNWRyZXVKYStTWHJiZ1BBalhPd21oU1lzSEJzWVBH?=
 =?utf-8?B?enZhUjNoNzBzOFNscVg2K3BsbGt3dGJHdzRMUE5nTDJkWm85R1FzaXptejBP?=
 =?utf-8?B?TStxVWZIVHBCdlJMV042U29CclJGTHljVlUrMHFGMnAzTmlmcExOby93VE1Z?=
 =?utf-8?B?TTdFdUxZNDVrY3hUV0RRMnAySkcrZ3RTVmxtN0p0YkI5cDlJZnFtbVNCWWU3?=
 =?utf-8?B?WFlldzlsRkdYOUphakZuY1pYU1lQUGJ3K2xpTFBHYnVoN1dheklUbVRhNlNB?=
 =?utf-8?B?UVp0dyswRTYxRmRPRW11R0kwdklZQTZUMWlNUTVZYjV4UDJYS3p5dy85R2dY?=
 =?utf-8?B?TmpuT0ZmQTU3WmludzlSUjBWRzRnc2VBZHVkSndUbm9SWjNMZHo2VjhSM0Rn?=
 =?utf-8?B?NXRGTk13YWViaWJiWDI3UzJWdTNGdThEVlNPYmRRK1hlZ1k0K2x1aEFNOUZz?=
 =?utf-8?B?eGozY2lyVVVzcmVOSWpUbVR3aWw2YlFnVDZETlJja0MwRjZHVENyc3R2NWRa?=
 =?utf-8?B?cUc4dlJSM05GNEUxeE1PT1BaRnp3N2ZqdjVmUFk1Ujd2N2VRNklSSlplbVZ6?=
 =?utf-8?Q?xFCNQ7irOTSnFiFA5w0xImEAZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /JnwF8J463R++MYdMt+kZSmTpKIDAo8PB24FonFHC4JbZKK/rdt9hV8Sv/FRmFId2nrU6gImySujM1uQuZvprg+TiWnELvJ6S/hqJAEZmdSJWJivl84AmtM2lKMYcd+RI0KfDy57rRx9iK/ycfvNnS3EGacKag9RqqecvcJgil+1LQI2J/aqYlAoCfScyBJkaOLjlqZwaQr8N1e2QEWsYk/7TJEEJt+ZE2V8XeypbHLXFnqNmC2XjSbkwSrT7U4GAJoKhUaop0IYtmQU2nukByscEE03gS6iNL2gTUfDnSBPKjxQxe69al9PxEcNFBmeJ+O4CPP6/egz8Jihl/ItKbJtRqj4CxPPgdmlQR6j/fn3mFKY/qYj/5ShPH9bG3KACxjYyqd/pA62ykpZq6++8Vunc6Lmd+ZJcqMi9jQ1xFPzzJEWN1pHrZ4zx+Es9rqNYhySAaCGjLVAwzUYlEqSOt/jglFI4oDSqH051LkWiucX35B3HS1tWQYV4rDJePS2Va3woB5XHPuiOoxU5nXq6LtIYBYF8y1kwo5cu16DbM0ikSeyiCnrpOBIcUyQeakAGPbM68Cw3ocybjipgbGUoJwDv8suK50Yh5Eug7K8hhMM0rQ297rRRFD4hRo9b27DHVRMNoT72bMtFujApb0MNU2DPnCGoERWV9vyBcccOV79TcG3NjJoQLmsV4R5sobecHHByodgDAgS5l876Ahef0tdufsXyYyQ+1ezvXga7Og4Q7ODqXfLUW+NieQ3XC4TayhR+7buGgRRg7g+b9lz3fyj3i1vWyWZ0h5EewT9a80=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e254dc-e220-4416-0320-08db635abca2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 11:15:56.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He31MNhRJF9jYclHU5pjJqEPAbJSHhwClnRiGo5izdjq5spW5GnX5Qu78yA0HEPgGo58BayhH/DFYzmk+a0Daw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020083
X-Proofpoint-GUID: v9id8vnzmZLLXk6Z70CCzc1XyC-TuzuC
X-Proofpoint-ORIG-GUID: v9id8vnzmZLLXk6Z70CCzc1XyC-TuzuC
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 01/06/2023 17:32, Zorro Lang wrote:
> On Mon, May 29, 2023 at 09:13:20PM +0800, Anand Jain wrote:
>> btrf/122 is failing on a system with 64k page size:
>>
>>       QA output created by 122
>>      +ERROR: illegal nodesize 16384 (smaller than 65536)
>>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
>>      +mount /dev/vdb2 /mnt/scratch failed
>>      +(see /xfstests-dev/results//btrfs/122.full for details)
>>
>> This test case requires the use of a 16k node size, however, it is not
>> possible on a system with a 64k page size. The smallest possible node size
>> is the page size. So, set nodesize to the system page size instead.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/122 | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/122 b/tests/btrfs/122
>> index 345317536f40..e7694173cc24 100755
>> --- a/tests/btrfs/122
>> +++ b/tests/btrfs/122
>> @@ -18,9 +18,10 @@ _supported_fs btrfs
>>   _require_scratch
>>   _require_btrfs_qgroup_report
>>   
>> -# Force a small leaf size to make it easier to blow out our root
>> +# Force a smallest possible leaf size to make it easier to blow out our root
>>   # subvolume tree
>> -_scratch_mkfs "--nodesize 16384" >/dev/null
>> +pagesize=$(get_page_size)
>> +_scratch_mkfs "--nodesize $pagesize" >> $seqres.full || _fail "mkfs failed"
> 
> Will this patch change the original test target? Due to it hopes to test
> nodesize=16k in 4k pagesize machine, but now it tests 4k nodesize as this
> change.
> 
> How about:
>    nodesize=16384
>    pagesize=$(get_page_size)
>    if [ $pagesize -gt $nodesize ];then
>    	nodesize=$pagesize
>    fi
>    _scratch_mkfs "--nodesize $nodesize" ...
> 
> Or
>    pagesize=$(get_page_size)
>    nodesize=$((4 * pagesize))
>    if [ $nodesize -gt 65536 ];then
>        nodesize=65536
>    fi
>    _scratch_mkfs "--nodesize $nodesize" ...
> 

Thanks for the review. Originally, the test case sets a 16K node size,
which is also the default node size. In fact, it would be better to
remove the nodesize option altogether. I'll send v2.

- Anand


> Thanks,
> Zorro
> 
> 
>>   _scratch_mount
>>   _run_btrfs_util_prog quota enable $SCRATCH_MNT
>>   
>> -- 
>> 2.38.1
>>
> 
