Return-Path: <linux-btrfs+bounces-15884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF25EB1BFB5
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C382C1842A8
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D931F561D;
	Wed,  6 Aug 2025 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fjp8qY3a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fjp8qY3a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62A1EE7B9
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455772; cv=none; b=g7Lb6SMJN2hXubkA9taX47OMDTTVQ8bCf/6rLPspUz7d/5CSJ5o5BW41wrAdg3vB4g6Vstrnrexac6epWv3D7cp6kFN7XxevP+pbG2GQ99Wh42+LZx4Q91jyvnieB7wz7F/RCGcLkOrpYykEV0lABMIOeGsVc22jLL9Xa9b8N94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455772; c=relaxed/simple;
	bh=iJ65xyV2485bQ0D8wNHOFM7JbAffV6EmjI2fxZdq5CQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlTHpAOH4XYhuRYkoXUSnzDHyrQb9cB8E+2uv69GhvKFRMZSa+Kec8Li7kU9lPOeUaBNlgKVlXVnBYcolFha2fZW2sTw/Jykse6fHN+749DIXkrX+i0kB3K6YN0aTHOJO9at64E/h6FjA+jBF+rvE9rqgn2gWraMNIMFmd4x0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fjp8qY3a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fjp8qY3a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5773211F5
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtAOemyf8o5OY7sa4HD0ZwTUqZwzO3Ow+xyvMR0xyzs=;
	b=fjp8qY3aij/qbm/Gl637bZtPbpTWIS0KsroURuet3wKOPaH1ihTm6jEV8yzlx6bo4pBhd5
	dUfINcyhmeM2B3xi6v6hIdVNQ8hIb0K+Ivxt14e3siiJqfBlK0/kfn4ntDXu8ubGZFCWTV
	9Q/ASyowNhRqpJ7aIs7tNa4UK9dLwGk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fjp8qY3a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtAOemyf8o5OY7sa4HD0ZwTUqZwzO3Ow+xyvMR0xyzs=;
	b=fjp8qY3aij/qbm/Gl637bZtPbpTWIS0KsroURuet3wKOPaH1ihTm6jEV8yzlx6bo4pBhd5
	dUfINcyhmeM2B3xi6v6hIdVNQ8hIb0K+Ivxt14e3siiJqfBlK0/kfn4ntDXu8ubGZFCWTV
	9Q/ASyowNhRqpJ7aIs7tNa4UK9dLwGk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E84A13AA8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJaUNM7ekmjFRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Aug 2025 04:49:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/6] btrfs-progs: add error handling for device_get_partition_size()
Date: Wed,  6 Aug 2025 14:18:54 +0930
Message-ID: <aaefe04f784bc601f355d13b3b0ecbde1aa44dee.1754455239.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754455239.git.wqu@suse.com>
References: <cover.1754455239.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D5773211F5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The function device_get_partition_size() has all kinds of error paths,
but it has no way to return error other than returning 0.

This is not helpful for end users to know what's going wrong.

Change that function to return s64, as even the kernel won't return a
block size larger than LLONG_MAX.
Thus we're safe to use the minus range of s64 to indicate an error.

The only exception is load_device_info() which will only give a warning
and continue.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem-usage.c | 13 +++++++++++--
 cmds/replace.c          | 14 ++++++++++++--
 common/device-utils.c   | 34 ++++++++++++++++------------------
 common/device-utils.h   |  2 +-
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index f812af13482e..755f540ac0bf 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -819,9 +819,18 @@ static int load_device_info(int fd, struct array *devinfos)
 		if (!dev_info.path[0]) {
 			strcpy(info->path, "missing");
 		} else {
+			s64 dev_size;
+
 			strcpy(info->path, (char *)dev_info.path);
-			info->device_size =
-				device_get_partition_size((const char *)dev_info.path);
+			dev_size = device_get_partition_size((const char *)dev_info.path);
+			if (dev_size < 0) {
+				errno = -dev_size;
+				warning("failed to get device size for %s: %m",
+					dev_info.path);
+				info->device_size = 0;
+			} else {
+				info->device_size = dev_size;
+			}
 		}
 		info->size = dev_info.total_bytes;
 		ndevs++;
