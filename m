Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EEF2FD588
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 17:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbhATQW5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 20 Jan 2021 11:22:57 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47368 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389590AbhATQV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 11:21:58 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EEDC794A289; Wed, 20 Jan 2021 11:20:59 -0500 (EST)
Date:   Wed, 20 Jan 2021 11:20:59 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210120162059.GN31381@hungrycats.org>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 20, 2021 at 11:02:41AM -0500, Josef Bacik wrote:
> On 1/17/21 1:54 PM, Goffredo Baroncelli wrote:
> > 
> > Hi all,
> > 
> > This is an RFC; I wrote this patch because I find the idea interesting
> > even though it adds more complication to the chunk allocator.
> > 
> > The basic idea is to store the metadata chunk in the fasters disks.
> > The fasters disk are marked by the "preferred_metadata" flag.
> > 
> > BTRFS when allocate a new metadata/system chunk, selects the
> > "preferred_metadata" disks, otherwise it selectes the non
> > "preferred_metadata" disks. The intial patch allowed to use the other
> > kind of disk in case a set is full.
> > 
> > This patches set is based on v5.11-rc2.
> > 
> > For now, the only user of this patch that I am aware is Zygo.
> > However he asked to further constraint the allocation: i.e. avoid to
> > allocated metadata on a not "preferred_metadata"
> > disk. So I extended the patch adding 4 modes to operate.
> > 
> > This is enabled passing the option "preferred_metadata=<mode>" at
> > mount time.
> > 
> 
> I'll echo Zygo's hatred for mount options.  The more complicated policy
> decisions belong in properties and sysfs knobs, not mount options.

Well, I hated it for two distinct reasons.  Only one of those was the
mount option.

The feature is really a per-_device_ policy:  whether we put data or
metadata or both (*) on the device, and in what order we fill devices
with each.

There's nothing filesystem-wide about the feature, other than we might
want to ensure there are enough devices to do allocations with our
raid profiles (e.g. if there are 2 data-only disks and raid1 data,
don't allow one of those disks to become metadata-only).

I had considered a couple of other ideas but dropped them:

	- keep a filesystem-wide "off" feature.  If that makes sense at
	all, it would be as a mount option, e.g. if you had painted your
	filesystem into a corner with data-only devices and didn't have
	enough metadata space to do a device property set to fix it.
	I dropped the idea because we don't have an existing feature
	for any other scenario where that happens (e.g. adding one disk
	to a full raid1 array) and it should be possible to recover
	immediately after the next mount using reserved metadata space.

	- for each device, specify a priority for metadata and data
	separately, with the lowest priority meaning "never use this
	device for that kind of chunk".  That is a more general form
	of the 4-device-type form (metadata only, metadata preferred,
	data preferred, data only), but all of the additional device
	orders that arbitrary sorting order permits will tend to make
	data and metadata fight with each other, to the point that the
	ordering isn't useful.  On the other hand, maybe this idea does
	have a future as a kind of advanced "move the data where I tell
	you to" balancing tool for complicated RAID array reshapes.

> And then for the properties themselves, presumably we'll want to add other
> FS wide properties in the future.  I'm not against adding new actual keys
> and items to the tree itself, but is there a way we could use our existing
> property infrastructure that we use for compression, and simply store the
> xattrs in the tree root?  It looks like we're just toggling a policy
> decision, and we don't actually need the other properties in the item you've
> created, so why not just a btrfs.preferred_metadata property with the value
> stored in it, dropped into the tree_root so it can be read on mount?
> Thanks,
> 
> Josef

(*) I suppose logically there could be a "neither" option, but I'm not
sure what it would be for.
