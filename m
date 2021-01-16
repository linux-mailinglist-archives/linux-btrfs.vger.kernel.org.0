Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0852A2F8A04
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 01:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbhAPAmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 19:42:50 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46754 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPAmt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 19:42:49 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 257A1940518; Fri, 15 Jan 2021 19:42:08 -0500 (EST)
Date:   Fri, 15 Jan 2021 19:42:08 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: Why do we need these mount options?
Message-ID: <20210116004208.GF31381@hungrycats.org>
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
 <20210115035448.GD31381@hungrycats.org>
 <649487eb-0161-877c-9e80-b0400d1097bf@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <649487eb-0161-877c-9e80-b0400d1097bf@dirtcellar.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 15, 2021 at 10:32:39AM +0100, waxhead wrote:
> Zygo Blaxell wrote:
> > 
> > > > commit
> > > > space_cache / nospace_cache
> > > > sdd / ssd_spread / nossd / no_ssdspread
> > 
> > How could those be anything other than filesystem-wide options?
> > 
> 
> Well being me, I tend to live in a fantasy world where BTRFS have complete
> world domination and has become the VFS layer.
> As I have nagged about before on this list - I really think that the only
> sensible way forward for BTRFS (or dare I say BTRFS2) would be to make it
> possible to assign "storage device groups" where you can make certain btrfs
> device ids belong to group a,b,c, etc...
> 
> And with that it would be possible to assign a weight to subvolumes so that
> they would be preferred to be stored on group a (SSD's perhaps), while other
> subvolumes would be stored mostly or exlusively on HDD's, Fast HDD's,
> Archival HDD's etc... So maybe a bit over enthusiastic in thinking perhaps ,
> but hopefully you see now why I think it is right that this is not
> filesystem-wide , but subvolume baseed properties.

Sure, that's all wonderful, but it has nothing to do with any of those
mount options.  ;)

commit sets a timer that forces a filesystem-wide sync() every now
and then.  space_cache picks one of the allocator implementations, also
for the entire filesystem.  ssd and related options affect the behavior
of the metadata allocator and superblocks.

> > > > discard / nodiscard
> > 
> > Maybe, but probably requires too much introspection in a fast path (we'd
> > have to add a check for the last owner of a deleted extent to see if it
> > had 'discard' set on some parent level).
> > 
> > On the other hand, I'm in favor of deprecating the whole discard option
> > and going with fstrim instead.  discard in its current form tends to
> > increase write wear rather than decrease it, especially on metadata-heavy
> > workloads.  discard is roughly equivalent to running fstrim thousands
> > of times a day, which is clearly bad for many (most?  all?) SSDs.
> > 
> > It might be possible to make the discard mount option's behavior more
> > sane (e.g. discard only full chunks, configurable minimum discard length,
> > discard only within data chunks, discard only once per hour, etc).
> > 
> Interesting, it might as well make sense to perhaps use the free space cache
> and a slow LRU mechanism e.g. "these chunks has not been in use for 64
> hours/days" or something similar.

That would add more writes, as the free space cache is an on-disk entity.
It might make sense to maintain a 'discard tree', which lists extents
that have been freed but not yet discarded or overwritten, to make fstrim
more efficient.  This wouldn't have to be very precise, just pointing to
general regions of the disk (maybe even entire block groups) so fstrim
doesn't issue discards to idle areas of the disk over and over.

Currently the discard extent list is stored in memory, so doing one
discard per T time units would use more memory.  This feature would be
like discard=async, but 1) it would hold on to the pinned extents for a
few hundred transactions instead of just one or two (subject to memory
availability), and 2) it would be able to reclaim space from the discard
list as free space, thus removing the need to issue a discard at all.

But that's really complicated, considering that a cron job that runs
fstrim once an hour can do the same thing without all the complexity.
On the other hand, I just ran fstrim on a test machine and it took
34 minutes, so maybe some complexity might be useful after all... :-O

> > > > compress / compress-force
> > > > datacow / nodatacow
> > > > datasum / nodatasum
> > 
> > Here's where I prefer the mount option over the more local attributes,
> > because I'd like filesystem-level sysadmin overrides for those.
> > i.e. disallow all users, even privileged ones, from being able to create
> > files that don't have csums or compression on a filesystem.
> > 
> Then how about a mount option that allow only root to do certain things?
> e.g. a security restriction.

No, I don't want root doing those things either.  Most of the applications
I want to bring to heel are already running as root.

Basically I want to say "every file on this filesystem shall be datacow
and datasum" and (short of altering the mount option) no other kind of
file can be created.

It might possibly make more sense to do this through tunefs--that way the
filesystem couldn't ever have nodatacow files (new kernels would refuse,
old kernels wouldn't be able to mount through a new feature flag).

> > > > user_subvol_rm_allowed
> > 
> > I'd like "user_subvol_create_disallowed" too.  Unprivileged users can
> > create subvols, and that breaks backups that rely on atomic btrfs
> > snapshots.  It could be a feature (it allows users to exclude parts of
> > their home directory from backups) but most users I've met who have
> > discovered this "feature" the hard way didn't enjoy it.
> > 
> > Historically I had other reasons to disallow subvol creates by
> > unprivileged users, but they are mostly removed in 4.18, now that 'rmdir'
> > works on an empty subvol.
> > 
> Again see above...

Here, unlike above, I was already asking precisely for subvol create to
be made root only.

That, or make snapshots recursive and atomic to avoid the accidental
user data loss/corruption case.
