Return-Path: <linux-btrfs+bounces-13498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325EFAA07BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 11:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E5C1B605F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49D2BD5BA;
	Tue, 29 Apr 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FSg5RWD9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FSg5RWD9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C671279338
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920271; cv=none; b=F0QNmk/SQANDa+ZmLqHNQPexZ2MZAHhbt8fkTSi/gnhvVQrIln8JB/DkdOI9F+L4rT2XVJnY8JPyBKixqYcxR+ng2tTHeDFyC2Ab7x6bC1+hnrRg69bEvaiIBEi6nApVnBJZsE06JagTqbnYNmmo/advJU5JEObUHy7gRtnFwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920271; c=relaxed/simple;
	bh=+UJdWFMW5joidp/JYWaoNzUNW+IV8fxLow6OD0fjKEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpNpHZ+8FfmQbV2pd79YIcJj9TQqnPoSvq7MoNa3LqrnEoJtiQX5lzLeAT1EjrZ41ppUTyn0A7uk1iicRr+oro8/biobltOGgytQrrDE0Cnd5rVqi5re08xk9C/y7tgu5Kk+B6VaNBrSEP8MyxcmwMMQjG0Wv3+idYz6r/T3wTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FSg5RWD9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FSg5RWD9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0656121205;
	Tue, 29 Apr 2025 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745920267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RkJuZWIxkoCXc1YclSCg1K77r6VFE9ztX6y+1ym3vLU=;
	b=FSg5RWD93Qbw7LWgq/EDyRoJlS1dwoZfs4FZax3WNCapdTqwjom83In3fh5P9vYfdINm34
	R8roBypZM0KNAusqLfq1hGCSGXzv6gMngq5P756DA1NZ6pKa7mTFyVLBVYnO46J/zJLA2L
	6oajYhXnq/lVIzNwOmIw018lfWXti/Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FSg5RWD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745920267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RkJuZWIxkoCXc1YclSCg1K77r6VFE9ztX6y+1ym3vLU=;
	b=FSg5RWD93Qbw7LWgq/EDyRoJlS1dwoZfs4FZax3WNCapdTqwjom83In3fh5P9vYfdINm34
	R8roBypZM0KNAusqLfq1hGCSGXzv6gMngq5P756DA1NZ6pKa7mTFyVLBVYnO46J/zJLA2L
	6oajYhXnq/lVIzNwOmIw018lfWXti/Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C4831340C;
	Tue, 29 Apr 2025 09:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PVB0MAmhEGjLIQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 29 Apr 2025 09:51:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH] Revert "btrfs: canonicalize the device path before adding it"
Date: Tue, 29 Apr 2025 19:20:48 +0930
Message-ID: <d944d52aa8635cb860dd68adaf30a64e116294d9.1745920244.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0656121205
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
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
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
RFC->v1:
- Add Reviewed-by tag
- Rebased to the latest for-next branch
  Minor rename related conflicts
---
 fs/btrfs/volumes.c | 91 +---------------------------------------------
 1 file changed, 1 insertion(+), 90 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fc7c931e71b4..85fa73b32eb0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -733,82 +733,6 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
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
-	if (IS_ERR(resolved_path)) {
-		ret = PTR_ERR(resolved_path);
-		goto out;
-	}
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
@@ -1513,23 +1437,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
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
@@ -1574,8 +1487,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto free_disk_super;
 	}
 
-	device = device_list_add(canonical_path ? : path, disk_super,
-				 &new_device_added);
+	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
@@ -1584,7 +1496,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 error_bdev_put:
 	fput(bdev_file);
-	kfree(canonical_path);
 
 	return device;
 }
-- 
2.49.0


