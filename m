Return-Path: <linux-btrfs+bounces-16616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE17B42ED9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 03:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BB71C23F65
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 01:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C31E0083;
	Thu,  4 Sep 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YMJixZSZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA871C831A;
	Thu,  4 Sep 2025 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949380; cv=none; b=q75cFE2zhvIXoFJCXJdZJR7iezb1W4iM7u0rVepnHuUQ3EUmGAWsdLBc7S8oLSnxIAfrltveFmK/2q93L/sOn2HdOiCNftHSCDD6/j8/l9qVW5rv3vTWps60VIvn6hR/fZEHWWWV8ftkI9m2XNRUF4aL6u1Kvh8n8HQ8vwdXJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949380; c=relaxed/simple;
	bh=dHTjyGPiyCByIC5r5/K5Y3GG6/PRhtx9fTsizj0rs/Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kydBDxcL0KqQxl3UJj0lEhxOqXrgHY1MmMtOZKpI5VJS5ttl3uTOglf/dcUbvEZNduvH6Z12kNn0lze3/7BDyzGzrifXbHYjWn52dhROE1uAzh7y5ehcro2AAz5iSMLzlA6of9+C8pp0TYOJOfcklbq1+Mj/6xzvPL6Wo4clyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YMJixZSZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756949376; x=1757554176; i=quwenruo.btrfs@gmx.com;
	bh=dHTjyGPiyCByIC5r5/K5Y3GG6/PRhtx9fTsizj0rs/Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YMJixZSZkUfvDdOvOCLuTXktWS+KULt2Dwqt76skLtpUdBpUaV569N+uwdGqinx0
	 n0ZlUUMvEfADy1I45eePuTVxczmFXtWN7VG0FqrJy1NXNPPvF65Mr8fo2grK6LmWk
	 DL1uoPRQ1gTf9QIOz0WjsX46GsQ+u3VWeLh+nG8Eo5J4SPPBTiBLyjcw4PFw9RIW8
	 1hW5njEJhxNZriRSLbqSZ9UyG+rnoNu2Rqsk8+oGaKmqubu8YD/1YbIwcddqzGmnk
	 NdiyR0NgMdRaqQorCsY+jbn1lyli9FJPFU60l6nllRJLtdcxFW1O+4muDfYzDcq5H
	 7m4yoeVaa1TbRR3BwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1uyqBJ2q70-00WK47; Thu, 04
 Sep 2025 03:29:36 +0200
Message-ID: <11b031c2-b4e6-44df-96ab-54e75e51eebe@gmx.com>
Date: Thu, 4 Sep 2025 10:59:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Golden output mismatch from generic/228, fs independent
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, linux-xfs@vger.kernel.org
References: <60b73970-9cb6-49b1-ad5f-51ab02ef2c98@gmx.com>
 <20250902120932.GA2564374@mit.edu>
 <f036067d-1901-4f53-b228-52245d7c2109@gmx.com>
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
In-Reply-To: <f036067d-1901-4f53-b228-52245d7c2109@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cDk7H1cRhDRFUVJ9PpPYLpXgVtYScQ45tZMjYTumvJzp+GwjJaT
 6iNIJPN2iOCGjBGIDb7e9efDrDCE2yi55CLdXpLlVq8bc+4YqXrCqFZUjyaqdu1rMG54QjL
 +IeQ0zzMxDRLWO1gPprxC/YU4+0V2LrtwpN+8rK+9bwi6TAsof0BLkq62pESUj5QsakEe/r
 fYUdu06i+qa8vBmOTGIqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MlwcHHiJLTc=;0a4VnJL5epkh1L+W+swXxCQ35bs
 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



