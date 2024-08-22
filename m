Return-Path: <linux-btrfs+bounces-7382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1072C95A89D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 02:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8664C28356C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 00:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD523B0;
	Thu, 22 Aug 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LxxaP9Ec"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BF28EA
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285619; cv=none; b=rwnMZb20UkzO09ilYFhhbs4FsE1fLjWkpg2rpd484dOnLatwHimpEbaabAr+ybhwk0q2RGwKboIm5XIuLkMiMEBSTBy8vecUtvaMbF/TT9GmjWoeAYC06dDzkVHODDovU6R+ew+GW2RkfSZJ6ntRywpf1A/IvwdGrTY73Yw+ztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285619; c=relaxed/simple;
	bh=Ik4JuTx8drT40dGSAfMA1eLoU8fD5b5Wrvqu2E8TPEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sL1NUXxF0/EMdKMmG+L67f6N1fJokAmrYy9cDUYiFhu/xfV9v0A9BlfQXLfcOsjU1F85BlsvaQzjScHCw9Ad7d2Qu9yOzcp+W3FdAi/kTOz659VflR959SqWtvu6bIy6ssfF8HNvtJHSiUc5q3/VA6jmGu3P0U5VV4WQQGsIoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LxxaP9Ec; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724285614; x=1724890414; i=quwenruo.btrfs@gmx.com;
	bh=yDuaffIFLrOpvs/InJXQy78UZFEYXXyOA0jRVTLBfSE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LxxaP9Ec7oOg7xEZBfxuEttAAVKOCrCuCipu2cS/kjvO2u85rL4lhimAsooPpcXd
	 wonMoVi/+Sqgn9AYCxAsiTmUa1AabHKA/LuoacZYnTJGZpkoyPhFV9qaeWLjsW4vx
	 bzdF2kRWo3rGBB3gSAft0VLInwskJmACkzQdUOBJuVR6na3IVa6qVgUNDPKbnBLPk
	 OgHLvwDNF2lt+eJkpk9xLPcNVIBuMWZ1GS3hPnGPNp0qkWBbRQffH/ZcUPr6uG9Rx
	 0WPwBNulHVzj1jsHzWFK5kB6HD2gJ5C9hz0pCdsNYO6aMgFtJXcQqiPFMye/0QSOl
	 v1jG+U/uzIrLZjp11g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1swf243Uef-009x4Y; Thu, 22
 Aug 2024 02:13:34 +0200
Message-ID: <4bbbe7f6-99b4-4d53-a72c-370f2c1ed4ca@gmx.com>
Date: Thu, 22 Aug 2024 09:43:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: File system errors causing read-only lock
To: Emily May <revsys413@gmail.com>, linux-btrfs@vger.kernel.org
References: <CABxKzfCEney-J_tE1yBVDaHAZTYKZXSqVd8deeBtwFx=RNCXNA@mail.gmail.com>
 <07e39275-8bcc-4656-9458-d05d0d68aa9c@gmx.com>
 <CABxKzfCFBgdPu21+n2mrF4Cf3yzM8CPf9q4oYJs=om0QS_Rbtg@mail.gmail.com>
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
In-Reply-To: <CABxKzfCFBgdPu21+n2mrF4Cf3yzM8CPf9q4oYJs=om0QS_Rbtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nAbuOrnXJiYiKNSGex8fEqcPBziZDoIs+/LvaNEqMb4y+Qrz3yi
 V/PlKiWvZV0BFuc1b1r1y5Z8sSKzTLdyEK1pPCYVXNcrd/9mseX5O2BsNkAkJ+i8MVpu54E
 guVFwmU98O4Q6lbHgXpJP7BWbSU8xFPKIcLLMzIrsKWUq2laeIQcrbESDSpJdL9PsUjtaR4
 3ukZoxld1XbxXZ+MwBGPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kg8qVMhyGDw=;53qSEFzLOYRwF7+1R30NSGqub3A
 i3079gwWsHHk5jDtpdD5hlffBOrqws1aHXoQh6zFcCTVXFWic+X1ofYdHIMhV0qQEb2SsfTcU
 FRV7meHinuy/vHxdjIcS8joLZ0hpEyRMRLsoAjY9ECBC2XAlKPxA7kqBHjns4e0Bdzu1j2ui0
 ef2iocz+KgTfaFhm8yasSidQtuk5UmaK3liyJeylyFH/+KA6tORtrPZvpKEp8z2foYd0RXwG/
 1wm3ZDakihdRnde5oPF6QyWxJNnqbWHDcR7Etu31sdKws+IyCvuuBV8ikA/0QCP2P+CJrCZV+
 v3Nj4Gf+rC3U5Asco69hUT80pn8vE7Dfw6UgvIaAWAyaW/b0ELORycn31ftgRXXVe05648BY/
 nXWVABvC1Cx3UWmSZiPQj7vLWVFAHP1TewO/3Xv6zl2MRI8xzmmO8KMs0kFrMJQlHlbiCSid8
 qN9quu84f/mi+GFXXaYXIpR/A6l0K3Zt5In1xgGZ/Ihswegb2bZOXNwNOaLex12i+9nPpjQ8z
 DRp4kyDZlVrk4MetdCU2mZHMkyf17corN8eCygTMyUA+uzz1Y1k0Oa3mdCfujjcZ2bOtFPRDe
 EAwJjTL9r3XRFaVy2mn1bnK3ex5hAxHQuhy/UFbn4nI65+YDdSWFIRoHXzqLdb/7MLM8ktsVq
 d9hoE/UeWMJaE+4VqUinJZUd1aNpKrb7Ao3jOsaVJU5fo1ztHBCWB7SIoVIcmnqXZaXl25j20
 AjzHqY5Ef1f1sZkrk3sz75mB5jEslZBSDr3Hpxfq69IITaXQIoH2CxfCsfUziOShhFaTEihU9
 zCI1brW7Ya9PUmWqk9NPr92yx37+jMZs2yc8F1jaMGvKg=



