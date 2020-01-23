Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF1146AF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWONv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 09:13:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:54616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgAWONv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 09:13:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F37EACA4;
        Thu, 23 Jan 2020 14:13:48 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] btrfs: remove buffer heads from super block
 reading
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-3-johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABzSJOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuZGU+wsF4BBMBAgAiBQJYijkSAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRBxvoJG5T8oV/B6D/9a8EcRPdHg8uLEPywuJR8URwXzkofT5bZE
 IfGF0Z+Lt2ADe+nLOXrwKsamhweUFAvwEUxxnndovRLPOpWerTOAl47lxad08080jXnGfYFS
 Dc+ew7C3SFI4tFFHln8Y22Q9075saZ2yQS1ywJy+TFPADIprAZXnPbbbNbGtJLoq0LTiESnD
 w/SUC6sfikYwGRS94Dc9qO4nWyEvBK3Ql8NkoY0Sjky3B0vL572Gq0ytILDDGYuZVo4alUs8
 LeXS5ukoZIw1QYXVstDJQnYjFxYgoQ5uGVi4t7FsFM/6ykYDzbIPNOx49Rbh9W4uKsLVhTzG
 BDTzdvX4ARl9La2kCQIjjWRg+XGuBM5rxT/NaTS78PXjhqWNYlGc5OhO0l8e5DIS2tXwYMDY
 LuHYNkkpMFksBslldvNttSNei7xr5VwjVqW4vASk2Aak5AleXZS+xIq2FADPS/XSgIaepyTV
 tkfnyreep1pk09cjfXY4A7qpEFwazCRZg9LLvYVc2M2eFQHDMtXsH59nOMstXx2OtNMcx5p8
 0a5FHXE/HoXz3p9bD0uIUq6p04VYOHsMasHqHPbsMAq9V2OCytJQPWwe46bBjYZCOwG0+x58
 fBFreP/NiJNeTQPOa6FoxLOLXMuVtpbcXIqKQDoEte9aMpoj9L24f60G4q+pL/54ql2VRscK
 d87BTQRYigc+ARAAyJSq9EFk28++SLfg791xOh28tLI6Yr8wwEOvM3wKeTfTZd+caVb9gBBy
 wxYhIopKlK1zq2YP7ZjTP1aPJGoWvcQZ8fVFdK/1nW+Z8/NTjaOx1mfrrtTGtFxVBdSCgqBB
 jHTnlDYV1R5plJqK+ggEP1a0mr/rpQ9dFGvgf/5jkVpRnH6BY0aYFPprRL8ZCcdv2DeeicOO
 YMobD5g7g/poQzHLLeT0+y1qiLIFefNABLN06Lf0GBZC5l8hCM3Rpb4ObyQ4B9PmL/KTn2FV
 Xq/c0scGMdXD2QeWLePC+yLMhf1fZby1vVJ59pXGq+o7XXfYA7xX0JsTUNxVPx/MgK8aLjYW
 hX+TRA4bCr4uYt/S3ThDRywSX6Hr1lyp4FJBwgyb8iv42it8KvoeOsHqVbuCIGRCXqGGiaeX
 Wa0M/oxN1vJjMSIEVzBAPi16tztL/wQtFHJtZAdCnuzFAz8ue6GzvsyBj97pzkBVacwp3/Mw
 qbiu7sDz7yB0d7J2tFBJYNpVt/Lce6nQhrvon0VqiWeMHxgtQ4k92Eja9u80JDaKnHDdjdwq
 FUikZirB28UiLPQV6PvCckgIiukmz/5ctAfKpyYRGfez+JbAGl6iCvHYt/wAZ7Oqe/3Cirs5
 KhaXBcMmJR1qo8QH8eYZ+qhFE3bSPH446+5oEw8A9v5oonKV7zMAEQEAAcLBXwQYAQIACQUC
 WIoHPgIbDAAKCRBxvoJG5T8oV1pyD/4zdXdOL0lhkSIjJWGqz7Idvo0wjVHSSQCbOwZDWNTN
 JBTP0BUxHpPu/Z8gRNNP9/k6i63T4eL1xjy4umTwJaej1X15H8Hsh+zakADyWHadbjcUXCkg
 OJK4NsfqhMuaIYIHbToi9K5pAKnV953xTrK6oYVyd/Rmkmb+wgsbYQJ0Ur1Ficwhp6qU1CaJ
 mJwFjaWaVgUERoxcejL4ruds66LM9Z1Qqgoer62ZneID6ovmzpCWbi2sfbz98+kW46aA/w8r
 7sulgs1KXWhBSv5aWqKU8C4twKjlV2XsztUUsyrjHFj91j31pnHRklBgXHTD/pSRsN0UvM26
 lPs0g3ryVlG5wiZ9+JbI3sKMfbdfdOeLxtL25ujs443rw1s/PVghphoeadVAKMPINeRCgoJH
 zZV/2Z/myWPRWWl/79amy/9MfxffZqO9rfugRBORY0ywPHLDdo9Kmzoxoxp9w3uTrTLZaT9M
 KIuxEcV8wcVjr+Wr9zRl06waOCkgrQbTPp631hToxo+4rA1jiQF2M80HAet65ytBVR2pFGZF
 zGYYLqiG+mpUZ+FPjxk9kpkRYz61mTLSY7tuFljExfJWMGfgSg1OxfLV631jV1TcdUnx+h3l
 Sqs2vMhAVt14zT8mpIuu2VNxcontxgVr1kzYA/tQg32fVRbGr449j1gw57BV9i0vww==
