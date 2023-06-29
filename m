Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C3A7429D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 17:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjF2PoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjF2PoS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 11:44:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C672D51
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 08:44:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCC961F896;
        Thu, 29 Jun 2023 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688053455;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ec4hA5g+3JVQdnis57BYF7g+Z4cSsH0CFCcjv5TUsM=;
        b=fGN0djh6YQa21WOLxDZOY5s4hr5hgU6PkVTwQvAd6qDOn5IHTfMtzuOyB51A8g3jml6zrO
        inA0rEPytrKnVhtTszHZ5tU5SO1tqa1HJ8oAzxSs5yuBjQnOljGSD96h5UZzkXNLwkqbkX
        D1Q7CbdznLJIKANffZ+VSev0EtqIf3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688053455;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ec4hA5g+3JVQdnis57BYF7g+Z4cSsH0CFCcjv5TUsM=;
        b=DRugHMMriytRjzNT919bw3maDc/g01FcBkv4QlVrWbfzM6EpQ3FmWwe+SAAOE9JSvyvmff
        wGv4pO3BwyIwbtAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AABED13905;
        Thu, 29 Jun 2023 15:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5k0BKc+mnWT/PQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 15:44:15 +0000
Date:   Thu, 29 Jun 2023 17:37:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add comments for btrfs_map_block()
Message-ID: <20230629153747.GO16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 27, 2023 at 03:34:31PM +0800, Qu Wenruo wrote:
> The function btrfs_map_block() is a critical part of the btrfs storage
> layer, which handles mapping of logical ranges to physical ranges.
> 
> Thus it's better to have some basic explanation, especially on the
> following points:
> 
> - Segment split by various boundaries
>   As a continuous logical range may be split into different segments,
>   due to various factors like zones and RAID0/5/6/10 boundaries.
> 
> - The meaning of @mirror_num
> 
> - The possible single stripe optimization
> 
> - One deprecated parameter @need_raid_map
>   Just explicitly mark it deprecated so we're aware of the problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> There would be a follow up patch, to add one new case for
> @mirror_num, where for RAID56 we allow mirror_num > num_copies, as a way
> to read P/Q stripes directly for the incoming scrub_logical.
> 
> Thus I believe it's better to explicit explain @mirror_num_ret at least.
> 
> Also if @need_raid_map can be finally removed, we can also remove the
> corner case for special op == READ && !need_raid_map case where
> mirror_num == 2 means P stripe.

Ok. Added to misc-next, thanks.

> ---
>  fs/btrfs/volumes.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ed15c89d4350..efac9293446d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6227,6 +6227,45 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
>  			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>  }
>  
> +/*
> + * Map one logical range to one or more physical ranges.
> + *
> + * @length:		(Mandatory) mapped length of this run.
> + *			One logical range can be split into different segments
> + *			due to factors like zones and RAID0/5/6/10 stripe
> + *			boundaries.
> + *
> + * @bioc_ret:		(Mandatory) returned btrfs_io_context structure.
> + *			which has one or more physical ranges (btrfs_io_stripe)
> + *			recorded inside.
> + *			Caller should call btrfs_put_bioc() to free it after use.
> + *
> + * @smap:		(Optional) single physical range optimization.
> + *			If the map request can be fulfilled by one single
> + *			physical range, and this is parameter is not NULL,
> + *			then @bioc_ret would be NULL, and @smap would be
> + *			updated.
> + *
> + * @mirror_num_ret:	(Mandatory) returned mirror number if the original
> + *			value is 0.
> + *
> + *			Mirror number 0 means to choose any live mirrors.
> + *
> + *			For non-RAID56 profiles, non-zero mirror_num means
> + *			the Nth mirror. (e.g. mirror_num 1 means the first
> + *			copy).
> + *
> + *			For RAID56 profile, mirror 1 means rebuild from P and
> + *			the remaingin data stripes.
> + *
> + *			For RAID6 profile, mirror > 2 means mark another
> + *			data/P stripe error and rebuild from the remaining
> + *			stripes..
> + *
> + * @need_raid_map:	(Deprecated) whether the map wants a full stripe map
> + *			(including all data and P/Q stripes) for RAID56.
> + *			Should always be 1 except for legacy call sites.
> + */
>  int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  		    u64 logical, u64 *length,
>  		    struct btrfs_io_context **bioc_ret,

There are some parameters that are not explained, though they're self
explaining and given how much text is needed for the others I don't
think we need to mention them.
