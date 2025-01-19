Return-Path: <linux-btrfs+bounces-11005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08017A1608C
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 07:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0571883ED9
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F6E15749A;
	Sun, 19 Jan 2025 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tkoehrJX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4028329415
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737267556; cv=none; b=t2VinSoAAcXuRv50S97YOphUrEWUff/ra7xruT/lzWR+Fx94ZBKhMkpnCnI4Vf4BO055Q31Zp33cIXGPv8ZkwaAdIhQ8wS4TeUHlOA057uGpF0Gbj3B5pdHkk9L/9eVZv6ZE1CshmW8AQqz5MWoCxEpd4CI+YVTLjdVI/dpxm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737267556; c=relaxed/simple;
	bh=gXrTHC0b9aFTPa1bPvZ9TOBdx1stQfOVcjOu2orqxEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxR4uV5dKAYDws7u6H/R3tM7x3lPfBYxh+6IXX/Cv0MMjstviOvVBWEEsAqNCFYDwQKfmUXxlKucS58AM1/8HZvlN8Qqsz/y/ATK5byw5kJx/0u9xHWiLfwnb0X/JFE/POXI0JV2H5l2b9v01i9rA8Px0JM80bIs/ZrqqWKdGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tkoehrJX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737267552; x=1737872352; i=quwenruo.btrfs@gmx.com;
	bh=wYn9FPlOQAqQ7c4CHBRtMX4spefqrmfKaNKLphuNTec=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tkoehrJXqIBtsAh9awSo7M2e9nveA7y3Nacw/dQAeKjo50gVYRTtn0H+dlU4GUt1
	 ODqkg5qQwG6FsQpT63M5AILmJ38BknI3uYkZ0TGSM+8gbT09eOFUZKV4l4F4HfxdT
	 wNwT0LlvHXhUk3rENTLSs0KJdersqATy4+zBnKecbJk9/rheMRvlQpumSFGcQgCPw
	 wb7wr2o0k4hOYtytezyAGHE474R9t8rQ6SsUVI7au2MKpcBaTBynyfJCMGhEhFhja
	 tz4NX1Odg+qfBUb5nw8z4CaRkktGRLvzXLRerPVJemqCP+LeHT2WUAMoZKdYhn2Cd
	 s+bCjD/ny8pLXcnLJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1tTqlH35GO-00ruii; Sun, 19
 Jan 2025 07:19:12 +0100
Message-ID: <b2267eca-5528-4cec-8956-d0f666f79c9c@gmx.com>
Date: Sun, 19 Jan 2025 16:49:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Dave T <davestechshop@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com>
 <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
 <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com>
 <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
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
In-Reply-To: <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+qOADWT25VXhTFVhSw288tQlR5CuAzPS3NOeo5EliVBimwBSpcB
 hWulHIQ4wWIEIoxJWzA2vRrqxo3cAEkgrtq2iWrqeIjJtvoIaD5EDMoT6qKci/EZT1VmtqK
 88S072PpS/edXENEYVr6M6m8EZl4LI0XiF7EbVTvDFnkSTe4IleA/8WaIzPppKP8hoeJJXE
 PCTtO6KiBYaKGjxVPyYJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eKQ4ZQbSFgc=;l3MjtLySqJQTFjJ3TzOUHCeSzib
 szHyMPB7v/AN5Ij4bLypiIuId7ksnKbaYY00bX4pVtLaVchNsJ40VmH3XMDMLxCVNqjCwzCwI
 ZEsjAbzwg9TUVVGoVEDzOURJC4Sx+juNyR54vgtK6HGSX4KxjRtCv2O8xa2knuSrUj3nVztOB
 iEbawQ0gO+EKZ5/hAfH05uiOxnbRb4+FbwqD+F1gchzwLRaSO+XZrtKlCgurVLfkPu5Jfk8RN
 ibFjnt2wUDIz2Efl0pPClSjZvFg5VZY4y25p7wT5XkMONU7UgJ7qW1L8vd83vlmOsFCsYFG6d
 t56st1mlxeGkSr3AwPqk5oawGe/YR2M3eiHjnahavZo3VtbgmZkOgD0KQXLgGwQVY2LB5ukXN
 Fp+slTBy4VvwQAuHbHXJDZggdcEQpY3mi0KvseAkEGJCfqtOCHDJWvlWlW1WOd56Y3Tjm6+kw
 p2qRxgo5IfK5V4B66qEDoq2xQ8SAMpgG36SVqeo3xioIZy58vb8wXtiJ5SLc2i0Z6zY0Om24e
 0qFGNUZE2WiN4T0Ds36afwaco3otF9dTrcflgx/WcOIkX3vjlXurkK0TbWXNVOl/SpBn81KeR
 HKSV1upoUhku6lgMPPEgEOgm7UVX2T2ZrfPB8ob/63j+e3iv0h9tUExiuLXW0PfV4M6thnFpK
 9RvOnSYGeBqdLRhuGB2pDi3/a/OpY58oldxBwBhP8WdYWgIwOkqNBqKjqLgB6YErx0OdcQaf6
 vwbK1L6I4c6vLO15Zm8lArJ0V6LGfgyqmrr69byAD0hnklLghyFE2FgkaKR4Rd6zhrrOYVPJo
 AJzorHktd7RS6DfiFPaqKbCdrrCC1Q/XXY3Vu7vxgxAlaPk6GUGf8BeJkIXRwa5XvoVcYGxXW
 X2qjur8lvVibhGO1UBoMcm4SvYxuEMD+YOzUVp0RtjqWGUBCAaZwaXIMPkSDY/Nf2OiMmxpSy
 O3nePbV6Pv58DiNCvffK+W9XbLdjBrA8+jfMJN625JXI0g3qTO/YsojF24jCOE6zNIzyjmT5g
 nNlXC6y9mnJlSvLlOMvAw++wjVebIB7mh1DDpv+wTNGMk4sTj/7AVMgiGttqfPSKJTCZZ6Qae
 zDrGoivmB9ePAS1UTer6uGSHRB4c2XULews+jrA6nFME+yzKjoue3vejW2GrsueQNHteqQ4Z5
 I1Z2HZQL6lutpMHvnDQfvi06p5Rg7zK76px2+CEj8QQ==



