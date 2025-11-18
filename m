Return-Path: <linux-btrfs+bounces-19110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE7C6B309
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 19:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10CBD36369D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B523612C8;
	Tue, 18 Nov 2025 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="bpcqGfXM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YuQoJh+W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B62D73B3
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490178; cv=none; b=nOOzzNSL8V1x3BHGtypkZ0+ZolAGzMHJTUeM72Cztu1x+7T+ZHb3HoUU4vhEpPlnM9GzqP2ad+k4gcEoi8OBdCcrC/ZderBZ/vfeLhPwhppIN9gIGKHZAWnVFlXmR1CdTSa1jrg87yBa6bRtRxsX/v/k6HbMrerttTtC2bcunc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490178; c=relaxed/simple;
	bh=7URgtmaT6XSXlhg2ThW9Wftzm3MBccPpHCb7drF6QW4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kdXTbkSFcYpfgmWojZB9ItisJiRsGPH6hMdAzbahtPTzIpTUNV8EzXa0WPfGjj1zVnnQRaHLdcaSFL3ZeSgX1sKNLaSnioi6zPwxRsjtiZwccBSuZUU74TuCJ/FkCDZOJObS8b0FJKCNn6q8BDs9sLNyGxQgsPhOL9LbUq/TMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=bpcqGfXM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YuQoJh+W; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7977E1D0033E;
	Tue, 18 Nov 2025 13:22:55 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Tue, 18 Nov 2025 13:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763490175; x=1763576575; bh=7URgtmaT6X
	SXlhg2ThW9Wftzm3MBccPpHCb7drF6QW4=; b=bpcqGfXMr7S12jjOeQL8PCjerr
	VxFD6of89YdnQQ5s6Sbaepvm3pZi7IPKTmXpsdNEDFQr+WGFZGWR0CiqBcJq5cEQ
	MJNGIugmvoOrLeb5AzX9W3kfFWbMpFA6MNgDFbS56zJZXlkb9ugYaYM5nhg7zB2X
	uI2uKTENDKZ5dE5+4jt35C5DRfSQSZk+lScmlTCW481dKAQh7rQQ9Hazi38RloZw
	coKN2mHzbbpLc+/eaqngTQeunkb6jzsxKmK9utO4ItVzqS5OdcxQc10QJNThSc5v
	Y6DkqYYtWJYpjB9iFq6BV0bTokQkFRwFo8fJzolTwwjK+xILn6FMLgBObeNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763490175; x=
	1763576575; bh=7URgtmaT6XSXlhg2ThW9Wftzm3MBccPpHCb7drF6QW4=; b=Y
	uQoJh+WlX3slK7NFaqUYxWVy/odt8L2SeX5ScFaKyQwJEm7gyb6uDMJpbuE7bWfY
	v4QOsGIip3xuZA/ihcaqabyOH2wHwwgL9cStA0YPivevgQ/3saztwF5+tfwhC8Nv
	APJQlNYTNVRL2r4DnlShbiKGG6Xw6CfOQhIi2VNVyGyca4bx7ui9SWUmnNrGxhdc
	M1pTXIyqMD/WgQF3Iz6ShIQNbnipk4ecGnL1aBG6m2YYng7iDhzTuZmmzwFzq8s1
	dgUDC8bqbTdrINRd/+5VurG5E9T6Rr0dW6O+4o8AO1af+MEZq/iaJRM27/9y8d8g
	hkbY2vAiC3lcnp5F7VkBQ==
X-ME-Sender: <xms:f7kcaSlTCFQQXDS6vVByK5bWHvMtg5AgiU_gTuL6MRIpLVX9uGz-UA>
    <xme:f7kcaUoSnVURJ9nQGhW23Kr5aIBpJA82oQlbsuObNzfyce6mrhFwJlSav0AV3Em9i
    vrAggTknU0z5wE2263_ZOWDzo6V_kgnV-aAcD-wpUMYTJ4ah0SrTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekhedtieejleeuleetvefgvefgtedvhfegtdejieffhffg
    tdeutdeljeevgfdvueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehunhhfrgdttdesgh
    hmrghilhdrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f7kcaXhJDokHwsfPCzTVdycRzv5cLvrzu01PttHeoOoqrqDxXrW-7g>
    <xmx:f7kcabybgeRcZOzgpVvj_KV7TUgzpTLfm_TUF70l1LGK9f6EdTatTA>
    <xmx:f7kcaaKyy8BPd0Lx0VUfobT_FDqRoOGbue7uWBCJFEwH6DDTYoXXVw>
    <xmx:f7kcaSQcIk0wWIUq2jozgnGxsvtVtMtV2eZkjMcehR3gFTFU2rRD0w>
    <xmx:f7kcacUt_ilaHiB9Gtp3l_up3BIcjH94itvZ7pCckkdv4X29IIIvYFGt>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E8BD018C004E; Tue, 18 Nov 2025 13:22:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9jZGU0JwjF3
Date: Tue, 18 Nov 2025 13:22:33 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>, "Qu WenRuo" <wqu@suse.com>
Message-Id: <4f3e3204-7a30-4a7f-841f-084acc8a9194@app.fastmail.com>
In-Reply-To: 
 <CAOsCCbNh-3GaW1bGTjBG-CjzpmjZMhbmt-fi9_vEUa8gqe8n2g@mail.gmail.com>
References: 
 <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com>
 <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com>
 <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
 <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com>
 <dab1f9d3-6b21-4df9-8217-faf1aff7ba0a@app.fastmail.com>
 <CAOsCCbMUnjo982rkUdjAsG6Q28AChMNQLQf7g1LDK1DNsgLUBg@mail.gmail.com>
 <1386ac4f-0154-4a3b-bc6f-d29e5296d71a@app.fastmail.com>
 <CAOsCCbNh-3GaW1bGTjBG-CjzpmjZMhbmt-fi9_vEUa8gqe8n2g@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sun, Nov 16, 2025, at 7:03 PM, Tobiasz Karo=C5=84 wrote:

