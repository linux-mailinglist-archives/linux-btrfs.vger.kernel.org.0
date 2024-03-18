Return-Path: <linux-btrfs+bounces-3371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F087F1F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4F282665
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5858225;
	Mon, 18 Mar 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jnyPN+Js";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6qCqtLG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4D57326
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796950; cv=none; b=Q3s9a7js4lmfv43j5QT6ZPVrDT7LE4/X0nuIRxqH5mRSmLycdR/jkyCr7LudLrKpZHXGyO+5cVPffxWFoDzeuLO53yjE4TewYK/XGlKwcs37S9wKcaW7fXbP53m3hRAFRFdbYTWNNx7FFUL5Im0hK2xTwpbJTlfXYMipgnTyS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796950; c=relaxed/simple;
	bh=+B7R3PEENbr+wb5E7PkiS0oo9XgFOdiU4+d2SpcMK/4=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=C9wnKUyyOrJVfftF0AaUgyDnaeMJW4iaeBGAJvnsh2LWc7a5BxYtpcKUocEvR0W5xqi4Gnbg5xZt+aZxeOqu3/rhkzafCkDF78JVWwifFZvbUU9N7/Hzg/dhFt4P9324ue3Fm0LeCA7EFezdqR1mZ6jyE03zvH3o4p5l/t1whMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jnyPN+Js; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O6qCqtLG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 90A17138008A
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 17:22:27 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 17:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1710796947; x=1710883347; bh=KamRSZq1pmMvyEooko2DvzQR29BHvdC9
	tPXYVf6jp9M=; b=jnyPN+Jsrur+mWQ/Bvmw8h+M8QNg3Mf2jjiWK066ZRZCtLAs
	xANqy5ov3FG9rslEHJZ6aU5OhTQVIODfNMVAs343ssHirYLZsnABGSnDeRHwPepw
	J6FZpFVqVP/iwkdpwqhpEkfyHg2aLQmsn1vDjIfxxGmGyC2J9gwYd6bwJs+eL5do
	D1oaOnb9ud3DRnM2nErhzFYhf9kEm5094CEHbs9gG0xZkoQYxtPr0u4b3CIOusJ8
	DOXeEhopTKzs8YegM8auqKJ4d9grkqb05Rn9FPDuVObIASCK+If6v66ljttq0/kE
	TyxYSD5U6fzD+nW3JRZ6srKdFAWq26uHdMluwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1710796947; x=1710883347; bh=KamRSZq1pmMvyEooko2DvzQR29BHvdC9tPX
	YVf6jp9M=; b=O6qCqtLGsBWgkw7GFakyWWOMq7W72HZhm5pQNX4rsqF/fEg1vvq
	fZyVZkKtyqfS7J8zWDTDzlxRVwvmr7rbHKfakZA7m38haBq1iC0BayNeJxSQCWzi
	+kGOWag6eiu4ZSo/JUmtxKAs4RMhidmIGfDYkr1BI9owYFAwVEho2zNWknHfpuPz
	n5KeN+Lyfe8b7b3Bz7zWXufuoZgdLtyjCsAriu8O+8ifuRA5ZxmKH9fiT98IflpC
	wDIrG4U/DAonEaOm/AXniZwb1qwI7HqH6Z6yqx5ReA6jYlIYciXeWcj1qWacPijT
	zubXFrA12o2I8SnhU8L32qcH0CGnm/dvF4Q==
X-ME-Sender: <xms:k7D4ZQ5a9LSVI0nGmHZ4Qh3VUNzaZ6Ew1yfFW9fvx_0NaIBfQ0ZQ_g>
    <xme:k7D4ZR4I0QUzkceZYya4udns-taXVB0aBXNhImlQqFDjkrLBBiPZVxg1pDnwTxgO4
    DXBPbfKDVJ_FuXr2TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpehkihhnugdrmhhoohhnudekiedvsehfrghsthhmrghilhdrtgho
    mhenucggtffrrghtthgvrhhnpeeggfffieehieeugfelledvfffgkeeghfekgffhhffhfe
    fhheffvddukeejveehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkihhnugdrmhhoohhnudekiedvsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:k7D4ZffAU74L9LSYCcSlPpLF3ai7dIZ6RUEYvXebJaVulWAi4rj1bQ>
    <xmx:k7D4ZVJ_nqO9-4Mq0dZT-lCW38OfRbFyJLWYsXc8xuxm8Wx5q5L_mA>
    <xmx:k7D4ZUKmu8hnZqT5NBkRXxDC1LEsmvi9egoXtscVirdQayBoOjKjrA>
    <xmx:k7D4ZWyyAxGNyJLaPzeW-O2MOjK8xNQ3w8g5MTGeBEZzhRKax-e2UQ>
    <xmx:k7D4Zehis_jIXQaRwlOaoT2yXcIee5z4XYgHanFvApLjPM30v2Dm7g>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5931036400B1; Mon, 18 Mar 2024 17:22:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37de8ead-fefa-4fab-a0ed-bbdb2bf15cf4@app.fastmail.com>
