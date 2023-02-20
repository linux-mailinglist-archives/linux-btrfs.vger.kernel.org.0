Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB669CA91
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 13:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjBTMPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 07:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjBTMPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 07:15:03 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0D1A67E;
        Mon, 20 Feb 2023 04:15:02 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id x1so1247634qtw.3;
        Mon, 20 Feb 2023 04:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1MSO2w1kMSKm/Y9n62XXqY52kNnO7PPqBPx0Lzak2c=;
        b=nHwOUCLXZvjPZfTIcJGfhLVjuNZu3NAMy3g/C+gG44nv/xIURrAW51hBnYWJe5CLgL
         ypHymGRbiBhYBOUbfL06eE2RDber2yc9mR3WEO/xvKxMr8Q6a6G1rn3p6WRRd/Matl1D
         ANyt3xaR9pP1nDSwlqIUhCY3bRsD/wMj1UaVC6F+4KNM6dTGSqi6xZXwIeyFDvRQtr3E
         d1mHziGBLtru8rUcA2yHzXE31H/Eo/XNVNzGnsQxF1CoNS1Z6d5ErXk+x1uc4uZdoNDz
         TDez/qn+fTVh43V7EZYmhiPKgb/xxy0kVpZ5ixJGqVEPNMUHUiDfts8pmBv5nZR1qzIJ
         mfBw==
X-Gm-Message-State: AO0yUKVSsHppYN3tdUhIDqxaNbHeZzqL0Bl9heWW9MB0NZAKR/KLU5HT
        FbSuWxc0fvmkrIjDnpv7aEDuIDSv8scrmw==
X-Google-Smtp-Source: AK7set9xK0kSmh7m0c+2eWRaCYtzSK2Qqjl6Z5w+NViYKqBBen2EnTD9yHbWKNYCk3RJgY2/Ro2dHA==
X-Received: by 2002:ac8:5f12:0:b0:3b9:c889:ec24 with SMTP id x18-20020ac85f12000000b003b9c889ec24mr15377681qta.12.1676895300819;
        Mon, 20 Feb 2023 04:15:00 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id l28-20020ac8459c000000b003b9bf862c04sm8885465qtn.55.2023.02.20.04.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 04:15:00 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id o145so1783994ybg.8;
        Mon, 20 Feb 2023 04:15:00 -0800 (PST)
X-Received: by 2002:a05:6902:2d0:b0:920:2b79:84b4 with SMTP id
 w16-20020a05690202d000b009202b7984b4mr702298ybh.386.1676895300117; Mon, 20
 Feb 2023 04:15:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675743217.git.wqu@suse.com> <f82eed6746d19cf3bea15631a120648eadf20852.1675743217.git.wqu@suse.com>
 <e3c9bab1-41e-7fe0-1833-1c81ced89a20@linux-m68k.org> <e567a113-1cbd-134b-6db0-82433eca6685@gmx.com>
In-Reply-To: <e567a113-1cbd-134b-6db0-82433eca6685@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Feb 2023 13:14:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwXB4YsCFEpLoTm8pxyjMty6tAT7joNj2EME4ynY8keQ@mail.gmail.com>
Message-ID: <CAMuHMdVwXB4YsCFEpLoTm8pxyjMty6tAT7joNj2EME4ynY8keQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] btrfs: replace btrfs_io_context::raid_map[] with a
 fixed u64 value
