Return-Path: <linux-btrfs+bounces-8190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4E983D42
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 08:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A162838B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33204182A0;
	Tue, 24 Sep 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eafJi+Uv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C917BBF
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160249; cv=none; b=CRnru5zXidga0/vSXKIo3h2VrJjcqCMyo/lDXfaNi6s+DrEK29Aqgwc1d5bJmTG//7HY23qoFbkM5LxW6nBy8N7qjKsMJnLHQROrxcafkF+bMNpyu5CZxGJuh0lP+19H8Pf2F469OKWFJ1uPnW1Huq4K/2C4MyXm5CNOVzRdZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160249; c=relaxed/simple;
	bh=qvIpOZ/bgn705/+KQsuIkBJK1iqXEZYzbQj70+qMx1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rg8BQoP+/76ntGRPtZBNSIq9mZar7uWC1nVJLbDjb0raW0EKbFekKnA1fJVXs5Rhhqtm8vurP4V5GJWh7mHH7XqrEoDpt/E3HGhdUf+wagfhAUBN0icU3FsQEkgehJ6x3SQyVGUZ1vPvI49l8IFSItIBAZfj2Xyoy8/75TdyA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eafJi+Uv; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727160244; x=1727765044; i=quwenruo.btrfs@gmx.com;
	bh=DA+M28uHseIQfdkPD509RrFKS8Q2TBaTImefaFqPXJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eafJi+UvhDfpcOFb7Zx3lMaxKdy95rIIQ1jqNo4cgUBtaegPxPFU81nqYp1XDJqH
	 wlzT7DInhoqXMWk4niy0fvnYNWUy2qIsxOw+/Vvmu8mh79CcI/v/fbGlO+7+ho1nz
	 zUJiTxHKMHxSBYBv9HkmWvag5q8YUeElc4+Lt56n3zWakwx/CGD/jzLd7zLaHhg2X
	 hYGAHsDrAnBmRu+ymv1BwmruHjVn+FgWUC5aEz7AvoUpQxPrb5wiIY9RDXWKPskzu
	 i7zdelIQHQxiiEMM4buOg9+LOjjv7pNFpVBhJU71HjUSqUaWXkKPog2XTxlI8OEkO
	 7Cc69FbvT5r3f7WWzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZCb5-1sOPaf05QH-00OEYF; Tue, 24
 Sep 2024 08:44:04 +0200
Message-ID: <be2e4159-d8ae-4170-83c0-a79354cec001@gmx.com>
Date: Tue, 24 Sep 2024 16:14:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem corrupted
To: Dave T <davestechshop@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
 <a9793ad6-1254-43d3-8a78-6bad7a27eaf1@gmx.com>
 <CAGdWbB4-4KkN_1P8WbnbkSM7mXfAh6CQhc8KHDHTvRFwA54hiQ@mail.gmail.com>
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
In-Reply-To: <CAGdWbB4-4KkN_1P8WbnbkSM7mXfAh6CQhc8KHDHTvRFwA54hiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q5v1aKKhm8MM6YzVKamMQx0bC4GRQoYXq9BtFamXrH7CaUqmsva
 QbW3QTILKUTP94MTq1YD7BUo5zFmh0NGMiLk6DmBR3+CrARDRt22P82EqYDV+qGEQvMl4+j
 58b9wQ3pyiRr6CWyEQf3pcTKDfYbXz0WmcTotWgeUMaDnQvKn4rl3unTSTeH5INFpAtkYdh
 l6/bvxrHxXR5E71y96TrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fr0Zmz1q8sw=;rzo84KVsPiz5wpuJnuWD17Nqp6v
 hnO7NO5Z255FwABuNxfBEGTqO1QjXYR7DWhkwVs0QRoJCZsNBidMDVU2/Tqsnln2JQnhPDB42
 sIWhCejaOXYR0cj9RjKt8M5Yj6/2Zu+jNDOVp0gapUey1xg7IEWCnCTXXyLCRqg3G5BC85ZQ6
 YO/lv/OxaRZkI0c8eXr+3s+V7jANJ7VIa2xtAqqxPoTDznMvOsrrsI4fQDtikjHxFy8VU3SbV
 fAFWEruEEipPvEDgLo29DLxCl7kRUajFZOiGhJTJs2X4+0vYrr6Hz214p+k6UvhtNq4R7uT13
 qya9WqEsm0voWgOXDQRSJTM04QcRRmdBZphKWjCvzvN1daGkFls3mXY9FF1KPSmyfSa7/B+0t
 20Z+ubv1NVnUkheZpM5cff2cLqV/sicPK4HjFvnsloSavee+ZDHzcTacNqlSa8fhmtqVzqNv0
 e3mN0GzoJ3NWUzmf3A8om098y1mpJthco100Yjt/OT8PWemr3R1sQDUSCrcINwrXGgnbG2v6c
 dHiRqN8axtN5M+7kEiPPxIKz20ickcEjIGsMhfZT06RTzVpoEiQ+YpdjahydGF97Htfl90y66
 D8NvSNo4wKX4SmKAwVhr4Jdj14yfDPgvJZXJqEp8toe/6h69vO+i/2qCALE8X0VUI5ezvXKvi
 rWUYcym0A404Fmw59VFZDjfW+wgHnn/bGVH8otr9yYivXPK54Dyu5rtwpnFpFF4OYa88rnE91
 xWk3oP5yAwkO1dGTAMdZCf3TgUU69DQUkbmtbcqv6iD5GsjlMArh/LX4AazBI7pFfjK0V97UP
 +rsvYnD9WhD35iTOwRf3KAEg==



