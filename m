Return-Path: <linux-btrfs+bounces-15786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A77B1792E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 00:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C99580006
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494FA27E1C6;
	Thu, 31 Jul 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="W+faYGbr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981B26772D
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001993; cv=none; b=rV/IzVyYmfgIcTya/8i3ndE3I4ve4z7EMqL/JDQkIgRrylI0ZoSJWs0QhyDKClQhR430yJEnC22nyOzQaokvXjFPbUZRfDn8ha0YMwNC65u6zx4r0SDZQPltP4j82EKCgTeED6gECglTQyt6F+wvgBRg50zqEX4QRmjAs0209yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001993; c=relaxed/simple;
	bh=DFZYANW1VlzFDAZTIoWBGHA28F0I6nUa3QRS7CK/8kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD0NS2K4vkFkZnAaEGs9y00edB5/+RaU+7gBHxpl4xoQgYg2M0WRC7ZoCw5y2b9SQWY/0cbpl1Q83J8IQF5tGrK2tgKJicPYXjK7pV5I5kewEYaS8Dc/l847O/XeoP6H6NeNrmmEbtBOPgZVQZ5ivE+pFJ1GgGu/zjkeEOv2oqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=W+faYGbr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754001987; x=1754606787; i=quwenruo.btrfs@gmx.com;
	bh=UhnYmEA1eur5g6i2HwrUa+9Sd5HSq836whcZYOX4GYs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W+faYGbrW95oJXOlRoucq7Z4e0ZR6xtdg1yFfZ7hHCiB9g4CDWOa6+BNHSQr6xFP
	 Z7alIZBk4p7n71vDIfjTCS8AgIISpMEg2kWzSVxJKRHr+7JxILDtNy/VHM1N5svvE
	 x722L7wB47Y8ai9ruWdu0tCJ+bC1NH5KKpzvbfCgNPixPf7dMVESWmVSLhS/OMA0W
	 RFjZpwm55toAdi24zspp66PT5bT4xT9LKiQg0QutZbRjvaBPlgh5vzz6mTkUARHeD
	 Z2S2qyiON1SY4qxIohQyqhSQOEYpkMaQo9TK9GMuUvQhTN4/45kI/L10uufLayfd2
	 DakRBup8+PEmBzJ+6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1v13m72yYz-00K2f3; Fri, 01
 Aug 2025 00:46:27 +0200
Message-ID: <bcccde38-d20b-4af9-8465-d0bb0ec47c81@gmx.com>
Date: Fri, 1 Aug 2025 08:16:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: Fixing invalid device size output when
 "btrfs device usage /" called as normal user
To: Zoltan Racz <racz.zoli@gmail.com>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <20250731125307.11939-1-racz.zoli@gmail.com>
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
In-Reply-To: <20250731125307.11939-1-racz.zoli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aMcWpPYKassqGQ87NyRr69Ih+xvK+74xR3PORjvP6jMSfd4PWc3
 1c2gsSOyV99HA/DUHVZhy8azw6Ob/pSfpxTF0Mo2Lekf8gZ0Y/TDqqHMROzXdtOYsMB5jTL
 0Mtr1nZGLVBW6LGZ2ssRfMs5OPUp5r6KakBWO/khVcEYNpFfg5J3LMXlK71MQgphAOe3oVK
 CfFL/nqgXW9vENdjvAvQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:odoVGAgTcP4=;9FUGl2bKuzpVkQX5Xvvzk27vVpT
 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
 PPnpemGvdtkeNo=



=E5=9C=A8 2025/7/31 22:23, Zoltan Racz =E5=86=99=E9=81=93:
> Issue: #979
>=20
> Changes since v1:
>   - Added Issue: #979 tag instead of bug description
>   - Added error handling to get_partition_sector_size_sysfs()
>   - Changed return value of get_partition_sector_size_sysfs() to negativ=
e
>     on failure

Please put change log behind "---" line so it can be dropped by git-am.


Furthermore, the "Issue:" tag should be put at the end of the commit=20
message, normally before an SoB line.

Although SoB is not mandatory for one-time contribution, but if you want=
=20
to keep contributing, an SoB will still be preferred.

You can follow the following example on how to put involved tags and=20
changelogs into a single patch:

https://lore.kernel.org/linux-btrfs/aa5a3d849cb093a767e08616258c03c7eec8fe=
26.1753806780.git.boris@bur.io/



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

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

You don't need to resend the patch, I'll do the modification during merge.

Thanks,
Qu

>=20
> ---
>   common/device-utils.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 783d7955..9b02a0e8 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -342,6 +342,50 @@ u64 device_get_partition_size_fd(int fd)
>   	return result;
>   }
>  =20
> +static ssize_t get_partition_sector_size_sysfs(const char *name)
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
> +	if (!realpath(link_path, real_path)) {
> +		error("Failed to resolve realpath of %s: %s\n", link_path, strerror(e=
rrno));
> +		return -1;
> +	}
> +
> +	dev_name =3D basename(real_path);
> +
> +	if (!dev_name) {
> +		error("Failed to determine basename for path %s\n", real_path);
> +		return -1;
> +	}
> +
> +	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", =
dev_name);
> +=09
> +	sysfd =3D open(sysfs, O_RDONLY);
> +	if (sysfd < 0) {
> +		error("Error opening %s to determine dev sector size: %s\n", real_pat=
h, strerror(errno));
> +		return -1;
> +	}
> +
> +	ret =3D sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
> +	close(sysfd);
> +
> +	if (ret < 0) {
> +		error("Error reading hw_sector_size from sysfs for device %s!\n", dev=
_name);
> +		return -1;
> +	}
> +
> +	return atoi(sizebuf);
> +}
> +
> +
>   static u64 device_get_partition_size_sysfs(const char *dev)
>   {
>   	int ret;
> @@ -351,6 +395,7 @@ static u64 device_get_partition_size_sysfs(const cha=
r *dev)
>   	const char *name =3D NULL;
>   	int sysfd;
>   	unsigned long long size =3D 0;
> +	ssize_t sector_size =3D 0;
>  =20
>   	name =3D realpath(dev, path);
>   	if (!name)
> @@ -375,7 +420,13 @@ static u64 device_get_partition_size_sysfs(const ch=
ar *dev)
>   		return 0;
>   	}
>   	close(sysfd);
> -	return size;
> +
> +	sector_size =3D get_partition_sector_size_sysfs(name);
> +
> +	if (sector_size < 0)
> +		return 0;
> +
> +	return size * sector_size;
>   }
>  =20
>   u64 device_get_partition_size(const char *dev)


