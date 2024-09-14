Return-Path: <linux-btrfs+bounces-8015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA9978C1D
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 02:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73581B21D53
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 00:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B22107;
	Sat, 14 Sep 2024 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GYUm9TBQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3920E6
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Sep 2024 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273695; cv=none; b=gdzrcXHDcTfTL8nZBh5RCQpluGeBuMK8enfexiV+FKSjCXKciuWBsY82RZ/92EkX4gHRJg78XSFkqKkw03sCJU3ASDsZJy4JMgJSsBoyhEEGh1keIo4yZJvD1Q2rmwmoBTksyZnzkJ9peKHkoyufgkltyJxDXBuw307Mo4p01fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273695; c=relaxed/simple;
	bh=10qTclWZQ1yux1Q+9kZFDVDuhmImiYLQW3tQz5cmOzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=avM4Qwt4p6b2IKAkUsWKv1IwOFSZ+s9rDTToOLH/6jshCEkN5s0fWrpMzbiBzM7QIwwDaSkK0x9CNRKHgFODzAEMG3e/Hlfq7vumbAfuiv4s34GQxgxvMfGGBOmcJuCw2tu/9NPnRyBKouVrX7RtHtTXNx9RwblovdGFyj6jG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GYUm9TBQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726273686; x=1726878486; i=quwenruo.btrfs@gmx.com;
	bh=9Z30KMvSoevZvDwRs4Py2feyeTMvAN5deiSL3uYX1eM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GYUm9TBQI6dz0uPhCDttwGOwX7VgvGZeGgZvbXCnjtvAjoDd+vgClrVHgsHyk3Ya
	 3/n9O3xXcRAMatkhS1Vw4VzCzFD9tZatXJIopl/kAVdZJBzmYBGS1+vCG2YxmcTpw
	 FVExFomMfODEnTSE5fjTgB1AZwsUTLLML59FDb8Ya4WTKlQ6+aSj/EST11f2p8wXj
	 ZSOjm61z48Y8WYTpab2kKBjk01oTxo2ahyH4mnqnbowuclx6FnJatGFgYVwr6Xtv2
	 eB7pvVyx3cZ9W8vsSnTdFqedJNZWAq7cLFnoMWi730d5+0zW6NnerEC3WQHH9DrKF
	 /i3gzG8vpJo8KHmbtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95iR-1rtc9Z0AFj-0167Ry; Sat, 14
 Sep 2024 02:28:06 +0200
Message-ID: <8694ef4e-b22f-4a7e-a574-f76992ef264e@gmx.com>
Date: Sat, 14 Sep 2024 09:58:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: remove free space when block group freed
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <083c235db86e27f6191fc938fd5f61c980cc5e18.1726269996.git.loemra.dev@gmail.com>
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
In-Reply-To: <083c235db86e27f6191fc938fd5f61c980cc5e18.1726269996.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5+0t4pEUTWZSssEmYM0XY4MulxlT6f2vXfoeTl8dBiOeqGxsSx
 U411yOFl4+AP4T5lnhu5OsaS7+cSEv5QWFS1tgZWWm3Z3Zv1mB9Y73p3D4rZ41Nnx9dSTmP
 2t+KfkQpWNvzDsGQdXANXBKrekDuxVSfrtQrTeZ6+QPdPoiyPqcnCDr3m7MmL3FwTJRYSbo
 5R/HPQFc3JaQiBJt+Mh3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pNrhao6/2VQ=;i25FJ6gVoPNADlPdgAcE3i74dzL
 4Wc4DgeTH1bnRFfxYBecwsBwLAVJsjRQ6e9mA1V5m190gD1zCvPgWZJeBcoW476svztS4ikjK
 MIHZtMekmUZWAIRhMGgIxjE60kgcPedYZ6TQawKsBMxBQEOajZzoUYb4/SGRDBgMf7XfjOqzl
 JUAlafyZYAM4Rz//SfcJvk6AHxvUVW7Vjl/mlYhAhyC/xi3g3XdYX1S+SfFbX1nMq5U3BMmVN
 seszT6AsSqdnD5vjRI8AUOqBfblpYhkwwzZZsCzLuiPWUQ38vvXdp8Ilh+JVF06DeZEEZROox
 aINXOH4TLqU4r+Hqn0tczBSqyT5HKy64s0f5h/jO10nolyQ+TEq6Ii/+hjL3+tSaU93tYGJj7
 uKCqSuKIxrsAGLKHSHD2jSppngNbguTQlMR/mSW0YEelx+f9DZMBRem4sZ+focexZ+DKjLN2X
 NsXzT8EhNDFeP/QeJcIRLjZ9SUj4EX9MMx1bSRKYQE6LA56Y245YOCfjoUPQuyTGVO5/TpUBg
 WpuelgdzbMNEIabWLyqjX9V2yUrNonnYdLdigp+ggeAnZbNHLLAJCIUL324bWw1gldMYibTE2
 EmRYfG4cJ9VHIyECVoykIAeLS0RED8ZTWca+1v259qKJUkdgdnFBRylHuwMwR5zTaI4brV1Ub
 Kp2Gh3Z9OWTIrIAR9R/VmU8NDzwjN6orvKZ/m5atWSpo8nbCUt25bbRJMwb+EmZNdXcmfCqcy
 IEbVIChfKmGrL4SJoCTXUqkQ9bw2trz2MODTB4d4dS7lbwAwfOZmRWx+wzAqpmyfthMZH8Iha
 HcAqxkd5mS2fTCwZcsSVOd9A==



=E5=9C=A8 2024/9/14 09:00, Leo Martins =E5=86=99=E9=81=93:
> In the upstream equivalent of btrfs_remove_block_group(), the
> function remove_block_group_free_space() is called to delete free
> spaces associated with the block group being freed. However, this
> function is defined in btrfs-progs but not called anywhere.
>
> To address this issue, I added a call to
> remove_block_group_free_space() in btrfs_remove_block_group(). This
> ensures that the free spaces are properly deleted when a block group
> is removed.

The idea is correct, we should remove the free space of a block group
from v1 or v2 free space cache.

But remove_block_group_free_space() in btrfs-progs is not the same as
the kernel one, as it doesn't check if the fs has free space tree enabled.

Thus for a v1 space cached btrfs, this will lead to a NULL pointer
dereference.

Mind to add the free space tree checks before calling it inside
btrfs_remove_block_group()?

Another thing is, this is very hard to trigger since in btrfs-progs we
seldom do deletion to trigger empty block groups removal.

If you can find a way to test this corner case, it would be a great help.

Thanks,
Qu
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>   kernel-shared/extent-tree.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index af04b9ea..df843862 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -3536,6 +3536,9 @@ int btrfs_remove_block_group(struct btrfs_trans_ha=
ndle *trans,
>   		return ret;
>   	}
>
> +	/* delete free space items associated with this block group */
> +	remove_block_group_free_space(trans, block_group);
> +
>   	/* Now release the block_group_cache */
>   	ret =3D free_block_group_cache(trans, fs_info, bytenr, len);
>   	btrfs_unpin_extent(fs_info, bytenr, len);

