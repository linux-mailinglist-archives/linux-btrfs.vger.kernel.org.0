Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D75FB65
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGDQD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 12:03:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfGDQD0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 12:03:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A545AE8D;
        Thu,  4 Jul 2019 16:03:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B3080DA89D; Thu,  4 Jul 2019 18:04:04 +0200 (CEST)
Date:   Thu, 4 Jul 2019 18:04:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        James Harvey <jamespharvey20@gmail.com>
Subject: Re: [PATCH v2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
Message-ID: <20190704160400.GY20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        James Harvey <jamespharvey20@gmail.com>
References: <20190701051225.17957-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701051225.17957-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 01, 2019 at 05:12:46AM +0000, Qu Wenruo wrote:
> As btrfs(5) specified:
> 
> 	Note
> 	If nodatacow or nodatasum are enabled, compression is disabled.
> 
> If NODATASUM or NODATACOW set, we should not compress the extent.
> 
> Normally NODATACOW is detected properly in run_delalloc_range() so
> compression won't happen for NODATACOW.
> 
> However for NODATASUM we don't have any check, and it can cause
> compressed extent without csum pretty easily, just by:
>   mkfs.btrfs -f $dev
>   mount $dev $mnt -o nodatasum
>   touch $mnt/foobar
>   mount -o remount,datasum,compress $mnt
>   xfs_io -f -c "pwrite 0 128K" $mnt/foobar
> 
> And in fact, we have a bug report about corrupted compressed extent
> without proper data checksum so even RAID1 can't recover the corruption.
> (https://bugzilla.kernel.org/show_bug.cgi?id=199707)
> 
> Running compression without proper checksum could cause more damage when
> corruption happens, as compressed data could make the whole extent
> unreadable, so there is no need to allow compression for
> NODATACSUM.
> 
> The fix will refactor the inode compression check into two parts:
> - inode_can_compress()
>   As the hard requirement, checked at btrfs_run_delalloc_range(), so no
>   compression will happen for NODATASUM inode at all.
> 
> - inode_need_compress()
>   As the soft requirement, checked at btrfs_run_delalloc_range() and
>   compress_file_range().
> 
> Reported-by: James Harvey <jamespharvey20@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Refactor inode_need_compress() into two functions
> - Refactor inode_need_compress() to return bool
> ---
>  fs/btrfs/inode.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a2aabdb85226..be1cabf35680 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -394,24 +394,49 @@ static noinline int add_async_extent(struct async_chunk *cow,
>  	return 0;
>  }
>  
> -static inline int inode_need_compress(struct inode *inode, u64 start, u64 end)
> +/*
> + * Check if the inode can accept compression.
> + *
> + * This checks for the hard requirement of compression, including CoW and
> + * checksum requirement.
> + */
> +static inline bool inode_can_compress(struct inode *inode)
> +{
> +	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW ||
> +	    BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
> +		return false;
> +	return true;
> +}
> +
> +/*
> + * Check if the inode need compression.
> + *
> + * This checks for the soft requirement of compression.
> + */
> +static inline bool inode_need_compress(struct inode *inode, u64 start, u64 end)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  
> +	if (!inode_can_compress(inode)) {
> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
> +			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
> +			btrfs_ino(BTRFS_I(inode)));
> +		return false;
> +	}
>  	/* force compress */
>  	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
> -		return 1;
> +		return true;
>  	/* defrag ioctl */
>  	if (BTRFS_I(inode)->defrag_compress)
> -		return 1;
> +		return true;
>  	/* bad compression ratios */
>  	if (BTRFS_I(inode)->flags & BTRFS_INODE_NOCOMPRESS)
> -		return 0;
> +		return false;
>  	if (btrfs_test_opt(fs_info, COMPRESS) ||
>  	    BTRFS_I(inode)->flags & BTRFS_INODE_COMPRESS ||
>  	    BTRFS_I(inode)->prop_compress)
>  		return btrfs_compress_heuristic(inode, start, end);
> -	return 0;
> +	return false;
>  }
>  
>  static inline void inode_should_defrag(struct btrfs_inode *inode,
> @@ -1630,7 +1655,8 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
>  	} else if (BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC && !force_cow) {
>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, 0, nr_written);
> -	} else if (!inode_need_compress(inode, start, end)) {
> +	} else if (!inode_can_compress(inode) ||
> +		   !inode_need_compress(inode, start, end)) {

Well, that's not excatly what I expected, but because this is an
important fix I won't object now and add it to 5.3 queue.
