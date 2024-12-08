Return-Path: <linux-btrfs+bounces-10132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66019E8822
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B02281276
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 21:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74C19340D;
	Sun,  8 Dec 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DYZmmUrW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41A18453E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693807; cv=none; b=nA1tDYV3BCWh1pMTp5THLduIs5YwRYJMVTpCgyrlVi73/3imSKKoEmHxU9Cgw1Dy4zQLS/D86kOxG0f8R9GlWU1nwgZJu2qttXAqZliDXMAYAzZaVayKMxLyiWs0YA2WcDMw6BBiOwvoKa+dIAT3e0wBUsnsW0WEwwRoZX43vFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693807; c=relaxed/simple;
	bh=W6YK+XyHY8u/G8lYJQmZ8yTLkiR0bvH/v2B5Ezbwd4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcgt9Wb5avmaHUdXU7ONv7ql8a5S2JhOJR4mAqxw7p0DZQuWDJDuzeCvtXLzOcgvNk109qa90QsJDjwzXnEXFCKHAhsRabKLDaiKBaLBvgeGZ0+d+FliY4xX/ooHmBHxdGvtcfPKkJboTZJLb2vmdBsSo7eYptGuXr5fP2zZAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DYZmmUrW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733693802; x=1734298602; i=quwenruo.btrfs@gmx.com;
	bh=WIduImZRSL/h6bysRbNnS+Dr8/2d76/QgEBToFPckik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DYZmmUrWT9GGw2tjbYTsQTYxpDneWR80FOaHprXK5sl951MC0wMzVO6Sm9Hxfh24
	 rWV36Sckca68efcg+pVbmwfwuzooLCzaLGs1CgvOHp364f5TRGhvtxynqpwCo6Zee
	 uAoLxPC0nKOttki8LOS2ozOLoPaCEaulgCEN6PjHfWW0E0Qc8jRWbVLxVWnI4kl2+
	 /tj/meTUPwuw3ifnXrY20ZICsFQRfjGKwjmIUyTv5MBxoxVcEKJ/vVm6Mn5HwLj4H
	 2W5dGepIExEuEQuIrx7zRiDkGtSHwmq3zwMvxlhDXQqo8T3a4LM4986I8YMW7qm5H
	 EgZRJ8t2QkWNtHFq4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McY8T-1tv7kS2oBh-00baaa; Sun, 08
 Dec 2024 22:36:42 +0100
Message-ID: <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com>
Date: Mon, 9 Dec 2024 08:06:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: j4nn <j4nn.xda@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com>
 <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
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
In-Reply-To: <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Vd8CrZcm6XNBRNAmuSUM1dM1eLWZlZlgvsGDhyPvKkb2zf2xcs
 I9hblixAclmL62A5U9IqmOKcDpjoRDudZ6tNnyp4vE1Zff+ORk9seOmrsYgZ0lHAYQTrTkY
 3td+kOVNv+iVh8GLKhIWP/9gbyIGzlBI494p7jQR/7n4eM+47B45w+U4ZlaCnLiHvVWhCla
 mJPADCgdPUIYyuG/ZI9QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4B5rZqvfPgU=;jD69Yhxm+KTcK1ZLfmKW3V7hv1A
 ptVkaaJ5UpUpviuW442SVGq6LdCENDznshWcrkcLICasznaYiiWXO27MNelNKWHvyB1hzyCm2
 LiTQUiRQ/zbFrf6CEATysObynlQi1qETbOlg0eBfgcbF1VA4nd7l6TicVW1VYWXE0b8I6zpB/
 aEmL+tLTJNzsO3aJ0T7b1N5BZ2AlGsv+qcNCrcmhi4OIREZETjlK2SdWhRY57wVwzA1i8dtng
 K0vZz6GYSm/q3G640gVaIBEcheUs1KLzXhrSCXhdYHHn5yEaF0+LE3bCitLF5MSvVUuKVtRKa
 8I91OPT/mZ8/VxZ3XRWv7cqtiB2UWHrTsVAUvHqShPI4wOXtY7RpQonn0NJyv8ZaFBy/yilYD
 Fj3yNHLcCy8Uywnh8JKgS4V3VEvBaE0Qz1VRUomI7/brmYvLPGcA0VngMhO4LwbI+h9+Mrkej
 RMEz2ZqvONeuZX2yWKFOZI7erXeqFMj9xsbUo58EaMv3//IK5CeTpybzVpWBTvkq85ccXOZ8n
 W1dTz0a1e5Lv10sC1rirC+l2sGrUCalIH6xYh1QAXnBVU/oNc94ir6Erm4SJpvn1Ohrvoagxw
 hPeLOKTenN35ocz8QrLmxrKmCZP5Cq/DI3/nIyfhTPglVOlOKvqdKR1Voqhqttgalrut6WwZU
 ertEYwX4CH+vuKdbZQkB9TmcsZhUMxppQ04PJAshzWISM9CTQ6RZA729QZ8+s9wSlc3P2dGU4
 V6XHstCSKuLaWaHlW0d+sA2s3knM2WvAtD68nojtlsSTShRZ/3SsiPA4KdOD0fGriZYhqr6ZB
 RwnaH91JxE+xAc5FU7gDgWdjc7sYrIJBsss+zw/mmzz8AtlOFHUJPKpXOBurmJ+lOr/WUsq6T
 zqUhZ4fdBrt7OZ/YRQU/9Q2o1dQPrpELCjiFbOrn5mQqIJ1sAolqEtlDwNX7UXr4nsF6Vl2su
 DWPWCtaMzPuijjt3jSGOHcbesWPdlvplayzA3DJq1XhgkiA23leUsYL9Hle4SMXGNW2xYgogd
 c66j9cLPYGo/Je34JO4/fpQiua9pSbz8Xpf+jOJmlLBACMjb2075TFjdhcjVrkvOz6jvmxIyj
 8knmpRMumu6mp0Q0bKkWgAsFMOGYkP



