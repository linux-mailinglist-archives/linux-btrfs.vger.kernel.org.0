Return-Path: <linux-btrfs+bounces-18177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F5BFEFC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 05:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F804E307B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC72248B4;
	Thu, 23 Oct 2025 03:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="KuLgpA4O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cMzCg+Ob"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043517C21B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761189743; cv=none; b=brE8+hlv1MLPJeXolbV/N2oNVIDVDOyf4FxbnZqEVLOd6Nw/VE4wlPniTv7lLChpxzKFkPSg9GUYQrGDWsKZFCR+s/TrUwN/SWOrqZaHeshGIdQgrRCOPMl3q0y2sGsTFq4hhNKIsjY7j5URTDAiVd8paJ6c6MHR9Y+zMyTXXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761189743; c=relaxed/simple;
	bh=zuC1M0Myb29h+RATbtT09UT5Vyr7+4WASUhELD/rTBE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U/NMjitEzaJYA//oECIXMBZTu4ngf7U/lw02+0845JiUeki8PdDVLzqCeXy2mx99zHSmeQ04df8cV+TFYE4HGWHQoddXmCwby2smeDcHpOruHowT0sO6Cs52NSLZHsuj6RasxhmZNdsFhF9083/6yK1gJu9//p57tM+pv+qaWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=KuLgpA4O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cMzCg+Ob; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 781EB1D00143;
	Wed, 22 Oct 2025 23:22:20 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Wed, 22 Oct 2025 23:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761189740; x=1761276140; bh=JAaXhbpXvJZokgJS2Cn6V
	Fzcxc9GJxx0h0WInft+NBQ=; b=KuLgpA4Obg6NIb+wysLcUGNfjxM4/39ccyR8E
	bXHjWOQmyhM/5g/DC9ITsXT6nwxm6QyA1M7PuXKkAV0S+Ip6R2pgIsB+S/SBss+N
	Epe0S4sQidvtC060FXYXXFyV59ugAUBBGUR0Vm/LIOrvEgO7uFx5LzIQTHL+aGlH
	4K3VlMZLLAJxf7/5UpjL+NaMJU2Pcl4+EOcSaNn8nc65m0JMKOyXkH2qOsIi7OyU
	GbV82oYk2cot+C11GQsWdfoBzrCQ9c41P/EeSiTIrFhgOEwZ+bLMS7xEzRxUimGw
	DdFOdV2vMpeG7+RiEmVYzjKtwSZNhOdHS9P7fTQmSr8g1/mJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761189740; x=1761276140; bh=J
	AaXhbpXvJZokgJS2Cn6VFzcxc9GJxx0h0WInft+NBQ=; b=cMzCg+ObaGYVCVOub
	mMJ12D+EFCaROiNpSC1rskyWVKNY6l+wIDUKdlvTAbSXaiOYS06h5INe3x1FEDuB
	vZz6/wBnOWciGL3VVk7kvZvFaT/+wouO7D3oY5aI+AwKWTXREIK/GnqbEfkOkqCa
	yqeSDLmquoUZuvAn4c8ngvVjosMl+DezGLViuzsvcMPMVQRG7qaJxRw4+wjb6330
	9KheEldSP7ghjUh86FQk1Ce0Y3OtTntlRvqjSjsorb5pO1UcK9AZtU9hn4TiVuxq
	pEIfhwx4WnAM+yPWyh7/CwoZ17188xV/CjyXheuNVJ/pMPdse/1EkSzNZ3txaUzc
	4X5+A==
