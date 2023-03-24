Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147A96C7689
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 05:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCXEYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 00:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXEYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 00:24:54 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B756B45A;
        Thu, 23 Mar 2023 21:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtGkC+ZVnbcXU6b0KNPB1pkDZ1vG5z0gVWLELRbctRJyMQmUEyEA/3PzC0QgXAjKBjU5Ocouq89FtahmMXK2w97XXBL2midOl+uTSGv0mCoTafvSKfaBSjC8sIWsogwASYblHFqvGQw94v7mUB5ouQSr4N3zcBMoVdN+vrNuYE21eUNfuIupCj+vBJ9Y3imbXE/hajc960KjGZdHSOLtWUtMMroWwvjP2ZeU/Bq65bqkYnIiMJ9WiBmkSMISSCvm9b/fq9Pq3SYnUTP/AB6oq/bEplab3dq2cWQZYXdrszQIGmv3rX8izH0fNfe9OEdAeuLxGjxNjxlDUU7e5YFySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LgRoYsg6cZeFADRoxTFfp4qQPsqPc+dcuWOUOfjCyo=;
 b=krfzJX4seJW5YLEZiuFhqXtjHf5VZ2v+/1bguC3nKd4Zwok077v6nZI0QHB6USgsGFZncGVCWZPXWIyiauhuWQ+Hx6168wKZHw218Zy7odGQeqZxobaLX98ILpeHlsrnY+obNyFFaZYHFD20dsLPy5cgiJqHuXbxHFUEwT/x+6yAxlchxbCGd+pWwdc4SeHrkw759COwX+9kDMRED65YC40a0WVIueafzHAVmfh5ZOyHTPg08Ds7RvxFg+RTm9tksjieGIQR10o7QF7DYPvrRDPAE2duRNujUSkVtOPcRK55C+48Aqed207XDhvnErF/9fI+OhMmxBjgR6Q5OioVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LgRoYsg6cZeFADRoxTFfp4qQPsqPc+dcuWOUOfjCyo=;
 b=iFbdtw9LVFydWjeGgTJPYw0nJOruN1wYLSUuslee6+4xqmlSbQ8Oi7mWRbCfbTX3vvPEiabzNlNX4PY/HZ/KqwfI+DHeCpfCVhvrUYMb4D4xRcaCgZLcDm707ny9LMf4z8Vh/3e8VWpf0d4rS6r3YHGbXuPkpRVjT90JFdriLZ4neIsC/osvpllduapz4jgSsvAYX1NGLyxBs9yV4MO4wMkZJ8/Yq2aeRjz8GCdlF3TD8HMG8Z+ZVrCVPLRXw3qlwmkxZ/2CUTvyE1M+Bap8m+YpzKIizES/0Rs4MYqrYgt6E7BY3L+arDDIsUGwca7luz2eYZ6BKJEyucRfFGyzAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB9512.eurprd04.prod.outlook.com (2603:10a6:20b:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 04:24:50 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%7]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 04:24:50 +0000
