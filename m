Return-Path: <linux-btrfs+bounces-10367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B249F19BE
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 00:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4587C1654DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2A11B4F15;
	Fri, 13 Dec 2024 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FyZehiba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bc2h/ZfW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882918E351
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131731; cv=none; b=ODRF2kiJz1KUJLvA6yxYuxnSYJwTCgJLlcIO00ARI+XThe4o18Oq6sMdUOeibm6GKPtNvvpwkEBTuveHqIDCE30fMNISsKfcL67WaJwmLOl+sEDfPxhqihciL1AnDaoEt/+Pek8hCv90xPpMol31TAbZ7Mk9qkwOxlSl4/Xq7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131731; c=relaxed/simple;
	bh=+Zmil7zuV6B7QGtL2AG40q6DzrkDrYo7c14C45xvtS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhFdGgGSH3Bi3QrY1t1BciKjf6ObseO4fsOW8ewzs3l1oVmVpSCPOaTlKY2AxQ9RPLL9DiWwHWuAjZQq23nEkXtIy99Zmk1rbI/dwBX49/tj0mGYUQlkxXUdJO+9NwG6oKPnrprHPJ7cnl4KXY9xI2LxK/Vk8hl6YiPWmaOd7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FyZehiba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bc2h/ZfW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F86C1383C87;
	Fri, 13 Dec 2024 18:15:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 18:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734131728; x=
	1734218128; bh=/uIXeo8KYGSolWHoyMU2+xdzK75hkYKgvR1yIlZxGj0=; b=F
	yZehibaaoJrf+jsu7hYyyir5Mj7oesElehzzhszEyg4Nisos8l0aw3MlhUzXfiHC
	pMTpTd9LGvHfPP6vBcAc2+LkYw8lIfb9sScs+vYJSR7+RyX83lVufoTQZJCoEJz3
	iBtuK0nrANA5aE9pzS6NKGslcvIjwkhB0vmb+QDkduwlUDikg4YH/Hzeo/ToNQ39
	hMZltmx4lTCswtpRqJecu9p7qZBkLf31NRSWTsw+BenzlqTHDnGzQnK5XM1qZvgK
	xQnLDPUYC18kS2GxhOPlyMfR3aOxCRToYdmfAU+aqRj2k+sb6DgsnRv8l1Yi16L9
	8sLQkE8GtH9nZmvRO+7iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734131728; x=1734218128; bh=/uIXeo8KYGSolWHoyMU2+xdzK75h
	kYKgvR1yIlZxGj0=; b=bc2h/ZfWWZWTyBBCLKIn9LycJDKnRxyEAmhh4bYKM14s
	1CAo+OufAHfp526/4RhqQYJIBC03a3OqXaPITzwZ5xxtEPXILYV2PdzLQ3LIfssf
	GRBq+4dymPoImrVWheRFh+C6G0dux1wmfApEk/Hs8eFcrnJhlE0YlJt0INjG9UPk
	H2B76cHwAFX6pOtCs07pV4UKtlBxJobKFQ9EPGatTJCtJ/M1N0LRRM/QsXz2eaFB
	Tr8RuvsSph1yDHWtX6PG8KjjLR+oQ1oTyRRsxb60DnbjyUVO8mA+ladMddfXCf3X
	m3MVC8xt0mA7im5jvr+Iz+vkwWWUtTE0WaevLmXfmg==
X-ME-Sender: <xms:EMBcZwe9kimNm53cY5zWc5rWwnnsrbfDKan_DsAEzQKI378IavMKTA>
    <xme:EMBcZyPiuCX-899pWJBJaZTaROjnwi4O6pdnQvDfqy1kxRa696IAh4o8y3jTq9HOm
    jzYoiwa3fX91GRSglE>
X-ME-Received: <xmr:EMBcZxgTiPRxoXvCU310UXzdf3js9XVnODLImQayb4nAJVqC-jpW1lpCtbB8lb3BBY_RPxwC_Zil7R1kgSkIDDUvTf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeekgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    fojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegs
    ohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehie
    fgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgs
    thhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqd
    htvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:EMBcZ18dGw7fcNrhGYuFrBZVqv_mzZGjHLHrL7t9XSNpZ20Gfp_PTA>
    <xmx:EMBcZ8ufxg8ms4XDZhbcZbEbI7Wv1zagVaLRTIBPAzVEo5T08b5bvA>
    <xmx:EMBcZ8EHLQUT8ewzqEVFzKUw-32Jgd2CaQuzotb0egToaf6Q5cuw0Q>
    <xmx:EMBcZ7NErZ9NF8FWmKe3PC9sKVrd7Lxwk5hpl9CGxu_MYZvBImYX6g>
    <xmx:EMBcZ167-0-dOV33CcIK4-EG-X7eI52JmN49SKhX3A_jVvVxyHnCCXjD>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 18:15:27 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: fix btrfs_read_folio race in relocation
