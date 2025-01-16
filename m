Return-Path: <linux-btrfs+bounces-10980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48EA136D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539EE3A7356
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316A1DAC97;
	Thu, 16 Jan 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gUUvnQG2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gUUvnQG2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28091198A29
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020604; cv=none; b=cKbyV4KUUA8o2uiGopduMRBrVOx9nuXZxX+1e6JKs1o4itm+YAz1cSVahzpCGbAU7CHaaiGy0sGwUeSFqy3M4JJjVKuAlWR/zSo9Wx4oo2/Ds3qwgp/dzVJ5tGf1cP72d24crRq0NwkBTAfwVW1ahD/kxwskLfzzK5u0VpO1+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020604; c=relaxed/simple;
	bh=9hqYj6ZilmClVrv+ZlswKj1Odh6vMip+qYI9Ce28FGM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sWT2dL4HOdJ5wkw2rVl074qU+ESGBqhyvsaXWwPS6Qxco3OmGsguNu3JuY03qvdhoFF25Evs59ifEiZSKOKMc3wCjiOGSWx8JnOdfG3LjLSG1PQee3k6LMi3ZS8WlGccywELtfml+TdWAu7+YpA8a3tIN5oLXbmFcWUwtE4QYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gUUvnQG2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gUUvnQG2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C2C31F7A3
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737020600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BUAHUMCyGbSXN9XNnGpVKHbmmXifi+d1aJ5jH084nkw=;
	b=gUUvnQG2q7sG2IgUT2YPfFI3QvLwcFYo/e0W0ttOTKiWzs2e3vLYxO7BcK0jczp5z5yLdA
	g/NtkyQ6e7XmKCqIZg6ntZ9ZPeIOfV87Lj6ifas0NXOTYEWixGiAtaOXfNGVqupsWtIfwJ
	qnZprV9c6KtYyY212CoUDobt/iyDdJ8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gUUvnQG2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737020600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BUAHUMCyGbSXN9XNnGpVKHbmmXifi+d1aJ5jH084nkw=;
	b=gUUvnQG2q7sG2IgUT2YPfFI3QvLwcFYo/e0W0ttOTKiWzs2e3vLYxO7BcK0jczp5z5yLdA
	g/NtkyQ6e7XmKCqIZg6ntZ9ZPeIOfV87Lj6ifas0NXOTYEWixGiAtaOXfNGVqupsWtIfwJ
	qnZprV9c6KtYyY212CoUDobt/iyDdJ8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5471913332
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 09:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZhaTBbfUiGfUawAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 09:43:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: remove loopback device resolution
Date: Thu, 16 Jan 2025 20:13:01 +1030
Message-ID: <6094201431aa981c6e0d149b6d528bc4b7a5af91.1737020580.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C2C31F7A3
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
mkfs.btrfs has a built-in loopback device resolution, to avoid the same
file being added to the same fs, using loopback device and the file
itself.

But it has one big bug:

