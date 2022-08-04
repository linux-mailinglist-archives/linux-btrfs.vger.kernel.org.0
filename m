Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DED589AC8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiHDLNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 07:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbiHDLMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 07:12:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154865542
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 04:12:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274B13Kn012136;
        Thu, 4 Aug 2022 11:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CT+p4u3HDRhHeKXxdae2Xz5VwtYBZfPTVA+4hCEHvuQ=;
 b=zPzXM/MOKLXIZH2eFIxksV1S2GEbpwunpXybIhGF7KQLV2zjoxIcVjj+Tr6yobjfgqQq
 msZM74Wok0Pim7YJg05+lor5UJ54xFg7QedKAGKH/+0+FpR7PLpAH4IQMBFs+cN71CL5
 6cFWMoLAkgKv8QkQXRLQ3rWJ7CXAEv6s0iD12Z/qGAas8nRLJI/UemdmAtJFtz4gNmlP
 e6MUzMbmpVdyrVVKh1TTK2NolORbqqJBC4ThukA3BTJ9tgTIW/LDUKMyThQ2WSywgLSg
 8vHE8PhDFHJqAEwgNHRbR5oCbN/RhB2vtoADJ1CxM+GHEx45fAofUL5oeePQgU5kr08q ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9v92f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 11:12:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2749e5E3014234;
        Thu, 4 Aug 2022 11:12:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu347qqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 11:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO+UQjun9Tj6uCm2r1IHHfQEsntK7x1sO9EbPNMh0vjQV3XFE5ewhEtPCML/A7MaQJtkhKZK+6W1YXrWP19Ya2JabauqXALgv3wb+oNPsWxA4fSXRhZ3UEXmISKhWGHBiLuUQTFVll/b4/DzilYcEpGFwDuLK1L+Tb7+orjKQUKIfUdTzT4tbjyh+WI+KdxncrGbiXkfXZe/QFw4a9N4AG1uCW4GKCusqGKu0rHqiytNj7Da1vEebV1G/0QRf9wlX2Js/6aNMATFTABDUka/jWpP3GZ7NEibvX+TwBC0z+hDUSKat0QTjgihX4gZ5iObpj9DH855uKfQSOjpOmh28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT+p4u3HDRhHeKXxdae2Xz5VwtYBZfPTVA+4hCEHvuQ=;
 b=mz0AGVB9TcOCwEnfdz36MDssDoFmjNV7EXXMLKk0T5UBm7uxGyaRAkiPYMxb9sOxGJXLRHF52/8uON7VCKFRccoOlGkwzdJEYNGslhyUOyPnS5NpV9hjE+Uf0xdBk5Oobz+2r3Iul8B9/5xuENyzt72Do5BLcimwVIv0NXS93J2W1tWLvgZcRO65tN1HcoKY+yKzZuDmdCvCPbD/boREjiF305dgi/+WXEfb91q1pDoxJ4Ml08A6DBHlGzJQRBz9ofv+Fcjlxfyfp4iYqygLCVSX+NP4+FoKuGoYTx3uAxFpEu3Di7i0CGW2uO6zRE0r4vmVQHecXcTDJ7SreqPONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT+p4u3HDRhHeKXxdae2Xz5VwtYBZfPTVA+4hCEHvuQ=;
 b=AGSXbc7kwohuN5o7evzgCEOwFqvcxjTu2JnjMF5mQD1mjdvKDhm0oYQ8WdVG7aJP0AtOklPmfzpdgSp9P6IvCWENhi3SG+L3Sxesn6QguuzGdlmIr5nZz65rIdMyI5X3QgRZjKTDS4JoY21uO/qNE5uSXb1RKUt3o0Ul+a6ohlI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5842.namprd10.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 4 Aug
 2022 11:12:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 11:12:43 +0000
Message-ID: <bf1c7443-8010-7ddf-d62b-78735860c818@oracle.com>
Date:   Thu, 4 Aug 2022 19:12:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] btrfs: add checksum implementation selection after
 mount
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659443199.git.dsterba@suse.com>
 <cc590040e5393aad0294e3d7c592de991706cf2e.1659443199.git.dsterba@suse.com>
 <cb79999e-a16c-294e-4dab-74c4be45b85e@oracle.com>
 <20220803140049.GH13489@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220803140049.GH13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fe400bb-cd58-4e3b-4b26-08da760a408f
