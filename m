Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2612A2CF9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgKBO2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:28:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:52313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgKBO2e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604327308;
        bh=R97JkT6Xbb8DVCyntPVN5Q+uF62r+dv2s9YfOd5LF+0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UNoxcALEfJpJZWh7Wtlr3IXYHu1Q0mj5gquejCpNCEE9wgIvp2vR8vFBiu1iqQY8l
         8Jc1Q6a54iditlmZAV5MQHxayXmAeBdyVT2p3bnZ9is91H+H/7+q5n+dwuj542v8he
         k4brIlHr5WjbFLwW9CWN4CGeHH6UhvY/GH03gvB4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2nK-1jwhJK39Zi-00n7Iw; Mon, 02
 Nov 2020 15:28:27 +0100
Subject: Re: [PATCH 06/10] btrfs: use cached value of fs_info::csum_size
 everywhere
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <cc7bf45e56b81cb2f947adfd83509c9f0a0f32f4.1603981453.git.dsterba@suse.com>
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
Message-ID: <d5340abb-7251-e9ed-b92b-45e322e2b7ef@gmx.com>
Date:   Mon, 2 Nov 2020 22:28:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cc7bf45e56b81cb2f947adfd83509c9f0a0f32f4.1603981453.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kCeciOierPb6PX1UicLUdqwqcatKmb2mI"
X-Provags-ID: V03:K1:+weCq6FjFcM4JymcsaAYGDxBF69p0/rINBKAQoENjzYSQ7raFuL
 +Jn+now/lWriXN+OHRH/z2/akkDMPB6WPM19a8+qbt84LjUsH3ecwDMDEx7ySHoWufktoP0
 79FdFAAu+4r8X0vTJqzmglOZw/hepQRi+Mdx6zgT/TyW8TwzSsvQp0fcKMQLzg9L/0GQRoa
 YTWGUMnvsmsVqeF1GFCOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:59ybZ1a5tR8=:vuRQ07mgNXqdwTx+M5NBH8
 cXOPZ1LKN8yPVd+DKZWaW5d750AKPJnkYaIFL+R3znJqZFE+sFsU6DnAKBG1BWgVNVYKjRfgF
 nFvRJmzoO46CuaVUlsk4270I2Y7IAznuUvAWMEJ3bRFipDaRNFgtPUtKWgR+B9453r4SN8wSZ
 4ea/xCzaYACE0elfD4JyWINd8RJpywx6woxYFilRp3BmmOQVV0sCoJFZ78gTl0/UTk2Gz+pnv
 q+3pqaxTMzpy3S1Pu4ZVWGUeFZ9p2FGmICs39u+kPn23Pzr9VIifj1VIW6WcWCTLqs0DSAJb8
 uSrw+Q9Pv1IyS/5LaVE04CYl4T4/n4qyuRmjZb90M7uzYAcodBC5n1DUTCWQa2dqfibEnnOjW
 TIQLqnUKYQwjxcCQdjdTTxCg15N9yg6gtT5/u5+jShKTih+s9B7x9ytnFwa7+XAe1nnDfSaQa
 OhW7ALIfEoSInZpIIErpoZEiMptnz+18874cBCMBzrYXsJpVI38QQ5GrMZ74pLhs2CIv/jpID
 coaVDD/we4YSw7Z133fgbKRYnUsJmx2hRAs7xYsexcVQmn/7NyRYtWmx68J3XULd6V3VU4DiZ
 c61a+zXY6vzXoPgHZ04SuqAQSt9SHAzbvMcE7q3HgNkfw5rmvbnSglJyeD46lSUyohyrr+nG3
 7YI1Z4Z65YmieNUgNoHl50gK1C5lrMvf3dKu16KT9kCHHdyGW8mXqsJWDzjJldyJkjEsnh8D+
 +FOknSNux8z/EjnDsEi8ewN/xAxuPhDJTo7R7v0+KgtjPTzpEcuVAUC1QrJcx25Ppmwt3+1TS
 SygMoMhLE4x+Qu9qKfB01k4MEBOB3eUISwb3gpr8rvGJWaCY8iVp0DShgyLvXVIduVWTV90RR
 5zvjhDihrzYQEThPlpIA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kCeciOierPb6PX1UicLUdqwqcatKmb2mI
