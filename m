Return-Path: <linux-btrfs+bounces-16533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA5B3C601
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 02:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741567A7FBD
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 00:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D84690;
	Sat, 30 Aug 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BXfagmjm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705E191
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756512247; cv=none; b=scOYDhNtg+8faXeutVYMp3h5isS+QJGwY12AOkLHeoyxs2L50JktwzvU0yP4WIlfKrmNHLd4CfBgk0BK509JNMxwnnHAkZ64NGChgZfCamB5gXdV49WXpw8Br/gghlTDgG655VuyB2/tbj3C1RUYuNu0xCxRRmpEBQVc/uvb2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756512247; c=relaxed/simple;
	bh=eDHRIC2Tsjhv4XuKm22FS7bh1QGOx9O5xE2abZb6znE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWbkWnWk/9csvos2mkh4iaLJ5v5fkXhF/yOC5N1rfV8WCMUoGy+y8cGj6QZWZK4NHwzDjaKq8Ce0tf65tjMYbO0xErv2SwK7wCQGpvXGHycSe5PaH4TSps8TMyewVOC8DJ0Qm413VusguGeNOQiNHJkCkRZgknxxH8YWc85Fh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BXfagmjm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756512233; x=1757117033; i=quwenruo.btrfs@gmx.com;
	bh=eDHRIC2Tsjhv4XuKm22FS7bh1QGOx9O5xE2abZb6znE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BXfagmjmNx+AJIi8LVQRfUcJx/t/ewfr6nfkkckwPgiieo6OB12zjdYp81eJ/ISv
	 C4TTjeTHe5PVn/5PHBLVXrKHOA4gFIJ2g/pjU2GPokHgpqs7kg3JqlrFjiesSKM1u
	 Td/0WMlF1BVgDwGeda2STdzHwdGS7NvBu02Tdp/cM0R2YOBimd61lJ6cu6meIpUoL
	 fEUiuqOWDWV/TZEZeoOADTyJPXblFEY5LSVo1jcQZyCAmcfQJ8ySZARgFQlQEOq43
	 iWJq46/ew4zQmWIXuVXpdWjq2udqSzVUZG5MuMw+29svte+5wpq3qcd6qc2GdLhiF
	 P63yrEqkacuTYOmHPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mv31W-1uakg436FU-00u7E7; Sat, 30
 Aug 2025 02:03:53 +0200
Message-ID: <5f38efc7-6d0c-4f9e-89a5-6d1fccbed397@gmx.com>
Date: Sat, 30 Aug 2025 09:33:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mysterious disappearing corruption and how to diagnose
To: Andy Smith <andy@strugglers.net>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
 <a48ac216-38f1-4a69-970e-f2ddee2ae8f2@suse.com>
 <aLIm5djb6Ee4T1ot@mail.bitfolk.com>
 <635a25a0-c8cb-4a48-bf8b-c81dac1c1260@gmx.com>
 <aLI8XeLxrWhwhcZK@mail.bitfolk.com>
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
In-Reply-To: <aLI8XeLxrWhwhcZK@mail.bitfolk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pWyhRGo/Z7oq9fJTnCDbSOkiNkPpkEnFB5gduk8mB05WQn7ZH7S
 +KCVDmbX4IKzUVXX1XFspGKvN5owHz1zIxfVLTNI9IZ3SqLO+ExkW+rq2+CcwBYF2xl+Dut
 Z6cpZbXWpwaNstVZg2NND0lDHdZvfHUz1npUoVUxE/IBeXtHKlSxVNx09cpsPIMX3o5Wkp3
 ecV/5nAZdR2MG2X4cXOXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0NL5exRWIv8=;rbFEL5I8r4hVqH435cxdFbo1meq
 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
 sr+MQ5BTHluyAeWuSeV



=E5=9C=A8 2025/8/30 09:18, Andy Smith =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> On Sat, Aug 30, 2025 at 08:28:25AM +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2025/8/30 07:47, Andy Smith =E5=86=99=E9=81=93:
>>> Okay. Yes it is still supported by Debian so they are still publishing
>>> updates for the related LTS kernel but I am relying here on fixes goin=
g
>>> in to LTS kernel in the first place.
>>
>> In v6.4 we reworked the scrub code (and of course introduced some
>> regression), but overall it should make the error reporting more consis=
tent.
>>
>> I didn't remember the old behavior, but the newer behavior will still r=
eport
>> errors on recoverable errors.
>>
>> I know you have ran scrub and it should have fixed all the missing writ=
es,
>> but mind to use some liveUSB or newer LTS kernel (6.12 recommended) and
>> re-run the scrub to see if any error reported?
>=20
> I do a bit of travelling the next few days and I will not like to change
> kernels on this non-server-grade system with no out-of-band management
> while I am not close by. So, I will leave things with sdh outside of the
> filesystem for now.

Have a good travel.

>=20
> When I return I will upgrade the kernel, scrub and if clean put sdh back
> into the filesystem then scrub again. The Debian bookworm-backports
> repository has a linux-image-amd64 package at version 6.12.38-1~bpo12+1.
>=20
> When I go to put sdh back in to the filesystem, I can do so with a
> "replace" because sdh > sdg. Unless you think it would be better in some
> way to do a "remove" and then an "add" this time?

Replace is way more efficient/faster than remove then add.

The latter will relocate all chunks of the source device to other=20
devices (which may not even have enough space), and add the new device=20
empty.
Thus you will need to rebalance all those chunks again to reach the new=20
device.

So just plain dev-replace will be the best.

Thanks,
Qu
>=20
> Thanks,
> Andy


