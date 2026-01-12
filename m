Return-Path: <linux-btrfs+bounces-20409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FED13B27
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D4213004CE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4AC35E527;
	Mon, 12 Jan 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OeVg+8UV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A342EAD16;
	Mon, 12 Jan 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232022; cv=none; b=BDnowRdl97W4kL8mcp/LQ0k7Q1za7/50hnbKKn2BOAcLprjgv/cMGBPmTcv7BbvnitUid1QIzJDDJ30ox51zwpFYWvSesxFCaKJHICoFnRZe5IOUc2SNURaxqy0xe71OcZ7Z0hwqpx6JQOISbq59xz8qgLep0kCzyQSt9PvP8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232022; c=relaxed/simple;
	bh=UC2rjDugE9v89Gc9Zvti3z5Rgit0aFf8ZfVdenpunNg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUIa1kYTxb3uSvTWaOQe36KDBRo8IBQXksnEukEQsrI4uQe4n3RPCJp4iAdRF8KzAadJ79lM8nfrH5rBf1x21hZRqzNV5cb1b6ZRGXeKX1zKGBGT9TdOffp6twgtgeP6sxF/oH8Knvi5fKkO5cHc05HUgjO6hyOrVjCxmUf77eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=fail smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OeVg+8UV; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mbnpruwjbverxciloz7mu3lcqq.protonmail; t=1768231999; x=1768491199;
	bh=UC2rjDugE9v89Gc9Zvti3z5Rgit0aFf8ZfVdenpunNg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OeVg+8UVM3D3e1TOvMdbwEUX2/Zu2h7LP5Kp4z2F6+XJ74KCj9a0O3Laj1wnVVnvW
	 npVcuIdIj60lCwUITlTN1JsYeyEFLtyOfgPLe4i1bh1no6jULCgjGpFQCEV18sWc6R
	 lh/fUQ/NU/ToZBsjtWxeb8YTYzG+2MH2KoVXucZ6cpdtgilZwedy6jL/PmobniSvGU
	 UyvqOHu8Uk71N3c/Dtq7MBecGK2F/x6Dc0eSUMJMTIAhv+Y+jQp11JR6eUYlX9oj/j
	 zc1eV85bgJbmaBx4QuzMx8bi8rEB/AJ2fbVJaiwGFYLYw81e8TwR+YIepuDG5AlDVr
	 xHgvkvh5ruFvQ==
Date: Mon, 12 Jan 2026 15:33:14 +0000
To: Qu Wenruo <wqu@suse.com>
From: jollycar <jollycar@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
Message-ID: <FmCqd98aDZ5GTLc-1FUc4NRHRhDEDUDy1ylzO4rrFy_mV1zgC2tnmht5ov8px3ME3pBa6dioALVRD_tDKC3FhdUd4alND6G5g2bx8N7R154=@proton.me>
In-Reply-To: <20c3ba51-fbf1-4de2-b88f-5edf817a24d6@suse.com>
References: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me> <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com> <LCM3zm3y1s51pkWBZg6NU-4R6f89SVYSAxtNqq0gM5IlDFZfFjwSqvl-8yAvYcl7VizHjXIENm1vf6b7z2e25YQce7IQCr3Ms-w6vKkOKfY=@proton.me> <20c3ba51-fbf1-4de2-b88f-5edf817a24d6@suse.com>
Feedback-ID: 175904438:user:proton
X-Pm-Message-ID: c832a120c01de0670311cc664a540bd406d036ec
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qemu/libvirt test results on kernel 6.18.3:

Setup:
- Virtualization: qemu via libvirt (virt-manager)
- Disk format: qcow2
- Disk location: /data/virtual-os/win10-qemu-test.qcow2 (same btrfs subvolu=
me as VirtualBox VMs)
- COW disabled on disk image (chattr +C)
- ISO: Same Windows 10 ISO used in VirtualBox tests
- Guest: Windows 10

Result:
Windows 10 installation completed successfully without any crashes. Install=
ation proceeded through all phases including multiple reboots and reached t=
he desktop without issues.

Summary of all tests on kernel 6.18.3:
- VirtualBox 7.2.4: Crashes during installation (all cache/mtype configurat=
ions tested)
- Qemu via libvirt: No crashes, installation completes successfully

Both using the same btrfs filesystem, same subvolume location, same Windows=
 ISO, and COW disabled.


On Sunday, January 11th, 2026 at 8:43 PM, Qu Wenruo <wqu@suse.com> wrote:

>=20
>=20
>=20
>=20
> =E5=9C=A8 2026/1/11 21:39, jollycar =E5=86=99=E9=81=93:
>=20
> > Storage configuration details:
> >=20
> > Storage format: VDI (VirtualBox Disk Image)
> > Storage location: /data/virtual-os/ (btrfs subvolume with COW disabled,=
 verified with lsattr)
