Return-Path: <linux-btrfs+bounces-10987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28DA1449B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 23:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C176418827C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B6236EA5;
	Thu, 16 Jan 2025 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eE6hmEhL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eE6hmEhL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99E22F3B4
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067200; cv=none; b=NpExA4VusREfLG+g9K9s0jkFM1vIE8LHwNArOc16zLaIn5zdIIGN1omuHsRR3q7le7/EaQf3TwdjnBmlDEBPuWYJTX8Jf0MQClOJhcyP+R0gAAaqnERMfZhhYdrP22Ou8Knf8EGxfM9641MKJ3EdHmbMc9LC/AZJiUbbTzevWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067200; c=relaxed/simple;
	bh=QVMj3p8PY473t7e58uil/ynfGDMwKfuC7LWNRzl0aJw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KiJEPpxLlTNmx51FJIqCuV4A8L1Nc0ZQgqu2LZIspKD5DLdz3XS1u5Z7JtQ1kBmv+jNiFklbbUcODDBE4SYd3C3fqbkXNv945xxlO9fOc+4aInXm25xuhN1HC+yovzlRZ3gCWMy3FGjyR0mMRXVg7f/Lu/QNJWJ38s9PP0oabA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eE6hmEhL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eE6hmEhL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E10D2117B
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737067196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Yzl2mq+9AyF7uO2kUc3Uu8JczqJZe7kP87IoN/f6og=;
	b=eE6hmEhLmYXEqF8nKqZxCCOGVplpqO+5gZaeqHUiMP0UHKrmgSVp4fN4O2YjGYmsMj4l/i
	WCdk2Xxv3NMilPKsTy/dpnY+MyXZyBXf+uqZmXw6N/An6cbyZvxuc9xW+lVUj5NeiGos75
	ALtarZJNu7XOoNm54Gp1jendRB/3qgw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737067196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Yzl2mq+9AyF7uO2kUc3Uu8JczqJZe7kP87IoN/f6og=;
	b=eE6hmEhLmYXEqF8nKqZxCCOGVplpqO+5gZaeqHUiMP0UHKrmgSVp4fN4O2YjGYmsMj4l/i
	WCdk2Xxv3NMilPKsTy/dpnY+MyXZyBXf+uqZmXw6N/An6cbyZvxuc9xW+lVUj5NeiGos75
	ALtarZJNu7XOoNm54Gp1jendRB/3qgw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA03413332
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 22:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gazSHruKiWeYcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 22:39:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] Revert "btrfs: canonicalize the device path before adding it"
Date: Fri, 17 Jan 2025 09:09:34 +1030
Message-ID: <65c879f1c79f2171e64335a4f2045a0e604a1950.1737067145.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This reverts commit 7e06de7c83a746e58d4701e013182af133395188.

Commit 7e06de7c83a7 ("btrfs: canonicalize the device path before adding
it") tries to make btrfs to use "/dev/mapper/*" name first, then any
filename inside "/dev/" as the device path.

This is mostly fine when there is only the root namespace involved, but
when multiple namespace are involved, things can easily go wrong for the
d_path() usage.

As d_path() returns a file path that is namespace dependent, the
resulted string may not make any sense in another namespace.

Furthermore, the "/dev/" prefix checks itself is not reliable, one can
still make a valid initramfs without devtmpfs, and fill all needed
device nodes manually.

Overall the userspace has all its might to pass whatever device path for
mount, and we are not going to win the war trying to cover every corner
case.

So just revert that commit, and do no extra d_path() based file path
sanity check.

Link: https://lore.kernel.org/linux-fsdevel/20250115185608.GA2223535@zen.localdomain/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

Although most distros will mount devtmpfs on "/dev/", it may not be the
case for containers.
And d_path() result is always namespace dependent, it means the mount
source shown in mount info is never ensured to make sense in another
namespace anyway.

I do not see a future that we can win the cat-and-mouse game, and the
complexity of the file path sanity check will only grow and grow,
eventually get out-of-control.

Thus I recommend to cut the loss early.
---
 fs/btrfs/volumes.c | 87 +---------------------------------------------
 1 file changed, 1 insertion(+), 86 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a594f66daedf..e511743bbc08 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -733,78 +733,6 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
-/*
- * We can have very weird soft links passed in.
- * One example is "/proc/self/fd/<fd>", which can be a soft link to
- * a block device.
- *
- * But it's never a good idea to use those weird names.
- * Here we check if the path (not following symlinks) is a good one inside
- * "/dev/".
- */
-static bool is_good_dev_path(const char *dev_path)
-{
-	struct path path = { .mnt = NULL, .dentry = NULL };
-	char *path_buf = NULL;
-	char *resolved_path;
-	bool is_good = false;
-	int ret;
-
-	if (!dev_path)
-		goto out;
-
-	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!path_buf)
-		goto out;
-
-	/*
-	 * Do not follow soft link, just check if the original path is inside
-	 * "/dev/".
-	 */
-	ret = kern_path(dev_path, 0, &path);
-	if (ret)
-		goto out;
-	resolved_path = d_path(&path, path_buf, PATH_MAX);
-	if (IS_ERR(resolved_path))
-		goto out;
-	if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
-		goto out;
-	is_good = true;
-out:
-	kfree(path_buf);
-	path_put(&path);
-	return is_good;
-}
-
-static int get_canonical_dev_path(const char *dev_path, char *canonical)
-{
-	struct path path = { .mnt = NULL, .dentry = NULL };
-	char *path_buf = NULL;
-	char *resolved_path;
-	int ret;
-
-	if (!dev_path) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!path_buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = kern_path(dev_path, LOOKUP_FOLLOW, &path);
-	if (ret)
-		goto out;
-	resolved_path = d_path(&path, path_buf, PATH_MAX);
-	ret = strscpy(canonical, resolved_path, PATH_MAX);
-out:
-	kfree(path_buf);
-	path_put(&path);
-	return ret;
-}
-
 static bool is_same_device(struct btrfs_device *device, const char *new_path)
 {
 	struct path old = { .mnt = NULL, .dentry = NULL };
@@ -1509,23 +1437,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct file *bdev_file;
-	char *canonical_path = NULL;
 	u64 bytenr;
 	dev_t devt;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (!is_good_dev_path(path)) {
-		canonical_path = kmalloc(PATH_MAX, GFP_KERNEL);
-		if (canonical_path) {
-			ret = get_canonical_dev_path(path, canonical_path);
-			if (ret < 0) {
-				kfree(canonical_path);
-				canonical_path = NULL;
-			}
-		}
-	}
 	/*
 	 * Avoid an exclusive open here, as the systemd-udev may initiate the
 	 * device scan which may race with the user's mount or mkfs command,
@@ -1570,8 +1487,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto free_disk_super;
 	}
 
-	device = device_list_add(canonical_path ? : path, disk_super,
-				 &new_device_added);
+	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
@@ -1580,7 +1496,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 error_bdev_put:
 	fput(bdev_file);
-	kfree(canonical_path);
 
 	return device;
 }
-- 
2.48.0


