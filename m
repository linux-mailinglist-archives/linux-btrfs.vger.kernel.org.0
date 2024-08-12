Return-Path: <linux-btrfs+bounces-7150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB8A94F994
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 00:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FD1B21FC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB2197A92;
	Mon, 12 Aug 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="n2VY3h4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDF168C33;
	Mon, 12 Aug 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501981; cv=none; b=piI8aK1yvG/nfkA5yDOJ83t+bPZfZ0ZWQk3wOI2IuMwfr/mFb6KuvWWGUR8aW6F2Wfim2ppZXzrmDE297m2Je3/FqtykLo3Bqtd+HsZ4w555mjQYykKiABMO8dxW/Vo/RUJSd7aVeWkwjputHzrl1DeWgfuM7h3/DmMmh+6yg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501981; c=relaxed/simple;
	bh=Qr2or/NTFaKRi/ZZ4sochRGYnPKN1AYAEdC5aRx/OuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lzci+gksrIKAhc9ZxOB/JdVsceC/Mj4jl2hZ3il0EzsjA9m44eQZX28DmRc2MBxGhQxYP4e5TPv4fjZgaz10nIV4U5NwfrhMS+4WA3RW7ItWOxkVuREzEGJZbLTpCwOK6nlPF1vlvI4zOV/BS81n6N8zXoYuLXoPu52at2wodJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=n2VY3h4d; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723501965; x=1724106765; i=quwenruo.btrfs@gmx.com;
	bh=nkgRotjfeo4sM+WHKQIjBrYlsPlcBZNYEVyevQYg3sQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=n2VY3h4dtBsqtYa7TGb/BRxCPmvdX9WiSLhTk49ehWQFBqpgq8TXfSUqYC/fz9d8
	 TgiPWLEHiIvaw6S2RnnPwIze9CFhvafUd2n1LO4/syZbgplfJoY3IcCadU9myZVuC
	 /Y0lQNtNytzHGWqborJM9Ijy1o6S6HfMJtcO8jsgQlTf1h996celEjmZZ8LD711PQ
	 Eedb47JyuRk0w9iVcqXg82HumkF/sInZlI5DdHEB7stHqkF5OAPRL8RdEasgaiH4H
	 We8gw+3/l7QbsZz+Jx9wWq6gtBWlRiFqoPXICFSDU+UxPeFVg2ixBCnvjb/s1Aw7p
	 4AlAao+VROwmKTpvow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNt0C-1soiMW3LGy-00PRKb; Tue, 13
 Aug 2024 00:32:45 +0200
Message-ID: <d1408143-13f2-4e0d-ac60-286bba4d72ab@gmx.com>
Date: Tue, 13 Aug 2024 08:02:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reduce chunk_map lookups in btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240812165931.9106-1-jth@kernel.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240812165931.9106-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GKejVCKTIxa3DNBhaO6Oq2ZYElJyxW7zjCKE4fXom+n1E5Z6Osp
 YX2UIe7MXwsPraU8Vyq1sbrcROatohR5lOQrQ2Q8lx1dq6Ugv6mHN0x0UC6jEDXR1pfqKA8
 a/+CMy8Hc5OHUuggLiTFsosvzpgQ5DsMjLA2qCcYz0Tfri+Y+nhQeOpnww4jGTKAAE0j8Fe
 wyMNFgwUZUWbcpCwqIt0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g2ogGmESCDM=;ZlExshoUPhqkRq218gHy73Ke2PF
 AzN71c0fJtgplvoMVPZH4kkpY7A3U/3XP/RtD3LiHVGsgt53Vd/B50EdIbnRilyD9CNNSVs1X
 n+OD6Rrssiz/gVNdMNMqpqUF+HO6uL6AqgZ92lUeCb59SfzeBC/EHH6osQO+7qhUl21fXNSfX
 h2rAOP+Q723mt1C0NYz0/cZ7NIbF9lEShIdvz5DYAig5o0PPh521TobdQFiiLUP8M5Lfv3nFz
 ePRX8ojGVowdMKa5vbwzJ4xpf8Pxb0ULqhx0PHxca+hvd2Sc2xF23BtbprkCg8uyT1FYP+vyK
 kMCeVn8VLJYFwobNcAws9nSyL213rrz1FgiNhhqC9eoB3UdzkBB1H6dgT4LM72puWHIH6cbYw
 6uKb4bMut31NFjsjwdeeCmrXWmSU3H7O4ATadocTX+Su6djCvSzWUK7RlbkVINZI/r0xdQOBC
 w33as9t5nBQGo6qCX3e/6PZzN+WZW8/hR0DazlVvIaoBaF7nOxc+rbK6eLP1UorFV8y4IT4Fw
 0ScdmaSCczP6qfIY+FIPxujISuaEJ8U7MC5dI3j/ySdvV6rnR3pTZUNkmzp7fEHMRten2tVLl
 pMQKoOZyBA56PjIIzI42xrPCUCBlX4MX8nZHjB7DAI7SKzwm5NUEHjm/mPGQfD8Kfg3Rb3RNS
 6nvwvTaNsOtJn8sIHsxBwC0s28fNMgcKLJYSHoGJwZYxYAQYXOlx3PDsBSh6e00TL6z/+7iBu
 ywHqE7bSnpHHBit2zm+VUXremQmDuphuMCazM+IHmUn8J2tPxDZ/5fs5BJFqlL5fHBwG4xcQs
 4HdjuN1QIkTovuf/FvsM1kdA==



