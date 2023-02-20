Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6012169CA3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjBTLux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 06:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjBTLut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 06:50:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D310C1;
        Mon, 20 Feb 2023 03:50:46 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sit-1oScqU1oPn-018OAc; Mon, 20
 Feb 2023 12:50:42 +0100
Message-ID: <e567a113-1cbd-134b-6db0-82433eca6685@gmx.com>
Date:   Mon, 20 Feb 2023 19:50:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 4/4] btrfs: replace btrfs_io_context::raid_map[] with a
 fixed u64 value
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>, Qu Wenruo <wqu@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1675743217.git.wqu@suse.com>
 <f82eed6746d19cf3bea15631a120648eadf20852.1675743217.git.wqu@suse.com>
 <e3c9bab1-41e-7fe0-1833-1c81ced89a20@linux-m68k.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e3c9bab1-41e-7fe0-1833-1c81ced89a20@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:da6j9werNj1PE2MDfC56h81+UpSCgBAr+F4+dy73t5Aet/87evS
 B9XtDgDzh6Xm4BoKAKM4J9T5Dcyta3lsXQjRSps3jDdPBGRCTAfAnfsxg56Pb9cFwjuDjGi
 ZVXWFHbm5P0++iFtHvP4nNmQGEpGTBXprP9xCFVjFaNKugxsLxame63r7yBujfE/PRX1xX6
 263vgQTXpLmcQJhEFmo/g==
UI-OutboundReport: notjunk:1;M01:P0:6x3W8FLRbf0=;tD7lvMQAid844y112+btel1wD4O
 kBHILI+p8cfGXKiDFd4UlsHjgjlNDLLYYmXBXktY/P5nmx88h8VuIB3zDeU6TDk0QhKY+akst
 1PWQllWEhBje93K3TcdnbXttHfuiVC7mrfk5mYuN8nLAuG/cNmvv/gcNoNpnqW0dE+/ch9HFi
 4XlTAYKf7cqffbKIK+ybO5WKLm8aomcKI+VCHhLXsdM8A46nFspxJYJHOCVjqrS9uaa0v7AXM
 9qF7taFO8E6b8BB6HLtl2NERUmY5KUa0C0kjY/TNgx7AcsLcnSNFhHootOcf5qdKgDCd8HG47
 PYv45OjIiNWCCTVwwkBgqlUnPuVgEndB5k7kL4LbBq5GYEEZUrvJZFKui32x/RHFXIZza85k9
 IChvnqqtEiTblkROrwBSvPq4whLnPX+sWB2WqU4Gj0iTF//k04xWMiAETEhe2gGfecq4a6doo
 zO594mwvNZ64/ZkU8Aysh4VqPWpUkZh4qr4TrvBrIuJgy3grXtSCvkdkSgpUPkVrCsyrAUUkV
 e22XYINB/ta3dUABkpA1FYKZqxsQGrvm0BI257DSaVydlcmNgnt1kwMrjamPy8tpUZHnLVKzr
 Mmof9SFb++uPyyqcAKSOAO0+i+JYP2COqQFsKl3aeLBX9eMycgmEsaD6fLrymIg5eL2sYttjd
 xyZ+Bnohu12xwchC932dpkw12nmpKYZESJWcfMiab+hDoRX92IH9CGqn1j7dkRIFqs5FtVBbq
 hG79EDq6tnN0RjarQxJp9FheVgV8gEB6MUGJiuH2aPFmkD0uDXVz3skYX6q/ykwgkNjdiPWG+
 2MMqfE2PDxM/eBkiW4PCJ+95vRNITloAvucOIT36tyzQ1ypsYYUwiFJCUwUUCgUeI32+nTHLm
 +urh8DfDRTezRZy/oMKTq5t2bOVkJfGryPxSTlyFAXYfkwYqbYc+vASRCSO7THFSHMvSm+NCh
 hFzKtqRl8lLUgLmyjUZ53cvJr1Q=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/20 16:53, Geert Uytterhoeven wrote:
