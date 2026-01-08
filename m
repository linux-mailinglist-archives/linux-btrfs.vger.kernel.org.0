Return-Path: <linux-btrfs+bounces-20308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 265CAD067A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 23:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AECC30255A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 22:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78832F740;
	Thu,  8 Jan 2026 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="cTtdhUoY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rmjZBYCx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B482EFDBB
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912768; cv=none; b=B1huwFaWp1VCB8SvbCbimUFqZAODkuqU6RGzL7EMoUVTprmKhv4FkiqQwcJmyHuEZZDrqmg/gl/n/jhhFvhb8zT9WbVS61MIwMgy6Uo/waOr6VAS3olpPhdNEjYW5Sqhss8cAqL7U5SKXU0OdjLGta7QfRxFv4VVhsSCW8y041g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912768; c=relaxed/simple;
	bh=ISIOqyCDNpohJ5vBC+Zu4TOXW7pGttpIBDaiU0bJVEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEsmsfpinoHTMuBXo64lIwpCd1CO0YfYZBJ86oyuivYPqTjHC4I6aHuSqdCvxctotS/xrxpf9UJBdIWKo35DmHVaRqO2ZvLkCrxGtUXWKRbjqGDAwsqeNDjpUGeOfdX2wC+DFaYr2wfomK+hjLKGYiDQgcr7FnJIFglwTYXZY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=cTtdhUoY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rmjZBYCx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2EC3D7A0083;
	Thu,  8 Jan 2026 17:52:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 08 Jan 2026 17:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767912766; x=1767999166; bh=6EK6y8nqFp
	TJ1KrBTg8jeEYgS3UG+4lGumzUYk+qQlk=; b=cTtdhUoYr4uhxnVnvpO1luwllp
	jq44ykH1ouyYsiBZQDoNRrN2A8lEvjqUneIILVxoM7AWBge/PtSkFRTCtxpWQHkY
	BM5YU0sdFmYFF2e38YdjIFqUOyNxPXgBkzAQtQmlWwESYi6QFn9f/b09K36pX9w3
	JJsz3O3oqomzzAv4nH4ov9E+wOjeDFkP/3EyY1zIha/+e2cL2PiMU+Eyq3aZs/Un
	CRTec01GgEM7rXuyRuMASowFW17khwMZVxxNU3Gauj+ICWeTZS6WioHWRoY6Q/nq
	HgleKhfPkqQIlartm5tI2F0By/AhITiQk3LeL8iibYhopLJ48wVtE9dcxaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767912766; x=1767999166; bh=6EK6y8nqFpTJ1KrBTg8jeEYgS3UG+4lGumz
	UYk+qQlk=; b=rmjZBYCxSzBEhXgFQocRPDKnOecb/8wgbcqu2fcr1HTs02Q74D3
	lnxEzbDTiJ8cWd/TX5iY4l+7ScCmn/1wEOcwn1TXhmX4M/vrCmkmTib+Lnig3gdG
	0GdRsDKLiBs0RIf0H84PTUCJKODbMSaA6ZJrSmCCZyyquAtxAwvazijU9iSjcwhU
	uhWn35XeoMFGraCu7jekJ2Vmx5ZndZz0pN7wONcW1oL0cv5aHu8stVZuyJmuSVoc
	j8ejaXjaGBCgSPlLu8TMKjdYepOYKePGX1VBN96kal3U6n/K2UI4tV95F8FvP580
	MQhFRVnUlmi2JQFdv7EN0+Uqx26uSyyhHeA==
X-ME-Sender: <xms:PTVgaVg2pOjdSjyuuKkh1EOf5F48O4K2gXa6Il0poakfqDC_5L6eIg>
    <xme:PTVgaQDTcdhrJypoqYnsiXFsQznvpqEQvfuDDtO-Zs7LBVmhksUSkCY3V103tYgOj
    mCQt1fXIOnx17c6t1qgUYywmmaB4ZLFnFHgM4AcoCRdAPV07_tOT6Q>
X-ME-Received: <xmr:PTVgaSvNUSRDQFJuvoyIlTH1-wNWcX9l_d5V4lKiDt0UxuGQDufj_1HqSLWKUyzueSprrWk1nGM-SSnlIyDjY1hP4Co>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephfefffehueeihffgfeehgeevfeejleevgfehveduge
    dvkeefgeetueegffdvieeunecuffhomhgrihhnpehlrghunhgthhhprggurdhnvghtpdhr
    vggrughthhgvughotghsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhimhhishesghhmgidrnhgvthdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PTVgaVZGp4qQ63OoPJad5Hw1Z-JiEBscYOI0DKNzzhB0ca9xln2iNQ>
    <xmx:PTVgaVW0eKdCCQUTYF0adp8CSbutt4uzPb1pDK5Eh4QRqHz7NMqKTg>
    <xmx:PTVgaZ4RXVJUhMRjgDTc35iU40NInFDF5BvcwdeUT96P7sX8kxu81Q>
    <xmx:PTVgaQgnsczOBjs2RORK0LiWDN1avDutzrAQ6MxoGJ_jlFQ_NEOtTg>
    <xmx:PjVgaSHLsPe3-0p3iTNgmKJ0MGq03LQUZxkaTPU9YWTyyFDs90oOGviz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 17:52:45 -0500 (EST)
Date: Thu, 8 Jan 2026 14:52:54 -0800
From: Boris Burkov <boris@bur.io>
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: error in btrfs_create_pending_block_groups:2788: errno=-17
 Object already exists
