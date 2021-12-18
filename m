Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87010479E07
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Dec 2021 23:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhLRWsn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 Dec 2021 17:48:43 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:41018 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhLRWsm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Dec 2021 17:48:42 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id F2E58100739; Sat, 18 Dec 2021 17:48:41 -0500 (EST)
Date:   Sat, 18 Dec 2021 17:48:41 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>
Subject: Re: [PATCH 4/4] btrfs: add allocator_hint mode
Message-ID: <Yb5lSevjq3eURuYB@hungrycats.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
 <0fbfde93-3a00-7f20-8891-dd0fa798676e@knorrie.org>
 <5767702c-665f-d1a1-ea65-12eb1db96c51@libero.it>
 <YbzoA6n8D7jT7y/F@hungrycats.org>
 <5afe9f17-d171-c4e5-84f0-24f9a7fa250f@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <5afe9f17-d171-c4e5-84f0-24f9a7fa250f@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 18, 2021 at 10:07:18AM +0100, Goffredo Baroncelli wrote:
> On 12/17/21 20:41, Zygo Blaxell wrote:
> > On Fri, Dec 17, 2021 at 07:28:28PM +0100, Goffredo Baroncelli wrote:
> > > On 12/17/21 16:58, Hans van Kranenburg wrote:
> [...]
> > > -----------------------------
> > > The chunk allocation policy is modified as follow.
> > > 
> > > Each disk may have one of the following tags:
> > > - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> > > - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> > > - BTRFS_DEV_ALLOCATION_DATA_ONLY
> > > - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> > 
> > Is it too late to rename these?  The order of the words is inconsistent
> > and the English usage is a bit odd.
> > 
> > I'd much rather have:
> > 
> > > - BTRFS_DEV_ALLOCATION_PREFER_METADATA
> > > - BTRFS_DEV_ALLOCATION_ONLY_METADATA
> > > - BTRFS_DEV_ALLOCATION_ONLY_DATA
> > > - BTRFS_DEV_ALLOCATION_PREFER_DATA (default)
> > 
> > English speakers would say "[I/we/you] prefer X" or "X [is] preferred".
> > 
> > or
> > 
> > > - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> > > - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> > > - BTRFS_DEV_ALLOCATION_DATA_ONLY
> > > - BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)
> > 
> > I keep typing "data_preferred" and "only_data" when it's really
> > "preferred_data" and "data_only" because they're not consistent.
> > 
> 
> Sorry but it is unclear to me the last sentence :-)
> 
> Anyway I prefer
> BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> BTRFS_DEV_ALLOCATION_METADATA_ONLY
> [...]
> 
> Because it seems to me more consistent

Sounds good.

> > There is a use case for a mix of _PREFERRED and _ONLY devices:  a system
> > with NVMe, SSD, and HDD might want to have the SSD use DATA_PREFERRED or
> > METADATA_PREFERRED while the NVMe and HDD use METADATA_ONLY and DATA_ONLY
> > respectively.  But this use case is not a very good match for what the
> > implementation does--we'd want to separate device selection ("can I use
> > this device for metadata, ever?") from ordering ("which devices should
> > I use for metadata first?").
> > 
> > To keep things simple I'd say that use case is out of scope, and recommend
> > not mixing _PREFERRED and _ONLY in the same filesystem.  Either explicitly
> > allocate everything with _ONLY, or mark every device _PREFERRED one way
> > or the other, but don't use both _ONLY and _PREFERRED at the same time
> > unless you really know what you're doing.
> 
> In what METADATA_ONLY + DATA_PREFERRED would be more dangerous than
> METADATA_ONLY + DATA_ONLY ?

If capacity is our first priority, we use METADATA_PREFERRED
and DATA_PREFERRED (everything can be allocated everywhere, we try
the highest performance but fall back).

If performance is our first priority, we use METADATA_ONLY and DATA_ONLY
(so we never have to balance which would reduce performance) or
METADATA_PREFERRED and DATA_ONLY (so we have more capacity, but get
lower performance because we must balance data in some cases, but not
as low as any combination of options with DATA_PREFERRED).

If we have a complicated setup with 3 or more drives we might use 3 or
4 options at once to create multiple performance and capacity tiers.
But never exactly those two options.

What is METADATA_ONLY + DATA_PREFERRED for?

METADATA_ONLY + DATA_PREFERRED allows metadata to be allocated on data
drives, causing a performance crash.  It doesn't remove the need for
data balances since metadata and data can compete for space on the
DATA_PREFERRED devices.  It reduces data capacity (no data on the
METADATA_ONLY device) but doesn't guarantee a performance benefit
(metadata is allowed on the DATA_PREFERRED device).  Of all the
combinations of options, why would a user choose this one?

> If fact there I see two mains differents use cases:
> - I want to put my metadata on a SSD for performance reasoning:
> 	METADATA_PREFERRED + DATA_PREFERRED
>    as the most conservative approach

If you're using METADATA_PREFERRED, your first priority can only be
capacity, as performance will fail when some of the disks fill up.

We can't prioritize performance and capacity at the same time (at least
not with this code).  The user must choose which is most important
in cases when both are not available.

I see now why you keep missing this use case--it is because you are
thinking that PREFERRED is a valid option for performance use cases,
and therefore serves a superset of ONLY use cases.  ONLY and PREFERRED
serve use cases with opposite requirements, so one cannot be used to
serve the needs of the other.

PREFERRED is for capacity use cases, not for performance use cases.
PREFERRED only improves performance when over 96%(*) of the metadata
accesses hit the SSD; otherwise, the 4% of metadata on spinning devices
will be so slow that it will dominate the metadata access time.  When it
is forced to make a decision, PREFERRED will choose capacity, and drop
performance to pre-allocation-preference levels very quickly.  If the
user can tolerate the worst-case performance, then PREFERRED can provide
average performance above the worst case, but below the best case.
Only worst-case performance is guaranteed (within the limits of this
patch and the current btrfs allocators).

ONLY is for performance, not capacity (though it can also be used for one
of its side-effects on metadata allocation).  ONLY will not sacrifice
performance because one of the disks filled up.  ONLY will give us
ENOSPC immediately to tell us that we have no more space available with
acceptable performance.  ONLY guarantees best-case performance all the
time, since it doesn't allow any other case to arise.

(*) 24:1 is the raw ratio of access time between HDD data and NVMe
drives, but btrfs typically does 2-4x as many metadata iops as data iops,
which makes the effect on performance even worse when metadata leaks
onto HDD.  Also the most recently allocated block groups are most active,
which weights the HDD overflow even more in the average access time.
We typically get "node timeout" alarms immediately after the first
metadata block group on a big filesystem is misallocated on a spinning
disk, which is an effective ratio of 250:1 or 99.6%.  As a result,
we have zero tolerance for metadata on HDD.

> - I want to protect the metadata BG space from exhaustion (assuming that
>   a "today standard" disk is far larger than the total BG metadata)
> 	METADATA_ONLY + X
>   is a valid approach

Even if today's disks are too small, you can always add more of them.
It might even improve performance to make a raid10 metadata array.

> [...]
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
