Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF96C6B94
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjCWOxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 10:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCWOxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 10:53:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097C14227
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 07:53:32 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5U0jx017608;
        Thu, 23 Mar 2023 07:53:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kONO4HSpoG0fgEo+s5+s6oX3TL7/1IPg53g1dSzQCFA=;
 b=Oape/VTLcF0JG43PHG3eiSUNqWB68zmTHTKvbvQOKz9HHTEi9CdXUnfRSTETJvLuRdjm
 YxQNMn2ixXz4HzxeK7zZJazV1SuqssZ/O8E94ar15PUjJWXSrnQpvgSN8om/xFuG5PEm
 0oh3AFQyVXP4++h7pzvD8RBO00S60JCTuGp7YAT9HTfqMqj8PgsDIqa+5bvqhoz0gVg7
 JXCPFyy1U/lSzjaafvn02Sy/8QzmuLthr5fo8l1qD/BCmqGa2h5qM07HNbaEJ2ay+0hJ
 K7nFWLPHRSXhjDpHbz/upH6r6qsKdbTBDFV4u7lfdpfKgXAEg9kmrYLKhEv1bT7AgvQO tA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pggp02jbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 07:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7Lm9J1e5dfWH2kh6kCsjVey6Hd2z9ltppZuO8pqsi4Dmeq338tTrl+lyr+G+UB4DXP61OznEiaSjCRmoNqH5876iRttac26g7adp0gyNo5+1HK5q7wy5K+QotKmIT4d0rOSf1JlKugo6PyxTrL6VX7w1IGXcSwH1znfbJjSr+Uek1YTg6NFO55ZlmBN9gQcm/cDd5RDpXy7iJZx9F4NeaBpGOreAFAUFv4D31A4PGYo9t89NLoP+t0FBPz0XWEefclaavUWzJJe7lRPC+JOU0hymojLCN1uPvncpYSqU+sRN0nx62p9G4xG27SbnB8vqdB4MII7AFEnZMM7HF88cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kONO4HSpoG0fgEo+s5+s6oX3TL7/1IPg53g1dSzQCFA=;
 b=l+k+1mAMcFrI+bn7CB5cnieeAw3x2/M2YWSFqndMUdz3PidGg8zz1rpVK6cgKgcDZ/Ie55f+JsE6nd1B5fTN+Cbc8TQBKWjnCO9lPqKoj/R1vvocmBFQsitK03kLdc7X0yY4cGYmkYd++onbFunEPn6iln+SjSpwg0JWbsB9J8j/NNq54VT1IxYDOVV+fc9fngKuO6GuE2ArHmNKIHpaDK8YTvFLD7fm6zuEJjb9HpP6o+hlBFp1yVeevPe6jwipOaP6W8JoK3bT49+40DILL8WEKFs5nqaXMxN3FZgdFXmTXXaateCQ+ADLOxnjItkvF4LEEgE/dSzNwCpiRu64ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH7PR15MB5767.namprd15.prod.outlook.com (2603:10b6:510:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 14:53:20 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:53:18 +0000
Message-ID: <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com>
Date:   Thu, 23 Mar 2023 10:53:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-4-hch@lst.de>
 <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de>
 <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
 <20230321125550.GB10470@lst.de>
 <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
 <20230322083258.GA23315@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230322083258.GA23315@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|PH7PR15MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe3fabb-567e-4781-9fc9-08db2bae56ab
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Qiua5POESuXg6JtoYBPh4JJDHASoqc9Q7kXsyjdctFpeYRHcwcVWqyEL/SlKoJFSafrAPOuMI0bUX9rxP+pTbEkoYR1YDr42tCVPk7DVrwCOg7Vmk9aCyOeIU4PrMfwyeSiYJToUKzfvVU8cilp0imAPl1Qf8Jv6px4CcTdjTxVVTxAY/Wzz160kM0/jJdwbokMSfzCcyTAGAH3dE4WZUvIk8UJPzFs3gPhU0fUS2EfumfqGarHGtufgDMIPEkrO5FXKAtTxWPfrFXiDBN6f21R/GNR7bQOjYNANO424+HWxe3D3sPMKfHxa5hHLYGzRgszTdReoT8FD+rjQMctTJFFeO8DqaRg9fZVnQEskMMPruxIo4rDQgLqggp8xYtOFFOctad8h/bIwf5xthFi+DaODodKHxuZdyc0eyOzF2caitFJnT2LUujaon2hhaUoRduTUyYbVftI3EUmJSoho7vfWPTWg92Ym2WSW59B+PuQ6EkLl/spxBZt9CErr8TdH/qecmFlCloi6HFnp5GTrU2FjRCYk/Mv0Xr0iUT1S5XgRD9Fw14XUfFeP7dI68xUcLaCZl/mipUhigq8HHFSoIDcW7bXE4IlZ7o7Ob6IEo1LWIKpbKEpQTGnn8gnECKAXwSzZyMsyII37svVgPEFr5MIrruOBIgQj41oWwCopENgmQ9tp2n4BKrAWVpJWOUTCDuG9I2gGEdk5Q3XALBiMoW52l+D10UWz3i+JlXVCAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(31686004)(38100700002)(2906002)(83380400001)(478600001)(6486002)(2616005)(186003)(31696002)(86362001)(36756003)(110136005)(54906003)(66556008)(8676002)(66946007)(66476007)(4326008)(8936002)(53546011)(6512007)(6506007)(316002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnprcERQSUJmTWVMQ0g0cE1DWXd6SS9rWWFjdU92bFBhSmJOd21PTlNtajBo?=
 =?utf-8?B?NiswNVdxcUhWOTJQRlY3QnpXak1hU3lVTGY4bml5c0tjYnVkQkU4RzU5UnRB?=
 =?utf-8?B?RWdkQ1Q4TWlxYzZ2THhRaUVITU40ZXJ6dlZPTjF5TmN3TUNkcGlqTmFielpV?=
 =?utf-8?B?VEdQWG8wVEVqMlVTUFpNeDEyZXRrWEJJRnNKNWpBRVovSks2ak9zZXJMc2dJ?=
 =?utf-8?B?MTRZajdtYTlUNnRGTnVqODBEbExoYnVOeFQ0dURUK2FqU1c2MUZCN1lqTVpt?=
 =?utf-8?B?eUZrMituVXlqSjZHSUFuMHZqMWpvcFZFOUdtcGtWL2RUcEUySGJQTG1xVXlW?=
 =?utf-8?B?eDBwNENSTUJiVVR3VGEzS0VlTWJuZGN0cDVYWDFqWDhZVFhiYTV2UkdGOEEr?=
 =?utf-8?B?YkhuK3loSWUzM0lKa1VvRUNiWmcvT21NN3Vsb3J4c2pxVU51QkxzV2NiVzRQ?=
 =?utf-8?B?WFRINWVYQkhWalZlSjZwemxkWGJWVXZ0NklYdGFnTnZCOWdEaGE4MHVOdzFh?=
 =?utf-8?B?bGRrYUsyRUNEUkxwcDczcS9hbWc3NHFQaXdZMkI2eU9zQ1psYjdoQUdjYm5n?=
 =?utf-8?B?VUlXSDc5OWlkQURMd0pSZG81WlZzZlBJYm5hWEEyd1ZXU01tUnB6cFpLTTlm?=
 =?utf-8?B?T0U1QVBwRGIzRE5sUFRUR3I2SUl3UFJOTzA1TW1HdDRwcGhMNHRzMExnUkdK?=
 =?utf-8?B?YUp6WUdwdE1jQUpjaHZXT0MyREFmVGE4SkgrY3JLMzJRRzB3bzg1ZW1OTWYv?=
 =?utf-8?B?RUMxNTRST0tqR0JLeEo3Zlg0dGV5bmNpVFE2S2poY3o5ZytnazdnWWNIU0Ey?=
 =?utf-8?B?NTBMR1BlSjBzUUdpVThsRGFUbGRvd01KbE9SUVFhRkNrQjV6MnkyYTFQdjZS?=
 =?utf-8?B?cGpiZVZKK1BEdmZGM01GWm5ENGxjc0xaMkJhUE9vQm9wSS9YZTl4RVl0V1Zs?=
 =?utf-8?B?bW95MFNYZHo5RkNuZmJveC9LczlrRTJwcmkrNVFZZlVzeXYxU0UxNlR1RkxS?=
 =?utf-8?B?WGdGa1NTRHdJNGluMU5KNEZtY0pEZFVzN01CYzNKM2VYQ1BPOVdqRmR1NW5l?=
 =?utf-8?B?U29YWTJYSHpmQ3JSTWpRVFhwQWRlNmRqUDhMaTR4MnhUVGF0cTdoUmlRbXpS?=
 =?utf-8?B?ZEp2QjVUV1Zqa3ZRNzUrNmVOcTJrM3orcUFmblBNeUpOZmxxZnJZek1RVUNY?=
 =?utf-8?B?Z2pMR2JYek8yVDdLeW1QUG1sVXZ2VmhBV0czc0t1WWFGYVhOZVh2WnVVT1Ey?=
 =?utf-8?B?UXRVQUZnRFhGVTFaK3IyZndJN2wvejUxaWRHaE5wNUFSTUNjby84OXR0YUlY?=
 =?utf-8?B?UzdLVWVOdVhUV2txcXhSb2luVTJDSXRBcjl0NzQ5ZW51SldSVmFjNFZTR1Fi?=
 =?utf-8?B?a0tTdEFzaWpQUDRTN0dLWnF5Z2UrdXdjcW80R29HZEdidjFsditWQzVrdzVz?=
 =?utf-8?B?TVl4RWRITkUvRVVDVFdTcHZaQ1FhYnoxdGw1SHpXWnNSNGNUbnBXU1JWNDEz?=
 =?utf-8?B?bXZOc1FxZkwzeEIrYXFxM0xVSWwydDJsbHMraWwwZU1TZElLTFF3SGtwZ24w?=
 =?utf-8?B?d3hzdDVLajdIVmtEb1BhVVJLc3QrYmMzZDAwaW1VNEFpbGhQUFVLcUR3VDdu?=
 =?utf-8?B?RjlGSFlGM0w4NDk1WnJhK2F5RnlvcW9aUkVhdjhTdzl4R2ErTVlPOUFwL0Rj?=
 =?utf-8?B?SVJpQ2s1WVZOR1hzK3lSZktJK01oRG50SXpsYjFuNnozaTdwdFhHcjhDKy9G?=
 =?utf-8?B?RVpON1BWY1BDOTN2YzhDdllVMGpBTFd6Z2YveDliQzMreTlEVVYyL3c3cUsr?=
 =?utf-8?B?RU1kRndDb2pGVU0yRzZEbGdFVW5PMmZsRGI3cVFudVNiNDhXKzZnMW9nV2V0?=
 =?utf-8?B?ZkRGVjBBMjRYRTlVaG5hVG55VlpFM0xPM2hyWmdmTkIxSlRhSzJCWjlnNWpI?=
 =?utf-8?B?QkNmY2Z0VHkzTlhHaDU2ZE9QTklMMDI4SWY5aWpodGdLN2I2REQ2TjcwYUtz?=
 =?utf-8?B?cHlzMW9aZE9GTlY3b3hsQTNUb3ZyUW15WlpmbExJWHV2b2dZc1JRcEoxa2hu?=
 =?utf-8?B?bnk2SGpzczB3ajhwL0VJQjdGN2lLR1lCajhLb1RXNTk2U2hqOTFWNXZCWXBl?=
 =?utf-8?B?aVhGa2RpZjNGSnZ0OWNlZGpTcXhHMGRNSlp3L0NEMTZPNk02Mis2UCtJVDBC?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe3fabb-567e-4781-9fc9-08db2bae56ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:53:18.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3dVk1yQUbfKQ3GhH53knEnQiiPqFfuy13gL/+VAq5f5WL3m0ZaByY430S8NPykh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5767
X-Proofpoint-GUID: I5-DU7qMrTv5ymOSCwVDGtzCK8NG2rl2
X-Proofpoint-ORIG-GUID: I5-DU7qMrTv5ymOSCwVDGtzCK8NG2rl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/22/23 4:32 AM, Christoph Hellwig wrote:
> On Wed, Mar 22, 2023 at 07:37:07AM +0800, Qu Wenruo wrote:
>>> If you limit max_active to a certain value, you clearly tell the
>>> workqueue code not not use more workers that that.  That is what the
>>> argument is for.
>>
>> And if a work load can only be deadlock free using the default max_active, 
>> but not any value smaller, then I'd say the work load itself is buggy.
> 
> Anything that has an interaction between two instances of a work_struct
> can deadlock.  Only a single execution context is guaranteed (and even
> that only with WQ_MEM_RECLAIM), and we've seen plenty of deadlocks due
> to e.g. only using a global workqueue in file systems or block devices
> that can stack.
> 
> Fortunately these days lockdep is generally able to catch these
> dependencies as well.
> 
>> The usecase is still there.
>> To limit the amount of CPU time spent by btrfs workloads, from csum 
>> verification to compression.
> 
> So this is the first time I see an actual explanation, thanks for that
> first.  If this is the reason we should apply the max_active to all
> workqueus that do csum an compression work, but not to other random
> workqueues.
> 
> Dave, Josef, Chis: do you agree to this interpretation?

The original reason for limiting the number of workers was that work
like crc calculations was causing tons of context switches.  This isn't
a surprise, there were a ton of work items, and each one was processed
very quickly.

So the original btrfs thread pools had optimizations meant to limit
context switches by preferring to give work to a smaller number of workers.

For compression it's more clear cut.  I wanted the ability to saturate
all the CPUs with compression work, but also wanted a default that
didn't take over the whole machine.

-chris


