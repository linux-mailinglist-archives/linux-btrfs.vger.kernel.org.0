Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B1666DFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 10:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbjALJZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 04:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjALJZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 04:25:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6175AC76
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 01:14:06 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C8f7bM016535;
        Thu, 12 Jan 2023 09:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=45LM9Ex55umEv0Qy7y+O83fj91ir+sAyvWfz+X++bYs=;
 b=xWbOgZHZF5utZvU0jkEVwOTC0Br64E8XyOonyBobL3VQ62DrKDRskADmUJ8rYSf0yqnU
 vpciuErPG0tOio27MaU9u9x20JtHMx+TnC2XIY+BbtiAZnwWpo8XpHWCfVqLeRQUVh+6
 0sT9uMR9/2aUEC7IZTzqVq2PvgxqyHQ/tH8wDW0UsIqlbHiUWa895rLCe0vzaQiWAIro
 7+0utULEuXtm41ZPBXmIxnaU3HR5ucanxNAiscIbq7A/Qbu/XybAzWouNFqdX/cd/5GC
 qccaUGeHFXz3NMFkct248VDUdjCKnkfSFWTbnl+H8d78Lr9aFuLd0hQwia8k8MdfzYJy dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1y1nj076-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 09:14:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C6w0pu034132;
        Thu, 12 Jan 2023 09:14:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4g5t38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 09:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA5ZAb+u9BXB4x1eKG1YTOUI2SHzkziI/AsS7KOAa7mBsJ0jhdBM0zCEcUYBu2ttbUq4tPrNQ6Y+gT4OHCYja+lORo4S9q3PoXYea9ji/mIlDhD60Pt3Sk4oIwifZ01H1ptzNteEWVfHpty6eeNmkMDUC5HEx6Y8X+VlHRfpTjOXpf71vhQID+SRr8i2WSZjhyuoTR1D4SLQ2V3gpXyVN1zNXhS7MX5azDzqPYf0zm6FFapd7Efx8MadwspveMy1ixsFC0AB+hYMNLPb0hMwqmt6tOm6Oe8bFB8PIG0ZClO1neW8ydOAFOG9T6ToAGAAoXg5c0AgPW15dwYFoNvExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45LM9Ex55umEv0Qy7y+O83fj91ir+sAyvWfz+X++bYs=;
 b=mPRVDCnTr8bZh26IJAotOlwtXJkQT7AoMWkJSZMPGYZYTqrkQQVPtvUrMl9DnAyeLNfdD1xoulV/YpcIAx3nz0axi9KBz0HpjNQ061FQGUEIpAZKhfhdD66sl6/yA5SJ4CSs+ETNaIGsslxgj5Jn25Q+N7lEAj2HFFGIs1DSl6gsSFIUWA05zrAoVayVESioyVST0+CXaM25j6X+hAnr5vd9FnBVd1AZZzy0qlW+w3rfplIRHCWi3yo4q/aF1v01/uzCwSBozPR72ZDMWBAalm7awoyeeH5JzgVYwZl58665tTz/04nQh4j8MH87mYULxr7dU9Xv9zNkc1ZiUt67sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45LM9Ex55umEv0Qy7y+O83fj91ir+sAyvWfz+X++bYs=;
 b=ItmGP4mcVByH7RTqLbx9ekOFzt9VBAdstghKa7hxkN2XpBFJ7lJ53mP1Z+dnF39ljW4YkYXpPMCfltHIeL81/GhEcibBVeU+REg9kLYOcPXddzvJzE8mzyFBtK/bqJKByIPD3V59EcTP4JoZmXazcp8xY0Aevx+4D5C0xeFhYKU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6499.namprd10.prod.outlook.com (2603:10b6:806:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Thu, 12 Jan
 2023 09:14:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Thu, 12 Jan 2023
 09:14:00 +0000
Message-ID: <f69f2602-169f-9735-4258-e47780110412@oracle.com>
Date:   Thu, 12 Jan 2023 17:13:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs: update fs features sysfs directory asynchronously
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <73d793a03d41534c284f8be92b41f9093215cba2.1673502450.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <73d793a03d41534c284f8be92b41f9093215cba2.1673502450.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: fef181fd-d98e-41b1-468d-08daf47d572f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yC/1jaf8uEoN0mDh+1mGFo69uzOw/DcnWi2uox6Nc/NRqx/7oQRXD5y1NbVnqN0Xg8jFarCZh5sj0+Bgpzdtt18I7RY6aMZ6YYZ6s3AAwSsUctgT26HDSScfoB0OXzU+yMMHTaA6BlenTB0Jk0KBzAf13NAkuD3Ky9FWcE4mHwjtfAVKwt9eJvV8ab1KATiPjQ7dhWQ+/epPtPC0jQkTxuoEKklMP8ryS/g71Gyc2tpO37snxDh6zmGDSrc7KWNP5/XttqMA+a8dPbr/Hms1q626Y5IieiVlFSfoPS7E8anzJqhbUdkAi/Ukf4T73xdxYjsejbwcguGC0YolMFznQBMePT58I6F4SB7iVytI4mGsgXZKas/HSptyAW3+yJfIMXWX1aQgqLCMbiR1qpg0ltFK73wIOTBXM2u677H8Xfr1BBIa9ln67c5HW8VNVVKGSvGjgixcZQoS3cqEK6jZRbHUL8A1FRsBQSPyenwcuMHeWgwegH/p28tl8gYDJ+n799QwuSrYfe4ubF4yWzlK9oVkwRblkCmrtI4Rahds8HAVqDAM3548I69FL3F7e9U94Gcp5cFMXMzVHWOxdcJDpLzGsVMFONJEwaWIeIJtk9mKZbyh/T8WXziT3aRslrHNg8iuOHlBEoTKitpizVgpFRiXzi6ADZAjtpiTw7EY2vQCMl0kv88q2r9LqiD6kJ9agmaTuNs5UzrWj4soLz0N5mmahck5LwtdW7o3WP7h9ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(8676002)(66946007)(66899015)(31686004)(41300700001)(2906002)(44832011)(8936002)(36756003)(5660300002)(30864003)(15650500001)(66476007)(316002)(66556008)(6512007)(478600001)(6666004)(6486002)(53546011)(6506007)(186003)(26005)(2616005)(31696002)(83380400001)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1h1V3F6dDBDMVJub2xYU1p3TFBya2YxVGZCdkdFQ251VE04RTNJTVNvYk43?=
 =?utf-8?B?dkhzd3VPZkxMTGVrUnE1dkFhS08vendlTlhJUi9oM0VUd0NXd1hwaXpvOEZv?=
 =?utf-8?B?MDRsWjJlS2xxdk5hcEY0S1k5VDQxZlVTZjNWQStyQXc5dGlsbTZyZ0g4YjI4?=
 =?utf-8?B?aERMM1VNbXozTmlHeHYycTUzQXh2ek0yQW5yZzU4MW9DOUxMYjMrT1pJbkpG?=
 =?utf-8?B?OW9lWWZtT2NJU0pMYTJjS0s0OVB1RDMvYlpCZmExU0RqM2Q5UzV6b2xDelEr?=
 =?utf-8?B?a3phaU5iNGZCVWxab3VFd29hSUdidWJwSm5Bb3BFYmFnTEszV01kYUVJcFhT?=
 =?utf-8?B?QW0vWHhnVys4Z0FVTVBLaE5DS1drZTVId2gvK0hZV2psRCsrVmZwYUNWaGpU?=
 =?utf-8?B?UVNLSUJJMmdlYlhJSWE5aWgrK2FvMlZNMGUzaUI5REJZVEF6b3I3SnNQODJ0?=
 =?utf-8?B?alVEWm1JV2ZQWWUzRDhYTWRyWFBkT092aUxZV1lCQThNOXhrWkFLL2xOUGth?=
 =?utf-8?B?NUM0UGoyRmFLY0JaWGRONFVqTjVWNzY5VENzaVJzSVBIUTA2UDNqMzhqYk04?=
 =?utf-8?B?Rmd0dXFvOU9ZWWttUmZHRWZWY1VLcDVEeTZaSUx5MWlSSHVuYXRYMnArRGlt?=
 =?utf-8?B?cWRoaXpOejgyNjdRNzRmc1hxSzhxVUtzeElaNEtxSWtGQlJVZVVFRVRoTHNH?=
 =?utf-8?B?QlhzL2R4U2RMUjladGlSOUhLUzlGaXdMa0lyU3FHT1FTSnV3MUw1WDdCQ3Js?=
 =?utf-8?B?QkhQRlVVdFREc3VJdjducDZScXJva3NVeU5iTnJEVTJ3ZkdFYjFFMGVVYzAz?=
 =?utf-8?B?WWloT21RRXk2U2J1YkJtRnlVS2FzWFZic3J3VlNvQzRucGFKRzZQd3pIeGhK?=
 =?utf-8?B?MmJXaHJwakU3T2JhUnM3QXNxRmVTNmRCbkw0WmVQYkxST0J6cHR1NGw4R1dt?=
 =?utf-8?B?WDZNQzFxUmdzYlpPUFYzcjZCSUsxYm16ZXVaN2hnekJDM3piNnFHQ2JIcG1Z?=
 =?utf-8?B?d3NhYzJQT09oUitQdWhmcXpuR2JIMHVrQlFjL3BRWW1DVklxSVpJak40Y1RL?=
 =?utf-8?B?Y3cwL2FUQmkvOHp1M2hueU5sSm1mQkVCWDRjZk9WeDFNVmV1T1RZT0tKbUxa?=
 =?utf-8?B?aENyNjBoUHNoWWwxSlRDQU1HUTJ5NmhORzRYUmU0dnB5aEZYbDNDN0hlQ21B?=
 =?utf-8?B?TWtmT3R0ODM4QlRnelRLdVFzMTR5ZkQrOUdXUC9ZQURjNWdhT3pib21uc1Z5?=
 =?utf-8?B?d0JvZG1RTC9BTW4xd0xXSzJsVW1mdUJjWmJydUl2NHVTL3E0dWN6MXdZa21O?=
 =?utf-8?B?bEFuUVlRN1BJejk1YnJLQmtHUkNpSHR6TEZuMUhPTUgyR3hKMGVOZVJ2UXAy?=
 =?utf-8?B?akRjZ29Kay92bmJYUlo5TzVHektTUW1KelJVN2xkbi9LVUZhaHdYbjRrUkdH?=
 =?utf-8?B?WW5VbEFaVGRLZlNobWVoT1UxK04xUHYzVndtLzR6VjhwelI5dDJvSklKNUZs?=
 =?utf-8?B?eG1jcThpSXQ2TmlDWnlzNEhtV05rdVp6OS9EeVJuUXNpMzV6TEwzOHM0SXpH?=
 =?utf-8?B?emxScnpnMXVWcElxN29NZmVwektrN29ubE5oMmEvREFSR082aFRmbGFsUVRh?=
 =?utf-8?B?b2NmSWNlbHlaQWFRQmZ4cDQ0OC9kNUlWcHgxbkZYb2IzNmo1cUNHYVJuSEZM?=
 =?utf-8?B?RHZJYkNJa2pnUWpTYkFoMWc1VEJSeDBuUVZucUtnNEt3MUxsdU1xUGhja2ps?=
 =?utf-8?B?ZG40LzhjbDVHWUR4RTJqczBJd1g1bWM4RTlub2U5ZVZpbnpyWERUS1pwcURY?=
 =?utf-8?B?Q0FqWGhlZVYxVU9tZzZLMGhMTzlSdEgxQUY2WStNM1JrTHZvSVhlZThKVHp1?=
 =?utf-8?B?VXVLRzNKcVRjaDgxWTJwYi9NdTVDVC9CV1Z4U1o5dGptREx5eEZDa0ROcGFv?=
 =?utf-8?B?T1luaUFoS0grTjZydUo1RmdyeDlkZUQ3N0poZUNpcVZyNVQwYWJJV2VlVi92?=
 =?utf-8?B?d0JTMnpMZlhzMmZ1ZDhILzh0ZzV2TmpzUERJMk8rWThqRG43Y1pGMG9WQ092?=
 =?utf-8?B?K3NEck05TFMrR3B2WDkxRit5THJ4NmlTNmZQT2JtT3BBWnBhSEtZN2Q3R0Jl?=
 =?utf-8?B?b2Z6QlY0enV6UnZ0alN2azUwYjRIa0I0c1drR2R3TjRzUExUbjM4dzRtSUd6?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u0a0596FuxZZ4TrWkAut42NVVWgfH3lBlaJ+qviB7HwG4bZVC0DZqeAyI0lI++GpPfzRAsTXK1nZnF/p1hlTfMsYKycPnHmQhAGzO3eER+IbcTc+MVLBWmUP9aDqOXYiNGiq0rBrI58KWPpDxhor0Ir+VXoi2MdMvYEkYEXbWXK27K0hf68ZnoM6QDpf+QziJF6UY10lDPeqtne5HxC0lDuz6v6DCSvI2rYNvxg+JMH/xKHTHkCyHLRiItExGeo6E/tHw7M67brm8ESDiu3WwtCTwMQUEkudkEEvE+mfD1N0yp/7lu4urRlNkCnMIaJ1dBVf3/Lqzrxguxn/zc1W7t14hC9Z6qGifrDDxhTdbDA/Rw3RYI1JSsBRcM7hVkgSAgw2ZRtmCrLXD2sGcfEbMAXwXagW/4ZmSVhixTG3OlqShAcRH6O10/J8qhFMfKt8IBnM7MLPCyyhFoCzerpWx3KuRaBzRthYBcHDycKeSgNCeKsNt81qd/1ihbH4s1KPUJuruv9P4xXt/YhfB+anvfcR0GRQ0a6Qcb0Y5ngEnFgwhW29rzaUn8AAmLopBjljNoOHpeA1B6C1fAKfNSSakf1Wt5y4tTxdq3By6DYcLmEpdlfp3xLAQwXtseMR0M2XgS+gfQvGZXGDeZ4A7u6I3qwt8T0ivxxnOLPjMf7xYHMPYrDbyfHZx4xulJOYMKnWixMU4sce9pfvVX+BC/EVHEk6kPIDWAD0ms/+eaN4zxuqTtJhh2xJz+S9wqCM/F6MI+15D4UDduOPs8wHX74S7cisugnsIXI73PCjt4P9QXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef181fd-d98e-41b1-468d-08daf47d572f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:13:59.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz1Lr/8K+1fMpciS2x1tN8HcZ7A26DPm7NKgJu2puYh9Q8StYmL+OWsnMhMUYCZpGOZO3xrlmExJ8/tlkQaRKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_05,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120063
X-Proofpoint-GUID: gHSkwhhFNeB9AYrTH5mByQKJsXjZJrUI
X-Proofpoint-ORIG-GUID: gHSkwhhFNeB9AYrTH5mByQKJsXjZJrUI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/01/2023 13:50, Qu Wenruo wrote:
> [BUG]
>  From the introduce of mounted fs feature sysfs interface
> (/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
> updated.
> 
> Thus for the following case, that directory will not show the new
> features like RAID56:
> 
>   # mkfs.btrfs -f $dev1 $dev2 $dev3
>   # mount $dev1 $mnt
>   # btrfs balance start -f -mconvert=raid5 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  skinny_metadata
> 
> While after unmount and mount, we got the correct features:
> 
>   # umount $mnt
>   # mount $dev1 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  raid56 skinny_metadata
> 
> [CAUSE]
> Because we never really try to update the content of per-fs features/
> directory.
> 
> We had an attempt to update the features directory dynamically in commit
> 14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
> files"), but unfortunately it get reverted in commit e410e34fad91
> ("Revert "btrfs: synchronize incompat feature bits with sysfs files"").
> 
> The exported by never utilized function, btrfs_sysfs_feature_update() is
> the leftover of such attempt.
> 
> The problem in the original patch is, in the context of
> btrfs_create_chunk(), we can not afford to update the sysfs group.
> 
> As even if we go sysfs_update_group(), new files will need extra memory
> allocation, and we have no way to specify the sysfs update to go
> GFP_NOFS.
> 
> [FIX]
> This patch will address the old problem by doing asynchronous sysfs
> update in cleaner thread.
> 
> This involves the following changes:
> 
> - Allow btrfs_(set|clear)_fs_(incompat|compat_ro) functions to return
>    bool
>    This allows us to know if we changed the feature.
> 
> - Introduce a new function btrfs_async_update_feature_change() for
>    callsites which change the fs feature
>    The function itself just set BTRFS_FS_FEATURE_CHANGING flag, and
>    wake up the cleaner kthread.
> 
> - Update btrfs_sysfs_feature_update() to use sysfs_update_group()
>    And drop unnecessary arguments.
> 
> - Call btrfs_sysfs_feature_update() in cleaner_kthread
>    If we have the BTRFS_FS_FEATURE_CHANGING flag set.
> 
> By this, all the previously dangerous call sites like
> btrfs_create_chunk() can just call the new
> btrfs_async_update_feature_change() and call it a day.
> 
> The real work happens at cleaner_kthread, thus we pay the cost of
> delaying the update to sysfs directory.
> But considering sysfs features is not a time-critical feature, and even
> with delayed operation, above balance has updated the features directory
> just after the balance finished.
> 

Looks good to me. Here, the sysfs layout update (by cleaner thread)
happens before the commit_transaction completion. And if the write
fails, we would have already updated the sysfs. Can the sysfs update
after commit completion?


Thanks, Anand



> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/block-group.c     |  9 +++++++--
>   fs/btrfs/defrag.c          | 10 ++++++++--
>   fs/btrfs/disk-io.c         |  3 +++
>   fs/btrfs/free-space-tree.c |  2 ++
>   fs/btrfs/fs.c              | 28 ++++++++++++++++++++--------
>   fs/btrfs/fs.h              | 32 +++++++++++++++++++++++++++-----
>   fs/btrfs/ioctl.c           |  3 ++-
>   fs/btrfs/props.c           |  7 +++++--
>   fs/btrfs/super.c           |  7 +++++--
>   fs/btrfs/sysfs.c           | 26 ++++++--------------------
>   fs/btrfs/sysfs.h           |  3 +--
>   fs/btrfs/verity.c          |  3 ++-
>   fs/btrfs/volumes.c         |  6 ++++--
>   13 files changed, 92 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e90800388a41..32f56e14f53a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -828,6 +828,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>   	    (flags & BTRFS_BLOCK_GROUP_RAID1C4)) {
>   		struct list_head *head = &fs_info->space_info;
>   		struct btrfs_space_info *sinfo;
> +		bool feature_changed = false;
>   
>   		list_for_each_entry_rcu(sinfo, head, list) {
>   			down_read(&sinfo->groups_sem);
> @@ -842,9 +843,13 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>   			up_read(&sinfo->groups_sem);
>   		}
>   		if (!found_raid56)
> -			btrfs_clear_fs_incompat(fs_info, RAID56);
> +			feature_changed |= btrfs_clear_fs_incompat(fs_info,
> +								   RAID56);
>   		if (!found_raid1c34)
> -			btrfs_clear_fs_incompat(fs_info, RAID1C34);
> +			feature_changed |= btrfs_clear_fs_incompat(fs_info,
> +								   RAID1C34);
> +		if (feature_changed)
> +			btrfs_async_update_feature_change(fs_info);
>   	}
>   }
>   
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 8065341d831a..00dd3dd5b256 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1336,6 +1336,8 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>   	 */
>   	range->start = cur;
>   	if (sectors_defragged) {
> +		bool feature_changed = false;
> +
>   		/*
>   		 * We have defragged some sectors, for compression case they
>   		 * need to be written back immediately.
> @@ -1347,9 +1349,13 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>   				filemap_flush(inode->i_mapping);
>   		}
>   		if (range->compress_type == BTRFS_COMPRESS_LZO)
> -			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> +			feature_changed |= btrfs_set_fs_incompat(fs_info,
> +								 COMPRESS_LZO);
>   		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
> -			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> +			feature_changed |= btrfs_set_fs_incompat(fs_info,
> +								 COMPRESS_ZSTD);
> +		if (feature_changed)
> +			btrfs_async_update_feature_change(fs_info);
>   		ret = sectors_defragged;
>   	}
>   	if (do_compress) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7586a8e9b718..a6f89ac1c086 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1914,6 +1914,9 @@ static int cleaner_kthread(void *arg)
>   			goto sleep;
>   		}
>   
> +		if (test_and_clear_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags))
> +			btrfs_sysfs_feature_update(fs_info);
> +
>   		btrfs_run_delayed_iputs(fs_info);
>   
>   		again = btrfs_clean_one_deleted_snapshot(fs_info);
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index c667e878ef1a..1a001de86923 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1195,6 +1195,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
>   
>   	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
>   	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
> +	btrfs_async_update_feature_change(fs_info);
>   	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
>   	ret = btrfs_commit_transaction(trans);
>   
> @@ -1270,6 +1271,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
>   
>   	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE);
>   	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
> +	btrfs_async_update_feature_change(fs_info);
>   
>   	ret = clear_free_space_tree(trans, free_space_root);
>   	if (ret)
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 5553e1f8afe8..a02e6b6cb97c 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -5,15 +5,17 @@
>   #include "fs.h"
>   #include "accessors.h"
>   
> -void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			     const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_incompat_flags(disk_super);
> -	if (!(features & flag)) {
> +	changed = !(features & flag);
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_incompat_flags(disk_super);
>   		if (!(features & flag)) {
> @@ -25,17 +27,20 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }
>   
> -void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			       const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_incompat_flags(disk_super);
> -	if (features & flag) {
> +	changed = features & flag;
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_incompat_flags(disk_super);
>   		if (features & flag) {
> @@ -47,17 +52,20 @@ void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }
>   
> -void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   			      const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_compat_ro_flags(disk_super);
> -	if (!(features & flag)) {
> +	changed = !(features & flag);
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_compat_ro_flags(disk_super);
>   		if (!(features & flag)) {
> @@ -69,17 +77,20 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }
>   
> -void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_compat_ro_flags(disk_super);
> -	if (features & flag) {
> +	changed = features & flag;
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_compat_ro_flags(disk_super);
>   		if (features & flag) {
> @@ -91,4 +102,5 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 37b86acfcbcf..b6f2201a1571 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -130,6 +130,12 @@ enum {
>   	BTRFS_FS_32BIT_ERROR,
>   	BTRFS_FS_32BIT_WARN,
>   #endif
> +
> +	/*
> +	 * Indicate if we have some features changed, this is mostly for
> +	 * cleaner thread to update the sysfs interface.
> +	 */
> +	BTRFS_FS_FEATURE_CHANGED,
>   };
>   
>   /*
> @@ -868,14 +874,18 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
>   void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
>   			  enum btrfs_exclusive_operation op);
>   
> -/* Compatibility and incompatibility defines */
> -void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +/*
> + * Compatibility and incompatibility defines.
> + *
> + * Return value is whether the operation changed the specified feature.
> + */
> +bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			     const char *name);
> -void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			       const char *name);
> -void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   			      const char *name);
> -void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				const char *name);
>   
>   #define __btrfs_fs_incompat(fs_info, flags)				\
> @@ -952,6 +962,18 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>   	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
>   }
>   
> +/*
> + * Called when btrfs has feature changed.
> + *
> + * The real work is delayed into cleaner.
> + */
> +static inline void btrfs_async_update_feature_change(struct btrfs_fs_info *fs_info)
> +{
> +	set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
> +	if (fs_info->cleaner_kthread)
> +		wake_up_process(fs_info->cleaner_kthread);
> +}
> +
>   #define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
>   						   &(fs_info)->fs_state)))
>   #define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info)				\
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7e348bd2ccde..f11443578acd 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2942,7 +2942,8 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
>   	btrfs_mark_buffer_dirty(path->nodes[0]);
>   	btrfs_release_path(path);
>   
> -	btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL);
> +	if (btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL))
> +		btrfs_async_update_feature_change(fs_info);
>   	btrfs_end_transaction(trans);
>   out_free:
>   	btrfs_put_root(new_root);
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index 0755af0e53e3..114d567043d7 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -302,6 +302,7 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>   				  size_t len)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	bool feature_changed = false;
>   	int type;
>   
>   	/* Reset to defaults */
> @@ -324,12 +325,12 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>   
>   	if (!strncmp("lzo", value, 3)) {
>   		type = BTRFS_COMPRESS_LZO;
> -		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> +		feature_changed |= btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
>   	} else if (!strncmp("zlib", value, 4)) {
>   		type = BTRFS_COMPRESS_ZLIB;
>   	} else if (!strncmp("zstd", value, 4)) {
>   		type = BTRFS_COMPRESS_ZSTD;
> -		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> +		feature_changed |= btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
>   	} else {
>   		return -EINVAL;
>   	}
> @@ -337,6 +338,8 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>   	BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
>   	BTRFS_I(inode)->flags |= BTRFS_INODE_COMPRESS;
>   	BTRFS_I(inode)->prop_compress = type;
> +	if (feature_changed)
> +		btrfs_async_update_feature_change(fs_info);
>   
>   	return 0;
>   }
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 433ce221dc5c..76566ad2d966 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -316,6 +316,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   	bool saved_compress_force;
>   	int no_compress = 0;
>   	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
> +	bool feature_changed = false;
>   
>   	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>   		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> @@ -431,7 +432,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   				btrfs_set_opt(info->mount_opt, COMPRESS);
>   				btrfs_clear_opt(info->mount_opt, NODATACOW);
>   				btrfs_clear_opt(info->mount_opt, NODATASUM);
> -				btrfs_set_fs_incompat(info, COMPRESS_LZO);
> +				feature_changed |=
> +					btrfs_set_fs_incompat(info, COMPRESS_LZO);
>   				no_compress = 0;
>   			} else if (strncmp(args[0].from, "zstd", 4) == 0) {
>   				compress_type = "zstd";
> @@ -443,7 +445,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   				btrfs_set_opt(info->mount_opt, COMPRESS);
>   				btrfs_clear_opt(info->mount_opt, NODATACOW);
>   				btrfs_clear_opt(info->mount_opt, NODATASUM);
> -				btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
> +				feature_changed |=
> +					btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
>   				no_compress = 0;
>   			} else if (strncmp(args[0].from, "no", 2) == 0) {
>   				compress_type = "no";
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 45615ce36498..f86c107ea2e4 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2272,36 +2272,22 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>    * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>    * values in superblock. Call after any changes to incompat/compat_ro flags
>    */
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set)
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_fs_devices *fs_devs;
>   	struct kobject *fsid_kobj;
> -	u64 __maybe_unused features;
> -	int __maybe_unused ret;
> +	int ret;
>   
>   	if (!fs_info)
>   		return;
>   
> -	/*
> -	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
> -	 * safe when called from some contexts (eg. balance)
> -	 */
> -	features = get_features(fs_info, set);
> -	ASSERT(bit & supported_feature_masks[set]);
> -
> -	fs_devs = fs_info->fs_devices;
> -	fsid_kobj = &fs_devs->fsid_kobj;
> +	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>   
>   	if (!fsid_kobj->state_initialized)
>   		return;
>   
> -	/*
> -	 * FIXME: this is too heavy to update just one value, ideally we'd like
> -	 * to use sysfs_update_group but some refactoring is needed first.
> -	 */
> -	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
> -	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
> +	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
> +	if (ret < 0)
> +		btrfs_err(fs_info, "failed to update features: %d", ret);
>   }
>   
>   int __init btrfs_init_sysfs(void)
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index bacef43f7267..86c7eef12873 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -19,8 +19,7 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device);
>   int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set);
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info);
>   void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
>   
>   int __init btrfs_init_sysfs(void);
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index bf9eb693a6a7..998884b57216 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -561,7 +561,8 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
>   	if (ret)
>   		goto end_trans;
>   	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
> -	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
> +	if (btrfs_set_fs_compat_ro(root->fs_info, VERITY))
> +		btrfs_async_update_feature_change(root->fs_info);
>   end_trans:
>   	btrfs_end_transaction(trans);
>   out:
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bcfef75b97da..2ae77516ca3f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5031,7 +5031,8 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
>   	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
>   		return;
>   
> -	btrfs_set_fs_incompat(info, RAID56);
> +	if (btrfs_set_fs_incompat(info, RAID56))
> +		btrfs_async_update_feature_change(info);
>   }
>   
>   static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
> @@ -5039,7 +5040,8 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
>   	if (!(type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)))
>   		return;
>   
> -	btrfs_set_fs_incompat(info, RAID1C34);
> +	if (btrfs_set_fs_incompat(info, RAID1C34))
> +		btrfs_async_update_feature_change(info);
>   }
>   
>   /*
> 

