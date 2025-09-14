Return-Path: <linux-btrfs+bounces-16806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA22B5684D
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 14:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A38124E11AD
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B792580ED;
	Sun, 14 Sep 2025 12:07:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FA911CBA
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851623; cv=none; b=JwrFG9m3tjaQzVPY8VpfsCZt9t9WqxwXi5z+EE45SDnrdx9wyy9+sZdV1bOYfIw4yKp3B64VbmeeUsTrRcJ3PxjxAL8Au8TBQBasHp0RF3VAUUkHMv5P+QIR8Yg6b0d2S2PetFkBkLIUWcQqEbZwRDZKLsjfJChojRy15J7WX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851623; c=relaxed/simple;
	bh=qwGcpIc3rcGD5Soyf5Lf0JVXhCnC6vZ1yBvvzmMp3kc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AbxyFtzS8PCrPiPNVKaRi0hnG4g6rFMwdcDdpoM/8rIjqsgvaiq39WkWw6OZYKYUBukZGOVmZpvgrqLHOBkTgrQySl1k6NPO8/rZS7mjxIVjXGLERqwwHnSfIUdSEPX5Qw+ZMqp1RCJ3cWl/cm7BWiM0CblvQ843nVedstToY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id B197414410D
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 11:57:55 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: BTRFS <linux-btrfs@vger.kernel.org>
Subject: SSD overheating during scrub in laptop
Date: Sun, 14 Sep 2025 13:57:52 +0200
Message-ID: <1938311.tdWV9SEqCh@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi!

Just to share an experience and ask whether others have experienced this.

Already during summer it happened, that the Samsung 990 Pro 4 TB SSD in=20
this ThinkPad T14 AMD Gen 5 said goodbye during scrubbing a 2 TB BTRFS=20
filesystem with almost 2 TB of data in big files running at about 3,5 to=20
4,2 GiB/s. I concluded this being due to excessive heat.

However it still succeeded with the 500 GiB /home with about 300-350 GiB=20
of data in it back then. I worked around it, by scrubbing two minutes,=20
then canceling, waiting to cool down, resuming for two minutes until the=20
7-9 minutes of scrubbing were complete. I tried to work around with=20
lowered speed, but even then the temperature slowly rose till the SSD said=
=20
goodbye. I think I went down to 1 GiB/s of speed maximum, maybe even below=
=20
that. But then the scrubbing takes longer so more time for SSD to heat up.=
=20
However=E2=80=A6 I would have thought it would not heat that much with a sl=
ower=20
speed. Maybe it would have worked with 50 or 100 MiB/s. But this takes=20
long.

Now I had these SSD goodbyes during regular use in times of heavy I/O and=20
in the end it could not even scrub that /home partition anymore in one go.=
=20
Linux hung and only way to recover was to forcefully power off the laptop.

I opened the laptop and removed dust with high pressure air can while=20
holding the fan still so it would not generate current. And with disabled=20
laptop battery.

This fixed the SSDs goodbye issue and I could even scrub that 2 TiB=20
filesystem again. However, according to sensors command it still had about=
=20
80,8 =C2=B0C composite temperature and even 100,8 =C2=B0C for sensor 2 for =
the NVME=20
SSD at "nvme-pci-0300" shortly before the end of the scrub, with critical=20
for composite at 84,8 =C2=B0C, but no critical set for sensor 2. That is st=
ill=20
quite high. Granted, it took about 7-8 minutes of scrubbing at 3,5 to 4,2=20
GiB/s in one go for it to heat up like this. But on the other hand it is=20
not summer anymore and room is not as hot as in summer.

Anyone had similar experiences?

My solution to this will be to remove the dust inside laptop about every=20
half year. However=E2=80=A6 I was a bit surprised that the NVME SSD would n=
ot=20
throttle itself before saying goodbye. Or maybe it tried and it was not=20
enough or to late? The laptop is a bit less than 15 months old. So I=20
conclude that it takes less than a year for the cooling system to become=20
quite a bit less effective due to dust. Good old ThinkPad T520 took way=20
longer for that. But it is way larger on the other hand with more space to=
=20
distribute heat.

I bet it is out of scope for btrfs scrub command to monitor NVME SSD=20
temperature and pause when to high. And I conclude the NVME layer of the=20
kernel is not throttling to hot NVME flash either.

I checked my data filesystems, two BTRFS and one BCacheFS by scrubbing and=
=20
fsck'ing without changing anything. They are okay.

Best,
=2D-=20
Martin



