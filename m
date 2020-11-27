Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6021A2C6E91
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Nov 2020 04:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgK0T5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 14:57:07 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.12]:14333 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730876AbgK0Ty7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 14:54:59 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 63E3A2077A
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 13:31:29 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id ijSrkXXAdnPrxijSrkybJX; Fri, 27 Nov 2020 13:31:29 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QQlnK8904Y5tSxI5gqzCuvKl4btdWYmKVGn1g/t6fVU=; b=S54d+zigOihNXE+nngfcrTaRBV
        pyYSY5jzX3LYpQCEZsOsNCw5b5KgXg3kSWrkEL0E7+1jlPC2BDgoI5rSfg4C4x/BjfHnHwEyyiFKS
        +Tyz5plisfAI8+TVP/Q0MgFfAl35dcCtC2tEErjWXGVJ35H4fNu+iYaMymM8Z4x8rTTqNJkRWACIh
        7KiTVlUeedcacummskLP3LSZZ/GdqFBFRh7khpAnGuRhmPn2r6HcrZCiQ3UdTPGamHDd5Hytly+nU
        WDoheYj0ebKIw32Hwt1M5JJUTW9juiJ8grtQWd6XJVvr8OSNBBYPmAzXFycplIwpLnu9LZXqSraeY
        G0rVRbwQ==;
