Return-Path: <linux-btrfs+bounces-16686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E92B468B9
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 05:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECE57B986E
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 03:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3824A04D;
	Sat,  6 Sep 2025 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Wj52+l48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352C27707
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Sep 2025 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757131127; cv=none; b=YY59rqE56IKIMUt0curdN30Z9dwNnnxpEqGZIChBpafNEYwfPe0vGML/Y7mQeRqk3+F1hNWn8D8GhUpclXROeTKdYfDNm7YG6KKL9r04fD0mUAKqZM0pgGRNXaH7Rbda25pdsCtdvKW+rGJzqj1zsluMdB0qyaWO8kOMeVbLTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757131127; c=relaxed/simple;
	bh=fXsWrbNU7FqGxYiKCpO+bt+hAztk1mWotAOFctCUayE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuG39gyuptQs0SpKzFIf0nsKwm0V+YzCH2wuJt2x3vV89VfZ5tysM/3BFxogWaaHUcwx5f+a7CLrgcMLfNDnjUkfAfQI7LycP1yeaPWWeC0A0fuhn1fxNdBIZaamNHmThmHATWRLgEWppCt4N/9eiznYaIX1bN+0oY2QqQvFSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Wj52+l48; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=cxm25q53i5fkdgolxrlhpnbadu.protonmail; t=1757131115; x=1757390315;
	bh=E8Q4g7XgEZ17L47eskBTyM3ZobsXi2cSkmHK/+IOpbE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wj52+l48lyj3IDKsgFmjSXetQt1a/MlrYKSVnbnNDjN0H2BbB6ZNCT0BVGQyKwROS
	 KheoJdql7eVkzpT24ZrO1qmr/aojgxupa6rxiXOQVNRqVzptcS5evuDvicJ0efg7vc
	 9WcpxhngCx5b9gDByBLdBmX2K9dwEQlThsu3sJuq8KtiT1MPOgQ5R2GZhEH29Sw8kw
	 B2aV+zN6Lgku3VJXx2uFEfETwM4sE9XgMWOB2iHCax/BX5i1IoYrPHsev6UqF/xDMN
	 porbH4LihbXFlnbRYqQC8yNVf85VeBLCIGZtDkWlwJ24ShpIMG9mUeNju2OuCpwbLe
	 UhPPXbV+7PoVw==
Date: Sat, 06 Sep 2025 03:58:29 +0000
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
From: jonas.timothy@proton.me
Cc: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs RAID 1 mounting as R/O
Message-ID: <xrsGddBl1hq0FSjKaqFM8275iii6WNju5hyl2wU8I9J7f2q3C11Dhsqgn-ANIXJRP-NMf4jioFdthalcpZn7YjKb0KAE7YBYxiGSA6g41Z4=@proton.me>
In-Reply-To: <595fb33e-a3e8-46cc-80ff-e50c2a70bffd@gmx.com>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me> <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com> <h5sKXFIVsnBPX0i1K8jnrgzAQu2oE-NMORKYVaNPyp-FnKaQN032HGmejwSQl8KIbtpMj-37pFT3KDrbn_xmrdzqNVzjzIw-9YU6s8DW0mA=@proton.me> <595fb33e-a3e8-46cc-80ff-e50c2a70bffd@gmx.com>
Feedback-ID: 94251912:user:proton
X-Pm-Message-ID: e6c11cfcd3305b10020eca4e21a498873f3b3261
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






Sent with Proton Mail secure email.

On Friday, September 5th, 2025 at 6:12 PM, Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:

>=20
> =E5=9C=A8 2025/9/5 19:34, jonas.timothy@proton.me =E5=86=99=E9=81=93:
> [...]
>=20
> > Hi Qu,
> >=20
> > I currently have 2 profiles because I have 2 sets of disks:
> >=20
> > $ sudo btrfs filesystem df /mnt/disks/disk-12TB
> > Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
> > System, RAID1: total=3D64.00MiB, used=3D800.00KiB
> > Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
>=20
> So this means this fs is more or less corrupted, recommended to salvage
> the data first, then either re-format the fs or try `btrfs check --repair=
` (which may not always repair the fs).
>=20
> > $ sudo btrfs filesystem df /mnt/disks/disk-20TB
> > Data, single: total=3D6.79TiB, used=3D6.75TiB
> > Data, RAID1: total=3D6.74TiB, used=3D6.71TiB
> > System, RAID1: total=3D32.00MiB, used=3D1.84MiB
> > Metadata, RAID1: total=3D14.00GiB, used=3D13.85GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> > WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
> > WARNING: Data: single, raid1
> >=20
> > the one that went R/O is the 12TB pair, but the 20TB currently is havin=
g trouble finishing setting up RAID 1.
>=20
>=20
> `btrfs fi usage` output please for the 20T fs.
>=20
> My guess is, you're mixing different sized disks in that 20T array.
> And you're using RAID1 with 2 disks, the usage won't balance that well
> among just 2 disks.

