Return-Path: <linux-btrfs+bounces-17599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACFBCB94B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 05:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F5D4011B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F91C8605;
	Fri, 10 Oct 2025 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fC7pgnio"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44B3FB31
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760068474; cv=none; b=MDGQT/234bxPxcuGHUccwY3fqRNWmfHWMxfcWOZ0ciUY5A7um/Tud0sIPbiHwj1dXSxtpC1OlwGLXQLnAZiXWdVc7KAxX70KbrFqhW8IdBCb7r7RDIjss5DTvAu2H/w8KckoR4stD/4ZfBB3Ejb9Ak78uQcsKID3KkCjyGqzIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760068474; c=relaxed/simple;
	bh=9U8AHGrk5V+Cu+Pgemt2+5Rp2L4a2gPDcr2nzjYp998=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=X2uV8ZyUiDCBiUmae1iN7otsznu0loMc8bzmYTAbnJ2Es76NlahpuDHg1p3a2mRo6YiX/to4CxjdZ92+xthtcbpK0xNT4LpcvdKpJfLMG3MfILQMF5GSoB8c+2L8wdUOdkV9eMgK1DGDOk1PrKQUG/bQHFwZEdhtgMhrrIypifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fC7pgnio; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760068465; x=1760673265; i=quwenruo.btrfs@gmx.com;
	bh=9U8AHGrk5V+Cu+Pgemt2+5Rp2L4a2gPDcr2nzjYp998=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fC7pgnioPNXX5/0RGrMtVI//eTFhiBdLxdax9J5x0o3R7he4T9xG5IgkeqxsEurp
	 UT+l6n4QM+pWi5eCBS0sc31Fb8mAuBXMrnB93brzr78G1V7z13SpR77tTRDENs+BV
	 D9Tui2sizInrfHsbJFDs6/sJ5LQxHBtxQotQ5IPti+9Bb0m/XCgHNnb6dxexqXDGr
	 3Qx9dd0fOT4/YLR1bGrVZr4pjIjUJqzcrAhzKNYQiovpnCb6OZ8GZARJ250QaPFwv
	 kO4quM6aVicyA0kD9tts7LIl9QYnV7yZApK5i/swbx3U1gftUCyMhqiMItjYjntys
	 nfXIHU6g6G7pMyRTvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1vCaW41Ylo-004kck; Fri, 10
 Oct 2025 05:54:24 +0200
Message-ID: <bc1f98b9-c013-4e5f-8e6f-16c724367a3e@gmx.com>
Date: Fri, 10 Oct 2025 14:24:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: check: stop checking for csums past i_size
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <6e3df8da61ea11e45809208e3795452c5291f467.1760028487.git.fdmanana@suse.com>
 <5d465706-b7bd-4302-89d1-7f6b5e16e350@gmx.com>
Content-Language: en-US
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
In-Reply-To: <5d465706-b7bd-4302-89d1-7f6b5e16e350@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHmHi04ea3OZPT3Ph+j0PtOUzc9yM4rtuUsKH1idT8I8gWnTTzd
 3yCqPYRlgrKncLsUhMYyrAuhs4ILj/f2GsDMphUOiUUOt8StW8loZdPHlhJP+LyeKUCuLx8
 qDp0TKhNwNrBZ+olzKfPJKrrO1wFcl++IEiDX2jmJGD1FZSy1OsiRueYyIrBxiFMBWIplcl
 MR/qnksdtKOHXqV64Cj1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lAVHckroH8E=;vRh+cCKBMf92rnXV/Sn09Reitd4
 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



