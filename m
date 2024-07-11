Return-Path: <linux-btrfs+bounces-6404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388492F1FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04CA281408
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184A1A0711;
	Thu, 11 Jul 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PVtnRsED"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78371155CB5
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737154; cv=none; b=H9SGbM5H436jG/Hq6oEL9nqMfAlSTidQxrpejfSvMY0zX47R2P+85YGpjlcxeKxufMryQmPQiOV1bA5FjIKqitp9zpxpJhFDa9xfZWG4uvupJF0lh+dO6BWPsj78xqRpxPt9M+uGXkxY00CMuF5ZTlPdlttx6SQ2/DJnDoVx88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737154; c=relaxed/simple;
	bh=265CFC/qURizKrylhJO86hXLxOKSSyxnl6bjzyRnbFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fxEv5HpVLu4tEmFBh8g6MNAZBRalx4IpM29ILLZeI9Mrlfo74F/aQggSWuvF95AAS7oq6090j80mUUFFew22a7nR3GxYb5Cqa5Aw73U1L9hE8uNyxYHqFsbAnhGSLgHp04IXqzqoZEm+/cILLESnR2gMuCrhAdEy7T2lgV5oKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PVtnRsED; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720737143; x=1721341943; i=quwenruo.btrfs@gmx.com;
	bh=9oAPiSvUUkCbzRI5qEjNO7FaH4wl8FvFMhERCptNqY8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PVtnRsEDJONo6UcVQm//zvHT6HUmciVXTVaKbpfgwZRcq/UraaQR3akgsfU9J839
	 L9rcoqnC5BUCh8ZXMQfm4I8sum9E6iLhcYsCi/J67/6fmFqCrQpHvKzNsZg43t0DC
	 Ad3em6QFWPGrpOL7fC4DHTZjOF3SZ3v+qpTboQTcamClOOIh6MjeJLSQ1tBhFVcXr
	 DcP3UbGQPpjxFROwAxXG4To02T9bgHbWjW1Vzz99cKVpxUdT5Y5lEum7pX9KXdEOq
	 LB1p867Y33bcLCjSaM0+FH8OwtKHU2eBZI/liw1O0Cn6JUi/cLrcn4p/xmjM3A3Mb
	 IGvqdgQenY0Eqboihg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1s6uqT3lD9-015YNj; Fri, 12
 Jul 2024 00:32:23 +0200
Message-ID: <a9378265-ad2f-42a6-b506-a919fda20101@gmx.com>
Date: Fri, 12 Jul 2024 08:02:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs-progs: add a helper for clearing all the items
 in a tree
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1720732480.git.boris@bur.io>
 <628cc8e20d7cf460ffdf50f3916860556d6ce3e1.1720732480.git.boris@bur.io>
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
In-Reply-To: <628cc8e20d7cf460ffdf50f3916860556d6ce3e1.1720732480.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GkyWg2AkOFWUNUA3IbDg4/HvIKihYYIdNVjSIiaAHUsJCviQJuC
 ziyN2n9DYvKZsm1M3SkggNz9D53sA98d9BvMQczCy4tcwPfsqSds6KSWy5N0HO0oZIFiSVf
 RXDaSVyHYtMsvD7X1dl+A5ek3Vfq7r4tm4v1LccEv7oNxyZx2AMBm5LJHABHXcdGHjzptLT
 Lm1KxFXzMNMocce0MztFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hxp2r1/CpUw=;P9x9eTAqTGL40z+Rcg1uiBhpU6X
 Tws1yUhiw2J85CdmouQT9ol+ed58wLNjurkhzUmobTcfmQE+0+buGG8I/1FCAi4wH+YuMCC37
 UAjQyRfaGQVpwSubLoueo9VhyatSZcsD6QFb8qIPeSkIFNnsbODlC7M3jAdatBumTTOtv+d+4
 znBxPaU5DpOjJ5Ldy9dY2v1Mb+yiX8Mdy2w6P1jmawiBlcn/uHb/3gSpyfUZ2sE77sXogE2S7
 A8duTapZXp0UWf5iz238f8wQchJQCt3xtvs7pbZSBKCcJAxmWABGnMxDaPdZWXXLR2bPBos6Z
 cW9Lt7R7YIpOV+W/g+QBOJuAfyzjXkLlB9npboanhwTvzHxqVFTOViYaKYybSvKj+oGDlByOq
 +WhhKcU0WvIh2b+HWarbfAt+PxemUhVqNcjvjg8HrhSfs+UruDbtGCKOMeqh8CZIXO6CNrAKC
 qos6jsLi/DDOAcUxYR8hNp9fO+JEMu9jEIBbr+JTwB0WD+quUrPpqquqrdAN4jKnl6komnByV
 xjznB09r2nfwK8rmwUV/01jGArxZ6Z4dv/cZ+elONS2rs/8EWV3pkQsblGe4vuuwghfPcpxo+
 1kiacGiJ9yyamfcvghvnQekQci5e+i/dTCQXhCgplUIpv79Q0zObRqG8Hl/wBSfmWuF0beZl0
 n+PG5M1m8VN212qH4PJUDGbJvy7BV+kT5E/9CyBrQWzQmH5paklmuJ+3yVoopA2Cg06m7DVH8
 KIR5Ao8iKDLDYKTVjQWLygDzq619ZdBImCsBGu2CWOV3KkteQ5sQZS28+kLvt3fl4x78nkgU3
 ihrhjTFCszvBmANbFHnQcUww==



