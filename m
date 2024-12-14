Return-Path: <linux-btrfs+bounces-10380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1059F20EA
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 22:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064021886053
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F211B0F07;
	Sat, 14 Dec 2024 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PQsxKbHj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA578C6D
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734210849; cv=none; b=IOw79kkjGVGbGzxJV4ft3piPiT63sps3TaNn893B+8/TO1xCo42/mPmpGKJwJzDZ8yK61GGoFJTouFrMvzkTsA0K0MmIwdG92UChPp/k9izw/ADynqDuR2js9gGAlHcpm9Vv1o2SuUKexFKlOVKkbSzn8j07oSg1DTdb6g+x7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734210849; c=relaxed/simple;
	bh=gIdw7B2ilmkBvi/4aYZfDpcdhkA14emCZQ6f6C5XC1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HBcAql1BbAVJJ8NQzGhu+2W80Jx8nJOs4AAy8KS3pYLa1j3E+NnDmuP4Vu4bKxxavrrr2rZZmoKxmFIDszwC7xe4JfvifOjmmocqv1Cdcme/U3E5lOQOngQ0KcgMiL8y8pS7TPKk4hpUn5qVpUttznb3SILJqDRmKsLvlHY2als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PQsxKbHj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734210844; x=1734815644; i=quwenruo.btrfs@gmx.com;
	bh=LPiaO40FjydNTsPz4zaIhmK6P40tMG7wHfKqxdQ/Fzk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PQsxKbHjatN9wU5QLZZ/+FOHy9xqSg9aHwImtZLOZqkSkRUvonkx8sID0oWADMfa
	 qF3PbruzL+MqbK1bfPWbWIL6jr4fx6/HgfWJgQAPzWW4la2dKCDna2HXMG6i7c9On
	 iY5JMZ0l2og1FX5JbDdilH6wfOkJXMBZpcZ8FUwnAahbNzfauvK2FCstt1Pz7BbhE
	 4ckZZJcpHvr13ayTkSc8YkdZKt/HzGx1X7nSoqXxY5z13gCC5ye6AXwsvjH66Dr4d
	 yb/jgVpNUScmXnvTmMg1OBsl07Bfp6H16eo5vZ4N2t711fgzHZQvMm5lrEfB5cvcQ
	 XdT8YYS7Nsix7iA5yQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOREi-1sxk8o1mdq-00TvGz; Sat, 14
 Dec 2024 22:14:04 +0100
Message-ID: <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
Date: Sun, 15 Dec 2024 07:44:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Leszek Dubiel <leszek@dubiel.pl>, Andrei Borzenkov <arvidjaar@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
 <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
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
In-Reply-To: <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m4wmozyDlGv90Qpq+k8h+iZ6Xu7xHF1gMt2mkoV1S/Fm63yIVdg
 GO1UMYA/S6eq2a6lVQlnpaeEnzmURrqzn1b/D/6yvJ7luNVdRSFyUpu1pqIuseXyx0y93Su
 2Uq5rbDbuNfCi7HMN0wKVhYsYCkF2M1h6cgf8d3+eOZv5KTpsFkJnTX1tp+mBCu4wN1CdDL
 KhUvZPLc+JvZfVR/rVaqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WNmUdMNxlZg=;DVmdcvLc9Wm3qdhl2eC2JA/0veE
 YjhRkNVbur+TthcsQQ4Rk9KmRyzPGQFAc6o8NazbUUkg4fTrw8R0hA3Uowa5Deh9NjJrS91sa
 K8i2DyRDmJo2JxuGUnsBKtYhG/OaMTQVufkkZ78t1877EYL3xGfMA/3w90uCCKNLO6OyD0VsK
 RwVNGrtDUYEWXMLA9AQdpyybAtJrFOkrhiDSv/+XpXtzE9RSA0d/G8IcJz2ZxL9cx5KjLbTTX
 LEXbzLOUu4ANemQO/deNbyKTxtyJQGOwhvGvmhug73Hn1pcb42Re7fK4sgMmROBWp5jww6Lyp
 SFP4E54VuJfIrfvYMWvSrS1Y/0JjD/4OxVbMsY0rC6PXpPhcXmA71z7QU02HvBtYGC8ZxmLfE
 4MCHO/u0wMh6wh6t4kd1pxuZq0AGv92fbCzKVAzt7VmC7EBsIanzz+idXthzo1Ipm4AgrS6eT
 kSndHGjYdQKlqWAgMqSw2aTs8q3PRmd8Frs5YbrQ+G+hhkcQD069pR69gEpLFkPloETe8awg8
 udmVofYpmha9O+5OCoZtHKrmhkDAy99Jv2dK8BrWNisaDNFAgP8+3aZ+fA4hqynP3PQwtNyui
 cEEnoyvEWQGIJoadPFFqS+gInViaNhvNQ66ciqFfMl0b424/+XM/KvwFQw5lPS+jl3D/CO+w6
 BDLlG+Xf8sUz4JxmG94hahcojT4Hwke+7WIv63aTUvMYsNpSz0fMdBTBA8vK3HjYGy0aBRH75
 /11xgdq0ybU146ntk7y93voBcNGCseN8gTIbtt930uTF62jZOUc0E3qXsrC/7/x+3nqjpqxHW
 M2TBPXq0DDBD5ETTY8H6MGiv2xCMHheUC1u6fHweW3e2ZQXoh+X2fEXkrujW4eS9NBdU2Cxa9
 Rh1gLoIXymWjRv9INdRHQxDNWBNhxjW0rD/AgO/tItvEvRxVlPOsBpthMWcVebzuZ6j4dJ6Er
 LiC0Y/KiFmlIIc8wUomEcMd2FQsylNmMKF2EhFDhvnl2ArZ4YwI7e6NzTg9cyHXcPzLenZWlP
 EYPffQWyHJW3SIbNZEFeQEkqqu8BoR907Hs6DHmBlPAca6HPhnsADzl/AnBv1dtKZdd/+z6KQ
 e1ltAFQTVSxSAk0qCRnFOe7kRUCP/Y



