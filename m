Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A546069D765
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 01:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjBUAKE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 19:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjBUAKD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 19:10:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B74B75C;
        Mon, 20 Feb 2023 16:10:01 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmGP-1pFCBg0FGj-00K9lg; Tue, 21
 Feb 2023 01:09:57 +0100
Message-ID: <4aaea5c5-a452-18a5-0c6b-82884874a950@gmx.com>
Date:   Tue, 21 Feb 2023 08:09:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 4/4] btrfs: replace btrfs_io_context::raid_map[] with a
 fixed u64 value
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1675743217.git.wqu@suse.com>
 <f82eed6746d19cf3bea15631a120648eadf20852.1675743217.git.wqu@suse.com>
 <e3c9bab1-41e-7fe0-1833-1c81ced89a20@linux-m68k.org>
 <e567a113-1cbd-134b-6db0-82433eca6685@gmx.com>
 <CAMuHMdVwXB4YsCFEpLoTm8pxyjMty6tAT7joNj2EME4ynY8keQ@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAMuHMdVwXB4YsCFEpLoTm8pxyjMty6tAT7joNj2EME4ynY8keQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:P1j/1VpNL4FgOklIpjk9vx+BZnMN8yynx188Q5JRpyO67t8vgTf
 WXzZJ+SOZftQ09wZwtAmMY+kup6BkUbjNs8gL6bhqYRVcqB/eBoyzldqvHXndsZbqHi8pwm
 85eZ8EmAKC4HwOczeQwcSEFA0Z1y0RwFzgcr1B1Mpz7TMg8mMuSXot9VpsCbTX3UghSxIYc
 aOJE+8fcSQCkgPEnZRGEw==
UI-OutboundReport: notjunk:1;M01:P0:jvlBWIHOtYo=;mAhQpo3M2ziQ/DZ2o3drm96RK9X
 2hvI2hkUi9ZXyfZaDpv0eCnzsHNU2w75gEVbm3gVwcimB0x/etAHjIaJNqWvSnlNSmo+JPOa4
 JJs1QFI+UBhrMp9lqVt0gwCytbNPRh5ZUeAjuHzjmbZxdXKEzpErlueS7F/hybrdVyNfnOHTN
 B99ANt26zw4EbwKybMh9A3ypbPij1XI62Kv26FUMzresX+iy0kyemQUw3Svb4EcwL8kyu4CWt
 eVuBYHU4BYRFkgeRS2MNDb4pTn0L1hINf0TzelHp6+D5RMKUfITxyvW5bBJ8LGoo3CGgumR+v
 VSNekGh3iCFXBhEy+7xzLjywO0dju3LkgECpg48yE8lQgtqAd6zQPZDJVgXvkJXsnlTpq0G93
 uRU+FicPwzfPDEPKVptG9QWRgYfjzKgKSBQNPWB7/nnzjARTO8T4rrxFR9O7BE5ovhiJeG/Xs
 OQD2GGt1OLaAk9viRh5xJ2sPYpZTX0sYqtUqns2n/4gI7M2GnkN+HWYOCxBh+Ujjf+HDpYCQg
 mJHKs4lFsCrpiN0HrSQeLytdCcjQeS/imW13J5J3ATZIjrFJuIQj48ZhlBz1J0KoDTa7gPYEZ
 8VJ2zbCrZzUpM2dbKBxkkUiGOWLB++dKGaVSPy4aD6bexVeRvGckoJBZ0LYqtSzHjatmYW900
 WsSZ9o9WaT5zGY5f4AFh57Bd9Ok4WyNWZjHmrla1m8LU2c+9JupzKKORPcDx50sNuRI8lxB46
 zDEMPJdDtZLxO3WuC8Fd7JKGI+IvwTVyVIZE2NHJBrzQjO08zYpRjv0JIhm95QFTLN8kU92hG
 KwcIY/eV47vUlcwosIYEIesxPKfZyvMof1blPbZooCs8TYDbGZMowJUxAmGO8pU+F4XrcY+M4
 9t8qbsnWZWsBurD8qy+rQUGxF5YGlvQx2+zCBEmt6Y7XwmYwLNGHtUWmgopcQ9i8Wh0lyxNyk
 CbcnRSpYXAdWgsU2E0C5f6NMvhk=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/20 20:14, Geert Uytterhoeven wrote:
