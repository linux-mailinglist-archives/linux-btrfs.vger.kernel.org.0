Return-Path: <linux-btrfs+bounces-7002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF806948D95
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CBFB25AC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7431C2314;
	Tue,  6 Aug 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hM2FYceH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35A13B2AC
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943393; cv=none; b=XdgDy8N8nfXzEOCJx9F0Oc33Z7XDvHbxYZEHNWJul+F7AMhGWrMpdmYcuAVIaMtKUpByyxUieKEw9cxVxaCw0xj5oqz4i2coItbSF/HE8mT//9oemXV7SvsPTioCDbpRSi5eM7QExl7qN1x37P0+VJQ88mXCIQAGluntL/jqssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943393; c=relaxed/simple;
	bh=X9Nn/z+LpnrOnN7Vm7GXfOj6DZPQ5Go95OZUkwE998U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iaCjWcfoaExKrZhgUtOUV8uC99o2aBn8luALt5ZoC2tRb3GLODrU8Abm3TOhuNhSNFCx5jcqrc1IpNhPsNx754Isw8FabFsxrLdzbeZPsLZFffWee7q5W+YfzbkCLpgvO1Hwh8MuJVU1O5HO5lA/8VkCLwQyvb67r/oliI+Yxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hM2FYceH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722943388; x=1723548188; i=quwenruo.btrfs@gmx.com;
	bh=v6Nt01mRHeCcEj6N/fQ+eypAL0R8BsCAVC7/cCV1lyw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hM2FYceHylF1IuNle1KPIMIi4mF9xs4J8hMKb15BT38AeX0oOiJ1qTfhdi5sTnCd
	 TCcrhdQbttOWZfg1P79kk1+DKjdgKI6jtA+MujyhjMBiddOjHLlMAw0OiiwHhixpF
	 NFJ8px28aw8YHb6NwHxazLhGso8gNSmjK15zc+CAg1iZYfziD+sGxkyzzsuK09Vmu
	 tNQ3z2jLWPlHALH4nF6p1kYpbE8pZymC8u4BT3f8q3DGA5ajpQKVkBX/A18652Toz
	 upnN57Z531fOxZ9CCPLie4QrMuHYThErLmDRg2GxTn44/g/bje5WU7spJhXgnjEer
	 bZZl7A8rrcLcAQiG2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1swGXf1uUm-00X6nl; Tue, 06
 Aug 2024 13:23:07 +0200
Message-ID: <d089a164-b2e8-4d29-8d96-41b12cbfae42@gmx.com>
Date: Tue, 6 Aug 2024 20:53:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
 <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
 <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
 <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
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
In-Reply-To: <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P01mLv+J4OM8kzTVIk1qKukDRW4rRaxP7Y56nFQq727Jk2LBz2B
 M0jupNm7xbc11Dms0sxhv1g3L/jlzTurC20pvTeRESjgy5OnfVm5zw8kldRIDGi+opzSnzX
 6HEJ5waaZxiGPJnZ/VLsJBSMqHFEWv5EJuqTN0dEP37uYgub557+xkwRq7bVoHK43XrXs2j
 vwUeWi8QgFx4UvHV5a1FQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fCmOW3xCPjo=;G1jCWus0HsFl7dn8h7iim2hSbUE
 WH/BeejMUa9tuiyJJ1OU8pJcY5GNYmRROutf6Rr5iO5cZGstUJ/965FfTayPtSMGK6Z/zRrh5
 FBpm83J4szzgqxTifUrUX+4MNbnKA1RYbyVstwXcghvY9dDZPyGEf4fJTev0R/cqNOeYsf/NU
 q88JmXMlmnrZD3q8ufo8E99aZp+ebidbqT67fGiIP/Gk21cjIH2ebyIIfIdp+G92iZBdWlyFG
 BpTRI6SBSu/wXlbiRBaeNtSl0i0TM2j8impijAvX/HFLltO71Bu/r7iXVaHZQX+RiB6+JEfJQ
 XvDUzsy6tpLYdwcLK5OPZ3ZSEewURe+7VqlZ4WivCBuzSpuUs1qc7EUMwKw/5UDE1RZ5+w7pb
 RF6iQvDPhxgyufckBwvX9ki3efldehf+4KNb+CN80baeoqvo+LOWVePcV/afb7Adif2dq2BHf
 RMqRHAmx0TicsYKvKkJWGR+nIoDviIQ7O8ifzViFgKr4iu4I26XTjdnhxc51RHeo69qUplKON
 vsSyOVS8I5UT9C2PZeo8rTcZDheXUioEDh9ppMlAOQHbUt1CV80omHestsDpFA/3sLA31NKFk
 TU1yFGzudDa/EOZeJ8xscMSpxk4CEpdhgenIadZIJSN/fpYyxz1Gpqc/QmLroEaVn173+gFqh
 f2fYuoXhZ1lYW7GmY8FPQXdWUKazg5IgVvV4w5LwaTleqn2AM/a46uJFhG6LcHp6ti3su8MTD
 1tfsd61nZ9Xque/nEfgMnmeF0GN8h54RG5mNetnvVmDRvysy6mzEB0dflOaDiPhYul2Kco3jV
 w2hMTTevmfYVK2RUTzmq6Aj1gFyBVlzQsgZ7VKgE/4/Ug=



