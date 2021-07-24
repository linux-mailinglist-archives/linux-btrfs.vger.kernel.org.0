Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A163D4A1C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 23:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGXUuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 16:50:46 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43366 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 16:50:46 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E2096AFE435; Sat, 24 Jul 2021 17:31:16 -0400 (EDT)
Date:   Sat, 24 Jul 2021 17:31:16 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <20210724213116.GE10170@hungrycats.org>
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 23, 2021 at 06:51:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/23 上午3:29, David Sterba wrote:
> > The data on raid0 and raid10 are supposed to be spread over multiple
> > devices, so the minimum constraints are set to 2 and 4 respectively.
> > This is an artificial limit and there's some interest to remove it.
> 
> This could be a better way to solve the SINGLE chunk created by degraded
> mount.
> 
> > 
> > Change this to allow raid0 on one device and raid10 on two devices. This
> > works as expected eg. when converting or removing devices.
> > 
> > The only difference is when raid0 on two devices gets one device
> > removed. Unpatched would silently create a single profile, while newly
> > it would be raid0.
> > 
> > The motivation is to allow to preserve the profile type as long as it
> > possible for some intermediate state (device removal, conversion).
> > 
> > Unpatched kernel will mount and use the degenerate profiles just fine
> > but won't allow any operation that would not satisfy the stricter device
> > number constraints, eg. not allowing to go from 3 to 2 devices for
> > raid10 or various profile conversions.
> 
> My initial thought is, tree-checker will report errors like crazy, but
> no, the check for RAID1 only cares substripe, while for RAID0 no number
> of devices check.
> 
> So a good surprise here.
> 
> 
> Another thing is about the single device RAID0 or 2 devices RAID10 is
> the stripe splitting.
> 
> Single device RAID0 is just SINGLE, while 2 devices RAID10 is just RAID1.
> Thus they need no stripe splitting at all.
> 
> But we will still do the stripe calculation, thus it could slightly
> reduce the performance.
> Not a big deal though.

It might have a more significant impact on a SSD cache below btrfs.
lvmcache (dm-cache) uses the IO request size to decide whether to bypass
the cache or not.

Scrubbing a striped-profile array through lvmcache is a disaster.  All the
IOs are carved up into chunks that are smaller than the cache bypass
threshold, so lvmcache tries to cache all the scrub IO and will flood
the SSD with enough writes to burn out a cheap SSD in a month or two.
Scrubbing raid1 or single uses bigger IO requests, so lvmcache bypasses
the SSD cache and there's no problem (other than incomplete scrub coverage
because of the caching, but that's a whole separate issue).

The kernel allows this already and it's a reasonably well-known gotcha (I
didn't discover it myself, I heard/read it somewhere else and confirmed
it) so there is no urgency, but some day either lvmcache should get
smarter about merging adjacent short reads, or btrfs should be smarter
about switching to "real" single profile behavior when it sees a striped
profile with 1 stripe.


> > Example output:
> > 
> >    # btrfs fi us -T .
> >    Overall:
> >        Device size:                  10.00GiB
> >        Device allocated:              1.01GiB
> >        Device unallocated:            8.99GiB
> >        Device missing:                  0.00B
> >        Used:                        200.61MiB
> >        Free (estimated):              9.79GiB      (min: 9.79GiB)
> >        Free (statfs, df):             9.79GiB
> >        Data ratio:                       1.00
> >        Metadata ratio:                   1.00
> >        Global reserve:                3.25MiB      (used: 0.00B)
> >        Multiple profiles:                  no
> > 
> > 		Data      Metadata  System
> >    Id Path       RAID0     single    single   Unallocated
> >    -- ---------- --------- --------- -------- -----------
> >     1 /dev/sda10   1.00GiB   8.00MiB  1.00MiB     8.99GiB
> >    -- ---------- --------- --------- -------- -----------
> >       Total        1.00GiB   8.00MiB  1.00MiB     8.99GiB
> >       Used       200.25MiB 352.00KiB 16.00KiB
> > 
> >    # btrfs dev us .
> >    /dev/sda10, ID: 1
> >       Device size:            10.00GiB
> >       Device slack:              0.00B
> >       Data,RAID0/1:            1.00GiB
> 
> Can we slightly enhance the output?
> RAID0/1 really looks like a new profile now, even the "1" really means
> the number of device.
> 
> >       Metadata,single:         8.00MiB
> >       System,single:           1.00MiB
> >       Unallocated:             8.99GiB
> > 
> > Note "Data,RAID0/1", with btrfs-progs 5.13+ the number of devices per
> > profile is printed.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> > ---
> >   fs/btrfs/volumes.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 86846d6e58d0..ad943357072b 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -38,7 +38,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
> >   		.sub_stripes	= 2,
> >   		.dev_stripes	= 1,
> >   		.devs_max	= 0,	/* 0 == as many as possible */
> > -		.devs_min	= 4,
> > +		.devs_min	= 2,
> >   		.tolerated_failures = 1,
> >   		.devs_increment	= 2,
> >   		.ncopies	= 2,
> > @@ -103,7 +103,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
> >   		.sub_stripes	= 1,
> >   		.dev_stripes	= 1,
> >   		.devs_max	= 0,
> > -		.devs_min	= 2,
> > +		.devs_min	= 1,
> >   		.tolerated_failures = 0,
> >   		.devs_increment	= 1,
> >   		.ncopies	= 1,
> > 
