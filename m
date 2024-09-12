Return-Path: <linux-btrfs+bounces-7956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0CB9761E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9542823D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562818950A;
	Thu, 12 Sep 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S2CT5fVR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA1910FF
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124075; cv=none; b=mxeLZvwqn05b1LU2d3biN3cmpEFNaF9OO8JI6s8AdHmtq4b2eBzKULwSDN0setrRhViTo6ept5r7N1kMTGuvKTlzI02Z5SrWP58ktQfL/BHgNsxcSytfL8dymiHlx5OK3nIdhcNgqDF3x/DR4rEAZ/AE4Nq0R5AP9nRx6F2lzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124075; c=relaxed/simple;
	bh=TrHB0KHW7gzZ5RvAvzGTDxvyV1rBx2yDYUA01gjfBic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsgP6q7TtjE8fcyi7Q4wU9LY4zzPXqgFmvUM6X4WTc8/6totyDTaEiIYrKiLRMmVBKAuDkIjv8TRlEWJANEnT2chGYBxcOhwluh+4XypZ9e/wjs36n4M+LOhC2e/Ihrh/MkKJkfdfPk6Movb1CZiVRn59GNLmQq3h5S+RPp+GeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S2CT5fVR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726124068; x=1726728868; i=quwenruo.btrfs@gmx.com;
	bh=ukltG0Tj7oScpBO7dT0Insfo1WaB7Lm9Qjej2LxnBEc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S2CT5fVRyY7qv9HEVZOKDHcbyTCyA/C9F79cnRbYjFyIgxq5q12IZdwVE+ZBEgQ4
	 WK2ZJPHQ9Bo+G5yOiwFxRCm104XOvZ14BpP8TvO2oT4X4abYXz+Xe5DUVIqwWuOlc
	 4dVpJH9mGVbBp7RB7E7lZu3QTJndvNax7YbQb9hINRotBw/5G1PJBhVGqdckkzGaL
	 35bis2NyH1hgDHkhEXomDnydhNA2OKNgGGA85LRyj1W/67WbDjs6EPaYgMQNReug9
	 59KkzdN2kOq9DjpTjOxym39YfkgXBBFdLOplBfYqGmWA71Vo4+kjrzkh0EdTKC31i
	 aoklD5FWxen2Uqb4+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5eR-1sYURq3fa1-00Thqo; Thu, 12
 Sep 2024 08:54:28 +0200
Message-ID: <5949cd07-59c8-4012-9865-0fdd3e9bcc6e@gmx.com>
Date: Thu, 12 Sep 2024 16:24:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
 <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
 <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
 <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com>
 <CAAYHqBbcDEuHQgG_iim84otLk-h9TioqNeT1BdiRSvEuwDJaZQ@mail.gmail.com>
 <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com>
 <CAAYHqBbfXj64BuY5kESx+8NJReqz-dzKeXHwf=vHKqYhKVwB3w@mail.gmail.com>
 <d96b8a47-3361-4226-b98a-67386bd6e7f4@suse.com>
 <CAAYHqBbcQwLqn4SBnKbimgttUbNxMRnH0AhwYKXJTJu1G=C9ZQ@mail.gmail.com>
 <d8619d5c-2780-41b2-bb48-4d208530f74b@gmx.com>
 <CAAYHqBaYW_6ooNnsmV4xa0_6oONdQw6rDswUk-jcEZipO1CNHg@mail.gmail.com>
 <30da9047-87a2-4d1f-b132-3153c74279d5@gmx.com>
 <CAAYHqBa2hD7UparX2mHo4jmt96Kpmb6TbYXiZpWdiE53ikzE2w@mail.gmail.com>
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
In-Reply-To: <CAAYHqBa2hD7UparX2mHo4jmt96Kpmb6TbYXiZpWdiE53ikzE2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5hByaPBT4eWao2BxYz13qnO7J3lfPAtpFV2uWAqxI4mVo5+hJ0v
 yEcqSoMN9eSZ9Q88I3IkwWILF3qUFGUjQaK51xOFPHQCdv99kxtndD1UxhtbDDL0D6mxIBQ
 c3U7EYeks/53ydIKl56m6B7Y4tMOz7nKF3Itt18Tb5xOT3SAndEkbZP15DKF8p8w6aI9NXn
 aU3ZAYfcVjqWjPnFHp38A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gxmqPsj/LpA=;eUlUHDoUCChIzZ1ntW9Sa/wYn+6
 aanLsMob892/dOT8aGmXrR0WfLwLK7txMqpCs9d+y11/Whe5f8Zni7mW1Ydk4IgT5o0ouxddT
 2CvNXe3oeMo5PDt/QEG6uhQhiJHRHtDsKvlw/AQvWDmf0X786IwA//rK9/NpVpmIY9Qq1/TWc
 lVKpez6WZUvoKHQKOjpQnOTsaKEWzTSK5eHWp7cTInnvJI2g4XngrmmwLRCXs8L7i53pcCAXo
 e5aCtueTlu9gi6ewINjEfadUPx6zJgdWBJzzSncY05+fjkOdQJ0Hyw4mxDEq2CCULarcnpLvW
 g2Qlno/JxkPBFIPzkUQbC1TeXqgs1ngrSLD08AN+TjSGlB0GBdJOXCK37rd6QdQOiZSqc8Q0m
 6poUqKofRLicAsZxxfdsKVsSEQBQbMKRI/bUP/hSbxaW+EkpY6lyN+H+MOjupLBGewJjKf+GD
 zEfxX6+Mh6/YLRCwzKoM2aZx+h4zL0UOlIqH6QvWDgTd5UkT4CoEFfC0THSHvWKVz8iQboXSh
 oYBRQbz3wif1GPMwKMgqnZsJ8rjbSdrykMH0DQbmKmH5x3q/860HsXQm97MkFEWY90TwgsIUq
 ByAcLOUOU3y9tvTb1NrG19xJTkHeJr4XlNBeNbhbhLv8ORS2HVYbsVl+QrB5o6W+oGW9oopLX
 qNXGu0/bGjlXVD3zQk/vEkg8uBFId3uf6E8L26WGDhRPz+8eKe+zeyOPAr3+h993WCbPTbZ8f
 9DIWW2dcqRo25OqNJiealvL2bS1SqgLOHA0JEbaJKwVb7TMFAClg+hvShoqwFiaQD7ena4eQy
 nCS3qSbWYUibAhjHXtA9H+kw==



