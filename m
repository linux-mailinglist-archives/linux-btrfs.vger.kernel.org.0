Return-Path: <linux-btrfs+bounces-16765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9697B50C4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD84162D5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 03:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8B25A631;
	Wed, 10 Sep 2025 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nvJJsqrM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB635961
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474576; cv=none; b=K9PdvSRrm2NqJN8wrz5ARVLMz8rUtFG+m5dx/9/Kr5e7nSp44r7H0AYtchcILnAvYTdgm/Gwu+amCs/JPNomo1rFPF1DPV9qkgPzEFqb5yuVx5eU+yR6IUvjQU84cKsa0ivS31lxHKTwOyd7XDtGtAGO8u3uK3KU/vVw+RjUFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474576; c=relaxed/simple;
	bh=AjQyCznBgOHF+92WC65urzKaeQqKYmdrs1z8Ym+N52c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN/UGi7bPqglatQWKFTY7+WuwNxLH5tS+Jch+flZOY2RMuJKmyNScy1Ay9qQfbgH7kwp6rU8r3IVHZqTMVWTFGV4kjg5HSgzdty+ifGF7Nr4BYInFcRG0dcl6FJkQsFOxwP96YY4DXriQMeRwtOeY3C3Lo6rHuFq1rV7nzo9/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nvJJsqrM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757474570; x=1758079370; i=quwenruo.btrfs@gmx.com;
	bh=m/bmAC525xOSsFH15CsdH9YkPqfU3X2R041r4DsyY1k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nvJJsqrMtiWaHp0CYGsGk7NuvUhEf7OEXH7n6XrJABrO6jDugydBzuL1diqSGoA5
	 q9cn89a0J12oXrl8h9W3FbtG9QDv5v3O+JhDABMckIduunKUVGcqCgHUZlAXCRPnz
	 NICQl43f7GDAJGIHPk6tnlAu/r5Z6LpOJ5uA0iDf1r2IqYjVFGiCVulIkM1cQZx9f
	 eaLG66zcwGVCyT9fbzQ/NtshAW4CSMSqLE4IPKCdzraB+ubRF7WL3lBRnjkN70foq
	 pT/Sga5waJ3u5v4e+KC/CaWpcAljvhG2pKzkSQGKA3JYIsFlNAMFCGGZRuSbwqKOq
	 K84lYC6HpptekQ6yEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1upkK82YOX-00Y2Ed; Wed, 10
 Sep 2025 05:22:50 +0200
Message-ID: <001d3b77-44a7-4720-936a-40d1868ba1f7@gmx.com>
Date: Wed, 10 Sep 2025 12:52:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs RAID 1 mounting as R/O
To: jonas.timothy@proton.me, Qu Wenruo <wqu@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
 <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com>
 <h5sKXFIVsnBPX0i1K8jnrgzAQu2oE-NMORKYVaNPyp-FnKaQN032HGmejwSQl8KIbtpMj-37pFT3KDrbn_xmrdzqNVzjzIw-9YU6s8DW0mA=@proton.me>
 <595fb33e-a3e8-46cc-80ff-e50c2a70bffd@gmx.com>
 <xrsGddBl1hq0FSjKaqFM8275iii6WNju5hyl2wU8I9J7f2q3C11Dhsqgn-ANIXJRP-NMf4jioFdthalcpZn7YjKb0KAE7YBYxiGSA6g41Z4=@proton.me>
 <198b7846-539c-44cf-b746-c70fe2befa69@suse.com>
 <OVaP9JLctKwGQE9-ko-DgNoKsm2gRoh8WP5W0HHyYnv0vXeLV2yqfI34NfT2W3z6peteBNk-D6wkZbPiZepfT83Xb7kHn6LfQsb3cDY0npU=@proton.me>
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
In-Reply-To: <OVaP9JLctKwGQE9-ko-DgNoKsm2gRoh8WP5W0HHyYnv0vXeLV2yqfI34NfT2W3z6peteBNk-D6wkZbPiZepfT83Xb7kHn6LfQsb3cDY0npU=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iiO/rN9JxgOgUEd3gMEiPKM6Qgj/T2dERSR8Kcw6CW3qvgNI8mw
 aROx8PrsY84ft060bHJ01PyujrHxjmEk0MWsxTXKpnYUgd+PTmjKRVkSdgsl3+ZQiyuAkdd
 +t2lkWpFYqSySowojSKDh6y1r7BDIpQdJGbx9WM4gh3oHOzA//WIryFRnFrTCL/AvUFxEQG
 gAW7I9lPqDrR79lIogn0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tvZ+zaANcwU=;JWMkrLJzfH4D4T4a/3fdYXqrpS9
 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
 mJVQJAsrhBRN5+1k=



