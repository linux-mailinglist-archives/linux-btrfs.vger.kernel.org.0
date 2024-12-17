Return-Path: <linux-btrfs+bounces-10443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1BC9F3EC4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 01:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A1C1883797
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B36C2FD;
	Tue, 17 Dec 2024 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JAbfRvyh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557A28F5
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395176; cv=none; b=cWlSpcv/lm446Nd/y8W6Hal/EWpuQ+2+PmExs6grmPk+FEODWAjWn/gia0/qUtp51usdtqrWtJ1ak04sKsgCtiusv6Dmw+u0zJEjeLo3PfcoIZ5uuATWg94CtSNfv410NtQIye7dkT4yD5o5KKV0dkeMIRToeQ3TXGNi/9nw3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395176; c=relaxed/simple;
	bh=WaD/KngJn4iYwoQjPzTTms6WX81wfps5jS3HFIvpcOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dSBs8BD76Tg49NRx46MBVIwP+jgH0seGp5s1PlfUwN7GTK/RZ3exYmSDTSq4/S/Wo8oP8WcKhUxsIlE0zldfhaDQzOUEHJnOcRwFIllX2poPH4b3VYCvjg86WZmG+AOyV6/+4p1Vc6O1lnpnL45ooC1kUX5K6PUwEAQESu5Hgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JAbfRvyh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734395167; x=1734999967; i=quwenruo.btrfs@gmx.com;
	bh=788wfRTkW25upRD0TjLO4V/WgSr4ogKey4ATy55pXSc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JAbfRvyhLtRpf/EEp/iR76jG/RrvSbcnGOZim1xjJoPn1i9FDq7sv1XfCytW6GkY
	 fQMmJzGo1IuPnv3I2d8t7bPM25QSrjEdZ4lPFbCLGJcd91byAwVUsbgCWySVq78bL
	 DKBLAmD8YIa3INh7gbkSeot9TXkG9QgDsOUC140cSkzb/78UMdJRr8CC9hG08wzDt
	 +O1T9GYpzdQy8LJepliJhqMeh94RaLOPQSYLive+5eIHGngGAuZK0ANl0b5sw9mo1
	 yXqh6PRl1rUzIFNAxjOWwWpTBpN1hnKJxlZd1VX2yuVEqpFgSYiQT0xqmTHH6QR5W
	 fQIDcbg7lrUtWjOclQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH5a-1tzi1z03Uy-00kMpz; Tue, 17
 Dec 2024 01:26:07 +0100
Message-ID: <36af89a5-f7e8-4a9f-a7ff-880a84d2fc6d@gmx.com>
Date: Tue, 17 Dec 2024 10:56:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into
 fs.c
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1734368270.git.fdmanana@suse.com>
 <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
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
In-Reply-To: <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iYEqCQnHrZ2Jx4s51g/YvFML7ewfwto+okYcSrUSBzd2ccZ4Wlg
 RiQovadMF7CC8ME5e8eKYKrmUxNX0jf4hvbGne5nPu5jm3c3I3n/goG5y1pRjyEJAjOm686
 phM8NKcAA4mfErcrKgt9W4C0eJW+BmueeIjeWp1Hf2RYvauDECKwqkvS82ooc+LAOwK6EP9
 o9GbSM0x4ovLi5hR0wp2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hs21PfuJUa4=;rTVn62JIjOQOYxk6Qyowf4eTm7O
 lZ3YCp/ZTuJ+FG1XiRPSjvmS4oM4vf/gu9fRQS5vpNGgJXyQTOsO3vX11PwMfDMOUmg4bU3n1
 AYe4fBFo8nJ7PiSaSymloWNn7NddxqD54AVo+8tvAe7a2PO0F1DyqC96w39lrKbK1VFpOkgod
 iaEdJ/yYT7u0ZciGwlVyrn2SMPQT46Zaz8UM9Z5BDJJwV9VQ5uD7eUVbGAqNMr/tSmbrZnfw4
 /LelxJaLg9UFCnQN35G0YyN5VjwSQu4JV2+lOOIKFwT93XzRKnR0PxplNWNe1NOWPZuPsbMB4
 5jPK5nmEP+s26Cs+yF6Tq5AunKqI9xKytoxIUBb5LiNmo7/iRnDkv/bmtEeZLWHQ3PBBz/2ky
 1tZmJ5gzXTeyn4NOFym0ewbDs9tuyWZ+wVjUzQ6O+jXTNkfQnJdl+TWEsEYSeKQncmX79Z2rr
 /1pbBo3QgNIcpNBenHybdMrLo5/TsE4vfwtAngTHKI5jaDc1RTDLpH67GBpX0Tj1lBN34FYdf
 +FUGiaH7/5TMN/K8DIt1LjFU6puVCPB6XKo7McnkNng5HmRoXCFCDZSG1xHgJtdZyyv5YVwrj
 jRA+Jl7gOVfFX0lq/uUT+/96L/GFSJe+r1ypSOJdx8SJzAS6Xclq+u332VnX/ull4UEtjLzCi
 GgU/WVMwY9u97dVbWzH/fmOL1KRBsNtDR8hu84e5kvHLr0Z8U+EVNTkE/5dE+gg4cENHrm8Me
 J+cw3LKiI6mXy9aUnS3ZE+qlsC0s/GiI1L04OAT2GxvyiflDf0vM/1DGoi4QsG969LSA/mZZY
 4Ay9HmXd8jC7O1ku6/qHgCWiPi9gjzsqDDtTZvVnZs6QsCR+qHHtWY6+ZGAm36hbaUclFk+IK
 /Y8OmqULjtm2CdbTaxh2ABXVziF5UjOGYD7Bqt33VkXs7gfheLne4wdvUR6/1z1zbsMy8eESM
 wbgP7UkG9dl8kLpYl9lA/3FQhqemOmSy0bJ7YEIBEQ2/51qGzThhXp2kOGMWabljSO/6rmdGm
 u8FcWc4+DfOJTDRwMfXnRaihsfOx9VBwkpTjs/gMP971jZYEUdZZccCYJVETPeZ/6WI7iGCqC
 te5IsaVpjTeyduJ/KnsqNjRAQrfDKi