- It doesn't detect partition on loopback devices correctly
  The function is_loop_device() only utilize major number to detect a
  loopback device.
  But partitions on loopback devices doesn't use the same major number
  as the loopback device:

  NAME            MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
  loop0             7:0    0    5G  0 loop
  |-loop0p1       259:3    0  128M  0 part
  `-loop0p2       259:4    0  4.9G  0 part

  Thus `/dev/loop0p1` will not be treated as a loopback device, thus it
  will not even resolve the source file.

  And this can not even be fixed, as if we do extra "/dev/loop*" based
  file lookup, `/dev/loop0p1` and `/dev/loop0p2` will resolve to the
  same source file, and refuse to mkfs on two different partitions.

[FIX]
The loopback file detection is the baby sitting that no one asks for.

Just as I explained, it only brings new bugs, and we will never fix all
ways that an experienced user can come up with.
And I didn't see any other mkfs tool doing such baby sitting.

So remove the loopback file resolution, just regular is_same_blk_file()
is good enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/open-utils.c |   7 ++-
 common/path-utils.c | 127 +-------------------------------------------
 common/path-utils.h |   2 +-
 3 files changed, 5 insertions(+), 131 deletions(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index 8490be4af070..a292177691e7 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -36,8 +36,7 @@
 #include "common/open-utils.h"
 
 /*
- * Check if a file is used (directly or indirectly via a loop device) by a
- * device in fs_devices
+ * Check if a file is used  by a device in fs_devices
  */
 static int blk_file_in_dev_list(struct btrfs_fs_devices* fs_devices,
 		const char* file)
@@ -46,7 +45,7 @@ static int blk_file_in_dev_list(struct btrfs_fs_devices* fs_devices,
 	struct btrfs_device *device;
 
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		if((ret = is_same_loop_file(device->name, file)))
+		if((ret = is_same_blk_file(device->name, file)))
 			return ret;
 	}
 
@@ -94,7 +93,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 			else if(!ret)
 				continue;
 
-			ret = is_same_loop_file(file, mnt->mnt_fsname);
+			ret = is_same_blk_file(file, mnt->mnt_fsname);
 		}
 
 		if(ret < 0)
diff --git a/common/path-utils.c b/common/path-utils.c
index 04861d1668cb..3030ddc47f0c 100644
--- a/common/path-utils.c
+++ b/common/path-utils.c
@@ -107,87 +107,11 @@ int path_exists(const char *path)
 	return 1;
 }
 
-/* checks if a device is a loop device */
-static int is_loop_device(const char *device)
-{
-	struct stat statbuf;
-
-	if(stat(device, &statbuf) < 0)
-		return -errno;
-
-	return (S_ISBLK(statbuf.st_mode) &&
-		MAJOR(statbuf.st_rdev) == LOOP_MAJOR);
-}
-
-/*
- * Takes a loop device path (e.g. /dev/loop0) and returns
- * the associated file (e.g. /images/my_btrfs.img) using
- * loopdev API
- */
-static int resolve_loop_device_with_loopdev(const char* loop_dev, char* loop_file)
-{
-	int fd;
-	int ret;
-	struct loop_info64 lo64;
-
-	fd = open(loop_dev, O_RDONLY | O_NONBLOCK);
-	if (fd < 0)
-		return -errno;
-	ret = ioctl(fd, LOOP_GET_STATUS64, &lo64);
-	if (ret < 0) {
-		ret = -errno;
-		goto out;
-	}
-
-	memcpy(loop_file, lo64.lo_file_name, sizeof(lo64.lo_file_name));
-	loop_file[sizeof(lo64.lo_file_name)] = 0;
-
-out:
-	close(fd);
-
-	return ret;
-}
-
-/*
- * Takes a loop device path (e.g. /dev/loop0) and returns
- * the associated file (e.g. /images/my_btrfs.img)
- */
-static int resolve_loop_device(const char* loop_dev, char* loop_file,
-		int max_len)
-{
-	int ret;
-	FILE *f;
-	char fmt[20];
-	char p[PATH_MAX];
-	char real_loop_dev[PATH_MAX];
-
-	if (!realpath(loop_dev, real_loop_dev))
-		return -errno;
-	snprintf(p, PATH_MAX, "/sys/block/%s/loop/backing_file", strrchr(real_loop_dev, '/'));
-	if (!(f = fopen(p, "r"))) {
-		if (errno == ENOENT)
-			/*
-			 * It's possibly a partitioned loop device, which is
-			 * resolvable with loopdev API.
-			 */
-			return resolve_loop_device_with_loopdev(loop_dev, loop_file);
-		return -errno;
-	}
-
-	snprintf(fmt, 20, "%%%i[^\n]", max_len - 1);
-	ret = fscanf(f, fmt, loop_file);
-	fclose(f);
-	if (ret == EOF)
-		return -errno;
-
-	return 0;
-}
-
 /*
  * Checks whether a and b are identical or device
  * files associated with the same block device
  */
-static int is_same_blk_file(const char* a, const char* b)
+int is_same_blk_file(const char* a, const char* b)
 {
 	struct stat st_buf_a, st_buf_b;
 	char real_a[PATH_MAX];
@@ -224,55 +148,6 @@ static int is_same_blk_file(const char* a, const char* b)
 	return 0;
 }
 
-/*
- * Checks if a and b are identical or device files associated with the same
- * block device or if one file is a loop device that uses the other file.
- */
-int is_same_loop_file(const char *a, const char *b)
-{
-	char res_a[PATH_MAX];
-	char res_b[PATH_MAX];
-	const char* final_a = NULL;
-	const char* final_b = NULL;
-	int ret;
-
-	/* Resolve a if it is a loop device */
-	if ((ret = is_loop_device(a)) < 0) {
-		if (ret == -ENOENT)
-			return 0;
-		return ret;
-	} else if (ret) {
-		ret = resolve_loop_device(a, res_a, sizeof(res_a));
-		if (ret < 0) {
-			if (errno != EPERM)
-				return ret;
-		} else {
-			final_a = res_a;
-		}
-	} else {
-		final_a = a;
-	}
-
-	/* Resolve b if it is a loop device */
-	if ((ret = is_loop_device(b)) < 0) {
-		if (ret == -ENOENT)
-			return 0;
-		return ret;
-	} else if (ret) {
-		ret = resolve_loop_device(b, res_b, sizeof(res_b));
-		if (ret < 0) {
-			if (errno != EPERM)
-				return ret;
-		} else {
-			final_b = res_b;
-		}
-	} else {
-		final_b = b;
-	}
-
-	return is_same_blk_file(final_a, final_b);
-}
-
 /* Checks if a file exists and is a block or regular file*/
 int path_is_reg_or_block_device(const char *filename)
 {
diff --git a/common/path-utils.h b/common/path-utils.h
index 558fa21adfa1..6efcd81cf860 100644
--- a/common/path-utils.h
+++ b/common/path-utils.h
@@ -31,7 +31,7 @@ int path_is_a_mount_point(const char *file);
 int path_exists(const char *file);
 int path_is_reg_file(const char *path);
 int path_is_dir(const char *path);
-int is_same_loop_file(const char *a, const char *b);
+int is_same_blk_file(const char* a, const char* b);
 int path_is_reg_or_block_device(const char *filename);
 int path_is_in_dir(const char *parent, const char *path);
 char *path_basename(char *path);
-- 
2.48.0


