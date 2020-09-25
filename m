Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9A277CFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 02:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIYAkE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 20:40:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:39753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgIYAkE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 20:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600994397;
        bh=e8lf7mOdfPTq1SoZd+JSxliu+cxs7pssGUAGc26+Kzk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Zeqo9jGlMdmks0qFobbr8CXf/NVyD72WeHn3V2L3tyg8+Haz2kXNeOpmsvKscSIQS
         CsrE5O/9vaxOev3sU+McA5+PzmVyYaFxyq6uD0qA5RA0h78Mp3TEmmfgKGvbLy5qep
         KTBG4V3rt74ZtDn3LSIRw8dOBAHF9UJDA4LIF0ds=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sHo-1kQXio2dV4-0050ZF; Fri, 25
 Sep 2020 02:39:57 +0200
Subject: Re: [PATCH 2/5] btrfs: push the NODATASUM check into
 btrfs_lookup_bio_sums
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
 <bdf1bf5c65679fdf39021e16a242094acd71b270.1600961206.git.josef@toxicpanda.com>
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
Message-ID: <a3d17402-7e3d-7fb4-9831-2db5be18d5b2@gmx.com>
Date:   Fri, 25 Sep 2020 08:39:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bdf1bf5c65679fdf39021e16a242094acd71b270.1600961206.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xx7NFr293VzVQxSefb3Fg0ISWIFUxtaSY"
X-Provags-ID: V03:K1:Gwy1HMGFyVsaNkTq4PAFYXzV+fV28FgEG6zp593lnmW6KLCKdBH
 fomyZIkSvDBPnoLExBCr5M5e2B7OTDcDHpTYhXdOL9cgBTs1g4MplNdqDJgr1jngNoLoPoK
 1Nger92O7hHWy39hSoTCpzOalUxm0iYc4V83hECeiOt390waSpvbyNY0M9GwSxE9snBZ9Ln
 8AMkS3sa+TZHQ6yoHL2sQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qFOagxRD6ZM=:gAKfKOTxW83uqh5glmG+xp
 T2lwZjnYeCtMWCQ9TXImpfrGOhVZ0Bjwq1jzJ4JD7wnzeCL+m2Ox9ezCh8+y9gCnrGuRgKeIi
 NytlWV0Wtf+Ezt+ftfm7omr2Yzt17XaEb7mFkeLVruQ9Y9uyEnEv+XRepL4hWrMiKP2Xm33Fh
 JbKZWmKm4UUU4zAh2lyxj7RgyiHP7uwwTEoczUHBCzZ+fqOFUWyRBe6Hnh3mLTG+n/OAzK5P6
 fcBPB1iTHm038Ue83bf/XQSwp8+Bq31HIutshD+UNN82v7Bo4UklVINs83Nnx5E/HWXpxJOy5
 9jua9L1sCGRxM7XiX5xn5+z2mFFmnV2Sae+lf6oA2TxpJZhokgDJllDw3gw6C2xhu6WweQxjV
 bYLusXToNs+eUsYpDvLMB1P0FB2xSeLOY8OJJt7tQtGRo3XVUui1nEIQDbWGuHBE3DPsAneek
 FqyZ9fWU8Jcx9lQl3l3MeQzsAJyntPW9jEkT0p4DfNORGfNxXn0GBw7ParkohR53wHh9ZWd3H
 UrtXP4NLY7bKZX8dyY5OGfY3sexptttBnSMp9A0dyyFLPvc2LKz5DJqD2CNk4XIh3WPX3KfLK
 0q8FCLryskz6ylO6mDIA8uqS9uSbsgj/g3jNVQVO67ZZR7MAoBZeOArQ3IBfFgSfFit+fxA7O
 WMH4PjV8k3UsWwl50Wf8tWUttRsrk7KK2vReYIF1DrA08lWMwfQV8tj1Ujea9cwfWdVX7WEHI
 uwGpCwbKYv74vnOQnJLRhbKUPeOQTFh4n4aI6H3s9OS3Cev7rzzVlLAc58gSUSqoB7LFuVJ3W
 Uu3nTZPNmMxG5R1y0SMtbHTO+sjCfwiK2H1Vsa7Cbmf81mD31uo00cNkngCnvp+isB/pP5+D1
 8q5JOs3m1dxKipGZ4RWpO9ZSbYu8b1oxqZ4YP4ghjSyBKx2bLHh7PqlpMs5lxWECjdYzJuelS
 e2hqaUqsQXpeXaXTHWVfxJDWe1ASNFbDuLQBy0OxRJP7uvPjrFX3NtvxGr9fLDuppkE62jEov
 7J4/5QSCODT4b4rGc2cQabdUk8PmrkPrl86pwmDchIE0IhaDbJyfEjXbZ1OKJtA7waDratB6D
 htNITYAll8ZdJnkoCQUWZyOu3ea5QjtZxkYtxKnOc6bWzdM4pQYevKoDbZ8JLKCrr/WO0cXdZ
 yrFiLD45jhHm/z2SN/NaDCy9kCANjhRozsh7AY/rfhtDRD+LuOy4ZJIkjXQ3LqB7PqhZM1a1m
 91qekWQazYfqhvHWtavcprdnNfBORbLZD7pkM2Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xx7NFr293VzVQxSefb3Fg0ISWIFUxtaSY
Content-Type: multipart/mixed; boundary="bQ7dLhVRrR5aRSdJ90kBdNMozgZEjwhoT"

