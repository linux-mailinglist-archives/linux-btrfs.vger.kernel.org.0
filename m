Return-Path: <linux-btrfs+bounces-14836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5776AE26DB
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jun 2025 03:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315364A2700
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jun 2025 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B8B35977;
	Sat, 21 Jun 2025 01:23:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94991BC2A
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Jun 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750469019; cv=none; b=fb7WS27u0SzV+pKMX2cKYQCyWm5O+4ycNXGVYEebPI5HV37V/h71Hwzu9hL02tRDjTq7U8Mqo4Q2lvGApN2GNOECPSMg9zkYk9z54UQAa+SfsTerO0lEdbhhbaV/tdxXEycxKS0pEsVheoTu7wX9bRByAbHSUcLK58o3/iEatAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750469019; c=relaxed/simple;
	bh=I1D+CXT4KVf8lf8xiVqc6macu7VabVy2Zcoty9wY2NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhLfDLpfLIUW9zvzMEy/cs/LdsH3Yr/PJI9ibsIbDjNE/Bx/smvhOO/ZupZyFA0OYRRvp4iBqkrm8aW9PN7eP3i0cd0WFmLMH1uhomq0qZ4kcv4Al7quDjy96k136+TRFOcevm/LFUYC9qJPZ9RcfLCEi6v0+x9eDv4L3ka40sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 7935D1444897; Fri, 20 Jun 2025 21:11:36 -0400 (EDT)
Date: Fri, 20 Jun 2025 21:11:25 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
Message-ID: <aFYGvY23MbhIS1Bm@hungrycats.org>
References: <cover.1747070147.git.anand.jain@oracle.com>
 <aC6jEehifdWWq4Pq@hungrycats.org>
 <5210224a-68ea-42e5-ac67-4b7aa44e761d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5210224a-68ea-42e5-ac67-4b7aa44e761d@oracle.com>

On Mon, Jun 02, 2025 at 12:26:41PM +0800, Anand Jain wrote:
> 
> Thanks for the detailed proposal, more below..
> 
> On 22/5/25 12:07, Zygo Blaxell wrote:
> > On Tue, May 13, 2025 at 02:07:06AM +0800, Anand Jain wrote:
> > > In host hardware, devices can have different speeds. Generally, faster
> > > devices come with lesser capacity while slower devices come with larger
> > > capacity. [...]
> > Using role-based names like these presents three problems:
> > 
> > 1. **Stripe incompatibility** -- These roles imply a hierarchy that breaks
> > in some multi-device arrays. e.g. with 5 devices of equal size and mixed
> > roles ("data_only" vs "data"), it's impossible to form a 5-device-wide
> > data chunk.
> > 
> Thanks for the feedback.
> 
> Details about the current proposal are here:
> 
> [1] https://asj.github.io/chunk-alloc-enhancement.html
>
> Some allocation modes aren't compatible with certain block group
> profiles. We'll need to check this at mkfs time and fail the command if
> the number of devices is below the minimum required.
> 
> The role hierarchy (exclusive-> none-> non-exclusive) only applies when
> there are more devices than required for a given block group profile and
> the allocator has a choice of which devices to use.

I may be reading more into this than you intended, but this can lead
to some unpleasant surprises.  To ensure predictable behavior, the
allocator should _always_ select devices based on configured priority.
If no devices meet the configured requirements, the chunk allocator
should return ENOSPC immediately, rather than silently falling back to
something not explicitly permitted.

We should never allocate metadata on slower devices simply because faster
ones are full.  That must be _explicitly_ allowed by the configuration.

> The use case for non-exclusive roles with striped profiles isn't very
> practical, but the design allows for future extensions if needed.
> 
> > 2. **Poor extensibility** -- The role system doesn't scale when
> > introducing additional allocation types. Any new category (e.g. PPL or
> > journal) would require duplicating preference permutations like "data,
> > then journal, then metadata" vs "journal, then data, then metadata",
> > resulting in combinatorial explosion.
> 
> Special devices like journal or write-cache are different; they are
> separate from the data and metadata storage devices. We will still hit
> ENOSPC even if the journal device is empty.
> 
> That said, it is still possible to specify write-cache as a role. For
> example:
> 
> 	mkfs.btrfs /dev/sdx:write-cache ...
> 
> I'm not sure I understood what you meant by "not extensible"?