> Here's the dmesg log of that mistakenly started captive test, and the
> aftermath (or lack thereof!):
>
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#11
> uas_eh_abort_handler 0 uas-tag 7 inflight: CMD OUT
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#11 CDB: Write(16) 8a
> 00 00 00 00 00 97 88 94 80 00 00 04 00 00 00
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#10
> uas_eh_abort_handler 0 uas-tag 4 inflight: CMD OUT
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#10 CDB: Write(16) 8a
> 00 00 00 00 00 97 88 90 80 00 00 04 00 00 00
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#9
> uas_eh_abort_handler 0 uas-tag 3 inflight: CMD OUT
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#9 CDB: Write(16) 8a
> 00 00 00 00 00 97 88 8c 80 00 00 04 00 00 00
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#8
> uas_eh_abort_handler 0 uas-tag 2 inflight: CMD OUT
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#8 CDB: Write(16) 8a
> 00 00 00 00 00 97 88 88 80 00 00 04 00 00 00
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#7
> uas_eh_abort_handler 0 uas-tag 8 inflight: CMD OUT
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#7 CDB: Write(16) 8a
> 00 00 00 00 00 97 60 5e c8 00 00 04 00 00 00
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#6
> uas_eh_abort_handler 0 uas-tag 6 inflight: CMD OUT
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#6 CDB: Write(16) 8a
> 00 00 00 00 00 97 60 5a c8 00 00 04 00 00 00
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#5
> uas_eh_abort_handler 0 uas-tag 5 inflight: CMD OUT
> [Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#5 CDB: Write(16) 8a
> 00 00 00 00 00 97 60 56 c8 00 00 04 00 00 00
> [Sun Nov 16 18:19:15 2025] sd 2:0:0:0: [sdc] tag#13
> uas_eh_abort_handler 0 uas-tag 9 inflight: CMD IN
> [Sun Nov 16 18:19:15 2025] sd 2:0:0:0: [sdc] tag#13 CDB: Read(16) 88
> 00 00 00 00 00 7c 44 8d a0 00 00 00 20 00 00
> [Sun Nov 16 18:19:17 2025] sd 2:0:0:0: [sdc] tag#14
> uas_eh_abort_handler 0 uas-tag 10 inflight: CMD IN
> [Sun Nov 16 18:19:17 2025] sd 2:0:0:0: [sdc] tag#14 CDB: Read(16) 88
> 00 00 00 00 00 7c 44 8b 20 00 00 00 20 00 00
> [Sun Nov 16 18:19:30 2025] sd 2:0:0:0: [sdc] tag#4
> uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
> [Sun Nov 16 18:19:30 2025] sd 2:0:0:0: [sdc] tag#4 CDB: ATA command
> pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
> [Sun Nov 16 18:19:30 2025] scsi host2: uas_eh_device_reset_handler sta=
rt
> [Sun Nov 16 18:19:30 2025] usb 4-1.2: reset SuperSpeed USB device
> number 7 using xhci_hcd
> [Sun Nov 16 18:19:30 2025] scsi host2: uas_eh_device_reset_handler suc=
cess
>
> Also - it seems I have managed to get a complete long test (offline,
> not a captive one!) thanks to the while-dd-sleep trick. It is clear to
> me that it was necessary to use that. I wonder if I should keep that

Sounds like a bad hack, as in, you can't rely on this and shouldn't have=
 to. There's a bug somewhere. I'd retest with mainline and then go shop =
the problem on the linux-usb list and see if they have a quirk to use or=
 can incorporate a better fix into the kernel. This is not an area of ex=
pertise of mine - so it's better to defer to usb upstream.

What I can tell you having experienced similar USB problems with SATA-US=
B enclosures, all problems were resolved by using a good quality (not ex=
pensive, but properly spec'd) USB hub. For whatever reason directly plug=
ging in USB devices into the port on a computer - which itself is a kind=
 of hub - was inadequate.



>> I'm not sure about that. Btrfs has no optimizations for write order b=
ased on device topology whereas the drive firmware knows things about th=
at topology and can acceptably do out of order writes for performance re=
asons that are quite safe.
>
> That's most intriguing. I was told in the past (2015?) that btrfs's
> filesystem integrity depends on the order of write operations being
> preserved.=20

There's different kinds of ordering.

There's many separate read and write commands when writing out data from=
 a variety of sources. The vast majority of these can be reordered by th=
e drive firmware for topology reasons. But when Btrfs issues a FLUSH or =
FUA to separate metadata (b-trees) writes from super block writes - that=
 *must* be honored.=20

Btrfs doesn't care if the drive reorders writes within the bracketing pr=
ovided by flush/fua.


> But does that mean the initial assumption about the dangers of btrfs
> cached write reordering is wrong?
> Or maybe that was a general problem with btrfs's atomic updates, but
> is no longer the case?

I'm not super familiar with bcache writeback mode but if metadata and su=
per block writes only persist on the SSD, and do not pass through to the=
 HDD, then it is not possible to separate the SSD and HDD - the HDD alon=
e is not in a consistent state. So following a crash in writeback mode, =
it's a requirement that the combined block device (SSD+HDD) are assemble=
d and that bcache device is what gets mounted.

I think where people went astray was not realizing there are critical wr=
ites only on the SSD and then decided to mount or repair the btrfs on th=
e HDD alone. But like I said, not super familiar with that issue.



--=20
Chris Murphy

