Return-Path: <linux-btrfs+bounces-19470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7DC9CEFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 21:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4797A3491F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC52EA158;
	Tue,  2 Dec 2025 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eL85cgzZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47E2E9757;
	Tue,  2 Dec 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707951; cv=none; b=OwSGGaXyFcD7XOkbWwessbJ11YSNuyqIhJTXGGQ795uGbsT0dWvsTEYMIYq292oFS7d0ysX2sbsRnVawRLDquFn8evxfSfrIY7gGmjziHh0oiD1Hd1sSs/jmQI0xPKH+MFF2OPfCSKN/6lYqV6uTrkMw0PnodXR5Bq5FT8bzPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707951; c=relaxed/simple;
	bh=NZrboX02c3lMkJzOfSynj7Wc1xX3TEZsz08dobDabbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lw+avdU6+g5fu5vO75g8+ypcdg19ygBRQt0vLLLzbrK9d3eWFbotizdc8E8UNtPd0ljx4ngFJKwway8eSE41TkioUq0zPBdFSnsT2ErUb9vE0S+nmayb1Pw2aR2mAgZfJ7W6Rwzcfc6rGKV22aTXgTkl5F8KHCNE7oC3ct9JsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eL85cgzZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764707939; x=1765312739; i=quwenruo.btrfs@gmx.com;
	bh=KfeBjtB9IxGOP9UOfr3+FgAhTgowaYjJwRmO+D6B+cU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eL85cgzZ1doJQpgJPKvpaCPON41VpV4zZy6kl8mF3g8LHAzihb31osOnmI1oJpQa
	 HS6r0jIFdZUhrvU2siTGS7ufThUTttbwS82tkz0xHKClkJrD2JV6STbV+d9Stg9g4
	 9NYBN3ZbNR1YtgmYDqBzaiXnByxddcda+thkS22uvCtbO/Xadt7B0mVS4UMBVYeO6
	 b63EomWzyqlOLodm/aTp9HzWZNqomWT6hjkoURdtZhFe9BUi96MGtCwziwDgMLOHg
	 YnN5ysSGDIuyhh21Pq4hKJYRhH2GNWYTtnqlwxKrlrj/a3qZERoX3K5xcNiZaInZU
	 gEHaQfQgM9Iztv+UZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1vZ1Zj2iiP-00I3Il; Tue, 02
 Dec 2025 21:38:59 +0100
Message-ID: <0bd22b17-97e8-4b8f-a7a5-5e79d280c078@gmx.com>
Date: Wed, 3 Dec 2025 07:08:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: dsterba@suse.com, herbert@gondor.apana.org.au, Qu Wenruo <wqu@suse.com>,
 clm@fb.com, terrelln@fb.com, linux-btrfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com, cyan@meta.com,
 brian.will@intel.com, weigang.li@intel.com, senozhatsky@chromium.org
References: <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
 <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
 <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
 <aS4UNIfxGK0y6HzO@gcabiddu-mobl.ger.corp.intel.com>
 <e532ff5c-a5a6-4ebf-977a-721471594908@gmx.com>
 <aS8dNt3gCzlIxBIs@gcabiddu-mobl.ger.corp.intel.com>
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
In-Reply-To: <aS8dNt3gCzlIxBIs@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q5juGEsjCki/jjiRsmMFFBxxrh+5jIWfwwpfkpuCJnz2KN+MtWU
 EzIokNtgT+FuXb2MuRL2MyI0QNPjm9v1RFCu34jrziPGYMDl+YDSU20Sf26sFhfXJaZv0Nl
 AO4Eq07C/mq3e/3eOKmj/ms3OSJeSkT3RmUndPKwe6IQDKVxGd7wQPwcAeSoL0e8EdF0KeO
 FFF5N6suPzQvLmZ/nMwLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4bUB3LHDMKc=;CVLizcnYfvVQp3I8Xl/nyJSBV9c
 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
 dfq7fZH8=



