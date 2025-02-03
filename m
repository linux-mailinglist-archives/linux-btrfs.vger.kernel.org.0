Return-Path: <linux-btrfs+bounces-11219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC9A25240
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 07:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96C818841D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 06:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D971C54AA;
	Mon,  3 Feb 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="q8h7OPWl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89A10FD
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738563190; cv=none; b=kuF6xsa2Y6tJrQ/S8mtQeFmkRM0dBC9CXIk3LuE2wx14bOZNxFKGKSfBH7d/ND7AV3nEqVVu8COL83Pi1xyHDVqZ0C6pxwbJ/RWAl78zKxlHBvm8i+bYWEAVCrRvcoyTQnkvqywC4t53YAu0JCKkgqdrSWvjjbFuJAagYTCKbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738563190; c=relaxed/simple;
	bh=RMcCwqSkLKyQfiKGEAxWm/CSWyTWzeP6tpIiC4kf0ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mfnrmu1Dm3K0UbmXI5aybxvupzTlijMed5mHw0tw8IoBn6ZbxDxGPN4x47UMQUI6Phbe4EmzQhxxhQZTinf2/CT+zyaV/xdSoxGYxPj9zPar7uR95RFFP8K4S6ROqjFLoSdjK56UycUtunHRBLjqtgqnBxH+YpY7xb17aEj2Z8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=q8h7OPWl; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738563186; x=1739167986; i=quwenruo.btrfs@gmx.com;
	bh=RMcCwqSkLKyQfiKGEAxWm/CSWyTWzeP6tpIiC4kf0ro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q8h7OPWlowj2SMEZqcQl+Gl71yJMdpVH9TJ7HdEg2ZXSQ5RVMaZ3KKcWxrHVT10D
	 KNqjMEd1TKkyIeUCNnC61crO0XYhS0LroXLK5E96EsJh0B5eBNycXeAmd+uE+qOT9
	 UF/mOG5jZgXXqxj+w7QKKs+xDsJb+gWGWO4CuvK5GnI2ZX/bl3KSWaDiV2gprRmdg
	 yQtt7zB57Q3Mo8XBqvCjNVJmSNs3gus4tOjyghLDfrJIo4D8ATfPNV1uIY9ci9ia7
	 Evr/QQIa5ccRWBFoTcmJcNGTHuy8be6iSTg0TGnKydKfNb9r4s0JaUJ162/6UIRf4
	 xyo9Of+8LI3tHCZQyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ykW-1tkrJP3VqQ-00A4Jp; Mon, 03
 Feb 2025 07:13:06 +0100
