Return-Path: <linux-btrfs+bounces-3904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8D8898210
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 09:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BAB237F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 07:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1658ABB;
	Thu,  4 Apr 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YK1lU4An"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89F5810C
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214945; cv=none; b=WRKqIb+FVJIHXBjphokuRZz65xi7cZS36ZnB2BhuIShGwyVc3nAYlrDEGJk3dCGa8v3CPhfM7fiPNLVZLCdojW9DtX8sxlJW3Ita2Don3x7p1TNrtYcvfpwJ0d9/EYDHu5ua+K1xjvFGxS/4ZVjI5HIvHYZMqgEbnOjIvAKorTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214945; c=relaxed/simple;
	bh=6ORPE2rgOWkvWR98pFqXKA1Goca859L77PSdPvRrnxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pz85dFlMRkPj4XHopE+FdtAdg3slvubYgcwnLJLX9ON0OvVP6KJVg2PBHzIN03tu8YQKwgYGUDBIgXB9M+FdEq4BFZtkdGZXacmPlY88zA351Ul0jmPRiDlatQ6LJdJqb3qlnMH+hwd7Fv+UeuCvR4x8AhDMiZz+Rj8uxwn3wiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YK1lU4An; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712214940; x=1712819740; i=quwenruo.btrfs@gmx.com;
	bh=+5LyK8jc/JjDP7MOE1r60/tfnYSyNnE5bmXpurXX5tA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=YK1lU4AnMEWHJPxMCPNj5y19pAmprxmp/QQAIsEmVircOOZBhUFd5kfEqmukhZzh
	 ZxhQGU5oVH6OmW8a/nprH8f8XCSnailYHvAlBwCWcEseonWJtte9w4SyQ8hqiOn8W
	 S/xJXUNUg2GJnlPqXu1pXM7guCw12NunVLeMEjtfeA8SBXtwrwunfegc/rHPICQ3p
	 flMWOpfbJAxHZTEGV41O4UrgjxJUhMfs06z6mbfqKJLifAfr447mNKaHYV5fGAYsD
	 QXQ/t/Q2QlwvL4rsthhFLMVzIMOLxO5eAzo1Ms2wwItgieYprCSF/s1RQ4AHtqXjS
	 3BAx1ykVxju8CjwE0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOGU-1sfIw92mo2-00upZb; Thu, 04
 Apr 2024 09:15:40 +0200
Message-ID: <d24d50b7-166c-413e-850c-0f5ebb2b2edf@gmx.com>
Date: Thu, 4 Apr 2024 17:45:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Understanding BTRFS Extent Tree?
To: "David F." <df7729@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAGRSmLv2TB5YT5_11zqVd6qfBgJ6wgzPCpmd6s4-gvSCnnnXWg@mail.gmail.com>
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
In-Reply-To: <CAGRSmLv2TB5YT5_11zqVd6qfBgJ6wgzPCpmd6s4-gvSCnnnXWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VI91mNIGmFVZPIBadTYPka8EENnBb+F8HSilI5PxN/zLDu1t9bL
 ezI4dPQfiQcdnYpZsVqyjwNjm0YjQR2Y6pmnFurctNd6dU1DTYDuDZtoihGzioSdMUQPbxe
 fbuC2o6YZ/BbFz6BD0eTfZl+9erw/IR0+qT7FWVtdg3scAC2SZKdNsnZTVLxdxePTQ3aHJu
 7H/Mwe7xG0BMz0b81RXQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ncd7HzEByZo=;fZIXMqpK3Znp8sPiiYEa/IIumId
 N8z5YX0L0rLz8ut40uGT8WDojzPUw00CXmbQm9J0RjVmk39LYG6zjyk6uquuOvneg5AOktY7I
 fit6kBHLE1ufV7P+LgJEa6B/M4oBJaD3OuVQrQDekHhTiUj4UEWir3MsdfnZtp/9cIVW1UvfY
 MpBYUks4JjJwjwDLFGX5WsCmBEtVH/dBK6hb5apPQPkG/wzbp2SwQ8aHlDrgavJCm/WAHaEQ8
 fGtCuBWu3gc0cOSZ4k3AAIr2DJYEaFuU4vgzJfDcUU1xnGGbjcuGKIId9RtGu8xRMvxiiG/N0
 K02zPDBztFMBtQUUa2VvlUG8UTJX1cUiWjFX1Qm3v40LCrizK/ASAgfZStZrFOz6p+nDF845U
 yyEEuuoeg5o03Wg1jTlhBr1qPFDZYVJGBVx1l8Zu2fqNIeHpg0QlELbsxVbg6CMwYPcVV2yj1
 GO3NC9LiQLcErHNp62LgRdZ9G61Hmrs7q+7jjjqTOPFyE5yjKtYifCgd6oor5dJBIGYgMwBWb
 FRAQbPWqz539pgoA1rwmVLKlyfG7Ap6SVa//2icj2XgEZyUPbwDCf6MeD3H2lAhLz/vKatr64
 QQH/gvXg1oQq49g/YWenngdcFR4l3ZObkBhGBukjqGoGkH+tFLeVfXCsXKN2OR6BUUO4j0T7k
 bBrOOmqKAnbv8t6Zy5pQ4NtNlaXDSa7RKW6Nbka+93zaz3P+vXl8cjBP2BJek/TncVN1gPwAE
 AeggDu7mTBPPEEe3hTqjgUGk1KeDxa8IwP1VCN6eYFT1wBByp6YeWv+NXm8eNHZfYH6g9BAPp
 g3T65CvYmGNiDkh88iYcryRiHM2quyN1/I6GkMYjeMefg=