=E5=9C=A8 2025/9/10 12:13, jonas.timothy@proton.me =E5=86=99=E9=81=93:
> Good news!
>=20
> * I swapped my RAM
> * Ran `btrfs check --repair`
>=20
> And that made my 12TB RAID bootable
>=20
> Now, I'm trying to get my 20TB working cuz it won't finish balancing
>=20
> Sep 08 03:12:13 skarletsky sudo[284148]: yamiyuki : TTY=3Dpts/0 ; PWD=3D=
/mnt/jellycloud ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs balance status /m=
nt/disks/disk-20TB/
> Sep 08 03:26:55 skarletsky kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 7302091505664 on dev /dev/sdc1 physical 7=
166808424448
> Sep 08 03:26:55 skarletsky kernel: BTRFS warning (device sdc1): checksum=
 error at logical 7302091505664 on dev /dev/sdc1, physical 7166808424448, =
root 256, inode 50573, offset 1824653312, length 4096, links 1 (path: Vide=
os/Movies/Atlantis - The Lost Empire/Atlantis - The Lost Empire 2001 (1080=
p x265 10bit Tigole).mkv)

So it shows exactly which files have data checksum problems.

And due to those data checksum errors, the balance failed.


You can either try to delete those files, or use the command `btrfs=20
rescue fix-data-checksum -m 1 <device>` to re-generate the data checksum.

But please keep in mind that, the new checksum will be generated from=20
the on-disk data, if the on-disk data really contains some corruption,=20
you will lose the correct checksum.

Thanks,
Qu

> Sep 08 03:32:36 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x1501=
08ef mirror 1
> Sep 08 03:32:36 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 1054, gen 0
> Sep 08 03:32:36 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x1501=
08ef mirror 1
> Sep 08 03:32:36 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 1055, gen 0
> Sep 08 03:32:36 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x1501=
08ef mirror 1
> Sep 08 03:32:36 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 1056, gen 0
> Sep 08 03:32:44 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x1501=
08ef mirror 1
> Sep 08 03:32:44 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 1057, gen 0
> Sep 08 03:32:44 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x1501=
08ef mirror 1
> Sep 08 03:32:44 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 1058, gen 0
> Sep 08 03:32:44 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x1501=
08ef mirror 1
> Sep 08 03:32:44 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 1059, gen 0
> Sep 08 03:48:20 skarletsky sudo[291173]: yamiyuki : TTY=3Dpts/0 ; PWD=3D=
/mnt/jellycloud ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs balance status /m=
nt/disks/disk-20TB/
> Sep 08 03:49:02 skarletsky kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 7581048766464 on dev /dev/sdc1 physical 7=
445765685248
> Sep 08 03:49:03 skarletsky kernel: BTRFS warning (device sdc1): checksum=
 error at logical 7581048766464 on dev /dev/sdc1, physical 7445765685248, =
root 256, inode 50820, offset 8564736000, length 4096, links 1 (path: Vide=
os/Movies/Fantastic Beasts and Where to Find Them (2016)/Fantastic.Beasts.=
and.Where.to.Find.Them.2016.Multi.UHD.BluRay.2160p.x265-DD.5.1[En+Hi]-DTOn=
e.mkv)
> Sep 08 05:12:50 skarletsky kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 8515220930560 on dev /dev/sdc1 physical 8=
373495398400
> Sep 08 05:12:50 skarletsky kernel: BTRFS warning (device sdc1): checksum=
 error at logical 8515220930560 on dev /dev/sdc1, physical 8373495398400, =
