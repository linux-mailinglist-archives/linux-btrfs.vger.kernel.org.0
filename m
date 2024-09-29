Return-Path: <linux-btrfs+bounces-8314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB49896B0
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Sep 2024 19:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14A31F225F4
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Sep 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D743AAE;
	Sun, 29 Sep 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="L7AGiogX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1q5V8V9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258641A8E
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Sep 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632611; cv=none; b=V08nSXCmrIEN1WUNaL1oMkTjolsESVxtHQWbQ2MmLyJEBUP/gvs5U/K8eAqJz05OrzQbjlUVyiUKoElDHbkOpPeldHJUI9boYFaapxXDiPFy7Fbr0ijnn7B69wmNRbAW4kSmFkzsKv0Sn0oE0PfA7ZLq7Fq/xpT3Qxu2LAiK8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632611; c=relaxed/simple;
	bh=Xr0XAc6QKj1WVdcz4G4G+i6Zpe+QxywruGviKhE8/Nc=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=lzHOIR1Keyue8QUiFNWwPlw+16GbjQoAgSRu6dHxIxyW9N7Hl8W8oQzq+65vmN5Z89idJCPerz/zh8NU2JmgdELMZjvgVMPwTt4kGckAHdEZyICXwG/KDlZ7QW7sddHy3cwT5+jVy2ZWhcZxNzmrBOsr9wsooxQl0voRFTWoEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=L7AGiogX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1q5V8V9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2583B11400EA
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Sep 2024 13:56:48 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Sun, 29 Sep 2024 13:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1727632608; x=1727719008; bh=FfKsKoC07Lif1wMDIZmDLD/QK+2EcGD5n+W
	Gj8OBGnw=; b=L7AGiogXiXce8Ej+yNcLhy486L+B5Puwh0e+84InBV1wTshzqKm
	JhlVF5nQ/733pM0vekW/jjHX2nOH9I8NqDCGtpF1K+Nw3WJOZeR5WDFr4TB5EHCH
	qjg0lyfqLZ801Q3GMnPqAkP0Pe3tOitNO581JP1j2h42mG5zEpvu8pvpz8/swuNq
	i+hr+F5sJ8B4yMWZPDJ4vwqn99LC18CMVWsXPf9OASzZwEZRKa1YICEel7uFSGkK
	I9xAC4mqYzTQlVQAkNysUHP3TgFctHKqTxs7lirmgcXQbWVQf/PEYoGZ4xnrnc44
	gnDNNa3U5KWelnhp9DFQL2GDM4wxAhCJJfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727632608; x=1727719008; bh=FfKsKoC07Lif1wMDIZmDLD/QK+2E
	cGD5n+WGj8OBGnw=; b=G1q5V8V91tWbZt3nsWVT9qZ9JAE0QvpkQMyGp4Algqgc
	o81pnUFOnnqZFLWz1ZHn5MDzKjvVMW5hxMYw7+6leuiloUQdqAHsNG5mao1BVZft
	Gcew12KkY2UMSHiMeUeWeOV0qpcqTAFBZWdQ/cfCQAwqPYWyNWgIZbV4LBkSDYBb
	T7BxJaOixbcMPGMJLMpcByAww4NPOPJr1QLOUbjVnU96cAD5ddbCxNJjJ6IxxSzc
	iipOy1yqf+WoctMHjvrRVQZWEJQTz+RlhG2aAv2Fz3BPxE3yQEypJ6iJeBy9YWtx
	zN8rdrbyHs+hj3tfvMwgob5pY6P9qxgpa9ThH5tDqA==
X-ME-Sender: <xms:35T5Zq7a3bCH-BMuE9rV8YEbVmQINnF9lYDNiaRsPGeZOkECcZf7rA>
    <xme:35T5Zj6MTGWxCkJI9dza8CrRW8J67zheyH1RAAv61GwXVoE6qYjHk9wd4dG3n4NqJ
    qNz5b4PtcA7c1UWpCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddufedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkffutgfgsehtjeertdertddtnecu
    hfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmh
    gvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeevjeeltdefffegvdeggedtvedt
    fefffeelffdtteffgeffjedttdejkeelvedutdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghs
    rdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:35T5ZpfCH-z_8j_L7AXQLOUtPJo8g_HbXYHRGLDJKuk-KI3c5xru0Q>
    <xmx:35T5ZnLwcKwGym0Enx2Dx_7kpktnvSwsdwjwE7N_RldDDscNGjOC-Q>
    <xmx:35T5ZuKQeKXsvySQDsntjQnqmpqFe3D5AocmCtvGe4tHQ35Uh-hkNg>
    <xmx:35T5ZoxYv9PhnlrwNnv9Z5MZRj9jncuwtkU-J5Wpcyi0ZrlD9bzbDw>
    <xmx:4JT5Zoz7EzvnD_lKfGdsmI-eMrHANdE96a7aF_g3Wftg3uZD91D31mqH>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D985C1C20066; Sun, 29 Sep 2024 13:56:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 29 Sep 2024 13:56:27 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <e3cb3a38-32a2-4b91-9512-4703f7c5a73a@app.fastmail.com>
Subject: 6.11.0, possible regression resuming balance
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

