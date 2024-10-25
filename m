Return-Path: <linux-btrfs+bounces-9183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75499B118F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 23:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A381A28252C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810A1C9DC8;
	Fri, 25 Oct 2024 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Gc0TyQN4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306D217F4A
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729891085; cv=none; b=BdTIdZWaJJVNDOpN484ZXUu8lz11apUQfuV1DmLOAeSV966km9VuiZGxwbGQvwBVEM3tGhPoR6Uo9YSLSXXqxYwWDEGEFY5mOLqWSkPUx3IcxSu/21fn0LUdjrWd9ChThSyyoTyq78rgPVU4UBg87CgvzUORdR2OhvND3fQKqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729891085; c=relaxed/simple;
	bh=ieAMcqAjI8r7wDudnMfdFnrzmNDif3JGCtuaP/sBtdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfVy2zKg/RZULjiQe4BRXvDooODuQpz1V2uKdnyxbffLxNdJAYAFzNvSYW2Ho3FiwLj/JZHkuFkEdY9BAijSvoguFGZKoH2D5lo2TyZb5+GAQtcUxE4iV0kBCLOOOr+X1WDmGYv5uMbRH6S3rxWjMp4asRm3NpZ9x7+tcB7LWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Gc0TyQN4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729891074; x=1730495874; i=quwenruo.btrfs@gmx.com;
	bh=ieAMcqAjI8r7wDudnMfdFnrzmNDif3JGCtuaP/sBtdE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gc0TyQN4sFre36igxx/+MfSOWCsM0YBx7Jur/itYLLOEAyZChuzZYEbc22ifeTv3
	 ojxDflASBf5mwzerfW6K0K2TEXsB1p06uSHBlAiMHpG86DaGrWaQYuQS948J/vhtK
	 kgsG0dUT2EKAY1Q2Q1V+7Q2KxvZs92xN9709UarMZZyJInCxJO0GM5E1xYVK7f8WT
	 E7mP7lxAH4YNwTHcd+2p/nOXDD8hK33B6QMfpeuiFANi2LnLXxLE5SJkUUO7Kojef
	 ITVtOSiDEvElgfc2trPeSDwrLTdDQfrPRhQfcrKwICtr+nSFjbrobd7JmZvNRZxqL
	 NuxVBCvIx0FzKOcmOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N63Ra-1txgzJ2tXk-013Mvt; Fri, 25
 Oct 2024 23:17:54 +0200
Message-ID: <32b261ae-9b75-4da4-a883-5387ffe5bd08@gmx.com>
Date: Sat, 26 Oct 2024 07:47:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
To: Filipe Manana <fdmanana@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1729784712.git.fdmanana@suse.com>
 <49b1a5df-eefc-437a-b175-2e9532932dfe@wdc.com>
 <CAL3q7H61-kM26sNZC6rLzbv2D3ku7NQ_B+PT9-eQYLMGxuySxQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H61-kM26sNZC6rLzbv2D3ku7NQ_B+PT9-eQYLMGxuySxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CSwjpIM/nZyR5fDKSn0CONZgxmTnBGpRTStBIM8lkpdxsS4SoiO
 /UFNPKXNNG2sjtaC9JER1OpqlKKpG52QyaSO8/Bucqpxza3PaRCVj1YIn6bumXuIiA88HKa
 Uc9FceuECZtLOFN9Um8pogHXN+EkYOBre81IW+O+jB41LOqyPy62uoHGEnK6EVdt4hdv8U1
 tMxQqvSz89qLhC9CqFdow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4VVJa4KlyKw=;ZnL43N8RBDnEXLEIflrdhRGfgFR
 HWdn0gnjMFdgnra1vs5FPcrtvT8Q+byhsEGpHG8aCALJAJ17tUkZSMVEudA5/sPtPAQ55j4WH
 XcybIeSPkrE17IHv+ZW7d8l6/QqWGCfVrCywvjAmExNabd8XZIN2xGWTnlMC0WXgJsBAVKgv7
 niZL47mb+p9iK0q2v14fm4yrxutbGxtiaa7skuSA6xWKHHNBx+ReB1+ylMvG0CRBMCps3tw/7
 cuvYoz75TdYes3Lfta4+U5sXHYczwKBI1kNiQyQMn9H02/vUIeAlMjfGqGYlwGGBErEf+Uz/o
 IT761FFwVgRHeUmGMkO16jKMFbEUbhbipMYnOnyo6CQ/Uay4iW0080WF9tRABX8s08kCZA/cG
 6VWn2tunwDznlpSGt2yqdbj5snGIat3DAGQcEg4x/G5HjfolRveuBE+y6pK2xN00Uyl6+2aab
 S9iUN4q7usW4j5IT/ksD0HVl5xBdv0QkdEEhtd9S3Uk8UQEXtEEDwq+lK6SiMRz7bOHEUULZV
 fR3n09cDZKvOl4CH87SQl92vpk7Ytpx+qmr4LZTyLv1alx/agS1nvRozLkz2vsKDqMgOnlfoR
 v7H827n5KOOEJbJjL8M1kxx3WIYwjdzzDtzeRRN9E4IhDxJVr2yaZo6bekVLo7EM74xCxwwhM
 4dP7pfq5nfDogHKsxnoDU5F3aqKosDE9rVWmT/YOrDz8kRPIUeq8ZBtmbu/m5z6Ry5fa+pfMg
 gLi1JKRjWE20fwPMmxmpupz0G9nXctFG/Z7jNKTX1ay7rf352+J364931bH03s9zixnXweeMM
 KD6vfNaC90cTTqNNbjvJ0gvw==



=E5=9C=A8 2024/10/26 00:05, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Oct 25, 2024 at 2:19=E2=80=AFPM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
>>
>> On 24.10.24 18:24, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> This converts the rb-tree that tracks delayed ref heads into an xarray=
,
>>> reducing memory used by delayed ref heads and making it more efficient
>>> to add/remove/find delayed ref heads. The rest are mostly cleanups and
>>> refactorings, removing some dead code, deduplicating code, move code
>>> around, etc. More details in the changelogs.
>>
>> Stupid question (and by that I literally mean, it's a stupid question, =
I
>> have no idea): looking at other places where we're heavily relying on
>> rb-trees is ordered-extents. Would it make sense to move them over to
>> xarrays as well?
>
> For ordered extents I wouldn't consider it, because I don't think it's
> common to have thousands of them per inode.
> Same for delayed refs inside a delayed ref head for example.
> For delayed ref heads, for every cow operation we get one to delete
> the old extent and another one for the new extent, so these can easily
> be thousands even for small filesystems with moderate and even low
> workloads.
>
> It may still be worth just to reduce structure sizes and memory usage,
> though it would have to be analyzed on a case by case basis.
>

Another question related to this is, if we switch ordered extent or
extent map to XArray, how do we find such structure that covers a bytenr?

For delayed ref and extent buffer (which uses radix tree) we are working
with the exact bytenr, but for OE/EM we do a lot of search using a bytenr.

Or do I miss some XArray feature that can do that?

Thanks,
Qu

