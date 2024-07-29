Return-Path: <linux-btrfs+bounces-6822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B193F21E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061931F22164
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AB1411DF;
	Mon, 29 Jul 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D/vB/0hd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D978C63
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247513; cv=none; b=Parix50jDRx/oqXbnyV8kacC6yoN0wlJJP3L/rJuAJm0x0EnULjRZTNoGIyKZ22OcjJi9rjVt4T62fwWr++wAgQmPukvrtyzCt61WHNvUHmV4ULcofYdYPAM7toEFPpcDdPj8EAUvPGPKwlNjLkU2W9VI6jazkfts0Z5x8lEYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247513; c=relaxed/simple;
	bh=980Zhe8/IEzrgSolD9qfbZVvFEl0HiLWoYlLYn9OBzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iTZqT/NQ5BT5NF/y0HrBmnk0s4hNt5eTtoLV4BNH9M3YuWm8SCqCBUImjzqAyVGJknDTp+aygyojXJGKKKDXEkuoB63hAlKT/YxzbXrFZENil95eqHa7fNM45BjuQ814Hj/rnaWI996vDnXEVxai8MRzC6sIBdmC6De4ujsv3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=D/vB/0hd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722247507; x=1722852307; i=quwenruo.btrfs@gmx.com;
	bh=J0ro3dNis/7rKo0qlUBvq/4GLQP7A6rCKBjmugoEw1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D/vB/0hdhK4DO4l0ZyAoVTmnvOmtcO/gw/qjHb78VwAu3f1JhWIy1p8nvzrMLlZT
	 FSq2lVQXbRy2pba/dsUfohpP0+Zf+zViGwVt7YmQ/QH370k1M65iAeGlmOCp1Gsmu
	 ytj9Z7DctqHPf8rNrR0QxGo2QrkfM6eXN+x9jPjzFbrbTBkkURY6SmRDypOFXZhWT
	 msUb8zHv+KWynU+8tLF41NAR/FcLMw/doywO4kYl29q8wmAC0hfklHMCkGw+EV9Fj
	 KNk3IKdIVW4NvLVPYFNw/izsZyy4iVjiK0y1jxdlGbH0sfD2cojsmVKuNCk6K1jCJ
	 wGBu30xyS7pFewYO+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1sUVNE3P3u-008AWJ; Mon, 29
 Jul 2024 12:05:07 +0200
Message-ID: <a00a0c80-85fa-4484-9076-d4a2f50e177e@gmx.com>
Date: Mon, 29 Jul 2024 19:35:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RAID1 two chunks of the same data on the same physical disk, one
 file keeps being corrupted
