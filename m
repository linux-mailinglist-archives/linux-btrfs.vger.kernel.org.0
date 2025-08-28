Return-Path: <linux-btrfs+bounces-16476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62DDB39282
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 06:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA0F9818EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 04:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66CE219319;
	Thu, 28 Aug 2025 04:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PYEDGzOp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PYEDGzOp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6320C00B
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354626; cv=none; b=G122Y2kBmB+grfkatdyaDtFJzLyqONX0POvCgKqE/5o1uWw6DocMa21VQI+HWMfNlPxIPVpn+CmIBtUrxXPNxCx675UM27n/dx11SXa0Lm1hi+zsOGYVrmXYKFkCoWUoSX32IxGDYH+hRPjBOc8NyYZrK6FpFqzTVFTQDv89mr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354626; c=relaxed/simple;
	bh=b+6eA1OvHhaaBVHoFL9oVEc3d+GhAfUBL2PhEfmSmXM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCweXP1+G+5a0Y8VKIiKO6+aJOcP/GIYNRGtyGT9/JpxsMd/fmPuNp3iaBI9KFuzx2nP1NxAqSxDS/QqQ30zGcK2m1YEOcqK1JkFL2KXhvBUWlJpy4W6ez333eCqlp9MQvEvhsCCnWbMKD1jVGPoLSIZwsfHQ0gwZl2sUD4wQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PYEDGzOp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PYEDGzOp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7757B20938
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1nsTPrxKhsv7Y87R+X5yCGLKU26ArrwaOcityHavI0=;
	b=PYEDGzOpGAVyrElBoJG+lYlVheOZKBvhTmrUjwqsHLCCuPF8wW1QIgoOUQhGhcQ5hP0ru8
	+HgKnFRgewDYl4TdJDpsESvbsJNV6+nAgtRSIGn+1H7iHgF0Gcwx6j9FcYw3EEGdzmGvKt
	L/Jlf4UMo9AbEc0YnMTg89E+jX3Cixs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1nsTPrxKhsv7Y87R+X5yCGLKU26ArrwaOcityHavI0=;
	b=PYEDGzOpGAVyrElBoJG+lYlVheOZKBvhTmrUjwqsHLCCuPF8wW1QIgoOUQhGhcQ5hP0ru8
	+HgKnFRgewDYl4TdJDpsESvbsJNV6+nAgtRSIGn+1H7iHgF0Gcwx6j9FcYw3EEGdzmGvKt
	L/Jlf4UMo9AbEc0YnMTg89E+jX3Cixs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA89013680
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sG06GzHYr2hhYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: return error if the primary super block write to a new device failed
Date: Thu, 28 Aug 2025 13:46:23 +0930
Message-ID: <1221cb8d5c463f08eb5f576a68c88dd3eef137d6.1756353444.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756353444.git.wqu@suse.com>
References: <cover.1756353444.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

When adding a new device to btrfs, btrfs adds the device and relying on
the regular transaction commit to put a new super block to that device.

However during that transaction commit, if the primary super block write
back failed for that device, the fs will not be able to be mounted
unless degraded.

This is because the primary super block failed to be written to that new
device, thus btrfs is unable to locate that new device thus it will be
treated as missing.

This means for the initial transaction commit on that new device, it is
more critical than other devices.

Treat primary super block write back to a new device as a critical error,
so that if that error happened, we will abort the transaction.

Although transaction abort is annoying, it keeps the fs to be mountable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 41 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.c |  3 ++-
 fs/btrfs/volumes.h |  1 +
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 90577fc73b3b..9a8c07a0986d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3999,6 +3999,21 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
 	return min_tolerated;
 }
 
+static bool is_critical_device(struct btrfs_device *dev)
+{
+	/*
+	 * New device primary super block writeback is not tolerated.
+	 *
+	 * As if a power loss after the current transaction, the new device
+	 * has no primary super block, and btrfs will refuse to mount.
+	 * Although it's still possible to mount the fs degraded since
+	 * there is no bgs on that device, it's better to error out now.
+	 */
+	if (test_bit(BTRFS_DEV_STATE_NEW, &dev->dev_state))
+		return true;
+	return false;
+}
+
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 {
 	struct list_head *head;
@@ -4009,6 +4024,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 	int do_barriers;
 	int max_errors;
 	int total_errors = 0;
+	bool critical_error = false;
 	u64 flags;
 
 	do_barriers = !btrfs_test_opt(fs_info, NOBARRIER);
@@ -4039,6 +4055,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		}
 	}
 
+	/* Start from newly added device, to detect problems of them early. */
 	list_for_each_entry(dev, head, dev_list) {
 		if (!dev->bdev) {
 			total_errors++;
@@ -4074,10 +4091,18 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		}
 
 		ret = write_dev_supers(dev, sb, max_mirrors);
-		if (ret)
+		if (ret) {
 			total_errors++;
+			if (is_critical_device(dev)) {
+				btrfs_crit(fs_info,
+					   "failed to write super blocks for device %llu",
+					   dev->devid);
+				critical_error = true;
+				break;
+			}
+		}
 	}
-	if (total_errors > max_errors) {
+	if (total_errors > max_errors || critical_error) {
 		btrfs_err(fs_info, "%d errors while writing supers",
 			  total_errors);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -4098,11 +4123,19 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 			continue;
 
 		ret = wait_dev_supers(dev, max_mirrors);
-		if (ret)
+		if (ret) {
 			total_errors++;
+			if (is_critical_device(dev)) {
+				btrfs_crit(fs_info,
+					   "failed to wait super blocks for device %llu",
+					   dev->devid);
+				critical_error = true;
+				break;
+			}
+		}
 	}
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-	if (total_errors > max_errors) {
+	if (total_errors > max_errors || critical_error) {
 		btrfs_handle_fs_error(fs_info, -EIO,
 				      "%d errors while writing supers",
 				      total_errors);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a031aafe253f..2106190e972b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2766,6 +2766,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 
 	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+	set_bit(BTRFS_DEV_STATE_NEW, &device->dev_state);
 	device->generation = trans->transid;
 	device->io_width = fs_info->sectorsize;
 	device->io_align = fs_info->sectorsize;
@@ -2865,7 +2866,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 
 	ret = btrfs_commit_transaction(trans);
-
+	clear_bit(BTRFS_DEV_STATE_NEW, &device->dev_state);
 	if (seeding_dev) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f69bc72680fb..8c571f66acff 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -101,6 +101,7 @@ enum btrfs_raid_types {
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
 #define BTRFS_DEV_STATE_SB_WRITE_ERROR	(6)
+#define BTRFS_DEV_STATE_NEW		(7)
 
 /* Special value encoding failure to write primary super block. */
 #define BTRFS_SUPER_PRIMARY_WRITE_ERROR		(INT_MAX / 2)
-- 
2.50.1


