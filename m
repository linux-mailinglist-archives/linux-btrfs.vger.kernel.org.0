Return-Path: <linux-btrfs+bounces-14346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858BAC9A1F
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426E19E2BC4
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D755D2376FC;
	Sat, 31 May 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ETAd0VgF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780511DE2A8
	for <linux-btrfs@vger.kernel.org>; Sat, 31 May 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748680957; cv=none; b=DcVJY1LSFfWzNDyO/PW7qhKNrBJMRIMMyYae9fxreALsLN3ZYw0KpymytKH6lAlCRpQybNSgbCuzltkRxc9vdyeut0TPxjVVnHnUoytXoRRb2g1kyZiX3Cnv7GaNLKv2kLNth0tSw3MOAEIqzm1ZH04z7VTm3DqEZ9Oyry/hhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748680957; c=relaxed/simple;
	bh=1bLhe2s25nu5OqS6T0FIwWA6+wD7QLiUNCKBj7GlIEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDP4THoiCgjPUgSyfhYtnESdRqVD/nAy8BuKP4A+CCWQ7U/2QHbTP58arY1/AAP2tlEU3Ov/ReAMIUnx6rjQVdfr2Ia8kWll+MBL1X1PLStuRXgrQO4IX9Kg0s6PS6QwiWTxfUGXlVuTtjN45wG6lvIUb0FJq0JkYUGihnZCNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ETAd0VgF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748680905; x=1749285705; i=quwenruo.btrfs@gmx.com;
	bh=1bLhe2s25nu5OqS6T0FIwWA6+wD7QLiUNCKBj7GlIEg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ETAd0VgF125vVsbvwSQBR0QwQNthJqr+lQpbfK7OgLwg+XEjRacHuQVt8w6Ig5yt
	 PqYqrHsOLfpIQJiFsudlsiQfzt+uaiVTEjhtNQVLuaSCmlAIiYM/iuM/Go8FsNfLl
	 2+uFhb6HPzhc+eosXWzDFXNstVreGahGzsykZjdmOKelIseH77FOIrP9a7Krc1f0H
	 reZEXjHAPHIPWI62CuT/Vn/u+LkEGhAB93JluM8bRIRcuPxUSuZhlf4TAO6SqZlYE
	 ++4ea57PqSiBA8yU1XkMWny+Wuk5FJVIsqjjDnU1CTpGIlKWWNdwxU234WBov9l+V
	 SjtPh2SQ2EJRQSc28w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJlc-1umgWU3BIq-00caXv; Sat, 31
 May 2025 10:41:39 +0200
