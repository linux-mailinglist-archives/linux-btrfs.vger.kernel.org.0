Return-Path: <linux-btrfs+bounces-18755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7FC3951F
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 08:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A8ED4F9EEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF702820AC;
	Thu,  6 Nov 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DKfeIFIM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657C26E143;
	Thu,  6 Nov 2025 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412542; cv=none; b=QN9gRBKDL+8mPQ+yAPbmQq3GVgI8NWOfLI2C1HiWWRxnUAkCvP/vi4cLgQTG2gN5Z+X3VzCiKFXAQ4GUh6FWzm/o8jHu+cZYn1yewoYiEFoAT70ClDvCDnk/HsGAa89xspeHKIXT1lWa2bg8adTv/2fqwEQXlhk/Kfu1QE9xjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412542; c=relaxed/simple;
	bh=nY5wl+G1A/bx/KpsmYLpo6PYdXGWBUGL/TDFMwCkdm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSW+94YbbwwBryw38mm0+KrtVxDgt6yNelTW8wCYo97cAFkhXYnv1sk3pVzvFt08R6Wg+kHXJHhuW113f1in39HCgOYFTbjEm/qlI46Cu+WlKgRwBng+EGKLgsdIlBNU9Jry7DcKCfz4nzhnHkbu7OSOIWGV7DbGWD9DvXCfBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DKfeIFIM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762412535; x=1763017335; i=quwenruo.btrfs@gmx.com;
	bh=nY5wl+G1A/bx/KpsmYLpo6PYdXGWBUGL/TDFMwCkdm4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DKfeIFIMmMWn4SAdQypCS5fCByAZwarivz3lrAk1QCPjAjffh2LmhAAt/dxcgpx8
	 nL/Lc4dewGWXKoG8crKsZ+K75QVmkZ2PpyaSOqN5qmOjegXQB3ciR25EfhZ2wHsaw
	 oVgnevKYIJ4q0JFSalpANsRk95PPFtgsS5/HSksdg/EPYpxljCmbYy696pqqadZKa
	 GZ13pj01lh/ZQ4vSExUwqh+kSBPzbvQT7yaRYmyHc/YMv6MfOoedFT1dxT3ZRKFor
	 wvajUlfr6SIq7w5QsDE3fRFhI0Riw437wpJhwJgr+3ijzcq33ur9qFrIhdKlk3uJ3
	 HhdS3kqitkJ+/2kXhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1vif3S16IH-00Mmul; Thu, 06
 Nov 2025 08:02:15 +0100
Message-ID: <21a34072-7f09-4d4f-b490-43637996c91f@gmx.com>
Date: Thu, 6 Nov 2025 17:32:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: scrub: fix memory leak in scrub_raid56_parity_stripe()
To: Markus Elfring <Markus.Elfring@web.de>, Zilin Guan <zilin@seu.edu.cn>,
 linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20251105035321.1897952-1-zilin@seu.edu.cn>
 <2603afff-0789-46d3-9872-3911132a53b1@web.de>
 <a2d629ab-9f21-4b98-a442-fd73cbbb2dcd@gmx.com>
 <c31de8ba-77d2-4d79-890a-c23f1797a735@web.de>
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
In-Reply-To: <c31de8ba-77d2-4d79-890a-c23f1797a735@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:He/OjiVGJ23+wumoOQC+IAcXgOhYgFFo1ySqGccSPPXXZtaltvr
 AUJWWJwDUGHOPnxxGYKvdhjk95rjkBEUkN4++ekfLg6FJCK210tuWlJBsqL+OMwkJKDOujN
 +cnMWxQ6XjyDOpzQ/LGfpxo9Pj00j0YsWTIj0wXRhW4pNeZihoUCx/0UdWoxUBLO0F1mN1I
 Ri6Wll02mtKdtowBuzFjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLh/9z2u46s=;iJ6kjbz0ZmLWGPRfE4wycggCjKD
 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



=E5=9C=A8 2025/11/6 17:25, Markus Elfring =E5=86=99=E9=81=93:
>>> =E2=80=A6
>>>> Add the missing bio_put() calls to properly drop the bio reference
>>>> in those error cases.
>>>
>>> How do you think about to use additional labels?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/coding-style.rst?h=3Dv6.18-rc4#n526
>>
>> I believe the current hot fix is fine.
> =E2=80=A6
>=20
> Would you like to care a bit more for avoidance of duplicate source code
> (also according to better exception handling)?

That is handled in this patch, a dedicated cleanup/refactor:

https://lore.kernel.org/linux-btrfs/2d2cfb7729a65d88ea8b9d6408611d0cc76e1a=
b7.1762398098.git.wqu@suse.com/T/#u

To be honest, doing that extra tag inside the original=20
scrub_raid56_parity_stripe() is not that helpful, that function is doing=
=20
a lot of different works, and @bio is only allocated for the last two=20
stages (using cached stripes and to wait for the scrub of parity stripe).

Doing a dedicated tag for less than half of the code is not going to=20
improve readability.

It's better to extract the unrelated behavior into a dedicated helper so=
=20
that it's way straight forward.

Thanks,
Qu

>=20
> Regards,
> Markus
>=20


