Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A927253A91E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354978AbiFAOZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355507AbiFAOZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 10:25:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F9F32EFF
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 07:16:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33585219D0;
        Wed,  1 Jun 2022 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654092996;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhMYiKOG4U6IQqQf26YYVuqgJwChN7/cJjB18haHOag=;
        b=D1W7L2l0fK2OYf3YmbdbGNQ/rzpNkmzlx+r9sdXL1UlOmim2Zy+3wcvA8h9lGMuUONw6cM
        pHzc/Os7/Lzjf+8I+x97DrALTwRWwtR0hBfVl9OBfvLY9+wLQVTtt0SZaVA1mV0WD99FyT
        MGAxyknEIc7iSuf5GxSB3bE5TG2e7qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654092996;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhMYiKOG4U6IQqQf26YYVuqgJwChN7/cJjB18haHOag=;
        b=abJXKZTjjp6+2S+Zt41LiovyvKGxyU/MU7zF7RRLbiPzKTXMYFWkFCfRtcQ4U4zLAKBTXp
        xeWNaeequw9n61Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0CE613A8F;
        Wed,  1 Jun 2022 14:16:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tkaROcN0l2LvEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 14:16:35 +0000
Date:   Wed, 1 Jun 2022 16:12:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add RAID56 submitted bio trace events
Message-ID: <20220601141209.GO20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <56cbf892eb0bec3b26da3e26f46537e94fb358af.1654076723.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cbf892eb0bec3b26da3e26f46537e94fb358af.1654076723.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 01, 2022 at 05:46:59PM +0800, Qu Wenruo wrote:
> For the later incoming RAID56J, it's better to know each bio we're
> submitting from btrfs RAID56 layer, so this patch will introduce the
> trace events for every bio submitted by btrfs RAID56 layer.

I'd phrase that it's useful in general, not in connection with some RFC
patchset.

> The output looks like this: (trace event header and UUID skipped)
> 
>    raid56_read_partial: full_stripe=389152768 devid=3 type=DATA1 offset=32768 opf=0x0 physical=323059712 len=32768
>    raid56_read_partial: full_stripe=389152768 devid=1 type=DATA2 offset=0 opf=0x0 physical=67174400 len=65536
>    raid56_write_stripe: full_stripe=389152768 devid=3 type=DATA1 offset=0 opf=0x1 physical=323026944 len=32768
>    raid56_write_stripe: full_stripe=389152768 devid=2 type=PQ1 offset=0 opf=0x1 physical=323026944 len=32768
> 
> The above debug output is from a 32K data write into an empty RAID56
> data chunk.
> 
> Some explanation on the event output:
>  full_stripe:	the logical bytenr of the full stripe
>  devid:		btrfs devid
>  type:		raid stripe type.
> 		DATA1:	the first data stripe
> 		DATA2:	the second data stripe
> 		PQ1:	the P stripe
> 		PQ2:	the Q stripe
>  offset:	the offset inside the stripe.
>  opf:		the bio op type
>  physical:	the physical offset the bio is for
>  len:		the length of the bio
> 
> The first two lines are from partial RMW read, which is reading the
> remaining data stripes from disks.
> 
> The last two lines are for full stripe RMW write, which is writing the
> involved two 16K stripes (one for DATA1 stripe, one for P stripe).
> The stripe for DATA2 doesn't need to be written.
> 
> There are 5 types of trace events:
> - raid56_read_partial
>   Read remaining data for regular read/write path.
> 
> - raid56_write_stripe
>   Write the modified stripes for regular read/write path.
> 
> - raid56_scrub_read_recover
>   Read remaining data for scrub recovery path.
> 
> - raid56_scrub_write_stripe
>   Write the modified stripes for scrub path.
> 
> - raid56_scrub_read
>   Read remaining data for scrub path.
> 
> Also, since the trace events are included at super.c, we have to export
> needed structure definitions into "raid56.h" and include the header in
> super.c, or we're unable to access those members.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

> @@ -1426,8 +1322,13 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
>  
>  	while ((bio = bio_list_pop(&bio_list))) {
> +		struct raid56_bio_trace_info trace_info = {0};

						          { 0 }
> +
>  		bio->bi_end_io = raid_write_end_io;
>  
> +		if (trace_raid56_write_stripe_enabled())
> +			bio_get_trace_info(rbio, bio, &trace_info);
> +		trace_raid56_write_stripe(rbio, bio, &trace_info);

The definition of trace_info and the call to trace_... should be inside
the if body.

>  		submit_bio(bio);
>  	}
>  	return;
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -7,6 +7,163 @@
>  #ifndef BTRFS_RAID56_H
>  #define BTRFS_RAID56_H
>  
> +#include <linux/workqueue.h>
> +#include "volumes.h"
> +
> +enum btrfs_rbio_ops {
> +	BTRFS_RBIO_WRITE,
> +	BTRFS_RBIO_READ_REBUILD,
> +	BTRFS_RBIO_PARITY_SCRUB,
> +	BTRFS_RBIO_REBUILD_MISSING,
> +};
> +
> +struct btrfs_raid_bio {
> +	struct btrfs_io_context *bioc;
> +
> +	/* while we're doing rmw on a stripe
> +	 * we put it into a hash table so we can
> +	 * lock the stripe and merge more rbios
> +	 * into it.
> +	 */

Moved comments should be reformatted and fixed.

> +/*
> + * For trace event usage only. Records useful debug info for each bio submitted
> + * by RAID56 to each physical device.
> + *
> + * No matter signed or not, (-1) is always the one indicating we can not grab
> + * the proper stripe number.
> + */
> +struct raid56_bio_trace_info {
> +	u64 devid;
> +
> +	/* The offset inside the stripe. (<= STRIPE_LEN) */
> +	u32 offset;
> +
> +	/*
> +	 * Stripe number.
> +	 * 0 is the first data stripe, and nr_data for P stripe,
> +	 * nr_data + 1 for Q stripe.
> +	 * >= real_stripes for 

This looks unfinished, please let me know what to write the I'll update
the commit.

> +	 */
> +	u8 stripe_nr;

Besides the above comment, I've reformatted the comments and moved the
tracepoint under the _enabled() condition, patch in misc-next. Thanks.
