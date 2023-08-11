Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D724779239
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjHKOwV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjHKOwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 10:52:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CD72702
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:52:20 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BEUnrc023363;
        Fri, 11 Aug 2023 07:52:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=eu13aIWfwtZHKwZYHe56XCmz4pTapseKjXqHQc5vVt4=;
 b=cD2tR/a3Sd0GgLl14GZAaQ9BmHnScCpVJWNTGgeRNBeoeet+ht2LNsbDWpSx4HlYTxb8
 YK8L9ltyJRTva9UekVgP1s3XTACcIYRVoTRjr85sz529JBd6w2Nt3rDdoH+8ABzc0Uzs
 XD5K2cqS6DEDAqfkISrSMuuRlUApbmLeGZnGc9my3yy+3qAC4UNI48b8kOJsZaEX2TrM
 YNBrpVNJ0z5crFmsYuYjt+CePvtpQdmWnZ07oHHl9zNqu5QuDwm6gD31hIl8kzfGw5wX
 951Xfd9PSF2l227JwM5d601xewvbprk4pRfTrUNC8yx7dPOV695SsEr0+w2Qw6VhTFnX 1Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sd90a7221-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 07:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvTEDByUIq1s0F9GviH4cXfntSPLqz3bzucxmrZFoVBpMpZ4VjreOQ8OqskXrxwVLM5YIGTNPwdX/0qcWOkXsKa0tud4KcaWUWnJmyP4qw/2jc+UJ+6iF886sc5NGyN063smGqdBg0DrwhTtrZSWM14OqV3nzqGglu+Jor7fCO8/kGjR9XWJtVdwRiN4LUXnmT3Hl2MLOxyNdCpCEm8+XwgGWjDHoGD3pe3uhwtF3d/yyk5mUFUxHE7KBTFOaWXzvGbcu0sMs5XQLP29Ozz1Ea86VV3/f1+xFaPxavfa563NSqxz2dUId07mfk06c27EB4aTEFgcxkeX8qzFU2DjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu13aIWfwtZHKwZYHe56XCmz4pTapseKjXqHQc5vVt4=;
 b=b9ayzGM3YtI+iCxvlDHV7t9HgjXVziRBtCkkWv8qxyHUeXuQ0/aSRsduqlYRnQvXRBFZN8kzymyQD8SIf9RhGombrQBpDoEqxAGhtaKPxx2FvGCrblhqgzINN7wAAReWeOFqYkP2paofyOUt3kt+rr8/Zaumftlr4YHoCDOdqIB+HoM8WBG6cddvA+Z6l4o2Ctft0Uo8vlOt7TgrEm2H5M+Vul69WTuEoRkHtageiN0fG2KLf44Z3b+igrMBThDhWfT7CBC8KE7tQ1PzcSA/zbayh1xFoP6V4UCydlXT6VieQlyAQD1bTzHuuuWPQRUwLCEdoJH0lKIlF9RanTz+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH0PR15MB4638.namprd15.prod.outlook.com (2603:10b6:510:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 14:52:11 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80%5]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 14:52:12 +0000
