Return-Path: <linux-btrfs+bounces-9861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB19D6E8C
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF97B24C0B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75A1D434F;
	Sun, 24 Nov 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvilzeHc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDF1D358F;
	Sun, 24 Nov 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452071; cv=none; b=Tneqk+3XJzrqcerI12Dv9u+udXrYwNhQ3F1d4tesmCIB5YtWB2xZsxW7KJ/6O5XQL7BZUBZYiKg80oKJXIbuLTnQyk3rRFRmKE0T7MFAeZUlbwp7nOpoNvDxEHymrcea8l8P0phaXedgfiQDqcvkAZmAG4sCkFUHy7MdIERnnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452071; c=relaxed/simple;
	bh=xj/1zaiqXiRaifbRNyd5oz4Q/yyMmG4POMsURXmDiVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAHI/lk6pJIspo1vvTavWHy61I3KomZbOj1ix7CGtBcTO/WZ+Xa0XJlVLf3S1LnAVNdJpt8OyFZ3Ku91T1m8ZOzUGJtkHtgS2RPVeWPaqT22uo30N7e7whEJDWHIS27sEkkzAQfqh3vttpRCGwpR/MwfFjvabR1GDxPwfDuJZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvilzeHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1C2C4CECC;
	Sun, 24 Nov 2024 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452071;
	bh=xj/1zaiqXiRaifbRNyd5oz4Q/yyMmG4POMsURXmDiVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvilzeHccvqlwFWbKOELb+v3uThKBLT8ioWd8F5zpNv/o1kauFWaILBREcV03qrrj
	 un1sFcVcNdRrf9WA0zlOGtvCou7klBCC8taudU82AXOmLOAjpCuFt+KKljZJ5+xIh/
	 GrplKdPLofimIyGIDdlVRACGB7HgSNPpPXRAtHwJvB4inOC2pXQxVi9QnVAQzFPDfx
	 LG3x9EKaGjAxklk1KOzDQslV6e2Z91eY+PAOuk+2aC1D7dfveZ2hLKXoStwye9ii7U
	 Wx/HnfV8e0QRRMjWui/nedUFf7awVojaywVtAA4NQLSaUvDJK8E7vEiGZ8xtteXUcU
	 3tyJ2/gK19hpQ==
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
Subject: [PATCH AUTOSEL 6.6 6/9] btrfs: do not clear read-only when adding sprout device
Date: Sun, 24 Nov 2024 07:40:44 -0500
Message-ID: <20241124124057.3336453-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124057.3336453-1-sashal@kernel.org>
References: <20241124124057.3336453-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index fdd392334916f..b9a0b26d08e1c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2738,8 +2738,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
 	if (seeding_dev) {
-		btrfs_clear_sb_rdonly(sb);
-
 		/* GFP_KERNEL allocation must not be under device_list_mutex */
 		seed_devices = btrfs_init_sprout(fs_info);
 		if (IS_ERR(seed_devices)) {
@@ -2882,8 +2880,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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


