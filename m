Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9014DFCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 18:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgA3RUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 12:20:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:59546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgA3RUM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 12:20:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5DBA3B12A;
        Thu, 30 Jan 2020 17:20:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04659DA84C; Thu, 30 Jan 2020 18:19:50 +0100 (CET)
Date:   Thu, 30 Jan 2020 18:19:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Message-ID: <20200130171950.GZ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <112911984.cFFYNXyRg4@merkaba>
 <0102016ff2e7e3ad-6b776470-32f1-4b3d-9063-d3c96921df89-000000@eu-west-1.amazonses.com>
 <2049829.BAvHWrS4Fr@merkaba>
 <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 29, 2020 at 03:55:06PM -0700, Chris Murphy wrote:
> On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald <martin@lichtvoll.de> wrote:
> >
> > So if its just a cosmetic issue then I can wait for the patch to land in
> > linux-stable. Or does it still need testing?
> 
> I'm not seeing it in linux-next. A reasonable short term work around
> is mount option 'metadata_ratio=1' and that's what needs more testing,
> because it seems decently likely mortal users will need an easy work
> around until a fix gets backported to stable. And that's gonna be a
> while, me thinks.

We're looking into some fix that could be backported, as it affects a
long-term kernel (5.4).

The fix
https://lore.kernel.org/linux-btrfs/20200115034128.32889-1-wqu@suse.com/
IMHO works by accident and is not good even as a workaround, only papers
over the problem in some cases. The size of metadata over-reservation
(caused by a change in the logic that estimates the 'over-' part) adds
up to the global block reserve (that's permanent and as last resort
reserve for deletion).

In other words "we're making this larger by number A, so let's subtract
some number B". The fix is to use A.

> Is that mount option sufficient? Or does it take a filtered balance?
> What's the most minimal balance needed? I'm hoping -dlimit=1
> 
> I can't figure out a way to trigger this though, otherwise I'd be
> doing more testing.

I haven't checked but I think the suggested workarounds affect statfs as
a side effect. Also as the reservations are temporary, the numbers
change again after a sync.