=E5=9C=A8 2024/4/4 16:11, David F. =E5=86=99=E9=81=93:
> Hi,
>
> I have a need to find all the used areas on the btrfs (in this case
> just a single disk, no RAID, etc..).  I read that the extent tree
> should have all the information necessary but the values don't add up.
>
> Looking at items in the Extent Tree for BTRFS_EXTENT_ITEM_KEY and
> BTRFS_METADATA_ITEM_KEY I find a total of  196,608 bytes.

That should be the correct way to calculate used space before RAID profile=
s.

Just note that, for BTRFS_EXTENT_KEY_KEY, the offset is the extent size,
while for BTRFS_METADATA_ITEM_KEY, the size is implied to nodesize of
the fs.

>
> Using "btrfs inspect-internal dump-tree --extents" and add that up you
> get exactly 1/2 of that 98,304 (presume because DUP).

=2D-extents dumps both extent tree and device tree.

The device tree is for chunk level info, and a chunk can have part or
even all of its space unused.

>
> Yet the file system says 3.6M is used.   How do I get all the used
> areas for a simple single drive or partition on a PC using btrfs?  I
> will probably need to manually handle the superblock area?
>
> Anyway, here is the output for the extent tree:
>
> linux-jn17:/home/suse # df -h /mnt
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdb        8.0G  3.6M  7.2G   1% /mnt

Overall vanilla df is not good at provide either "used" nor "Avail".

But I need to dig deeper to find out how "used" is calculated.

> linux-jn17:/home/suse # btrfs inspect-internal dump-tree --extents /dev/=
sdb
> btrfs-progs v4.19.1
> extent tree key (EXTENT_TREE ROOT_ITEM 0)
> leaf 30523392 items 12 free space 15594 generation 14 owner EXTENT_TREE
> leaf 30523392 flags 0x1(WRITTEN) backref revision 1
> fs uuid 7fe21481-9083-4f7b-a00c-e651fd16bfac
> chunk uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
>      item 0 key (13631488 EXTENT_ITEM 65536) itemoff 16230 itemsize 53
>          refs 1 gen 14 flags DATA
>          extent data backref root ROOT_TREE objectid 256 offset 0 count =
1
>      item 1 key (13631488 BLOCK_GROUP_ITEM 8388608) itemoff 16206 itemsi=
ze 24
>          block group used 65536 chunk_objectid 256 flags DATA

So 64K data.

>      item 2 key (22020096 BLOCK_GROUP_ITEM 8388608) itemoff 16182 itemsi=
ze 24
>          block group used 16384 chunk_objectid 256 flags SYSTEM|DUP
>      item 3 key (22036480 METADATA_ITEM 0) itemoff 16149 itemsize 33
>          refs 1 gen 5 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root CHUNK_TREE