=E5=9C=A8 2024/8/22 09:11, Emily May =E5=86=99=E9=81=93:
> Okay, I=E2=80=99ve installed a more recent openSUSE build, which is runn=
ing v6.5
> progs, onto my live USB, and I will use that for anything I don=E2=80=99=
t need
> to boot the problematic SSD for from now on.
>
> One thing I DO need to boot that SSD for is to get that dmesg to see
> what exactly is happening, because it only seems to flip to read-only
> when it=E2=80=99s booted. So after doing that, and then piping a dmesg t=
o
> termbin as soon as I noticed the FS flipping, this was the result. I
> believe it will be far more helpful:
>
> https://termbin.com/95np <https://termbin.com/95np>

This is enough to show the corruption.

[  396.619887] 	item 146 key (2846002233344 168 24576) itemoff 8928
itemsize 79
[  396.619889] 		extent refs 3 gen 7333105 flags 1
[  396.619890] 		ref#0: extent data backref root 257 objectid 4306433448
offset 0 count 1
[  396.619892] 		ref#1: shared data backref parent 1541599117312 count 1
[  396.619894] 		ref#2: shared data backref parent 1541594447872 count 1

[  396.620269] BTRFS error (device nvme0n1p3): unable to find ref byte
nr 2846002233344 parent 0 root 257  owner 11466152 offset 0

For the bytenr 2846002233344 root 257, the objectid on-disk is
4306433448, but the one we want to delete is having objectid 2846002233344

hex(4306433448) =3D 0x100aef5a8
hex(11466152)   =3D 0x000aef5a8

So it's another bitflip. Before doing anything I strongly recommend to a
memtest.

Then you can still mount the fs read-only and copy your data.

Unfortunately the corruption seems to be inside the subvolume tree,
while the extent tree looks correct, I do not think btrfs-check can
really repair this.

>
> Also, I tried to use the command requested in the previous email (that i=
s,
> sudo btrfs check --read-only /dev/nvme0n1p3 &> /tmp/output), but it
> doesn=E2=80=99t seem to be doing anything and I can=E2=80=99t find any p=
roduct files.
> (I=E2=80=99m not very good with bash, apologies.)

The output file is at /tmp/output.

Just change '/tmp/output' to whatever path you prefer.

That output is still helpful, to rule out any other corruption.

Thanks,
Qu

>
> I will look into it more, assuming this is user error, to see if I can
> get something to dump for more information when I=E2=80=99m back at my m=
achine.
>
> Thanks,
> Emily
>
> On Tue, Aug 20, 2024 at 10:34=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     =E5=9C=A8 2024/8/21 14:55, Emily May =E5=86=99=E9=81=93:
>      > Hello,
>      >
>      > I've been having an issue with my PC suddenly going read-only aft=
er a
>      > short amount of uptime. Before panicking about SSD failure or
>     something
>      > like that, I was told it would be prudent to check for brtfs
>     errors and
>      > ask the mailing group for support. Though I don't really
>     understand what
>      > the log is saying, from what I can see it does indeed seem like t=
here
>      > are errors with the file system.
>      >
>      > I've attached the text from sudo btrfs check --readonly
>     /dev/nvme0n1p3
>      > to this message along with the dmesg.log. Here are the other comm=
ands
>      > needed for support requests:
>      >
>      > mint@mint:~$ uname -a
>      > Linux mint 5.15.0-76-generic #83-Ubuntu SMP Thu Jun 15 19:16:32
>     UTC 2023
>      > x86_64 x86_64 x86_64 GNU/Linux
>      > mint@mint:~$ btrfs --version
>      > btrfs-progs v5.16.2
>
>     Since you're using a liveUSB, please use a much newer distro.
>     With at least v6.0 progs.
>
>     And when dumping the output of "btrfs check", please also dump the
>     stderr and stdout, e.g.
>
>      =C2=A0 $ sudo btrfs check --read-only /dev/nvme0n1p3 &> /tmp/output
>
>
>     Furthermore, you should check the dmesg immediately after the fs fli=
ps
>     read-only, that can provide the most direct reason, especially we ma=
y
>     hit some sanity checks triggered by something like hardware memory
>     bitflip (in that case, btrfs flips RO to prevent the corruption reac=
hing
>     the disk, but won't be detected by btrfs-check afterwards).
>
>     The attached dmesg provides nothing useful instead...
>
>     Thanks,
>     Qu
>      > mint@mint:~$ btrfs fi show
>      > mint@mint:~$ btrfs fi df
>     /media/mint/6c2c7d51-04aa-4be3-bdc6-86d30b1119f9
>      > Data, single: total=3D1.76TiB, used=3D1.67TiB
>      > System, DUP: total=3D40.00MiB, used=3D240.00KiB
>      > Metadata, DUP: total=3D9.00GiB, used=3D5.11GiB
>      > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>      >
>      > Note: This is obviously from a live USB, not my main system, so a=
ny
>      > system information may not necessarily be correct. However, it is=
 the
>      > same LTS version of Linux Mint as is installed on the problematic
>     file
>      > system.
>      >
>      > Please let me know where to go from here.
>      >
>      > Thanks for your time,
>      > Emily
>