=E5=9C=A8 2025/12/3 03:39, Giovanni Cabiddu =E5=86=99=E9=81=93:
> On Tue, Dec 02, 2025 at 09:43:24AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/12/2 08:48, Giovanni Cabiddu =E5=86=99=E9=81=93:
>>> On Tue, Dec 02, 2025 at 07:27:18AM +1030, Qu Wenruo wrote:
>> [...]
>>>>> Here is what happens:
>>>>> 1. The acomp tfm is allocated as part of the compression workspace.
>>>>
>>>> Not an expert on crypto, but I guess acomp is not able to really dyna=
mically
>>>> queue the workload into different implementations, but has to determi=
ne it
>>>> at workspace allocation time due to the differences in
>>>> tfm/buffersize/scatter list size?
>>> Correct. There isn't an intermediate layer that can enqueue to a
>>> separate implementation. The enqueue to a separate implementation can =
be
>>> done in a specific implementation. The QAT driver does that to impleme=
nt
>>> a fallback to software.
>>>
>>>> This may be unrealistic, but is it even feasible to hide QAT behind g=
eneric
>>>> acomp decompress/compress algorithm names.
>>>> Then only queue the workload to QAT devices when it's available?
>>> That is possible. It is possible to specify a generic algorithm name t=
o
>>> crypto_alloc_acomp() and the implementation that has the highest
>>> priority will be selected.
>>
>> I think it will be the best solution, and the most transparent one.
>>
>>>
>>>> Just like that we have several different implementation for RAID6 and=
 can
>>>> select at module load time, but more dynamically in this case.
>>>>
>>>> With runtime workload delivery, the removal of QAT device can be pret=
ty
>>>> generic and transparent. Just mark the QAT device unavailable for new
>>>> workload, and wait for any existing workload to finish.
>>>>
>>>> And this also makes btrfs part easier to implement, just add acomp in=
terface
>>>> support, no special handling for QAT and acomp will select the best
>>>> implementation for us.
>>>>
>>>> But for sure, this is just some wild idea from an uneducated non-cryp=
to guy.
>>>
>>> I'm trying to better understand the concern:
>>>
>>> Is the issue that QAT specific details are leaking into BTRFS?
>>> Or that we currently have two APIs performing similar functions being
>>> called (acomp and the sw libs)?
>>>
>>> If it is the first case, the only QAT-related details exposed are:
>>>
>>>    * Offload threshold =E2=80=93 This can be hidden inside the impleme=
ntation of
>>>      crypto_acomp_compress/decompress() in the QAT driver or exposed a=
s a
>>>      tfm attribute (that would be my preference), so we can decide ear=
ly
>>>      whether offloading makes sense without going throught the convers=
ions
>>>      between folios and scatterlists
>>
>> This part is fine, the practical threshold will be larger than 1024 and=
 2048
>> anyway.
>>
>>>
>>>    * QAT implementation names, i.e.:
>>>          static const char *zlib_acomp_alg_name =3D "qat_zlib_deflate"=
;
>>>          static const char *zstd_acomp_alg_name =3D "qat_zstd";
>>>      We can use the generic names instead. If the returned implementat=
ion is
>>>      software, we simply ignore it. This way we will enable all the de=
vices
>>>      that implement the acomp API, not only QAT. However, the risk is =
testing.
>>>      I won't be able to test such devices...
>>
>> This is only a minor part of the concern.
>>
>> The other is the removal of QAT, which is implemented as a per-fs inter=
face
>> and fully exposed to btrfs.
>> And that's really the only blockage to me.
>>
>> If QAT is the first one doing this, would there be another drive
>> implementing the same interface for its removal in the future?
>> To me this doesn't look to scale.
>=20
> I should have explained this better.
>=20
> The switch is not QAT specific:
>=20
>      /sys/fs/btrfs/<UUID>/offload_compress
>=20
> It does not require any other compression engine that plugs into the
> acomp framework to implement anything.
>=20
> Here's how it works:
>=20
>    * If `offload_compress` is enabled, an acomp tfm is allocated. The tf=
m
>      allocation in the algorithm implementation typically increments the
>      reference count on the driver that provides the algorithm. At this
>      point, the hardware implementation of the algorithm is selected.
>      Compression/decompression is done through the acomp APIs.
>=20
>    * If `offload_compress` is disabled, the acomp tfms in the workspace =
are
>      freed, and the software libraries are used instead.
>=20
> So there is nothing QAT specific here. The mechanism is generic.

But only QAT requires this, a "generic" mechanism only for QAT.

>=20
> Have a look at the code, it is pretty straightforward :-).
>=20
> Hopefully this clarifies.
>=20
> Thanks,
>=20


