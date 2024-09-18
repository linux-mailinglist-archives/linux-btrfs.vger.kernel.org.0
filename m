Return-Path: <linux-btrfs+bounces-8101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CA97B756
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 07:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1CB1F25A54
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 05:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1714D6FE;
	Wed, 18 Sep 2024 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lYcvdKOg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3213CFBC
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726636300; cv=none; b=ND8n6VVu7frmSETZD57wc5so0CZx7cUm/1vl7QbJykCf3vgzO7bSJN6HnX4BJVPvAkuh/FN9+Z/WDaF83HZmkeah+Cd5bLoX5XInjYajyCHC/cY/7Rm72jjw5yNz33zYqi+aZY1oxSeJ5AYtGqcmUFk1BSNng8saxF693/phneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726636300; c=relaxed/simple;
	bh=A1cvnmMHspL5o5NuVtmTeRfYb32O3p1sboubhz5vv0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4oMtiVYRKJndL9i7S0oPT95wvWZeyvlPq+0i+EDimGmNIeuDLcQo4JWcwHL3AvgK0uXnqVy23sSlhdEsVQxKOlKnWtPdrZ3aNUdqLJE33zva40p3sBbCqRGjFG5sSWtqnm98HV2TTQMiZ8rcgIpED7lED34Aly6Nht1hud0mpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lYcvdKOg; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726636294; x=1727241094; i=quwenruo.btrfs@gmx.com;
	bh=lK22khm5i6oNBsZsbfKAOOPWaVjV48UJSdez5iUwCGY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lYcvdKOgC6OSTr28+Z3yV5B2nniI309njVQtPVbewhCOmKRxff5b6cDxNbv6fCKf
	 lg46WEzw+1SSyZPGNIdYg3+t9hw0ZRT8I4230/IJYoz6xNxtaNxZvWwncAbH/tv4L
	 +XRFjlLrIaeKuhnXbggXqQXKw3KGwOPDYiLbp3wHAAm/mlO11pH6Sb78vC4CmmSZ3
	 U89WTr8AfCQxhDxYzcp9LfPU43fwKCCM/iB7P3qgpK4s4df/M5fpJvcdcmOh/MZg8
	 5SKdvx3EwXfvN8LGFxJUvDkf5UWlRam0okfYBpA+pgMzZvq3HfQxqS6xnQbD+wpyb
	 kVhjLaLULxw4xoMtZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvcA-1sUhlO1g3M-00OVdE; Wed, 18
 Sep 2024 07:11:34 +0200
Message-ID: <7d10742c-41eb-4b7d-9ff4-189eb71f85b7@gmx.com>
Date: Wed, 18 Sep 2024 14:41:32 +0930
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
 <8cdf0eeb-0c88-4900-8e85-e793cffe7330@gmx.com>
 <CACSb8p+F0njvqFg0-ZVZ0bTtgVGwvV6pSYdWsi=0Cg7BK1qh=g@mail.gmail.com>
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
In-Reply-To: <CACSb8p+F0njvqFg0-ZVZ0bTtgVGwvV6pSYdWsi=0Cg7BK1qh=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CpXYKQEgsKVcAVl5Y3wLnnAGdf4AcApr18tqY96BsgGx9KGbAm8
 NP9d+Q9BG3mncxpQLo89x/gvmlKyFkEjfLcs1Mag1Twnh/yg5gcMwCinypzPJNAw80iPpBr
 bilKIwScTTDKKS221iImzuUQPrAyRCwkTMn8CxMMdCjRdYZdDM0dpTc5DwhiFM8cp3ie4K9
 j9l7H70RBa3JcQY6VmbpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IS4G4hDDKsU=;5o6KcfJGzKftvbCfSMMM5kzTt0O
 xADL3pfjiQ7NyOruEgcDHd9PVIgVBHqDqGIztgVKGoTGwGjfo3fqGGaFuYIXRrtWV0yQVf0vW
 B+ALlhrWzTpgg1rVgUMGDhxFFvDI5n7HEdPdmXFk0MDFlDCJE1gl+5Vg3ioWhmuN4s9IJFMrI
 j9f2i4xvFs/pi59BLD3ELcK8LgxQdLdohwB6hgOSJPY2hmcvmOC65Vnw5PJaeRY5c4rUNHkef
 eJKhssqVnFr7JaWrBhmOHhboInZ41uEbipbeOMCf2u0xbqQz3EdlAa7LNOICTAXaV8eNE8ILX
 1DHhhJSZMtuNewj0nW1uVcWt84LaHW9P5JHd9M3IFw1WC210JC8nRt/L8hzBZAaZLUOdIqGAe
 so+nIjWXvkw5IOut+nZP0PDju8h0A2ganxxfpSSuTupw9mimsLq13NTe3aTsNf/mpY/VXPTh5
 kLdaeK0+8OhzPZ2RIQ02krLKJLlqpVfKxFZOUfDwIyoG4Wnz3TI4YsXSCniuJmi0i8hbBOtXT
 AM8kK5xakbXOr9EKjwrkaU4a2c+WohcYWBEtfc51I9CbDA/HP1+fdHZkU6fDkWd5U5ytMvORs
 rwVrv1IdODGDg3j+thDOCfJWnuWrygAiqKE2a62oNZlfGqkMC3r0KybeSoWBaL8wTJ5PJJlGu
 +nR7H2LfxLARBcpURiFYVXd70dZ0E2U/hS7C8ylOeuUyEY1pYfvh25DFSDqZTsEZIzhjBw2Hh
 bMLqD3/wGfcC2ShA0tme7BU5NwvtQYFbJ97QR7SJ1LHfleDD6wMGY/IngnZUAfgB8R8YOinAI
 rvRuUY/CyJPonaPgcjcKOKFkBa+Z+8EtBbVaACvszfICY=



