Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003282EC7F0
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jan 2021 03:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAGCGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 21:06:49 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42812 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbhAGCGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jan 2021 21:06:48 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 88EA092A989; Wed,  6 Jan 2021 21:06:04 -0500 (EST)
Date:   Wed, 6 Jan 2021 21:06:04 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Forza <forza@tnonline.net>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Graham Cobb <g.btrfs@cobb.uk.net>, Cedric.dewijs@eclipso.eu,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
Message-ID: <20210107020604.GW31381@hungrycats.org>
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
 <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
 <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
 <CAN4oSBcL7ae_qwKDDoP=sbjkR4gcweTO8otEQv1Zh0YhStWZsw@mail.gmail.com>
 <b9662cf1-e45f-5113-5b23-bf1aaa73cb97@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9662cf1-e45f-5113-5b23-bf1aaa73cb97@tnonline.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 06, 2021 at 09:18:30AM +0100, Forza wrote:
> 
> 
> On 2021-01-05 13:24, Cerem Cem ASLAN wrote:
> > I also thought about a different approach in the past:
> > 
> > 1. Take a snapshot and rsync it to the server.
> > 2. When it succeeds, make it readonly and take a note on the remote
> > site that indicates the Received_UUID and checksum of entire
> > subvolume.
> > 3. When you want to send your diff, run `btrfs send -p ./first
> > ./second | list-file-changes -o my-diff-for-second.txt` if that
> > Received_UUID on the remote site matches with ./first. (Otherwise, you
> > should run rsync without taking advantage of
> > `my-diff-for-second.txt`.)
> 
> You can use `btrbk diff old-snap new-snap` to list changes between
> snapshots.
> 
> Example:
> ------------------------------------------------------------------------------
> #btrbk diff /mnt/systemRoot/snapshots/root.20210101T0001/
> /mnt/systemRoot/snapshots/root.20210102T0001/
> 
> Subvolume Diff (btrbk command line client, version 0.30.0)
> 
>     Date:   Wed Jan  6 09:06:37 2021
> 
> Showing changed files for subvolume:
>   /mnt/systemRoot/snapshots/root.20210102T0001  (gen=6050233)
> 
> Starting at generation after subvolume:
>   /mnt/systemRoot/snapshots/root.20210101T0001  (gen=6046626)
> 
> This will show all files modified within generation range:
> [6046627..6050233]
> Newest file generation (transid marker) was: 6050233
> 
> Legend:
>     +..     file accessed at offset 0 (at least once)
>     .c.     flags COMPRESS or COMPRESS|INLINE set (at least once)
>     ..i     flags INLINE or COMPRESS|INLINE set (at least once)
>     <count> file was modified in <count> generations
>     <size>  file was modified for a total of <size> bytes
> ------------------------------------------------------------------------------
> +ci   1       1318  etc/csh.env
> +ci   1       2116  etc/dispatch-conf.conf
> +ci   1       1111  etc/environment.d/10-gentoo-env.conf
> +ci   1       2000  etc/etc-update.conf
> +c.   1      94208  etc/ld.so.cache
> ...
> ------------------------------------------------------------------------------
> 
> You can also use `btrfs find-new` to list filesystem changes, but the output
> is much more verbose than that of btrbk, and you need to figure out the
> generation id's first. I also think that some things like deleted files and
> renamed files do not get listed? [*]

find-new runs TREE_SEARCH to find everything in subvol metadata pages that
were unshared since the given transid.  It then filters out references to
file data that are older than the given transid, and prints what is left.

It's roughly all the new extents in the subvol since the given transid.  No
deletions, (it has nothing to compare against to know something is now
no longer there), no file attributes, no new clones or reflinks of old data
(i.e. after 'cp --reflink=always old_file old_file_2', old_file_2 will
not show up in find-new).

> Example:
> ------------------------------------------------------------------------------
> # btrfs subvolume find-new /mnt/systemRoot/snapshots/root.20210102T0001/
> 6046626
> 
> inode 3054490 file offset 0 len 8192 disk start 239676399616 offset 0 gen
> 6048209 flags COMPRESS etc/passwd-
> inode 9527306 file offset 0 len 4096 disk start 239792578560 offset 0 gen
> 6049979 flags COMPRESS var/lib/dhcp/dhclient.leases
> inode 9527306 file offset 4096 len 4096 disk start 239437688832 offset 0 gen
> 6050179 flags COMPRESS var/lib/dhcp/dhclient.leases
> inode 9527306 file offset 8192 len 4096 disk start 241226248192 offset 0 gen
> 6050220 flags NONE var/lib/dhcp/dhclient.leases
> inode 9527438 file offset 0 len 4096 disk start 244439986176 offset 0 gen
> 6049681 flags NONE var/lib/samba/wins.tdb
> inode 9527438 file offset 4096 len 4096 disk start 244569776128 offset 0 gen
> 6050217 flags NONE var/lib/samba/wins.tdb
> inode 9527438 file offset 8192 len 4096 disk start 243901612032 offset 0 gen
> 6049543 flags NONE var/lib/samba/wins.tdb
> inode 9527438 file offset 12288 len 8192 disk start 242191458304 offset 4096
> gen 6048901 flags PREALLOC var/lib/samba/wins.tdb
> inode 9527438 file offset 20480 len 4096 disk start 244319576064 offset 0
> gen 6049691 flags NONE var/lib/samba/wins.tdb
> ------------------------------------------------------------------------------
> 
> > 4. Use rsync to send the changed files listed in `my-diff-for-second.txt`.
> > 5. Verify by using a rolling hash, create a second snapshot and so on.
> > 
> > That approach will use all advantages of rsync and adds the "change
> > detection" benefit from BTRFS. The problem is, I don't know how to
> > implement the `list-file-changes` tool.
> > 
> > By the way, why wouldn't BTRFS keep a CHECKSUM field on readonly
> > subvolumes and simply use that field for diff and patch operations?
> > Calculating incremental checksums on every new readonly snapshot seems
> > like a computationally cheap operation. We could then transfer our
> > snapshots whatever method/tool we like (even we could create the
> > /home/foo/hello.txt file with "hello world" content manually and then
> > create another snapshot that will automatically match with our new
> > local snapshot).
> > 
> [*]http://marc.merlins.org/perso/btrfs/post_2014-05-19_Btrfs-diff-Between-Snapshots.html
