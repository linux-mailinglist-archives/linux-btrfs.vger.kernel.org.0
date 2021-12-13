Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB524737E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 23:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhLMWtX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 17:49:23 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:45348 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240684AbhLMWtX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 17:49:23 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 8A82CDE6C5; Mon, 13 Dec 2021 17:49:22 -0500 (EST)
Date:   Mon, 13 Dec 2021 17:49:22 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <YbfN8gXHsZ6KZuil@hungrycats.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybe34gfrxl8O89PZ@localhost.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 04:15:14PM -0500, Josef Bacik wrote:
> On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
> > Gentle ping :-)
> > 
> > Are there anyone of the mains developer interested in supporting this patch ?
> > 
> > I am open to improve it if required.
> > 
> 
> Sorry I missed this go by.  I like the interface, we don't have a use for
> device->type yet, so this fits nicely.
> 
> I don't see the btrfs-progs patches in my inbox, and these don't apply, so
> you'll definitely need to refresh for a proper review, but looking at these
> patches they seem sane enough, and I like the interface.  I'd like to hear
> Zygo's opinion as well.

I've been running earlier versions with modifications since summer 2020,
and this version mostly unmodified (rebase changes only) since it was
posted.  It seems to work, even in corner cases like converting balances,
replacing drives, and running out of space.  The "running out of space"
experience is on btrfs is weird at the best of times, and these patches
add some more new special cases, but it doesn't behave in ways that
would surprise a sysadmin familiar with how btrfs chunk allocation works.

One major piece that's missing is adjusting the statvfs (aka df)
available blocks field so that it doesn't include unallocated space on
any metadata-only devices.  Right now all the unallocated space on
metadata-only devices is counted as free even though it's impossible to
put a data block there, so anything that is triggered automatically
on "f_bavail < some_threshold" will be confused.

I don't think that piece has to block the rest of the patch series--if
you're not using the feature, df gives the right number (or at least the
same number it gave before), and if you are using the feature, you can
subtract the unavailable data space until a later patch comes along to
fix it.

I like

	echo data_only > /sys/fs/btrfs/$uuid/devinfo/3/type

more than patching btrfs-progs so I can use

	btrfs prop set /dev/... allocation_hint data_only

but I admit that might be because I'm weird.

> If we're going to use device->type for this, and since we don't have a user of
> device->type, I'd also like you to go ahead and re-name ->type to
> ->allocation_policy, that way it's clear what we're using it for now.
> 
> I'd also like some xfstests to validate the behavior so we're sure we're testing
> this.  I'd want 1 test to just test the mechanics, like mkfs with different
> policies and validate they're set right, change policies, add/remove disks with
> different policies.
> 
> Then a second test to do something like fsstress with each set of allocation
> policies to validate that we did actually allocate from the correct disks.  For
> this please also test with compression on to make sure the test validation works
> for both normal allocation and compression (ie it doesn't assume writing 5gib of
> data == 5 gib of data usage, as compression chould give you a different value).
> 
> With that in place I think this is the correct way to implement this feature.
> Thanks,
> 
> Josef