=E5=9C=A8 2025/1/19 15:02, Dave T =E5=86=99=E9=81=93:
> It's Arch Linux and kernel version 6.12.6-arch1-1
>
> Here is the output of btrfs check. (FYI - BTRFS runs on top of
> dm-crypt, and I passed the "--readonly" flag to "cryptesetup open"
> before running this. I guess that is why it says "log skipped" below.)
>
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> ref mismatch on [300690628608 16384] extent item 10, found 9
> data extent[300690628608, 16384] bytenr mimsmatch, extent item bytenr
> 300690628608 file item bytenr 0
> data extent[300690628608, 16384] referencer count mismatch (parent
> 404419657728) wanted 1 have 0
> backpointer mismatch on [300690628608 16384]

This is the root cause. data extent 300690628608 has one bad parent that
can not be found.

Unfortunately I can not find related item in the tree dump to verify if
it's a bitflip or not.

Anyway, I'd still recommend a memtest to rule out any possible bad
hardware RAM problems.

After that, this extent tree corruption should be able to be repaired by
"btrfs check --repair"

> ERROR: errors found in extent allocation tree or chunk allocation
> [4/8] checking free space cache
> [5/8] checking fs roots
> root 336 inode 69064 errors 1040, bad file extent, some csum missing

Those are minor problems and can be ignored.

Thanks,
Qu
[...]
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/int_luks
> UUID: a7613217-9dd7-4197-b5dd-e10cc7ed0afa
> found 786786136064 bytes used, error(s) found
> total csum bytes: 750877664
> total tree bytes: 4204183552
> total fs tree bytes: 2994487296
> total extent tree bytes: 367149056
> btree space waste bytes: 721104463
> file data blocks allocated: 2761159544832
>   referenced 1384698466304
>
> On Sat, Jan 18, 2025 at 11:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/1/19 14:17, Dave T =E5=86=99=E9=81=93:
>>> Here is the full dmesg. Does this go back far enough?
>>
>> It indeed shows the first error. But it doesn't include the kernel call
>> trace shown in your initial mail:
>>
>> [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000010
>> [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
>> 000074c0e2887ced
>> [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI:
>> 0000000000000003
>> [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09:
>> 0000000000000000
>> [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
>> 0000000000000000
>> [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15:
>> 0000000000000000
>> [  +0.000004]  </TASK>
>> [  +0.000001] ---[ end trace 0000000000000000 ]---
>> [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -22
>>
>> I guess that's no longer in the dmesg buffer?
>>
>>
>>> I will run the "btrfs check --readonly" soon.
>>>
>>> # dmesg
>>
>>> [  +5.340568] BTRFS info (device dm-0): relocating block group
>>> 299998642176 flags data
>>> [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
>>> move data extents
>>> [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
>>> for logical 404419657728 length 16384
>>> [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
>>> for logical 404419657728 length 16384
>>> [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -5
>>> [Jan18 17:31] netfs: FS-Cache loaded
>>
>> So far that balance is trying to balancing a tree block at the next
>> block group. That definitely doesn't look correct.
>>
>> Please also provide the kernel version.
>>
>> Thanks,
>> Qu


