Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235E82B4EB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 18:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbgKPR5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 12:57:07 -0500
Received: from gateway20.websitewelcome.com ([192.185.62.46]:34112 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387746AbgKPR5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 12:57:07 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 2F364400D4CE9
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Nov 2020 11:30:18 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id eiNXkr8EDYLDneiNYkuHlP; Mon, 16 Nov 2020 11:33:24 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CvCF2EJByJxft3hiWPr9rn0jNMAENVSlLPjoW6c+JnE=; b=rUe3mojXWiFaKKx2jlowLVkx9R
        ARXuHL1mrmC4y9iu5L5F6wKXA1YDGtp+0ZmIKp62hM0ynO8XOx6fkWGBfbqGx5Atlu2/fCCsgn7Vh
        RxPlR9/WfzEUypfIiMhLcmzMk+D8PAq1D/1Ak7Atq+ZzrxY+GoXEly/h9dq2ULPDEu3j2HoeMc7NQ
        mqICZxEvnhBj4M/6rQWL+v45eFXU4HCRrj7TtQZ97GBo8EY6V+GYqd/3z2BqoU/La0DMcOzcz/dkZ
        sMZYooCw1S0IR3ylVKNMkpLNVChsNWKGP7E4DZxQ3zrk2DD+PBQaNYm+5DfqHKvviKJ4QaPtrXoaM
        xsLecA/Q==;
Received: from [191.249.68.105] (port=38938 helo=localhost.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1keiNX-000wCw-0F; Mon, 16 Nov 2020 14:33:23 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: [PATCH v2 2/3] btrfs-progs: inspect: Fix logical-resolve file path lookup
Date:   Mon, 16 Nov 2020 14:32:48 -0300
Message-Id: <20201116173249.11847-3-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116173249.11847-1-marcos@mpdesouza.com>
References: <20201116173249.11847-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.68.105
X-Source-L: No
X-Exim-ID: 1keiNX-000wCw-0F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.suse.de) [191.249.68.105]:38938
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
The subvolume '@' is never mounted, and accessed, but only it's child:

mount | grep btrfs
/dev/sda2 on / type btrfs (rw,relatime,ssd,space_cache,subvolid=267,subvol=/@/.snapshots/1/snapshot)
/dev/sda2 on /opt type btrfs (rw,relatime,ssd,space_cache,subvolid=262,subvol=/@/opt)
/dev/sda2 on /boot/grub2/i386-pc type btrfs (rw,relatime,ssd,space_cache,subvolid=265,subvol=/@/boot/grub2/i386-pc)

logical-resolve command calls btrfs_list_path_for_root, that returns the
subvolume full-path that corresponds to the tree id of the logical
address. As the name implies, the 'full-path' returns all subvolumes,
starting from '@'. Later on, btrfs_open_dir is calles using the path
returned, but it fails to resolve it since it contains the '@' and this
subvolume cannot be accessed.

The same problem can be triggered to any user that calls for
logical-resolve on a child subvolume that has the parent subvolume
not accessible.

Another problem in the current approach is that it believes that a
subvolume will be mounted in a directory with the same name e.g /@/boot
being mounted in /boot. When this is not true, the code also fails,
since it uses the subvolume name as the path accessible by the user.

[FIX]
Extent the find_mount_root function by allowing it to check for mnt_opts
member of mntent struct. Using this new approach we can change
logical-resolve command to search for subvolid=XXX,subvol=YYY. This is
the two problems stated above by not trusting the subvolume name being
the mountpoint name, and not following the subvolume tree blindly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/inspect.c | 30 ++++++++++++++++++++++--------
 common/utils.c | 13 +++++++++----
 common/utils.h |  5 ++++-
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 2530b904..0dc62d18 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -245,15 +245,29 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 				path_ptr[-1] = '\0';
 				path_fd = fd;
 			} else {
-				path_ptr[-1] = '/';
-				ret = snprintf(path_ptr, bytes_left, "%s",
-						name);
-				free(name);
-				if (ret >= bytes_left) {
-					error("path buffer too small: %d bytes",
-							bytes_left - ret);
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
+				if (ret < 0)
 					goto out;
-				}
+
+				strncpy(full_path, mounted, PATH_MAX);
+				free(mounted);
+
 				path_fd = btrfs_open_dir(full_path, &dirs, 1);
 				if (path_fd < 0) {
 					ret = -ENOENT;
diff --git a/common/utils.c b/common/utils.c
index 1c264455..7e6f406b 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1261,8 +1261,6 @@ int find_mount_root(const char *path, const char *data, u8 flag, char **mount_ro
 	char *cmp_field = NULL;
 	bool found;
 
-	BUG_ON(flag != BTRFS_FIND_ROOT_PATH);
-
 	fd = open(path, O_RDONLY | O_NOATIME);
 	if (fd < 0)
 		return -errno;
@@ -1273,11 +1271,18 @@ int find_mount_root(const char *path, const char *data, u8 flag, char **mount_ro
 		return -errno;
 
 	while ((ent = getmntent(mnttab))) {
-		cmp_field = ent->mnt_dir;
+		/* BTRFS_FIND_ROOT_PATH is the default behavior */
+		if (flag == BTRFS_FIND_ROOT_OPTS)
+			cmp_field = ent->mnt_opts;
+		else
+			cmp_field = ent->mnt_dir;
 
 		len = strlen(cmp_field);
 
-		found = strncmp(cmp_field, data, len) == 0;
+		if (flag == BTRFS_FIND_ROOT_OPTS)
+			found = strstr(cmp_field, data) != NULL;
+		else
+			found = strncmp(cmp_field, data, len) == 0;
 
 		if (found) {
 			/* match found and use the latest match */
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

