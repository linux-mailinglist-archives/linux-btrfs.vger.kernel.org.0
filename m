Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF14794F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 20:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbhLQTl5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 14:41:57 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:43234 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235528AbhLQTl5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 14:41:57 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id A7D75FC8B0; Fri, 17 Dec 2021 14:41:55 -0500 (EST)
Date:   Fri, 17 Dec 2021 14:41:55 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>
Subject: Re: [PATCH 4/4] btrfs: add allocator_hint mode
Message-ID: <YbzoA6n8D7jT7y/F@hungrycats.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
 <0fbfde93-3a00-7f20-8891-dd0fa798676e@knorrie.org>
 <5767702c-665f-d1a1-ea65-12eb1db96c51@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5767702c-665f-d1a1-ea65-12eb1db96c51@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 17, 2021 at 07:28:28PM +0100, Goffredo Baroncelli wrote:
> On 12/17/21 16:58, Hans van Kranenburg wrote:
> > Hi,
> > 
> > On 10/24/21 5:31 PM, Goffredo Baroncelli wrote:
> > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > 
> > > When this mode is enabled, the chunk allocation policy is modified as
> > > follow.
> > > 
> > > Each disk may have a different tag:
> > > - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> > > - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> > > - BTRFS_DEV_ALLOCATION_DATA_ONLY
> > > - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> > > 
> > > Where:
> > > - ALLOCATION_PREFERRED_X means that it is preferred to use this disk for
> > > the X chunk type (the other type may be allowed when the space is low)
> > > - ALLOCATION_X_ONLY means that it is used *only* for the X chunk type.
> > > This means also that it is a preferred choice.
> > > 
> > > Each time the allocator allocates a chunk of type X , first it takes the
> > > disks tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space
> > > is not enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY;
> > > if the space is not enough, it uses also the other disks, with the
> > > exception of the one marked as ALLOCATION_PREFERRED_Y, where Y the other
> > > type of chunk (i.e. not X).
> > 
> > I read this last paragraph for 5 times now, I think, but I still have no
> > idea what's going on here. Can you rephrase it? It's more complex than
> > the actual code below.
> > 
> > What the above text tells me is that if I start filling up my disks, it
> > will happily write DATA to METADATA_ONLY disks when the DATA ones are
> > full? And if the METADATA_ONLY disks are full with DATA also, it will
> > not write DATA into PREFERRED_METADATA disks.
> > 
> > I don't think that's what the code actually does. At least, I hope not.
> > 
> Thanks for reviewing it: my English is very bad :-(
> 
> Yes, I wrote ALLOCATION_METADATA_ONLY when I would write ALLOCATION_PREFERRED_Y.
> 
> Let to me to rewrite it as following:
> 
> -----------------------------
> The chunk allocation policy is modified as follow.
> 
> Each disk may have one of the following tags:
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)

Is it too late to rename these?  The order of the words is inconsistent
and the English usage is a bit odd.

I'd much rather have:

> - BTRFS_DEV_ALLOCATION_PREFER_METADATA
> - BTRFS_DEV_ALLOCATION_ONLY_METADATA
> - BTRFS_DEV_ALLOCATION_ONLY_DATA
> - BTRFS_DEV_ALLOCATION_PREFER_DATA (default)

English speakers would say "[I/we/you] prefer X" or "X [is] preferred".

or

> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)

I keep typing "data_preferred" and "only_data" when it's really
"preferred_data" and "data_only" because they're not consistent.

> During a *mixed data/metadata* chunk allocation, BTRFS works as
> usual.
> 
> During a *data* chunk allocation, the space are searched first in
> BTRFS_DEV_ALLOCATION_DATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_DATA
> tagged disks. If no space is found or the space found is not enough (eg.
> in raid5, only two disks are available), then also the disks tagged
> BTRFS_DEV_ALLOCATION_PREFERRED_METADATA are evaluated. If even in this
> case this the space is not sufficient, -ENOSPC is raised.
> A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
> for a data BG allocation.
> 
> During a *metadata* chunk allocation, the space are searched first in
> BTRFS_DEV_ALLOCATION_METADATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> tagged disks. If no space is found or the space found is not enough (eg.
> in raid5, only two disks are available), then also the disks tagged
> BTRFS_DEV_ALLOCATION_PREFERRED_DATA are considered. If even in this
> case this the space is not sufficient, -ENOSPC is raised.
> A disk tagged with BTRFS_DEV_ALLOCATION_DATA_ONLY is never considered
> for a metadata BG allocation.
> 
> By default the disks are tagged as BTRFS_DEV_ALLOCATION_PREFERRED_DATA,
> so the default behavior happens. If the user prefer to store the
> metadata in the faster disks (e.g. the SSD), he can tag these with
> BTRFS_DEV_ALLOCATION_PREFERRED_DATA: in this case the data BG go in the
> BTRFS_DEV_ALLOCATION_PREFERRED_DATA disks and the metadata BG in the
> others, until there is enough space. Only if one disks set is filled,
> the other is occupied.
> 
> WARNING: if the user tags a disk with BTRFS_DEV_ALLOCATION_DATA_ONLY,
> this means that this disk will never be used for allocating metadata
> increasing the likelihood of exhausting the metadata space.

