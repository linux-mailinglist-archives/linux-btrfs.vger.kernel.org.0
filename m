Return-Path: <linux-btrfs+bounces-6255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D396928F8A
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 01:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C261F22F69
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 23:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3B1487E1;
	Fri,  5 Jul 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VxuyEC6Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B44145A0E;
	Fri,  5 Jul 2024 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720222153; cv=none; b=PStr64Vv22fLUjSozmm9ijiabBYLl1G89YDOJLJueacyZHIkOBm/46ipbn0rQ3mx95M016iperfgdO546W4V+hFtvwx0Ori4SUAYz82r4G0ciRfTP5l5v5D5bEr7e0EkckGuAhTaQd1XRt/jbUmYi7/axTVt32vpq+ldgxv64QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720222153; c=relaxed/simple;
	bh=B0D2OJ2RYoZ35gmbJ+It72kP6PlKoxma9WkmF6H1qmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prb9wkjZTx4BZwLhGBqVHg0qZNO4gbvr5e+6so2ckbbmjwyDpAOyERhLkdt9+PndPogjZWC0Q2fBLUhfgeOxoonFrrVUdjYh1ND01MjpQIQlcuekETDsxyoM8jGoP3a4WuaVK+s9czwrPS8+m0Qtdir/lbsRuJKXqfDLl7N7IEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VxuyEC6Y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720222138; x=1720826938; i=quwenruo.btrfs@gmx.com;
	bh=abKSkO0vfpGjY7lu92zfZV1FnQJk5DZDKam7BVpzvPY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VxuyEC6YOS6WE+dvhtdQSXwAIAdvQnP6wkQ5NkyPyyx2Qe7QFh5TxPKZHOgaRRm9
	 4qKKOCsaMHQ0JmvXvI3YTPTXrS8XxK8UenqrKVmqucMX7xfPh88CEkFLEVvAalKXh
	 sw6e4lX9m4B4irBRQzsC6iKDzKmYw88b2wZaJ4Lo6XYsp3nl2eiL0gRqlDEFRFsGL
	 rlFbqgZDd3EjP2QMr3NIT2bgYnXVNt8tpydm6+T4xPaI5DenExvlpUvLBAxi9quY/
	 FOXychkBxOI2JUzwQSD9/f+IDVY5DxC55HdW/o0it2/iHQL15LF709Z/WBztqO4V/
	 0aw8wE51CAL6z5n6YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1sRo2H0rHL-00Fp0k; Sat, 06
 Jul 2024 01:28:58 +0200
Message-ID: <29cd4e79-de21-41ea-8241-2706d37fe4ae@gmx.com>
Date: Sat, 6 Jul 2024 08:58:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-5-f3eed3f2cfad@kernel.org>
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
In-Reply-To: <20240705-b4-rst-updates-v4-5-f3eed3f2cfad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wmDCLOCHARycJNMJ4Yj6uwfpLNjh+SAtDDDWcEVsnC0aCzuMBO0
 N7xjAJ7MTQkBP5xElYAENAC0YKkm3dWqbaGTbOUEG+HOW17UdWp4UiSwKggRKHIlSfepbW6
 bIS7Lnbopy4RmYfjyh+y8Z7dvo6+tmovZnx9ow8TyTiOiDLA+e6wTXWE7H9xkUIEcddAkUk
 todphm7dcWscmHyE9D0aA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9CYoSiTcWXM=;1eaGSu7Xa1fc7wC9Fg+qpb28Qjs
 wdeDX5gmXPGtsvvAHkNKcBrFUUTSt7qvrcbcHvN+hlcj1hrXnSbH52eKYA54MgvaB8NbzkyKp
 S0SnPeZac5oqkR2B517L1qsIUfhA1MzDC/4Mu/u0pqKlogYM9Ybxw7x8wh2S0imbJWuTQVKNC
 IYfHmN2W46mMGe6OjjBNnLkNGP1NKhzlknlgJVI7TK21yvqErXbX6ODIGAGv1i4994Y7WTDbO
 D+brdXX2WwVl40GQOCqbxA91SrckFJc2Td0oQsZ8xGrcxnDnHOjJkfigS4SAnwi2wGVN4ExoM
 TsurKtvt44r48IuqTpceoq/XCP3tDNLZRJzOwWG/ZWTNtIYuk8O1/UR0IGykA+hfRX7R9xQ1t
 ovb6aSskH/0mnl3Sv+V6APnicQumWDcUX+qb7WhTSjqJjTJQmCjuHq4jjfkdAt+Ct2ah/bFEc
 ZenWYNK74sSX0/8q08LRxfXn22nUq3FeeIfNlqy1+xlUUlEejNL6EUt/0dTsK2FN0Mhm4yNT/
 2D9bsi42vVTfj3GH3rcj8yMh+qvub0IPOkp6A2aA13srnCKqB7f/aixb0720T4sE2zlBZzCMm
 Rsj7LUbBrUuAmRu+lclOa8eiXG4lGzTo/AHKLYBwhMzbc5mW5YBoedf5RTdOiS90HcpnVU1Y4
 XP4r0jbHEKhOiJaSDqiseawj7Wz0DnO6HNVIbT8AXNE4GTDVKz23AC9qbv6H3wr1f4oM+H2wb
 TDM3JZYM27JDOOxM7SzfuVmqyCrivH+Cned38XKkWYnjhfkYUK1g3OX0zU86p0kAvADqpGYIm
 Tgw7mirspebZG/KXHyIualu9LLYRq6QW41I1uPIOR74RY=