Message-ID: <20260108225254.GA2633085@zen.localdomain>
References: <q7760374-q1p4-029o-5149-26p28421s468@tzk.arg>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q7760374-q1p4-029o-5149-26p28421s468@tzk.arg>

On Thu, Jan 08, 2026 at 03:53:17PM +0100, Dimitrios Apostolou wrote:
> Hello list,
> 
> I got an error while copying recursively (cp -a) several TBs of GB-sized
> files, from an old zstd:3 compressed btrfs filesystem, to a newly created
> same-settings (zstd:3 compressed) btrfs filesystem. Error happened after
> many hours of copying, without any issues or log messages before that. No
> hardware errors were logged either.
> 
> OS: Ubuntu 24.04 with HWE kernel 6.14.0-37-generic.
> 
> The kernel source code should be about this one here:
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/noble/tree/fs/btrfs/block-group.c?h=hwe-6.14-next#n2788
> 
> 
> Mkfs output:
> 
> # mkfs.btrfs /dev/sde
> btrfs-progs v6.6.3
> See https://btrfs.readthedocs.io for more information.
> 
> Performing full device TRIM /dev/sde (10.00TiB) ...
> NOTE: several default settings have changed in version 5.15, please make
> sure
>       this does not affect your deployments:
>       - DUP for metadata (-m dup)
>       - enabled no-holes (-O no-holes)
>       - enabled free-space-tree (-R free-space-tree)
> 
> Label:              (null)
> UUID:               ff746273-9a0d-419c-9cc0-efe1c85b5857
> Node size:          16384
> Sector size:        4096
> Filesystem size:    10.00TiB
> Block group profiles:
>   Data:             single            8.00MiB
>   Metadata:         DUP               1.00GiB
>   System:           DUP               8.00MiB
> SSD detected:       yes
> Zoned device:       no
> Incompat features:  extref, skinny-metadata, no-holes, free-space-tree
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    10.00TiB  /dev/sde
> 
> 
> Kernel stacktrace:
> 
> [Jan 7 21:02] ------------[ cut here ]------------
> [  +0.000005] BTRFS: Transaction aborted (error -17)
> [  +0.000039] WARNING: CPU: 9 PID: 5589 at fs/btrfs/block-group.c:2788 btrfs_create_pending_block_groups+0x525/0x5a0 [btrfs]
> [  +0.000071] Modules linked in: tls udp_diag tcp_diag inet_diag qrtr vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock cfg80211 binfmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common isst_if_common skx_edac_common nfit rapl vmw_balloon vmwgfx i2c_piix>
> [  +0.000036] CPU: 9 UID: 0 PID: 5589 Comm: btrfs-transacti Not tainted 6.14.0-37-generic #37~24.04.1-Ubuntu
> [  +0.000003] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [  +0.000002] RIP: 0010:btrfs_create_pending_block_groups+0x525/0x5a0 [btrfs]
> [  +0.000049] Code: 48 8b 7d 98 e8 ac 9a f6 ff e9 45 fd ff ff 4c 89 ef e8 7f 23 3a f9 e9 ff fc ff ff 44 89 e6 48 c7 c7 d8 07 67 c0 e8 7b 19 ff f8 <0f> 0b e9 5e fe ff ff 44 89 e6 48 c7 c7 d8 07 67 c0 e8 65 19 ff f8
> [  +0.000001] RSP: 0018:ffffcf0b0469fd58 EFLAGS: 00010246
> [  +0.000002] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [  +0.000002] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  +0.000000] RBP: ffffcf0b0469fde8 R08: 0000000000000000 R09: 0000000000000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffef
> [  +0.000001] R13: ffff8a86290e2840 R14: ffff8a8bb2f8c118 R15: ffff8a82c07cf2a0
> [  +0.000001] FS:  0000000000000000(0000) GS:ffff8a91bfa80000(0000) knlGS:0000000000000000
> [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000001] CR2: 000074cdbd8053e8 CR3: 0000000caf7c0003 CR4: 0000000000770ef0
> [  +0.000025] PKRU: 55555554
> [  +0.000002] Call Trace:
> [  +0.000001]  <TASK>
> [  +0.000003]  btrfs_commit_transaction+0x7d/0xc50 [btrfs]
> [  +0.000051]  ? hrtimers_cpu_dying+0x130/0x1f0
> [  +0.000004]  transaction_kthread+0x167/0x1d0 [btrfs]
> [  +0.000042]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [  +0.000038]  kthread+0xfb/0x230
> [  +0.000003]  ? __pfx_kthread+0x10/0x10
> [  +0.000002]  ret_from_fork+0x47/0x70
> [  +0.000003]  ? __pfx_kthread+0x10/0x10
> [  +0.000001]  ret_from_fork_asm+0x1a/0x30
> [  +0.000004]  </TASK>
> [  +0.000001] ---[ end trace 0000000000000000 ]---
> [  +0.000002] BTRFS: error (device sde state A) in btrfs_create_pending_block_groups:2788: errno=-17 Object already exists
> [  +0.000014] BTRFS info (device sde state EA): forced readonly
> [  +0.000603] BTRFS warning (device sde state EA): Skipping commit of aborted transaction.
> 
> 
> 
> Any ideas?

Not yet, but I have seen it at Meta as well and am investigating.

Are you able to reproduce it or did it happen just once?

Hopefully something for you soon.

> 
> Thank you in advance,
> Dimitris
> 

Thanks,
Boris

