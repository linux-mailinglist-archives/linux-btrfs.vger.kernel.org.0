Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC217D085
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 00:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCGXHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Mar 2020 18:07:06 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.212]:23037 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgCGXHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Mar 2020 18:07:06 -0500
X-Greylist: delayed 1480 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Mar 2020 18:07:06 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 160922747C
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2020 16:42:26 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ai9KjpY03RP4zAi9KjCNzH; Sat, 07 Mar 2020 16:42:26 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SA+QQmc1pIEmN+Nq6MRtFjJBYMMue438C/sLfQOcQsI=; b=LouPhJly9PHiOGdxjZyjOQ1sZF
        U7ZQQl172eapx5O79dJIewONDOtCjvAKKXeGHttU8OLY3qL56CJj0lVZwnIp4SFHb1rnp+2YiAcod
        EBNSdV8x/T9oys+uNLyTTrmAg/LnJMs+1DHLUWLvEAUdRC5p2WLGoZgeaW+VjjtmG3i4Pa2d1v4Tx
        vKri5zJN6FsU3Ykf874Nxzuuhu5h13ouwLlUhyF3lZCANYhkg+TEiql8omBuZ5dMCvHVMlP56tDTb
        LhgnpScY0LNvG30iNO8E5l4mLby7hcQ/kx/ehRFCC4/A+6IYqxiQf67ywyWOwi+Xc/ofE+Xe2+UEm
        B+X85eRw==;
Received: from 189.26.190.248.dynamic.adsl.gvt.net.br ([189.26.190.248]:56604 helo=hephaestus.suse.cz)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jAi9J-002tnS-Ho; Sat, 07 Mar 2020 19:42:25 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/2] btrfs-progs: replace: New argument to resize the fs after replace
Date:   Sat,  7 Mar 2020 19:45:16 -0300
Message-Id: <20200307224516.16315-3-marcos@mpdesouza.com>
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
X-Exim-ID: 1jAi9J-002tnS-Ho
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.190.248.dynamic.adsl.gvt.net.br (hephaestus.suse.cz) [189.26.190.248]:56604
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 8
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

By using the -a flag on replace makes btrfs issue a resize ioctl after
the replace finishes. This argument is a shortcut for

btrfs replace start -f 3 /dev/sdf BTRFS/
btrfs fi resize 3:max BTRFS/

The -a stands for "automatically resize"

Fixes: #21

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/btrfs-replace.asciidoc |  4 +++-
 cmds/replace.c                       | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfs-replace.asciidoc b/Documentation/btrfs-replace.asciidoc
index b73bf1b3..e0b30066 100644
--- a/Documentation/btrfs-replace.asciidoc
+++ b/Documentation/btrfs-replace.asciidoc
@@ -18,7 +18,7 @@ SUBCOMMAND
 *cancel* <mount_point>::
 Cancel a running device replace operation.
 
-*start* [-Bfr] <srcdev>|<devid> <targetdev> <path>::
+*start* [-aBfr] <srcdev>|<devid> <targetdev> <path>::
 Replace device of a btrfs filesystem.
 +
 On a live filesystem, duplicate the data to the target device which
@@ -53,6 +53,8 @@ never allowed to be used as the <targetdev>.
 +
 -B::::
 no background replace.
++a::::
+automatically resizes the filesystem if the <targetdev> is bigger than <srcdev>.
 
 *status* [-1] <mount_point>::
 Print status and progress information of a running device replace operation.
diff --git a/cmds/replace.c b/cmds/replace.c
index 2321aa15..48f470cd 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -91,7 +91,7 @@ static int dev_replace_handle_sigint(int fd)
 }
 
 static const char *const cmd_replace_start_usage[] = {
-	"btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>",
+	"btrfs replace start [-aBfr] <srcdev>|<devid> <targetdev> <mount_point>",
 	"Replace device of a btrfs filesystem.",
 	"On a live filesystem, duplicate the data to the target device which",
 	"is currently stored on the source device. If the source device is not",
@@ -104,6 +104,8 @@ static const char *const cmd_replace_start_usage[] = {
 	"from the system, you have to use the <devid> parameter format.",
 	"The <targetdev> needs to be same size or larger than the <srcdev>.",
 	"",
+	"-a     automatically resize the filesystem if the <targetdev> is bigger",
+	"       than <srcdev>",
 	"-r     only read from <srcdev> if no other zero-defect mirror exists",
 	"       (enable this if your drive has lots of read errors, the access",
 	"       would be very slow)",
@@ -129,6 +131,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	char *path;
 	char *srcdev;
 	char *dstdev = NULL;
+	bool auto_resize = false;
 	int avoid_reading_from_srcdev = 0;
 	int force_using_targetdev = 0;
 	u64 dstdev_block_count;
@@ -138,8 +141,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	u64 dstdev_size;
 
 	optind = 0;
-	while ((c = getopt(argc, argv, "Brf")) != -1) {
+	while ((c = getopt(argc, argv, "aBrf")) != -1) {
 		switch (c) {
+		case 'a':
+			auto_resize = true;
+			break;
 		case 'B':
 			do_not_background = 1;
 			break;
@@ -309,6 +315,15 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 			goto leave_with_error;
 		}
 	}
+
+	if (ret == 0 && auto_resize && dstdev_size > srcdev_size) {
+		char amount[BTRFS_PATH_NAME_MAX + 1];
+		snprintf(amount, BTRFS_PATH_NAME_MAX, "%s:max", srcdev);
+
+		if (resize_filesystem(amount, path))
+			goto leave_with_error;
+	}
+
 	close_file_or_dir(fdmnt, dirstream);
 	return 0;
 
-- 
2.25.0

