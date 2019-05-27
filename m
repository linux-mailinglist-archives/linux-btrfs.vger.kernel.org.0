Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EB2B855
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE0PU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 11:20:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfE0PUW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 11:20:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FA2CAF05;
        Mon, 27 May 2019 15:20:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A767DA85E; Mon, 27 May 2019 17:21:16 +0200 (CEST)
Date:   Mon, 27 May 2019 17:21:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: incremental send, fix file corruption when
 no-holes feature is enabled
Message-ID: <20190527152116.GM15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190520085542.29282-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520085542.29282-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 20, 2019 at 09:55:42AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the no-holes feature, if we have a file with prealloc extents
> with a start offset beyond the file's eof, doing an incremental send can
> cause corruption of the file due to incorrect hole detection. Such case
> requires that the prealloc extent(s) exist in both the parent and send
> snapshots, and that a hole is punched into the file that covers all its
> extents that do not cross the eof boundary.
> 
> Example reproducer:
> 
>   $ mkfs.btrfs -f -O no-holes /dev/sdb
>   $ mount /dev/sdb /mnt/sdb
> 
>   $ xfs_io -f -c "pwrite -S 0xab 0 500K" /mnt/sdb/foobar
>   $ xfs_io -c "falloc -k 1200K 800K" /mnt/sdb/foobar
> 
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base
> 
>   $ btrfs send -f /tmp/base.snap /mnt/sdb/base
> 
>   $ xfs_io -c "fpunch 0 500K" /mnt/sdb/foobar
> 
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr
> 
>   $ btrfs send -p /mnt/sdb/base -f /tmp/incr.snap /mnt/sdb/incr
> 
>   $ md5sum /mnt/sdb/incr/foobar
>   816df6f64deba63b029ca19d880ee10a   /mnt/sdb/incr/foobar
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt/sdc
> 
>   $ btrfs receive -f /tmp/base.snap /mnt/sdc
>   $ btrfs receive -f /tmp/incr.snap /mnt/sdc
> 
>   $ md5sum /mnt/sdc/incr/foobar
>   cf2ef71f4a9e90c2f6013ba3b2257ed2   /mnt/sdc/incr/foobar
> 
>     --> Different checksum, because the prealloc extent beyond the
>         file's eof confused the hole detection code and it assumed
>         a hole starting at offset 0 and ending at the offset of the
>         prealloc extent (1200Kb) instead of ending at the offset
>         500Kb (the file's size).
> 
> Fix this by ensuring we never cross the file's size when issuing the
> write operations for a hole.
> 
> Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
> CC: stable@vger.kernel.org # 3.14+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Queued for 5.2-rc, thanks.
