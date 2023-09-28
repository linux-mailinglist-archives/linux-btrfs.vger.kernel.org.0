Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0E7B1D27
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjI1M6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjI1M6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 08:58:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A0198;
        Thu, 28 Sep 2023 05:58:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8psVD003222;
        Thu, 28 Sep 2023 12:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kOo8o1vaxIQtNaAj+Q/F+yIWYfQgfMcr4qKKsC8ugjg=;
 b=H319duBx7uHJ+7MaElpaaqaTE0tLeZw7qQJbhiJRIsxOsEFz0KSoUuyczWeJ2yehMylW
 xWaTOU47vt+Bl5ewbQcAR97Y4VcnTUjmRGMd1bMLus/wWTxmIURl1fFM3uAD2+D+T50q
 lPAYDFWqwswL1CH3+UmWJ0OCGM1fLQBm+6dciW0elOz2wS1E5u7NhZYZSDqxMuu6bM3P
 yDk+h/eQgtRN/5/Gx8rXnkruSMNrVQ+KNOFXfJsXCecBOScM8VVql0FPEWN/HtKSPvP4
 V5KIqknq8EYx4xAs9eUjDKBl2k62E+p7ndbznbwzW7Ea5466wRYaJvcWNRkFCGl/xhK/ 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peecae5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 12:58:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCNg8W001693;
        Thu, 28 Sep 2023 12:58:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9q3sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 12:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLBC7e/sLu04TI0htsnpJoRUAKeD4ycSLxK74ptQHAF3f/66e6+kbU9jBfOsAP7UauvkGUxl20xyiyi/VzU0HXIcGuHPJcTariXoZuhh9qa/jaV3MiS3Oveg7jCdjDGVZxgx35Q49SfDllfdBWmUzMnkbziHYUc5xyD60+B5npph0IPICfi2UPFDIiADeUP6elr1yCLdHc320MQh+t9Zyeucck8wTztVIGwgBL8OoLlmvhq8pHE+6/1tTdS2RL3v8S7SSo4yni4PQFjP6NMYwAO/r/Nk5+pq1IVYj/yiOc/XU2R7l/BNltYo0X4X+AhL5OTwZ8c0nBsD3b5wYMKaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOo8o1vaxIQtNaAj+Q/F+yIWYfQgfMcr4qKKsC8ugjg=;
 b=FhGPOd39k6FG6JINYB0Md9clhg/R6BmmXVmNwgzWB8+Zu0QqAiZDOFD7/f4BwKxjtcA17QJnySGiYMT81F4bvJQM0lO6JY1BNkSKB9nHvI85zpeKr/anIxlcjEe1JWgRP8rKtylUx91xut/x1cCI0FK/3uweqSbCmsYFWyhva9S0gquIoPiC1GSS3AKZHE3GmXGJjObRQgp5tGQ3B7fEG1rV/89Qo30Ws5CFBDqhu99nnwJHV+QY0RPzSCXLwj2JkEt0Wd2GXJILlRjk9lWsuPm0VF7MN4M8ky/rgdeyYbEWEGyIPVsFCggFZBNwnwH7J2z9TwNkBagd6ERN5NuTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOo8o1vaxIQtNaAj+Q/F+yIWYfQgfMcr4qKKsC8ugjg=;
 b=RfbPsIg5CXPUSNeImcGDAWEHtzd6LtLfG0L3SFtqBLTJix8/kyXVDl+uB9H6ioCWy3O8dBN7afnAy7JtO5ckJkQ+p2zVVVzjkokMwVpBpVkzru1mQNJ7Ve+J1f18jcPulzmpXxRWtF1ORxyl1bwx9OYRCrk2vNSCMELy3yJGYnA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6300.namprd10.prod.outlook.com (2603:10b6:303:1ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 28 Sep
 2023 12:58:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 12:58:18 +0000
Message-ID: <c3de3910-0f09-ce8f-4a7d-7926f5a1e043@oracle.com>
Date:   Thu, 28 Sep 2023 20:58:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 4/6] btrfs: quota rescan helpers
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695856385.git.boris@bur.io>
 <1111e2f58d73dfe7571598cdd044211e15076a1b.1695856385.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1111e2f58d73dfe7571598cdd044211e15076a1b.1695856385.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4892397c-4819-4821-c78a-08dbc022961b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOoD0suXeGb3YBtITqhApLuqHcKS152YbKFOpUWVaCx3lY4Viep/MkJSeEVMhzNCtlpyeEdJ5voyvHFw1nu0Aj5p/Cq7clJzxhTspZ3Slsd8fYZOyllv8znLz4Wz1rNWB1PwtjuYQIkZtXbcwi+/NZeYOU8R9HSZorBm/Z0tp+ReFQzJYqRFoh3LFqCyPtwApk4fRi1fnRegHcagjzgshIXxQQqLiZRcQbwD4imRPoIK9g48PxA0hwO4AlOXHkvKYYpw8QcNE4oSSFB/burKwpncYF6isb6anZFXF8jQuLGUerEte4Cluvmnd9GPkispNjyBP3Diz2QZ1AqRSd2Je6KI/cJWp4vO3aNcgmB6Zyt0F53GKjKwK7pF1DX7Qm39Z3Dq6mG6moR5KKiAfQvO8nrOrBv0tdQTbPxSDqIi2DkqfCY3tCLg3o0xwQNHDxX4hnfxzmKp8ktamRMJyb7J/YPw9FQmjgGeQd6lCMvNtsuVosUWq21uqJOvFTmooQZQG+RnK2+G7wgVHiMFeMutvgXz5uK226lGTUz5YJy6YsWzvxbTH5El1N41Xtp7ShJsYYJPu+N9/GFUccn0u36AlqupLsR6N2Wffdhfsj8ZoZDQ1Idxn31WekUwp75PHrIDBArjt4CtIC0RbbjCAXYKVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(15650500001)(2906002)(31686004)(8936002)(41300700001)(8676002)(5660300002)(66556008)(66476007)(316002)(26005)(86362001)(2616005)(83380400001)(66946007)(478600001)(36756003)(6666004)(53546011)(6506007)(38100700002)(6486002)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTlzM3hxZHUybVo0S3FtSWFVNGIvY09zbzBXd0YrU3V2T25LbWN6eEtVRWlE?=
 =?utf-8?B?Q3VLL3BqQVNaZDNQQnFPa2xKK3VENjNpRC9rd2xrSVFieEVKZ0MzTE0yUFVF?=
 =?utf-8?B?emJCbWVid0d3azh1TER6enVEUCs0NHJ3Q1JsQ2gxL3dCdlRTRjRleTY1WmFn?=
 =?utf-8?B?MDZsbGxhS0RGTVNSVk5oSlV5b0hTeUYzQmtJZTY2emFOM0tVU21LNWltaUE3?=
 =?utf-8?B?SlZUc2xOQjQvYk5DMWJtYzhpMXJvaFhOaklQUXh5Vy9xZHUrUzFUZlBUdVlo?=
 =?utf-8?B?VVZsdHZMbThBTmJ1NUxabVFnWG80QVU4ZHZyeHdmYzFxZmRYSTluUXRoNUY2?=
 =?utf-8?B?dnlpSGRYK2RlQkx6TnRncGZ3dnY3YWdtak9RVW5aN01kOGdrelozQjBMaWJv?=
 =?utf-8?B?ckgzY1ZiQkd4VUE4SjNLZ2JkWnJZbEkveGdIN3pYTTZ0TzdDdmgwMStCUnRk?=
 =?utf-8?B?Nm9LSmdvZDV5cFlpMkNPY3dlekRxSGhramdIM3RvYUhJcGU2OEl3MHU1amoz?=
 =?utf-8?B?TmQyd3NSUThjZEFCNGNBVGVid25SN1F5QVgyRWQ3a3huQWhJZ09kM0M1eDhU?=
 =?utf-8?B?S0tFUzJYNkRiOTBQTkloMXBTYkgzWno2N1RQclhveHU5OWJYVFU4bUU1ek9n?=
 =?utf-8?B?aUx2bWwzMyt1OGZScWxldkpPZkdnZkt3LzR0NUZZdEpWSHlMYmwvaXVvWUhh?=
 =?utf-8?B?cW1Ed09GbWNyR2xBNDBnODhjeFhaZ2dLOEVrTVFxM0FJWlVJOGJWQTR4RHFE?=
 =?utf-8?B?S0t6ZDFXQURLTFo2d2hqaVpxeFJucHZ6VHU5RlZjcldSbHZKb083RHVKcnpi?=
 =?utf-8?B?U2hDaFhjbEtXUEltdytWbEVyQ2lyamtjOXRremx2WGVhdXhvNzVpU2hZZXZC?=
 =?utf-8?B?V3U3NnRabm1RVVAwcjdSODJDcll3SHNmOGFpNEo4c3M4aGlRaTdxQVJsajVV?=
 =?utf-8?B?VGswblhvSnJwY0hURVVvQnM2WUEyRllydll6b1lnM0wwbThUd3cxbE5RcGZ5?=
 =?utf-8?B?cklJWVpzOHA5eGpaYjgvVkZWUHhIVkV1U3J6OVRJdkFqbmVnNE1FaEZHb0RP?=
 =?utf-8?B?SnBkNWl1Zm9VL05tSjlKSnpkV3NSN3N1aUdsRER3SXRpaCt4bCtaMzJhTVVN?=
 =?utf-8?B?MzkwNzZOM0diNmZFTFFqczBSTzRTbWJ4YlJTVkFPSHpFRTBRNFdaRjBmT1Fy?=
 =?utf-8?B?bGhpWXRuaXFEa01lTEhRKzM2OUloL0RqM1AxQTNlbndPZ1VQZFlTTE54NEw2?=
 =?utf-8?B?RTdtYXN2ZitTZERLdEtjR2FabVZ1THdNQmtqS1N0eTVlQVlDNmlUUlcwUXVG?=
 =?utf-8?B?NXVxT2lZOFdZVDZDSXVFUFBVdXh2WnE1UFd4bWFqTy9hQ2NSZjl2MDV3ZTh5?=
 =?utf-8?B?OXQ1cUlJTVV1OE9SbFdKSi9TRWdzODR2M1kvTG5raE9LNGpNVTdhMkV0WjFp?=
 =?utf-8?B?QUlqd3BlMzJJYy9kT2w1VEpkRDZCU1d5aE5nRkk2N0tNa1V5YjZnYnZKL0ti?=
 =?utf-8?B?dzBFYzdad3dMYmZ3dGsyM2cxdWwwY0ZaRGVycXk0MDBxcUlPNjBiaXlneUhD?=
 =?utf-8?B?N1IzdUhpY2p1SXRlTkprOC80U2ZtODQwODlnZnIxM1NXZkhPYWl2ZUQ5ZktL?=
 =?utf-8?B?Nnh6YUsvMGcvLytlTzJudWswN21zOWZ2Nm5BWTdtVlFpR2tMYUlLalE0K1NE?=
 =?utf-8?B?OVdvUzhrdk5wT3VVSWZKMW55aHg1WDB6c1E1V0taZGprYlNNTzVVdUplaURD?=
 =?utf-8?B?VExaZFhjK1l1NzFXanFlOTNQM2VSOWpuR2ZveWFUVU54S1BMUlMyYmpRd1Q0?=
 =?utf-8?B?TmM3QVVQMnNIUmZ1T2RITlBvektIeGlGWmFOd3NwS3JraGJyNjQ4aWRLU3Iw?=
 =?utf-8?B?aGFQalRZam1EOUpPeGVEQ3RjWEZzOVFxWkVwcHk4S2VkZXB6SVlCWmd4dmNW?=
 =?utf-8?B?eVIwMEIzSlB4TlZDRENRMml3WFlmajZzS2x6UitVaittNjQ3a2NtamloV0VK?=
 =?utf-8?B?WW1nRndQd1g2LzEwWFZMbTYxVU56VHJvSWt5Q3hpU0VlNVVFSHNyVWhMUnc4?=
 =?utf-8?B?dXdCdGlqZXdma3d1UWhWSXNERFZwTWxjajZCeXNGMy9jRmk2MDlqbS9YQ2VY?=
 =?utf-8?B?VUxHVVJKZllkUitYajNWVGx3TTRlcnBicFErTDNNWVZ6Z29QTU5KVHZCaEl3?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3WHbOgWQY2/R/G3idBHJorto8TvdCfRlXQgjcFwctHFJrAbyOEnPvN4Yc5tuTodcYGoGTsPh0A/J/EDMPqZk2ipwYPBrGI25xhqjvJPm8sScbd0y1Puf9fpcE6gQMBkWTnWj/vfRypwqcn5jDEtUenHVBwrddQaEbv9q1Eev3fvmziZNQPBeMASH4mHOPsrxzMTbYitTKZ79DiZt0Wl0n0ZFKHQqXhz6HDpX7QLU1QLubT14Q/ZhqMk9YmbFAt/VOz4GQvmvbVPXTQlWXqezPihtGSwG+mtftWjpIkAIxJGTOh/Y2WuBUM/zr5y1iyYB4W77e+aQwpCfxwtNgPdjvbCm07l/HQx7KGU01A7GxrfpYvhHlMsD9OK1UzMHAYZoARMJlEgjAdn41s5UE1ovP9IyRi1r7U44KZv3jaKAu0bABaFaXp+l3hSZCkjaioqbjWW4Lac17JN6NjFDoDlR/aWj5gsCZ4zIN3S+csZL/CubDKUDYnF1dOVY6WBlz2auoAfy93Yimq/RxIJDZecqT7t30u7Z0hDfqsHgsYWK7mrDQ/h+GPJqUYduUWqj5+D0chsK8k0BfbusmqmAHn2nDepSop0iqGKIKSMKrrKaeuISkEUYMK2FP2DgocE4cti5b6MOf5Ifk4R+3ioKkyY1hYHPIiglDD+PdEWPKodhCk4WsaYu+aaJipkGW6Yy1f0FlaXy3zqDlwBKcXCbBUOiS5eU5Pne8gjdFP5fm14DvH8QF+/+wklzr9n3Xc4V4IYCSkSstcSvFsexS8WeLMzLjhyD3nXjCEQ3OUmrP9ZE6t8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4892397c-4819-4821-c78a-08dbc022961b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 12:58:18.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qABEa3oWywQ7V1oAag9vMOrgjChoISAZKOSY4TW0zqUTaB+8UdtNZvwdemQj0mtLVwOHgtya1SaVOppvlevqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_11,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280111
