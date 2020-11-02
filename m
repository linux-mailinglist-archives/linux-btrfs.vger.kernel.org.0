Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E12A2CD5
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgKBOZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:25:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:37157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgKBOXw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604327027;
        bh=QFkunoCEiGEtEwRLSvsohS2k03iMhthFUeOe9lmIV+g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=I29ix1RC40qNZDqgGyzON22ZNIHZUeTHoYggNzpBOlrPXHpejO5PRmV0PrGpjcQY/
         EGIk7TgXxX/9qgiFVgWGVf8QZWhNeBGTlvD8yYHJrgCFYqRnDqsooQS4Z0YcIOhljs
         lTh7Q0F+nlGhhN5AHlcb+L0KweshXu9XcYu0C4mo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5UN-1kX81l1RzD-00FBrX; Mon, 02
 Nov 2020 15:23:47 +0100
Subject: Re: [PATCH 03/10] btrfs: replace s_blocksize_bits with
 fs_info::sectorsize_bits
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <1021ce9995a25cca9dbfeb49ba298aaff53f0986.1603981453.git.dsterba@suse.com>
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
Message-ID: <8154edcf-f82f-1e1e-8313-433ff46d94c1@gmx.com>
Date:   Mon, 2 Nov 2020 22:23:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1021ce9995a25cca9dbfeb49ba298aaff53f0986.1603981453.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hU6Xe9orWlcCFV3Uiv6uhlz5NFp0pZWlF"
X-Provags-ID: V03:K1:5JUI3VCuh56CMsD04U7dT4nwEXvBr945f6uMg4WQ4zWx69XiAgc
 CDtgvdbHowbybZGWMZTHc8nySSYPr2Raz99iY+y8P6Sr1Q9S+pAl+q8hOPaK18yIvMiUqmh
 6BOQTvC0gmAfFtwL3eZpeNxoJNuhaaYG4DkJdh8rR0Pt3P0ZsEV3ih3bBQ5yNOHbPjEL1qu
 JFWKMer7KPcaYSl9oSubA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ckSS2OChGg=:pDu6fsNPvXznDkrpMFmDty
 F54NqL5ftkOCCBZlhhxt6+itOsLV/ST+h+2mW/hOeBse3Wrl1aifLhI6nexCq54DIpmWnRa4e
 7V72aWk4mz7Suile9nDvOeODnXbERu1KG3oJw1LAnzezTwtCJ9PxzirhvamQjpbdabkU3BndR
 PLl4pBrb5FvxjwVAd/Coo3Ud2e3z9Mtw6u0dr9OT+pm6l0OVbhXCo6ZjMvl2HTVSUkjLaFIqr
 FEj8MIWTXyAP5y0oK1nR+2ZIOh198MmIrYxJoHbsI3TGli3ad2vnjU5HpC49OXROZYLz7HEWP
 6cieX8cwMLKRhwsKg9AgGX1vZH+dekDoz8IyimcMEb4bTtLjIuFSaGuCTgUUvBOe+u4Ft+xdL
 E78BYKVqhx6A73VupkIyqGRQmnpZCFYRaf0NAq8InNq2fpnH9Ijc3ZR8UkbS9+8pcEWWP0OE+
 gRRKRRDFET1GwuANJ2SZx4yxZva8zTofB45MuMXhhwY/vQR+xIQ7rDrZCcmK8UGX0X4ZA1kS/
 OOP+mxgFaYCvbSL0GrZrFtKlnCJ3pfGPAIBaiEYx+C/r00gfH9yukE8MbPlv3s2giYc3NzJ8h
 wZp3rQ1/5Dh5oVmteMK81+wvLbNKhVbMtn+rn6EGzElM4bRimabQbQD4r2gROBYRaqhZ8FVI/
 bMS+rpSje82RlyEuFbYOYhhPh7L6/t2dHAP6ck9bRifUf1HQJiGHSKakBKH8SHr9PNFoBvQ8g
 pCPnKLTUdRznh7/Z32Hp6LZqU2BaRlj0W9awgC0uncjW/XYL8kA666FtcFve5+ZmAv65/LPID
 t4dhrlydPpwBuskdul/6/NK87b9Ht6uzJGrE1lsZDOvgiLKk1kt2S1PjYrdEVtWPq5ja9NPjo
 lYqDttwo+BR99Ks8htgQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hU6Xe9orWlcCFV3Uiv6uhlz5NFp0pZWlF
Content-Type: multipart/mixed; boundary="CTsif6dygMtAunEdaGiDaVvaSmiNITjqb"