Date: Fri, 13 Dec 2024 15:13:13 -0800
Message-ID: <13b9e50db9f1778e2819f597dbd82498860f1666.1734131353.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734131353.git.boris@bur.io>
References: <cover.1734131353.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we call btrfs_read_folio to bring a folio uptodate, we unlock the
folio. The result of that is that a different thread can modify the
mapping (like remove it with invalidate) before we call folio_lock.
This results in an invalid page and we need to try again.

In particular, if we are relocating concurrently with aborting a
transaction, this can result in a crash like the following:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP
CPU: 76 PID: 1411631 Comm: kworker/u322:5
Workqueue: events_unbound btrfs_reclaim_bgs_work
RIP: 0010:set_page_extent_mapped+0x20/0xb0
Code: c9 eb e8 cc cc cc cc cc cc cc 0f 1f 44 00 00 53 48 8b 47 08 a8 01 75 60 48 89 fb 66 90 48 f7 03 00 80 00 00 75 34 48 8b 4b 18 <48> 8b 01 48 8b 90 40 fe ff ff 48 8b ba 08 02 00 00 81 bf 8c 0c 00
RSP: 0018:ffffc900516a7be8 EFLAGS: 00010246
RAX: ffffea009e851d08 RBX: ffffea009e0b1880 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffc900516a7b90 RDI: ffffea009e0b1880
RBP: 0000000003573000 R08: 0000000000000001 R09: ffff88c07fd2f3f0
R10: 0000000000000000 R11: 0000194754b575be R12: 0000000003572000
R13: 0000000003572fff R14: 0000000000100cca R15: 0000000005582fff
FS:  0000000000000000(0000) GS:ffff88c07fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000407d00f002 CR4: 00000000007706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
? __die+0x78/0xc0
? page_fault_oops+0x2a8/0x3a0
? __switch_to+0x133/0x530
? wq_worker_running+0xa/0x40
? exc_page_fault+0x63/0x130
? asm_exc_page_fault+0x22/0x30
? set_page_extent_mapped+0x20/0xb0
relocate_file_extent_cluster+0x1a7/0x940
relocate_data_extent+0xaf/0x120
relocate_block_group+0x20f/0x480
btrfs_relocate_block_group+0x152/0x320
btrfs_relocate_chunk+0x3d/0x120
btrfs_reclaim_bgs_work+0x2ae/0x4e0
process_scheduled_works+0x184/0x370
worker_thread+0xc6/0x3e0
? blk_add_timer+0xb0/0xb0
kthread+0xae/0xe0
? flush_tlb_kernel_range+0x90/0x90
ret_from_fork+0x2f/0x40
? flush_tlb_kernel_range+0x90/0x90
ret_from_fork_asm+0x11/0x20
</TASK>

This occurs because cleanup_one_transaction calls
destroy_delalloc_inodes which calls invalidate_inode_pages2 which takes
the folio_lock before setting mapping to NULL. We fail to check this,
and subsequently call set_extent_mapping, which assumes that mapping !=
NULL (in fact it asserts that in debug mode)

Note that the "fixes" patch here is not the one that introduced the
race (the very first iteration of this code from 2009) but a more recent
change that made this particular crash happen in practice.

Fixes: e7f1326cc24e ("btrfs: set page extent mapped after read_folio in relocate_one_page")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/relocation.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6d3d2a9b6ed3..cdd9a7b15a11 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2831,6 +2831,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 	const bool use_rst = btrfs_need_stripe_tree_update(fs_info, rc->block_group->flags);
 
 	ASSERT(index <= last_index);
+again:
 	folio = filemap_lock_folio(inode->i_mapping, index);
 	if (IS_ERR(folio)) {
 
@@ -2866,6 +2867,11 @@ static int relocate_one_folio(struct reloc_control *rc,
 			ret = -EIO;
 			goto release_folio;
 		}
+		if (folio->mapping != inode->i_mapping) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto again;
+		}
 	}
 
 	/*
-- 
2.47.0


