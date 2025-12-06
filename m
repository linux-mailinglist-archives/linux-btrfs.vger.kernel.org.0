Return-Path: <linux-btrfs+bounces-19550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA822CAAF88
	for <lists+linux-btrfs@lfdr.de>; Sun, 07 Dec 2025 00:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60972305A81E
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Dec 2025 23:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F202D24BF;
	Sat,  6 Dec 2025 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="eAhtlxUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lX3rV+KF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44241DDC2C
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Dec 2025 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765065257; cv=none; b=FTJd3KqNb3n7S5gcPzsJP8NrPsGqtgyZaDw2Q/U/l1UvljB4x8TYXrY0/mdXXiWk3UNBDJWMTJcGijF+9gh64WDb45CLhpURP4w7LFOILgriJQgxqNJYY2n3K+z+c7oCmBoV7wmI9eki/eOXKp1YLZ0u3YGUwXEU3jOU3h6x0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765065257; c=relaxed/simple;
	bh=UcM0YrVU7G4dT4eOkiUisPAr3aZfm/gQqHlntIy1A0g=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=pogVxOmPZfJxUmftQ2HG7rimvpVd2T674zK0EbIgZPzDNYZkW5ymR7MuiIj/oBVbBgBoLMsy4P0UyWkXsNMmHstb2MkknZLvKwtTvyd6XcuEWXe0TYv+5eEX4gDcepvt3wIWEd9IsnXNI2zvBvuW4K80wwfIuFsOs7zK9OwFXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=eAhtlxUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lX3rV+KF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE06B7A01A9
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Dec 2025 18:54:13 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Sat, 06 Dec 2025 18:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1765065253; x=1765151653; bh=GVyuvDv1d6sGxDkq4nHggxfcVZJ3xf2VA3N
	sLTWAlmg=; b=eAhtlxUHGYPIgxFOht13MLC+W0pHVePmZq2hz39+/ORSe/cT7sh
	9PP5zv+F7KCQSLWzhvdNezdEapWNRcPdhFu4CZeyA0fn6mFqwcRPBRWTpRRY8Bci
	xX6WjK6QWxBI62P02BshIgHxLAPaeXVrlFIt3vIzuanxi74Wk4ND+wG9pZpZN9Sx
	DPAtCG43/kzRdT2uCNAMOfHkX8OvKvTtHLxCx4hG6DftEKCuVeX2/AJbRndCMDW5
	xJix86+mZbWhPUyFPGiERGczT4ofvDzuuzH2sQLlhhVd+/9FrWYK2OZ1OByYvYcG
	Cni20tZWh6TieIOPLuYyz/3tCCKpQorlpVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765065253; x=1765151653; bh=GVyuvDv1d6sGxDkq4nHggxfcVZJ3xf2VA3N
	sLTWAlmg=; b=lX3rV+KFHEi8CnfGjlE6LDRGT0IeeEBRxhQiE6fyXO3iEPPKmLM
	zt0W8e8BkR5T59TuKbCGTnKWa4sZ/fLP/EepkUGfRw87nmBVJKL0qXu7v5P0kKsi
	f0iaY0qW0h+ySjepcgX3mcMXqUVWzYB42f4eyFWdiTK9HFxqp9eRBWLwCS/YZVmy
	nIxmTzEtrCL5LcutvmjbdqoKUQ1OS4Ix6jl2uhDg4oPLcqFoh0zAz5ubQlnx+Hvb
	zhl67TrUxyvzqrJlImis9dKT861aZGRwb0L2XGdDh/1SZKL8WcRvCC45gcL2ooC1
	lmcilY/ftE9+mML/xFCdycUbXQuhVaLZIdA==
X-ME-Sender: <xms:JcI0aXlzpkCI5juzAEoT_wFwTpUILdvKg_V735mC4iw4p6cDFyDhiQ>
    <xme:JcI0aVq0uE-GtXAPddaETx2XJRhbhrBrl656IhJeSn27kx8UFuRyR-KdDVUq98oXL
    O1a1V3HJWeQsgRkkDmyXvAfmt5AQgnPYw1rUW0d6o_6C24QYqzl4bYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcuofhu
    rhhphhihfdcuoegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtf
    frrghtthgvrhhnpeelfeeuudeiieffveejteefleefjeehvdefvedtfeevgedvtdeiueeh
    feejvdfghfenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhishestgholhhorhhrvghm
    vgguihgvshdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JcI0aZUKRN04OPzGjDqzFk2FWoNdfjMBw5WoYiBNRDd4V8fY7P8L8g>
    <xmx:JcI0aZjgS7cJ4kI5CYqhA15NUJ_uQ1fy3xvRM1C8WmA4FsIMJNFrXg>
    <xmx:JcI0aSQmXLSD1Fc7sksaqp4WC24F2Yv1_LzdyLhmS8Go4266x-xzlg>
    <xmx:JcI0aUGCW7gvN8EGk1lAyEpUh7KkNLWVseFHu5x27C6jA926dlfuqg>
    <xmx:JcI0afpbbWAJ4oklHLG6bKtu_AnaJ_DuCJXEU_r2QAlR16gSUdwtnz5I>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85DCF18C004E; Sat,  6 Dec 2025 18:54:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ao4TdNMJRVfg
Date: Sat, 06 Dec 2025 16:53:53 -0700
From: "Chris Murphy" <chris@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <80f8e3f6-b42e-4dee-b1d0-4fa0d2b8c01a@app.fastmail.com>
Subject: 6.17.8 on POWER10, WARNING fs/btrfs/extent_map.c:422 btrfs_unpin_extent_cache,
 forced readonly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

