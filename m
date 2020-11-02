Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D872A2C43
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKBOGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:06:05 -0500
Received: from mout.gmx.net ([212.227.15.18]:42257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgKBOGE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604325960;
        bh=WySublnz2W284yeOpNt16ZWzWONRJhUpDy1Ul0BfowY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BsFLQY+Y4f4u0PEpbcdlvdVupR6ZGvz1HhacznqUKai5aCZAdL9tCPUordDiFj49C
         dOeejOCVx+cIOOJJIBWKFIZSV11Z96veQdfc9Bz8D500oymSuyAo0AnaP6DNrJvmHs
         jPihiJ1Zig2eui8eVe7zKV9gy4X2wLipUrnTW3g0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Ed-1kD1De2Zcz-013MgA; Mon, 02
 Nov 2020 15:06:00 +0100
Subject: Re: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from
 fs_info
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <5d586f76-7cad-b7be-60d3-44c8d3b67623@gmx.com>
Date:   Mon, 2 Nov 2020 22:05:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qUobdW3qRUrA5mUqeCxkreNOW6ZkYxJcO"
X-Provags-ID: V03:K1:x4XW8GnEbq5ZxnlH4yzn2qMrP47/zaeQeAsdEYzBKHwYUJcxkNG
 7ZCArJWQF6zObzTVyP/Fe7VRQiAWIKV1lN3ye70Hp7Mu+p1oRgcp/b6qe41V+SFIEHkwGWw
 LDJHmd4zij2fsEiGW+ybxtL498Nj1hINlwf4xwvc31Kk8yhW+7iaAHI1rCxICJC0sfbWQ40
 Vu3fcwro8IkUF81CHajNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c755QTjRay8=:61eImVo2WBJe+2xGsUm1R0
 iWtD9qZbJS8qimuQ7EHlSevnBSdzRZ0+UPC6rpgzHjDec3wBI17/AvOF5GrgsYu+IOlCcOc6l
 1DAxuFwBVDXTUb15sH0pcv5GpnpSTY136n+Zn234H1+yhPhgQUOLLdYipXn29xd7dQIZeVowB
 Qthd8p//K7bLG1I2FpXEWMNN01o74KqbRbMFegLZlBu+2Yhawa+fxgWR/cQT4sAq/DEeicVzw
 Y8L6Vobl+RdFijQTg7eiGsbtpsILQUbTonFU8oB4PPW5iV4SbWB81EWi5lu4KCUtYcZps4yxL
 hQ9E4LStnaUaJIF0Hsq+KdhGbclxuY5ZlN2yU9tiM58PcftShMeO16URgF0Uq0XwV3kVh2ICn
 BN3Z7Taed8keeElHj/BnZThgjC9Bal08SdJzPqoVRpXD8TqfWLZUH0m/OSdOR5MA+sCwDuePu
 VnaJoAuHdSO+JP3IJwFMt+m1ELNfYUgw8FMA9UdYRt78Q21OpPCjOYwKZFUFId+KZxpoOC8bD
 NyRoEZTL3nsXUoILJzpA9D64DC4DxxmJr1Lw2aBCFX0JyoR2tF8gtJSURQYFnrhxwRl6rZTTN
 +0gQRnYu8J3uHv6ODSPsnL6vyCpmEJC2hESjp8ungUZv159BpwywYrZ+Fefoy4h76hZc2M7Et
 noEUw7Fz4Dj8rSUHlfKquFhgam7O1pUPvCrOORrA1FgCEq7lAqvQXmRVvy9L8Q4ZMGN5OOD8G
 Sx751tB0/iK5PL1SWiJ6R5IM7s0C3TzAMjR+2HQoQXD0zvZi5FUPzg9vDkyGA6nwlnBH1bDFs
 9oUaaBMGAZysmU5Y5/FSaHJMQrZ3MBscH5kOMWGrkgQLXbLIuCoSGgIiSPU8mPrva6wHJBcVX
 PxHDcq5oG5etL1YVFp6Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qUobdW3qRUrA5mUqeCxkreNOW6ZkYxJcO
Content-Type: multipart/mixed; boundary="jB9eOvS8Ipm19lJXKVihh86DJKbtbEpXV"

--jB9eOvS8Ipm19lJXKVihh86DJKbtbEpXV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/29 =E4=B8=8B=E5=8D=8810:27, David Sterba wrote:
> We do a lot of calculations where we divide or multiply by sectorsize.
> We also know and make sure that sectorsize is a power of two, so this
> means all divisions can be turned to shifts and avoid eg. expensive
> u64/u32 divisions.
>=20
> The type is u32 as it's more register friendly on x86_64 compared to u8=

> and the resulting assembly is smaller (movzbl vs movl).
>=20
> There's also superblock s_blocksize_bits but it's usually one more
> pointer dereference farther than fs_info.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h           |  1 +
>  fs/btrfs/disk-io.c         |  2 ++
>  fs/btrfs/extent-tree.c     |  2 +-
>  fs/btrfs/file-item.c       | 11 ++++++-----
>  fs/btrfs/free-space-tree.c | 12 +++++++-----
>  fs/btrfs/ordered-data.c    |  3 +--
>  fs/btrfs/scrub.c           | 12 ++++++------
>  fs/btrfs/tree-checker.c    |  3 ++-
>  8 files changed, 26 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8a83bce3225c..87c40cc5c42e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -931,6 +931,7 @@ struct btrfs_fs_info {
>  	/* Cached block sizes */
>  	u32 nodesize;
>  	u32 sectorsize;
> +	u32 sectorsize_bits;

For the bit shift, it can alwasy be contained in one u8.
Since one u32 is only to be at most 32 bits, it can be easily contained
in u8 whose max value is 255.

This should allow us to pack several u8 together to reduce some memory
usage.

Despite this, the series is pretty good.

Thanks,
Qu
>  	u32 stripesize;
> =20
>  	/* Block groups and devices containing active swapfiles. */
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 601a7ab2adb4..4e67c122389c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2812,6 +2812,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_=
info)
>  	/* Usable values until the real ones are cached from the superblock *=
/
>  	fs_info->nodesize =3D 4096;
>  	fs_info->sectorsize =3D 4096;
> +	fs_info->sectorsize_bits =3D ilog2(4096);
>  	fs_info->stripesize =3D 4096;
> =20
>  	spin_lock_init(&fs_info->swapfile_pins_lock);
> @@ -3076,6 +3077,7 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
>  	/* Cache block sizes */
>  	fs_info->nodesize =3D nodesize;
>  	fs_info->sectorsize =3D sectorsize;
> +	fs_info->sectorsize_bits =3D ilog2(sectorsize);
>  	fs_info->stripesize =3D stripesize;
> =20
>  	/*
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5fd60b13f4f8..29ac97248942 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2145,7 +2145,7 @@ u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_in=
fo *fs_info, u64 csum_bytes)
>  	csum_size =3D BTRFS_MAX_ITEM_SIZE(fs_info);
>  	num_csums_per_leaf =3D div64_u64(csum_size,
>  			(u64)btrfs_super_csum_size(fs_info->super_copy));
> -	num_csums =3D div64_u64(csum_bytes, fs_info->sectorsize);
> +	num_csums =3D csum_bytes >> fs_info->sectorsize_bits;
>  	num_csums +=3D num_csums_per_leaf - 1;
>  	num_csums =3D div64_u64(num_csums, num_csums_per_leaf);
>  	return num_csums;
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 816f57d52fc9..d8cd467b4e0c 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -119,7 +119,7 @@ static inline u32 max_ordered_sum_bytes(struct btrf=
s_fs_info *fs_info,
>  {
>  	u32 ncsums =3D (PAGE_SIZE - sizeof(struct btrfs_ordered_sum)) / csum_=
size;
> =20
> -	return ncsums * fs_info->sectorsize;
> +	return ncsums << fs_info->sectorsize_bits;
>  }
> =20
>  int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
> @@ -369,7 +369,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *in=
ode, struct bio *bio,
>  		 * a single leaf so it will also fit inside a u32
>  		 */
>  		diff =3D disk_bytenr - item_start_offset;
> -		diff =3D diff / fs_info->sectorsize;
> +		diff =3D diff >> fs_info->sectorsize_bits;
>  		diff =3D diff * csum_size;
>  		count =3D min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
>  					    inode->i_sb->s_blocksize_bits);
> @@ -465,7 +465,8 @@ int btrfs_lookup_csums_range(struct btrfs_root *roo=
t, u64 start, u64 end,
>  			start =3D key.offset;
> =20
>  		size =3D btrfs_item_size_nr(leaf, path->slots[0]);
> -		csum_end =3D key.offset + (size / csum_size) * fs_info->sectorsize;
> +		csum_end =3D key.offset +
> +			   ((size / csum_size) >> fs_info->sectorsize_bits);
>  		if (csum_end <=3D start) {
>  			path->slots[0]++;
>  			continue;
> @@ -606,7 +607,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode =
*inode, struct bio *bio,
> =20
>  			data =3D kmap_atomic(bvec.bv_page);
>  			crypto_shash_digest(shash, data + bvec.bv_offset
> -					    + (i * fs_info->sectorsize),
> +					    + (i << fs_info->sectorsize_bits),
>  					    fs_info->sectorsize,
>  					    sums->sums + index);
>  			kunmap_atomic(data);
> @@ -1020,7 +1021,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_han=
dle *trans,
> =20
>  	index +=3D ins_size;
>  	ins_size /=3D csum_size;
> -	total_bytes +=3D ins_size * fs_info->sectorsize;
> +	total_bytes +=3D ins_size << fs_info->sectorsize_bits;
> =20
>  	btrfs_mark_buffer_dirty(path->nodes[0]);
>  	if (total_bytes < sums->len) {
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 6b9faf3b0e96..f09f62e245a0 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -416,16 +416,18 @@ int convert_free_space_to_extents(struct btrfs_tr=
ans_handle *trans,
>  	btrfs_mark_buffer_dirty(leaf);
>  	btrfs_release_path(path);
> =20
> -	nrbits =3D div_u64(block_group->length, block_group->fs_info->sectors=
ize);
> +	nrbits =3D block_group->length >> block_group->fs_info->sectorsize_bi=
ts;
>  	start_bit =3D find_next_bit_le(bitmap, nrbits, 0);
> =20
>  	while (start_bit < nrbits) {
>  		end_bit =3D find_next_zero_bit_le(bitmap, nrbits, start_bit);
>  		ASSERT(start_bit < end_bit);
> =20
> -		key.objectid =3D start + start_bit * block_group->fs_info->sectorsiz=
e;
> +		key.objectid =3D start +
> +			       (start_bit << block_group->fs_info->sectorsize_bits);
>  		key.type =3D BTRFS_FREE_SPACE_EXTENT_KEY;
> -		key.offset =3D (end_bit - start_bit) * block_group->fs_info->sectors=
ize;
> +		key.offset =3D (end_bit - start_bit) <<
> +					block_group->fs_info->sectorsize_bits;
> =20
>  		ret =3D btrfs_insert_empty_item(trans, root, path, &key, 0);
>  		if (ret)
> @@ -540,8 +542,8 @@ static void free_space_set_bits(struct btrfs_block_=
group *block_group,
>  		end =3D found_end;
> =20
>  	ptr =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
> -	first =3D div_u64(*start - found_start, fs_info->sectorsize);
> -	last =3D div_u64(end - found_start, fs_info->sectorsize);
> +	first =3D (*start - found_start) >> fs_info->sectorsize_bits;
> +	last =3D (end - found_start) >> fs_info->sectorsize_bits;
>  	if (bit)
>  		extent_buffer_bitmap_set(leaf, ptr, first, last - first);
>  	else
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 87bac9ecdf4c..7b62dcc6cd98 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -868,7 +868,6 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inod=
e, u64 offset,
>  	struct btrfs_ordered_inode_tree *tree =3D &inode->ordered_tree;
>  	unsigned long num_sectors;
>  	unsigned long i;
> -	u32 sectorsize =3D btrfs_inode_sectorsize(inode);
>  	const u8 blocksize_bits =3D inode->vfs_inode.i_sb->s_blocksize_bits;
>  	const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
>  	int index =3D 0;
> @@ -890,7 +889,7 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inod=
e, u64 offset,
>  			index +=3D (int)num_sectors * csum_size;
>  			if (index =3D=3D len)
>  				goto out;
> -			disk_bytenr +=3D num_sectors * sectorsize;
> +			disk_bytenr +=3D num_sectors << fs_info->sectorsize_bits;
>  		}
>  	}
>  out:
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 54a4f34d4c1c..7babf670c8c2 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2300,7 +2300,7 @@ static inline void __scrub_mark_bitmap(struct scr=
ub_parity *sparity,
>  	u64 offset;
>  	u64 nsectors64;
>  	u32 nsectors;
> -	int sectorsize =3D sparity->sctx->fs_info->sectorsize;
> +	u32 sectorsize_bits =3D sparity->sctx->fs_info->sectorsize_bits;
> =20
>  	if (len >=3D sparity->stripe_len) {
>  		bitmap_set(bitmap, 0, sparity->nsectors);
> @@ -2309,8 +2309,8 @@ static inline void __scrub_mark_bitmap(struct scr=
ub_parity *sparity,
> =20
>  	start -=3D sparity->logic_start;
>  	start =3D div64_u64_rem(start, sparity->stripe_len, &offset);
> -	offset =3D div_u64(offset, sectorsize);
> -	nsectors64 =3D div_u64(len, sectorsize);
> +	offset =3D offset >> sectorsize_bits;
> +	nsectors64 =3D len >> sectorsize_bits;
> =20
>  	ASSERT(nsectors64 < UINT_MAX);
>  	nsectors =3D (u32)nsectors64;
> @@ -2386,10 +2386,10 @@ static int scrub_find_csum(struct scrub_ctx *sc=
tx, u64 logical, u8 *csum)
>  	if (!sum)
>  		return 0;
> =20
> -	index =3D div_u64(logical - sum->bytenr, sctx->fs_info->sectorsize);
> +	index =3D (logical - sum->bytenr) >> sctx->fs_info->sectorsize_bits;
>  	ASSERT(index < UINT_MAX);
> =20
> -	num_sectors =3D sum->len / sctx->fs_info->sectorsize;
> +	num_sectors =3D sum->len >> sctx->fs_info->sectorsize_bits;
>  	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
>  	if (index =3D=3D num_sectors - 1) {
>  		list_del(&sum->list);
> @@ -2776,7 +2776,7 @@ static noinline_for_stack int scrub_raid56_parity=
(struct scrub_ctx *sctx,
>  	int extent_mirror_num;
>  	int stop_loop =3D 0;
> =20
> -	nsectors =3D div_u64(map->stripe_len, fs_info->sectorsize);
> +	nsectors =3D map->stripe_len >> fs_info->sectorsize_bits;
>  	bitmap_len =3D scrub_calc_parity_bitmap_len(nsectors);
>  	sparity =3D kzalloc(sizeof(struct scrub_parity) + 2 * bitmap_len,
>  			  GFP_NOFS);
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 8784b74f5232..c0e19917e59b 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -361,7 +361,8 @@ static int check_csum_item(struct extent_buffer *le=
af, struct btrfs_key *key,
>  		u32 prev_item_size;
> =20
>  		prev_item_size =3D btrfs_item_size_nr(leaf, slot - 1);
> -		prev_csum_end =3D (prev_item_size / csumsize) * sectorsize;
> +		prev_csum_end =3D (prev_item_size / csumsize);
> +		prev_csum_end <<=3D fs_info->sectorsize_bits;
>  		prev_csum_end +=3D prev_key->offset;
>  		if (prev_csum_end > key->offset) {
>  			generic_err(leaf, slot - 1,
>=20


--jB9eOvS8Ipm19lJXKVihh86DJKbtbEpXV--

--qUobdW3qRUrA5mUqeCxkreNOW6ZkYxJcO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+gEkIACgkQwj2R86El
/qg65wf/Q6MCsEwq56r/3kvOjGaTSYEtsCgMQ+fzl0+WzJXgwfDM07vTfuhbEJw1
tERB93NtKWUhGspzFRrStg9TCPWMzmdwUcu3n/CoKtwQo4gwFX58SGFGbkeWxki0
1D66Mbacab9YHrCq1BqxvICTN2/t7mt2kF1sxTE4MuzbPCuigS//hEixXJcb9Jt1
pKmH47K1DzV3jfFhIhTmoe3NiaNaARZRtdkXmZO0aRAF6SH6r9ELkz3EqdDdaIXg
WPgOCm6/Mk2Wsgsmr3eGrj5Cat/trOyS8izeOdF4eNMuI2xBCIqYfUYBZj28ff2u
FKmNj68uO0+dgkBtfCOp82oyEA6EOQ==
=GYJG
-----END PGP SIGNATURE-----

--qUobdW3qRUrA5mUqeCxkreNOW6ZkYxJcO--