Received: from 200.146.52.186.dynamic.dialup.gvt.net.br ([200.146.52.186]:60574 helo=localhost.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kijSr-003Dm3-3Z; Fri, 27 Nov 2020 16:31:29 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: [PATCH v4 2/3] btrfs-progs: inspect: Fix logical-resolve file path lookup
Date:   Fri, 27 Nov 2020 16:30:34 -0300
Message-Id: <20201127193035.19171-3-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201127193035.19171-1-marcos@mpdesouza.com>
References: <20201127193035.19171-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.52.186
X-Source-L: No
X-Exim-ID: 1kijSr-003Dm3-3Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.52.186.dynamic.dialup.gvt.net.br (localhost.suse.de) [200.146.52.186]:60574
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 12
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

[BUG]
logical-resolve is currently broken on systems that have a child
subvolume being mounted without access to the parent subvolume.
This is the default for SLE/openSUSE installations. openSUSE has the
subvolume '@' as the parent of all other subvolumes like /boot, /home.
The subvolume '@' is never mounted and accessed, but only it's childs:

mount | grep btrfs
/dev/sda2 on / type btrfs (rw,relatime,ssd,space_cache,subvolid=267,subvol=/@/.snapshots/1/snapshot)
/dev/sda2 on /opt type btrfs (rw,relatime,ssd,space_cache,subvolid=262,subvol=/@/opt)
/dev/sda2 on /boot/grub2/i386-pc type btrfs (rw,relatime,ssd,space_cache,subvolid=265,subvol=/@/boot/grub2/i386-pc)

logical-resolve command calls btrfs_list_path_for_root, that returns the
subvolume full-path that corresponds to the tree id of the logical
address. As the name implies, the 'full-path' returns the subvolume full
path, starting from '@'. Later on, btrfs_open_dir is called using the path
returned, but it fails to resolve it since it contains the '@' and this
subvolume cannot be accessed.

The same problem can be triggered to any user that calls for
logical-resolve on a child subvolume that has the parent subvolume
not accessible.

Another problem in the current approach is that it believes that a
subvolume will be mounted in a directory with the same name e.g /@/boot
being mounted in /boot. When this is not true, the code also fails,
since it uses the subvolume name as the path.

[FIX]
Extent the find_mount_root function by allowing it to check for mnt_opts
member of mntent struct. Using this new approach we can change
logical-resolve command to search for subvolid=XXX,subvol=YYY returning
the correct path accessible to the user. Using this approach we can solve
the problems stated above by not trusting the subvolume name being the
mountpoint, and not executing the lookup based only in the subvolume
tree.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/inspect.c | 44 ++++++++++++++++++++++++++++++++++----------
 common/utils.c | 29 +++++++++++++++++++++++------
 common/utils.h |  5 ++++-
 3 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 2530b904..cfa2f708 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -236,6 +236,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		DIR *dirs = NULL;
 
 		if (getpath) {
+			char mount_path[PATH_MAX];
 			name = btrfs_list_path_for_root(fd, root);
 			if (IS_ERR(name)) {
 				ret = PTR_ERR(name);
@@ -244,23 +245,46 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 			if (!name) {
 				path_ptr[-1] = '\0';
 				path_fd = fd;
+
+				strncpy(mount_path, full_path, PATH_MAX);
 			} else {
-				path_ptr[-1] = '/';
-				ret = snprintf(path_ptr, bytes_left, "%s",
-						name);
-				free(name);
-				if (ret >= bytes_left) {
-					error("path buffer too small: %d bytes",
-							bytes_left - ret);
-					goto out;
+				char *mounted = NULL;
+				char volid_str[PATH_MAX];
+
+				/*
+				 * btrfs_list_path_for_root returns the full
+				 * path to the subvolume pointed by root, but the
+				 * subvolume can be mounted in a directory name
+				 * different from the subvolume name. In this
+				 * case we need to find the correct mountpoint
+				 * using same subvol path and subvol id found
+				 * before.
+				 */
+				snprintf(volid_str, PATH_MAX, "subvolid=%llu,subvol=/%s",
+						root, name);
+
+				ret = find_mount_root(full_path, volid_str,
+						BTRFS_FIND_ROOT_OPTS, &mounted);
+
+				if (ret == -ENOENT) {
+					printf("inode %llu subvol %s could not be accessed: not mounted\n",
+							inum, name);
+					continue;
 				}
-				path_fd = btrfs_open_dir(full_path, &dirs, 1);
+
+				if (ret < 0)
+					goto out;
+
+				strncpy(mount_path, mounted, PATH_MAX);
+				free(mounted);
+
+				path_fd = btrfs_open_dir(mount_path, &dirs, 1);
 				if (path_fd < 0) {
 					ret = -ENOENT;
 					goto out;
 				}
 			}
-			ret = __ino_to_path_fd(inum, path_fd, full_path);
+			ret = __ino_to_path_fd(inum, path_fd, mount_path);
 			if (path_fd != fd)
 				close_file_or_dir(path_fd, dirs);
 		} else {
diff --git a/common/utils.c b/common/utils.c
index 1c264455..1562ac52 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1259,9 +1259,6 @@ int find_mount_root(const char *path, const char *data, u8 flag, char **mount_ro
 	int longest_matchlen = 0;
 	char *longest_match = NULL;
 	char *cmp_field = NULL;
-	bool found;
-
-	BUG_ON(flag != BTRFS_FIND_ROOT_PATH);
 
 	fd = open(path, O_RDONLY | O_NOATIME);
 	if (fd < 0)
@@ -1273,12 +1270,32 @@ int find_mount_root(const char *path, const char *data, u8 flag, char **mount_ro
 		return -errno;
 
 	while ((ent = getmntent(mnttab))) {
-		cmp_field = ent->mnt_dir;
+		bool found = false;
 
-		len = strlen(cmp_field);
+		/* BTRFS_FIND_ROOT_PATH is the default behavior */
+		if (flag == BTRFS_FIND_ROOT_OPTS)
+			cmp_field = ent->mnt_opts;
+		else
+			cmp_field = ent->mnt_dir;
 
-		found = strncmp(cmp_field, data, len) == 0;
+		len = strlen(cmp_field);
 
+		if (flag == BTRFS_FIND_ROOT_OPTS) {
+			size_t dlen = strlen(data);
+			char *tmp_str = strstr(cmp_field, data);
+			/*
+			 * Make sure that we are dealing with the wanted string,
+			 * since strstr returns the start of the string found.
+			 * Compare the end string position from data with the
+			 * mount point found, and make sure that we have an
+			 * option separator or string end.
+			 */
+			if (tmp_str)
+				found = tmp_str[dlen] == ',' ||
+					tmp_str[dlen] == 0;
+		} else {
+			found = strncmp(cmp_field, data, len) == 0;
+		}
 		if (found) {
 			/* match found and use the latest match */
 			if (longest_matchlen <= len) {
diff --git a/common/utils.h b/common/utils.h
index 449e1d3e..b5d256c6 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -54,7 +54,10 @@
 
 enum btrfs_find_root_flags {
 	/* check mnt_dir of mntent */
-	BTRFS_FIND_ROOT_PATH = 0
+	BTRFS_FIND_ROOT_PATH = 0,
+
+	/* check mnt_opts of mntent */
+	BTRFS_FIND_ROOT_OPTS
 };
 
 void units_set_mode(unsigned *units, unsigned mode);
-- 
2.26.2