Date: Mon, 18 Mar 2024 14:22:07 -0700
From: kind.moon1862@fastmail.com
To: linux-btrfs@vger.kernel.org
Subject: Help requested: btrfs can't read superblock
Content-Type: text/plain


Dear btrfs team,

I've been asked to help someone with a btrfs problem.  They use CentOS 7.  I've been told the host was shut down cleanly, but it won't mount a btrfs filesystem when powering on.

Below is what I've done so far.  Any guidance would be appreciated!

I booted using SystemRescue 11.0.  Some info about the rescue OS:

# uname -a
Linux sysrescue 6.6.14-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 26 Jan 2024 11:54:58 +0000 x86_64 GNU/Linux

# btrfs --version
btrfs-progs v6.6.3

Here are the disks:

# btrfs fi show
Label: '<redacted>'  uuid: 834b4bfd-fbd4-40b9-8868-d1187c3c5a63
	Total devices 4 FS bytes used 17.44TiB
	devid    1 size 9.10TiB used 8.94TiB path /dev/sda
	devid    2 size 9.10TiB used 8.94TiB path /dev/sdb
	devid    3 size 9.10TiB used 8.94TiB path /dev/sdc
	devid    4 size 9.10TiB used 8.94TiB path /dev/sdd

I tried mounting:

# mount -t btrfs -o recovery,ro /dev/sda /mnt/data
mount: /mnt/data: can't read superblock on /dev/sda.
       dmesg(1) may have more information after failed mount system call.

dmesg shows this:

[ 1940.962632] BTRFS info (device sda): first mount of filesystem 834b4bfd-fbd4-40b9-8868-d1187c3c5a63
[ 1940.962665] BTRFS info (device sda): using crc32c (crc32c-intel) checksum algorithm
[ 1940.962686] BTRFS warning (device sda): 'recovery' is deprecated, use 'rescue=usebackuproot' instead
[ 1940.962692] BTRFS info (device sda): trying to use backup root at mount time
[ 1940.962698] BTRFS info (device sda): disk space caching is enabled
[ 1942.115796] BTRFS critical (device sda): corrupt leaf: root=2 block=11438351450112 slot=170, invalid key objectid, have 5822947745796 expect to be aligned to 4096
[ 1942.115819] BTRFS error (device sda): read time tree block corruption detected on logical 11438351450112 mirror 2
[ 1942.116170] BTRFS critical (device sda): corrupt leaf: root=2 block=11438351450112 slot=170, invalid key objectid, have 5822947745796 expect to be aligned to 4096
[ 1942.116183] BTRFS error (device sda): read time tree block corruption detected on logical 11438351450112 mirror 1
[ 1942.116212] BTRFS error (device sda): failed to read block groups: -5
[ 1942.140369] BTRFS error (device sda): open_ctree failed

I tried to recover the superblock:

# btrfs rescue super-recover -v /dev/sda

All Devices:
	Device: id = 3, name = /dev/sdc
	Device: id = 2, name = /dev/sdb
	Device: id = 4, name = /dev/sdd
	Device: id = 1, name = /dev/sda

Before Recovering:
	[All good supers]:
		device name = /dev/sdc
		superblock bytenr = 65536

		device name = /dev/sdc
		superblock bytenr = 67108864

		device name = /dev/sdc
		superblock bytenr = 274877906944

		device name = /dev/sdb
		superblock bytenr = 65536

		device name = /dev/sdb
		superblock bytenr = 67108864

		device name = /dev/sdb
		superblock bytenr = 274877906944

		device name = /dev/sdd
		superblock bytenr = 65536

		device name = /dev/sdd
		superblock bytenr = 67108864

		device name = /dev/sdd
		superblock bytenr = 274877906944

		device name = /dev/sda
		superblock bytenr = 65536

		device name = /dev/sda
		superblock bytenr = 67108864

		device name = /dev/sda
		superblock bytenr = 274877906944

	[All bad supers]:

All supers are valid, no need to recover

I checked the filesystem:

# btrfs check --readonly /dev/sda
Opening filesystem to check...
corrupt leaf: root=2 block=62421692628992 slot=7, bad key order, prev (7275590123520 168 11227136) current (7258421481472 168 10948608)
corrupt leaf: root=2 block=62421692628992 slot=7, bad key order, prev (7275590123520 168 11227136) current (7258421481472 168 10948608)
corrupt leaf: root=2 block=62421692628992 slot=7, bad key order, prev (7275590123520 168 11227136) current (7258421481472 168 10948608)
corrupt leaf: root=2 block=62421692628992 slot=7, bad key order, prev (7275590123520 168 11227136) current (7258421481472 168 10948608)
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system


