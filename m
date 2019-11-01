Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0897EC4B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfKAO1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 10:27:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:37642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727031AbfKAO1x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 10:27:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF6FAB1D0;
        Fri,  1 Nov 2019 14:27:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8DB45DA7AF; Fri,  1 Nov 2019 15:28:00 +0100 (CET)
Date:   Fri, 1 Nov 2019 15:28:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: send, allow clone operations within the same file
Message-ID: <20191101142759.GR3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191030122311.31349-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030122311.31349-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 12:23:11PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> For send we currently skip clone operations when the source and destination
> files are the same. This is so because clone didn't support this case in
> its early days, but support for it was added back in May 2013 by commit
> a96fbc72884fcb ("Btrfs: allow file data clone within a file"). This change
> adds support for it.
> 
> Example:
> 
>   $ mkfs.btrfs -f /dev/sdd
>   $ mount /dev/sdd /mnt/sdd
> 
>   $ xfs_io -f -c "pwrite -S 0xab -b 64K 0 64K" /mnt/sdd/foobar
>   $ xfs_io -c "reflink /mnt/sdd/foobar 0 64K 64K" /mnt/sdd/foobar
> 
>   $ btrfs subvolume snapshot -r /mnt/sdd /mnt/sdd/snap
> 
>   $ mkfs.btrfs -f /dev/sde
>   $ mount /dev/sde /mnt/sde
> 
>   $ btrfs send /mnt/sdd/snap | btrfs receive /mnt/sde
> 
> Without this change file foobar at the destination has a single 128Kb
> extent:
> 
>   $ filefrag -v /mnt/sde/snap/foobar
>   Filesystem type is: 9123683e
>   File size of /mnt/sde/snap/foobar is 131072 (32 blocks of 4096 bytes)
>    ext:     logical_offset:        physical_offset: length:   expected: flags:
>      0:        0..      31:          0..        31:     32:             last,unknown_loc,delalloc,eof
>   /mnt/sde/snap/foobar: 1 extent found
> 
> With this we get a single 64Kb extent that is shared at file offsets 0
> and 64K, just like in the source filesystem:
> 
>   $ filefrag -v /mnt/sde/snap/foobar
>   Filesystem type is: 9123683e
>   File size of /mnt/sde/snap/foobar is 131072 (32 blocks of 4096 bytes)
>    ext:     logical_offset:        physical_offset: length:   expected: flags:
>      0:        0..      15:       3328..      3343:     16:             shared
>      1:       16..      31:       3328..      3343:     16:       3344: last,shared,eof
>   /mnt/sde/snap/foobar: 2 extents found
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
