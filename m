Return-Path: <linux-btrfs+bounces-8945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331A99FA70
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 23:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A141C21E30
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 21:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047F20F5AC;
	Tue, 15 Oct 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YDTIAh0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5tEaNG5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240A1B0F08
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028345; cv=none; b=LZFppV4AmE6lRVCU0m5aA+XDXOWlmxoqVMSRGDfwYUy4n9YkXUINgPz/9LblXvMJWuI+BeQ1MNIDtiY6lD40HFYHkdpKs5H8alHdAdu76YlsGzVbfflhEhhHE5gaIiDSzMAZ6Dzadl7lVBrLfAdDtHZxCH4JzSJFoNeybW3sA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028345; c=relaxed/simple;
	bh=m/bIvvX3IWzWi4TJ6XIvq/wRQbBIqfEDw4k3bSy0H+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VXHa4RHgzIbuqo4szVI596p6ZSfaOph97Jv8oZDoTnbDCDVJ/o2BHhrCHC9XIieN7qM0qPqhbIAfKJv383Yn4Iq1sTUT5Z0S9NnXkLGVHS4zdORGm9HvayEIxyw2E7WPPCzn6D4pUXnXtHmEPNawU0FnRIvySskVKeAwWo30wIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YDTIAh0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i5tEaNG5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E4D11140198;
	Tue, 15 Oct 2024 17:39:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 15 Oct 2024 17:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1729028342; x=1729114742; bh=9Zb6toMq4aOnoNT5lVrQQ
	m15lTXx3KQXOdTks7Hq8Vo=; b=YDTIAh0z7E5qDJJSFTymtQ5CJC67PJd+EVbL/
	8ATc/GoVqWUrOx/urZnr9DacILvvDh0AdLWEFDNF29BXpnrOock5+PWnQKkQPNpU
	D32+7zq7VVOmjO2V+IGB7IIXqnR4kzOP43lKs3P3vWief1wU9S1k18C5LAP8e/NF
	knCJ1+HDZWIn2S2sgLqqhSAQIbPcNSLSGQ7sD8tbJ6C21tE2d2gXEgGY6x1JoPwU
	ileA6NSOBYmz3B8veAfYy0gqgxjwCMGBPuqD3sYOnPSQFPMEgeSzPF2k9YmSKYIf
	oCG8MYDh7Zn5cTuAyu/5epVHHZPMju660oCfoqB/LTtSenBSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729028342; x=1729114742; bh=9Zb6toMq4aOnoNT5lVrQQm15lTXx
	3KQXOdTks7Hq8Vo=; b=i5tEaNG5VHNWB8KnANTffE11qV9HLj9sKPchJRMkCcjm
	oWzHIV9vuuXmTJDL42CJd3oVady41N+QU5DtHn6pgUHR67kWqNdjvMyMbUFVHTVf
	9vhU9lbJJEhcc6Y3p1df0OwnBzYrrdlgDjREJpeRpC87GluBZVY2s0ixZ192aD1v
	PN/Oa4uTdfjla4+UZmCz2q9KZPvBCnoc1pvG1OSubtGEwn3Ik6ZSTToTqZ9adVOD
	66pnxdFEjXZx5PnzW/ziOKTu1LCqKCG7cEH+6IsINJwVwQiWFQcLQYF+WCUgm3FF
	+bMaLhp134aEuZ2hZGmPzzPRs+ICdihsBzZRolE94w==
X-ME-Sender: <xms:9uAOZ9-knvhsPRzbD2vpR9LGlODIx94DtAivNx5SAVT43khVU7ZlZw>
    <xme:9uAOZxupNgsdAam7v0Hyvy9cJDBndRPOAVn5UZlx9AI9kw6OTCAsP9QWtTzkgT0sj
    pxxrdAf3YrjGgGu8oQ>
X-ME-Received: <xmr:9uAOZ7CaeCi0K4osGvPhQChaDx6LJ3nl4ikuIugRtoK5E2E9NmG5zvTlj-zUz96CEksPkUOBlP-9JsErYzfMNgVw5zY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosgho
    rhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiledtfffhhfdvtdefgedvie
    etleeijeejiedthfefgeekheevheekjeelkeegkeenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:9uAOZxdpdxVopzfuzMLlcH5WTTTXszoIRN2PIGCvSPWrUvqrIuSjbw>
    <xmx:9uAOZyMtunu64l1_H2J0CR8sLXpcgWgJ0FHZl1YF5lQrLn8NcaesPQ>
    <xmx:9uAOZzlG_WnPlroBkGufUIiTUxBKee4qwfT6LYGmp7vNIeSxemD-lw>
    <xmx:9uAOZ8utF0uoQR6uJH8d_smCwrv-RfEKnhC1QWR8WrMVhqZ9gPbuPg>
    <xmx:9uAOZ7ab4pRAYMPfyrkvwsahDEEpgnl2lATxNUiEQa2Z-D4xVOvbs6hk>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 17:39:01 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: do not clear read-only when adding sprout device
Date: Tue, 15 Oct 2024 14:38:34 -0700
Message-ID: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If you follow the seed/sprout wiki, it suggests the following workflow:

btrfstune -S 1 seed_dev
mount seed_dev mnt
btrfs device add sprout_dev
mount -o remount,rw mnt

The first mount mounts the FS readonly, which results in not setting
BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
somewhat surprisingly clears the readonly bit on the sb (though the
mount is still practically readonly, from the users perspective...).
Finally, the remount checks the readonly bit on the sb against the flag
and sees no change, so it does not run the code intended to run on
ro->rw transitions, leaving BTRFS_FS_OPEN unset.

As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
does no work. This results in leaking deleted snapshots until we run out
of space.

I propose fixing it at the first departure from what feels reasonable:
when we clear the readonly bit on the sb during device add.

A new fstest I have written reproduces the bug and confirms the fix.

Signed-off-by: Boris Burkov <boris@bur.io>
---
Note that this is a resend of an old unmerged fix:
https://lore.kernel.org/linux-btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
were also explored but not merged around that time:
https://lore.kernel.org/linux-btrfs/cover.1654216941.git.anand.jain@oracle.com/

I don't have a strong preference, but I would really like to see this
trivial bug fixed. For what it is worth, we have been carrying this
patch internally at Meta since I first sent it with no incident.
---
 fs/btrfs/volumes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dc9f54849f39..84e861dcb350 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
 
 	if (seeding_dev) {
-		btrfs_clear_sb_rdonly(sb);
-
 		/* GFP_KERNEL allocation must not be under device_list_mutex */
 		seed_devices = btrfs_init_sprout(fs_info);
 		if (IS_ERR(seed_devices)) {
@@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 error_trans:
-	if (seeding_dev)
-		btrfs_set_sb_rdonly(sb);
 	if (trans)
 		btrfs_end_transaction(trans);
 error_free_zone:
-- 
2.46.2