>      Hi Qu,
> 
> On Tue, 7 Feb 2023, Qu Wenruo wrote:
>> In btrfs_io_context structure, we have a pointer raid_map, which is to
>> indicate the logical bytenr for each stripe.
>>
>> But considering we always call sort_parity_stripes(), the result
>> raid_map[] is always sorted, thus raid_map[0] is always the logical
>> bytenr of the full stripe.
>>
>> So why we waste the space and time (for sorting) for raid_map[]?
>>
>> This patch will replace btrfs_io_context::raid_map with a single u64
>> number, full_stripe_start, by:
>>
>> - Replace btrfs_io_context::raid_map with full_stripe_start
>>
>> - Replace call sites using raid_map[0] to use full_stripe_start
>>
>> - Replace call sites using raid_map[i] to compare with nr_data_stripes.
>>
>> The benefits are:
>>
>> - Less memory wasted on raid_map
>>  It's sizeof(u64) * num_stripes vs size(u64).
>>  It's always a save for at least one u64, and the benefit grows larger
>>  with num_stripes.
>>
>> - No more weird alloc_btrfs_io_context() behavior
>>  As there is only one fixed size + one variable length array.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks for your patch, which is now commit 4a8c6e8a6dc8ae4c ("btrfs:
> replace btrfs_io_context::raid_map with a fixed u64 value") in
> next-20230220.
> 
> noreply@ellerman.id.au reported several build failures when
> building for 32-bit platforms:
> 
>      ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
> 
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6556,35 +6532,44 @@ int __btrfs_map_block(struct btrfs_fs_info 
>> *fs_info, enum btrfs_map_op op,
>>     }
>>     bioc->map_type = map->type;
>>
>> -    for (i = 0; i < num_stripes; i++) {
>> -        set_io_stripe(&bioc->stripes[i], map, stripe_index, 
>> stripe_offset,
>> -                  stripe_nr);
>> -        stripe_index++;
>> -    }
>> -
>> -    /* Build raid_map */
>> +    /*
>> +     * For RAID56 full map, we need to make sure the stripes[] follows
>> +     * the rule that data stripes are all ordered, then followed with P
>> +     * and Q (if we have).
>> +     *
>> +     * It's still mostly the same as other profiles, just with extra
>> +     * rotataion.
>> +     */
>>     if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
>>         (need_full_stripe(op) || mirror_num > 1)) {
>> -        u64 tmp;
>> -        unsigned rot;
>> -
>> -        /* Work out the disk rotation on this stripe-set */
>> -        rot = stripe_nr % num_stripes;
>> -
>> -        /* Fill in the logical address of each stripe */
>> -        tmp = stripe_nr * data_stripes;
>> -        for (i = 0; i < data_stripes; i++)
>> -            bioc->raid_map[(i + rot) % num_stripes] =
>> -                em->start + ((tmp + i) << BTRFS_STRIPE_LEN_SHIFT);
>> -
>> -        bioc->raid_map[(i + rot) % map->num_stripes] = RAID5_P_STRIPE;
>> -        if (map->type & BTRFS_BLOCK_GROUP_RAID6)
>> -            bioc->raid_map[(i + rot + 1) % num_stripes] =
>> -                RAID6_Q_STRIPE;
>> -
>> -        sort_parity_stripes(bioc, num_stripes);
>> +        /*
>> +         * For RAID56 @stripe_nr is already the number of full stripes
>> +         * before us, which is also the rotation value (needs to modulo
>> +         * with num_stripes).
>> +         *
>> +         * In this case, we just add @stripe_nr with @i, then do the
>> +         * modulo, to reduce one modulo call.
>> +         */
>> +        bioc->full_stripe_logical = em->start +
>> +            ((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
>> +        for (i = 0; i < num_stripes; i++) {
>> +            set_io_stripe(&bioc->stripes[i], map,
>> +                      (i + stripe_nr) % num_stripes,
> 
> As stripe_nr is u64, this is a 64-by-32 modulo operation, which
> should be implemented using a helper from include/linux/math64.h
> instead.

This is an older version, in the latest version, the @stripe_nr variable 
is also u32, and I tried compiling the latest branch with i686, it 
doesn't cause any u64 division problems anymore.

You can find the latest branch in either github or from the mailling list:

https://github.com/adam900710/linux/tree/map_block_refactor

https://lore.kernel.org/linux-btrfs/cover.1676611535.git.wqu@suse.com/

Thanks,
Qu

> 
>> +                      stripe_offset, stripe_nr);
>> +        }
>> +    } else {
>> +        /*
>> +         * For all other non-RAID56 profiles, just copy the target
>> +         * stripe into the bioc.
>> +         */
>> +        for (i = 0; i < num_stripes; i++) {
>> +            set_io_stripe(&bioc->stripes[i], map, stripe_index,
>> +                      stripe_offset, stripe_nr);
>> +            stripe_index++;
>> +        }
>>     }
>>
>> +
>>     if (need_full_stripe(op))
>>         max_errors = btrfs_chunk_max_errors(map);
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- 
> geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. 
> But
> when I'm talking to journalists I just say "programmer" or something 
> like that.
>                                  -- Linus Torvalds
