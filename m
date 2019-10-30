Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941DDE9BB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJ3Mpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:45:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:35477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfJ3Mpb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572439522;
        bh=MASM7LGMCQRv/YgHjTkEsKwT3Rx0MjFv4qObN5vEMiA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S5ujQC82ltQsL6B6Vdv3571ojznGMK8JdrqD1zwF54P8jycj/meYjtn82ROqr2hRu
         R1BW24XOObZK36o11DcfoAHu22EK6aFSoJXi4cgU6HyttLGVZykMWaGslbzTaFfb2O
         R+wS7rj4f1G7chGUhbw4UEZwttHj/tor32+2Z3aw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1i10cx3bYk-011SiI; Wed, 30
 Oct 2019 13:45:22 +0100
Subject: Re: [PATCH 3/3] btrfs-progs: Remove convert param from
 btrfs_alloc_data_chunk
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20191030122227.28496-1-nborisov@suse.com>
 <20191030122227.28496-4-nborisov@suse.com>
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
Message-ID: <d90e7757-f646-87f7-a729-8c3652154721@gmx.com>
Date:   Wed, 30 Oct 2019 20:45:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191030122227.28496-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+pl8/dH099oe3YnqoP56AcmOYxEkLy6K8rPbmJZxWssmI7Zc8GQ
 T5dNCj2kM9Eb+0xPOQZ6Xn3cd0UvYakXgOFvhpsGHPDLaEQhgCdAgiG2tMBr2T1CHukM1R9
 8m9kEx5LjI8tLWYh5L6LtWdwhuJIR2HyQY9yXjjRjcZLUzqddp5a3laazsmjLi1aNMgadxY
 S2AJRDQrkeLeTh3Vl+X2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XpjWzQ5q0Xc=:whJUOEBLDN4mSjg6KkzGxT
 2BpC8FSiK9qEMZZE0AhcAdlfpLlFkZyAlZFTdugw2ytkhNSigHo9HI5tG16E5RjZlGmJOc+BH
 as8YATQ1vGP/z3W1RkbcvMda0hXQx7eJYRkgah+UrS16QkJabnfB+nW7qjAMN77WOUkeglSuS
 0C28pi8mdFXEacKLSWQYHyv6hpOYoYtLEyjz0vGx8GwsYyFAu4DrY9+usA6kjA4+OWLxwTiW6
 FjJ7AVOf+9drVVDnvOyQelvjnVGkQwm4loysP5mTuL9KhwzwN3bSNP8wFxVoC2yau7vXbs/f5
 R5Vq78iKYXt2HcVYi8j/sWXYqYedqfuLvwpbi7jYG6889ffrEiiC4CyQVOY+/u8bhi637i4nE
 dkZyZFngk9qUzVGHn7Zy0qMfn6odMItDvpagLAi8//JT2w1kGLnIa5cdo5LOwuVubaNDEl6Y1
 R1Entzsi2BMtzG4ohKxJtwiHEJwTTXf/LZJWzkn882rP/XVblxV7ALqmEEqjvrsChETegifFt
 NcrUgCYu6r1yEkgzuEDH6YDw27OyZSzXFBT0D+1oPjQRc2I8AEbHbhLYXb/LbkEuUJmSvIeWo
 oRd7+jq22aCuHwehSm2+McM/eL+E8ooLlXbOULgRYXM9/SJUQK2C9HT8SIR+XBZvu+xDVzvMV
 nahBRkJeqeU/nsWAnWCkFrWRvX2IZSYtiIp6a22+SqrZs62aRhrMhJ5lU9VEc9MM9HWiJRs57
 uxk/3Ir7hBTmzGuyAcbjOsSVavzv3Nexw+k5YgPA2oppferloHdSspVvLG3S0tMlZq684ylQS
 wMhIrHm9Xbbu2kU9szpLsUrB5LVywGms1a60HS4B0GmarQ8xj87TljyNXA/Li6Op2RckCNJsH
 IKaKOBCZBUMjy8S2ec3egwJ7KypNQLv2eDDu6Xb+Cb9w9Kax44u6gyxydTHF900/mCyRQ5Abo
 8SeGf9EROPTMsB6KZIi22AcwU15tSt+JtQpE69FOA17cZ1Shnb6CUGFYT4vJ1WUXPk9RxwIXa
 yF026pGp8ngOIuEi1vkJLRiIyNi/bZuQ8oN7JCrC2IuXHd42iDB+fcul3iCNCEKB2P6jQ5RwY
 05uw7qEmbevc0AVSVQKl3a6Qo5Rp+1HZSDgKPxZS1mfpXhWXFrK+fkV9ALUAgLcCiqzTsjQz+
 W/od5bsBowLN2iGNaBP+cgobuxWFE6AbCGVVbYGvyMRkXM9J2mJoTyuVLdrA1tIOKErJ76lT8
 2jPkQ/kwq33bFGg/mG99t29NviuZKbvZUb5oH3AcOyDZLosjVVAdMVVJMSvI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/30 =E4=B8=8B=E5=8D=888:22, Nikolay Borisov wrote:
> convert is always set to true so there's no point in having it as a
> function parameter or using it as a predicate inside btrfs_alloc_data_ch=
unk.
> Remove it and all relevant code which would have never been executed.
> No semantics changes.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one tip for further patches.

