Return-Path: <linux-btrfs+bounces-7883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D396FDEA
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Sep 2024 00:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1561C21EBD
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F01A158D8D;
	Fri,  6 Sep 2024 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JfhEeDCJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A113D251
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661245; cv=none; b=K9Ula4FrSgFUe2UlwTLu1Gwr2KFEbAWUeCmlgr0+OSb/5UY68+2qFyGT3BMak7tVjY5RP5qYr1ryYJG4YAsx5kkkyRITcGAt5k8SL92ysyypqD18PPwKyMkbxa6cGYEkBqcWWOyybp/6BDwfg6+5lXy94mLverNTBgRIjbfPdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661245; c=relaxed/simple;
	bh=2ZaDq5U0Uc2SDzt0ZDA2d1yTczZ9O5HNydBIeYQ0ZKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laYf6KjQ1TXnXB5LuXLp8cZbSHTrarcFg7JismIfLoJ/ESh0S6y6i6E63YiN22CO/Z6iMzKZSg+6/FUJUbP1/dgErOSTyFbq1fe7UTEADdiEs+CZ01aEZd5Wz4afnaCii3vPuIQCjgD67oDN3L94n3wmJVlN/c47fOfP6xQxtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JfhEeDCJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725661240; x=1726266040; i=quwenruo.btrfs@gmx.com;
	bh=yPn8Rbu8nEuK8Wr7JIzQGzfe4cESxxDqjUud7FIR/tA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JfhEeDCJZ0tt3O7PaUnOVbDqxOTEznVfMAgnfAfchMy6rgczxnCPQuvutn0xfZcb
	 7fPsjz2zy6aaawSFStWp3gz6ekyoEjPsKvcKSwM98J4mJQ3EnamWcntP3c4RKL2se
	 uBQrI4wfUQ8ooMmYAXvshmjnEmcqDlk9sUqsd+H2km8MsKPkIZ6UUUw+t/oPxJWUM
	 gaQSqWsaML8JBQlaA/vBM1GrJDVQ+A7sak04Iq2XHPPOBdbV6vpmUROnwZ6zi50F/
	 3ZuUbc1xYC39SE73fkpGItXIVrzpavQ9nSY1LmwvOWpqX1fGoe0/vSMVrsBr/M3bP
	 GXiMhD/d33KSq2isAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63VY-1ry5pH3x4i-00weG0; Sat, 07
 Sep 2024 00:20:40 +0200
Message-ID: <8cdf0eeb-0c88-4900-8e85-e793cffe7330@gmx.com>
Date: Sat, 7 Sep 2024 07:50:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SSD stuck in read-only mode with call trace and itemoff /
 itemsize errors
