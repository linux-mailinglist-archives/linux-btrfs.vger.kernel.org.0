Return-Path: <linux-btrfs+bounces-13879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE658AB324B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520F216C2CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDD325A2B2;
	Mon, 12 May 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GBJ7asAi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4B433CB
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040061; cv=none; b=fKGEMzsDJoA6EgU1eU2MO+rGbTArWJY4kSmyPmdz5QkrvsqXHx4QktWgIc2+moyUMT1eINWIi/UigyqCQgNM4zpGlkGKzZe+P8RarnaJds7fdKowkJLhHcLqoPGh3TR3TRfs5iMUv8w4wnGP+53swwlaaWEuKAhRQJU0VhjeAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040061; c=relaxed/simple;
	bh=93D+a2inyAmyRdXWBTY6spFOeqgWLkxd+EvfkdXMNSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pf34T22Y3vXaTR8DxCS3gf0bGTc7zj6+AoyyIMfyFvv9MTnb/yM/LXSdjMxc9O4PBWXyoEhh0xlhZq9cwbDD7XuHC8Bk4s6h2JiwLu74rQl09oBmVgYM5Oiwfx8SdeYxKYYBUaeSdtzwjmJLQkvBtZJxGJIzT3EvKPE+4W6mWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GBJ7asAi; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747040053; x=1747644853; i=quwenruo.btrfs@gmx.com;
	bh=rwdFEjuk3fALuxShPjjufxHmSm1pfwl12LrtU3ptLZs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GBJ7asAih56pM1rlM/GtT3rTCROaxsIap63zyxJA86YljEA51j8h3qNx1PlImPx1
	 RwpPBCHucm5HPqgHmNPhtR+ZNIo4kzNIj8A0utk41iM8xNVt5nMYwRJ36DWsrxaxK
	 Vh/gTYZSHINwN353xtlXcyw686On7a5Tr+t+ueDpSzgV87895ZFs6OBSwejjsITTW
	 urfqhIT9r+NWA1QGWt4LLLDypLwxyOQrDlHqJ5HSVbZ2p71xZBZWDF6BnwgPJFvyJ
	 VH3R8JAL/8yM+emZahxytQTOkSMYD+Co4x/wU7KvWbFwkYH2aXybejGNcdu01Pecz
	 zFz5/gLA54e2TSY7rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1uWLBP2VBj-00Tc4D; Mon, 12
 May 2025 10:54:13 +0200
Message-ID: <7cbc5e90-9c05-45c1-a554-079c09e141c3@gmx.com>
Date: Mon, 12 May 2025 18:24:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify error return logic when getting folio at
 prepare_one_folio()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <0ef572363b52c57d95cc1a8912430187f868a7d5.1747035909.git.fdmanana@suse.com>
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
In-Reply-To: <0ef572363b52c57d95cc1a8912430187f868a7d5.1747035909.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VOFRgRX3p6mSNnjKFDdxMzR0mik/IZF9aAzFxsxbxl+XRnKVFbT
 mLStWLcEbrisuRlqoP8gNpWGaDIgkdWEYKA+EsA9ZtpafWpDpu2HR+B0lMcuTN9cV9OyY5y
 R95flJEyCg/mkeLk6XsbbstrcM2nkAcVySjxqnTfjlXxFU6kzM0OKT3B4gZflbe6RwEbMaf
 7rN+KBNbjLhC1xt3Uc+Ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t3cirBhGvZY=;vnLfRvg0IKpBddv0HzCAgtMQEqR
 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
 rLyyKFTsGFeh0=



=E5=9C=A8 2025/5/12 17:18, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> There's no need to have special logic to return -EAGAIN in case the call
> to __filemap_get_folio() fails, because when FGP_NOWAIT is passed to
> __filemap_get_folio() it returns ERR_PTR(-EAGAIN) if it needs to do
> something that would imply blocking.
>=20
> The reason we have this logic is from the days before we migrated to the
> folio interface, when we called pagecache_get_page() which would return
> NULL instead of an error pointer.
>=20
> So remove this special casing and always return the error that the call
> to __filemap_get_folio() returned.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index c9a3e75befb9..8d6a4a835bfa 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -866,13 +866,9 @@ static noinline int prepare_one_folio(struct inode =
*inode, struct folio **folio_
>  =20
>   again:
>   	folio =3D __filemap_get_folio(inode->i_mapping, index, fgp_flags, mas=
k);
> -	if (IS_ERR(folio)) {
> -		if (nowait)
> -			ret =3D -EAGAIN;
> -		else
> -			ret =3D PTR_ERR(folio);
> -		return ret;
> -	}
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
> +
>   	ret =3D set_folio_extent_mapped(folio);
>   	if (ret < 0) {
>   		folio_unlock(folio);


