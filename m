Return-Path: <linux-btrfs+bounces-18428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2520FC22D82
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 02:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D845F4E8ED0
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743222127A;
	Fri, 31 Oct 2025 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="RmP9tDNz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y0XY+0MU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7C190664
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873013; cv=none; b=C6xMhFoJuzqgE9chxOpL8P9bhwhEjXyodc7eqWD/7z1peuj5tBVla+ADfeOpw1Va5MWA8uAKz08te5a4gSfO10o9vqGd0gMXsU6uCMJY95ZWdpUdPguhaixt/KTHYZaAYqUSRyk4arMSGezNRg5xfl5RLSZiabdfEzy3tJjVc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873013; c=relaxed/simple;
	bh=h6VxR4aCwOd7uWqDGk/XMBuHwUSTILVA1u+EuL5YJAg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Jzuc4gD3Bu8RJ290AM3xhkz2BXQyx0a4Ci3qupEdYr0qHc7eHkpl93uZ7LrmGy6ph96BEB1HJh6jxe9UM5QJm8vbYrxlrFHuYy5bA/d2MBBs2d8hd+ZmBwYIs52B5fleqA0nCxwqWgxAp1NBLjn/qaleLkBIV/f6OdbbJwXtQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=RmP9tDNz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y0XY+0MU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BE4F91D000D0;
	Thu, 30 Oct 2025 21:10:04 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 21:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761873004; x=1761959404; bh=W9y7piWwJhbVYkTHtXtAv
	GxIYD7jwU0nZLAUH55iqio=; b=RmP9tDNzqCvcMjlPbbAbaKyPAWfguPKz5OtBX
	se3HlrW0498s3xfmBKODvhFomdfLby8M3Uw/WgSuyUeXdOEbJqTGFHvqT4hPpNdj
	bHU9ibp9ykB15tdFyA/pEZlRv1XgezGDzh6HPILx6Fp0MhPqmDT016LkHyHysyhi
	1FModUD+wrgQy+dMQ3yZCggSIuIwECs5TDkIyMQhnFWr9w89QPQuPiddeVVFu43Y
	3J246ZVZk3W3zqAv1uSqgkRm7riQMgLdL41eXnizNCOIkgdjKGGXPy+6c0OLJfdo
	qRCHhIe083yRLzROiJQShBSDCkiOdafNwF+SaPpP87NNw+9YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761873004; x=1761959404; bh=W
	9y7piWwJhbVYkTHtXtAvGxIYD7jwU0nZLAUH55iqio=; b=y0XY+0MUO8chSqM+h
	Jr2tFO479uobjATd7KR+kEQ/uiLhCd3yr1+Go3lHWatbh6bvLCt+2W2LrMdDCwmo
	JyAVljygspAEKKyz3ZtJ/xqCf3hCCU3XEsz5fJ6/j1VFaMuhjw0mnb+Sa99aKo3a
	gE1AN7VXr/Zcu1h8XusCfPWHVxNfonkyfiN16M/mF4YbaJueBZyfaj58YNj59kRe
	uvoZeitPV0eUxvfXesxzm8ZzZ9rGXWHwcjiRuxNB4VvfUEBHpxyZ49yzR+2DaHXj
	Jb3HNe1KX4f+BuJGaCF44+xTcTlZFo/cWZ7tQFRwkr7zSqtKAgYdpmE3EGJgia3+
	hsHrw==