=E5=9C=A8 2024/9/12 16:13, Neil Parton =E5=86=99=E9=81=93:
> I left a scrub running overnight and woke up this morning to find that
> the scrub is still running but the fs has become ro again.
>
> I have a new hdd waiting to be swapped in for sdc, how can I run a
> btrfs replace if the filesystem won't stay in rw?  dmesg output below
>
> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
> [    6.064021] BTRFS info (device sdc): first mount of filesystem
> 75c9efec-6867-4c02-be5c-8d106b352286
> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
> checksum algorithm
> [    6.064064] BTRFS info (device sdc): use zstd compression, level 3
> [    6.064079] BTRFS info (device sdc): enabling auto defrag
> [    6.064092] BTRFS info (device sdc): using free space tree
> [   76.647420] BTRFS error (device sdc): level verify failed on
> logical 313163105075200 mirror 2 wanted 0 found 1
> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105075200 (dev /dev/sdc sector 1145047360)
> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105079296 (dev /dev/sdc sector 1145047368)
> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105083392 (dev /dev/sdc sector 1145047376)
> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
> off 313163105087488 (dev /dev/sdc sector 1145047384)
> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
> [  260.968635] BTRFS error (device sdc): parent transid verify failed
> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116052480 (dev /dev/sdc sector 1145068800)
> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116056576 (dev /dev/sdc sector 1145068808)
> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116060672 (dev /dev/sdc sector 1145068816)
> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
> off 313163116064768 (dev /dev/sdc sector 1145068824)
> [ 2803.367836] BTRFS warning (device sdc): tree block 313163165237248
> mirror 2 has bad generation, has 12746888 want 12746900
> [ 2803.470703] BTRFS error (device sdc): fixed up error at logical
> 313163165204480 on dev /dev/sdc physical 586324377600
> [ 2803.470787] BTRFS error (device sdc): fixed up error at logical
> 313163165204480 on dev /dev/sdc physical 586324377600
> [ 2803.470847] BTRFS error (device sdc): fixed up error at logical
> 313163165204480 on dev /dev/sdc physical 586324377600
> [ 2803.470904] BTRFS error (device sdc): fixed up error at logical
> 313163165204480 on dev /dev/sdc physical 586324377600
> [40675.013231] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [40675.013337] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 1
> [40675.165371] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [40675.165477] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 2
> [40675.303196] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [40675.303301] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 3
> [40675.304132] BTRFS info (device sdc): scrub: not finished on devid
> 12 with status: -5
> [49340.321632] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [49340.321780] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 1
> [49340.424554] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [49340.424698] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 2
> [49340.498068] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [49340.498213] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 3
> [49340.505620] BTRFS info (device sdc): scrub: not finished on devid
> 15 with status: -5
> [65972.755968] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [65972.756043] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 2
> [65972.765683] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241
> [65972.765759] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 1
> [65972.802812] BTRFS critical (device sdc): corrupt leaf:
> block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D=
36864
> invalid data ref objectid value 65241

