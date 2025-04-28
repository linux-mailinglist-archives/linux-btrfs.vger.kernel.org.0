Return-Path: <linux-btrfs+bounces-13457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09EA9E7CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 07:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18C63B543B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961F1A3159;
	Mon, 28 Apr 2025 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qdMDbIBK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEF78F3A
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745818587; cv=none; b=Ys13C6GPRG/iBDqIf+fnr0nXV+aK7xiVc/4r1a6i6zgavmog2HUw5ONkcRZpRnyoRNP9MHNXElD3By7fKNd2ZajU+VnGHE91P+dlaygXX+uVzSyFgfVJJbYxCMm8e1xhqs3G0dv14CoKZMTNWOPEjBb8y4MNBzkASzhc5YHJl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745818587; c=relaxed/simple;
	bh=EpITqp+TF+cjr1M2GAGQmBQ4cPKAK4sQMfOFTyeAwz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7tvFaBfYHvIeRmERiMTxB2tKByOQcTYgPH0J4dKoFOifKOaGkQoK09GkIkRA/e8iWrypF6gUUskBbNzNgMWGEHkmXGNjldxx/9H/4NXTdu3qDfbkza7wTqNQiAQnv2SyQsBELvhTaivW4BzuWMqGa7miJBsb5K1lQsEc48H4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qdMDbIBK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745818579; x=1746423379; i=quwenruo.btrfs@gmx.com;
	bh=D/D5TyS/s4l2ycglWuoxxoiMQhkHjP9L2kmHYTEcaJ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qdMDbIBK1F4f96zZbAYNo/aJywmZi3UE+1oCVzr/Nset9LvDvHNn2OOOLTH+Yqz/
	 UZOBW2ZpVBKIUp25RRhJCI5PaqhjyTYPIGXt734a6rGmdrnCAkMC+/7rn9Uq6Ijcf
	 kZIj+SMY1QkcqlBm8Ti9j0ceWBqqokElKy96wnUVXAOwMJGpF8JFGY7Uafo2c92/d
	 p5n3og7cFTew/n4qL8CcIRIXpJM8EC0rMu6aFw/9eoTk/9RacIzQxbFPtWSQYxGBI
	 2A/3TqtfSsoH1aBY7FHD4PGotgRYbIpiegjcTGSoYELdPejvH59RvJJiPQ4nFM7Za
	 HwP+XY/ZdfMqiuXxoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1uZV7z3ITh-00Uk42; Mon, 28
 Apr 2025 07:36:19 +0200
Message-ID: <a95364ca-7903-4cbf-9f75-417fc0d26bbc@gmx.com>
Date: Mon, 28 Apr 2025 15:06:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Implement warning for commit values exceeding 300
To: sawara04.o@gmail.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
References: <20250428044626.2371987-1-sawara04.o@gmail.com>
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
In-Reply-To: <20250428044626.2371987-1-sawara04.o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7JVu6K/amss6rEoQMRbQPZJNNr5zc0G6KiNWyjtZwQ6TJDGxy/V
 sw4Xy3RF4K2zTRAGevE4nFJdErnvwOjvnKSgPeJQ+AeoGhZ6v5RaJCmuSNPFwmPuSiim0W2
 gnX2EtxwqiGUumDafkKcWZ15tMht5Q480SSL6rktJJlD+/m3M2ro+WdlFvmrdC7iVL2Je5W
 IfTjZwstCoKet9FnOb6Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lma+FijG308=;7tJm0RETkZFrPLrubqP0SpsDeIC
 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



=E5=9C=A8 2025/4/28 14:16, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
>=20
> The Btrfs documentation states that if the commit value is greater than =
300
> a warning should be issued. This commit implements that functionality.
> For more details, visit:
> https://btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specifi=
c-mount-options
>=20
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
> ---
>   fs/btrfs/fs.h    | 1 +
>   fs/btrfs/super.c | 6 ++++++
>   2 files changed, 7 insertions(+)
>=20
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b572d6b9730b..f46fba127caa 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -285,6 +285,7 @@ enum {
>   #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
>  =20
>   #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
> +#define BTRFS_WARNING_COMMIT_INTERVAL	(300)
>   #define BTRFS_DEFAULT_MAX_INLINE	(2048)
>  =20
>   struct btrfs_dev_replace {
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index dc4fee519ca6..c6911e9f17f2 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -569,6 +569,12 @@ static int btrfs_parse_param(struct fs_context *fc,=
 struct fs_parameter *param)
>   		break;
>   	case Opt_commit_interval:
>   		ctx->commit_interval =3D result.uint_32;
> +		if (ctx->commit_interval > BTRFS_WARNING_COMMIT_INTERVAL) {
> +			btrfs_warn(NULL,
> +"commit=3D%u is considerably high (> %u). Large amount of data can be l=
ost when the system crashes.",

I'd say the large commit value is not really going to cause a lot of=20
data on crash.
It's really depending on the workload, e.g. if there no fs activity at=20
all for over 300s, there will be no data loss at all.

Furthermore, we do not really to scare users to use a super low value,=20
which will cause tons of unnecessary transactions and fragments the=20
filesystem with too many small extents (if data cow is enabled).

Another thing is, we do not even warn about more dangerous mount=20
options, like nobarrier, thus I'm not sure if we really want such a warnin=
g.


At least I'd prefer a less scary warning, maybe just "Use with care"?

Thanks,
Qu

> +				ctx->commit_interval,
> +				BTRFS_WARNING_COMMIT_INTERVAL);
> +		}
>   		if (ctx->commit_interval =3D=3D 0)
>   			ctx->commit_interval =3D BTRFS_DEFAULT_COMMIT_INTERVAL;
>   		break;


