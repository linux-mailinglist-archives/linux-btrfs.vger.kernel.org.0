Return-Path: <linux-btrfs+bounces-14664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92647AD9B0B
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 09:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896B3189D598
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD721DDC04;
	Sat, 14 Jun 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Z6cqSx8D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1A2E11D2
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749886482; cv=none; b=QtrcGtCjOTLY+8r+vHCHFs1/Lcgfxreo3+qlB7U+nSUcbUqjc0znir90E2sviv5nsCz816O8zFW2PVtshWrH2QwluONKgKcfyTjNJXBC47n+8NwCBt5ua9GVXXjp+yc2YPT08MRwBrCG0YNCZPzwrMxW5L4E7g/MwgnmK9FmOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749886482; c=relaxed/simple;
	bh=jolG9XBsa22RpqcL1qxzuIzC66bh4P/JncqvrRDsR9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OJovpJQ+oIEYZg1CzrYJHvKSEOPEtxQgh8ARxU8OuXgxNZ/IvmIUDwy7n77bzMiDLmAo+asjDynnZn17M33EajW1kN41On08S+irwzjsTpRPr7k4oEPUwODGuS5E8LkXAOVBlqAPKGtBi/5BTCoQ9NVBpMQsTJ3cVNjAr7omEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Z6cqSx8D; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749886478; x=1750491278; i=quwenruo.btrfs@gmx.com;
	bh=q37aQtkXWryQXbVJ6a7SzQ59SHAl1zbNzPwPWFYcnJM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z6cqSx8D+OUYyyrF89bAa+PMglSUhSj6mCick8g+NeWdTF36O0ykMDyxCLdltBcS
	 47B//xX6fk/1HdOJEKKlnfx2LoKazHqP/CeSyR1nFVySVe4Q3DUWtBZRTQonplCPO
	 iPb/cj581dlqHgg/Py8q9j+lROR2W9DZ2c6Rc7amTWjbTDbsDqQYf2sT46pkms+l3
	 ND8T2UZzhshHnyQKQjYVvNEO3vEtF4ZeDD2pD66s98nGRlOpDr6N0OPeiRtZhiDNW
	 1yvG8GNomeAeQ0vVbMZ4zbCYZUp9HM0Lhf0L17xUM5DQrPJ/1M3tFpDgCKptwceR7
	 hFB/S9O4h6FnUK+39w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1uamLT1ci6-007Ix2; Sat, 14
 Jun 2025 09:34:37 +0200
Message-ID: <bc326ef2-9808-4be3-8ccb-2ad7bd3b3db7@gmx.com>
Date: Sat, 14 Jun 2025 17:04:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify btrfs_lookup_inode_extref() by removing
 unused parameters
To: Sun YangKai <sunk67188@gmail.com>, linux-btrfs@vger.kernel.org
References: <20250614033920.3874-1-sunk67188@gmail.com>
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
In-Reply-To: <20250614033920.3874-1-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eK0cDBCjAQlM5k+0tJDhxaIwmqGLqCEG5yeTWto3IsejSljFHmB
 1jh+W/MkwScmXrgF8TAtxzHf72CJgT0jFesHdUk6M+T/RYuhMKTrcyq+lzuSKu0ZRKhoXuS
 pPUffjjVQg8I4Aaj7OMv+nqOGVtNM40xe2xURxqqpqdwoP/tcXNMneF17XYzDdE62qCX7j1
 zhxdQQNICOSxwfIR1WQ3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:omG2KN7I/xk=;TK3DTJhuyOGfou8SPj9lCAqxGFl
 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
 8oVjyNZQVmFGZr5d



=E5=9C=A8 2025/6/14 13:09, Sun YangKai =E5=86=99=E9=81=93:
> The `btrfs_lookup_inode_extref()` function no longer requires transactio=
n
> handle, insert length, or COW flag, as the onlycaller now perform a
> read-only lookup using `trans =3D NULL`, `ins_len =3D 0`, and `cow =3D 0=
`.
>=20
> This patch removes the unused parameters from the function signature and
> call sites, simplifying the interface and clarifying its current usage a=
s
> a read-only lookup helper.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

This function is introduced in the early days where extref feature is=20
introduced by commit f186373fef00 ("btrfs: extended inode refs").
Then some cleanup is done in commit 33b98f227111 ("btrfs: cleanup:=20
removed unused 'btrfs_get_inode_ref_index'"), which removed the only=20
caller passing trans and other COW specific options.

Thanks,
Qu

> ---
>   fs/btrfs/inode-item.c | 8 +++-----
>   fs/btrfs/inode-item.h | 4 +---
>   fs/btrfs/tree-log.c   | 5 ++---
>   3 files changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index a61c3540d67b..a35abe10de64 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -79,12 +79,10 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_ba=
ckref(
>  =20
>   /* Returns NULL if no extref found */
>   struct btrfs_inode_extref *
> -btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
> -			  struct btrfs_root *root,
> +btrfs_lookup_inode_extref(struct btrfs_root *root,
>   			  struct btrfs_path *path,
>   			  const struct fscrypt_str *name,
> -			  u64 inode_objectid, u64 ref_objectid, int ins_len,
> -			  int cow)
> +			  u64 inode_objectid, u64 ref_objectid)
>   {
>   	int ret;
>   	struct btrfs_key key;
> @@ -93,7 +91,7 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *t=
rans,
>   	key.type =3D BTRFS_INODE_EXTREF_KEY;
>   	key.offset =3D btrfs_extref_hash(ref_objectid, name->name, name->len)=
;
>  =20
> -	ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, cow);
> +	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>   	if (ret < 0)
>   		return ERR_PTR(ret);
>   	if (ret > 0)
> diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
> index c11b97fdccc4..c57661bdde30 100644
> --- a/fs/btrfs/inode-item.h
> +++ b/fs/btrfs/inode-item.h
> @@ -102,12 +102,10 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *=
trans,
>   		       struct btrfs_key *location, int mod);
>  =20
>   struct btrfs_inode_extref *btrfs_lookup_inode_extref(
> -			  struct btrfs_trans_handle *trans,
>   			  struct btrfs_root *root,
>   			  struct btrfs_path *path,
>   			  const struct fscrypt_str *name,
> -			  u64 inode_objectid, u64 ref_objectid, int ins_len,
> -			  int cow);
> +			  u64 inode_objectid, u64 ref_objectid);
>  =20
>   struct btrfs_inode_ref *btrfs_find_name_in_backref(const struct extent=
_buffer *leaf,
>   						   int slot,
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 97e933113b82..66fff2bc60f3 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1125,9 +1125,8 @@ static inline int __add_inode_ref(struct btrfs_tra=
ns_handle *trans,
>   	btrfs_release_path(path);
>  =20
>   	/* Same search but for extended refs */
> -	extref =3D btrfs_lookup_inode_extref(NULL, root, path, name,
> -					   inode_objectid, parent_objectid, 0,
> -					   0);
> +	extref =3D btrfs_lookup_inode_extref(root, path, name,
> +					   inode_objectid, parent_objectid);
>   	if (IS_ERR(extref)) {
>   		return PTR_ERR(extref);
>   	} else if (extref) {