X-ME-Sender: <xms:bJ_5aEPEOWsHulyh0BJ1bUBjZl1xDVtvRN10Qux6GzsoAB1Nj9xrPg>
    <xme:bJ_5aFyWP3Fbao3ozXPc6oVMD5i8U28UG0SJ69pIZlYKx_ZZ23rWshZOestKvQsRN
    B939_GruNRbiAiDHiky6yt_alfHiHR6Qk0U3olqFAP_rjaGFYuXAHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepkeeiueejkeffhfevvdefgeefffelffelgfejieevteevleff
    ueeuvdfghfdujefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhnfhgrtddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:bJ_5aC7C2bYN3zMBiXLXXRvNIX9561QPvKXwt2oEEcVd9XxGp3wh1w>
    <xmx:bJ_5aJ1Kb43j8c-JgZXL8gbpDgc2yxbjVufuDZElbkA_LLJU7_pE9w>
    <xmx:bJ_5aJBQ7g0MMvEvj89HoWCQe9DT_R22U1GyNT73NhXpw7URoKcTZQ>
    <xmx:bJ_5aL2YMc24XW0gWClJmyzoINNCfEw4OB8wEihJgJL_E-R4pjyzmQ>
    <xmx:bJ_5aKhhMutEPX5wXGaB3zniN8TIGb5KBecNcp75PKAqUgELVTqhTae8>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 14D4F18C004E; Wed, 22 Oct 2025 23:22:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Oct 2025 23:21:59 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com>
In-Reply-To: 
 <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
References: 
 <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Oct 22, 2025, at 7:27 AM, Tobiasz Karo=C5=84 wrote:

> root@pve:~# uname -a=20
> Linux pve 6.8.12-15-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-15 (2025-09-=
12T11:02Z) x86_64 GNU/Linux=20
> root@pve:~# btrfs --version=20
> btrfs-progs v6.2
>=20

This is an EOL kernel, so support would come from the provider of this k=
ernel. The 6.8 kernel was released in early 2024, and isn't receiving st=
able backports from upstream.

Also the btrfs-progs version is quite old, about 2023. It's safe to run =
it without --repair but there's too many bug fixes since then to give a =
summary.

> root@pve:~# btrfs fi show=20
> Label: 'unfa-RollingBackup6G'  uuid: a11787a5-de1d-421c-ac2e-b669f948b=
1f0=20
>        Total devices 2 FS bytes used 9.08TiB=20
>        devid    1 size 0 used 0 path /dev/sdd MISSING=20
>        devid    2 size 0 used 0 path /dev/sdb MISSING
>=20

Not sure why these are reported missing.

>=20
> root@pve:~#  btrfs fi df /mnt/backup/=20
> Data, single: total=3D9.07TiB, used=3D9.07TiB=20
> System, RAID1: total=3D32.00MiB, used=3D1.19MiB=20
> Metadata, RAID1: total=3D11.03GiB, used=3D9.91GiB=20
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> I am attaching a full zstd-compressed dmesg log.
> SMART reports no errors, and I can still mount the FS.
> btrfs check returned this:
>=20
> root@pve:~# btrfs check /dev/sde =20
> Opening filesystem to check...=20
> Checking filesystem on /dev/sde=20
> UUID: a11787a5-de1d-421c-ac2e-b669f948b1f0=20
> [1/7] checking root items=20
> [2/7] checking extents=20
> [3/7] checking free space tree=20
> [4/7] checking fs roots=20
> root 5 inode 32750 errors 2000, link count wrong
>=20

This is a minor issue, and should be repairable with --repair using rece=
nt btrfs-progs, but I can't recommend it with old btrfs-progs.



>=20
> I use a dual-disk USB enclosure to accees these drives - I know it's l=
ess than ideal, but the machine I have is low-power and that's the best =
I can do with the budget I have for now.

Kernel first sees them at:

[70132.171424] BTRFS: device label unfa-RollingBackup6G devid 2 transid =
70744 /dev/sdb scanned by (udev-worker) (340477)
[70132.337014] BTRFS: device label unfa-RollingBackup6G devid 1 transid =
70744 /dev/sdd scanned by (udev-worker) (340481)

There are command queue failures happening with both drives:

[2075668.586774] sd 2:0:0:0: [sdb] tag#18 uas_eh_abort_handler 0 uas-tag=
 6 inflight: CMD OUT=20
[2075668.586778] sd 2:0:0:0: [sdb] tag#18 CDB: Write(16) 8a 00 00 00 00 =
01 d1 9f af e0 00 00 00 60 00 00
[2075668.586849] sd 2:0:0:0: [sdb] tag#17 uas_eh_abort_handler 0 uas-tag=
 5 inflight: CMD OUT=20
[2075668.586852] sd 2:0:0:0: [sdb] tag#17 CDB: Write(16) 8a 00 00 00 00 =
01 d1 9f ae e0 00 00 00 20 00 00

