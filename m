Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830673745A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjFTSeV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjFTSeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 14:34:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7355A10D0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 11:34:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 149481F37C;
        Tue, 20 Jun 2023 18:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687286058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcMYVggcIQFQPzQAUkaRx2ATNPFSeHBn+SJeSK/VYBM=;
        b=f9jncfFYVJBEb0mZBSx9xGgTEbvDGsOx8r6CSSt97DL/Vw0Uh4pqaYNoc8roD3UqLMpI9+
        jv6/eld/dNZkS/8jo8X6ugpfdvt4HRn73iIEYhkpMeacdb5n+AhbJIgV79Wrg76bHDYate
        s7veM/d66nRTI1jIYQZPM6M4EUzdPg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687286058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcMYVggcIQFQPzQAUkaRx2ATNPFSeHBn+SJeSK/VYBM=;
        b=6DtVZ/x2Tk8m4Fovgh1K+sETaPIGTgl64drW5M2+GZhHahkOBXwE5sc+Whjac14hLovqH3
        RG88+jJRMdG0RADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D557E133A9;
        Tue, 20 Jun 2023 18:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yVxHMynxkWQuSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Jun 2023 18:34:17 +0000
Date:   Tue, 20 Jun 2023 20:27:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: fix u32 overflows when left shifting @stripe_nr
Message-ID: <20230620182754.GL16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1974782b207e7011a859a45115cf4875475204dc.1687254779.git.wqu@suse.com>
 <20230620102743.GI16168@twin.jikos.cz>
 <fd37dee1-0597-ef23-67b0-9cd0b3c2f780@gmx.com>
 <20230620115641.GJ16168@twin.jikos.cz>
 <c9b1c74c-e5af-5c70-8939-64d0360a452b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9b1c74c-e5af-5c70-8939-64d0360a452b@suse.com>
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

On Tue, Jun 20, 2023 at 08:05:58PM +0800, Qu Wenruo wrote:
> On 2023/6/20 19:56, David Sterba wrote:
> > On Tue, Jun 20, 2023 at 07:24:24PM +0800, Qu Wenruo wrote:
> >> On 2023/6/20 18:27, David Sterba wrote:
> >>> On Tue, Jun 20, 2023 at 05:57:31PM +0800, Qu Wenruo wrote:
> >>>> ---
> >>>>    fs/btrfs/volumes.c | 15 +++++++++------
> >>>>    1 file changed, 9 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>> index b8540af6e136..ed3765d21cb0 100644
> >>>> --- a/fs/btrfs/volumes.c
> >>>> +++ b/fs/btrfs/volumes.c
> >>>> @@ -5985,12 +5985,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
> >>>>    	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
> >>>>
> >>>>    	/* stripe_offset is the offset of this block in its stripe */
> >>>> -	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
> >>>> +	stripe_offset = offset - ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
> >>>
> >>> This needs a helper, mandating a type cast for correctness in so many
> >>> places is a bad pattern.
> >>
> >> The problem is, we still need to manually determine if we need a cast or
> >> not.
> >>
> >> For a lot of cases like "for (int i = 0; i < nr_data_stripes; i++) { do
> >> with i << BTRFS_STRIPE_LEN_SHIFT;}", it's safe to go with 32 bit and
> >> left shift.
> > 
> > The helper is supposed to avoid deciding if the cast is needed or not,
> > so the raw "<< BTRFS_STRIPE_LEN_SHIFT" should be abstracted away
> > everywhere and any uncommented occurece considered for closer
> > inspection. If you have a specific example where this would not work
> > please point to the code.
> 
> E.g. for the code inside RAID56 utilizing the left shift, they are all 
> safe and no need to do a u64 cast.
> 
> Yes, I got your point, but for the bug fix, can we split them into two 
> patches?
> The first one introduce the helper and fix the 5 call sites, this should 
> be very small and easy to backport.
> 
> Then the second patch to convert the remaining ones no matter if it's 
> safe or not.
> 
> Would this be a reasonable solution?

Yes, given the time constraints it's safer to do a minimal fix. No other
problem has appeared, I tried the workload on 26 devices, some profile
conversions, device deletions, scrub etc.
