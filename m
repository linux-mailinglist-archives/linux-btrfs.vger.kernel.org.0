Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACD02F8B0A
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 04:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbhAPDwG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 15 Jan 2021 22:52:06 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33710 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPDwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 22:52:06 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3B5269407AE; Fri, 15 Jan 2021 22:51:25 -0500 (EST)
Date:   Fri, 15 Jan 2021 22:51:24 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: Why do we need these mount options?
Message-ID: <20210116035110.GH31381@hungrycats.org>
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
 <20210115035448.GD31381@hungrycats.org>
 <649487eb-0161-877c-9e80-b0400d1097bf@dirtcellar.net>
 <20210116004208.GF31381@hungrycats.org>
 <650854d9-1558-ab11-683d-6ebac147b0b7@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <650854d9-1558-ab11-683d-6ebac147b0b7@dirtcellar.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 02:57:05AM +0100, waxhead wrote:
> 
> 
> Zygo Blaxell wrote:
> > On Fri, Jan 15, 2021 at 10:32:39AM +0100, waxhead wrote:
> > > Zygo Blaxell wrote:
> > > > 
> > > > > > commit
> > > > > > space_cache / nospace_cache
> > > > > > sdd / ssd_spread / nossd / no_ssdspread
> > > > 
> > > > How could those be anything other than filesystem-wide options?
> > > > 
> > > 
> > > Well being me, I tend to live in a fantasy world where BTRFS have complete
> > > world domination and has become the VFS layer.
> > > As I have nagged about before on this list - I really think that the only
> > > sensible way forward for BTRFS (or dare I say BTRFS2) would be to make it
> > > possible to assign "storage device groups" where you can make certain btrfs
> > > device ids belong to group a,b,c, etc...
> > > 
> > > And with that it would be possible to assign a weight to subvolumes so that
> > > they would be preferred to be stored on group a (SSD's perhaps), while other
> > > subvolumes would be stored mostly or exlusively on HDD's, Fast HDD's,
> > > Archival HDD's etc... So maybe a bit over enthusiastic in thinking perhaps ,
> > > but hopefully you see now why I think it is right that this is not
> > > filesystem-wide , but subvolume baseed properties.
> > 
> > Sure, that's all wonderful, but it has nothing to do with any of those
> > mount options.  ;)
> > 
> > commit sets a timer that forces a filesystem-wide sync() every now
> > and then.  space_cache picks one of the allocator implementations, also
> > for the entire filesystem.  ssd and related options affect the behavior
> > of the metadata allocator and superblocks.
> > 
> Ok I understand the space_cache, but commit (the way I understand it) could
> be useful to keep stuff in memory for longer for certain subvolume.

That's probably something to implement mostly above the filesystem level,
as it's VFS that controls most of writeback, and maybe memcg could be
adapted to have per-cgroup writeback settings.

The btrfs transaction commit updates all of the filesystem trees at once
(they are all children of the root subtree's root node).  Changing that
would be a significant restructuring.

> ssd options could also be useful pr. subvolume *if* and that is a big if
> BTRFS sometime in the far future allows for storage device groups. However
> when that happens maybe everything is solid state , who knows ;)

First the ssd options have to do something that could be per-subvolume.
Right now they do almost nothing, and the little they do is per-device.

There are various proposals for HSM, metadata-on-SSD, hot data tracking
floating around.  If they ever arrive at btrfs, they definitely won't be
tacked onto the ssd mount option.