=E5=9C=A8 2024/9/18 14:29, Brent Bartlett =E5=86=99=E9=81=93:
> I used Ventoy to boot into a memtest86+ ISO. I got errors, so it looks
> like there's a problem with at least one of my memory modules.

Great, btrfs is again acting as the second best memtest tool. :)

Then you can run the "btrfs check --repair" on a system which can pass
memtest, and that should fix the error.
Just to be extra safe, you can run "btrfs check --readonly" after above
fix to make sure everything is fine.

Thanks,
Qu
>
> On Fri, Sep 6, 2024, 3:20 PM Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     =E5=9C=A8 2024/9/7 07:41, Brent Bartlett =E5=86=99=E9=81=93:
>      > I'm not familiar with memtest.=C2=A0 This is the program for test=
ing RAM?
>
>     You can either go memtest86+, it supports both legacy BIOS and UEFI
>     payload.
>
>     That should be the most comprehensive one, as it acts an independent
>     UEFI payload, with minimal amount of memory reserved.
>
>     The disadvantage is you need to boot into memtest86+ payload to do
>     the test.
>
>     https://wiki.archlinux.org/title/Stress_testing#MemTest86+
>     <https://wiki.archlinux.org/title/Stress_testing#MemTest86+>
>
>
>
>     Another but less comprehensive one is memtester, it will lock certai=
n
>     amount of memory and do the tests in user space.
>
>     The problem is kernel can still reserve quite some memory, and that =
part
>     can not be tested.
>     But at least you do not need to boot into another UEFI payload.
>
>     Thanks,
>     Qu
>      >
>      > On Fri, Sep 6, 2024, 2:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com
>     <mailto:quwenruo.btrfs@gmx.com>
>      > <mailto:quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>>>
>     wrote:
>      >
>      >
>      >
>      >=C2=A0 =C2=A0 =C2=A0=E5=9C=A8 2024/9/7 04:12, Brent Bartlett =E5=
=86=99=E9=81=93:
>      >=C2=A0 =C2=A0 =C2=A0 > Here's the output from btrfs check --mode=
=3Dlowmem <device>
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > Opening filesystem to check...
>      >=C2=A0 =C2=A0 =C2=A0 > Checking filesystem on /dev/nvme0n1p2
>      >=C2=A0 =C2=A0 =C2=A0 > UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
>      >=C2=A0 =C2=A0 =C2=A0 > [1/7] checking root items
>      >=C2=A0 =C2=A0 =C2=A0 > [2/7] checking extents
>      >=C2=A0 =C2=A0 =C2=A0 > ERROR: extent [228558536704 16384] lost ref=
erencer (owner:
>     1281,
>      >=C2=A0 =C2=A0 =C2=A0level: 0)
>      >=C2=A0 =C2=A0 =C2=A0 > ERROR: extent[335642972160, 4096] reference=
r count
>     mismatch (root:
>      >=C2=A0 =C2=A0 =C2=A0 > 257, owner: 9223372036856479121, offset: 30=
5790976) wanted: 1,
>      >=C2=A0 =C2=A0 =C2=A0have: 0
>      >=C2=A0 =C2=A0 =C2=A0 > ERROR: file extent[1703313 305790976] root =
257 owner 257
>     backref lost
>      >=C2=A0 =C2=A0 =C2=A0 > ERROR: errors found in extent allocation tr=
ee or chunk
>     allocation
>      >
>      >=C2=A0 =C2=A0 =C2=A0So that's the only corruption (at least inside=
 metadata).
