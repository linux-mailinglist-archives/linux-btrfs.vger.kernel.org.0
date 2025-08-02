Return-Path: <linux-btrfs+bounces-15801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BBBB18AF4
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA56242A6
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C931DF26A;
	Sat,  2 Aug 2025 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BljHvRkk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BljHvRkk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E91DD877
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117790; cv=none; b=aG5TyCwxoPyp4gIlF/WAh4uyoUJkaj6vMXdi+tAaQ7Sp/oQKDiDJkYay5bLWcY/FW//jMK0ONik9utOE6ZSyhzh20FhLvqLTgFrtBy6RL9ThGnZVnQPS9bfgmZYezAo/NhM3ZX+aipUwgW8VyKWXlCPmjmYiMuX1gI3o4DTxMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117790; c=relaxed/simple;
	bh=r6qyvRnzzXLN1g0sCdo5f7W2Tm3YBoWZj/L4aL1cnx4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqnT33FyQAcdbWPPCTohoVz4cpJwWe2cIR6kB1WyTa3QCXrw3CRt+htCsgDm9R2I39lImELh81LOQo0ijJaFsTC5CLj9Cv+E7f7lHM8Ehvc7tHhqqwmNOTQePYXNNvIcnGGBm1lbhh/Zy/6DAfpwLkT9udyTwKjT/pvSPzT8xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BljHvRkk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BljHvRkk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0707A1F456
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VOMo6WSkvn8K61WCnSlKHrjOVqn7ERn5jlCJqUFhF0=;
	b=BljHvRkk41j2kUTR+CNuQCaEnO+cK1a+ZIfWCMgxaZnrRjAjujUZceVTt9QS8RL96InBLF
	+FlmHvT9VUUwKZm/5lJjnE/aB/YVVcPfmaiLFGmIY7F4KngosCJLaA02oOo1llnAVuyHiC
	E1Eo5XKf/rO1p5I5cWGEfAz6EecyQr0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BljHvRkk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VOMo6WSkvn8K61WCnSlKHrjOVqn7ERn5jlCJqUFhF0=;
	b=BljHvRkk41j2kUTR+CNuQCaEnO+cK1a+ZIfWCMgxaZnrRjAjujUZceVTt9QS8RL96InBLF
	+FlmHvT9VUUwKZm/5lJjnE/aB/YVVcPfmaiLFGmIY7F4KngosCJLaA02oOo1llnAVuyHiC
	E1Eo5XKf/rO1p5I5cWGEfAz6EecyQr0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D952133D1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kL4GAIy2jWhhHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 06:56:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs-progs: add error handling for device_get_partition_size()
Date: Sat,  2 Aug 2025 16:25:48 +0930
Message-ID: <525dbf649790b855d109714bf9a82796fe3d7b1e.1754116463.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754116463.git.wqu@suse.com>
References: <cover.1754116463.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0707A1F456
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

The function device_get_partition_size() has all kinds of error paths,
but it has no way to return error other than returning 0.

This is not helpful for end users to know what's going wrong.

Change that function to have a dedicated return value for error
handling, and pass a u64 pointer for the result.

For most callers they are able to exit gracefully with a proper error
message.

But for load_device_info(), we allow a failed size probing to continue
without 0 size, just as the old code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem-usage.c |  9 +++++++--
 cmds/replace.c          | 14 ++++++++++++--
 common/device-utils.c   | 29 +++++++++++++++--------------
 common/device-utils.h   |  2 +-
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index f812af13482e..e367bffc3a01 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -820,8 +820,13 @@ static int load_device_info(int fd, struct array *devinfos)
 			strcpy(info->path, "missing");
 		} else {
 			strcpy(info->path, (char *)dev_info.path);
-			info->device_size =
-				device_get_partition_size((const char *)dev_info.path);
+			ret = device_get_partition_size((const char *)dev_info.path,
+							&info->device_size);
+			if (ret < 0) {
+				errno = -ret;
+				warning("failed to get device size for devid %llu: %m", dev_info.devid);
+				info->device_size = 0;
+			}
 		}
 		info->size = dev_info.total_bytes;
 		ndevs++;
diff --git a/cmds/replace.c b/cmds/replace.c
index 887c3251a725..d5b0b0e02ce1 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -269,7 +269,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 		strncpy_null((char *)start_args.start.srcdev_name, srcdev,
 			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
 		start_args.start.srcdevid = 0;
-		srcdev_size = device_get_partition_size(srcdev);
+		ret = device_get_partition_size(srcdev, &srcdev_size);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to get device size for %s: %m", srcdev);
+			goto leave_with_error;
+		}
 	} else {
 		error("source device must be a block device or a devid");
 		goto leave_with_error;
@@ -279,7 +284,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	if (ret)
 		goto leave_with_error;
 
-	dstdev_size = device_get_partition_size(dstdev);
+	ret = device_get_partition_size(dstdev, &dstdev_size);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get device size for %s: %m", dstdev);
+		goto leave_with_error;
+	}
 	if (srcdev_size > dstdev_size) {
 		error("target device smaller than source device (required %llu bytes)",
 			srcdev_size);
diff --git a/common/device-utils.c b/common/device-utils.c
index 783d79555446..6d89d16b029d 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -342,7 +342,7 @@ u64 device_get_partition_size_fd(int fd)
 	return result;
 }
 
-static u64 device_get_partition_size_sysfs(const char *dev)
+static int device_get_partition_size_sysfs(const char *dev, u64 *result_ret)
 {
 	int ret;
 	char path[PATH_MAX] = {};
@@ -354,45 +354,46 @@ static u64 device_get_partition_size_sysfs(const char *dev)
 
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
 	if (ret < 0) {
 		close(sysfd);
-		return 0;
+		return ret;
 	}
 	errno = 0;
 	size = strtoull(sizebuf, NULL, 10);
 	if (size == ULLONG_MAX && errno == ERANGE) {
 		close(sysfd);
-		return 0;
+		return -errno;
 	}
 	close(sysfd);
-	return size;
+	*result_ret = size;
+	return 0;
 }
 
-u64 device_get_partition_size(const char *dev)
+int device_get_partition_size(const char *dev, u64 *result_ret)
 {
-	u64 result;
 	int fd = open(dev, O_RDONLY);
 
 	if (fd < 0)
-		return device_get_partition_size_sysfs(dev);
+		return device_get_partition_size_sysfs(dev, result_ret);
+
+	if (ioctl(fd, BLKGETSIZE64, result_ret) < 0) {
+		int ret = -errno;
 
-	if (ioctl(fd, BLKGETSIZE64, &result) < 0) {
 		close(fd);
-		return 0;
+		return ret;
 	}
 	close(fd);
-
-	return result;
+	return 0;
 }
 
 /*
diff --git a/common/device-utils.h b/common/device-utils.h
index cef9405f3a9a..bf04eb0f2fdd 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -42,7 +42,7 @@ enum {
  */
 int device_discard_blocks(int fd, u64 start, u64 len);
 int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
-u64 device_get_partition_size(const char *dev);
+int device_get_partition_size(const char *dev, u64 *result_ret);
 u64 device_get_partition_size_fd(int fd);
 u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
 int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
-- 
2.50.1


