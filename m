Return-Path: <linux-btrfs+bounces-13640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF958AA7F77
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 May 2025 10:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535989A5703
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 May 2025 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9251BEF8C;
	Sat,  3 May 2025 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="H3O6BPZk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113591A5B89
	for <linux-btrfs@vger.kernel.org>; Sat,  3 May 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746261627; cv=none; b=PSQfuVrhtn/eRXUX0cc1l8ykF1wEUn8pyP5+hsq0dnTfsAb5hN1NHu5fcq4X85gsmNLPvTfqtbGHZacGSJFJS3JAhkj38T/ZPugv+4bjm/Tt5Uk5i8b3FISAjO/zbKBp2ZDSAyAzgEBD5DcHs9sN4sTCxSYkzAPxG/bzhNV92mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746261627; c=relaxed/simple;
	bh=1oW5x8ZKLfRk9OiBRwe9f0FHIF+EoxmerFPcGnKe2cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ozttTE4Hmk6bR1m3q1CeS+A5PSfOCuecnKusYUpo5/poZGqg5wW8/ryVv5QdINIpZjfOL7zUvdfBpBkqFGAV4qp+djP6XA/sBSFxb5y/0aSLETDwZfMAsfaejvHmv/LWmAcSRBmalu2ao8Dv+zqTjGtgQU0lKDVXhQ/tnAnrnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=H3O6BPZk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1746261621; x=1746866421; i=quwenruo.btrfs@gmx.com;
	bh=wHnN321kXzL85YGpDzvOVLQcUtknBHe+RwhEP+50hMg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=H3O6BPZkKgxzGKhxr1kUxxIzaoiHWkP0apSsTMcfU+VghSG/Qfg9IkI3AkXiDgby
	 HqsY6nM1Fj6EJizq3nujHe2VdijbdB/d2945StrcGJe7hlIzzZFjctO74uCfM6uWB
	 Vjzfv9WAbH4J8pSCEOngPHcMl1UEkJc+npi2lQRBJ8IwrZgWKUk3Ef+WHVMGiKhsy
	 92YsJnRbeBnDZKb5Pqg1igbtcQTRgA8hDqNs1ECvxCa4W5cNqkXgdZq9xrrhaf6ue
	 r5oxfn4Y3ro4P8kDacv/MS1Npll19okOioAv1TDu1k9gdA27NPEKzYQHYhG9tvxj1
	 TdVy3VRFmR0NnphI+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1udyrn1bWV-00KCrQ; Sat, 03
 May 2025 10:40:21 +0200
Message-ID: <e822ec87-6603-4549-aef4-0e057be60a0d@gmx.com>
Date: Sat, 3 May 2025 18:10:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Fwd: HTML message rejected: btrfs checksum error
To: Przemek Klosowski <przemek.klosowski@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <1745893230-14268-mlmmj-729fb3af@vger.kernel.org>
 <CAC=1GgGRobZ7sMN6iBExMuYCRzNyei_mngkyRd=kvOX9rj90Lg@mail.gmail.com>
 <1be5f421-a36e-4a27-8c4b-73140f94a217@suse.com>
 <43dc4c77-cc8c-4c16-9fab-76833e2fc4dd@suse.com>
 <CAC=1GgEaY80tHuA1av-u8y43o_U-yF6-7b8kaDNLi=i5X-fGqw@mail.gmail.com>
 <CAC=1GgFJ8oDYgpX3T5FFv3bvVyDwkA-ce9c1TEugE=j9NTmHvg@mail.gmail.com>
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
In-Reply-To: <CAC=1GgFJ8oDYgpX3T5FFv3bvVyDwkA-ce9c1TEugE=j9NTmHvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wSiM6zkP0MbCuDe39HxqtQRvvLKHp0BcYrghuOY1OwGM+O/XnT8
 k0KtE6Hk2ZeSTTlLIytLmVYA8JRLd6h/Z+GCJzQgyWvstkHE2YTK9iftQoY4VYcR3TQBS1U
 rts4WbYpCPPQI+7Y+vnqHjeDCDMfUTsc5xoOnFcqYLy/e4/CyaxLy4GhC2d3fzf0jbsOqpu
 AMVXbvrwjA0WnvENLWbGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9aI4L668W58=;TIYqswm7a3RrexB7rLQQxARcBbs
 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



