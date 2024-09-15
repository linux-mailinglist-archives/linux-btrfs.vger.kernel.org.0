Return-Path: <linux-btrfs+bounces-8036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D8979930
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 23:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85BEB212B9
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1183CDA;
	Sun, 15 Sep 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AlBp+VSo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A453C488
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726435804; cv=none; b=HrXWCWbYS9NYjzmmJ7KNWz2QCbXyQdhlxuDdHCLlbxP82/sH0PzkwfFGQy3rQHjNEAMzGYG3bvYjU597fRUblrS0Cr8k0rfggDIWD7E24+OnblMdVJi26VJLuvLNSQCSuNiZxmI57TxUFsMG7+qVYhKfzUdLCsP6gdRyMUmIoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726435804; c=relaxed/simple;
	bh=x+MraY98yyngI8zAOsO5OucpRs4CcUMEw+Eb+Idkb2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z9tB4r94/2A2V90lBwo0DQTgbiFrnFlZSFs/7v97C6uE92ibL0Z7bTR8cQ9Gld551dzi8RxZ/FLMwY/nUao1vWDDXIDJ7Vu+/53uOZtKZcEM1dJsjLkCSnF6y15YhgMlosBOkOQrX0uqUSjHJf7t5fN7eAdYLgxr7syCTvjDNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AlBp+VSo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726435798; x=1727040598; i=quwenruo.btrfs@gmx.com;
	bh=x+MraY98yyngI8zAOsO5OucpRs4CcUMEw+Eb+Idkb2o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AlBp+VSoiE/x1AYpePc4SGECc/dxSAEXaaWJdEbNoOVk6lR8hhl881VN/71mzG9X
	 qa34/GJ4nFAeK6ypRHuCFgPglr3yxSg5MXvu4ZvIVRnAFMU425lr7kJwj4sJ/sM2n
	 SRSbb9jPALzmBUpzBI9WOHAyUKoHXF+yTVr9HxSw1C+ndNOnnlUeTAIaafc2C/IZ+
	 bOuSt7v8cyGYoc1NzCHcZ+9AsaLhab5U3op2+S0LnANUV77elp9D6IZbQ3bGSLvL/
	 J1KDWe0N2UPaJObx0egB3gQbglMJtmsZPvLK8Sc00Yxdaeba8r9CE8pM4oHb1LIG7
	 3GZCRe1RO+RzCfBWrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1s1xSN2pba-0179Ym; Sun, 15
 Sep 2024 23:29:58 +0200
Message-ID: <05487866-261a-46da-8b1b-fa8e0092be81@gmx.com>
Date: Mon, 16 Sep 2024 06:59:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs keeps getting corrupted
To: Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org
References: <20240916004527.0464200f@nvm>
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
In-Reply-To: <20240916004527.0464200f@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LQIGYr6lN5O7+1K7iJIvXTtFa/CAPS9sKjl1cFN+gjAxiR3CIs8
 oyfPmxCOE4q2XtvoUeC5PrbMP/PPEBbO7Ut8mhLHydL+Isa0dYdwjydH2QY94DZf/QQgXBV
 CoTbJ+x3A1njPaHI2EeLLKLsIWe7+mSBEN3kcOQtbIQxQNdH3IxQw3Nn0xYcYfiqF4XzAZX
 zq2AMzNr2olSkIzRz2jIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2KWrfBaPyig=;ffdhhedOfE79lZRi72XCM7hG/u3
 uSmb39JvN/kI01SrbhR4S7O1V32eGEy10XxMkNH0yQmDymPci+VtKwr/0tDZxxVCy51lydUT7
 C+MNj4iwryBjU0mXbT7EkQ1h6lL+IVkU0Hg/Vt1uHCFh3tbIqtLWhbf0ayTnfuaoSxkRxR0vK
 d+HZXja1T6JSC7tBkY75d0BSw2eHXwrDxseqOPsIhRsvHXLxU4q2BJN0xj7GvM5PXRMfXQBm2
 x6y38nMtyYYOznmenN6T+mgQzXi+PmVgoTfz0wTnSfny/Oo9R9eo/5KnwlT7DEjLrd4TYry8+
 QwcUw68lcU7ldle5q76QbfSKkuM+vUzlmWmTpHhvEHX4xKSVMOSzELhiuNydP9bTsuA/DISBr
 YOU5RyISZi3CbDDTtK0QFWrJXODy0pOT9hmZoJMTmDBCQaiOiPGcdQhTmIq3fsF+2D+8kaReD
 0JAfIdWgHYklZAQpI7fkbPGaavLOlZM0kejm7wMgoGilaAH8arE7QQdniEF8DqBIinJL7rM5X
 64yC9f3pOZ9i6uVI6U9xbIcbHbzrdIdGsqd0rMJaWc6dAl75kHCSrEJC8MZRpknx2e6wBP42B
 TwsiIRNARjI1/InqKtbHwLP//VJ6MNI7untAMMK0a2SQBmf/wC2WiOqf3FYY3vN+1/rCSa23b
 S1uko59OubrYzDhbN0+cK/hAAnmGW1lD/CclfpF1te76BBzFxsYVI42Aga8EszeJsl/QkUDLt
 XcaER7u2hLHh5F8SQmMUaFScNnIb5N+BTIMlPUtPAOGTFTJuVRX7MMvn95tN+ND786yywzW0J
 DHfXSlhbW0w5u9HdQmSi0RoA==



