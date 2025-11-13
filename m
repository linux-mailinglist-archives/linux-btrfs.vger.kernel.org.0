Return-Path: <linux-btrfs+bounces-18929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98AFC5540F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 02:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643B23A601E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51428265621;
	Thu, 13 Nov 2025 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="V4qukhNa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zjnUMh6d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6E191F98
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997298; cv=none; b=d9TiDrbUu8eqVSi7nDyCn2S0peKJaaG9N354nvveMf6XCI6mhTXNxMkeYGAuxx/taQpvnjCZQ9iddr6vrXlK24n2/NwgjCiNFzE5VIsBxTRw4pLpd/TrbX9FCcyA6pJr/8GeYqm4PsyDIKK/PvLoXEJzYD8jahV7X/laABMRA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997298; c=relaxed/simple;
	bh=HM0K0bMzG9lABc8UsUR6LbAVGGCU+MqLb1bWAG6fr+M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cS2DQhFDNptH6KSN3eDfQ9s/8qxHrMxVM0NVGou4GWIbdn0hqOQW4ozd/eJ6xQTtRBN/RTFMsfDoKhRLkryyulqByb4VcKmIgTyjxuo+IwE3FVQDeFL83DDlZ50IsdL1h92vMeB8PB4ggwewUaWACyCiuAJycsPZ/auCFSMmduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=V4qukhNa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zjnUMh6d; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B9697A0101;
	Wed, 12 Nov 2025 20:28:15 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 20:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762997295; x=1763083695; bh=r/UnhC9lts
	cDEO24CooTgQw8ng5i9wVdH35YAV2qnVU=; b=V4qukhNacVDhj/izB1kigo49d4
	hW5UbA4qnouFP6Lnov9RquctBLUB67zE6SOfD0DxnJi99eywkso0lXj47GNc2krj
	U7M9ZB8iefR7jHNxk6YCwuyPNNY4KKe/Hb8N8m8GVzc3mPTYroEx9biTBmcA7iBI
	ZOZyAgMfwtImTDMyiQ0aEU6GI+vieGIXu2SVL83Kwvw0R/bg0NXrjZTd6Arr/ElI
	2cSOwX4dk+AHlQSYg3cXSugYkJNjoP0DycIywdh3uf0U/XaONxtX9fXtPIk8mPBo
	+UDWxT96/Y34I1bMzuKVRGR6iysrS1OLN3rFsRPRO1wVUclFY6fhVFE9JNoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762997295; x=
	1763083695; bh=r/UnhC9ltscDEO24CooTgQw8ng5i9wVdH35YAV2qnVU=; b=z
	jnUMh6dKZW+0AXBjWiR+MiOPFUlkCVBaW0SWPjlnhdP4uN8vYRlhXIVjMKC70W5Y
	CfYqtScAoEWrVjrp9aX9LgW8/h/gOIKkCeGXmsYhId6TSMEsXs0KG/bkodIrWDmb
	ewI/th/6R2CtrzcjfE1dCXRnnoEPHCDGdRDu8WuhIm4D3fxZ7/gKYhw4+T4CFOcc
	RN6er20JNTUKszf1Qzd4pInGzP4CW+h14VvX9offcpOv65zf7BWX7rpwnbO+3B97
	uWcwS+uRGi9h+osesPZUgyL5w4QYmYQzJOIKKQ4sL0AhReTV7SeDu6tZgyFGz1cw
	XfzvaRE0U03lAtWoiMObw==
X-ME-Sender: <xms:LzQVaQIQCl-yEf-3C3mr9m_pBQFoC6xMQMuAxyD5aPUv9zIGcVc0OA>
    <xme:LzQVaa9wEds0eCTS1d3jjYW-DTMP-CqTFv_HVYFt6qJUCksllhcKXCQ8FmltDSr5b
    AmU0_ZzvopkXYEBLwYNd_8WCvSxF5hoVsSu7tdY43chMks1ylHkJ00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeettdfhudfhhffgjeejuefgtdejvdeihfekhfeuheejgfdu
    ieejtdfhudeifeegveenucffohhmrghinheplhhinhhugidquhhssgdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegt
    ohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehunhhfrgdttdesghhmrghilhdrtghomhdprhgtphht
    thhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LzQVackt0c8Oc9TShO7EgXmjups-SFB6ustcTB_7jfbSpM9UmF_JEw>
    <xmx:LzQVaTmYSdcsolN9OemNTi3lDeunq4TAl6D1b0NZHL26-QEcGncG-A>
    <xmx:LzQVaduBBvZGCg-CXS2AGvrV_yQ2vZFW8Z3ru2bRVoRv_O8iZbu4qg>
    <xmx:LzQVaWmN5UM_5O8kE07sgoB8ERciyYchoOTuvyO_XA-X6vJe2tzO9Q>
    <xmx:LzQVaTZE8mxT7Si-_vAaH7Jt61Zpz6GHP5DNjtkStc4RRzBeJPj1Uehq>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 13BA718C004E; Wed, 12 Nov 2025 20:28:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9jZGU0JwjF3
