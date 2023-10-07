Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3038E7BC4C9
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 07:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjJGFTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 01:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJGFTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 01:19:45 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C6BBD
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 22:19:44 -0700 (PDT)
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by drax.kayaks.hungrycats.org (Postfix) with ESMTP id 83010A7CC29;
        Sat,  7 Oct 2023 01:14:25 -0400 (EDT)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.94.2)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1qozdx-00086Y-4t; Sat, 07 Oct 2023 01:14:25 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix stripe length calculation for non-zoned data chunks
Date:   Sat,  7 Oct 2023 01:14:20 -0400
Message-Id: <20231007051421.19657-1-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit f6fca3917b4d "btrfs: store chunk size in space-info struct"
introduces several regressions.  One of these is the regression fixed
by 5da431b71d4b "btrfs: fix the max chunk size and stripe length
calculation".  Another is fixed by my patch, which turns out to be
identical to a patch that was previously proposed, but its importance
was missed.

There are some remaining problems with those commits (and a few adjacent
ones) which I'm not going to touch, but I am going to rant about them
a little.

5da431b71d4b broke the one use case that f6fca3917b4d was intended to
support:  metadata chunks larger than 1 GiB.  Between the two commits,
metadata chunks could have stripe_len > 1 GiB, but 5da431b71d4b imposes
a maximum stripe_len == 1 GiB, effectively capping the metadata chunk
size at the original 1 GiB and defeating f6fca3917b4d.

Currently it's still possible to create metadata chunks with smaller
stripe_len than 1 GiB, and maybe there's a corner case (especially
on smaller filesystems) where that could still be useful.  It's also
possible to force data chunks to be created with a smaller-than-1-GiB
stripe_len which would be useful if the 10% heuristic wasn't good enough
for a particular small-filesystem workload.  But all of this paragraph
is just an implementation looking for a use case--if 50 GiB filesystems
have these kinds of problems, the practical solution is more likely to
be found in using mixed_bg instead of separate data and metadata.

IMHO f6fca3917b4d should be reverted without making any attempt to fix
its remaining problems.  f6fca3917b4d was a terrible approach for its
ostensible goal, for two reasons:

1.  The simpler reason is that the feature allows a device to have
dev_extents of varying sizes.  That's usually a bad thing all by itself,
particularly on large filesystems, and even worse when striped profiles
(raid0/10/5/6) are used.

It's a useful constraint to disallow a larger filesystem to allocate any
stripe_len that is not exactly 1 GiB (or a constant size used across the
entire FS) for any reason.  The short stripe at the end of the device
isn't worth massive filesystem fragmentation to use, and the 32M hole
left behind when a system chunk is relocated can lead to chaos after a
few drive upgrades.

Over the course of a large filesystem's lifetime, its devices may be
replaced, upgraded, and rebalanced many times.  If the filesystem is
using a striped profile which tries to allocate a stripe on every device
in the filesystem, then variation in dev_extent sizes will result in
_explosive_ dev_extent fragmentation as the filesystem fills up.  Some of
my filesystems have reached the point where almost 10% of the filesystem
cannot be used because the majority of chunks are smaller than 128 MiB,
or even nr_devs * 1 MiB.  It can take _years_ of balancing to fix a
mess that takes only a few months to create.

Even the existing system chunk stripe_len of 32 MiB, and the partial
dev_extent at the end of a device that is not an exact multiple of 1
GiB, are both bad.  We should get rid of all the existing cases where
stripe_len != SZ_1G on filesystems above some size (say 1 TiB or larger),
and definitely not add any new ones.


2.  The other reason is that it is better for ENOSPC avoidance to have
more small metadata chunks than fewer large ones.

Balance, scrub, and discard all lock block groups to prevent modification
while they're running.  This means that a filesystem can be in a state
where it has enough space for the global reserve, but can't use some
of the space because balance, scrub, or discard is running, so when
it's time to use the space, surprise, it's not available after all.

If the filesystem only has one metadata block group (e.g. because it's
a huge block group allocated with the use of the configurable chunk_size
feature), then during scrub, discard, or balance, it must abruptly double
its metadata allocation, or hit ENOSPC.

