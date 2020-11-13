Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB072B23DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKMSgE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMSgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:36:04 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274CC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:36:02 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id m65so7330178qte.11
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=usv+SoCvo4VMDi4nfzKafqL7SbbnUcrOdUvPD5SadmM=;
        b=Y+Kn6KmWI4VB6+TvlGCJR3RzdLGUjMWQ9w3UJTfxNd4asd9DanA9a9VRL1l1SlVutr
         8jp7HapmeUswvF2qOd7CkYHd9WvZWpbj7EU3utmqHT9TWApAVN/oBkFY7MPWMraQg0/N
         ZS8gkvfBIO6aPWkl9tSv448b1jWTD1st8ksrF3tvvPiNcz7oc+OLr/KpxCwstUAOBj6V
         2fHtkznQnnOFCy0cmcAmWj1q5lWrt3SZ6UYISXe+JKws5y0Bsiab/7eEDTIBi3IyvMi8
         oK+uQ8MAoz93ZBYyFkcRR77JQnMqAta1ka7xEfeU8/uOI43Jy2hqOvSZb+sms+w9iWn7
         z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usv+SoCvo4VMDi4nfzKafqL7SbbnUcrOdUvPD5SadmM=;
        b=RuWt8EDR4Bii2jawQQSw5Wr47TkxZUjdfrWC6nhVTbF0o5hrgiEBWHa8w+chovSTm7
         ghc7RipICf9vTe/psDo5FIgm5MmZKgdzKNPqkUkrfCNaOhsF8uic5SQxtPnMHJLQ3Pbd
         7DUHJM2fxaZiHzRXoRKF968reXNXPL4AEetBPVuy/cC/ZSsKfrxw0zkY46b6BsIQwC6B
         njpCdp0awQUdJyvf+r1JBkqrMqa/Sqk0q3WlbgqmZwPLO3ctJb0wjgHNBwVicz0UY6JI
         XQzl43tH7C6/DCIYyXhLUM+ozHZGLR9WT8VWzznfT3/Txeauvt2bAEM9OlckDEsA/pc4
         c5XQ==
X-Gm-Message-State: AOAM533evFDlbeDVM9PIwsCOHVs049EPYCRdwiEfV90f5lUshrop5/qP
        vaEDSMv0ilXmDChXJdCFrlY4fY1Cw2eGEg==
X-Google-Smtp-Source: ABdhPJzT0P9r4VlLP7ujAUWb9UgzcNbIDt79+qSsRnIbUreT53lcDD9DA6uh2i3bEmWBz7Kbr9apJQ==
X-Received: by 2002:ac8:580c:: with SMTP id g12mr3391447qtg.340.1605292561326;
        Fri, 13 Nov 2020 10:36:01 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g123sm263647qkd.135.2020.11.13.10.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:36:00 -0800 (PST)
Subject: Re: [PATCH v3 2/2] btrfs: pass bio_offset to check_data_csum()
 directly
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201112084758.73617-1-wqu@suse.com>
 <20201112084758.73617-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e50c7ca6-1a31-051f-c051-89764c4bd546@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:35:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201112084758.73617-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/12/20 3:47 AM, Qu Wenruo wrote:
> Parameter @icsum for check_data_csum() is a little hard to understand.
> So is the @phy_offset for btrfs_verify_data_csum().
> 
> Both parameters are calculated values for csum lookup.
> 
> Instead of some calculated value, just pass @bio_offset and let the
> final and only user, check_data_csum(), to calculate whatever it needs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ctree.h     |  2 +-
>   fs/btrfs/extent_io.c | 14 ++++++++------
>   fs/btrfs/inode.c     | 26 ++++++++++++++++----------
>   3 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 679da4920c92..99955b6bfc62 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3046,7 +3046,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
>   /* inode.c */
>   blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>   				   int mirror_num, unsigned long bio_flags);
> -int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
> +int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 bio_offset,
>   			   struct page *page, u64 start, u64 end, int mirror);
>   struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
>   					   u64 start, u64 len);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d26677745757..72aac9a007ee 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2878,7 +2878,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>   	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
>   	struct extent_io_tree *tree, *failure_tree;
>   	struct processed_extent processed = { 0 };
> -	u64 offset = 0;
> +	u64 bio_offset = 0;
>   	u64 start;
>   	u64 end;
>   	u64 len;
> @@ -2924,8 +2924,9 @@ static void end_bio_extent_readpage(struct bio *bio)
>   		mirror = io_bio->mirror_num;
>   		if (likely(uptodate)) {
>   			if (is_data_inode(inode))
> -				ret = btrfs_verify_data_csum(io_bio, offset, page,
> -							     start, end, mirror);
> +				ret = btrfs_verify_data_csum(io_bio,
> +						bio_offset, page, start, end,
> +						mirror);
>   			else
>   				ret = btrfs_validate_metadata_buffer(io_bio,
>   					page, start, end, mirror);
> @@ -2953,12 +2954,13 @@ static void end_bio_extent_readpage(struct bio *bio)
>   			 * If it can't handle the error it will return -EIO and
>   			 * we remain responsible for that page.
>   			 */
> -			if (!btrfs_submit_read_repair(inode, bio, offset, page,
> +			if (!btrfs_submit_read_repair(inode, bio, bio_offset,
> +						page,
>   						start - page_offset(page),
>   						start, end, mirror,
>   						btrfs_submit_data_bio)) {
>   				uptodate = !bio->bi_status;
> -				offset += len;
> +				bio_offset += len;
>   				continue;
>   			}
>   		} else {
> @@ -2983,7 +2985,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>   			if (page->index == end_index && off)
>   				zero_user_segment(page, off, PAGE_SIZE);
>   		}
> -		offset += len;
> +		bio_offset += len;
>   
>   		endio_readpage_update_page_status(page, uptodate);
>   		endio_readpage_release_extent(&processed, BTRFS_I(inode),
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 435b270430e3..bcf3152d0efb 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2931,26 +2931,28 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>    * check_data_csum - verify checksum of one sector of uncompressed data
>    * @inode:	the inode
>    * @io_bio:	btrfs_io_bio which contains the csum
> - * @icsum:	checksum index in the io_bio->csum array, size of csum_size
> + * @bio_offset:	the offset to the beginning of the bio (in bytes)
>    * @page:	page where is the data to be verified
>    * @pgoff:	offset inside the page
>    *
>    * The length of such check is always one sector size.
>    */
>   static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
> -			   int icsum, struct page *page, int pgoff)
> +			   u64 bio_offset, struct page *page, int pgoff)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	char *kaddr;
>   	u32 len = fs_info->sectorsize;
>   	const u32 csum_size = fs_info->csum_size;
> +	int offset_sectors;
>   	u8 *csum_expected;
>   	u8 csum[BTRFS_CSUM_SIZE];
>   
>   	ASSERT(pgoff + len <= PAGE_SIZE);
>   
> -	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
> +	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
> +	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
>   
>   	kaddr = kmap_atomic(page);
>   	shash->tfm = fs_info->csum_shash;
> @@ -2978,8 +2980,13 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
>    * when reads are done, we need to check csums to verify the data is correct
>    * if there's a match, we allow the bio to finish.  If not, the code in
>    * extent_io.c will try to find good copies for us.
> + *
> + * @bio_offset:	The offset to the begining of the bio (in bytes)

beginning, I'd recommend doing the btrfs-setup-git-hooks to catch these things 
before you submit.  Other than that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