Date: Wed, 12 Nov 2025 20:27:54 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>, "Qu WenRuo" <wqu@suse.com>
Message-Id: <1386ac4f-0154-4a3b-bc6f-d29e5296d71a@app.fastmail.com>
In-Reply-To: 
 <CAOsCCbMUnjo982rkUdjAsG6Q28AChMNQLQf7g1LDK1DNsgLUBg@mail.gmail.com>
References: 
 <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com>
 <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com>
 <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
 <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com>
 <dab1f9d3-6b21-4df9-8217-faf1aff7ba0a@app.fastmail.com>
 <CAOsCCbMUnjo982rkUdjAsG6Q28AChMNQLQf7g1LDK1DNsgLUBg@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Nov 12, 2025, at 7:57 AM, Tobiasz Karo=C5=84 wrote:
> I have been trying various things, also with other drives.
> I purchased a 20 TB Toshiba drive and I am currently attempting to do
> a burn-in before using it for backup.
>
> I see issues with the USB exclosure, where it resets ev en with jsut
> this one drive in it (so one bay is empty). Dmesg says:
>
> [Wed Nov 12 11:09:31 2025] sd 2:0:0:0: [sdc] tag#19
> uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
> [Wed Nov 12 11:09:31 2025] sd 2:0:0:0: [sdc] tag#19 CDB: ATA command
> pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
> [Wed Nov 12 11:09:31 2025] scsi host2: uas_eh_device_reset_handler sta=
rt
> [Wed Nov 12 11:09:31 2025] usb 4-1.2: reset SuperSpeed USB device
> number 7 using xhci_hcd
> [Wed Nov 12 11:09:31 2025] scsi host2: uas_eh_device_reset_handler suc=
cess
>
> [Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5
> uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
> [Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5 CDB: ATA command
> pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
> [Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler sta=
rt
> [Wed Nov 12 11:11:01 2025] usb 4-1.2: reset SuperSpeed USB device
> number 7 using xhci_hcd
> [Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler suc=
cess
>
> That happens after a minute wheenver I do:
> smartctl -l long -C /dev/sdc
>
> So it seems I can't do a long, captive HDD test through this enclosure.

       -C, --captive
              [ATA] Runs self-tests in captive mode.  This has no effect=
 with '-t offline' or if the '-t' option is not used.

              WARNING: Tests run in captive mode may busy out the drive =
for the length of the test.  Only run captive tests on drives without an=
y mounted partitions!


Maybe use -t long and omit -C


>
> I have tested blacklisting the uas driver, but the enclosure would
> just not show up (should I load an alternative driver for it?)

usb_storage


> lsusb says this about the 2-bay disk enclosure:
> Bus 004 Device 007: ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA
> 6Gb/s bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
> ASM1153E SATA 6Gb/s bridge
>
> I wonder if there's something that can be done about this enclosure in
> terms of patching the driver or something?
> Should I contact a different mailing list?

linux-usb@vger.kernel.org

http://www.linux-usb.org


> About write cache disabling, I was unable to do it persistently with
> hdparm, but I found that there's a way to disable write caching
> persistently with smartclt. It's also possible to disable write cache
> reordering, which I suppose could be more dangerous fro Btrfs.=20

I'm not sure about that. Btrfs has no optimizations for write order base=
d on device topology whereas the drive firmware knows things about that =
topology and can acceptably do out of order writes for performance reaso=
ns that are quite safe.=20

Granted, the code for these settings is not available fo us to inspect.=20


>
> Same with short self-test. I wonder if I can use this disk in the
> enclosure at all if this keeps happening...

I just wouldn't use the captive test.



--=20
Chris Murphy

