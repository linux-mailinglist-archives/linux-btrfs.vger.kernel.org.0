Return-Path: <linux-btrfs+bounces-15608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD514B0C9E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0DD3A741C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888502E093F;
	Mon, 21 Jul 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jgL1YThm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3902874E5
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119705; cv=none; b=tpouf9PwjjQL6d4IVgNpUGDZZbln9uyp+JHaJmrmph7tTm5j05dT6vGuCnJJ7Zpl4CoYW1VWGOItA0lPJKaVDFvP76aCyGxFrdRcCXSwm5w8wFha9QbkyDWvzLYBv7bQR/+jC7mNTGcatWsVZS8IzWZnqe/0s8ifQ5tAdh+WN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119705; c=relaxed/simple;
	bh=1g9LI7+nzKzUDtdYm+YdEyMm6yHiz0uR70awueVb4rU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfC0iiLD89yqvPoIBjedRAed4tQqysmpW1GxcBO0I7BZ9SW/IWpq17W057Fi6Lub7an/gqEgV4xuTRKBK5I8Sncz2i9jTNrNqFiqYyRqoCtrq8ySoLr7gPDskC6KXT4W5sbezsafaHQ3u9OMMuw9cAee29P6f+KQ2Z+IDiTlICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=jgL1YThm; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753119701; x=1753378901;
	bh=834qlVQW2Jol4atXUhv7VsjLXOMJ/dOrVB2WkocHrbU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jgL1YThmnZqMWuB6pgyh8PbBFU1kM8jTAXp2/3fqgL+XHAQ7WSrphyWQHPcr+Gz/0
	 hIU9Yxi7UAlLLcQhbT4a8FaR8ig604/2qpuJF7gXxsr3bO9on/L2HqYIPsPjluVueB
	 +RcDoAzJIwnyH9Q/tlWiOLBe5FlPl1BFmukmV/SuYpRDMqzZZqidAMjD64baIyR1CI
	 xUKLlsvYaB4znSPFWA8hJdI9hH/Ku6g0AXQFdu7HBdw9WBR2EwcGHELqc2nLtM8x+v
	 hX5FgS4dUuBzDhZOF0kddIJ/xrGiNsYLrHFdDsKw2GTlERYHGM1/AV7nteGQZhdtH+
	 iYXiiHQcXMhyQ==
Date: Mon, 21 Jul 2025 17:41:37 +0000
To: Boris Burkov <boris@bur.io>
From: burneddi <burneddi@protonmail.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: log tree corrupted (and successfully fixed) -- anything I can do to diagnose why?
Message-ID: <DBfdTFMu_U0whFCsYA-jAAzwYGCh6UYXTW-S9bd0NaFSE0LDzvNWL4Ix9JK8PZwm5tHGcFn3YdXPHSisMnDzTqDiymQCD6vDsKIcFOL7Ox8=@protonmail.com>
In-Reply-To: <hDedgabtauGBrte7Y8hOUixCdR-j255nc8o8sr_lYVIudj_zkd9WSRgJk1FSBYhnIwCMsbzc9ooFE1BL7VKjsLqHZasXEQpK6XQT3uH9XB0=@protonmail.com>
References: <lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com> <20250721154643.GA1839816@zen.localdomain> <hDedgabtauGBrte7Y8hOUixCdR-j255nc8o8sr_lYVIudj_zkd9WSRgJk1FSBYhnIwCMsbzc9ooFE1BL7VKjsLqHZasXEQpK6XQT3uH9XB0=@protonmail.com>
Feedback-ID: 41869915:user:proton
X-Pm-Message-ID: b28532af980c74edf6d511ebf2201bd5ab25a500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oh, and I should mention that my kernel is currently tainted due to a lefto=
ver boot option (enable_guc) related to an out-of-tree i915 module (https:/=
/github.com/strongtz/i915-sriov-dkms) -- the module itself is currently ina=
ctive, but I forgot to remove the kernel options, and apparently this optio=
n is considered dangerous:

[    3.623122] Setting dangerous option enable_guc - tainting kernel

I doubt it's pertinent seeing that many others seem to have had the same is=
sue and this isn't that common of a kernel option, but surely worth mention=
ing.

- Peter



On Monday, 21 July 2025 at 20:34, burneddi <burneddi@protonmail.com> wrote:

>=20
>=20
> Okay, that's too bad. Unfortunately I didn't even note down the full dmes=
g; only snapped photos of the top and bottom with my phone. Here are those =
photos anyway, on the off chance they are of any use: https://i.imgur.com/R=
Jk0qaI.jpeg https://i.imgur.com/n6t5nGG.jpeg
>=20
> I am on kernel version 6.15.6-200.fc42.x86_64 on Fedora 42. My CPU is Int=
el i9 12900k on a Z690 platform motherboard. Mount options: subvol=3Dsubvol=
_root,compress=3Dzstd,x-systemd.device-timeout=3D30.
>=20
> Perhaps it's worth adding a note suggesting users collect troubleshooting=
 information in the documentation at https://btrfs.readthedocs.io/en/latest=
/btrfs-rescue.html. This is the documentation I read to find out how to fix=
 the issue.
>=20
> Regards,
> Peter
>=20
>=20
> On Monday, 21 July 2025 at 18:45, Boris Burkov boris@bur.io wrote:
>=20
> > On Sun, Jul 20, 2025 at 09:19:42PM +0000, burneddi wrote:
> >=20
> > > Hi,
> > > My system had a hard crash today (some AMD graphics instability), whi=
ch resulted in the log tree on my boot drive becoming corrupt, giving me th=
e error "open_ctree failed: -2".
> > >=20
> > > I managed to fix this successfully with "btrfs-rescue zero-log", but =
now I'm wondering if I should try to diagnose and report this somehow. I ha=
ve been running this drive with btrfs for many years and have had a fair nu=
mber of hard crashes during that time (AMD graphics instability...), but th=
is is the first time the log tree has been corrupted, so I suspect it could=
 be a kernel bug rather than an issue with my drive's firmware. I run Fedor=
a, so my kernel is quite new; 6.15.6 right now.
> > >=20
> > > Is there anything I should or even can do after zeroing the log that =
could help btrfs developers narrow the cause down?
> >=20
> > Thank you for your report, and sorry for the instability. Unfortunately=
,
> > after zeroing the log, there isn't much we can do, besides just collect
> > basic information about your setup to try to correlate with other
> > reporters:
> >=20
> > stuff like
> > - hw architecture
> > - exact kver
> > - mount options
> >=20
> > While we're on the topic,
> > https://lore.kernel.org/linux-btrfs/20250718185845.GA4107167@zen.locald=
omain/T/#t
> >=20
> > is another thread with more reports where I mentioned the information
> > I'd be looking for to help debug. So if you do crash and hit it again
> > going forward, and are able to run btrfs check or btrfs inspect-interna=
l
> > dump-tree before recovering with zero-log, that would be very helpful.
> >=20
> > Thanks,
> > Boris
> >=20
> > > Best regards,
> > > Peter Wedder

