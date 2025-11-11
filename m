Return-Path: <linux-btrfs+bounces-18875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C165C4FA04
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10593B1FA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF27329E53;
	Tue, 11 Nov 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="NozAeXAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wb8q+Cbs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64412329C61;
	Tue, 11 Nov 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890037; cv=none; b=bc9eU9sltOmSspoKFoptsWXlsvY1aouw1rZFzG8AbVIDFu1nBuKiXQGA4mCxw9E3BdsQ4cFnarntbnWsykgMvI9HNpdSbijRzlYrsbXLQpYdtRh+nGZSa1rBO9D8kScFTqfsCMTmwWX1vBZ6vG0jFRRICE8+mnj0mJcYkIL7u70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890037; c=relaxed/simple;
	bh=cghmO4+jxOcPXoW03Dz5sjvslzYXuj59UWXnRTGiqjc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oI5z2Qu4PE8sylwFiCRYl5tOMvXNIzQi5cwoh7v7DwsKy6zKl75ufSHR4rF9FlY7K0bLnuJSIdKX7Y8vrlKmb5OEuGYCYh1rHPWCIo8nk4EVi8GAd3HqF4ejUpRZ1Acq4tFWf+B3PLddr8uhMruQNjVloPXTXxiqVLy23SY2uXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=NozAeXAI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wb8q+Cbs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E76DEC0088;
	Tue, 11 Nov 2025 14:40:33 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 14:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762890033; x=1762976433; bh=oTBGjM1hxB
	PC3XrJPcevXldfIqkBQfy+2sLa6f5882c=; b=NozAeXAIo8siVLLRomX3zC1UtK
	meQ5HrpHqY0pXUc5JDn63vpG/RKOorvDsYt8HKbNz59Z3zELVXgFM+3ssS/8Kfmj
	f+5rMkRt1hC4E5XhiuPBEJ6zbQUXqv4WKlk9BYEpteTrnKY8jWYmdB0kcaYowIDq
	UMNr38f47xxe0Xu3OH69xgE9uP5tnPB29XZ2RyXs0hQb+Nfvy22PglllZvIMeTMo
	0hpkwusyllRSmumw1BbE6+2iC2vWjgViXfg3GC9PFMvIhDecjbAXS3mUdc9IdGc9
	Y4NJE0bHvh40YdVSjTH0Yh00LnH/l1NbPoR+xLIm7EOxF2bNRxxKZmIeaj6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762890033; x=
	1762976433; bh=oTBGjM1hxBPC3XrJPcevXldfIqkBQfy+2sLa6f5882c=; b=W
	b8q+CbscEnsKTDzds+hwn4Z+pBu9X3LPFch4BupA9PMoiH5q3XG/IJwSmKT807Wz
	tOZWlLi8VsIdqwElJKZNPxnlM1wQg2Ig9wHNioM+lNgPEk++jUN3Rk+awCuOIfFL
	mJYJjKmW+SmNOE26i+74ZptAYVO6RJ7FQjCcit+E/OnZg3jzR8qA20n4P5HoHsr+
	kJ4M3B9hwANQ6SiAoskYhBp4JAKSmJa2msjOgqYZnxJN8Yj8BLqn9Tuu9AZBY9Bb
	nnIKvev0d9onBwgGkbyoe4s2NmrYAt1Nu+0SksAwh0WJJHtKFw2WpqWKF0fnfBjw
	oYBIv+ESOwLibl/Nljg+Q==
X-ME-Sender: <xms:MJETaci4nxk0G0xqNyZ7z2e_XCc88AASMWqSEC9vXZMigXAyGVEVSQ>
    <xme:MJETaf0w9AyqbJGrx8kAyfzbyga5bQcniw-EUMiqli4TRTgFs6lskOqia9AzajdIH
    p53L3zgPfwG0lDS6n1jhwNYbFuJIl1SULdXSS58siSclFS8Yc8AN3P4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhuedvkeetudehgfethfevtdefiefgffehvefhveeuffef
    vddtgeeiffelffelgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhnvh
    hmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjphhishii
    tgiisehluhgtihguphhigigvlhhsrdgtohhmpdhrtghpthhtoheptghhrghithgrnhihrg
    hksehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MJETaaVxqXcecYmh1fpCKHXH8H8LYx4KVoI3kMigizMuRfpZKAmgsA>
    <xmx:MJETaaTizAA3420Zy7PpuNudM3ZQlhjmyOVhvTTelFHdx8bkHk5V-A>
    <xmx:MJETaYMyz9pkHUyz-SWUYFscElsTR6-YWqcBvLl3arTV9aAerfhOLw>
    <xmx:MJETaYSjS2DuChgarXILsOm31aE5HF1h_iklnPpg4XUTa1OF1iXIXw>
    <xmx:MZETabZodhesaWmZpx_m4V4-o_oGERCx41OhKD54ISrKj30VblcO-ZzU>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B5DD818C004E; Tue, 11 Nov 2025 14:40:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABlTi-3C1DAF