>      >
>      >=C2=A0 =C2=A0 =C2=A0IIRC "btrfs check --repair" is able to fix tha=
t, but just in
>     case, you
>      >=C2=A0 =C2=A0 =C2=A0may want to backup the important data first.
>      >
>      >=C2=A0 =C2=A0 =C2=A0Meanwhile I'm more interested in the memtest r=
esult though.
>      >
>      >=C2=A0 =C2=A0 =C2=A0Thanks,
>      >=C2=A0 =C2=A0 =C2=A0Qu
>      >
>      >=C2=A0 =C2=A0 =C2=A0 > [3/7] checking free space tree
>      >=C2=A0 =C2=A0 =C2=A0 > [4/7] checking fs roots
>      >=C2=A0 =C2=A0 =C2=A0 > [5/7] checking only csums items (without ve=
rifying data)
>      >=C2=A0 =C2=A0 =C2=A0 > [6/7] checking root refs done with fs roots=
 in lowmem
>     mode, skipping
>      >=C2=A0 =C2=A0 =C2=A0 > [7/7] checking quota groups skipped (not en=
abled on this FS)
>      >=C2=A0 =C2=A0 =C2=A0 > found 771521245184 bytes used, error(s) fou=
nd
>      >=C2=A0 =C2=A0 =C2=A0 > total csum bytes: 750323744
>      >=C2=A0 =C2=A0 =C2=A0 > total tree bytes: 2901278720
>      >=C2=A0 =C2=A0 =C2=A0 > total fs tree bytes: 1938309120
>      >=C2=A0 =C2=A0 =C2=A0 > total extent tree bytes: 166903808
>      >=C2=A0 =C2=A0 =C2=A0 > btree space waste bytes: 365206037
>      >=C2=A0 =C2=A0 =C2=A0 > file data blocks allocated: 857740091392
>      >=C2=A0 =C2=A0 =C2=A0 > referenced 855826853888
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > and here's the output from btrfs check <dev=
ice>
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > Opening filesystem to check...
>      >=C2=A0 =C2=A0 =C2=A0 > Checking filesystem on /dev/nvme0n1p2
>      >=C2=A0 =C2=A0 =C2=A0 > UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
>      >=C2=A0 =C2=A0 =C2=A0 > [1/7] checking root items
>      >=C2=A0 =C2=A0 =C2=A0 > [2/7] checking extents
>      >=C2=A0 =C2=A0 =C2=A0 > tree extent[228558536704, 16384] root 257 h=
as no backref
>     item in
>      >=C2=A0 =C2=A0 =C2=A0extent tree
>      >=C2=A0 =C2=A0 =C2=A0 > tree extent[228558536704, 16384] root 1281 =
has no tree
>     block found
>      >=C2=A0 =C2=A0 =C2=A0 > incorrect global backref count on 228558536=
704 found 2
>     wanted 1
>      >=C2=A0 =C2=A0 =C2=A0 > backpointer mismatch on [228558536704 16384=
]
>      >=C2=A0 =C2=A0 =C2=A0 > data extent[335642972160, 4096] referencer =
count mismatch
>     (root 257
>      >=C2=A0 =C2=A0 =C2=A0 > owner 1703313 offset 305790976) wanted 0 ha=
ve 1
>      >=C2=A0 =C2=A0 =C2=A0 > data extent[335642972160, 4096] bytenr mims=
match, extent
>     item bytenr
>      >=C2=A0 =C2=A0 =C2=A0 > 335642972160 file item bytenr 0
>      >=C2=A0 =C2=A0 =C2=A0 > data extent[335642972160, 4096] referencer =
count mismatch
>     (root 257
>      >=C2=A0 =C2=A0 =C2=A0 > owner 9223372036856479121 offset 305790976)=
 wanted 1 have 0
