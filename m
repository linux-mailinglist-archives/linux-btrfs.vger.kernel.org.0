Return-Path: <linux-btrfs+bounces-17097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328AB9364F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 23:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627DF190840C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9E2FD7BC;
	Mon, 22 Sep 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WfovT1FP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BEC219A7D
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577127; cv=none; b=R+v6KC5053vkPOpXDB2ZiwEtyBJ5kDmuM0fE3AA9wR3RSVICxOKl3x45dqSpgjq4Jcsgu0WsvUhVG/iGKEllI412VxBZthizh11rRlaB3WChtY0KYvaVPOcAHKotYx6RJr64vVbRkl6eZCTjY1NBJIdzGFp1VoarTMEn91JA3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577127; c=relaxed/simple;
	bh=e+x30siCPsSxbJJeRulCt5IqGthiBz6pOEnNubro/fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D716zEIhKFQOKHZrgvGDxDOPK1YcxBp7QSz51fS4K3FEazOv/OqVw3qC/+iDgqYzWDf+GpV4/zSB1ZjyceinAco1lUIRx92KxhiTFwQZxe0wBvUk98ZbETBGQXgWG/jkdAoomf+CLn//wBsPWxTSEe3k2u8WcFzZobZMQmEwzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WfovT1FP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758577123; x=1759181923; i=quwenruo.btrfs@gmx.com;
	bh=gcW13A8ZDhDtwS78FMLhWPV2Xq9shkuuZLl3lfTpMAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WfovT1FP8pQgn8o9IEcytEHj1gt3aJKzgvm1H66O8ttKWrSxo+M0ToM//G/96lDH
	 3xoD/5DfdpRxCS5g2Y8P0NSBxhZI6W5VoE0FH9WGzxdcgNnK0nrtJiQ0GObnrnnDg
	 PtbFSBxdPEyCNhoe+DnRQrX/q2ZmXJ1Zljs8SoTv8LntPULRyAAUM4vGYprvEjFy/
	 i1eU4qdO+4srJ3mozziJEMYxfxURdsOPdX1xDm1xWq0xZrmM2huozxZxcafeheOIX
	 6xIpvcXiAYrTbFLi0OLjy7s9VU86/smeezyCICTG2M+p5FK4zvbU/YM7B8mrqxlpU
	 wigKjAzjAhnQk2KhyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1v2k3P3Pa5-00EC4f; Mon, 22
 Sep 2025 23:38:43 +0200
Message-ID: <18894449-adc7-47e0-ae81-3e3612a1a4b3@gmx.com>
Date: Tue, 23 Sep 2025 07:08:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
To: Demi Marie Obenour <demiobenour@gmail.com>, linux-btrfs@vger.kernel.org
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <62a97fb7-75e3-4832-b97c-90763b287a5c@gmx.com>
 <e4423bc0-38e8-4f61-9cd9-c3d9c00308ab@gmail.com>
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
In-Reply-To: <e4423bc0-38e8-4f61-9cd9-c3d9c00308ab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1YV/3xsNubw3zjk+jDuJ7Mby3ldA1UgBIidScLQ7/e/o1ZYq/05
 mdbI4PlBmnl2uBvAwYvUufa5e3x/mq9nnj4HMcpWphAF5lToVVGUw8ou9pp+t7VTDm2ByI/
 DLnzTIcmbGP1bwr7OJkRcacGlWpkahlPCamOt+a6ZlYO9jwlJI88n/f/Gb5S4vlgAtV+AY9
 udoW4yb5f5ft72FtR8tGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hKwprkXstvY=;0S3eES1KW4QD/KBWFJoRkwIi28W
 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



=E5=9C=A8 2025/9/23 03:54, Demi Marie Obenour =E5=86=99=E9=81=93:
> On 9/21/25 20:50, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/9/22 09:37, Demi Marie Obenour =E5=86=99=E9=81=93:
>>> Wyng Backup (https://codeberg.org/tasket/wyng-backup) relies on FIEMAP
>>> to determine which parts of a file have not changed since it was last
>>> backed up.  Specifically, the output of filefrag -v is passed to sort =
and
>>> then to uniq, and differences between the outputs for the file and
>>> the previous version (a reflink copy) determine what gets backed up.
>>>
>>> Is this safe under BTRFS,
>>
>> No. There are several factors affecting this, some are minor some are n=
ot:
>>
>> - Inlined extents
>>     The returned bytenr is unreliable in that case.
>>     Although the fiemap flags should indicate that, with 'inline' flag
>>     set.
>>
>> - Balance
>>     Btrfs can balance the data extents, which will result the change of
>>     the fiemap.
>>
>>     E.g.
>>     ## Before balance
>>     # md5sum  /mnt/btrfs/foobar
>>     27c9068d1b51da575a53ad34c57ca5cc  /mnt/btrfs/foobar
>>     # filefrag -v /mnt/btrfs/foobar
>>     Filesystem type is: 9123683e
>>     File size of /mnt/btrfs/foobar is 65536 (8 blocks of 8192 bytes)
>>      ext:     logical_offset:        physical_offset: length:   expecte=
d:
>> flags:
>>        0:        0..       7:       1664..      1671:      8:
>> last,eof
>>     /mnt/btrfs/foobar: 1 extent found
>>
>>     ## Do data balance
>>     # btrfs balance start -d /mnt/btrfs/
>>     Done, had to relocate 1 out of 3 chunks
>>
>>     ## After data balannce
>>     # filefrag -v /mnt/btrfs/foobar
>>     Filesystem type is: 9123683e
>>     File size of /mnt/btrfs/foobar is 65536 (8 blocks of 8192 bytes)
>>       ext:     logical_offset:        physical_offset: length:
>> expected: flags:
>>        0:        0..       7:      36480..     36487:      8:
>> last,eof
>>     /mnt/btrfs/foobar: 1 extent found
>>
>>
>> - NODATACOW cases.
>>     In that case new data is written into the same location, without an=
y
>>     extra new data extents. This completely breaks the assumption.
>>
>> - Dirty data that is not yet written into the disk
>>     In that case fiemap won't show those data but only the ones that ar=
e
>>     on the disk.
>>
>>> or can it result in data loss due to data
>>> not being backed up that should be?  In other words, can it result
>>> in data being considered unchanged when it really is?
>>
>> Dirty data and NODATACOW will result data being considered unchanged
>> using fiemap only.
>>
>> And balance will make the unchanged data to be considered changed.
>>
>> So overall, fiemap based solution on btrfs is unreliable.
>=20
> Can one implement this reliably with TREE_SEARCH_V2

If you go deep into that rabbit hole, I guess you must be very=20
experienced with btrfs on-disk format.

> or by parsing
> the output of `btrfs send`?  Using `btrfs receive` to apply deltas
> might work, but the backups must be encrypted with a key the
> destination doesn't have,

You're mixing extra objectives into the situation.

And why you need to bother encryption by yourself? There are things like=
=20
ecryptfs to do that for you.

Your objective looks overly complex without proper layer separation.

Thanks,
Qu

> and that means the backups must be
> opaque to the remote.  Therefore, I think periodic full backups
> with incremental backups on top of them (each containing the hash
> of the last) is the best that could be done.  This means that old
> backups cannot be garbage-collected without taking a full backup
> first.