Content-Type: multipart/mixed; boundary="bglPWlnQ6ZK0rESEPAxEiBRqmvjCss54D"

--bglPWlnQ6ZK0rESEPAxEiBRqmvjCss54D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/29 =E4=B8=8B=E5=8D=8810:27, David Sterba wrote:
> btrfs_get_16 shows up in the system performance profiles (helper to rea=
d
> 16bit values from on-disk structures). This is partially because of the=

> checksum size that's frequently read along with data reads/writes, othe=
r
> u16 uses are from item size or directory entries.
>=20
> Replace all calls to btrfs_super_csum_size by the cached value from
> fs_info.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/btrfs_inode.h     |  3 +--
>  fs/btrfs/check-integrity.c |  2 +-
>  fs/btrfs/compression.c     |  6 +++---
>  fs/btrfs/disk-io.c         |  6 +++---
>  fs/btrfs/extent_io.c       |  2 +-
>  fs/btrfs/file-item.c       | 14 +++++++-------
>  fs/btrfs/inode.c           |  6 +++---
>  fs/btrfs/ordered-data.c    |  2 +-
>  fs/btrfs/ordered-data.h    |  2 +-
>  fs/btrfs/scrub.c           |  2 +-
>  fs/btrfs/tree-checker.c    |  2 +-
>  11 files changed, 23 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 92dd86bceae3..f1c9cbd0d184 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -341,8 +341,7 @@ static inline void btrfs_print_data_csum_error(stru=
ct btrfs_inode *inode,
>  		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
>  {
>  	struct btrfs_root *root =3D inode->root;
> -	struct btrfs_super_block *sb =3D root->fs_info->super_copy;
> -	const u16 csum_size =3D btrfs_super_csum_size(sb);
> +	const u16 csum_size =3D root->fs_info->csum_size;
> =20
>  	/* Output minus objectid, which is more meaningful */
>  	if (root->root_key.objectid >=3D BTRFS_LAST_FREE_OBJECTID)
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 81a8c87a5afb..2905fe5974e6 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -660,7 +660,7 @@ static int btrfsic_process_superblock(struct btrfsi=
c_state *state,
>  		return -1;
>  	}
> =20
> -	state->csum_size =3D btrfs_super_csum_size(selected_super);
> +	state->csum_size =3D state->fs_info->csum_size;
> =20
>  	for (pass =3D 0; pass < 3; pass++) {
>  		int num_copies;
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 972fb68a85ac..00bbd859f31b 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -131,7 +131,7 @@ static int btrfs_decompress_bio(struct compressed_b=
io *cb);
>  static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
>  				      unsigned long disk_size)
>  {
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
> =20
>  	return sizeof(struct compressed_bio) +
>  		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * csum_size;
> @@ -142,7 +142,7 @@ static int check_compressed_csum(struct btrfs_inode=
 *inode, struct bio *bio,
>  {
>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> -	const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	struct page *page;
>  	unsigned long i;
>  	char *kaddr;
> @@ -628,7 +628,7 @@ blk_status_t btrfs_submit_compressed_read(struct in=
ode *inode, struct bio *bio,
>  	struct extent_map *em;
>  	blk_status_t ret =3D BLK_STS_RESOURCE;
>  	int faili =3D 0;
> -	const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	u8 *sums;
> =20
>  	em_tree =3D &BTRFS_I(inode)->extent_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f870e252aa37..e22e8de31c07 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -319,7 +319,7 @@ static int btrfs_check_super_csum(struct btrfs_fs_i=
nfo *fs_info,
>  	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
>  			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
> =20
> -	if (memcmp(disk_sb->csum, result, btrfs_super_csum_size(disk_sb)))
> +	if (memcmp(disk_sb->csum, result, fs_info->csum_size))
>  		return 1;
> =20
>  	return 0;
> @@ -452,7 +452,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *=
fs_info, struct page *page)
>  	u64 start =3D page_offset(page);
>  	u64 found_start;
>  	u8 result[BTRFS_CSUM_SIZE];
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	struct extent_buffer *eb;
>  	int ret;
> =20
> @@ -541,7 +541,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_=
bio *io_bio, u64 phy_offset,
> =20
>  	eb =3D (struct extent_buffer *)page->private;
>  	fs_info =3D eb->fs_info;
> -	csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	csum_size =3D fs_info->csum_size;
> =20
>  	/* the pending IO might have been the only thing that kept this buffe=
r
>  	 * in memory.  Make sure we have a ref for all this other checks
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cd27a2a4f717..e943fff35608 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2685,7 +2685,7 @@ blk_status_t btrfs_submit_read_repair(struct inod=
e *inode,
>  	repair_bio->bi_private =3D failed_bio->bi_private;
> =20
>  	if (failed_io_bio->csum) {
> -		const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +		const u16 csum_size =3D fs_info->csum_size;
> =20
>  		repair_io_bio->csum =3D repair_io_bio->csum_inline;
>  		memcpy(repair_io_bio->csum,
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index ed750dd8a115..a4a68a224342 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -181,7 +181,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,=

>  	struct btrfs_csum_item *item;
>  	struct extent_buffer *leaf;
>  	u64 csum_offset =3D 0;
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	int csums_in_item;
> =20
>  	file_key.objectid =3D BTRFS_EXTENT_CSUM_OBJECTID;
> @@ -270,7 +270,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *in=
ode, struct bio *bio,
>  	u32 diff;
>  	int nblocks;
>  	int count =3D 0;
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
> =20
>  	if (!fs_info->csum_root || (BTRFS_I(inode)->flags & BTRFS_INODE_NODAT=
ASUM))
>  		return BLK_STS_OK;
> @@ -409,7 +409,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *roo=
t, u64 start, u64 end,
>  	int ret;
>  	size_t size;
>  	u64 csum_end;
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
> =20
>  	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>  	       IS_ALIGNED(end + 1, fs_info->sectorsize));
> @@ -541,7 +541,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode =
*inode, struct bio *bio,
>  	int i;
>  	u64 offset;
>  	unsigned nofs_flag;
> -	const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
> =20
>  	nofs_flag =3D memalloc_nofs_save();
>  	sums =3D kvzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_siz=
e),
> @@ -639,7 +639,7 @@ static noinline void truncate_one_csum(struct btrfs=
_fs_info *fs_info,
>  				       u64 bytenr, u64 len)
>  {
>  	struct extent_buffer *leaf;
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	u64 csum_end;
>  	u64 end_byte =3D bytenr + len;
>  	u32 blocksize_bits =3D fs_info->sectorsize_bits;
> @@ -693,7 +693,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *tran=
s,
>  	u64 csum_end;
>  	struct extent_buffer *leaf;
>  	int ret;
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	u32 blocksize_bits =3D fs_info->sectorsize_bits;
> =20
>  	ASSERT(root =3D=3D fs_info->csum_root ||
> @@ -848,7 +848,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handl=
e *trans,
>  	int index =3D 0;
>  	int found_next;
>  	int ret;
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
> =20
>  	path =3D btrfs_alloc_path();
>  	if (!path)
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5582c1c9c007..549dca610f8c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2796,7 +2796,7 @@ static int check_data_csum(struct inode *inode, s=
truct btrfs_io_bio *io_bio,
>  	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	char *kaddr;
> -	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	u8 *csum_expected;
>  	u8 csum[BTRFS_CSUM_SIZE];
> =20
> @@ -7738,7 +7738,7 @@ static inline blk_status_t btrfs_submit_dio_bio(s=
truct bio *bio,
> =20
>  		csum_offset =3D file_offset - dip->logical_offset;
>  		csum_offset >>=3D fs_info->sectorsize_bits;
> -		csum_offset *=3D btrfs_super_csum_size(fs_info->super_copy);
> +		csum_offset *=3D fs_info->csum_size;
>  		btrfs_io_bio(bio)->csum =3D dip->csums + csum_offset;
>  	}
>  map:
> @@ -7763,7 +7763,7 @@ static struct btrfs_dio_private *btrfs_create_dio=
_private(struct bio *dio_bio,
>  	dip_size =3D sizeof(*dip);
>  	if (!write && csum) {
>  		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -		const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +		const u16 csum_size =3D fs_info->csum_size;
>  		size_t nblocks;
> =20
>  		nblocks =3D dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index ecc731a6bbae..4d612105b991 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -868,7 +868,7 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inod=
e, u64 offset,
>  	struct btrfs_ordered_inode_tree *tree =3D &inode->ordered_tree;
>  	unsigned long num_sectors;
>  	unsigned long i;
> -	const u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
>  	int index =3D 0;
> =20
>  	ordered =3D btrfs_lookup_ordered_extent(inode, offset);
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index c3a2325e64a4..4662fd8ca546 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -137,7 +137,7 @@ static inline int btrfs_ordered_sum_size(struct btr=
fs_fs_info *fs_info,
>  					 unsigned long bytes)
>  {
>  	int num_sectors =3D (int)DIV_ROUND_UP(bytes, fs_info->sectorsize);
> -	int csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csum_size =3D fs_info->csum_size;
> =20
>  	return sizeof(struct btrfs_ordered_sum) + num_sectors * csum_size;
>  }
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 7babf670c8c2..d4f693a4ca38 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -610,7 +610,7 @@ static noinline_for_stack struct scrub_ctx *scrub_s=
etup_ctx(
>  	atomic_set(&sctx->bios_in_flight, 0);
>  	atomic_set(&sctx->workers_pending, 0);
>  	atomic_set(&sctx->cancel_req, 0);
> -	sctx->csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> +	sctx->csum_size =3D fs_info->csum_size;
> =20
>  	spin_lock_init(&sctx->list_lock);
>  	spin_lock_init(&sctx->stat_lock);
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index c0e19917e59b..5efaf1f811e2 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -336,7 +336,7 @@ static int check_csum_item(struct extent_buffer *le=
af, struct btrfs_key *key,
>  {
>  	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>  	u32 sectorsize =3D fs_info->sectorsize;
> -	u32 csumsize =3D btrfs_super_csum_size(fs_info->super_copy);
> +	const u16 csumsize =3D fs_info->csum_size;
> =20
>  	if (key->objectid !=3D BTRFS_EXTENT_CSUM_OBJECTID) {
>  		generic_err(leaf, slot,
>=20


--bglPWlnQ6ZK0rESEPAxEiBRqmvjCss54D--

--kCeciOierPb6PX1UicLUdqwqcatKmb2mI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+gF4MACgkQwj2R86El
/qhYcQf/Q7ncd4CQWcQhkvAF/vovFIDQJfH2nbkF+S7jDGAeAFi4WaCPvvVKlBoF
qGWyD5oKFeqgn84EYYkqzV6g4laHsQSISjVDuiOnCreM1iJx8VD5gMBdBrYP0Srl
cMEabkn1iHtYuAAD2N3V5IwmDh3J6uPuPawrcUvCw10aaws2+aaP4uDR5h5WfGsq
tI96l49qkEoisRQBM+/f1242Y8uJHMK41mRh4MwtDQe52hpldZuFnS9dnHWE1N8w
EEX3Hhw4pFRhcZMJvHDuXj9yij44dKsxwfRIWY1RSUEwmDtdiWSUxl60uimixSaC
isjN2tBKCi6YMmmSlLTGXXSgdi+8LQ==
=jqzq
-----END PGP SIGNATURE-----

--kCeciOierPb6PX1UicLUdqwqcatKmb2mI--
