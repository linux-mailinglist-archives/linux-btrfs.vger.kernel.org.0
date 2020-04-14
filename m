Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B41A808F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405476AbgDNO6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 10:58:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405178AbgDNO6n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 10:58:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A049DACE3;
        Tue, 14 Apr 2020 14:58:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07FF3DA72D; Tue, 14 Apr 2020 16:58:01 +0200 (CEST)
Date:   Tue, 14 Apr 2020 16:58:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     stijn rutjens <rutjensstijn@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow setting per extent compression
Message-ID: <20200414145801.GR5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, stijn rutjens <rutjensstijn@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+UfgrWR1rn-VbHHcK0+2cN08m0C529NtY-ofUMNX3mM4NoTaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UfgrWR1rn-VbHHcK0+2cN08m0C529NtY-ofUMNX3mM4NoTaw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Sun, Apr 12, 2020 at 10:57:03AM +0200, stijn rutjens wrote:
> Hi all,
> As mentioned in https://github.com/kdave/btrfs-progs/issues/184 it
> would be nice to be able to set the compression level per extent (or
> file) from the IOCTL interface.
> I'm not sure how submitting patches to mailing lists works, but I have
> attached a patch which implements this. Any and all feedback is
> appreciated.

thanks for sending it, I don't insist on the patch formatting etc as
long as we have code to discuss, adding the signed-off-by tags is easy
and not the most imporatnt thing at the moment.

So the idea is to allow passing compression level to the defrag ioctl
where it applies to the files, regardless of other compression settings
like mount options or properties.

This has several parts:

* make the code accept the type and level, ie. it has to filter out the
  level which is what your patch mostly does

* keep compatibility with older kernels and newer tools, so the
  type+level is refused by older kernels

* priority of the level when there are more settings to choose from
  (inode, mount, ioctl)

* on-disk format

> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index bb374042d..e1603e1cf 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -67,7 +67,7 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
>  	btrfs_set_file_extent_ram_bytes(leaf, item, ram_bytes);
>  	btrfs_set_file_extent_generation(leaf, item, trans->transid);
>  	btrfs_set_file_extent_type(leaf, item, BTRFS_FILE_EXTENT_REG);
> -	btrfs_set_file_extent_compression(leaf, item, compression);
> +	btrfs_set_file_extent_compression(leaf, item, compression & 0xF);

As a general comment, open coding the level as "& 0xf" should be replaced
with a helper.

But in all cases where btrfs_set_file_extent_compression is called,
there shluld be already only the type. Ie. it's up to the calling code
to pass the correct value. An assert would be good.

The number of entry points where the type and level are available is
limited to ioctls or properties and the level is not part of the on-disk
format so all code that handles the format should assume the value is
valid.

>  	btrfs_set_file_extent_encryption(leaf, item, encryption);
>  	btrfs_set_file_extent_other_encoding(leaf, item, other_encoding);
>  
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index dbc9bcaf5..3285d4bd3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -227,7 +227,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  			compressed_size -= cur_size;
>  		}
>  		btrfs_set_file_extent_compression(leaf, ei,
> -						  compress_type);
> +						  compress_type & 0XF);
>  	} else {
>  		page = find_get_page(inode->i_mapping,
>  				     start >> PAGE_SHIFT);
> @@ -573,14 +573,31 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>  		}
>  
>  		/* Compression level is applied here and only here */
> -		ret = btrfs_compress_pages(
> -			compress_type | (fs_info->compress_level << 4),
> -					   inode->i_mapping, start,
> -					   pages,
> -					   &nr_pages,
> -					   &total_in,
> -					   &total_compressed);
> -
> +		/*
> +		 * Check if the upper bits are set, and if so,
> +		 * take them as the compression level.
> +		 * the inode compression level takes precendence, if set
> +		 */
> +		if ((compress_type & 0xF) == compress_type) {

So this is a default behaviour, if no level is specified, take whatever
default is there. Ok.

> +			ret = btrfs_compress_pages(
> +				compress_type | (fs_info->compress_level << 4),
> +						inode->i_mapping, start,
> +						pages,
> +						&nr_pages,
> +						&total_in,
> +						&total_compressed);
> +		} else {
> +			int compress_level = btrfs_compress_set_level(
> +						compress_type & 0xF,
> +						compress_type>>4);

Otherwise use the level specified by the user, that's the intended
usecase.

> +			ret = btrfs_compress_pages(
> +				compress_type | (compress_level << 4),
> +				inode->i_mapping, start,
> +				pages,
> +				&nr_pages,
> +				&total_in,
> +				&total_compressed);
> +		}
>  		if (!ret) {
>  			unsigned long offset = offset_in_page(total_compressed);
>  			struct page *page = pages[nr_pages - 1];
> @@ -2362,7 +2379,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
>  	btrfs_set_file_extent_offset(leaf, fi, 0);
>  	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
>  	btrfs_set_file_extent_ram_bytes(leaf, fi, ram_bytes);
> -	btrfs_set_file_extent_compression(leaf, fi, compression);
> +	btrfs_set_file_extent_compression(leaf, fi, compression & 0xF);
>  	btrfs_set_file_extent_encryption(leaf, fi, encryption);
>  	btrfs_set_file_extent_other_encoding(leaf, fi, other_encoding);
>  
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0fa1c386d..2a9c1f312 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1414,7 +1414,11 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>  		return -EINVAL;
>  
>  	if (do_compress) {
> -		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> +		/*
> +		* The bottom 4 bits of compress_type are for used for the
> +		* compression type, the other bits for the compression level
> +		*/
> +		if ((range->compress_type & 0xF) >= BTRFS_NR_COMPRESS_TYPES)
>  			return -EINVAL;

For the backward compatibility, the check without "& 0xf" is sufficient,
but a new flag is needed to actually tell the ioctl code to read the
level. I'm not sure that relying on automatic parsing of the high 4 bits
is a good idea, usually all new data are accompanied by new flags.

>  		if (range->compress_type)
>  			compress_type = range->compress_type;
> @@ -1572,9 +1576,9 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>  			filemap_flush(inode->i_mapping);
>  	}
>  
> -	if (range->compress_type == BTRFS_COMPRESS_LZO) {
> +	if ((range->compress_type & 0xF) == BTRFS_COMPRESS_LZO) {
>  		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> -	} else if (range->compress_type == BTRFS_COMPRESS_ZSTD) {
> +	} else if ((range->compress_type & 0xF) == BTRFS_COMPRESS_ZSTD) {
>  		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
>  	}

For further iterations of the patch, I suggest to split it into more
patches by logical change, like adding helpers, extending the ioctl,
adding asserts, etc.

I haven't found any obstacles, the core of the work is already in this
patch, remaining is the interface bits and polishing the code.
