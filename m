Return-Path: <linux-btrfs+bounces-14151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB2ABEADA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 06:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B881BA4F62
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 04:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601423184C;
	Wed, 21 May 2025 04:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HnUBg8fX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101322F74C
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800817; cv=none; b=KoWQmkp6uxum7hRdrVbBuHwlI5DCSZoGbzJl9rBvaTffXTBqKYLNjB2nPy2W2JGHV/4aNhYHDvpRdDeBXRFfm2lzZW3wN7jwfWmroq7LozJtYDcVXbBXM3/efdj1X/UOLSFrJ9T8nj64YeJL83LHIgKAfMLdCd6Uj1MotnVpdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800817; c=relaxed/simple;
	bh=ru2AVToLu6bHyyG30L63bLTtIcmZ3BOQghMM00/MeH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlANpAlkcqoXjyEka4LI/Yixn1X4UnBHyoKgIKgsoQMkOTzKxKWxg1AWMxpoxuiJncTOyEUM5pexmjPwnzEKhr495LXKCNVurSzjUfrNhJMRq3ySFu/CNHf72MLVCvy2g87xKGUQdDZIh9oSH/PdsEtVVAoqU8juzOGTSE5HS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HnUBg8fX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747800812; x=1748405612; i=quwenruo.btrfs@gmx.com;
	bh=aGdjomUTxkQhYfDprWQkUsMVVNl66k0ojY4E1WYRQEQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HnUBg8fXVhvnQaK4pNhnPxhVA0QLY7S6Vo7cSBYCPN2aIBplXJ8La5wVszTwVTyk
	 38TNrVyCJpW7GTOWJn9NMAFL2ETv3OR4f2muvLjUKbFY3wKok/4T4+brsNjpcPhnB
	 H29kZ489Lg18Ya6i1HIvAELmP6tKD1Io7xWvQgLBZBymm8y1vzmaiHJnZXxee+C83
	 j1A2pRvQ16U/0XL1BWkDKfuh7xnaYfsVvwVjwlpf0q/fHMe3cjBrOtnjMQMIawr1U
	 bPiywu3BvIRZqe4+QgoLl01/qmSQnF9Dfdjr8ByMv9XPv5YBUNZV63gBVA5frVkSS
	 ODEoXR6e2ttM+adcPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1uulL80BYk-00dWHo; Wed, 21
 May 2025 06:13:32 +0200
Message-ID: <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com>
Date: Wed, 21 May 2025 13:43:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
To: sawara04.o@gmail.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
References: <20250521032713.7552-1-sawara04.o@gmail.com>
 <20250521032713.7552-2-sawara04.o@gmail.com>
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
In-Reply-To: <20250521032713.7552-2-sawara04.o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bqHRqPb9mO4ar1WWGjy9r7aufdL+rUdzISaGgCelI6nHUTSQd/c
 frQVW2h/BkaWZT/w9jW5x0SmDaPm9mMQ5Wp2253x7PUfg9OpSaKVS+RL6gLYkfs+DeiksWD
 hpK/eJfLcjhcKI0rqYN57rhgiNfz72ws8iepwTInAfUSkWsaR22UtvgEpYx7la+1imheVri
 nkTqiOeK6LAemZfynulXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y6wbwLAkKMU=;TMgghvAnvIEY4WeZ73Kax3EMxRu
 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



=E5=9C=A8 2025/5/21 12:57, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
>=20
> The nobarrier option disables barriers, improving performance at the cos=
t
> of potential data loss during crashes or power failures especially on de=
vices
> without reliable write-back caching.
> To better reflect this risk, the log level has been raised to warn.
>=20
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
> ---
>   fs/btrfs/super.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7310e2fa8526..012b63a07ab1 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -407,10 +407,12 @@ static int btrfs_parse_param(struct fs_context *fc=
, struct fs_parameter *param)
>   		}
>   		break;
>   	case Opt_barrier:
> -		if (result.negated)
> +		if (result.negated) {
>   			btrfs_set_opt(ctx->mount_opt, NOBARRIER);
> -		else
> +			btrfs_warn(NULL, "turning off barriers, use with care");
> +		} else {
>   			btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
> +		}
>   		break;
>   	case Opt_thread_pool:
>   		if (result.uint_32 =3D=3D 0) {
> @@ -1439,7 +1441,6 @@ static void btrfs_emit_options(struct btrfs_fs_inf=
o *info,
>   	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
>   	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
>   	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation=
 scheme");
> -	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");

I know you want to avoid duplicated messages about the nobarrier.

But it is better to use btrfs_emit_options() to add the warning.

The problem of showing the error in btrfs_parse_param() is, it can be=20
triggered multiple times.

E.g. mount -o nobarrier,nobarrier,nobarrier $dev $mnt

Then there will be 3 lines of "turning of barrier, use with care".
But inside btrfs_emit_options() it will be only once.

In fact this also affect the warning for excessive commit mount option,=20
but there is no better solution for that option, but we can do better here=
.

Thanks,
Qu