My favorite example of this is trying to replace a small but full device
with a larger one, where the small device has no unallocated space
and only one metadata block group.  The replace fails because replace
(like scrub) locks the only metadata block group, no new metadata block
groups are possible, and the filesystem becomes read-only during the
next metadata update due to lack of space.  The replace can proceed if
the user balances away one data block group to create a new unallocated
space, then allocates a metadata block group, then starts the replace
again, because now there are two metadata block groups with free space
and replace can't lock both at the same time.  We have to explain this
to new users (and occasionally to old ones!) a few times a year.

A 2-device raid1 needs 5 block groups containing a total of 512 MiB of
allocated but unused metadata space in the worst case:  balance, discard,
and 2 scrub threads can lock up to 4 block groups, and without counting
free space from those, there must be one or more block groups remaining
with a total of 512M of free space for the global reserve.  If the block
groups are 1 GiB, in the worst case, the filesystem needs to keep 4.5
GiB of unused metadata space allocated.  On a smaller filesystem, less
than 1.0 GiB is needed due to smaller block groups and smaller global
reserve.  If the block groups are 5 GiB each, in the worst case 20.5
GiB of allocated but unused metadata space is needed to avoid ENOSPC.
This gets worse on filesystems with more devices, as each device comes
with a scrub thread to lock another block group in the worst case,
e.g. a 8-device filesystem with 5 GiB metadata block groups could require
50.5 GiB of reserved metadata space, but only 10.5 GiB if it used 1 GiB
metadata block groups.

fstrim, device remove and device replace also lock block groups, but
they can't run concurrently with balance, discard, and scrub.  If space
is reserved for the latter three operations, then it is also available
to the former three.

A better solution for reserving metadata space is to keep the metadata
block groups the same size, but increase their number.  Metadata block
group reclaim should sort block groups by available free space, then
exclude the highest N block groups from the total (N = nr_devs + 1 (for
balance) + 1 (for discard or fstrim) and count the total free space
that is left.  Block groups should not be removed if it would bring
non-excluded free space below the global reserve amount.  As metadata
block groups fill up, empty block groups should be added to increase
space above the global reserve.


3.  (bonus reason!)  the chunk_size parameter isn't a very useful thing
to control from sysfs.  There's a fundamental unit conformability error
when trying to map chunk_size (a number of logical bytes in virtual
address space) to stripe_len (a number of physical bytes in device
address space).  The third term in the conversion equation between
these units--number of data-bearing devices--is not a constant across
the filesystem.  Without more information, the implementation can't
guess the user's intent as nr_devs changes from one chunk to another,
so it's always going to be wrong in at least one useful case.

Earlier versions of f6fca3917b4d on the mailing list did try to set
stripe_len, but then seemed to get confused about what max_stripe_len
and max_chunk_size do, and the result was several bugs.

It would be better to control nr_devs, stripe_len, and chunk_size
separately as ranged sysfs parameters (i.e. with max and min values).
Control over these parameters can be a useful tool for a user who knows
what they're doing.  A user might have a big filesystem where longer
stripe_len is desirable (so there are fewer block groups to manage,
as long as the change is made early and all block groups have the same
stripe_len), or a legacy filesystem with a lot of unusable small holes
due to dev_extent fragmentation (where it would be better for btrfs to
fail to allocate at all than to create a tiny block group that can't
hold larger extents), or a huge array of many devices with bandwidth
constraints (where maybe chunks with more than 6 stripes are undesirable).
Or even all of these at the same time (long narrow block groups with
no tiny fragments allowed).  If this is going to exposed via sysfs at
all, there should be a different, more useful set of sysfs knobs, with
different semantics than the ones f6fca3917b4d had.


I am especially disappointed that 19fc516a516f "btrfs: sysfs: export
chunk size in space infos" explicitly disallows changing the chunk size
(and therefore the stripe_len) of system chunks, with no rationale that
I can find.  It would be very useful to make system chunks be 1 GiB long,
so they match the size of other block group types, making no fragmentation
of dev_extents possible.