=E5=9C=A8 2024/9/24 15:57, Dave T =E5=86=99=E9=81=93:
> [  +0.000001] ---[ end trace 0000000000000000 ]---
[...]
> [  +0.000003]   item 21 key (227177795584 168 61440) itemoff 13596 items=
ize 209
> [  +0.000003]           extent refs 13 gen 135 flags 1
> [  +0.000002]           ref#0: extent data backref root 490 objectid
> 426346 offset 0 count 1
> [  +0.000003]           ref#1: shared data backref parent
> 18014665013673984 count 1
> [  +0.000003]           ref#2: shared data backref parent 267180048384 c=
ount 1
> [  +0.000003]           ref#3: shared data backref parent 267147673600 c=
ount 1
> [  +0.000003]           ref#4: shared data backref parent 267079155712 c=
ount 1
> [  +0.000002]           ref#5: shared data backref parent 266967482368 c=
ount 1
> [  +0.000003]           ref#6: shared data backref parent 266640375808 c=
ount 1
> [  +0.000003]           ref#7: shared data backref parent 266567467008 c=
ount 1
> [  +0.000003]           ref#8: shared data backref parent 266540056576 c=
ount 1
> [  +0.000003]           ref#9: shared data backref parent 266489921536 c=
ount 1
> [  +0.000002]           ref#10: shared data backref parent 266355146752 =
count 1
> [  +0.000003]           ref#11: shared data backref parent 254191419392 =
count 1
> [  +0.000003]           ref#12: shared data backref parent 253777068032 =
count 1

Above the is the offending slot of the bytenr.

At ref#1, the slot has bytenr 18014665013673984, but our target is
266504192000.

hex(18014665013673984) =3D 0x40003e0ce34000
hex(266504192000)      =3D 0x00003e0ce34000

This is a strong indication of bitflip.

Thus it's strongly recommended to do a memtest before doing anything.
Please report back about the memtest result.

Thanks,
Qu

>>>       [  +0.000001] BTRFS critical (device dm-3 state EA): unable to
>>> find ref byte nr 227177795584 parent 266504192000 root 490 owner>
>>>       [  +0.000018] BTRFS error (device dm-3 state EA): failed to run
>>> delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
>>>       [  +0.000017] BTRFS: error (device dm-3 state EA) in
>>> btrfs_run_delayed_refs:2207: errno=3D-2 No such entry
>>>
>>> The drive is a Samsung SSD 970 EVO Plus 2TB.
>>>
>>> Overall:
>>>       Device size:                   1.82TiB
>>>       Device allocated:           300.04GiB
>>>       Device unallocated:            1.53TiB
>>>       Device missing:                  0.00B
>>>       Device slack:                    0.00B
>>>       Used:                        299.07GiB
>>>       Free (estimated):              1.53TiB      (min: 1.53TiB)
>>>       Free (statfs, df):             1.53TiB
>>>       Data ratio:                       1.00
>>>       Metadata ratio:                   1.00
>>>       Global reserve:              398.55MiB      (used: 16.00KiB)
>>>       Multiple profiles:                  no
>>>
>>> Data,single: Size:298.01GiB, Used:297.82GiB (99.94%)
>>>      /dev/mapper/userluks  298.01GiB
>>>
>>> Metadata,single: Size:2.00GiB, Used:1.25GiB (62.51%)
>>>      /dev/mapper/userluks    2.00GiB
>>>
>>> System,single: Size:32.00MiB, Used:48.00KiB (0.15%)
>>>      /dev/mapper/userluks   32.00MiB
>>>
>>> What is the recommended course of action given this error?
>>>
>>> What other info do I need to share, if any?
>>>
>>> Thank you!
>>>
>>


