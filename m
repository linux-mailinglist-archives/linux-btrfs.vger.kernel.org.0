Return-Path: <linux-btrfs+bounces-20463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8761D1AF6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC66309282E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12635A93E;
	Tue, 13 Jan 2026 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mwzkuzns"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F71359709
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331342; cv=none; b=SKR4QT/4hehz+TIgLuiH7e1jrWrfTbc/wajycvnTcFGA7hXUurtIIaWdRYO31/j+9yT/Va+Q00vh7tfK2TT6Oc4hitQTDzUsIGtc/5x9d+Q+wSLRd3i2Ty2GaSEucCQav9aTWsQHkXl5S9e9Zgk8GaVVZ4f2gMVOsyDjkMF4VDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331342; c=relaxed/simple;
	bh=JcM+ZUzn1ffe/j15xIZxkT3nGhTeEbgfqlLnQrEca1o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8i8/kMIfZ0WQhqKyKTvXT5Rxr/GmeCXLipdQss8VDk7NQPw0wOcZujpyRyoaVk5CtPXXyJ6DFEezVs1WgbS5e/1cMPcoN3FASurpqwVKblg77/AZ3zEBXttYEMhFRDTwKZCLVgB+raisTldmXN745lAK7kClZMkJeg+8wsgHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mwzkuzns; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1768331327; x=1768590527;
	bh=JcM+ZUzn1ffe/j15xIZxkT3nGhTeEbgfqlLnQrEca1o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mwzkuzns5g8ZZ5WS5IFrSIjZoFX3EarUEjR0b6E7oI+ezyH0M06aOfro90gPp8S7G
	 aBBYDo0Q6d/orNbBmr3v9YckXxLUeuG0RH29OgV6+nXaLT45/1t1+Cq17mlzkd1Pll
	 7S0BWWngROo3jfTLSQTIbZn2N6AQr7RDUPrkvfWyqeBU5qOLyFQgxhGmXF6Bjp4GzZ
	 l0IBhLHXXxW3/Ikt2gCpSUOZVS4ifdGJ9XvZAUZheeSfT1OSiVxfRGLCQfXRgtCGta
	 z8Y7uJ9utfcwoYC+//ic26TcutMJtXjYC95/+xk7mMDLh1EMD+PyTBB7wXZXqazvY8
	 2oTqJNIaYn5Gg==
Date: Tue, 13 Jan 2026 19:08:42 +0000
To: Qu Wenruo <wqu@suse.com>
From: jollycar <jollycar@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
Message-ID: <ScE5lMhg6rlV47ttw0oUEWA5IsyxChuvN1pTOoj_KNj5rUpineEqR3GsPjNZl61xtXG4QS4v9v3ur4Ac0zI5GvdGEW_gWFJBD_FazYLcd_E=@proton.me>
In-Reply-To: <07600bff-a6dc-4b86-9dd6-aa5077ca8b09@suse.com>
References: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me> <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com> <LCM3zm3y1s51pkWBZg6NU-4R6f89SVYSAxtNqq0gM5IlDFZfFjwSqvl-8yAvYcl7VizHjXIENm1vf6b7z2e25YQce7IQCr3Ms-w6vKkOKfY=@proton.me> <20c3ba51-fbf1-4de2-b88f-5edf817a24d6@suse.com> <FmCqd98aDZ5GTLc-1FUc4NRHRhDEDUDy1ylzO4rrFy_mV1zgC2tnmht5ov8px3ME3pBa6dioALVRD_tDKC3FhdUd4alND6G5g2bx8N7R154=@proton.me> <07600bff-a6dc-4b86-9dd6-aa5077ca8b09@suse.com>
Feedback-ID: 175904438:user:proton
X-Pm-Message-ID: 571888882e32771812090b7d612f00003cfc635a
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the response.

Module installation: DKMS via the virtualbox-host-dkms package. The dkms st=
atus output confirms vboxhost/7.2.4_OSE is compiled for each kernel includi=
ng the broken ones (6.18.3, 6.18.5 (tkg), 6.19.0-rc3).

Regarding CPU type specification:

