Return-Path: <linux-btrfs+bounces-15500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA3EB04D20
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 02:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEDA3A5E2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 00:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB61917FB;
	Tue, 15 Jul 2025 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tVOWMPJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VMmo9Dsv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46144F9C1
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540694; cv=none; b=n/FLFuk7/t0mSypzwXD4UIlBElIhMrZ8fHcz3qZZhKNXsuTPFUDPgi1PPmOeni/FL76isO/B1Ckt8+NQm2e+9IQhkonaZNNfUjDAwEmALLh82V/o5bJObn9qdzEEgN2s92Pi348dnTIBfi4MZ3nTnOCR9XWurVaO3Jc0xaW45Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540694; c=relaxed/simple;
	bh=uGdrHwok0mHK2RiNafM3GY0Y1uW+7u4i029Msb8L8Tc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I1twWhKl3nDKrSNXFLnUvP/mMRmMIC9HiXkciwJ4+wBCDEC0odZmB4TV1xEJvpSiMOB20YhJwhvpK45jBHW4QBiS8lwEL7a+D2EoS7ruY6LQzzetaWXA1btM90mL5C3Si9gEsL4amMtN2nswlP0VeGamcvOsvl3d/8rdp+9qC9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=tVOWMPJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VMmo9Dsv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FF2F1400435;
	Mon, 14 Jul 2025 20:51:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Jul 2025 20:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1752540690; x=1752627090; bh=FyKFu6TZfof26smv64PqY
	q2XB0wvEJgMO6KrjAHui0E=; b=tVOWMPJyWSTF9ZJ4FQ5UaXIgMFPAlUUOel6Ok
	jrszTwQOCTk3naoaCXRWNG8wOywlbAoPF9vQrzuu/NlhP1FXu9CO2LsZEtjgo3nX
	pz6TlSsHCWY+fJGV0xZpHiUBBL5RxGNUx1doF6ZbX03e0E8iSCzRhJlB4f6RP8z5
	SwFiQnLpeGYfoBpRxovhd+3QZE/KFqIWZHpcL+y2YKa6jZ4b5scULnCFWnP4YSp+
	NyVJwiEs/NTPUyNxC6nkPgVSIZHrbXUNnGeMEu5fO8lHwK6/GR43YZxJqVnSSpUf
	ZUprFaSqSJwEZqfFE4FYhCcWwGPP+mATaUXv3ITXU2WBHYrig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752540690; x=1752627090; bh=FyKFu6TZfof26smv64PqYq2XB0wvEJgMO6K
	rjAHui0E=; b=VMmo9Dsvf/kP1KNLvyVflugkqRDbu276OsAbHGiErVWHGgG0mmV
	ZifkL9dhgNVkmoMj31PvWezjAzNb7/pYVVndfMBtdyZVJqlfjNWcmmsMF0506E3i
	2FzYlTEt+vhr/58cFyBkGvzgX/zctK1U569QR4vRUNao2ekgekyBDohI4CJKlesC
	XwtDvTXTuN/DGefvkOJLeHauS88iRE0ZWzf5WisqcpEVqyRgOBzV2NL5oeYz1PPi
	+kY5zT/7XAeL0DYnMhgJ16RVf2E7v7yNfQLXFbDSoUpH7BPklM3hBdICQXGSfUAC
	7JNckKTnPMa+Qq+XpoGfCTM/G7Gp0SYh6DQ==
X-ME-Sender: <xms:EaZ1aBtizei_oC7hhLUajYsydL4AouCoAMcn7LfQ5UxxuNQrF3OXng>
    <xme:EaZ1aKr9w7SuAEvz4KZTFO6cXRvkOu3bFMiMiF-CS0g5EjzF6J-hKd_64xMn2np_3
    mcD3HIJWk2lQjqVTOg>
