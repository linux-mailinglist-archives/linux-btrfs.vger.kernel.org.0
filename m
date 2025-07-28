Return-Path: <linux-btrfs+bounces-15719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B46B143BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 23:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9786B5406DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87EB23505E;
	Mon, 28 Jul 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Xvi+57SS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89B26281
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753737150; cv=none; b=IcrlvDIeJS7GJJpjbf+TSzx1eHqT50b3Tin+IH83yOtVaVrKbTXcAC/kyDEj39RRPmrqRqPaYrQfJiRaZW+kjd0eGatToPYl269YIvDCjwLkOHmo5+7uD86sGKvpbocQEiNKx2W9WhSR3UBTBQJwm5XOz8/qwrZTBSFjlBCKamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753737150; c=relaxed/simple;
	bh=s97YcB/d2MS+3X7q/w6hqpxEKgZOV3mfG/3CMZ4A+RY=;
	h=From:To:Subject:In-Reply-To:References:CC:Date:Message-ID:
	 MIME-Version:Content-Type; b=JVyCE9ypmNZdhJ6/hpnAVMDJwchaEA+5iK/cTGHvu0dARMO2YEwbCATk+cHaf4CIgW8HN4KRVVRJC+sdX+x8iJSk1eZng6pAE3JWVUQOxZiEfZfiVvN99fCAbcWx06rRmy5x+eJRuLavWooK2Q+pstHLZYzaIPZ8h1pOcboINhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Xvi+57SS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:CC:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktJ8zyfyYaxGPp7Gm74F+PizK15sbbdFwox1imHJ97s=; b=Xvi+57SSVh68mHOn0SqIo5t9Ue
	4DN/Viz0Bq/SaPseS4tsUUvocQpUzrlqKxYKM8fVxocUNnCDEVMaa5Sjpj8hVVzK9EIQmwfImGaMw
	JRnaYlPnyeDwtkHSpmqaDf8I84aIyKDbkP3lrvWDffXg1zMq+9oRtT7vcLgubsFcnJQ0SDVLux75F
	yKuuPWa1QibQE9/VEVaxmJHqD8WwkoMMdQkruTCOg3JKAYSBpuv4d3QfL43943akv9uZylp9Loo3O
	6moOhzUiYKatSJoYQ1fpcR75eK/dv/VlGJNzJVCYsM6D8WMFaCTmkCmkX4yKePhwOsoDwAFNKY3Xm
	wCdqc47Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1ugV8s-00CymD-KC; Mon, 28 Jul 2025 21:12:19 +0000
From: Nicholas D Steeves <sten@debian.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: balance failed with checksum error
In-Reply-To: <4bf5d74c-910f-4cc9-b290-26bf5bcc8e47@gmx.com>
References: <20250726234755.GA842273@tik.uni-stuttgart.de>
 <4bf5d74c-910f-4cc9-b290-26bf5bcc8e47@gmx.com>
CC: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Date: Mon, 28 Jul 2025 17:12:10 -0400
Message-ID: <87ecu0t3yt.fsf@navis.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: sten

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Qu Wenruo <quwenruo.btrfs@gmx.com> writes:

> Data checksum mismatch is known to happen for certain workload.
> E.g. direct IO with buffer modification during writeback.
>
> Thus upstream commit 968f19c5b1b7 ("btrfs: always fallback to buffered=20
> write if the inode requires checksum") fix this hole, at the cost of=20
> performance for those direct IOs.

6.12.40 is the latest LTS kernel, but it doesn't have this fix.

Ulli Horlacher <framstag@rus.uni-stuttgart.de> writes:

>> > root@quak:~# sysinfo
>> > System:        Linux quak 6.8.0-64-generic x86_64

[snip]

> Meanwhile I have upgraded the kernel:
>
> root@mux22:~# uname -a
> Linux mux22 6.14.0-24-generic #24~24.04.3-Ubuntu SMP PREEMPT_DYNAMIC Mon =
Jul  7 16:39:17 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
>
> And now there are no more error(s):

I guess this means the patch was applied to 6.14 as gregkh requested,
and it just needs to be resent for 6.12.x?

https://yhbt.net/lore/stable/968f19c5b1b7d5595423b0ac0020cc18dfed8cb5.17466=
65263.git.wqu@suse.com/T/#m6a70c86370f8a22ab6559704b4edbaed067763a0

Cheers,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmiH56sQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYdprEADVRg3LFJbiZrkPsl9fEC9s0H2y/UtEcI9y
iEcHkIWcH9GecklGnVeGrVFvM8o6jmsgfFI1wg1E1jdTwHxAkXN2PIRfD3uk7TVd
u4pfXU5C9UxkscdCrGEDMKPG5hHRlOMJpC83lpiT3Ninup4jn+mP9DGCFFNl+i2q
2SDSudjqHPBhl2VFOJF6m4Tor5BI3vT2VubR5gFreZ5V0uPC4D1FKw4UmsyySbWq
XEgSNUfh6/imJ/tQ1h8T8SsdRk8dc7olwEHCDPAQa0NdoZNal/e7mwmMfyx/nNW6
dpuVHqn2bCd3codmB+D+/DzVO9SPPhJ6XcvEGKiMDBnxnxouNAqccXzJjkfumoYt
fZOIzzrWLQuhTMOb7IEAhfD/i0UpNIYcbmhw7vcFwFUOkwFX1/jxKqflIi3ZlAom
yHF4V8R7PTmmxFVs/Yg7wvepde/xwEA4Goib+DVLH0mwEq30MuVLHVwr8ieBHRxm
GjZB7ptUHoGToyl+vIlVJ9K6n6D3OrqxDIdIvw2Q95NsH7Eacr1D9R32LJhcovgR
BLI0ww+r9DhVt5G16zaiyWPS8uCJDmD1y/WTePYBAPMIyV1M19ieOWyV/S6JQe0d
VJ7qy4fmjbfHjaYdW0B3s2Gk3u95MQuLEZy2fPo168ytMTFohVUEg5+TOQHjp9MN
7ryO9Z0tag==
=7Xne
-----END PGP SIGNATURE-----
--=-=-=--

