Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85A217D084
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 00:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCGXD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Mar 2020 18:03:28 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.113]:14856 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgCGXD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Mar 2020 18:03:28 -0500
X-Greylist: delayed 1262 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Mar 2020 18:03:27 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id BB607400C7879
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2020 16:42:24 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ai9IjqHF8vBMdAi9Ijk8bX; Sat, 07 Mar 2020 16:42:24 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lYOtt7KGHO960OWZ5UfHWWk3prAlToez2yvjevkz3I0=; b=EBwMjVB4WpwqIQidA0/FI5Ez55
        EJdcOMxyViRbUESnVLNUKIIMovI01Eb3mI8urdVM0RE87vAd+vYjX/mmrSxTmzKLRMMPRwh3VSJN9
        QJemSq3ZnExXDv2Q7uA7I13RoK+bb+WVZEKiMd2TZcqxOD0sSQ6R+3oZrYDlkQeuwueX8KPCwcnsb
        UVLXP3ibkVitEHdpFu4DJAOzK9LFlGuaONh/ZYdaom3Md/ynbiDi5urJEjY03ir8LnwWMd24XHHAJ
        bABr2dQ0tauxZyyuLyY4O7E50jZ3x1EwOL/ZQ/Qn65V1nJgv2ll59A0e266h2FEDwbdWmgKJHLbVl
        oSDnpDew==;
Received: from 189.26.190.248.dynamic.adsl.gvt.net.br ([189.26.190.248]:56604 helo=hephaestus.suse.cz)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jAi9I-002tnS-6w; Sat, 07 Mar 2020 19:42:24 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 1/2] btrfs-progs: Move resize into functionaly into utils.c
Date:   Sat,  7 Mar 2020 19:45:15 -0300
Message-Id: <20200307224516.16315-2-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200307224516.16315-1-marcos@mpdesouza.com>
References: <20200307224516.16315-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.190.248
X-Source-L: No
X-Exim-ID: 1jAi9I-002tnS-6w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.190.248.dynamic.adsl.gvt.net.br (hephaestus.suse.cz) [189.26.190.248]:56604
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 5
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This function will be used in the next patch to auto resize the
filesystem when a bigger disk is added.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/filesystem.c | 58 ++-------------------------------------------
 common/utils.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 common/utils.h    |  1 +
 3 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089a..9d31f236 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1074,11 +1074,7 @@ static const char * const cmd_filesystem_resize_usage[] = {
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 				 int argc, char **argv)
 {
-	struct btrfs_ioctl_vol_args	args;
-	int	fd, res, len, e;
-	char	*amount, *path;
-	DIR	*dirstream = NULL;
-	struct stat st;
+	char *amount, *path;
 
 	clean_args_no_options_relaxed(cmd, argc, argv);
 
@@ -1088,57 +1084,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	amount = argv[optind];
 	path = argv[optind + 1];
 
-	len = strlen(amount);
-	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
-		error("resize value too long (%s)", amount);
-		return 1;
-	}
-
-	res = stat(path, &st);
-	if (res < 0) {
-		error("resize: cannot stat %s: %m", path);
-		return 1;
-	}
-	if (!S_ISDIR(st.st_mode)) {
-		error("resize works on mounted filesystems and accepts only\n"
-			"directories as argument. Passing file containing a btrfs image\n"
-			"would resize the underlying filesystem instead of the image.\n");
-		return 1;
-	}
-
-	fd = btrfs_open_dir(path, &dirstream, 1);
-	if (fd < 0)
-		return 1;
-
-	printf("Resize '%s' of '%s'\n", path, amount);
-	memset(&args, 0, sizeof(args));
-	strncpy_null(args.name, amount);
-	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
-	e = errno;
-	close_file_or_dir(fd, dirstream);
-	if( res < 0 ){
-		switch (e) {
-		case EFBIG:
-			error("unable to resize '%s': no enough free space",
-				path);
-			break;
-		default:
-			error("unable to resize '%s': %m", path);
-			break;
-		}
-		return 1;
-	} else if (res > 0) {
-		const char *err_str = btrfs_err_str(res);
-
-		if (err_str) {
-			error("resizing of '%s' failed: %s", path, err_str);
-		} else {
-			error("resizing of '%s' failed: unknown error %d",
-				path, res);
-		}
-		return 1;
-	}
-	return 0;
+	return resize_filesystem(amount, path);
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
 
diff --git a/common/utils.c b/common/utils.c
index 4ce36836..dddf0a6f 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -461,6 +461,66 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mod
 	return snprintf(str, str_size, "%.2f%s", fraction, suffix[num_divs]);
 }
 
+int resize_filesystem(const char *amount, const char *path)
+{
+	struct btrfs_ioctl_vol_args	args;
+	int	fd, res, len, e;
+	DIR	*dirstream = NULL;
+	struct stat st;
+
+	len = strlen(amount);
+	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
+		error("resize value too long (%s)", amount);
+		return 1;
+	}
+
+	res = stat(path, &st);
+	if (res < 0) {
+		error("resize: cannot stat %s: %m", path);
+		return 1;
+	}
+	if (!S_ISDIR(st.st_mode)) {
+		error("resize works on mounted filesystems and accepts only\n"
+			"directories as argument. Passing file containing a btrfs image\n"
+			"would resize the underlying filesystem instead of the image.\n");
+		return 1;
+	}
+
+	fd = btrfs_open_dir(path, &dirstream, 1);
+	if (fd < 0)
+		return 1;
+
+	printf("Resize '%s' of '%s'\n", path, amount);
+	memset(&args, 0, sizeof(args));
+	strncpy_null(args.name, amount);
+	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
+	e = errno;
+	close_file_or_dir(fd, dirstream);
+	if( res < 0 ){
+		switch (e) {
+		case EFBIG:
+			error("unable to resize '%s': no enough free space",
+				path);
+			break;
+		default:
+			error("unable to resize '%s': %m", path);
+			break;
+		}
+		return 1;
+	} else if (res > 0) {
+		const char *err_str = btrfs_err_str(res);
+
+		if (err_str) {
+			error("resizing of '%s' failed: %s", path, err_str);
+		} else {
+			error("resizing of '%s' failed: unknown error %d",
+				path, res);
+		}
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Checks to make sure that the label matches our requirements.
  * Returns:
diff --git a/common/utils.h b/common/utils.h
index 5c1afda9..8609d3c9 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -62,6 +62,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 		struct btrfs_fs_devices **fs_devices_mnt, unsigned sbflags);
 
 int pretty_size_snprintf(u64 size, char *str, size_t str_bytes, unsigned unit_mode);
+int resize_filesystem(const char *amount, const char *path);
 #define pretty_size(size) 	pretty_size_mode(size, UNITS_DEFAULT)
 const char *pretty_size_mode(u64 size, unsigned mode);
 
-- 
2.25.0

