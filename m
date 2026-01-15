Return-Path: <linux-btrfs+bounces-20595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009CDD28ACC
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 22:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F8330D5C94
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD67324707;
	Thu, 15 Jan 2026 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BnxneM77"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F242D0298
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511554; cv=none; b=M3QePWU7HgxN+oO75IFH3PQRDVQqunmNysPR2KL1tFoEfzikFHITBWXF2rh3GSN+lSAqKCUsAPeWeisdKs893hOE/UTAPw9X71+xUDyToombnrgTr8po5YMPbDj+pgQQmaLUJJcKJK9rwpwns8Crs6GY7KrDG/lnhsq04PcajQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511554; c=relaxed/simple;
	bh=gxVB9VK7JuTCkZWV7fjG76pSGm5Aw0wUvqebF3/fm6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2AVkRMslfKTngoEWlH9fnAr9zGEhjuOP+gWjFXpwRQupb7SPDP8PlVWR4AsCDjM3GE81mGLE14XKQ/uzeIquUdufQfcsWZbXm+0wH+BuU6HvlOrnOzkVdvZsqS2eQ+NOnHg4S0F5bAwkx6O4TqWmU7bB3PRE8E9woznQfVijto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BnxneM77; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1768511541; x=1768770741;
	bh=gxVB9VK7JuTCkZWV7fjG76pSGm5Aw0wUvqebF3/fm6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BnxneM77zTrEOVzH41hKUigphV51shCjN3OFaUUKZ62DgbzwbBIeGG1V9q42v15l4
	 3aYwD4hyeEd/4kjc0kRFy3naCr6lXzDTIQdmyjIPv8CuwCNvD4SKVluOVDAkr/0AHh
	 mf3qY4jBXkruvYzsuyYZ6bfp+/G0SAVEdEG+NxIqKve3Fd5ymkOo8hU1542JPZUk06
	 ID1RaeWi9t4z6rlY4wM8iA116gFj8TShlD6rMDk83ttTlLeLUbS+W8dgxe4XThBa1K
	 tm8nEjDdsT5YMxW6doRglUW/SBaeY9N2xSp1W7ubnyx5xb/8VBz18mYEcGJCIqJcbz
	 zW74j2qTYyAMg==
Date: Thu, 15 Jan 2026 21:12:17 +0000
To: Qu Wenruo <wqu@suse.com>
From: jollycar <jollycar@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
Message-ID: <X0lfIuRtAucC_QSQqThoEcvj3TAfGqQ8Cr--HLo4NpjJPtayej6Tjehlylu2EV2lANMvacCb9xRRfynobNO8DAsMTTrQXhzt6WpTOvjGFOA=@proton.me>
In-Reply-To: <5a643fd6-1b1c-45ad-86a0-5d53f074d6f7@suse.com>
References: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me> <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com> <LCM3zm3y1s51pkWBZg6NU-4R6f89SVYSAxtNqq0gM5IlDFZfFjwSqvl-8yAvYcl7VizHjXIENm1vf6b7z2e25YQce7IQCr3Ms-w6vKkOKfY=@proton.me> <20c3ba51-fbf1-4de2-b88f-5edf817a24d6@suse.com> <FmCqd98aDZ5GTLc-1FUc4NRHRhDEDUDy1ylzO4rrFy_mV1zgC2tnmht5ov8px3ME3pBa6dioALVRD_tDKC3FhdUd4alND6G5g2bx8N7R154=@proton.me> <07600bff-a6dc-4b86-9dd6-aa5077ca8b09@suse.com> <ScE5lMhg6rlV47ttw0oUEWA5IsyxChuvN1pTOoj_KNj5rUpineEqR3GsPjNZl61xtXG4QS4v9v3ur4Ac0zI5GvdGEW_gWFJBD_FazYLcd_E=@proton.me> <5a643fd6-1b1c-45ad-86a0-5d53f074d6f7@suse.com>
Feedback-ID: 175904438:user:proton
X-Pm-Message-ID: 170360ba42beea8594cb848b66efd1055325c575
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tested VirtualBox setup on ext4:

- Created new ext4 partition on different physical disk
- Cloned VM instance to ext4 location
- Copied Windows 10 ISO to ext4 partition
- Started fresh Windows 10 installation

Result: BSOD still occurs during installation on kernel 6.18.5.

Regards,
Jollycar



On Tuesday, January 13th, 2026 at 11:03 PM, Qu Wenruo <wqu@suse.com> wrote:

