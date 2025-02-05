Return-Path: <linux-btrfs+bounces-11304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E9A29B9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3871884717
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 21:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7B214A72;
	Wed,  5 Feb 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QjwoYsau"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD0214809
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789615; cv=none; b=L3PQwYAXaird923u+K9Z0M/p+5NuO/hvG/2Fv+f0N97MVySpfVIyVIIQYnP6TgHJx3iirK0wz7NAqNfQkM99sHXKBnNFG/Kq/o1ZRVREgdBrEkHfNhdtSrqGdr/k5CTdzdM+YX7AOcesKsT5aEizhDyYx5/UCqW8ydgKEyQ08ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789615; c=relaxed/simple;
	bh=IMulULrKc+YPH2TWLA35642nxcJiP5zzYzdZZ+vwb9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HUmXxJT3Wu0LGrweNWuxZ8QXefiThgGjq6EDfogBucuDzpp6mvfEDHIdH0tPKrwFnPzVkOWIBLcDUSgG676Sn7duzArg6/UQrPRT6wqY/bp1prXaLLiEKWjHVIg+5Ui1Z3h61T+IocXs/dr6qXoRfrnqOspoqikECG/MhxALb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QjwoYsau; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738789607; x=1739394407; i=quwenruo.btrfs@gmx.com;
	bh=Rzt325+q1TGd4ItEIzvcvBUUGb/TUYOTBJ8dL5BELYk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QjwoYsauoVo6lw4DcFCucPdZNbKu8Z2FsIjmnEiiFLT/pqZ4hdpfTqlG7pk+MtSM
	 GvFYb2QQiE5yS/9iOgQkZM012wdt3eL+DhUTTrn8Ul+JP3tbbM3KYB9hvjDCmBwq4
	 8MlmgUIO0bnwLSA77Ob3+MdNNZC483JU7eGsl2YDeI6uIVSv8JrmPT3co7rESvMAw
	 x45j/2/fDP2ug6Qf7qsmUWEqv8M6O4mBOk23VU/KC+UWD5jvLTajHiP6Wb+fvPkkw
	 znE92Qk7oLkV8wvjTMvKLmm8g2OUv1a5V8k9NkuujUEvuLcmHJBrGSJ7d+dCxSSKP
	 YXPTVQ2CQu32vapAQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDou-1tUZHq2bcW-011tu4; Wed, 05
 Feb 2025 22:06:47 +0100
Message-ID: <63295388-5089-4f9b-a63d-aba8680202d7@gmx.com>
Date: Thu, 6 Feb 2025 07:36:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid assigning twice to block_start at
 btrfs_do_readpage()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <87182120501efa8c878a65196fd6225481cab7c1.1738755264.git.fdmanana@suse.com>
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
In-Reply-To: <87182120501efa8c878a65196fd6225481cab7c1.1738755264.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aye+xC7HoC/SeLtsI9lw9ZBObXosr3dxVkaDghvruL3QkNKgpwu
 oDFHdXVEnRjSABi5USgc9oYWotEfYaZWvoeCdWnQ5LNpseLrwQ9w1YvgTlnhRI3LA7I8PDa
 ZlyISGmI7vOaAxMCH34NyMY33H999CDORGfkHdTQgJbabzMy87y77zRC1NluUp5IR40Eemc
 F1Fj/cDRQkFUlMSFipVRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J5FXa1fo10k=;ol+Uc7W8t4d6GouIcWfM5GBeRs8
 iIY1KQqG3kgcb54Y4C9/nOcQdqCr5gtKKr0npmyd/KJNoerdIwQ99za1oR9KdTvctD8IxomxL
 pvufue3ukYmqi7RoSjyFHp84mSM2oGlJcP4ISam3qRwXoxye+fYlMwHAj1oO+3ez91YgKW2Wl
 51U+80Z/ArISgNeNVsqFC8LAvqXFcZJd6wlakEplbw4kEhSYiFmjNN4yz+DDEf0ELLQ9kZwHL
 K72uyCGEzS3m8U0/rLY9IzSJYUIxTURDMN4J8Tl6gfdrzR/Afyka3IJat5oz3G82t6cXHxuRW
 fnFs8fYZgYyZsxkT9Yu2GpPhF/puVei6i0z6wb46NRb2nFhOAmdjlqmseNyc6EI1qGAr6ZSMJ
 AcGcto1zIV3P4hX40kQbmBsdLYb4hQ3UYqo6l6ZXMVcBTjKhe6nir7wYkSaC3Hn3Hia/1gAs6
 FJNK2siss22K9BC0KscCRQNbWrBH9ivXW+Jy+6XwwgxbBNmBqgSQjjliopFBWFDBtJAerE5id
 PeYIpFJ7FCIaIxqWSo7IEJ27qfRMMhUWFQ4CnvZDzqJW9KlvHaq9A9zM7otpQyZF1mh8Jgdnb
 JR16QKZeP2FrJjqHph0fkBcMPrE6FNPOHZHdpEUXBWfVC24eRBanBRRUWTEIGgXOf8aW3whCO
 erGg4AJlK1beWHDbL8Ysk+h5ke0ARHBzdAZu4qm9Ckl2wvHBVtzqYcQ3JFsMXIJIGzXcUy515
 94ZUj0+zPsomi3LBhTfE+1Hal7L5V9ab4McrEn6RNqzMt/kQOscveo2TwEvfETz3psc12XQ6n
 smCLmHS6WJjNLWCsGRgEM3/spo+F7LpOPn8gPgYJ43XrSQ5VU5PXcOuWwDFOVvKIzPLvraskL
 aFKld7huyBNyb53/uwHMl3EnSkmGWHzVMhFPcFm9HFvQhf8KQLBJERIRJ14fy3Lt4TYBDwI8d
 low6Nb4irC9udpi0vE+vnCmxXYgYnB+7fvLX0R1gvgt01JtJKX2aYgAePoe/Iv9tUeyDku+uE
 2+zTkHFEeTz8A/du2eQdsM6HQl2ZLcjt0Y1nsOOfkSPEmoK9ZMwSOCQEyh6Fkr4Uyx8o3mJ57
 N9Wo87ne4m2UmMHCvi6qeoG8gPkKXFONd+w2Ocz5IHiubB5DnAz/fS9cr+3eUMD2io9GQU9Jo
 2IjurgP/ChIT8vGZouXdi8iKiJyZAo7+o2T5DTqh3Orh+U6OymfZKmcoZvY6mvS58xBkzTtBg
 nQtGf41wApKit14tdhH4WiUedipxx847c/EJRFmn8hyhTf9ulDDygJHbbSURXb9Vj6YIVtc6o
 Py9PzmyjHuqiN/GNtQq8SiZGw==



=E5=9C=A8 2025/2/5 22:06, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_do_readpage() if we get an extent map for a prealloc extent we
> end up assigning twice to the 'block_start' variable, first the value
> returned by extent_map_block_start() and then EXTENT_MAP_HOLE. This is
> pointless so make it more clear by using an if-else statement and doing
> only one assignment.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bdb9816bf125..9e70d43e19cb 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -991,9 +991,11 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>   			disk_bytenr =3D em->disk_bytenr;
>   		else
>   			disk_bytenr =3D extent_map_block_start(em) + extent_offset;
> -		block_start =3D extent_map_block_start(em);
> +
>   		if (em->flags & EXTENT_FLAG_PREALLOC)
>   			block_start =3D EXTENT_MAP_HOLE;
> +		else
> +			block_start =3D extent_map_block_start(em);
>
>   		/*
>   		 * If we have a file range that points to a compressed extent