X-MS-TrafficTypeDiagnostic: SA1PR10MB5842:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GVQqcEJhBz5vuuIe6JALopbAcN9bU6dzIbyCvVqcRK6ZbRqYnDu/UuH8ERvCJVE/d8lgJ0A4IYBH1TeNGxNiqHBbEnQt6kUQg+8Tb5n6KvrmRH9UMJcS5lB6YlFtKWqcqIei0PthDw5Ltwi4VKGgk0jkRfCcINAw6QnNP29Zs0AOVx0F/WdU4UMHc3E+bYYRUKSXruRnLBigbDALkddzzC7AEtsRGcj+j8zMFvNfo/RxB3JE4kiDHGqO0IEojOtweWYHhsj+joH+UBLtw4AVwDb7PT5YjRonw880mS95XobNUIIrQsRZeVIM1YFeiVMIPQYi+tVmUXj/pEvoql9WlBp1QFfMFKZSCzd3jazmgma5vSX4dCtI+UqadBHG8DwkYEaW1/l9iZwgk5vSw4hd+oXrwOVTi7DsqyKuhgURXSRTm9jNT27eDZz//WpyV6juupDO7STNqD7kSbSqXRVALR+y4GEytUVizAFiu0Jj6XwmTSFjHn4nEkfqGEOg1K/GTBb4gzQY9Rh1aZBtCLUxKBy3OtDJEJkFJS06RYs1L3Cgso5UxU6+Pty+evpiLt0fE7Ad9ZLsxmIEHEPULkbz7ILQI63D9WzE+ejB3SyZ5F2gN2qqzCkT1ojcN/wjKVxA5F39GIy519uRFa5bKj7u1SqBl3t19TcyfQebmQWvkxVnqa+G/fb5NFMOZaus1X7HCG2HLNTHkWBTs1NFTqcqRzVXjBij6qcps/ENyzc8VRee2jJ3H1KC7bKWChV4at0UyIDnF5U+j+OeAksfllTw/qnO5kLfkyMRyRzIv4ULoZjknvInjnBVVdDFoc5yJA8XK4ES8cnJrK7bSvkU2zDog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(346002)(39860400002)(44832011)(6486002)(186003)(478600001)(66946007)(83380400001)(38100700002)(5660300002)(8676002)(86362001)(66556008)(66476007)(6506007)(2616005)(41300700001)(36756003)(31686004)(6512007)(6666004)(26005)(53546011)(31696002)(316002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9wSldtUTJwL1RaNG9QYnJLdlVzbGZIYzhuVEM5R3JVZWhnY0xabWNDbitr?=
 =?utf-8?B?dG9CVU1pMjJJS3NxNksyS05jdzlVb0sxM09WQmM2MENPVmZPbGxJbU96ajRN?=
 =?utf-8?B?Tk9aVUJvc0tpSjUyV0FXWGF6VW1HSmxYdkFzVFJzbTcvT0lhUWxIZVFHTTg5?=
 =?utf-8?B?eHJ0MHRRSFl3RlZkTzBOQmkwUUN4NFdkdXJwUFBrUlEwT3BPQnYvUW1maEpr?=
 =?utf-8?B?MTI0cjdob3BUS0FvSXhJdFhwU2V6T0l2VWpXT3J1TDIvSXJ2SmEwdkxqTExu?=
 =?utf-8?B?Unl4YWV6Vi9Ga0gxdmpYZit4USszQlJNZHVBNVdhN3Q5SXlKYXhUaUY0YjVW?=
 =?utf-8?B?aGUrM0poajRYR25zcU9XTHhFaEsvalNqRkJybENoUXJUUmxzMTFpWVNDaEhO?=
 =?utf-8?B?ZGtpNzc4c1dSbVlCUnIyN0RIM0ZEakd4YW5HbXZMZHAwUlV3MEdXT0dDZ2xV?=
 =?utf-8?B?OWIyVCtnNUhKTWV2R2VyOVFHdEs2S2JKTGNZRXFaajhEN3FTRGNHNllVUGdL?=
 =?utf-8?B?SzBmaDVwMXRlL0RJNkttT0NiR3pDOVlWNm8xR3E5bEZHWjlTN3p6U3h5aGcx?=
 =?utf-8?B?eUxubThHYi9VQXNvSjl3REd2Z0ZqbWdhQzVoMjNpUnJQVC8vdVJrdGE2N1Qv?=
 =?utf-8?B?SHVPbW9uZDRiZUVqSGNaK3Q1a3NiQUVLNEtTNjdYL3VyOTFvVWkzdlNZMlA1?=
 =?utf-8?B?d2RQNmxPQWlBcXN1T3FYbEhhcE10MFhnTFhxTU5ReFlzZDhWbjdEN0toVm9x?=
 =?utf-8?B?K0VuSWtJMmIxQysvYXh6dG9UMXhseWc3WnNsUjRmeGpsdGZMamsrRkwwdDBu?=
 =?utf-8?B?T3c2bHBVRi8zWGpnWS9xZ2FmVG1ENzl5ZFF2L2lXQ2dDMTJjNHFETWtzWHNN?=
 =?utf-8?B?bEdjSGo3UUFyKzhpMURXK2Q2Ris0NWtOZUtKQUpWVkJrYkpOdE9xbGgyMWNn?=
 =?utf-8?B?NkxmMlNQd3dtRGlGNHAyZ2tUdzdZM0x1N0w3WS9hc2ZtT3pvT1hQdFB2Sk1S?=
 =?utf-8?B?QXQzTk81YkFUSDR3Y0E5ZkhhTVFGREJpRlFQc2NTMVR4aHBWK3JoL20yVFUw?=
 =?utf-8?B?dW8wWnREL2hXa3oyQmlWbHB4elR1YnBSbS9EYldDQUdKd05POVl3V3JscTZK?=
 =?utf-8?B?bVdENkJCV3BmYTdvZUxHQ2JmMEwvM0N6ZC9rMDRHR1cyRGJWdzZHNllEKytX?=
 =?utf-8?B?elBET0FsYnkzOXA3YitNd3l5ejRRNVRaanY2cHlmcFhTbVpSbmp0SVQ1LzVs?=
 =?utf-8?B?MWgwajRZSDNLdmY2cVNDSVUvMnE5N1NiUVRlbm54TjAzc0YzdE9HbFUyd0lw?=
 =?utf-8?B?V3RSSjhvZ21MaC9rTGQ1aXA4QThlM0RlZUFLY2luOERWOHJhWEVvbUlLUStL?=
 =?utf-8?B?dU9BQnAwQXNabGxKUndzQlhoSTlvMkNzWlV3dTFDOTVaaGVWK2tVTHpIZjQx?=
 =?utf-8?B?WVpFUnRvS2tYcXU5Wk5paS9xRWl4UHdSS0krOEVCZTlzeDBYVkxYdHRETjRW?=
 =?utf-8?B?Q3Q0WEloWHpaZkF0Q3BJTlgxTkZsYXNHNjBoN3FjMlVuemRVOW9heWpHdGtl?=
 =?utf-8?B?WmpnZXNQMHFaVVdicWMxTlBXb1hhRGFPcHNIaW0zNlFON0wyeXFEM1NGV2Iz?=
 =?utf-8?B?MWxXMmpkbW9MNXgrUkJPZzBVQUY1VEJ1UTNFMWQ3SElONUQzMEJLRHBuaFBW?=
 =?utf-8?B?a05qWEt3S0U1K3Z5SkpFOGZqR3RpaFVMUVcwSCtSVmkzZmh3SkxzSTRQcFUr?=
 =?utf-8?B?MlUxYVpkNXhyZ2duZEVxOGx1NDRLS3dRb0piaVlCQ3lMT2RnT1F1VXVYQWNM?=
 =?utf-8?B?cmdaQ3VRcVBVNUlUaGJUbTJmZ2E0ZDlSOFJDVVFmM1ZqLzdyUVZSZm11WEpF?=
 =?utf-8?B?YWJFZGxYTHRlSWxWV29YSUc1cWdHdTR6YkMzeS9XRHlQY1BGSEFGTDc2cHAr?=
 =?utf-8?B?dFNlVitIaWdrODhCWk1BczVmZjZSajJXc2RscHFzQUlHNFRvdENybVlaQUFw?=
 =?utf-8?B?bU5zNXRsM251NG5HZURuN1d3azJxWjRJeHlra1p0dmtKS0xxcm84ZlZvN1RP?=
 =?utf-8?B?eWRXR2prZnBYc054VDByOFpoamtEM0pJVTFTR2ptOTRYd0VuNHdBZFVGSFJB?=
 =?utf-8?Q?wgKFecdP5BcPZZd7H7s4CNhdi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe400bb-cd58-4e3b-4b26-08da760a408f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 11:12:43.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi7S+svVAW9I6ELqr1/Q/3DtaOpobwqejy6vDjAY1wBF5tpKziGpKB0cH2fS8N53MquH0xYN2rBTNa0h5ocz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208040049
