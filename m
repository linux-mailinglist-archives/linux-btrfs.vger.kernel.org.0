Return-Path: <linux-btrfs+bounces-11007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7065CA1608F
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 07:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91E0163E79
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BC1779B8;
	Sun, 19 Jan 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tKOYafvN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40E29415
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737268020; cv=none; b=ikqLelgqws+Q7jG/0GJ6FF5C7puwMWPTvfKYM6YDUbmOulsDIEfRaJYjq+XB6BhQsRXF+bMouYf0DWwOQRlGCv8QCTfdQr5fgovrszxwv/+C8V/9R64IHg99R2Z221/R60NScOBfhc6H99oMz+FF73VJqpoblbXzesvXdoLfVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737268020; c=relaxed/simple;
	bh=KHeGtTA00tBh6O+Xt5eHJOZ8pfpYRCAMLJ2lmNqhDcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYnz5YTk+xIawXnoLSApHrGu0Il0LOVPLKqFsehylBRKykJTDcNJZplFw81BvI8RkjWLH/gHkcFGBV/PltLDhPZg/WhdhSOYegSB5vGxLsP8YN++nyPUBLuSCjh3BpHHWLVoRwY0WliYPyiYysNAuX8/KGxP/XF1r8tw2nATcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tKOYafvN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737268016; x=1737872816; i=quwenruo.btrfs@gmx.com;
	bh=DYBFDHUP+VIXqpG0QacbzGJt8ua1YpM84q0o5kM8Kqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tKOYafvNX96t8J7ZGIivrpOIiEV3Zze3EooUWaLhBpUkria0DAeLcKfZ0tuR47Ee
	 kG1+sWuIi1dAZkT0kU8CR/XGgSfllS8USKLdCajBityD3uFSFzPOgpEDug1W+wsBA
	 7g87mGIqGuEx4tqqlN6oQ+F3rbg6YQ1iJ8PjY2qY9tgv4UAH1o2Hzk070BVbQ6VS8
	 /TdDdimBuIKLr/MBiNqwJMnlmAmB5gCUxkRVk5EJJhYOaWR9xy3oLm47ZXed7EqAG
	 SrrlxaDLv/qPRRVFXZwk7w+Z8j9J3VAjTK4hM7A33mqpowYTL7rRvroOV6/ot/yFk
	 bjXfyp+lIVrrPItwew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7KU-1tgZUr3GbC-00CwRi; Sun, 19
 Jan 2025 07:26:56 +0100
Message-ID: <cf1b590c-6ffa-4c92-bc39-7d72a4282d28@gmx.com>
Date: Sun, 19 Jan 2025 16:56:53 +1030
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
 <b2267eca-5528-4cec-8956-d0f666f79c9c@gmx.com>
 <CAGdWbB46VJrjDMUxcNmeXsAfxq+YCD52v4pKcHK7OjpRpgc8rA@mail.gmail.com>
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
In-Reply-To: <CAGdWbB46VJrjDMUxcNmeXsAfxq+YCD52v4pKcHK7OjpRpgc8rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SJsBT36vijwi0SOf3CoqbhnQTNqa53NM8jDtAbgxP93gbFaIjB+
 qFEAzITVsaTm+6eUE5vBmyqfI9MnMnRsGeclhUKr26Gqs8bdW+O+lqpG1fy0r63D8NLwUVH
 ARI2BLLxX/4KSdXfpF0JxxlUe4jSJx/VyUuY+AWCDo/AjsQbcNPQzdAdSbqcLwEcL46kKiH
 S0op8RDvv5rcUzYzPbPZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dIVy82G3DH4=;LAGdYUU+R7gBdvuwJHveVJzTy2s
 RAuBhGt8lK47of1PhihFlzpHgazjMIlG8mMl71SovsbMhS4w5P+RAKkwhdl6SgCxPF6ShLa9f
 AnMxGhz3Kt79twSbOHyY+qKlC9LCVkVvjU/OE+lbpmKvxZioJn/cY7G/uuydeQXDkOXb8L6Pr
 i+WpO0uIlEf5Lho/D/kL7RZlCkNJ4TraBmkoeyB9sYAjoUWXPZ+XMyu1QxYHD4PoH4NaG7fi3
 +x88gMdXZb7ACfmiEeK4dpmWKnlTpTliOWvhmFF3aVfnzA3X5SZU5sOJwXLWatjZ8Xpcx9m4Z
 PGqAzP0CYvQEE7ZXaAPolTDFsByiamkCQqfM2Q3gNfxVT/RrGnEEqOVa7mwV+DekGReSqZphx
 vhq+kbJZv1s/dRlYnVvdeD1nId85fN7l/5uaQ8BXoHlyJfaW5Qovch+9EBtrVMeSoMdUto6ZK
 MTqGBZeCatirOXh+X4Img6SFe5oMA56GY9aW1qiLQjfLDJzIEtpMp1B8qfdFfKCeMe1QvZV2c
 qK4WFce7EEXV+TzQqwKcpLZuRmQiQmwaUKu38BBggy9SnZrQzc1M21OYhM8caUkWL0r863ipP
 jOVVb9w+PqvdvE2KZf19TmtGzI/9l91k1TmVuU2c60EcdUYr690rsndJy1qbQfIP8xiyBH2RO
 O7vQOq+H1KZV4p104zj7p9/xnzObInt1DzHHLeT3oqmuSYMVKyfeOOTgcm6zgsQBj7YAPiwrz
 +v3LXXw3ppTGnEOy7PMREWdvSe61st6I+ZdvJyEEOAymODtPGvRpazia/O2ysDjAxKCzPx5kt
 8qfx29wfB/KMQgaonLIGpEK29hRPZUtAIzs6G+DL95T1IJoeja78HYTupolf6Egi5AwYoqk6p
 FJOrHP9mh63ceaCdu+HqANM1QoiYWbOg3f4ROW3I9a8mVNs5f0ZtPiAJ3sWqWoxpYwLQ1GGeU
 xjt/WpVWSv2kHr8CFgVt5LtOy/z6CXILnu2MuQjNXbU3huCwTitkUNXgLa9s9El9QtrNaK6sK
 iIW1XWo1eREyO4cPdeZekm6KGrNkZzy5qSWOMw1uwhNNS98celFEsREDAb4Pbl/0PW5JtnKUO
 stM8EaDH5/ebuWp5E5w3ZiQG7SyREpDg9zqTAM9dLV6wOpYqMrwMBnLJGcsJ30wazucTjMGBa
 uuiwUE+jx6z55/5wHNxI70Fcz/1FHjQU65b2XpBQu5A==



