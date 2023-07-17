Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B1756D1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 21:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGQTZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 15:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGQTZp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 15:25:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB56E49
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 12:25:43 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HIxW0n011020;
        Mon, 17 Jul 2023 19:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fNPEkZNjTqlPs3pVznCaQv7fGEIAg+Nfq3Rw52kvFdM=;
 b=lIQITJcjdOkznRZId8Y5K+lSUMZoaLyB94n53fvVRoZA4/7qsJOCphPjflB2HaUgDKrF
 DR3483vBnBdDtTN7xjBWiTY2jcbsCOXRRMzBRAfBsvqc5kjvL40qSRGYIP1YHxvftfZL
 v8g9qGBuVu5qq3CLavSFPnOjXCRHlmYXZLeeQl81uXGI7qn9pWSQSYlGU0Yipimckv7y
 6Vhtop6kIec0xpB+fMJHU1epew5tdqHJIaog5jK7DHcV/4CgnWpnPIWGfW90+rzW6vK0
 auJiG3J7POZaLrN6csTKKU9pgHoZB6uKPm5ru6A//hQ4sdAUFLYzxfOVMjnZ7OrkRY8+ xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run89uhs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 19:25:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HHf6au000760;
        Mon, 17 Jul 2023 19:25:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw43xbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 19:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhh0JHOAJ5JC1hMZvp2PSRtMhwH21iruU1uB2eD4bJYJkMfHjWxllxGvuOws4buN4ADAJaPWDRQ9IxZ/p1o8+8Z7Ewaw2rBFhYgJ7dbEuKICAZHBHWSuAnqqieGlWwtYvUyFD3GifnuPPPUTnUWfyxDIe1sspcoVBIDi+Q5qDKZReGTXdvTZEdN30cvjdN6Fp/AvhBESimrbX1Ic9I33nAe/NH9dqnx5u6Eqo2JGBxgRZlbatD/h3Pk4zb9J6K+dEdzC2Y08x+g5f5uNOG7sPH/kK+hm4CsdebRGVDr/EdS9mbr6qrH4EmhU9k+AZ85NAX3p+2DsMM3gyJmDGkOshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNPEkZNjTqlPs3pVznCaQv7fGEIAg+Nfq3Rw52kvFdM=;
 b=YHZiwCOd0PE60c1nJq2MrLi3yzMVhg7OGCr17qvsjlkHbkAxy0Q6VVCIRUOebjiztZHidoYL6rXgnObQ6//LSr4tmYwNeaFH/ZUrf8m3HagSNMnWpvbv92Jn1hI9Cuj2hpuunHZQW+sj4HwxXCi6hsnznQZ1dxrRL19cz0MnNAM7f01pUG9SUCLdFDScZ2k/pZ2KN+bv27/lpQCrorHvD/KfqIoNDdm0C5my3jecidQNiOMn/IVo4YhsmD3atM3zoBjd3C/WbuCk/kQGNiWcnIKzuAUavFrfSma+WiOeUIJmTjT9jNfuEeDaSEEnMz/w4pDVco6/vm/ZPTYXF/sy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNPEkZNjTqlPs3pVznCaQv7fGEIAg+Nfq3Rw52kvFdM=;
 b=mF7h/9LJcIc0ee0VrxiNoCK++g+IYllhSsnBw59SulfdAkY3D9FytEeKlyoHn6D4pEHILzuyJC16HJNb7/A3KktlHI/QpnhpjQQTbH9fQWcDMXT+YLt8mzTetXaoFkBQw9z8VfYXG69u+IIyC0Qy2JevXOvqRQVnts8wKUGyfiY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 19:25:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 19:25:31 +0000
