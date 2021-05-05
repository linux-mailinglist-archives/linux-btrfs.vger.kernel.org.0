Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E098B373DF5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhEEOwz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 10:52:55 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36624 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhEEOwy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 May 2021 10:52:54 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9B97FA46032; Wed,  5 May 2021 10:51:56 -0400 (EDT)
Date:   Wed, 5 May 2021 10:51:56 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     remi@georgianit.com
Cc:     Abdulla Bubshait <darkstego@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: Array extremely unbalanced after convert to Raid5
Message-ID: <20210505145156.GC32440@hungrycats.org>
References: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
 <5b563f2f-9057-44cc-8ec8-5367548aef6f@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b563f2f-9057-44cc-8ec8-5367548aef6f@www.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 05, 2021 at 09:58:03AM -0400, remi@georgianit.com wrote:
> 
> 
> On Wed, May 5, 2021, at 9:41 AM, Abdulla Bubshait wrote:
> > I ran a balance convert of my data single setup to raid 5. Once
> > complete the setup is extremely unbalanced and doesn't even make sense
> > as a raid 5. I tried to run a balance with dlimit of 1000, but it just
> > seems to make things worse.
> 
> > 
> > Unallocated:
> >   /dev/sdd       14.12TiB
> >   /dev/sdc      404.99GiB
> >   /dev/sdf        1.00MiB
> >   /dev/sde        1.00MiB
> > 
> > 
> 
> 
> Sorry, I don't have a solution for you, but I want to point out that
> the situation is far more critical than you seem to have realized.. this
> filesystem is now completely wedged, and I would suggest adding another
> device, or replacing either /dev/sdf  or /dev/sde with something
> larger,, (though, if those are real disks, I see that might be a
> challenge.)
> 
> Your metadata is Raid1C3, (meaning 3 copies,), but you only have 2 disks
> with free space.  And thanks to the recent balancing, there is very
> little free space in the already allocated metadata,, so effectively,
> the filesystem can no longer write any new metadata and will very
> quickly hit out of space errors.

The situation isn't that dire.  Balancing one data chunk off of either
/dev/sdf or /dev/sde will resolve the issue.