Message-ID: <48bf3e3c-52a5-4fec-b399-93ababfa025d@gmx.com>
Date: Mon, 3 Feb 2025 16:43:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting RAID1 to single fails if RAID1 is missing device
To: Colin S <linux-btrfs-ml@zetafleet.com>, linux-btrfs@vger.kernel.org
References: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
 <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
 <92dbe939-46a6-4142-b6be-3ef69fffce1b@gmail.com>
 <23f97ef3-5d4e-411e-abb3-9725d7f92238@gmx.com>
 <ef9dfa64-63f8-47ad-9857-d40aecb20546@zetafleet.com>
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
In-Reply-To: <ef9dfa64-63f8-47ad-9857-d40aecb20546@zetafleet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Or4HgvThn2IcZuzX6jasvyENtwOVXuC8LjGh3zFlLKYB7eax5H4
 sFLcWoC8pxzJUaBxYIZufFR8TgQyH9RunpkUYH+hz0YCB8kwdKKQJax4nn6GdRwaUk7jH8t
 J8xOTa1WxayX8SEtpq2TuLkgIVxAif4659TCEAlwzX8ANFp9dIQANle8BpWXvQlgKRgtIJF
 7OaQrUa2frK+YbQLbhl2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:STBlbFGe83Q=;7aMYA99yh/mfrzDUqKvpdgW7VsU
 XgaJpK2mOeJb4MSLC+y/Sy4/XnvJAkQRjRbcX4HIuiY1YLcWKqk6H1tNLnrXO/DAzWZ7cz0+e
 lk7chvmz+jcMdY9Z0OKtNlTtgxLSetnx2/D8CHVr48Byvrq1yfI/C5W84ex69X0eJanNSJyK+
 Jx6/c9LTkYu08Yuaw1bkH7esRq0ovdvp7/q1Q5j9TK5+hE8lk+ELzUJH+PG2HQAQDlyA/9DZv
 joPt4wRb3zKqVZ1bKGlERI1WXqEEjEibELo9tyXsJZuAA10oVGCcTN/Vi/SzsfbccTFFWpQvH
 ctJvgeo5Nz25FWVrpB6GBhJ9P4ypo2mp1mReFd1heUVqgcHsmKWQynRxOCsaKmIs0VtzVlveE
 2S7nHc7L4rH+7//KUdrUaRgbcx7JdWrtTDzHkcLe6RL5k/9yvIz6du4bZLdNUccyMQoIQB/6r
 BKdbkj+lTWJ1C1m83d8FqJ7UcXXUuFMCZTqwwN1B42Lq1OTadbv8KHaWF/oXFo17wZCciQGko
 4SHGWDfyfm0JnrpGNzy7kFzxkkE2/LAJMr2/skUHKpB/tYj7KAyGIToNQB7kjlMAuUS5ME+KX
 Wbnw2SMTkRV+vQZNMrJSwpB8ZMojWWK9VI5VzWHSC3x9sNYikLYCLYfRxgFjkibhU7/HjrqsD
 fQV0VF8y1+16n2DKG31xj/WRCvnRVdWbSkTQEyoKkmc18CChzh+Eg+tWJjk1Pi9aRRMpuCeiD
 fooRO9aCgMEeFcsqawWquLwCPuTlpXcN6998pVI1qIVJxaIKXZg9trZyZPn6UvCCUfQ9yo6KA
 3+kuW2gNEURd6zax8hTNsS8u7CI1J2khiPOEg7G9VFzag9eomEddj0yGQykgUbtBqWrS8r0m/
 kdElFjWhofDt0le3WwbFAn31yaqqJjGucoG/lo150JWDW8HSQ3YECq6AgLbHzbXutdmh52+Zg
 gbmSeVjGoR68oOHOtCIXidMGQ7f/pW2JXMFofZUPnpftDhvq/x3hMgnztcTrJlVOC1eVNgQQT
 NW7HuQfHkn6AT7st/MkEzuB8YS5dIth8gcFdexSZOyOf+PWKKAaHTuDUPJaEZl0UVApxDM0/6
 hGGTLtvXUZfsE5MOiSCDvFpBMujQX55C8w4FTI1FMFhRakU2j9snGyrh3RCqlpppXxo+1n0fi
 dXINh7RodY8pFwr3H2CKoMbzWRztLQVWBvv/NkrfzGCfAJSb2+vYM6fQgPK7zJa9IGrZ8uKuV
 7fncLeGMJ2IFhfFZSY/twrj9VB6boHxlCQzwzQAZtCEwbd/R7Ka/EbAm0Vr32uVbwh22vBPoA
 +nsodbGWvCLs8hMpISoTsbucw==



=E5=9C=A8 2025/2/3 15:52, Colin S =E5=86=99=E9=81=93:
> On 02/02/2025 20:32, Qu Wenruo wrote:
>>
>> But I think the ultimate solution is to make btrfs to properly detect
>> and support device shut down request.
>
> Yes. How many years and how many more users need to have this problem
> before it=E2=80=99s given some priority?

Complaining is so easy that some one doesn't even know what's going
wrong can do.

>
>> Although that would also introduce new complexity, e.g. what if the
>> missing devices show up again after missing several writes?
>
> Since I see you wrote a patch in 2022 to add write-intent bitmap for
> raid5/6, don=E2=80=99t you already understand the answer is a write-inte=
nt
> bitmap? Further, did you not see any of the several messages I have sent
> to the mailing list talking about exactly this in the last year? I am
> genuinely confused.
>


It's completely a different bug.

It doesn't even have RAID56 involved.

And write-intent bitmap is not the solution at all. It doesn't support
things like zoned device support (which is now part of the core btrfs
functionality).

Knowing what you don't know is important.