There are some interesting proposals based on the allocation preferences
patches from 2020.  We might want to hack up the extent allocator so that
extents <= 128K are sent to SSD, while larger extents are sent to HDD.
A maintenance process could run a defrag-like operation periodically
to relocate cold data to slow devices by combining small extents (which
prefer SSD) into large extents (which prefer HDD).

In that case, we'd need at least two preference levels for data block
groups, in addition to a separate preference level for metadata (i.e.
a total of 3 alloc_priority fields per device:  small_data, large_data,
and metadata).

> Also, allocation modes (for example, FREE_SPACE, ROLE, LINEAR,
> ROUND_ROBIN) are designed to be composable as needed.

In that case, why bother with ROLE, when PRIORITY (with one priority
value per role) can express a functional superset?

> If roles do not cover a specific use case, the existing alloc_priority
> (1 to 255) and alloc_mode can be extended to support new logic.
> 
> Note: LINEAR and ROUND_ROBIN are not implemented yet.
> 
> > 3. **Misleading terminology** -- The name "none" is used in a misleading
> > way.  That name should be reserved for the case that prohibits all new
> > chunk allocations--a critical use case for array reshaping. A clearer
> > term would be "default," but the scheme would be even clearer if all
> > the legacy role names were discarded.
> 
> Got it, I'll rename none to default.
> 
> "None" is internal to the kernel and means no particular role
> preference. It currently falls into the middle tier (41 to 80) of
> alloc_priority, but we could adjust that to something more meaningful if
> needed.

This "default" value was present in earlier versions of the allocation
preferences patch set from 2020.  It was killed because its semantics were
confusing--users had to read the doc to understand what it did, then asked
questions about why there are two options that are equivalent to "data
preferred, metadata allowed", but behave differently in a filesystem
because they have different numeric values in the device sort.

In other words, the problem is not just the name--it's the _concept_ of
"default" being a distinct value, as opposed to an alias for one of the
non-default values.  There's no way a device can have a "default" or
"other" role in the presence of any device with a non-default role--a
device that merely participates in allocation potentially modifies the
result of every allocation.

Instead, we picked "data preferred" (which is "role=data" in your
proposal) as the default.  This compromise achieves two key goals:

 * not putting metadata on slow drives when fast drives exist, and
 * not running out of metadata space, by allowing metadata allocation
   on data devices as a last resort.

That said, there could be a distinct on-disk encoding for "default"
or "unspecified", as long as it maps exactly to one of the explicit
choices at runtime, i.e. it must not have a distinct numeric value in the
ordering.  I think the point is moot, though, since there's no need to put
role on disk at all, and alloc_priority can simply default to zero.

> > I suggest replacing roles with a pair of orthogonal properties per device
> > for each allocation type:
> > 
> > * Per-type tier level -- A simple u8 tier number that expresses allocation
> > preference. Allocators attempt to satisfy allocation using devices at
> > the lowest available tier, expanding the set to higher tiers as needed
> > until the minimum number of devices is reached.
> 
> This is the same as alloc_priority stored in dev_item::type:8.

To clarify, I propose independent priorities for each allocation type on a
device.  For example, a device would maintain separate priority values for
data and metadata, and future extensions like write_cache, small_extent, etc.
(For the purpose of this discussion, system is part of metadata.)

struct btrfs_dev_item {
        ...
        union {
            __le64 type;              /* unused */
            struct {
                __le8 reserved[6];
                __le8 prio_metadata;  /* bits 8 - 15: metadata priority */
                __le8 prio_data;      /* bits 0 - 07: data priority */
            };
        };
        __le32 dev_group;  /* FT device groups */
        ...
    };

These per-type priorities group devices into tiers for each type.
For different allocation types, devices may be arranged into different
groups.  Within a tier, devices can then be ordered or filtered--using
round-robin, linear placement, FT-domain, or other placement policies--to
satisfy the allocation requirements.

In other words, _devices_ shouldn't have roles--_allocations_ do.