=E5=9C=A8 2024/8/13 02:29, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Currently we're calling btrfs_num_copies() before btrfs_get_chunk_map() =
in
> btrfs_map_block(). But btrfs_num_copies() itself does a chunk map lookup
> to be able to calculate the number of copies.
>
> So split out the code getting the number of copies from btrfs_num_copies=
()
> into a helper called btrfs_chunk_map_num_copies() and directly call it
> from btrfs_map_block() and btrfs_num_copies().
>
> This saves us one rbtree lookup per btrfs_map_block() invocation.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one nitpick inlined below.

> ---
>   fs/btrfs/volumes.c | 50 +++++++++++++++++++++++++++-------------------
>   1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e07452207426..4863bdb4d6f4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5781,10 +5781,33 @@ void btrfs_mapping_tree_free(struct btrfs_fs_inf=
o *fs_info)
>   	write_unlock(&fs_info->mapping_tree_lock);
>   }
>
> +static int btrfs_chunk_map_num_copies(struct btrfs_chunk_map *map)
> +{
> +	enum btrfs_raid_types index =3D btrfs_bg_flags_to_raid_index(map->type=
);
> +
> +	/* Non-RAID56, use their ncopies from btrfs_raid_array. */
> +	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> +		return btrfs_raid_array[index].ncopies;
> +
> +	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
> +		return 2;
> +
> +	/*
> +	 * There could be two corrupted data stripes, we need
> +	 * to loop retry in order to rebuild the correct data.
> +	 *
> +	 * Fail a stripe at a time on every retry except the
> +	 * stripe under reconstruction.
> +	 */
> +	if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> +		return map->num_stripes;
> +
> +	return 1;

IIRC above if()s have checks all profiles.

Thus should we call ASSERT() instead? Or return map->num_stripes since
that's the only remaining possible case.

Thanks,
Qu
> +}
> +
>   int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 l=
en)
>   {
>   	struct btrfs_chunk_map *map;
> -	enum btrfs_raid_types index;
>   	int ret =3D 1;
>
>   	map =3D btrfs_get_chunk_map(fs_info, logical, len);
> @@ -5797,22 +5820,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_inf=
o, u64 logical, u64 len)
>   		 */
>   		return 1;
>
> -	index =3D btrfs_bg_flags_to_raid_index(map->type);
> -
> -	/* Non-RAID56, use their ncopies from btrfs_raid_array. */
> -	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> -		ret =3D btrfs_raid_array[index].ncopies;
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
> -		ret =3D 2;
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> -		/*
> -		 * There could be two corrupted data stripes, we need
> -		 * to loop retry in order to rebuild the correct data.
> -		 *
> -		 * Fail a stripe at a time on every retry except the
> -		 * stripe under reconstruction.
> -		 */
> -		ret =3D map->num_stripes;
> +	ret =3D btrfs_chunk_map_num_copies(map);
>   	btrfs_free_chunk_map(map);
>   	return ret;
>   }
> @@ -6462,14 +6470,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_inf=
o, enum btrfs_map_op op,
>   	io_geom.stripe_index =3D 0;
>   	io_geom.op =3D op;
>
> -	num_copies =3D btrfs_num_copies(fs_info, logical, fs_info->sectorsize)=
;
> -	if (io_geom.mirror_num > num_copies)
> -		return -EINVAL;
> -
>   	map =3D btrfs_get_chunk_map(fs_info, logical, *length);
>   	if (IS_ERR(map))
>   		return PTR_ERR(map);
>
> +	num_copies =3D btrfs_chunk_map_num_copies(map);
> +	if (io_geom.mirror_num > num_copies)
> +		return -EINVAL;
> +
>   	map_offset =3D logical - map->start;
>   	io_geom.raid56_full_stripe_start =3D (u64)-1;
>   	max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);

