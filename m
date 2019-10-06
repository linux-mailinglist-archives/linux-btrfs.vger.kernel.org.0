Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEDCD9A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 01:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfJFX2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Oct 2019 19:28:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:46092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfJFX2W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 6 Oct 2019 19:28:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DA35B13A;
        Sun,  6 Oct 2019 23:28:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4825DDA7FB; Mon,  7 Oct 2019 01:28:35 +0200 (CEST)
Date:   Mon, 7 Oct 2019 01:28:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: code cleanup for compression type
Message-ID: <20191006232834.GY2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chengguang Xu <cgxu519@mykernel.net>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20191005051736.29857-1-cgxu519@mykernel.net>
 <20191005051736.29857-2-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005051736.29857-2-cgxu519@mykernel.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 05, 2019 at 01:17:35PM +0800, Chengguang Xu wrote:
> Let BTRFS_COMPRESS_TYPES represents the total number
> of cmpressoin types and fix related calling places.
> It will be more safe when adding new compression type
> in the future.

I think we're not going to add a new type anytime soon, zstd provides
the choice between fast and good ratio. This itself is not an objection
to your patch but is not IMO the true reason for the changes.

Can you please describe the motivation behind the patches? Eg. if it's a
general cleanup or if there are other changes planned on top.

> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/btrfs/compression.c  |  2 ++
>  fs/btrfs/compression.h  | 12 ++++++------
>  fs/btrfs/ioctl.c        |  2 +-
>  fs/btrfs/tree-checker.c |  4 ++--
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index d70c46407420..93deaf0cc2b8 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -39,6 +39,8 @@ const char* btrfs_compress_type2str(enum btrfs_compression_type type)
>  	case BTRFS_COMPRESS_ZSTD:
>  	case BTRFS_COMPRESS_NONE:
>  		return btrfs_compress_types[type];
> +	default:
> +		break;
>  	}
>  
>  	return NULL;
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index dd392278ab3f..091ff3f986e5 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -101,11 +101,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
>  
>  enum btrfs_compression_type {
> -	BTRFS_COMPRESS_NONE  = 0,
> -	BTRFS_COMPRESS_ZLIB  = 1,
> -	BTRFS_COMPRESS_LZO   = 2,
> -	BTRFS_COMPRESS_ZSTD  = 3,
> -	BTRFS_COMPRESS_TYPES = 3,
> +	BTRFS_COMPRESS_NONE,
> +	BTRFS_COMPRESS_ZLIB,
> +	BTRFS_COMPRESS_LZO,
> +	BTRFS_COMPRESS_ZSTD,
> +	BTRFS_COMPRESS_TYPES

Please note that the on-disk format values should be expressed by the
values, even if it's the same as the automatic enum assignments.

Regarding change of the BTRFS_COMPRESS_TYPES value, I vaguely remember
we had patches for that but I don't recall why it was not changed. The
progs have an extra BTRFS_COMPRESS_LAST (== 4) that would be used the
same way as you do in this patch.

BTRFS_COMPRESS_* is not in the public API so changing the value should
be safe, but needs double checking.

>  };
>  
>  struct workspace_manager {
> @@ -163,7 +163,7 @@ struct btrfs_compress_op {
>  };
>  
>  /* The heuristic workspaces are managed via the 0th workspace manager */
> -#define BTRFS_NR_WORKSPACE_MANAGERS	(BTRFS_COMPRESS_TYPES + 1)
> +#define BTRFS_NR_WORKSPACE_MANAGERS	BTRFS_COMPRESS_TYPES
>  
>  extern const struct btrfs_compress_op btrfs_heuristic_compress;
>  extern const struct btrfs_compress_op btrfs_zlib_compress;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index de730e56d3f5..8c7196ed7ae0 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1411,7 +1411,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>  		return -EINVAL;
>  
>  	if (do_compress) {
> -		if (range->compress_type > BTRFS_COMPRESS_TYPES)
> +		if (range->compress_type >= BTRFS_COMPRESS_TYPES)
>  			return -EINVAL;
>  		if (range->compress_type)
>  			compress_type = range->compress_type;
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index f28f9725cef1..2d91c34bbf63 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -168,11 +168,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  	 * Support for new compression/encryption must introduce incompat flag,
>  	 * and must be caught in open_ctree().
>  	 */
> -	if (btrfs_file_extent_compression(leaf, fi) > BTRFS_COMPRESS_TYPES) {
> +	if (btrfs_file_extent_compression(leaf, fi) >= BTRFS_COMPRESS_TYPES) {
>  		file_extent_err(leaf, slot,
>  	"invalid compression for file extent, have %u expect range [0, %u]",
>  			btrfs_file_extent_compression(leaf, fi),
> -			BTRFS_COMPRESS_TYPES);
> +			BTRFS_COMPRESS_TYPES - 1);
>  		return -EUCLEAN;
>  	}
>  	if (btrfs_file_extent_encryption(leaf, fi)) {
> -- 
> 2.21.0
> 
> 
> 
