Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43442A20A3
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Nov 2020 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgKARuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 1 Nov 2020 12:50:12 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48648 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgKARuM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Nov 2020 12:50:12 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2251B881068; Sun,  1 Nov 2020 12:49:07 -0500 (EST)
Date:   Sun, 1 Nov 2020 12:49:03 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Switching from spacecache v1 to v2
Message-ID: <20201101174902.GU5890@hungrycats.org>
References: <fc45b21c-d24e-641c-efab-e1544aa98071@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <fc45b21c-d24e-641c-efab-e1544aa98071@dirtcellar.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 31, 2020 at 01:27:57AM +0100, waxhead wrote:
> A couple of months ago I asked on IRC how to properly switch from version 1
> to version 2 of the space cache. I also asked if the space cache v2 was
> considered stable.
> I only remember what we talked about, and from what I understood it was not
> as easy to switch as the wiki may seem to indicate.
> 
> We run a box with a btrfs filesystem at 19TB, 9 disks, 11 subvolumes that
> contains about 6.5 million files (and this number is growing).
> 
> The filesystem has always been mounted with just the default options.
> 
> Performance is slow, and it improved when I moved the bulk of the files to
> various subvolumes for some reason. The wiki states that performance on very
> large filesystems (what is considered large?) may degrade drastically.

The important number for space_cache=v1 performance is the number of block
groups in which some space was allocated or deallocated per transaction
(i.e. the number of block groups that have to be updated on disk),
divided by the speed of the drives (i.e. the number of seeks they can
perform per second).

"Large" could be 100GB if it was on a slow disk with a highly fragmented
workload and low latency requirement.

A 19TB filesystem has up to 19000 block groups and a spinning disk can do
maybe 150 seeks per second, so a worst-case commit could take a couple of
minutes.  Delete a few old snapshots, and you'll add enough fragmentation
to touch a significant portion of the block groups, and thus see a lot
of additional latency.

> I would like to try v2 of the space cache to see if that improves speed a
> bit.
> 
> So is space cache v2 safe to use?!

AFAIK it has been 663 days since the last bug fix specific to free space
tree (a6d8654d885d "Btrfs: fix deadlock when using free space tree due
to block group creation" from 5.0).  That fix was backported to earlier
LTS kernels.

We switched to space_cache=v2 for all new filesystems back in 2016, and
upgraded our last legacy machine still running space_cache=v1 in 2019.

I have never considered going back to v1:  we have no machines running
v1, I don't run regression tests on new kernels with v1, and I've never
seen a filesystem fail in the field due to v2 (even with the bugs we
now know it had).

IMHO the real question is "is v1 safe to use", given that its design is
based on letting errors happen, then detecting and recovering from them
after they occur (this is the mechanism behind the ubiquitous "failed to
load free space cache for block group %llu, rebuilding it now" message).
v2 prevents the errors from happening in the first place by using the
same btrfs metadata update mechanisms that are used for everything else
in the filesystem.

The problems in v1 may be mostly theoretical.  I've never cared enough
about v1 to try a practical experiment to see if btrfs recovers from
these problems correctly (or not).  v2 doesn't have those problems even
in theory, and it works, so I use v2 instead.

> And
> How do I make the switch properly?

Unmount the filesystem, mount it once with -o clear_cache,space_cache=v2.
It will take some time to create the tree.  After that, no mount option
is needed.

With current kernels it is not possible to upgrade while the filesystem is
online, i.e. to upgrade "/" you have to set rootflags in the bootloader
or boot from external media.  That and the long mount time to do the
conversion (which offends systemd's default mount timeout parameters)
are the two major gotchas.

There are some patches for future kernels that will take care of details
like deleting the v1 space cache inodes and other inert parts of the
space_cache=v1 infrastructure.  I would not bother with these
now, and instead let future kernels clean up automatically.