root 256, inode 51497, offset 3236429824, length 4096, links 1 (path: Vide=
os/Movies/Lucy (2014)/Lucy (2014) [2160p] [4K] [BluRay] [5.1] [YTS.MX].mkv=
)
> Sep 08 06:54:29 skarletsky sudo[354666]: yamiyuki : TTY=3Dpts/0 ; PWD=3D=
/home/yamiyuki ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs balance status /mn=
t/disks/disk-20TB/
> Sep 08 06:54:37 skarletsky sudo[354711]: yamiyuki : TTY=3Dpts/0 ; PWD=3D=
/home/yamiyuki ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs scrub status /mnt/=
disks/disk-20TB/
> Sep 08 07:06:11 skarletsky kernel: BTRFS error (device sdc1): parent tra=
nsid verify failed on logical 199494880460800 mirror 1 wanted 288230376153=
242741 found 1530997
> Sep 08 07:06:11 skarletsky kernel: BTRFS error (device sdc1): parent tra=
nsid verify failed on logical 199494880460800 mirror 2 wanted 288230376153=
242741 found 1530997
> Sep 08 07:06:11 skarletsky kernel: BTRFS info (device sdc1): scrub: not =
finished on devid 1 with status: -5
> Sep 08 07:44:54 skarletsky kernel: BTRFS info (device sdc1): scrub: fini=
shed on devid 2 with status: 0
>=20
>=20
> Sent with Proton Mail secure email.
>=20
> On Saturday, September 6th, 2025 at 1:40 AM, Qu Wenruo <wqu@suse.com> wr=
ote:
>=20
>>
>> =E5=9C=A8 2025/9/6 13:28, jonas.timothy@proton.me =E5=86=99=E9=81=93:
>>
>>> Sent with Proton Mail secure email.
>>>
>>> On Friday, September 5th, 2025 at 6:12 PM, Qu Wenruo quwenruo.btrfs@gm=
x.com wrote:
>>>
>>>> =E5=9C=A8 2025/9/5 19:34, jonas.timothy@proton.me =E5=86=99=E9=81=93:
>>>> [...]
>>>>
>>>>> Hi Qu,
>>>>>
>>>>> I currently have 2 profiles because I have 2 sets of disks:
>>>>>
>>>>> $ sudo btrfs filesystem df /mnt/disks/disk-12TB
>>>>> Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
>>>>> System, RAID1: total=3D64.00MiB, used=3D800.00KiB
>>>>> Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>
>>>> So this means this fs is more or less corrupted, recommended to salva=
ge
>>>> the data first, then either re-format the fs or try `btrfs check --re=
pair` (which may not always repair the fs).
>>>>
>>>>> $ sudo btrfs filesystem df /mnt/disks/disk-20TB
>>>>> Data, single: total=3D6.79TiB, used=3D6.75TiB
>>>>> Data, RAID1: total=3D6.74TiB, used=3D6.71TiB
>>>>> System, RAID1: total=3D32.00MiB, used=3D1.84MiB
>>>>> Metadata, RAID1: total=3D14.00GiB, used=3D13.85GiB
>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
>>>>> WARNING: Data: single, raid1
>>>>>
>>>>> the one that went R/O is the 12TB pair, but the 20TB currently is ha=
ving trouble finishing setting up RAID 1.
>>>>
>>>> `btrfs fi usage` output please for the 20T fs.
>>>>
>>>> My guess is, you're mixing different sized disks in that 20T array.
>>>> And you're using RAID1 with 2 disks, the usage won't balance that wel=
l
>>>> among just 2 disks.
>>>
>>> I'm attaching both of them. I don't know if I should've done this diff=
erently, but I originally "muscled" it through when both were just stoppin=
g on their own by removing the file they mentioned can't be fixed by cutti=
ng it out of the drive, then placing it back in the drive.
>>>
>>> $ sudo btrfs filesystem usage /mnt/disks/disk-20TB
>>> Overall:
>>> Device size: 36.38TiB
>>> Device allocated: 20.30TiB
>>> Device unallocated: 16.08TiB
>>> Device missing: 0.00B
>>> Device slack: 0.00B
>>> Used: 20.20TiB
>>> Free (estimated): 10.80TiB (min: 8.10TiB)
>>> Free (statfs, df): 4.68TiB
>>> Data ratio: 1.50
>>> Metadata ratio: 2.00
>>> Global reserve: 512.00MiB (used: 0.00B)
>>> Multiple profiles: yes (data)
>>>
>>> Data,single: Size:6.79TiB, Used:6.75TiB (99.51%)
>>> /dev/sdc1 6.79TiB
>>>
>>> Data,RAID1: Size:6.74TiB, Used:6.71TiB (99.53%)
>>> /dev/sdc1 6.74TiB
>>> /dev/sdd1 6.74TiB
>>>
>>> Metadata,RAID1: Size:14.00GiB, Used:13.85GiB (98.95%)
>>> /dev/sdc1 14.00GiB
>>> /dev/sdd1 14.00GiB
>>>
>>> System,RAID1: Size:32.00MiB, Used:1.84MiB (5.76%)
>>> /dev/sdc1 32.00MiB
>>> /dev/sdd1 32.00MiB
>>>
>>> Unallocated:
>>> /dev/sdc1 4.65TiB
>>> /dev/sdd1 11.43TiB
>>
>>
>> Your 20TiB system indeed have some unbalanced data.
>>
>> But it should be mostly fine, as your single DATA is less than 7TiB on
>> sdc1, with that combined with the unused 4.6TiB on sdc, you should be
>> able to migrate the single to RAID1.
>>
>> What is preventing you from converting the single to RAID1 using
>> something like:
>>
>> # btrfs balance start -dprofile=3DSINGLE,convert=3Draid1 <mnt>
>>
>>
>> Thanks,
>> Qu
>=20
> If it doesn't get interrupted, it goes all the way until it locks up:
> Aug 31 23:37:22 skarletsky kernel: BTRFS info (device sdc1): relocating =
block group 199494852411392 flags metadata|raid1
> Aug 31 23:40:19 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 122 seconds.
> Aug 31 23:40:19 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:40:19 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:40:19 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:40:19 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:42:22 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 245 seconds.
> Aug 31 23:42:22 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:42:22 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:42:22 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:42:22 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:44:25 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 368 seconds.
> Aug 31 23:44:25 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:44:25 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:44:25 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:44:25 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:46:28 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 491 seconds.
> Aug 31 23:46:28 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:46:28 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:46:28 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:46:28 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:48:31 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 614 seconds.
> Aug 31 23:48:31 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:48:31 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:48:31 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:48:31 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:50:34 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 737 seconds.
> Aug 31 23:50:34 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:50:34 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:50:34 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:50:34 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:52:37 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 860 seconds.
> Aug 31 23:52:37 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:52:37 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:52:37 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:52:37 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:54:40 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 983 seconds.
> Aug 31 23:54:40 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:54:40 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:54:40 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:54:40 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:56:42 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 1105 seconds.
> Aug 31 23:56:42 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:56:42 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:56:42 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:56:42 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
> Aug 31 23:58:45 skarletsky kernel: INFO: task btrfs-transacti:1188 block=
ed for more than 1228 seconds.
> Aug 31 23:58:45 skarletsky kernel: task:btrfs-transacti state:D stack:0 =
    pid:1188  tgid:1188  ppid:2      task_flags:0x208040 flags:0x00004000