X-ME-Received: <xmr:EaZ1aGkG7HlTjwrrxgJykWTop7Zvq6JH-7jrBaABNBewk45KoIkRqbCp4NRkKQzDAV5D29EdufX2JU16gBw7YJTPkzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehfeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:EaZ1aGyO09ff-m-gw0R0CoXr620O67CL69MO7sHvvT9yN12yMeYC6Q>
    <xmx:EaZ1aGmXMIhdunIqBCUtff2-vCBX-xN1LIlG4MpVePLWdyZxq8TToQ>
    <xmx:EaZ1aHeAGSOMHGxXQ-pl68mmpID1RLY6_DUNnK-esV6ko4u2c7gm6Q>
    <xmx:EaZ1aEqUzCztOlKY9QWEul9yUUZvEcMJwKc5zyRAGVOgTuEUZWEPdQ>
    <xmx:EqZ1aHFllGz0Y0vaBRl7o5ee6VIuEDSVo9BTYoZfiYbd5oe8sPgC5iCh>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 20:51:29 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix ssd_spread overallocation
Date: Mon, 14 Jul 2025 17:53:00 -0700
Message-ID: <22b101fdabce832fc954622fcc0d49793d2070f2.1752540760.git.boris@bur.io>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the ssd_spread mount option is enabled, then we run the so called
clustered allocator for data block groups. In practice, this results in
creating a btrfs_free_cluster which caches a block_group and borrows its
free extents for allocation.

Since the introduction of allocation size classes, there has been a bug
in the interaction between that feature and ssd_spread. find_free_extent()
has a number of nested loops. The loop going over the allocation stages,
stored in ffe_ctl->loop and managed by find_free_extent_update_loop(),
the loop over the raid levels, and the loop over all the block_groups in
a space_info. The size class feature relies on the block_group loop to
ensure it gets a chance to see a block_group of a given size class.
However, the clustered allocator uses the cached cluster block_group and
breaks that loop. Each call to do_allocation() will really just go back
to the same cached block_group. Normally, this is OK, as the allocation
either succeeds and we don't want to loop any more or it fails, and we
clear the cluster and return its space to the block_group.

But with size classes, the allocation can succeed, then later fail,
outside of do_allocation() due to size class mismatch. That latter
failure is not properly handled due to the highly complex multi loop
logic. The result is a painful loop where we continue to allocate the
same num_bytes from the cluster in a tight loop until it fails and
releases the cluster and lets us try a new block_group. But by then, we
have skipped great swaths of the available block_groups and are likely
to fail to allocate, looping the outer loop. In pathological cases like
the reproducer below, the cached block_group is often the very last one,
in which case we don't perform this tight bg loop but instead rip
through the ffe stages to LOOP_CHUNK_ALLOC and allocate a chunk, which
is now the last one, and we enter the tight inner loop until an
allocation failure. Then allocation succeeds on the final block_group
and if the next allocation is a size mismatch, the exact same thing
happens again.

Triggering this is as easy as mounting with -o ssd_spread and then
running:

mount -o ssd_spread $dev $mnt
dd if=/dev/zero of=$mnt/big bs=16M count=1 &>/dev/null
dd if=/dev/zero of=$mnt/med bs=4M count=1 &>/dev/null
sync

if you do the two writes + sync in a loop, you can force btrfs to spin
an excessive amount on semi-successful clustered allocations, before
ultimately failing and advancing to the stage where we force a chunk
allocation. This results in 2G of data allocated per iteration, despite
only using ~20M of data. By using a small size classed extent, the inner
loop takes longer and we can spin for longer.

The simplest, shortest term fix to unbreak this is to make the clustered
allocator size_class aware in the dumbest way, where it fails on size
class mismatch. This may hinder the operation of the clustered
allocator, but better hindered than completely broken and terribly
overallocating.

Further re-design improvements are also in the works.

Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocator")
Reported-by: Dave Sterba <dsterba@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 85833bf216de..ca54fbb0231c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3672,7 +3672,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 	if (!cluster_bg)
 		goto refill_cluster;
 	if (cluster_bg != bg && (cluster_bg->ro ||
-	    !block_group_bits(cluster_bg, ffe_ctl->flags)))
+	    !block_group_bits(cluster_bg, ffe_ctl->flags) ||
+	    ffe_ctl->size_class != cluster_bg->size_class))
 		goto release_cluster;
 
 	offset = btrfs_alloc_from_cluster(cluster_bg, last_ptr,
-- 
2.50.0


