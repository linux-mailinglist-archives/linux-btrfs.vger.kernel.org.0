Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0481222B8F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgGWVx1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 23 Jul 2020 17:53:27 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47918 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGWVx1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 17:53:27 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6313577BA1E; Thu, 23 Jul 2020 17:53:26 -0400 (EDT)
Date:   Thu, 23 Jul 2020 17:53:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
Message-ID: <20200723215325.GB5890@hungrycats.org>
References: <20200721203340.275921-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200721203340.275921-1-kreijack@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 10:33:39PM +0200, Goffredo Baroncelli wrote:
> 
> Hi all,
> 
> this is an RFC to discuss a my idea to allow a simple rollback of the
> root filesystem at boot time.
> 
> The problem that I want to solve is the following: DPKG is very slow on
> a BTRFS filesystem. The reason is that DPKG massively uses
> sync()/fsync() to guarantee that the filesystem is always coherent even
> in case of sudden shutdown.
> 
> The same can be useful even to the RPM Linux based distribution (which however
> suffer less than DPKG).
> 
> A way to avoid the sync()/fsync() calls without loosing the DPKG
> guarantees, is:
> 1) perform a snapshot of the root filesystem (the rollback one)
> 2) upgrade the filesystem without using sync/fsync
> 3) final (global) sync
> 4) destroy the rollback snapshot

The idea sounds OK, but there are alternatives:

	1) perform snapshot of root filesystem
	2) chroot snapshot eatmydata apt dist-upgrade (*)
	3) sync -f snapshot
	4) renameat2(..., snapshot, ..., root, RENAME_EXCHANGE)
	5) delete snapshot

(*) OK you have to set up /dev, /proc, /sys, etc, probably a whole
namespace.

This may not play well with maintainer scripts on some distros, but it
does mean you don't have a half-broken system _during_ the upgrade.

Sometimes when I have a really problematic upgrade I rsync the system
to another box, do the upgrade there, and then rsync the system back
to the problematic box.  As a side-effect it also allows me to do a
verification test to make sure the upgrade worked before throwing it
onto a production system.  The snapshot/rollback thing would be a
local version of that.

> If an unclean shutdown happens between 1) and 4), two subvolume exists:
> the 'main' one and the 'rollback' one (which is the snapshot before the
> update). In this case the system at boot time should mount the "rollback"
> subvolume instead of the "main" one. Otherwise in case of a "clean" boot, the
> "rollback" subvolume doesn't exist and only the "main" one can be
> mounted.
> 
> In [1] I discussed a way to implement the steps 1 to 4. (ok, I missed
> the point 3) ).
> 
> The part that was missed until now, is an automatic way to mount the rollback
> subvolume at boot time when it is present.
> 
> My idea is to allow more 'subvol=' option. In this case BTRFS tries all the
> passed subvolumes until the first succeed. So invoking the kernel as:
> 
>   linux root=UUID=xxxx rootflags=subvol=rollback,subvol=main ro 
> 
> First, the kernel tries to mount the 'rollback' subvolume. If the rollback
> subvolume doesn't exist then it mounts the 'main' subvolume.

This could be done already from the initramfs.

> Of course after the mount, the system should perform a cleanup of the
> subvolumes: i.e. if a rollback subvolume exists, the system should destroy
> the "main" one (which contains garbage) and rename "rollback" to "main".
> To be more precise:
> 
> 	if test -d "rollback"; then
> 		if test -d "old"; then
> 			btrfs sub del "old"
> 		fi
> 		if test -d "main"; then
> 			mv "main" "old"
> 		fi
> 		mv "rollback" "main"
> 		btrfs sub del "old"
> 	fi
> 
> Comments are welcome
> BR
> G.Baroncelli
> 
> [1] http://lore.kernel.org/linux-btrfs/69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it/
> 
> P.S.
> I am guessing if an idea like this can be applied to a file. E.g. a sqlite
> database that instead of reling to sync/fsync, creates a reflink file as
> "rollback" if something goes wrong.... The ordering is preserved. Not the
> duration.
> 
