Return-Path: <linux-btrfs+bounces-18008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B0BEE191
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 11:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1B534E62E9
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F62E03E8;
	Sun, 19 Oct 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A3RfW2Rw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03925126C17;
	Sun, 19 Oct 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760865179; cv=none; b=qn3GbW8SEaa1C4JnuFBA+JyNuG/0632xMey+Rz8U43EhcCf5EidKoVGke72xM8u7JChNhCCHeu8XkdBfQF8xFgqzDgK5Eu5PWdmWHrLacLv5Bkm1eFu3ez9JB/MAOROB/S0tVoGm+dbeYXdTrKp2VH1gckvCrs5NymiO3ASZqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760865179; c=relaxed/simple;
	bh=iWOig4kQf4kFb3TIgEFkR+kYFpVNh6IkDXuVegFDu+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1uRgU3v0ORT/eG75OKOWXAgimCoZ6FSqT9ft9MnzHfTnjtZYY0UUqlRwL9/UFoRmKNUrR42xXM4/DQjMoRV0aGWmWz3Lqx1VoxJVC0ConYxNP5bb/tS9w4ciX7vs6UxdSFJqfB+8ZqVaDB/kCc9T1D5dotYNzG+PlQX3emg9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=A3RfW2Rw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760865167; x=1761469967; i=quwenruo.btrfs@gmx.com;
	bh=GLpCzEK3VAHXP99FoKwHy4oEZ+27F/EgdYjsk/uj3as=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A3RfW2Rwdg6G+s8gpEJSflnmbpP1TdDTjwXTsQSD4h9cMSXWofJ0lDDyz3JxG39p
	 eV50UKjWVBfgRNe71rncmbi6yTiJxs3LjaoqQQ/SPLN9zXU5osPfqIVAy1Va5M6R6
	 p7JQkCGKJHe5mwDmPAbrob5cctBH8VFwg0Z2Iz2B9ao6Bc1HAsXWA9C/kc9i/4/kR
	 ppjPmw9uJzHGEFFVUvm0YUWK02K4c9SciSiX3zLXR4WhDt00WmYiyu+so9czGHBy0
	 L5/tFbxkrqjdxNQ5a6YxG3SIv94RLklLveQAIFMaGh4Ss7Y+6doE0uiOppdYBieHj
	 c654PDfvY0o9yO8yAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1uNJHc3gD0-00bimj; Sun, 19
 Oct 2025 11:12:47 +0200
Message-ID: <97fc4d4c-2142-45f3-b1a9-4b4f3bd3d21c@gmx.com>
Date: Sun, 19 Oct 2025 19:42:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: initialize folios to NULL in compress_file_range()
To: Kriish Sharma <kriish.sharma2006@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 kernel test robot <lkp@intel.com>
References: <20251019083647.2096733-1-kriish.sharma2006@gmail.com>
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
In-Reply-To: <20251019083647.2096733-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yAzRKbn2OjlFv8bQwSPNEns7jPUXps9iRwsfwjFyqL6pcxL9Vse
 I7zJ5cEF6QjZ7Q461/nsIPX785pmFGU4Ro7k2rgMxZxs78FNoWpzg37A0FTGfPIxm0uKdTg
 /SJz0ePn17UbGoURFSqw2McY1Q9ION8A41bIwOmcX3+IZ/ydZGjlKW98EfdA44z5FNrSSJq
 fbq2KwyKdfsumSD+lCW6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GcN28E0sl0E=;QeVSlq1b5f0x0P+x/3te+MF9q1T
 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
 3kSvw==



=E5=9C=A8 2025/10/19 19:06, Kriish Sharma =E5=86=99=E9=81=93:
> The variable 'folios' may be used uninitialized when jumping to cleanup
> labels, triggering the following clang warning:
>=20
>    fs/btrfs/inode.c:874:6: warning: variable 'folios' is used uninitiali=
zed
>    whenever 'if' condition is true
>=20
> Initialize 'folios' to NULL to ensure the cleanup path is safe and to
> silence the compiler warning.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510171743.VQ6yA0Uu-lkp@=
intel.com/
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Before the LKP report it's already fixed in the for-next branch.

> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d726bcdacf6b..54903e17338f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -862,7 +862,7 @@ static void compress_file_range(struct btrfs_work *w=
ork)
>   	u64 actual_end;
>   	u64 i_size;
>   	int ret =3D 0;
> -	struct folio **folios;
> +	struct folio **folios =3D NULL;
>   	unsigned long nr_folios;
>   	unsigned long total_compressed =3D 0;
>   	unsigned long total_in =3D 0;


