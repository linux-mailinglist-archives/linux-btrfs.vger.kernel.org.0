Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CD3182A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 01:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBKA1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 19:27:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:60100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhBKA1k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 19:27:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10E54AD2B;
        Thu, 11 Feb 2021 00:26:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5CE8ADA6E9; Thu, 11 Feb 2021 01:25:04 +0100 (CET)
Date:   Thu, 11 Feb 2021 01:25:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove workaround for setting capabilities
 in the receive command
Message-ID: <20210211002504.GC1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <e35e5d556cd5964a4ab80bdd997856ee5be8b888.1612870936.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35e5d556cd5964a4ab80bdd997856ee5be8b888.1612870936.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 09, 2021 at 11:49:12AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We had a few bugs on the kernel side of send/receive where capabilities
> ended up being lost after receiving a send stream. They all stem from the
> fact that the kernel used to send all xattrs before issuing the chown
> command, and the later clears any existing capabilities in a file or
> directory.
> 
> Initially a workaround was added to btrfs-progs' receive command, in commit
> 123a2a085027e ("btrfs-progs: receive: restore capabilities after chown"),
> and that fixed some instances of the problem. More recently, other instances
> of the problem were found, a proper fix for the kernel was made, which fixes
> the root problem by making send always emit the sexattr command for setting
> capabilities after issuing a chown command. This was done in kernel commit
> 89efda52e6b693 ("btrfs: send: emit file capabilities after chown"), which
> landed in kernel 5.8.
> 
> However, the workaround on the receive command now causes us to incorrectly
> set a capability on a file that should not have it, because it assumes all
> setxattr commands for a file always comes before a chown.
> 
> Example reproducer:
> 
>   $ cat send-caps.sh
>   #!/bin/bash
> 
>   DEV1=/dev/sdh
>   DEV2=/dev/sdi
> 
>   MNT1=/mnt/sdh
>   MNT2=/mnt/sdi
> 
>   mkfs.btrfs -f $DEV1 > /dev/null
>   mkfs.btrfs -f $DEV2 > /dev/null
> 
>   mount $DEV1 $MNT1
>   mount $DEV2 $MNT2
> 
>   touch $MNT1/foo
>   touch $MNT1/bar
>   setcap cap_net_raw=p $MNT1/foo
> 
>   btrfs subvolume snapshot -r $MNT1 $MNT1/snap1
> 
>   btrfs send $MNT1/snap1 | btrfs receive $MNT2
> 
>   echo
>   echo "capabilities on destination filesystem:"
>   echo
>   getcap $MNT2/snap1/foo
>   getcap $MNT2/snap1/bar
> 
>   umount $MNT1
>   umount $MNT2
> 
> When running the test script, we can see that both files foo and bar get
> the capability set, when only file foo should have it:
> 
>   $ ./send-caps.sh
>   Create a readonly snapshot of '/mnt/sdh' in '/mnt/sdh/snap1'
>   At subvol /mnt/sdh/snap1
>   At subvol snap1
> 
>   capabilities on destination filesystem:
> 
>   /mnt/sdi/snap1/foo cap_net_raw=p
>   /mnt/sdi/snap1/bar cap_net_raw=p
> 
> Since the kernel fix was backported to all currently supported stable
> releases (5.10.x, 5.4.x, 4.19.x, 4.14.x, 4.9.x and 4.4.x), remove the
> workaround from receive. Having such a workaround relying on the order
> of commands in a send stream is always troublesome and doomed to break
> one day.
> 
> A test case for fstests will come soon.
> 
> Reported-by: Richard Brown <rbrown@suse.de>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks. I'm going to add a btrfs-progs test case as well, based on the
script in the changelog.
