Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A9019FBFB
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDFRqs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 6 Apr 2020 13:46:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46244 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgDFRqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 13:46:47 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8BE826581FF; Mon,  6 Apr 2020 13:40:52 -0400 (EDT)
Date:   Mon, 6 Apr 2020 13:40:52 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
Message-ID: <20200406174052.GL2693@hungrycats.org>
References: <20200405082636.18016-1-kreijack@libero.it>
 <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
 <20200406022441.GM13306@hungrycats.org>
 <69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it>
 <20200406172104.GK2693@hungrycats.org>
 <0d598f1a-b86e-ffab-01a2-3eff56b2d3b1@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0d598f1a-b86e-ffab-01a2-3eff56b2d3b1@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 06, 2020 at 07:33:16PM +0200, Goffredo Baroncelli wrote:
> On 4/6/20 7:21 PM, Zygo Blaxell wrote:
> > On Mon, Apr 06, 2020 at 06:43:04PM +0200, Goffredo Baroncelli wrote:
> > > On 4/6/20 4:24 AM, Zygo Blaxell wrote:
> > > > > > Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
> > > > > > apt on a rotational was a dramatic experience. And IMHO  this should be replaced
> > > > > > by using the btrfs snapshot capabilities. But this is another (not easy) story.
> > > > flushoncommit and eatmydata work reasonably well...once you patch out the
> > > > noise warnings from fs-writeback.
> > > > 
> > > 
> > > You wrote flushoncommit, but did you mean "noflushoncommit" ?
> > 
> > No.  "noflushoncommit" means applications have to call fsync() all the
> > time, or their files get trashed on a crash.  I meant flushoncommit
> > and eatmydata.
> 
> It is a tristate value (default, flushoncommit, noflushoncommit), or
> flushoncommit IS the default ?

noflushoncommit is the default.  flushoncommit is sort of terrible--it
used to have deadlock bugs up to 4.15, and spams the kernel log with
warnings since 4.15.

> > While dpkg runs, it must never call fsync, or it breaks the write
> > ordering provided by flushoncommit (or you have to zero-log on boot).
> > btrfs effectively does a point-in-time snapshot at every commit interval.
> > dpkg's ordering of write operations and renames does the rest.
> > 
> > dpkg runs much faster, so the window for interruption is smaller, and
> > if it is interrupted, then the result is more or less the same as if
> > you had run with fsync() on noflushoncommit.  The difference is that
> > the filesystem might roll back to an earlier state after a crash, which
> > could be a problem e.g. if your maintainer scripts are manipulating data
> > on multiple filesystems.
> > 
> > 
> > > Regarding eatmydata, I used it too. However I was never happy. Below my script:
> > > ----------------------------------
> > > ghigo@venice:/etc/apt/apt.conf.d$ cat 10btrfs.conf
> > > 
> > > DPkg::Pre-Invoke {"bash /var/btrfs/btrfs-apt.sh snapshot";};
> > > DPkg::Post-Invoke {"bash /var/btrfs/btrfs-apt.sh clean";};
> > > Dpkg::options {"--force-unsafe-io";};
> > > ---------------------------------
> > > ghigo@venice:/etc/apt/apt.conf.d$ cat /var/btrfs/btrfs-apt.sh
> > > 
> > > btrfsroot=/var/btrfs/debian
> > > btrfsrollback=/var/btrfs/debian-rollback
> > > 
> > > 
> > > do_snapshot() {
> > > 	if [ -d "$btrfsrollback" ]; then
> > > 		btrfs subvolume delete "$btrfsrollback"
> > > 	fi
> > > 
> > > 	i=20
> > > 	while [ $i -gt 0 -a -d "$btrfsrollback" ]; do
> > > 		i=$(( $i + 1 ))
> > > 		sleep 0.1
> > > 	done
> > > 	if [ $i -eq 0 ]; then
> > > 		exit 100
> > > 	fi
> > > 
> > > 	btrfs subvolume snapshot "$btrfsroot" "$btrfsrollback"
> > > 	
> > > }
> > > 
> > > do_removerollback() {
> > > 	if [ -d "$btrfsrollback" ]; then
> > > 		btrfs subvolume delete "$btrfsrollback"
> > > 	fi
> > > }
> > > 
> > > if [ "$1" = "snapshot" ]; then
> > > 	do_snapshot
> > > elif [ "$1" = "clean" ]; then
> > > 	do_removerollback
> > > else
> > > 	echo "usage: $0  snapshot|clean"
> > > fi
> > > --------------------------------------------------------------
> > > 
> > > Suggestion are welcome how detect automatically where is mount the
> > > btrfs root (subvolume=/) and  my root subvolume name (debian in my
> > > case). So I will avoid to wrote directly in my script.
> > 
> > You can figure out where "/" is within a btrfs filesystem by recusively
> > looking up parent subvol IDs with TREE_SEARCH_V2 until you get to 5
> > FS_ROOT (sort of like the way pwd works on traditional Unix); however,
> > root can be a bind mount, so "path from fs_root to /" is not guaranteed
> > to end at a subvol root.
> 
> May be an use case for a new ioctl :-) ? Snapshot a subvolume without
> mounting the root subvolume....

That would make access control mechanisms like chroot...challenging.
;)  But I hear we have a delete-by-id ioctl now, so might as well have
snap-by-id too.

> > Also, sometimes people put /var on its own subvol, so you'd need to
> > find "the set of all subvols relevant to dpkg" and that's definitely
> > not trivial in the general case.
> 
> I know that a general rule it is not easy. Anyway I also would put /boot
> and /home in a dedicated subvolume.
> If the "roolback" is done at boot, /boot should be an invariant...
> However I think that there are a lot of corner case even here (what happens
> if the boot kernel doesn't have modules in the root subvolume ?)
> 
> It is not an easy job. It must be performed at distribution level...
> 
> > 
> > It's not as easy to figure out if there's an existing fs_root mount
> > point (partly because namespacing mangles every path in /proc/mounts
> > and mountinfo), but if you know the btrfs device (and can access it
> > from your namespace) you can just mount it somewhere and then you do
> > know where it is.
> 
> I agree, looking from root to the "root device", then mount the
> root subvolume in a know place, where it is possible to snapshot
> the root subvolume.
> 
> > 
> > > BR
> > > G.Baroncelli
> > > -- 
> > > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> > > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
