Return-Path: <linux-btrfs+bounces-14152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE28ABEADC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 06:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCF1885A64
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 04:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD0222F169;
	Wed, 21 May 2025 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SIDlBD3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B041C69
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800925; cv=none; b=XS2Yuj/OOxsklP1f8hGvxDeSAOpnc0R4tTqzfIsN958mr3oaxNtdyZxEmMs9wCKnunUHwik6DLJfec2UQ0WgI0yInTCZhPlF0woYtx6hrnf9bce/nkqsdrmZhZj1Hf3FT/QYZgylte2E83JW/zesS9nrKPHYg0S93QfK81lBSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800925; c=relaxed/simple;
	bh=0pWnF+Pt26Ru4iGwqkIQt8+YvnloI9pGJnA5e+AE94Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuHlR0U/Fc5ygGOqR9E8oyy1IX3wGKCmv3wjhAbra+lwsniQjYVxBpVCWMo3suxBFS3fcCvTmOUtkX2Bd8X2lXsNInOhd8rWS65pl9CMBeAnn68StFjr+FFilVhOPeMrg41vV9xWE8W4fbBecnboYhtEhgjywBaeitMUHX6wE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SIDlBD3r; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747800919; x=1748405719; i=quwenruo.btrfs@gmx.com;
	bh=fYAlbCo4KaKXocDPP3Hb62uM6bn8VsBSGE6Yf0I8i2Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SIDlBD3ravxFAGTQnVVlDrsq/MSAZwGgDH9oIUO1/PWc3jUAYMGrMtjIJv4X2Vd5
	 z65dtwpFrOzEeZp954psTI0YNP2z827ZFcPBw9Fo8gIgTQFazLP8FgDfE/dc9DkJg
	 hzT1Yc7CtCmefPDkmQ1UksD77lfAXCuecSHvd5zB8rT5GJcYB6nmTj5cqMEkzRczV
	 gnJOAuDSqBnQUjx7zZ0f5sCSIMtra3+bWVYi/Gj+Su5YKMXYM3lAfg+P7ypuvX6S4
	 FQP4zRS9WmDkMYFO7znnMYIuSqLsgoE6DE89kFjryGn8OX9aO3oYELmkgiUohv09x
	 GJEzvGPqhUpcJnHASQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1uSozU0wIt-00R2MA; Wed, 21
 May 2025 06:15:19 +0200
Message-ID: <e508301e-4474-4490-93ad-bbea3e6ed04d@gmx.com>
Date: Wed, 21 May 2025 13:45:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: Fix incorrect log message related barrier
To: sawara04.o@gmail.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
References: <20250521032713.7552-1-sawara04.o@gmail.com>
 <20250521032713.7552-3-sawara04.o@gmail.com>
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
In-Reply-To: <20250521032713.7552-3-sawara04.o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UE8W+AdNByofQcOucV0OlYw7fGXAIcW9/i3lIK/FBTm6fywe2hD
 3QFjH/vOw/ZR7mE5OxCJLU6U++NGqrQA+0wX04esTVqDOsdtC/PMC20QxBpZNQmCMY2kWVc
 rtGxLzkwet1h5hBVplggpt7oKxyFEIJ8AAS2PrPbvGBcsQoB/hoJfHHYUMB8bdK8WtQPHZG
 x1OVIJVe3IFOR66SbDiDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dKGbjdCZ2Z0=;lJVFVnNUTY3IHUbLQNUFsqCnaqF
 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
 LWrC+MEOQNSKs=



=E5=9C=A8 2025/5/21 12:57, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
>=20
> Fix a wrong log message that appears when the "nobarrier" mount
> option is unset.
> When "nobarrier" is unset, barrier is actually enabled. However,
> the log incorrectly stated "turning off barriers".
>=20
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

This is definitely a copy-paste-error.

And we can add a fixes tag when merging:

Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")

Thanks,
Qu

> ---
>   fs/btrfs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 012b63a07ab1..0e8e978519d8 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1462,7 +1462,7 @@ static void btrfs_emit_options(struct btrfs_fs_inf=
o *info,
>   	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
>   	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
>   	btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allo=
cation scheme");
> -	btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers");
> +	btrfs_info_if_unset(info, old, NOBARRIER, "turning on barriers");
>   	btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
>   	btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space cac=
hing");
>   	btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free space=
 tree");


