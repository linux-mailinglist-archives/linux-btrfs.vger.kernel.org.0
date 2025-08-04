Return-Path: <linux-btrfs+bounces-15835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240C5B19ECE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB81768DB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623022DF95;
	Mon,  4 Aug 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ok4HcWrn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9986E1EEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300004; cv=none; b=qyRvCkK+7aLXJGgO/wmqUFyxlQxfhxVG2dMcZN53nl/qDk7E6Kt70KyQE3YbXoiR3CxJbY+5AQBpzIUYFaF/WMlgDVFkfEj+N55STswWQj7H1EWDU1h7lQCD3/KbWnBwaRoOsaWWH4izNohgP+rJcJQyMMK7qP4tTrChS2gdnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300004; c=relaxed/simple;
	bh=OY6p7dGGHCDRCd+T8FdXPlZqzjFtrMzaKtab3lXbyJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YUiYNUf8TtPyYzCHkxAAuz20NukYb3eDSrO9I0nitI5RPQuSy9JPQWKl82a1oXt8lOIvmNv9CU27nkGu0cdu7H7gsMi47wO7QROttacw5SLhujYA9vEyzqze9huIpPDN0A6+FYDMRfgX/OlN0hnXRcacAWuxQPjL4n2/mlmk3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ok4HcWrn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754299965; x=1754904765; i=quwenruo.btrfs@gmx.com;
	bh=OY6p7dGGHCDRCd+T8FdXPlZqzjFtrMzaKtab3lXbyJc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ok4HcWrn1VUIeQO3+PWGESc9JKe6/Bru3UntZMNkmWsXRkjMJOJnjNP+sYTvNa6+
	 6r8OGHxfCNzpkAzugZ70EFyO9Q8/3G1QIUdqbbVz9Qcv6e4FXHQZdcRnP+EcrQEdR
	 5h8vp9GWOsiJWVt7P0XjDsoqCJixDqgN0RnvNkhNI4VoUdcwH4+QKMdO1dwMRXmPr
	 YHDv/Cl9GlfNpsnHF/c8agoiVylXadRxnBvJD3ys+olSLN8W/KX6/NSbH1fIrTvfm
	 nvaQnAz/HxMndJXLqCJClVn4HdWE1TxLqKczEiBb3Lkk53Towd4hM/Cw/NeLRPF3N
	 fvzxKT/X5TYgwBPuRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHGCu-1unD8G3I48-00Cdoo; Mon, 04
 Aug 2025 11:32:45 +0200
Message-ID: <bc8ecf02-b1a1-4bc0-80e3-162e334db94a@gmx.com>
Date: Mon, 4 Aug 2025 19:02:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
 <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
 <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
 <184c750a-ce86-4e08-9722-7aa35163c940@oracle.com>
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
In-Reply-To: <184c750a-ce86-4e08-9722-7aa35163c940@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6qAEiXjefofwdCY3SOwzBp8vg60idUi0sk+SQmfpNNYHxkgoyKs
 rQICE9FftM4M1INQBm3I3YxZcZT8n5htnvFaCSlWMMZQIPAGaqpqS7UagGWyXNr2cXRLS4U
 4oYQPm0d+RbZsSXfvEpHIh3ENwRs9ILiDe6QmvsKqB2hNTDMUQ+ddH6roxFgpZ7eyvsZvp9
 I+bDLNvOkWT4ZgXHxpjng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q352uJdC9L8=;1HN6Y3OUs9VR6/SZWn4HR9DV3WT
 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
 Uw==