>=20
>=20
>=20
>=20
> =E5=9C=A8 2026/1/14 05:38, jollycar =E5=86=99=E9=81=93:
>=20
> > Thanks for the response.
> >=20
> > Module installation: DKMS via the virtualbox-host-dkms package. The dkm=
s status output confirms vboxhost/7.2.4_OSE is compiled for each kernel inc=
luding the broken ones (6.18.3, 6.18.5 (tkg), 6.19.0-rc3).
> >=20
> > Regarding CPU type specification:
> >=20
> > VirtualBox doesn't have qemu-style CPU model selection. The --cpu-profi=
le option only supports "host" (full passthrough) or ancient CPUs (8086/802=
86/80386) which don't meet Windows 10 requirements.
> >=20
> > Additional testing: I recently upgraded my desktop pc from Ryzen 9 5900=
X to 9950X3D (reusing same disks and linux install) and the regression occu=
rred identically on both CPUs. Also tested custom compiled TKG kernels (6.1=
2/6.18 with bore scheduler). The behavior matches the Manjaro kernels exact=
ly (6.12 works, 6.18 breaks).
>=20
>=20
> Thanks for the extra info, I guess the last thing we can verify is, try
> to run the same VBox setup, using disk images from an EXT4/XFS.
>=20
> And if that still failed, we're sure it's fs independent but more likely
> VBox dependent.
>=20
> Thanks,
> Qu
>=20
> > Regards,
> > Jollycar
> >=20
> > On Monday, January 12th, 2026 at 8:48 PM, Qu Wenruo wqu@suse.com wrote:
> >=20
> > > =E5=9C=A8 2026/1/13 02:03, jollycar =E5=86=99=E9=81=93:
> > >=20
> > > > Qemu/libvirt test results on kernel 6.18.3:
> > > >=20
> > > > Setup:
> > > > - Virtualization: qemu via libvirt (virt-manager)
> > > > - Disk format: qcow2
> > > > - Disk location: /data/virtual-os/win10-qemu-test.qcow2 (same btrfs=
 subvolume as VirtualBox VMs)
> > > > - COW disabled on disk image (chattr +C)
> > > > - ISO: Same Windows 10 ISO used in VirtualBox tests
> > > > - Guest: Windows 10
> > > >=20
> > > > Result:
> > > > Windows 10 installation completed successfully without any crashes.=
 Installation proceeded through all phases including multiple reboots and r=
eached the desktop without issues.
> > > >=20
> > > > Summary of all tests on kernel 6.18.3:
> > > > - VirtualBox 7.2.4: Crashes during installation (all cache/mtype co=
nfigurations tested)
> > > > - Qemu via libvirt: No crashes, installation completes successfully
> > > >=20
> > > > Both using the same btrfs filesystem, same subvolume location, same=
 Windows ISO, and COW disabled.
> > >=20
> > > Thanks a lot, this looks like there is something wrong related to the
> > > VBox out-of-tree kernel module.
> > > In that case, the btrfs community is not going to help much unfortuna=
tely.
> > >=20
> > > Mind to share how is the out-of-tree kernel module installed?
> > > The pre-compiled one from the distro? The DKMS one or something else?
> > >=20
> > > And just some guesses, can VBox specify what type of CPU (and extensi=
ons
> > > like SSE/AVX) it uses?
> > > If so (like qemu), mind to check if you can specify some CPU types
> > > without some newer extensions while still meets the minimal CPU
> > > requirement of Windows 10?
> > >=20
> > > I'm wondering if it's some extension handling not done properly, whic=
h
> > > is commonly utilized by checksums.
> > > Thus triggers the checksum mismatch errors inside Windows.
> > >=20
> > > Thanks,
> > > Qu
> > >=20
> > > > On Sunday, January 11th, 2026 at 8:43 PM, Qu Wenruo wqu@suse.com wr=
ote:
> > > >=20
> > > > > =E5=9C=A8 2026/1/11 21:39, jollycar =E5=86=99=E9=81=93:
> > > > >=20
> > > > > > Storage configuration details:
> > > > > >=20
> > > > > > Storage format: VDI (VirtualBox Disk Image)
> > > > > > Storage location: /data/virtual-os/ (btrfs subvolume with COW d=
isabled, verified with lsattr)
> > > > >=20
> > > > > OK, this means it's not related to the direct IO changes in newer=
 kernels.
> > > > >=20
> > > > > When COW is disabled, data checksum is also disables, thus direct=
 IO is