While I'm here...I'm looking at the other alloc_mode bits.  Do we need
any of them?

 * FREE_SPACE: legacy.  Don't need a bit for this--it's the absense of
   all other bits.

 * ROLE: honor role bits.  Don't need this because we can do it better
   by making "role" an attribute of the allocation, and use priority for
   device selection by role.

 * PRIORITY: use raw alloc_priority.  Don't need this bit, because we'll
   always use priority.  The default is zero, and "all devices have
   priority zero" gives current legacy behavior.

 * FT_GROUP: use dev_group for fault domains.  Don't need this because
   it's equivalent to "every dev_group on the filesystem != 0".

The above eliminates all of the bits except:

 * LINEAR: sequential allocation.
 * ROUND-ROBIN: pick the next device.

How do those work if some devices have thee bits set and some are cleared?

It seems to me that it would be better to put LINEAR and ROUND-ROBIN in
a btrfs item, so there's only one item on disk, which describes how
allocations work on disks of the same priority.

> > * Per-type enable bit -- Indicates whether the device allows allocations
> > of that type at all. This can be stored explicitly, or encoded using a
> > reserved tier value (e.g. 0xFF = disabled).
> 
> The device type can refer to a special device (like write-cache) or a
> regular data/metadata device. Within a data/metadata device, the role,
> whether for data or metadata, can still be represented using the current
> *_only, *, or default/any roles. So this approach remains compatible.

This reflects different mental models.  Your approach treats a device's
role as _exclusive_:  if it holds block groups for one role, it cannot be
used for another.  A device can hold metadata but cannot hold write_cache.
As a result, we need special cases like "preferred data with metadata
allowed" because we can't have a single-device filesystem without at
least one mixed role.

In contrast, my model is _inclusive_:  each device can support any
permitted block group type, provided that it assigns a priority to
that type.  Per-type priorities then partition devices into tiers,
letting a device handle data, metadata, write_cache--or any combination
thereof--seamlessly, scaling to 2^N configurations as new roles emerge.

If the user wants exclusive device roles, like "journal only" or "write
cache only", then they can simply set the priorities so that only one
type of chunk is allowed on the device.

> > Encoding this way makes "0" a reasonable default value for each field.
> > 
> > Then you get all of the required combinations, e.g.
> > 
> 
> Added below the current proposal.
> 
> > * metadata 0, data 0 - what btrfs does now, equal preference
> 
>  role=< > no role | default
> 
> > * metadata 2, data 1 - metadata preferred, data allowed
> > 
>  role=metadata
> 
> > * metadata 1, data 2 - data preferred, metadata allowed
> 
>  role=data
> 
> > * metadata 0, data 255 - metadata only, no data
> 
>  role=metadata_only
> 
> > * metadata 255, data 0 - data only, no metadata
> 
>  role=data_only

Fair point--this example didn't show anything that can't be done with
pure role-based allocations.  Try this with 5 equal-size drives:

 * Device 1:  metadata preference 100, data preference 100
 * Device 2:  metadata preference 100, data preference 100
 * Device 3:  metadata preference 100, data preference 100
 * Device 4:  metadata preference 200, data preference 100
 * Device 5:  metadata preference 200, data preference 100

then put -draid5 -mraid1 on it.

When the sorting for data is "data_only, data, metadata, metadata_only",
and the sorting for metadata is the opposite, it's not possible to get
a 5-device-wide data chunk.

Even with the PRIORITY bit overriding the sort order, each device has only
one priority.  We can solve the above by setting the role for devices
1-3 to 'data_only' and 4-5 to 'data', but we can't solve this for 7
devices with 4 metadata drives when there's two distinct preferences
for the metadata devices.

There need to be two _distinct_ priority values on each device to make
this work.

> > * metadata 255, data 255 - no new chunk allocations
> 
>  Flag it read-only.

"Read only" is another misleading name.  Allocations and writes must
still be allowed in existing block groups on these devices.  We are only
preventing the allocation of new block groups.  "None" is a better name
for this, or "no_alloc" or even "no_new".

> [...]
> I actually started with the idea of using bitmap flags, since it's more
> straightforward. But I eventually leaned toward using an Allocation
> Priority list to allow for a manual priority order within roles or
> tiers, if needed in the future. That flexibility pushed me in that
> direction.

I went the other way:  from roles to bitmaps, then replaced the bitmaps
with role-specific priority levels to allow userspace full control over
device selection in chunk allocation.  We did this because the concept
of a device role with a single priority was too limiting in practice.

