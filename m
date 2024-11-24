Return-Path: <linux-btrfs+bounces-9857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E579D6E6C
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DCDB23F12
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0F1C07F1;
	Sun, 24 Nov 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmydMylR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D191BE86E;
	Sun, 24 Nov 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452038; cv=none; b=NMmO3d38+6/GtZZJD4Z+gkOVZRZn4AdXgxHhmrwEpH4b7adsEfWQB4y6pm+29JwJ3PTJtqln5JL6hOlxSAyWk5VLosKamY7ephwV62HiSICJf5m9MSL9vkbvXy90lyZ5sl1suXDPJ9ukLnSib84IC3Y+jPWPFl61n+e1NhgT3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452038; c=relaxed/simple;
	bh=DdI9q3XIEjQeW//zsmhBZaKiC6fpf5J2GogKRQNE5y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKNP1he7xnf8mA1fk9Z1WJK79B7fdIYXDoO3KCG4BR3xEegxh0K0L+suUlZusd8xtqkHX3vsrjaK6T6x5DG6PwszXIj0FZaHbVwT3Og/a3JcGwAFXhDiMl4S2IEHfoBRYFcq8fXLOJjtRb8og4WTt3SeN+osadh5cg6+MPEsqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmydMylR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFCCC4CED1;
	Sun, 24 Nov 2024 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452038;
	bh=DdI9q3XIEjQeW//zsmhBZaKiC6fpf5J2GogKRQNE5y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmydMylRlDzrIOe3mnTl95e7rf0L59PPQpHfHe6jECDaGTClt5Zc52CFV7VJk26xo
	 2vT7VdEMbG1lW4WE/VVeruavRoy6lpZ4jrqzGbCwDOrGQQD9j5W+DVbaZ0zmYJ4cCm
	 izm2gwRC9kHnsQa+MZOJrQqmsiYqdXhHmryLRu/c/3LoHxPSw6Uhr6gclgYFePCGnT
	 GlC0lqQlSfRBBkOPh1pXmOKfx/ikMjm4kKoNj5O1wvYY8JiyoDDfVI/VBkKWt6qGMQ
	 BNikvkiwAolKIoghlJTn9SH5lbRIPc0HpYBX90e3fYJczMPRKoVKnZ7GlnIgxjE+tT
	 3E5P716/cy5fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 12/16] btrfs: do not clear read-only when adding sprout device
Date: Sun, 24 Nov 2024 07:39:49 -0500
Message-ID: <20241124124009.3336072-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 70958a949d852cbecc3d46127bf0b24786df0130 ]

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

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a06d530835d4e..28b79341e7e05 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2840,8 +2840,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
 
 	if (seeding_dev) {
-		btrfs_clear_sb_rdonly(sb);
-
 		/* GFP_KERNEL allocation must not be under device_list_mutex */
 		seed_devices = btrfs_init_sprout(fs_info);
 		if (IS_ERR(seed_devices)) {
@@ -2984,8 +2982,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 error_trans:
-	if (seeding_dev)
-		btrfs_set_sb_rdonly(sb);
 	if (trans)
 		btrfs_end_transaction(trans);
 error_free_zone:
-- 
2.43.0


