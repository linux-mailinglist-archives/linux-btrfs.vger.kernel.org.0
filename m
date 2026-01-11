Return-Path: <linux-btrfs+bounces-20376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B5D0EA94
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C549C30031BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB7330670;
	Sun, 11 Jan 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cLBsQ0ZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B80227E95;
	Sun, 11 Jan 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768129811; cv=none; b=rzHzQcVYSyujwQcOne5CclQSkmyadiX2W08ApkbLNcntsbypxIUVhebNwSrp/S2aF0QOX7xqkt2g0kUACQmJ7MajGDycK8xttNvVuzjrwprfGJAvknrbzOvPZq9MejT+Zk/MInKaLPlu1liyL80fNVxNJ7TkqS5VSvUP7T9Xjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768129811; c=relaxed/simple;
	bh=yKYF0bZ1DLZKvlSDBugumpJoYx2l2RkLx5wMTV/RV8M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sldh8wwesdkQ/2kU4KkAEz8zR5j/trjVVYNy+WI7EdnyTNt3ChkHe9LMiroa45yPJk1T8qvS55GldGREV7PKWiVRywb1I6ulbEVFlIgNiOv1pxpqiC+PQB/QqRNubKMmfj7GTlogib3XZVGxZfHqWOV5CD1lIUY2rmCfNp/1GG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cLBsQ0ZY; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1768129804; x=1768389004;
	bh=yKYF0bZ1DLZKvlSDBugumpJoYx2l2RkLx5wMTV/RV8M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cLBsQ0ZYUb4gl+zJTStLrBD8EPeo9KdSwtDhnFziQruzdRj1INkNH9zsuCYkIn3vi
	 hkUwx+FmqmQYOPaB7b+S3gdmi+QG10G55+oddEPgpjnXvx7H+AkQE6szFea8vXVIdV
	 Bdip6OikMlxDiUkrh0r6Oeu3NemM/SNAfRxg+wafYJaBeyBeJVxcoXOQKt6pWlnn69
	 NqtAsOBP5/HmrJwIdhu9KXvBSMsCF4JmrYA3B24RpX+xRwoxuAd0vOa+tx/7hPMvBo
	 vsaSjjOpW7xs9V17lqIWyzx2pAzUtgnmGY2Nr7vyKXW/4eL65+He86X8zZ3kjz3k4e
	 72zFq+PDif8Uw==
Date: Sun, 11 Jan 2026 11:09:59 +0000
To: Qu Wenruo <wqu@suse.com>
From: jollycar <jollycar@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
Message-ID: <LCM3zm3y1s51pkWBZg6NU-4R6f89SVYSAxtNqq0gM5IlDFZfFjwSqvl-8yAvYcl7VizHjXIENm1vf6b7z2e25YQce7IQCr3Ms-w6vKkOKfY=@proton.me>
In-Reply-To: <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com>
References: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me> <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com>
Feedback-ID: 175904438:user:proton
X-Pm-Message-ID: 195927f674aaa808e1b47b8cd1f8e101a2ed93c4
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Storage configuration details:

Storage format: VDI (VirtualBox Disk Image)
Storage location: /data/virtual-os/ (btrfs subvolume with COW disabled, ver=
ified with lsattr)
Controller: IntelAhci (SATA)
Default configuration: hostiocache on, mtype normal

Cache and media type testing on kernel 6.18.3:
- Default (hostiocache on, mtype normal): BSOD within 1 minute during insta=
llation
- mtype writethrough: Gets much further, BSOD occurs on first VM reboot
- hostiocache off (mtype normal): Gets much further, BSOD occurs on first V=
M reboot

None of the configurations provide a working solution - they only delay the=
 crash.

On kernel 6.12.63 with default settings (hostiocache on, mtype normal), Win=
dows installation completes successfully without any crashes.

I have not yet tested with qemu/libvirt. Should I proceed with that test?


On Sunday, January 11th, 2026 at 10:15 AM, Qu Wenruo <wqu@suse.com> wrote:

>=20
>=20
>=20
>=20
> =E5=9C=A8 2026/1/11 20:33, jollycar =E5=86=99=E9=81=93:
>=20
> > #regzbot introduced: v6.12..v6.18
> >=20
> > [1.] One line summary of the problem:
> > VirtualBox VM crashes with BSOD during Windows installation on kernels =
6.18+ (works fine on 6.12 LTS)
> >=20
> > [2.] Full description of the problem:
> > Windows 10 and Windows 11 installation inside VirtualBox consistently c=
rashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.19-rc3. T=
he same VirtualBox configuration and VM image work perfectly on kernel 6.12=
 LTS. The BSOD errors vary each time (most recent: 0x80070470 - "file may b=
e corrupt or missing"). The host system remains completely stable with no l=
ogged errors.
> >=20
> > [3] Kernel & Hardware:
> > - Kernel versions tested:
> > * Working: 6.12.63-1
> > * Broken: 6.18.3-2, 6.19.0-rc3-1
> > - Distribution: Manjaro Linux
> > - Architecture: x86_64
> > - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJARO SMP pre=
empt mod_unload)
> >=20
> > [4.] Filesystem and storage:
> > - Root filesystem: btrfs on LUKS encryption
> > - Mount options: zstd compression level 3, SSD optimizations, async dis=
card, free space tree
> > - VM storage: separate btrfs subvolume
>=20
>=20
> What's the storage file configuration? Like what's the cache mode setting=
?
> I don't know VBox at all, but there may be something similar to
> libvirt's cache mode (none/unsafe/writethrough etc).
>=20
> More importantly, will tweaking the cache mode change fix the broken
> kernels?
> If so it may point to direct IO related behavior changes.
>=20
>=20
> And what's the storage file format? QCOW2? RAW? Or whatever format
> provided by Vbox?
>=20
>=20
> And one final question, have you tried qemu (or libvirt + qemu) and can
> it still be reproduced with qemu?
> As I'm wondering if the direct IO related change will even affects qemu
>=20
> Thanks,
> Qu
>=20
> > - btrfs device stats: all zeros (no errors)
> >=20
> > [5.] Reproduction:
> > - Boot kernel 6.18.3-2 or 6.19.0-rc3
> > - Start VirtualBox 7.2.4 r170995
> > - Create new Windows 10 or Windows 11 VM
> > - Begin OS installation
> > - BSOD occurs within 1-3 minutes with varying errors (latest: 0x8007047=
0)
> > - Issue is 100% reproducible on 6.18+, never occurs on 6.12
> >=20
> > Additional context:
> > - Host system remains completely stable during VM crashes
> > - No btrfs errors in dmesg or device stats (all zero)
> > - Issue persists across multiple 6.18/6.19 releases over one month
> > - VirtualBox 7.2.4 modules load successfully on all kernel versions
> >=20
> > Regards,
> > Jollycar

