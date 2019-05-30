Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403902FB60
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 14:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfE3MCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 08:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:55908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbfE3MCC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 08:02:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F32E7AE3E
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 12:02:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E955DA85E; Thu, 30 May 2019 14:02:54 +0200 (CEST)
Date:   Thu, 30 May 2019 14:02:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: Check if the file extent end
 overflow
Message-ID: <20190530120253.GC15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190503003054.9346-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503003054.9346-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 03, 2019 at 08:30:54AM +0800, Qu Wenruo wrote:
> Under certain condition, we could have strange file extent item in log
> tree like:
> 
>   item 18 key (69599 108 397312) itemoff 15208 itemsize 53
> 	extent data disk bytenr 0 nr 0
> 	extent data offset 0 nr 18446744073709547520 ram 18446744073709547520
> 
> The num_bytes and ram_bytes part overflow.
> 
> For num_bytes part, we can detect such overflow along with file offset
> (key->offset), as file_offset + num_bytes should never go beyond u64
> max.
> 
> For ram_bytes part, it's about the decompressed size of the extent, not
> directly related to the size.
> In theory is OK to have super large value, and put extra
> limitation on ram bytes may cause unexpected false alert.
> 
> So in tree-checker, we only check if the file offset and num bytes
> overflow.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 4f4f5af6345a..795eb6c18456 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -112,6 +112,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  	struct btrfs_file_extent_item *fi;
>  	u32 sectorsize = fs_info->sectorsize;
>  	u32 item_size = btrfs_item_size_nr(leaf, slot);
> +	u64 extent_end;
>  
>  	if (!IS_ALIGNED(key->offset, sectorsize)) {
>  		file_extent_err(leaf, slot,
> @@ -186,6 +187,14 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  	    CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
>  	    CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize))
>  		return -EUCLEAN;
> +	/* Catch extent end overflow case */
> +	if (check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
> +			       key->offset, &extent_end)) {
> +		file_extent_err(leaf, slot,
> +	"extent end overflow, have file offset %llu extent num bytes %llu",
> +				key->offset,
> +				btrfs_file_extent_num_bytes(leaf, fi));

Isn't this missing

		return -EUCLEAN;

?

> +	}
>  	return 0;
>  }
>  
> -- 
> 2.21.0
