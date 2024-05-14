Return-Path: <linux-btrfs+bounces-4998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D78C5DEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 00:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11EE2829EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 22:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC18182C8C;
	Tue, 14 May 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AqNwSVKu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC14181CFB
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727298; cv=none; b=sGCaWeMRR+r5sqyluSrWhuWxztrJ54wmRssGhU0N7Qe8plLOz9+XrhVdFRzTaNFLDPyhqWBR5BX4R+FclgPAHsDbWKFMz6cSJgqXDtD1sJ6WtPMqn34cP/Zkb0MuK7Z8qkRNnQCct4kYb/fFQRW7fykWRk2QS/4Hpe9P0ytxntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727298; c=relaxed/simple;
	bh=DXVW/DrZMJD+VLMY4h/sw0gQY2huw/1TYS6FoAmvnCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OBqrpveJdDAc23ZZcUK9cWGQZ2U4B7XunFUtSCE0xFdKKTA6LthNlhERNAf2fDHmWs0Qf1qvx6du1KXq+6wEEYSsVnwfzbe0NPo5KNbPimBAjmmq1PoTb5DBe1Ofq+/8F0elC3ELoyLmtT02epDICzIhWYOK+W/GqfAw5Xwt65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AqNwSVKu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715727291; x=1716332091; i=quwenruo.btrfs@gmx.com;
	bh=lWnSIGoHJ2uXDKJ6VlnUhbvOGQUAzBf6YmiKYzGo+ps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AqNwSVKu7VOcLzDHIYMFzHw/dcl5/wuywdUERXIoI1iWzCOPrlajDlVLe1Mu3Rl1
	 G+lyCo5qYlgqLxJv0VoYAnKoa/KGbOZqbwVNM5B32oATfbFOgboSRkZRlqn1CBo22
	 ylYHhdMu6+eHP4rnytEA33qmS5miIMIHrEHODG/+Ih8jO1x6vBvv1GW4CcTIKVxML
	 DcAjlsSARAyg8HENbgp4lm5LDQZRv6kGYTrHC+XkB7cNe600tyRM4aSFP+dh0M4sA
	 rx8tkkmIk3uPJ9EibuxvpVdgV2nir/i3LkuhNv78E9cj50w4CdUhWy5N4kxxcaoXk
	 GrHr/6LKPCc9uVYS+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3He-1sMOAc2lpo-00FQVJ; Wed, 15
 May 2024 00:54:51 +0200
Message-ID: <bc637e8e-de79-46d8-b13d-e80d49131b8f@gmx.com>
Date: Wed, 15 May 2024 08:24:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] btrfs-progs: mkfs: fix minimum size calculation
 for zoned mode
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-5-naohiro.aota@wdc.com>
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
In-Reply-To: <20240514182227.1197664-5-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B7eQ/zN+T5FCwxPhPdsN/PTnzYmLSH39wt2pvB2ku7Kphc6EZAn
 IHwyBS6maqiclBwrcYZSnzUvOme/8Jd/l240bgqC8QxZH4OA2fR/M8q+/4ktu6dP2LCqIjw
 /oRhnGXvrntD1rMmQg+ILTOcvVD6gdYbT0dSo+78L39j4T+D+euolthCqQ4I9/preleVs7w
 A43j5qzYxyqs55ExG3OKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KJxsInnbJgw=;LHieBQ6skdz72RwmtQdmpl++wXY
 ioIAQmFrGSO1bZs67PcsSU6BIh3DhJXZ5X5bqvydyPZtIAICHEBgXpdakLBiSStkadrvacpiE
 AK2tjOekc3ktwoESky2KYMvovSykFxLTK+V4yntptgUoyqYHlDK1CaRkbo5J/yq3vMKHwhwSp
 mntVQmIbBlCZ6yWbtwnirs254RWCKGCQFQ8dHRM48L3xrzka4KNxh5P0u1T/re8beqCcv3kEZ
 5vLlpSIB2C/9aoRhsdV64YkUVs6qezSoZ7P7VUFfNeSsitUevAIgYxX5WiHlVOAtqlQMdazvH
 o+OUELlQk28V+nwMsu6KuGHHqDIzyet3q2nKnH6s/mcIeYEovTLmioHZpI9WVomOXDALZ3qMS
 qB/fmWZ/Up1HO2/Bfxpl6/5PokDRzgpqqv/YLC+jG24L+Q5ZfyZ6iXqGIDATLpEkv2Sn28hl7
 CXjjatH5b4aNXNmCM3q+F3MhJ2S2bhwkR0hIPu8I9ZXqiERqW2G8nS+PO32W99fRNi0PKmge0
 jnZWSQEaxBK1FyLPG0ZhPAolgOtUYaq+1N9Cd5bVpuP3N7O0AL24MyY8CoRxbKep6Uojv9oLE
 T2NWa0yhW8c3XoZpxMqfsizmvWCY5vLQvl3Pg5AobU4lsO9xs4GojYg+pkkMSsvaDy2bXgWq2
 z8GIjM1GwcOMnRXHpRZQT6dnbnslf4OtAeHxX20KPD8HGGsOJIu2Z3ATqvuCAFH9blo2Cgt7d
 /RLrjgwXVnn8l4EQUwhFcNuoFo735D9mVtdBObICOXx2cA8noFIpq/EjGFyOJfgs8qIWRc7yp
 L3+rr2C+wsob3xfDuWFAS4uK019wseblcXNg87zZOK4O4=