=E5=9C=A8 2025/1/19 16:51, Dave T =E5=86=99=E9=81=93:
> Thank you. I will run the btrfs check --repair" now.
> I guess I should also change the metadata to duplicate from single, righ=
t?
>
>> Anyway, I'd still recommend a memtest to rule out any possible bad hard=
ware RAM problems.
>
> The laptop doesn't have ECC RAM. Is it even worth it to run memtest?

Still recommended, as if it's really bad RAM and it's soldered, you
should make sure that you didn't run btrfs check --repair, which is a
dangerous operation with possible unreliable memory.

If that biftlip happens again during "btrfs check --repair", you have a
very high chance to corrupt the fs, meanwhile you originally had a very
good chance repairing it.

And even if you can not replace the RAM because it's soldered, you may
still use the bad memtest result for an RMA/replacement.

Even for the worst case, professional 3rd party repair shops should
still be able to replace bad memory chips.

Thanks,
Qu

>
> On Sun, Jan 19, 2025 at 1:19=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/1/19 15:02, Dave T =E5=86=99=E9=81=93:
>>> It's Arch Linux and kernel version 6.12.6-arch1-1
>>>
>>> Here is the output of btrfs check. (FYI - BTRFS runs on top of
>>> dm-crypt, and I passed the "--readonly" flag to "cryptesetup open"
>>> before running this. I guess that is why it says "log skipped" below.)
>>>
>>> [1/8] checking log skipped (none written)
>>> [2/8] checking root items
>>> [3/8] checking extents
>>> ref mismatch on [300690628608 16384] extent item 10, found 9
>>> data extent[300690628608, 16384] bytenr mimsmatch, extent item bytenr
>>> 300690628608 file item bytenr 0
>>> data extent[300690628608, 16384] referencer count mismatch (parent
>>> 404419657728) wanted 1 have 0
>>> backpointer mismatch on [300690628608 16384]
>>
>> This is the root cause. data extent 300690628608 has one bad parent tha=
t
>> can not be found.
>>
>> Unfortunately I can not find related item in the tree dump to verify if
>> it's a bitflip or not.
>>
>> Anyway, I'd still recommend a memtest to rule out any possible bad
>> hardware RAM problems.
>>
>> After that, this extent tree corruption should be able to be repaired b=
y
>> "btrfs check --repair"
>>
>>> ERROR: errors found in extent allocation tree or chunk allocation
>>> [4/8] checking free space cache
>>> [5/8] checking fs roots
>>> root 336 inode 69064 errors 1040, bad file extent, some csum missing
>>
>> Those are minor problems and can be ignored.
>>
>> Thanks,
>> Qu
>> [...]
>>> ERROR: errors found in fs roots
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/mapper/int_luks
>>> UUID: a7613217-9dd7-4197-b5dd-e10cc7ed0afa
>>> found 786786136064 bytes used, error(s) found
>>> total csum bytes: 750877664
>>> total tree bytes: 4204183552
>>> total fs tree bytes: 2994487296
>>> total extent tree bytes: 367149056
>>> btree space waste bytes: 721104463
>>> file data blocks allocated: 2761159544832
>>>    referenced 1384698466304
>>>
>>> On Sat, Jan 18, 2025 at 11:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx=
.com> wrote:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2025/1/19 14:17, Dave T =E5=86=99=E9=81=93:
>>>>> Here is the full dmesg. Does this go back far enough?
>>>>
>>>> It indeed shows the first error. But it doesn't include the kernel ca=
ll
>>>> trace shown in your initial mail:
>>>>
>>>> [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
>>>> 0000000000000010
>>>> [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
>>>> 000074c0e2887ced
>>>> [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI:
>>>> 0000000000000003
>>>> [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09:
>>>> 0000000000000000
>>>> [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>> 0000000000000000
>>>> [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15:
>>>> 0000000000000000
>>>> [  +0.000004]  </TASK>
>>>> [  +0.000001] ---[ end trace 0000000000000000 ]---
>>>> [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -=
22
>>>>
>>>> I guess that's no longer in the dmesg buffer?
>>>>
>>>>
>>>>> I will run the "btrfs check --readonly" soon.
>>>>>
>>>>> # dmesg
>>>>
>>>>> [  +5.340568] BTRFS info (device dm-0): relocating block group
>>>>> 299998642176 flags data
>>>>> [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
>>>>> move data extents
>>>>> [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
>>>>> for logical 404419657728 length 16384
>>>>> [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
>>>>> for logical 404419657728 length 16384
>>>>> [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: =
-5
>>>>> [Jan18 17:31] netfs: FS-Cache loaded
>>>>
>>>> So far that balance is trying to balancing a tree block at the next
>>>> block group. That definitely doesn't look correct.
>>>>
>>>> Please also provide the kernel version.
>>>>
>>>> Thanks,
>>>> Qu
>>