--CTsif6dygMtAunEdaGiDaVvaSmiNITjqb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/29 =E4=B8=8B=E5=8D=8810:27, David Sterba wrote:
> The value of super_block::s_blocksize_bits is the same as
> fs_info::sectorsize_bits, but we don't need to do the extra dereference=
s
> in many functions and storing the bits as u32 (in fs_info) generates
> shorter assembly.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

This patch is great.

I was just going to kill all "inode->i_sb->s_blocksize_bits" for subpage.=


Although for subpage case, we may populate sb->s_blocksize_bits to
PAGE_SHIFT, as current subpage doesn't support real subpage write at all.=

Thus we want everything from DIO alignement to reflink alignment to
still be PAGE_SIZE.

With this patch, this allows us to get correct sector size from btrfs
directly, without bothering the superblock block size.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/ctree.h        |  2 +-
>  fs/btrfs/extent_io.c    |  2 +-
>  fs/btrfs/file-item.c    | 34 +++++++++++++++-------------------
>  fs/btrfs/file.c         |  3 +--
>  fs/btrfs/inode.c        |  6 +++---
>  fs/btrfs/ordered-data.c |  6 +++---
>  fs/btrfs/super.c        |  2 +-
>  7 files changed, 25 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 87c40cc5c42e..a1a0b99c3530 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1405,7 +1405,7 @@ struct btrfs_map_token {
>  };
> =20
>  #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
> -				((bytes) >> (fs_info)->sb->s_blocksize_bits)
> +				((bytes) >> (fs_info)->sectorsize_bits)
> =20
>  static inline void btrfs_init_map_token(struct btrfs_map_token *token,=

>  					struct extent_buffer *eb)
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 14d01b76f5c9..cd27a2a4f717 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2652,7 +2652,7 @@ blk_status_t btrfs_submit_read_repair(struct inod=
e *inode,
>  	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
>  	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_t=
ree;
>  	struct btrfs_io_bio *failed_io_bio =3D btrfs_io_bio(failed_bio);
> -	const int icsum =3D phy_offset >> inode->i_sb->s_blocksize_bits;
> +	const int icsum =3D phy_offset >> fs_info->sectorsize_bits;
>  	bool need_validation;
>  	struct bio *repair_bio;
>  	struct btrfs_io_bio *repair_io_bio;
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index d8cd467b4e0c..ed750dd8a115 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -201,7 +201,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,=

>  			goto fail;
> =20
>  		csum_offset =3D (bytenr - found_key.offset) >>
> -				fs_info->sb->s_blocksize_bits;
> +				fs_info->sectorsize_bits;
>  		csums_in_item =3D btrfs_item_size_nr(leaf, path->slots[0]);
>  		csums_in_item /=3D csum_size;
> =20
> @@ -279,7 +279,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *in=
ode, struct bio *bio,
>  	if (!path)
>  		return BLK_STS_RESOURCE;
> =20
> -	nblocks =3D bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
> +	nblocks =3D bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
>  	if (!dst) {
>  		struct btrfs_io_bio *btrfs_bio =3D btrfs_io_bio(bio);
> =20
> @@ -372,7 +372,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *in=
ode, struct bio *bio,
>  		diff =3D diff >> fs_info->sectorsize_bits;
>  		diff =3D diff * csum_size;
>  		count =3D min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
> -					    inode->i_sb->s_blocksize_bits);
> +					    fs_info->sectorsize_bits);
>  		read_extent_buffer(path->nodes[0], csum,
>  				   ((unsigned long)item) + diff,
>  				   csum_size * count);
> @@ -436,8 +436,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *roo=
t, u64 start, u64 end,
>  		btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
>  		if (key.objectid =3D=3D BTRFS_EXTENT_CSUM_OBJECTID &&
>  		    key.type =3D=3D BTRFS_EXTENT_CSUM_KEY) {
> -			offset =3D (start - key.offset) >>
> -				 fs_info->sb->s_blocksize_bits;
> +			offset =3D (start - key.offset) >> fs_info->sectorsize_bits;
>  			if (offset * csum_size <
>  			    btrfs_item_size_nr(leaf, path->slots[0] - 1))
>  				path->slots[0]--;
> @@ -488,10 +487,9 @@ int btrfs_lookup_csums_range(struct btrfs_root *ro=
ot, u64 start, u64 end,
>  			sums->bytenr =3D start;
>  			sums->len =3D (int)size;
> =20
> -			offset =3D (start - key.offset) >>
> -				fs_info->sb->s_blocksize_bits;
> +			offset =3D (start - key.offset) >> fs_info->sectorsize_bits;
>  			offset *=3D csum_size;
> -			size >>=3D fs_info->sb->s_blocksize_bits;
> +			size >>=3D fs_info->sectorsize_bits;
> =20
>  			read_extent_buffer(path->nodes[0],
>  					   sums->sums,
> @@ -644,11 +642,11 @@ static noinline void truncate_one_csum(struct btr=
fs_fs_info *fs_info,
>  	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
>  	u64 csum_end;
>  	u64 end_byte =3D bytenr + len;
> -	u32 blocksize_bits =3D fs_info->sb->s_blocksize_bits;
> +	u32 blocksize_bits =3D fs_info->sectorsize_bits;
> =20
>  	leaf =3D path->nodes[0];
>  	csum_end =3D btrfs_item_size_nr(leaf, path->slots[0]) / csum_size;
> -	csum_end <<=3D fs_info->sb->s_blocksize_bits;
> +	csum_end <<=3D blocksize_bits;
>  	csum_end +=3D key->offset;
> =20
>  	if (key->offset < bytenr && csum_end <=3D end_byte) {
> @@ -696,7 +694,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *tran=
s,
>  	struct extent_buffer *leaf;
>  	int ret;
>  	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> -	int blocksize_bits =3D fs_info->sb->s_blocksize_bits;
> +	u32 blocksize_bits =3D fs_info->sectorsize_bits;
> =20
>  	ASSERT(root =3D=3D fs_info->csum_root ||
>  	       root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID);
> @@ -925,7 +923,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handl=
e *trans,
>  	if (btrfs_leaf_free_space(leaf) >=3D csum_size) {
>  		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>  		csum_offset =3D (bytenr - found_key.offset) >>
> -			fs_info->sb->s_blocksize_bits;
> +			fs_info->sectorsize_bits;
>  		goto extend_csum;
>  	}
> =20
> @@ -943,8 +941,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handl=
e *trans,
> =20
>  	leaf =3D path->nodes[0];
>  	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> -	csum_offset =3D (bytenr - found_key.offset) >>
> -			fs_info->sb->s_blocksize_bits;
> +	csum_offset =3D (bytenr - found_key.offset) >> fs_info->sectorsize_bi=
ts;
> =20
>  	if (found_key.type !=3D BTRFS_EXTENT_CSUM_KEY ||
>  	    found_key.objectid !=3D BTRFS_EXTENT_CSUM_OBJECTID ||
> @@ -960,7 +957,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handl=
e *trans,
>  		u32 diff;
> =20
>  		tmp =3D sums->len - total_bytes;
> -		tmp >>=3D fs_info->sb->s_blocksize_bits;
> +		tmp >>=3D fs_info->sectorsize_bits;
>  		WARN_ON(tmp < 1);
> =20
>  		extend_nr =3D max_t(int, 1, (int)tmp);
> @@ -985,9 +982,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handl=
e *trans,
>  		u64 tmp;
> =20
>  		tmp =3D sums->len - total_bytes;
> -		tmp >>=3D fs_info->sb->s_blocksize_bits;
> +		tmp >>=3D fs_info->sectorsize_bits;
>  		tmp =3D min(tmp, (next_offset - file_key.offset) >>
> -					 fs_info->sb->s_blocksize_bits);
> +					 fs_info->sectorsize_bits);
> =20
>  		tmp =3D max_t(u64, 1, tmp);
>  		tmp =3D min_t(u64, tmp, MAX_CSUM_ITEMS(fs_info, csum_size));
> @@ -1011,8 +1008,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_han=
dle *trans,
>  	item =3D (struct btrfs_csum_item *)((unsigned char *)item +
>  					  csum_offset * csum_size);
>  found:
> -	ins_size =3D (u32)(sums->len - total_bytes) >>
> -		   fs_info->sb->s_blocksize_bits;
> +	ins_size =3D (u32)(sums->len - total_bytes) >> fs_info->sectorsize_bi=
ts;
>  	ins_size *=3D csum_size;
>  	ins_size =3D min_t(u32, (unsigned long)item_end - (unsigned long)item=
,
>  			      ins_size);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 1c97e559aefb..25dc5eb495d8 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1763,8 +1763,7 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
> =20
>  		if (num_sectors > dirty_sectors) {
>  			/* release everything except the sectors we dirtied */
> -			release_bytes -=3D dirty_sectors <<
> -						fs_info->sb->s_blocksize_bits;
> +			release_bytes -=3D dirty_sectors << fs_info->sectorsize_bits;
>  			if (only_release_metadata) {
>  				btrfs_delalloc_release_metadata(BTRFS_I(inode),
>  							release_bytes, true);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1dcccd212809..5582c1c9c007 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2854,7 +2854,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *i=
o_bio, u64 phy_offset,
>  		return 0;
>  	}
> =20
> -	phy_offset >>=3D inode->i_sb->s_blocksize_bits;
> +	phy_offset >>=3D root->fs_info->sectorsize_bits;
>  	return check_data_csum(inode, io_bio, phy_offset, page, offset, start=
,
>  			       (size_t)(end - start + 1));
>  }
> @@ -7737,7 +7737,7 @@ static inline blk_status_t btrfs_submit_dio_bio(s=
truct bio *bio,
>  		u64 csum_offset;
> =20
>  		csum_offset =3D file_offset - dip->logical_offset;
> -		csum_offset >>=3D inode->i_sb->s_blocksize_bits;
> +		csum_offset >>=3D fs_info->sectorsize_bits;
>  		csum_offset *=3D btrfs_super_csum_size(fs_info->super_copy);
>  		btrfs_io_bio(bio)->csum =3D dip->csums + csum_offset;
>  	}
> @@ -7766,7 +7766,7 @@ static struct btrfs_dio_private *btrfs_create_dio=
_private(struct bio *dio_bio,
>  		const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
>  		size_t nblocks;
> =20
> -		nblocks =3D dio_bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bit=
s;
> +		nblocks =3D dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
>  		dip_size +=3D csum_size * nblocks;
>  	}
> =20
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 7b62dcc6cd98..ecc731a6bbae 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -868,7 +868,6 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inod=
e, u64 offset,
>  	struct btrfs_ordered_inode_tree *tree =3D &inode->ordered_tree;
>  	unsigned long num_sectors;
>  	unsigned long i;
> -	const u8 blocksize_bits =3D inode->vfs_inode.i_sb->s_blocksize_bits;
>  	const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
>  	int index =3D 0;
> =20
> @@ -880,8 +879,9 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inod=
e, u64 offset,
>  	list_for_each_entry_reverse(ordered_sum, &ordered->list, list) {
>  		if (disk_bytenr >=3D ordered_sum->bytenr &&
>  		    disk_bytenr < ordered_sum->bytenr + ordered_sum->len) {
> -			i =3D (disk_bytenr - ordered_sum->bytenr) >> blocksize_bits;
> -			num_sectors =3D ordered_sum->len >> blocksize_bits;
> +			i =3D (disk_bytenr - ordered_sum->bytenr) >>
> +			    fs_info->sectorsize_bits;
> +			num_sectors =3D ordered_sum->len >> fs_info->sectorsize_bits;
>  			num_sectors =3D min_t(int, len - index, num_sectors - i);
>  			memcpy(sum + index, ordered_sum->sums + i * csum_size,
>  			       num_sectors * csum_size);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 1ffa50bae1dd..87b390a5351f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2205,7 +2205,7 @@ static int btrfs_statfs(struct dentry *dentry, st=
ruct kstatfs *buf)
>  	u64 total_used =3D 0;
>  	u64 total_free_data =3D 0;
>  	u64 total_free_meta =3D 0;
> -	int bits =3D dentry->d_sb->s_blocksize_bits;
> +	u32 bits =3D fs_info->sectorsize_bits;
>  	__be32 *fsid =3D (__be32 *)fs_info->fs_devices->fsid;
>  	unsigned factor =3D 1;
>  	struct btrfs_block_rsv *block_rsv =3D &fs_info->global_block_rsv;
>=20


--CTsif6dygMtAunEdaGiDaVvaSmiNITjqb--

--hU6Xe9orWlcCFV3Uiv6uhlz5NFp0pZWlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+gFm8ACgkQwj2R86El
/qhNoAf+N68BSHSX5DksZ+JY3BCaikRBYYjQd6dfKXPrfLf2SxHx2f6SINBnUTG5
egdPYLPgb4rPGQfStU6WSu+1c1VVwP/God/7UmCVHtMH+tLfYie31NNIXM77i9py
13aoTZUjEN8aBoxAZaAR7R7Nhidaot+hx/I9MIcamPNnQoM+Nh+9nb8RtLytjMH7
9Bc8NB9IpP1hNaH8CTFtm6KLCESb9AyPxl/bviRrJKEntg1sF4WvPdkIdyYPZB8L
EzUj0A8n61Y9tOjQVLrcCQapJDCKQ8Q4FDvczEvAQ2X8HPOxgzKW7Syyo7GdDzrZ
p+cfafpcs9q0Q2ggsqar41b7Xp2rBg==
=AG61
-----END PGP SIGNATURE-----

--hU6Xe9orWlcCFV3Uiv6uhlz5NFp0pZWlF--
