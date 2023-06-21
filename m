Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054937383ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjFUMhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 08:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjFUMhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 08:37:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20089B
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 05:37:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 527FE1FE3B;
        Wed, 21 Jun 2023 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687351063;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EMtY9Mu+swiWu1cbfNftiToPIx0EoOZhyBhmFLGGPE=;
        b=Encq6r0dv4/KimQbyejrrLL77jqxrhQCnFBi6/7AwG+sWCoHhnl++6PDPvJi6zSQAGsO+q
        w7AXZ4Fmd7tXU+bOHa4MilzaGbszV/a4qH0zu6qUtv5BtzkFjH1mh+U1CJFFGBqud/l/R3
        /M9UIazcXZtAX4iULDwYf+vh7YdQKA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687351063;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EMtY9Mu+swiWu1cbfNftiToPIx0EoOZhyBhmFLGGPE=;
        b=pKv/hystno9VJm1sHU2/zHU7mkfVuQ6s5h2SleZtOSzOLxHCu0Fu+VQ6NjnU1q4JrLeKGL
        Hk1iLeBWfxqePyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FAB4133E6;
        Wed, 21 Jun 2023 12:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id igHDBhfvkmQpTwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Jun 2023 12:37:43 +0000
Date:   Wed, 21 Jun 2023 14:31:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3] btrfs: fix u32 overflows when left shifting @stripe_nr
Message-ID: <20230621123119.GO16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f54a6df348877cb38380d842743aafdf8ab8995a.1687308686.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54a6df348877cb38380d842743aafdf8ab8995a.1687308686.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 21, 2023 at 08:52:40AM +0800, Qu Wenruo wrote:
> [BUG]
> David reported an ASSERT() get triggered during certain fio load.
> 
> The ASSERT() is from rbio_add_bio() of raid56.c:
> 
> 	ASSERT(orig_logical >= full_stripe_start &&
> 	       orig_logical + orig_len <= full_stripe_start +
> 	       rbio->nr_data * BTRFS_STRIPE_LEN);
> 
> Which is checking if the target rbio is crossing the full stripe
> boundary.
> 
> [CAUSE]
> Commit a97699d1d610 ("btrfs: replace map_lookup->stripe_len by
> BTRFS_STRIPE_LEN") changes how we calculate the map length, to reduce
> u64 division.
> 
> Function btrfs_max_io_len() is to get the length to the stripe boundary.
> 
> It calculates the full stripe start offset (inside the chunk) by the
> following command:
> 
> 		*full_stripe_start =
> 			rounddown(*stripe_nr, nr_data_stripes(map)) <<
> 			BTRFS_STRIPE_LEN_SHIFT;
> 
> The calculation itself is fine, but the value returned by rounddown() is
> dependent on both @stripe_nr (which is u32) and nr_data_stripes() (which
> returned int).
> 
> Thus the result is also u32, then we do the left shift, which can
> overflow u32.
> 
> If such overflow happens, @full_stripe_start will be a value way smaller
> than @offset, causing later "full_stripe_len - (offset -
> *full_stripe_start)" to underflow, thus make later length calculation to
> have no stripe boundary limit, resulting a write bio to exceed stripe
> boundary.
> 
> There are some other locations like this, with a u32 @stripe_nr got left
> shift, which can lead to a similar overflow.
> 
> [FIX]
> Introduce a dedicated helper, btrfs_stripe_nr_to_offset(), to do the
> proper type cast.
> 
> Those involved @stripe_nr or similar variables are recording the stripe
> number inside the chunk, which is small enough to be contained by u32,
> but their offset inside the chunk can not fit into u32.
> 
> For now only the unsafe call sites are converted to the helper, as this
> patch is only a hotfix.
> 
> The remaining call sites would be cleaned up later.
> 
> Reported-by: David Sterba <dsterba@suse.com>
> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix all @stripe_nr with left shift
> - Apply the ASSERT() on full stripe checks for all RAID56 IOs.
> 
> v3:
> - Use a dedicated helper to do the left shift.

Please rephrase the changelog so it's describing the cleanup and refresh
it on top of misc-next that now has the fix (v2). Thanks.
