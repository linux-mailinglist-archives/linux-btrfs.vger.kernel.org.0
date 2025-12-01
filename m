Return-Path: <linux-btrfs+bounces-19441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD2C998DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 00:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9785345EDE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61D29C321;
	Mon,  1 Dec 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MTIUJFEm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6A288514;
	Mon,  1 Dec 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630817; cv=none; b=iwzJ8HvnlfldBzEZtVsH/M3VyaQJEbGYAlSt+oBJyXd0NwUHy67LGDbG54zhveNCVfdQdfRwSMNYzyUOwmmemCBVzQF4b8wnzKJkDWLC7bsqwubYFF+WdxOQR/fe8flReDotdFeigmjZ1F0fYxrkn/y7CU9Zl9ohmzdYTR5CkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630817; c=relaxed/simple;
	bh=KdcmjWdxyYh1fN12xsOv0xv4JKHOmBBEXI4SGd7pN/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTpEa2vmgejb0+n9X3OFZOYYPYMTbvcXqDUI1DnUaLPZt59lqNqIcxjqrY9M6YqrDn8fkk4l7DEPUv+Pz59Cj5TypJh8IZYpJBEKixiGZo675Y12kHlhPr7Gy6eG+Z21lumBgu6Efa8y7uuZlwjIX5X4PnwjVTmLbC56Kbmz2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MTIUJFEm; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764630812; x=1765235612; i=quwenruo.btrfs@gmx.com;
	bh=DtBx52lwcA1ySQk3W33ssbuLMeHTKJW7lOhIgqQmTek=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MTIUJFEmch0kahGPvHN/QYRrxtWYFeqtfaTH20p6aEuAMuhOz9/0Jh37hSgOKEzg
	 m1yhDf5XRPdalKPCZdMpioV/JwJSoOL/2FFszMN6l6c8BMJvgQFsPnGGNAHRx0RNJ
	 CH31MS2RA3mMPPoNi1qWCDBA01Uzk5fsHfkAf1scDmUbLOgsIInHu3dtX5g5GERBs
	 T+elRITG8F7hsHMMZTKL7Xtw4wPwoMnr0pd4+AMtYqXeBRdnbqhqmmGm2HTsW8exq
	 zAnpUo87r0iCo6Xs7unwjUYWwTl48IdkIoxrtI7RYEfde84Rldsj6tbnPb1BKzzs2
	 ILg5qtq4VPzuh8EK0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6m4-1vnQQR2srE-00cbro; Tue, 02
 Dec 2025 00:13:32 +0100
Message-ID: <e532ff5c-a5a6-4ebf-977a-721471594908@gmx.com>
Date: Tue, 2 Dec 2025 09:43:24 +1030
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
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
 <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
 <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
 <aS4UNIfxGK0y6HzO@gcabiddu-mobl.ger.corp.intel.com>
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
In-Reply-To: <aS4UNIfxGK0y6HzO@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UnGX1S1Ou2WNV/ggnLUmTcJwSqz6q4TgL7AJCnZM7A1FS65wdBW
 qgdghu5HQgTElZS4A/KsEVzEY/MI3JBjtMOKz7dGG6Rgx9XonzuoDE7P28xNu2UMU75i9gH
 9mC2obwqBLx0sVo+DQ37hsTvMneapfIaX6RRo2B6pujSso3UMf9cFWdSYTwpKjrShQ/AWih
 AIwH7S1t/TWtIUwUnx5Zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZmYhYL+sVCw=;CthVR2oailmNmSwQ31EW2MThlHJ
 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
 fbe1/zJdHfvTqYPS9Z2zCo9SRXKt7cpVdHRdwm



=E5=9C=A8 2025/12/2 08:48, Giovanni Cabiddu =E5=86=99=E9=81=93:
> On Tue, Dec 02, 2025 at 07:27:18AM +1030, Qu Wenruo wrote:
[...]
>>> Here is what happens:
>>> 1. The acomp tfm is allocated as part of the compression workspace.
>>
>> Not an expert on crypto, but I guess acomp is not able to really dynami=
cally
>> queue the workload into different implementations, but has to determine=
 it
