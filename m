Return-Path: <linux-btrfs+bounces-10379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232E9F20DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F429188785C
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BE1B0F3D;
	Sat, 14 Dec 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ViQqQ4UN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15C78C6D
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734210043; cv=none; b=SZOx972xJOgjMIY2qq8gj2xIB3VxdGXdSJfqr3aozDrluTxoBBEslth61SyqdNmZyaC1m95qe/ukqhM4pNXBCXyH3wDAgC4/H11Z0jzwygxfTbpuxS6NWchvxAWrQd+8wEiP1G9kDqjPWUPgohZtRDTjESIth2LG5W9Pl/huObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734210043; c=relaxed/simple;
	bh=6epiXkwn9zoECA2cJNJbBiiGB9KKU08h7UApPw0oRV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvhqrblqjGG6YcK81rOixCVihMpuseu2lzJt7sGeJpOQcbv7rzkR0ZKPvop1czWcg+asUaKO5soVFM4JKE+6WYS/wOJ2d0cSeL1EBQ6NuiD89bPNVmBnvuRXcWmLKr8Gyv46aqSxpzOVPrDVW4SCWxlQohDqwK3NtNSSkHJ8Yf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ViQqQ4UN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734210038; x=1734814838; i=quwenruo.btrfs@gmx.com;
	bh=dUw6SUSM2IjGYBDzKWAp/CH6v/7ONAHcESMlDKxN8eE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ViQqQ4UNolcN49vbHyiW2fj4FARHXGKYBcgDH2t5qKrWfkVmHlLHUzxsREUI4Vph
	 UYtlLRG/3Wx/OG5UbItAnvhGAEFx6E6TxSsQSKTmxYBk9Yo3VuacbKu2IzIQawUYc
	 f3m4aradxsOCWp9SNI58lAIRWNv1jFojHJkVGoi3uiJy04t7e5t05jL8fPLnHF6uy
	 3Ek13nRy9qwNWYfHrj9Za59ZAMnemB+/rp/RXeGtlg0E2a3cAzlUg/FSCwgwpq/eX
	 q+8rkkXXQJkQ7XqLZiIdFd2tInI7/hZ4Wzoji6nT7ph1gZxPEnVy1q9xbJCH2xbK9
	 zRY1veusGbDHaUGQhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4QsO-1tmBGt2yCU-00rbqY; Sat, 14
 Dec 2024 22:00:38 +0100
Message-ID: <d5372478-70f4-4a3c-bf9d-26366f955e5e@gmx.com>
Date: Sun, 15 Dec 2024 07:30:34 +1030
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
In-Reply-To: <CAJhrHS1xgfrp=Wpk18xCBGUEi2tYxaqCxrMQG5UEGSUbR4G-_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KyEeOUn6rVETudOBqHWgEJMQf1QMbA62mwh17IUADhFxl4Cp+cW
 YubE4VzWfghHpWwNn8DJc/x1RGOSq+sNyQI7up7JIpsbHPYDbWH4GZ77LRmKCO0/r7XAVW8
 2vIZ+mdLJnptcLbp+1vxa8cDde/DTRYQ9X/6jI2bUVKyRjOnaa9veSDJOToV1o3pDSSdckw
 htwK5uDBdBeyeuiB/TLzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Xk0BNK82W8=;XFaqDImycVo+g77FEtIW3dMxZk2
 8B19Ad/D25bwcitqOhwiecZ7onZVhwjEKlUAk/QSvN5rY9BgMcGs5ZCn6F20uwum4sgaWHDFV
 UVwUsRFOpGdK057aDBu62oopzVxtKXvl5NTxiDJA7AuXJopP0P03mkg/48VpgfMwPpiIziOaq
 xv/m4kzz/PmwI5kxetiUpRrPYhsD1cYy0PSebbRnhBesTSg6KAEIDajlPPJ8QE70skfeXKPDb
 gcrGr2LyFpPj1mMnXUBIU0ATMgkI549L9qxKCsnO/y9/G/QMmxB70zf2Db2uu3eY78125or2h
 oRK88qqpcGNt0Pu9gEe4/y6GImCCrziRA6f70ZobkU5PLbCvZGz9x5bn73WzB7VQCSjc/tUBw
 rxc6qMCdhV1Q8+lrRCXoRkAuRnxIqBaA0gvZ10gl9qmIwNz042YmtIzlMOn/KL3S9hWzNQnbA
 BCRGluZs//UG/EYehnPUypkaBwaIeWscWq7qzt+6jbPTIs8VfUz6Oe+XtqxFADuEIEow0Tqwi
 yonZZnxGGbaq2jmatDW5PW4R2nqG9SMV2/O6ZA5rQFzhSSpntiwHE3JenCR0r11IKOUn9v8WG
 utgLl8y53RooLAp114XMxWv2heJ6Woi7wNvGOSeuFcWudgQTvEYFqMiOpPEWoQFW0Nerhd4cg
 7cVdtNL8NLCnj0psRtJVw29UWvSqaBvqk/0WXttq15QS8Bc/IBGnRgc8pla8Z1EGnDGZhVsDV
 KPDDVVHz1qCJQ4BQC0wZX3mCSf9Iomb0FbsuTtY/GNu4urTwpSDqVRaOTe5+91H0H39VprZTW
 GBPgzLp3Qf5nySEMoYU7aWzXnF2Qw4yCVmG9rwSlTuB1q7e1qwBYSmYTs5J/rM9lN4Fx6SEZk
 c8eElkHwC4TxCZJDj4AOz0NKCiZc2SlZo5oyRhApqyX/4k/o95BeluodCb6Arc9doa5V8vkGu
 8/8t/HH503xMCcTrUGKZwpdQXdiuGGd6HPXDgoOLCg/lyoaDmHmQT9+mjaar4bxuRiXTpPji5
 OHOuZKIHtaWLVeIT9rBhVDRMo6WOqtzUnghTf0wz+QdPq7sd+2+5SVjS5EC7XMxBS4DBLDmPp
 pLzZNRwP04dkjZ21TDZkXuEJVtJsUlmWdqj3CqTYipHgUmEdtarDtuv1P14qVLDSMXeUTLqe8
 =



