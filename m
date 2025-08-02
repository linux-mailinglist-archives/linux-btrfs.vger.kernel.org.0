Return-Path: <linux-btrfs+bounces-15797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E2B18AAF
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 06:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FED567DAC
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D9189F43;
	Sat,  2 Aug 2025 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RmaEsKbA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E02E36EB
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754108379; cv=none; b=beaD1ZHITf0EFAfauqF+h5u/ZRq5VhnPzK4DhnxoC3uuqKr8zCZu4zE7wJkn23H+Hced7Rjm/iQ5s6eUf7aR4jgfd4Bo+YJxtVF3JkK3IIFOME6icnaBqVhwfO9A59cy6Dvcmq6gbF/imiS5Rhb4RrJisD+lDRGKmmw2UPH7De4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754108379; c=relaxed/simple;
	bh=oKfDWpEdHTE1bNlSpdYWpJS8aW6wfUCnDwQSSmNcPes=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uFPnlx+Rxp0XDBJys59sBnWlNI+PDqnBZ6NelBMF58GuKoWlBpmthk9+rEDNW/Km15jk6tzZEPm/rl8PjbQ5R5SFcX8H6E4Seu1xFYPFektZo1R0uIU+vwUJUEnqv6M7f7omjptV9K6aqha3B8Xd37mHgXMH0BTqDU0HLEt1WUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RmaEsKbA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754108374; x=1754713174; i=quwenruo.btrfs@gmx.com;
	bh=MgKncKZisSgFUI9VASh0A6Y8zJIt1MRt0x8qcDM7BxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RmaEsKbAqOfAn7nvuleNaShNn7GfLMbmYMMLh8N4pMzkkN4IUD4lnzo9ZgJYuEXZ
	 vhEoEkHpINheqUjs2B5gaG6McRrW8uq8BfmleU+/qg6JgMo0XIbb6Dc3hK2SSFVGQ
	 K1qy0iN3qvBb/atu+3iEcnwTCPGA9EHx3fwityb3h8I5Jbgr0Cf4QBfwVQsnFc1MO
	 EEi7hQ4DgY2RRSg3EOusDFynB/XUEwRI0YT3VOevr9wjJH4FfPHh2TerAHmtCUMck
	 66VdMZL/1oHNCAySMNMgO5GduTmMojBlN9JVxcVJvfhCmZdJV4fpJB8gA/kBq1e4U
	 v/Jfz6GQg8OzrYt7sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1uVf4q3zrx-0142M1; Sat, 02
 Aug 2025 06:19:34 +0200
Message-ID: <3a8f23bf-e1cf-4803-a290-8d77b0d5dadd@gmx.com>
Date: Sat, 2 Aug 2025 13:49:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: Fix get_partition_sector_size_sysfs() to
 handle loopback and device mapper devices
To: Zoltan Racz <racz.zoli@gmail.com>, linux-btrfs@vger.kernel.org
References: <20250801110318.37249-1-racz.zoli@gmail.com>
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
In-Reply-To: <20250801110318.37249-1-racz.zoli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R1M1MEmq1t4r/1YxN6rUGstXUhLCU6N1tP4t5egIrCIbwjQaYul
 XVvXvkYkocPg+BSUc6W9pq1kNhkVvhHbL3FQZ6cfIbRFHHRpJ5QbnKjuoxMVyffHlAnbq5A
 nD2XqKLoFgKrnC09+TY15PJd9eiKiaAoDg16+WT+NzAVWWJ1WUFpSgp321ZBwe1joxROOvd
 xU8Acczxgy0coU+1pwwBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NMivD7vXaQE=;W6F6BFQlxtydW7+JfEB/zJ/4AcF
 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



=E5=9C=A8 2025/8/1 20:33, Zoltan Racz =E5=86=99=E9=81=93:
> Commit e39ed66 added get_partition_sector_size_sysfs() used by "btrfs de=
vice usage"
> which returns the sector size of a partition (or its parent). After more=
 testing
> it turned out it couldn`t handle loopback or mapper devices. This patch =
adds a fix
> for them.

I can fold this change into the original patch if needed.

Although during my test, even unprivileged users can still do regular=20
ioctl based size detection, as long as the user have read permission to=20
that device.

And if the user can not even read the device, I'd say the environment is=
=20
set up to intentionally prevent user accesses to that block device.

So I'm not convinced about all the fallback method, especially we're=20
doing a lot of special handling (partition vs raw devices).

Mind to also provide the test setup you're using and the involved block=20
device mode?

>=20
> Signed-off-by: Zoltan Racz <racz.zoli@gmail.com>
> ---
>   common/device-utils.c | 48 +++++++++++++++++++++++++++++--------------
>   1 file changed, 33 insertions(+), 15 deletions(-)
>=20
> diff --git a/common/device-utils.c b/common/device-utils.c
> index dd781bc5..a75194bf 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -353,26 +353,44 @@ static ssize_t get_partition_sector_size_sysfs(con=
st char *name)
>   	char sysfs[PATH_MAX] =3D {};
>   	char sizebuf[128];
>  =20
> -	snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
> +	/*
> +	 * First we look for hw_sector_size directly directly under
> +	 * /sys/class/block/[partition_name]/queue. In case of loopback and
> +	 * device mapper devices there is no parent device (like /dev/sda1 -> =
/dev/sda),
> +	 * and the partition`s sysfs folder itself contains informations regar=
ding
> +	 * the sector size
> +	 */
> +	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", =
name);
> +	sysfd =3D open(sysfs, O_RDONLY);
>  =20
> -	if (!realpath(link_path, real_path)) {
> -		error("Failed to resolve realpath of %s: %s\n", link_path, strerror(e=
rrno));
> -		return -1;
> -	}
> +	if (sysfd < 0) {

Just a small nitpic, it's better to check the errno against ENOENT.

But my question still stands, does it really make sense to use sysfs as=20
a fallback?

Thanks,
Qu

> +		/*
> +		 * If we couldn`t find it, it means our partition is created on a rea=
l
> +		 * device and we need to find its parent
> +		 */
> +		snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
>  =20
> -	dev_name =3D basename(real_path);
> +		if (!realpath(link_path, real_path)) {
> +			error("Failed to resolve realpath of %s: %s\n", link_path, strerror(=
errno));
> +			return -1;
> +		}
>  =20
> -	if (!dev_name) {
> -		error("Failed to determine basename for path %s\n", real_path);
> -		return -1;
> -	}
> +		dev_name =3D basename(real_path);
>  =20
> -	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", =
dev_name);
> +		if (!dev_name) {
> +			error("Failed to determine basename for path %s\n", real_path);
> +			return -1;
> +		}
>  =20
> -	sysfd =3D open(sysfs, O_RDONLY);
> -	if (sysfd < 0) {
> -		error("Error opening %s to determine dev sector size: %s\n", real_pat=
h, strerror(errno));
> -		return -1;
> +		memset(sysfs, 0, PATH_MAX);
> +		snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size",=
 dev_name);
> +
> +		sysfd =3D open(sysfs, O_RDONLY);
> +
> +		if (sysfd < 0) {
> +			error("Error opening %s to determine dev sector size: %s\n", real_pa=
th, strerror(errno));
> +			return -1;
> +		}
>   	}
>  =20
>   	ret =3D sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));


