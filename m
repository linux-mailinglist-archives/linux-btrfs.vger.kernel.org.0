Return-Path: <linux-btrfs+bounces-9014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C79A56E5
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2024 23:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7CF2827CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2024 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B46196D98;
	Sun, 20 Oct 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OubTPlI2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815E3A1CD
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729458122; cv=none; b=CIl4f5BOusHdG4nagItom5fWBkm4evu/W/fWYsEbs3KTED7QY2v1j2bO7gmCwJwzcbmmODIOPIHtZw8D5aBzOc4puqJ6TV/F1pvlzkHXCTCoG6mQ153FkuY0y0l1o72VOJIwR7bmrVl2je5WgZyKlyaoNIBFDHjW7R9HuTPIQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729458122; c=relaxed/simple;
	bh=HuMY40UgW5bOa5FZ4xd6YAxoC6R1clutlKXQY2oCfuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NO6fuWhNFYUtn3ha8maFGnv/surYWZf5TYRLA99wefeTHiYRMfKPNe/6+ipMVx/uqKSmPTGL8oeuiCtm2jbEsJ1FQnYs8t01VdwmfjWDA5kMz2sS0wB0ZycauGHZ6VLc7i8NHj/0UpIm5cXTNPhBzDf6zAXSikck/EiTe7uG704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OubTPlI2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729458116; x=1730062916; i=quwenruo.btrfs@gmx.com;
	bh=qawA844FaJgCUQ5eYAInCPNfC8oLqvwp0gdszU9sTeU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OubTPlI2+Tx8Zm6qOALUtqzd8+je7ADWmEuTpTpzEAVycyc6J9CeWu51mBW6AzEq
	 Hv92RdGCENfPkO1kUVnXvYjwnUI9KEVmAKSnB3BZwVLP1MJO3QiXts7IzkWB3MSts
	 qwCzs+9ywmsJvSvw6OSdiUoDj38UDUL1ShdWGI9baTpVQvQjjtgTOATXONsPD7tV+
	 VQsKW/ZI9g6ueRdnXyL9VFsrNBqCDmqRwFEDjr6D1DU1QI3YUdZtEw3eTO8E64Mtn
	 j1OyDaqA0qCvqLMuB9AFcxyC1Sjiok+VSNh85UN/goQpCvqiXT7ZMbexyVWYtm/ei
	 /bN5MZ+zUScGzts2QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1u3LVH2ybM-0137GC; Sun, 20
 Oct 2024 23:01:56 +0200
Message-ID: <67b3649b-2372-4846-bb86-79fafec1bab0@gmx.com>
Date: Mon, 21 Oct 2024 07:31:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: strangely uncorrectable errors with RAID-5
To: russell@coker.com.au, linux-btrfs@vger.kernel.org
References: <23840777.EfDdHjke4D@xev>
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
In-Reply-To: <23840777.EfDdHjke4D@xev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34VLgavvXDD9URZ1Uef3EU6u3I5xQ7ek9opZNdQvjDXRz3dR676
 0o1X/JW1gOuxjjUFi8gspnXss4WgNc/7GN4R9xnSBTaU7SdewbvR/DSvorfPQnZKsfVYQCt
 Fl1wLPLNzqLdnyGz3ntwQ6JQZi5Xohhl0LU2k/MDsJVTbphwPvPPvlAckN/jk38LgRv+wLl
 gtcJzBHFUz/mY7AW8O0qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:98OuKzEcvFc=;Fd+832FoXBNbHrT0xwzeh+RZ7Zn
 b/rOXMTNeRSb/eCdMcwA93tJxDdVbASBqNRwU0TSQavlKi5v8YopI/q1yb8ufSf8nnCE4YPHT
 5ULXpsf9YIEzkBS0We+O0hrmwyWYCCsRu4demb7zyQI6v/v7IWxkQyCkinjpL9bO3F5wxHtOf
 WKzSrvcZjqYeqtM3S6QAPntpHR80YdCB+4QsdO8RuRX93F+DFOhH6PEMwk9wfLdzFtTGPFH1q
 VYDc42jgMtVHjUBs5qPfvBCINOUIvOC5iWnginrEOln5eUkpL++Dekm0uiQvF2f4iTQRxP5Xs
 gqd5IdC3wKqrIPgYkkzFBpOdUj+6qfUmVAFyrLN8pFnMMAVpimPSgwfkfXaVsqq3PsumcQpR7
 cv1hw187pi7ZjhyGU5AMjJ2ImqsJJ5c1jwTEAgf0ENXCq+nUvdG69JtQGbFI49QtctR8cbUBZ
 +qTZvuYNluGK0+Q5SiR6ooRuWmcdjoJpbtQWQdmYiy7j0h4CKG79EpedWdhbix8VME8rbjAa0
 5OX0FhkuQY7LfbGcebadbKd93RRIxwHHwftdYN6XRN8lozl1266JyMq0jPEu1FbMKeBvce+QI
 4PS++vAGRGY/8oJJzTU4b+GDFiijTBQ0ReDT3alamrlLHZO9C0xr1qtvQQ7ucKJh2v0doTRoD
 rh+0Hn7/raw269gCJewu49clvRSYR1Een9BNYfFtHvvuKfdYgacrF97ZoKc1fA4L9zYaEUIl4
 tVNIDm8qtX/aaWVG7JkzB9/VvQHHZDEWdODwQBz/KVD2ngWE228pCZtoFgB0gGDVJU9VhMFji
 e2l6A0YTGb/a4/7686GHhFkQ==