> Aug 31 23:58:45 skarletsky kernel:  btrfs_commit_transaction+0x9fc/0xc50=
 [btrfs]
> Aug 31 23:58:45 skarletsky kernel:  transaction_kthread+0x167/0x1d0 [btr=
fs]
> Aug 31 23:58:45 skarletsky kernel:  ? __pfx_transaction_kthread+0x10/0x1=
0 [btrfs]
>=20
>=20
> After I swapped the RAM, I've been slowly fixing the corruptions I run i=
nto that's been interrupting its balance:
> Sep 07 06:37:11 skarletsky kernel: BTRFS info (device sdc1): found 8 ext=
ents, stage: move data extents
> Sep 07 06:37:11 skarletsky kernel: BTRFS info (device sdc1): found 8 ext=
ents, stage: update data pointers
> Sep 07 06:37:11 skarletsky kernel: BTRFS info (device sdc1): relocating =
block group 12421075828736 flags data
> Sep 07 06:37:22 skarletsky kernel: BTRFS info (device sdc1): found 8 ext=
ents, stage: move data extents
> Sep 07 06:37:23 skarletsky kernel: BTRFS info (device sdc1): found 8 ext=
ents, stage: update data pointers
> Sep 07 06:37:23 skarletsky kernel: BTRFS info (device sdc1): relocating =
block group 12420002086912 flags data
> Sep 07 06:37:34 skarletsky kernel: BTRFS info (device sdc1): found 8 ext=
ents, stage: move data extents
> Sep 07 06:37:34 skarletsky kernel: BTRFS info (device sdc1): found 8 ext=
ents, stage: update data pointers
> Sep 07 06:37:35 skarletsky kernel: BTRFS info (device sdc1): relocating =
block group 12418928345088 flags data
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root -9 ino 891 off 564490240 logical 12419492835328 csum 0x423ede89 e=
xpected csum 0x4d402d24 mirror 1
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): checksum=
 error at logical 12419492835328 mirror 1 root 256 inode 65383 offset 1101=
