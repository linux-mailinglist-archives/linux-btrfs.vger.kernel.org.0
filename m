Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB5210B636
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 19:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfK0Sz1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 13:55:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0Sz1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 13:55:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF190AAC2;
        Wed, 27 Nov 2019 18:55:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90778DA733; Wed, 27 Nov 2019 19:55:23 +0100 (CET)
Date:   Wed, 27 Nov 2019 19:55:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Open code __btrfs_free_reserved_extent in
 btrfs_free_reserved_extent
Message-ID: <20191127185523.GY2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191121120331.29070-1-nborisov@suse.com>
 <20191121120331.29070-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121120331.29070-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 21, 2019 at 02:03:30PM +0200, Nikolay Borisov wrote:
> __btrfs_free_reserved_extent performs 2 entirely different operations
> depending on whether its 'pin' argument is true or false. This patch
> lifts the 2nd case (pin is false) into it's sole caller
> btrfs_free_reserved_extent. No semantics changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 613c7bbf5cbd..dae6f8d07852 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4164,17 +4164,7 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
>  		return -ENOSPC;
>  	}
>  
> -	if (pin) {
> -		ret = pin_down_extent(cache, start, len, 1);
> -		if (ret)
> -			goto out;
> -	} else {
> -		btrfs_add_free_space(cache, start, len);
> -		btrfs_free_reserved_bytes(cache, len, delalloc);
> -		trace_btrfs_reserved_extent_free(fs_info, start, len);
> -	}
> -
> -out:
> +	ret = pin_down_extent(cache, start, len, 1);
>  	btrfs_put_block_group(cache);
>  	return ret;
>  }
> @@ -4182,7 +4172,21 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
>  int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
>  			       u64 start, u64 len, int delalloc)
>  {
> -	return __btrfs_free_reserved_extent(fs_info, start, len, 0, delalloc);
> +	struct btrfs_block_group *cache;
> +
> +	cache = btrfs_lookup_block_group(fs_info, start);
> +	if (!cache) {
> +		btrfs_err(fs_info, "Unable to find block group for %llu",
> +			  start);

I think the error message should be either removed or at least hidden
under enospc_debug. This has little value to a normal user and also the
function can be indirectly called many times, spamming logs.
