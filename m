Return-Path: <linux-btrfs+bounces-10629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087239F9D47
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2024 00:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB0616CD2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF49227B8A;
	Fri, 20 Dec 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JnwEVscR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE935970
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738673; cv=none; b=ibVOkI19w+9yPUkDKNfo5iUFoM3C+woHP/4NVAWoOziSPw01IIHw+uc+MqXbkzP1UjZvxsS58ThxEvG8vvAtWO+UHB75A7l/wLea5cVjbOrS5Hf+aj/fPcqe0fNa9xHG8hmzTza9mlw+3C2SGtuPQN1rN/YphigVV3W7DtOdMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738673; c=relaxed/simple;
	bh=l8/5SI1dq7Lyn+J+txQ+9KqnFZSBSIB24moyC2e06Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMZfs5PYY0bif2ybEcaj9eXb19g+WzreSql701pQjloZrV3V4fBB7mpEOmxQZlljW/+nHUhuJw/X94W81rnTlYT3AT+PBgyb2A+bOMPuo8+i701xMQu/KxywCpPYbiE77b3NDQ+QEHHlw5MLuB94MSZ5AyqTfRxzT3UZqaEvEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JnwEVscR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734738668; x=1735343468; i=quwenruo.btrfs@gmx.com;
	bh=1v/S04mFQVafPyPMcFdPGZdpCSl20MD/nRTuU0rSU18=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JnwEVscR6N6moAdoDy6lZ8DN3nZFZGmk5f6vWmstYXGDukjudgWCJ3ADO4vi2FLg
	 2cgy5Yk8mU/zss8wETz3jo8Bt6FHrIv+n/hOTPeoQ4fxzKxsX8h8fmFQnPz/ShSwJ
	 3y0mrV8OSwvHZRNJxGdQH61uBBvoJTmaB0KubYzej3AfXYU7EWCgxT6RIwsIifor+
	 BTPnUE403TOi1nh5N4xWb5iwSwhZG9we5ff6U2LNtaIAPpzU31TmSPbjnm6GU/SmB
	 f4fuZZPSIZd1i7mI64Sod69xmqJUUuh8/Jy29hhag2y7vxD4mwNxomNV3o/+RvBZH
	 HELP+7PrJPjlawqkLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fjb-1tRpa01ZyB-004zjN; Sat, 21
 Dec 2024 00:51:07 +0100
Message-ID: <836179ee-60a7-446a-8cf1-54580cbdd5e0@gmx.com>
Date: Sat, 21 Dec 2024 10:21:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dev extent physical offset [...] on devid 1 doesn't have
 corresponding chunk
To: Ben Millwood <thebenmachine@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
 <56d3885e-5651-4fd4-af6d-89897f8bd240@gmx.com>
 <CAJhrHS1xgfrp=Wpk18xCBGUEi2tYxaqCxrMQG5UEGSUbR4G-_w@mail.gmail.com>
 <d5372478-70f4-4a3c-bf9d-26366f955e5e@gmx.com>
 <2809427a-41f5-4b59-9d03-2c2012e16f76@gmx.com>
 <CAJhrHS3tE22AYSRjBLRC4vkdGaUxX-ibKoXt=K4RAvEbLq3_7Q@mail.gmail.com>
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
In-Reply-To: <CAJhrHS3tE22AYSRjBLRC4vkdGaUxX-ibKoXt=K4RAvEbLq3_7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FNLjx0O0IjDOPZuNCX/uqfjmTnOV6Dc0zbk0yWcQuqQ0YZyIDdh
 JjmEx++IU58XBS+fHjexiDt2eriJbc9uA1i9KAPrWxU8Nkq8vyBV2Fo6eF7H13OnXz1Ruoq
 iLCqefmAD4XIQoCWxymm8rxpnRwxHar1fCVzWtKqLveroIVu6BEAZ50v4hZBlnIKjClKq8x
 EeYskfALqdoy9JsZccyNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TYT1toSK74c=;AjBdLkmpZyJchO34blb7HVq+Gg2
 yT9y+JTurhl0ljUZ39SFINRJiJb/8uaw3Z6hfkqGyKJ6LoRlVKMoNX/SJnflt9v7548bzUzVk
 +J0vkJYJtDxaY1bBgF5gt3HGPzFfS+UATg8Vw/XhEbSzm7eZU6U+edAtC+iNkMqrMYx89xHLl
 QAHR+gnuEIYegI6emwgDSDkrm55u+/1DuztpnSZyLyRO9LoqO/H1LYz/vbHyi/9J8Gd2t87Sp
 mkvXrV3My/wWFFoU392I7eWxDfiJsS0Ahs4Zet4BfmXjYlegzhKyvUE3GGfQEcb+n4Ozm4IvO
 TO9dpoNheIkG4EV4/UGH8wM7vp0sP6yoCU0kchUFpAEGPfWfGxx6Xj5E+hpZdTD22znFYoB5Z
 iIVyoxUGBcfBCGtpduGxta+SnVcx8jnUEuZtdnuRJEwrvUIcBMtHVhOJZJQwX3yMsr2QobUkx
 OJnHhpOVlP22c6Hdfn6NbNk3ldXZNQEbGNv7tFoQurxBbSX0QPbGwgLtWEHqJ7OpOO64nA6jd
 dI0gtLugTklpjTiEldS9GqmfPG7qWaI4S7a8+dEbDxb+bc6EOYnCB5DXUgY0m/lDS45GU0/OU
 8RvIPA/Y9YEFL5fwaO6qXr3vFt7rmVxLP0MdueqbiSbMQTndZuvpSkKTmyWLeKV4j4xxo7Y6S
 F4ma80R4F8sF91BJkgCSmG58r95rBXZmoDrz9baLVox8jxS08dIQpq9IceTaWjb0eq4tWlX/9
 2GTla3dvyZlFLsrhOIKB9HHWOLTupMkxGLyBByzr8porP8WX1rX2tIF+xs6iu2A5VeiCZbbcg
 GB2H1S9C6cIH9p7VKHVj7M4DhTo4Vnt7yDfsCr7hblmvxy2NZAYX7ubKZuG0E/5HeMfjflr5l
 o8yC4ztOhYd0lhIYzFR4UnpUzat13D53/ILgcV/sufWblwixrmxnj3WGAH5z4tws2GU4qqSZa
 I/PbddzOdvAJ6dnViVrK4nRqBkGHiqR8sBeLnlAeIijZszPvyifnkSK0oXBJiLwZdVcdhieb+
 PKaSAFJBL3IgmHM2mgE8EJBdaNHFByPz7VpE2ce59aZo4C0YrLFt0P70V4qwnBm53hOdK0K13
 66Apz9JDihbpj/Xx29qx/MtBeR2GIV0ozWSWAGaW4D1a8Um0yHm9FLWkU3e0JnuOUy6mBNlIg
 =