=E5=9C=A8 2024/12/15 06:43, Leszek Dubiel =E5=86=99=E9=81=93:
>>
>>
>> btrfs filesystem usage -T
>>
>
> Overall:
>  =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 16.28TiB
>  =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 16.24TiB
>  =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 38.02GiB
>  =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15.75TiB
>  =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 264.00GiB=C2=A0=C2=A0=C2=A0 (min: 264.00GiB)
>  =C2=A0=C2=A0=C2=A0 Free (statfs, df):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 257.98GiB
>  =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>  =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>  =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0 (used: 160.00KiB)
>  =C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Data=C2=A0=C2=A0=C2=A0 Metadata System
> Id Path=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RAID1=C2=A0=C2=A0 RAID1=C2=A0=C2=
=A0=C2=A0 RAID1=C2=A0=C2=A0=C2=A0 Unallocated Total=C2=A0=C2=A0=C2=A0 Slac=
k
> -- --------- ------- -------- -------- ----------- -------- -----
>  =C2=A01 /dev/sdb2 5.39TiB 28.00GiB 32.00MiB=C2=A0=C2=A0=C2=A0 13.00GiB=
=C2=A0 5.43TiB=C2=A0=C2=A0=C2=A0=C2=A0 -
>  =C2=A02 /dev/sdc2 5.39TiB 20.00GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -=C2=A0=C2=A0=C2=A0 13.03GiB=C2=A0 5.43TiB=C2=A0=C2=A0=C2=A0=C2=A0 =
-
>  =C2=A03 /dev/sda3 5.38TiB 34.00GiB 32.00MiB=C2=A0=C2=A0=C2=A0 12.00GiB=
=C2=A0 5.43TiB=C2=A0=C2=A0=C2=A0=C2=A0 -
> -- --------- ------- -------- -------- ----------- -------- -----
>  =C2=A0=C2=A0 Total=C2=A0=C2=A0=C2=A0=C2=A0 8.08TiB 41.00GiB 32.00MiB=C2=
=A0=C2=A0=C2=A0 38.02GiB 16.28TiB 0.00B
>  =C2=A0=C2=A0 Used=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.84TiB 37.67GiB=C2=A0 =
1.47MiB
>
>
>
>>>
>>> But unallocated space didn't increase.
>>>
>>>
>>
>> Why did you expect it to increase? To free space balance need to pack
>> more extents into less chunks. In your case chunks are near to full
>> and extents are relatively large, so chunks simply may not have enough
>> free space to accommodate more extents. You just move extents around.
>>
>
> Ok. I didn't exactly know what chunks are compared to extents.
>
>
>
>
>
>> Relocating one chunk simply moves extents from this chunk to another
>> location. It does not free any chunk. You can only get more
>> unallocated space when you are able to pack extents from two (or more)
>> chunks into one chunk. Which is only possible if chunks are filled to
>> 50%.
>>
>
> Thank you for explanation.
>
>
>
>
>>> What should i do next?
>>
>> It looks like your filesystem is simply full. Do you have reasons to
>> believe that it is not true?
>
>
> It is backup server. It should be almost full.
> I have a procedure that:
>
> =E2=80=94 removes old snapshots if free space is less then 250 GB
> =E2=80=94 starts balancing if there is less then 8GB of unallocated spac=
e on any
> disk
>
>
> It failed now =E2=80=94 there is 258 GB free, but balancing didn't help =
to
> restore unallocated space.

Because there isn't that much free space to reclaim in the first place.

Your data and metadata chunks are already very highly utilized, you can
increase the dusage/musage and retry, but they will only bring marginal
gain if any.

The only way to go next is start deleting more
snapshots/subvolumes/files/etc.

With more data/metadata space released, then try musage/dusage again
which can free up some space.

Thanks,
Qu

