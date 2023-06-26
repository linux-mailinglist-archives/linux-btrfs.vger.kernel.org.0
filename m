Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908A073DC59
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFZKiz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFZKiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 06:38:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE8E73
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 03:38:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 567B82184D;
        Mon, 26 Jun 2023 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687775931;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trGggfR/IUvAVWlPH1bERxA92AsPmlQL8l5VrRJOKmg=;
        b=D7ntllqYcQ5Fsbkaamb04d97OzKJKLymJLUCr0QC2mOYXX4MeDgJFwcKypuaAf7tD20nW2
        tBqTuToYReuj9Sr0RbouD+5DDA4FRs1/Rqh9G/0uXGs8wgbglGJn5v4PhFZ3v4sTqj57RC
        fFeHsVIb4ENh8TKz7J1KrY7nz2FFFac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687775931;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trGggfR/IUvAVWlPH1bERxA92AsPmlQL8l5VrRJOKmg=;
        b=BzhhBT7C/E/zQMeSQmlQV4+67U7Be1Mzn+rUVFJ1oKdfTXBFNVvmx2niGjD/X6Fdq8RHNm
        hMoLAT0e8By8GbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3889313905;
        Mon, 26 Jun 2023 10:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1doaDbtqmWSOEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 26 Jun 2023 10:38:51 +0000
Date:   Mon, 26 Jun 2023 12:32:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use a dedicated helper to convert stripe_nr to
 offset
Message-ID: <20230626103224.GW16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <10aca1661eee22e6a74ecab62a48227b51284ece.1687416153.git.wqu@suse.com>
 <20230622143730.GU16168@twin.jikos.cz>
 <21ac5eab-ef7e-5b41-8d06-332a1485801b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ac5eab-ef7e-5b41-8d06-332a1485801b@gmx.com>
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

On Fri, Jun 23, 2023 at 02:17:16PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/22 22:37, David Sterba wrote:
> > The subject should be clear that it's fixing a bug not a cleanup.
> >
> > On Thu, Jun 22, 2023 at 02:42:40PM +0800, Qu Wenruo wrote:
> >> [BACKGROUND]
> >> We already had a nasty regression introduced by commit a97699d1d610
> >> ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN"), which is
> >> doing a u32 left shift and can cause overflow.
> >>
> >> Later we have an incomplete fix, a7299a18a179 ("btrfs: fix u32 overflows
> >> when left shifting @stripe_nr"), which fixes 5 call sites, but with one
> >> missing call site (*) still not caught until a proper regression test is
> >> crafted.
> >>
> >> *: The assignment on bioc->full_stripe_logical inside btrfs_map_block()
> >>
> >> [FIX]
> >> To end the whack-a-mole game, this patch will introduce a helper,
> >> btrfs_stripe_nr_to_offset(), to do the u32 left shift with proper type
> >> cast to u64 to avoid overflow.
> >>
> >> This would replace all "<< BTRFS_STRIPE_LEN_SHIFT" calls, and solve the
> >> problem permanently.
> >>
> >> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
> >> Fixes: a7299a18a179 ("btrfs: fix u32 overflows when left shifting stripe_nr")
> >
> > The patch was expected to be based on commit a7299a18a179 as it's meant
> > to go to current master branch, and it does not apply cleanly. I will
> > resolve it, a few hunks get dropped and no other places need to be
> > converted but please try to make it smooth when we're getting last
> > minute urgent fixes.
> 
> I was basing the patch on the latest misc-next, shouldn't hot fix also
> go the same misc-next branch way?

It should be both but the actual code may diverge between the branches.

> Or hot fixes should go upstream instead?

If it's a regression fix namely an urgent one a few days before the
release then it certainly must go to the master branch first and it's
that should be used as a base branch.