This WARNING is not correct.  We use a combination of METADATA_ONLY and
DATA_ONLY preferences to exclude data allocations from metadata devices,
reducing the likelihood of exhausting the metadata space all the way
to zero.  We do have to provide correctly-sized metadata devices, but
SSDs come in powers-of-2 sizes, so we just bump up to the next power of
two or add another SSD to the filesystem every time a metadata device
goes over 50%.

Metadata-only devices completely eliminate our need to do other
workarounds like data balances to reclaim unallocated space for metadata.

_PREFERRED devices are the problematic case.  Since no space is
exclusively reserved for metadata, it means you have to do maintenance
data balances as the filesystem fills up because you will be constantly
getting data clogging up your metadata devices.

There is a use case for a mix of _PREFERRED and _ONLY devices:  a system
with NVMe, SSD, and HDD might want to have the SSD use DATA_PREFERRED or
METADATA_PREFERRED while the NVMe and HDD use METADATA_ONLY and DATA_ONLY
respectively.  But this use case is not a very good match for what the
implementation does--we'd want to separate device selection ("can I use
this device for metadata, ever?") from ordering ("which devices should
I use for metadata first?").

To keep things simple I'd say that use case is out of scope, and recommend
not mixing _PREFERRED and _ONLY in the same filesystem.  Either explicitly
allocate everything with _ONLY, or mark every device _PREFERRED one way
or the other, but don't use both _ONLY and _PREFERRED at the same time
unless you really know what you're doing.

