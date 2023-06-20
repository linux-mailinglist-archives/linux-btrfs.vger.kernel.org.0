Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D872736B82
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjFTMDI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 08:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjFTMDH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 08:03:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090FE71
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 05:03:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 890A31F37C;
        Tue, 20 Jun 2023 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687262584;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPoAtBvv+fajShoFvqxquKFG5LJo2X4SIYMjkjNho70=;
        b=xuevw+88gFRKZAwhjsyU/ZsPC0+jqyZltnDQxRjN+TnM2rIzzKMglmVrRncw031t2VJuo+
        VFeyalulR2CD3QJB4LiAh1uPuDWAYfY7IFiIPxOjfZiFwlHbjB5c0VQZI4VzpFwn/Agr9/
        ayXCQH7u0FcU6ha2hp9vZGyKRBvScCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687262584;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPoAtBvv+fajShoFvqxquKFG5LJo2X4SIYMjkjNho70=;
        b=CHIhnd/jFR1E2naVknqhGndo80wHQfI8+sOSzqNDctog6GgF6oktVF0dYxjlTwrF2hNUwq
        CSayPHF5UPpig8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6256D133A9;
        Tue, 20 Jun 2023 12:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QSsqF3iVkWQFDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Jun 2023 12:03:04 +0000
Date:   Tue, 20 Jun 2023 13:56:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: fix u32 overflows when left shifting @stripe_nr
Message-ID: <20230620115641.GJ16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1974782b207e7011a859a45115cf4875475204dc.1687254779.git.wqu@suse.com>
 <20230620102743.GI16168@twin.jikos.cz>
 <fd37dee1-0597-ef23-67b0-9cd0b3c2f780@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd37dee1-0597-ef23-67b0-9cd0b3c2f780@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 07:24:24PM +0800, Qu Wenruo wrote:
> On 2023/6/20 18:27, David Sterba wrote:
> > On Tue, Jun 20, 2023 at 05:57:31PM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> David reported an ASSERT() get triggered during certain fio load.
> >>
> >> The ASSERT() is from rbio_add_bio() of raid56.c:
> >>
> >> 	ASSERT(orig_logical >= full_stripe_start &&
> >> 	       orig_logical + orig_len <= full_stripe_start +
> >> 	       rbio->nr_data * BTRFS_STRIPE_LEN);
> >>
> >> Which is checking if the target rbio is crossing the full stripe
> >> boundary.
> >>
> >> [CAUSE]
> >> Commit a97699d1d610 ("btrfs: replace map_lookup->stripe_len by
> >> BTRFS_STRIPE_LEN") changes how we calculate the map length, to reduce
> >> u64 division.
> >>
> >> Function btrfs_max_io_len() is to get the length to the stripe boundary.
> >>
> >> It calculates the full stripe start offset (inside the chunk) by the
> >> following command:
> >>
> >> 		*full_stripe_start =
> >> 			rounddown(*stripe_nr, nr_data_stripes(map)) <<
> >> 			BTRFS_STRIPE_LEN_SHIFT;
> >>
> >> The calculation itself is fine, but the value returned by rounddown() is
> >> dependent on both @stripe_nr (which is u32) and nr_data_stripes() (which
> >> returned int).
> >>
> >> Thus the result is also u32, then we do the left shift, which can
> >> overflow u32.
> >>
> >> If such overflow happens, @full_stripe_start will be a value way smaller
> >> than @offset, causing later "full_stripe_len - (offset -
> >> *full_stripe_start)" to underflow, thus make later length calculation to
> >> have no stripe boundary limit, resulting a write bio to exceed stripe
> >> boundary.
> >>
> >> There are some other locations like this, with a u32 @stripe_nr got left
> >> shift, which can lead to a similar overflow.
> >>
> >> [FIX]
> >> Fix all @stripe_nr with left shift with a type cast to u64 before the
> >> left shift.
> >>
> >> Those involved @stripe_nr or similar variables are recording the stripe
> >> number inside the chunk, which is small enough to be contained by u32,
> >> but their offset inside the chunk can not fit into u32.
> >>
> >> Thus for those specific left shifts, a type cast to u64 is necessary.
> >>
> >> Reported-by: David Sterba <dsterba@suse.com>
> >> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Fix all @stripe_nr with left shift
> >> - Apply the ASSERT() on full stripe checks for all RAID56 IOs.
> >> ---
> >>   fs/btrfs/volumes.c | 15 +++++++++------
> >>   1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index b8540af6e136..ed3765d21cb0 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -5985,12 +5985,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
> >>   	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
> >>
> >>   	/* stripe_offset is the offset of this block in its stripe */
> >> -	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
> >> +	stripe_offset = offset - ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
> >
> > This needs a helper, mandating a type cast for correctness in so many
> > places is a bad pattern.
> 
> The problem is, we still need to manually determine if we need a cast or
> not.
> 
> For a lot of cases like "for (int i = 0; i < nr_data_stripes; i++) { do
> with i << BTRFS_STRIPE_LEN_SHIFT;}", it's safe to go with 32 bit and
> left shift.

The helper is supposed to avoid deciding if the cast is needed or not,
so the raw "<< BTRFS_STRIPE_LEN_SHIFT" should be abstracted away
everywhere and any uncommented occurece considered for closer
inspection. If you have a specific example where this would not work
please point to the code.
