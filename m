Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BC29E4ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbgJ2Ht4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:49:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731751AbgJ2Hnn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603956746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=t2TjfK4kLpX3xMSrPrm0k1Oubrb/KSxNFAXHHpL8oH4=;
        b=R/4n+SMqD5vQWke3fHn/eRf++BdPzyqu1rOTSwC2UjWN1LrpjbK6AGmVEmVd0YMfu3DjR3
        egUyKYQxxBq26SV1RD0d9vhe+dqa99RmcMwlff9N5jnWMZSgLcGXwE0FaR83F9wb8h/Ezv
        k22C1+I3lLMGeYcS03ssFiOnsLMfZeU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C76F0BA92;
        Thu, 29 Oct 2020 07:32:26 +0000 (UTC)
Subject: Re: [PATCH 2/3] btrfs: ordered-data: rename parameter @len to
 @nr_sectors
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201028072432.86907-1-wqu@suse.com>
 <20201028072432.86907-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4d701078-6fa1-7261-086d-e994b8dc7fc1@suse.com>
Date:   Thu, 29 Oct 2020 09:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028072432.86907-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.10.20 г. 9:24 ч., Qu Wenruo wrote:
> The parameter is the number of sectors of the range to search.
> While most "len" we used in other locations are in byte size, this can
> lead to confusion.
> 
> Rename @len to @nr_sectors to make it more clear and avoid confusion.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/ordered-data.c | 9 ++++++---
>  fs/btrfs/ordered-data.h | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index ebac13389e7e..10c13f8a1603 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -802,9 +802,11 @@ btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
>   * search the ordered extents for one corresponding to 'offset' and
>   * try to find a checksum.  This is used because we allow pages to
>   * be reclaimed before their checksum is actually put into the btree
> + *
> + * @nr_sectors:	The length of the search range, in sectors.
>   */
>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
> -			   u8 *sum, int len)
> +			   u8 *sum, int nr_sectors)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_ordered_sum *ordered_sum;
> @@ -828,12 +830,13 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,

FWIW: The loop can be made slightly more readable by applying the following hunk:

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 9a277a475a1c..0b41499bb45a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -878,8 +878,8 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
 
        spin_lock_irq(&tree->lock);
        list_for_each_entry_reverse(ordered_sum, &ordered->list, list) {
-               if (disk_bytenr >= ordered_sum->bytenr &&
-                   disk_bytenr < ordered_sum->bytenr + ordered_sum->len) {
+               if (in_range(disk_bytenr, ordered_sum->bytenr,
+                            ordered_sum->len)) {
                        i = (disk_bytenr - ordered_sum->bytenr) >> blocksize_bits;
                        num_sectors = ordered_sum->len >> blocksize_bits;
                        num_sectors = min_t(int, len - index, num_sectors - i);


>  			    inode->i_sb->s_blocksize_bits;
>  			num_sectors = ordered_sum->len >>
>  				      inode->i_sb->s_blocksize_bits;
> -			num_sectors = min_t(int, len - index, num_sectors - i);
> +			num_sectors = min_t(int, nr_sectors - index,
> +					    num_sectors - i);
>  			memcpy(sum + index, ordered_sum->sums + i * csum_size,
>  			       num_sectors * csum_size);
>  
>  			index += (int)num_sectors * csum_size;
> -			if (index == len)
> +			if (index == nr_sectors)
>  				goto out;
>  			disk_bytenr += num_sectors * sectorsize;
>  		}

<snip>
