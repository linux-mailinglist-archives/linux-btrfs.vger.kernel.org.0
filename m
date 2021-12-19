Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322D4479ED6
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 03:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhLSCbB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Dec 2021 21:31:01 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:38146 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234244AbhLSCbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Dec 2021 21:31:00 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id B9401100E41; Sat, 18 Dec 2021 21:30:59 -0500 (EST)
Date:   Sat, 18 Dec 2021 21:30:59 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     kreijack@inwind.it, Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>
Subject: Re: [PATCH 4/4] btrfs: add allocator_hint mode
Message-ID: <Yb6ZY3BPtbXn44gX@hungrycats.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
 <0fbfde93-3a00-7f20-8891-dd0fa798676e@knorrie.org>
 <5767702c-665f-d1a1-ea65-12eb1db96c51@libero.it>
 <YbzoA6n8D7jT7y/F@hungrycats.org>
 <5afe9f17-d171-c4e5-84f0-24f9a7fa250f@libero.it>
 <Yb5lSevjq3eURuYB@hungrycats.org>
 <4e18eff2-fca1-bde2-b942-159f89569f0f@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e18eff2-fca1-bde2-b942-159f89569f0f@cobb.uk.net>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 19, 2021 at 12:03:32AM +0000, Graham Cobb wrote:
> On 18/12/2021 22:48, Zygo Blaxell wrote:
> > On Sat, Dec 18, 2021 at 10:07:18AM +0100, Goffredo Baroncelli wrote:
> >> On 12/17/21 20:41, Zygo Blaxell wrote:
> >>> On Fri, Dec 17, 2021 at 07:28:28PM +0100, Goffredo Baroncelli wrote:
> >>>> On 12/17/21 16:58, Hans van Kranenburg wrote:
> >> [...]
> >>>> -----------------------------
> >>>> The chunk allocation policy is modified as follow.
> >>>>
> >>>> Each disk may have one of the following tags:
> >>>> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> >>>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> >>>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> >>>> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> >>>
> >>> Is it too late to rename these?  The order of the words is inconsistent
> >>> and the English usage is a bit odd.
> >>>
> >>> I'd much rather have:
> >>>
> >>>> - BTRFS_DEV_ALLOCATION_PREFER_METADATA
> >>>> - BTRFS_DEV_ALLOCATION_ONLY_METADATA
> >>>> - BTRFS_DEV_ALLOCATION_ONLY_DATA
> >>>> - BTRFS_DEV_ALLOCATION_PREFER_DATA (default)
> >>>
> >>> English speakers would say "[I/we/you] prefer X" or "X [is] preferred".
> >>>
> >>> or
> >>>
> >>>> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> >>>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> >>>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> >>>> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)
> >>>
> >>> I keep typing "data_preferred" and "only_data" when it's really
> >>> "preferred_data" and "data_only" because they're not consistent.
> >>>
> >>
> >> Sorry but it is unclear to me the last sentence :-)
> >>
> >> Anyway I prefer
> >> BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> >> BTRFS_DEV_ALLOCATION_METADATA_ONLY
> >> [...]
> >>
> >> Because it seems to me more consistent
> > 
> > Sounds good.
> > 
> >>> There is a use case for a mix of _PREFERRED and _ONLY devices:  a system
> >>> with NVMe, SSD, and HDD might want to have the SSD use DATA_PREFERRED or
> >>> METADATA_PREFERRED while the NVMe and HDD use METADATA_ONLY and DATA_ONLY
> >>> respectively.  But this use case is not a very good match for what the
> >>> implementation does--we'd want to separate device selection ("can I use
> >>> this device for metadata, ever?") from ordering ("which devices should
> >>> I use for metadata first?").
> >>>
> >>> To keep things simple I'd say that use case is out of scope, and recommend
> >>> not mixing _PREFERRED and _ONLY in the same filesystem.  Either explicitly
> >>> allocate everything with _ONLY, or mark every device _PREFERRED one way
> >>> or the other, but don't use both _ONLY and _PREFERRED at the same time
> >>> unless you really know what you're doing.
> >>
> >> In what METADATA_ONLY + DATA_PREFERRED would be more dangerous than
> >> METADATA_ONLY + DATA_ONLY ?
> > 
> > If capacity is our first priority, we use METADATA_PREFERRED
> > and DATA_PREFERRED (everything can be allocated everywhere, we try
> > the highest performance but fall back).
> > 
> > If performance is our first priority, we use METADATA_ONLY and DATA_ONLY
> > (so we never have to balance which would reduce performance) or
> > METADATA_PREFERRED and DATA_ONLY (so we have more capacity, but get
> > lower performance because we must balance data in some cases, but not
> > as low as any combination of options with DATA_PREFERRED).
> 
> I think it would be a mistake to think that your performance and
> capacity use cases are the only ones others will care about.
> 
> Your analysis misses a third option for priority: resilience. I have a
> nearline backup server. It stores a lot of data but it is almost
> entirely write-only. My priority is to be able to get at most of the
> data quickly if I need it sometime - it isn't critical for any specific
> piece of data as I have additional, slower backups, but I want to be
> able to restore as much as possible from this server for speed and
> convenience. To keep as much nearline backup as possible, I keep data in
> SINGLE and metadata in RAID1. Fine - I can do that today.

