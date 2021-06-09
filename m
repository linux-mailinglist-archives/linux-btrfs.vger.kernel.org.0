Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25F03A1B0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 18:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhFIQgT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 12:36:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhFIQgS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 12:36:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A49321FD5E;
        Wed,  9 Jun 2021 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623256462;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6RW9GXhtrxu1U/fqugoZyGOBOmrC8annheH2ufgLmE=;
        b=SekJs0jjVdqrZT0APCOHfCo3uK6K8Bb0ksTdLkVlSr9SmEkshdOfs6FHaY+s+A5kfyJaht
        o2OiEXl4dI7MNSd9Jy5d4mYdtt9gMMcMl2sy2oz8CAb9TCbeRGSmFODNamTR6o+y0GHdB5
        fm1s8gkfOoWsK9n3Ur9KlSENSGtC9oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623256462;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6RW9GXhtrxu1U/fqugoZyGOBOmrC8annheH2ufgLmE=;
        b=7Zj63LIH0GYCNgCsEEbGK1WRN98ijEWTB8KY86EUbbJNsqzHHpY26LLzNhom6qYM/ceXCW
        gtBgAmCMhAdX/ADg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9EBC7A3B81;
        Wed,  9 Jun 2021 16:34:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8630DDA8C5; Wed,  9 Jun 2021 18:31:38 +0200 (CEST)
Date:   Wed, 9 Jun 2021 18:31:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix invalid path for unlink operations
 after parent orphanization
Message-ID: <20210609163138.GD27283@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <375bc37e9eb10cef96fe9f37d89b598737943499.1623234153.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375bc37e9eb10cef96fe9f37d89b598737943499.1623234153.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 09, 2021 at 11:25:03AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During an incremental send operation, when processing the new references
> for the current inode, we might send an unlink operation for another inode
> that has a conflicting path and has more than one hard link. However this
> path was computed and cached before we processed previous new references
> for the current inode. We may have orphanized a directory of that path
> while processing a previous new reference, in which case the path will
> be invalid and cause the receiver process to fail.
> 
> The following reproducer triggers the problem and explains how/why it
> happens in its comments:
> 
>   $ cat test-send-unlink.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdi
>   MNT=/mnt/sdi
> 
>   mkfs.btrfs -f $DEV >/dev/null
>   mount $DEV $MNT
> 
>   # Create our test files and directory. Inode 259 (file3) has two hard
>   # links.
>   touch $MNT/file1
>   touch $MNT/file2
>   touch $MNT/file3
> 
>   mkdir $MNT/A
>   ln $MNT/file3 $MNT/A/hard_link
> 
>   # Filesystem looks like:
>   #
>   # .                                     (ino 256)
>   # |----- file1                          (ino 257)
>   # |----- file2                          (ino 258)
>   # |----- file3                          (ino 259)
>   # |----- A/                             (ino 260)
>   #        |---- hard_link                (ino 259)
>   #
> 
>   # Now create the base snapshot, which is going to be the parent snapshot
>   # for a later incremental send.
>   btrfs subvolume snapshot -r $MNT $MNT/snap1
>   btrfs send -f /tmp/snap1.send $MNT/snap1
> 
>   # Move inode 257 into directory inode 260. This results in computing the
>   # path for inode 260 as "/A" and caching it.
>   mv $MNT/file1 $MNT/A/file1
> 
>   # Move inode 258 (file2) into directory inode 260, with a name of
>   # "hard_link", moving first inode 259 away since it currently has that
>   # location and name.
>   mv $MNT/A/hard_link $MNT/tmp
>   mv $MNT/file2 $MNT/A/hard_link
> 
>   # Now rename inode 260 to something else (B for example) and then create
>   # a hard link for inode 258 that has the old name and location of inode
>   # 260 ("/A").
>   mv $MNT/A $MNT/B
>   ln $MNT/B/hard_link $MNT/A
> 
>   # Filesystem now looks like:
>   #
>   # .                                     (ino 256)
>   # |----- tmp                            (ino 259)
>   # |----- file3                          (ino 259)
>   # |----- B/                             (ino 260)
>   # |      |---- file1                    (ino 257)
>   # |      |---- hard_link                (ino 258)
>   # |
>   # |----- A                              (ino 258)
> 
>   # Create another snapshot of our subvolume and use it for an incremental
>   # send.
>   btrfs subvolume snapshot -r $MNT $MNT/snap2
>   btrfs send -f /tmp/snap2.send -p $MNT/snap1 $MNT/snap2
> 
>   # Now unmount the filesystem, create a new one, mount it and try to
>   # apply both send streams to recreate both snapshots.
>   umount $DEV
> 
>   mkfs.btrfs -f $DEV >/dev/null
> 
>   mount $DEV $MNT
> 
>   # First add the first snapshot to the new filesystem by applying the
>   # first send stream.
>   btrfs receive -f /tmp/snap1.send $MNT
> 
>   # The incremental receive operation below used to fail with the
>   # following error:
>   #
>   #    ERROR: unlink A/hard_link failed: No such file or directory
>   #
>   # This is because when send is processing inode 257, it generates the
>   # path for inode 260 as "/A", since that inode is its parent in the send
>   # snapshot, and caches that path.
>   #
>   # Later when processing inode 258, it first processes its new reference
>   # that has the path of "/A", which results in orphanizing inode 260
>   # because there is a a path collision. This results in issuing a rename
>   # operation from "/A" to "/o260-6-0".
>   #
>   # Finally when processing the new reference "B/hard_link" for inode 258,
>   # it notices that it collides with inode 259 (not yet processed, because
>   # it has a higher inode number), since that inode has the name
>   # "hard_link" under the directory inode 260. It also checks that inode
>   # 259 has two hardlinks, so it decides to issue a unlink operation for
>   # the name "hard_link" for inode 259. However the path passed to the
>   # unlink operation is "/A/hard_link", which is incorrect since currently
>   # "/A" does not exists, due to the orphanization of inode 260 mentioned
>   # before. The path is incorrect because it was computed and cached
>   # before the orphanization. This results in the receiver to fail with
>   # the above error.
>   btrfs receive -f /tmp/snap2.send $MNT
> 
>   umount $MNT
> 
> When running the test, it fails like this:
> 
>   $ ./test-send-unlink.sh
>   Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap1'
>   At subvol /mnt/sdi/snap1
>   Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap2'
>   At subvol /mnt/sdi/snap2
>   At subvol snap1
>   At snapshot snap2
>   ERROR: unlink A/hard_link failed: No such file or directory
> 
> Fix this by recomputing a path before issuing an unlink operation when
> processing the new references for the current inode if we previously
> have orphanized a directory.
> 
> A test case for fstests will follow soon.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