>      >=C2=A0 =C2=A0 =C2=A0 > backpointer mismatch on [335642972160 4096]
>      >=C2=A0 =C2=A0 =C2=A0 > ERROR: errors found in extent allocation tr=
ee or chunk
>     allocation
>      >=C2=A0 =C2=A0 =C2=A0 > [3/7] checking free space tree
>      >=C2=A0 =C2=A0 =C2=A0 > [4/7] checking fs roots
>      >=C2=A0 =C2=A0 =C2=A0 > [5/7] checking only csums items (without ve=
rifying data)
>      >=C2=A0 =C2=A0 =C2=A0 > [6/7] checking root refs
>      >=C2=A0 =C2=A0 =C2=A0 > [7/7] checking quota groups skipped (not en=
abled on this FS)
>      >=C2=A0 =C2=A0 =C2=A0 > found 771521236992 bytes used, error(s) fou=
nd
>      >=C2=A0 =C2=A0 =C2=A0 > total csum bytes: 750323744
>      >=C2=A0 =C2=A0 =C2=A0 > total tree bytes: 2901278720
>      >=C2=A0 =C2=A0 =C2=A0 > total fs tree bytes: 1938309120
>      >=C2=A0 =C2=A0 =C2=A0 > total extent tree bytes: 166903808
>      >=C2=A0 =C2=A0 =C2=A0 > btree space waste bytes: 365206037
>      >=C2=A0 =C2=A0 =C2=A0 > file data blocks allocated: 857740091392
>      >=C2=A0 =C2=A0 =C2=A0 > referenced 855826853888
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > Thank you
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > On Fri, Sep 6, 2024 at 1:39=E2=80=AFAM Qu W=
enruo
>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:quwenruo.btrfs@gmx.com
>     <mailto:quwenruo.btrfs@gmx.com>>> wrote:
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> =E5=9C=A8 2024/9/6 10:29, Brent Bartlett =
=E5=86=99=E9=81=93:
>      >=C2=A0 =C2=A0 =C2=A0 >>> I have an SSD drive that was mounted by t=
he system as
>     read-only
>      >=C2=A0 =C2=A0 =C2=A0due to
>      >=C2=A0 =C2=A0 =C2=A0 >>> errors. I have posted my full dmesg here:
>      >=C2=A0 =C2=A0 =C2=A0 >>> https://pastebin.com/BDQ9eUVc
>     <https://pastebin.com/BDQ9eUVc> <https://pastebin.com/BDQ9eUVc
>     <https://pastebin.com/BDQ9eUVc>>
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> Great you have posted the full output:
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> [=C2=A0 =C2=A036.195752]=C2=A0 item 123 ke=
y (228558536704 169 0) itemoff
>     12191
>      >=C2=A0 =C2=A0 =C2=A0itemsize 33
>      >=C2=A0 =C2=A0 =C2=A0 >> [=C2=A0 =C2=A036.195754]=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 extent refs 1 gen 101460 flags 2
>      >=C2=A0 =C2=A0 =C2=A0 >> [=C2=A0 =C2=A036.195754]=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ref#0: tree block backref root 1281
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> This is the offending backref item for the=
 tree block.
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> But what your fs is expecting is:
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> [=C2=A0 =C2=A036.195988] BTRFS critical (d=
evice nvme0n1p2 state
>     EA): unable to
>      >=C2=A0 =C2=A0 =C2=A0 >> find ref byte nr 228558536704 parent 0 roo=
t 257 owner 0
>     offset 0
>      >=C2=A0 =C2=A0 =C2=A0slot 124
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> hex(1281) =3D 0x501
>      >=C2=A0 =C2=A0 =C2=A0 >> hex(257)=C2=A0 =3D 0x101
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> Another bitflip.
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> I'm pretty sure "btrfs check" will just gi=
ve the same error.
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> And this really looks like something wrong=
 with your hardware
>      >=C2=A0 =C2=A0 =C2=A0memory.
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >>>
>      >=C2=A0 =C2=A0 =C2=A0 >>> Please let me know if you need any other =
information. How
>      >=C2=A0 =C2=A0 =C2=A0should I proceed?
>      >=C2=A0 =C2=A0 =C2=A0 >>>
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> It's strongly recommend to run a full memt=
est before
>     doing anything.
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> I'd say your previous RO flips may also be=
 caused by your
>     faulty
>      >=C2=A0 =C2=A0 =C2=A0 >> hardware memory too.
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> Other than that, please provide the follow=
ing output on
>     another
>      >=C2=A0 =C2=A0 =C2=A0system:
>      >=C2=A0 =C2=A0 =C2=A0 >> (The lowmem mode output is a little more h=
uman readable)
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> # btrfs check --mode=3Dlowmem <device>
>      >=C2=A0 =C2=A0 =C2=A0 >> # btrfs check <device>
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> To make sure if that's the only corruption=
, and we can
>     determine
>      >=C2=A0 =C2=A0 =C2=A0what to
>      >=C2=A0 =C2=A0 =C2=A0 >> do next.
>      >=C2=A0 =C2=A0 =C2=A0 >>
>      >=C2=A0 =C2=A0 =C2=A0 >> Thanks,
>      >=C2=A0 =C2=A0 =C2=A0 >> Qu
>      >
>