=E5=9C=A8 2024/8/6 20:35, Hanabishi =E5=86=99=E9=81=93:
> On 8/6/24 10:42, Qu Wenruo wrote:
>
>> Too low values means kernel will trigger dirty writeback aggressively, =
I
>> believe for all extent based file systems (ext4/xfs/btrfs etc), it woul=
d
>> cause a huge waste of metadata, due to the huge amount of small extents=
.
>>
>> So yes, that setting is the cause, although it will reduce the memory
>> used by page cache (it still counts as memory pressure), but the cost i=
s
>> more fragmented extents and overall worse fs performance and possibly
>> more wear on NAND based storage.
>
> Thanks for explanation. I'm aware of low dirty page cache performance
> tradeoffs, I prefer more reliability in case of system failure / power
> outage.
> But that rises questions anyway.
>
> 1. Why are files ok initially regardless of page cache size? It only
> blows up with explicit run of the defragment command. And I didn't face
> anything similar with other filesystems either.

Because btrfs merges extents that are physically adjacent at fiemap time.

Especially if you go fallocate, then the initial write are ensured to
land in that preallocated range.
Although they may be split into many small extents, they are still
physically adjacent.

When defrag happens, it triggers data COW, and screw up everything.

>
> 2. How I get my space back without deleting the files? Even if I crank
> up the page cache amount and then defragment "properly", it doesn't
> reclaim the actual space back.
>
> # btrfs filesystem defragment mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
>
> # compsize mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
> Processed 1 file, 3 regular extents (3 refs), 0 inline.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=
49M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 449M=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 449M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 449M=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 224M
>
> There are 3 extents, it's defenitely not a metadata overhead.

I'm not sure how high the value you set, but at least please do
everything with default kernel config, not just crank the settings up.

And have you tried sync before compsize/fiemap?

If you still have problems reclaiming the space, please provide the
fiemap output (before defrag, and after defrag and sync)

>
> 3. Regardless of settings, what if users do end up in low memory
> conditions for some reason? It's not an uncommon scenario.
> You end up with Btrfs borking your disk space. In my opinion it looks
> like a bug and should not happen.
>

If we try to lock the defrag range, to ensure them to land in a larger
extent, I'm 100% sure MM guys won't be happy, it's blocking the most
common way to reclaim memory.

By that method we're only going to exhaust the system memory at the
worst timing.


IIRC it's already in the document, although not that clear:

   The value is only advisory and the final size of the extents may
   differ, depending on the state of the free space and fragmentation or
   other internal logic.

To be honest, defrag is not recommended for modern extent based file
systems already, thus there is no longer a common and good example to
follow.

And for COW file systems, along with btrfs' specific bookend behavior,
it brings a new level of complexity.

So overall, if you're not sure what the defrag internal logic is, nor
have a clear problem you want to solve, do not defrag.

Thanks,
Qu