=E5=9C=A8 2024/10/20 20:39, Russell Coker =E5=86=99=E9=81=93:
> I've been testing out BTRFS RAID-5 with Debian kernels 6.10.9 and 6.11.2=
 from
> Unstable.
>
> I know that RAID-5 is not expected to be good enough for real data but i=
t
> still seemed interesting to test it as apparently there have been improv=
emnts
> recently.  I created some errors that SHOULD be recoverable (and are
> recoverable with RAID-1) which turned out to not be recoverable (accordi=
ng to
> BTRFS) even though the diff command reported that the data was intact.  =
Now I
> can't get the filesystem to an error-free status.
>
> To test it I created a 4 device RAID-5 filesystem and ran the following =
script
> to stress it a bit:
>
> #!/bin/bash
> set -e
> cd /mnt
> while true ; do
>    cp -r usr usr2
>    cp -r usr usr3
>    cp -r usr usr4
>    cp -r usr usr5
>    sync
>    diff -ru usr usr2
>    diff -ru usr usr3
>    diff -ru usr usr4
>    diff -ru usr usr5
>    rm -rf usr?
> done
>
> Then I ran the following script to cause corruption and scrub it to see =
what
> happens:
>
> #!/bin/bash
> set -e
> while true ; do
>    for DEV in c d e f ; do
>      dd if=3D/dev/zero of=3D/dev/vd$DEV oseek=3D$((20+$RANDOM%3*1000)) b=
s=3D1024k \
> count=3D1000
>      sync
>      btrfs scrub start -B /mnt
>      sync
>    done
> done
>
> It didn't take very long before it reported problems scrubbing the files=
ystem
> even though the diff commands didn't report any errors.  According to di=
ff
> that filesystem has not lost any data, but now even after rebooting I ge=
t the
> following when I run a scrub:
>
> root@testing1:~# btrfs scrub start -B /mnt
> Starting scrub on devid 1
> Starting scrub on devid 2
> Starting scrub on devid 3
> Starting scrub on devid 4
> ERROR: scrubbing /mnt failed for device id 1: ret=3D-1, errno=3D5 (Input=
/output
> error)
> ERROR: scrubbing /mnt failed for device id 2: ret=3D-1, errno=3D5 (Input=
/output
> error)
> ERROR: scrubbing /mnt failed for device id 3: ret=3D-1, errno=3D5 (Input=
/output
> error)
> ERROR: scrubbing /mnt failed for device id 4: ret=3D-1, errno=3D5 (Input=
/output
> error)
> scrub canceled for f8a30d07-f92e-4dfc-a62f-f49d35b70467
> Scrub started:    Sun Oct 20 10:01:21 2024
> Status:           aborted
> Duration:         0:00:03
> Total to scrub:   332.22MiB
> Rate:             110.74MiB/s (some device limits set)
> Error summary:    csum=3D4
>    Corrected:      0
>    Uncorrectable:  4
>    Unverified:     0
> root@testing1:~# btrfs scrub start -B /mnt
> Starting scrub on devid 1
> Starting scrub on devid 2
> Starting scrub on devid 3
> Starting scrub on devid 4
> ERROR: scrubbing /mnt failed for device id 1: ret=3D-1, errno=3D5 (Input=
/output
> error)
> ERROR: scrubbing /mnt failed for device id 2: ret=3D-1, errno=3D5 (Input=
/output
> error)
> ERROR: scrubbing /mnt failed for device id 3: ret=3D-1, errno=3D5 (Input=
/output
> error)
> ERROR: scrubbing /mnt failed for device id 4: ret=3D-1, errno=3D5 (Input=
/output
> error)
> scrub canceled for f8a30d07-f92e-4dfc-a62f-f49d35b70467
> Scrub started:    Sun Oct 20 10:01:27 2024
> Status:           aborted
> Duration:         0:00:03
> Total to scrub:   332.22MiB
> Rate:             110.74MiB/s (some device limits set)
> Error summary:    csum=3D4
>    Corrected:      0
>    Uncorrectable:  4
>    Unverified:     0
>
> Below is some output from dmesg:
>
> [   36.975742] BTRFS info (device vdc): bdev /dev/vdc errs: wr 0, rd 0, =
flush
> 0, corrupt 5443, gen 0
> [   36.976083] BTRFS info (device vdc): bdev /dev/vde errs: wr 0, rd 0, =
flush
> 0, corrupt 13127, gen 0
> [   36.976397] BTRFS info (device vdc): bdev /dev/vdf errs: wr 0, rd 0, =
flush
> 0, corrupt 1412, gen 0
> [   38.877364] BTRFS info (device vdc): scrub: started on devid 3
> [   38.878607] BTRFS info (device vdc): scrub: started on devid 4
> [   38.880468] BTRFS info (device vdc): scrub: started on devid 1
> [   38.885000] BTRFS info (device vdc): scrub: started on devid 2
> [   39.347569] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   39.350325] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   39.353158] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   39.355091] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832