This is the same problem as the old inode cache.

It looks like the existing bug in "btrfs rescue clear-ino-cache" is not
fully deleting all ino cache.

You can go with this btrfs-progs branch:

https://github.com/adam900710/btrfs-progs/tree/ino_clear_fix

Which should fix the bug in "btrfs rescue clear-ino-cache", and clear
all ino caches.

Thanks,
Qu

> [65972.802887] BTRFS error (device sdc): read time tree block
> corruption detected on logical 334871673176064 mirror 3
> [65972.802977] BTRFS error (device sdc): failed to run delayed ref for
> logical 333252141424640 num_bytes 49152 type 178 action 1 ref_mod 1:
> -5
> [65972.803040] BTRFS error (device sdc: state A): Transaction aborted (e=
rror -5)
> [65972.803073] BTRFS: error (device sdc: state A) in
> btrfs_run_delayed_refs:2168: errno=3D-5 IO failure
> [65972.803110] BTRFS info (device sdc: state EA): forced readonly
>
> On Wed, 11 Sept 2024 at 11:31, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/11 19:37, Neil Parton =E5=86=99=E9=81=93:
>>> SMART looks ok on all 4 drives
>>>
>>> btrfs-map-logical -l 313163116052480 /dev/sdc
>>> parent transid verify failed on 332196885348352 wanted 12747065 found =
12747069
>>> parent transid verify failed on 332196885348352 wanted 12747065 found =
12747069
>>> parent transid verify failed on 332196885348352 wanted 12747065 found =
12747069
>>> ERROR: failed to read block groups: Input/output error
>>> ERROR: open ctree failed
>>>
>>> /dev/sdc is the drive that originally started giving tree and leaf
>>> errors 2 days ago so definitely looking to replace that with the new
>>> drive tomorrow once the scrub has completed.
>>>
>>> However the above map command for sda returns nothing, but for sdb and=
 sdd:
