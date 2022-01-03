Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47F9483775
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 20:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiACTOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 14:14:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiACTOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 14:14:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C84A6210FE;
        Mon,  3 Jan 2022 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641237250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xSkVvsz1+UltbaBs9C9EFJgw/cJ1i4D+ZWg/EU0+N4=;
        b=K2+EZeTRcAGUcGrHSsCTxXtwE9ExT251KyQQvWUv/Lpl+m6rH5sYh5Yo/6zqmtEUrk4H4+
        EJKyZ44STFFRhbw716GTJANpgBCX6guBA4fyik91nHsfBT/Tk2kX+9OPAppnpXK2AGgXYe
        Wc9CesXMbv+XPx9tkQQHE4Y9ptVuCvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641237250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xSkVvsz1+UltbaBs9C9EFJgw/cJ1i4D+ZWg/EU0+N4=;
        b=d6M60weD1hHlfBXsRBhh4EYAXo/G53LV7mwENQHAWh8IQGMIPX9xbFRBO6EngXctNafWP6
        NhD/InTVwg31JZCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 96FC6A3B81;
        Mon,  3 Jan 2022 19:14:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83A1EDA729; Mon,  3 Jan 2022 20:13:41 +0100 (CET)
Date:   Mon, 3 Jan 2022 20:13:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/3] btrfs: zoned: fix zoned extent allocator
Message-ID: <20220103191341.GS28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20211207153549.2946602-1-naohiro.aota@wdc.com>
 <20211208161814.GL28560@twin.jikos.cz>
 <20211229002230.6qvi5jelmitwjvlz@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229002230.6qvi5jelmitwjvlz@shindev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 29, 2021 at 12:22:31AM +0000, Shinichiro Kawasaki wrote:
> On Dec 08, 2021 / 17:18, David Sterba wrote:
> > On Wed, Dec 08, 2021 at 12:35:46AM +0900, Naohiro Aota wrote:
> > > There are several reports of hung_task on btrfs recently.
> > > 
> > > - https://github.com/naota/linux/issues/59
> > > - https://lore.kernel.org/linux-btrfs/CAJCQCtR=jztS3P34U_iUNoBodExHcud44OQ8oe4Jn3TK=1yFNw@mail.gmail.com/T/
> 
> (snip)
> 
> > > While we are debugging this issue, we found some faulty behaviors on
> > > the zoned extent allocator. It is not the root cause of the hung as we
> > > see a similar report also on a regular btrfs. But, it looks like that
> > > early -ENOSPC is, at least, making the hung to happen often.
> > > 
> > > So, this series fixes the faulty behaviors of the zoned extent
> > > allocator.
> > > 
> > > Patch 1 fixes a case when allocation fails in a dedicated block group.
> > > 
> > > Patches 2 and 3 fix the chunk allocation condition for zoned
> > > allocator, so that it won't block a possible chunk allocation.
> > > 
> > > Naohiro Aota (3):
> > >   btrfs: zoned: unset dedicated block group on allocation failure
> > >   btrfs: add extent allocator hook to decide to allocate chunk or not
> > >   btrfs: zoned: fix chunk allocation condition for zoned allocator
> > 
> > All seem to be relevant for 5.16-rc so I'll add them to misc-next now to
> > give it some testing, pull request next week. Thanks.
> 
> Hello David, thanks for your maintainer-ship always.
> 
> When I run my test set for zoned btrfs configuration, I keep on observing the
> issue that Naohiro addressed with the three patches. The patches are not yet
> merged to 5.16-rc7. Can I expect they get merged to rc8?

Sorry, I did not get to sending the pull request due to holidays. The
timing of 5.16 release next week is too close, I'll tag the patches for
stable so they'll get to 5.16 later.
