Return-Path: <linux-btrfs+bounces-19425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A703C934FF
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 01:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39D474E0732
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 00:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435116F288;
	Sat, 29 Nov 2025 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AZrZQ31y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446C33E7;
	Sat, 29 Nov 2025 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764375840; cv=none; b=BWNV9rdO8elMT1/iuQ9r3uqe6932ohqhY5Fmo0tlSQIt6BXGFZQkItNSUxZz+hGxEGhdhF6BmQklY048zogtWnFHgkI5ZYBglv0oMGE6VWfWt3RmPc0v/CD46RVuCPhT17aOjrZcrkdLzdDdTfzAxjX+5uSwvHD6+TKv6s0uDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764375840; c=relaxed/simple;
	bh=ZBnxUHD3MbNLP6Qs7FzTOgt2tgEwDyGBs41DnxBTmqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqaEYbN6AHJUZYUqlUlnAqfU9rHFCprNuuDM1o+jQX3B4tPNSjawthpry63jQIrK/VwmOGwdmVlW4edeaVsMlKcH6hubfPSFiTFtSEn/BlaobwVhEKvoYAg3HSzQrmGoln68wKVFlRAeODZhISoLlxUf70lgCiNKzLfDf6XSSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AZrZQ31y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764375791; x=1764980591; i=quwenruo.btrfs@gmx.com;
	bh=ZBnxUHD3MbNLP6Qs7FzTOgt2tgEwDyGBs41DnxBTmqY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AZrZQ31yrhRtS4xYu+wFMCADl/RcKiTtBtEyKhgAamzFSFGuhkbF5cV4DbOFtyVo
	 pv84bPH9yMBm34W2qVWJgvRNvQVnnYP5yJxw6XfUB/2ddxXqguCQ/duk9YcEL/n5+
	 01VZvR1q02KTNxVtvQwI4vB2PgDw6LLOdAE+v3RvrijxOLBwDbc2fxYtI3bg3lIcT
	 cG4kRxTx1sPR5E3E3Fv+AW8PU9O1p4BswSrjXtiCs5I7Cqsw6WFgwRs8R34RvsvqD
	 0tdlv1KfBLNYoGgGUVTgMHDgCKseWhb37FF/C8BGDhxWLcZaqMZ4tfxg5qxzpfHZH
	 FGZXZi1YNBtf/zAoyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1vwXgN1cWv-00nilV; Sat, 29
 Nov 2025 01:23:11 +0100
Message-ID: <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
Date: Sat, 29 Nov 2025 10:53:02 +1030
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
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
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
In-Reply-To: <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bUl1Tf70b/OK1rJIIGVcn+kjqVkSkVUFSg9NEWJ+6BmMZJwLNJK
 yHq3SrGjHFW4gj4syFwPXWlToYy8g6Lg2s/biTEZZaxp+ujsSuICUbzZYGrGfu6feK3EHIB
 rNsycaDa9MLbmIJ3tAQHfKShJFdOWRoi4r38s3uElf000Pe9982JVkYDFp9qHa/5dy9Me2m
 sVlEUL/mnkXV22vwvEV2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UBAIWyPJzis=;USTvca0svcElCIyyX9UJAtHopci
 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
 zC6srfe1DEFDmHnoc=



=E5=9C=A8 2025/11/29 10:29, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/11/29 09:10, Giovanni Cabiddu =E5=86=99=E9=81=93:
>> Thanks for your feedback, Qu Wenruo.
>>
>> On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
> [...]
>>> Not an compression/crypto expert, thus just comment on the btrfs part.
>>>
>>> sysfs is not a good long-term solution. Since it's already behind
>>> experiemental flags, you can just enable it unconditionally (with prop=
er
>>> checks of-course).
>> The reason for introducing a sysfs attribute is to allow disabling the
>> feature to be able to unload the QAT driver or to assign a QAT device t=
o
>> user space for example to QATlib or DPDK.
>>
>> In the initial implementation, there was no sysfs switch because the
>> acomp tfm was allocated in the data path. With the current design,
>> where the tfm is allocated in the workspace, the driver remains
>> permanently in use.
>>
>> Is there any other alternative to a sysfs attribute to dynamically
>> enable/disable this feature?
>=20
> For all needed compression algorithm modules are loaded at btrfs module=
=20
> load time (not mount time), thus I was expecting the driver being there=
=20
> until the btrfs module is removed from kernel.
>=20
> This is a completely new use case. Have no good idea on this at all.=20
> Never expected an accelerated algorithm would even get removed halfway.

Personally speaking, I'd prefer the acomp API/internals to handle those=20
hardware acceleration algorithms selection.

If every fs type utilizes this new accelerated path needs an interface=20
to disable QAT acceleration, it doesn't look sane that one has to toggle=
=20
every involved fs type to disable QAT acceleration.

Thus hiding the accelerated details behind common acomp API looks more san=
e.

Thanks,
Qu