The metadata is gone, and there is only one mirror for it.

What profile are you using for metadata?

Just in case, RAID5 is not recommended for metadata due to the complex
recovery combinations:

 >> The power failure safety for metadata with RAID56 is not 100%.

I'm pretty sure if you're using RAID5 for metadata, that's exactly the
case where corrupted metadata can not be properly fixed at a per-sector
basis.

Thus it's recommended to go RAID1* for metadata if you want to use RAID5
for data.

Thanks,
Qu


> [   39.355786] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   39.356293] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   39.357059] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   39.357198] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   39.357602] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   39.359539] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   39.363175] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   39.364156] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   39.364813] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   39.365519] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   39.365838] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   39.368456] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   39.369461] BTRFS error (device vdc): unrepaired sectors detected, fu=
ll
> stripe 411893760 data stripe 2 errors 0-3
> [   39.370175] BTRFS info (device vdc): scrub: not finished on devid 4 w=
ith
> status: -5
> [   41.231719] BTRFS error (device vdc): bad tree block start, mirror 1 =
want
> 412024832 have 0
> [   41.232326] BTRFS error (device vdc): bad tree block start, mirror 2 =
want
> 412024832 have 0
> [   41.232832] BTRFS error (device vdc): bad tree block start, mirror 1 =
want
> 412024832 have 0
> [   41.233470] BTRFS error (device vdc): bad tree block start, mirror 2 =
want
> 412024832 have 0
> [   41.234085] BTRFS info (device vdc): scrub: not finished on devid 1 w=
ith
> status: -5
> [   41.234170] BTRFS info (device vdc): scrub: not finished on devid 2 w=
ith
> status: -5
> [   41.234231] BTRFS info (device vdc): scrub: not finished on devid 3 w=
ith
> status: -5
> [   44.243128] BTRFS info (device vdc): scrub: started on devid 1
> [   44.243901] BTRFS info (device vdc): scrub: started on devid 2
> [   44.243928] BTRFS info (device vdc): scrub: started on devid 4
> [   44.244796] BTRFS info (device vdc): scrub: started on devid 3
> [   44.774710] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.793802] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.797168] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.803175] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.807162] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   44.810892] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   44.811443] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   44.823205] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.823540] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   44.823544] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   44.823546] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   44.823547] BTRFS error (device vdc): unable to fixup (regular) error=
 at
> logical 412024832 on dev /dev/vde physical 315555840
> [   44.823549] BTRFS warning (device vdc): checksum error at logical 412=
024832
> on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
> [   44.832155] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.838895] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.844663] BTRFS warning (device vdc): tree block 412024832 mirror 1=
 has
> bad bytenr, has 0 want 412024832
> [   44.845561] BTRFS error (device vdc): unrepaired sectors detected, fu=
ll
> stripe 411893760 data stripe 2 errors 0-3
> [   44.846842] BTRFS info (device vdc): scrub: not finished on devid 4 w=
ith
> status: -5
> [   47.746767] BTRFS error (device vdc): bad tree block start, mirror 1 =
want
> 412024832 have 0
> [   47.748256] BTRFS error (device vdc): bad tree block start, mirror 2 =
want
> 412024832 have 0
> [   47.749069] BTRFS info (device vdc): scrub: not finished on devid 3 w=
ith
> status: -5
> [   47.754752] BTRFS error (device vdc): bad tree block start, mirror 1 =
want
> 412024832 have 0
> [   47.755952] BTRFS error (device vdc): bad tree block start, mirror 2 =
want
> 412024832 have 0
> [   47.758766] BTRFS info (device vdc): scrub: not finished on devid 2 w=
ith
> status: -5
> [   47.822683] BTRFS error (device vdc): bad tree block start, mirror 1 =
want
> 412024832 have 0
> [   47.826760] BTRFS error (device vdc): bad tree block start, mirror 2 =
want
> 412024832 have 0
> [   47.834688] BTRFS info (device vdc): scrub: not finished on devid 1 w=
ith
> status: -5
>