[2075668.086683] sd 2:0:0:1: [sdd] tag#0 uas_eh_abort_handler 0 uas-tag =
1 inflight: CMD IN=20
[2075668.086694] sd 2:0:0:1: [sdd] tag#0 CDB: Read(16) 88 00 00 00 00 00=
 0e 0a cc 08 00 00 00 08 00 00
[2075668.176701] sd 2:0:0:1: [sdd] tag#23 uas_eh_abort_handler 0 uas-tag=
 24 inflight: CMD OUT=20
[2075668.176718] sd 2:0:0:1: [sdd] tag#23 CDB: Write(16) 8a 00 00 00 00 =
02 ba 3f f0 e0 00 00 00 80 00 00

This can mean there are dropped reads and writes at the block layer. My =
guess is there's a firmware quirk with both enclosures and the quirk isn=
't being set by this kernel. You might be able to work around it by disa=
bling the uas driver for both drives. That can be done with a udev rule.

I have two enclosures that had similar errors and it was fixed either by=
 disabling uas for both drives, or connecting to an externally powered U=
SB hub. Something with a good bit of power in the spec so both drives ca=
n use their max runtime amps at the same time. I advise not powering the=
m up at the same time, the draw is too much, and while they will eventua=
lly spin up - in effect the drive is "booting" with a brown out and that=
 could result in indeterminate behavior of the firmware.

Also, best to disable the write cache on both drives. Neither drive supp=
orts FUA. That too can be set with a udev rule. Make sure to check the h=
dparm man page and get the correct flag because the wrong one can brick =
a drive.=20


[70132.042567] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabl=
ed, doesn't support DPO or FUA
[70132.042929] sd 2:0:0:1: [sdd] Write cache: enabled, read cache: enabl=
ed, doesn't support DPO or FUA


This errors suggests that drive sdb dropped writes and it was corrected

[2080584.362151] BTRFS error (device sdd): parent transid verify failed =
on logical 15136619216896 mirror 2 wanted 74627 found 73734
[2080584.376137] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136619216896 (dev /dev/sdb sector 7811870432)
[2080584.376260] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136619220992 (dev /dev/sdb sector 7811870440)
[2080584.376378] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136619225088 (dev /dev/sdb sector 7811870448)
[2080584.376496] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136619229184 (dev /dev/sdb sector 7811870456)


More command queue errors

[2086918.503672] sd 2:0:0:1: [sdd] tag#3 uas_eh_abort_handler 0 uas-tag =
24 inflight: CMD OUT=20
[2086918.503681] sd 2:0:0:1: [sdd] tag#3 CDB: Write(16) 8a 00 00 00 00 0=
2 ba 23 da 20 00 00 00 40 00 00

Device reset

[2086940.343856] usb 4-1.2: reset SuperSpeed USB device number 5 using x=
hci_hcd

And also the other file systems have issues going on too which is likely=
 related to the hardware/firmware/kernel block layer confusion - therefo=
re all the file systems get confused.

And then enospc issues, unrelated to the above.

[2092753.887210] BTRFS info (device sdd): balance: start -dusage=3D1 -mu=
sage=3D1 -susage=3D1
[2092784.472774] BTRFS info (device sdd): 157 enospc errors during balan=
ce
[2092784.472782] BTRFS info (device sdd): balance: ended with status: -28

Add more space I assume

[2652031.025503] BTRFS info (device sdd): disk added /dev/loop0

The balance now proceeds. More errors and fixups from good copies on the=
 mirror (lucky since both drives appear to be occasionally dropping writ=
es - just so far not the same writes):

[2652149.062979] BTRFS error (device sdd): bad tree block start, mirror =
2 want 15135668535296 have 8901696662615020189
[2652149.184097] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15135668535296 (dev /dev/sdb sector 7810013632)
[2652149.184226] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15135668539392 (dev /dev/sdb sector 7810013640)
[2652149.184370] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15135668543488 (dev /dev/sdb sector 7810013648)
[2652149.184511] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15135668547584 (dev /dev/sdb sector 7810013656)


The balance continues for a long time - so a balance is a very intense p=
rocess. I'm not sure why balance 90 was indicated for this file system, =
but it's going to take a long time during which a write could be dropped=
 at any moment. It's pretty risky. But it finally ends OK.

