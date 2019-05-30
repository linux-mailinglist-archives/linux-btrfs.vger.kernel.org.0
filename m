Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EEF2FF92
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfE3Pq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 11:46:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3Pq6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 11:46:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A6E1AD17;
        Thu, 30 May 2019 15:46:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29063DA85E; Thu, 30 May 2019 17:47:50 +0200 (CEST)
Date:   Thu, 30 May 2019 17:47:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 07/13] btrfs: add common checksum type validation
Message-ID: <20190530154749.GH15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-8-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522081910.7689-8-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 10:19:04AM +0200, Johannes Thumshirn wrote:
> Currently btrfs is only supporting CRC32C as checksumming algorithm. As
> this is about to change provide a function to validate the checksum type in
> the superblock against all possible algorithms.
> 
> This makes adding new algorithms easier as there are fewer places to adjust
> when adding new algorithms.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
> ---
> Changes to v2:
> - Only pass csum_type into btrfs_supported_csum() (David)
> - Directly return in btrfs_check_super_csum() (David)
> ---
>  fs/btrfs/disk-io.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 663efce22d98..594583273782 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -356,6 +356,16 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
>  	return ret;
>  }
>  
> +static bool btrfs_supported_super_csum(u16 csum_type)
> +{
> +	switch (csum_type) {
> +	case BTRFS_CSUM_TYPE_CRC32:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * Return 0 if the superblock checksum type matches the checksum value of that
>   * algorithm. Pass the raw disk superblock data.
> @@ -366,7 +376,12 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>  	struct btrfs_super_block *disk_sb =
>  		(struct btrfs_super_block *)raw_disk_sb;
>  	u16 csum_type = btrfs_super_csum_type(disk_sb);
> -	int ret = 0;
> +
> +	if (!btrfs_supported_super_csum(csum_type)) {
> +		btrfs_err(fs_info, "unsupported checksum algorithm %u",
> +			  csum_type);
> +		return 1;
> +	}
>  
>  	if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
>  		u32 crc = ~(u32)0;
> @@ -382,16 +397,10 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>  		btrfs_csum_final(crc, result);
>  
>  		if (memcmp(raw_disk_sb, result, sizeof(result)))
> -			ret = 1;
> +			return 1;
>  	}
>  
> -	if (csum_type >= ARRAY_SIZE(btrfs_csum_sizes)) {
> -		btrfs_err(fs_info, "unsupported checksum algorithm %u",
> -				csum_type);
> -		ret = 1;
> -	}
> -
> -	return ret;
> +	return 0;
>  }
>  
>  int btrfs_verify_level_key(struct extent_buffer *eb, int level,
> @@ -2577,7 +2586,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
>  	ret = validate_super(fs_info, sb, -1);
>  	if (ret < 0)
>  		goto out;
> -	if (btrfs_super_csum_type(sb) != BTRFS_CSUM_TYPE_CRC32) {
> +	if (!btrfs_supported_super_csum(sb)) {

Type mismatch, this needs the type now, not the superblock. And
open_ctree also needs an update.

>  		ret = -EUCLEAN;
>  		btrfs_err(fs_info, "invalid csum type, has %u want %u",
>  			  btrfs_super_csum_type(sb), BTRFS_CSUM_TYPE_CRC32);
> -- 
> 2.16.4