=E5=9C=A8 2024/7/6 00:43, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().
>
> It is only needed to protect
> a) calls to find_live_mirror() and
> b) calling into handle_ops_on_dev_replace().
>
> But there is no need to hold the rwsem for any kind of set_io_stripe()
> calls.
>
> So relax taking the dev_replace rwsem to only protect both cases and che=
ck
> if the device replace status has changed in the meantime, for which we h=
ave
> to re-do the find_live_mirror() calls.
>
> This fixes a deadlock on raid-stripe-tree where device replace performs =
a
> scrub operation, which in turn calls into btrfs_map_block() to find the
> physical location of the block.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fcedc43ef291..4209419244a1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6650,14 +6650,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>   	max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
>   	*length =3D min_t(u64, map->chunk_len - map_offset, max_len);
>
> +again:
>   	down_read(&dev_replace->rwsem);
>   	dev_replace_is_ongoing =3D btrfs_dev_replace_is_ongoing(dev_replace);
> -	/*
> -	 * Hold the semaphore for read during the whole operation, write is
> -	 * requested at commit time but must wait.
> -	 */
> -	if (!dev_replace_is_ongoing)
> -		up_read(&dev_replace->rwsem);
>
>   	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
>   	case BTRFS_BLOCK_GROUP_RAID0:
> @@ -6695,6 +6690,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   			   "stripe index math went horribly wrong, got stripe_index=3D%u, n=
um_stripes=3D%u",
>   			   io_geom.stripe_index, map->num_stripes);
>   		ret =3D -EINVAL;
> +		up_read(&dev_replace->rwsem);
>   		goto out;
>   	}
>
> @@ -6710,6 +6706,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   		 */
>   		num_alloc_stripes +=3D 2;
>
> +	up_read(&dev_replace->rwsem);
> +
>   	/*
>   	 * If this I/O maps to a single device, try to return the device and
>   	 * physical block information on the stack instead of allocating an
> @@ -6782,6 +6780,18 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>   		goto out;
>   	}
>
> +	/*
> +	 * Check if something changed the dev_replace state since
> +	 * we've checked it for the last time and if redo the whole
> +	 * mapping operation.
> +	 */
> +	down_read(&dev_replace->rwsem);
> +	if (dev_replace_is_ongoing !=3D
> +	    btrfs_dev_replace_is_ongoing(dev_replace)) {
> +		up_read(&dev_replace->rwsem);
> +		goto again;
> +	}
> +
>   	if (op !=3D BTRFS_MAP_READ)
>   		io_geom.max_errors =3D btrfs_chunk_max_errors(map);
>
> @@ -6789,6 +6799,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   	    op !=3D BTRFS_MAP_READ) {
>   		handle_ops_on_dev_replace(bioc, dev_replace, logical, &io_geom);
>   	}
> +	up_read(&dev_replace->rwsem);
>
>   	*bioc_ret =3D bioc;
>   	bioc->num_stripes =3D io_geom.num_stripes;
> @@ -6796,11 +6807,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>   	bioc->mirror_num =3D io_geom.mirror_num;
>
>   out:
> -	if (dev_replace_is_ongoing) {
> -		lockdep_assert_held(&dev_replace->rwsem);
> -		/* Unlock and let waiting writers proceed */
> -		up_read(&dev_replace->rwsem);
> -	}
>   	btrfs_free_chunk_map(map);
>   	return ret;
>   }
>

