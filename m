Return-Path: <linux-btrfs+bounces-15923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15800B1E239
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 08:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5FB3AD7B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922321CFEF;
	Fri,  8 Aug 2025 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aXs8h7nB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099791DC9B3
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634339; cv=none; b=tK16vjlLwHwrutK0uNVJu8Sw/y0BHs+0owK954wIWc+FvuQUkLkkJOCkV8HTXI7Wqc7UgiHzG/V862m9aP8XII4TCCy/u88b403PIHbgPMbzG0XQjhedQnVJyg3OfAT+6gGh/X/tPB7BO2DhLZg0TyrrkluEzAEl186i4rSd5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634339; c=relaxed/simple;
	bh=kXTq4JO5nxtHLvR8pyCjKi18gecvBv5bczhKvZ8UrRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BdGJXS7S4cjEv8EbimdJmN5F7IzM3I5Hu4RGVDJK3mvD7z4njnCPEJschM0KOrLP2IRVu8oSmnAbfusd/PtiWsvhPHevXHXTmVHhMGdnf5uLA/OadbML8jnEFkQO1Ffo/4Ar8JtSmSObUxyyZDeb8MIisbOj8Wj0WKVJYoQyoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aXs8h7nB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754634335; x=1755239135; i=quwenruo.btrfs@gmx.com;
	bh=BMv/lUfisOwOWZoOnnI356MS+mmwak9cQpN/u+d9enA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aXs8h7nBclMrfA3eoas+8wFmShRIcVDKWgUQ/BCotjBs0FdaykZdNHnDhpCC8f/W
	 0KCXOia++qZ8TQkniwruwkhn3cObisqqaZIf4Lv5mqJkb7V4iyt0WuXqeoAWAxb3b
	 hoMT49zA919CwjkBqBurADZJrsez6UpHjUqBTpLPfiz5KNV0a8ZBjSKw96oTYr1Jf
	 Fy0LuEOwvwMn4w6Dg9+0WX6j2dd8yk10jWPSSQziGmmaMfgStSYfThW3ZbWR/Pry8
	 GJH5NBwJfvoz57IimRoBIwBVIMj8b6J35t7KkjiipOsFC5YpwAvqFEc7RnTB5FK6M
	 OH4YBzqdZacTDw12LQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRQq-1vBrYA2J4u-00NJOH; Fri, 08
 Aug 2025 08:25:35 +0200
Message-ID: <68f1658c-92c1-4c37-b444-20e251eb8dd1@gmx.com>
Date: Fri, 8 Aug 2025 15:55:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify support block size check
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
 <0905172b-c9b4-49e8-9a0e-45702f495074@oracle.com>
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
In-Reply-To: <0905172b-c9b4-49e8-9a0e-45702f495074@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I27JZrBh67doe24LwvuxgQqYfSqfhJzDLz8de+6DTUhzfBmAG3g
 JIEFuNhCzTnim5p0csXTINxRva2bU5zDVlOWvEibuSPhE9uHXS6eJ/dbIbUfJeBD0gi0KwR
 EsQsQOh+feKaXj86N2k0Ppg1MLFkQhwjEhrIJHR/651yKWCMa0M3rS/ElYno/p5lTSqynLr
 fzZI5MVOLZLTxPSlmQ/dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YeV8qrhVJfI=;sDLbw1hIizrWqJ6I620Mv4NFeH6
 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



=E5=9C=A8 2025/8/8 15:10, Anand Jain =E5=86=99=E9=81=93:
[...]
>> +=C2=A0=C2=A0=C2=A0 if (blocksize =3D=3D PAGE_SIZE || blocksize =3D=3D =
SZ_4K || blocksize =3D=3D=20
>> BTRFS_MIN_BLOCKSIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>=20
>  =C2=A0So just remove this line for multi-page blocksize support?

Yes, that will be the final step, making that function to return true=20
unconditionally.

Although it will be done in several steps:

1. Enlarge subpage support
    Currently we only support 4K if page size > 4k.
    We will want to support all block sizes <=3D page size.

    This is the easiest change and I'm already testing on 64K page sized
    aarch64 machines.

2. Add block size > page size support
    We only need to set the min order for data folios to enable it.

    But compression is the main blockage, as we have to allocated folios
    for compressed data, and those folios must also follow the minimal
    order.
    This is not yet possible due to the compr folio pool, which is a
    global pool and only support page sized folios.

And of course, both step 1 and 2 will only be enabled for experimental=20
builds first.

Thanks,
Qu

>  =C2=A0Looks good to me, either as-is or with David=E2=80=99s suggested =
changes.
>=20
>  =C2=A0Reviewed-by: Anand Jain <anand.jain@oracle.com>
>=20
> Thanks.
>=20
>=20
>> +=C2=A0=C2=A0=C2=A0 return false;
>> +}
>> +
>> =C2=A0 static inline gfp_t btrfs_alloc_write_mask(struct address_space=
=20
>> *mapping)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mapping_gfp_constraint(mapping, ~=
__GFP_FS);
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 9d398f7a36ad..a3c3281a4949 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -409,13 +409,19 @@ static ssize_t supported_sectorsizes_show(struct=
=20
>> kobject *kobj,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char=
 *buf)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 bool has_output =3D false;
>> -=C2=A0=C2=A0=C2=A0 if (BTRFS_MIN_BLOCKSIZE !=3D SZ_4K && BTRFS_MIN_BLO=
CKSIZE !=3D=20
>> PAGE_SIZE)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D sysfs_emit_at(buf,=
 ret, "%u ", BTRFS_MIN_BLOCKSIZE);
>> -=C2=A0=C2=A0=C2=A0 if (PAGE_SIZE > SZ_4K)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D sysfs_emit_at(buf,=
 ret, "%u ", SZ_4K);
>> -=C2=A0=C2=A0=C2=A0 ret +=3D sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE=
);
>> -
>> +=C2=A0=C2=A0=C2=A0 for (u32 cur =3D BTRFS_MIN_BLOCKSIZE; cur <=3D BTRF=
S_MAX_BLOCKSIZE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur <<=3D 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!btrfs_blocksize_suppor=
ted(cur))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (has_output)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 +=3D sysfs_emit_at(buf, ret, " %u", cur);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 +=3D sysfs_emit_at(buf, ret, "%u", cur);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_output =3D true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ret +=3D sysfs_emit_at(buf, ret, "\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 BTRFS_ATTR(static_feature, supported_sectorsizes,
>=20
>=20


