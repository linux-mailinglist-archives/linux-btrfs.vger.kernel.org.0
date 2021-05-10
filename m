Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23933793C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 18:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEJQar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 12:30:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhEJQar (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 12:30:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620664181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVcmrz4YjcqVGHjhTcPaObed6Cxqt96EtuDZd9o/hvI=;
        b=Qu052cJ3kPsaoIwBGfDd2RkM1Ikq2SB3MmrWVJbaWH3+mkSPVC5pXYYGseo8paMEq7/G5W
        Hh16iALjiJD8B1+gb4rifMZoTEfoEKvFTVAxSUbVXjajr5LdpACD3IvWgBMmG7h7X6A5R9
        AiPDGVXx1v8ysNinvkLEPSjGi4a6Roo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7074CB136;
        Mon, 10 May 2021 16:29:41 +0000 (UTC)
Subject: Re: [PATCH] btrfs: let check_async_write return bool
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ac35b9ba276cf4eefcf9641a19eaabae715f6d2d.1620659830.git.johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <daaa1507-8dc5-14fa-d588-856c1439b9f1@suse.com>
Date:   Mon, 10 May 2021 19:29:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ac35b9ba276cf4eefcf9641a19eaabae715f6d2d.1620659830.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.05.21 г. 18:17, Johannes Thumshirn wrote:
> The 'check_async_write' function is a helper used in
> 'btrfs_submit_metadata_bio' and it checks if asynchronous writing can be
> used for metadata.
> 
> Make the function return bool and get rid of the local variable async in
> btrfs_submit_metadata_bio storing the result of check_async_write's tests.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Nit: Won't it make it more clear if the function is named
"should_write_async" or something along those lines?

> ---
>  fs/btrfs/disk-io.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c9a3036c23bf..4305e3a26a6b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -917,23 +917,22 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
>  	return btree_csum_one_bio(bio);
>  }
>  
> -static int check_async_write(struct btrfs_fs_info *fs_info,
> +static bool check_async_write(struct btrfs_fs_info *fs_info,
>  			     struct btrfs_inode *bi)
>  {
>  	if (btrfs_is_zoned(fs_info))
> -		return 0;
> +		return false;
>  	if (atomic_read(&bi->sync_writers))
> -		return 0;
> +		return false;
>  	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
> -		return 0;
> -	return 1;
> +		return false;
> +	return true;
>  }
>  
>  blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
>  				       int mirror_num, unsigned long bio_flags)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> -	int async = check_async_write(fs_info, BTRFS_I(inode));
>  	blk_status_t ret;
>  
>  	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
> @@ -946,7 +945,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
>  		if (ret)
>  			goto out_w_error;
>  		ret = btrfs_map_bio(fs_info, bio, mirror_num);
> -	} else if (!async) {
> +	} else if (!check_async_write(fs_info, BTRFS_I(inode))) {
>  		ret = btree_csum_one_bio(bio);
>  		if (ret)
>  			goto out_w_error;
> 
