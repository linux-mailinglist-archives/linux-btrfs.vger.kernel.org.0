Return-Path: <linux-btrfs+bounces-8282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08987987E00
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 07:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E681C21FA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7031177991;
	Fri, 27 Sep 2024 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mknJ26kC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mknJ26kC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BA16DEB2
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416430; cv=none; b=rmVw/8qRYhttNzuiw0E5mi4MdvLczpHrE3iNtwK6eOGuk9Qz3HDPqU0SYpg+D/huTE0tJk5KWwIvWEjsoMZvP0itHStMKBWvC1WTlZ/RN9PB0ud9bWZQAEK0nmkaT0dytAgBKhgx75zXcoD6d3wDfnLevHjvWt0UiN3NFDBeqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416430; c=relaxed/simple;
	bh=BfkFrqL5qBnXxsZP40+e1CyE8Gi56JZTP8JlxrXuA8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+BKzUOY7oY1XtnqlgvieDeIkS/mKTrAt05eChxNU17+nBL6xfHMVLpLBGHo1+OjA7MEM8kB6W40aIECrDhnQXE2wwkfhtL07BkpMhHswhHGmyv1YB3RGfKTN4xGqWvO/5TveFaZwZCo/PRvVopidgx3PUbfO4ogZwjWTJoUm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mknJ26kC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mknJ26kC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0084B21AD5;
	Fri, 27 Sep 2024 05:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727416426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA/T0vJdr4beX+5VLSSRLuWUZKQr++pwNNTJ2mMBF9Y=;
	b=mknJ26kCvAV5WUdenpJJCYcYl4dDnC/EBJX4SISnsnbhDkEwdrccf+GS7pM4VTP2T+8q8R
	CpxK8EA6/Li/qbFyfzJCw5NKypVcdYY3h8ACULU99IR3Ah085cTBzjoTiuHoa5bULfXFON
	COnmx8Uwn7oOWClT6XwvVBRW6LnK+qo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727416426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA/T0vJdr4beX+5VLSSRLuWUZKQr++pwNNTJ2mMBF9Y=;
	b=mknJ26kCvAV5WUdenpJJCYcYl4dDnC/EBJX4SISnsnbhDkEwdrccf+GS7pM4VTP2T+8q8R
	CpxK8EA6/Li/qbFyfzJCw5NKypVcdYY3h8ACULU99IR3Ah085cTBzjoTiuHoa5bULfXFON
	COnmx8Uwn7oOWClT6XwvVBRW6LnK+qo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6C7613A58;
	Fri, 27 Sep 2024 05:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QI6tKWhI9maDBwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 27 Sep 2024 05:53:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Ben Millwood <thebenmachine@gmail.com>
Subject: [PATCH 1/2] btrfs-progs: receive: workaround unaligned full file clone
Date: Fri, 27 Sep 2024 15:23:24 +0930
Message-ID: <16df770373ded4bf871d9d89f5af1ea7865de896.1727416314.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727416314.git.wqu@suse.com>
References: <cover.1727416314.git.wqu@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
The following script can lead to receive failure with latest kernel:

  dev="/dev/test/scratch1"
  mnt="/mnt/btrfs"

  mkfs.btrfs -f $dev
  mount $dev $mnt
  btrfs subv create $mnt/subv1
  xfs_io -f -c "pwrite 0 4000" $mnt/subv1/source
  xfs_io -f -c "reflink $mnt/subv1/source" $mnt/subv1/dest
  btrfs subv snap -r $mnt/subv1 $mnt/ro_subv1
  btrfs subv snap $mnt/subv1 $mnt/snap1
  xfs_io -f -c "pwrite -S 0xff 0 3900" -c "truncate 3900" $mnt/snap1/source
  truncate -s 0 $mnt/snap1/dest
  xfs_io -f -c "reflink $mnt/snap1/source" $mnt/snap1/dest
  btrfs subv snap -r $mnt/snap1 $mnt/ro_snap1
  btrfs send $mnt/ro_subv1 -f /tmp/ro_subv1.stream
  btrfs send -p $mnt/ro_subv1 $mnt/ro_snap1 -f /tmp/ro_snap1.stream
  umount $mnt
  mkfs.btrfs -f $dev
  mount $dev $mnt
  btrfs receive -f /tmp/ro_subv1.stream $mnt
  btrfs receive -f /tmp/ro_snap1.stream $mnt
  At snapshot ro_snap1
  ERROR: failed to clone extents to dest: Invalid argument

