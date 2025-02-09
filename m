Return-Path: <linux-btrfs+bounces-11352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C3A2E15C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 00:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4357164BBC
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2025 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D822F39B;
	Sun,  9 Feb 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="coHIw/hX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F015B543
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Feb 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739142511; cv=none; b=TPxgOs2U+mKra4OfKy0CQRScb6SQaVJeif8e5HkJGfJExdZFQJiFxlsGGBMvPNMehaeV3pKiIhWy+jw8hiHuxWskBMWE/gvTXJmeFSNmhOkHogr9VAhK/BbvdQbOFtUaYFk774lrlWjkgzEWLMz8u1pTWrXUbFeIEkj1Hra7970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739142511; c=relaxed/simple;
	bh=1g19nOqD9uIcamdJAy9BKRXzicCcsJ/vEdXsWAc1wLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cTTnnskuD4VwH04q3y6r7tKWdmYczSgd0QjaonGt61R8NJeF8NNZkYVKRj5F4fds2zZhJEvwQeD8uFSnVXdlbrYgW1ryrvDlFnUwOzF8QL4BGeOD+H3FCWlFnRA2LTLa6U1OYl4/cxtYE97kAbsgvlWfdQETJ2gSoQCIJtf16uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=coHIw/hX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739142507; x=1739747307; i=quwenruo.btrfs@gmx.com;
	bh=4t47E3Yrisf2LTbYQ+qg8TZ29wm1YkLoDEcA247LMSk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=coHIw/hXmuedAR0Ig1npUdVCiwNjqiKdeCxSRNdurL+Sdr7vKCqiayJXuUIaehbV
	 5nwyolAQv6CIIBZEjndK85+6lZgVedoCuwC3boeJAit8mth18tyVFWC7DLUvRtDk8
	 crfNiXvp7PQSkxYMMx2k/pnylcFuqTKYxkXzQIlTb7JSpn8H9lCMyj9pXKhfY83m2
	 GiDcqGqHbWUD1RA6Q931jet/tG0JCSBK516DQCjNBklCPbJfZRuAlqmetRXnK/1ha
	 Xxr3zZbz2IlF8szBq2mqnipXPCmxmxw75LWorzE4lYDTdRdUuIW1jEUE0sUWfJgUv
	 1jPOZg91/ynA8yUMMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1tPKNw3Ba2-017yTm; Mon, 10
 Feb 2025 00:08:27 +0100
