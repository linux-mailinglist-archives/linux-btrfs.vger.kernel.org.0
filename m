Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735944430CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 15:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhKBOxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 10:53:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48476 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhKBOxa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 10:53:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 67A481FD4C;
        Tue,  2 Nov 2021 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635864654;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hUR1+HJbWQQ47r9x8xPETncMuUN4UXEP73XAuC0V2SE=;
        b=Q1buZLmwVNFTcORhqbeBaA5ReztWd8isw4byGjZVw0NjdL0YObpeLVoIITtGIIsyDXfxxa
        RS/EvdlsIiuMHGIsiXgEFw3l6oDZpaBNrpUpTu524LiyUikMuwFNRZe+nXcacXhM+148ny
        nru2XvSo9B3bNc22G5oT6x9hETLTEDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635864654;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hUR1+HJbWQQ47r9x8xPETncMuUN4UXEP73XAuC0V2SE=;
        b=P37eNTEvq9XTW4hMU/dAT/benTNmc0IeqMmaHavyX99QFglCHrUGSN4ekuMqbAUWtEG/C+
        YckmuzwLhtLFyeDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5E6FDA3B81;
        Tue,  2 Nov 2021 14:50:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2214ADA7A9; Tue,  2 Nov 2021 15:50:19 +0100 (CET)
Date:   Tue, 2 Nov 2021 15:50:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs updates for 5.16
Message-ID: <20211102145018.GK20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1635773880.git.dsterba@suse.com>
 <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 01, 2021 at 01:03:25PM -0700, Linus Torvalds wrote:
> On Mon, Nov 1, 2021 at 9:46 AM David Sterba <dsterba@suse.com> wrote:
> >
> > There's a merge conflict due to the last minute 5.15 changes (kmap
> > reverts) and the conflict is not trivial.
> 
> You don't say.
> 
> I ended up just re-doing that resolution entirely, and as I did so, I
> think I found a bug in the original revert that caused the conflict in
> the first place.
> 
> And since that revert made it into 5.15, I felt like I had to fix that
> bug first - and separately - so that the fix can be backported to
> stable.
> 
> I then re-did my merge on top of that hopefully fixed state, and maybe
> it's correct.
> 
> Or maybe I messed up entirely.
> 
> I did end up comparing it to your other branch too, but that was
> equally as messy, apart from the "ok, I can mindlessly just take your
> side".
> 
> And it was fairly different from what I had done in my merge
> resolution, so who knows.

Looks good to me, thanks for catching the bug.

> ANYWAY. What I'm trying to say is that you should look very very
> carefully at commits
> 
>   2cf3f8133bda ("btrfs: fix lzo_decompress_bio() kmap leakage")
>   037c50bfbeb3 ("Merge tag 'for-5.16-tag' of git://git.../linux")
> 
> because I marked that first one for stable, and the second is
> obviously my entirely untested merge.
> 
> It makes sense to me, but apart from "it builds", I've not actually
> tested any of it. This is all purely from looking at the code and
> trying to figure out what the RightThing(tm) is.
> 
> Obviously the kmap thing tends to only be noticeable on 32-bit
> platforms, and that lzo_decompress_bio() bug also needs just the
> proper filesystem settings to trigger in the first place.
> 
> Again - please take a careful look. Both at my merge and at that
> alleged kmap fix.

I checked the commits individually and in the source files, all the
kmaps seem to be correctly paired with kunmaps. We'll do more tests too.
I'm sorry that it turned out to be such mess.
