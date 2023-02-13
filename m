Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E518694429
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 12:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjBMLOE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 06:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjBMLN5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 06:13:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3D7EEF
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 03:13:32 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1p380m0n75-00XvQh; Mon, 13
 Feb 2023 12:12:51 +0100
Message-ID: <d107a6a1-4b9d-0e72-9779-1ce905b815aa@gmx.com>
Date:   Mon, 13 Feb 2023 19:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
 <54c0f200-2598-37e0-efe8-1cb6d65c9774@gmx.com>
 <30f068ad-d704-9316-992d-290630256712@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
In-Reply-To: <30f068ad-d704-9316-992d-290630256712@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ya+i/h+4iCjQT6yDb/OFZZKpwDqHKmdIZA+PGdhTcK5V22QeBDq
 qs7y73hVUESqVKDfebLZbbAHv8rdnbk7jysK9M0R4NxUw+x6jEMjU5rqGdciEOwg13P01lP
 0Ge1itdb83CQjBzxHI6JYe1Sxp0boOPaFmhRRezvSB0dwt8ASIycgC8uN1beWfaedVM7P3a
 9DJglfM1amIQP81oFnkTA==
UI-OutboundReport: notjunk:1;M01:P0:8sIK4zixrfM=;pUj6ziD9Ot0Ajzij5skogoqphiG
 GwIVc7gKeR6dTu9QV5hCSkGKhtTqeaYgNJhTkXMlZXctvcOYFZdqLzCZ/kk4aULzQOzR+EYqw
 iJVkoj1f8aTwrK6MZUd01Kzf8SeeRVLv0dzrR4QJCNM0ZIMbIJLmmDkDOHwjhN5nW8e1H5qcJ
 ODmc9H5/qktuK5JsreXvbLVTedMrzl2rQpo1WLT9K24WUOZN5CPUPvfJ7JmxWKf98MaTULi57
 8k3M32moBd3eJPidwWnMPNDPI11WDJjQoJuxYR4jUthShflRJlJYp2c4FSSPmr5wWnlbNTFQH
 RDDFQgrmz009WoY1wsNayVWlf999pefPRfm4ue83A3TMPHNtmT7wM2jooN46QIZfvrlkPAtpE
 7xjbmxQ8kgCxrMGayqvN/pbT45G4awiigTiwxBEWybUgeZ9IuaZcg50n/a1z2siTKGQlGygbA
 Voj9G1e8XWvZvLzYkDzeTa2uZl7pIct3K8oHTJ6ZQecdce8Sk02qQp9xoD/r2bxNDUkwmtIcM
 tCjS+jIb6fQ/o3oh4/eBzsqxHKioYF/cWBO751ZHQ86+aydOBYe88D8/x/7yUayhhW4IrVgMI
 wODCYlAlMqTGVWBtCsPr5SAz/UesGdheOzdVCzJCpYkpuFRkI2Fdu2qV+ZaryLbjfLTGIGsEK
 Ade7QKIbnazefLsoFYA7nUjtrojJhtN/aDbxltzZGjxZv7Bs5KA2V3OkaFRRkcHfArbfrbRXn
 qcolY710ThQcT6400T9OXaApkikJVvqLPwDHA8/jvo22uwxTYpR9+PW1eWp4994VyMlaoXHiZ
 imlKWFhLaFPCFpr1nWb9u5UyAyeXz9QefLgaKrq/HhFZqILTJIrKeCyXe21xSdiSuGL17PcFJ
 8PZ8o9VgCmAzbvB6VBJVq6a2dUyS8y7bmeAWNoH6UIfHbkt2fyhP1iEDZfysmqDVJCBUqAolP
 qa4u5oU/peBsfqozhx1aImbrxHg=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/13 18:49, Johannes Thumshirn wrote:
> On 13.02.23 08:40, Qu Wenruo wrote:
>> So the in-memory stripe tree entry insersion is delated.
>>
>> Could the following race happen?
>>
>>                T1                  |              T2
>> ---------------------------------+----------------------------------
>> write_pages()                    |
>> btrfs_orig_write_end_io()        |
>> |- INIT_WORK();                  |
>> `- queue_work();                 |
>>                                    | btrfs_invalidate_folio()
>>                                    | `- the pages are no longer cached
>>                                    |
>>                                    | btrfs_do_readpage()
>>                                    | |- do whatever the rst lookup
>> workqueue                        |
>> `- btrfs_raid_stripe_update()    |
>>      `- btrfs_add_ordered_stripe() |
>>
>> In above case, T2 read will fail as it can not grab the RST mapping.
>>
>> I really believe the in-memory rst update should not be delayed into a
>> workqueue, but done inside the write endio function.
> 
> I haven't yet thought about that race, but doing memory allocations from
> inside an endio function doesn't sound appealing to me.

Another solution is always try to pre-allocate a memory for the 
in-memory structure.

> 
> An obvious solution to this would of cause be to bump the refcount on the
> btrfs_io_context (which I have forgotten here thanks for catching it).

I'm not sure if the bioc refcount is involved.

As long as the writeback flag is gone, the race can happen at any time.

For non-RST we prevent this by the following check:

- btrfs_lock_and_flush_ordered_range() at read time
   Ensure we wait any ordered extent to finish before read.

But the delayed rst tree update is not ensured to happen before 
btrfs_finish_ordered_io(), thus the race can happen.

So my idea is to put the RST tree update to btrfs_finish_ordered_io().
Although this also means we need some argument passing for ordered extents.

Thanks,
Qu
