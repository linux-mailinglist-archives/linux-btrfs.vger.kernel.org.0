Return-Path: <linux-btrfs+bounces-2259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 093E984E9BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC090B266A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468044C7A;
	Thu,  8 Feb 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="30v20QSF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489723F9F8
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424253; cv=none; b=jfsTTeV9SKkAqrGidWNPwRLwo4vpoX3lFVPgY1IzNreBNv0luU3Gy2HlbgqPyxAfCaYMBxojvUf/zHowTlWqbDd8hPiHnDfJV4Tnxmi9rDPUyYYvB0a9ok0yHs3Qle/1VUvVzlzpT7447+lD5Lo6nfxZDJKOVXh6GMHmAZqX8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424253; c=relaxed/simple;
	bh=WkFAp1r3lf4xQYVqTfXRD7KJ1BNDbZWPodt4pZKcXWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtFT5sddhdoC/st1EdxFtcg0WUZkRbn5p94mJpg8Gv05ZfcHOgUIaXfneUmpsIqB7VaEgsconh1jGoRrejPEMfQC/AJLI0PdWNJp+c15a2s+zr/zWUMSfJQQBYq0uNG3SpoJDPl4lcAROsUSY5tGX3CaojSXap3PbUXYgLPWay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=30v20QSF; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVfoG; Thu, 08 Feb 2024 20:29:39 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/9] Killing dirstream: replace btrfs_open_dir with btrfs_open_dir_fd
Date: Thu,  8 Feb 2024 21:19:21 +0100
Message-ID: <9d7800b5c4b57f30333c0a93ff9d28dc8b387831.1707423567.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707423567.git.kreijack@inwind.it>
References: <cover.1707423567.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1707424179; bh=9Dcrhgyjxj5tFURKk2brlZMKyCkFPhdrsrIBqgE4aY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=30v20QSFQB74u7l0wgXoa9ny/+9rpMOo0Tj9MnF+Ft1Je2UrJBlZaXPjkrIy+Gr+G
	 3RaAO5QDSDz9MAA1+WO/i9NLqOTAk5PyHBAsl1noj661vRUIrjUwJ0KneR3YEMnSvm
	 AmRcU3ja87YrnCO0yd9QP/AcmYyTLa44VjfUKqLs=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This patch replaces the last btrfs_open_dir() call with btrfs_open_dir_fd()
removing any reference to the unused/useless dirstream variables.

At the same time this patch updates the add_seen_fsid() function removing
any reference to dir stream (again this is never used).

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/filesystem.c    | 4 ++--
 cmds/subvolume.c     | 8 +++-----
 common/device-scan.c | 6 ++----
 common/device-scan.h | 4 +---
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 9867403f..d37b52a3 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -307,7 +307,7 @@ static void print_one_uuid(struct btrfs_fs_devices *fs_devices,
 	u64 devs_found = 0;
 	u64 total;
 
-	if (add_seen_fsid(fs_devices->fsid, seen_fsid_hash, -1, NULL))
+	if (add_seen_fsid(fs_devices->fsid, seen_fsid_hash, -1))
 		return;
 
 	uuid_unparse(fs_devices->fsid, uuidbuf);
@@ -352,7 +352,7 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
 	struct btrfs_ioctl_dev_info_args *tmp_dev_info;
 	int ret;
 
-	ret = add_seen_fsid(fs_info->fsid, seen_fsid_hash, -1, NULL);
+	ret = add_seen_fsid(fs_info->fsid, seen_fsid_hash, -1);
 	if (ret == -EEXIST)
 		return 0;
 	else if (ret)
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index cca73379..65582f67 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -374,7 +374,6 @@ static int cmd_subvolume_delete(const struct cmd_struct *cmd, int argc, char **a
 	char	*dupdname = NULL;
 	char	*dupvname = NULL;
 	char	*path = NULL;
-	DIR	*dirstream = NULL;
 	int commit_mode = 0;
 	bool subvol_path_not_found = false;
 	u8 fsid[BTRFS_FSID_SIZE];
@@ -498,7 +497,7 @@ again:
 	if (subvolid > 0)
 		dname = dupvname;
 
-	fd = btrfs_open_dir(dname, &dirstream, 1);
+	fd = btrfs_open_dir_fd(dname);
 	if (fd < 0) {
 		ret = 1;
 		goto out;
@@ -592,7 +591,7 @@ again:
 			goto out;
 		}
 
-		if (add_seen_fsid(fsid, seen_fsid_hash, fd, dirstream) == 0) {
+		if (add_seen_fsid(fsid, seen_fsid_hash, fd) == 0) {
 			uuid_unparse(fsid, uuidbuf);
 			pr_verbose(LOG_INFO, "  new fs is found for '%s', fsid: %s\n",
 				   path, uuidbuf);
@@ -606,10 +605,9 @@ again:
 	}
 
 out:
-	close_file_or_dir(fd, dirstream);
+	close(fd);
 keep_fd:
 	fd = -1;
-	dirstream = NULL;
 	free(dupdname);
 	free(dupvname);
 	dupdname = NULL;
diff --git a/common/device-scan.c b/common/device-scan.c
index c1cd7266..c04c2388 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -313,8 +313,7 @@ int is_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[])
 	return 0;
 }
 
-int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[],
-		int fd, DIR *dirstream)
+int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[], int fd)
 {
 	u8 hash = fsid[0];
 	int slot = hash % SEEN_FSID_HASH_SIZE;
@@ -342,7 +341,6 @@ insert:
 	alloc->next = NULL;
 	memcpy(alloc->fsid, fsid, BTRFS_FSID_SIZE);
 	alloc->fd = fd;
-	alloc->dirstream = dirstream;
 
 	if (seen)
 		seen->next = alloc;
@@ -362,7 +360,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 		seen = seen_fsid_hash[slot];
 		while (seen) {
 			next = seen->next;
-			close_file_or_dir(seen->fd, seen->dirstream);
+			close(seen->fd);
 			free(seen);
 			seen = next;
 		}
diff --git a/common/device-scan.h b/common/device-scan.h
index 8a875832..90ec766d 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -41,7 +41,6 @@ struct btrfs_trans_handle;
 struct seen_fsid {
 	u8 fsid[BTRFS_FSID_SIZE];
 	struct seen_fsid *next;
-	DIR *dirstream;
 	int fd;
 };
 
@@ -56,8 +55,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 int btrfs_device_already_in_root(struct btrfs_root *root, int fd,
 				 int super_offset);
 int is_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[]);
-int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[],
-		int fd, DIR *dirstream);
+int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[], int fd);
 void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
 int test_uuid_unique(const char *uuid_str);
 
-- 
2.43.0


