Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD16DA69F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 02:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjDGAf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 20:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjDGAf5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 20:35:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D47282;
        Thu,  6 Apr 2023 17:35:56 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5VDE-1qUI4h1MuQ-016tVK; Fri, 07
 Apr 2023 02:35:46 +0200
Message-ID: <353b44f3-fb95-ac43-53ba-0d3b45fff574@gmx.com>
Date:   Fri, 7 Apr 2023 08:35:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: Avoid potential integer overflow when
 left-shifting 32-bit int
Content-Language: en-US
To:     Nur Hussein <hussein@unixcat.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406192406.2300379-1-hussein@unixcat.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230406192406.2300379-1-hussein@unixcat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nA5DEbDJm+YxLSbpl7WTVTG9htwqsEPlsYR4iGgpp1FpaUl2XCH
 aaD2iblrktHrlJT+lnYecAyW8v4GPRS0jvL38jFQQFOnjbsOlRBebOT82hvs3JwVtbfQwQ4
 7r/ikkYBMrUYkSfKM2Fp7D4HRIfVe1ho6Lt1B76r3NTawUuyrcrzwje7Io9AxNOt0fBGKbS
 p2sRFQLSKE+MbYSUKlS5g==
UI-OutboundReport: notjunk:1;M01:P0:67SDILSAIMQ=;mB37kQs9m1OHlz3IExDdj30CGQX
 MNzG8WyGWeJZu1LXSEfEPj7rN8CmyHFKTvWHi6sfS+ApG+T6NDhI6uyt1ooq1ZpBMuXU1PLcE
 qD3wSxg3R9V7hRRm66dBj8IHO1VNeZbF9gxhXBIQRVZT+GMnJ/lB5lwmPUuxjpgKGGra/3z3Q
 h2Y9X/TayGaeAgrKJ6B+adBCLjviv9GguBHlUEaV85fAkQwZamhlfBsXeEGgANsvOnNvE/UYY
 nGyKQeyOiSQK8bjz8qKB6K3/Ax2Ivxohu5xRF/Vr9ri0aaPHEoRksSqAIoCDKBF8iwbtHO739
 4xXBtZ1kAXphdfKkLYlh/hdAy57I/d6UftJl/w/d+4cw7b47OKxxaQjb9AMwPvmShHlMMGC21
 9v5G0UBt3ZxGxveAVcZRITBoiNEZPQYWico76km2WuM+MtP3wNabHh9wGOfW38+51PIBJqSEK
 3wBzYgVn35U7dPjqGw5TyOyAls+EuhZV6VEljTspiGco7CFLxN36blJcjUs0SSF0EioxRDiMn
 DcmNPk5h5LfLY7m5787QeTRvdBuve2beIki6tIwPWrkWH2XBxHrKIG2WZU3v+GV9gPei6cjo7
 xa4LQnj7xStNEo2Az0eY0CUp1p2pZa9B5mrdswyVJIB8x1LEEnQuVOlsuI85j/V3wiysesBBS
 pc9PC/wmsHqRB0GY4/H3Y//EugaBER/ZhziRPOEpizF2U+dyJ7Yn0gfxhqj9lBh1rxxxpWu7E
 HvPmA2wNCJafMC6p9ChWOk4h/6m1XR6yPyu8nc5Vm+NNeGi1c9sojeln8IYEPwExXs192lDa8
 Zs5yn3k+6+Hd1hCyuPrgg3fG80/BrVzQ5hAzsPRZZlSwRizMRpEVgjII/bIzws+d7jb3oLF9J
 7IhpQ21FDg9doZ9hnGYOdZCDl+3XJU2b/fFGmuG3VXzGEQaMxOSuw1O2mOyxdKG7dnRX2/AKu
 VhBDD6/qi+uK1pDIyzb+WY0y4V0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/7 03:24, Nur Hussein wrote:
> In scrub_stripe(), the 32-bit signed value returned by the
> nr_data_stripes(map) function call should be cast to u64
> before being shifted left by BTRFS_STRIPE_LEN_SHIFT (16),
> as a cautionary measure to avoid potential overflows. We
> then assign it to a u64 value anyway, so a cast before a
> shift seems prudent.

I'd say it's a little overkilled.

For nr_data_stripes(), it's at most hundreds of stripes (which is 
already insane).
Even with 16 bits left shift, we need to get 2 ** 16 stripes to overflow 
32bits.

Thanks,
Qu
> 
> Signed-off-by: Nur Hussein <hussein@unixcat.org>
> ---
>   fs/btrfs/scrub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ccb4f58ae307..4de1665fcd52 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2187,7 +2187,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   
>   	/* Initialize @offset in case we need to go to out: label */
>   	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
> -	increment = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
> +	increment = (u64)nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
>   
>   	/*
>   	 * Due to the rotation, for RAID56 it's better to iterate each stripe
