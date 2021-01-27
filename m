Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655CD305DEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 15:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhA0OKq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 09:10:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:56318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhA0OJO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 09:09:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611756506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=gJv/hbT78BYzJZuwzm4mKADbRWOr4MyzOQlHDUOthEw=;
        b=FiAaA0E92wd89gA2fr7sDiVZwZW3CK0OAiH7WdGk1VqThdKFosMlNwzit29vsrFnNPfXOW
        0li0vQBxUusCHQ2t1mJQolcU16/D5KHkGHbxNbEiasgyj6EyZedR9cCBxaGdBKJHgGzm7K
        p5e8d9FH/uHKWdAog4KqE1HFEg5qm/M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DF45AC4F;
        Wed, 27 Jan 2021 14:08:26 +0000 (UTC)
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
To:     Michal Rostecki <mrostecki@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Rostecki <mrostecki@suse.com>
References: <20210127135728.30276-1-mrostecki@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <b3abfe2f-0abb-c7d5-07c8-c2eaede6eb3c@suse.com>
Date:   Wed, 27 Jan 2021 16:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127135728.30276-1-mrostecki@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.01.21 г. 15:57 ч., Michal Rostecki wrote:
> From: Michal Rostecki <mrostecki@suse.com>
> 
> Before this change, the btrfs_get_io_geometry() function was calling
> btrfs_get_chunk_map() to get the extent mapping, necessary for
> calculating the I/O geometry. It was using that extent mapping only
> internally and freeing the pointer after its execution.
> 
> That resulted in calling btrfs_get_chunk_map() de facto twice by the
> __btrfs_map_block() function. It was calling btrfs_get_io_geometry()
> first and then calling btrfs_get_chunk_map() directly to get the extent
> mapping, used by the rest of the function.
> 
> This change fixes that by passing the extent mapping to the
> btrfs_get_io_geometry() function as an argument.
> 
> v2:
> When btrfs_get_chunk_map() returns an error in btrfs_submit_direct():
> - Use errno_to_blk_status(PTR_ERR(em)) as the status
> - Set em to NULL
> 
> Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> ---
>  fs/btrfs/inode.c   | 38 +++++++++++++++++++++++++++++---------
>  fs/btrfs/volumes.c | 39 ++++++++++++++++-----------------------
>  fs/btrfs/volumes.h |  5 +++--
>  3 files changed, 48 insertions(+), 34 deletions(-)

So this adds more code but for what benefit? In your reply to Filipe you
said you didn't observe this being a performance-affecting change so

> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0dbe1aaa0b71..e2ee3a9c1140 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2183,9 +2183,10 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
>  	struct inode *inode = page->mapping->host;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	u64 logical = bio->bi_iter.bi_sector << 9;
> +	struct extent_map *em;
>  	u64 length = 0;
>  	u64 map_length;
> -	int ret;
> +	int ret = 0;
>  	struct btrfs_io_geometry geom;
>  
>  	if (bio_flags & EXTENT_BIO_COMPRESSED)
> @@ -2193,14 +2194,21 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
>  
>  	length = bio->bi_iter.bi_size;
>  	map_length = length;
> -	ret = btrfs_get_io_geometry(fs_info, btrfs_op(bio), logical, map_length,
> -				    &geom);
> +	em = btrfs_get_chunk_map(fs_info, logical, map_length);
> +	if (IS_ERR(em))
> +		return PTR_ERR(em);
> +	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical,
> +				    map_length, &geom);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
> -	if (geom.len < length + size)
> -		return 1;
> -	return 0;
> +	if (geom.len < length + size) {
> +		ret = 1;
> +		goto out;
> +	}

this could be simply

if (geom.len <length + size)
   ret = 1;

Not need for the extra 'goto out'