Message-ID: <f561f253-ebe3-0907-bf03-4daa334d3693@oracle.com>
Date:   Tue, 18 Jul 2023 03:25:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/11] btrfs-progs: tune: fix incomplete fsid_change
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1688724045.git.anand.jain@oracle.com>
 <24bef15af8c65da69ab8a3b574e0da7b71295008.1688724045.git.anand.jain@oracle.com>
 <20230713185726.GE30916@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230713185726.GE30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eef8c36-f975-4f1d-65da-08db86fb95e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVnjFQuKFSoqKJgtSTSvHVx6zYTxX0jEsC26HiA5H7cCV3yOjEjfltPzKfTpdsRbW6NrNyZGGQ2wx4TUDEJSzSDpoItzMMvbAcJY7PzZDSz+NcNm1fA0VGsN5WEx9aCr2+gmBmzY1g1alV74rVD/4N4Odo0PQ2PU2ao7erxhIhCK7zleW3vnjjw8ktBzX/Abh0JkAliU/mkgcCG84N81+hFvLX4ujKaJgAK42r2u4WxTgXKOxoOjJbQEG4iuVW3fcEs90uOKqgHTfLk1fH7mrICt2zhVzBHnKFbIetjF7L1T6CqKING6CGOd42bPJt6RwMnMHS7ZGMJhXb5WbgqUyIrM05V/uAokm8THeTmAI/NCnxPIf8y7L82TfAmo8kZ8vSj80+wSAIclpgDXUjz/eYSuHw6Q770fFjlBz+lUVzVhjUcva19EB+vAAFxDLWcYRQqwb/FH52CYEvze6zUO5PD6MSFgr6pfo6k4Lknh5CMrzsx/3q9Mck7GUS+C/YGnVNKbMYV/ru/BgHI1jGQmE99gfof+UxpEKeVjuI876uqk+Q4ZyQlqLTnaR9TIZMsCax+N/KtOyBrwSuwDEPhK5bwBY4qQc2D9oUwCs/K5WVd5fxIGDYY+Sc6GAJmQrE0c4eVKoGrHRQBrTc3Rz9YLMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(31686004)(2906002)(478600001)(6666004)(6486002)(36756003)(8676002)(4326008)(44832011)(41300700001)(316002)(6916009)(66556008)(66476007)(8936002)(66946007)(83380400001)(38100700002)(6512007)(5660300002)(86362001)(31696002)(53546011)(26005)(2616005)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGIxR1ZGSjRIL1BBZ3NNOGdxajkvMjA5VVBhMkFzS0JqT0orSXpJam9uSCtI?=
 =?utf-8?B?ajlxTWRiT2hmNkY2dFZDc214ZnNmRkR2cDZ6YzV2TDRUTzJ1eDZhUVpyWE51?=
 =?utf-8?B?K0l0dWVKK3g1SmdvVk9yb2hrK3M3NnYyNTQ3dE1RcCtOajdxNDRUczVLR2Zo?=
 =?utf-8?B?b0dFSzREUWZVaXRCYzlBKzQ0cTY5TzUrY05hSUVkNTFhUmR4MUcvOGxIUWU4?=
 =?utf-8?B?VXhQbXBoSDlsZW8yaGFpNzhQT2FwWXlCRVZ5N3dySlRHWUcvODR5bmcyaVBu?=
 =?utf-8?B?cTlxVzZSQjc2elhyU3dzeml5Zk9rN1JES0lFZHVPWmJSTlY2K0VHdmJRY3ky?=
 =?utf-8?B?cHdXUk1wNXNraXlCZlVyZDdjeWpWYnB5TTlocXZrZkVpSThVYnVQME1JblJP?=
 =?utf-8?B?SWNOMDl3eGhBWmdlajBxVWRlNWF1OURnVng4TC82dkFEcWZrYTI1M3lkUnRr?=
 =?utf-8?B?cnVYQlU2d0VNODFOZUt2V2lrbFNBR0ozZk4ydUR3R0p6M1NaM3pIQXdYSmxw?=
 =?utf-8?B?OXBqM0QzVk1xRUxvVUxxd0FTeE9XNk96dE9ORGFYL29CbEV1UVFQVHhMNy8r?=
 =?utf-8?B?SXB3U0dFMVV0ZEY3RXFDcFZ1UEE3V3F6eWw3dFpmR3N4akJzODIzUUdSNHh0?=
 =?utf-8?B?TUZ2YzNmdVlEY0hSZGt3eElLaWxnVVptZGZobGt4VlFGVlRHdEJUZWljaWx3?=
 =?utf-8?B?eFVVc3NhV0ovWmo1RjZuVlhoZ0o3enNpd0VkdEVWbC9MYTJSTW9tTkd0UHY1?=
 =?utf-8?B?aW1tK3hJL1ZuY3hGYkxBenkwNUpsc1NnVnljRWVQaldSTVBTYmUvb3VvMm9W?=
 =?utf-8?B?Y0lES0ZmUm5vMzA2aW0raExJRlh1bVU0NDY1cnBrTWZ1VkgrdysxT1ViNXM5?=
 =?utf-8?B?WGRhbGlMU3k4VEk5L05lVkpsZVFFVlNMMHZvM2RwWE85N0JzaCswbmozOWVh?=
 =?utf-8?B?S2ZHbStYZjRPeU0ycTNSelVzdTBxV0lEWVJndWhac3F2RTk3N0FvV01PK09J?=
 =?utf-8?B?MTl3SmZ0OEhOVjJJR2JST1VtbndnSWdzNGt3SGRtckQyU01JcUp3aEhrb3My?=
 =?utf-8?B?UDFjR2JHaFRCbmtmUWxqRnhodVcyajZ6UC9iMGkzMy9teFc5SEd4SXc5dlFn?=
 =?utf-8?B?aTJDMjFpOU92M0dVY2ZGR3NHS1JFdndTalFjd0xKelV6cHJZaEhjRXlsQWJu?=
 =?utf-8?B?ekx0M1pPWVh5ZFFUeG9oTldEUzNLeTI0WDlweEd2RWZLVW42Mit2bVlDVmh4?=
 =?utf-8?B?dFFSUFNRQ2lTS1czU005cVRhZDU4THZGWmwzTXhIOWdrNXRTWjJhL0xWT0pG?=
 =?utf-8?B?SnZIM3h1ZWh2R001TlQ4N2VWM1RBWmk2M2NycG5JVmhranNvQnhRUUI4NTFW?=
 =?utf-8?B?TTRUT1NQNXFTUFR5NnhnTjlna1RGS2pnY0NVOG5hMmRONkR5dzd2aUVUdkFL?=
 =?utf-8?B?b0F4SGNFZ3B4bjVSUXJyUUJ0M0g5WkZYYWZxWFA2L0RzY2ZtWVR4NkY1Rlpu?=
 =?utf-8?B?a2VFVGwrak1UdkN3ZFQ4ZGpVSSszWGJGNEpIbUxkcXhabzZIa0VoY1FWRjc1?=
 =?utf-8?B?QWNRUEdYYzF4dzh4blExVkVyUjZGcHcvd0p5bVAydUM5MEdmV0dNU0xHUHNw?=
 =?utf-8?B?THJxUG1UV0l1SHVZOS9EQ01Rc25YWktVcmlvS3RxWHREK3AyMmwrK3FiNkt6?=
 =?utf-8?B?NzNkaUJicFQyMklXYVhia3hJTVRKSXRVYnE4amJFR2ZwQjNBRWJsMWkxeE9o?=
 =?utf-8?B?Z0h5RjZtMHIwQ1QzQ1kzdGN1L1V5SGp6ZzlTQ1djcE1Ld1hqWEhVVTBMZ0VO?=
 =?utf-8?B?ZncwU1NsZkpGQkZUY0thdUtuL1RJS3dDNTFmR2VPUy9HT1pxQTErT2xBL2tV?=
 =?utf-8?B?bmtXekpMVDF0d1JXODhud0lpWXpvS1E2YUM0bUkrcUtRMnVGY0hsN1R3Vkdz?=
 =?utf-8?B?cXI2aE5FS2YwdklHTm5MKzdjN3ZJK2NLVHBzODJuUmgyQjZrLzJBMFJpWTF6?=
 =?utf-8?B?NXRqQURjc3d4eDhrYnJabEFaUEFCa3EwSG5zSk5KRjg4dG10YVF0QlpSWUJr?=
 =?utf-8?B?akNUVW9UZE50U3JkUFF6MnhBV00xUDRMaDVvZkhHMDRSbENGUnhxSTNMUzNw?=
 =?utf-8?Q?9UhGVt2naQPglL7eYvxPoJOkr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GILNWU3sKSbKEXJRJQ8Zi1UOsm2aYDdzQM5OHGMoZTedxGYDHtWKKCUMeVtsf8MvjUJ45opZ1Ohiuw3EjNsT26LSFPPpiZFk/iYZas9p1irpmQDFLboE2KuFvfyTesGa1iTxGVtHXMm02gjHf7hQPC/MTShvYK2nKlznSFmKUY5ofoWGjEJyHUILB7U80c5dxyUWxNPOOoQ9QPLbWAkiCOZDOZzyrVch/CIS7c2bSO1qIoS9jh5J+AhJOArAT7jVY+KPlrGZH0mLMiiirA4TdEQSf0xoxSBdpK+yL9M5R7yk0xTr9pc2N9wXD8IHmhEMeVNJ2PMgRtY3N+X8eRRlB/ARLOzXnLiPAhDOVeRNrm2E3ZkZgcGTpWGGDpVRTBv3WAXjEcDhK0OIdJFVmIsdeR5hKoP+r+4CDMTFq0SYdDMkiucrS4E7MYKBVN2s5VPEqVr+zZz8MOUV/koYy7THOx0m68qvRuw7VQbeUXOx3Z/omK2fMfErVByT37BWl7Qfd1pgx8Hu0Al5d0gzvUlKW3PFUP3ankNh8FFmJgm7JJGLQQBr/noHIMzrTk1B4cV/HvhDrO/Mhbc6d6f/iuu9NQVvPcS+dmyrj12rl51R8YnRaTsSu49oWWvJ6A2mcZD+ZcdCf1EmyISWr7l+srdXnXN/rWdms8SxAgFZvFNFbEnHqyzGVG5CQHzTPLvaPVzXthIKOg0agdNIlvfDET/NpEEaJeGCk6JwP6tO+Hlx10LYVLA7VNf0Tk/tDt0NzINoXQOkmz5yyPEScQh/y+EKwDAZ5j6LHwqATLFKIXiW0R4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eef8c36-f975-4f1d-65da-08db86fb95e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 19:25:31.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dgwTWqiMWMOs3PPNlMP0VUmmWzroYQCgQImszsvNuox5SkKLYOgAB1mkRTuBe0aBWxN4CtScQNB2hdoo+6qGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170178