=E5=9C=A8 2024/5/15 03:52, Naohiro Aota =E5=86=99=E9=81=93:
> Currently, we check if a device is larger than 5 zones to determine we c=
an
> create btrfs on the device or not. Actually, we need more zones to creat=
e
> DUP block groups, so it fails with "ERROR: not enough free space to
> allocate chunk". Implement proper support for non-SINGLE profile.
>
> Also, current code does not ensure we can create tree-log BG and data
> relocation BG, which are essential for the real usage. Count them as
> requirement too.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   mkfs/common.c | 53 +++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index af54089654a0..a5100b296f65 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -818,14 +818,51 @@ u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u=
64 zone_size, u64 meta_profile
>   	u64 meta_size;
>   	u64 data_size;
>
> -	/*
> -	 * 2 zones for the primary superblock
> -	 * 1 zone for the system block group
> -	 * 1 zone for a metadata block group
> -	 * 1 zone for a data block group
> -	 */
> -	if (zone_size)
> -		return 5 * zone_size;
> +	if (zone_size) {
> +		/* 2 zones for the primary superblock. */
> +		reserved +=3D 2 * zone_size;
> +
> +		/*
> +		 * 1 zone each for the initial system, metadata, and data block
> +		 * group
> +		 */
> +		reserved +=3D 3 * zone_size;
> +
> +		/*
> +		 * non-SINGLE profile needs:
> +		 * 1 zone for system block group
> +		 * 1 zone for normal metadata block group
> +		 * 1 zone for tree-log block group
> +		 *
> +		 * SINGLE profile only need to add tree-log block group

This comments looks a little confusing to me.

As (for now) the non-SINGLE profiles for metadata is only DUP, thus they
needs at least 2 zones for each bg.

It's only explained later in the "meta_size *=3D 2;" line.

Would the following ones be a little better?

/*
  * non-SINGLE profile needs:
  * 1 extra system block group
  * 1 extra normal metadata block group
  * 1 extra tree-log block group
  *
  * SINGLE profiles needs:
  * 1 extra tree-log block group
  */
  if (meta_profiles & BTRFS_BLOCK_GROUP_DUP)
      factor =3D 2;
  if (meta_profiles & BTRFS_BLOCK_GROUP_PROFILE_MASK)
      meta_size =3D 3 * zone_size * factor;
  else
      meta_size =3D 1 * zone_size * factor;

Otherwise looks reasonable to me.

Thanks,
Qu
> +		 */
> +		if (meta_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
> +			meta_size =3D 3 * zone_size;
> +		else
> +			meta_size =3D zone_size;
> +		/* DUP profile needs two zones for each block group. */
> +		if (meta_profile & BTRFS_BLOCK_GROUP_DUP)
> +			meta_size *=3D 2;
> +		reserved +=3D meta_size;
> +
> +		/*
> +		 * non-SINGLE profile needs:
> +		 * 1 zone for data block group
> +		 * 1 zone for data relocation block group
> +		 *
> +		 * SINGLE profile only need to add data relocationblock group
> +		 */
> +		if (data_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK)
> +			data_size =3D 2 * zone_size;
> +		else
> +			data_size =3D zone_size;
> +		/* DUP profile needs two zones for each block group. */
> +		if (data_profile & BTRFS_BLOCK_GROUP_DUP)
> +			data_size *=3D 2;
> +		reserved +=3D data_size;
> +
> +		return reserved;
> +	}
>
>   	if (mixed)
>   		return 2 * (BTRFS_MKFS_SYSTEM_GROUP_SIZE +