Message-ID: <20ab0be0-e7d0-632b-b94c-89d76911f1ed@meta.com>
Date:   Fri, 11 Aug 2023 10:52:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
To:     Wang Yugui <wangyugui@e16-tech.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
References: <20230802080451.F0C2.409509F4@e16-tech.com>
 <20230802092631.GA27963@lst.de> <20230811222321.2AD2.409509F4@e16-tech.com>
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230811222321.2AD2.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0120.namprd02.prod.outlook.com
 (2603:10b6:208:35::25) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|PH0PR15MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e914f95-0734-4909-1124-08db9a7a8b5e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNgHLbYTh7MRSA7AgcPUoXD/PxK6BTxBoFSjRqfr9h+ofclJhBCaPRgB/ZSuoZv8EMbML74aEHmq49ZSiIjYxm0i3gTQSZIyDcQfD5Vfb9aPYS7r0N1XUwklyqCWn23sS5sKcTKY+YIaF3kKPQUPH+9AGuQpt7mQnVgzCrglAyOoUmRA6+3TsXBgosO8NO6UApUKlgzHjf6lP2Td1wSZa5PleJtejjW9R/j+8KllvKUe3tb2WcA89HV1clmMr8TaXiUoZ5JeLJwylza7Fi3SHx8d6GxwERzPkP20fd0RrIZJGfwIwmrvmfi/yr8qjfFCF8IjIc6zhtTHxzhxr8l6Wzwu8eFgYMED760FMnHwVgZ07Acsu7WWWSN87mWYJvUvEehI1WnzfXIII9V8FmLYjCHCDSBzZ+hbr1X+Puqc38ejYHDskM5j9qqwcOkD/zskzmxLQq7K/OQnmuT+mKhVs/U052IEwS0MLgGiCumqxht9l0y0ULAXZ2EteNcP7fIx8P4jNzqVGEwNJz3XJ6iaCP+K2/0XiwV0z0TjXQh1sRtHSXmE0uyzpjWfDvXvlyBYDd8dLmt37vgKePyK3HzZWic1r3G8ud6nUZO4wQbZG/2ufPwnlX7+xADSJfspArh1/QR3DTRW+SktJ+bXXXmQYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(186006)(1800799006)(6512007)(478600001)(6486002)(66476007)(66556008)(4326008)(66946007)(5660300002)(316002)(6666004)(110136005)(31686004)(53546011)(41300700001)(8676002)(8936002)(6506007)(31696002)(86362001)(36756003)(2616005)(83380400001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEZmRnBtc21UUzJZMUxVeFE5OVUvak51VzlKbFQxTnVqbFhtcC9TTHJUSzhj?=
 =?utf-8?B?SFpOVkNrZmMyUytkM0czUHgydUczNXVSZ0N1VCtmVllsSElDYmlRaEk3dGFY?=
 =?utf-8?B?Wk9nMDBsalJFSWZ2N1BWMjkvYXNVYlZua2xNdGtlUnpzandvSTNwKzdYbFlG?=
 =?utf-8?B?OC8vNzcwNDhHaHdjTDR3SklsVXJuUllNRVRweW5Tcy9WVmlIN2E3VHFuUysz?=
 =?utf-8?B?T3dGZ09pVnhXam4wWGUyTmR6b3RJNGk4T2dHZXE4dmZ6RklhN0xpblhRMTN5?=
 =?utf-8?B?dWZqdWtnbXB5TktlOWszUkY4cnRMckUrWmk4V0UwZDBIM0FDRy9EM2Y3WmlO?=
 =?utf-8?B?dWN4c1JyYjc5ZlVxbG94RkNDMnJmaHZ4NG5CN2J6eVoybUVVVmIzS3AzQ1pV?=
 =?utf-8?B?RlRVZzdtNEFjQTBMWjRMM1IwTmFTT1FhNk54aW42MGphNEJkKy9qU1hmME9T?=
 =?utf-8?B?RVBlRHJXU1lBNlh4WWRwNjh1bVlLbWY4cFRvZlpDKzNWazNzdVo0RWgrVlQ5?=
 =?utf-8?B?VTZScUt5b1pNTFlLZlpzWE1HVkNmRXpzMDBSSEsrd0NNM1BZSTZReDBTYytF?=
 =?utf-8?B?TVYyRXlWdzdwQkwwOHhvTktVMkZJL29tRDZCNDJZa21DdGhIVXI2ak1zQ3Rk?=
 =?utf-8?B?dWNubG1DRWpnaDB2bW5KZVRYbWpvbjhrTXduUVRzcjgzc2NjTkc1WGk3c1da?=
 =?utf-8?B?S00yVzhNcUFld3Jkb0cyYzRCSHYzTndwRlk3L1lnV1RhY0NMT0pVNHp1QzYv?=
 =?utf-8?B?eVB5Q0FSMFQ0UEIvaC9hU20wcHBmY3A0ZWJYelZTNlNwZ2lHQmtYUzhQSEJ4?=
 =?utf-8?B?MkNlR1RlcHNtZE9iWnZyanhKazZCTFc1alNleTd0cFk3SUJRSk16Qys1ekhV?=
 =?utf-8?B?ZEdacjBjUG81eVVBZGQrbW9wVEovNndlaWR3SnNnb09oVkNrKzJ3NHhaTGM1?=
 =?utf-8?B?Um1rRG12OEpmbm5MOHRsYjZ6eGorT2FZT1RFMk1uZHg2VjFKZHFId3JtZGUx?=
 =?utf-8?B?MW9YWE5xNnZHRFUzNDdhazNQVzEvVStiR1pFbVRhQnJpaU5rcVhFbmpjRy9O?=
 =?utf-8?B?WUs4MFhTMkxXQU9qQzl5Z0Vvd2RPVnpxMWpJeFdDMTZzSmthakRoQzYyNlY2?=
 =?utf-8?B?WDM2Vnc4bi8zMHplWldDL0pMbGFUa0JSVllOTGt4UVhpQ0RnQmw2cGhVanYw?=
 =?utf-8?B?SXpOS2N6WnpFTE5JVHU3aTVhTm15aitvaUVRbEtnOTFDa1luU3R1S0xwT2Ez?=
 =?utf-8?B?aDR2cXhORmNNa3VWWEdNV2RteStxVmNhaTR5QTBvY3VtbWxhem5Vb3U0aUlY?=
 =?utf-8?B?NHhwTFJxOW5adE5sQ0xiNXA2ZTJaQm1HK0NpbTVkblkwOW9FclNieitPVVUw?=
 =?utf-8?B?V2lsdXpkaExrSnFNOStMMHdzVWdIQUlHMm0ya21mbDNlVVk1SEZCMEJaWnRh?=
 =?utf-8?B?cG0vbm1zS2MxTzJ1c2dwL3BuOURUdWIzWC9Ma0ZQbmJINk1lRkY4V0RoNnFE?=
 =?utf-8?B?VXBXMFJXZWtUV3FwNWdKWTlsaEhvN3JCNG1GVEl0MGZTN2ZUYlJUVTc4YTZB?=
 =?utf-8?B?V1UxZkdTc3A5enB0ZjhzR0VoVWpwLzErdElodDdIdytLeXNGRi9zdXMySndN?=
 =?utf-8?B?K3B4cGpxelMrbU9kMW5tb0JhL2kxR0hjZU1MUkNpZXZhZHRqYU9iT2laTkNt?=
 =?utf-8?B?bnVuc3dOaUppTm83ZUw5M3puajkybnpYZk82YW9mOWFmZ094OE5LenV3Tjc1?=
 =?utf-8?B?WEEzMkRRa1ovLzEwMlpVVTVYa2FxMnJNMFlLbkYwNWhuenRQQ0lYRHdSU2Vi?=
 =?utf-8?B?eG83OVpGcmFxZzQxQ3FYNjExazJEbWlvbmdHZE9xS0tKQno3a1dBeE9RaEd1?=
 =?utf-8?B?YlRTMk9PdnU5SEVYU2JpN3A3cmtOZHRjNUFNd0pmSnNCT2hjUSt5YmpIUXFG?=
 =?utf-8?B?am96SndvcHZXUkpuSTdBb1BaOTZTRlpMTklXTVZWN0t1cVFhV09Yc2RiV2ln?=
 =?utf-8?B?MHZOTHVqdzZlTE1aUUs5aXMva1VHQkQrTnMvUkVBNDlxU1VhVnAyeEFqRExC?=
 =?utf-8?B?ZlA1bUkvdUVIOERQY2hrNC94NEJJZUhMMGpLNmkwT0RwaExZc0NTZEUxRnFH?=
 =?utf-8?B?bHk0ajhQTmcydk8yTDVSRExpLzhqRXp1dDZ2NkpqT3RxYm9VVzlKMlN2MHFU?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e914f95-0734-4909-1124-08db9a7a8b5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:52:11.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJt3Yidq1qX6fUw7IDaiqIohw8kPYKyQ8DINGrFqXMUjTs7mHdRsoVNlip8gcwr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4638
X-Proofpoint-GUID: HLLoO0dU2lscaWh3orxJhlhtLouwk7GF
X-Proofpoint-ORIG-GUID: HLLoO0dU2lscaWh3orxJhlhtLouwk7GF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/23 10:23 AM, Wang Yugui wrote:
> Hi,
> 
> 
>> On Wed, Aug 02, 2023 at 08:04:57AM +0800, Wang Yugui wrote:
>>>> And with only a revert of
>>>>
>>>> "btrfs: submit IO synchronously for fast checksum implementations"?
>>>
>>> GOOD performance when only (Revert "btrfs: submit IO synchronously for fast
>>> checksum implementations") 
>>
>> Ok, so you have a case where the offload for the checksumming generation
>> actually helps (by a lot).  Adding Chris to the Cc list as he was
>> involved with this.
>>
>>>>> -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>>> +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>>>                 return false;
>>>>
>>>> This disables synchronous checksum calculation entirely for data I/O.
>>>
>>> without this fix, data I/O checksum is always synchronous?
>>> this is a feature change of "btrfs: submit IO synchronously for fast checksum implementations"?
>>
>> It is never with the above patch.
>>
>>>
>>>> Also I'm curious if you see any differents for a non-RAID0 (i.e.
>>>> single profile) workload.
>>>
>>> '-m single -d single' is about 10% slow that '-m raid1 -d raid0' in this test
>>> case.
>>
>> How does it compare with and without the revert?  Can you add the numbers?
> 

Looking through the thread, you're comparing -m single -d single, but
btrfs is still doing the raid.

Sorry to keep asking for more runs, but these numbers are a surprise,
and I probably won't have time today to reproduce before vacation next
week (sadly, Christoph and I aren't going together).

Can you please do a run where lvm or MD raid are providing the raid0?

It doesn't look like you're using compression, but I wanted to double check.

How much ram do you have?

Your fio run has 4 jobs going, can I please see the full fio output for
a fast run and a slow run?

Thanks!

-chris