X-Proofpoint-ORIG-GUID: 5PBaGUTtOocv6Lnu1Z8eYl57uJeWi09G
X-Proofpoint-GUID: 5PBaGUTtOocv6Lnu1Z8eYl57uJeWi09G
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2023 07:14, Boris Burkov wrote:
> Many btrfs tests explicitly trigger quota rescan. This is not a
> meaningful operation for simple quotas, so we wrap it in a helper that
> doesn't blow up quite so badly and lets us run those tests where the
> rescan is a qgroup detail.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   common/btrfs | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 37796cc6e..0053fec48 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -710,6 +710,24 @@ _check_regular_qgroup()
>   	_qgroup_mode "$@" | grep -q 'qgroup'
>   }
>   
> +_qgroup_rescan()
> +{
> +	local mnt=$1
> +
> +	_check_regular_qgroup $dev || return 1

$dev is not initialized.

Test case such as btrfs/028 fails with MKFS_OPTIONS="-O squota" config 
option.


btrfs/028 30s ... [failed, exit status 1]- output mismatch (see 
/xfstests-dev/results//btrfs/028.out.bad)
     --- tests/btrfs/028.out	2023-02-20 12:32:31.399005973 +0800
     +++ /xfstests-dev/results//btrfs/028.out.bad	2023-09-28 
20:54:52.744848575 +0800
     @@ -1,2 +1,3 @@
      QA output created by 028
     -Silence is golden
     +failed: '/usr/local/bin/btrfs quota rescan -w /mnt/scratch'
     +(see /xfstests-dev/results//btrfs/028.full for details)
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/028.out 
/xfstests-dev/results//btrfs/028.out.bad'  to see the entire diff)


Thanks, Anand


> +	_run_btrfs_util_prog quota rescan -w $mnt
> +}
> +
> +_require_qgroup_rescan()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT || \
> +		_notrun "not able to run quota rescan"
> +	_scratch_unmount
> +}
> +
>   _require_scratch_qgroup()
>   {
>   	_scratch_mkfs >>$seqres.full 2>&1