>>>
>>> btrfs-map-logical -l 313163116052480 /dev/sdb
>>> parent transid verify failed on 332196960649216 wanted 12747071 found =
12747073
>>> parent transid verify failed on 332196960649216 wanted 12747071 found =
12747073
>>> parent transid verify failed on 332196960649216 wanted 12747071 found =
12747073
>>> ERROR: failed to read block groups: Input/output error
>>> ERROR: open ctree failed
>>>
>>> btrfs-map-logical -l 313163116052480 /dev/sdd
>>> parent transid verify failed on 332197012652032 wanted 12747073 found =
12747075
>>> parent transid verify failed on 332197012652032 wanted 12747073 found =
12747075
>>> parent transid verify failed on 332197012652032 wanted 12747073 found =
12747075
>>> ERROR: failed to read block groups: Input/output error
>>> ERROR: open ctree failed
>>>
>>> I'm guessing this is due to raid1c3 on the metadata?
>>
>> Is the fs mounted? Or it means the fs is fully corrupted.
>>
>> I'm not aware of any way to do the same chunk mapping with a mounted fs=
.
>>
>> But since you're sure the problem is from sdc, then it should be fine.
>>
>> Thanks,
>> Qu
>>
>>>
>>> On Wed, 11 Sept 2024 at 10:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/9/11 19:08, Neil Parton =E5=86=99=E9=81=93:
>>>>> OK I have a new drive on the way which I was going to use to copy da=
ta
>>>>> on to, but will now replace /dev/sdc to be on the safe side.  SMART
>>>>> looks ok but don't want to go through this again!
>>>>>
>>>>> Maybe it was a bit flip?
>>>>
>>>> Nope, bitflip should not lead to a single mirror corruption, but all
>>>> mirrors corrupted.
>>>>
>>>> This looks more like that specific disk (mirror 2 of that logical
>>>> bytenr) is not fully following the FLUSH command.
>>>>
>>>> Thus some writes doesn't really reach disk but it still reports the
>>>> FLUSH is finished.
>>>>
>>>> Furthermore only two tree blocks are affected, which may just mean th=
e
>>>> disk is only dropping part of the writes.
>>>> Or you should have at least 4 tree blocks (root, subvolume(s), extent=
,
>>>> free space trees) affected.
>>>>
>>>> This behavior will eventually leads to transid mismatch on a power lo=
ss.
>>>> It's the other mirror(s) saving the day.
>>>>
>>>> And before replacing the disk, please really making sure that
>>>> "btrfs-map-logical" is really reporting the mirror 2 is sdc, or you c=
an
>>>> still keep a bad disk in the array.
>>>>
>>>>
>>>> Just keep running RAID1* for metadata, that's really a good practice.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> On Wed, 11 Sept 2024 at 10:32, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> =E5=9C=A8 2024/9/11 18:59, Neil Parton =E5=86=99=E9=81=93:
>>>>>>> dmesg | grep BTRFS
>>>>>>> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35=
2286
>>>>>>> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
>>>>>>> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35=
2286
>>>>>>> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
>>>>>>> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35=
2286
>>>>>>> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
>>>>>>> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35=
2286
>>>>>>> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
>>>>>>> [    6.064021] BTRFS info (device sdc): first mount of filesystem
>>>>>>> 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel=
)
>>>>>>> checksum algorithm
>>>>>>> [    6.064064] BTRFS info (device sdc): use zstd compression, leve=
l 3
>>>>>>> [    6.064079] BTRFS info (device sdc): enabling auto defrag
>>>>>>> [    6.064092] BTRFS info (device sdc): using free space tree
>>>>>>> [   76.647420] BTRFS error (device sdc): level verify failed on
>>>>>>> logical 313163105075200 mirror 2 wanted 0 found 1
>>>>>>> [   76.660155] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163105075200 (dev /dev/sdc sector 1145047360)
>>>>>>> [   76.660353] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163105079296 (dev /dev/sdc sector 1145047368)
>>>>>>> [   76.660553] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163105083392 (dev /dev/sdc sector 1145047376)
>>>>>>> [   76.660719] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163105087488 (dev /dev/sdc sector 1145047384)
>>>>>>> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
>>>>>>> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
>>>>>>> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
>>>>>>> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
>>>>>>> [  260.968635] BTRFS error (device sdc): parent transid verify fai=
led
>>>>>>> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
>>>>>>> [  261.047602] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163116052480 (dev /dev/sdc sector 1145068800)
>>>>>>> [  261.047893] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163116056576 (dev /dev/sdc sector 1145068808)
>>>>>>> [  261.051132] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163116060672 (dev /dev/sdc sector 1145068816)
>>>>>>> [  261.051398] BTRFS info (device sdc): read error corrected: ino =
0
>>>>>>> off 313163116064768 (dev /dev/sdc sector 1145068824)
>>>>>>
>>>>>> All happen on mirror 2.
>>>>>>
>>>>>> You can locate the device by:
>>>>>>
>>>>>> # btrfs-map-logical -l 313163116052480 /dev/sdc
>>>>>>
>>>>>> Which gives the device path.
>>>>>>
>>>>>> I would recommend to check the device's smart log and cables just i=
n case.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
>>>>>>>>> Many thanks Qu, I appear to be back up and running but I also ha=
d to
>>>>>>>>> run 'btrfs rescue zero-log' to get rid of a superblock error.
>>>>>>>>> super-recover said the superblock was fine.
>>>>>>>>
>>>>>>>> This is not expected. I believe btrfs-rescue should check log tre=
es
>>>>>>>> before doing the operation.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> On reboot and remount (as normal) I have a couple of residual tr=
ansid
>>>>>>>>> errors and I'm currently running a full scrub to try and clean t=
hings
>>>>>>>>> up.
>>>>>>>>
>>>>>>>> Transid is also not expected, if the transid error persists, it's=
 a huge
