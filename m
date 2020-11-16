Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2790D2B4A87
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 17:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgKPQQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 11:16:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:35950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbgKPQQn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 11:16:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDDA9ABF4;
        Mon, 16 Nov 2020 16:16:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B12DDA6E3; Mon, 16 Nov 2020 17:14:57 +0100 (CET)
Date:   Mon, 16 Nov 2020 17:14:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: pass bio_offset to check_data_csum()
 directly
Message-ID: <20201116161457.GQ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201112084758.73617-1-wqu@suse.com>
 <20201112084758.73617-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112084758.73617-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 12, 2020 at 04:47:58PM +0800, Qu Wenruo wrote:
> Parameter @icsum for check_data_csum() is a little hard to understand.
> So is the @phy_offset for btrfs_verify_data_csum().
> 
> Both parameters are calculated values for csum lookup.
> 
> Instead of some calculated value, just pass @bio_offset and let the
> final and only user, check_data_csum(), to calculate whatever it needs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This has been sent independently and is also part of the subpage
patchset but without the reviewed-by tags.

>  static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
> -			   int icsum, struct page *page, int pgoff)
> +			   u64 bio_offset, struct page *page, int pgoff)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	char *kaddr;
>  	u32 len = fs_info->sectorsize;
>  	const u32 csum_size = fs_info->csum_size;
> +	int offset_sectors;
>  	u8 *csum_expected;
>  	u8 csum[BTRFS_CSUM_SIZE];
>  
>  	ASSERT(pgoff + len <= PAGE_SIZE);
>  
> -	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
> +	offset_sectors = bio_offset >> fs_info->sectorsize_bits;

	int = u64 >> u32

This does not match up, either bio_offset is unnecessarily wide or
offset_sectors needs to be widened.

> +	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
>  
>  	kaddr = kmap_atomic(page);
>  	shash->tfm = fs_info->csum_shash;
> @@ -2978,8 +2980,13 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
>   * when reads are done, we need to check csums to verify the data is correct
>   * if there's a match, we allow the bio to finish.  If not, the code in
>   * extent_io.c will try to find good copies for us.
> + *
> + * @bio_offset:	The offset to the begining of the bio (in bytes)

For parameter description please drop the initial 'The'

> + * @start:	The file offset of the range start
> + * @end:	The file offset of the range end (inclusive)
> + * @mirror:	The mirror number