--bQ7dLhVRrR5aRSdJ90kBdNMozgZEjwhoT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8B=E5=8D=8811:32, Josef Bacik wrote:
> When we move to being able to handle NULL csum_roots it'll be cleaner t=
o
> just check in btrfs_lookup_bio_sums instead of at all of the caller
> locations, so push the NODATASUM check into it as well so it's unified.=

>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But an off-topic question inlined below:

> ---
>  fs/btrfs/compression.c | 14 +++++---------
>  fs/btrfs/file-item.c   |  3 +++
>  fs/btrfs/inode.c       | 12 +++++++++---
>  3 files changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index eeface30facd..7e1eb57b923c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -722,11 +722,9 @@ blk_status_t btrfs_submit_compressed_read(struct i=
node *inode, struct bio *bio,
>  			 */
>  			refcount_inc(&cb->pending_bios);
> =20
> -			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> -				ret =3D btrfs_lookup_bio_sums(inode, comp_bio,
> -							    (u64)-1, sums);
> -				BUG_ON(ret); /* -ENOMEM */

Is it really possible to have compressed extent without data csum?
Won't nodatacsum disable compression?

Or are we just here to handle some old compressed but not csumed data?

Thanks,
Qu

> -			}
> +			ret =3D btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1,
> +						    sums);
> +			BUG_ON(ret); /* -ENOMEM */
> =20
>  			nr_sectors =3D DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
>  						  fs_info->sectorsize);
> @@ -751,10 +749,8 @@ blk_status_t btrfs_submit_compressed_read(struct i=
node *inode, struct bio *bio,
>  	ret =3D btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
>  	BUG_ON(ret); /* -ENOMEM */
> =20
> -	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> -		ret =3D btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1, sums);
> -		BUG_ON(ret); /* -ENOMEM */
> -	}
> +	ret =3D btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1, sums);
> +	BUG_ON(ret); /* -ENOMEM */
> =20
>  	ret =3D btrfs_map_bio(fs_info, comp_bio, mirror_num);
>  	if (ret) {
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 8f4f2bd6d9b9..8083d71d6af6 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -272,6 +272,9 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *in=
ode, struct bio *bio,
>  	int count =3D 0;
>  	u16 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
> =20
> +	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
> +		return BLK_STS_OK;
> +
>  	path =3D btrfs_alloc_path();
>  	if (!path)
>  		return BLK_STS_RESOURCE;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d526833b5ec0..d262944c4297 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2202,7 +2202,12 @@ blk_status_t btrfs_submit_data_bio(struct inode =
*inode, struct bio *bio,
>  							   mirror_num,
>  							   bio_flags);
>  			goto out;
> -		} else if (!skip_sum) {
> +		} else {
> +			/*
> +			 * Lookup bio sums does extra checks around whether we
> +			 * need to csum or not, which is why we ignore skip_sum
> +			 * here.
> +			 */
>  			ret =3D btrfs_lookup_bio_sums(inode, bio, (u64)-1, NULL);
>  			if (ret)
>  				goto out;
> @@ -7781,7 +7786,6 @@ static blk_qc_t btrfs_submit_direct(struct inode =
*inode, struct iomap *iomap,
>  		struct bio *dio_bio, loff_t file_offset)
>  {
>  	const bool write =3D (bio_op(dio_bio) =3D=3D REQ_OP_WRITE);
> -	const bool csum =3D !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);=

>  	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>  	const bool raid56 =3D (btrfs_data_alloc_profile(fs_info) &
>  			     BTRFS_BLOCK_GROUP_RAID56_MASK);
> @@ -7808,10 +7812,12 @@ static blk_qc_t btrfs_submit_direct(struct inod=
e *inode, struct iomap *iomap,
>  		return BLK_QC_T_NONE;
>  	}
> =20
> -	if (!write && csum) {
> +	if (!write) {
>  		/*
>  		 * Load the csums up front to reduce csum tree searches and
>  		 * contention when submitting bios.
> +		 *
> +		 * If we have csums disabled this will do nothing.
>  		 */
>  		status =3D btrfs_lookup_bio_sums(inode, dio_bio, file_offset,
>  					       dip->csums);
>=20


--bQ7dLhVRrR5aRSdJ90kBdNMozgZEjwhoT--

--Xx7NFr293VzVQxSefb3Fg0ISWIFUxtaSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9tPFkACgkQwj2R86El
/qhEAAf/dhsVljVX0TtHLVeKDNQWnFzVMyhwcGp6g1iQ82fhNAozb2FlmNtwM6Jj
R+r7yMc3GAU5zUiEVvNV9BreFGrXKuhDXWe/Ll1J8vJCr96nCYm0Vh7iLN/KJHC2
3AfemmTMat3v/IM8Z1F+1oqoOymE/e/II0MrRQ8cr9Lp+YpYcy+0J+/tyQ4KFeWC
CI1NROBdp+Wo6lU9JyAlvKhFU+z1sobm8nmSoB9MDEJwWWHfX9pJlrCz5PyEw851
frlxJbni6orLjjKt6GOxl3+zTslEyOEhZv7dJFaT+i7A/GIZZMls3hyQ9rd2SzJB
FP6jU0Ny7hGT9kOciJox6Z0ff2+j3A==
=u0ZV
-----END PGP SIGNATURE-----

--Xx7NFr293VzVQxSefb3Fg0ISWIFUxtaSY--