To:     quwenruo.btrfs@gmx.com
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On Mon, Feb 20, 2023 at 12:50 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2023/2/20 16:53, Geert Uytterhoeven wrote:
> > On Tue, 7 Feb 2023, Qu Wenruo wrote:
> >> In btrfs_io_context structure, we have a pointer raid_map, which is to
> >> indicate the logical bytenr for each stripe.
> >>
> >> But considering we always call sort_parity_stripes(), the result
> >> raid_map[] is always sorted, thus raid_map[0] is always the logical
> >> bytenr of the full stripe.
> >>
> >> So why we waste the space and time (for sorting) for raid_map[]?
> >>
> >> This patch will replace btrfs_io_context::raid_map with a single u64
> >> number, full_stripe_start, by:
> >>
> >> - Replace btrfs_io_context::raid_map with full_stripe_start
> >>
> >> - Replace call sites using raid_map[0] to use full_stripe_start
> >>
> >> - Replace call sites using raid_map[i] to compare with nr_data_stripes.
> >>
> >> The benefits are:
> >>
> >> - Less memory wasted on raid_map
> >>  It's sizeof(u64) * num_stripes vs size(u64).
> >>  It's always a save for at least one u64, and the benefit grows larger
> >>  with num_stripes.
> >>
> >> - No more weird alloc_btrfs_io_context() behavior
> >>  As there is only one fixed size + one variable length array.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Thanks for your patch, which is now commit 4a8c6e8a6dc8ae4c ("btrfs:
> > replace btrfs_io_context::raid_map with a fixed u64 value") in
> > next-20230220.
> >
> > noreply@ellerman.id.au reported several build failures when
> > building for 32-bit platforms:
> >
> >      ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
> >
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -6556,35 +6532,44 @@ int __btrfs_map_block(struct btrfs_fs_info
> >> *fs_info, enum btrfs_map_op op,
> >>     }
> >>     bioc->map_type = map->type;
> >>
> >> -    for (i = 0; i < num_stripes; i++) {
> >> -        set_io_stripe(&bioc->stripes[i], map, stripe_index,
> >> stripe_offset,
> >> -                  stripe_nr);
> >> -        stripe_index++;
> >> -    }
> >> -
> >> -    /* Build raid_map */
> >> +    /*
> >> +     * For RAID56 full map, we need to make sure the stripes[] follows
> >> +     * the rule that data stripes are all ordered, then followed with P
> >> +     * and Q (if we have).
> >> +     *
> >> +     * It's still mostly the same as other profiles, just with extra
> >> +     * rotataion.
> >> +     */
> >>     if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
> >>         (need_full_stripe(op) || mirror_num > 1)) {
> >> -        u64 tmp;
> >> -        unsigned rot;
> >> -
> >> -        /* Work out the disk rotation on this stripe-set */
> >> -        rot = stripe_nr % num_stripes;
> >> -
> >> -        /* Fill in the logical address of each stripe */
> >> -        tmp = stripe_nr * data_stripes;
> >> -        for (i = 0; i < data_stripes; i++)
> >> -            bioc->raid_map[(i + rot) % num_stripes] =
> >> -                em->start + ((tmp + i) << BTRFS_STRIPE_LEN_SHIFT);
> >> -
> >> -        bioc->raid_map[(i + rot) % map->num_stripes] = RAID5_P_STRIPE;
> >> -        if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> >> -            bioc->raid_map[(i + rot + 1) % num_stripes] =
> >> -                RAID6_Q_STRIPE;
> >> -
> >> -        sort_parity_stripes(bioc, num_stripes);
> >> +        /*
> >> +         * For RAID56 @stripe_nr is already the number of full stripes
> >> +         * before us, which is also the rotation value (needs to modulo
> >> +         * with num_stripes).
> >> +         *
> >> +         * In this case, we just add @stripe_nr with @i, then do the
> >> +         * modulo, to reduce one modulo call.
> >> +         */
> >> +        bioc->full_stripe_logical = em->start +
> >> +            ((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
> >> +        for (i = 0; i < num_stripes; i++) {
> >> +            set_io_stripe(&bioc->stripes[i], map,
> >> +                      (i + stripe_nr) % num_stripes,
> >
> > As stripe_nr is u64, this is a 64-by-32 modulo operation, which
> > should be implemented using a helper from include/linux/math64.h
> > instead.
>
> This is an older version, in the latest version, the @stripe_nr variable
> is also u32, and I tried compiling the latest branch with i686, it
> doesn't cause any u64 division problems anymore.
>
> You can find the latest branch in either github or from the mailling list:
>
> https://github.com/adam900710/linux/tree/map_block_refactor
>
> https://lore.kernel.org/linux-btrfs/cover.1676611535.git.wqu@suse.com/

So the older version was "v2", and the latest version had no
version indicator, nor changelog, thus assuming v1?
No surprise people end up applying the wrong version...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