[CAUSE]
Since kernel commit 46a6e10a1ab1 ("btrfs: send: allow cloning
non-aligned extent if it ends at i_size"), kernel can send out clone
stream if we're cloning a full file, even if the size of the file is not
sector aligned, like this one:

  snapshot        ./ro_snap1                      uuid=2a3e2b70-c606-d446-b60b-baab458be6da transid=9 parent_uuid=d8ff9b9e-3ffc-6343-b53e-e22f8bbb7c25 parent_transid=7
  write           ./ro_snap1/source               offset=0 len=4700
  truncate        ./ro_snap1/source               size=4700
  utimes          ./ro_snap1/source               atime=2024-09-27T13:08:54+0800 mtime=2024-09-27T13:08:54+0800 ctime=2024-09-27T13:08:54+0800
  clone           ./ro_snap1/dest                 offset=0 len=4700 from=./ro_snap1/source clone_offset=0
  truncate        ./ro_snap1/dest                 size=4700
  utimes          ./ro_snap1/dest                 atime=2024-09-27T13:08:54+0800 mtime=2024-09-27T13:08:54+0800 ctime=2024-09-27T13:08:54+0800

However for the clone command, if the file inside the source subvolume
is larger than the new size, kernel will reject the clone operation, as
the resulted layout may read beyond the EOF of the clone source.

This should be addressed by the kernel, by doing the truncation before
the clone to ensure the destination file is no larger than the source.

[FIX]
It won't hurt for "btrfs receive" command to workaround the
problem, by truncating the destination file first.

Here we choose to truncate the file size to 0, other than the
source/destination file size.
As truncating to an unaligned size can cause the fs to do extra page
dirty and zero the tailing part.

Since we know it's a full file clone, truncating the file to size 0 will
avoid the extra page dirty, and allow the later clone to be done.

Reported-by: Ben Millwood <thebenmachine@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/receive.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/cmds/receive.c b/cmds/receive.c
index 4cc5b9009442..9bda5485d895 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -56,6 +56,8 @@
 #include "cmds/commands.h"
 #include "cmds/receive-dump.h"
 
+static u32 g_sectorsize;
+
 struct btrfs_receive
 {
 	int mnt_fd;
@@ -739,6 +741,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	struct btrfs_receive *rctx = user;
 	struct btrfs_ioctl_clone_range_args clone_args;
 	struct subvol_info *si = NULL;
+	struct stat st = { 0 };
 	char full_path[PATH_MAX];
 	const char *subvol_path;
 	char full_clone_path[PATH_MAX];
@@ -802,11 +805,36 @@ static int process_clone(const char *path, u64 offset, u64 len,
 		error("cannot open %s: %m", full_clone_path);
 		goto out;
 	}
+	ret = fstat(clone_fd, &st);
+	if (ret < 0) {
+		errno = -ret;
+		error("cannot stat %s: %m", full_clone_path);
+		goto out;
+	}
 
 	if (bconf.verbose >= 2)
 		fprintf(stderr,
 			"clone %s - source=%s source offset=%llu offset=%llu length=%llu\n",
 			path, clone_path, clone_offset, offset, len);
+	/*
+	 * Since kernel commit 46a6e10a1ab1 ("btrfs: send: allow cloning
+	 * non-aligned extent if it ends at i_size"), we can have send
+	 * stream cloning a full file even its size is not sector aligned.
+	 *
+	 * But if we're cloning this unaligned range into an existing file,
+	 * which has a larger i_size, the clone will fail.
+	 *
+	 * Address this quirk by introducing an extra truncation to size 0.
+	 */
+	if (clone_offset == 0 && !IS_ALIGNED(len, g_sectorsize) &&
+	    len == st.st_size) {
+		ret = ftruncate(rctx->write_fd, 0);
+		if (ret < 0) {
+			errno = - ret;
+			error("failed to truncate %s: %m", path);
+			goto out;
+		}
+	}
 
 	clone_args.src_fd = clone_fd;
 	clone_args.src_offset = clone_offset;
@@ -1468,6 +1496,18 @@ static struct btrfs_send_ops send_ops = {
 	.enable_verity = process_enable_verity,
 };
 
+static int get_fs_sectorsize(int fd, u32 *sectorsize_ret)
+{
+	struct btrfs_ioctl_fs_info_args args = { 0 };
+	int ret;
+
+	ret = ioctl(fd, BTRFS_IOC_FS_INFO, &args);
+	if (ret < 0)
+		return -errno;
+	*sectorsize_ret = args.sectorsize;
+	return 0;
+}
+
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
 		      char *realmnt, int r_fd, u64 max_errors)
 {
@@ -1491,6 +1531,13 @@ static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
 			dest_dir_full_path);
 		goto out;
 	}
+	ret = get_fs_sectorsize(rctx->dest_dir_fd, &g_sectorsize);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get sectorsize of the destination directory %s: %m",
+			dest_dir_full_path);
+		goto out;
+	}
 
 	if (realmnt[0]) {
 		rctx->root_path = realmnt;
-- 
2.46.1