361152 length 4096 links 1 (path: Videos/TV/Gilmore Girls/Season 1/Gilmore=
.Girls.S01E11.Paris.is.Burning.1080p.WEB-DL.x265.10bit.HEVC-MONOLITH.mkv)
> Sep 07 06:37:38 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 976, gen 0
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): csum fai=
led root -9 ino 891 off 564490240 logical 12419492835328 csum 0x423ede89 e=
xpected csum 0x4d402d24 mirror 1
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): checksum=
 error at logical 12419492835328 mirror 1 root 256 inode 65383 offset 1101=
361152 length 4096 links 1 (path: Videos/TV/Gilmore Girls/Season 1/Gilmore=
.Girls.S01E11.Paris.is.Burning.1080p.WEB-DL.x265.10bit.HEVC-MONOLITH.mkv)
> Sep 07 06:37:38 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/=
sdc1 errs: wr 0, rd 0, flush 0, corrupt 977, gen 0
> Sep 07 06:37:41 skarletsky kernel: BTRFS info (device sdc1): balance: en=
ded with status: -5
>=20
> I'm currently running --repair on it, and thankfully, I have a backup.
>=20
>>> $ sudo btrfs filesystem usage /mnt/disks/disk-12TB
>>> Overall:
>>> Device size: 21.56TiB
>>> Device allocated: 10.58TiB
>>> Device unallocated: 10.98TiB
>>> Device missing: 0.00B
>>> Device slack: 276.00GiB
>>> Used: 10.34TiB
>>> Free (estimated): 5.61TiB (min: 5.61TiB)
>>> Free (statfs, df): 5.47TiB
>>> Data ratio: 2.00
>>> Metadata ratio: 2.00
>>> Global reserve: 512.00MiB (used: 0.00B)
>>> Multiple profiles: no
>>>
>>> Data,RAID1: Size:5.28TiB, Used:5.17TiB (97.77%)
>>> /dev/sdb1 5.28TiB
>>> /dev/sda1 5.28TiB
>>>
>>> Metadata,RAID1: Size:7.00GiB, Used:6.18GiB (88.36%)
>>> /dev/sdb1 7.00GiB
>>> /dev/sda1 7.00GiB
>>>
>>> System,RAID1: Size:64.00MiB, Used:800.00KiB (1.22%)
>>> /dev/sdb1 64.00MiB
>>> /dev/sda1 64.00MiB
>>>
>>> Unallocated:
>>> /dev/sdb1 5.35TiB
>>> /dev/sda1 5.62TiB
>>>
>>>>> Would I have to redo this if COW is broken?
>>>>
>>>> Mostly yes.
>>>
>>> Bummer :-(
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> P.S. resending because I accidentally used regular "reply". Sorry.
>>>>>
>>>>> It also just finished scrubbing my 12TB RAID 1 array, and it aborted=
 :-(
>>>>>
>>>>> Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent=
 transid verify failed on logical 54114557984768 mirror 1 wanted 1250553 f=
ound 1250557
>>>>> Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent=
 transid verify failed on logical 54114557984768 mirror 2 wanted 1250553 f=
ound 1250557
>>>>>
>>>>> $ sudo btrfs filesystem df /mnt/disks/disk-12TB
>>>>> Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
>>>>> System, RAID1: total=3D64.00MiB, used=3D800.00KiB
>>>>> Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>>
>>>>> $ sudo btrfs scrub status /dev/sda1
>>>>> UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
>>>>> Scrub resumed: Fri Sep 5 03:16:31 2025
>>>>> Status: aborted
>>>>> Duration: 5:33:42
>>>>> Total to scrub: 10.34TiB
>>>>> Rate: 182.62MiB/s
>>>>> Error summary: no errors found
>>>>>
>>>>> $ sudo btrfs scrub status /dev/sdb1
>>>>> UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
>>>>> Scrub resumed: Fri Sep 5 03:16:31 2025
>>>>> Status: aborted
>>>>> Duration: 6:05:48
>>>>> Total to scrub: 10.34TiB
>>>>> Rate: 200.25MiB/s
>>>>> Error summary: no errors found


