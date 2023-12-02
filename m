Return-Path: <linux-btrfs+bounces-539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C6801EE3
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 22:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24DDB20AA9
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347692230A;
	Sat,  2 Dec 2023 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="F/IYGTDW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA496FB
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Dec 2023 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701554177; x=1702158977; i=quwenruo.btrfs@gmx.com;
	bh=av0+fgp2oZ6MjoQuy26SC+TCN5NpkxvVJjgcGFl7xbg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=F/IYGTDWfBAcXvq4EXRbY83JOw82rcqJxX6XDxFlMBgKx4oKOw0XfEoTsn4VdE4b
	 3RYD0ffoHX4rH7+YPiCYt9uYZP2CQ9goPUp51BpVh6TR5xauApqAYNT+O1Jx+QcHo
	 KhaeSBpNUo6hxLKXxwhOP0ZVyKZggOwnkMQ1cihTpQ2YSlO0F4k/R6qIZxH8KitZl
	 6PMoOJEtSP7/YZHBKsGvZO2IdJzJvyEzFRWV42wKK9G4y1k3EmDT8L2ThR54UeMwg
	 63hqqLelQv35j50CMEsK25YGJ18lQX6Xf7dGn7CsJC+hS9UFpmd1mg2yPDLVUgP7F
	 mZu79fuRtG7ckeH4Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1rTHom4BeS-00xZIy; Sat, 02
 Dec 2023 22:56:17 +0100
Message-ID: <6ae85272-3967-417e-bc9a-e2141a4c688a@gmx.com>
Date: Sun, 3 Dec 2023 08:26:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
 <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
 <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
 <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
Content-Language: en-US
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
In-Reply-To: <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oi66PAQHZAGzibmM5R5Kk80Zjf5IrW41YNWpQ8nG7EdkMsie7fb
 gPNXTEUoogtSh8N/QnW1AEI+I9CeZuAGggrpa1G+XQ0hkNJBuucoBpWjQDJ8tL+pc+Fp2ME
 lWGtu810TnkGBL3Jjv/VWKiuiegEb6jdDhs4WtfTxLJa26Z2Wh3vThjNpPG/KpeDHg10AnS
 cfTUoP5UaCfA02FKUQ/9w==
UI-OutboundReport: notjunk:1;M01:P0:P4H5OfqWK7o=;6hDukb0AeRRE56R165xn1VxFRCD
 BXMm0Sq+yRYxkJrMvD0p4RsoYB7tojY2aRJSp8qFrSEXzosRfOK7KqeBxaSOk7csERdIXAg17
 SEVOwd6cUWmXP0MbUSGopn1QTsFq5bkn0I637GD3tY7DkG6LdZIS4o7kW4sTBTDFUY3oxDtj7
 uwmLOI6fZA0wlr/nsc7OLQayT5o7YC8TOE8jP4Kh9C7YpCYhYa4hlyd3PWQwMzOP/TkEdnRXf
 j7GLb4h/zpLiUo7PoY67I7QYG6P28QYXlejfC7sbUermCaKVJLd6L3mt6Cyp4pTcdq/g7vJB5
 HwJpmEsa34jm65d1Ith+rNfMSzU/T4dJ+9vPXcgJSnVK/OQM6iXRW1Ah1XM20YZvJdE+ZfRbX
 Au64SZuYgopgyJJOHvp5t1PJ+MVk8kJtQvUB0KThrBxr9PY/h/+2UnAyhhzYX93M7xOrhS3Bl
 z5pWTQAAyJ3oFP+kZoJhYA0HjGX1sAdlB48/MDsQ8HCKe4+DSMmJosfBoNqDfsXPk5rRmtXEh
 11w0mZwfJeepl1N/nlKVOs+5ImhA+78v1kMPHhHaAALypUHm0LIq0tTWRhuxCodU43OgvCzhz
 VKEodM3VavnMlqOdBPP3NF0Wvs40a3bt7pzIRtnfaoEcOSMstwttl6NS/8LoWTjheEy0USu8X
 X1xYOI6Hoj9oM2iHV9e3QzptL6DA0+8nyWUG/oVHjrhoIkjIE+i9AfB5MrJ2enZfj2qfXwm8p
 /RQ096a/JTKNsvI1bzwlywiW9S9m9MTeZGtFC8oVhTyvDV7zAggDznqlP3NTWre97aq85D9kI
 fDME3zIQg2EiMvifcs5sXDezVPlc7J4AInnbkyd5LrYJK/DPXTbtnokfwVqLpbYDeC02zEWII
 NfJm46jCFN9XLlRgQnVrtdOa795BFao7yMc/f3jdQtETUnMEbelKTCvekfu/8RTtIPFWkdH0E
 JkahcxMnvKTAhrusnkBSIbzWqYk=



