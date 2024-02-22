Return-Path: <linux-btrfs+bounces-2641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E710585F7D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 13:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEE31C20BF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB35FB8C;
	Thu, 22 Feb 2024 12:15:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F455FB8D
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604105; cv=none; b=LFXYFRjW2m8jeUF8F8NT7mLC8P4Ors2VNTbuAgMM2ql/ApcAVFnqu0mipQ2DRGRMrEBQXXmQ6fcPuITfEIFlv5nX2XqNvhIJcy/8XS4Hbi7Hg4fVnLLlbXu2+gxGe4IX5NglonoVgeodpXrPrkFPyf8UgeaMiEQ4/mKez5ijlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604105; c=relaxed/simple;
	bh=3xmtqRpXZCpGqTs7C3g0aIumaFO7VNNSgrraVOnjm4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqA1c3hMqNGj/6rdTc1GvuykN1XgXc9KuPMyq7iUQElOWr1WqySh999nx3oX9bAn1FE/if67F6exjzwrYQl1gRiRpcsdWcL0mxE2sIEcjhcFr6w68Kzhx7aF+AqktYuBKYX2g1oLgSvO1IWTNaagvuny9ycVteOWpUtS8PQFl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E31991F457;
	Thu, 22 Feb 2024 12:15:01 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DD54613A6B;
	Thu, 22 Feb 2024 12:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CLgFNsU612WARQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 22 Feb 2024 12:15:01 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: pass btrfs_device to btrfs_scratch_superblocks()
Date: Thu, 22 Feb 2024 13:14:21 +0100
Message-ID: <8326738f7055973d842968990ce9d9c21e7f1920.1708603965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708603965.git.dsterba@suse.com>
References: <cover.1708603965.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E31991F457
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Replace the two parameters bdev and name by one that can be used to get
them both.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dev-replace.c |  3 +--
 fs/btrfs/volumes.c     | 13 +++++--------
 fs/btrfs/volumes.h     |  4 +---
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 1c02d4dc0b72..e24d784898fc 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -998,8 +998,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	btrfs_sysfs_remove_device(src_device);
 	btrfs_sysfs_update_devid(tgt_device);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
-		btrfs_scratch_superblocks(fs_info, src_device->bdev,
-					  src_device->name->str);
+		btrfs_scratch_superblocks(fs_info, src_device);
 
 	/* write back the superblocks */
 	trans = btrfs_start_transaction(root, 0);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 32312f0de2bb..3cc947a42116 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2030,11 +2030,10 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 			copy_num, ret);
 }
 
-void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-			       struct block_device *bdev,
-			       const char *device_path)
+void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_device *device)
 {
 	int copy_num;
+	struct block_device *bdev = device->bdev;
 
 	if (!bdev)
 		return;
@@ -2050,7 +2049,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device_path);
+	update_dev_time(device->name->str);
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
@@ -2185,8 +2184,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * device and let the caller do the final bdev_release.
 	 */
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
-		btrfs_scratch_superblocks(fs_info, device->bdev,
-					  device->name->str);
+		btrfs_scratch_superblocks(fs_info, device);
 		if (device->bdev) {
 			sync_blockdev(device->bdev);
 			invalidate_bdev(device->bdev);
@@ -2299,8 +2297,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
-				  tgtdev->name->str);
+	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev);
 
 	btrfs_close_bdev(tgtdev);
 	synchronize_rcu();
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 055e095c2f61..feba8d53526c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -817,9 +817,7 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev);
-void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-			       struct block_device *bdev,
-			       const char *device_path);
+void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_device *device);
 
 enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags);
 int btrfs_bg_type_to_factor(u64 flags);
-- 
2.42.1


