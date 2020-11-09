Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6782AB811
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgKIMTn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 07:19:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:35088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKIMTn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 07:19:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604924381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=g7mhrvihsdqck7HK7htK+4L58gqVyXVMvGchj410A+8=;
        b=vQEjHwYEtoE8ftpDC+ETJ/aHQkYOft1NtR5LdtLUenmACR5Uw/DQVWA5FPHWqzsFdZ+/b4
        rMtgxqHM/FSYfBRXGFz57/og/y8mpRVZo3w+By6tYpEesDfEE5UAVLXlLI6l19zkq+AGFg
        oZS7i7ZKYdyeUEbPufPZyx0e5DLBTwc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96451ABF4;
        Mon,  9 Nov 2020 12:19:41 +0000 (UTC)
Subject: Re: [PATCH 2/2] btrfs: use more straightforward disk_bytenr to
 replace icsum for check_data_csum()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201109115410.605880-1-wqu@suse.com>
 <20201109115410.605880-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bb177936-c2e7-2b1d-387c-13128527667b@suse.com>
Date:   Mon, 9 Nov 2020 14:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109115410.605880-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.11.20 г. 13:54 ч., Qu Wenruo wrote:
> Parameter @icsum for check_data_csum() is a little hard to understand.
> It is the offset in sectors compared to io_bio->logical.

This second sentence is confusing because io_bio->logical is used for repair/dio bios and not buffered whilst  icsum is calculated independently of io_bio->logical so I'd suggest you remove it. 
> 
> Instead of using the calculated value, let's go with disk_bytenr, as the
> new name is not only straightforward,  but also utilized in a lot of
> existing code for file items.

Just say that instead of passing in the calculated offset couple of levels deep you modify the code to instead pass disk_bytenr of currently processed biovec and use that to calculate the offset closer to actual users of it. Kind of like what I did below. 

> 
> To get the old @icsum value, we simply use
> (disk_bytenr - (io_bio->bio.bi_iter.bi_sector << 9)) >>
> fs_info->sectorsize_bits;
> 
> This patch would separate file offset with disk_bytenr completely, to
> reduce the confusion.

I find this description somewhat confusing, what you are doing is just moving the sector offset calculation closer to where it's being used, rather than calculating it in the top level endio handler and passing it several levels down to where it's actually used - in the csum verification function. So where is file offset involved?

Otherwise the code LGTM apart from some minor nits below. 

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 14 ++++++++------
>  fs/btrfs/inode.c     | 35 ++++++++++++++++++++++++++---------
>  2 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bd5a22bfee68..f8b5d3d4e5b0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2878,7 +2878,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>  	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
>  	struct extent_io_tree *tree, *failure_tree;
>  	struct processed_extent processed = { 0 };
> -	u64 offset = 0;
> +	u64 disk_bytenr = (bio->bi_iter.bi_sector << 9);

needless parentheses.

>  	u64 start;
>  	u64 end;
>  	u64 len;

<snip>

> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c54e0ed0b938..eff987931f0d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2843,19 +2843,27 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>   * The length of such check is always one sector size.
>   */

It's not evident from the hunk but you should also modify the parameter description of this function since we no longer have 'icsum'

>  static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
> -			   int icsum, struct page *page, int pgoff)
> +			   u64 disk_bytenr, struct page *page, int pgoff)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	char *kaddr;
>  	u32 len = fs_info->sectorsize;
>  	const u32 csum_size = fs_info->csum_size;
> +	u64 bio_disk_bytenr = (io_bio->bio.bi_iter.bi_sector << 9);

Again, extra parentheses, they don't bring anything in this particular expression. 

> +	int offset_sectors;
>  	u8 *csum_expected;
>  	u8 csum[BTRFS_CSUM_SIZE];
>  
>  	ASSERT(pgoff + len <= PAGE_SIZE);
>  
> -	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
> +	/* Our disk_bytenr should be inside the io_bio */
> +	ASSERT(bio_disk_bytenr <= disk_bytenr &&
> +	       disk_bytenr < bio_disk_bytenr + io_bio->bio.bi_iter.bi_size);

nit: in_range(disk_bytenr, bio_disk_bytenr, io_bio->bio.bi_iter.bi_size); 

IMO the assert is redundant since it's obvious disk_bytenr will always be within range, but perhahps it's needed for your future subpage work so I'm not going to insist on removing it. 

> +
> +	offset_sectors = (disk_bytenr - bio_disk_bytenr) >>
> +			 fs_info->sectorsize_bits;
> +	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
>  
>  	kaddr = kmap_atomic(page);
>  	shash->tfm = fs_info->csum_shash;
> @@ -2883,8 +2891,13 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,

<snip>