=E5=9C=A8 2025/10/10 07:07, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/10/10 03:19, fdmanana@kernel.org =E5=86=99=E9=81=93:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> While running test case btrfs/192 from fstests on a kernel with=20
>> support for
>> large folios (needs CONFIG_BTRFS_EXPERIMENTAL=3Dy kernel configuration=
=20
>> at the
>> moment) I ended up getting very sporadic btrfs check failures reporting
>> that csum items were missing. Looking into the issue it turned out=20
>> that we
>> end up looking for csum items of a file extent item with a range that=
=20
>> spans
>> beyond the i_size of a file and we don't have any, because the kernel's
>> writeback code skips submitting bios for ranges beyond eof.
>>
>> Example output when this happens:
>>
>> =C2=A0=C2=A0 $ btrfs check /dev/sdc
>> =C2=A0=C2=A0 Opening filesystem to check...
>> =C2=A0=C2=A0 Checking filesystem on /dev/sdc
>> =C2=A0=C2=A0 UUID: 69642c61-5efb-4367-aa31-cdfd4067f713
>> =C2=A0=C2=A0 [1/8] checking log skipped (none written)
>> =C2=A0=C2=A0 [2/8] checking root items
>> =C2=A0=C2=A0 [3/8] checking extents
>> =C2=A0=C2=A0 [4/8] checking free space tree
>> =C2=A0=C2=A0 [5/8] checking fs roots
>> =C2=A0=C2=A0 root 5 inode 332 errors 1000, some csum missing
>> =C2=A0=C2=A0 ERROR: errors found in fs roots
>> =C2=A0=C2=A0 (...)
>>
>> Looking at a tree dump of the fs tree (root 5) for inode 332 we have:
>>
>> =C2=A0=C2=A0=C2=A0 $ btrfs inspect-internal dump-tree -t 5 /dev/sdc
>> =C2=A0=C2=A0=C2=A0 (...)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 28 key (332 INODE=
_ITEM 0) itemoff 2006 itemsize 160
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 17 transid 19 size 610969 nbytes 86=
016
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 block group 0 mode 100666 links 1 uid 0 gid 0 =
rdev 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sequence 11 flags 0x0(none)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 atime 1759851068.391327881 (2025-10-07 16:31:0=
8)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctime 1759851068.410098267 (2025-10-07 16:31:0=
8)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 mtime 1759851068.410098267 (2025-10-07 16:31:0=
8)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 otime 1759851068.391327881 (2025-10-07 16:31:0=
8)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 29 key (332 INODE=
_REF 340) itemoff 1993 itemsize 13
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 index 2 namelen 3 name: f1f
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 30 key (332 EXTEN=
T_DATA 589824) itemoff 1940 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 19 type 1 (regular)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte 21745664 nr 65536
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 65536 ram 65536
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 0 (none)
>> =C2=A0=C2=A0=C2=A0 (...)
>>
>> We can see that the file extent item for file offset 589824 has a=20
>> length of
>> 64K and its number of bytes is 64K. Looking at the inode item we see th=
at
>> its i_size is 610969 bytes which falls within the range of that file=20
>> extent
>> item [589824, 655360[.
>>
>> Looking into the csum tree:
>>
>> =C2=A0=C2=A0 $ btrfs inspect-internal dump-tree /dev/sdc
>> =C2=A0=C2=A0 (...)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 15 key (EXTENT_CS=
UM EXTENT_CSUM 21565440) itemoff 991=20
>> itemsize 200
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 range start 21565440 end 21770240 length 20480=
0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item=
 16 key (EXTENT_CSUM EXTENT_CSUM 1104576512) itemoff=20
>> 983 itemsize 8
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 range start 1104576512 end 1104584704 length 8=
192
>> =C2=A0=C2=A0 (..)
>>
>> We see that the csum item number 15 covers the first 24K of the file=20
>> extent
>> item - it ends at offset 21770240 and the extent's disk_bytenr is=20
>> 21745664,
>> so we have:
>>
>> =C2=A0=C2=A0=C2=A0 21770240 - 21745664 =3D 24K
>>
>> We see that the next csum item (number 16) is completely outside the=20
>> range,
>> so the remaining 40K of the extent doesn't have csum items in the tree.
>>
>> If we round up the i_size to the sector size, we get:
>>
>> =C2=A0=C2=A0=C2=A0 round_up(610969, 4096) =3D 614400
>>
>> If we subtract from that the file offset for the extent item we get:
>>
>> =C2=A0=C2=A0=C2=A0 614400 - 589824 =3D 24K
>>
>> So the missing 40K corresponds to the end of the file extent item's ran=
ge
>> minus the rounded up i_size:
>>
>> =C2=A0=C2=A0=C2=A0 655360 - 614400 =3D 40K
>>
>> Normally we don't expect a file extent item to span over the rounded up
>> i_size of an inode, since when truncating, doing hole punching and othe=
r
>> operations that trim a file extent item, the number of bytes is adjuste=
d.
>>
>> There is however a short time window where the kernel can end up,
>> temporarily,persisting an inode with an i_size that falls in the=20
>> middle of
>> the last file extent item and the file extent item was not yet trimmed=
=20
>> (its
>> number of bytes reduced so that it doesn't cross i_size rounded up by t=
he
>> sector size).
>>
>> The steps (in the kernel) that lead to such scenario are the following:
>>
>> =C2=A0 1) We have inode I as an empty file, no allocated extents, i_siz=
e is 0;
>>
>> =C2=A0 2) A buffered write is done for file range [589824, 655360[ (len=
gth of
>> =C2=A0=C2=A0=C2=A0=C2=A0 64K) and the i_size is updated to 655360. Note=
 that we got a single
>> =C2=A0=C2=A0=C2=A0=C2=A0 large folio for the range (64K);
>>
>> =C2=A0 3) A truncate operation starts that reduces the inode's i_size d=
own to
>> =C2=A0=C2=A0=C2=A0=C2=A0 610969 bytes. The truncate sets the inode's ne=
w i_size at
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_setsize() by calling truncate_setsize() =
and before calling
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_truncate();
>>
>> =C2=A0 4) At btrfs_truncate() we trigger writeback for the range starti=
ng at
>> =C2=A0=C2=A0=C2=A0=C2=A0 610304 (which is the new i_size rounded down t=
o the sector size) and
>> =C2=A0=C2=A0=C2=A0=C2=A0 ending at (u64)-1;
>>
>> =C2=A0 5) During the writeback, at extent_write_cache_pages(), we get f=
rom the
>> =C2=A0=C2=A0=C2=A0=C2=A0 call to filemap_get_folios_tag(), the 64K foli=
o that starts at file
>> =C2=A0=C2=A0=C2=A0=C2=A0 offset 589824 since it contains the start offs=
et of the writeback
>> =C2=A0=C2=A0=C2=A0=C2=A0 range (610304);
>>
>> =C2=A0 6) At writepage_delalloc() we find the whole range of the folio =
is=20
>> dirty
>> =C2=A0=C2=A0=C2=A0=C2=A0 and therefore we run delalloc for that 64K ran=
ge ([589824, 655360[),
>> =C2=A0=C2=A0=C2=A0=C2=A0 reserving a 64K extent, creating an ordered ex=
tent, etc;
>>
>> =C2=A0 7) At extent_writepage_io() we submit IO only for subrange [5898=
24,=20
>> 614400[
>> =C2=A0=C2=A0=C2=A0=C2=A0 because the inode's i_size is 610969 bytes (ro=
unded up by sector=20
>> size
>> =C2=A0=C2=A0=C2=A0=C2=A0 is 614400). There, in the while loop we intent=
ionally skip IO beyond
>> =C2=A0=C2=A0=C2=A0=C2=A0 i_size to avoid any unnecessay work and just c=
all
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_mark_ordered_io_finished() for the range=
 [614400,=20
>> 655360[ (which
>> =C2=A0=C2=A0=C2=A0=C2=A0 has a 40K length);
>>
>> =C2=A0 8) Once the IO finishes we finish the ordered extent by ending u=
p at
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_finish_one_ordered(), join transaction N=
, insert a file extent
>> =C2=A0=C2=A0=C2=A0=C2=A0 item in the inode's subvolume tree for file of=
fset 589824 with a=20
>> number
>> =C2=A0=C2=A0=C2=A0=C2=A0 of bytes of 64K, and update the inode's delaye=
d inode item or=20
>> directly
>> =C2=A0=C2=A0=C2=A0=C2=A0 the inode item with a call to btrfs_update_ino=
de_fallback(), which
>> =C2=A0=C2=A0=C2=A0=C2=A0 results in storing the new i_size of 610969 by=
tes;
>>
>> =C2=A0 9) Transaction N is committed either by the transaction kthread =
or some
>> =C2=A0=C2=A0=C2=A0=C2=A0 other task committed it (in response to a sync=
 or fsync for=20
>> example).
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 At this point we have inode I persisted with a=
n i_size of 610969=20
>> bytes
>> =C2=A0=C2=A0=C2=A0=C2=A0 and file extent item that starts at file offse=
t 589824 and has a=20
>> number
>> =C2=A0=C2=A0=C2=A0=C2=A0 of bytes of 64K, ending at an offset of 655360=
 which is beyond the
>> =C2=A0=C2=A0=C2=A0=C2=A0 i_size rounded up to the sector size (614400).
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 --> So after a crash or power failure here, th=
e btrfs check program
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reports that error abo=
ut missing checksum items for this=20
>> inode, as
>> =C2=A0=C2=A0=C2=A0=C2=A0it tries to lookup for checksums covering the w=
hole range of the
>> =C2=A0=C2=A0=C2=A0=C2=A0extent;
>>
>> 10) Only after transaction N is commited that at btrfs_truncate() the=
=20
>> call
>> =C2=A0=C2=A0=C2=A0=C2=A0 to btrfs_start_transaction() starts a new tran=
saction, N + 1,=20
>> instead
>> =C2=A0=C2=A0=C2=A0=C2=A0 of joining transaction N. And it's with transa=
ction N + 1 that it=20
>> calls
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_truncate_inode_items() which updates the=
 file extent item=20
>> at file
>> =C2=A0=C2=A0=C2=A0=C2=A0 offset 589824 to reduce its number of bytes fr=
om 64K down to 24K, so
>> =C2=A0=C2=A0=C2=A0=C2=A0 that the file extent item's range ends at the =
i_size rounded up=20
>> to the
>> =C2=A0=C2=A0=C2=A0=C2=A0 sector size - 614400 bytes.
>=20
> Thanks a lot for the detailed reason.
>=20
>>
>> So fix this by skipping the search of csum items beyond the sector that
>> contains a file's i_size.
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>> =C2=A0 check/main.c | 13 +++++++++++++
>=20
> And lowmem mode is missing the same handling.
>=20
> In lowmem mode if we hit a file extent we still expect @csum_found to=20
> match @search_len.

Another thing I'm wondering is, can we make the beyond i_size writes to=20
behave more like truncated ordered extent.

With truncated OE, the num_bytes of the file extent will still be inside=
=20
the rounded up inodes, and the existing btrfs check will handle them=20
correctly.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>> =C2=A0 1 file changed, 13 insertions(+)
>>
>> diff --git a/check/main.c b/check/main.c
>> index 49a6ad25..f4a135c1 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -1774,6 +1774,19 @@ static int process_file_extent(struct=20
>> btrfs_root *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 disk_bytenr +=3D extent_offset;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A truncate, reducin=
g a file's size, can temporarily leave an
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * inode with the new =
i_size falling somewhere in the middle of
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the last file exten=
t item without having any csum items for
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * blocks past the new=
 i_size (rounded up to the i_size). This
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * happens when the ne=
w i_size falls in the middle of a delalloc
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * range and that file=
 range does not have yet any allocated
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * extents. So make su=
re we don't search for csum items beyond
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the i_size.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key->offset + num_bytes=
 > rec->isize)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num=
_bytes =3D round_up(rec->isize, gfs_info->sectorsize) -=20
>> key->offset;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D count_cs=
um_range(disk_bytenr, num_bytes, &found);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret;
>=20
>=20


