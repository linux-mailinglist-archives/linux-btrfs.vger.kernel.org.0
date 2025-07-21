Return-Path: <linux-btrfs+bounces-15612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E390B0CA5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 20:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4751C20E69
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31822BEFFA;
	Mon, 21 Jul 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="T2fofz6a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671B1DFDE
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121702; cv=none; b=S7Yj5w3NMzyHOhy7uap4uqD9VE03pbdpdTgwdph8Sp4gtW7FN065N9cItOc64wrQ6xUO4n7vM3nMppl5HlJt6ms6Mjq/x6TLmPMjZl4MLSHifuedP3s8r+I4ViMqwqksqR7CUti2NSO6SSSFXr2pJyZ/Ba5Bn+Wwb0iCWu4J/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121702; c=relaxed/simple;
	bh=arLZkkzrsad8W0pljgTb+GvxiQ/7Oa9rmjBH37q3Oks=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ohvv7wywPKE6MsnXCFZL18YJokIrkQUrXMPRxLCQOfCDeEfqCNbAjFxzNhnY+Z2O/JtDW7LOarG4jNGAOFF5eHBIalDDuPRORWmpcdGuciye5PTsylJB2uDfM7oCUbhVGGDsmNrN6IIRshsrDVuFvlIB+BothTgiRv0dTw59DsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=T2fofz6a; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753121698; x=1753380898;
	bh=arLZkkzrsad8W0pljgTb+GvxiQ/7Oa9rmjBH37q3Oks=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T2fofz6a9J0JXIj4kwW4DYXi+EF38vS4XQUO6FKtbX6RS/TCM6kYR+g/YaI/MyTUV
	 vcmewJYtGq9ktOYpfrBUzUI8a96b3AtSwRnl72lD8yy2yJ3oytsNyF+QTmtPV6M2Sf
	 doqAZZEgaj0i3XKgeJgH1FL6cEJLJ+f+EjlglRNzW2QhA2Uyk9JGu/ydCM2bXWDeEH
	 pKIljVUuAZw5BkdsG+CxxSH4KykZzDlV/hXicQK2n7J/4F6Cihe+XvnbbkRSb5QMzH
	 +qGJ9fgDAEajiquf+TbSGfWsxKY6ARfvv9kpHG6fHA69yNUEoctyDq5FydKMvSKxNE
	 7Aj/46G3TnSfw==
Date: Mon, 21 Jul 2025 18:14:53 +0000
To: Mark Harmstone <mark@harmstone.com>
From: burneddi <burneddi@protonmail.com>
Cc: Boris Burkov <boris@bur.io>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: log tree corrupted (and successfully fixed) -- anything I can do to diagnose why?
Message-ID: <Xp2CfkW7eGQWuN-pNpMByD4Bk9TnFd26Q14zPCOID8_xn7sFQZow07bTZrvw6NtjhYYKYwqgWAT8W9svId25RG2bt593y3REUkAERRG7bOQ=@protonmail.com>
In-Reply-To: <6c2dafc2-01e9-4035-84a7-c7ddace435cb@harmstone.com>
References: <lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com> <20250721154643.GA1839816@zen.localdomain> <hDedgabtauGBrte7Y8hOUixCdR-j255nc8o8sr_lYVIudj_zkd9WSRgJk1FSBYhnIwCMsbzc9ooFE1BL7VKjsLqHZasXEQpK6XQT3uH9XB0=@protonmail.com> <DBfdTFMu_U0whFCsYA-jAAzwYGCh6UYXTW-S9bd0NaFSE0LDzvNWL4Ix9JK8PZwm5tHGcFn3YdXPHSisMnDzTqDiymQCD6vDsKIcFOL7Ox8=@protonmail.com> <6c2dafc2-01e9-4035-84a7-c7ddace435cb@harmstone.com>
Feedback-ID: 41869915:user:proton
X-Pm-Message-ID: 7f9fb39e73a87d72416fcfa55d083ef994d4e6ca
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Figures I'd forget the most important thing!

It's a 512G Samsung 970 Evo Plus bought in 2020, identified as the followin=
g by lspci: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM98=
3

