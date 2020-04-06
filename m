Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D794519FB4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgDFRVG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 6 Apr 2020 13:21:06 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40494 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgDFRVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 13:21:06 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id AB42065812C; Mon,  6 Apr 2020 13:21:04 -0400 (EDT)
Date:   Mon, 6 Apr 2020 13:21:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
Message-ID: <20200406172104.GK2693@hungrycats.org>
References: <20200405082636.18016-1-kreijack@libero.it>
 <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
 <20200406022441.GM13306@hungrycats.org>
 <69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 06, 2020 at 06:43:04PM +0200, Goffredo Baroncelli wrote:
> On 4/6/20 4:24 AM, Zygo Blaxell wrote:
> > > > Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
> > > > apt on a rotational was a dramatic experience. And IMHO  this should be replaced
> > > > by using the btrfs snapshot capabilities. But this is another (not easy) story.
> > flushoncommit and eatmydata work reasonably well...once you patch out the
> > noise warnings from fs-writeback.
> > 
> 
> You wrote flushoncommit, but did you mean "noflushoncommit" ?

No.  "noflushoncommit" means applications have to call fsync() all the
time, or their files get trashed on a crash.  I meant flushoncommit
and eatmydata.

While dpkg runs, it must never call fsync, or it breaks the write
ordering provided by flushoncommit (or you have to zero-log on boot).
btrfs effectively does a point-in-time snapshot at every commit interval.
dpkg's ordering of write operations and renames does the rest.

dpkg runs much faster, so the window for interruption is smaller, and
if it is interrupted, then the result is more or less the same as if
you had run with fsync() on noflushoncommit.  The difference is that
the filesystem might roll back to an earlier state after a crash, which
could be a problem e.g. if your maintainer scripts are manipulating data
on multiple filesystems.


> Regarding eatmydata, I used it too. However I was never happy. Below my script:
> ----------------------------------
> ghigo@venice:/etc/apt/apt.conf.d$ cat 10btrfs.conf
> 
> DPkg::Pre-Invoke {"bash /var/btrfs/btrfs-apt.sh snapshot";};
> DPkg::Post-Invoke {"bash /var/btrfs/btrfs-apt.sh clean";};
> Dpkg::options {"--force-unsafe-io";};
> ---------------------------------
> ghigo@venice:/etc/apt/apt.conf.d$ cat /var/btrfs/btrfs-apt.sh
> 
> btrfsroot=/var/btrfs/debian
> btrfsrollback=/var/btrfs/debian-rollback
> 
> 
> do_snapshot() {
> 	if [ -d "$btrfsrollback" ]; then
> 		btrfs subvolume delete "$btrfsrollback"
> 	fi
> 
> 	i=20
> 	while [ $i -gt 0 -a -d "$btrfsrollback" ]; do
> 		i=$(( $i + 1 ))
> 		sleep 0.1
> 	done
> 	if [ $i -eq 0 ]; then
> 		exit 100
> 	fi
> 
> 	btrfs subvolume snapshot "$btrfsroot" "$btrfsrollback"
> 	
> }
> 
> do_removerollback() {
> 	if [ -d "$btrfsrollback" ]; then
> 		btrfs subvolume delete "$btrfsrollback"
> 	fi
> }
> 
> if [ "$1" = "snapshot" ]; then
> 	do_snapshot
> elif [ "$1" = "clean" ]; then
> 	do_removerollback
> else
> 	echo "usage: $0  snapshot|clean"
> fi
> --------------------------------------------------------------
> 
> Suggestion are welcome how detect automatically where is mount the
> btrfs root (subvolume=/) and  my root subvolume name (debian in my
> case). So I will avoid to wrote directly in my script.

You can figure out where "/" is within a btrfs filesystem by recusively
looking up parent subvol IDs with TREE_SEARCH_V2 until you get to 5
FS_ROOT (sort of like the way pwd works on traditional Unix); however,
root can be a bind mount, so "path from fs_root to /" is not guaranteed
to end at a subvol root.

Also, sometimes people put /var on its own subvol, so you'd need to
find "the set of all subvols relevant to dpkg" and that's definitely
not trivial in the general case.

It's not as easy to figure out if there's an existing fs_root mount
point (partly because namespacing mangles every path in /proc/mounts
and mountinfo), but if you know the btrfs device (and can access it
from your namespace) you can just mount it somewhere and then you do
know where it is.

> BR
> G.Baroncelli
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
