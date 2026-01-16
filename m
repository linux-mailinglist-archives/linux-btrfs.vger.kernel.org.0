Return-Path: <linux-btrfs+bounces-20610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D1D2D273
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 08:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21698300C626
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888134216C;
	Fri, 16 Jan 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sf2xs0+i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19861632C8
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548414; cv=none; b=pCNNF+0KRoTQBcbfap75J1OVBhOzYtT/LPZ5eDwRdJ6ZSzYgR3zOJPI3ZWUYnD6ogN96FPaCRg4LcUDNJazASF14MrH+i0sN9kfRqybI7ZVvwHl1K6GxoZPPGq9cyLGJraP8BgGK5gZ5k/kgAp4xSo8cMvZw/Je7gM9MKPtVQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548414; c=relaxed/simple;
	bh=cdaZ5ardDU8FlNtZMdMB6qo9NOyH8k6ca6ZadsunDbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=spD7RqHwBAhy8HUQdmggeesO/PAXANHERwiDj3W8/77ASJuM4Q+qmIXlHnnzetKSxMjV5fDKBuVp542JxOAmPRFvF579ZhF2hfWryBTdXegd+ZH0NgRvFfg2yRcJLNqkn03IYKNB536jZUTI8spD9woEaHmgHR6vLM/0H4p+eB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sf2xs0+i; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768548411; x=1769153211; i=quwenruo.btrfs@gmx.com;
	bh=xIFgv33VfHUb4yrLN1oXPDLGT7Iw6RK8W3tykYOv2kY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sf2xs0+iZVQGqlBnbAQou6H67Uw7yMs5T6iD6McTe66oupFPezz/7rwTa3nvfCTm
	 0TdZ8NsOmGTyMkQsOqYYV8xb2MHyKxXeP1nhlR33aO39o/R+jyaKu2bbmljiIDXkL
	 n6MfMhNpprQLoPaeMJF0cahiHo1mqKcvBn5BZa4R45WRbgx6sFQi/n3jCoJEN0cC8
	 axnw/WdTI1Ixx3Rf++SQpWhlqFpbUgHvx6nT6kEAVQoJ6ptHD5oyzMpRjBK7rDHzR
	 TX3zf0Y6yVIJiVZc2GsktSaVKtZPHK3RnxZ4Fj+Y4/CcCtjsR68R0ezLejl8k8puD
	 GpPkdh3myzAZz3ekcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1veRIw27GS-008QCQ; Fri, 16
 Jan 2026 08:26:51 +0100
Message-ID: <675a1121-d1b4-4dca-9fb0-4a9cbaa22277@gmx.com>
Date: Fri, 16 Jan 2026 17:56:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
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
In-Reply-To: <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rdg1aouk0sSESGLfuttafhPmREdT5fKalfIrx7ofnIXxHLJ5akW
 4KznCPTuIJhTrEPLgW9qHvOSyvjbOgQdHIa9BtBFKhLhS2hFPMIO77QKuszQ125npkBr9sy
 jKMoZ6C1B394O0SCsAycc4P2a5JFobCt8aVyLbSb4Zkt94Jf26Km1zvlHq8LSA94RUsBVpM
 HGmommbkFhnGOYoMp8UFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/GLWcxa6lIc=;V3+d7VLgIeodJsNvR8VziY0ErTy
 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



=E5=9C=A8 2026/1/16 08:22, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have currently three places that compute how much free space a block
> group has. Add a helper function for this and use it in those places.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>=20
> V2: Fix typos leading to compilation failure.
>=20
>   fs/btrfs/block-group.c | 9 ++-------
>   fs/btrfs/block-group.h | 8 ++++++++
>   fs/btrfs/space-info.c  | 3 +--
>   3 files changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index a1119f06b6d1..d17fe777b727 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1376,8 +1376,7 @@ static int inc_block_group_ro(struct btrfs_block_g=
roup *cache, bool force)
>   		goto out;
>   	}
>  =20
> -	num_bytes =3D cache->length - cache->reserved - cache->pinned -
> -		    cache->bytes_super - cache->zone_unusable - cache->used;
> +	num_bytes =3D btrfs_block_group_free_space(cache);
>  =20
>   	/*
>   	 * Data never overcommits, even in mixed mode, so do just the straigh=
t
> @@ -3089,7 +3088,6 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gr=
oup *cache,
>   void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
>   {
>   	struct btrfs_space_info *sinfo =3D cache->space_info;
> -	u64 num_bytes;
>  =20
>   	BUG_ON(!cache->ro);
>  =20
> @@ -3105,10 +3103,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_=
group *cache)
>   			btrfs_space_info_update_bytes_zone_unusable(sinfo, cache->zone_unus=
able);
>   			sinfo->bytes_readonly -=3D cache->zone_unusable;
>   		}
> -		num_bytes =3D cache->length - cache->reserved -
> -			    cache->pinned - cache->bytes_super -
> -			    cache->zone_unusable - cache->used;
> -		sinfo->bytes_readonly -=3D num_bytes;
> +		sinfo->bytes_readonly -=3D btrfs_block_group_free_space(cache);
>   		list_del_init(&cache->ro_list);
>   	}
>   	spin_unlock(&cache->lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 5f933455118c..6662e644199a 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -295,6 +295,14 @@ static inline bool btrfs_is_block_group_data_only(c=
onst struct btrfs_block_group
>   	       !(block_group->flags & BTRFS_BLOCK_GROUP_METADATA);
>   }
>  =20
> +static inline u64 btrfs_block_group_free_space(const struct btrfs_block=
_group *bg)
> +{
> +	lockdep_assert_held(&bg->lock);
> +
> +	return (bg->length - bg->used - bg->pinned - bg->reserved -
> +		bg->bytes_super - bg->zone_unusable);
> +}
> +
>   #ifdef CONFIG_BTRFS_DEBUG
>   int btrfs_should_fragment_free_space(const struct btrfs_block_group *b=
lock_group);
>   #endif
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 857e4fd2c77e..a9fe6b66c5e1 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -656,8 +656,7 @@ void btrfs_dump_space_info(struct btrfs_space_info *=
info, u64 bytes,
>   		u64 avail;
>  =20
>   		spin_lock(&cache->lock);
> -		avail =3D cache->length - cache->used - cache->pinned -
> -			cache->reserved - cache->bytes_super - cache->zone_unusable;
> +		avail =3D btrfs_block_group_free_space(cache);
>   		btrfs_info(fs_info,
>   "block group %llu has %llu bytes, %llu used %llu pinned %llu reserved =
%llu delalloc %llu super %llu zone_unusable (%llu bytes available) %s",
>   			   cache->start, cache->length, cache->used, cache->pinned,