=E5=9C=A8 2025/5/3 14:04, Przemek Klosowski =E5=86=99=E9=81=93:
>     I guess the problem is you're still trying to scrub with that
> rescue=3Didatacsums mount option?
>=20
> No--it's my root fs so I mounted the individual device as
> readonly/degraded, kind-of recursively in the same live fs. I just
> wanted to see if I can recover more data, and thought it'd be safe
> because of its readonly status.

In that case, unless fully RO mounted with "rescue=3Didatacsums" mount=20
option, btrfs will still do the data checksum verification thus leading=20
to the error messages, and reject reads of involved blocks.

>=20
> Thank you for the suggestions---after deleting the problem file, all
> is well (btrfs scrub shows no errors)
>=20
> By the way, I was perplexed by the tooling, because it seems that I need=
 to run
>   btrfs check --readonly --force --check-data-csum -p /dev/nvme0n1p2
> on a live filesystem (it's my root fs) to get the error locations, and
> it reports additional checksum errors due to the activity on the fs
> (mozilla cache files, etc).
>=20
> As you suggested, I extracted the offsets and piped to btrfs ins
> logical, which gave multiple filenames. I knew which one was the real
> one. I wonder if there's a way to avoid the fake ones?

Mind to give some examples?

It can be a bug in the logical resolve implementation, which is part of=20
the kernel code.

> Of course I
> could have booted from flash and mounted my real fs readonly under it,
> got the filename, remounted rw and deleted the file.
> Is there a simpler, recommended workflow for this case? Maybe making a s=
napshot?

Making snapshots will make it worse, as now you have to delete both the=20
original file and the file in the snapshots.

Unfortunately we do not have a good workflow for that, and maybe we can=20
add something like "btrfs rescue delete-bad-files" to do that automaticall=
y.

So far our priority is still detecting the problem, the repair is always=
=20
done by the extra copies, thus no manual data corruption fix.

But there is a recent kernel fix that will force direct-IO to be=20
buffered IO if the file has data checksum, to avoid any badly programmed=
=20
direct IO users to cause false data checksum mismatch.


If you're sure the corruption is not caused by hardware, then upgrading=20
the kernel may prevent such false alerts from happening in the future.

>=20
> BTW, btrfs dev stat keeps showing corruption_errs on both raid1
> devices. Do you recommend 'btrfs dev stats -z' to zero them out?

Since scrub and btrfs check reports no more error, it's completely fine=20
to zero them out.

Thanks,
Qu

>=20
>=20
>=20
> On Tue, Apr 29, 2025 at 1:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/4/29 15:02, Qu Wenruo =E5=86=99=E9=81=93:
>>>
>>>
>>> =E5=9C=A8 2025/4/29 11:55, Przemek Klosowski =E5=86=99=E9=81=93:
>>>> I have a RAID1 btrfs root/home on Fedora 42 that developed what
>>>> appears to be a single data checksum error. RAM tests fine, but it's =
a
>>>> DELL system that had memory problems early on (years ago), that were
>>>> fixed by Dell BIOS memory tests  (which changed the mem controller
>>>> settings).
>>>>
>>>> The errors seem to have started right after a scrub (see btrfs
>>>> messages from journal below)
>>>>
>>>> btrfs check --readonly --force --check-data-csum -p /dev/nvme0n1p2
>>>>
>>>> shows a cascade of errors (which seem to be increasing in number)
>>>> ..
>>>> [4/7] checking fs roots                        (0:00:04 elapsed, 6092=
3
>>>> items checked)
>>>> mirror 1 bytenr 299511672832 csum 0x125beb3c expected csum
>>>> 0xc8374bb569 items checked)
>>>> mirror 1 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
>>>> mirror 2 bytenr 299511672832 csum 0x125beb3c expected csum 0xc8374bb5
>>>> mirror 2 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
>>>> mirror 1 bytenr 306513821696 csum 0x8941f998 expected csum
>>>> 0xa5fe1bfd94 items checked)
>>>> mirror 1 bytenr 306513825792 csum 0x8941f998 expected csum 0x77c755d4
>>>> .. and many more
>>>>
>>>> I can recover the file with only 1 4kB block zeroed out.
>>>>
>>>> Is there a way to read the bad sector? I thought that
>>>> mount -o ro,degraded,rescue=3Dignoredatacsums/dev/sda5 /mnt
>>>> would read data ignoring the bad checksum? as it is, it replicates th=
e
>>>> I/O error that is raised when reading the original file.
>>>
>>> It turns out to be a bug in the implementation, we expect to ignore ba=
d
>>> data csum error and return the data directly, but it's not implemented
>>> if the csum tree is still valid...
>>>
>>> I'll send out a patch for that, but that will also mean with
>>> rescue=3Didatacsums mount option, the data will only be the first one
>>> btrfs read out.
>>
>> It is not a bug, it is already handled properly by completely ignoring
>> the data csum tree.
>>
>> I guess the problem is you're still trying to scrub with that
>> rescue=3Didatacsums mount option?
>>
>> That mount option is to be used with regular read, which will not do an=
y
>> verification now.
>>
>> Please verify if regular read on those files work.
>>
>> Thanks,
>> Qu
>>
>>>
>>> It'll be fine for your case, as both mirrors have the same csum.
>>>
>>>>
>>>> Do you think that deleting the file with the bad checksum will solve
>>>> this?
>>>
>>> Yes.
>>>
>>>> or should I move to rebuilding and restoring from backups?
>>>
>>> No need, "btrfs check --check-data-csum" is the most comprehensive che=
ck
>>> we have and it only reports error of data checksum so far (better than
>>> scrub because of the comprehensive metadata checks).
>>>
>>> Although you will need to find out all involved files, scrub is doing =
a
>>> good job resolving the path, but the output may be ratelimited.
>>>
>>> I'd recommend to craft a small script, parsing all involved unique
>>> bytenr into `btrfs ins logical` to get a full path to the affected fil=
es.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>
>>>> Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> started on devid 1
>>>> Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> started on devid 2
>>>> Apr 26 22:41:36 fedora kernel: BTRFS error (device nvme0n1p2): unable
>>>> to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p=
2
>>>> physical 74303995904
>>>> Apr 26 22:41:36 fedora kernel: BTRFS warning (device nvme0n1p2):
>>>> checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physica=
l
>>>> 74303995904, root 257, inode 35328, offset 26034176, length 4096,
>>>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>>>> Apr 26 22:42:52 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> finished on devid 1 with status: 0
>>>> Apr 26 22:45:46 fedora kernel: BTRFS error (device nvme0n1p2): unable
>>>> to fixup (regular) error at logical 452965761024 on dev /dev/sda5
>>>> physical 147297468416
>>>> Apr 26 22:45:46 fedora kernel: BTRFS warning (device nvme0n1p2):
>>>> checksum error at logical 452965761024 on dev /dev/sda5, physical
>>>> 147297468416, root 257, inode 35328, offset 26034176, length 4096,
>>>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>>>> Apr 26 22:48:45 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> finished on devid 2 with status: 0
>>>> Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> started on devid 2
>>>> Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> started on devid 1
>>>> Apr 26 22:53:52 fedora kernel: BTRFS error (device nvme0n1p2): unable
>>>> to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p=
2
>>>> physical 74303995904
>>>> Apr 26 22:53:52 fedora kernel: BTRFS warning (device nvme0n1p2):
>>>> checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physica=
l
>>>> 74303995904, root 257, inode 35328, offset 26034176, length 4096,
>>>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>>>> Apr 26 22:55:07 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> finished on devid 1 with status: 0
>>>> Apr 26 22:58:04 fedora kernel: BTRFS error (device nvme0n1p2): unable
>>>> to fixup (regular) error at logical 452965761024 on dev /dev/sda5
>>>> physical 147297468416
>>>> Apr 26 22:58:04 fedora kernel: BTRFS warning (device nvme0n1p2):
>>>> checksum error at logical 452965761024 on dev /dev/sda5, physical
>>>> 147297468416, root 257, inode 35328, offset 26034176, length 4096,
>>>> links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
>>>> Apr 26 23:01:01 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
>>>> finished on devid 2 with status: 0
>>>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>>> Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>>>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>>>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
>>>> Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
>>>> Apr 27 07:35:55 fedora kernel: btrfs_print_data_csum_error: 2
>>>> callbacks suppressed
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:55 fedora kernel: btrfs_dev_stat_inc_and_print: 2
>>>> callbacks suppressed
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
>>>> 0xcf4a5572 mirror 2
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
>>>> Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
>>>> failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
>>>> 0xcf4a5572 mirror 1
>>>> Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
>>>> /dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
>>>>
>>>
>>>
>>
>=20