To: Brent Bartlett <brent.bartlett1@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CACSb8pLWjCPBvfYNGqFQ_6V06SFSqdm-Ea=SC6g+D9_=qygvgw@mail.gmail.com>
 <57d77231-4d07-4773-93c4-0f27bd9a851c@gmx.com>
 <CACSb8p+PLVhF8iKDjxr_jD+q8tAuG99NdF7Z2EQ5UZQqt9aJ4Q@mail.gmail.com>
 <6fc7b8e6-ae80-411b-8313-8e89d2c3a6d7@gmx.com>
 <CACSb8pKHFYYBVA7Jri+XnpMnrfRtfym8Xc0T4uVP3CyftecwEQ@mail.gmail.com>
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
In-Reply-To: <CACSb8pKHFYYBVA7Jri+XnpMnrfRtfym8Xc0T4uVP3CyftecwEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7LZnLSvbhLx9QBBCR4wUzpgh5SR4rxnBtMuEUJf6RQnm4kmYyyM
 y4tMsD2x08hj6r+Uv1jNOPcOfw1U9cv6k4IJ3SgDWt+W3TME9RL7KxikqiGP6e4nG0qFoLr
 h/CUBYUUywcoSF5R8NUMCjjac/EpWFe9haIpXERAfkix3ebc/KnKGQCaO5cH7jxUQIsr95n
 PVCPgMSq8cTGBNJxgAaEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pOfyT+1nBko=;23sMAAVu92AWt0gTKmcT7suEg8C
 a4sUbvXCoF/g1MTZU9hB07cPTgNYy9YDfKJLNcJgaWu0uEjFwgm1eE/9PUpRzz3cgyqbeeR0/
 ErcWVsQu0q+7YDZarfZkXqJ+AKCj931IOQY41cL17FkNpQeRn5FtjEofOAF/ndTA8h9NLPqIg
 +9FEN9uMQQwSV4GMiFNWzMN79jxep8p27J277+gBa7nbyhsmd20MzMKwtHKoNz1rFLK1GttX/
 +JuREvM9kQ1kOLpVbnpSvJLmSgpZ+JhjX6MwiB2qPL+IhBOCVian7zfIajj/xVpgocLZHfVgV
 shSqY2bqE+Z0D6W2tyJW8UbBG04byvoeu++1wqxEbetMaNxjcpx6kLOZO2aiiufGidXHPWWRI
 UobBiCxJH4bG0FB407IRJK/ghNuw8Gy74a1vmjhHEQmMP4H2AUJ65IpeDD/NxIC1Ifvrg6w12
 UITCNi8CXQO+ZXhesTJ9d+XTMZJg7I+CXKk5wHXB/Q/q3ZFA1Ihv4dzQKJN911VTRIpZ6vcx1
 0YYcpF7XIrojTTluz53NTdW3NJHZccfpDhXYlv1YpFib1hftq1Cv2z3EYW+wYhEcsqBAEJrLg
 uUDfCCgRQedYBRizqbkmp2pbbjSsfqjbVau+8IkX+55NgCbp0DodQxLKFZMMctlzj2Jvvh0BO
 6iZRcXbz8z+U3gYJX59xYbah0xAqWlJ1TY+WhBbuQPrbbDj4bYmVtqA94SPv80F1no6cKOGY3
 4f/y/Lt3svT/ZNJFtCeyc7BV1ANL5tgWB9zu1m/VipGbz4mMGtYzsVHx7M978o0asdUCw2RbM
 ZGAuf37jVX/S/p7KorAnwJDg==



=E5=9C=A8 2024/9/7 07:41, Brent Bartlett =E5=86=99=E9=81=93:
> I'm not familiar with memtest.=C2=A0 This is the program for testing RAM=
?

You can either go memtest86+, it supports both legacy BIOS and UEFI payloa=
d.

That should be the most comprehensive one, as it acts an independent
UEFI payload, with minimal amount of memory reserved.

The disadvantage is you need to boot into memtest86+ payload to do the tes=
t.

https://wiki.archlinux.org/title/Stress_testing#MemTest86+



Another but less comprehensive one is memtester, it will lock certain
amount of memory and do the tests in user space.

The problem is kernel can still reserve quite some memory, and that part
can not be tested.
But at least you do not need to boot into another UEFI payload.

