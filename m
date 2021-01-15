Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7422F7144
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 04:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbhAODza convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 14 Jan 2021 22:55:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41602 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbhAODz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 22:55:29 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9610393D65B; Thu, 14 Jan 2021 22:54:48 -0500 (EST)
Date:   Thu, 14 Jan 2021 22:54:48 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        linux-btrfs@vger.kernel.org
Subject: Re: Why do we need these mount options?
Message-ID: <20210115035448.GD31381@hungrycats.org>
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210114163729.GY6430@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 14, 2021 at 05:37:29PM +0100, David Sterba wrote:
> Hi,
> 
> On Thu, Jan 14, 2021 at 03:12:26AM +0100, waxhead wrote:
> > I was looking through the mount options and being a madman with strong 
> > opinions I can't help thinking that a lot of them does not really belong 
> > as mount options at all, but should rather be properties set on the 
> > subvolume - for example the toplevel subvolume.
> 
> I agree that some of them should not be there but mount options still
> have their own usecase. They can be set from the outside and are
> supposed to affect the whole filesystem mount lifetime.
> 
> However, they've been used as default values for some operations, which
> is something that points more to what you suggest. And as they're not
> persistent and need to be stored in /etc/fstab is also weighing for
> storage inside the fs.
> 
> > And any options set on a child subvolume should override the parrent 
> > subvolume the way I see it.
> 
> Yeah, that's one of the ways how to do it and I see it that way as well.
> Property set closer to the object takes precedence, roughly
> 
> mount < subvolume < directory < file

Wearing my grumpy sysadmin hat, I have occasionally wanted the mount
options to override the subvolume and inode operations.  Examples below.

> but last time we had a discussion about that, the other oppinion was
> that mount options beat everything, perhaps because they can be set from
> the outside and forced to ovrride whatever is on the filesystem.
> 
> > By having a quick look - I don't see why these should be mount options 
> > at all.
> > 
> > autodefrag / noautodefrag

That makes sense as an inode property--you only want autodefrag on a few
files and they're usually easy to spot.

> > inode_cache / noinode_cache

That one is already gone as of v5.11-rc1.

> > commit
> > space_cache / nospace_cache
> > sdd / ssd_spread / nossd / no_ssdspread

How could those be anything other than filesystem-wide options?

> > discard / nodiscard

Maybe, but probably requires too much introspection in a fast path (we'd
have to add a check for the last owner of a deleted extent to see if it
had 'discard' set on some parent level).

On the other hand, I'm in favor of deprecating the whole discard option
and going with fstrim instead.  discard in its current form tends to
increase write wear rather than decrease it, especially on metadata-heavy
workloads.  discard is roughly equivalent to running fstrim thousands
of times a day, which is clearly bad for many (most?  all?) SSDs.

It might be possible to make the discard mount option's behavior more
sane (e.g. discard only full chunks, configurable minimum discard length,
discard only within data chunks, discard only once per hour, etc).

> > compress / compress-force
> > datacow / nodatacow
> > datasum / nodatasum

Here's where I prefer the mount option over the more local attributes,
because I'd like filesystem-level sysadmin overrides for those.
i.e. disallow all users, even privileged ones, from being able to create
files that don't have csums or compression on a filesystem.

It might be better to allow the per-inode/subvol properties to be set,
but have a mount option to override them.  I don't want to deal with
legacy applications that might throw an error if they get an error return
from a nodatacow chattr, so "silently drop the chattr" is better than
"prevent chattr with error."

I also want to store backup / live-mountable copies of filesystems that
have these attributes set, but that's a lot more complicated to implement.
The filesystem can't just ignore a nodatasum bit on an inode once it
has been set, and I can solve the problem above the filesystem by
modifying btrfs receive or other backup code to strip those bits and
store them somewhere else.

Something like this seems mandatory to have working crypto integrity in
the future, but silent data corruption on cheap SSDs is bad enough to
make it a requirement for plaintext storage now.

compress has some significant holes in its per-inode interface: no way
to specify compress level in an inode property, no way to specify force
on some files but not others.

Compress is far easier to override from a mount option--we just don't
look at the inode bits in needs_compress and everything else still works
the same as before.

> > user_subvol_rm_allowed

I'd like "user_subvol_create_disallowed" too.  Unprivileged users can
create subvols, and that breaks backups that rely on atomic btrfs
snapshots.  It could be a feature (it allows users to exclude parts of
their home directory from backups) but most users I've met who have
discovered this "feature" the hard way didn't enjoy it.

Historically I had other reasons to disallow subvol creates by
unprivileged users, but they are mostly removed in 4.18, now that 'rmdir'
works on an empty subvol.

> So there are historical reasons and interface limitations that led to
> current state and multiple ways to do things.
> 
> Per-inode attributes were originally private ioctl of ext2 that other
> filesystems adopted due to feature parity, and as the interface was
> bit-based, no additional values could be set eg. compression, limited
> number of bits, no precedence, inter-flag dependencies.
> 
> > Stuff like compress and nodatacow can be set with chattr so there is as 
> > far as I am aware three methods of setting compression for example.
> > 
> > Either by mount options in fstab, by chattr or by btrfs property set
> > 
> > I think it would be more consistent to have one interface for adjusting 
> > behavior.
> 
> I agree with that and there's a proposal to unify that into the
> properties as interface once for all, accessible through the extended
> attributes. But there are much more ways how to do that wrong so it
> hasn't been implemented so far.
> 
> A suggestion for an inode flag here and there comes from time to time,
> fixing one problem each time. Repeating that would lead to a mess that
> can be demonstrated on the existing mount options, so we've been there
> and need to do it the right way.
> 
> > As I asked before, the future plan to have different storage profiles on 
> > subvolumes seem to have been sneakily(?) removed from the wiki
> 
> I don't think the per-subvolume storage options were ever tracked on
> wiki, the closest match is per-subvolume mount options that's still
> there
> 
> https://btrfs.wiki.kernel.org/index.php/Project_ideas#Per-subvolume_mount_options
> 
> > - if that is indeed a dropped goal I can see why it makes sense to
> > keep the mount options, if not I think the mount options should go in
> > favor of btrfs property set.