16K for system (chunk tree).

>      item 4 key (30408704 BLOCK_GROUP_ITEM 429457408) itemoff 16125 item=
size 24
>          block group used 114688 chunk_objectid 256 flags METADATA|DUP

And 112K for metadata.

Your calculation 196608 is correct, but that's only for btrfs logical
address space (before chunk profiles).

And with their corresponding profiles into consider, your real used
space would be something like :

64K * 1 + 16K * 2 + 112K * 2 =3D 320K.



But remember, knowing this is really of no help to get an accurate
used/free space for btrfs.

As the data/metadata/system space can not be shared by the other
profile, it can be very tricky to know the available space.

E.g. if your workload is very heavy on metadata (inlined extents + tons
of xattr), you may have a lot of metadata usage, thus would cause double
the usage.

If your workload is mostly data, it's not that much different compared
to other fs.

But if your workload tricks btrfs to allocate a lot of metadata space,
then suddenly the workload goes back to data heavy, you may find no more
space for data, and hit early ENOSPC unexpected.

So in short, there is no reliable used/available space for btrfs, and
that's even before complex situations.

Thanks,
Qu
>      item 5 key (30425088 METADATA_ITEM 0) itemoff 16092 itemsize 33
>          refs 1 gen 6 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root UUID_TREE
>      item 6 key (30490624 METADATA_ITEM 0) itemoff 16059 itemsize 33
>          refs 1 gen 4 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root DATA_RELOC_TREE
>      item 7 key (30507008 METADATA_ITEM 0) itemoff 16026 itemsize 33
>          refs 1 gen 14 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root ROOT_TREE
>      item 8 key (30523392 METADATA_ITEM 0) itemoff 15993 itemsize 33
>          refs 1 gen 14 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root EXTENT_TREE
>      item 9 key (30539776 METADATA_ITEM 0) itemoff 15960 itemsize 33
>          refs 1 gen 14 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root DEV_TREE
>      item 10 key (30556160 METADATA_ITEM 0) itemoff 15927 itemsize 33
>          refs 1 gen 14 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root CSUM_TREE
>      item 11 key (30670848 METADATA_ITEM 0) itemoff 15894 itemsize 33
>          refs 1 gen 7 flags TREE_BLOCK
>          tree block skinny level 0
>          tree block backref root FS_TREE
> device tree key (DEV_TREE ROOT_ITEM 0)
> leaf 30539776 items 6 free space 15853 generation 14 owner DEV_TREE
> leaf 30539776 flags 0x1(WRITTEN) backref revision 1
> fs uuid 7fe21481-9083-4f7b-a00c-e651fd16bfac
> chunk uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
>      item 0 key (0 PERSISTENT_ITEM 1) itemoff 16243 itemsize 40
>          persistent item objectid 0 offset 1
>          device stats
>          write_errs 0 read_errs 0 flush_errs 0 corruption_errs 0 generat=
ion 0
>      item 1 key (1 DEV_EXTENT 13631488) itemoff 16195 itemsize 48
>          dev extent chunk_tree 3
>          chunk_objectid 256 chunk_offset 13631488 length 8388608
>          chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
>      item 2 key (1 DEV_EXTENT 22020096) itemoff 16147 itemsize 48
>          dev extent chunk_tree 3
>          chunk_objectid 256 chunk_offset 22020096 length 8388608
>          chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
>      item 3 key (1 DEV_EXTENT 30408704) itemoff 16099 itemsize 48
>          dev extent chunk_tree 3
>          chunk_objectid 256 chunk_offset 22020096 length 8388608
>          chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
>      item 4 key (1 DEV_EXTENT 38797312) itemoff 16051 itemsize 48
>          dev extent chunk_tree 3
>          chunk_objectid 256 chunk_offset 30408704 length 429457408
>          chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
>      item 5 key (1 DEV_EXTENT 468254720) itemoff 16003 itemsize 48
>          dev extent chunk_tree 3
>          chunk_objectid 256 chunk_offset 30408704 length 429457408
>          chunk_tree_uuid 44ceacdd-bc48-409f-8af7-6bd2eb7cb44a
>
> Thanks!!
>

