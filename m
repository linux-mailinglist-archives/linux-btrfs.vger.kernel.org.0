Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA11AB536
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 03:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404651AbgDPBEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 21:04:34 -0400
Received: from gateway30.websitewelcome.com ([192.185.180.41]:22521 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405821AbgDPBEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 21:04:32 -0400
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 21:04:31 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 93D2DBA712
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 19:44:22 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id OsdijnV8MVQh0OsdijxSz5; Wed, 15 Apr 2020 19:44:22 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kp9uLZU//RbzdWsCumY2HiyuXj9Q52SB5U6JH6t6D0w=; b=kLLnY7jwUWx4pJLQpa0qdFK/XH
        aKijh4fQVLqXYNKpd1eCAIQPsbhF9nHJgRyqF/xUU1QxiVj733cTTYAqJmWk2ZtGPgo6/SJH8qwSP
        TAbNg4KQGdZiq0CTxgH1vAEW0fZJkQrSvuyenyBNFvNniSFj0S+IOfkuKzl5oBeeDYVBmcZcwL8sP
        qYbR+9uzFp+Q8rtUg/lFhzYkgJLEODf6Gent54MlPqKNqSmYRd39ReJNqSq1PnxFKwRZJywhHNVAa
        JtEIbSAjMpaKm48DgChCnRDIJeH39Wf+F6pceBbHhClbKf6J10zxOAFF6BTsM2m/iISruRvVMoWoi
        oLG4LZKw==;
Received: from [177.132.129.218] (port=35128 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jOsdi-0046UY-01; Wed, 15 Apr 2020 21:44:22 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv3 1/3] btrfs-progs: Move resize into functionaly into utils.c
Date:   Wed, 15 Apr 2020 21:46:40 -0300
Message-Id: <20200416004642.9941-2-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416004642.9941-1-marcos@mpdesouza.com>
References: <20200416004642.9941-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 177.132.129.218
X-Source-L: No
X-Exim-ID: 1jOsdi-0046UY-01
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [177.132.129.218]:35128
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 7
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
 common/utils.h    |  2 ++
 3 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index c4bb13dd..cb7c3806 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1075,11 +1075,7 @@ static const char * const cmd_filesystem_resize_usage[] = {
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
 
@@ -1089,57 +1085,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
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
index 2517bb34..99d638cc 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -461,6 +461,66 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mod
 	return snprintf(str, str_size, "%.2f%s", fraction, suffix[num_divs]);
 }
 
+int resize_filesystem(const char *amount, const char *path)
+{
+	struct btrfs_ioctl_vol_args args;
+	int fd, res, len, e;
+	DIR *dirstream = NULL;
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
index 79c168c5..ba873c02 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -147,4 +147,6 @@ static inline int btrfs_test_for_mixed_profiles_by_fd(int fd)
 int btrfs_check_for_mixed_profiles_by_path(const char *path);
 int btrfs_check_for_mixed_profiles_by_fd(int fd);
 
+int resize_filesystem(const char *amount, const char *path);
+
 #endif
-- 
2.25.1