diff --git a/cmds/replace.c b/cmds/replace.c
index 887c3251a725..bb8f81979389 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -136,8 +136,8 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	bool force_using_targetdev = false;
 	u64 dstdev_block_count;
 	bool do_not_background = false;
-	u64 srcdev_size;
-	u64 dstdev_size;
+	s64 srcdev_size;
+	s64 dstdev_size;
 	bool enqueue = false;
 	bool discard = true;
 
@@ -270,6 +270,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
 		start_args.start.srcdevid = 0;
 		srcdev_size = device_get_partition_size(srcdev);
+		if (srcdev_size < 0) {
+			errno = -srcdev_size;
+			error("failed to get device size for %s: %m", srcdev);
+			goto leave_with_error;
+		}
 	} else {
 		error("source device must be a block device or a devid");
 		goto leave_with_error;
@@ -280,6 +285,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 		goto leave_with_error;
 
 	dstdev_size = device_get_partition_size(dstdev);
+	if (dstdev_size < 0) {
+		errno = -dstdev_size;
+		error("failed to get device size for %s: %m", dstdev);
+		goto leave_with_error;
+	}
 	if (srcdev_size > dstdev_size) {
 		error("target device smaller than source device (required %llu bytes)",
 			srcdev_size);
diff --git a/common/device-utils.c b/common/device-utils.c
index b32bd2cec1f1..8b545d171b18 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -329,7 +329,7 @@ u64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
 	return 0;
 }
 
-static u64 device_get_partition_size_sysfs(const char *dev)
+static s64 device_get_partition_size_sysfs(const char *dev)
 {
 	int ret;
 	char path[PATH_MAX] = {};
@@ -341,33 +341,30 @@ static u64 device_get_partition_size_sysfs(const char *dev)
 
 	name = realpath(dev, path);
 	if (!name)
-		return 0;
+		return -errno;
 	name = path_basename(path);
 
 	ret = path_cat3_out(sysfs, "/sys/class/block", name, "size");
 	if (ret < 0)
-		return 0;
+		return ret;
 	sysfd = open(sysfs, O_RDONLY);
 	if (sysfd < 0)
-		return 0;
+		return -errno;
 	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
-	if (ret < 0) {
-		close(sysfd);
-		return 0;
-	}
+	close(sysfd);
+	if (ret < 0)
+		return ret;
 	errno = 0;
 	size = strtoull(sizebuf, NULL, 10);
-	if (size == ULLONG_MAX && errno == ERANGE) {
-		close(sysfd);
-		return 0;
-	}
-	close(sysfd);
-
-	/* <device>/size value is in sector (512B) unit. */
+	if (size == ULLONG_MAX && errno == ERANGE)
+		return -ERANGE;
+	/* Extra overflow check. */
+	if (size > LLONG_MAX >> SECTOR_SHIFT)
+		return -ERANGE;
 	return size << SECTOR_SHIFT;
 }
 
-u64 device_get_partition_size(const char *dev)
+s64 device_get_partition_size(const char *dev)
 {
 	u64 result;
 	int fd = open(dev, O_RDONLY);
@@ -377,10 +374,11 @@ u64 device_get_partition_size(const char *dev)
 
 	if (ioctl(fd, BLKGETSIZE64, &result) < 0) {
 		close(fd);
-		return 0;
+		return -errno;
 	}
 	close(fd);
-
+	if (result > LLONG_MAX)
+		return -ERANGE;
 	return result;
 }
 
diff --git a/common/device-utils.h b/common/device-utils.h
index 82e6ba547585..2ada057adcd3 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -42,7 +42,7 @@ enum {
  */
 int device_discard_blocks(int fd, u64 start, u64 len);
 int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
-u64 device_get_partition_size(const char *dev);
+s64 device_get_partition_size(const char *dev);
 u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
 int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
 u64 device_get_zone_unusable(int fd, u64 flags);
-- 
2.50.1