=E5=9C=A8 2024/12/21 09:41, Ben Millwood =E5=86=99=E9=81=93:
> Sorry for the delayed reply. I left this for a few days to see how the
> check would get along.
>
> I think probably the terminal I was doing the check in was resized a
> bit, so the output got a little shuffled around, but it now looks like
> this:
>
> root@vigilance:~# btrfs check --progress --mode lowmem
> /dev/masterchef-vg/btrfs
> Opening filesystem to check...
> Checking filesystem on /dev/masterchef-vg/btrfs
> UUID: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> [1/7] checking root items                      (0:46:43 elapsed,
> 68928137 items checked)
> [2/7] checking extents                         (14:49:23 elapsed,
> 2419[2/7] checking extents                         (14:49:24 elapsed,
> 2419[
> 2/7] checking extents                         (14:49:25 elapsed,
> 2419[2/7] checking extents                         (14:49:26 elapsed,
> 2419[2
> ERROR: device extent[1, 1997265698816, 576716800] did not find the
> related chunkhecked)
> [2/7] checking extents                         (164:06:57 elapsed,
> 34215503 items checked)
>
> so it looks like the check has noticed the same problem that the mount
> has, at least.
>
> I don't actually understand all this terminology -- is the "items
> checked" number for checking extents counting towards the same total
> as the "root items" number? Or is there any other way of estimating
> how far it needs to count? (Obviously using that to estimate time
> remaining would be highly approximate, but hopefully I could still
> find out if it's measured in weeks or years).
>
> On Sun, 15 Dec 2024 at 04:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> Do you still remember if there is any error message for the
>> clear-space-cache interruption and the next RW mount of it?
>
> I can't say confidently at this stage, but I think there was no error
> at clear-space-cache interruption time. I think it's highly possible I
> could have missed an error at my next RW mount attempt, I was probably
> trying a lot of mounts and often only paying attention to the part of
> the error I thought I could debug. (there has been no next
> *successful* mount of this disk, RW or otherwise...)
>
>> Thanks,
>> Qu
>>>
>>> Meanwhile I have created a branch for you to manually fix the bug:
>>> https://github.com/adam900710/btrfs-progs/tree/orphan_dev_extent_clean=
up
>>>
>>> Since the lowmem is still running, you can prepare an environment to
>>> build btrfs-progs, so after the lowmem check finished, you can use tha=
t
>>> branch to delete the offending item by:
>>>
>>> # ./btrfs-corrupt-block -X <device>
>
> (I have been able to build this but haven't run it yet, since I'm
> still waiting to see if the check says anything interesting)

Please go ahead. Weirdly this error is really a single orphan dev
extent, without any extra other problem.

Thus that command should fix it.

Thanks,
Qu
>
>
>>> Thanks,
>>> Qu
>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>> smartctl appears
>>>>>> not to work with this disk, so I can't easily say whether the disk =
is
>>>>>> or is not healthy.
>>>>>>
>>>>>
>>>
>>>
>>


