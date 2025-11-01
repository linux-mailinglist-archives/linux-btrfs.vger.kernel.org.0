Return-Path: <linux-btrfs+bounces-18506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FBAC2744A
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 01:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E542B1B25A45
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 00:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035501D7999;
	Sat,  1 Nov 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="s9lE0TeP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdyQFr16"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76F2581
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956974; cv=none; b=t3VtXdUB8d6yGgH2YRDkxf5H/0iQpvAsYyGvH9k3pqF1PsYt7xDvGWrMr3YRWhoHhqBIdSNNqMJROMI5QlgrSrGx1fSfgB6qd1pmJTREIvqvqFrpCdbfsRzDENo/zKQYYWIuY2GEOOmyLHsAYTqVmLLnNiq5NvoZtX1arYQgJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956974; c=relaxed/simple;
	bh=31TIOJ0Mf2QFPqgyXbXHVXjNy3HUwOssH5wp6Cnx6bY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OOxsrZkjAe1+vGMupBaNXm7vmLAisTfhDSKLSH6HLtPVjnMqilb/Gsb3zTFqZDndK1IiUr5sQS6NXJUKPYczAkTMW7nJZKG4LIGgaS319m9DQsqjB0+C6MqoFzYXkFGYhE8JlJbvNaa6lTswbk9LE3nSe0xusrmfdsWZ20jeBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=s9lE0TeP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdyQFr16; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 834CF7A0074;
	Fri, 31 Oct 2025 20:29:31 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 20:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761956971; x=1762043371; bh=nX1hKumgdnHXCtObG7ZxF
	Yt8RLTgsbexUIPvhNvojGI=; b=s9lE0TePqau3U5dxPkxINbVNx3Skmg2aTezkF
	ylZcUTL1qpLKf3dA7ExWAEe1odqcFzhNWGUTseHKU0KhW1DxJsQQzXiuBUJkomHw
	Bm3uo1QQx3YkRbf/lmgyKS6yGm51UFKzcJ9STEuV6J52nulKy3HxF//L+0d+IJkt
	3bm4VIqDlJcWF4swwbtErryOJ+03uS6xAXo5NF4DXhyGeiFvp1odaPBuqpUa8wl7
	U+lUbXnsZ/cu4yPEM/i37/8tshRgXd5vu3Qx2zpozrkqolaF+0Xd1dEaSjD0qXk+
	0GU5pz1Bkm+e4rt1AMZ9M6twvG9R49emMMQ95YBQ/8Gi+VA/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761956971; x=1762043371; bh=n
	X1hKumgdnHXCtObG7ZxFYt8RLTgsbexUIPvhNvojGI=; b=MdyQFr16KOEPdybDl
	A2E6jV7a9zx6M68C33EpKvL4csr60+AJIplobk6yssvSv57wZ5se3w4zCXm4WxCG
	odkqo8ZmfGCkHC3MiTXQLLR+LwPYsPp3o3+jAxd8k5SngP2TBFT885tmJ7z+72e0
	M27b7t9/IVg3bYuifoLk5CPCuuRPBdX2gH6HUTjcEsJr5bcYRmzEAJhYGlvAuJoT
	08zyTc7U2q4r72f0FV+VR1IC0B7UaQnAbtLez8rgTMICfZ08dsSI4r+1peyPD69A
	s+gVUtNjXOP0tUgB9Hrtf+LVACQvd7G7DIulU4OSm0SH4+OcwfnMjRfK1E61Qyyf
	8fPLg==
X-ME-Sender: <xms:a1QFaQM53P3oN8pMPVUM2wT50XAzVHsBY3wnZCWqa45tuvYGeXUWug>
    <xme:a1QFaRzMT_aztFbC00ntYaB-yMtyWM_jiHVHSH2AiYda2poaU1KyOwnmpLQoJZjAQ
    3Ngrs4VOYIrQDxS1fm1hEesTZvrFapk08jwKDjGuWh00ftPZiimACw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepteefudehkeehgeekhfdvgefhjedvveeuhfdtgfejgfevieev
    iedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvnhgurhhikhesfh
    hrihgvuggvlhhsrdhnrghmvgdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a1QFae7mAh4FZ8qMnnoqJCZkPK06IGOsPb-nnE-qhlPka27KayevyA>
    <xmx:a1QFaV1w-NFO-W_MbemK2_Z5gmUrJEZ1P3EWg5bC2Qk6D_xP-6wZgQ>
    <xmx:a1QFaVDjPcGEjOLZ7vEhXvcdBNFrJ9H9_leKw43ck1OsGAu2C7CGTA>
    <xmx:a1QFaX2U62wgJaNvYYC4NLi_-x49c03dtcHzUmKt5BtSynxNdz6jIg>
    <xmx:a1QFaUscItln6YQM2aNS5ZG53-amATOdZ5m6vqjYpBaHDdvSHGCRURZv>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF34E18C004E; Fri, 31 Oct 2025 20:29:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVMxPOgRNBic
Date: Fri, 31 Oct 2025 20:29:10 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Hendrik Friedel" <hendrik@friedels.name>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <f6858f97-1fe2-49d7-b1ad-dc688142fdcb@app.fastmail.com>
In-Reply-To: <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 31, 2025, at 5:05 AM, Hendrik Friedel wrote:
> Hi Chris,
>
> thanks for your reply!
>
> FYI: I am now running "badblocks" on SDA (Serial Number: Y5J6YGLC) since 
> 2 days without errors. It is not complete yet (it does four different 
> patterns), but two patterns are passed already.