X-Proofpoint-ORIG-GUID: GV2golBM4yDgZdlZllso_fc855e1Esnk
X-Proofpoint-GUID: GV2golBM4yDgZdlZllso_fc855e1Esnk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 03/08/2022 22:00, David Sterba wrote:
> On Wed, Aug 03, 2022 at 08:06:46AM +0800, Anand Jain wrote:
>> On 02/08/2022 20:28, David Sterba wrote:
>>> The sysfs file /sys/fs/btrfs/FSID/checksum shows the filesystem checksum
>>> and the crypto module implementing it. In the scenario when there's only
>>> the default generic implementation available during mount it's selected,
>>> even if there's an unloaded module with accelerated version.
>>>
>>> This happens with sha256 that's often built-in so the crypto API may not
>>> trigger loading the modules and select the fastest implementation. Such
>>> filesystem could be left using in the generic for the whole time.
>>> Remount can't fix that and full umount/mount cycle may be impossible eg.
>>> for a root filesystem.
>>>
>>> Allow writing strings to the sysfs checksum file that will trigger
>>> loading the crypto shash again and check if the found module is the
>>> desired one.
>>>
>>> Possible values:
>>>
>>> - default - select whatever is considered default by crypto subsystem,
>>>               either generic or accelerated
>>> - accel   - try loading an accelerated implementation (must not contain
>>>               "generic" in the name)
>>> - generic - load and select the generic implementation
>>>
>>> A typical scenario, assuming sha256 is built-in:
>>>
>>>     $ mkfs.btrfs --csum sha256
>>>     $ lsmod | grep sha256
>>>     $ mount /dev /mnt
>>>     $ cat ...FSID/checksum
>>>     sha256 (sha256-generic)
>>>     $ modprobe sha256
>>>     $ lsmod | grep sha256
>>>     sha256_ssse3
>>>     $ echo accel > ...FSID/checksum
>>>     sha256 (sha256-ni)
>>
>> I am not sure if I understand the use of slots 1 and 2 correctly.
>> As each checksum type can be either generic or accelerated, slot 0 is
>> the default which tells the preferred method. So slot0 is either
>> CSUM_GENERIC or CSUM_ACCEL. And by default, we prefer accelerated when
>> available or user requests. So I am still not getting the purpose of
>> slot1 and 2. Instead, overwriting slot0 will still do the job without
>> slot1 and 2.
> 
> We need to keep track of all allocated hashes so they don't leak, which
> would happen if slot 0 is overwritten after the switch. Also we must not
> free the hash from sysfs because it could be in use. That's why there
> are slots that keep track of the allocated structures and slot 0 that's
> provided to use it for checksumming, merely as an alias.
> 

