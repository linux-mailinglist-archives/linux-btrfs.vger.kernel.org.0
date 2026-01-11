Return-Path: <linux-btrfs+bounces-20374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE02D0E87A
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F5EC30090B8
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC712222C0;
	Sun, 11 Jan 2026 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UqJ6+qVf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76316500948
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768125813; cv=none; b=WcWJFxTERlUv97kBorpAo+27GfS3lZ/cmUjg3YhoEMptb1XsgrgWRWuIoLFTwMomoXlwPmYnUE1Ag1nsQZKOne9FwpeFQkF4PiWamqwHoCBf61gDLal9uQ8FRGqvdXsGIjAle5O5B0lLDuWF08v+s/FcgEc+kkF33PPiWEV2DAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768125813; c=relaxed/simple;
	bh=pFIaYpRRPMjjtN4Tig5hPfgB0o4f7i4NjpC93QcNfKE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=faVzGBeTDZ077KJ712j0/V4pW1zKvxN9DOkXJjtOfmMWmIBfe5HuwBfNJegSItQE28NlXVwPf32+pSVOoTclEiO9lsOtSsJtFw16Va/osodOG7u2SiN6FhVwjlbWZAJ8FbhPEZV6WbWW1GmYwq5FcLiTjsagKmekA/9PsIcCleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UqJ6+qVf; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1768125802; x=1768385002;
	bh=pFIaYpRRPMjjtN4Tig5hPfgB0o4f7i4NjpC93QcNfKE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UqJ6+qVfGazGF7erFkeZKnZe9acly3dn0qmCZJlSBRxQ8PmeoFTc7PTiyMpzbbztk
	 xdPqqX+7FgN0/c7ClGFpfSbCWA/zKRnCABw8u6gL3u0lOO4Apk7mMMjlRSlpgVrSl/
	 inMB06bDhfYQfrmezIUliNePHhXMJU1aC70PBA/8OO92sG8dGsh06aEbtM8sMIeUpr
	 gvudbxJnq6dcRyMYgM8UpkjI+TC/c6dK6sglsqwBJQtES9DNc1WJfbmng+shpcchYX
	 Y4aoWmGsIA7LUGk6XMLvxQxisexZCRsZFpykqCNywxPUefgeoNNWnjnT8DD1VbrcZA
	 x/N78GLFnfEBw==
Date: Sun, 11 Jan 2026 10:03:17 +0000
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From: jollycar <jollycar@proton.me>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
Message-ID: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me>
Feedback-ID: 175904438:user:proton
X-Pm-Message-ID: d5830a78e20cd011b57234af969d4d377238880c
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

#regzbot introduced: v6.12..v6.18

[1.] One line summary of the problem:
VirtualBox VM crashes with BSOD during Windows installation on kernels 6.18=
+ (works fine on 6.12 LTS)

[2.] Full description of the problem:
Windows 10 and Windows 11 installation inside VirtualBox consistently crash=
es with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.19-rc3. The s=
ame VirtualBox configuration and VM image work perfectly on kernel 6.12 LTS=
. The BSOD errors vary each time (most recent: 0x80070470 - "file may be co=
rrupt or missing"). The host system remains completely stable with no logge=
d errors.

[3] Kernel & Hardware:
=C2=A0 =C2=A0- Kernel versions tested:
=C2=A0 =C2=A0 =C2=A0* Working: 6.12.63-1
=C2=A0 =C2=A0 =C2=A0* Broken: 6.18.3-2, 6.19.0-rc3-1
=C2=A0 =C2=A0- Distribution: Manjaro Linux
=C2=A0 =C2=A0- Architecture: x86_64
=C2=A0 =C2=A0- VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJAR=
O SMP preempt mod_unload)

[4.] Filesystem and storage:
=C2=A0 =C2=A0- Root filesystem: btrfs on LUKS encryption
=C2=A0 =C2=A0- Mount options: zstd compression level 3, SSD optimizations, =
async discard, free space tree
=C2=A0 =C2=A0- VM storage: separate btrfs subvolume
=C2=A0 =C2=A0- btrfs device stats: all zeros (no errors)

[5.] Reproduction:
- Boot kernel 6.18.3-2 or 6.19.0-rc3
- Start VirtualBox 7.2.4 r170995
- Create new Windows 10 or Windows 11 VM
- Begin OS installation
- BSOD occurs within 1-3 minutes with varying errors (latest: 0x80070470)
- Issue is 100% reproducible on 6.18+, never occurs on 6.12

Additional context:
- Host system remains completely stable during VM crashes
- No btrfs errors in dmesg or device stats (all zero)
- Issue persists across multiple 6.18/6.19 releases over one month
- VirtualBox 7.2.4 modules load successfully on all kernel versions

Regards,
Jollycar

