Return-Path: <linux-btrfs+bounces-16510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE211B3AE54
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BB51C837BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A123C507;
	Thu, 28 Aug 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dPZ+by6s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119F262FD3
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423038; cv=none; b=AStf2UqaLmENqBbyqEY3KVWt9r53h/NY1yOL9YsYr8EBQ5nT/5F+Sug/bbF8sWwr2Kb26Q2gUp+0U4TQjOiCbjx45LAYssj18u5zEMMjHY9TvpD43CiiTU9ejCLFXfkad+UqWGlNInnhD22f/CnMr4G6KUIZIOjcFS8ooOHyt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423038; c=relaxed/simple;
	bh=dbNTkghvwLtpNKXKcNSXOrgh5oiqk3GaAAOQ/F84B9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MymTSgppsObo8YEIKa0MzydZEsmPLZTmZ/n3iWK62+t4m+9+oLPW5apslJVPTnsg7TDFixSHB9Hpzm7UwmORO7hTY1/Mzkc2ykDK7NQoDqnyulbssMj+kDDbpeywDlyp93aFCUV4TXQ7ewhFHGUdzgFPM+MoGQ143t+L1SL/Iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dPZ+by6s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756423034; x=1757027834; i=quwenruo.btrfs@gmx.com;
	bh=dbNTkghvwLtpNKXKcNSXOrgh5oiqk3GaAAOQ/F84B9s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dPZ+by6sa0pvwO+/BVCCt4vR6fYBGjRYFE0q427QRzo8MxUHD9ofDe9ZMBKB6NCG
	 uXX1xZeHHZbddHn7PeffpwlgXN0ZX//NIbA+UVnWvM9Iq1M1M+4ufIA81o5Tjyhdo
	 RjyqQ44gMbBTFIp9Ii1/QDik1BO2j9jD5MTzufnmc5N0vbobb++8MU5tltlap3Nri
	 FagPYFW7O3pbLJys9DsmOrcYj2XpKujPxuPFPWLSTeVGRV9D+QwXUQK+aSqA0nOv0
	 BB5iWZ/aMBVODSEwkHrnY32Xvm92bbc16kebdw5Qw3jZF+mHHNRcuozNlO8pqrvrF
	 u+I+1GxQ8VZvkhegbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1uqyVo1Ezd-00F8Im; Fri, 29
 Aug 2025 01:17:14 +0200
Message-ID: <25c45f36-4857-4f89-9f57-49bb9f46e997@gmx.com>
Date: Fri, 29 Aug 2025 08:47:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
 <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
Content-Language: en-US
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
In-Reply-To: <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T2WE54UopQGPb/zxWMy4Vkw/aPIfIoTTC/ilyB3vF8kotUjcwj3
 7NXTIZiYuNbQDu9XV+5pwH1oppfKFB9u8fUCCuHjGVkM4eN0HmMBbFy5RT51EcNcAQh++0R
 /r0n206H/eGVhSBanneXq/tZk2LcdoQJnXB4tzjj1zYdsDM6gHiloeLeBSAFxN7sXhgVhSz
 MAKG3aNnqnOCa5JnwFP4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zww6LnjaqFI=;02tZYadDunFxt2dm1vKJvAH5Tic
 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



