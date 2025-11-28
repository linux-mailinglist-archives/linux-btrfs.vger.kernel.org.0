Return-Path: <linux-btrfs+bounces-19424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077EC934E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 00:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8B7434B98B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFC2EC0A3;
	Fri, 28 Nov 2025 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U/hj7Uc7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB1134AB;
	Fri, 28 Nov 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764374361; cv=none; b=LocpcRugJ+9Pq68RAt0HSkB9hqtV3/M50WOCndHUpIAAHmAnIYG4LcaBX0anVmYLYxd1z8r90OvLAPz9YBuqF2Qe7Wvd8QPEX9S7kIQLEFqDwDV1VjHU4itsG9Uc6eD90oXV3tmn3xc7sZ9apIGYArjSzLS11W8RDaP1KTQ8XiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764374361; c=relaxed/simple;
	bh=jiddtCAuGP07WXLgz3My9gzZ4suhZlS1fe6Bnrv+wSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyDOgWqQ7RG19u/9/8L8OxNcslnmcugrmRDg5yOruRkYXWHk3OsmL1gLv1MwShIycMyCXnx+RHe4AxplBP1SP2z2cglmeiiBNAba3FxYG7VoGCmV9JrGZYRKVZcXArxvyFAwkKl1Yjmgt4oTcr7IsDkuEteXyZ0/0tddCusQpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U/hj7Uc7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764374353; x=1764979153; i=quwenruo.btrfs@gmx.com;
	bh=FJlsWOp36mz4gwIG6RL6BE1f/FZw/sPuFCRuiDLScy8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U/hj7Uc74xQUN3Evsf7Y2pdnmu3GbfZ9niIYdGmHSI7K8BN3i8ACBUn+n8zpdRrg
	 WorC/dPHw3bPAkzVLGmcBap/oA29egXZebPpI7Mh4nle6ygSbtqJ32nq+BBTP6trc
	 isXHZXTX5XsWTc1yxf5zs/sMDJh/oys7JWSW63CG6ob7YEGRa4goUrnUFMWWE0eme
	 GssQvUoaQ3J/g/jJkCVeli6tpKsdkgARdOBnKCNp8XHTuV0CRm9YRnQJuqz437Z2v
	 ws6MEIt4jjhoULAH3x97wSjXUbNXFf3aiOuIyJyaTDvsXck11LW09cTOKI5vhkGOR
	 bQDyL2l4UF1MLwQ8Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1vgFVq2aJe-00Hvhg; Sat, 29
 Nov 2025 00:59:13 +0100
Message-ID: <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
Date: Sat, 29 Nov 2025 10:29:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Qu Wenruo <wqu@suse.com>
Cc: clm@fb.com, dsterba@suse.com, terrelln@fb.com,
 herbert@gondor.apana.org.au, linux-btrfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com, cyan@meta.com,
 brian.will@intel.com, weigang.li@intel.com, senozhatsky@chromium.org
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
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
In-Reply-To: <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:72jzWlpzY44M6PjMNf3+BXTNKnLOT3dbNtvVcVur4UTUwCgdFzT
 sRWYqtuGcB4wPQkSDbzEOmI/ffIZzGvrBWp/H8RrcQ1We6pGiFnb7J76isRJt1qC0KgHsZY
 HsytlHJlSLuQWrE8ei9syNkMKoX79nekmLknmNXZ/ygwMbB6+PCq4QIw2gGrMgz+3ETdXPX
 sN88L24ugDFc5rS1IIxAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ay5Ez5HlhI8=;5N15ilHyzps/TWgul10K9dtEhzB
 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



=E5=9C=A8 2025/11/29 09:10, Giovanni Cabiddu =E5=86=99=E9=81=93:
> Thanks for your feedback, Qu Wenruo.
>=20
> On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
[...]
>> Not an compression/crypto expert, thus just comment on the btrfs part.
>>
>> sysfs is not a good long-term solution. Since it's already behind
>> experiemental flags, you can just enable it unconditionally (with prope=
r
>> checks of-course).
> The reason for introducing a sysfs attribute is to allow disabling the
> feature to be able to unload the QAT driver or to assign a QAT device to
> user space for example to QATlib or DPDK.
>=20
> In the initial implementation, there was no sysfs switch because the
> acomp tfm was allocated in the data path. With the current design,
> where the tfm is allocated in the workspace, the driver remains
> permanently in use.
>=20
> Is there any other alternative to a sysfs attribute to dynamically
> enable/disable this feature?

For all needed compression algorithm modules are loaded at btrfs module=20
load time (not mount time), thus I was expecting the driver being there=20
until the btrfs module is removed from kernel.

This is a completely new use case. Have no good idea on this at all.=20
Never expected an accelerated algorithm would even get removed halfway.

[...]
>>
>> This function get all input/output folios in a batch, but ubifs, which =
also
>> uses acomp for compression, seems to only compress one page one time
>> (ubifs_compress_folio()).
>>
>> I'm wondering what's preventing us from doing the existing folio-by-fol=
io
>> compression.
>> Is the batch folio acquiring just for performance or something else?
> There are a few reasons for using batch folio processing instead of
> folio-by-folio compression:
>=20
> * Performance: for a hardware accelerator like QAT, it is more efficient=
 to
>    process a larger chunk of data in a single request rather than issuin=
g
>    multiple small requests. (BTW, it would be even better if we could ba=
tch
>    multiple requests and run them asynchronously!)
>=20
> * API limitations: The current acomp interface is stateless. Supporting
>    folio-by-folio compression with proper streaming would require change=
s
>    to introduce a stateful API.

BTW, is there any extra benefit of using acomp interface (independent of=
=20
QAT acceleration)?

If so we may consider experiment with it first and migrate btrfs to that=
=20
interface step by step, and making extra accelerated algorithms easier=20
to implement.

[...]
>=20
>>
>> [...]
>>> @@ -418,6 +468,20 @@ int zstd_compress_folios(struct list_head *ws, st=
ruct btrfs_inode *inode,
>>>    	unsigned long max_out =3D nr_dest_folios * min_folio_size;
>>>    	unsigned int cur_len;
>>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>>> +	if (workspace->acomp_ws && len >=3D 2048) {
>>
>> And why zstd has a different threshold compared to zlib?
> These thresholds vary by algorithm, device, and compression level.
> I tried to generalize them. For ZSTD on QAT GEN4, for example, QAT only
> implements part of the algorithm. The remaining steps are handled in
> software via the ZSTD library. This makes the offload threshold
> different compared to zlib where the algorithm is completely executed in
> HW.
>=20
> That is why I asked in the cover letter whether it would make sense to
> expose these thresholds through acomp. The concern is that I don=E2=80=
=99t want
> to waste cycles converting folios to scatterlists only to discover that
> software compression would have been more efficient.

At least for btrfs' use case, the threshold is so small that it only=20
makes a difference for inlined extents (the inline threshold is=20
configurable at mount time, by default it's 2K, max to fs block size=20
normally 4K).

Considering how small the inline extent is already, you may want to only=
=20
focus on multi-block compression, and use a single threshold (fs block=20
size) inside btrfs.

Thanks,
Qu

>=20
> Thanks,
>=20


