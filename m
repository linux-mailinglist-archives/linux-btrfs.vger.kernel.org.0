Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AD2FF0F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbhAUQuI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 11:50:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:40120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbhAUQtp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 11:49:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69EE2AAAE;
        Thu, 21 Jan 2021 16:49:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C853CDA6E3; Thu, 21 Jan 2021 17:47:06 +0100 (CET)
Date:   Thu, 21 Jan 2021 17:47:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: rework the order of btrfs_ordered_extent::flags
Message-ID: <20210121164706.GD6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210121061354.61271-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121061354.61271-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 02:13:54PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a long existing bug in the last parameter of
> btrfs_add_ordered_extent(), in commit 771ed689d2cd ("Btrfs: Optimize
> compressed writeback and reads") back to 2008.
> 
> In that ancient commit btrfs_add_ordered_extent() expects the @type
> parameter to be one of the following:
> - BTRFS_ORDERED_REGULAR
> - BTRFS_ORDERED_NOCOW
> - BTRFS_ORDERED_PREALLOC
> - BTRFS_ORDERED_COMPRESSED
> 
> But we pass 0 in cow_file_range(), which means BTRFS_ORDERED_IO_DONE.
> 
> Ironically extra check in __btrfs_add_ordered_extent() won't set the bit
> if we're seeing (type == IO_DONE || type == IO_COMPLETE), and avoid any
> obvious bug.
> 
> But this still leads to regular COW ordered extent having no bit to
> indicate its type in various trace events, rendering REGULAR bit
> useless.
> 
> [FIX]
> This patch will change the following aspects to avoid such problem:
> - Reorder btrfs_ordered_extent::flags
>   Now the type bits go first (REGULAR/NOCOW/PREALLCO/COMPRESSED), then
>   DIRECT bit, finally extra status bits like IO_DONE/COMPLETE/IOERR.
> 
> - Add extra ASSERT() for btrfs_add_ordered_extent_*()
> 
> - Remove @type parameter for btrfs_add_ordered_extent_compress()
>   As the only valid @type here is BTRFS_ORDERED_COMPRESSED.
> 
> - Remove the unnecessary special check for IO_DONE/COMPLETE in
>   __btrfs_add_ordered_extent()
>   This is just to make the code work, with extra ASSERT(), there are
>   limited values can be passed in.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next thanks.

> ---
>  fs/btrfs/inode.c             |  4 ++--
>  fs/btrfs/ordered-data.c      | 18 +++++++++++++-----
>  fs/btrfs/ordered-data.h      | 37 +++++++++++++++++++++++-------------
>  include/trace/events/btrfs.h |  7 ++++---
>  4 files changed, 43 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ef6cb7b620d0..ea9056cc5559 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -917,7 +917,6 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
>  						ins.objectid,
>  						async_extent->ram_size,
>  						ins.offset,
> -						BTRFS_ORDERED_COMPRESSED,
>  						async_extent->compress_type);
>  		if (ret) {
>  			btrfs_drop_extent_cache(inode, async_extent->start,
> @@ -1127,7 +1126,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		free_extent_map(em);
>  
>  		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
> -					       ram_size, cur_alloc_size, 0);
> +					       ram_size, cur_alloc_size,
> +					       BTRFS_ORDERED_REGULAR);
>  		if (ret)
>  			goto out_drop_extent_cache;
>  
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index d5d326c674b1..bd7e187d9b16 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -199,8 +199,11 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
>  	entry->compress_type = compress_type;
>  	entry->truncated_len = (u64)-1;
>  	entry->qgroup_rsv = ret;
> -	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
> -		set_bit(type, &entry->flags);
> +
> +	ASSERT(type == BTRFS_ORDERED_REGULAR || type == BTRFS_ORDERED_NOCOW ||
> +	       type == BTRFS_ORDERED_PREALLOC ||
> +	       type == BTRFS_ORDERED_COMPRESSED);

I've reformatted that so that all the checks are on separate lines, it's
easier to read though it does not fill the whole line.

> +	set_bit(type, &entry->flags);
>  
>  	if (dio) {
>  		percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
> @@ -256,6 +259,8 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
>  			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
>  			     int type)
>  {
> +	ASSERT(type == BTRFS_ORDERED_REGULAR || type == BTRFS_ORDERED_NOCOW ||
> +	       type == BTRFS_ORDERED_PREALLOC);
>  	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
>  					  num_bytes, disk_num_bytes, type, 0,
>  					  BTRFS_COMPRESS_NONE);
> @@ -265,6 +270,8 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
>  				 u64 disk_bytenr, u64 num_bytes,
>  				 u64 disk_num_bytes, int type)
>  {
> +	ASSERT(type == BTRFS_ORDERED_REGULAR || type == BTRFS_ORDERED_NOCOW ||
> +	       type == BTRFS_ORDERED_PREALLOC);
>  	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
>  					  num_bytes, disk_num_bytes, type, 1,
>  					  BTRFS_COMPRESS_NONE);
> @@ -272,11 +279,12 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
>  
>  int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
>  				      u64 disk_bytenr, u64 num_bytes,
> -				      u64 disk_num_bytes, int type,
> -				      int compress_type)
> +				      u64 disk_num_bytes, int compress_type)
>  {
> +	ASSERT(compress_type != BTRFS_COMPRESS_NONE);
>  	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
> -					  num_bytes, disk_num_bytes, type, 0,
> +					  num_bytes, disk_num_bytes,
> +					  BTRFS_ORDERED_COMPRESSED, 0,
>  					  compress_type);
>  }
>  
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 46194c2c05d4..151ec6bba405 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -27,7 +27,7 @@ struct btrfs_ordered_sum {
>  };
>  
>  /*
> - * bits for the flags field:
> + * Bits for btrfs_ordered_extent::flags.
>   *
>   * BTRFS_ORDERED_IO_DONE is set when all of the blocks are written.
>   * It is used to make sure metadata is inserted into the tree only once
> @@ -38,24 +38,36 @@ struct btrfs_ordered_sum {
>   * IO is done and any metadata is inserted into the tree.
>   */
>  enum {
> +	/*
> +	 * Different types for direct io, one and only one of the 4 type can

direct io

> +	 * be set when creating ordered extent.
> +	 *
> +	 * REGULAR:	For regular non-compressed COW write
> +	 * NOCOW:	For NOCOW write into existing non-hole extent
> +	 * PREALLOC:	For NOCOW write into preallocated extent
> +	 * COMPRESSED:	For compressed COW write
> +	 */
> +	BTRFS_ORDERED_REGULAR,
> +	BTRFS_ORDERED_NOCOW,
> +	BTRFS_ORDERED_PREALLOC,
> +	BTRFS_ORDERED_COMPRESSED,
> +
> +	/*
> +	 * Extra bit for DirectIO, can only be set for

DirectIO

> +	 * REGULAR/NOCOW/PREALLOC. No DIO for compressed extent.

DIO

Three different ways to spell that but one is enough. Fixed.
