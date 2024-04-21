Return-Path: <linux-btrfs+bounces-4467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC6A8AC0D5
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Apr 2024 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581C8B20DAD
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Apr 2024 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBF23EA83;
	Sun, 21 Apr 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b="RGvXN7Rw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.tnonline.net (mx.tnonline.net [65.109.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E678219F9
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Apr 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726567; cv=none; b=JrZbRZ3kqdotHNaddT4CG4LhomP/F/noFFXTsXU0Pawcrmd1dVjCm1Z5nWdQ1V7eQf0FE9JewT0rjUTwUgIKdj290d5zfPTSV5no/JET+1WHJvbPoTLvtni5qC1iPvTeppYsbHVzbCQtv2d/MMxqHl4X5MnxF30MFKhnJgrXow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726567; c=relaxed/simple;
	bh=NtnOCahnWDUh0oEWiAJ9R0GIpEBQTUkfXI09f4uiXjc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OL5QomRfGbsUnMlcpepl93Ioy8qkdflUX06EWCfHrEzqY8uFehZFeZdf4JeiOxDCg0wJqtUW2HOCyp8NxtvmFvKZcijzJWNXfWwyB3cKKub0Od8VRP0RXLSZxkml4SS768gwEyN8HSGNJBihjwplv/VHn+w/qZ20izbAorIvfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net; spf=pass smtp.mailfrom=tnonline.net; dkim=pass (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b=RGvXN7Rw; arc=none smtp.client-ip=65.109.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnonline.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/vxFBDjSDyN94kBoIdMkbFzQ8M/ZF4T3GkBo83u6KTg=; t=1713726565; x=1714936165; 
	b=RGvXN7RwSnMpbKo54riBXl4NOkCYcVzuox0Cqy+7m8E/Zvf+gss9Q707m6Mua72TMwL/D1YOlwP
	NZPMIq8e3REx6uA2qpPV7/iYWQnkQ9uC8mLbD3sm2SUjWosdDbeLTtEuJStKFDwVkk1xFYYnm7iJr
	eboLkL7bccEXZ3FNSYqXECh44m6GZxBXomTSeaq/sIQG1UwCqq4lqc8R7mfDNisLimOScfB3LYkNm
	ToUbo1DGGiyN7Hww3kwNOGYbWxcE7udP5bvgqGpRKd+ur30UpiW6wv1f4ixRx268JdZPVrurZjecI
	1toVvF7PyoWmzIn1RTB8NRI/6bISyQBG1fEA==;
Received: from tnonline.net ([2001:470:28:704::1]:42046)
	by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <postmaster@tnonline.net>)
	id 1rycYu-000000002It-0G9v;
	Sun, 21 Apr 2024 19:09:17 +0000
Received: from [192.168.0.132] (port=58202)
	by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <forza@tnonline.net>)
	id 1rycYq-00000000BJw-0Zz6;
	Sun, 21 Apr 2024 21:09:12 +0200
Date: Sun, 21 Apr 2024 21:09:11 +0200 (GMT+02:00)
From: Forza <forza@tnonline.net>
To: Leszek Dubiel <leszek@dubiel.pl>, linux-btrfs@vger.kernel.org
Message-ID: <909ed27.f7893fdf.18f020ff6fc@tnonline.net>
In-Reply-To: <99701acc-161b-477c-b1b3-d61e95903045@dubiel.pl>
References: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl> <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe> <b2806d95-a50c-41a2-b321-cf62c4f28966@dubiel.pl> <3aefeb1.20bf1a80.18ee7da3d40@tnonline.net> <99701acc-161b-477c-b1b3-d61e95903045@dubiel.pl>
Subject: =?UTF-8?Q?Re:_enospc_errors_during_balanc?=
 =?UTF-8?Q?e_=E2=80=94_how_to_prevent_out_of_space?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
X-Spam-Score: -2.2 (--)



---- From: Leszek Dubiel <leszek@dubiel.pl> -- Sent: 2024-04-16 - 22:07 ---=
-

