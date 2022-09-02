Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D135AAE2F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiIBMPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 08:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIBMPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 08:15:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD315E311
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 05:15:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 48E915BDB9;
        Fri,  2 Sep 2022 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662120950;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJ0zPz3st6f4W3RSXsaCdmNxQL+fk0gg5NdmMxm2zzg=;
        b=U33bd8IpTfSmQv1r4sZxuhkV8o/CRLsb5HXBcCmKYc0V/42BAcrfqoDNUaaBcrGMgcOU9Z
        CSIg9R5N89fVWnZIiej8kNB2PlI/g4DyMaVG0TK4r/nooXFgTNn7BfEzJm751BQGoq74oK
        015jt9vVaKRUtkQvd9DXJMt5vqfxMb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662120950;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJ0zPz3st6f4W3RSXsaCdmNxQL+fk0gg5NdmMxm2zzg=;
        b=CaccykFTObjnb6NFBdj1WkzwKaBfhVhZgUZntMnnZ8E76yF2+lOwM1kUGQ3IpkpCbjp5B3
        jr3lSch3+oQl/cCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16F1213328;
        Fri,  2 Sep 2022 12:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aSueBPbzEWO5YAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 12:15:50 +0000
Date:   Fri, 2 Sep 2022 14:10:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from
 extent tree v2
Message-ID: <20220902121029.GS13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
 <20220831191442.GL13489@twin.jikos.cz>
 <66396669-7174-dd04-aaa9-d8322bc39fdb@gmx.com>
 <ab123921-773a-9e1b-1d49-9e82614a37d9@gmx.com>
 <20220902092140.GP13489@twin.jikos.cz>
 <2b614da3-0fe2-f2fc-1754-ecbdcd1620d9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b614da3-0fe2-f2fc-1754-ecbdcd1620d9@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 05:37:53PM +0800, Qu Wenruo wrote:
> > Yeah, the free-space-tree is misplaced and I did not realize that back
> > then. That something is possible to switch on at run time by a mount
> > option should not be the only condition to put the option to the -R option.
> > 
> > Quota are maybe still a good example of the runtime feature, there's a
> > command to enable and disable it. There are additional structures
> > created or deleted but it's not something fundamental. The distinction
> > in the options should hint at what's the type "what if I don't select
> > this now, can I turn it on later?", perhaps documentation should be more
> > explicit about that.
> 
> Quota tree is a special case, just because it's from day-one, thus no 
> compat/compat ro/incompat flags needed at all.
> 
> To me, we can accept one exception.
> 
> > 
> > For compatibility we need to keep free-space-tree under -R but we can
> > add an alias to -O and everything of that sort add there too, like the
> > block group tree.
> 
> That's simple, make -R deprecated, and treat -R just as -O internally, 
> and put all features including quota into -O.
> 
> Of course, we may need some small changes, as now one fs feature needs 1 
> or 0 compat/compat ro/incompat flags set.
> But everything else, from the compat/safe/default string can be 
> inherited from the existing format.
> 
> By this, we have the minimal code change, while still keeps the same 
> compatibility (in fact, greatly enlarged -O options)

It's a change to the interface so it's always with some consequences but
I think a single option for features is indeed an improvement. We now
have only 2 under -R so it's not that bad yet.

I've looked to manual pages of other filesystems' mkfs, there are
separate options but for specific features like for journal, or
additional tunables. For the global features there's one option.

We can add the quota and f-s-tree in a minor release, it's not breaking
compatibility and add a warning to -R in some future major release.