Message-ID: <851dded9-e91d-4d89-a3df-170d3af1dca5@gmx.com>
Date: Mon, 10 Feb 2025 09:38:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deleted or Orphaned extent not being cleaned up
To: Abdulla Bubshait <darkstego@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADOXG6GukpR3DPPT808+MMCtMo8B8HW43VwAqVyd5iP9xoH5GA@mail.gmail.com>
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
In-Reply-To: <CADOXG6GukpR3DPPT808+MMCtMo8B8HW43VwAqVyd5iP9xoH5GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4V/Vy887axIrIu/q8dAHdrDcr/tom7W53POzVxO5SCTVz80j88i
 UUiwHbp5uSptCMiZT/gkihTqZVoNZuJrdQWJ8fMS246TAdO4b8DN1Z1qZKunLR0AsbsetE+
 TMY8i5+Po60POPGAPBMbrFSjqVu0ZYbjuOp4oQwYHqu1gsEOgKUkbq70vnJnVtzoFtS5e9t
 sSJ1lFKJtSnBpxqsZydFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9dsEgR4Hoho=;WUCzwPzjHiR564nUae2jpXkQAZj
 BuC3F4PQ7tn822LTiQZjqTfH07DbGlmU1uWsSUu1P+LE3pOMkrO9vwtwSSrqoF9INcC4zHqcm
 aUDFQNDn5ujebhb8jUNoAxzSxiqBAEDJl6/ahlE0x/fCYqfk2QPHskJMmmgIoziB1PVrS70Wd
 ow6ulujpLQDfBC62sjS3HPja4Cyrout/z+buktshhKNscCQ5F6X8u0w1N4UH90Dc5ygPP1Nwc
 p6k0PuaAbqo6zHHCkpQUxIx8+OO/Bqpa+jUUbKps4Gd7xzI65ZI2p0H6rYg2otbvKB8DexXr1
 r4DMoGXiRYNDaO/z6Sd7oL8tMBCWyWYfqFAmWSzauoy3aAxnB9bnF3aKNjoNCZLhJEacyA4UK
 E1qG15GUWXDpFD7Cnlh8ohPml164NBq7YIGq5c9YnZ88YFNpieOUUeqOgy3ubgY3aBtJXyAFu
 rEUJK8K/J6lcUtd5UesvEBGu3fdmgxn1XWVIeu7IuLDe+FdT8bdF+E8bQwX/DYJQfi6eARxSM
 5GpXYjnbdb/XIvCb+S5HyHtAQwVcYthT4mABWgWk1C9Dt6N+7fvrhBERmvz7tyANo3Aap3+AB
 XuKRkKBzao0P6IbJIDgdy5HhGygZz+5zProW5rkkzA//fy01NnsuunDuDQx9QFf1/FR1Djx4e
 rR18A8sFSzabq9whSHAAHBabncjC88erGiNX3A+7UBH8VbCd9nWgPt7Vtj7qhtzZBT7NgkOr3
 q9tYvpZUOo6haesj4UOBJwvbM/m4loGvNbuzqbO25mDEGqNXYSauzdKoY1zTJgXmdjLEVOlhC
 LWbZ1KvThLmjA5QTxarBR7J5GgyPH+ISrwn9DzpMaFMSN9yK/j3uEEPWo76wPDf2hQxASpo+n
 9XXmZdn+SOSsaaOAGD2GFtMpAEdu8N2HZv6FH0ZVc8vbMpvmfNDte7mu9lmLS5Zd6fiaeeA8n
 rdzhITxdTyjEJG8GbWRjWKEJnqH1jsm1SBJz8MM03zSaHwg4cyewVwiJ2FWY43HM6FFo0qQ29
 25EG8lEHIBdk639inYR93tzABC61G7YLHYoB/ITHzUDWqaVAJ+3rkt0t9p3PMtK3I9Ly6AFTN
 q7wcfpYFqcOlinQFjMXB4K4Cg1ZoUM9NpZmmRheZGrFCyGrufLi+qkGVeE49lL3U7SFL+SuGJ
 u/u8Hhkm6NlZZsA4yW50EYK/EGN+vZGkMX0Rec2LjwoK42Smiuo8yaLMhEzQn79QRce9rjRV8
 h7AVMmpq3aM4iDQnpS1xUN6u6HqWi+0rDV9aK35M17VLOZSAQ1QbaHbVJLB8rFgqPePxKiXid
 sbaUInM+xxbwlmT3K8wYtrmFC81ZWHwdFDKsuJovdKDYnYTtTsF5F/plr1pKpdj7gqnY+NfPc
 NQY563cNviC1sqq5cT0bfNoZFdauJlZNDZnHL7C/HCBBfLr91GJsyBrkUL



=E5=9C=A8 2025/2/10 01:38, Abdulla Bubshait =E5=86=99=E9=81=93:
> I have a problem with my btrfs system that is causing a few issues.
> Issues were in kernel 6.12 and still persist in kernel 6.13.0
>
> Mounting at boot has this problem:
> [    8.457699] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
> [    8.463544] BTRFS: device label horde devid 2 transid 2428513
> /dev/sdd (8:48) scanned by (udev-worker) (741)
> [    8.463645] BTRFS: device label horde devid 5 transid 2428513
> /dev/sdf (8:80) scanned by (udev-worker) (761)
> [    8.463928] BTRFS: device label horde devid 3 transid 2428513
> /dev/sdb1 (8:17) scanned by (udev-worker) (810)
> [    8.463946] BTRFS: device label horde devid 4 transid 2428513
> /dev/sdc (8:32) scanned by (udev-worker) (721)
> [    8.463966] BTRFS: device label horde devid 1 transid 2428513
> /dev/sde (8:64) scanned by (udev-worker) (751)
> [    9.145058] BTRFS info (device sde): first mount of filesystem
> 26debbc1-fdd0-4c3a-8581-8445b99c067c
> [    9.145064] BTRFS info (device sde): using crc32c (crc32c-intel)
> checksum algorithm
> [    9.145067] BTRFS info (device sde): using free-space-tree
> [   74.766650] BTRFS error (device sde): parent transid verify failed
> on logical 118776413634560 mirror 2 wanted 1840596 found 1740357
> [   74.782064] BTRFS error (device sde): parent transid verify failed
> on logical 118776413634560 mirror 1 wanted 1840596 found 1740357