Message-ID: <fa80a24c-e174-ec21-9228-8ff5fc415c72@suse.com>
Date:   Thu, 23 Jan 2020 16:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123081849.23397-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.01.20 г. 10:18 ч., Johannes Thumshirn wrote:

<snip>

> @@ -3374,40 +3378,60 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  }
>  
>  int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> -			struct buffer_head **bh_ret)
> +			struct page **super_page)
>  {
> -	struct buffer_head *bh;
>  	struct btrfs_super_block *super;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	struct page *page;
>  	u64 bytenr;
> +	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	gfp_t gfp_mask;
> +	int ret;
>  
>  	bytenr = btrfs_sb_offset(copy_num);
>  	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>  		return -EINVAL;
>  
> -	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
> +	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
> +	page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT, gfp_mask);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +	bio_set_dev(&bio, bdev);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE,
> +		     offset_in_page(bytenr));
> +
> +	ret = submit_bio_wait(&bio);
> +	unlock_page(page);

So this is based on my code where the page is unlocked as soon as it's
read. However, as per out off-list discussion, I think this page needs
to be unlocked once the caller of
btrfs_read_dev_one_super/btrfs_read_dev_super is finished with it.

>  	/*
>  	 * If we fail to read from the underlying devices, as of now
>  	 * the best option we have is to mark it EIO.
>  	 */
> -	if (!bh)
> +	if (ret) {
> +		put_page(page);
>  		return -EIO;
> +	}
>  
> -	super = (struct btrfs_super_block *)bh->b_data;
> +	super = kmap(page);
>  	if (btrfs_super_bytenr(super) != bytenr ||
>  		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> -		brelse(bh);
> +		btrfs_release_disk_super(page);
>  		return -EINVAL;
>  	}
> +	kunmap(page);
>  
> -	*bh_ret = bh;
> +	*super_page = page;
>  	return 0;
>  }
>  
>  
> -struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
> +int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
>  {
> -	struct buffer_head *bh;
> -	struct buffer_head *latest = NULL;
> +	struct page *latest = NULL;
>  	struct btrfs_super_block *super;
>  	int i;
>  	u64 transid = 0;

<snip>

>  
>  void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
>  {
> -	struct buffer_head *bh;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
>  	struct btrfs_super_block *disk_super;
>  	int copy_num;
>  
>  	if (!bdev)
>  		return;
>  
> +	bio_init(&bio, &bio_vec, 1);
>  	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
>  		copy_num++) {
> +		u64 bytenr = btrfs_sb_offset(copy_num);
> +		struct page *page;
>  
> -		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
> +		if (btrfs_read_dev_one_super(bdev, copy_num, &page))
>  			continue;
>  
> -		disk_super = (struct btrfs_super_block *)bh->b_data;
> +		disk_super = kmap(page) + offset_in_page(bytenr);
>  
>  		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
> -		set_buffer_dirty(bh);
> -		sync_dirty_buffer(bh);
> -		brelse(bh);
> +
> +		bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +		bio_set_dev(&bio, bdev);
> +		bio_set_op_attrs(&bio, REQ_OP_WRITE, 0);
> +		bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE,
> +			     offset_in_page(bytenr));
> +
> +		lock_page(page);
> +		submit_bio_wait(&bio);
> +		unlock_page(page);
> +		btrfs_release_disk_super(page);
> +		bio_reset(&bio);

For example in this code if btrfs_read_dev_one_super held the page
locked you would have unlocked after submit_bio_wait is has returned.
But in this case what you do is take the page unlocked and now you have
a race window between btrfs_read_dev_one_super and lock_page(page) in
this function? btrfs_scratch_superblocks is used in replace context so
what if it races with transaction commit? If my worries are moot and I
have missed anything then at the very least safety should be documented
in the changelog of the patch.

> +
>  	}
>  
>  	/* Notify udev that device has changed */
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index b7f2edbc6581..1e4ebe6d6368 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -17,8 +17,6 @@ extern struct mutex uuid_mutex;
>  
>  #define BTRFS_STRIPE_LEN	SZ_64K
>  
> -struct buffer_head;
> -
>  struct btrfs_io_geometry {
>  	/* remaining bytes before crossing a stripe */
>  	u64 len;
> 