VirtualBox doesn't have qemu-style CPU model selection. The --cpu-profile o=
ption only supports "host" (full passthrough) or ancient CPUs (8086/80286/8=
0386) which don't meet Windows 10 requirements.

Additional testing: I recently upgraded my desktop pc from Ryzen 9 5900X to=
 9950X3D (reusing same disks and linux install) and the regression occurred=
 identically on both CPUs. Also tested custom compiled TKG kernels (6.12/6.=
18 with bore scheduler). The behavior matches the Manjaro kernels exactly (=
6.12 works, 6.18 breaks).

Regards,
Jollycar

On Monday, January 12th, 2026 at 8:48 PM, Qu Wenruo <wqu@suse.com> wrote:

>=20
>=20
>=20
>=20
> =E5=9C=A8 2026/1/13 02:03, jollycar =E5=86=99=E9=81=93:
>=20
> > Qemu/libvirt test results on kernel 6.18.3:
> >=20
> > Setup:
> > - Virtualization: qemu via libvirt (virt-manager)
> > - Disk format: qcow2
> > - Disk location: /data/virtual-os/win10-qemu-test.qcow2 (same btrfs sub=
volume as VirtualBox VMs)
> > - COW disabled on disk image (chattr +C)
> > - ISO: Same Windows 10 ISO used in VirtualBox tests
> > - Guest: Windows 10
> >=20
> > Result:
> > Windows 10 installation completed successfully without any crashes. Ins=
tallation proceeded through all phases including multiple reboots and reach=
ed the desktop without issues.
> >=20
> > Summary of all tests on kernel 6.18.3:
> > - VirtualBox 7.2.4: Crashes during installation (all cache/mtype config=
urations tested)
> > - Qemu via libvirt: No crashes, installation completes successfully
> >=20
> > Both using the same btrfs filesystem, same subvolume location, same Win=
dows ISO, and COW disabled.
>=20
>=20
> Thanks a lot, this looks like there is something wrong related to the
> VBox out-of-tree kernel module.
> In that case, the btrfs community is not going to help much unfortunately=
.
>=20
> Mind to share how is the out-of-tree kernel module installed?
> The pre-compiled one from the distro? The DKMS one or something else?
>=20
>=20
> And just some guesses, can VBox specify what type of CPU (and extensions
> like SSE/AVX) it uses?
> If so (like qemu), mind to check if you can specify some CPU types
> without some newer extensions while still meets the minimal CPU
> requirement of Windows 10?
>=20
> I'm wondering if it's some extension handling not done properly, which
> is commonly utilized by checksums.
> Thus triggers the checksum mismatch errors inside Windows.
>=20
> Thanks,
> Qu
>=20
>=20
> > On Sunday, January 11th, 2026 at 8:43 PM, Qu Wenruo wqu@suse.com wrote:
> >=20
> > > =E5=9C=A8 2026/1/11 21:39, jollycar =E5=86=99=E9=81=93:
> > >=20
> > > > Storage configuration details:
> > > >=20
> > > > Storage format: VDI (VirtualBox Disk Image)
> > > > Storage location: /data/virtual-os/ (btrfs subvolume with COW disab=
led, verified with lsattr)
> > >=20
> > > OK, this means it's not related to the direct IO changes in newer ker=
nels.
> > >=20
> > > When COW is disabled, data checksum is also disables, thus direct IO =
is
> > > still doing the true zero-copy behavior.
> > >=20
> > > This ruled out the btrfs direct io change, but this means I have no c=
lue
> > > what is going wrong at all now.
> > >=20
> > > > Controller: IntelAhci (SATA)
> > > > Default configuration: hostiocache on, mtype normal
> > > >=20
> > > > Cache and media type testing on kernel 6.18.3:
> > > > - Default (hostiocache on, mtype normal): BSOD within 1 minute duri=
ng installation
> > > > - mtype writethrough: Gets much further, BSOD occurs on first VM re=
boot
> > > > - hostiocache off (mtype normal): Gets much further, BSOD occurs on=
 first VM reboot
> > > >=20
> > > > None of the configurations provide a working solution - they only d=
elay the crash.
> > > >=20
> > > > On kernel 6.12.63 with default settings (hostiocache on, mtype norm=
al), Windows installation completes successfully without any crashes.
> > > >=20
> > > > I have not yet tested with qemu/libvirt. Should I proceed with that=
 test?