We have a lot of servers built this way.  None with just two disks though.
Maybe that gives me a blind spot for the 2-disk corner cases...

> However, in normal use the main activity is btrfs receive of many mostly
> unchanged subvolumes every day. So, what I do today is have a large data
> disk and a second small disk for the RAID1 copy of the metadata. I want
> to keep data off that second disk. With this patch, I expect to set the
> metadata disk as METADATA_ONLY and the data disk as DATA_PREFERRED.

Thanks, that's exactly the missing use case I was looking for.

In this case, we are starting off by prioritizing performance over
capacity (otherwise we'd use METADATA_PREFERRED and DATA_PREFERRED),
so we would normally use METADATA_ONLY and DATA_ONLY.  If we had enough
disks for metadata, we'd be done and we'd stop there.

We can't use DATA_ONLY here, because we would then have only one disk
for raid1 metadata, and that doesn't work.  We could have DATA_ONLY
with dup metadata for best performance, but then we lose resilience
because SSD failure would wipe out the whole filesystem.  We can
add more data disks and then make some of them DATA_ONLY, but we'd
always need at least two devices to have one of the three allocation
preferences that allow metadata, or raid1 metadata won't work at all.
We could use the SSD for a block-layer writethrough cache instead,
but while the resiliency properties are similar (SSD is expendible, HDD
takes all the data with it when it fails), it's not completely identical:
it's prone to data evicting the metadata which makes it less useful,
and it's a separate chunk of code with exposure to more kernel bugs.
So every other option is worse than METADATA_ONLY and DATA_PREFERRED.

With the read_policy patches also applied, and allocation preferences
set to METADATA_ONLY and DATA_PREFERRED, we'd have maximum performance
on reads (they would exclusively use SSD) and minimum performance on
writes (they would all necessarily use HDD) and get the best possible
result given the combination of performance, resilience, and available
device constraints.

> Of course I would *also* like to be able to get btrfs to mostly read the
> RAID1 copy from the fast metadata disk for reading metadata. This patch
> does not address that, but I hope one day there will be a separate
> option for that.

That's the read_policy patch set.  I've been running that for a while too,
but I dropped it when I started having problems with kernels after 5.10.
I'm still having problems without the read_policy patch set, so it was
probably fine?

> I think the proposed settings are a useful step and will allow some
> experimentation and learning with different scenarios. They certainly
> aren't the answer to all allocation problems but I would like to see
> them available as soon as possible,
> 
> Graham
> 
