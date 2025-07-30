Return-Path: <linux-btrfs+bounces-15774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF76B16948
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 01:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7945A24A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 23:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AA231837;
	Wed, 30 Jul 2025 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DfWgJA35"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C417BD9
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918074; cv=none; b=araiTs4fy4s/mQ0FotTtxLrKTqniuu3L1xybcsfUA+I3qjdu+4Qf9CBZTMIS5QV5ATPCYsWTQXyRjXICcskghF2KIiWNag0M6mkZpoV6ljXRz4OHhMSHSOn/2OXdOWUv6Fqcosg3QjAQMXcFW+pVrCvZKMsUGfYK5BwbPOISe+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918074; c=relaxed/simple;
	bh=Jz5edXzBaWB8J1QnYO5JXeKKKCUH8xwHcTGB7CUY5dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sjewzb5F9ewGiFlyilfeuOfwFXaXl+O8ZU0eR/nqZv2O3snX6ohyHHmfDl8fR3UrYaenAgirxfM+N+hRH56a49h376ILVhcKxqFdGOLPeFLpueGVwXMueaa5D7SrWmSxEJE8cWuWYPNq3/TUMYp4JXL+I/V+ZFKbcAWV2BQbT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DfWgJA35; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753918068; x=1754522868; i=quwenruo.btrfs@gmx.com;
	bh=iqEDZWl5QKSVoNymmeXKOLnRE1Y9ct4Bq12vsaYHlJw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DfWgJA35xVNBmF1lmXHCXONEz7bJn//pWncImDnGqSg/f+ZRIh5zh27GKcAT+/7y
	 HqoZ0GoJ6oXjhP6a4fzuaSQw25DkwRGimU8P9n1nTESiI47nO00aerikTjAtecdpV
	 b3mwht7unGfTJ5ZafiPN37Hqa+DysntEyYkNaBpYAqmcPq/0n7OAw/zNQw/jLvpJA
	 nQdDTe3FYA+8s+HFOrxifJDexWwYCOLoq0akFzCBj3ZLF5x0UhTCxsxPEJCTFnNV4
	 gpgApWMtYIs4dAdMmmh5QqkaOx+rO0XXpWqMxE3QRcJ4es0zoEgmSmN1txh8U3zH6
	 87nGwvKecTnAi7REhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNp7-1uFrXa3Gxx-00mVD5; Thu, 31
 Jul 2025 01:27:48 +0200
Message-ID: <d06dd073-bc7b-4643-8c4c-7b7eff5ab70f@gmx.com>
Date: Thu, 31 Jul 2025 08:57:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: Fixing invalid device size output when
 "btrfs device usage /" is called as normal user
To: Zoltan Racz <racz.zoli@gmail.com>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <20250730222629.25902-1-racz.zoli@gmail.com>
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
In-Reply-To: <20250730222629.25902-1-racz.zoli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AcHxaoMfYLsdLv6Nn9YtMKFhOzUQD8CHP2nVyQYi4FWKfTLGsRH
 nCgrJjoAKZzXGL6+SXmXyVyCtzMjkMYmHLznF1PLgvj4n8ZMsM37esieYPbLtGHXDg43ej3
 OWCadEI9xk/GLJzUW1akMcvOQ7wCrSGOgRjA9W1+KWvtVg7q87wpTh4n+2WIQtQk2XZGXHL
 gt960gF+qRaeGRdU916lQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CsW7RnHqjFw=;eYuDym0uQd9BvfykeskMwHOs0JF
 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



=E5=9C=A8 2025/7/31 07:56, Zoltan Racz =E5=86=99=E9=81=93:
> This patch fixes bug #979 - "wrong and misleading" device usage output a=
s normal user

This can be replaced by "Issue: #979" tag.

And github will automatically handle the reference.

>=20
> When "btrfs device usage /" is being called as a normal user,
> the function device_get_partition_size in device-utils.c calls
> device_get_partition_size_sysfs() as a fallback, which reads
> the size of the partition from "/sys/class/block/[partition]/size".
>=20
> The problem here is that the size read is not actually the size of
> the partition but rather a number of how many 512B (or whatever the
> devices sector size is) sectors the partition contains.
>=20
> Ex: if read value is 104857600 the size is not 100MB but 104857600 *
> 512B =3D 50GB
>=20
> This patch adds a function named get_partition_sector_size_sysfs which
> based on the partition name returns the sector size of the device, and
> replaces "return size" with "return size * sector_size" in
> device_get_partition_size_sysfs.
>=20
>=20
> ---
>   common/device-utils.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 783d7955..68aaa538 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -342,6 +342,42 @@ u64 device_get_partition_size_fd(int fd)
>   	return result;
>   }
>  =20
> +static u64 get_partition_sector_size_sysfs(const char *name)
> +{
> +	int ret =3D 0;
> +	char real_path[PATH_MAX] =3D {};
> +	char link_path[PATH_MAX] =3D {};
> +	char *dev_name =3D NULL;
> +	int sysfd;
> +	char sysfs[PATH_MAX] =3D {};
> +	char sizebuf[128];
> +
> +	snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
> +
> +	if (!realpath(link_path, real_path))
> +		return 0;
> +
> +	dev_name =3D basename(real_path);
> +
> +	if (!dev_name)
> +		return 0;

No error handling.

> +
> +	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", =
dev_name);
> +=09
> +	sysfd =3D open(sysfs, O_RDONLY);
> +	if (sysfd < 0)
> +		return 0;

The same missing error handling.

> +
> +	ret =3D sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
> +	close(sysfd);
> +
> +	if (ret < 0)
> +		return 0;
> +
> +	return atoi(sizebuf);

Again returning 0 on error.

> +}
> +
> +
>   static u64 device_get_partition_size_sysfs(const char *dev)
>   {
>   	int ret;
> @@ -351,6 +387,7 @@ static u64 device_get_partition_size_sysfs(const cha=
r *dev)
>   	const char *name =3D NULL;
>   	int sysfd;
>   	unsigned long long size =3D 0;
> +	unsigned long long sector_size =3D 0;
>  =20
>   	name =3D realpath(dev, path);
>   	if (!name)
> @@ -375,7 +412,10 @@ static u64 device_get_partition_size_sysfs(const ch=
ar *dev)
>   		return 0;
>   	}
>   	close(sysfd);
> -	return size;
> +
> +	sector_size =3D get_partition_sector_size_sysfs(name);

So when on error, sector_size is 0 and device_get_partition_size() just=20
return 0, causing even more confusing result.

I'd prefer get_parition_sector_size_sysfs() to return minus number for=20
error, and output a warning when we failed to get the correct value.

Thanks,
Qu

> +
> +	return size * sector_size;
>   }
>  =20
>   u64 device_get_partition_size(const char *dev)