We also found that even with years of experience running with the patches
based on four roles, sysadmins still made errors trying to predict where
data would go.  The priority-driven system is much easier to understand:
data goes where it's allowed, metadata goes where it's allowed, and
when both are allowed, priority rules specify which devices are filled
first.  Devices can be reordered for allocation in a way similar to the
LINEAR mode you propose with priority alone.

Your proposal has some other interesting elements.  The linear and
round-robin modes would work well after sorting devices by FT group
and per-role priority.

I have seen a lot of users request it, but I'm not sure what round-robin
mode is intended to address in practice.  The most significant effect is
that it can cause the filesystem to reach ENOSPC earlier than necessary
if space is not distributed carefully, but users have requested it for
its perceived load-balancing properties.  To work properly, the
allocator needs to store some persistent state to remember the device
it last allocated on--without this, every umount/mount cycle would
reset the allocator, so it would either fill up a low-numbered devid all
the time, or it would behave the same way as legacy btrfs allocation.
This points to a btrfs item as a good place to store all the allocator
configuration and state information, so the allocator can remember where
it was in the round-robin sequence across mounts.

> You can find more details about the current Allocation Priority list
> here:
> 
> 	https://asj.github.io/chunk-alloc-enhancement.html

I note that there is no "read-only" variant at this URL.

> That said, we could store the mode in a separate btrfs-key and keep the
> manual priority in dev_item::type, which would give us both.
> But as always, we try to avoid new on-disk new keys unless absolute
> necessary.
> [...]
> dev_item::dev_type (u64) comes from the reserved field list, so there's
> no additional space overhead in using it. I considered whether using a
> btrfs_key for roles would offer any advantage over dev_item::dev_type,
> but I couldn't find a clear benefit.

Heh.  Back in 2020 I got different opinions on new items (using the
existing PERSISTENT_ITEM key, but claiming some of the objectid space).
One reviewer wanted to control it via xattrs on the root directory.

On the one hand, using items (or even xattrs) means that schema upgrades
and schema size are practically unlimited.  As long as there's some way
to recognize all the new keys as part of the same feature, we don't need
to burn precious superblock compat bits for each one--the filesystem
would support allocation enhancement or not, and if it did, the kernel
would look into the items to find versioning information.

On the other hand, if the sysadmin has to cope with the cognitive load
of parsing more than 64 bits of different interrelated configuration
settings to predict where the filesystem is going to put its data, the
design places too much burden on users, and risks becoming impractical
from the start.  So there is value in keeping the schema small enough
to fit it all in one u64 in btrfs_dev_item.

This detail of the implementation doesn't matter very much given the
scope proposed so far.  There is room for 7 allocation type priorities
in the u64, today we need only 2, and in 10 years we might use up
to 5 priorities if all proposals I'm aware of are implemented.

If we do run out of bits in a u64 some day, we can always create new
items then.

> Also, with alloc_priority + alloc_mode, we can support a manual device
> order with the same cost.

> Let me still consider what you proposed again to see if there’s any
> advantage to doing it that way.
> 
> Good discussion, thanks a lot.
> 
> -Anand

Thanks for reading this far!

> > > Anand Jain (10):
> > >    btrfs: fix thresh scope in should_alloc_chunk()
> > >    btrfs: refactor should_alloc_chunk() arg type
> > >    btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
> > >    btrfs: introduce device allocation method
> > >    btrfs: sysfs: show device allocation method
> > >    btrfs: skip device sorting when only one device is present
> > >    btrfs: refactor chunk allocation device handling to use list_head
> > >    btrfs: introduce explicit device roles for block groups
> > >    btrfs: introduce ROLE_THEN_SPACE device allocation method
> > >    btrfs: pass device roles through device add ioctl
> > > 
> > >   fs/btrfs/block-group.c |  11 +-
> > >   fs/btrfs/ioctl.c       |  12 +-
> > >   fs/btrfs/sysfs.c       | 130 ++++++++++++++++++++--
> > >   fs/btrfs/volumes.c     | 242 +++++++++++++++++++++++++++++++++--------
> > >   fs/btrfs/volumes.h     |  35 +++++-
> > >   5 files changed, 366 insertions(+), 64 deletions(-)
> > > 
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 
> 
> 