=E5=9C=A8 2024/7/12 06:48, Boris Burkov =E5=86=99=E9=81=93:
> Used in clear_free_space_tree, this is a totally generic operation.
> It will also be used for clearing the qgroup tree from btrfstune.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   kernel-shared/disk-io.c         | 39 ++++++++++++++++++++++++++++++
>   kernel-shared/disk-io.h         |  2 ++
>   kernel-shared/free-space-tree.c | 42 ++-------------------------------
>   3 files changed, 43 insertions(+), 40 deletions(-)
>
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 295bd50ad..1e4c46aa0 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -2342,6 +2342,45 @@ static bool is_global_root(struct btrfs_root *roo=
t)
>   		return true;
>   	return false;
>   }
> +
> +int btrfs_clear_tree(struct btrfs_trans_handle *trans,
> +		     struct btrfs_root *root)

The original function name clear_free_space_tree() is also shared inside
kernel.

Maybe you can also do a cleanup for kernel?

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +{
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf =3D NULL;
> +	int ret;
> +	int nr =3D 0;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	key.objectid =3D 0;
> +	key.offset =3D 0;
> +	key.type =3D 0;
> +
> +	while (1) {
> +		ret =3D btrfs_search_slot(trans, root, &key, path, -1, 1);
> +		if (ret < 0)
> +			goto out;
> +		leaf =3D path->nodes[0];
> +		nr =3D btrfs_header_nritems(leaf);
> +		if (!nr)
> +			break;
> +		path->slots[0] =3D 0;
> +		ret =3D btrfs_del_items(trans, root, path, 0, nr);
> +		if (ret)
> +			goto out;
> +
> +		btrfs_release_path(path);
> +	}
> +	ret =3D 0;
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>   int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
>   			       struct btrfs_root *root)
>   {
> diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
> index 9f848635f..702a5e274 100644
> --- a/kernel-shared/disk-io.h
> +++ b/kernel-shared/disk-io.h
> @@ -241,6 +241,8 @@ int btrfs_fs_roots_compare_roots(const struct rb_nod=
e *node1, const struct rb_no
>   struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
>   				     struct btrfs_fs_info *fs_info,
>   				     struct btrfs_key *key);
> +int btrfs_clear_tree(struct btrfs_trans_handle *trans,
> +		     struct btrfs_root *root);
>   int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
>   			       struct btrfs_root *root);
>   struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 =
bytenr);
> diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-=
tree.c
> index 93806ca01..08b220740 100644
> --- a/kernel-shared/free-space-tree.c
> +++ b/kernel-shared/free-space-tree.c
> @@ -1228,44 +1228,6 @@ out:
>   		btrfs_abort_transaction(trans, ret);
>   	return ret;
>   }
> -static int clear_free_space_tree(struct btrfs_trans_handle *trans,
> -				 struct btrfs_root *root)
> -{
> -	struct btrfs_path *path;
> -	struct btrfs_key key;
> -	int nr;
> -	int ret;
> -
> -	path =3D btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> -
> -	key.objectid =3D 0;
> -	key.type =3D 0;
> -	key.offset =3D 0;
> -
> -	while (1) {
> -		ret =3D btrfs_search_slot(trans, root, &key, path, -1, 1);
> -		if (ret < 0)
> -			goto out;
> -
> -		nr =3D btrfs_header_nritems(path->nodes[0]);
> -		if (!nr)
> -			break;
> -
> -		path->slots[0] =3D 0;
> -		ret =3D btrfs_del_items(trans, root, path, 0, nr);
> -		if (ret)
> -			goto out;
> -
> -		btrfs_release_path(path);
> -	}
> -
> -	ret =3D 0;
> -out:
> -	btrfs_free_path(path);
> -	return ret;
> -}
>
>   int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
>   {
> @@ -1288,7 +1250,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_in=
fo *fs_info)
>
>   		while (key.offset < fs_info->nr_global_roots) {
>   			free_space_root =3D btrfs_global_root(fs_info, &key);
> -			ret =3D clear_free_space_tree(trans, free_space_root);
> +			ret =3D btrfs_clear_tree(trans, free_space_root);
>   			if (ret)
>   				goto abort;
>   			key.offset++;
> @@ -1299,7 +1261,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_in=
fo *fs_info)
>   			      BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
>   		btrfs_set_super_compat_ro_flags(fs_info->super_copy, features);
>
> -		ret =3D clear_free_space_tree(trans, free_space_root);
> +		ret =3D btrfs_clear_tree(trans, free_space_root);
>   		if (ret)
>   			goto abort;
>

