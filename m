Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA80518C40
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEIOsS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 10:48:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfEIOsS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 10:48:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90913ACB1;
        Thu,  9 May 2019 14:48:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0A637DA8DC; Thu,  9 May 2019 16:49:15 +0200 (CEST)
Date:   Thu, 9 May 2019 16:49:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: Flush before reflinking any extent to prevent
 NOCOW write falling back to CoW without data reservation
Message-ID: <20190509144915.GV20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190508104958.18363-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508104958.18363-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 08, 2019 at 06:49:58PM +0800, Qu Wenruo wrote:
> [BUG]
> The following script can cause unexpected fsync failure:
> 
>   #!/bin/bash
> 
>   dev=/dev/test/test
>   mnt=/mnt/btrfs
> 
>   mkfs.btrfs -f $dev -b 512M > /dev/null
>   mount $dev $mnt -o nospace_cache
> 
>   # Prealloc one extent
>   xfs_io -f -c "falloc 8k 64m" $mnt/file1
>   # Fill the remaining data space
>   xfs_io -f -c "pwrite 0 -b 4k 512M" $mnt/padding
>   sync
> 
>   # Write into the prealloc extent
>   xfs_io -c "pwrite 1m 16m" $mnt/file1
> 
>   # Reflink then fsync, fsync would fail due to ENOSPC
>   xfs_io -c "reflink $mnt/file1 8k 0 4k" -c "fsync" $mnt/file1
>   umount $dev
> 
> The fsync fails with ENOSPC, and the last page of the buffered write is
> lost.
> 
> [CAUSE]
> This is caused by:
> - Btrfs' back reference only has extent level granularity
>   So write into shared extent must be CoWed even only part of the extent
>   is shared.
> 
> So for above script we have:
> - fallocate
>   Create a preallocated extent where we can do NOCOW write.
> 
> - fill all the remaining data and unallocated space
> 
> - buffered write into preallocated space
>   As we have not enough space available for data and the extent is not
>   shared (yet) we fall into NOCOW mode.
> 
> - reflink
>   Now part of the large preallocated extent is shared, later write
>   into that extent must be CoWed.
> 
> - fsync triggers writeback
>   But now the extent is shared and therefore we must fallback into COW
>   mode, which fails with ENOSPC since there's not enough space to
>   allocate data extents.
> 
> [WORKAROUND]
> The workaround is to ensure any buffered write in the related extents
> (not just the reflink source range) get flushed before reflink/dedupe,
> so that NOCOW writes succeed that happened before reflinking succeed.
> 
> The workaround is expensive

Can you please quantify that, how big the performance drop is going to
be?

If the fsync comes soon after reflink, then it's effectively no change.
In case the buffered writes happen on a different range than reflink and
fsync comes later, the buffered writes will stall reflink, right?

If there are other similar corner cases we'd better know them in advance
and estimate the impact, that'll be something to look for when we get
complaints that reflink is suddenly slow.

> NOCOW range, but that needs extra accounting for NOCOW range.
> For now, fix the possible data loss first.

filemap_flush says

 437 /**
 438  * filemap_flush - mostly a non-blocking flush
 439  * @mapping:    target address_space
 440  *
 441  * This is a mostly non-blocking flush.  Not suitable for data-integrity
 442  * purposes - I/O may not be started against all dirty pages.
 443  *
 444  * Return: %0 on success, negative error code otherwise.
 445  */

so how does this work together with the statement about preventing data
loss?