Thanks,
Qu
>
> On Fri, Sep 6, 2024, 2:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     =E5=9C=A8 2024/9/7 04:12, Brent Bartlett =E5=86=99=E9=81=93:
>      > Here's the output from btrfs check --mode=3Dlowmem <device>
>      >
>      > Opening filesystem to check...
>      > Checking filesystem on /dev/nvme0n1p2
>      > UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
>      > [1/7] checking root items
>      > [2/7] checking extents
>      > ERROR: extent [228558536704 16384] lost referencer (owner: 1281,
>     level: 0)
>      > ERROR: extent[335642972160, 4096] referencer count mismatch (root=
:
>      > 257, owner: 9223372036856479121, offset: 305790976) wanted: 1,
>     have: 0
>      > ERROR: file extent[1703313 305790976] root 257 owner 257 backref =
lost
>      > ERROR: errors found in extent allocation tree or chunk allocation
>
>     So that's the only corruption (at least inside metadata).
>
>     IIRC "btrfs check --repair" is able to fix that, but just in case, y=
ou
>     may want to backup the important data first.
>
>     Meanwhile I'm more interested in the memtest result though.
>
>     Thanks,
>     Qu
>
>      > [3/7] checking free space tree
>      > [4/7] checking fs roots
>      > [5/7] checking only csums items (without verifying data)
>      > [6/7] checking root refs done with fs roots in lowmem mode, skipp=
ing
>      > [7/7] checking quota groups skipped (not enabled on this FS)
>      > found 771521245184 bytes used, error(s) found
>      > total csum bytes: 750323744
>      > total tree bytes: 2901278720
>      > total fs tree bytes: 1938309120
>      > total extent tree bytes: 166903808
>      > btree space waste bytes: 365206037
>      > file data blocks allocated: 857740091392
>      > referenced 855826853888
>      >
>      > and here's the output from btrfs check <device>
>      >
>      > Opening filesystem to check...
>      > Checking filesystem on /dev/nvme0n1p2
>      > UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
>      > [1/7] checking root items
>      > [2/7] checking extents
>      > tree extent[228558536704, 16384] root 257 has no backref item in
>     extent tree
>      > tree extent[228558536704, 16384] root 1281 has no tree block foun=
d
>      > incorrect global backref count on 228558536704 found 2 wanted 1
>      > backpointer mismatch on [228558536704 16384]
>      > data extent[335642972160, 4096] referencer count mismatch (root 2=
57
>      > owner 1703313 offset 305790976) wanted 0 have 1
>      > data extent[335642972160, 4096] bytenr mimsmatch, extent item byt=
enr
>      > 335642972160 file item bytenr 0
>      > data extent[335642972160, 4096] referencer count mismatch (root 2=
57
>      > owner 9223372036856479121 offset 305790976) wanted 1 have 0
>      > backpointer mismatch on [335642972160 4096]
>      > ERROR: errors found in extent allocation tree or chunk allocation
>      > [3/7] checking free space tree
>      > [4/7] checking fs roots
>      > [5/7] checking only csums items (without verifying data)
>      > [6/7] checking root refs
>      > [7/7] checking quota groups skipped (not enabled on this FS)
>      > found 771521236992 bytes used, error(s) found
>      > total csum bytes: 750323744
>      > total tree bytes: 2901278720
>      > total fs tree bytes: 1938309120
>      > total extent tree bytes: 166903808
>      > btree space waste bytes: 365206037
>      > file data blocks allocated: 857740091392
>      > referenced 855826853888
>      >
>      > Thank you
>      >
>      > On Fri, Sep 6, 2024 at 1:39=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@=
gmx.com
>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>      >>
>      >>
>      >>
>      >> =E5=9C=A8 2024/9/6 10:29, Brent Bartlett =E5=86=99=E9=81=93:
>      >>> I have an SSD drive that was mounted by the system as read-only
>     due to
>      >>> errors. I have posted my full dmesg here:
>      >>> https://pastebin.com/BDQ9eUVc <https://pastebin.com/BDQ9eUVc>
>      >>
>      >> Great you have posted the full output:
>      >>
>      >> [=C2=A0 =C2=A036.195752]=C2=A0 item 123 key (228558536704 169 0)=
 itemoff 12191
>     itemsize 33
>      >> [=C2=A0 =C2=A036.195754]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exten=
t refs 1 gen 101460 flags 2
>      >> [=C2=A0 =C2=A036.195754]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref#0=
: tree block backref root 1281
>      >>
>      >> This is the offending backref item for the tree block.
>      >>
>      >> But what your fs is expecting is:
>      >>
>      >> [=C2=A0 =C2=A036.195988] BTRFS critical (device nvme0n1p2 state =
EA): unable to
>      >> find ref byte nr 228558536704 parent 0 root 257 owner 0 offset 0
>     slot 124
>      >>
>      >> hex(1281) =3D 0x501
>      >> hex(257)=C2=A0 =3D 0x101
>      >>
>      >> Another bitflip.
>      >>
>      >> I'm pretty sure "btrfs check" will just give the same error.
>      >>
>      >> And this really looks like something wrong with your hardware
>     memory.
>      >>
>      >>>
>      >>> Please let me know if you need any other information. How
>     should I proceed?
>      >>>
>      >>
>      >> It's strongly recommend to run a full memtest before doing anyth=
ing.
>      >>
>      >> I'd say your previous RO flips may also be caused by your faulty
>      >> hardware memory too.
>      >>
>      >> Other than that, please provide the following output on another
>     system:
>      >> (The lowmem mode output is a little more human readable)
>      >>
>      >> # btrfs check --mode=3Dlowmem <device>
>      >> # btrfs check <device>
>      >>
>      >> To make sure if that's the only corruption, and we can determine
>     what to
>      >> do next.
>      >>
>      >> Thanks,
>      >> Qu
>

