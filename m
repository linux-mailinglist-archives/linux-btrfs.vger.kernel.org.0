Return-Path: <linux-btrfs+bounces-17643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8A9BD0DB3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D08034E32B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3B2EC54C;
	Sun, 12 Oct 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dLjvboFn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dLjvboFn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB722AE5D
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313158; cv=none; b=bP0vLZwODYUXSZa0QrBrflx/Yzmx9GeRyHu8YDjiTH7V0LkIaT23Otu1qP2uX8fNNgj12mBp2UpDO8aL8930toikBj4Zdv28Lkz6U61TMIUHmvx5nc1efDO3zxCqKYWdMjLSJSs3nzxO2Sa7/0L+Y9rAG8CU6BvG1+mkdm62LA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313158; c=relaxed/simple;
	bh=DfvvgOQ+7DWUoV+k+qOyX74faq5PvRHFFEoCJH3dPsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5sJJVwxtN94s+JCQwKaYdXHd23tjPe/2Y+D3c628wTOMdRDn6AJMPrdKDKR/nJlFfGpVGKLJUUCVIcnxr/aXQJulO+OgdaQ4QnSIkeYkLl6jwcc4osibIUlcv3/rpO91XwFlIpsUWaO3ieqMa1bPwdRJSxryfs6kWivUcJg/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dLjvboFn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dLjvboFn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D8A021238
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9H7n5w/Hq9ggzTQgj/JBXUQb3cEvLoIuU4pAg82DBfs=;
	b=dLjvboFnJBb4khDLHjc1v06Y5UqKxoFNCsdR5sDKpn6S8fJ3peD/jt3Dp9B9NkFPovIRQx
	3cTbeP9nFRZ7Hwx+89g2nEgUez8hSGDJMp4jjhW2ZRDFI/kXKzb6Ld1TXetjzjEy5vcHd+
	rV6b0hQBZSfd+tW9C9Nx9oTbOeRLL7Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9H7n5w/Hq9ggzTQgj/JBXUQb3cEvLoIuU4pAg82DBfs=;
	b=dLjvboFnJBb4khDLHjc1v06Y5UqKxoFNCsdR5sDKpn6S8fJ3peD/jt3Dp9B9NkFPovIRQx
	3cTbeP9nFRZ7Hwx+89g2nEgUez8hSGDJMp4jjhW2ZRDFI/kXKzb6Ld1TXetjzjEy5vcHd+
	rV6b0hQBZSfd+tW9C9Nx9oTbOeRLL7Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98AC713A59
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFrEFjs/7Gj8SQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v7 3/3] btrfs: implement remove_bdev and shutdown super operation callbacks
Date: Mon, 13 Oct 2025 10:22:05 +1030
Message-ID: <ff8b34ef24508e6bed6f7a5b4cbf052c3e33749b.1760312845.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1760312845.git.wqu@suse.com>
References: <cover.1760312845.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

For the ->remove_bdev() callback, btrfs will:

- Mark the target device as missing

- Go degraded if the fs can afford it

- Return error other wise
  Thus falls back to the shutdown callback

For the ->shutdown callback, btrfs will:

- Set the SHUTDOWN flag
  Which will reject all new incoming operations, and make all writeback
  to fail.

  The behavior is the same as the NOLOGFLUSH behavior.

To support the lookup from bdev to a btrfs_device,
btrfs_dev_lookup_args is enhanced to have a new @devt member.
If set, we should be able to use that @devt member to uniquely locating a
btrfs device.

I know the shutdown can be a little overkilled, if one has a RAID1
metadata and RAID0 data, in that case one can still read data with 50%
chance to got some good data.

But a filesystem returning -EIO for half of the time is not really
considered usable.
Further it can also be as bad as the only device went missing for a single
device btrfs.

So here we go safe other than sorry when handling missing device.

And the remove_bdev callback will be hidden behind experimental features
for now, the reasons are:

- There are not enough btrfs specific bdev removal test cases
  The existing test cases are all removing the only device, thus only
  exercises the ->shutdown() behavior.

- Not yet determined what's the expected behavior
  Although the current auto-degrade behavior is no worse than the old
  behavior, it may not always be what the end users want.

  Before there is a concrete interface, better hide the new feature
  from end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 ++
 fs/btrfs/volumes.h |  5 ++++
 3 files changed, 73 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index aadc02374b2a..b02ab17077af 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2424,6 +2424,68 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	return 0;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_remove_bdev(struct super_block *sb, struct block_device *bdev)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_device *device;
+	struct btrfs_dev_lookup_args lookup_args = { .devt = bdev->bd_dev };
+	bool can_rw;
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	device = btrfs_find_device(fs_info->fs_devices, &lookup_args);
+	if (!device) {
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		/* Device not found, should not affect the running fs, just give a warning. */
+		btrfs_warn(fs_info, "unable to find btrfs device for block device '%pg'",
+			   bdev);
+		return 0;
+	}
+	/*
+	 * The to-be-removed device is already missing?
+	 *
+	 * That's weird but no special handling needed and can exit right now.
+	 */
+	if (unlikely(test_and_set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))) {
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		btrfs_warn(fs_info, "btrfs device id %llu is already missing",
+			   device->devid);
+		return 0;
+	}
+
+	device->fs_devices->missing_devices++;
+	if (test_and_clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
+		list_del_init(&device->dev_alloc_list);
+		WARN_ON(device->fs_devices->rw_devices < 1);
+		device->fs_devices->rw_devices--;
+	}
+	can_rw = btrfs_check_rw_degradable(fs_info, device);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	/*
+	 * Now device is considered missing, btrfs_device_name() won't give a
+	 * meaningful result anymore, so only output the devid.
+	 */
+	if (!can_rw) {
+		btrfs_crit(fs_info,
+		"btrfs device id %llu has gone missing, can not maintain read-write",
+			   device->devid);
+		return -EIO;
+	}
+	btrfs_warn(fs_info,
+		   "btrfs device id %llu has gone missing, continue as degraded",
+		   device->devid);
+	btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+	return 0;
+}
+
+static void btrfs_shutdown(struct super_block *sb)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	btrfs_force_shutdown(fs_info);
+}
+#endif
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2439,6 +2501,10 @@ static const struct super_operations btrfs_super_ops = {
 	.unfreeze_fs	= btrfs_unfreeze,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	.remove_bdev	= btrfs_remove_bdev,
+	.shutdown	= btrfs_shutdown,
+#endif
 };
 
 static const struct file_operations btrfs_ctl_fops = {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 65b02a93db31..928fc6a061b6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6802,6 +6802,8 @@ static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
 				  const struct btrfs_device *device)
 {
+	if (args->devt)
+		return device->devt == args->devt;
 	if (args->missing) {
 		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
 		    !device->bdev)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2cbf8080eade..adbd9e6c09ff 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -662,6 +662,11 @@ struct btrfs_dev_lookup_args {
 	u64 devid;
 	u8 *uuid;
 	u8 *fsid;
+	/*
+	 * If devt is specified, all other members will be ignored as it is
+	 * enough to uniquely locate a device.
+	 */
+	dev_t devt;
 	bool missing;
 };
 
-- 
2.50.1