On 2023/12/3 06:37, Qu Wenruo wrote:
>
>
> On 2023/12/2 22:32, Gerhard Wiesinger wrote:
>> Hello Qu,
>>
>> Thank you for the answers, see inline.
>>
>> Any further ideas?
>>
>> Ciao,
>> Gerhard.
>>
>> On 30.11.2023 21:53, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/11/30 21:51, Gerhard Wiesinger wrote:
>>>> Dear All,
>>>>
>>>> I created a new BTRFS volume with migrating an existing PostgreSQL
>>>> database on it. Versions are recent.
>>>
>>> Does the data base directory has something like NODATACOW or NODATASUM
>>> set?
>>> The other possibility is preallocation, for the first write on
>>> preallocated range, no matter if the compression is enabled, the write
>>> would be treated as NOCOW.
>>>
>> I don't think so. How to find out (googled already a lot)?
>
> I normally go `btrfs ins dump-tree`, dump the subvolume, grep for the
> inode number with `grep -A 3 "item .* key (257 INODE_ITEM 0)"`, which
> would show something like this:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0item 6 key (257 INODE_ITEM 0) itemoff 15811 ite=
msize 160
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 7 transid 8 size =
4194304 nbytes 4194304
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block group 0 mode 100644 li=
nks 1 uid 0 gid 0 rdev 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sequence 513 flags 0x10(PREA=
LLOC)
>
> The flags is the btrfs specific flags, which would show NODATACOW or
> NODATASUM.
>
>>
>> At least it is not mounted with these options (see also original post).
>>
>> # Mounted via force
>> findmnt -vno OPTIONS /var/lib/pgsql
>> rw,relatime,compress-force=3Dzstd:3,space_cache=3Dv2,subvolid=3D5,subvo=
l=3D/'
>>
>> According to the following link it should compress anyway with the -o
>> compress-force option:
>>
>> https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Comp=
ression.html#What.27s_the_precedence_of_all_the_options_affecting_compress=
ion.3F
>> Compression to newly written data happens:
>> always -- if the filesystem is mounted with -o compress-force
>> never -- if the NOCOMPRESS flag is set per-file/-directory
>> if possible -- if the COMPRESS per-file flag (aka chattr +c) is set, bu=
t
>> it may get converted to NOCOMPRESS eventually
>> if possible -- if the -o compress mount option is specified
>> Note, that mounting with -o compress will not set the +c file attribute=
.
>
> Well, if you check the kernel code, inside btrfs_run_delalloc_range(),
> which calls should_nocow() to check if we should fall to NOCOW path.
>
> That should_nocow() would check if the inode has NODATACOW or PREALLOC
> flags, then verify if there is any defrag request for it.
> If no defrag request, then it can go NOCOW, thus break the COW requireme=
nt.
>
>>
> [...]
>>>> # Stays here at this compression level
>>>> compsize -x /var/lib/pgsql
>>>> Processed 5332 files, 575858 regular extents (591204 refs), 40 inline=
.
>>>> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0=
 Disk Usage=C2=A0=C2=A0 Uncompressed Referenced
>>>> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 63%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 51G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G
>>>> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 40G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G
>>>> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27%=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 10G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 40G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G
>>>> prealloc=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.0M=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.0M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 5.5M
>>>
>>> Not sure if the preallocation is the cause, but maybe you can try
>>> disabling preallocation of postgresql?
>>>
>>> As preallocation doesn't make that much sense on btrfs, there are too
>>> many cases that can break the preallocation.
>>
>>
>> I googled a lot and didn't find anything useful with preallocation and
>> postgresql (looks like it doesn'use fallocate).
>
> I don't think so.
>
>>
>> How can I find something about preallocation out?
>
> Above compsize is already showing there is some preallocated space.
>
> Thus I'm wondering if the preallocation is the cause.
>
> As should_nocow() would also check the PREALLOC inode flag, and tries
> NOCOW path first (then falls to COW if needed)

Yep, I just reproduced it, for any INODE with PREALLOC flag (aka, the
file has some preallocated range), even we're writing into the range
that needs COW anyway (e.g. new writes which would enlarge the file),
the compression would not work anyway.

  # mkfs.btrfs test.img
  # mount test.img -o compress-force=3Dzstd /mnt/btrfs
  # fallocate -l 128k /mnt/btrfs/file1
  # xfs_io -f -c "pwrite 128k 128k" /mnt/btrfs/file1
  # xfs_io -f -c "pwrite 128k 128k" /mnt/btrfs/file2
  # sync

Since file1 has 128K preallocated range, thus the inode has PREALLOC
flag, and would lead to no compression:

	item 6 key (257 INODE_ITEM 0) itemoff 15811 itemsize 160
		generation 8 transid 8 size 262144 nbytes 262144
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 33 flags 0x10(PREALLOC) <<<<
	item 7 key (257 INODE_REF 256) itemoff 15796 itemsize 15
		index 2 namelen 5 name: file1
	item 8 key (257 EXTENT_DATA 0) itemoff 15743 itemsize 53
		generation 8 type 2 (prealloc)
		prealloc data disk byte 13631488 nr 131072
		prealloc data offset 0 nr 131072
	item 9 key (257 EXTENT_DATA 131072) itemoff 15690 itemsize 53
		generation 8 type 1 (regular)
		extent data disk byte 13762560 nr 131072
		extent data offset 0 nr 131072 ram 131072
		extent compression 0 (none) <<<

Meanwhile for the other file, which has no prealloc, would go regular
compression path.

	item 10 key (258 INODE_ITEM 0) itemoff 15530 itemsize 160
		generation 8 transid 8 size 262144 nbytes 131072
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 32 flags 0x0(none)
	item 11 key (258 INODE_REF 256) itemoff 15515 itemsize 15
		index 3 namelen 5 name: file2
	item 12 key (258 EXTENT_DATA 131072) itemoff 15462 itemsize 53
		generation 8 type 1 (regular)
		extent data disk byte 13893632 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 3 (zstd)

To me, this looks a bug, and the reason is exactly what I explained before=
.

The worst thing is, as long as the inode has PREALLOC flag, even if all
preallocated extents are used, it would prevent compression from
happening, forever for that inode.

Let me try to fix the fallback to COW path to include compression.

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>>
>>
>