kernel 6.11.0
btrfs-progs 6.11

I think there's a regression in balance resume. Both automatic (mount time) and manual (btrfs command line) are affected. The balance command immediately exits with 0 status in kernel messages, i.e. the kernel thinks it should resume but then just exits.

Example 1 is a balance running, interrupted by a power failure, and then resumed on next mount.

The original balance command:

$ sudo btrfs balance start -dvrange=100962140160..1325128482817 /mnt/first

...
[207090.400019] kernel: BTRFS info (device dm-0): relocating block group 996496375808 flags data
[207126.164580] kernel: BTRFS info (device dm-0): found 19 extents, stage: move data extents
[207130.579625] kernel: BTRFS info (device dm-0): found 19 extents, stage: update data pointers
[207132.733915] kernel: BTRFS info (device dm-0): relocating block group 995422633984 flags data
[207174.119093] kernel: BTRFS info (device dm-0): found 19 extents, stage: move data extents
[207177.504472] kernel: BTRFS info (device dm-0): found 19 extents, stage: update data pointers
[207179.227876] kernel: BTRFS info (device dm-0): relocating block group 994348892160 flags data
[207226.481484] kernel: BTRFS info (device dm-0): found 26 extents, stage: move data extents
[207232.177170] kernel: BTRFS info (device dm-0): found 26 extents, stage: update data pointers
[207252.918904] kernel: BTRFS info (device dm-0): relocating block group 993275150336 flags data
[POWERFAILURE]
...
$ journalctl -k -o short-monotonic --no-hostname | grep -i btrfs
...
[ 7933.811228] kernel: BTRFS: device label first devid 1 transid 28265 /dev/mapper/first (253:0) scanned by mount (1231)
[ 7933.813593] kernel: BTRFS info (device dm-0): first mount of filesystem fddd56d3-8eb0-4841-af2d-4f722fdffeaf
[ 7933.813753] kernel: BTRFS info (device dm-0): using xxhash64 (xxhash64-generic) checksum algorithm
[ 7933.813824] kernel: BTRFS info (device dm-0): using free-space-tree
[ 7942.065893] kernel: BTRFS info (device dm-0): checking UUID tree
[ 7943.116362] kernel: BTRFS info (device dm-0): balance: resume -dusage=90,vrange=100962140160..1325128482817
[ 7943.132048] kernel: BTRFS info (device dm-0): balance: ended with status: 0

(993275150336-100962140160)/1024^3=831GiB and the vast majority of those are >90% full, a few are <50% full.  The kernel message for resume at [ 7943.116362] appears on its own, I didn't prompt it manually with a resume command. So the kernel detects that resume is indicated, but then ends immediately.


Example 2 is the same file system. I paused the balance, then tried to resume it but the same thing happens.

$ btrfs balance start -dvrange=100962140160..1325128482817 /mnt/first

[187020.876597] kernel: BTRFS info (device dm-0): balance: start -dvrange=100962140160..1325128482817
[187020.944695] kernel: BTRFS info (device dm-0): relocating block group 1325128482816 flags data
[187047.993704] kernel: BTRFS info (device dm-0): found 576 extents, stage: move data extents
[187050.773509] kernel: BTRFS info (device dm-0): found 576 extents, stage: update data pointers
[187052.242351] kernel: BTRFS info (device dm-0): relocating block group 1324054740992 flags data
[187099.305246] kernel: BTRFS info (device dm-0): found 53171 extents, stage: move data extents
[187130.645529] kernel: BTRFS info (device dm-0): found 53171 extents, stage: update data pointers
[187136.587658] kernel: BTRFS info (device dm-0): relocating block group 1322980999168 flags data
[187178.681986] kernel: BTRFS info (device dm-0): found 25 extents, stage: move data extents
[187181.168150] kernel: BTRFS info (device dm-0): found 25 extents, stage: update data pointers
[187182.283792] kernel: BTRFS info (device dm-0): relocating block group 1321907257344 flags data
[187191.382548] sudo[7025]:    chris : TTY=pts/5 ; PWD=/home/chris ; USER=root ; COMMAND=/usr/sbin/btrfs balance pause /mnt/first
[187215.318442] kernel: BTRFS info (device dm-0): found 12 extents, stage: move data extents
[187217.044154] kernel: BTRFS info (device dm-0): found 12 extents, stage: update data pointers
[187217.382086] kernel: BTRFS info (device dm-0): balance: paused
[187288.869557] sudo[7055]:    chris : TTY=pts/5 ; PWD=/home/chris ; USER=root ; COMMAND=/usr/sbin/btrfs balance resume /mnt/first
[187285.581049] kernel: BTRFS info (device dm-0): balance: resume -dusage=90,vrange=100962140160..1325128482817
[187285.596390] kernel: BTRFS info (device dm-0): balance: ended with status: 0
[187311.081127] sudo[7060]:    chris : TTY=pts/5 ; PWD=/home/chris ; USER=root ; COMMAND=/usr/sbin/btrfs balance resume /mnt/first

The 2nd resume command results in no kernel message, but a message on CLI "ERROR: balance resume on '/mnt/first' failed: Not in progress"

So it really seems like resume isn't working? 



--
Chris Murphy