Date: Tue, 11 Nov 2025 14:40:12 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>,
 "Chaitanya Kulkarni" <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <a383946c-60b4-49f2-a3d0-dda1a5b41117@app.fastmail.com>
In-Reply-To: 
 <CAO9zADydZ=WrHbeREhWfetAupvzewM_A9Sz0RV8tY0h9CctoFA@mail.gmail.com>
References: 
 <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
 <e5a2b8b2-d4e5-42ce-9324-5748c5e078d4@app.fastmail.com>
 <1e4dd261-0836-4eea-b7fd-8dec9a7453d9@nvidia.com>
 <CAO9zADydZ=WrHbeREhWfetAupvzewM_A9Sz0RV8tY0h9CctoFA@mail.gmail.com>
Subject: Re: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 37868055...
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 11, 2025, at 1:25 PM, Justin Piszcz wrote:

> Absolutely correct!!  Luckily, I do have remote syslog enabled and
> captured the errors that were not logged to persistent storage, do the
> errors below point to an NVME firmware issue?
>
> "2025-11-10 01:42:51","notice","user","","machine1","[4043499.402974]
> BTRFS info (device nvme1n1p2): scrub: started on devid 2"
> "2025-11-10 01:42:51","notice","user","","machine1","[4043499.403000]
> BTRFS info (device nvme1n1p2): scrub: started on devid 1"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.683686]
> nvme nvme0: I/O tag 2 (a002) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.684742]
> nvme nvme0: I/O tag 3 (c003) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.685778]
> nvme nvme0: I/O tag 4 (1004) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.686802]
> nvme nvme0: I/O tag 5 (c005) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.712274]
> nvme nvme0: I/O tag 6 (0006) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.712483]
> nvme nvme0: I/O tag 7 (4007) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.712698]
> nvme nvme0: I/O tag 8 (3008) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:22","notice","user","","machine1","[4043590.712906]
> nvme nvme0: I/O tag 9 (5009) opcode 0x2 (I/O Cmd) QID 2 timeout,
> aborting req_op:READ(0) size:131072"
> "2025-11-10 01:44:53","notice","user","","machine1","[4043621.419061]
> nvme nvme0: I/O tag 2 (a002) opcode 0x2 (I/O Cmd) QID 2 timeout, reset
> controller"

All of those read requests were dropped by the nvme controller and then the kernel nvme driver reset the conroller which appears to not work...

> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.821452]
> nvme nvme0: Device not ready; aborting reset, CSTS=0x1"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.850059]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.850351]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.850630]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.850903]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.851173]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.851440]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.851705]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:14","notice","user","","machine1","[4043702.851971]
> nvme nvme0: Abort status: 0x371"
> "2025-11-10 01:46:34","notice","user","","machine1","[4043722.877036]
> nvme nvme0: Device not ready; aborting reset, CSTS=0x1"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.941289]
> pcieport 0000:00:1b.4: AER: Multiple Uncorrectable (Non-Fatal) error
> message received from 0000:06:00.0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.942254]
> nvme nvme0: Disabling device after reset failure: -19"

And now it's going to drop writes too because the device is disabled.

> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969046]
> I/O error, dev nvme0n1, sector 86788096 op 0x1:(WRITE) flags 0x100000
> phys_seg 1 prio class 2"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969083]
> I/O error, dev nvme0n1, sector 464581888 op 0x0:(READ) flags 0x4000
> phys_seg 3 prio class 3"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969128]
> I/O error, dev nvme0n1, sector 45027984 op 0x1:(WRITE) flags 0x4000800
> phys_seg 1 prio class 2"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969127]
> I/O error, dev nvme0n1, sector 117882144 op 0x1:(WRITE) flags 0x1800
> phys_seg 8 prio class 2"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969146]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969146]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969163]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 4, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969160]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 3, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969167]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 5, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969167]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 6, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969179]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 7, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969179]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 8, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969184]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 9, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.969187]
> BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 10, rd 0,
> flush 0, corrupt 0, gen 0"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.972280]
> BTRFS warning (device nvme1n1p2): lost super block write due to IO
> error on /dev/nvme0n1p2 (-5)"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.972938]
> BTRFS error (device nvme1n1p2): fixed up error at logical 782844493824
> on dev /dev/nvme0n1p2 physical 237354287104"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.972957]
> BTRFS error (device nvme1n1p2): fixed up error at logical 782844821504
> on dev /dev/nvme0n1p2 physical 237354614784"
> "2025-11-10 01:46:35","notice","user","","machine1","[4043722.972960]
> BTRFS error (device nvme1n1p2): fixed up error at logical 782844821504
> on dev /dev/nvme0n1p2 physical 237354614784"




> Got it, I was running 4B2QJXD7 firmware on both drives when this issue
> occurred.  Recently, Samsung released a new NVME F/W update 7B2QJXD7,
> which they note "address(es) an intermittent non-recognition and blue
> screen issue."  I've flashed the drives to 7B2QJXD7 and will see if
> this issue recurs.

That's probably the proper fix. The only other thing I can think of is there's a quirk for this drive that the kernel doesn't yet have, and therefore see if kernel 6.18-rc5 behaves better. 

-- 
Chris Murphy