I'm attaching both of them.  I don't know if I should've done this differen=
tly, but I originally "muscled" it through when both were just stopping on =
their own by removing the file they mentioned can't be fixed by cutting it =
out of the drive, then placing it back in the drive.

$ sudo btrfs filesystem usage /mnt/disks/disk-20TB=20
Overall:
    Device size:                  36.38TiB
    Device allocated:             20.30TiB
    Device unallocated:           16.08TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         20.20TiB
    Free (estimated):             10.80TiB      (min: 8.10TiB)
    Free (statfs, df):             4.68TiB
    Data ratio:                       1.50
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                 yes      (data)

Data,single: Size:6.79TiB, Used:6.75TiB (99.51%)
   /dev/sdc1       6.79TiB

Data,RAID1: Size:6.74TiB, Used:6.71TiB (99.53%)
   /dev/sdc1       6.74TiB
   /dev/sdd1       6.74TiB

Metadata,RAID1: Size:14.00GiB, Used:13.85GiB (98.95%)
   /dev/sdc1      14.00GiB
   /dev/sdd1      14.00GiB

System,RAID1: Size:32.00MiB, Used:1.84MiB (5.76%)
   /dev/sdc1      32.00MiB
   /dev/sdd1      32.00MiB

Unallocated:
   /dev/sdc1       4.65TiB
   /dev/sdd1      11.43TiB


$ sudo btrfs filesystem usage /mnt/disks/disk-12TB=20
Overall:
    Device size:                  21.56TiB
    Device allocated:             10.58TiB
    Device unallocated:           10.98TiB
    Device missing:                  0.00B
    Device slack:                276.00GiB
    Used:                         10.34TiB
    Free (estimated):              5.61TiB      (min: 5.61TiB)
    Free (statfs, df):             5.47TiB
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,RAID1: Size:5.28TiB, Used:5.17TiB (97.77%)
   /dev/sdb1       5.28TiB
   /dev/sda1       5.28TiB

Metadata,RAID1: Size:7.00GiB, Used:6.18GiB (88.36%)
   /dev/sdb1       7.00GiB
   /dev/sda1       7.00GiB

System,RAID1: Size:64.00MiB, Used:800.00KiB (1.22%)
   /dev/sdb1      64.00MiB
   /dev/sda1      64.00MiB

Unallocated:
   /dev/sdb1       5.35TiB
   /dev/sda1       5.62TiB


>=20
> > Would I have to redo this if COW is broken?
>=20
>=20
> Mostly yes.

Bummer :-(
>=20
> Thanks,
> Qu
>=20
> > P.S. resending because I accidentally used regular "reply". Sorry.
> >=20
> > It also just finished scrubbing my 12TB RAID 1 array, and it aborted :-=
(
> >=20
> > Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent tr=
ansid verify failed on logical 54114557984768 mirror 1 wanted 1250553 found=
 1250557
> > Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent tr=
ansid verify failed on logical 54114557984768 mirror 2 wanted 1250553 found=
 1250557
> >=20
> > $ sudo btrfs filesystem df /mnt/disks/disk-12TB
> > Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
> > System, RAID1: total=3D64.00MiB, used=3D800.00KiB
> > Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >=20
> > $ sudo btrfs scrub status /dev/sda1
> > UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
> > Scrub resumed: Fri Sep 5 03:16:31 2025
> > Status: aborted
> > Duration: 5:33:42
> > Total to scrub: 10.34TiB
> > Rate: 182.62MiB/s
> > Error summary: no errors found
> >=20
> > $ sudo btrfs scrub status /dev/sdb1
> > UUID: 8641eeeb-ddf0-47af-8ed0-254327dcc050
> > Scrub resumed: Fri Sep 5 03:16:31 2025
> > Status: aborted
> > Duration: 6:05:48
> > Total to scrub: 10.34TiB
> > Rate: 200.25MiB/s
> > Error summary: no errors found