To: ein <ein.net@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6ae187b3-7770-4b64-aa65-43fff3120213@gmail.com>
 <37cfd270-4b64-4415-8fee-fa732575d3a9@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <37cfd270-4b64-4415-8fee-fa732575d3a9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BFlahatFLzgT2vt8HMDZ8TnqMJ7T4iZFk7DQmB1PFMPgeEc6QHJ
 cEyY98Svd7yJMuGH91uWW63GxToHwQmY0qI00nnwks8H8dDuxQHb9c5y5JWSCPuhF3k02sT
 XKzKthUPf2QneDHGUSOYxPo8Vw8YIYTCyFJKz/J8DmTJAQDsb57OcS0kWIwKJ7tx09nusSI
 GUsnLP/fKZ8Ymio8Zi08A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h/nlBMezZTM=;wi8BUhY2JbFRJ8ezqW0TIK43q7s
 Ego3LghBBGtkwoEfqLeiCOv6LZfW92pqoo0CsLFBkiBmdb86Co/OATkgHtZ2uniuQP/vtGJw4
 I1WdB8uqtzcJfrVwUhx6Th5k/AX4le/vI8wO0RxflWBKHLp1X31iWlIIN5l8jVnrMrLjwMdCo
 s6aGBR1UuuPUzQcjVb/i/dDgpP5Z7NVOTiQkxfYugfrPnzztm59XSUQCUdpNytBHVFM1tPHW9
 LD57XmLfS+YcooT1JxGfHbZT/+qLxY/3mcjEMF+SdTOFuZjFZk6llRwwMyS2tg4GlvLs5dXzB
 vgXh/XSy9OuY2aEm76BnC04RxlMZW6HbvXwwEwqvhBfVhsCxApaXBDVcGyfe+JusGfER7HhNa
 Cf/gKp0dFYKIZM1uGZm4BASTyX+Y8CyfiGApEs1Ii6oQQAdRMNRYjjlOsbzrVA8pY3PLYEYmG
 opOb2itTvaAt3wobqI6dUK52Oo/96Ao1gS5pAurgn7dIujFIHTViSKcm+qqmT1sgbNI+jyb4d
 J9wfBHGVRXnmFpII4uaMx16jVwCN1s0AtMUSaNaH250GyGBLEECSiNHTRCXLadz3wA7AtwiXL
 LqtwlrNrktAoITgF/ARiy6pxMW78CazH/kyeBunTHsOQNtRbfGifu/pUCWBMzTOpk+mvBduiR
 jiy3aPjMhsfy0TAy0Fw65ippc81upGgC8krZP3SGmwg5QDnk/ibaMHoTtCnI9u7w66m8e8M20
 /1806Z5NhoFstIq3OduzYO8P8LQP2ANebNnHVbND2JvImvPF11n0hDNAFemyZo5ARLCNdSDEO
 BNB0oR5ZML24kcIh5Axa8Z9w==



=E5=9C=A8 2024/7/29 18:13, ein =E5=86=99=E9=81=93:
> On 10.06.2024 16:56, ein wrote:
>> [...]
>>
>> I don't think that it's RAM related because,
>> - HW is new, RAM is good quality and I did mem. check couple months ago=
,
>> - it affects only one file, I have other much busier VMs, that one
>> mostly stays idle,
>> - other OS operations seems to be working perfectly for months.
>>
>> Sincerely,
>
> Hi,
>
> after spotting this:
> https://www.reddit.com/r/GlobalOffensive/comments/1eb00pg/intel_processo=
rs_are_causing_significant/
>
> I decided to move from:
> cpupower frequency-set -g performance
> to:
> cpupower frequency-set -g powersave
>
> I have got:
>
> ~# lscpu
> Architecture: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0x86_64
>  =C2=A0CPU op-mode(s): =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=
2-bit, 64-bit
>  =C2=A0Address sizes: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A046 bits physical, 48 bits virtual
>  =C2=A0Byte Order: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0Little Endian
> CPU(s): =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A032
>  =C2=A0On-line CPU(s) list: =C2=A0=C2=A0=C2=A00-31
> Vendor ID: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GenuineIntel
>  =C2=A0BIOS Vendor ID: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0I=
ntel(R) Corporation
>  =C2=A0Model name: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A013th Gen Intel(R) Core(TM) i9-13900K
>  =C2=A0=C2=A0=C2=A0BIOS Model name: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A013th G=
en Intel(R) Core(TM) i9-13900K To Be
> Filled By O.E.M. CPU @ 5.3GHz
>
> One week without corruptions.

Normally we only suspect the hardware when we have enough evidence.
(e.g. proof of bitflip etc)
Even if the hardware is known to have problems.

In your case, I still do not believe it's hardware problem.

 > - it affects only one file, I have other much busier VMs, that one
mostly stays idle,

Due to btrfs' datacsum behavior, it's very sensitive to page content
change during writeback.

Normally this should not happen for buffered writes as btrfs has locked
the page cache.

But for Direct IO it's still very possible that one process submitted a
direct IO, and when the IO was still under way, the user space changed
the contents of that page.

In that case, btrfs csum is calculated using that old contents, but the
on-disk data is the new contents, causing the csum mismatch.

So I'm wondering what's the workload inside the VM?

Thanks,
Qu
>
> Sincerely,
>
>