kernel 6.17.8-300.fc43.ppc64le on a VM

Downstream bug report, includes full kernel messages
https://bugzilla.redhat.com/show_bug.cgi?id=2419731

Possibly relevant: 
>BTRFS info (device vda3): forcing free space tree for sector size 4096 with page size 65536

Excerpt of the call trace:

Dec  6 21:37:22 buildvm-ppc64le-12 kernel: ------------[ cut here ]------------
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: WARNING: CPU: 5 PID: 3085920 at fs/btrfs/extent_map.c:422 btrfs_unpin_extent_cache+0x84/0x1b0
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: Modules linked in: wireguard curve25519_ppc64le libcurve25519_generic vxlan vrf ip6_vti xfrm6_tunnel ip_vti sit macvtap tap macvlan ipip tunnel4 ip6_gre ip6_tunnel tunnel6 ip_gre ip_tunnel gre 8021q garp mrp team sch_tbf bridge stp llc veth sch_ingress sch_sfq dummy can_bcm sctp ip6_udp_tunnel udp_tunnel bluetooth can_j1939 can_isotp can_raw can ib_core overlay tun nfsv3 nfs_acl bonding tls rfkill nfs lockd grace nfs_localio netfs nft_reject_ipv6 nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables binfmt_misc xfs joydev virtio_net net_failover virtio_balloon vmx_crypto failover auth_rpcgss sunrpc loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common zram lz4hc_compress vsock lz4_compress bochs pseries_wdt i2c_dev fuse aes_gcm_p10_crypto crypto_simd cryptd
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: CPU: 5 UID: 0 PID: 3085920 Comm: kworker/u46:11 Not tainted 6.17.8-300.fc43.ppc64le #1 PREEMPT(voluntary) 
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected) 0x800200 0xf000006 of:SLOF,HEAD hv:linux,kvm pSeries
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: Workqueue: btrfs-endio-write btrfs_work_helper
Dec  6 21:37:22 buildvm-ppc64le-12 systemd[1]: Stopping machine-b2a4df599bc44a58bf9bfb55f7c9fd5b.scope - Container b2a4df599bc44a58bf9bfb55f7c9fd5b...
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: REGS: c0000000129ff960 TRAP: 0700   Not tainted  (6.17.8-300.fc43.ppc64le)
Dec  6 21:37:22 buildvm-ppc64le-12 systemd[1]: machine-b2a4df599bc44a58bf9bfb55f7c9fd5b.scope: Deactivated successfully.
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000484  XER: 200400b4
Dec  6 21:37:22 buildvm-ppc64le-12 systemd[1]: Stopped machine-b2a4df599bc44a58bf9bfb55f7c9fd5b.scope - Container b2a4df599bc44a58bf9bfb55f7c9fd5b.
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: CFAR: c000000000a9154c IRQMASK: 0 #012GPR00: c000000000a92158 c0000000129ffc00 c00000000265a900 0000000000000000 #012GPR04: 0000000000088000 0000000000001000 0000000000000001 0000000000000000 #012GPR08: 0000000000080000 0000000000000001 0000000000088000 0000015b51c5a005 #012GPR12: c00000051a328208 c00000097fff7f00 0000000000000000 0000000000000000 #012GPR16: 0000000000000000 c00000023f51e5f8 0000000000000000 0000000000000000 #012GPR20: c00000000d383c10 c000000021887000 0000000000000000 0000000000001000 #012GPR24: 0000000000088000 c000000021887000 0000000000001000 c00000023f51e5f0 #012GPR28: 0000000000015493 0000000000088000 c00000023f51e5c8 0000000000000000 
Dec  6 21:37:22 buildvm-ppc64le-12 systemd[1]: machine-b2a4df599bc44a58bf9bfb55f7c9fd5b.scope: Consumed 19min 29.517s CPU time, 1.5G memory peak.
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: NIP [c000000000a92164] btrfs_unpin_extent_cache+0x84/0x1b0
Dec  6 21:37:22 buildvm-ppc64le-12 systemd-machined[952]: Machine b2a4df599bc44a58bf9bfb55f7c9fd5b terminated.
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: LR [c000000000a92158] btrfs_unpin_extent_cache+0x78/0x1b0
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: Call Trace:
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129ffc00] [c000000000a92158] btrfs_unpin_extent_cache+0x78/0x1b0 (unreliable)
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129ffca0] [c000000000a75088] btrfs_finish_one_ordered+0x458/0xe00
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129ffdf0] [c000000000a9c640] finish_ordered_fn+0x20/0x40
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129ffe10] [c000000000ac1468] btrfs_work_helper+0x118/0x2c0
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129ffe60] [c0000000002897b4] process_one_work+0x1d4/0x530
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129fff10] [c00000000028a61c] worker_thread+0x2dc/0x450
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129fff90] [c000000000298878] kthread+0x188/0x1a0
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: [c0000000129fffe0] [c00000000000ded8] start_kernel_thread+0x14/0x18
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: Code: e9290208 7d394b78 48e63f4d 60000000 38c00001 7fe3fb78 7f45d378 7fa4eb78 4bfff215 7c690074 7c7f1b78 7929d182 <0b090000> 2c230000 41820084 e9030018 
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: ---[ end trace 0000000000000000 ]---
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: BTRFS warning (device vda3): no extent map found for inode 304326735 (root 256) when unpinning extent range [557056, 561152), generation 87187
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: ------------[ cut here ]------------
Dec  6 21:37:22 buildvm-ppc64le-12 kernel: BTRFS: Transaction aborted (error -2)



--
Chris Murphy