>> It is not wise to balance metadata block groups
>=20
> I have never run balancing with musage=3D.
>=20
> Disk got full.
> I remove snapshots.
> Run balance with=C2=A0 dusage=3D many times.
> Hit "no space" error agian.
> As a last rescue try i used=C2=A0 musage=3D0.
> This helped.
>=20
>=20
> In script from Kdave:
>=20
> https://github.com/kdave/btrfsmaintenance/blob/be42cb6267055d125994abd692=
7cf3a26deab74c/btrfs-balance.sh#L55
>=20
> Anyway =E2=80=94 I will use musage as a last resort.
>=20
>=20
>=20
>=20
>=20
>>   Btrfs needs unallocated disk space to be able to allocate new data or =
metadata chunks
>=20
> Yes, thank you.
>=20
>=20
>=20
>=20
>=20
>=20
>>   If it cannot allocate new data chunks you will see an out of disk spac=
e error. However if btrfs cannot allocate new metadata chunks, the filesyst=
em will turn read-only, making it much harder to fix - as you cannot balanc=
e or add additional space in an read-only filesystem.
>=20
> Now I understand it. :)
>=20
>=20
>=20
>=20
>>> I started to run this script from cron every 10 minutes:
>>>
>>>
>>> #!/usr/bin/bash
>>>
>>> mount | sed -nr 's%^/dev/sd[a-z][0-9] on (/[/_[:alnum:]]+) type btrfs
>>> .*$%\1%; T; p' |
>>> while read mnt; do
>>>   =C2=A0=C2=A0 =C2=A0if
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 btrfs dev usage "$mnt" -g |
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 perl -ne '/Unallocated: +([0-9]=
+\.[0-9]{2})GiB/ and $1 < 64 and
>>> print $1' |
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 grep -q .
>>>   =C2=A0=C2=A0 =C2=A0then
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 echo "porz=C4=85dkowa=C4=87 $mn=
t"
>>>
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 for usa in $(seq 0 10 100); do
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # I don't kn=
ow whether to start with "dusage" or "musage",
>>> so i shuffle it;
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # 15 april 2=
024 my serwer was locked, "dusage" returned
>>> "enospace", and it
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # got unlock=
ed after "musage=3D0"
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 {
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 echo d $usa
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 echo m $usa
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 } | shuf
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 done |
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 while read typ usa; do
>>>
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 echo; echo; =
date; echo "balance type=3D$typ, usage=3D$usa"
>>>
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 out=3D"$(btr=
fs balance start -${typ}usage=3D$usa,limit=3D3 "$mnt"
>>> 2>&1)"
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 echo "$out"
>>>
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # if nothing=
 was done, then try higher usage
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 echo "$out" =
| grep -q "had to relocate 0 out of" && continue
>>>
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # otherwise =
finish: on error or on successful relocate
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break
>>>   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 done
>>>   =C2=A0=C2=A0 =C2=A0fi
>>> done
>>>
>> Do you mean you run this continuously on your filesystem? This is normal=
ly not required and will increase wear on your disks.
>=20
> Yes. But it runs balance only when Unallocated is less then limit.
>=20
>=20
>>> Thanks for hints :) :)
>>>
>>> This solves my questions:
>>>
>>> 1. i have to rebalance when Unallocated is low
>>>
>>> 2. i have to keep 2Gb at least.
>> You should keep at least 1GB x profile mode. That is for DUP, 2GB, and f=
or RAID1, at least 1GB on two devices.
>=20
> Great info. :)
>=20
> My raid is 3 disk, so I will set limit of 3 disk * 1Gb =3D 3Gb minimum.
>=20
>=20
>> It would be better to have more, to be safe.
>>
>> An option that could be used is 'bg_reclaim_threshold', which is a sysfs=
 knob to let the kernel automatically reclaim (balance) block groups that f=
all under a specific threshold.
>>
>> https://btrfs.readthedocs.io/en/latest/ch-sysfs.html
>=20
> On my system it is set to 75.
>=20

It is '0' as default. There are two different sysfs files with that name. Y=
ou should look the one at:

 /sys/fs/btrfs/<uuid>/allocation/data/



> Disk got full.
> I remove snapshots.
> Disk showed it has free space 1Tb out of 8TB.
> And I got "no space" error again.
> I spotted then "Unallocated =3D 1 MiB",
> then started to balance by hand.
>=20
> I will observe that system and test all i know from your help.
> Thank you.
>=20
>=20
>=20
> # cat=20
> /sys/fs/btrfs/ec3525ef-b73a-452a-a4ee-86286252d730/bg_reclaim_threshold
> 75
>=20
>=20
> # btrfs fi show /
> Label: none=C2=A0 uuid: ec3525ef-b73a-452a-a4ee-86286252d730
>  =C2=A0=C2=A0 =C2=A0Total devices 3 FS bytes used 7.22TiB
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.43TiB used 5.36TiB p=
ath /dev/sdc3
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 5.43TiB used 5.36TiB p=
ath /dev/sda3
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 3 size 5.43TiB used 5.37TiB p=
ath /dev/sdb3
>=20
>=20
>=20
> # btrfs fi df /
> Data, RAID1: total=3D8.00TiB, used=3D7.18TiB
> System, RAID1: total=3D32.00MiB, used=3D1.36MiB
> Metadata, RAID1: total=3D43.00GiB, used=3D39.31GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D48.00KiB
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20



