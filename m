Return-Path: <linux-btrfs+bounces-9356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EF9BDDEB
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 05:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E01C22505
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 04:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F66190493;
	Wed,  6 Nov 2024 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="keHYHDbu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89443211
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730867011; cv=none; b=bZdl8vjM1Ux0ChEZRzFjH5XhlEGvJZzvdCrz9g1WIkUY2DZaB2x4OhALZ9SWXIlzLohJnZ2fAN0ueWDRTwhn7WdEgW0lOjIThlrct5VEa95BHYP+1Ow8W028Tm7Oh6h9/tufUEy2Ely6iKjWIxuYeqJfb8TowJJ4I8a4uyQRshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730867011; c=relaxed/simple;
	bh=Jry4Vp1Xc9wkg6BS+84uNHEUNN7AAMuwG4E9FuR//0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QymqVOEPCvRXSfpGGQ7VBzYqbjFKsoBV9a6Eqg22KEcW2rA7s2j5jwC8EAYhz6zJgka32MPCHJnOpxjA6ECgkaj/G6pHZ9W70sU43P6PcjGlCWtCCvf2QkoFHKKJKm9u6+KIQ5rocFM2m7TFX44giXoS4dxq12exfb+mwzfoQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=keHYHDbu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730866999; x=1731471799; i=quwenruo.btrfs@gmx.com;
	bh=8wSnnxJsFdfZn32ul//unmWKV4Zv/eDK7tv/M4m88eE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=keHYHDbubKwfVEExdyVae3aQFNLltFJ6exxIt9iIDHxZTBFfrwAK6eoVqVo21hHf
	 K5Yw/m+6DZ5UB8e0X3FYPoOoPvq0cgqDfyaIAaY56QbyJHmxOZha88jBrS1dxRqbA
	 aVKakSmhkBFk76/E+hCkwO90ncFS88tYDFJB3yj9EUCRxVi1nUf9m+X91ShHj3WN1
	 bzt2OwNxu75mPJOQZfaYr3Xk616sZqeDxaejMmjw07AZcUYpKs6KSvYZA/FeZvTmm
	 PQRdzXPnfYGtbm5REYCB5nxhakepl2jKYmyOdZSZDw2pSD7KBZCPHVJleL98JE28W
	 M3KizYd5xdxA+Dv65A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1tdBTz19N2-00eZ53; Wed, 06
 Nov 2024 05:23:19 +0100
Message-ID: <864430d3-65d7-48c5-8f59-30869ff565f3@gmx.com>
Date: Wed, 6 Nov 2024 14:53:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on
 'load'
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
 Tom Rini <trini@konsulko.com>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
References: <20241106012918.1395878-1-dominique.martinet@atmark-techno.com>
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
In-Reply-To: <20241106012918.1395878-1-dominique.martinet@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j1sjjEgfLwoRLEoBSDWWmf/M4DVwrhH9KQVsvE150wfnFaU0eM8
 8TgUgwqhoz4eH/7pRjTawC6ywBwVHvkMxMCmPAnT2dkKwpNui3yI7/LW5bTR3taFuxSo9uJ
 v+21ISWOxP2H0B+QDTahCAzecjBAKk79TEFxX4UZoVt4DTlOqgSy1z30S2R9RAWagwQrLRQ
 dBW3cKTk4wecwt3lqHspw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5+7NKCrtaek=;GImmB3UlW/N8+OnxDEmcPgObUA8
 2mgoSnGYO3RIYgYRGu8vQ3KNSqRiNQquIDhTeQ5j9tpd1r7L3nBHVG5WqgX89+/a4dTBCCXth
 lCamWeDlAtV6ozzJrUCr6yzUtP8KXLry5LaLhvPC+7XElZ3cUalc1CuH/PpLCxsjId3abaMqZ
 RHv57LdI3/Pmu4vI9xoZbLq8NUQ8M27Y+eIY1fpMVQz82lFxVBdfFlzSmcK+jzP7RKhLUxiSt
 7NlLjAJ+DdPMZqfHMypOlRuJOrv07Mb4dN/4xiaGCJzqBxulGy8sC40CwuW/R2Hf6BBNvJLc0
 /TTyoQdR2mr+U588OqHcQd5f9NFcr6rbuvdonr+84I0gIlTriz5o/7/Y7PbOLIjVDj7+ZUwRA
 2DZjzk56NZJD4d6eV/7WB9oFg26SbQUuTgGHGh1Z+Msu2Au7g/7vZUVu27jbZYNOnmgCKwiSd
 ueEdh64Sl6tEUzag3Gbby0TusN+E3kLx0tLrvt/0j+rJ5BOVxIH8CtZHouiWacLywOcwLnyJC
 UJvLXEgGxoK40gbBgBfUmTlLTN+32HO2d09hURJ2JUhJ22elDQ8CYtZTBV3ZQQW0UCysz6JcU
 F6He7b+w1yjCP67y5YsYnLqq7B+qwrK473qF+SD8i5l6kLUqjGpc/Fsvlhv1vPKknxL1HI4AS
 csE3REbpnYMtF/qfg8JYVaaOQZUdeq6i4zxxLIoioYDTCCUk7fhg9McmChZ6aoEvazsdCWqHB
 X1G+KK0MO1bUZjirLeBsjEi5TSQHC7mXBOzdZafBpsFSJ0f/pSv00g1d4qtAO9eQ8ZWVZSTcl
 HGnTI0Dp9bItxSpLoLRrTwjQ==



=E5=9C=A8 2024/11/6 11:59, Dominique Martinet =E5=86=99=E9=81=93:
> Running commands such as 'load mmc 2:1 $addr $path' when path does not
> exists historically do not print any error on filesystems such as ext4
> or fat.
> Changing the root filesystem to btrfs would make existing boot script
> print 'Cannot lookup file xxx' errors, confusing customers wondering if
> there is a problem when the mmc load command was used in a if (for
> example to load boot.scr conditionally)
>
> Make that printf a debug message so it is not displayed by default, like
> it is on other filesystems
>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Since other fses are already not output that error message, we have no
extra reason not to follow them.

Thanks for the fix,
Qu

> ---
> iirc this also used to trip up some test in test/fs but I don't recall
> what.
>
> It might make sense to print that error but I think we ought to be
> coherent and either print it for all fs or none; but if we print it
> we'll need to prepare a new command to test file existence before
> loading it.
>
> Thanks!
>
>   fs/btrfs/btrfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> index 350cff0cbca0..f3087f690fa4 100644
> --- a/fs/btrfs/btrfs.c
> +++ b/fs/btrfs/btrfs.c
> @@ -193,7 +193,7 @@ int btrfs_size(const char *file, loff_t *size)
>   	ret =3D btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID=
,
>   				file, &root, &ino, &type, 40);
>   	if (ret < 0) {
> -		printf("Cannot lookup file %s\n", file);
> +		debug("Cannot lookup file %s\n", file);
>   		return ret;
>   	}
>   	if (type !=3D BTRFS_FT_REG_FILE) {


