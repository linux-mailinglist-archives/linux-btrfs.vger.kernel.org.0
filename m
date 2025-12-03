Return-Path: <linux-btrfs+bounces-19493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D0CA1A1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 22:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D946300252C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 21:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BC2D190C;
	Wed,  3 Dec 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CK/uXO4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TarUlpvA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB882BEFF8
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796258; cv=none; b=Hx2MebI0CBXYrca3zFHoxbcK4YvkNC6qVdCJYdSDcUD5l+gvbF9rKN46vdpC/iBma2dpyTRX216OAMFZ5N5zq/PoIUxkdXIBNqcqyuQXWAfKXGkFf6VnFSSHg34ziL1edapWynRodTUMRJOfuEr8rzKbLmCHIKYVI7GaO1C/n9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796258; c=relaxed/simple;
	bh=smkCzcrDzEimIc/9MDJDQI9xwkSKyq6Bv2eM/RB/Sws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtvWAwDskehyBEbwr7nvOSqQ2NX/x37KcIspXPSCmeeebSXZ5v1lnJZkmKDDJxlZ19vCzTrUU+I3SxqhYGDcSHCBSi3ysrfpQoYJ2YZXnv2+y2qc9AGTlxbFeBozGSESNZdRyq0sF38D/PRLWtcDw+E0dYAzbEKbtrCGPw5d6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CK/uXO4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TarUlpvA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C2427A00A3;
	Wed,  3 Dec 2025 16:10:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 16:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764796254; x=
	1764882654; bh=cglOQH7BOquUFXSZsRY4HcbM6RSmxp8lvHmS0ZQsVBY=; b=C
	K/uXO4dkFwC+chqIIpCEAM7/IAe+PSnT7irAvFOKj1Y6fprpe98xu5YAhNwoYsXj
	CHvxLBJshFw8f1MWh0w0p5ZxwjLo3uWRr1zVaNEFnpyryOnnxlXD3OfIWm+eFDmJ
	ErIjnvjIZdG+mN7Jkz/bkppiTUa7mYJjX45aR4Bs41JMJA4pQulNOn1VuoE+3zZ0
	0baXNYcLfE1Bbyy+/bcQNTqjPlQVhKJ3XbS2EOPSrKTPFMkee33ln94U2bo6oT8K
	80l5PtZ6/zP2icsTUn/ZmelBAb9OxwzkfEyXNyWB/ZKpCfFfjL+eTlxC3BLROzwO
	8Kc2lm4nBLPWGVIZnDM9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1764796254; x=1764882654; bh=cglOQH7BOquUFXSZsRY4HcbM6RSm
	xp8lvHmS0ZQsVBY=; b=TarUlpvApNEs1C7cScu/8DqPSqDjG9+buBe9ORhE+LJH
	QUMjQqJ/Tge9CfC0tDfpRt0qbkyB38wfXgzzuTelPFYw6e0tFIXoP5/C5V3hjX6Q
	qWVbWgM3QklERD8QudLY9VMH4ciG6XLUvwCeZm0STaDyNX/Q6YVhF4Sy+iJD2hWu
	qcsPm7otdfRSjDz5imhTVNcuNee8RSUvjV+HvP3lriHBEfWA4jmu96F/5jzyNo+P
	dUf4HbkQXA3fmkrSPetPyCHSIlW8S9KI+mv7ZH3IAYwOXaT0+zUJFZRd0x5+Pl0Y
	wXkuGAl+NBZ742CqHy4MfPK3H86YIZNLOW+OsMSoQQ==
X-ME-Sender: <xms:Xqcwadpwe5WHFQNUcRgp_2qmiWG_tPpNW_J1nwRgL93d8UKfP4gm_g>
    <xme:XqcwaVqIfno7NFBiS5YVoTTgWH7y912-QXdgovsPUdHIJ6M1ke8tK8MVOtEH46zRt
    rbuk87IoL-6XxGWSRzDJa0JnVpohcv8qP2tc2s-cB7oQ7mz0-o4Rmk>
X-ME-Received: <xmr:XqcwaX3gocnS-THjPhdQqqiJBZh-inCjMsfIlbXFrAoUyhR1zPHL4lC-ILNXGGV7xvp3LlVGDgJs-Sdx78FNVzZOcUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffvedvhedtud
    efiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:XqcwaUAss8rsnvAc5Q7AdGf28g88DP0u4uFq9xx-e1tmgoM99yL0kg>
    <xmx:XqcwaffU0XzxkPIY1h6RXqs7Yb3ns2XwmAuY35jLgAN6kqTXVIojVA>
    <xmx:XqcwaZiC-c0ySi-7_KFKw9TGB9jRefPDJXGjmUQ_RUmjjHqsYfxmmA>
    <xmx:XqcwaXrdRe5k_18ZfJ1ur61ouaKhC7ht0gYypGt3o61m51ruUbj8Ow>
    <xmx:XqcwacPkIHq2zZFQK60d415l3yLoAtaBUr5BTHv6gQpModkg7VNckGNX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:10:54 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: fix qgroup_snapshot_quick_inherit() squota bug
