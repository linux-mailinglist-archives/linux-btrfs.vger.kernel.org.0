Return-Path: <linux-btrfs+bounces-16764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7FB50C38
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCBB188F551
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 03:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E238257435;
	Wed, 10 Sep 2025 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XgleUrDu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED61200C2
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473918; cv=none; b=ExLmsiv8nvlrbiKZLLMkSsO4oKqJJ9qk65TNBfWzvOpdRAOyo3r61bEi8VfxoM4P3620Q2ooaJVBd4ltVzNs0WfpQH9pl9cXxDpccuTa0ECvcESM4k1H6zdkgTIu3It+OBLUGfrzxu7E+DwZPTViEDMiIV53hHOdJlKOU5TEgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473918; c=relaxed/simple;
	bh=K1DmrB22ilsaYLIhg2ylGhZ6GUxVGoXe7A3iRybwna0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3XqxCL6LbD8eMca/9bQ7eDxHpW8UeIcjV7g779MvX3wJdrwRdG4rQIPAoWYCh6uQ6U7Ub712I3k/rbqJ3ZjQMvFAeY8KGVgLYzY0R6a/KJOT9Jq8uTGNhIIGIt6u+R7g2YY6L1qCsxkcc9UP7fcdSCxy+5SSNuUA2BXbVRq7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XgleUrDu; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757473911; x=1757733111;
	bh=K1DmrB22ilsaYLIhg2ylGhZ6GUxVGoXe7A3iRybwna0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XgleUrDux9uy+DVm3M0lGx3V7fb4rZF5QV2d5kpwkKUFXbLsxgcOeIZEA/7QnvY5v
	 Pqbi/Rr/HON2i9gOY7VJZsz6FteON355beA2gKBf0HtztsVSPDCn0iM3YDDtXxs1Yc
	 3ytkUIrKw+8wqoLR0kc2E4lJkoM3XUJd0d3B9b5kelmBYF0tzzzJmvIMXqFjY5yKSa
	 wm24idduZDVK6ZAfN75zB9v/Qd5aVLDIP1KqQqp34QwN8IxRFKQEdFSlXitpMOGJjA
	 eDB7xor7nwtwwcQ3rYuoUor46DFIjpeo5ucrqK1rWc7bjUtrTnu8VEXExqfXZW6fYc
	 JST2PzmlTB8oA==