- Peter




On Monday, 21 July 2025 at 21:03, Mark Harmstone <mark@harmstone.com> wrote=
:

>=20
>=20
> Could you please give us the make and model of your NVMe drive, in case
> it turns out to be relevant?
>=20
> On 21/07/2025 6.41 pm, burneddi wrote:
>=20
> > Oh, and I should mention that my kernel is currently tainted due to a l=
eftover boot option (enable_guc) related to an out-of-tree i915 module (htt=
ps://github.com/strongtz/i915-sriov-dkms) -- the module itself is currently=
 inactive, but I forgot to remove the kernel options, and apparently this o=
ption is considered dangerous:
> >=20
> > [ 3.623122] Setting dangerous option enable_guc - tainting kernel
> >=20
> > I doubt it's pertinent seeing that many others seem to have had the sam=
e issue and this isn't that common of a kernel option, but surely worth men=
tioning.
> >=20
> > - Peter
> >=20
> > On Monday, 21 July 2025 at 20:34, burneddi burneddi@protonmail.com wrot=
e:
> >=20
> > > Okay, that's too bad. Unfortunately I didn't even note down the full =
dmesg; only snapped photos of the top and bottom with my phone. Here are th=
ose photos anyway, on the off chance they are of any use: https://i.imgur.c=
om/RJk0qaI.jpeg https://i.imgur.com/n6t5nGG.jpeg
> > >=20
> > > I am on kernel version 6.15.6-200.fc42.x86_64 on Fedora 42. My CPU is=
 Intel i9 12900k on a Z690 platform motherboard. Mount options: subvol=3Dsu=
bvol_root,compress=3Dzstd,x-systemd.device-timeout=3D30.
> > >=20
> > > Perhaps it's worth adding a note suggesting users collect troubleshoo=
ting information in the documentation at https://btrfs.readthedocs.io/en/la=
test/btrfs-rescue.html. This is the documentation I read to find out how to=
 fix the issue.
> > >=20
> > > Regards,
> > > Peter
> > >=20
> > > On Monday, 21 July 2025 at 18:45, Boris Burkov boris@bur.io wrote:
> > >=20
> > > > On Sun, Jul 20, 2025 at 09:19:42PM +0000, burneddi wrote:
> > > >=20
> > > > > Hi,
> > > > > My system had a hard crash today (some AMD graphics instability),=
 which resulted in the log tree on my boot drive becoming corrupt, giving m=
e the error "open_ctree failed: -2".
> > > > >=20
> > > > > I managed to fix this successfully with "btrfs-rescue zero-log", =
but now I'm wondering if I should try to diagnose and report this somehow. =
I have been running this drive with btrfs for many years and have had a fai=
r number of hard crashes during that time (AMD graphics instability...), bu=
t this is the first time the log tree has been corrupted, so I suspect it c=
ould be a kernel bug rather than an issue with my drive's firmware. I run F=
edora, so my kernel is quite new; 6.15.6 right now.
> > > > >=20
> > > > > Is there anything I should or even can do after zeroing the log t=
hat could help btrfs developers narrow the cause down?
> > > >=20
> > > > Thank you for your report, and sorry for the instability. Unfortuna=
tely,
> > > > after zeroing the log, there isn't much we can do, besides just col=
lect
> > > > basic information about your setup to try to correlate with other
> > > > reporters:
> > > >=20
> > > > stuff like
> > > > - hw architecture
> > > > - exact kver
> > > > - mount options
> > > >=20
> > > > While we're on the topic,
> > > > https://lore.kernel.org/linux-btrfs/20250718185845.GA4107167@zen.lo=
caldomain/T/#t
> > > >=20
> > > > is another thread with more reports where I mentioned the informati=
on
> > > > I'd be looking for to help debug. So if you do crash and hit it aga=
in
> > > > going forward, and are able to run btrfs check or btrfs inspect-int=
ernal
> > > > dump-tree before recovering with zero-log, that would be very helpf=
ul.
> > > >=20
> > > > Thanks,
> > > > Boris
> > > >=20
> > > > > Best regards,
> > > > > Peter Wedder