>>>>>>>> problem.
>>>>>>>>
>>>>>>>> Does the transid only shows on certain mirrors?
>>>>>>>>
>>>>>>>> Anyway a full dmesg from the first transid mismsatch will help a =
lot to
>>>>>>>> find out what's really going wrong.
>>>>>>>>
>>>>>>>> I hope it's really just the bad log trees.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> Hopefully though I'm back up and running, this is the longest th=
e FS
>>>>>>>>> has been mounted in 48 hours without it reverting to ro!
>>>>>>>>>
>>>>>>>>> Can't thank you enough for your help. I hope I'm not premature i=
n
>>>>>>>>> thanking you / will report back with any more errors.
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>>
>>>>>>>>> Neil
>>>>>>>>>
>>>>>>>>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
>>>>>>>>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 driv=
es in
>>>>>>>>>>> the array?
>>>>>>>>>>
>>>>>>>>>> Run it on any device of the fs.
>>>>>>>>>>
>>>>>>>>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
>>>>>>>>>>
>>>>>>>>>> And you must run the command with the fs unmounted.
>>>>>>>>>>
>>>>>>>>>>>       Reason I ask is when this first occurred it was one
>>>>>>>>>>> particular drive reporting errors and now after switching out =
cables
>>>>>>>>>>> and to a different hard drive controller it's a different driv=
e
>>>>>>>>>>> reporting errors.
>>>>>>>>>>>
>>>>>>>>>>> It's also worth noting that this array was originally created =
on a
>>>>>>>>>>> Debian system some 6-8 years ago and I've gradually upgraded t=
he
>>>>>>>>>>> drives over time to increase capacity, I'm up to drive ID 16 n=
ow to
>>>>>>>>>>> give you an idea.  Does that mean there are other gremlins pot=
entially
>>>>>>>>>>> lurking behind the scenes?
>>>>>>>>>>
>>>>>>>>>> Nope, this is really limited to that inode_cache mount option.
>>>>>>>>>> I guess you mounted it once with inode_cache, but kernel never =
cleans
>>>>>>>>>> that up, and until that feature is fully deprecated, and newer
>>>>>>>>>> tree-checker consider it invalid, and trigger the problem.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
>>>>>>>>>>>>> btrfs check --readonly /dev/sda gives the following, I will =
run a
>>>>>>>>>>>>> lowmem command next and report back once finished (takes a w=
hile)
>>>>>>>>>>>>>
>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>> Checking filesystem on /dev/sda
>>>>>>>>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>>>>>> [1/7] checking root items
>>>>>>>>>>>>> [2/7] checking extents
>>>>>>>>>>>>> [3/7] checking free space tree
>>>>>>>>>>>>> [4/7] checking fs roots
>>>>>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>>>>>> [6/7] checking root refs
>>>>>>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>>>>>>>> found 24251238731776 bytes used, no error found
>>>>>>>>>>>>> total csum bytes: 23630850888
>>>>>>>>>>>>> total tree bytes: 25387204608
>>>>>>>>>>>>> total fs tree bytes: 586088448
>>>>>>>>>>>>> total extent tree bytes: 446742528
>>>>>>>>>>>>> btree space waste bytes: 751229234
>>>>>>>>>>>>> file data blocks allocated: 132265579855872
>>>>>>>>>>>>>         referenced 23958365622272
>>>>>>>>>>>>>
>>>>>>>>>>>>> When the error first occurred I didn't manage to capture wha=
t was in
>>>>>>>>>>>>> dmesg, but far more info seemed to be printed to the screen =
when I
>>>>>>>>>>>>> check on subsequent tries, I have some photos of these messa=
ges but no
>>>>>>>>>>>>> text output, but can try again with some mount commands afte=
r the
>>>>>>>>>>>>> check has completed.
>>>>>>>>>>>>>
>>>>>>>>>>>>> dump as requested:
>>>>>>>>>>>>>
>>>>>>>>>>>> [...]
>>>>>>>>>>>>>                        refs 1 gen 12567531 flags DATA
>>>>>>>>>>>>>                        (178 0x674d52ffce820576) extent data =
backref root 2543
>>>>>>>>>>>>> objectid 18446744073709551604 offset 0 count 1
>>>>>>>>>>>>
>>>>>>>>>>>> This is the cause of the tree-checker.
>>>>>>>>>>>>
>>>>>>>>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for ino=
de cache.
>>>>>>>>>>>>
>>>>>>>>>>>> Unfortunately that feature is no longer supported, thus being=
 rejected.
>>>>>>>>>>>>
>>>>>>>>>>>> I'm very surprised that someone has even used that feature.
>>>>>>>>>>>>
>>>>>>>>>>>> For now, it can be cleared by the following command:
>>>>>>>>>>>>
>>>>>>>>>>>>         # btrfs rescue clear-ino-cache /dev/sda
>>>>>>>>>>>>
>>>>>>>>>>>> Then kernel will no longer rejects it anymore.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Qu
>>>>>>>>>>>
>>>>>
>>>

