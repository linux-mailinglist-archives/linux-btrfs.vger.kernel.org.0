Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF23546DAAA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhLHSFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 13:05:13 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:44200 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234813AbhLHSFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Dec 2021 13:05:13 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 6807FC8926; Wed,  8 Dec 2021 13:01:40 -0500 (EST)
Date:   Wed, 8 Dec 2021 13:01:40 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Rory Campbell-Lange <rory@campbell-lange.net>
Cc:     Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org
Subject: Re: trouble replacing second disk from pair
Message-ID: <20211208180140.GN17148@hungrycats.org>
References: <YbCnrqxHJxYPATj9@campbell-lange.net>
 <20211208180955.170c6138@nvm>
 <YbDpr5mlHhGhHGwd@campbell-lange.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbDpr5mlHhGhHGwd@campbell-lange.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 08, 2021 at 05:21:51PM +0000, Rory Campbell-Lange wrote:
> On 08/12/21, Roman Mamedov (rm@romanrm.net) wrote:
> > On Wed, 8 Dec 2021 12:40:14 +0000
> > Rory Campbell-Lange <rory@campbell-lange.net> wrote:
> > 
> > > We're trying to upgrade the disks in a btrfs pair, and I have successfully replaced one of them using btrfs replace. I presently have 
> > > 
> > > Label: 'btrfs-bkp'  uuid: da90602a-b98e-4f0b-959a-ce431ac0cdfa
> > > 	Total devices 2 FS bytes used 700.29GiB
> > > 	devid    2 size 2.73TiB used 1.73TiB path /dev/mapper/cdisk4
> > > 	devid    3 size 2.73TiB used 1.75TiB path /dev/mapper/cdisk2
> > > 
> > > I'd like to get rid of cdisk2 and replace it with a new disk.
> > > 
> > > However I'm unable to mount cdisk4 (the new disk) in degraded mode to allow me to similarly replace cdisk2 as I previously did for cdisk3. Is this because some of the data in only on cdisk2? If so I'd be grateful to 
> > > know how to ensure the two disks have the same data and to allow cdisk2 to be replaced.
> > 
> > Looks like you need to ensure everything is RAID1 first:

You definitely need these two:

> >   btrfs balance start -dconvert=raid1,soft /bkp
> >   btrfs balance start -mconvert=raid1,soft /bkp

but not this one:

> >   btrfs balance start -sconvert=raid1,soft /bkp
> > 
> > It might warn you about operating on system chunks, but I believe this still
> > needs to be done. 
> 
> I wasn't able to run system chunks (-s) on btrfs 4.20.1-2 (debian) without
> forcing it:
> 
>     ERROR: Refusing to explicitly operate on system chunks.
>     Pass --force if you really want to do that.

-m implies -s.  In normal use, there is never a reason to have different
profiles for metadata and system, so balance refuses to do it.

-s is useful to set up some scenarios for developer testing (though even
that could be achieved with -mconvert=...,vrange=... without needing a
special option).

The manual could be clearer on this.

> Happily everything worked fine after running the data and metadata balances.
> 
> Thanks very much indeed for the advice.
> 
> Rory