=E5=9C=A8 2025/8/29 07:56, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/8/29 07:23, David Sterba =E5=86=99=E9=81=93:
>> This is preparatory work to use cache folio address in the extent buffe=
r
>> to avoid reading folio_address() all the time (this is hidden in the
>> accessors).
>>
>> However this is not as straightforward as just adding the array, the
>> extent buffers are of variable size depending on the node size and
>> adding 16*8=3D128 bytes would bloat the whole structure too much.
>>
>> We already waste 3/4 of the folios array on x86_64 and default node siz=
e
>> 16K so we need to make the arrays variable size. This is allowed only
>> for one such array and it must be at the end of the structure. And we
>> need two.
>>
>> With one indirection this is possible. For N folios in a node the
>> variable sized array will be 2N:
>=20
> I'm OK with the variable folio pointer array, but why faddrs?
>=20
> It looks like a little overkilled just to get rid of folio_address().
>=20
>=20
> And to be honest, if we really want to reduce the complexity of=20
> folio_address(), we should go direct to large folios, which is much=20
> easier and less risky.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0faddr=C2=A0=C2=A0=C2=A0=C2=A0 ----+
>> =C2=A0=C2=A0=C2=A0=C2=A0folios[]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0[0]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0[1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0[N]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <---+
>> =C2=A0=C2=A0=C2=A0=C2=A0[N+1]
>> =C2=A0=C2=A0=C2=A0=C2=A0...
>>
>> There are 5 node sizes supported in total, but not all of them are used=
.
>> Create slabs only for 2 sizes where 16K is for the default size on
>> x86_64 and 64K. The one that contains the node size will be used,
>> possibly with some slack space.
>=20
> I'm not a fan of two magic numbers.
>=20
> Can we just make folios[] variable size first without bothering the=20
> cached folio address?
> Especially you're mentioning the series do not pass btrfs/002.
>=20
> Thanks,
> Qu
>=20
>>
>> In case of 16K node size we'll gain a few more objects per slab:
>>
>> Before this change:
>>
>> =C2=A0=C2=A0 sizeof (struct extent_buffer) =3D 240
>> =C2=A0=C2=A0 objects in 8K slab =3D 34
>>
>> After, the base size of extent buffer is 120 bytes:
>>
>> For 16K:
>>
>> =C2=A0=C2=A0 size =3D 120 + 2 * 4 * 8 =3D 184
>> =C2=A0=C2=A0 objects in 8K slab =3D 44
>>
>> For 64K:
>>
>> =C2=A0=C2=A0 size =3D 120 + 2 * 16 * 8 =3D 376
>> =C2=A0=C2=A0 objects in 8K slab =3D 21
>>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 71 +++++++++++++++++++++++++++++++++-----=
=2D-----
>> =C2=A0 fs/btrfs/extent_io.h | 20 +++++++++----
>> =C2=A0 2 files changed, 68 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index ca7174fa024056..4c906e5ea8ac70 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -35,7 +35,21 @@
>> =C2=A0 #include "super.h"
>> =C2=A0 #include "transaction.h"
>> -static struct kmem_cache *extent_buffer_cache;
>> +static struct kmem_cache *extent_buffer_cache_16k;
>> +static struct kmem_cache *extent_buffer_cache_64k;
>> +
>> +static void free_eb(struct extent_buffer *eb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (!eb)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (test_bit(EXTENT_BUFFER_16K, &eb->bflags))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(extent_buff=
er_cache_16k, eb);
>> +=C2=A0=C2=A0=C2=A0 else if (test_bit(EXTENT_BUFFER_64K, &eb->bflags))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(extent_buff=
er_cache_64k, eb);
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEBUG_WARN("eb size mismatc=
h");
>> +}
>> =C2=A0 #ifdef CONFIG_BTRFS_DEBUG
>> =C2=A0 static inline void btrfs_leak_debug_add_eb(struct extent_buffer =
*eb)
>> @@ -81,7 +95,7 @@ void btrfs_extent_buffer_leak_debug_check(struct=20
>> btrfs_fs_info *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_header_owner(eb));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&eb->le=
ak_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(extent_buff=
er_cache, eb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_eb(eb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&fs_info->eb_leak=
_lock, flags);
>> =C2=A0 }
>> @@ -221,11 +235,24 @@ static void submit_write_bio(struct=20
>> btrfs_bio_ctrl *bio_ctrl, int ret)
>> =C2=A0 int __init extent_buffer_init_cachep(void)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 extent_buffer_cache =3D kmem_cache_create("btrfs_ex=
tent_buffer",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=
of(struct extent_buffer), 0, 0,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL=
);
>> -=C2=A0=C2=A0=C2=A0 if (!extent_buffer_cache)
>> +=C2=A0=C2=A0=C2=A0 size_t size;
>> +
>> +=C2=A0=C2=A0=C2=A0 size=C2=A0 =3D sizeof(struct extent_buffer);
>> +=C2=A0=C2=A0=C2=A0 size +=3D (SZ_16K >> PAGE_SHIFT) * sizeof(struct fo=
lio *);
>> +=C2=A0=C2=A0=C2=A0 size +=3D (SZ_16K >> PAGE_SHIFT) * sizeof(void *);

And this won't work for 64K page sized systems at all.

In fact there is no space to save on 64K page sized system, the folios[]=
=20
array is always allocated with one single slot.

Please just use a folios pointer instead.

Thanks,
Qu

>> +=C2=A0=C2=A0=C2=A0 extent_buffer_cache_16k =3D=20
>> kmem_cache_create("btrfs_extent_buffer_16k",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 size, 0, 0, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 size=C2=A0 =3D sizeof(struct extent_buffer);
>> +=C2=A0=C2=A0=C2=A0 size +=3D (SZ_64K >> PAGE_SHIFT) * sizeof(struct fo=
lio *);
>> +=C2=A0=C2=A0=C2=A0 size +=3D (SZ_64K >> PAGE_SHIFT) * sizeof(void *);
>> +=C2=A0=C2=A0=C2=A0 extent_buffer_cache_64k =3D=20
>> kmem_cache_create("btrfs_extent_buffer_64k",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 size, 0, 0, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!extent_buffer_cache_16k || !extent_buffer_cach=
e_64k) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent_buffer_free_cachep()=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> @@ -237,7 +264,8 @@ void __cold extent_buffer_free_cachep(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * destroy caches.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_barrier();
>> -=C2=A0=C2=A0=C2=A0 kmem_cache_destroy(extent_buffer_cache);
>> +=C2=A0=C2=A0=C2=A0 kmem_cache_destroy(extent_buffer_cache_16k);
>> +=C2=A0=C2=A0=C2=A0 kmem_cache_destroy(extent_buffer_cache_64k);
>> =C2=A0 }
>> =C2=A0 static void process_one_folio(struct btrfs_fs_info *fs_info,
>> @@ -692,8 +720,10 @@ static int alloc_eb_folio_array(struct=20
>> extent_buffer *eb, bool nofail)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> -=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < num_pages; i++)
>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < num_pages; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->folios[i] =
=3D page_folio(page_array[i]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->faddr[i] =3D folio_addr=
ess(eb->folios[i]);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->folio_size =3D PAGE_SIZE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->folio_shift =3D PAGE_SHIFT;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> @@ -2192,7 +2222,7 @@ static noinline_for_stack void=20
>> write_one_eb(struct extent_buffer *eb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepare_eb_write(eb);
>> -=C2=A0=C2=A0=C2=A0 bbio =3D btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES=
,
>> +=C2=A0=C2=A0=C2=A0 bbio =3D btrfs_bio_alloc(num_extent_folios(eb),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REQ_OP_WRITE | REQ_MET=
A | wbc_to_write_flags(wbc),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->fs_info, end_bbio_=
meta_write, eb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbio->bio.bi_iter.bi_sector =3D eb->star=
t >> SECTOR_SHIFT;
>> @@ -2929,7 +2959,7 @@ static void=20
>> btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(!extent_buffer_under_io(eb));
>> -=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < INLINE_EXTENT_BUFFER_PAGES; i=
++) {
>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < num_extent_folios(eb); i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct folio *fo=
lio =3D eb->folios[i];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!folio)
>> @@ -2946,7 +2976,7 @@ static inline void=20
>> btrfs_release_extent_buffer(struct extent_buffer *eb)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_extent_buffer_folios(eb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_leak_debug_del_eb(eb);
>> -=C2=A0=C2=A0=C2=A0 kmem_cache_free(extent_buffer_cache, eb);
>> +=C2=A0=C2=A0=C2=A0 free_eb(eb);
>> =C2=A0 }
>> =C2=A0 static struct extent_buffer *__alloc_extent_buffer(struct=20
>> btrfs_fs_info *fs_info,
>> @@ -2954,7 +2984,16 @@ static struct extent_buffer=20
>> *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 eb =3D kmem_cache_zalloc(extent_buffer_cache, GFP_N=
OFS|__GFP_NOFAIL);
>> +=C2=A0=C2=A0=C2=A0 ASSERT(fs_info->nodesize <=3D BTRFS_MAX_METADATA_BL=
OCKSIZE);
>> +=C2=A0=C2=A0=C2=A0 if (fs_info->nodesize <=3D SZ_16K) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb =3D kmem_cache_zalloc(ex=
tent_buffer_cache_16k, GFP_NOFS |=20
>> __GFP_NOFAIL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(EXTENT_BUFFER_16K=
, &eb->bflags);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->faddr =3D (void **)(eb-=
>folios + (SZ_16K >> PAGE_SHIFT));
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb =3D kmem_cache_zalloc(ex=
tent_buffer_cache_64k, GFP_NOFS |=20
>> __GFP_NOFAIL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(EXTENT_BUFFER_64K=
, &eb->bflags);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->faddr =3D (void **)(eb-=
>folios + (SZ_64K >> PAGE_SHIFT));
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->start =3D start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->len =3D fs_info->nodesize;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->fs_info =3D fs_info;
>> @@ -2965,8 +3004,6 @@ static struct extent_buffer=20
>> *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&eb->refs_lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_set(&eb->refs, 1);
>> -=C2=A0=C2=A0=C2=A0 ASSERT(eb->len <=3D BTRFS_MAX_METADATA_BLOCKSIZE);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return eb;
>> =C2=A0 }
>> @@ -3550,7 +3587,7 @@ static inline void=20
>> btrfs_release_extent_buffer_rcu(struct rcu_head *head)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 container_of(head, struct extent_buffer, rcu_head);
>> -=C2=A0=C2=A0=C2=A0 kmem_cache_free(extent_buffer_cache, eb);
>> +=C2=A0=C2=A0=C2=A0 free_eb(eb);
>> =C2=A0 }
>> =C2=A0 static int release_extent_buffer(struct extent_buffer *eb)
>> @@ -3586,7 +3623,7 @@ static int release_extent_buffer(struct=20
>> extent_buffer *eb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_ex=
tent_buffer_folios(eb);
>> =C2=A0 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(tes=
t_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kme=
m_cache_free(extent_buffer_cache, eb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fre=
e_eb(eb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 #endif
>> @@ -3837,7 +3874,7 @@ int read_extent_buffer_pages_nowait(struct=20
>> extent_buffer *eb, int mirror_num,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_buffer_tree_ref(eb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_inc(&eb->refs);
>> -=C2=A0=C2=A0=C2=A0 bbio =3D btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES=
,
>> +=C2=A0=C2=A0=C2=A0 bbio =3D btrfs_bio_alloc(num_extent_folios(eb),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REQ_OP_READ | REQ_META=
, eb->fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_bbio_meta_read, eb=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbio->bio.bi_iter.bi_sector =3D eb->star=
t >> SECTOR_SHIFT;
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index 61130786b9a3ad..3903913924f02c 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -48,6 +48,9 @@ enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_BUFFER_ZONED_ZEROOUT,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Indicate that extent buffer pages a b=
eing read */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_BUFFER_READING,
>> +=C2=A0=C2=A0=C2=A0 /* Size of slab derived from fs_info->nodesize. */
>> +=C2=A0=C2=A0=C2=A0 EXTENT_BUFFER_16K,
>> +=C2=A0=C2=A0=C2=A0 EXTENT_BUFFER_64K,
>> =C2=A0 };
>> =C2=A0 /* these are flags for __process_pages_contig */
>> @@ -107,16 +110,21 @@ struct extent_buffer {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rw_semaphore lock;
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Pointers to all the folios of the extent bu=
ffer.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 *
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * For now the folio is always order 0 (aka, a=
 single page).
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 struct folio *folios[INLINE_EXTENT_BUFFER_PAGES];
>> =C2=A0 #ifdef CONFIG_BTRFS_DEBUG
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head leak_list;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid_t lock_owner;
>> =C2=A0 #endif
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Pointers to all folios of the extent buffer=
.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For now the folio is always order 0 (a sing=
le page).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Extent buffer size is determined at runtime=
, and allocated=20
>> from the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * right slab depending on "nodesize <=3D 16K"=
. Cached folio=20
>> address array
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * is stored after folios, @faddr is set up at=
 allocation time.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 void **faddr;
>> +=C2=A0=C2=A0=C2=A0 struct folio *folios[];
>> =C2=A0 };
>> =C2=A0 struct btrfs_eb_write_context {
>=20
>=20