Your fs is already broken.

Metadata COW is not working properly.

> [   74.782093] BTRFS error (device sde): Error removing orphan entry,
> stopping orphan cleanup
> [   74.782097] BTRFS error (device sde): could not do orphan cleanup -22
> [   79.968610] BTRFS error (device sde): open_ctree failed
>
> I can still mount the filesystem as ro, then remount it as rw which
> gives me access to my system without any issues.

Nope, it's just some luck that the RO mount doesn't read the corrupted
metadata, thus you can mount it initially.

>
> Running a logical-resolve on the offending address (118776413634560) giv=
e:
> ERROR: logical ino ioctl: No such file or directory

That bynter belongs to a tree block, it will never be resolved by
logical-resolve.

>
> running btrfs check (btrfs-progs 6.12-2) gives the following (using
> ellipses to cut off repeated messsage):
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> parent transid verify failed on 118776413634560 wanted 1840596 found 174=
0357
> parent transid verify failed on 118776413634560 wanted 1840596 found 174=
0357
> parent transid verify failed on 118776413634560 wanted 1840596 found 174=
0357
> Ignoring transid failure
> ref mismatch on [101299707011072 172032] extent item 1, found 0
> data extent[101299707011072, 172032] bytenr mimsmatch, extent item
> bytenr 101299707011072 file item bytenr 0
> data extent[101299707011072, 172032] referencer count mismatch (parent
> 118776413634560) wanted 1 have 0
> backpointer mismatch on [101299707011072 172032]
> owner ref check failed [101299707011072 172032]
> ref mismatch on [101303265419264 172032] extent item 1, found 0
> data extent[101303265419264, 172032] bytenr mimsmatch, extent item
> bytenr 101303265419264 file item bytenr 0
> data extent[101303265419264, 172032] referencer count mismatch (parent
> 118776413634560) wanted 1 have 0
> backpointer mismatch on [101303265419264 172032]
> owner ref check failed [101303265419264 172032]
> .......1000 lines
> ERROR: errors found in extent allocation tree or chunk allocation
> [4/8] checking free space tree
> [5/8] checking fs roots
> parent transid verify failed on 118776413634560 wanted 1840596 found 174=
0357
> Ignoring transid failure
> parent transid verify failed on 118776413634560 wanted 1840596 found 174=
0357
> Ignoring transid failure
> ....... 400 lines
> Wrong key of child node/leaf, wanted: (4750734, 108, 918990848), have:
> (18446744073709551606, 128, 95879105421312)
> Wrong generation of child node/leaf, wanted: 1740357, have: 1840596
> root 5 inode 305253 errors 2000, link count wrong
> unresolved ref dir 5226045 index 26 namelen 9 name Foo D filetype 0
> errors 3, no dir item, no dir index
> root 5 inode 305498 errors 2000, link count wrong
> unresolved ref dir 5227053 index 38 namelen 84 name foo.bar filetype 0
> errors 3, no dir item, no dir index
> root 5 inode 305613 errors 2000, link count wrong
> unresolved ref dir 5230734 index 147 namelen 88 name foo2.bar filetype
> 0 errors 3, no dir item, no dir index
> root 5 inode 305630 errors 2000, link count wrong
> .......100,000 lines
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/sde
> UUID: 26debbc1-fdd0-4c3a-8581-8445b99c067c
> found 63923737210880 bytes used, error(s) found
> total csum bytes: 62318397744
> total tree bytes: 71287357440
> total fs tree bytes: 1053753344
> total extent tree bytes: 661929984
> btree space waste bytes: 6740509258
> file data blocks allocated: 64021126631424
>   referenced 63814394556416
>
>
> Running a logical-resolve on the data extents listed that have the
> offending extent (118776413634560) as a parent returns nothing (no
> errors).
> Checking a sample of the file names mentioned with link count wrong
> and they appear to be fine in the filesystem.
>
> What would be the steps to clean up these issues from the filesystem?
>
It's a corruption. Just backup as much data as possible, but considering
there is subvolume tree corruption, you're going to lost quite some data.

It's also recommended to run a memtest, at least if it found some error
in your hardware memory, you know the root cause.

Thanks,
Qu

