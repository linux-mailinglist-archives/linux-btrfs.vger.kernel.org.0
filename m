Return-Path: <linux-btrfs+bounces-5196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F78CBB7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7781F229CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B479952;
	Wed, 22 May 2024 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Z5MpG/Gk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF601CD13
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360227; cv=none; b=URueW36FGhZyj3Wi4CsyGSuhlKnXkRoQcZ4781nKHdvqGlsz7Pu0WR1a6d4O+VKHL0dHmGdjzv36Z9P7/ib72hXy3auKGPj5mN4yFjVGebXtt8z11crb0/i5R8rnMt1nJ/k6PjnkR1G8Kc1g4UPz9hjWk0qc08WDmLuYV/LfEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360227; c=relaxed/simple;
	bh=4LE8SbsXiT7yrV+OiYdVdptLnNt7E3jL60Mu2dmp4j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E7v47gi8gyP0ifgmlvp5V2eB8delkz7cPqEf6Dk3yrtqRr9nrfmC7hJNtRcVyXe2SGtU8O/Y/tsrPrGzXY0i9hy2aqkf16Mpslhk+XWVF4azH9546T/mdZ30C+sHOLGI3jvmY3yVKgMJAWxRg3OPMAkTMwFZ0XmLb2sdxR90lAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Z5MpG/Gk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716360220; x=1716965020; i=quwenruo.btrfs@gmx.com;
	bh=qMKEG9sRmzNTxnYr2NW9HD9ITlkyIzT5baRaxN1U/Zs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z5MpG/GkpgJQgfv4Uwqjk24+KwLg0TYVzeXxEnnRmdlruWgc5754dE7cREP/Szlr
	 HGvraoyJhYt2ui4mg2OyUfLISfbQ8r4M1q/DRrFQm9nC9h05lC0eaegawPaYyfv+h
	 KdRw0F7CVGTL6kunEWnUe/OyQoZ+tYmNiNha+yyt2Gvg+UKA/InuI/plKxcgw7fS/
	 z7Qg7cafxsr3ZdTCcNka5m1/jBvFtzsKaDPr/h54PnFAtX1EmhBYZnmgMzdqeoiDO
	 Lnv9ijcjM2x0VWAwtmYKeGsIs1WSNbArDFVeuWMDge7XSgy1Po3vBlVUhVfIZTEzW
	 vc0GVal8dAiBsivs9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzFx-1rrrre3BD7-00L1W0; Wed, 22
 May 2024 08:43:40 +0200
Message-ID: <d959127a-d0f0-4444-a69a-0ffa1002d5f1@gmx.com>
Date: Wed, 22 May 2024 16:13:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
 <20240522060232.3569226-6-naohiro.aota@wdc.com>
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
In-Reply-To: <20240522060232.3569226-6-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3juCao8f4eqHRa7/TvvPdF7bKXX1CC0dMbGeEJazpKNUmRgbucq
 wWIEx3URzvi9hy+IuKKAI7E4WeyQmicxgMHQGXQiab0gLDi0e2NLPQGvKceFefH47Thccdj
 n6OAG2aGKuTxotHam4jEtCu4R2cWd+WA2R7PgIWVir8xtCj3iaQF93QflmnMLVeqmVEETe0
 FQrNPYzCxk5gXQOxdzljg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WaNBdUDCM5Y=;4h4ZlWTJoumQ3vDvKwExHF5Qn4g
 V6GKU/coxF1rSrjx78xj6Qa1p9Go7b2R3rNSiFSHX/khkAvXFZM1GgGa4MXZe5vP4EPOzJr8t
 qLdu1GSFi0Sk0OOW7WLmZWhSVnbWZpthCcnSBwa0WsF6AG50bk/hRL1B1DowBjZ4xT7GOib6S
 hUm/sR86XTeXhNVC2wI1XS88ogmUHIim3Nbipz8XyCFNfJnocEAcoXOrdCyUjbjSFDbVAYT4V
 c1HlcYfBy8MBNLWwLbXHxna/+/roZaLP4whBCpiX1xPfovVGkjSlT5fccnrzFLfl7Hj+aJ7R0
 iYKchfkVfQSJBDEJfysVmhR0mpwUq8SWF+TG1i/QbVYkddL8tMlqH9NqpJXghyTqC+NFU8vy3
 x0dG2qwdifJyLgYgtECEUbl8AxCCucknJo/igDNgTpH/fRsc0LbTPD92CmUMhw/A3cv9fPV0Q
 YV6cW6oZHwjgeMK2byF/74qgPipIeaKlT1ilyN1BHvWbZadEeGRAjMp9y+VphcNCqCE0geHHE
 itLNMB3spBo3c6t0gmNX7UcrKwMyAD3gkPFpI6tabPbxzaMgzzwUhRVRAwF3et9ZeUgx1QfgN
 pjZ/OdAAGAL64rdeP4lBji3sDT8WpZLxLHpMQfZziPucOyQ3u2EbvA+UTBmWcij+L6EJxuKLb
 WylSVqOSo5dTPfGXOyrFWBRXPL7qYj6V8MyqxgokMyd3tEeAEsSqys8PLP1UkyBZME5f7QS7r
 ByIU+EK7BpdpT8lSO/rMVV9rEf9luUyrL0ACueVkDlVacTKJS5WH4Fl42VJ4hnAji7zwq2SPz
 hZ+cV0nvWKEaT+YdxQpN8a3kfGen4HRk2+enr/l0zaU/Y=



=E5=9C=A8 2024/5/22 15:32, Naohiro Aota =E5=86=99=E9=81=93:
> While "byte_count" is eventually rounded down to sectorsize at make_btrf=
s()
> or btrfs_add_to_fs_id(), it would be better round it down first and do t=
he
> size checks not to confuse the things.
>
> Also, on a zoned device, creating a btrfs whose size is not aligned to t=
he
> zone boundary can be confusing. Round it down further to the zone bounda=
ry.
>
> The size calculation with a source directory is also tweaked to be align=
ed.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   mkfs/main.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index a437ecc40c7f..baf889873b41 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1591,6 +1591,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	min_dev_size =3D btrfs_min_dev_size(nodesize, mixed,
>   					  opt_zoned ? zone_size(file) : 0,
>   					  metadata_profile, data_profile);
> +	if (byte_count) {
> +		byte_count =3D round_down(byte_count, sectorsize);
> +		if (opt_zoned)
> +			byte_count =3D round_down(byte_count,  zone_size(file));
> +	}
> +
>   	/*
>   	 * Enlarge the destination file or create a new one, using the size
>   	 * calculated from source dir.
> @@ -1624,12 +1630,13 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		 * Or we will always use source_dir_size calculated for mkfs.
>   		 */
>   		if (!byte_count)
> -			byte_count =3D device_get_partition_size_fd_stat(fd, &statbuf);
> +			byte_count =3D round_up(device_get_partition_size_fd_stat(fd, &statb=
uf),
> +					      sectorsize);
>   		source_dir_size =3D btrfs_mkfs_size_dir(source_dir, sectorsize,
>   				min_dev_size, metadata_profile, data_profile);
>   		if (byte_count < source_dir_size) {
>   			if (S_ISREG(statbuf.st_mode)) {
> -				byte_count =3D source_dir_size;
> +				byte_count =3D round_up(source_dir_size, sectorsize);

I believe we should round up not round down, if we're using --rootdir
option.

As smaller size would only be more possible to hit ENOSPC.

Otherwise looks good to me.

Thanks,
Qu
>   			} else {
>   				warning(
>   "the target device %llu (%s) is smaller than the calculated source dir=
ectory size %llu (%s), mkfs may fail",