> > >=20
> > > Yes please. Libvirt/qemu is a more common solution among developers.
> > > If you can reproduce it using libvirt/qemu, more btrfs developers can
> > > try to reproduce it and look into it.
> > >=20
> > > And if not, the cause may shift towards vbox other than btrfs.
> > >=20
> > > Thanks,
> > > Qu
> > >=20
> > > > On Sunday, January 11th, 2026 at 10:15 AM, Qu Wenruo wqu@suse.com w=
rote:
> > > >=20
> > > > > =E5=9C=A8 2026/1/11 20:33, jollycar =E5=86=99=E9=81=93:
> > > > >=20
> > > > > > #regzbot introduced: v6.12..v6.18
> > > > > >=20
> > > > > > [1.] One line summary of the problem:
> > > > > > VirtualBox VM crashes with BSOD during Windows installation on =
kernels 6.18+ (works fine on 6.12 LTS)
> > > > > >=20
> > > > > > [2.] Full description of the problem:
> > > > > > Windows 10 and Windows 11 installation inside VirtualBox consis=
tently crashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.1=
9-rc3. The same VirtualBox configuration and VM image work perfectly on ker=
nel 6.12 LTS. The BSOD errors vary each time (most recent: 0x80070470 - "fi=
le may be corrupt or missing"). The host system remains completely stable w=
ith no logged errors.
> > > > > >=20
> > > > > > [3] Kernel & Hardware:
> > > > > > - Kernel versions tested:
> > > > > > * Working: 6.12.63-1
> > > > > > * Broken: 6.18.3-2, 6.19.0-rc3-1
> > > > > > - Distribution: Manjaro Linux
> > > > > > - Architecture: x86_64
> > > > > > - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJARO=
 SMP preempt mod_unload)
> > > > > >=20
> > > > > > [4.] Filesystem and storage:
> > > > > > - Root filesystem: btrfs on LUKS encryption
> > > > > > - Mount options: zstd compression level 3, SSD optimizations, a=
sync discard, free space tree
> > > > > > - VM storage: separate btrfs subvolume
> > > > >=20
> > > > > What's the storage file configuration? Like what's the cache mode=
 setting?
> > > > > I don't know VBox at all, but there may be something similar to
> > > > > libvirt's cache mode (none/unsafe/writethrough etc).
> > > > >=20
> > > > > More importantly, will tweaking the cache mode change fix the bro=
ken
> > > > > kernels?
> > > > > If so it may point to direct IO related behavior changes.
> > > > >=20
> > > > > And what's the storage file format? QCOW2? RAW? Or whatever forma=
t
> > > > > provided by Vbox?
> > > > >=20
> > > > > And one final question, have you tried qemu (or libvirt + qemu) a=
nd can
> > > > > it still be reproduced with qemu?
> > > > > As I'm wondering if the direct IO related change will even affect=
s qemu
> > > > >=20
> > > > > Thanks,
> > > > > Qu
> > > > >=20
> > > > > > - btrfs device stats: all zeros (no errors)
> > > > > >=20
> > > > > > [5.] Reproduction:
> > > > > > - Boot kernel 6.18.3-2 or 6.19.0-rc3
> > > > > > - Start VirtualBox 7.2.4 r170995
> > > > > > - Create new Windows 10 or Windows 11 VM
> > > > > > - Begin OS installation
> > > > > > - BSOD occurs within 1-3 minutes with varying errors (latest: 0=
x80070470)
> > > > > > - Issue is 100% reproducible on 6.18+, never occurs on 6.12
> > > > > >=20
> > > > > > Additional context:
> > > > > > - Host system remains completely stable during VM crashes
> > > > > > - No btrfs errors in dmesg or device stats (all zero)
> > > > > > - Issue persists across multiple 6.18/6.19 releases over one mo=
nth
> > > > > > - VirtualBox 7.2.4 modules load successfully on all kernel vers=
ions
> > > > > >=20
> > > > > > Regards,
> > > > > > Jollycar

