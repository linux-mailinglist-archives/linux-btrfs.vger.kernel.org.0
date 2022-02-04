Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD024A9F57
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 19:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiBDSld (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 13:41:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43468 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbiBDSlc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 13:41:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 03820210EA;
        Fri,  4 Feb 2022 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644000092;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGdJ6ki4qhh/XEJGnjPopR+ECmcGaXmqyQD1QXHiEzY=;
        b=CSqIUKhLv/J/P+fVOak3P5uPEJY9nANibZhdzTFbmILFQtE7VkAOjZCc/R4O8eKwTXstyy
        2E5xVsniUgsvEw7tLrMgPsxA+XKwsrsrLPx6LIiuKAH6GEePnpuGkkZwtgWMAEEMZsGKW+
        vF5B1fc+5Jt8VtSIMJhEATK3nbsG6iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644000092;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGdJ6ki4qhh/XEJGnjPopR+ECmcGaXmqyQD1QXHiEzY=;
        b=vpirmjsVEYpHqjzofIA9oMym21Yr2s6YD06qSbJN4coem6GjwyVpN6L4QyDRGTSCsOkcPT
        wqtlM2KjiXDUHEBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EF369A3B83;
        Fri,  4 Feb 2022 18:41:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34BA4DA781; Fri,  4 Feb 2022 19:40:46 +0100 (CET)
Date:   Fri, 4 Feb 2022 19:40:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
Message-ID: <20220204184046.GJ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20220130010956.1459147-1-rosenp@gmail.com>
 <20220131143930.GL14046@twin.jikos.cz>
 <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
 <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com>
 <20220201134402.GM14046@twin.jikos.cz>
 <CAKxU2N8YVZOrPTEi0tL2dAKRgpLuSs+F8rqqvwHcw1Bbzurh5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N8YVZOrPTEi0tL2dAKRgpLuSs+F8rqqvwHcw1Bbzurh5w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 01, 2022 at 04:11:25PM -0800, Rosen Penev wrote:
> > > >>> +#ifndef __SANE_USERSPACE_TYPES__
> > > >>> +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 types */
> > > >>> +#endif
> > > >>
> > > >> Is there a cleaner way instead of defining magic macros?
> > > > no. https://github.com/torvalds/linux/blob/master/arch/powerpc/include/uapi/asm/types.h#L18
> > >
> > > Really?
> > >
> > > I have the same issue in btrfs-fuse, but it can be easily solved without
> > > using the magic macro.
> > >
> > > See this issue:
> > >
> > > https://github.com/adam900710/btrfs-fuse/issues/2
> > >
> > > including <linux/types.h> seems to solve it for btrfs-fuse.
> >
> > Ok, so it's just the asm/types.h, once it's deleted it should all work
> > with linux/types.h (included via kerncompat.h).
> Qu is referring to a different issue. I am referring to bad printf formats.
> >
> > Rosen, could you please verify that this is sufficient (without the
> > extra macro)?
> It is not.
> 
> Also note that this is specific to ppc64 and mips64. and alpha
> (whatever that is).
> 
> a git grep of the linux tree for that macro shows that it's used in tools/

Ok, let's use the magic macro.