> ---------------------------------
> 
> 
> 
> > > Where:
> > > - ALLOCATION_PREFERRED_X means that it is preferred to use this disk for
> > > the X chunk type (the other type may be allowed when the space is low)
> > > - ALLOCATION_X_ONLY means that it is used *only* for the X chunk type.
> > > This means also that it is a preferred choice.
> > > 
> > > Each time the allocator allocates a chunk of type X , first it takes the
> > > disks tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space
> > > is not enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY;
> > > if the space is not enough, it uses also the other disks, with the
> > > exception of the one marked as ALLOCATION_PREFERRED_Y, where Y the other
> > > type of chunk (i.e. not X).
> 
> > Hans
> > 
> > > Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> > > ---
> > >   fs/btrfs/volumes.c | 98 +++++++++++++++++++++++++++++++++++++++++++++-
> > >   fs/btrfs/volumes.h |  1 +
> > >   2 files changed, 98 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 8ac99771f43c..7ee9c6e7bd44 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -153,6 +153,20 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
> > >   	},
> > >   };
> > > +#define BTRFS_DEV_ALLOCATION_MASK ((1ULL << \
> > > +		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) - 1)
> > > +#define BTRFS_DEV_ALLOCATION_MASK_COUNT (1ULL << \
> > > +		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT)
> > > +
> > > +static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
> > > +	[BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
> > > +	[BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
> > > +	[BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 1,
> > > +	[BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 2,
> > > +	/* the other values are set to 0 */
> > > +};
> > > +
> > > +
> > >   const char *btrfs_bg_type_to_raid_name(u64 flags)
> > >   {
> > >   	const int index = btrfs_bg_flags_to_raid_index(flags);
> > > @@ -4997,13 +5011,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
> > >   }
> > >   /*
> > > - * sort the devices in descending order by max_avail, total_avail
> > > + * sort the devices in descending order by alloc_hint,
> > > + * max_avail, total_avail
> > >    */
> > >   static int btrfs_cmp_device_info(const void *a, const void *b)
> > >   {
> > >   	const struct btrfs_device_info *di_a = a;
> > >   	const struct btrfs_device_info *di_b = b;
> > > +	if (di_a->alloc_hint > di_b->alloc_hint)
> > > +		return -1;
> > > +	if (di_a->alloc_hint < di_b->alloc_hint)
> > > +		return 1;
> > >   	if (di_a->max_avail > di_b->max_avail)
> > >   		return -1;
> > >   	if (di_a->max_avail < di_b->max_avail)
> > > @@ -5166,6 +5185,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
> > >   	int ndevs = 0;
> > >   	u64 max_avail;
> > >   	u64 dev_offset;
> > > +	int hint;
> > > +	int i;
> > >   	/*
> > >   	 * in the first pass through the devices list, we gather information
> > > @@ -5218,16 +5239,91 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
> > >   		devices_info[ndevs].max_avail = max_avail;
> > >   		devices_info[ndevs].total_avail = total_avail;
> > >   		devices_info[ndevs].dev = device;
> > > +
> > > +		if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
> > > +		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) {
> > > +			/*
> > > +			 * if mixed bg set all the alloc_hint
> > > +			 * fields to the same value, so the sorting
> > > +			 * is not affected
> > > +			 */
> > > +			devices_info[ndevs].alloc_hint = 0;
> > > +		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
> > > +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> > > +
> > > +			/*
> > > +			 * skip BTRFS_DEV_METADATA_ONLY disks
> > > +			 */
> > > +			if (hint == BTRFS_DEV_ALLOCATION_METADATA_ONLY)
> > > +				continue;
> > > +			/*
> > > +			 * if a data chunk must be allocated,
> > > +			 * sort also by hint (data disk
> > > +			 * higher priority)
> > > +			 */
> > > +			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
> > > +		} else { /* BTRFS_BLOCK_GROUP_METADATA */
> > > +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> > > +
> > > +			/*
> > > +			 * skip BTRFS_DEV_DATA_ONLY disks
> > > +			 */
> > > +			if (hint == BTRFS_DEV_ALLOCATION_DATA_ONLY)
> > > +				continue;
> > > +			/*
> > > +			 * if a data chunk must be allocated,
> > > +			 * sort also by hint (metadata hint
> > > +			 * higher priority)
> > > +			 */
> > > +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
> > > +		}
> > > +
> > >   		++ndevs;
> > >   	}
> > >   	ctl->ndevs = ndevs;
> > > +	/*
> > > +	 * no devices available
> > > +	 */
> > > +	if (!ndevs)
> > > +		return 0;
> > > +
> > >   	/*
> > >   	 * now sort the devices by hole size / available space
> > >   	 */
> > >   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> > >   	     btrfs_cmp_device_info, NULL);
> > > +	/*
> > > +	 * select the minimum set of disks grouped by hint that
> > > +	 * can host the chunk
> > > +	 */
> > > +	ndevs = 0;
> > > +	while (ndevs < ctl->ndevs) {
> > > +		hint = devices_info[ndevs++].alloc_hint;
> > > +		while (ndevs < ctl->ndevs &&
> > > +		       devices_info[ndevs].alloc_hint == hint)
> > > +				ndevs++;
> > > +		if (ndevs >= ctl->devs_min)
> > > +			break;
> > > +	}
> > > +
> > > +	BUG_ON(ndevs > ctl->ndevs);
> > > +	ctl->ndevs = ndevs;
> > > +
> > > +	/*
> > > +	 * the next layers require the devices_info ordered by
> > > +	 * max_avail. If we are returing two (or more) different
> > > +	 * group of alloc_hint, this is not always true. So sort
> > > +	 * these gain.
> > > +	 */
> > > +
> > > +	for (i = 0 ; i < ndevs ; i++)
> > > +		devices_info[i].alloc_hint = 0;
> > > +
> > > +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> > > +	     btrfs_cmp_device_info, NULL);
> > > +
> > >   	return 0;
> > >   }
> > > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > > index b8250f29df6e..37eb37b533c5 100644
> > > --- a/fs/btrfs/volumes.h
> > > +++ b/fs/btrfs/volumes.h
> > > @@ -369,6 +369,7 @@ struct btrfs_device_info {
> > >   	u64 dev_offset;
> > >   	u64 max_avail;
> > >   	u64 total_avail;
> > > +	int alloc_hint;
> > >   };
> > >   struct btrfs_raid_attr {
> > > 
> > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
