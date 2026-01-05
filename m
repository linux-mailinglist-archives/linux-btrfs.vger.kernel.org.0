Return-Path: <linux-btrfs+bounces-20098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF8CF28A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 09:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23FF2300295A
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209F4328B44;
	Mon,  5 Jan 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bxrhyk6C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8732861E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603296; cv=none; b=NICIcE2E55sEn6Widwz2euhnAyRYC+atDBNG2n2uOmSKkFRSrwSmtupb5lOwHHUYdv5019jNvgp654LmXLrRWaSZ0xPWDTclZufim9bf0OHUTU0sYZtu+HCwumtNQOcX0wJDlJU7MtuUi/KL1n7gBcojaKJ1yhZLiqC7Vfq5jCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603296; c=relaxed/simple;
	bh=DsV13zb+Ko3Lzs5DWIB51HUD9RGSoXXgwPrv78uwsU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ckfjLc+0EOrEHxiUz54Oahecwyws4DwfYWD1w5id5R2TiqHJV2e8UpP4YJBAgRvEnsHkg3oln1Rg8aB8QnuRdRtXRmx3+udFu5pibex6h+u41qw7EQFIjXaXVUtFXdYHAc89K7LF1cDXHws/fZ+OXuUb5gPuMk+64IRD8rHn5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bxrhyk6C; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1767603288; x=1768208088; i=quwenruo.btrfs@gmx.com;
	bh=hlGSgiHd5PFh9B+FNRtR/XwrHX+3hRna1sV4ofgNfTg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bxrhyk6CeuIEXaqmHV2mpvWR51ynd+rN4fawt6PrmRM1oN9RKcZsMj/PX5CO08fK
	 obhsHR6tLXJRHfbD8FgIdUp/f8rbLU+A0+P086QR+L85tqx96KaWOXxH+Nhwzj6ND
	 foQm1S3D7VObsZZAyAMdjZDDztLHISbk2COY2oDhEGI85JHG4Oqp7Gc5Mn9GQJWKS
	 loQbVqNl4Je+KTUcypi3/DSABKm9907ZdI3EOXDDy48nEbD0aPtk7PfbzR1roqPbw
	 1aoYH+oIAg7486DAdLC4cWwCxJdos4GUbZKliXkhsDGIPWqS5pJQs16NfA/iREnBC
	 A7ngSEnHDJtTiyicvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72oB-1vWKZE1tst-002K5S; Mon, 05
 Jan 2026 09:54:47 +0100
Message-ID: <101696ce-35cf-4bf5-9b7d-e0b44eec16af@gmx.com>
Date: Mon, 5 Jan 2026 19:24:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tests: fix return 0 on rmap test failure
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20260105081905.993994-1-naohiro.aota@wdc.com>
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
In-Reply-To: <20260105081905.993994-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PhmDv95wvVPP5xslAc/hdMOGWhQYQALRE8vbwW+vyZ2QzvFU9Xp
 DLIPrW+Vr1CRefL/dqKx1mIgR3OhbA3pvj+gsM9pGfdZIipVoHbIqnuSHKFRf9NSRJV1Hj1
 9waKE+SSDjb4VFvaABK976y5F/LNnazB2kqnqc4KLn0lEdyQIyxnhg9SSvTiOZbaUKz3+hg
 P31zHorMNdCZgorQzp9+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WZyTEJ91TGo=;8dGXj8gznzJaV1H19IwcS99qeVE
 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



=E5=9C=A8 2026/1/5 18:49, Naohiro Aota =E5=86=99=E9=81=93:
> In test_rmap_blocks(), we have ret =3D 0 before checking the results. We=
 need
> to set it to -EINVAL, so that a mismatching result will return -EINVAL n=
ot
> 0.
>=20
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tests/extent-map-tests.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-m=
ap-tests.c
> index 0b9f25dd1a68..6bad0c995177 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -1057,6 +1057,8 @@ static int test_rmap_block(struct btrfs_fs_info *f=
s_info,
>   		goto out;
>   	}
>  =20
> +	ret =3D -EINVAL;
> +
>   	if (out_stripe_len !=3D BTRFS_STRIPE_LEN) {
>   		test_err("calculated stripe length doesn't match");
>   		goto out;