> The pointer switch is atomic (regarding the pointer value, not the
> atomic_t semantics) so once some function uses it for shash it'll stay
> there even if it won't be the default anymore.

How would that help? The read part depends on the CSUM_DEFAULT, which 
can change per user request. As below.

+	/* Select it */
+	fs_info->csum_shash[CSUM_DEFAULT] = fs_info->csum_shash[type];


> 
> I could add READ_ONCE/WRITE_ONCE for the slots so it's clear the access
> is done in some unusal way, as we do with other sysfs variables.
> 

IMO it is a must as we do read twice in all functions. For example:

disk-io.c:	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
disk-io.c:	shash->tfm = fs_info->csum_shash;


>>> The crypto shash for all slots has the same lifetime as the mount, so
>>> it's not possible to unload the crypto module.
>>
>> How does the update of the accelerated module work if a btrfs is a
>> non-root filesystem? Does it need a reboot?
> 
> By update you mean rmmod/insmod with eventual update of the .ko file?
Yes.

> That won't work due to reference counts, so reloading the module would
> require unmounting the filesystem, or reboot.

ok.

> Freeing the allocated hash structure could be implemented by usage
> counters when there's some checksumming in progress, the sysfs write
> would wait until there are no users left and then free it.

Looks like we need something that.


A basic question

Isn't that a module load at the boot will solve the problem?
