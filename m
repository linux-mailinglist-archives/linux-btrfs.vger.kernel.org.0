Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6862C1FD4FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 20:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFQS5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 14:57:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFQS5o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 14:57:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1C7C0AAC3;
        Wed, 17 Jun 2020 18:57:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AAE62DA728; Wed, 17 Jun 2020 20:57:32 +0200 (CEST)
Date:   Wed, 17 Jun 2020 20:57:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Martin Doucha <martin.doucha@suse.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: Allow btrfs_truncate_block() to fallback to
 nocow for data space reservation
Message-ID: <20200617185730.GQ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Martin Doucha <martin.doucha@suse.com>,
        Filipe Manana <fdmanana@suse.com>
References: <20200603062115.16227-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603062115.16227-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 03, 2020 at 02:21:15PM +0800, Qu Wenruo wrote:
> [BUG]
> When the data space is exhausted, even the inode has NOCOW attribute,
> btrfs will still refuse to truncate unaligned range due to ENOSPC.
> 
> The following script can reproduce it pretty easily:
>   #!/bin/bash
> 
>   dev=/dev/test/test
>   mnt=/mnt/btrfs
> 
>   umount $dev &> /dev/null
>   umount $mnt&> /dev/null
> 
>   mkfs.btrfs -f $dev -b 1G
>   mount -o nospace_cache $dev $mnt
>   touch $mnt/foobar
>   chattr +C $mnt/foobar
> 
>   xfs_io -f -c "pwrite -b 4k 0 4k" $mnt/foobar > /dev/null
>   xfs_io -f -c "pwrite -b 4k 0 1G" $mnt/padding &> /dev/null
>   sync
> 
>   xfs_io -c "fpunch 0 2k" $mnt/foobar
>   umount $mnt
> 
> Current btrfs will fail at the fpunch part.
> 
> [CAUSE]
> Because btrfs_truncate_block() always reserve space without checking the
> NOCOW attribute.
> 
> Since the writeback path follows NOCOW bit, we only need to bother the
> space reservation code in btrfs_truncate_block().
> 
> [FIX]
> Make btrfs_truncate_block() to follow btrfs_buffered_write() to try to
> reserve data space first, and falls back to NOCOW check only when we
> don't have enough space.
> 
> Such always-try-reserve is an optimization introduced in
> btrfs_buffered_write(), to avoid expensive btrfs_check_can_nocow() call.
> 
> Since now check_can_nocow() is needed outside of inode.c, also export it
> and rename it to btrfs_check_can_nocow().
> 
> Reported-by: Martin Doucha <martin.doucha@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> Changelog:
> v2:
> - Rebased to misc-next
>   Only one minor conflict in ctree.h
> ---
>  fs/btrfs/ctree.h |  2 ++
>  fs/btrfs/file.c  | 10 +++++-----
>  fs/btrfs/inode.c | 41 ++++++++++++++++++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 161533040978..40e8c8170d39 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2984,6 +2984,8 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
>  		      size_t num_pages, loff_t pos, size_t write_bytes,
>  		      struct extent_state **cached);
>  int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
> +			  size_t *write_bytes);

This does not apply anymore after Filipe's aio nowait fixes, can you
please rebase it on top of current misc-next?
