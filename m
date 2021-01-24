Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D31B301971
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 05:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbhAXEBH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 23 Jan 2021 23:01:07 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46742 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhAXEBG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 23:01:06 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 585F8951FDB; Sat, 23 Jan 2021 23:00:25 -0500 (EST)
Date:   Sat, 23 Jan 2021 23:00:25 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210124040025.GK28049@hungrycats.org>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
 <20210121185400.GH28049@hungrycats.org>
 <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
 <20210122224253.GI28049@hungrycats.org>
 <7b73eb0f-1b59-e6dd-5420-ef2d31a9fd62@cobb.uk.net>
 <20210123172118.GJ28049@hungrycats.org>
 <24522e9a-8cfb-73ab-2332-c7e0c6b9677c@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <24522e9a-8cfb-73ab-2332-c7e0c6b9677c@cobb.uk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 05:44:48PM +0000, Graham Cobb wrote:
> On 23/01/2021 17:21, Zygo Blaxell wrote:
> > On Sat, Jan 23, 2021 at 02:55:52PM +0000, Graham Cobb wrote:
> >> On 22/01/2021 22:42, Zygo Blaxell wrote:
> >> ...
> >>>> So the point is: what happens if the root subvolume is not mounted ?
> >>>
> >>> It's not an onerous requirement to mount the root subvol.  You can do (*)
> >>>
> >>> 	tmp="$(mktemp -d)"
> >>> 	mount -osubvolid=5 /dev/btrfs "$tmp"
> >>> 	setfattr -n 'btrfs...' -v... "$tmp"
> >>> 	umount "$tmp"
> >>> 	rmdir "$tmp"
> >>
> >> No! I may have other data on that disk which I do NOT want to become
> >> accessible to users on this system (even for a short time). As a simple
> >> example, imagine, a disk I carry around to take emergency backups of
> >> other systems, but I need to change this attribute to make the emergency
> >> backup of this system run as quickly as possible before the system dies.
> >> Or a disk used for audit trails, where users should not be able to
> >> modify their earlier data. Or where I suspect a security breach has
> >> occurred. I need to be able to be confident that the only data
> >> accessible on this system is data in the specific subvolume I have mounted.
> > 
> > Those are worthy goals, but to enforce them you'll have to block or filter
> > the mount syscall with one of the usual sandboxing/container methods.
> > 
> > If you have that already set up, you can change root subvol xattrs from
> > the supervisor side.  No users will have access if you don't give them
> > access to the root subvol or the mount syscall on the restricted side
> > (they might also need a block device FD belonging to the filesystem).
> > 
> > If you don't have the sandbox already set up, then root subvol access
> > is a thing your users can already do, and it may be time to revisit the
> > assumptions behind your security architecture.
> 
> I'm not talking about root. I mean unpriv'd users (who can't use mount)!
> If I (as root) mount the whole disk, those users may be able to read or
> modify files from parts of that disk to which they should not have
> access. That may be  why I am not mounting the whole disk in the first
> place.

So put the temporary mount point behind a mode 700 directory owned
by root, e.g.

	umask 077
	tmp="$(mktemp -d)"
	mkdir "$tmp/mp"
	mount -osubvolid=5 /dev/btrfs "$tmp/mp"
	setfattr -n 'btrfs...' -v... "$tmp/mp"
	umount "$tmp/mp"
	rmdir "$tmp/mp" "$tmp"

This doesn't seem like a new problem, or a problem that doesn't already
have lots of good solutions.

Anyway I'm no longer favor of using an xattr this way for a number of
better reasons, so the point is moot.

> I gave a few very simple examples, but I can think of many more cases
> where a disk may contain files which users might be able to access if
> the disk was mounted (maybe the disk has subvols used by many different
> systems but UIDs are not coordinated, or ...).  And, of course, if they
> can open a FD during the brief time it is mounted, they can stop it
> being unmounted again.
> 
> No. If I have chosen to mount just a subvol, it is because I don't want
> to mount the whole disk.
> 