=E5=9C=A8 2024/12/17 03:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The ctree module is about the implementation of the btree data structure
> and not a place holder for generic filesystem things like the csum
> algorithm details. Move the functions related to the csum algorithm
> details away from ctree.c and into fs.c, which is a far better place for
> them. Also fix missing punctuation in comments and change one multiline
> comment to a single line comment since everything fits in under 80
> characters.
>
> For some reason this also sligthly reduces the module's size.
>
> Before this change:
>
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1782126	 161045	  16920	1960091	 1de89b	fs/btrfs/btrfs.ko
>
> After this change:
>
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1782094	 161045	  16920	1960059	 1de87b	fs/btrfs/btrfs.ko
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.c | 51 ------------------------------------------------
>   fs/btrfs/ctree.h |  6 ------
>   fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/fs.h    |  6 ++++++
>   4 files changed, 55 insertions(+), 57 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 99a58ede387e..c93f52a30a16 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -37,19 +37,6 @@ static int push_node_left(struct btrfs_trans_handle *=
trans,
>   static int balance_node_right(struct btrfs_trans_handle *trans,
>   			      struct extent_buffer *dst_buf,
>   			      struct extent_buffer *src_buf);
> -
> -static const struct btrfs_csums {
> -	u16		size;
> -	const char	name[10];
> -	const char	driver[12];
> -} btrfs_csums[] =3D {
> -	[BTRFS_CSUM_TYPE_CRC32] =3D { .size =3D 4, .name =3D "crc32c" },
> -	[BTRFS_CSUM_TYPE_XXHASH] =3D { .size =3D 8, .name =3D "xxhash64" },
> -	[BTRFS_CSUM_TYPE_SHA256] =3D { .size =3D 32, .name =3D "sha256" },
> -	[BTRFS_CSUM_TYPE_BLAKE2] =3D { .size =3D 32, .name =3D "blake2b",
> -				     .driver =3D "blake2b-256" },
> -};
> -
>   /*
>    * The leaf data grows from end-to-front in the node.  this returns th=
e address
>    * of the start of the last item, which is the stop of the leaf data s=
tack.
> @@ -148,44 +135,6 @@ static inline void copy_leaf_items(const struct ext=
ent_buffer *dst,
>   			      nr_items * sizeof(struct btrfs_item));
>   }
>
> -/* This exists for btrfs-progs usages. */
> -u16 btrfs_csum_type_size(u16 type)
> -{
> -	return btrfs_csums[type].size;
> -}
> -
> -int btrfs_super_csum_size(const struct btrfs_super_block *s)
> -{
> -	u16 t =3D btrfs_super_csum_type(s);
> -	/*
> -	 * csum type is validated at mount time
> -	 */
> -	return btrfs_csum_type_size(t);
> -}
> -
> -const char *btrfs_super_csum_name(u16 csum_type)
> -{
> -	/* csum type is validated at mount time */
> -	return btrfs_csums[csum_type].name;
> -}
> -
> -/*
> - * Return driver name if defined, otherwise the name that's also a vali=
d driver
> - * name
> - */
> -const char *btrfs_super_csum_driver(u16 csum_type)
> -{
> -	/* csum type is validated at mount time */
> -	return btrfs_csums[csum_type].driver[0] ?
> -		btrfs_csums[csum_type].driver :
> -		btrfs_csums[csum_type].name;
> -}
> -
> -size_t __attribute_const__ btrfs_get_num_csums(void)
> -{
> -	return ARRAY_SIZE(btrfs_csums);
> -}
> -
>   struct btrfs_path *btrfs_alloc_path(void)
>   {
>   	might_sleep();
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2c341956a01c..a1bab0b3f193 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -756,12 +756,6 @@ static inline bool btrfs_is_data_reloc_root(const s=
truct btrfs_root *root)
>   	return root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID;
>   }
>
> -u16 btrfs_csum_type_size(u16 type);
> -int btrfs_super_csum_size(const struct btrfs_super_block *s);
> -const char *btrfs_super_csum_name(u16 csum_type);
> -const char *btrfs_super_csum_driver(u16 csum_type);
> -size_t __attribute_const__ btrfs_get_num_csums(void);
> -
>   /*
>    * We use folio flag owner_2 to indicate there is an ordered extent wi=
th
>    * unfinished IO.
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 31c1648bc0b4..3756a3b9c9da 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -5,6 +5,55 @@
>   #include "fs.h"
>   #include "accessors.h"
>
> +static const struct btrfs_csums {
> +	u16		size;
> +	const char	name[10];
> +	const char	driver[12];
> +} btrfs_csums[] =3D {
> +	[BTRFS_CSUM_TYPE_CRC32] =3D { .size =3D 4, .name =3D "crc32c" },
> +	[BTRFS_CSUM_TYPE_XXHASH] =3D { .size =3D 8, .name =3D "xxhash64" },
> +	[BTRFS_CSUM_TYPE_SHA256] =3D { .size =3D 32, .name =3D "sha256" },
> +	[BTRFS_CSUM_TYPE_BLAKE2] =3D { .size =3D 32, .name =3D "blake2b",
> +				     .driver =3D "blake2b-256" },
> +};
> +
> +/* This exists for btrfs-progs usages. */
> +u16 btrfs_csum_type_size(u16 type)
> +{
> +	return btrfs_csums[type].size;
> +}
> +
> +int btrfs_super_csum_size(const struct btrfs_super_block *s)
> +{
> +	u16 t =3D btrfs_super_csum_type(s);
> +
> +	/* csum type is validated at mount time. */
> +	return btrfs_csum_type_size(t);
> +}
> +
> +const char *btrfs_super_csum_name(u16 csum_type)
> +{
> +	/* csum type is validated at mount time. */
> +	return btrfs_csums[csum_type].name;
> +}
> +
> +/*
> + * Return driver name if defined, otherwise the name that's also a vali=
d driver
> + * name.
> + */
> +const char *btrfs_super_csum_driver(u16 csum_type)
> +{
> +	/* csum type is validated at mount time */
> +	return btrfs_csums[csum_type].driver[0] ?
> +		btrfs_csums[csum_type].driver :
> +		btrfs_csums[csum_type].name;
> +}
> +
> +size_t __attribute_const__ btrfs_get_num_csums(void)
> +{
> +	return ARRAY_SIZE(btrfs_csums);
> +}
> +

I'm wondering if those simple functions can be converted to inline.

Although btrfs_csums[] array has to be put inside fs.c, those functions
seems be fine defined as inline ones inside the header.

Otherwise looks good to me.

Thanks,
Qu
>   void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			     const char *name)
>   {
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 79a1a3d6f04d..b05f2af97140 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -982,6 +982,12 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_=
info,
>
>   int btrfs_check_ioctl_vol_args_path(const struct btrfs_ioctl_vol_args =
*vol_args);
>
> +u16 btrfs_csum_type_size(u16 type);
> +int btrfs_super_csum_size(const struct btrfs_super_block *s);
> +const char *btrfs_super_csum_name(u16 csum_type);
> +const char *btrfs_super_csum_driver(u16 csum_type);
> +size_t __attribute_const__ btrfs_get_num_csums(void);
> +
>   /* Compatibility and incompatibility defines */
>   void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			     const char *name);