=E5=9C=A8 2025/9/3 07:10, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/9/2 21:39, Theodore Ts'o =E5=86=99=E9=81=93:
>> On Tue, Sep 02, 2025 at 08:00:32PM +0930, Qu Wenruo wrote:
>>> Hi,
>>>
>>> Recently I updated my arm64 VM, and now several test cases are=20
>>> failing due
>>> to golden output mismatch.
>>>
>>> This time it's fs independent, and I haven't yet updated fstests=20
>>> itself, so
>>> it looks like some updates in my environment is breaking the test.
>>>
>>> E.g, generic/228 on ext4 (the same on btrfs)
>>>
>>> I checked my log, bash/xfsprogs and a lot of other packages are all=20
>>> updated,
>>> and unfortunately my distro doesn't provide older packages for me to
>>> bisect...
>>
>> I don't know if this helps, but here's a kvm-xfstests using Debian
>> Trixie and certain updated critical packages (fio, quota, xfsprogs,
>> util-linux, etc.) overriden.=C2=A0 How does that differ from your distr=
o
>> package versions?
>>
>> I haven't updated my arm64 image in a bit (this was from dated July=20
>> 20th).
>> I can try doing an arm64 rebuild and see if a newer version still
>> works on arm64, but here's a data point....
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TE=
d
>>
>>
>> KERNEL:=C2=A0=C2=A0=C2=A0 kernel=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.=
17.0-rc3-xfstests #1 SMP Tue Sep=C2=A0 2 07:57:28=20
>> EDT 2025 aarch64
>> CMDLINE:=C2=A0=C2=A0 --arm64 -c ext4/4k generic/228
>> CPUS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> MEM:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1977.09
>>
>> ext4/4k: 1 tests, 5 seconds
>> =C2=A0=C2=A0 generic/228=C2=A0 Pass=C2=A0=C2=A0=C2=A0=C2=A0 2s
>> Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 2s
>>
>> FSTESTVER: blktests=C2=A0=C2=A0=C2=A0=C2=A0 401420a (Fri, 6 Jun 2025 22=
:12:43 +0900)
>> FSTESTVER: fio=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi=
o-3.40 (Tue, 20 May 2025 12:23:01 -0600)
>=20
> Fio is in fact newer than mine. Mine is 3.39.
>=20
>> FSTESTVER: fsverity=C2=A0=C2=A0=C2=A0=C2=A0 v1.6-2-gee7d74d (Mon, 17 Fe=
b 2025 11:41:58 -0800)
>> FSTESTVER: ima-evm-utils=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v1.5=
 (Mon, 6 Mar 2023 07:40:07 -0500)
>> FSTESTVER: libaio=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libaio-0.3.108-82=
-gb8eadc9 (Thu, 2 Jun 2022=20
>> 13:33:11 +0200)
>=20
> Mine is a little newer, 0.3.113.
>=20
>> FSTESTVER: ltp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=
250130-280-g60656cbbb (Wed, 28 May 2025=20
>> 15:04:44 +0200)
>> FSTESTVER: quota=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4.05-71-g4cd93fc (Sun, 27 Apr 2025=
=20
>> 08:24:24 -0400)
>> FSTESTVER: util-linux=C2=A0=C2=A0 v2.41-40-g22b91501d (Mon, 26 May 2025=
 11:27:31=20
>> +0200)
>> FSTESTVER: xfsprogs=C2=A0=C2=A0=C2=A0=C2=A0 v6.15.0 (Mon, 23 Jun 2025 1=
3:56:41 +0200)
>> FSTESTVER: xfstests=C2=A0=C2=A0=C2=A0=C2=A0 v2025.07.13-12-gef63d1368 (=
Sat, 19 Jul 2025=20
>> 18:14:29 -0400)
>> FSTESTVER: xfstests-bld gce-xfstests-202504292206-20-g905451c1 (Sun,=20
>> 20 Jul 2025 03:04:27 +0000)
>> FSTESTVER: zz_build-distro=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trixie
>=20
> Others are mostly the same version.
>=20
>=20
> And indeed it's bash, after rolling back to v5.2.037 bash, everything is=
=20
> fine.
>=20
> It looks like it's bash 5.3.x starting to fail (5.3.0 tested and failed)=
.
>=20
> I'll try dig a little deeper, and this is why I'm always running=20
> Archlinux (ArchlinuxARM in this case), to give some early warnings of=20
> some unexpected updates breaking the test cases.

It turns out to be the core dump behavior, the following script can=20
easily reproduce it:

```
#!/bin/bash

dev=3D"/dev/test/scratch1"
mnt=3D"/mnt/btrfs"

mkfs.btrfs -f $dev > /dev/null
mount $dev $mnt
sysctl -w kernel.core_pattern=3Dcore &>/dev/null
ulimit -c 0
ulimit -f 102400
xfs_io -f -c "falloc 0 101m" /mnt/btrfs/foobar
umount $mnt
```

Xfs_io will trigger coredump, and the full cmdline dump belongs to the=20
core dump handling of bash.

Thanks,
Qu


>=20
> Thanks,
> Qu
>=20
>> FSTESTCFG: ext4/4k
>> FSTESTSET: generic/228
>> FSTESTOPT: aex
>> Truncating test artifacts in /results to 31k
>>
>=20


