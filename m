Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC16C2647
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 01:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCUAU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 20:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUAU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 20:20:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F942241EF
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 17:20:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 923ED21A0D;
        Tue, 21 Mar 2023 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679358055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIp5Cz18GJnm/IzY/OydPmOfAyymM44UvRjjv2ft878=;
        b=NTOzLHYHvtJ3fSyLxmP0tUOg3TFCJiv79T/XNCGgs0P4llMzpvpOrtNknFSqNjsqIKaSbX
        O9mSjwq7bLbsqIaVufmtL5/nLcnJlZTYhu/MSh7EZAQwlHTR4NQMmWKjdDe/TaPf5yIL/9
        IIRpxGFdmebsxNS9TL5t/3mquTMhWuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679358055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIp5Cz18GJnm/IzY/OydPmOfAyymM44UvRjjv2ft878=;
        b=ABQiYhb379P+AHlglNM97EmGOBNdMAaQPuKVWiAmUaCS73wRnc/1lKkWB+Y4Om8TPDUAbH
        w/wgj8J4NlAcYICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E7CD13451;
        Tue, 21 Mar 2023 00:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P5y0GWf4GGSvRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 00:20:55 +0000
Date:   Tue, 21 Mar 2023 01:14:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 03/12] btrfs: introduce a new helper to submit write
 bio for scrub
Message-ID: <20230321001445.GJ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <c9482839875af328d7fe5ff6a9bebdc84c33c5ab.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9482839875af328d7fe5ff6a9bebdc84c33c5ab.1679278088.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 10:12:49AM +0800, Qu Wenruo wrote:
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index b96f40160b08..633447b6ba44 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> +	/* Map the RAID56 multi-stripe writes to a single one. */
> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		int data_stripes = bioc->map_type & BTRFS_BLOCK_GROUP_RAID5 ?
> +				   bioc->num_stripes - 1 : bioc->num_stripes - 2;

When ternary operator is used in expression, please put ( ) around it so
it's clear where it starts.

> +		int i;
> +
> +		/* This special write only works for data stripes. */
> +		ASSERT(mirror_num == 1);
> +		for (i = 0; i < data_stripes; i++) {

		for (int i = 0; ...)

We can now use the iterator value defined inside for (), it's relatively
new due to bumped minimum compiler version so I'd like to see it used
where possible.

> +			u64 stripe_start = bioc->full_stripe_logical +
> +					   (i << BTRFS_STRIPE_LEN_SHIFT);
> +
> +			if (logical >= stripe_start &&
> +			    logical < stripe_start + BTRFS_STRIPE_LEN)
> +				break;
> +		}
> +		ASSERT(i < data_stripes);
> +		smap.dev = bioc->stripes[i].dev;
> +		smap.physical = bioc->stripes[i].physical +
> +				((logical - bioc->full_stripe_logical) &
> +				 BTRFS_STRIPE_LEN_MASK);
> +		goto submit;
> +	}
> +	ASSERT(mirror_num <= bioc->num_stripes);
> +	smap.dev = bioc->stripes[mirror_num - 1].dev;
> +	smap.physical = bioc->stripes[mirror_num - 1].physical;
> +submit:
> +	ASSERT(smap.dev);
> +	btrfs_put_bioc(bioc);
> +	bioc = NULL;
> +	if (dev_replace) {
> +		ASSERT(smap.dev == fs_info->dev_replace.srcdev);
> +		smap.dev = fs_info->dev_replace.tgtdev;
> +	}
> +	__btrfs_submit_bio(&bbio->bio, bioc, &smap, mirror_num);
> +	return;
> +
> +fail:
> +	btrfs_bio_counter_dec(fs_info);
> +	btrfs_bio_end_io(orig_bbio, ret);
> +}
