Return-Path: <linux-btrfs+bounces-14179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D27FAC0352
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 06:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A891BA021F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 04:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4A415A85A;
	Thu, 22 May 2025 04:09:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E840A923
	for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747886960; cv=none; b=a9MJXX8GDfDEQzUAKtLdWN5desEhuP4rBe24X/JN/o4YYOH+sW82xITdQcZkriCNY1/6UdBJajjd+kRum55kOuP21CCCg04olwiL+xJx01+QOwsyplKVKSqjS1iiuVFceX6m1GcU/ncNY/uAI92lFJXLAdxPyjvvKCbxQb0MzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747886960; c=relaxed/simple;
	bh=L5eOZq5SfVn/sA1q4fUBeoUuVsB++KNwC7NrRaaozyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeKtTpyKiJ/b0ano63mFn3r7qOotgvGgBse/50b0Yb4eRa9iKPToVZ6K1fbP3p+EhUM4l4nmkVioqrQbLWQzizrJ3JgPCXaSqiU8SuDsGEN/QPh9KiZM/cV4zkoF69G4gAmN8tEGj18nqijsryPqNQXvj6/u6ruEB45J6HQnTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 39E6613C462C; Thu, 22 May 2025 00:07:45 -0400 (EDT)
Date: Thu, 22 May 2025 00:07:45 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
Message-ID: <aC6jEehifdWWq4Pq@hungrycats.org>
References: <cover.1747070147.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>

On Tue, May 13, 2025 at 02:07:06AM +0800, Anand Jain wrote:
> In host hardware, devices can have different speeds. Generally, faster
> devices come with lesser capacity while slower devices come with larger
> capacity. A typical configuration would expect that:
> 
>  - A filesystem's read/write performance is evenly distributed on average
>  across the entire filesystem. This is not achievable with the current
>  allocation method because chunks are allocated based only on device free
>  space.
> 
>  - Typically, faster devices are assigned to metadata chunk allocations
>  while slower devices are assigned to data chunk allocations.
> 
> Introducing Device Roles:
> 
>  Here I define 5 device roles in a specific order for metadata and in the
>  reverse order for data: metadata_only, metadata, none, data, data_only.
>  One or more devices may have the same role.
>
>  The metadata and data roles indicate preference but not exclusivity for
>  that role, whereas data_only and metadata_only are exclusive roles.

Using role-based names like these presents three problems:

1. **Stripe incompatibility** -- These roles imply a hierarchy that breaks
in some multi-device arrays. e.g. with 5 devices of equal size and mixed
roles ("data_only" vs "data"), it's impossible to form a 5-device-wide
data chunk.

2. **Poor extensibility** -- The role system doesn't scale when
introducing additional allocation types. Any new category (e.g. PPL or
journal) would require duplicating preference permutations like "data,
then journal, then metadata" vs "journal, then data, then metadata",
resulting in combinatorial explosion.

3. **Misleading terminology** -- The name "none" is used in a misleading
way.  That name should be reserved for the case that prohibits all new
chunk allocations--a critical use case for array reshaping. A clearer
term would be "default," but the scheme would be even clearer if all
the legacy role names were discarded.

I suggest replacing roles with a pair of orthogonal properties per device
for each allocation type:

* Per-type tier level -- A simple u8 tier number that expresses allocation
preference. Allocators attempt to satisfy allocation using devices at
the lowest available tier, expanding the set to higher tiers as needed
until the minimum number of devices is reached.

* Per-type enable bit -- Indicates whether the device allows allocations
of that type at all. This can be stored explicitly, or encoded using a
reserved tier value (e.g. 0xFF = disabled).

Encoding this way makes "0" a reasonable default value for each field.

Then you get all of the required combinations, e.g.

* metadata 0, data 0 - what btrfs does now, equal preference

* metadata 2, data 1 - metadata preferred, data allowed

* metadata 1, data 2 - data preferred, metadata allowed

* metadata 0, data 255 - metadata only, no data

* metadata 255, data 0 - data only, no metadata

* metadata 255, data 255 - no new chunk allocations

This model offers cleaner semantics and more robust scaling:

* It eliminates unintended allocation spillover. A device either allows
data/metadata, or it doesn't.
* It expresses preference via explicit tiering rather than role overlap.
* It generalizes easily to future allocation types without rewriting
role logic.

"Allow nothing" is an important case for reshaping arrays.  If you are
upgrading 4 out of 12 disks in a striped raid filesystem, you don't
want to rewrite all the data in the filesystem 4 times.  Instead, set
the devices you want to remove to "allow nothing", run a balance with a
`devid` filter targeting each device to evacuate the data, and then run
device delete on the 4 empty drives.

> Introducing Role-then-Space allocation method:
> 
>  Metadata allocation can happen on devices with the roles metadata_only,
>  metadata, none, and data in that order. If multiple devices share a role,
>  they are arranged based on device free space.
> 
>  Similarly, data allocation can happen on devices with the roles data_only,
>  data, none, and metadata in that order. If multiple devices share a role,
>  they are arranged based on device free space.
> 
> Finding device speed automatically:
> 
>  Measuring device read/write latency for the allocaiton is not good idea,
>  as the historical readings and may be misleading, as they could include
>  iostat data from periods with issues that have since been fixed. Testing
>  to determine relative latency and arranging in ascending order for metadata
>  and descending for data is possible, but is better handled by an external
>  tool that can still set device roles.
> 
> On-Disk Format changes:
> 
>  The following items are defined but are unused on-disk format:
> 
> 	btrfs_dev_item::
> 	 __le64 type; // unused
> 	 __le64 start_offset; // unused
> 	 __le32 dev_group; // unused
> 	 __u8 seek_speed; // unused
> 	 __u8 bandwidth; // unused
> 
>  The device roles is using the dev_item::type 8-bit field to store each
>  device's role.

In the other implementations of this idea, allocation roles are stored in
`dev_item::type`, a single `u8` field, for simplicity; however, it would
be better to store these roles in the filesystem tree--e.g. using a
`BTRFS_PERSISTENT_ITEM_KEY` with a dedicated objectid for allocation
roles, and offset values corresponding to device IDs. This would enable
versioning of the schema and flexible extension (e.g., to add migration
policies, size-based allocation preferences, or other enhancements).

Since btrfs loads the trees before allocation can occur, tree-based
role data will be available in time for allocation, and we don't need
to store roles in the superblocks.

A longer version of this with use cases and some discussion is available
here:

	https://github.com/kakra/linux/pull/36#issuecomment-2784251968

	https://github.com/kakra/linux/pull/36#issuecomment-2784434490

> Anand Jain (10):
>   btrfs: fix thresh scope in should_alloc_chunk()
>   btrfs: refactor should_alloc_chunk() arg type
>   btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
>   btrfs: introduce device allocation method
>   btrfs: sysfs: show device allocation method
>   btrfs: skip device sorting when only one device is present
>   btrfs: refactor chunk allocation device handling to use list_head
>   btrfs: introduce explicit device roles for block groups
>   btrfs: introduce ROLE_THEN_SPACE device allocation method
>   btrfs: pass device roles through device add ioctl
> 
>  fs/btrfs/block-group.c |  11 +-
>  fs/btrfs/ioctl.c       |  12 +-
>  fs/btrfs/sysfs.c       | 130 ++++++++++++++++++++--
>  fs/btrfs/volumes.c     | 242 +++++++++++++++++++++++++++++++++--------
>  fs/btrfs/volumes.h     |  35 +++++-
>  5 files changed, 366 insertions(+), 64 deletions(-)
> 
> -- 
> 2.49.0
> 
> 