X-Proofpoint-ORIG-GUID: 1QBlUKqE39P5pPPRs4ZkgWxu-ViffYcZ
X-Proofpoint-GUID: 1QBlUKqE39P5pPPRs4ZkgWxu-ViffYcZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/07/2023 02:57, David Sterba wrote:
> On Fri, Jul 07, 2023 at 11:52:41PM +0800, Anand Jain wrote:
>> An incomplete fsid state occurs when devices have two or more fsids
>> associated with the same metadata_uuid. As it can be confusing to
>> determine which devices should be assembled together, the fix only
>> works when both the --noscan and --device options are used. This means
>> the user will have to manually select and assemble the devices with the
>> same metadata_uuids.
> 
> This is not a good usability. If the user can determine which devices
> should be in the --noscan and --device options why can't we do that
> programaticaly?

Technically, there can be many fsids with the same metadata_uuid.
I'm afraid that in all split-brain scenarios, we may not be able
to successfully identify device partners, and assembling the
filesystem with the wrong device could be disastrous.

> If the found devices can be reliably identified as part
> of the filesystem (and there are e.g. no ambiguities due to duplicated
> devices) then the command should work it out by itself.

I expect btrfstune -m to be used more for modifying btrfs file images
rather than block devices. Users can simply copy the image and change
the fsid, which the system won't be aware of unless the user informs
us.

> The btrfstune commands are supposed to be restartable, namely the uuid
> conversions, basically with the same command that was used to begin the
> conversion. If there's a problem that needs user interactions then there
> should be specific instructions what to check and how to resolve it
> manually.

I was trying to avoid yet another cmd option. If the command is
restarted and the superblock has the CHANGING_FSID flag set, then
the command will fail. In this state, we can add specific
instructions on how to continue (i.e., --noscan and --device options
are mandatory). Or any suggestion?

Thanks.
