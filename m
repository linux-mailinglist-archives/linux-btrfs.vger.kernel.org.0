Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFB65BC8C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjACI5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 03:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbjACI5O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 03:57:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503A2C6
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 00:57:11 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wLZ-1p9c9o3wx1-007Vzx; Tue, 03
 Jan 2023 09:57:00 +0100
Message-ID: <076b7842-bdc9-4b8c-16d4-128ff0304e49@gmx.com>
Date:   Tue, 3 Jan 2023 16:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with
 dev-replace
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
 <20230102112600.8869.409509F4@e16-tech.com>
 <8fcf8963-7077-21dd-2b87-976014533c7c@gmx.com>
 <20230102145424.GD11562@twin.jikos.cz>
 <b0b2222e-137b-48b3-030b-2b2468e09eb5@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b0b2222e-137b-48b3-030b-2b2468e09eb5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3wnVi70gWPObj/pSiBVkd88Sn0zaZQPg1vim8IyrUJFT19Jg/S8
 cFIfaLXT2xwgc+P8cyP2w7G6AtnzUPoWFzbLK+J2SfDTXstTRu5CIVWn/IEa/OdLkUF4602
 H/hKJHgfJWF9U071Yvbhnn+nH7B7lYKIv2IrZI6Ll6kuFEVZNUp/tETcqF99LUkk4ldhmrt
 1X5mLzmZxE8CWmTnVvHXw==
UI-OutboundReport: notjunk:1;M01:P0:fkcdka3HFT0=;J26S2uZfbsEVin/UDWADOWNyy6K
 DdFOADD9w2DI8K1FUxMYW0qG5sMn4mJXawp4uDc8SePjm6wOc5VG53UBtUQtUMYL3GQPBVbyg
 uU+BOy6/2qiGB7DTa8QVCClv8LuD9AYnJuJS8MBnLQqw/tA3nmQgrVvlDw6Mh+cGufRvc4gwv
 /k5WfYEczttBGs8b3SDyf67P/vNhE9IQBk+jvoH5byYrkBX9Lw+z5C1SirSywZoC7mo7XXEXw
 qC066SdY+0C1ZtgR9oKflh41EknguHLKay4SANVqBSqGl+7KJ1+SMQ2iFy3JiCnndZg7Ognip
 ifRow+/Xqe9F8gBMchIPPn8tqg7EZ2ureiQUVN3O67mV5zPIuj3brsi3+sTfvCcRx5EmbuhmD
 jxPSfrg7n16D8kVKiDdarJiyyv+z1f9RMYqb366M8fak9DsndBX4fsyCJx+eHG736lfpgO1jx
 dnyq5sGlMCOdVk19b3kDcn1IH96C4ypVV78UWdepAuMgE2YT54oVg0c3bYO40Sxe9zCqpPT2l
 pawomLBA1VpLtLJoM1FsB+/Y7HdHJa7Fs3mSQs04HaoyoX49XyK3FhiqH+M5Xj6ZY47em1OrE
 odyytMJJSx8zLU2pOA+bu/hJdlb7GKBCesZ8vgRLPgD7nz8RhFgiaJLCNCKfvPmnjNTBxB9+n
 SjMY3eg3G7oUiX3qEOT092L4IuLm/Cw60DcuvHD3c5wZ4wtD8azi/lPxVLhVUW164ibUJ5aL4
 nulRW4m1fVSjzNuJr3Eg7H0EAhVd/ArnKPg5725R7bi1WpAFfpkPrXP18LRynyYzKs1OP5PAd
 7mmgmefaJ0GtL94doH9NjcLUMflCKp1TIiiZ/QFZTwvPZC9bvVdssIF7+uoLu3k6C2eFchgBp
 Byf8LlMi7yh2GeeoKRUXRZwRq/kTTHFNNiKR3bQFnUi+3G0+pD9GQt3BYPrQJoq1V7u8qtjnN
 RBGMa/RNYMiFXM4Y8GQF1kM35I0=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/3 16:24, Anand Jain wrote:
> On 1/2/23 22:54, David Sterba wrote:
>> On Mon, Jan 02, 2023 at 12:08:01PM +0800, Qu Wenruo wrote:
>>> On 2023/1/2 11:26, Wang Yugui wrote:
>>>>> [BUG]
>>>>> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
>>>>> (originally repair_io_failure() in v6.0 kernel) got triggered when
>>>>> replacing a unreliable disk:
>>>>
>>>> It seems a good test case that we could add to fstests.
>>>>
>>>> Is there any reproducer already?
>>>> corrence of scrub and dev-replace ? still fail to reproduce it here.
>>>
>>> It's not that simple, and you need to understand the workflow before
>>> crafting a script.
>>>
>>> It needs several things to happen at the same time:
>>>
>>> - The corruption happens at the last mirror.
>>>     This can be done manually, but I doubt if it's reliable for a test
>>>     case.
>>>
>>>     As the new data chunks can easily switch their devices:
>>>
>>>         item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751
>>> itemsize 112
>>>         length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
>>>         io_align 65536 io_width 65536 sector_size 4096
>>>         num_stripes 2 sub_stripes 1
>>>             stripe 0 devid 1 offset 298844160
>>>             dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7
>>>             stripe 1 devid 2 offset 277872640
>>>             dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
>>>     item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 1372585984) itemoff 15639
>>> itemsize 112
>>>         length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
>>>         io_align 65536 io_width 65536 sector_size 4096
>>>         num_stripes 2 sub_stripes 1
>>>             stripe 0 devid 2 offset 1351614464
>>>             dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
>>>             stripe 1 devid 1 offset 1372585984
>>>             dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7
>>>
>>>
>>> - The corrupted device still needs to be recognized
>>>
>>> - Dev-replace must be running, and has not yet reach the corrupted
>>>     mirror
>>>
>>> - A read on that corrupted mirror happened
>>>
>>> The last two conditions are already very hard to trigger.
>>>
>>>>
>>>> local reproducer:
>>>> dev1=/dev/sdb2
>>>> dev2=/dev/sdb3
>>>> dev3=/dev/sdb4
>>>>
>>>> mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
>>>> mount $dev1 /mnt/scratch/
>>>> dd if=/dev/urandom bs=1M count=2K of=/mnt/scratch/r.txt
>>>
>>> This would create extra data stripes, but it won't ensure that devid 1
>>> is going to mirror 2.
>>>
>>> It may or may not depending on the chunk layout, and I'd say it's a
>>> little random.
>>
>> Right it's hard to reproduce and not possible to be done reliably but
>> could we do a series of the case with different timeouts or sleeps
>> in between? This could catch some cases, we have various testing setups
>> so I think it would pop up eventually. Once a problem like this is hit
>> it's not hard to find the reason and fix.
> 
> 
> I faced a similar problem. I used the read policy type 'devid' that can 
> read from the specified device. I also sent a patch to allocate the 
> chunks in orders other than free space, such as 'devid'. These two 
> patches should be in the ML and may help with this issue.

I'm aware read mirror can remove the randomness of choosing the mirror, 
but this case relies too many things to happen at specified timing, thus 
unfortunately it may not help that much.

Thanks,
Qu
> 
> Thanks, Anand
> 
> 
> 