One other thing to make sure of with this configuration is that SCT ERC for the drives is a lower value than the kernel command timer. If not, the drive delay during recovery of bad sectors will make the kernel think the device isn't responding, and it will reset the link and at least for SATA drives this can clear the entire command queue.

SCT ERC is a drive firmware setting, it's not persistent, can be get or set with smartctl -l scterc command.

Kernel command time out is found in sysfs for each drive, but note that this is not a device setting.

This is important because the drive needs to give up on reads from bad sectors quickly, and Btrfs can just overwrite the bad copy with good copy. Delays can mean these never get fixed, and there is a reduction in redundancy. I'm not able to tell if either of your drives have bad sectors though - this is just a best practices FYI.


>Okt 14 12:03:37 homeserver kernel: BTRFS: device label DataPool1 devid 2 transid 1704441 /dev/sda1 scanned by btrfs (226)
>Okt 14 12:03:37 homeserver kernel: BTRFS: device label DataPool1 devid 1 transid 1704441 /dev/sdb1 scanned by btrfs (226)
...
>Okt 14 23:33:33 homeserver kernel: BTRFS error (device sdb1): parent transid verify failed on logical 8332327665664 mirror 1 wanted 1704434 found 1701990

This is a large transid gap. Thousands of generations different. Potentially many missing writes on this device at this point. The problem happens earlier than this I think.

>Okt 14 23:33:36 homeserver kernel: BTRFS error (device sdb1): balance: reduces metadata redundancy, use --force if you want this

Hopefully this is a mistake and the command was not reissued with -f

>Okt 14 23:33:37 homeserver kernel: BTRFS error (device sdb1): parent transid verify failed on logical 8332327845888 mirror 1 wanted 1704434 found 1701990

So far these look like they're resulting in corrections from the other drive, but then...

>Okt 14 23:45:52 homeserver kernel: btrfs_repair_io_failure: 10 callbacks suppressed

I see this once. And then later...


>Okt 15 01:18:07 homeserver kernel: BTRFS warning (device sdb1): tree block 8332303564800 mirror 1 has bad generation, has 1703468 want 1704433
>Okt 15 01:18:07 homeserver kernel: BTRFS warning (device sdb1): tree block 8332303564800 mirror 0 has bad generation, has 1703468 want 1704433

Both copies have the same (wrong) generation? OK...

>Okt 15 01:18:07 homeserver kernel: BTRFS warning (device sdb1): checksum/header error at logical 8332303564800 on dev /dev/sda1, physical 337160077312: metadata leaf (level 0) in tree 7

And it's a metadata leaf with checksum mismatch, but this is reported twice for only sda1. No report of this for sdb1.

>Okt 15 01:18:07 homeserver kernel: BTRFS error (device sdb1): fixed up error at logical 8332303564800 on dev /dev/sda1

But it gets fixed? So wait, the block on sdb1 has an OK checksum, but still a bad generation? What? This block doesn't show up again. But I also see this:

>Okt 15 01:18:07 homeserver kernel: BTRFS error (device sdb1): bdev /dev/sda1 errs: wr 1979752, rd 888370, flush 0, corrupt 368, gen 2

Over 2 million dropped writes on sda1? That doesn't tell us for sure they're missing, they might have gotten fixed later. But it's so many missing writes, that if there is even 1 copy wrong, corrupt, or missing on sdb1 then Btrfs can't fix itself.

More of these occur with different blocks but also appear to get fixed somehow, even though both copies have bad generations, with seemingly only one copy also have a csum mismatch. Strange.

Skipping ahead

>Okt 26 14:39:52 homeserver kernel: BTRFS error (device sda1): balance: reduces metadata redundancy, use --force if you want this
>Okt 26 14:40:34 homeserver kernel: BTRFS info (device sda1): balance: force reducing metadata redundancy
>Okt 26 14:40:35 homeserver kernel: BTRFS info (device sda1): balance: start -f -dconvert=single -mconvert=single -sconvert=single

OK so the problem occurs during a conversion from raid1 to single.


> But in order to scrub, the Filesystem must be consistent and fully 
> readable, I thought. 

No the file system could be inconsistent. Newer kernels have limited checks for consistency with read time and write time tree checker that can catch common problems before the file system gets too confused.

>TBH, when you read about btrfs, the message is: do 
> scrubs, but do not touch btrfs check. Apparently, you should do both 
> regularly, and it is only --repair that you should avoid.

I think scrub more often than check, but in particular use check when there's evidence of write, flush, or corruption errors.

>
> Me too. That (and to learn that I should do btrfs check regularly) is 
> why I reach out instead of using a backup. It is 6.3.3 (I had been 6.5.0 
> for a while).

These are both EOL for a really long time, they're not getting any bug fixes. I recommend newer kernels, and newer btrfs-progs. No matter the file system, upstream developers recommend current stable kernels. That's where all the latest fixes are incorporated.

If you have a strong use case for needing older kernels then use the most recent actively maintained longterm kernel you can. But just know that these kernels don't necessarily get all fixes, if the fix it too hard to backport. It just depends on the bug. 


-- 
Chris Murphy

