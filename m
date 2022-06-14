Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A554B2BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiFNOFb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiFNOFa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 10:05:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E53A724
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 07:05:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE5AF21B22;
        Tue, 14 Jun 2022 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655215526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpwrcU7FUC8giJavt1yksuzGDaMkhv+HLL0aO11UYT8=;
        b=rJabR4bB3xfxuYGp50vug9/gg1W2UUyAMIojVyZuTIcWrbcyqXrTkJVJbIG9Ts7uzJU+or
        KQA4H1axZURJMzL7e/Hu0uUFCFfnoi+nk6CLnhSVPezy2cAvazoWjwFvxqAsj0v+EnhtsL
        RUalHMDp75i65+wFVXxquDr5n1iC1kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655215526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpwrcU7FUC8giJavt1yksuzGDaMkhv+HLL0aO11UYT8=;
        b=ZGJjv7XAVe5KJy+8zdiyGOWJd+s9l8zBDZA54Es7ESjlpApIjSEa0bNF2+RxaUSNspa5Dy
        EYbV+tkMmsDcX3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E49E139EC;
        Tue, 14 Jun 2022 14:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZEXrHaaVqGLhOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Jun 2022 14:05:26 +0000
Date:   Tue, 14 Jun 2022 16:00:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't trust any cached sector in
 __raid56_parity_recover()
Message-ID: <20220614140053.GL20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com>
 <20220608094751.GA3603651@falcondesktop>
 <b4a9889a-2c9d-8f74-985b-f0b7b176a1fa@suse.com>
 <CAL3q7H6emgApw9saZ3k7Eb7PDx46=-nLKTRBcYvqXCQ3d=0BVQ@mail.gmail.com>
 <4919754e-045d-9061-27dd-dea61e9e4cef@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4919754e-045d-9061-27dd-dea61e9e4cef@gmx.com>
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

On Thu, Jun 09, 2022 at 05:54:31AM +0800, Qu Wenruo wrote:
> >>      incidentally make it possible.
> >>
> >>      But later patch "btrfs: update stripe_sectors::uptodate in
> >>      steal_rbio" will revert it.
> >>
> >> 2) No full P/Q stripe write for partial write
> >>      This is done by patch "btrfs: only write the sectors in the vertical
> >>      stripe which has data stripes".
> >>
> >>
> >> So in misc-next tree, the window is super small, just between patch
> >> "btrfs: only write the sectors in the vertical stripe which has data
> >> stripes" and "btrfs: update stripe_sectors::uptodate in steal_rbio".
> >>
> >> Which there is only one commit between them.
> >>
> >> To properly test that case, I have uploaded my branch for testing:
> >> https://github.com/adam900710/linux/tree/testing
> >
> > With that branch, it seems to work, it ran 108 times here and it never failed.
> > So only the changelog needs to be updated to mention all the patches that
> > are needed.
> 
> And a new problem is, would I need to push all of those patches to
> stable kernels?
> Especially there is a patch that doesn't make sense for stable (part of
> subpage support for RAID56)

If a fix makes sense for an older stable but the code diverges too much,
it should be OK to do a special version as long as it's reasonable
(size or what code is touched). Also it does not need to be for all
stable kernels, if it's eg. 5.15 or 5.10 that's IMO good enough.