=E5=9C=A8 2024/12/15 04:09, Ben Millwood =E5=86=99=E9=81=93:
> On Sat, 14 Dec 2024 at 02:51, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> Both kernel and btrfs-progs should go with metadata COW with transactio=
n
>> protection, so even something went wrong (power loss or Ctrl-C) we
>> should only see the previous transaction, thus everything should be fin=
e.
>
> Thanks for the reassurance, that is what I'd hoped would be true :)
>
>> =E5=9C=A8 2024/12/14 12:47, Ben Millwood =E5=86=99=E9=81=93:
>>> While I'm waiting for the lowmem check to progress, are there any
>>> other useful recovery / diagnosis steps I could try?
>>
>> If you do not want to waste too long time on btrfs check, please dump
>> the device tree and chunk tree:
>>
>> # btrfs ins dump-tree -t chunk <device>
>> # btrfs ins dump-tree -t dev <device>
>>
>> That's all the info we need to cross-check the result.
>>
>> Although `btrfs check --readonly --mode=3Dlowmem` would be the best, as=
 it
>> will save me a lot of time to either manually verify the output or craf=
t
>> a script to do that.
>
> Well, the check is still going:
>
> root@vigilance:~# btrfs check --progress --mode lowmem /dev/masterchef-v=
g/btrfs
> Opening filesystem to check...
> Checking filesystem on /dev/masterchef-vg/btrfs
> UUID: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> [1/7] checking root items                      (0:46:43 elapsed,
> 68928137 items checked)
> [2/7] checking extents                         (14:31:49 elapsed,
> 239591 items checked)
>
> I'll let it continue. In the meantime I'll e-mail you the trees you
> asked for off-thread: they don't obviously look like they contain
> private information, but I'd like to minimise the exposure anyway.
> (Feel free to send them to other btrfs devs.)

Those trees are completely anonymous, the only information that contains
are:

- How large your fs is
- How many bytes and their ranges are allocated
- The type of the allocated chunks

So it should be very safe to share, unless you have some very
confidential info hidden in the device size :)

[...]
>>
>> That's all the info we need to cross-check the result.
>>
>> Although `btrfs check --readonly --mode=3Dlowmem` would be the best, as=
 it
>> will save me a lot of time to either manually verify the output or craf=
t
>> a script to do that.
>>
>> My current assumption is a bitflip at runtime, but no proof yet.

Unfortunately it doesn't look like this.

I scanned the last several dev-extents and chunks, it turns out that
it's very possible `btrfs clear-space-cache` is causing something wrong:

- The offending dev-extent have chunk_tree_uuid set
   This is not the kernel behavior, but progs specific one.
   This means there are two chunks allocated during
   `btrfs-progs clear-space-cache`, but one is missing.

- One of chunk allocated by btrfs-progs is totally fine
   And it's still in the chunk tree

- The other (the offending one) points to a chunk that's beyond
   the last known chunk

So I guess either:

- The btrfs-progs has a bug in the chunk creation code
   So that a chunk and its dev-extent are not created in the same
   transaction, and Ctrl-C breaks it, causing an orphan dev-extent

- The btrfs-progs has a bug in the chunk deletion code
   Similar but in the empty chunk cleanup code.

Anyway I'll need to dig deeper to fix the bug.

Meanwhile I have created a branch for you to manually fix the bug:
https://github.com/adam900710/btrfs-progs/tree/orphan_dev_extent_cleanup

Since the lowmem is still running, you can prepare an environment to
build btrfs-progs, so after the lowmem check finished, you can use that
branch to delete the offending item by:

# ./btrfs-corrupt-block -X <device>

Thanks,
Qu

>>
>> Thanks,
>> Qu
>>
>>> smartctl appears
>>> not to work with this disk, so I can't easily say whether the disk is
>>> or is not healthy.
>>>
>>