> > > > > > discard / nodiscard
> > > > 
> > > > Maybe, but probably requires too much introspection in a fast path (we'd
> > > > have to add a check for the last owner of a deleted extent to see if it
> > > > had 'discard' set on some parent level).
> > > > 
> > > > On the other hand, I'm in favor of deprecating the whole discard option
> > > > and going with fstrim instead.  discard in its current form tends to
> > > > increase write wear rather than decrease it, especially on metadata-heavy
> > > > workloads.  discard is roughly equivalent to running fstrim thousands
> > > > of times a day, which is clearly bad for many (most?  all?) SSDs.
> > > > 
> > > > It might be possible to make the discard mount option's behavior more
> > > > sane (e.g. discard only full chunks, configurable minimum discard length,
> > > > discard only within data chunks, discard only once per hour, etc).
> > > > 
> > > Interesting, it might as well make sense to perhaps use the free space cache
> > > and a slow LRU mechanism e.g. "these chunks has not been in use for 64
> > > hours/days" or something similar.
> > 
> > That would add more writes, as the free space cache is an on-disk entity.
> > It might make sense to maintain a 'discard tree', which lists extents
> > that have been freed but not yet discarded or overwritten, to make fstrim
> > more efficient.  This wouldn't have to be very precise, just pointing to
> > general regions of the disk (maybe even entire block groups) so fstrim
> > doesn't issue discards to idle areas of the disk over and over.
> > 
> > Currently the discard extent list is stored in memory, so doing one
> > discard per T time units would use more memory.  This feature would be
> > like discard=async, but 1) it would hold on to the pinned extents for a
> > few hundred transactions instead of just one or two (subject to memory
> > availability), and 2) it would be able to reclaim space from the discard
> > list as free space, thus removing the need to issue a discard at all.
> > 
> > But that's really complicated, considering that a cron job that runs
> > fstrim once an hour can do the same thing without all the complexity.
> > On the other hand, I just ran fstrim on a test machine and it took
> > 34 minutes, so maybe some complexity might be useful after all... :-O
> > 
> Thanks for the education. Inspired by this I ran fstrim on my main machine
> with 7 older and smaller SSD's. Have not run fstrim on it or maybe a year so
> it took 15-20 minutes to do. But I see your point. Minimizing writes to
> SSD's is a good thing, but if I am not mistaking SMR disks can benefit from
> discard as well, I don't know the details but maybe it would be more
> beneficial on real disks than SSD storage?

Overwriting data at a given LBA implies discarding the data currently in
the LBA, regardless of underlying storage.  discard is useful on SSD,
SMR, and also caching/thin LV layers if the LBAs are not going to be
overwritten for a long time (thin LVs take less space, caches have more
room for other data).  There is no need to send a separate discard command
if the LBAs in question are not part of a file at the time, and there is
a high probability of overwriting the same LBA with new data very soon.

There are multiple variants of the discard operation in devices.
One variant leaves the contents of the discarded blocks undefined.
That's a nice feature, since the device is free to ignore the discard
request if it might improve performance (i.e. there is no need to ensure
the discard has immediate persistent effect, so it is acceptable for
the drive to not flush discards to persistent storage right away, and
merge the discard into some later write command to save one write cycle).

Most of the SSDs I've tested do a different variant of discard, where the
discarded blocks are guaranteed to return zeros.  That forces the drive
to do at least one flash write for each discard.  On such drives it's
important to not send redundant discards from the filesystem, as those
discards are necessarily wasting write cycles.

On SMR drives, redundant discards are even worse than on SSD.  SMR
drives have address translation layers like SSD, but they are stored
on spinning disks.  It will take milliseconds to move heads to record
the discard in the translation layer, only to spend more milliseconds
to write the replacement data in the same location immediately after.
The disk platter has higher endurance than SSD, but can be orders of
magnitude slower if there are too many translation layer updates.

> > > > > > compress / compress-force
> > > > > > datacow / nodatacow
> > > > > > datasum / nodatasum
> > > > 
> > > > Here's where I prefer the mount option over the more local attributes,
> > > > because I'd like filesystem-level sysadmin overrides for those.
> > > > i.e. disallow all users, even privileged ones, from being able to create
> > > > files that don't have csums or compression on a filesystem.
> > > > 
> > > Then how about a mount option that allow only root to do certain things?
> > > e.g. a security restriction.
> > 
> > No, I don't want root doing those things either.  Most of the applications
> > I want to bring to heel are already running as root.
> > 
> > Basically I want to say "every file on this filesystem shall be datacow
> > and datasum" and (short of altering the mount option) no other kind of
> > file can be created.
> > 
> > It might possibly make more sense to do this through tunefs--that way the
> > filesystem couldn't ever have nodatacow files (new kernels would refuse,
> > old kernels wouldn't be able to mount through a new feature flag).
> > 
> Allrighty point taken.
> 
> > > > > > user_subvol_rm_allowed
> > > > 
> > > > I'd like "user_subvol_create_disallowed" too.  Unprivileged users can
> > > > create subvols, and that breaks backups that rely on atomic btrfs
> > > > snapshots.  It could be a feature (it allows users to exclude parts of
> > > > their home directory from backups) but most users I've met who have
> > > > discovered this "feature" the hard way didn't enjoy it.
> > > > 
> > > > Historically I had other reasons to disallow subvol creates by
> > > > unprivileged users, but they are mostly removed in 4.18, now that 'rmdir'
> > > > works on an empty subvol.
> > > > 
> > > Again see above...
> > 
> > Here, unlike above, I was already asking precisely for subvol create to
> > be made root only.
> > 
> > That, or make snapshots recursive and atomic to avoid the accidental
> > user data loss/corruption case.
> > 
> Allrighty again! :)