Date: Wed,  3 Dec 2025 13:11:09 -0800
Message-ID: <f9b72f1440cd4c4f63dbe224256afb65c0671a4e.1764796022.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764796022.git.boris@bur.io>
References: <cover.1764796022.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qgroup_snapshot_quick_inherit() detects conditions where the snapshot
destination would land in the same parent qgroup as the snapshot source
subvolume. In this case we can avoid costly qgroup calculations and just
add the nodesize of the new snapshot to the parent.

However, in the case of squotas this is actually a double count, and
also an undercount for deeper qgroup nestings.

The following annotated script shows the issue:

  btrfs quota enable --simple "$mnt"

  # Create 2-level qgroup hierarchy
  btrfs qgroup create 2/100 "$mnt"  # Q2 (level 2)
  btrfs qgroup create 1/100 "$mnt"  # Q1 (level 1)
  btrfs qgroup assign 1/100 2/100 "$mnt"

  # Create base subvolume
  btrfs subvolume create "$mnt/base" >/dev/null
  base_id=$(btrfs subvolume show "$mnt/base" | grep 'Subvolume ID:' | awk '{print $3}')

  # Create intermediate snapshot and add to Q1
  btrfs subvolume snapshot "$mnt/base" "$mnt/intermediate" >/dev/null
  inter_id=$(btrfs subvolume show "$mnt/intermediate" | grep 'Subvolume ID:' | awk '{print $3}')
  btrfs qgroup assign "0/$inter_id" 1/100 "$mnt"

  # Create working snapshot with --inherit (auto-adds to Q1)
  # src=intermediate (in only Q1)
  # dst=snap (inheriting only into Q1)
  # This double counts the 16k nodesize of the snapshot in Q1, and
  # undercounts it in Q2.
  btrfs subvolume snapshot -i 1/100 "$mnt/intermediate" "$mnt/snap" >/dev/null
  snap_id=$(btrfs subvolume show "$mnt/snap" | grep 'Subvolume ID:' | awk '{print $3}')

  # Fully complete snapshot creation
  sync

  # Delete working snapshot
  # Q1 and Q2 will lose the full snap usage
  btrfs subvolume delete "$mnt/snap" >/dev/null

  # Delete intermediate and remove from Q1
  # Q1 and Q2 will lose the full intermediate usage
  btrfs qgroup remove "0/$inter_id" 1/100 "$mnt"
  btrfs subvolume delete "$mnt/intermediate" >/dev/null

  # Q1 should be at 0, but still has 16k. Q2 is "correct" at 0 (for now...)

  # Trigger cleaner, wait for deletions
  mount -o remount,sync=1 "$mnt"
  btrfs subvolume sync "$mnt" "$snap_id"
  btrfs subvolume sync "$mnt" "$inter_id"

  # Remove Q1 from Q2
  # Frees 16k more from Q2, underflowing it to 16EiB
  btrfs qgroup remove 1/100 2/100 "$mnt"

  # And show the bad state:
  btrfs qgroup show -pc "$mnt"

        Qgroupid    Referenced    Exclusive Parent   Child   Path
        --------    ----------    --------- ------   -----   ----
        0/5           16.00KiB     16.00KiB -        -       <toplevel>
        0/256         16.00KiB     16.00KiB -        -       base
        1/100         16.00KiB     16.00KiB -        -       <0 member qgroups>
        2/100         16.00EiB     16.00EiB -        -       <0 member qgroups>

Fix this by simply not doing this quick inheritance with squotas.

I suspect that it is also wrong in normal qgroups to not recurse up the
qgroup tree in the quick inherit case, though other consistency checks
will likely fix it anyway.

Fixes: b20fe56cd285 ("btrfs: qgroup: allow quick inherit if snapshot is created and added to the same parent")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e2b53e90dcb..d46f2653510d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3223,6 +3223,9 @@ static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
 	struct btrfs_qgroup_list *list;
 	int nr_parents = 0;
 
+	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_FULL)
+		return 0;
+
 	src = find_qgroup_rb(fs_info, srcid);
 	if (!src)
 		return -ENOENT;
-- 
2.52.0


