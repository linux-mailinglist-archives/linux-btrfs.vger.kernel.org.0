Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE152DB17F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 17:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgLOQdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 11:33:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:42162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbgLOQd0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 11:33:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4B98AC7F;
        Tue, 15 Dec 2020 16:32:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91808DA7C3; Tue, 15 Dec 2020 17:31:05 +0100 (CET)
Date:   Tue, 15 Dec 2020 17:31:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send, fix wrong file path when there is an inode
 with a pending rmdir
Message-ID: <20201215163105.GU6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <e3057ad7ddc549dc204593c01adad90545994617.1607601701.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3057ad7ddc549dc204593c01adad90545994617.1607601701.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 12:09:02PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing an incremental send, if we have a new inode that happens to
> have the same number that an old directory inode had in the base snapshot
> and that old directory has a pending rmdir operation, we end up computing
> a wrong path for the new inode, causing the receiver to fail.
> 
> Example reproducer:
> 
>   $ cat test-send-rmdir.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdi
>   MNT=/mnt/sdi
> 
>   mkfs.btrfs -f $DEV >/dev/null
>   mount $DEV $MNT
> 
>   mkdir $MNT/dir
>   touch $MNT/dir/file1
>   touch $MNT/dir/file2
>   touch $MNT/dir/file3
> 
>   # Filesystem looks like:
>   #
>   # .                                     (ino 256)
>   # |----- dir/                           (ino 257)
>   #         |----- file1                  (ino 258)
>   #         |----- file2                  (ino 259)
>   #         |----- file3                  (ino 260)
>   #
> 
>   btrfs subvolume snapshot -r $MNT $MNT/snap1
>   btrfs send -f /tmp/snap1.send $MNT/snap1
> 
>   # Now remove our directory and all its files.
>   rm -fr $MNT/dir
> 
>   # Unmount the filesystem and mount it again. This is to ensure that
>   # the next inode that is created ends up with the same inode number
>   # that our directory "dir" had, 257, which is the first free "objectid"
>   # available after mounting again the filesystem.
>   umount $MNT
>   mount $DEV $MNT
> 
>   # Now create a new file (it could be a directory as well).
>   touch $MNT/newfile
> 
>   # Filesystem now looks like:
>   #
>   # .                                     (ino 256)
>   # |----- newfile                        (ino 257)
>   #
> 
>   btrfs subvolume snapshot -r $MNT $MNT/snap2
>   btrfs send -f /tmp/snap2.send -p $MNT/snap1 $MNT/snap2
> 
>   # Now unmount the filesystem, create a new one, mount it and try to apply
>   # both send streams to recreate both snapshots.
>   umount $DEV
> 
>   mkfs.btrfs -f $DEV >/dev/null
> 
>   mount $DEV $MNT
> 
>   btrfs receive -f /tmp/snap1.send $MNT
>   btrfs receive -f /tmp/snap2.send $MNT
> 
>   umount $MNT
> 
> When running the test, the receive operation for the incremental stream
> fails:
> 
>   $ ./test-send-rmdir.sh
>   Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap1'
>   At subvol /mnt/sdi/snap1
>   Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap2'
>   At subvol /mnt/sdi/snap2
>   At subvol snap1
>   At snapshot snap2
>   ERROR: chown o257-9-0 failed: No such file or directory
> 
> So fix this by tracking directories that have a pending rmdir by inode
> number and generation number, instead of only inode number.
> 
> A test case for fstests follows soon.
> 
> Reported-by: Massimo B. <massimo.b@gmx.net>
> Tested-by: Massimo B. <massimo.b@gmx.net>
> Link: https://lore.kernel.org/linux-btrfs/6ae34776e85912960a253a8327068a892998e685.camel@gmx.net/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
