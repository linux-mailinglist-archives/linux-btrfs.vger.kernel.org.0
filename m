Return-Path: <linux-btrfs+bounces-16849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AEB59556
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 13:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2997B22BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F192F7AA0;
	Tue, 16 Sep 2025 11:36:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A38199939
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022600; cv=none; b=TPfO8n5KlHC9CLPvpyW4ntubktrxCJkGhVOZUZisprvIhG8crkAi+tMupQKAcOTl5ROuG+0CEVCzGNV+POODs1U1t0dixQgIdmWV4sjI8wF3doX3aq8E93HEHpaN4t9HUBWTa17i5i+aYPwG3zrLasUmpW+OEnD56i81tGZ6+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022600; c=relaxed/simple;
	bh=UwVqbs1mPWz+CaTyhkd9o8dTwKywkrb/0GOjT4A94lo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pD3I53CMwFLdCIjqGIB0ehZbmHfMi4O6oMkrtI/qxd16Dbs1dLYDjyy3sQn8QpjYkShMalie/Fl/+8vUtC+8gUSJp+WaueHNX9vg1OULNZ7jua6/B6mXugnc9NAliVgeoJXDu6ukVR1jDgjXAeGcEC516HrqgP/xLtjNqEs3jUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 0DDC814564C;
	Tue, 16 Sep 2025 11:36:28 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: BTRFS <linux-btrfs@vger.kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: SSD overheating during scrub in laptop
Date: Tue, 16 Sep 2025 13:36:27 +0200
Message-ID: <2031348.PYKUYFuaPT@laptop>
In-Reply-To: <45131321-5ed8-4abe-9edb-19b1936e83b4@gmx.com>
References:
 <1938311.tdWV9SEqCh@lichtvoll.de>
 <44330134-4c22-4fea-9a14-84c78daecdb5@gmx.com>
 <45131321-5ed8-4abe-9edb-19b1936e83b4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Thanks.

Qu Wenruo - 14.09.25, 23:33:01 CEST:
> =E5=9C=A8 2025/9/15 06:58, Qu Wenruo =E5=86=99=E9=81=93:
> > =E5=9C=A8 2025/9/14 21:27, Martin Steigerwald =E5=86=99=E9=81=93:
[=E2=80=A6]
> >> Now I had these SSD goodbyes during regular use in times of heavy I/O
> >> and in the end it could not even scrub that /home partition anymore
> >> in one go.
> >> Linux hung and only way to recover was to forcefully power off the
> >> laptop.
> >=20
> > Can you setup netconsole and catch the dying message?

I suppose I could do that as I have several laptops at hand. However=E2=80=
=A6=20
after cleansing out at least some of the dust it did not happen anymore.=20
And I do not quite feel like putting some dust back or otherwise provoke=20
the issue. I do not quite feel like trying to overheat the SSD again. :) I=
=20
looked at it more closely, it looks fine enough. Nothing melted=20
apparently, but what do I know? And I think it does not add to the=20
lifetime of the SSD to overheat it on purpose.

I might have made a photo of some earlier time, but I am not sure. I will=20
have a look and see whether I can find any. I remember the kernel wrote a=20
lot about NVME opcodes. However I do not recall the details. Unfortunately=
=20
at this recent occasion I did not make a photo.

In case it happens again by itself, I am at going for a netconsole log =E2=
=80=93=20
in case I can reproduce it then. Otherwise I would need to run netconsole=20
permanently to be sure to catch it on the first occurrence already. Not=20
sure whether that is a good idea.

> > I doubt if it's really the drive dying.

Why? The issue went away after removing at least some of the dust. Of=20
course that is a correlation and not necessarily a causation, but what=20
makes you think that something different is happening?

I checked the drive smart status. SMART status is passed. So everything=20
okay. There is 2% of spare area used, but that is still a very good value.

An indication that there is something to your suspicion is:

Media and Data Integrity Errors:    0
Error Information Log Entries:      0
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0

So the drive itself recorded no critical composite temperature times. And=20
if it has fields for that, I suppose it could still record it on overheat=20
condition.

Oh by the way, it is a Samsung 990 Pro with a firmware version above that=20
firmware version that was known to be broken regarding SMART status=20
reporting. In the first I bought I made sure of that myself, but this one=20
came with a newer firmware version already.

> >> I opened the laptop and removed dust with high pressure air can while
> >> holding the fan still so it would not generate current. And with
> >> disabled laptop battery.
> >>=20
> >> This fixed the SSDs goodbye issue and I could even scrub that 2 TiB
> >> filesystem again. However, according to sensors command it still had
> >> about 80,8 =C2=B0C composite temperature and even 100,8 =C2=B0C for se=
nsor 2=20
> >> for the NVME SSD at "nvme-pci-0300" shortly before the end of the=20
> >> scrub, with critical for composite at 84,8 =C2=B0C, but no critical se=
t=20
> >> for sensor 2. That is still quite high. Granted, it took about 7-8
> >> minutes of scrubbing at 3,5 to 4,2 GiB/s in one go for it to heat up
> >> like this. But on the other hand it is not summer anymore and room
> >> is not as hot as in summer.
> >=20
> > I have hit similar situation, but the symptom is very different, the
> > death come silently at boot, the drive is no longer recognized by the
> > BIOS thus no longer bootable, and Linux kernel from liveUSB will not
> > recognize it either.

Hmm, did you capture any logs?

> > That's why I'm asking if it's really dying caused by the heat.

Ah okay=E2=80=A6 You mentioned your physical solution being a thermal pad. =
So did=20
this symptom go away with it? Or was your physical solution a general=20
solution to reduce temperature, a solution unrelated to that symptom you=20
described?

> >> My solution to this will be to remove the dust inside laptop about
> >> every half year. However=E2=80=A6 I was a bit surprised that the NVME =
SSD
> >> would not throttle itself before saying goodbye. Or maybe it tried
> >> and it was not enough or to late? The laptop is a bit less than 15
> >> months old. So I conclude that it takes less than a year for the
> >> cooling system to become quite a bit less effective due to dust.
> >> Good old ThinkPad T520 took way longer for that. But it is way
> >> larger on the other hand with more space to distribute heat.
> >=20
> > You can refer to man page of btrfs-scrub, it provides the way to limit
> > the bandwidth of scrub using cgroup or even the btrfs sysfs interface.
>=20
> And I forgot my physical solution, with a thick thermal pad, you can
> connect the NVME to the back plate of the laptop to dissipate heat.

Well it has some violet colored pad below the NVME SSD. So a pad that is=20
between NVME SSD and motherboard. Not sure whether it is a cooling pad. It=
=20
might be more about isolating the motherboard from the heat of the SSD? It=
=20
has been there for the initial SSD Lenovo put into the laptop that I=20
replaced with the larger Samsung 990 Pro one.

But yeah, I may order a cooling plate to connection to the back plate.=20
Good idea.
=20
> If there is enough space (I doubt for laptop though), you can add some
> thin heatsink for the drive.

Ha ha, no way. I would like to put a 8 TB SSD in there, but it would be=20
double layered and I doubt it would be a good idea to put a double layered=
=20
SSD into the laptop.

Best,
=2D-=20
Martin



