Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0F602C2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJRMwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJRMwn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 08:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4436C4C12
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 05:52:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8125920805;
        Tue, 18 Oct 2022 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666097561;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hg2CCtCGqsCBDBTJ7EkeQ/vLqyNyi4AeBUZIJ6ldl3E=;
        b=mDzrW6NTIQ0Z7UgoskkuRr+n0ZbkUixZ4IcmN7sF0dcLVH5OE8evGLK/MAWEEP4meLeF6b
        3V6A96tM9ExIM9q6W61jzuhnNj2hxGwv7v38Z9RW+4j4fUj5MM7VzBauaSZ600DPZl0V/6
        7FN87AZnlNnKp/uep159+FGee8Y3OfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666097561;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hg2CCtCGqsCBDBTJ7EkeQ/vLqyNyi4AeBUZIJ6ldl3E=;
        b=ACXa58MTn6ryKifvCA82TIAIzkCBTjyyIdxfgHlRBPzchNuD47OQj8cMlo1AR02RHnyarU
        iwga6cc11OB0F8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A757139D2;
        Tue, 18 Oct 2022 12:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p0szFZmhTmMdAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 12:52:41 +0000
Date:   Tue, 18 Oct 2022 14:52:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: do not panic if we can't allocate a prealloc
 extent state
Message-ID: <20221018125231.GU13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665755095.git.josef@toxicpanda.com>
 <97fb0828deb341efe99ef2bc35cda0eccc5963de.1665755095.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97fb0828deb341efe99ef2bc35cda0eccc5963de.1665755095.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 10:00:41AM -0400, Josef Bacik wrote:
> We sometimes have to allocate new extent states when clearing or setting
> new bits in an extent io tree.  Generally we preallocate this before
> taking the tree spin lock, but we can use this preallocated extent state
> sometimes and then need to try to do a GFP_ATOMIC allocation under the
> lock.
> 
> Unfortunately sometimes this fails, and then we hit the BUG_ON() and
> bring the box down.  This happens roughly 20 times a week in our fleet.
> 
> However the vast majority of callers use GFP_NOFS, which means that if
> this GFP_ATOMIC allocation fails, we could simply drop the spin lock, go
> back and allocate a new extent state with our given gfp mask, and begin
> again from where we left off.
> 
> For the remaining callers that do not use GFP_NOFS, they are generally
> using GFP_NOWAIT, which still allows for some reclaim.  So allow these
> allocations to attempt to happen outside of the spin lock so we don't
> need to rely on GFP_ATOMIC allocations.
> 
> This in essence creates an infinite loop for anything that isn't
> GFP_NOFS.  To address this we will want to migrate to using mempools for
> extent states so that we will always have emergency reserves in order to
> make our allocations.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-io-tree.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 618275af19c4..6ad09ba28aae 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -572,7 +572,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
>  		clear = 1;
>  again:
> -	if (!prealloc && gfpflags_allow_blocking(mask)) {

There's another call to gfpflags_allow_blocking(mask) at the end of the
loop before cond_resched(), if we pass only GFP_NOFS and GFP_NOWAIT we
can assume blocking is always right? Eventually we can put an assert.

And on top of that the mask argument can be refined to 'bool wait' and
we can drop passing GFP_NOFS everywhere in the set_extent_bit* helpers.
It's for a separate patch but I think we should continue with cleanups
here as this patchset enabled a few more.
