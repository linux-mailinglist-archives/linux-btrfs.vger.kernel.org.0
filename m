Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16FF6944A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 12:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBMLgN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 06:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBMLgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 06:36:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211768A49
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 03:36:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DAQQXx015215;
        Mon, 13 Feb 2023 11:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PVHFYMAmPFS2EsohkMx/lRhq/Fst2eUX6khdSNoDbmk=;
 b=hc2eYOj4D4T8TXYTk5bAwg4iBanIo2CJ+FdtIpKy0ZtlOSUcaM4tmjX43jcxYPCSwhuA
 JwWxKdVofKMpL47+V3Ff3aP/praYES2mRSiG4Z3MbM475rTMnPQONFDpXmIJTk3gOz46
 O3ogRaBHLzXnDbzhqqBFsYnkFbYqgED2tSqcI87JPjwaPW77nJsT28JNip2hfxlUAPZ4
 UgxITYjG9uLQN0fsEkHmlQ/sfYVZ+J9ZXajSR9p6j8TXukTF++uHcnuU/IWx7vFZYTDc
 mporGFZ/X3YjwgQVY5wSrG3kNaE24LczYdipeZ8JQt1qhg/dqjbNmX2IJc1vZDQMOZSj Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3ajcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 11:36:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DBOhhD032459;
        Mon, 13 Feb 2023 11:36:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3yn7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 11:36:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo4yFCgkulSALEvvs7n4xmO2dFUCCZ16s52YGYrSUIAInG+oUESDDBpyN+pRB+JfXOGs7AhCZZHv+ITjs1G7yhb1DNTeWXyH6YxtQaBVfRgwyjXPDUUhdXYs6S1KeKdlE8Kif3NKF0wInOwEoDdp9POAZtigrUhGcPBVrx1n6KSAqt0dqM3cNIdGxE+29VveBjhMNGBLMsnmTjSyvAODwypDc1yjcPgknvUI3QnXpCqAO2+jSKOFSTunkbGbBaU207R2VdtrPykwfAVyxtc26Ejc3wAHuDTQvdNwg3w3c33nZtJjvlXxTa5NOTe+dYRQnxS1RKCMMkCpVjwUkRq76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVHFYMAmPFS2EsohkMx/lRhq/Fst2eUX6khdSNoDbmk=;
 b=LbQBdvsvQUdZYpUkxqVJVer2AwvEe7Z2CBoMG5xJsvxMGdC1aOB0Aa/f4mVxzbUQ83Yf2F1rbkcbNrjJ9DNUDf8i9FO998M35JojeoC3LUE9rhRg27aO5vC7HAAFlrUJmJCylkf9ezQ3tVYrF5F90lGkuOb59COHzlEnDSxPMSFKGEN4ZW4lUGjsKSiJH7T6z6RRwxJyzmxi9KdCMj91Nugd/zUJW/fBHOfKLbJ1776Ejyqw/oMb67KShCmGdnT82sDEA+FgYctfSt+ldz8WWdU21pqV4/a/PSQ0wM3d0cB+0BQWphaOgDxK6PBUcmPQDtwXVC91ytyfMPeFKBIoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVHFYMAmPFS2EsohkMx/lRhq/Fst2eUX6khdSNoDbmk=;
 b=IN98sY2nPZpi11hAE671a1RYdM9u21vBNQUST13mZGNTfgPUAeGGCMPJYaS0581zCoowj4rXeYpQQe8vedXoNUgWjp2YfYxmPmz7xrPT9G7ydOrRxGrHiXMmIEXtTqa1YkzHMkHH0S/oLpaqI3XL5QiHtUIYqKWAzYYjMPLZ+lE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5110.namprd10.prod.outlook.com (2603:10b6:408:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 11:36:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 11:36:03 +0000
Message-ID: <aeb7a8aa-cb71-6737-6394-cf2696403f81@oracle.com>
Date:   Mon, 13 Feb 2023 19:35:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 03/13] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <5898b85677c784bf6af4e3a18d61bf261af3141a.1675853489.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5898b85677c784bf6af4e3a18d61bf261af3141a.1675853489.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: e1268147-5fca-4ca8-5675-08db0db67cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OY5k7TE8Wx8Yq/of1LltOOcPgijZaaU96bwzuvQjGSqxmjzZ4r7tlm08++fHt7bplDGfdRUTY3P5wjerjG6z7Vg+BLWdr3HC6Wk7OvQ6AmvOakGUd0U5Re7Sh3FqqnuAhfAoruj5Uce9nWzX0nY7shcCzwXdGcyNFzx87tRcc3wPfyhzjYkzkE/3btUF7FYvQgiA5DmmVx9Dm7bedAZRqz3sM4zzDUje6Ho4W/KUhTdR9HSPlxa8XSNUwDyKE7g4CUsFAZx/wQps1GYfUfSCEthLEyas654O4reHjEYxg16qSR7Mzy561iuD6BvGUb1h840QB8vK3AqDZZGLIOhvgYDvzwK17j0ClGadNxJk/qVZKZ9CCQzVDEH2WOj/8c4QBybZ70YY7pum1h+Y5wqgM2uBHZD8/AqYWJyk5TfWH9k4ZQ5uPvfF6Isoxe0q5OeGSyn1XT2xibdyXUvOEuPGSS3kh4ZbDiZAxBu1ZQ8RFZmtRys4PQbN+b+DNtss1lml+WyWpNkvPkHtYgZ962kTGyLPMbA2A+KYOufPTnjGqwnD4uWY5a9NQXJbx9NgEz7RICQRPsUWVbzzDAll0IqZVqXmpD+/Cay8y/5dDfQcNVkiXdsQN9N/31vmYMlIy28GyjOwEX9UJVwWb5rf/Bs5Ls5uSCzuqAUnEtxel7OzOqirrcgVL9ELaUOF0FIx0ZOA55P3wdTfB88F06PQoHXiGxWsdUxl75VcmwAwHUPiQHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199018)(5660300002)(8936002)(41300700001)(31696002)(6506007)(186003)(6666004)(6512007)(53546011)(2906002)(38100700002)(44832011)(8676002)(478600001)(86362001)(31686004)(316002)(26005)(6486002)(558084003)(66946007)(66556008)(2616005)(66476007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEczSk5uRnc0V3pneFpuT2IvUkpUVGh4SjNxdHFjbFdSQ3g5SjlmcmVLUllY?=
 =?utf-8?B?VERJYTlveVhUd290dHhGa2l6RmJaQy9ZckpiVXBNdDRtVStHUnl0ZzErZHlR?=
 =?utf-8?B?ZGN3VVNxZ21GUE01Zm0zWnlNVVRyYTA1ZWNUcnkyMFhZZmI2TVlrbkQ2UnRN?=
 =?utf-8?B?bnVPSEtSSm1lUWJPRGt2UWJYOVllRE5HTkNHajVDVG5BeTcvV3RxT01Tajl4?=
 =?utf-8?B?TGZqNlVuQjE0V0hoOWxlbzZMenFrQjNXTDBET1V1S3hzdHk0c3JyZkpiOTht?=
 =?utf-8?B?MkUzdDFHblRhcVNBekdvQitObU1jZzF3NEZsa2t4U0lwQjVLUVNmc3ErblRV?=
 =?utf-8?B?bXJvaUV0dGYrc3Fja1E0eTBRMjdEdE55ZnhkOEhBZENKL2ZvYUZwUjYyUXdU?=
 =?utf-8?B?UERvNWFnWFoyY2x1RnRWZ2VETXQ0Nm53NC9lSE9VMFFnZ205WUM1UVBqYlBw?=
 =?utf-8?B?VmdHMGhweHBrMWV4UGV3K2pEYXlRMjJaMlVwWHIzajJrckYyNGViOFNBbDNw?=
 =?utf-8?B?ZmpkNTlsSEExRHI4Tjd5VkhVZzFsMDlocGJObzRBRSsreGl5Rk9yZVBFcDJF?=
 =?utf-8?B?SlhZMmJGRG5CWDFLbTN4MjhPSXBZZTFHTnpYd1ljc2xNOHIyd2pXK0lZdGxI?=
 =?utf-8?B?bWlGVzl1U01vcThkMHcrSzNIb3hVamdJdlJYWXN0T2cveVJDYjYxVkdrSEZO?=
 =?utf-8?B?YjlIR0ExSGxxOHdJem9lMHZXa29Ga0NwbTUxamNlNm82N3lnWXNoN0kyU04v?=
 =?utf-8?B?TFZqb1BxUkRrNm1ud2dSNTlLS1Jsaks0RXYrWG9ObThIK3BVcFRVWjNXZnZq?=
 =?utf-8?B?SndGdTNCMjZaRGNlOXV6TW5oVXd1Tkhjazd0RkVpU3Zuc3c4NHUvRVFWL0U5?=
 =?utf-8?B?ZEMwamNhMVdOci9HMkhFQ3pKc2ppdktHWTlQcVluYkN1bGNDYm41eWxUd3VZ?=
 =?utf-8?B?R3VNN3NPWE5lSndiTVFTL2xoUTBYUWxNNFpqQWdoRnNkR1prbXRNVXNtNFM2?=
 =?utf-8?B?TGxJSWlIMHFoMDZjdlZoUEZ4QisrUFoyNDd0b1JSWkhFMDh2dlVBRGdYcEJL?=
 =?utf-8?B?ZktFTDBFd2hjc2lSZlh1bWMzaUxkVlZndGFaYmVsL1p3eFZab0R3Y2huK1N2?=
 =?utf-8?B?bEcrNVRJaFlVRC93OUVZd3BUaUZ2YjM4YU56K212RU1VdStLa1lwWTJCWmJk?=
 =?utf-8?B?UG9jUnYrK2tuYTBQTk1wY21Ja2VIaFRyYVJqZnhvbHI3RzJ0RnBFRDlud3NJ?=
 =?utf-8?B?ZkJwdjZqWnUvcU1adDgvL291MXFLSCtvK1Z2T2RuYlNHcXAwcUt5U2tRd25i?=
 =?utf-8?B?U1M2dzJjeW5IOW9YVHlnN2dVbTNXc0pDRmg1U0RhS1NYT2VFRnp1RUtFMWMy?=
 =?utf-8?B?dDlFdUJ5TXJJblpRSm5JTnE2MlJDRzhFMzNXOW9XSUtvVncxYmcvWGJZaDR6?=
 =?utf-8?B?UTJPWURnVDdQRWRRUklGajE2RFBmWStweVMzUnRKUW5yazBDcTlwTWt0c2Fx?=
 =?utf-8?B?MHMwYnMrcDRFeHJKZzFKRDg1dUQzM2RWUzY3TENiZFRzNUhVemNDenRxb2dP?=
 =?utf-8?B?elZRcFdObHV1Tll1WVhNY015NEd1NWhXY1kzUDI2ZkZSYVlqbmgyczV6bE5B?=
 =?utf-8?B?MXQvQnp4RmVQcnI5clNEbGtzVm1hSVlzYU9XT1YzSkM5L1VGL0huaEdzVDV3?=
 =?utf-8?B?N284c2lLR1prcFV3MjBoY2RNMXhDR242bm8vandRTDZ3T08rQVlQeHZpWXBk?=
 =?utf-8?B?Zkx5MDNhYVFJR2I1REx0MExrUUx6d2NHOURBVVo5SzQ2U1BPcyt1UUhVZ2xU?=
 =?utf-8?B?blBqWWljNk1pRlE5cVVyMjZJc2hXRkF0ZDVqZ2tOcUE1cGdUL3o5WUVsbXZY?=
 =?utf-8?B?eHdGdUIrWDF5NWNVa09VT2NCdWJ2MmRLcG56aml2L01LVVlSTmh5WC9QQjcz?=
 =?utf-8?B?dnRYQm5YUFlEUTROalI4emlRRFR0MW9vcUJBR1hVOFBkQWJiZytJbHJRUUR3?=
 =?utf-8?B?QytTeGhSSmhqYWlKRWhJaDV2N1RkcjBxT2pUang0bUd2OVl0cVRuc090NXlU?=
 =?utf-8?B?aGhlb0F3L3BSMkRtK1BZVW5ldUNRTWVqQlpTUHMyT1JZZ09yQW9WaEJlcThL?=
 =?utf-8?B?V09yNkl6RWoxcGNLcHB1ZW40ekRqZkZiWkJaYW8rVVZFZytJdXY0bGpjN3FU?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pJH+hPPH/CGpMeYl4OJpSj5I52d5QckIWDrG+5ohRGHWfslURH2nRtATf0p0hHx3oUeMNj77v2gnhwqhHIwGRwwfpV7TDfuzHNeT0kUPFFvjxzT7Y6A8im+ljxLnK82/n3Fmakcv+FoxaEnKZ7z9/AO2jKm31XDMrdoCbjUJ7TV/tMM8EqCCNX4d+x4WU8GHYFOUViUIx2Fbsy8pxoXebqgUF7tFJHYNUKZcWMlxQyhXKg4O68MS54+E+Xo4XTGu/PIDAbsz4LxFeopDSGVucoeDkZXzWmqURcVObIbH5J7JBZ2XDEbbQgpi8iQx6rujrY18MQPjbYmhgsUcGLxq9tOg4KKlgPn+6dDOMEXiqciCSwcf0OkYlqW1D9KGhA9pnSQc0WIX/gdDiVxXVRliTRN4YfZ3GKTGhqh9lH0MrEmLsGrhBPnSTzjdm1qXmxb1iG6KyJ7TEfBnkaD6B97CwL3czx3GR3nIqtTccLXYhtngDpvaFyIJxQPgz5IgOKtgzsOwXOKBDYlbV46ZMf49K4Nj9yIK0F9qsbbehvnS3llp3iVBlSPM9jBKeb7ZU1dBhezdsrmroAbcE07HZX0xcCMo+zsRLI+2X5MY8RvxfwMQcPXPRE7D4qFhXnHZQ7VAbEeAmhSUzMQ6ckK29wL9/S6YTP3YKqxBRfy9EnOekssk5o5nNsonGOeqdrnoIkB9Lv7Wotutn7DJaVsoYP9uCIkNiFwO7csuY0nzaT8yKt5sZQd8CxsIFjPx9xGDPGiU8NvoALS5zvbk+VDZ6w0KCyoXJNWNGYmHuS6P7pzrjQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1268147-5fca-4ca8-5675-08db0db67cb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 11:36:03.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jJdb4PvW28KXzPyY4F1fBfcItVHrwX8kZj/AWxLPjs57Ahjic4khwGQxa/6oYlr/khp7vtvHn4M1rdrl/E6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130104
X-Proofpoint-GUID: Dd34qsFnkPCo2CnoFP8-tErgnk7bZlty
X-Proofpoint-ORIG-GUID: Dd34qsFnkPCo2CnoFP8-tErgnk7bZlty
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/02/2023 18:57, Johannes Thumshirn wrote:
> If we find a raid-stripe-tree on mount, read it from disk.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oralce.com>