> +out:
> +	free_extent_map(em);
> +	return ret;
>  }
>  
>  /*
> @@ -7941,10 +7949,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
>  	u64 submit_len;
>  	int clone_offset = 0;
>  	int clone_len;
> +	int logical;
>  	int ret;
>  	blk_status_t status;
>  	struct btrfs_io_geometry geom;
>  	struct btrfs_dio_data *dio_data = iomap->private;
> +	struct extent_map *em;
>  
>  	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
>  	if (!dip) {
> @@ -7970,11 +7980,18 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
>  	}
>  
>  	start_sector = dio_bio->bi_iter.bi_sector;
> +	logical = start_sector << 9;
>  	submit_len = dio_bio->bi_iter.bi_size;
>  
>  	do {
> -		ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
> -					    start_sector << 9, submit_len,
> +		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
> +		if (IS_ERR(em)) {
> +			status = errno_to_blk_status(PTR_ERR(em));
> +			em = NULL;
> +			goto out_err;
> +		}
> +		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
> +					    logical, submit_len,
>  					    &geom);
>  		if (ret) {
>  			status = errno_to_blk_status(ret);
> @@ -8030,12 +8047,15 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
>  		clone_offset += clone_len;
>  		start_sector += clone_len >> 9;
>  		file_offset += clone_len;
> +
> +		free_extent_map(em);
>  	} while (submit_len > 0);
>  	return BLK_QC_T_NONE;
>  
>  out_err:
>  	dip->dio_bio->bi_status = status;
>  	btrfs_dio_private_put(dip);
> +	free_extent_map(em);
>  	return BLK_QC_T_NONE;
>  }

For example in this function you increase complexity by having to deal
with free_extent_map as well so I'm not sure this is a net-win.

>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a8ec8539cd8d..4c753b17c0a2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5940,23 +5940,24 @@ static bool need_full_stripe(enum btrfs_map_op op)
>  }
>  
>  /*
> - * btrfs_get_io_geometry - calculates the geomery of a particular (address, len)
> + * btrfs_get_io_geometry - calculates the geometry of a particular (address, len)
>   *		       tuple. This information is used to calculate how big a
>   *		       particular bio can get before it straddles a stripe.
>   *
> - * @fs_info - the filesystem
> - * @logical - address that we want to figure out the geometry of
> - * @len	    - the length of IO we are going to perform, starting at @logical
> - * @op      - type of operation - write or read
> - * @io_geom - pointer used to return values
> + * @fs_info: the filesystem
> + * @em:      mapping containing the logical extent
> + * @op:      type of operation - write or read
> + * @logical: address that we want to figure out the geometry of
> + * @len:     the length of IO we are going to perform, starting at @logical
> + * @io_geom: pointer used to return values
>   *
>   * Returns < 0 in case a chunk for the given logical address cannot be found,
>   * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
>   */
> -int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> -			u64 logical, u64 len, struct btrfs_io_geometry *io_geom)
> +int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
> +			  enum btrfs_map_op op, u64 logical, u64 len,
> +			  struct btrfs_io_geometry *io_geom)
>  {
> -	struct extent_map *em;
>  	struct map_lookup *map;
>  	u64 offset;
>  	u64 stripe_offset;
> @@ -5964,14 +5965,9 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  	u64 stripe_len;
>  	u64 raid56_full_stripe_start = (u64)-1;
>  	int data_stripes;
> -	int ret = 0;
>  
>  	ASSERT(op != BTRFS_MAP_DISCARD);
>  
> -	em = btrfs_get_chunk_map(fs_info, logical, len);
> -	if (IS_ERR(em))
> -		return PTR_ERR(em);
> -
>  	map = em->map_lookup;
>  	/* Offset of this logical address in the chunk */
>  	offset = logical - em->start;
> @@ -5985,8 +5981,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  		btrfs_crit(fs_info,
>  "stripe math has gone wrong, stripe_offset=%llu offset=%llu start=%llu logical=%llu stripe_len=%llu",
>  			stripe_offset, offset, em->start, logical, stripe_len);
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  
>  	/* stripe_offset is the offset of this block in its stripe */
> @@ -6033,10 +6028,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  	io_geom->stripe_offset = stripe_offset;
>  	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
>  
> -out:
> -	/* once for us */
> -	free_extent_map(em);
> -	return ret;
> +	return 0;
>  }

Effectively, what's going on is you are pulling complexity from
btrfs_get_io_geometry and putting it into its 2 callers which is IMO bad.

So unless you can demonstrate this is indeed affecting performance I'd
be inclined to NAK it.