> > > > > still doing the true zero-copy behavior.
> > > > >=20
> > > > > This ruled out the btrfs direct io change, but this means I have =
no clue
> > > > > what is going wrong at all now.
> > > > >=20
> > > > > > Controller: IntelAhci (SATA)
> > > > > > Default configuration: hostiocache on, mtype normal
> > > > > >=20
> > > > > > Cache and media type testing on kernel 6.18.3:
> > > > > > - Default (hostiocache on, mtype normal): BSOD within 1 minute =
during installation
> > > > > > - mtype writethrough: Gets much further, BSOD occurs on first V=
M reboot
> > > > > > - hostiocache off (mtype normal): Gets much further, BSOD occur=
s on first VM reboot
> > > > > >=20
> > > > > > None of the configurations provide a working solution - they on=
ly delay the crash.
> > > > > >=20
> > > > > > On kernel 6.12.63 with default settings (hostiocache on, mtype =
normal), Windows installation completes successfully without any crashes.
> > > > > >=20
> > > > > > I have not yet tested with qemu/libvirt. Should I proceed with =
that test?
> > > > >=20
> > > > > Yes please. Libvirt/qemu is a more common solution among develope=
rs.
> > > > > If you can reproduce it using libvirt/qemu, more btrfs developers=
 can
> > > > > try to reproduce it and look into it.
> > > > >=20
> > > > > And if not, the cause may shift towards vbox other than btrfs.
> > > > >=20
> > > > > Thanks,
> > > > > Qu
> > > > >=20
> > > > > > On Sunday, January 11th, 2026 at 10:15 AM, Qu Wenruo wqu@suse.c=
om wrote:
> > > > > >=20
> > > > > > > =E5=9C=A8 2026/1/11 20:33, jollycar =E5=86=99=E9=81=93:
> > > > > > >=20
> > > > > > > > #regzbot introduced: v6.12..v6.18
> > > > > > > >=20
> > > > > > > > [1.] One line summary of the problem:
> > > > > > > > VirtualBox VM crashes with BSOD during Windows installation=
 on kernels 6.18+ (works fine on 6.12 LTS)
> > > > > > > >=20
> > > > > > > > [2.] Full description of the problem:
> > > > > > > > Windows 10 and Windows 11 installation inside VirtualBox co=
nsistently crashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and=
 6.19-rc3. The same VirtualBox configuration and VM image work perfectly on=
 kernel 6.12 LTS. The BSOD errors vary each time (most recent: 0x80070470 -=
 "file may be corrupt or missing"). The host system remains completely stab=
le with no logged errors.
> > > > > > > >=20
> > > > > > > > [3] Kernel & Hardware:
> > > > > > > > - Kernel versions tested:
> > > > > > > > * Working: 6.12.63-1
> > > > > > > > * Broken: 6.18.3-2, 6.19.0-rc3-1
> > > > > > > > - Distribution: Manjaro Linux
> > > > > > > > - Architecture: x86_64
> > > > > > > > - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MAN=
JARO SMP preempt mod_unload)
> > > > > > > >=20
> > > > > > > > [4.] Filesystem and storage:
> > > > > > > > - Root filesystem: btrfs on LUKS encryption
> > > > > > > > - Mount options: zstd compression level 3, SSD optimization=
s, async discard, free space tree
> > > > > > > > - VM storage: separate btrfs subvolume
> > > > > > >=20
> > > > > > > What's the storage file configuration? Like what's the cache =
mode setting?
> > > > > > > I don't know VBox at all, but there may be something similar =
to
> > > > > > > libvirt's cache mode (none/unsafe/writethrough etc).
> > > > > > >=20
> > > > > > > More importantly, will tweaking the cache mode change fix the=
 broken
> > > > > > > kernels?
> > > > > > > If so it may point to direct IO related behavior changes.
> > > > > > >=20
> > > > > > > And what's the storage file format? QCOW2? RAW? Or whatever f=
ormat
> > > > > > > provided by Vbox?
> > > > > > >=20
> > > > > > > And one final question, have you tried qemu (or libvirt + qem=
u) and can
> > > > > > > it still be reproduced with qemu?
> > > > > > > As I'm wondering if the direct IO related change will even af=
fects qemu
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > > Qu
> > > > > > >=20
> > > > > > > > - btrfs device stats: all zeros (no errors)
> > > > > > > >=20
> > > > > > > > [5.] Reproduction:
> > > > > > > > - Boot kernel 6.18.3-2 or 6.19.0-rc3
> > > > > > > > - Start VirtualBox 7.2.4 r170995
> > > > > > > > - Create new Windows 10 or Windows 11 VM
> > > > > > > > - Begin OS installation
> > > > > > > > - BSOD occurs within 1-3 minutes with varying errors (lates=
t: 0x80070470)
> > > > > > > > - Issue is 100% reproducible on 6.18+, never occurs on 6.12
> > > > > > > >=20
> > > > > > > > Additional context:
> > > > > > > > - Host system remains completely stable during VM crashes
> > > > > > > > - No btrfs errors in dmesg or device stats (all zero)
> > > > > > > > - Issue persists across multiple 6.18/6.19 releases over on=
e month
> > > > > > > > - VirtualBox 7.2.4 modules load successfully on all kernel =
versions
> > > > > > > >=20
> > > > > > > > Regards,
> > > > > > > > Jollycar