The function btrfs_alloc_data_chunk() is purely used for convert to
create a 1:1 mapped data chunk.

It would be be even better to rename the function to indicate it better.

Thanks,
Qu

> ---
>  convert/main.c |  3 +--
>  volumes.c      | 44 ++++++++++++++------------------------------
>  volumes.h      |  3 +--
>  3 files changed, 16 insertions(+), 34 deletions(-)
>
> diff --git a/convert/main.c b/convert/main.c
> index 9904deafba45..416ab5d264a3 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -942,8 +942,7 @@ static int make_convert_data_block_groups(struct btr=
fs_trans_handle *trans,
>
>  			len =3D min(max_chunk_size,
>  				  cache->start + cache->size - cur);
> -			ret =3D btrfs_alloc_data_chunk(trans, fs_info,
> -					&cur_backup, len, 1);
> +			ret =3D btrfs_alloc_data_chunk(trans, fs_info, &cur_backup, len);
>  			if (ret < 0)
>  				break;
>  			ret =3D btrfs_make_block_group(trans, fs_info, 0,
> diff --git a/volumes.c b/volumes.c
> index 87315a884b49..39e824a43736 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1238,14 +1238,11 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle =
*trans,
>  /*
>   * Alloc a DATA chunk with SINGLE profile.
>   *
> - * If 'convert' is set, it will alloc a chunk with 1:1 mapping
> - * (btrfs logical bytenr =3D=3D on-disk bytenr)
> - * For that case, caller must make sure the chunk and dev_extent are no=
t
> - * occupied.
> + * It allocates a chunk with 1:1 mapping (btrfs logical bytenr =3D=3D o=
n-disk bytenr)
> + * Caller must make sure the chunk and dev_extent are not occupied.
>   */
>  int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
> -			   struct btrfs_fs_info *info, u64 *start,
> -			   u64 num_bytes, int convert)
> +			   struct btrfs_fs_info *info, u64 *start, u64 num_bytes)
>  {
>  	u64 dev_offset;
>  	struct btrfs_root *extent_root =3D info->extent_root;
> @@ -1264,25 +1261,18 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_ha=
ndle *trans,
>  	int stripe_len =3D BTRFS_STRIPE_LEN;
>  	struct btrfs_key key;
>
> -	key.objectid =3D BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> -	key.type =3D BTRFS_CHUNK_ITEM_KEY;
> -	if (convert) {
> -		if (*start !=3D round_down(*start, info->sectorsize)) {
> -			error("DATA chunk start not sectorsize aligned: %llu",
> -					(unsigned long long)*start);
> -			return -EINVAL;
> -		}
> -		key.offset =3D *start;
> -		dev_offset =3D *start;
> -	} else {
> -		u64 tmp;
>
> -		ret =3D find_next_chunk(info, &tmp);
> -		key.offset =3D tmp;
> -		if (ret)
> -			return ret;
> +	if (*start !=3D round_down(*start, info->sectorsize)) {
> +		error("DATA chunk start not sectorsize aligned: %llu",
> +				(unsigned long long)*start);
> +		return -EINVAL;
>  	}
>
> +	key.objectid =3D BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> +	key.type =3D BTRFS_CHUNK_ITEM_KEY;
> +	key.offset =3D *start;
> +	dev_offset =3D *start;
> +
>  	chunk =3D kmalloc(btrfs_chunk_item_size(num_stripes), GFP_NOFS);
>  	if (!chunk)
>  		return -ENOMEM;
> @@ -1303,12 +1293,8 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_han=
dle *trans,
>  	while (index < num_stripes) {
>  		struct btrfs_stripe *stripe;
>
> -		if (convert)
> -			ret =3D btrfs_insert_dev_extent(trans, device, key.offset,
> -					calc_size, dev_offset);
> -		else
> -			ret =3D btrfs_alloc_dev_extent(trans, device, key.offset,
> -					calc_size, &dev_offset);
> +		ret =3D btrfs_insert_dev_extent(trans, device, key.offset, calc_size,
> +				dev_offset);
>  		BUG_ON(ret);
>
>  		device->bytes_used +=3D calc_size;
> @@ -1345,8 +1331,6 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_hand=
le *trans,
>  	ret =3D btrfs_insert_item(trans, chunk_root, &key, chunk,
>  				btrfs_chunk_item_size(num_stripes));
>  	BUG_ON(ret);
> -	if (!convert)
> -		*start =3D key.offset;
>
>  	map->ce.start =3D key.offset;
>  	map->ce.size =3D num_bytes;
> diff --git a/volumes.h b/volumes.h
> index 83ba827e422b..f6f05054b5c4 100644
> --- a/volumes.h
> +++ b/volumes.h
> @@ -271,8 +271,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *tra=
ns,
>  		      struct btrfs_fs_info *fs_info, u64 *start,
>  		      u64 *num_bytes, u64 type);
>  int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
> -			   struct btrfs_fs_info *fs_info, u64 *start,
> -			   u64 num_bytes, int convert);
> +			   struct btrfs_fs_info *fs_info, u64 *start, u64 num_bytes);
>  int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		       int flags);
>  int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>
