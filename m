Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4228E5206B2
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiEIVhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 17:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiEIVhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 17:37:39 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 284C22764EB
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 14:33:43 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 9CB87333897; Mon,  9 May 2022 17:33:42 -0400 (EDT)
Date:   Mon, 9 May 2022 17:33:42 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Alexander Zapatka <alexzapatka@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: How important is a full balance?
Message-ID: <YnmItm/NW3eUcvsL@hungrycats.org>
References: <CAFd7XocnyH8d_U8A0Mjy9+fk=DOTyiHzTR9FX+QSFevMtHGs=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd7XocnyH8d_U8A0Mjy9+fk=DOTyiHzTR9FX+QSFevMtHGs=Q@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 06, 2022 at 02:12:51AM +0000, Alexander Zapatka wrote:
> How important is completing a full balance after adding a device?  I
> had a 16tb single array.  I then added a 4tb harddrive and started a
> full balance.  It's been running for several days and I still have 81%
> to go.  Despite that, if I look at the usage statistics the drive has
> balanced out the free space among the 5 physical drives.  dmesg still
> shows chunks being moved... is it worth completing the balance even if
> it takes several weeks?  or is it "good enough" because the files are
> distributed?

It depends on what your current configuration is, and also on what you
intend to do in the future.  If you intend to ever use a striped raid
profile, now or in the future, you must run a full data balance every
time you add a device or resize an existing one larger.  If you will
only use unstriped profiles, then minimal balancing for the profiles in
use will suffice.

Balance makes a lot more sense if you think of it as distributing free
space, not files.  Balance relocates the data in a block group to a
new location, then it deletes the block group.  It's the deletion that
we want to exploit to get free space on the devices where we want it.
Except for the conversion case, never balance metadata, only data.

The unallocated space requirements depend on the selected storage
profiles.  The requirements below must be met for the storage profile
selected for both data and metadata (e.g. if you have single data and
raid1 metadata, the stricter raid1 requirements must be met or the
filesystem may run out of metadata space and go read-only).

Before adding a drive, make sure there is enough unallocated space on
existing drives to create new metadata block groups (for filesystems
over 50GB, this is 1GB * (number_of_devices + 2)).

If using a striped profile (raid0, raid10, raid5, or raid6), then do a
full data balance of all data after adding a drive.  If adding multiple
drives at once, do a full data balance after adding the last one.
If the balance is interrupted, it can be restarted using the 'stripes'
filter (i.e. -dstripes=1..$N where $N is the previous size of the array
before the new device was added) as long as all devices are the same size.
If the devices are different sizes, a specialized userspace balance tool
is required.  The data balance must be completed before adding any new
devices or increasing the size of existing ones.

If you are not using a striped profile now, but intend to convert to a
striped profile in the future, always perform a full data balance after
adding drives or replacing existing drives with larger ones.  The stock
btrfs balance tool cannot cope with special cases on filesystems with
striped raid profiles, and will paint itself into a corner that will
require custom userspace balancing tools to recover if you try.

Single profile has no requirement of its own for balance after adding
a device.

If using raid0 profile on a recent kernel then there's no need to balance
anything except for performance reasons.  Raid0 is able to reduce stripe
width dynamically, reducing to a single device with recent kernels, so
all space will be usable, but performance may be affected.  To avoid
the performance issue, run a full data balance.  Older kernels have a
2-device minimum and cannot use space when only one device is available.

If using an unstriped redundant profile (raid1, raid1c3, raid1c4, raid10)
then balance data block groups until unallocated space is equal on the
minimum number of devices for the profile.  e.g.  raid1c3 will need 3
disks with an equal amount of space, while raid1 will need 2 disks with an
equal amount of space.  raid10 requires 4 disks on older kernels, and can
degenerate to 2 disks on newer kernels (still mirrored but not striped).

If the devices are different sizes such that it's not possible to have
an equal amount of space on the largest devices (e.g. raid1 with 4tb and
16tb), then resize the largest devices smaller until the requirement can
be met (e.g. resize the 16tb device to 4tb) or convert to a different
raid profile which doesn't have this restriction (e.g. dup will be able
to use the space, but will only tolerate single-sector device failures).
The gotcha to avoid in this case is that very unequal sizes might work
for a while, until metadata runs out, then the filesystem gets stuck
read-only with ENOSPC.

If using dup profile then there should normally be only one device in
the filesystem.  When adding a second device, convert all dup profile
block groups to raid1 (even metadata).

Don't balance the metadata unless converting the metadata to a different
profile (e.g. the dup -> raid1 case when adding the second disk to a
filesystem for the first time).  Converting metadata to a different
profile deallocates some of the slack space that is needed for metadata
allocation in the future.  After a profile conversion, monitor metadata
usage and be prepared to balance some data block groups to ensure there
is sufficient unallocated space for new metadata.