>> at workspace allocation time due to the differences in
>> tfm/buffersize/scatter list size?
> Correct. There isn't an intermediate layer that can enqueue to a
> separate implementation. The enqueue to a separate implementation can be
> done in a specific implementation. The QAT driver does that to implement
> a fallback to software.
>=20
>> This may be unrealistic, but is it even feasible to hide QAT behind gen=
eric
>> acomp decompress/compress algorithm names.
>> Then only queue the workload to QAT devices when it's available?
> That is possible. It is possible to specify a generic algorithm name to
> crypto_alloc_acomp() and the implementation that has the highest
> priority will be selected.

I think it will be the best solution, and the most transparent one.

>=20
>> Just like that we have several different implementation for RAID6 and c=
an
>> select at module load time, but more dynamically in this case.
>>
>> With runtime workload delivery, the removal of QAT device can be pretty
>> generic and transparent. Just mark the QAT device unavailable for new
>> workload, and wait for any existing workload to finish.
>>
>> And this also makes btrfs part easier to implement, just add acomp inte=
rface
>> support, no special handling for QAT and acomp will select the best
>> implementation for us.
>>
>> But for sure, this is just some wild idea from an uneducated non-crypto=
 guy.
>=20
> I'm trying to better understand the concern:
>=20
> Is the issue that QAT specific details are leaking into BTRFS?
> Or that we currently have two APIs performing similar functions being
> called (acomp and the sw libs)?
>=20
> If it is the first case, the only QAT-related details exposed are:
>=20
>   * Offload threshold =E2=80=93 This can be hidden inside the implementa=
tion of
>     crypto_acomp_compress/decompress() in the QAT driver or exposed as a
>     tfm attribute (that would be my preference), so we can decide early
>     whether offloading makes sense without going throught the conversion=
s
>     between folios and scatterlists

This part is fine, the practical threshold will be larger than 1024 and=20
2048 anyway.

>=20
>   * QAT implementation names, i.e.:
>         static const char *zlib_acomp_alg_name =3D "qat_zlib_deflate";
>         static const char *zstd_acomp_alg_name =3D "qat_zstd";
>     We can use the generic names instead. If the returned implementation=
 is
>     software, we simply ignore it. This way we will enable all the devic=
es
>     that implement the acomp API, not only QAT. However, the risk is tes=
ting.
>     I won't be able to test such devices...

This is only a minor part of the concern.

The other is the removal of QAT, which is implemented as a per-fs=20
interface and fully exposed to btrfs.
And that's really the only blockage to me.

If QAT is the first one doing this, would there be another drive=20
implementing the same interface for its removal in the future?
To me this doesn't look to scale.


And that also looks like a layer violation, exporting low-level crypto=20
details into a fs, which shouldn't really care about the fast=20
implementation or the details on how to remove a QAT device.

Thus I really want to follow the RAID6 scheme, let RAID6 module to=20
select the fastest one, btrfs just use the provide interface.
(And add the missing part of dynamically remove one implementation at=20
runtime)


I understand your concern related to the QAT device removal, but=20
considering the layer separation, QAT device removal would be better to=20
be handled inside acomp layer, so that not every QAT user needs to=20
implement a kill switch.

Considering acomp is never designed with such runtime workload delivery,=
=20
this may be too much to ask though.

>=20
> Beyond that, the BTRFS/acomp code can use a software backend without any
> changes.
>=20
> If the concern is about having two APIs, we could remove direct calls to
> the software libraries and rely only on acomp.

That's not a huge deal, at least not to me.

I'm fine to have acomp interface with the existing interface, as long as=
=20
it provides better performance.

Thanks,
Qu

> One option might be to
> allocate two tfms in the workspace, one for software and one for the
> accelerator, since the software names are stable and hardcoded, and
> perform the switch.  However, the trend in the kernel nowadays is to
> prefer direct calls to the libraries, rather than going through the
> crypto layer.  That said, I still need a mechanism to indicate when the
> accelerator should not be used. (BTW, I saw David's email confirming
> that using sysfs for this is acceptable.)
>=20
> Thanks,
>=20


