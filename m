Return-Path: <linux-btrfs+bounces-13876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A566AAB30F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 10:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11688189B993
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF019E83C;
	Mon, 12 May 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="g9ZZiUvo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7B198A11
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036817; cv=none; b=UIEr3FtrY+R16ckkobMZ77AEyOFfSJRS2x2y8R99bYGhIeKTVZ/kw+kglmvpD5Z8bWN6/W6o8J+oGFZ6kBYybeC0+mwLqKqppPXSCsSDbRNP+UrpQxDz52uD8zxU/uF7AW4lQhjj33ImTmyBcKAZhTZFsv597FgdED3lS7ok+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036817; c=relaxed/simple;
	bh=8I9lQZP2CDXoXbofxaBn33vh+Z12fxZHGKUUQ74d0rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uOFYnanT1l85GO7/8GW00lU4kTd+bx2SkCcLYEWXg1wURjwREFLu1w+KxbBuJpp2Bc4gWtFkkct5csA+Vg3KUeHhw5UdtDffXZ2oBezDR/6SMRfjDstqyHnREKKG57/KxbUiWFrSf71aKBPChRX1jujRL05bPQCIxfdW+djdkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=g9ZZiUvo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747036807; x=1747641607; i=quwenruo.btrfs@gmx.com;
	bh=uGPOomdxIDsp5X1sCLzq6Ecfx8NFxiNBYXhRVlXyboM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g9ZZiUvodRrJdAh+x39d4vl6Hf3cSneHAvjlcTVma3ICIPcx08vYAy4JsRuNR/wo
	 1P0IGULXmzzUqMDoIAJRko5XcK1HZzsI6UTDJRv6IgacC37T/qBbSpH+C1zNgI6je
	 oo34Z0NdB9oMLgQiuiGl1X9B6ViFeBi0GC8MWPm5cc4Vvqn0XKDpdSooa6afkL/GB
	 vzSthx/eftIGyE077kKOwpgOSHjqhOliyktIqS3ifCchDng4L5sefuQs5+DVQIWJ+
	 x8SDy3X0PfRbWdK9eBtr1FEoVu+8jNg4dtnR/C+fbKOJJFqqTM7ruxcc4+RDesdNb
	 y/dPFjY7ftCXwIK7LQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7i8Y-1v1FJs15Wc-012rEn; Mon, 12
 May 2025 10:00:06 +0200
Message-ID: <745691a5-ea85-46e2-b1a4-f1c01f8e5632@gmx.com>
Date: Mon, 12 May 2025 17:30:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: return real error from __filemap_get_folio() calls
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <bd0068a988e80be345b7a513df5448ee9da4a0d7.1747035899.git.fdmanana@suse.com>
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
In-Reply-To: <bd0068a988e80be345b7a513df5448ee9da4a0d7.1747035899.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXCsUDSdA5fFIxX/d/o1IzwcjKlTUTlJz6G8YNvDBbuXlwP+2Wd
 aoNIhr+pmsx+EeJw6p9eEWnIZWsoRbsD8E6HVtRno1PSK08GfxWvczCjCS77hY1Q+eURJsy
 HJeORD5uwBrfYkpsqNsFjcsgi0uI08Pdxzs2XzAjYbn1CtwjpT1O9u0YLGvhqbMGMc4XxYC
 aEkfYzdVqM5cSPHZ9iFuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iOZa4mK42OA=;c3hrsOU40MOSmi+FISVMz4A7IDX
 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



=E5=9C=A8 2025/5/12 17:17, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have a few places that always assume a -ENOMEM error happened in case=
 a
> call to __filemap_get_folio() returns an error, which is just too much o=
f
> an assumption and even if it would be the case at some point in time, it=
's
> not future proof and there's nothing in the documentation that guarantee=
s
> that only ERR_PTR(-ENOMEM) can be returned with the flags we are passing
> to it.
>=20
> So use the exact error returned by __filemap_get_folio() instead.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/free-space-cache.c | 2 +-
>   fs/btrfs/inode.c            | 2 +-
>   fs/btrfs/reflink.c          | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 18496ebdee9d..4b34ea1f01c2 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -457,7 +457,7 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl =
*io_ctl, bool uptodate)
>   					    mask);
>   		if (IS_ERR(folio)) {
>   			io_ctl_drop_pages(io_ctl);
> -			return -ENOMEM;
> +			return PTR_ERR(folio);
>   		}
>  =20
>   		ret =3D set_folio_extent_mapped(folio);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8c1f7196636a..0420be88063a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4938,7 +4938,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode=
, u64 offset, u64 start, u64 e
>   			btrfs_delalloc_release_space(inode, data_reserved,
>   						     block_start, blocksize, true);
>   		btrfs_delalloc_release_extents(inode, blocksize);
> -		ret =3D -ENOMEM;
> +		ret =3D PTR_ERR(folio);
>   		goto out;
>   	}
>  =20
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 42c268dba11d..62161beca559 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -87,7 +87,7 @@ static int copy_inline_to_page(struct btrfs_inode *ino=
de,
>   					FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
>   					btrfs_alloc_write_mask(mapping));
>   	if (IS_ERR(folio)) {
> -		ret =3D -ENOMEM;
> +		ret =3D PTR_ERR(folio);
>   		goto out_unlock;
>   	}
>  =20