Date: Wed, 10 Sep 2025 03:11:47 +0000
To: Qu Wenruo <wqu@suse.com>
From: jonas.timothy@proton.me
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs RAID 1 mounting as R/O
Message-ID: <gK_zcURIHaYlRYBag1Gl6YVZdvtQ8_A5kBrwTdc4utvoXbPYTuxtXJPl8bi_8mjmd9zEuJuQDTJxchydAuoYaXXux0ZL4bcq4vGJvyPN4-U=@proton.me>
In-Reply-To: <OVaP9JLctKwGQE9-ko-DgNoKsm2gRoh8WP5W0HHyYnv0vXeLV2yqfI34NfT2W3z6peteBNk-D6wkZbPiZepfT83Xb7kHn6LfQsb3cDY0npU=@proton.me>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me> <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com> <h5sKXFIVsnBPX0i1K8jnrgzAQu2oE-NMORKYVaNPyp-FnKaQN032HGmejwSQl8KIbtpMj-37pFT3KDrbn_xmrdzqNVzjzIw-9YU6s8DW0mA=@proton.me> <595fb33e-a3e8-46cc-80ff-e50c2a70bffd@gmx.com> <xrsGddBl1hq0FSjKaqFM8275iii6WNju5hyl2wU8I9J7f2q3C11Dhsqgn-ANIXJRP-NMf4jioFdthalcpZn7YjKb0KAE7YBYxiGSA6g41Z4=@proton.me> <198b7846-539c-44cf-b746-c70fe2befa69@suse.com> <OVaP9JLctKwGQE9-ko-DgNoKsm2gRoh8WP5W0HHyYnv0vXeLV2yqfI34NfT2W3z6peteBNk-D6wkZbPiZepfT83Xb7kHn6LfQsb3cDY0npU=@proton.me>
Feedback-ID: 94251912:user:proton
X-Pm-Message-ID: ee0f81f3b28537edb64bd2867f23e9548272696b
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Currently getting a fair amount of this when running --repair on my unfinis=
hed 20TB RAID

Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
^[[A^[[A^[[Asuper bytes used 14894738132992 mismatches actual used 14894738=
149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376
parent transid verify failed on 199494880460800 wanted 288230376153242741 f=
ound 1530997
Ignoring transid failure
super bytes used 14894738132992 mismatches actual used 14894738149376





Sent with Proton Mail secure email.

On Tuesday, September 9th, 2025 at 10:43 PM, jonas.timothy@proton.me <jonas=
.timothy@proton.me> wrote:

> Good news!
>=20
> * I swapped my RAM
> * Ran `btrfs check --repair`
>=20
> And that made my 12TB RAID bootable
>=20
> Now, I'm trying to get my 20TB working cuz it won't finish balancing
>=20
> Sep 08 03:12:13 skarletsky sudo[284148]: yamiyuki : TTY=3Dpts/0 ; PWD=3D/=
mnt/jellycloud ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs balance status /mnt=
/disks/disk-20TB/
> Sep 08 03:26:55 skarletsky kernel: BTRFS error (device sdc1): unable to f=
ixup (regular) error at logical 7302091505664 on dev /dev/sdc1 physical 716=
6808424448
> Sep 08 03:26:55 skarletsky kernel: BTRFS warning (device sdc1): checksum =
error at logical 7302091505664 on dev /dev/sdc1, physical 7166808424448, ro=
ot 256, inode 50573, offset 1824653312, length 4096, links 1 (path: Videos/=
Movies/Atlantis - The Lost Empire/Atlantis - The Lost Empire 2001 (1080p x2=
65 10bit Tigole).mkv)
> Sep 08 03:32:36 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x150108=
ef mirror 1
> Sep 08 03:32:36 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 1054, gen 0
> Sep 08 03:32:36 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x150108=
ef mirror 1
> Sep 08 03:32:36 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 1055, gen 0
> Sep 08 03:32:36 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x150108=
ef mirror 1
> Sep 08 03:32:36 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 1056, gen 0
> Sep 08 03:32:44 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x150108=
ef mirror 1
> Sep 08 03:32:44 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 1057, gen 0
> Sep 08 03:32:44 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x150108=
ef mirror 1
> Sep 08 03:32:44 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 1058, gen 0
> Sep 08 03:32:44 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root 256 ino 50573 off 1824694272 csum 0xbfe73655 expected csum 0x150108=
ef mirror 1
> Sep 08 03:32:44 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 1059, gen 0
> Sep 08 03:48:20 skarletsky sudo[291173]: yamiyuki : TTY=3Dpts/0 ; PWD=3D/=
mnt/jellycloud ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs balance status /mnt=
/disks/disk-20TB/
> Sep 08 03:49:02 skarletsky kernel: BTRFS error (device sdc1): unable to f=
ixup (regular) error at logical 7581048766464 on dev /dev/sdc1 physical 744=
5765685248
> Sep 08 03:49:03 skarletsky kernel: BTRFS warning (device sdc1): checksum =
error at logical 7581048766464 on dev /dev/sdc1, physical 7445765685248, ro=
ot 256, inode 50820, offset 8564736000, length 4096, links 1 (path: Videos/=
Movies/Fantastic Beasts and Where to Find Them (2016)/Fantastic.Beasts.and.=
Where.to.Find.Them.2016.Multi.UHD.BluRay.2160p.x265-DD.5.1[En+Hi]-DTOne.mkv=
)
> Sep 08 05:12:50 skarletsky kernel: BTRFS error (device sdc1): unable to f=
ixup (regular) error at logical 8515220930560 on dev /dev/sdc1 physical 837=
3495398400
> Sep 08 05:12:50 skarletsky kernel: BTRFS warning (device sdc1): checksum =
error at logical 8515220930560 on dev /dev/sdc1, physical 8373495398400, ro=
ot 256, inode 51497, offset 3236429824, length 4096, links 1 (path: Videos/=
Movies/Lucy (2014)/Lucy (2014) [2160p] [4K] [BluRay] [5.1] [YTS.MX].mkv)
> Sep 08 06:54:29 skarletsky sudo[354666]: yamiyuki : TTY=3Dpts/0 ; PWD=3D/=
home/yamiyuki ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs balance status /mnt/=
disks/disk-20TB/
> Sep 08 06:54:37 skarletsky sudo[354711]: yamiyuki : TTY=3Dpts/0 ; PWD=3D/=
home/yamiyuki ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs scrub status /mnt/di=
sks/disk-20TB/
> Sep 08 07:06:11 skarletsky kernel: BTRFS error (device sdc1): parent tran=
sid verify failed on logical 199494880460800 mirror 1 wanted 28823037615324=
2741 found 1530997
> Sep 08 07:06:11 skarletsky kernel: BTRFS error (device sdc1): parent tran=
sid verify failed on logical 199494880460800 mirror 2 wanted 28823037615324=
2741 found 1530997
> Sep 08 07:06:11 skarletsky kernel: BTRFS info (device sdc1): scrub: not f=
inished on devid 1 with status: -5
> Sep 08 07:44:54 skarletsky kernel: BTRFS info (device sdc1): scrub: finis=
hed on devid 2 with status: 0
>=20
>=20
> Sent with Proton Mail secure email.
>=20
>=20
> On Saturday, September 6th, 2025 at 1:40 AM, Qu Wenruo wqu@suse.com wrote=
:
>=20
> > =E5=9C=A8 2025/9/6 13:28, jonas.timothy@proton.me =E5=86=99=E9=81=93:
> >=20
> > > Sent with Proton Mail secure email.
> > >=20
> > > On Friday, September 5th, 2025 at 6:12 PM, Qu Wenruo quwenruo.btrfs@g=
mx.com wrote:
> > >=20
> > > > =E5=9C=A8 2025/9/5 19:34, jonas.timothy@proton.me =E5=86=99=
=E9=81=93:
> > > > [...]
> > > >=20
> > > > > Hi Qu,
> > > > >=20
> > > > > I currently have 2 profiles because I have 2 sets of disks:
> > > > >=20
> > > > > $ sudo btrfs filesystem df /mnt/disks/disk-12TB
> > > > > Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
> > > > > System, RAID1: total=3D64.00MiB, used=3D800.00KiB
> > > > > Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
> > > > > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> > > >=20
> > > > So this means this fs is more or less corrupted, recommended to sal=
vage
> > > > the data first, then either re-format the fs or try `btrfs check --=
repair` (which may not always repair the fs).
> > > >=20
> > > > > $ sudo btrfs filesystem df /mnt/disks/disk-20TB
> > > > > Data, single: total=3D6.79TiB, used=3D6.75TiB
> > > > > Data, RAID1: total=3D6.74TiB, used=3D6.71TiB
> > > > > System, RAID1: total=3D32.00MiB, used=3D1.84MiB
> > > > > Metadata, RAID1: total=3D14.00GiB, used=3D13.85GiB
> > > > > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> > > > > WARNING: Multiple block group profiles detected, see 'man btrfs(5=
)'
> > > > > WARNING: Data: single, raid1
> > > > >=20
> > > > > the one that went R/O is the 12TB pair, but the 20TB currently is=
 having trouble finishing setting up RAID 1.
> > > >=20
> > > > `btrfs fi usage` output please for the 20T fs.
> > > >=20
> > > > My guess is, you're mixing different sized disks in that 20T array.
> > > > And you're using RAID1 with 2 disks, the usage won't balance that w=
ell
> > > > among just 2 disks.
> > >=20
> > > I'm attaching both of them. I don't know if I should've done this dif=
ferently, but I originally "muscled" it through when both were just stoppin=
g on their own by removing the file they mentioned can't be fixed by cuttin=
g it out of the drive, then placing it back in the drive.
> > >=20
> > > $ sudo btrfs filesystem usage /mnt/disks/disk-20TB
> > > Overall:
> > > Device size: 36.38TiB
> > > Device allocated: 20.30TiB
> > > Device unallocated: 16.08TiB
> > > Device missing: 0.00B
> > > Device slack: 0.00B
> > > Used: 20.20TiB
> > > Free (estimated): 10.80TiB (min: 8.10TiB)
> > > Free (statfs, df): 4.68TiB
> > > Data ratio: 1.50
> > > Metadata ratio: 2.00
> > > Global reserve: 512.00MiB (used: 0.00B)
> > > Multiple profiles: yes (data)
> > >=20
> > > Data,single: Size:6.79TiB, Used:6.75TiB (99.51%)
> > > /dev/sdc1 6.79TiB
> > >=20
> > > Data,RAID1: Size:6.74TiB, Used:6.71TiB (99.53%)
> > > /dev/sdc1 6.74TiB
> > > /dev/sdd1 6.74TiB
> > >=20
> > > Metadata,RAID1: Size:14.00GiB, Used:13.85GiB (98.95%)
> > > /dev/sdc1 14.00GiB
> > > /dev/sdd1 14.00GiB
> > >=20
> > > System,RAID1: Size:32.00MiB, Used:1.84MiB (5.76%)
> > > /dev/sdc1 32.00MiB
> > > /dev/sdd1 32.00MiB
> > >=20
> > > Unallocated:
> > > /dev/sdc1 4.65TiB
> > > /dev/sdd1 11.43TiB
> >=20
> > Your 20TiB system indeed have some unbalanced data.
> >=20
> > But it should be mostly fine, as your single DATA is less than 7TiB on
> > sdc1, with that combined with the unused 4.6TiB on sdc, you should be
> > able to migrate the single to RAID1.
> >=20
> > What is preventing you from converting the single to RAID1 using
> > something like:
> >=20
> > # btrfs balance start -dprofile=3DSINGLE,convert=3Draid1 <mnt>
> >=20
> > Thanks,
> > Qu
>=20
>=20
> If it doesn't get interrupted, it goes all the way until it locks up:
> Aug 31 23:37:22 skarletsky kernel: BTRFS info (device sdc1): relocating b=
lock group 199494852411392 flags metadata|raid1
> Aug 31 23:40:19 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 122 seconds.
> Aug 31 23:40:19 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:40:19 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:40:19 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:40:19 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:42:22 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 245 seconds.
> Aug 31 23:42:22 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:42:22 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:42:22 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:42:22 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:44:25 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 368 seconds.
> Aug 31 23:44:25 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:44:25 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:44:25 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:44:25 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:46:28 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 491 seconds.
> Aug 31 23:46:28 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:46:28 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:46:28 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:46:28 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:48:31 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 614 seconds.
> Aug 31 23:48:31 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:48:31 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:48:31 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:48:31 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:50:34 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 737 seconds.
> Aug 31 23:50:34 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:50:34 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:50:34 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:50:34 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:52:37 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 860 seconds.
> Aug 31 23:52:37 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:52:37 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:52:37 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:52:37 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:54:40 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 983 seconds.
> Aug 31 23:54:40 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:54:40 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:54:40 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:54:40 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:56:42 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 1105 seconds.
> Aug 31 23:56:42 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:56:42 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:56:42 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:56:42 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
> Aug 31 23:58:45 skarletsky kernel: INFO: task btrfs-transacti:1188 blocke=
d for more than 1228 seconds.
> Aug 31 23:58:45 skarletsky kernel: task:btrfs-transacti state:D stack:0 p=
id:1188 tgid:1188 ppid:2 task_flags:0x208040 flags:0x00004000
> Aug 31 23:58:45 skarletsky kernel: btrfs_commit_transaction+0x9fc/0xc50 [=
btrfs]
> Aug 31 23:58:45 skarletsky kernel: transaction_kthread+0x167/0x1d0 [btrfs=
]
> Aug 31 23:58:45 skarletsky kernel: ? __pfx_transaction_kthread+0x10/0x10 =
[btrfs]
>=20
>=20
> After I swapped the RAM, I've been slowly fixing the corruptions I run in=
to that's been interrupting its balance:
> Sep 07 06:37:11 skarletsky kernel: BTRFS info (device sdc1): found 8 exte=
nts, stage: move data extents
> Sep 07 06:37:11 skarletsky kernel: BTRFS info (device sdc1): found 8 exte=
nts, stage: update data pointers
> Sep 07 06:37:11 skarletsky kernel: BTRFS info (device sdc1): relocating b=
lock group 12421075828736 flags data
> Sep 07 06:37:22 skarletsky kernel: BTRFS info (device sdc1): found 8 exte=
nts, stage: move data extents
> Sep 07 06:37:23 skarletsky kernel: BTRFS info (device sdc1): found 8 exte=
nts, stage: update data pointers
> Sep 07 06:37:23 skarletsky kernel: BTRFS info (device sdc1): relocating b=
lock group 12420002086912 flags data
> Sep 07 06:37:34 skarletsky kernel: BTRFS info (device sdc1): found 8 exte=
nts, stage: move data extents
> Sep 07 06:37:34 skarletsky kernel: BTRFS info (device sdc1): found 8 exte=
nts, stage: update data pointers
> Sep 07 06:37:35 skarletsky kernel: BTRFS info (device sdc1): relocating b=
lock group 12418928345088 flags data
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root -9 ino 891 off 564490240 logical 12419492835328 csum 0x423ede89 exp=
ected csum 0x4d402d24 mirror 1
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): checksum =
error at logical 12419492835328 mirror 1 root 256 inode 65383 offset 110136=
1152 length 4096 links 1 (path: Videos/TV/Gilmore Girls/Season 1/Gilmore.Gi=
rls.S01E11.Paris.is.Burning.1080p.WEB-DL.x265.10bit.HEVC-MONOLITH.mkv)
> Sep 07 06:37:38 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 976, gen 0
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): csum fail=
ed root -9 ino 891 off 564490240 logical 12419492835328 csum 0x423ede89 exp=
ected csum 0x4d402d24 mirror 1
> Sep 07 06:37:38 skarletsky kernel: BTRFS warning (device sdc1): checksum =
error at logical 12419492835328 mirror 1 root 256 inode 65383 offset 110136=
1152 length 4096 links 1 (path: Videos/TV/Gilmore Girls/Season 1/Gilmore.Gi=
rls.S01E11.Paris.is.Burning.1080p.WEB-DL.x265.10bit.HEVC-MONOLITH.mkv)
> Sep 07 06:37:38 skarletsky kernel: BTRFS error (device sdc1): bdev /dev/s=
dc1 errs: wr 0, rd 0, flush 0, corrupt 977, gen 0
> Sep 07 06:37:41 skarletsky kernel: BTRFS info (device sdc1): balance: end=
ed with status: -5
>=20
> I'm currently running --repair on it, and thankfully, I have a backup.
>=20
> > > $ sudo btrfs filesystem usage /mnt/disks/disk-12TB
> > > Overall:
> > > Device size: 21.56TiB
> > > Device allocated: 10.58TiB
> > > Device unallocated: 10.98TiB
> > > Device missing: 0.00B
> > > Device slack: 276.00GiB
> > > Used: 10.34TiB
> > > Free (estimated): 5.61TiB (min: 5.61TiB)
> > > Free (statfs, df): 5.47TiB
> > > Data ratio: 2.00
> > > Metadata ratio: 2.00
> > > Global reserve: 512.00MiB (used: 0.00B)
> > > Multiple profiles: no
> > >=20
> > > Data,RAID1: Size:5.28TiB, Used:5.17TiB (97.77%)
> > > /dev/sdb1 5.28TiB
> > > /dev/sda1 5.28TiB
> > >=20
> > > Metadata,RAID1: Size:7.00GiB, Used:6.18GiB (88.36%)
> > > /dev/sdb1 7.00GiB
> > > /dev/sda1 7.00GiB
> > >=20
> > > System,RAID1: Size:64.00MiB, Used:800.00KiB (1.22%)
> > > /dev/sdb1 64.00MiB
> > > /dev/sda1 64.00MiB
> > >=20
> > > Unallocated:
> > > /dev/sdb1 5.35TiB
> > > /dev/sda1 5.62TiB
> > >=20
> > > > > Would I have to redo this if COW is broken?
> > > >=20
> > > > Mostly yes.
> > >=20
> > > Bummer :-(
> > >=20
> > > > Thanks,
> > > > Qu
> > > >=20
> > > > > P.S. resending because I accidentally used regular "reply". Sorry=
.
> > > > >=20
> > > > > It also just finished scrubbing my 12TB RAID 1 array, and it abor=
ted :-(
> > > > >=20
> > > > > Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): par=
ent transid verify failed on logical 54114557984768 mirror 1 wanted 1250553=
 found 1250557
> > > > > Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): par=
ent transid verify failed on logical 54114557984768 mirror 2 wanted 1250553=
 found 1250557
> > > > >=20
> > > > > $ sudo btrfs filesystem df /mnt/disks/disk-12TB
> > > > > Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
> > > > > System, RAID1: total=3D64.00MiB, used=3D800.00KiB
> > > > > Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
> > > > > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> > > > >=20
> > > > > $ sudo btrfs scrub status /dev/sda1
> > > > > UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
> > > > > Scrub resumed: Fri Sep 5 03:16:31 2025
> > > > > Status: aborted
> > > > > Duration: 5:33:42
> > > > > Total to scrub: 10.34TiB
> > > > > Rate: 182.62MiB/s
> > > > > Error summary: no errors found
> > > > >=20
> > > > > $ sudo btrfs scrub status /dev/sdb1
> > > > > UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
> > > > > Scrub resumed: Fri Sep 5 03:16:31 2025
> > > > > Status: aborted
> > > > > Duration: 6:05:48
> > > > > Total to scrub: 10.34TiB
> > > > > Rate: 200.25MiB/s
> > > > > Error summary: no errors found

