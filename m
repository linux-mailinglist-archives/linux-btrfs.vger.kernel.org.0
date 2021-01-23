Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BF30172B
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbhAWRWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 12:22:05 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36458 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbhAWRWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 12:22:01 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 85C7D951470; Sat, 23 Jan 2021 12:21:18 -0500 (EST)
Date:   Sat, 23 Jan 2021 12:21:18 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210123172118.GJ28049@hungrycats.org>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
 <20210121185400.GH28049@hungrycats.org>
 <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
 <20210122224253.GI28049@hungrycats.org>
 <7b73eb0f-1b59-e6dd-5420-ef2d31a9fd62@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b73eb0f-1b59-e6dd-5420-ef2d31a9fd62@cobb.uk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 02:55:52PM +0000, Graham Cobb wrote:
> On 22/01/2021 22:42, Zygo Blaxell wrote:
> ...
> >> So the point is: what happens if the root subvolume is not mounted ?
> > 
> > It's not an onerous requirement to mount the root subvol.  You can do (*)
> > 
> > 	tmp="$(mktemp -d)"
> > 	mount -osubvolid=5 /dev/btrfs "$tmp"
> > 	setfattr -n 'btrfs...' -v... "$tmp"
> > 	umount "$tmp"
> > 	rmdir "$tmp"
> 
> No! I may have other data on that disk which I do NOT want to become
> accessible to users on this system (even for a short time). As a simple
> example, imagine, a disk I carry around to take emergency backups of
> other systems, but I need to change this attribute to make the emergency
> backup of this system run as quickly as possible before the system dies.
> Or a disk used for audit trails, where users should not be able to
> modify their earlier data. Or where I suspect a security breach has
> occurred. I need to be able to be confident that the only data
> accessible on this system is data in the specific subvolume I have mounted.

Those are worthy goals, but to enforce them you'll have to block or filter
the mount syscall with one of the usual sandboxing/container methods.

If you have that already set up, you can change root subvol xattrs from
the supervisor side.  No users will have access if you don't give them
access to the root subvol or the mount syscall on the restricted side
(they might also need a block device FD belonging to the filesystem).

If you don't have the sandbox already set up, then root subvol access
is a thing your users can already do, and it may be time to revisit the
assumptions behind your security architecture.

> Also, the backup problem is a very real problem - abusing xattrs for
> filesystem controls really screws up writing backup procedures to
> correctly backup xattrs used to describe or manage data (or for any
> other purpose).
> 
> I suppose btrfs can internally store it in an xattr if it wants, as long
> as any values set are just ignored and changes happen through some other
> operation (e.g. sysfs). It still might confuse programs like rsync which
> would try to reset the values each time a sync is done.

I want to upgrade my "one lingering concern" about xattr to a "we really
shouldn't use an inode's xattr to describe device layout."

The layout configuration can still be a string (I kind of like the string,
it's more extensible than a binary blob, though we don't do balance that
way so I'm not married to the string idea) but that string should live
elsewhere, like in a dev tree persistent item where we currently keep
replace progress and dev stats.

It shouldn't be attached to an inode, even if it's easier to manage there.
Unlike all of btrfs's previous per-inode flags, per-device storage
preferences are not the kind of metadata you could move to another btrfs
filesystem and expect to work.

Even some of the previous btrfs inode attributes cause issues and need
to be filtered or translated when they are copied, e.g. nodatacow needs
to be _stored_ in backups so it can be restored to the original system,
but must not _affect_ backups so the backups have csums, dedupe, and/or
compression.  We don't want to add a new xattr that ends up having to
be filtered out of everything.
