Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBFA1B2421
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgDUKo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 06:44:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgDUKo3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 06:44:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 84843ADCE;
        Tue, 21 Apr 2020 10:44:26 +0000 (UTC)
Subject: Re: [PATCH v2 03/15] btrfs: fix double __endio_write_update_ordered
 in direct I/O
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1587072977.git.osandov@fb.com>
 <594c8cb6dd64cebdf5e01016ce823e1be00fc7ab.1587072977.git.osandov@fb.com>
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
Message-ID: <251a02c2-b6b9-7b31-38dc-a56abc2e0f77@suse.com>
Date:   Tue, 21 Apr 2020 13:44:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <594c8cb6dd64cebdf5e01016ce823e1be00fc7ab.1587072977.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.04.20 г. 0:46 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In btrfs_submit_direct(), if we fail to allocate the btrfs_dio_private,
> we complete the ordered extent range. However, we don't mark that the
> range doesn't need to be cleaned up from btrfs_direct_IO() until later.
> Therefore, if we fail to allocate the btrfs_dio_private, we complete the
> ordered extent range twice. We could fix this by updating
> unsubmitted_oe_range earlier, but it's cleaner to reorganize the code so
> that creating the btrfs_dio_private and submitting the bios are
> separate, and once the btrfs_dio_private is created, cleanup always
> happens through the btrfs_dio_private.
> 
> Fixes: f28a49287817 ("Btrfs: fix leaking of ordered extents after direct IO write error")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Generally looks ok, so :

Reviewed-by: Nikolay Borisov <nborisov@suse.com>, however please see
below for some remarks on the logic around unsubmitted_oe_range_start/end

> ---
>  fs/btrfs/inode.c | 174 ++++++++++++++++++-----------------------------
>  1 file changed, 66 insertions(+), 108 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b628c319a5b6..f6ce9749adb6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7903,14 +7903,60 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>  	return ret;
>  }
>  
> -static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
> +/*
> + * If this succeeds, the btrfs_dio_private is responsible for cleaning up locked
> + * or ordered extents whether or not we submit any bios.
> + */
> +static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
> +							  struct inode *inode,
> +							  loff_t file_offset)
>  {
> -	struct inode *inode = dip->inode;
> +	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
> +	struct btrfs_dio_private *dip;
> +	struct bio *bio;
> +
> +	dip = kzalloc(sizeof(*dip), GFP_NOFS);
> +	if (!dip)
> +		return NULL;
> +
> +	bio = btrfs_bio_clone(dio_bio);
> +	bio->bi_private = dip;
> +	btrfs_io_bio(bio)->logical = file_offset;
> +
> +	dip->private = dio_bio->bi_private;
> +	dip->inode = inode;
> +	dip->logical_offset = file_offset;
> +	dip->bytes = dio_bio->bi_iter.bi_size;
> +	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
> +	dip->orig_bio = bio;
> +	dip->dio_bio = dio_bio;
> +	atomic_set(&dip->pending_bios, 1);
> +
> +	if (write) {
> +		struct btrfs_dio_data *dio_data = current->journal_info;
> +
> +		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
> +			dip->bytes;
> +		dio_data->unsubmitted_oe_range_start =
> +			dio_data->unsubmitted_oe_range_end;

The logic around those 2 members is really subtle. We really have the
following:

1. btrfs_direct_IO sets those two to the same value.

2. When we call __blockdev_direct_IO unless
btrfs_get_blocks_direct->btrfs_get_blocks_direct_write is called to
modify unsubmitted_oe_range_start so that start < end. Cleanup won't
happen.

3. We come into btrfs_submit_direct - if it dip allocation fails we'd
return with oe_range_end now modified so cleanup will happen.

4. If we manage to allocate the dip we reset the unsubmitted range
members to be equal so that cleanup happens from btrfs_endio_direct_write.

This 4-step logic is not really obvious, especially given it's scattered
across 3 functions. Perhaps a comment saying that having the 2 members
being equal means cleanup in btrfs_DIRECT_io is disabled.

I'd rather have it spelled out in the changelog, I guess David can also
do that ?

> +
> +		bio->bi_end_io = btrfs_endio_direct_write;
> +	} else {
> +		bio->bi_end_io = btrfs_endio_direct_read;
> +		dip->subio_endio = btrfs_subio_endio_read;
> +	}
> +	return dip;
> +}
> +

<snip>