Message-ID: <ffbd0c96-313d-4524-9b6e-b24437fc0347@gmx.com>
Date: Sat, 31 May 2025 18:11:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Portable HDD Keeps Going Read Only
To: Matthew Jurgens <btrfs@edcint.co.nz>, Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
 <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
 <5de3840d-70c5-48cb-a7c0-7db17e789e95@edcint.co.nz>
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
In-Reply-To: <5de3840d-70c5-48cb-a7c0-7db17e789e95@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lpfKMxUXFs2poGAvr+iYLGiRgvXXMpsUAd8j0/qvIHCOoCrjkFQ
 qRFyk1RxkaJruy+88Wk9N7TVEA86cal44DezYyW+f7r0y6uaR8W5yfBq299qOvEYUQCLkOA
 +hPapa70msOzzOdWMx6m2GIbJEUVIjQVlIbwYk7hzrjBMcTgKF1PJhj8LiPbIAHeO/XMrej
 H9Xa74zPppa7BXre7zRrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M5qFu6+NSH4=;wsnJxkGoUOVhKFixvC7IT65A8uh
 E8rfYxUTKR4jAfzHUAVM5TbtsER/WZGxYcmgWX9VN4FpKDIZ5uZRdUGI0omgijNVQELZoiBI6
 ynQEUVmBefvaaP2F1JTG4/FvFgYdFpBoc7Mk/YCqbqu6aM/YSQ7vhXi1R7Ccz6OoHq2NQ+Q/c
 b5vukwsR874x97SlXjNZ9zxfxQxKC4I/cx2MFMae5Exb8Ap7LwbL+B+fQamq9wf4EolgPeBQ9
 mPpnZcYCWJjLQJTgK5fGEWTrgfQvApPy/VrOA3HmrVuCdQIOZ/AVOtE5VGBerbpVHWRzUJHSl
 o5GTnYLBXtDpIUlnPHMSB1h7Ns01mr1FyikgTrI5EJBs2Ysu87iCTYi4mDDpm/d3kqR47ds4o
 kKwK63QZHzAuzfbVhAvcrLSz9vNqOuBe+FiH+irg8ujWnZ4BSOAxytOuPbyCWpoQ0aUKLNzt4
 sY2ijVuc+WkX9Yx150kv4cYnMRcaKoHCKULvPYEAoG32NNsfRnLhpLbkg+d5F+lxaA2NLDiR0
 hcL+3pBawW1hCwykMLXVK7IWX6OeSfuUh5+xjAi+RkgqIhBe7dMagV/3F3gkGvHgp+/3+UBmX
 IBWIAmyyBUtweu0ajDJhC1mNGv/kCLy0KIUU40hr+53dSB33t9Wja/9UZ6akKU6v2gNgIuImg
 0vtdDU7FaDR6aK8DOToQ9w9/LIwxZbPcZ+xbLQhlJPho4DG1odzPC9CoUu3/cESPSRBrhSozY
 p4M+Kzue/lzLaMyo+jZQO9eX0olqbqYt+FGzaGOT3NUBWykObhl7gKAhu/6C6urXeN3ET2MtT
 UgHIbqK2TgpcGMxcgK0+naltZE3ZSyplQmu5X2hhI5bWIjC15U28J38YX0zFSKoTLa8a9NpG/
 t/YnU4xRygPbvs/nMQQ+voIsmnmFzqXXgRhL4zgEjOTWyacX6rtFh8BZt3RuEAEp7JCW2NgGu
 oRXVWCxoHYI2GckzQ13gLt0Y/LX58sN/l9lFSHr/qWU7uq8mkg/gdHTPcCQRs3Frbgfb4lJYm
 XFVeLErnBFzbfyjWFHlhaMEIvXsIbTjr6VoQD6ENv6Q4BiNhbbbbvsItsCpG9sNDnE4z+VN/D
 uozYID4wtJJdBLb3bGF3fLFMuZDqiFRNjF1pslsHW/3GAqppimmnxRkz8TTziOUNnbVmC6+AH
 mHhby3h7w6Fwk7G7/QE9plZ98LZq7al1aVbRcDxlooPD5XGdQlCHjUXn7mtAAzlOCmEfuLI3X
 0t9kOgrjl3U4VZ4T7xB9EXBDw7GSWsqyIjl4BxdBl+GHpd7EzvhpDuIwHWMhGSXDlOwKmlMvf
 nxyrtHLuxpLV/CxtHVVeWXR/YMYqOuEhPzmjbFG2361bQqO2Nhurz/qv085xdSZdT+A8fNPYt
 9qpkSFeWOSnhRBLvPfK+GKvfH1on02yYKuAdo=



=E5=9C=A8 2025/5/31 17:39, Matthew Jurgens =E5=86=99=E9=81=93:
> On 29/05/2025 9:08 pm, Daniel Vacek wrote:
>> On Thu, 29 May 2025 at 04:08, Matthew Jurgens <btrfs@edcint.co.nz> wrot=
e:
>>> I have a portable HDD that I just use for backups (so I can lose the
>>> data on this drive if I need to).
>>>
>>> It keeps going read only. Sometimes at mount time and other times afte=
r
>>> a small amount of usage.
>>>
>>> The dmesg and btrfs check output is large so I have made them availabl=
e
>>> at this link https://www.edcint.co.nz/tmp/btrfs_portable_hdd/ (I tried
>>> to attach them to the email but it seems it never got delivered to the
>>> mailing list).
>> It did hit the ML. You may have missed Qu's answer:
>>
>> https://lore.kernel.org/linux-btrfs/3d1c4611-=20
>> d385-4d31-96de-3a617e02c94c@gmx.com/T/#t
>=20
> I ran a mem test and 4 rounds all passed. I have had some intermittent=
=20
> RAM issues in the past (with other RAM though), so I'll keep running it=
=20
> a bit.
>=20
> I can happily rebuild this drive but just wondering if there is anything=
=20
> else that's needed from it before I do so?

Maybe a full "btrfs check --mode=3Dlowmem" output?

That output is a little more human readable, although much slower.
With that the clue may be a little more obvious.

Thanks,
Qu