=E5=9C=A8 2024/9/16 05:15, Roman Mamedov =E5=86=99=E9=81=93:
> Hello,
>
> I have a Btrfs filesystem that keeps getting corrupted for some reason.
>
> The setup is a 4-disk external enclosure connected via USB3. It is power=
ed-on
> and off as needed.
>
> In it there's one 12TB Seagate Exos HDD, that admittedly has a low numbe=
r of
> reallocated sectors, but there are no IO errors at any time during the
> operartion (so those do not seem to be hit and there are no new ones).
>
> On the HDD there's a LUKS partition, and inside LUKS there's a Btrfs
> filesystem.
>
> The workflow is power-on, luks-open, mount, rsync, unmount, luks-close,
> power-off.
>
> On the previous attempt to use this, the FS was starting to go read-only=
 on
> accessing some recently-copied files, and there were "transid verify fai=
led"
> errors in dmesg. I wrote that off as perhaps not syncing, unmounting and
> closing everything off correctly before power-off.
>
> Modified my scripts to do a "sync" before every step in the power-off
> sequence. Reformatted from scratch, copied all data again, and turned it=
 off.
>
> Next time, a few weeks later, I try to do another rsync, and this time i=
t
> doesn't even mount:
>
> [248942.223437] BTRFS: device label sea12.k4e devid 1 transid 725 /dev/d=
m-26 scanned by (udev-worker) (5328)
> [248942.267427] BTRFS info (device dm-26): first mount of filesystem 407=
1aeab-ccab-4b36-901f-38fd38e4ef41
> [248942.267441] BTRFS info (device dm-26): using crc32c (crc32c-intel) c=
hecksum algorithm
> [248942.267446] BTRFS info (device dm-26): use zstd compression, level 3
> [248942.267448] BTRFS info (device dm-26): using free space tree
> [248942.358145] BTRFS error (device dm-26): level verify failed on logic=
al 1053650288640 mirror 1 wanted 3 found 0
> [248942.388148] BTRFS error (device dm-26): level verify failed on logic=
al 1053650288640 mirror 2 wanted 3 found 0

This is definitely something wrong with the flush behavior.

The level check happens after bytenr check, so at least it's not full
garbage.

> [248942.396897] BTRFS error (device dm-26: state C): failed to load root=
 csum
> [248942.408461] BTRFS error (device dm-26: state C): open_ctree failed
>
> btrfsck:
>
> Opening filesystem to check...
> parent transid verify failed on 1053650288640 wanted 723 found 110
> parent transid verify failed on 1053650288640 wanted 723 found 110
> parent transid verify failed on 1053650288640 wanted 723 found 110
> Ignoring transid failure
> ERROR: root [7 0] level 0 does not match 3
>
> ERROR: could not setup csum tree
> ERROR: cannot open file system
>
> =3D=3D=3D
>
> Such a high disparity in transid mismatch, flush is not working somewher=
e? But
> I specifically do "sync" even multiple times now, before unmounting and =
after.

Manually sync still relies on FLUSH, and FLUSH is not working on the
lower storage stack (from LUKS to your SSD/HDD firmware), sync won't
save you.

>
> How can I figure out what is to blame here, is it the enclosure, is it U=
SB,
> LUKS, Btrfs, or some fundamental bug involving a combination of these?

In that case, you may want to provide your kernel version first (to rule
out known bugs or too old kernels), then reduce the depth of the storage
stack, aka, running btrfs directly on that device as a test.

I do not believe it's the LUKS/device mapper layer, but just in case.

If btrfs on the raw device works fine, then you may focus on the
LUKS/device-mapper layer.

Thanks,
Qu

>
> Or maybe the drive is faulty in some mysterious way and storing/returnin=
g old
> data instead of IO errors or sector reallocation.
>

