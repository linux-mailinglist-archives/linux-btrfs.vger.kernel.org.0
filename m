Return-Path: <linux-btrfs+bounces-9377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92B9BF880
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 22:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8C21C20E66
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6520C48B;
	Wed,  6 Nov 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AB0RtOhN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DA13CFAD
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928594; cv=none; b=llgW3aOAiKmzUNYGn86QReoeWZKtZvEcaAdK89c+7/OyLjPgP5QAN+95vLE96/KBAkwRstV9uSGCSo2fvU0UMRXAxDBmy6tmHzzHEkRHjiGJZd7KQK6cCDa6b3FS99kozadCnhD9iyVQRKApNjKhy+Hjr17YGFdxloDXR/0yl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928594; c=relaxed/simple;
	bh=CsHlfyD9rOFOkfCDD47W+SBA4DpFQ8PixHgMfkf2vRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T3aqhUnN9IXG/jx0qUipOrSmwny6MxVguAsoLgiaRPMZmy/h/luIhXvqDmdjflUsdD/m+UhaW2FsqMnzF8YptxWAQ9s7rHgPZdMnxCtnI8NsKzbU+2ufcRyZhPZEJPYN+3/xh7+3GygTBj+h3kCdX1U2cTJGDCoLIzqmiNMmuQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AB0RtOhN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730928586; x=1731533386; i=quwenruo.btrfs@gmx.com;
	bh=q5C3EaBlxMOXicSfsbNl97EaGaUDDV9d/DBITb/IxbQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AB0RtOhNC6iS4XyFZKQG3n6Ug7zieVmhtcGR3uLi08QoEjkT/1A8ak+DWbn1iKev
	 0AGyUhUhpHO6f0MMoN9sBNFabuZws4U27frpK9BOXbd8lv0A6XakI5N/mIYm2w9rp
	 8eJejHxGtYHQYy+96h28ldhh8IIxuYJYWyA/hgAHhK1it4MWN4ABsuyuIIHMsO0fy
	 5SR+Jt/U6xcPnRvSq9lg8igB2LViXydvNRKWcOFlCkHi39A/JQ81encKK9TQhrI9F
	 cZiexgby9bEs4Id5+IdwIkSFhqiQXZTr571lLMettFlx2laK+vbHMCo2gumdCv4An
	 g6bFv0aXh4fRzkhZjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bfw-1ttLDY0pDC-00r1az; Wed, 06
 Nov 2024 22:29:46 +0100
Message-ID: <2298f69e-4ba4-4151-99be-ec3b806744a7@gmx.com>
Date: Thu, 7 Nov 2024 07:59:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix warning on PTR_ERR() against NULL device at
 btrfs_control_ioctl()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <5bbe65395fcb54fd561cc17a705ce6d50d0cc5c0.1730898948.git.fdmanana@suse.com>
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
In-Reply-To: <5bbe65395fcb54fd561cc17a705ce6d50d0cc5c0.1730898948.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+4PeItdjx/+PBxgQUK6Y+BmcxDZkE9AgI8r2gMstoPRuPdcIvaZ
 qbo8R23zumCkOgYdUQPKJqDA6iLoQ4CaEC5yELbJmFf30Fanbb0yM02ZtlJpnGrLYN9q1al
 s5I4pjEzP0+RLvC7c6y7OIHGkt6bJ2ASM28wAeW+42+No6f6nKWGqbM9VyQycExONj7ItHX
 /UlPNckW/i5wSibG7W9OQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V3DKoe1Ux8I=;tk1LxsFjMPrpus/LLU0mQkMXsJo
 OBMi0THcHURkcNPvdlTaa0I3q+R3X6kEYQem8AaF92nRsCsa+JgNwPJ4a80RR+pTkkARqLyhV
 4aNntgj32XTrvaAczgswLjHQxMMMViZwOLO80bMTc+EODapgLvM7T3j7Uj/yCYHsnHjPZMw36
 VRe91Bd+V1hnRXrV0wozzAKZH9BlY2zT4XRKRblZFPYXv/NYeJeUVSLDBfUkMPNZr99DZ5qO3
 PJc7tDUjdkZm5cjY/eZDB3R7qFpvefA9C6Bt/id2zp+uzkKgj4/7qSLFGGUtrv5xQMYqgyjO3
 q0Pqc2V1dLW424RTPzJWPnZODSJ7G3NC2oMSqVQoU3vMyI9+CR2MwpptpUFRjFiJWasK2l99X
 f55Hymias5Q/PMNLbnQdf3nRzN5WUnlkQUr5LzXQ/m2lpKcl+wTnTgjwXPaKkSMJrp+rpScJc
 MT8Xd4SVk3QI/KSfJ7imwOMUAF14uljjKSms5uQgt3VrLOlqMEJnn12FhuCkcytvxfboP4Oo7
 tznqfwYexMYh+jC8ef5Xz/dhkqTy9eoDQQ19QEmXjraEthtpRBN3M6u3FkpSXiPhDdMv+Axo2
 YPTU1mh3MoQ8ZI4FGclml8MNlnjFNczbP9zwyFOrM87FiLgzkYfZTblKNswAh80b8LYj54qtQ
 Gz+EFCNyXIbtq7TU4FApEAouLl/iM1Pr3stdl2DSwksvaR4KWjb23QqKX8l7ZNd3QecZa12Ds
 Ywh1KU/hdo1i75MYxBEi1gI7Ti5vFcKMvisZC783xbW3DdhWh6cy7GMdt6Q+NneI27Z5aUd5d
 gnWklhmjNrLexpuA8oh+SKvAN6+7l8zTwFUG8dtqFItyrNEO+n0EBu9Hm6F1GpLOrtFeMMfUb
 Bf8Bcn8SnT/cpRTxNt3kgRG/OZLbsKzJCPvf569AyUX+yENgbri60bRBD



=E5=9C=A8 2024/11/6 23:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Smatch complains about calling PTR_ERR() against a NULL pointer:
>
>    fs/btrfs/super.c:2272 btrfs_control_ioctl() warn: passing zero to 'PT=
R_ERR'
>
> Fix this by calling PTR_ERR() against the device pointer only if it
> contains an error.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/super.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 6cc9291c4552..9a09a1251057 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2269,7 +2269,10 @@ static long btrfs_control_ioctl(struct file *file=
, unsigned int cmd,
>   		device =3D btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>   		if (IS_ERR_OR_NULL(device)) {
>   			mutex_unlock(&uuid_mutex);
> -			ret =3D PTR_ERR(device);
> +			if (IS_ERR(device))
> +				ret =3D PTR_ERR(device);
> +			else
> +				ret =3D 0;
>   			break;
>   		}
>   		ret =3D !(device->fs_devices->num_devices =3D=3D