X-ME-Sender: <xms:bAwEaSNRmlA_Th3-4BWwMfoRGa6MYbgYfgHa_KfMhwDRUeqjlbCyzQ>
    <xme:bAwEabzRbPiqFEMni48TwyTMjV_fZSOwPVFJgtUB-Qi9sg351ZW_50_YM1fhd8YCM
    cdzbSwD0YeQGOGb7d_YnEU6FMwReoDsRMXcRC3kM6pQEx43t8YZVk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnheptdfhgeffffehveefieevkeeuieejjeeggeffueetgfefgeef
    ieduhfdvudejieffnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhdptgifihhllh
    hurdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtoh
    epvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvnhgurhhikhesfhhrihgv
    uggvlhhsrdhnrghmvgdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bAwEaQ5H94rQ1xw_lcXlQxuaBDjZleKep74MXKpQPyU_9Hnnpg4L3A>
    <xmx:bAwEaf0d4iG8Zf7tpbZWC_SwIsH0Yjyve1u2bbOThI1JXhsUWarqZQ>
    <xmx:bAwEaXCQOok49w3KDUCw8TzguP9qbCfPlewdllaYsMjtIzTBD-2W_A>
    <xmx:bAwEaR0LjPAq9p6z06OTg722Bw0Ki4EEPuVfHdxiOtYCeAtw017z4Q>
    <xmx:bAwEaevEoNTUj0JyYF68Y55gfANlqf5_9K6sA4GBmumAVjypLufiM0Y->
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4395118C004E; Thu, 30 Oct 2025 21:10:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVMxPOgRNBic
Date: Thu, 30 Oct 2025 21:09:43 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Hendrik Friedel" <hendrik@friedels.name>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
In-Reply-To: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Oct 27, 2025, at 9:00 AM, Hendrik Friedel wrote:
> Hello,
>
> I have a corrupt filesystem - and a Backup.
> So, I am only here to learn, not to recover :-)
>
> The history:
> - a raid 1/mirror of data and metadata. 12TB identical WD Drives
> - some issues with bad sata cables, causing related dmesg messages
>  =C2=A0 =C2=A0https://pastebin.com/Z0T3fhcv

This ends after the bus error, so we have no idea what happens next, inc=
luding whether Btrfs became aware of the problem or what it did next.

> -UDMA_CRC_Error_Count: 1237 on one device. It remained stable since I=20
> replaced the cables, also during one successful scrub run. Also I run =
now
>  =C2=A0 for host in /sys/class/scsi_host/host*/link_power_management_p=
olicy;=20
> do echo max_performance > "$host"; done
>  =C2=A0 during boot - not sure whether this or the cables did the tric=
k.

But were both drives affected at the same time?

What kernel?

>
> Now today, I wanted to reduce redundancy to single, as I need the one=20
> drive for other purpose.
>
> The balance failed:
> https://pastebin.com/UA8vGm8g
> http://cwillu.com:8080/84.60.242.132/1


[So Okt 26 18:30:23 2025] BTRFS critical (device sda1): unable to find l=
ogical 15401206349824 length 16384
[So Okt 26 18:30:23 2025] BTRFS critical (device sda1): unable to find l=
ogical 15401206349824 length 16384

Well that seems bad. Both copies? And scrub didn't detect this problem?

I guess that means writes to both drives were lost, but then Btrfs shoul=
d know this, and not write a super block update pointing to a root tree =
with metadata write failures.

>
> btrfs check (without --repair) gives me
> https://pastebin.com/PG3Uz4SK

The mapping complaint makes me think it's chunk tree corruption, but thi=
s isn't an error I've seen before.




>
> Now, I would like to understand:
> - where did I go wrong.
>  =C2=A0 =C2=A0 - I was thinking that the raid1 should prevent me getti=
ng into this=20
> situation (I know, it does not prevent other reasons for data loss and=20
> thus I have a backup)
>  =C2=A0 =C2=A0 - I thought that after spotting the sata-cable issues, =
fixing those=20
> and running a scrub, I would be safe

It should, but I'm not following the sequence. You scrubbed *after* the =
cable problem was resolved, and that scrub comes up clean. But then you =
balance and the file system reports missing logical blocks, goes read on=
ly?

scrub checks for csum mismatches, not file system consistency

check checks for consistency

But to scrub, btrfs needs to read the chunk tree, and metadata. I'm conf=
used how it can scrub without error, but then run into a problem with ba=
lance.

> - could btrfs repair fix it (no need to do)?
> - I would now like to
>  =C2=A0 =C2=A0 - keep one of the drives in my drawer (as I now have lo=
st redundancy).
>  =C2=A0 =C2=A0 - kill the Filesystem from the other drive. Do some tor=
ture test=20
> (smart long selftest, badblocks)
>  =C2=A0 =C2=A0 - create the filesystem (single) restore redundancy by =
copying data=20
> over (not from the drawer drive, but from a different filesystem
>  =C2=A0 =C2=A0 - running torture test of the other drive and use that =
for other=20
> purpose (as originally intended for totally different reasons)
>  =C2=A0 =C2=A0 Does that sound like a plan?


I think wait for a developer or more experienced user to respond. Your c=
onfusion makes sense to me. Unless the hardware issue occurs *exactly id=
entically* for both drives (they'd have to share the cable) at the same =
time, then your expectation that raid1 on separate drives is correct, it=
 should protect against this case.

So I have to wonder if it's a bug. Hence, what kernel version?

--=20
Chris Murphy

