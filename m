Return-Path: <linux-btrfs+bounces-15607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC99BB0C9BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07841889075
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBE22DECB0;
	Mon, 21 Jul 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="x9Q+jXIn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E22874E5
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119252; cv=none; b=AOhRAtOhkPw3YL7LrvlvGnwd2Nu+7Gd9kz7lpPDkNYrc6VKRqRuO1MWcwggoXK5N5zxwZAVvV3yIZbkqzPePpy8mOoGfJXuDX11egcDdZr5fShOUR4cc29HZlD7AhsEABeAXQPM+ElXun69RnYzfEzIG9VGLNWtTV0ky5tjKcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119252; c=relaxed/simple;
	bh=BaYtvVRtI6KZnSiyfJXBwNpBCoBJY+xrG99Lo/g8F+w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6cfQyOF3HUHRVeZN9G/dRtRFc3xXkz4I1Tv43q7HK1cEMVFHfpluAbhd5//Dbt2SDlLj4rQNjYMZFEO8lFGFhDgwXHEhYS4BYZ93+XjdVyZ0DQ63dPHOyrOKkdCSefr5gZzadMfs5ColIhf0T1WgrjSxBY2403U+75YmYYj7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=x9Q+jXIn; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753119247; x=1753378447;
	bh=BaYtvVRtI6KZnSiyfJXBwNpBCoBJY+xrG99Lo/g8F+w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=x9Q+jXInNMbToUCMteJdybNyijG/ZlLOECDv99p7ZPagMGPuSAHjRgfc4zB2OsZJL
	 bPBZYbeUp33uagdcOgNeST1aV0zagakoui2paUTocYAi60dbEcrDBrs6mURuR51i+9
	 i/HQNhqiLfOOf0t3bh4exMoLLTKVvW5tjTOn0yfQpwdI5n/Q+eQs85JsZ/bNuRU0So
	 snZTNZAa7RCJoCsRLuKRUdbJYfBN+tRVpyL1JDnfJTrbkPOgWWTCwbijDv1jj1IIi/
	 bzuqt8LGdNiqAaaqDZU5nG4Km3RUDHvV8INQMUhzCLOtOFecPKwA6gWufPx4ZWk8vr
	 6o7MnGLEaA5Bw==
Date: Mon, 21 Jul 2025 17:34:04 +0000
To: Boris Burkov <boris@bur.io>
From: burneddi <burneddi@protonmail.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: log tree corrupted (and successfully fixed) -- anything I can do to diagnose why?
Message-ID: <hDedgabtauGBrte7Y8hOUixCdR-j255nc8o8sr_lYVIudj_zkd9WSRgJk1FSBYhnIwCMsbzc9ooFE1BL7VKjsLqHZasXEQpK6XQT3uH9XB0=@protonmail.com>
In-Reply-To: <20250721154643.GA1839816@zen.localdomain>
References: <lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com> <20250721154643.GA1839816@zen.localdomain>
Feedback-ID: 41869915:user:proton
X-Pm-Message-ID: 3cdf565ea35efd260ca5ce43d261544bfb8b2a1e
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Okay, that's too bad. Unfortunately I didn't even note down the full dmesg;=
 only snapped photos of the top and bottom with my phone. Here are those ph=
otos anyway, on the off chance they are of any use: https://i.imgur.com/RJk=
0qaI.jpeg https://i.imgur.com/n6t5nGG.jpeg

I am on kernel version 6.15.6-200.fc42.x86_64 on Fedora 42. My CPU is Intel=
 i9 12900k on a Z690 platform motherboard. Mount options: subvol=3Dsubvol_r=
oot,compress=3Dzstd,x-systemd.device-timeout=3D30.

Perhaps it's worth adding a note suggesting users collect troubleshooting i=
nformation in the documentation at https://btrfs.readthedocs.io/en/latest/b=
trfs-rescue.html. This is the documentation I read to find out how to fix t=
he issue.

Regards,
Peter


On Monday, 21 July 2025 at 18:45, Boris Burkov <boris@bur.io> wrote:

>=20
>=20
> On Sun, Jul 20, 2025 at 09:19:42PM +0000, burneddi wrote:
>=20
> > Hi,
> > My system had a hard crash today (some AMD graphics instability), which=
 resulted in the log tree on my boot drive becoming corrupt, giving me the =
error "open_ctree failed: -2".
> >=20
> > I managed to fix this successfully with "btrfs-rescue zero-log", but no=
w I'm wondering if I should try to diagnose and report this somehow. I have=
 been running this drive with btrfs for many years and have had a fair numb=
er of hard crashes during that time (AMD graphics instability...), but this=
 is the first time the log tree has been corrupted, so I suspect it could b=
e a kernel bug rather than an issue with my drive's firmware. I run Fedora,=
 so my kernel is quite new; 6.15.6 right now.
> >=20
> > Is there anything I should or even can do after zeroing the log that co=
uld help btrfs developers narrow the cause down?
>=20
>=20
> Thank you for your report, and sorry for the instability. Unfortunately,
> after zeroing the log, there isn't much we can do, besides just collect
> basic information about your setup to try to correlate with other
> reporters:
>=20
> stuff like
> - hw architecture
> - exact kver
> - mount options
>=20
> While we're on the topic,
> https://lore.kernel.org/linux-btrfs/20250718185845.GA4107167@zen.localdom=
ain/T/#t
>=20
> is another thread with more reports where I mentioned the information
> I'd be looking for to help debug. So if you do crash and hit it again
> going forward, and are able to run btrfs check or btrfs inspect-internal
> dump-tree before recovering with zero-log, that would be very helpful.
>=20
> Thanks,
> Boris
>=20
> > Best regards,
> > Peter Wedder

