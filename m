Return-Path: <linux-btrfs+bounces-4826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0458BFBCF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FB31C21185
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF3823D1;
	Wed,  8 May 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy7MS3Bv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E92628B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167221; cv=none; b=Uq12Nwbb4e7kGCwi4dIwzk4A8Gc7IgAuf3znzdXYO091OwaFxoKiXOt5+BxcnhZ0Uci/5KJoUAw15qHw7JFuVppbvwVP+wgoDT74+Qve9PuW5A1Qs5JEN309W7SN3eFwHVnakDCn/QLhzVaz/7ghnGMtxBSr7NRvdQMfmL7NnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167221; c=relaxed/simple;
	bh=0pjTlXEnABnzYeZtJKKbmpMwdn8eEDV3GJT9qWb8Dhc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SpLU2X2WnezJ5GPPTnXvTBek1TlRyckFNIuwZNp0YFTDdp5E/CAFvlm43NzlQ6wFJLKPm/irMvkyWeB5HAJa2r5vEun1diOrVYOk+fisyhO3ecymOgezDN7pAUQiMRXox/dV1ts+ZpIP5khN+jYLsAJedvMW7rkNUeI6kwBHSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy7MS3Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA26C113CC
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167221;
	bh=0pjTlXEnABnzYeZtJKKbmpMwdn8eEDV3GJT9qWb8Dhc=;
	h=From:To:Subject:Date:From;
	b=uy7MS3Bvsb9wvZSzFXFeBntapmZwu0VMQBRT1ZEAV3n2lGPJnhQ9ESLjFK8parWya
	 cNpt1e+O1XReuCga2xPkKEdD259jnLOZAOWrwcvwBoygxCf7nq4EjoPUs8T4ulV97A
	 Lj9SAV6T0vqC9eW6TRx1jVSbqaPmfUAm8/izoRhef3LXS0j9y8X4rCVBRxGpjEdcUA
	 cS/eB4iuRyrCNVt072i01/cHygNU4kakNiiw5WQyZhIq8ooGx19a1srIJCr1CkCVDJ
	 mTxlJRNRMwSkN+zIhIKzucDUSTJNT9oSUsM6iS5nrCbEXxQzOAYkqg297cFkSeGcJV
	 iUPoci5KOli3w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: make btrfs_get_dev_zone() static
Date: Wed,  8 May 2024 12:20:17 +0100
Message-Id: <5609a1191a2bba44aef148a56b67c313b7713a41.1715167141.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's not used outside zoned.c, so make it static.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/zoned.c | 4 ++--
 fs/btrfs/zoned.h | 7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4cba80b34387..aeab33708702 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -652,8 +652,8 @@ struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *o
 	return NULL;
 }
 
-int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
-		       struct blk_zone *zone)
+static int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+			      struct blk_zone *zone)
 {
 	unsigned int nr_zones = 1;
 	int ret;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 77c4321e331f..ff605beb84ef 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -53,8 +53,6 @@ struct btrfs_zoned_device_info {
 void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
-		       struct blk_zone *zone);
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
 int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
@@ -98,11 +96,6 @@ int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
-static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
-				     struct blk_zone *zone)
-{
-	return 0;
-}
 
 static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 {
-- 
2.43.0