=E5=9C=A8 2025/8/4 18:50, Anand Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 4/8/25 16:24, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/8/4 17:09, Anand Jain =E5=86=99=E9=81=93:
>>>
>>>
>>> On 3/8/25 07:35, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2025/8/2 16:41, Qu Wenruo =E5=86=99=E9=81=93:
>>>>> Hi,
>>>>>
>>>>> There is the test case misc/046 from btrfs-progs, that the same=20
>>>>> seed device is mounted multiple times while a sprouted fs already=20
>>>>> being mounted.
>>>>>
>>>>> However after kernel commit e04bf5d6da76 ("btrfs: restrict writes=20
>>>>> to opened btrfs devices"), every device can only be opened once.
>>>>>
>>>>> Thus the same read-only seed device can not be mounted multiple=20
>>>>> times anymore.
>>>>>
>>>>> I'm wondering what is the proper way to handle it.
>>>>>
>>>>> Should we revert the patch and lose the extra protection, or change=
=20
>>>>> the docs to drop the "seed multiple filesystems, at the same time"=
=20
>>>>> part?
>>>>
>>>> BTW, reverting will not be that simple anymore.
>>>>
>>>> The problem is we're now using unique blk dev holder (super block)=20
>>>> for each filesystem.
>>>>
>>>> Thus each block device can not have two different super blocks.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Personally speaking, I'd prefer the latter solution for the sake of=
=20
>>>>> safety (no one can write our block devices when it's mounted).
>>>
>>>
>>> This is expected to work- it's a key feature.
>>> ------------
>>> $ mount /dev/sda /btrfs
>>> mount: /btrfs: WARNING: source write-protected, mounted read-only.
>>> $ btrfs dev add -f /dev/sdb /btrfs
>>> $ mount -o remount,rw /btrfs
>>>
>>>
>>> $ mount /dev/sda /btrfs1
>>> mount: /btrfs1: /dev/sda already mounted or mount point busy.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmesg(1) may have more info=
rmation after failed mount system=20
>>> call.
>>>
>>> [130903.161395] BTRFS error: failed to open device for path /dev/sda=
=20
>>> with flags 0x23: -16
>>>
>>> $ mount -o ro /dev/sda /btrfs1
>>> mount: /btrfs1: /dev/sda already mounted or mount point busy.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmesg(1) may have more info=
rmation after failed mount system=20
>>> call.
>>>
>>> [130943.678745] BTRFS error: failed to open device for path /dev/sda=
=20
>>> with flags 0x21: -16
>>> ------------
>>>
>>>
>>> One workaround is to mount all devices first, then add the sprout.
>>> But that's not practical, as the full list of mount points may not be=
=20
>>> known ahead of time.
>>>
>>> ------------
>>> $ mount /dev/sda /btrfs
>>> mount: /btrfs: WARNING: source write-protected, mounted read-only.
>>> $ mount /dev/sda /btrfs1
>>> mount: /btrfs1: WARNING: source write-protected, mounted read-only.
>>> $ btrfs dev add -f /dev/sdb /btrfs
>>> $ mount -o remount,rw /btrfs
>>> $ btrfs dev add -f /dev/sdc /btrfs1
>>> $ mount -o remount,rw /btrfs1
>>> ---------------
>>>
>>>
>>> BLK_OPEN_RESTRICT_WRITES appears to apply per block device or possibly
>>> per FSID (I'm not sure).?
>>
>> That's one factor, but not all.
>>
>> The problem is the new block dev holder. One can only open the bdev=20
>> multiple times if the new holder is the same as the existing one.
>>
>> Now since the block device will have a super block as the holder, it=20
>> means it's impossible to have one block device belonging to two or=20
>> more different filesystems.
>>
>>>
>>> Since seed devices are read-only, a second read-only mount should have
>>> been allowed.!!
>>
>> I'd say the original design is too naive, allowing all mounted btrfs=20
>> devices to share the same holder (fs type, which is never a common=20
>> thing).
>>
>> Previously we do not even properly implement all the device event=20
>> handler, but now consider a situation, that the block device is going=
=20
>> to be frozen.
>>
>> Now which filesystem should be frozen?
>>
>>>
>>> After sprouting (device add), the FSID changes.
>>> Looks like we need to inform the VFS of this update (guessing)?
>>>
>>> Will work on a fix, appreciate the report.
>>
>> Good luck, a good fix won't come up so easily.
>>
>>>
>>> Thanks.
>>>
>>> PS:
>>> I remember this (some other aswell) patch on the mailing list,
>>> it went in pretty quickly (3 days).
>>> I couldn=E2=80=99t keep up with the pace. I suggest 2 weeks sock time.
>>
>> The problem is not the new patches breaking the behavior, but the old=
=20
>> behavior is never solid.
>>
>> Let me be clear again, there is no fs except btrfs, allowing a block=20
>> device belonging two different mounted fs.
>>
>> We're abusing the block device holder, and just never realize it.
>>
>> Now it's time for us to do the choice, continue the abuse and never=20
>> act like a normal fs, or accept the behavior change and become a more=
=20
>> normal fs.
>=20
>=20
> Thanks for the comments.
> Our seed block device use-case doesn=E2=80=99t fall under the kind of ri=
sk that
> BLK_OPEN_RESTRICT_WRITES is meant to guard against=E2=80=94it=E2=80=99s =
not a typical
> multi-FS RW setup. Seed devices are readonly, so it might be reasonable
> to handle this at the block layer=E2=80=94or maybe it=E2=80=99s not feas=
ible.

Read-only doesn't prevent the device from being removed suddenly.

You still didn't know that the whole fs_holder_ops is based on the=20
assumption that one block device should only belong to one mounted fs.

And I see that assumption completely valid.

I didn't see any reason why any sane people want to mount the sported fs=
=20
and the seed device at the same time.

If the use case is to sprout a fs based on the seed device multiple=20
times, it's still possible, just unmount the sprout fs before mounting=20
the seed device again.

I didn't see why you're stubbornly insist that mounting sprout and seed=20
device at the same time is a hard requirement.

>=20
> We did have another commit reverted recently. A two-week soak time
> sounds fair to me.

You need some solid reason to revert.

Just to revert to an initially insane behavior doesn't sound sane to me.

Thanks,
Qu

>=20
> Thanks, Anand
>=20