[2655999.361506] BTRFS info (device sdd): balance: ended with status: 0

But I don't see removal of /dev/loop0. There are more errors found thoug=
h.

[2719403.975693] BTRFS error (device sdd): bad tree block start, mirror =
2 want 15136617250816 have 15136619364352
[2719403.996904] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136617250816 (dev /dev/sdb sector 7811866592)
[2719403.997058] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136617254912 (dev /dev/sdb sector 7811866600)
[2719403.997347] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136617259008 (dev /dev/sdb sector 7811866608)
[2719403.997500] BTRFS info (device sdd): read error corrected: ino 0 of=
f 15136617263104 (dev /dev/sdb sector 7811866616)

next, quite a lot of command queue errors again and then  a new error:

[3082064.445514] I/O error, dev sdd, sector 1378595728 op 0x0:(READ) fla=
gs 0x84700 phys_seg 128 prio class 0
[3082064.445543] I/O error, dev sdd, sector 1378594800 op 0x0:(READ) fla=
gs 0x80700 phys_seg 116 prio class 0
[3082064.445567] I/O error, dev sdd, sector 1378596752 op 0x0:(READ) fla=
gs 0x80700 phys_seg 128 prio class 0
...
there's quite a lot of these now

btrfs reports on the effect of these read errors

[3082064.490661] BTRFS error (device sdd): bdev /dev/sdd errs: wr 0, rd =
1, flush 0, corrupt 0, gen 0
[3082064.531667] BTRFS error (device sdd): bdev /dev/sdd errs: wr 0, rd =
2, flush 0, corrupt 0, gen 0
[3082064.595676] sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result:=
 hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[3082064.608670] BTRFS error (device sdd): bdev /dev/sdd errs: wr 0, rd =
3, flush 0, corrupt 0, gen 0

Either the devices are unplugged or drop off the bus, I can't tell but t=
hen they come back and....

[3082068.348113] BTRFS warning: duplicate device /dev/sde devid 2 genera=
tion 80653 scanned by (udev-worker) (1575180)
[3082068.514282] BTRFS warning: duplicate device /dev/sdf devid 1 genera=
tion 80653 scanned by (udev-worker) (1575184)
[3082072.149738] kworker/u66:3: attempt to access beyond end of device
                 sdd: rw=3D1052673, sector=3D11695499072, nr_sectors =3D=
 32 limit=3D0
[3082072.149747] BTRFS error (device sdd): bdev /dev/sdd errs: wr 1, rd =
3, flush 0, corrupt 0, gen 0
[3082072.149754] kworker/u66:3: attempt to access beyond end of device
                 sdb: rw=3D1052673, sector=3D1847256896, nr_sectors =3D =
32 limit=3D0

...
and kaboom

[3082097.750544] BTRFS info (device sdd: state EA): forced readonly

And then clearly the kernel is confused:

[3082919.543755] BTRFS warning: duplicate device /dev/sde devid 2 genera=
tion 80653 scanned by (udev-worker) (1578969)
[3082919.728788] BTRFS warning: duplicate device /dev/sdf devid 1 genera=
tion 80653 scanned by (udev-worker) (1578973)
[3082994.380016] BTRFS warning: duplicate device /dev/sdf devid 1 genera=
tion 80653 scanned by mount (1579331)
[3083009.198896] BTRFS warning: duplicate device /dev/sde devid 2 genera=
tion 80653 scanned by (udev-worker) (1579398)
[3083009.605855] BTRFS warning: duplicate device /dev/sdf devid 1 genera=
tion 80653 scanned by (udev-worker) (1579398)


As far as I'm aware, when it gets confused about drives dropping off USB=
 bus and then coming back - it reassigns them new nodes instead of conne=
cting them to the nodes they had before - and that's only fixable with a=
 reboot.

And then figure out how to disable uas for these drives.

And disable the write cache for the drives.

And only then should they be scrubbed, and it'll probably work. But with=
 write cache disabled, writes will be slower yet safer.

I don't think the file system is damaged, I think all the problems are r=
elated to enclosures having quirky firmware, very common. These quirks g=
et cleaned up by USB hubs. But also, with later kernels at least my USB =
drives no longer misbehave when directly connected to computers, instead=
 of via an externally powered USB hub.


--
Chris Murphy