> Hi Qu,
> 
> On Mon, Feb 20, 2023 at 12:50 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> On 2023/2/20 16:53, Geert Uytterhoeven wrote:
>>> On Tue, 7 Feb 2023, Qu Wenruo wrote:
>>>> In btrfs_io_context structure, we have a pointer raid_map, which is to
>>>> indicate the logical bytenr for each stripe.
>>>>
>>>> But considering we always call sort_parity_stripes(), the result
>>>> raid_map[] is always sorted, thus raid_map[0] is always the logical
>>>> bytenr of the full stripe.
>>>>
>>>> So why we waste the space and time (for sorting) for raid_map[]?
>>>>
>>>> This patch will replace btrfs_io_context::raid_map with a single u64
>>>> number, full_stripe_start, by:
>>>>
>>>> - Replace btrfs_io_context::raid_map with full_stripe_start
>>>>
>>>> - Replace call sites using raid_map[0] to use full_stripe_start
>>>>
>>>> - Replace call sites using raid_map[i] to compare with nr_data_stripes.
>>>>
>>>> The benefits are:
>>>>
>>>> - Less memory wasted on raid_map
>>>>   It's sizeof(u64) * num_stripes vs size(u64).
>>>>   It's always a save for at least one u64, and the benefit grows larger
>>>>   with num_stripes.
>>>>
>>>> - No more weird alloc_btrfs_io_context() behavior
>>>>   As there is only one fixed size + one variable length array.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Thanks for your patch, which is now commit 4a8c6e8a6dc8ae4c ("btrfs:
>>> replace btrfs_io_context::raid_map with a fixed u64 value") in
>>> next-20230220.
>>>
>>> noreply@ellerman.id.au reported several build failures when
>>> building for 32-bit platforms:
>>>
>>>       ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
>>>
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -6556,35 +6532,44 @@ int __btrfs_map_block(struct btrfs_fs_info
>>>> *fs_info, enum btrfs_map_op op,
>>>>      }
>>>>      bioc->map_type = map->type;
>>>>
>>>> -    for (i = 0; i < num_stripes; i++) {
>>>> -        set_io_stripe(&bioc->stripes[i], map, stripe_index,
>>>> stripe_offset,
>>>> -                  stripe_nr);
>>>> -        stripe_index++;
>>>> -    }
>>>> -
>>>> -    /* Build raid_map */
>>>> +    /*
>>>> +     * For RAID56 full map, we need to make sure the stripes[] follows
>>>> +     * the rule that data stripes are all ordered, then followed with P
>>>> +     * and Q (if we have).
>>>> +     *
>>>> +     * It's still mostly the same as other profiles, just with extra
>>>> +     * rotataion.
>>>> +     */
>>>>      if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
>>>>          (need_full_stripe(op) || mirror_num > 1)) {
>>>> -        u64 tmp;
>>>> -        unsigned rot;
>>>> -
>>>> -        /* Work out the disk rotation on this stripe-set */
>>>> -        rot = stripe_nr % num_stripes;
>>>> -
>>>> -        /* Fill in the logical address of each stripe */
>>>> -        tmp = stripe_nr * data_stripes;
>>>> -        for (i = 0; i < data_stripes; i++)
>>>> -            bioc->raid_map[(i + rot) % num_stripes] =
>>>> -                em->start + ((tmp + i) << BTRFS_STRIPE_LEN_SHIFT);
>>>> -
>>>> -        bioc->raid_map[(i + rot) % map->num_stripes] = RAID5_P_STRIPE;
>>>> -        if (map->type & BTRFS_BLOCK_GROUP_RAID6)
>>>> -            bioc->raid_map[(i + rot + 1) % num_stripes] =
>>>> -                RAID6_Q_STRIPE;
>>>> -
>>>> -        sort_parity_stripes(bioc, num_stripes);
>>>> +        /*
>>>> +         * For RAID56 @stripe_nr is already the number of full stripes
>>>> +         * before us, which is also the rotation value (needs to modulo
>>>> +         * with num_stripes).
>>>> +         *
>>>> +         * In this case, we just add @stripe_nr with @i, then do the
>>>> +         * modulo, to reduce one modulo call.
>>>> +         */
>>>> +        bioc->full_stripe_logical = em->start +
>>>> +            ((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
>>>> +        for (i = 0; i < num_stripes; i++) {
>>>> +            set_io_stripe(&bioc->stripes[i], map,
>>>> +                      (i + stripe_nr) % num_stripes,
>>>
>>> As stripe_nr is u64, this is a 64-by-32 modulo operation, which
>>> should be implemented using a helper from include/linux/math64.h
>>> instead.
>>
>> This is an older version, in the latest version, the @stripe_nr variable
>> is also u32, and I tried compiling the latest branch with i686, it
>> doesn't cause any u64 division problems anymore.
>>
>> You can find the latest branch in either github or from the mailling list:
>>
>> https://github.com/adam900710/linux/tree/map_block_refactor
>>
>> https://lore.kernel.org/linux-btrfs/cover.1676611535.git.wqu@suse.com/
> 
> So the older version was "v2", and the latest version had no
> version indicator, nor changelog, thus assuming v1?
> No surprise people end up applying the wrong version...

The previous version is two separate patchsets, the new one is the 
merged one.

And I sent the merged version because the dependency problem and 
conflicts, and since it's the merged version, no changelog based on 
previous version.

Thanks,
Qu

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
