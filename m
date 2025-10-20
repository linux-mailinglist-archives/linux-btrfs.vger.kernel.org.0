Return-Path: <linux-btrfs+bounces-18031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A00BEFA7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A70D3AE7AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2022D876A;
	Mon, 20 Oct 2025 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLzH3keM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F626B761
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944977; cv=none; b=azpr/Uoc9gwVCIuZJH2rkGJ+JJ1e03HgIsqXq2l3ZteD4MOotmH7AU4hogVbLtwBhf/HaGI9cPZM5OikNJlTHAItzLsKXOZK/DElLIkeZH5p2lj5x6NmUFmLBFsCkpAUyWTe5OA6yqenO4RRfvoBHRaRuFD5wAlC557S18RZks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944977; c=relaxed/simple;
	bh=o+/bmb1lwhmANRQ3GMKe2UlStGYtljIoyKcanpPIeh8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nVS/z3mUv25VyFdC+B6Zc8rudIvageu5t2BkOutejbitKYRKHMNQ06100wb0hI5mIIb+X4fC7TF5yym2q6hoV7jrkYkBeH9rpho1GrxzZNVHUcY1iaL8vZ1s46FVtWabpgJjLLArPl0VDiZQ5u7GJVHrXi9G+200EF0KD6t3vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FLzH3keM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UYBKaBABmEwTaUDF/bTR2zLYC6MXWabgOyrHs9bL9yg=; b=FLzH3keM5ATi/aa5ctVHJQkzPe
	B2rHxDHS/kZhudYyVmuQA87VOWVt6EptSSTSXVSqnp9PyilQPql9P+sGlReYOvlDxau3HEaNjChzC
	V3/4DgNofOYOoagMDO4bpggd8OtfMTokvk9sMOAiK1xqgTzYYr9BZXf8IUu512T834xLAdnoJSpeF
	HbniIGMBAQkr9YvR4ag5fHAxuXIERF+dB0HKZfJtyFAr8m/Fdn0bid3CE1o/6QaJwjgqmakl9Jtoi
	PmxtlzJJWVHl8Z1XlEa2NIO0dBal1qXrAidSUs+QAChqMKBUx2Rp/X/zELqLizt6tlgZzbWfek0qs
	5r9HWNbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkEJ-0000000CCCA-3vbd
	for linux-btrfs@vger.kernel.org;
	Mon, 20 Oct 2025 07:22:55 +0000
Date: Mon, 20 Oct 2025 00:22:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: linux-btrfs@vger.kernel.org
Subject: btrfs/071 is unhappy on 6.18-rc2
Message-ID: <aPXjTw8WN5Jlv2ho@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I just kicked off a baseline run with the xfstests volume group and
a SCRATCH_DEV_POOL with 5 virtual nvme devices to test a VFS change that
affects іt a little, and it does not seem too happy.

btrfs/071 gets into slab poisoning:

[  279.241695] BTRFS info (device nvme1n1 state M): use zlib compression, level 3
[  279.247651] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6d73:I
[  279.250656] CPU: 1 UID: 0 PID: 82037 Comm: btrfs-cleaner Tainted: GN  6.18.0-rc2  
[  279.250656] Tainted: [N]=TEST
[  279.250656] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/4
[  279.250656] RIP: 0010:btrfs_kill_all_delayed_nodes+0x145/0x1e0
[  279.250656] Code: 08 48 c1 e5 03 4b 8b 5c 3d 00 48 89 df e8 23 d0 ff ff 48 85 db 74 0f 4a 8d 54 3c0
[  279.250656] RSP: 0018:ffffc9000138bdc0 EFLAGS: 00010246
[  279.250656] RAX: 6b6b6b6b6b6b6b6b RBX: ffff88810dad3d58 RCX: 0000000000000000
[  279.250656] RDX: 0000000000000001 RSI: 0000000000000286 RDI: 00000000ffffffff
[  279.250656] RBP: 0000000000000008 R08: ffff88810dad3f60 R09: ffff88810dad3f10
[  279.250656] R10: 000000000000000d R11: ffff88810dad3d58 R12: ffff88811bdfbc18
[  279.250656] R13: ffffc9000138bdc8 R14: ffff88811bdfb800 R15: 0000000000000000
[  279.250656] FS:  0000000000000000(0000) GS:ffff8883ef66a000(0000) knlGS:0000000000000000
[  279.250656] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  279.250656] CR2: 00007fcba10194c8 CR3: 00000001217a3002 CR4: 0000000000772ef0
[  279.250656] PKRU: 55555554
[  279.250656] Call Trace:
[  279.250656]  <TASK>
[  279.250656]  ? __schedule+0x52c/0xb60
[  279.250656]  btrfs_clean_one_deleted_snapshot+0x72/0x100
[  279.250656]  cleaner_kthread+0xd3/0x150
[  279.250656]  ? __pfx_cleaner_kthread+0x10/0x10
[  279.250656]  kthread+0x109/0x220
[  279.250656]  ? __pfx_kthread+0x10/0x10
[  279.250656]  ? __pfx_kthread+0x10/0x10
[  279.250656]  ret_from_fork+0x120/0x160
[  279.250656]  ? __pfx_kthread+0x10/0x10
[  279.250656]  ret_from_fork_asm+0x1a/0x30
[  279.250656]  </TASK>
[  279.250656] Modules linked in: kvm_intel kvm irqbypass
[  279.277534] ---[ end trace 0000000000000000 ]---

similar things repeat a few times, and then it loops basically forever
doing device replacements, I waited for 30 minutes before killing it.