Message-ID: <fd8bf37e-3481-3607-834b-28805f0b7dc6@suse.com>
Date:   Fri, 24 Mar 2023 12:24:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: fix uninitialized variable warning
Content-Language: en-US
To:     genjian zhang <zhanggenjian123@gmail.com>, dsterba@suse.cz
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
 <78422b96-52ed-b48a-27d0-1cfaa89a6608@gmx.com>
 <20230324022904.GD10580@twin.jikos.cz>
 <CAOd03yQUD1ehcfApW++7buVDOiWzggnvjTzsgiWGqf+pdrL9sA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAOd03yQUD1ehcfApW++7buVDOiWzggnvjTzsgiWGqf+pdrL9sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 5293c138-c601-49a8-6ffb-08db2c1fb525
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KRplsXGpJEgQanYfGXWkfIryqEM4pOUGg/JlSOWOSoYZ+cmPaYDg4LE9U87aUb396YpmAidmPetiH8Cj6ljWh0j6fL2Ek1jWLfFUwYgDqoXDWKMpM/AOlTuDGL7IpR9L5jaZjIk7+c/BAEnDcHvB4OBYuWwKmSmilzjzBvjbEDqdl+U0BdyFw8FinjtGeAAWcpugT5lHt1ybvObcmhJHY1U23vlfaKYiHA5yNvsGOHXd1eI+zDt2Viax++3o+WDl8OrNV09nhmzqFPzihClpRfBDay58GhYYnw6tMA/zvIamZwkizMp+f40vDHAfMyVrvF66qEPIWhWMQSaZRY1GKpDg66SbvL92gr9sFDSUhea9zQBPek6wjMJpbevwioxQBWNownYZM1G6qGvq13iknU0wtX4U+jJ7FoznzBpMsOEBdtZmYVMCy4S+h5Q3QW1xPoB/I4O+uNJjWq3YVSaePPag/XKeLcF+LvdGoJtwSSwsyRBbGgGiqOOqIVRSqK42qF0l/I8hjctFcg293rt51g+vFQ/XJNMUheZAMVZjIBb+pIS9Bwa7kU0LRL7ZAmsvvJCCwD3R9F7s7QPZEsW/ddjLKHdXEhnWJrObXaiudxELf+u7Sif6ie982JhauYY9d5Sw22JOqUANonMMLiQ4lHIIoQyoK2+yrezo9d25+TAhkfdywkyinxy++pc6xbYw55IOlzX6H3wMhSV1ilo2p9WW9iBlGhZiAbQGavfgfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(31686004)(66899018)(66476007)(41300700001)(66556008)(8676002)(5660300002)(2906002)(4326008)(86362001)(31696002)(36756003)(38100700002)(6666004)(6486002)(478600001)(316002)(66946007)(6512007)(8936002)(2616005)(83380400001)(54906003)(6506007)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmo5SEdwdUl4TGVvbVRZRjZSSUVBcGtoU3pESmFOSnV2NE9KcUF5bDNCVHZQ?=
 =?utf-8?B?Ui9BNTNxM2VEbi8vendRVnA1ZjlmU2hNdnlLV2wyRGIvWGRRYzgxWkxWdXlX?=
 =?utf-8?B?QmNVVG1aNkpSVFdhN281YVluTjlEOXdZM295RzQ1WEhqS1pwSEtiaWhkMEh4?=
 =?utf-8?B?bGdsRDV6aWdZYnYzMkFFOW9LNGxJdFdJbW5OZUd5d3d2S0JJbFJnV25WNzY0?=
 =?utf-8?B?Y01qOFJHUDI5cVJiL25WaWpHLzREZStsK0FCais0MTNYeHVHS1ZZclVsR3lo?=
 =?utf-8?B?ZjdUS3h0eTNoaUpVbS93eGhJVzhubWwyc1dzb09wVC80eHUvK2NGTmdqdXVT?=
 =?utf-8?B?ei93bTltTFlkZlJIT05JdVlBa3NzSUVOM3RNWTVNdWZLcW1ERlhkNHNhUWt0?=
 =?utf-8?B?OWhKVUF2b1hqa1VGTE1VUjNxT3ZPL2ZhUUZRYnFOL291NjF6N3VvNVgybXN6?=
 =?utf-8?B?a21ITmxnbUx1eDJmc2FTNUdsMnpCSmNBMEpuN1B6TWcwampRcEtQS0pVQysr?=
 =?utf-8?B?MVo4K200UExOT081dE5nMFcvOE13TlVGUkNqV3NJcE9CY3I1bTBkKzhhWDhX?=
 =?utf-8?B?Q3JydHdKTXZlbk8vVm5aNXVVdzNBUGk4UnZzYWk3eXRDWndLa0tBWTAwN2l5?=
 =?utf-8?B?cmhaZGJRNHAvVGRTbWZmLy96R2lrcEhLQWRrdXNyS1U2R1JUa2xRTTBjVW80?=
 =?utf-8?B?K3dKb2taWFBYMUhVWk5VWVRYVVY2QzN6b1J2bjJ3OTNINlFZMHBHREVvLzdS?=
 =?utf-8?B?ZnJYd1hkMUZlZWh2T2hKUGZGN25zZW12Zm0yWVJTUXVEc29Ua25tb0NiUk1L?=
 =?utf-8?B?dE4zWG4rckkrdzAvcmJySHZCYlQ0bmp0RUVLTEl5TE43cUtVbjBZd1BMcjdG?=
 =?utf-8?B?cWc2ckJJbTRid0dvMUluZElQTTkvTkRBaFZwamNxT2Znb0lkdmFsOE9tOVdR?=
 =?utf-8?B?SXRzSXFXN0FLK3h2YnhhT1kzb3dLdklFK3Zpam1uSWpCMFdaUTVSNE10NjFj?=
 =?utf-8?B?bjVPV2IwM3VZZmhRTy9KaUhOWVRpaXliTmt0NlBIaTJXUERWZktOYnNNQjJR?=
 =?utf-8?B?WnR2MTdseEtjbTVkODgvL2Njd01ETFFDK0ZidkJ1YnRvYUFrRXRpRk9vTysx?=
 =?utf-8?B?dFZWWVFaMDU5UHJ4UTUvMUF6WW8yUmhyWTlieFVpdG9vbUJsVFBUTlRvanhm?=
 =?utf-8?B?S0lSRHpXUW16LzY1TGUvY0x2M1JXVW5ndjdoMFZrRFVkT1FwSFFMYjdoeFhO?=
 =?utf-8?B?UVZFOUswemZOODJEZUxwYlQvSkZUNWM3THpFcjJwUVNKVnN5Sk90NFoxbE9L?=
 =?utf-8?B?cHBDU2hkSmNaRnY2c25TOHQybjhtSkZuSUN6aTMxa3cxYzUvcm1LTHR0U1Y3?=
 =?utf-8?B?YVpmTzVYUldEQlNNTHJ2d1BCWjgzMHJWM2M2cU5uV01zY0g0ZTQ3WGxjVjl0?=
 =?utf-8?B?c0FxQ294YzFrM0w4ZElhOEpsczBlMTNDTU85ZlBnSEE2aWtjZWc2bTMvc3lK?=
 =?utf-8?B?YXJ1N0F5QWRhK1BCckR5OUxiQ2JxQ3pIWmlvMjFqNlo4K2VFWEtPNWczWk5X?=
 =?utf-8?B?bHhTdnhKQzVEQTE1WVgzV2IwSDN6M1FWSjBxVnhNcHVhdDhTUkpmVDFxTnNs?=
 =?utf-8?B?L1pPSVJuNTRjbFJxSEFSeGFnd0N4ajBtKy9yUWR1ajNvOWtyck9VZHBnT0l3?=
 =?utf-8?B?VXRWaVpxY28wS1BOcmFjNUcxeFh6YmZ0MkVoUCs0VGRsYVNvN1dGcXN2N1du?=
 =?utf-8?B?M0tZWm56QmlpWU1EN1FERWlTakx4SEo5OE9neS9TaHFsL3BDU1kwZk1NYmt1?=
 =?utf-8?B?dzFlSk9oN2pBcUFFR1RiWEVweGtJSHJ5amlGdXRvQ25iSW9mNnhKMjJsK1ZX?=
 =?utf-8?B?OGJPUWtrL3VST1A0cHlORDd0WXlRN1REdWttK1RyV2ZuRFlTaEVFaEIzOEVs?=
 =?utf-8?B?bU51ZXI2b1E1OGZ1ZkZUWnM1LzhoRUtvNUNUMnRZWEIremp3NDBXbDAzRlQ5?=
 =?utf-8?B?SmxvOXZRYzJ6MzBhNWt1WVF5L3RrN0puY0xwNmlqR01wbDdsWEtLczd6cGho?=
 =?utf-8?B?bDlwRmVrTjBMTlo1SmlFbHZkSlBIZUhkVWNxdmI5cUcyTzNtTUhteWtpMXh0?=
 =?utf-8?B?TXkxbGRMa0ZOMXc2ZnJESkdvaEhqUG56dk5keCs5NVVBMWRET3REUU1rdlRX?=
 =?utf-8?Q?oByMR3ztTEoKsGWn9JR13mc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5293c138-c601-49a8-6ffb-08db2c1fb525
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 04:24:49.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hsPfAQ9dj2+tZ8xkma0gLdwgN6cfUO/uuyF25+DbJNBSb7z3XszuOU5SnePL/QZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9512
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/24 11:05, genjian zhang wrote:
> On Fri, Mar 24, 2023 at 10:35 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Fri, Mar 24, 2023 at 10:24:55AM +0800, Qu Wenruo wrote:
>>> On 2023/3/24 10:08, Genjian wrote:
>>>> From: Genjian Zhang <zhanggenjian@kylinos.cn>
>>>>
>>>> compiler warning:
>>>
>>> Compiler version please.
>>>
>>>>
>>>> ../fs/btrfs/volumes.c: In function ‘btrfs_init_new_device’:
>>>> ../fs/btrfs/volumes.c:2703:3: error: ‘seed_devices’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>>    2703 |   btrfs_setup_sprout(fs_info, seed_devices);
>>>>         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> ../fs/btrfs/send.c: In function ‘get_cur_inode_state’:
>>>> ../include/linux/compiler.h:70:32: error: ‘right_gen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>>      70 |   (__if_trace.miss_hit[1]++,1) :  \
>>>>         |                                ^
>>>> ../fs/btrfs/send.c:1878:6: note: ‘right_gen’ was declared here
>>>>    1878 |  u64 right_gen;
>>>>         |      ^~~~~~~~~
>>>>
>>>> Initialize the uninitialized variables.
>>>>
>>>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>>>> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
>>>> ---
>>>>    fs/btrfs/send.c    | 2 +-
>>>>    fs/btrfs/volumes.c | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>>> index e5c963bb873d..af2e153543a5 100644
>>>> --- a/fs/btrfs/send.c
>>>> +++ b/fs/btrfs/send.c
>>>> @@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
>>>>      int left_ret;
>>>>      int right_ret;
>>>>      u64 left_gen;
>>>> -   u64 right_gen;
>>>> +   u64 right_gen = 0;
>>>
>>> IIRC this is not my first time explaining why this is a false alert.
>>>
>>> Thus please report your compiler version first.
>>
>> This is probably because of the -Wmaybe-uninitialized we enabled, on
>> some combination of architecture and compiler. While I'm also interested
>> in the compiler and version we need to fix the warnings before 6.3 final.
>> We'd be gettting the warnings and reports/patches, which is wasting
>> peoples' time, it's not a big deal to initialize the variables. But
>> still I also want to know which version reports that.
> 
> aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 and
> aarch64-linux-gnu-gcc (7.3.0-20190804.h30.ky10.aarch64 )

Latest GCC 10.x is already 10.3, and 7.x is already 7.5.

Either report to your distro and let them update the toolchain, or find 
a way to make your bot shut up on the false alert.

> 
> Thanks,
> 
> Genjian.