=E5=9C=A8 2024/12/9 07:55, j4nn =E5=86=99=E9=81=93:
> On Sun, 8 Dec 2024 at 21:26, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> =E5=9C=A8 2024/12/9 02:32, j4nn =E5=86=99=E9=81=93:
>>> gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bda=
ta
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>
>> This is a common indicator of -ENOSPC.
>>
>> But according to the fi df output, we should have quite a lot of
>> metadata space left.
>>
>> The only concern is the DUP metadata, which may cause the space
>> reservation code not to work in progs.
>>
>> Have you tried to convert the DUP metadata first?
>
> I am not sure how to do that.
> I see the "Multiple block group profiles detected" warning, assumed it
> is about metadata in RAID1 and DUP.
> But I am not sure how that got created or if it has any benefit or not.
> And what that DUP should be converted into?

Not sure either. But I guess in the past you mounted the device with one
disk missing, and did some writes.
And those writes by incident created a new chunk, and in that case the
new chunk are only seeing one writable disk, so it went DUP.


To remove it, you need specific balance filter, e.g

  # btrfs balance start -mprofiles=3Ddup,convert=3Draid1 /mnt/data

>
>> And `btrfs fi usage` output please.
>
> gentoo ~ # btrfs fi usage /mnt/data
> Overall:
>     Device size:                  16.00TiB
>     Device allocated:             14.51TiB
>     Device unallocated:            1.48TiB
>     Device missing:                  0.00B
>     Device slack:                    0.00B
>     Used:                         14.18TiB
>     Free (estimated):            923.95GiB      (min: 923.95GiB)
>     Free (statfs, df):           918.95GiB
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                 yes      (metadata)
>
> Data,RAID1: Size:7.19TiB, Used:7.03TiB (97.77%)
>    /dev/mapper/wdrb-bdata          7.19TiB
>    /dev/mapper/wdrc-cdata          7.19TiB
>
> Metadata,RAID1: Size:63.00GiB, Used:58.56GiB (92.95%)
>    /dev/mapper/wdrb-bdata         63.00GiB
>    /dev/mapper/wdrc-cdata         63.00GiB
>
> Metadata,DUP: Size:5.00GiB, Used:1.18GiB (23.60%)
>    /dev/mapper/wdrb-bdata         10.00GiB
>
> System,RAID1: Size:32.00MiB, Used:1.08MiB (3.37%)
>    /dev/mapper/wdrb-bdata         32.00MiB
>    /dev/mapper/wdrc-cdata         32.00MiB
>
> Unallocated:
>    /dev/mapper/wdrb-bdata        755.00GiB
>    /dev/mapper/wdrc-cdata        765.00GiB

You have more than enough space to remove the DUP chunks.

>
> gentoo ~ # lvs
>   LV     VG     Attr       LSize    Pool Origin Data%  Meta%  Move Log
> Cpy%Sync Convert
>   bdata  wdrb   -wi-ao----    8.00t
>   cdata  wdrc   -wi-ao----    8.00t
> gentoo ~ # vgs
>   VG     #PV #LV #SN Attr   VSize    VFree
>   wdrb     1   1   0 wz--n-   <9.10t <1.10t
>   wdrc     1   3   0 wz--n-    9.09t     0
> gentoo ~ # pvs
>   PV         VG     Fmt  Attr PSize    PFree
>   /dev/sdb1  wdrc   lvm2 a--     9.09t     0
>   /dev/sdd1  wdrb   lvm2 a--    <9.10t <1.10t
>
>
>>> Tried some balance as found example posted, not really sure if that sh=
ould help:
>>>
>>> gentoo ~ # btrfs balance start -dusage=3D10 /mnt/data
>>> Done, had to relocate 32 out of 7467 chunks
>>
>> The balance doesn't do much, the overall chunk layout is still the same=
.
>>>
>>> gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bda=
ta
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> Unable to find block group for 0
>>> ERROR: failed to clear free space cache
>>> extent buffer leak: start 7995086045184 len 16384
>>
>> Migrating to v2 cache doesn't really need to manually clear the v1 cach=
e.
>>
>> Just mounting with "space_cache=3Dv2" option will automatically purge t=
he
>> v1 cache, just as explained in the man page:
>>
>>     If v2 is enabled, and v1 space cache will be cleared (at the first
>>     mount)
>>
>> If you want to dig deeper, the implementation is done in
>> btrfs_set_free_space_cache_v1_active() which calls
>> cleanup_free_space_cache_v1() if @active is false.
>
> Ok, I just followed a howto for the switch.
> Did not know it is ok just with the mount option.
> Should it be safe to try it if I get the errors with the "btrfs rescue
> clear-space-cache v1"?

Since progs and kernel have different implementations on the space
reservation code, it's not that rare to hit cases where btrfs-progs hits
some false alerts.

If you balanced removed the DUP profile, then you can try "btrfs rescue"
again, just to see if it works and I really appreciate the extra
feedback to help debugging the progs bug.

Otherwise I believe it should be pretty safe just using "space_cache=3Dv2"
mount option.

Thanks,
Qu
>
> Thank you.


