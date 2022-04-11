Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF384FB9A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 12:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbiDKKbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 06:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345543AbiDKKbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 06:31:48 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432F2DA8F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 03:29:33 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b509:6862:2557:437a])
        by michel.telenet-ops.be with bizsmtp
        id HNVW2700H1G7NMJ06NVWo2; Mon, 11 Apr 2022 12:29:30 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndrIY-0009rq-42; Mon, 11 Apr 2022 12:29:30 +0200
Date:   Mon, 11 Apr 2022 12:29:30 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Qu Wenruo <wqu@suse.com>
cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH 03/16] btrfs: introduce new cached members for
 btrfs_raid_bio
In-Reply-To: <a2f049f315b3c218d909c854ab117779d8842abe.1648807440.git.wqu@suse.com>
Message-ID: <alpine.DEB.2.22.394.2204111227010.37905@ramsan.of.borg>
References: <cover.1648807440.git.wqu@suse.com> <a2f049f315b3c218d909c854ab117779d8842abe.1648807440.git.wqu@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 	Hi Qu,

On Fri, 1 Apr 2022, Qu Wenruo wrote:
> The new members are all related to number of sectors, but the existing
> number of pages members are kept as is:
>
> - nr_sectors
>  Total sectors of the full stripe including P/Q.
>
> - stripe_nsectors
>  The sectors of a single stripe.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for your patch, which is now commit f1e779cdb7f165f0
("btrfs: raid56: introduce new cached members for btrfs_raid_bio") in
next-20220411.

> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -958,18 +964,25 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
> 	const unsigned int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
> 	const unsigned int num_pages = DIV_ROUND_UP(stripe_len, PAGE_SIZE) *
> 				       real_stripes;
> +	const unsigned int num_sectors = DIV_ROUND_UP(stripe_len * real_stripes,
> +						      fs_info->sectorsize);

noreply@ellerman.id.au reports for m68k builds:

     ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!

As this is a 64-by-32 division, you should not use a plain division,
but e.g. a shift by fs_info->sectorsize_bits.

> 	const unsigned int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
> +	const unsigned int stripe_nsectors = DIV_ROUND_UP(stripe_len,
> +							  fs_info->sectorsize);

Likewise.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
