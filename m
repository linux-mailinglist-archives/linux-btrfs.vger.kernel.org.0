Return-Path: <linux-btrfs+bounces-17132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29DB97CBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786363B42AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF130FC0C;
	Tue, 23 Sep 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QG7XItGb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A672E972C
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758669710; cv=none; b=PM8u/D6sljMug+j3LWdk5SuldYRkn0nMH+gokji5qQ/Uz91GBzwxyZjXqPihZKrRw3B0sAV24ATBut5zPvmTrokGHBfpPLuu/JihAgcsjeTx3ekGbFnN5yAc2J02k/tRu84LFr4kCUjraO9T1LotB3RPhSnDCMWxUJolN1VHDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758669710; c=relaxed/simple;
	bh=cjfNHKQovJXWUgPIcF8M8bNQY6IS8JjL/sGkRjr6I7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UHNyAjNAcOaYcsdvt8pf2pMyFEvFeueIq7D3XGshtygCNTyDgjuIsZdbTBm/LUpPlKEZXs1Vttrn3N8AA89t1zpb1oTOOo5ciIdA+xvMCZ7XqAForWOAasO/LidI5T0xlfbxSbjkffLVhhifn0OBuncfLgZZwhcn5yRPhmQvcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QG7XItGb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758669706; x=1759274506; i=quwenruo.btrfs@gmx.com;
	bh=Oc0PbuLT8i3Foa99tHAvPBdgpJa0ed1C4T3HVH0jRvk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QG7XItGb5zbOSdxonaps6SyiTAeFTTCfHs5dX2eXWMxJ9uYTzbkqcHzqxvCuACHi
	 zDkkp0tvYxCGUEumydzdG9oXZqO/JqiMwwjzXuAjYGeVITER5NjXqsYFl0ymzsekT
	 Hpgd6Bksx7mpRcHfbyCBJj9Lfsfx/0TvLnb5A9e0Add1bWEUBX+xfoQGTqUF9JFjC
	 PnP84SrLBzmjUVQ0KLczk1u/PKi1aPBQoUSbszAwC5m2cAAQvKT0uaqEAo1UDCDSe
	 ibWG/p6lNDaXBlyQnuAmH6MEDkDWUOjAQqaQBgGWErZvKA3j9WkFA5m4T1EGVWIKT
	 avqL5n725tItKZUXpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1uERCt1gYM-014Ggu; Wed, 24
 Sep 2025 01:21:46 +0200
Message-ID: <88517a08-527b-4adc-9a7b-30e0b2c24077@gmx.com>
Date: Wed, 24 Sep 2025 08:51:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle ENOMEM from alloc_bitmap()
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <0380625eee35a412417a8780e74255830486f2d6.1758660529.git.boris@bur.io>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <0380625eee35a412417a8780e74255830486f2d6.1758660529.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QPQHnghuFYEXHgc4wbi2GIl/L8kqXCbHrkxUDzKynyRyX/ipYUu
 LKGtHvy9Zg8SCdELCZpNrCfVXmsqMigg9yFJqN3J+m3rGPO5S2jQ2wQL/QQALur3kTCjVKk
 ClmU0/R1Nzo9FyRHXFhAc7kPvgUB6jR8X36apRL0xIuUHroRGtH3sfIfu3seXSUCuZOPcVs
 Aujftk2Tl1RsktAKAVKtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dhv1YJZ7WdM=;Vay4y8kxGGcQUsjCwShb4hzHolC
 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
 /IPQXHEVGq4wnB0wPk/REyUyeMi8



=E5=9C=A8 2025/9/24 06:19, Boris Burkov =E5=86=99=E9=81=93:
> btrfs_convert_free_space_to_bitmaps() and
> btrfs_convert_free_space_to_extents() both allocate a bitmap struct
> with:
>=20
>          bitmap_size =3D free_space_bitmap_size(fs_info, block_group->le=
ngth);
>          bitmap =3D alloc_bitmap(bitmap_size);
>          if (!bitmap) {
>                  ret =3D -ENOMEM;
>                  btrfs_abort_transaction(trans);
>                  return ret;
>          }
>=20
> This conversion is done based on a heuristic and the check triggers each
> time we call update_free_space_extent_count() on a block group (each
> time we add/remove an extent or modify a bitmap). Furthermore, nothing
> relies on maintaining some invariant of bitmap density, it's just an
> optimization for space usage. Therefore, it is safe to simply ignore
> any memory allocation errors that occur, rather than aborting the
> transaction and leaving the fs read only.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/free-space-tree.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index eba7f22ae49c..18008e288acd 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -218,11 +218,8 @@ int btrfs_convert_free_space_to_bitmaps(struct btrf=
s_trans_handle *trans,
>  =20
>   	bitmap_size =3D free_space_bitmap_size(fs_info, block_group->length);
>   	bitmap =3D alloc_bitmap(bitmap_size);
> -	if (!bitmap) {
> -		ret =3D -ENOMEM;
> -		btrfs_abort_transaction(trans, ret);
> -		goto out;
> -	}
> +	if (!bitmap)
> +		return 0;
>  =20
>   	start =3D block_group->start;
>   	end =3D block_group->start + block_group->length;
> @@ -361,11 +358,8 @@ int btrfs_convert_free_space_to_extents(struct btrf=
s_trans_handle *trans,
>  =20
>   	bitmap_size =3D free_space_bitmap_size(fs_info, block_group->length);
>   	bitmap =3D alloc_bitmap(bitmap_size);
> -	if (!bitmap) {
> -		ret =3D -ENOMEM;
> -		btrfs_abort_transaction(trans, ret);
> -		goto out;
> -	}
> +	if (!bitmap)
> +		return 0;
>  =20
>   	start =3D block_group->start;
>   	end =3D block_group->start + block_group->length;


