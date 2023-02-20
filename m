Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4862669C705
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 09:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBTIxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 03:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBTIxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 03:53:50 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F69EC0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 00:53:48 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:e2ba:5470:259d:9c84])
        by michel.telenet-ops.be with bizsmtp
        id PLtl290072zSf1N06LtlMR; Mon, 20 Feb 2023 09:53:45 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pU1vd-009WV9-4b;
        Mon, 20 Feb 2023 09:53:45 +0100
Date:   Mon, 20 Feb 2023 09:53:45 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Qu Wenruo <wqu@suse.com>
cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: replace btrfs_io_context::raid_map[] with
 a fixed u64 value
In-Reply-To: <f82eed6746d19cf3bea15631a120648eadf20852.1675743217.git.wqu@suse.com>
Message-ID: <e3c9bab1-41e-7fe0-1833-1c81ced89a20@linux-m68k.org>
References: <cover.1675743217.git.wqu@suse.com> <f82eed6746d19cf3bea15631a120648eadf20852.1675743217.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 	Hi Qu,

On Tue, 7 Feb 2023, Qu Wenruo wrote:
> In btrfs_io_context structure, we have a pointer raid_map, which is to
> indicate the logical bytenr for each stripe.
>
> But considering we always call sort_parity_stripes(), the result
> raid_map[] is always sorted, thus raid_map[0] is always the logical
> bytenr of the full stripe.
>
> So why we waste the space and time (for sorting) for raid_map[]?
>
> This patch will replace btrfs_io_context::raid_map with a single u64
> number, full_stripe_start, by:
>
> - Replace btrfs_io_context::raid_map with full_stripe_start
>
> - Replace call sites using raid_map[0] to use full_stripe_start
>
> - Replace call sites using raid_map[i] to compare with nr_data_stripes.
>
> The benefits are:
>
> - Less memory wasted on raid_map
>  It's sizeof(u64) * num_stripes vs size(u64).
>  It's always a save for at least one u64, and the benefit grows larger
>  with num_stripes.
>
> - No more weird alloc_btrfs_io_context() behavior
>  As there is only one fixed size + one variable length array.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for your patch, which is now commit 4a8c6e8a6dc8ae4c ("btrfs:
replace btrfs_io_context::raid_map with a fixed u64 value") in
next-20230220.

noreply@ellerman.id.au reported several build failures when
building for 32-bit platforms:

     ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!

> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6556,35 +6532,44 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> 	}
> 	bioc->map_type = map->type;
>
> -	for (i = 0; i < num_stripes; i++) {
> -		set_io_stripe(&bioc->stripes[i], map, stripe_index, stripe_offset,
> -			      stripe_nr);
> -		stripe_index++;
> -	}
> -
> -	/* Build raid_map */
> +	/*
> +	 * For RAID56 full map, we need to make sure the stripes[] follows
> +	 * the rule that data stripes are all ordered, then followed with P
> +	 * and Q (if we have).
> +	 *
> +	 * It's still mostly the same as other profiles, just with extra
> +	 * rotataion.
> +	 */
> 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
> 	    (need_full_stripe(op) || mirror_num > 1)) {
> -		u64 tmp;
> -		unsigned rot;
> -
> -		/* Work out the disk rotation on this stripe-set */
> -		rot = stripe_nr % num_stripes;
> -
> -		/* Fill in the logical address of each stripe */
> -		tmp = stripe_nr * data_stripes;
> -		for (i = 0; i < data_stripes; i++)
> -			bioc->raid_map[(i + rot) % num_stripes] =
> -				em->start + ((tmp + i) << BTRFS_STRIPE_LEN_SHIFT);
> -
> -		bioc->raid_map[(i + rot) % map->num_stripes] = RAID5_P_STRIPE;
> -		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> -			bioc->raid_map[(i + rot + 1) % num_stripes] =
> -				RAID6_Q_STRIPE;
> -
> -		sort_parity_stripes(bioc, num_stripes);
> +		/*
> +		 * For RAID56 @stripe_nr is already the number of full stripes
> +		 * before us, which is also the rotation value (needs to modulo
> +		 * with num_stripes).
> +		 *
> +		 * In this case, we just add @stripe_nr with @i, then do the
> +		 * modulo, to reduce one modulo call.
> +		 */
> +		bioc->full_stripe_logical = em->start +
> +			((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
> +		for (i = 0; i < num_stripes; i++) {
> +			set_io_stripe(&bioc->stripes[i], map,
> +				      (i + stripe_nr) % num_stripes,

As stripe_nr is u64, this is a 64-by-32 modulo operation, which
should be implemented using a helper from include/linux/math64.h
instead.

> +				      stripe_offset, stripe_nr);
> +		}
> +	} else {
> +		/*
> +		 * For all other non-RAID56 profiles, just copy the target
> +		 * stripe into the bioc.
> +		 */
> +		for (i = 0; i < num_stripes; i++) {
> +			set_io_stripe(&bioc->stripes[i], map, stripe_index,
> +				      stripe_offset, stripe_nr);
> +			stripe_index++;
> +		}
> 	}
>
> +
> 	if (need_full_stripe(op))
> 		max_errors = btrfs_chunk_max_errors(map);

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