>=20
>=20
> OK, this means it's not related to the direct IO changes in newer kernels=
.
>=20
> When COW is disabled, data checksum is also disables, thus direct IO is
> still doing the true zero-copy behavior.
>=20
> This ruled out the btrfs direct io change, but this means I have no clue
> what is going wrong at all now.
>=20
> > Controller: IntelAhci (SATA)
> > Default configuration: hostiocache on, mtype normal
> >=20
> > Cache and media type testing on kernel 6.18.3:
> > - Default (hostiocache on, mtype normal): BSOD within 1 minute during i=
nstallation
> > - mtype writethrough: Gets much further, BSOD occurs on first VM reboot
> > - hostiocache off (mtype normal): Gets much further, BSOD occurs on fir=
st VM reboot
> >=20
> > None of the configurations provide a working solution - they only delay=
 the crash.
> >=20
> > On kernel 6.12.63 with default settings (hostiocache on, mtype normal),=
 Windows installation completes successfully without any crashes.
> >=20
> > I have not yet tested with qemu/libvirt. Should I proceed with that tes=
t?
>=20
>=20
> Yes please. Libvirt/qemu is a more common solution among developers.
> If you can reproduce it using libvirt/qemu, more btrfs developers can
> try to reproduce it and look into it.
>=20
> And if not, the cause may shift towards vbox other than btrfs.
>=20
> Thanks,
> Qu
>=20
> > On Sunday, January 11th, 2026 at 10:15 AM, Qu Wenruo wqu@suse.com wrote=
:
> >=20
> > > =E5=9C=A8 2026/1/11 20:33, jollycar =E5=86=99=E9=81=93:
> > >=20
> > > > #regzbot introduced: v6.12..v6.18
> > > >=20
> > > > [1.] One line summary of the problem:
> > > > VirtualBox VM crashes with BSOD during Windows installation on kern=
els 6.18+ (works fine on 6.12 LTS)
> > > >=20
> > > > [2.] Full description of the problem:
> > > > Windows 10 and Windows 11 installation inside VirtualBox consistent=
ly crashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.19-rc=
3. The same VirtualBox configuration and VM image work perfectly on kernel =
6.12 LTS. The BSOD errors vary each time (most recent: 0x80070470 - "file m=
ay be corrupt or missing"). The host system remains completely stable with =
no logged errors.
> > > >=20
> > > > [3] Kernel & Hardware:
> > > > - Kernel versions tested:
> > > > * Working: 6.12.63-1
> > > > * Broken: 6.18.3-2, 6.19.0-rc3-1
> > > > - Distribution: Manjaro Linux
> > > > - Architecture: x86_64
> > > > - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJARO SMP=
 preempt mod_unload)
> > > >=20
> > > > [4.] Filesystem and storage:
> > > > - Root filesystem: btrfs on LUKS encryption
> > > > - Mount options: zstd compression level 3, SSD optimizations, async=
 discard, free space tree
> > > > - VM storage: separate btrfs subvolume
> > >=20
> > > What's the storage file configuration? Like what's the cache mode set=
ting?
> > > I don't know VBox at all, but there may be something similar to
> > > libvirt's cache mode (none/unsafe/writethrough etc).
> > >=20
> > > More importantly, will tweaking the cache mode change fix the broken
> > > kernels?
> > > If so it may point to direct IO related behavior changes.
> > >=20
> > > And what's the storage file format? QCOW2? RAW? Or whatever format
> > > provided by Vbox?
> > >=20
> > > And one final question, have you tried qemu (or libvirt + qemu) and c=
an
> > > it still be reproduced with qemu?
> > > As I'm wondering if the direct IO related change will even affects qe=
mu
> > >=20
> > > Thanks,
> > > Qu
> > >=20
> > > > - btrfs device stats: all zeros (no errors)
> > > >=20
> > > > [5.] Reproduction:
> > > > - Boot kernel 6.18.3-2 or 6.19.0-rc3
> > > > - Start VirtualBox 7.2.4 r170995
> > > > - Create new Windows 10 or Windows 11 VM
> > > > - Begin OS installation
> > > > - BSOD occurs within 1-3 minutes with varying errors (latest: 0x800=
70470)
> > > > - Issue is 100% reproducible on 6.18+, never occurs on 6.12
> > > >=20
> > > > Additional context:
> > > > - Host system remains completely stable during VM crashes
> > > > - No btrfs errors in dmesg or device stats (all zero)
> > > > - Issue persists across multiple 6.18/6.19 releases over one month
> > > > - VirtualBox 7.2.4 modules load successfully on all kernel versions
> > > >=20
> > > > Regards,
> > > > Jollycar

