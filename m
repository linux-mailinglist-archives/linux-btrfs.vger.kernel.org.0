Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F842DB9B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 04:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgLPDnf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 22:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPDnf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 22:43:35 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5564C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 19:42:54 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id m6so6020918pfm.6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 19:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP3zh7QwcCzehAB5EkMfo7FC+j39J1/uKdrKzR8sD2Y=;
        b=r58zIwAE+AkZzRjUEicHnVbbvRb81aLD/L5XjdeqS4FA9rO4vK+SikxlRZphc6iqQa
         LQ8zf/cn6lblo1ebIIa3F2YW1xjMyXDJnDGQS0dGUiTgSuaNLBOCDFFWeesGFJF4owh6
         9m1PwurFBfpiF/Fd0QkX44R1AlTbcZHmc1uM4aYwJ0/s7eX/Sky++5sDCJZy9/09+4Dv
         qYrcHUa4EE4yv1oKWG3XzD4ILAPpjxJyi7pjQgQ8OmnEqE3pXi/6synks0q1ke7issNF
         JONNE/qw/2CEIBJ869dbB2aHzvcwfT2VQtOKV+WrkpfHhgjA511oGhkxWrksgpHv4Tsr
         btIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP3zh7QwcCzehAB5EkMfo7FC+j39J1/uKdrKzR8sD2Y=;
        b=rKg1y1S5rjv8SyYs2ZD/fGRJWeE+DYR262JBjNfWhVJK/Eyy/GWePppLAr/nKMJHL5
         vL2hGwpiwbktkTQzh/w78lp7qobZ76grKFTx+6s639LfeW9FUAMIeQSkWsOtcYJ8dAhS
         IL6JlaCm0QvegFGW1Mzo3oEzdFjea6Yy1stOpcnB9wUs1oi2GWSDLsUaL2fjnVWmN8lr
         DQcwy8MixcLYWWKmArHwY08ICXTPaaC5qfh4xVB5Ci2SjLifVIWudMRr0bUMuaf5zb1H
         qkVkBlCU8cRad4BDz1/5Ue85jNURPZJmGX+tn9q5pB4VdWdJWJDvMgeK+dHFapY/G9YN
         DCIw==
X-Gm-Message-State: AOAM533ZNr88j+l71NUV/eHH5gHcwx7x/3SUa1IfceNvkyG4GBJMQYww
        Dbv1ZZ5mIf1cKZvPTTKoLPrZ2uoEIBLXcg==
X-Google-Smtp-Source: ABdhPJyS8jqt2zjcjxd91K5+HjKLukk6UlooLTKiFxhen94LwhIrwHg0rjXFdMuJ1qJffa2ZaVT1nQ==
X-Received: by 2002:a62:8386:0:b029:19e:c636:3c7d with SMTP id h128-20020a6283860000b029019ec6363c7dmr21313182pfe.24.1608090174134;
        Tue, 15 Dec 2020 19:42:54 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id z6sm485090pfj.22.2020.12.15.19.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 19:42:53 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: filesystem-resize: make output more readable
Date:   Wed, 16 Dec 2020 03:42:40 +0000
Message-Id: <20201216034240.2029-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch make output of filesystem-resize command more readable and
give detail information for users. This patch provides more information
about filesystem like below.

Before:
Resize '/mnt' of '1:-1G'

After:
Resize device id 1 (/dev/vdb) from 4.00GiB to 3.00GiB

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index fac612b2..53e775b7 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1084,6 +1084,14 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	int ret;
 	struct stat st;
 	bool enqueue = false;
+	struct btrfs_ioctl_fs_info_args fi_args;
+	struct btrfs_ioctl_dev_info_args *di_args = NULL;
+	char newsize[256];
+	char sign;
+	u64 inc_bytes;
+	u64 res_bytes;
+	int i, devid, dev_idx;
+	const char *res_str;
 
 	optind = 0;
 	while (1) {
@@ -1142,7 +1150,58 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	printf("Resize '%s' of '%s'\n", path, amount);
+	ret = get_fs_info(path, &fi_args, &di_args);
+	if (ret)
+		error("unable to retrieve fs info");
+
+	if (!fi_args.num_devices)
+		error("num_devices = 0");
+
+	ret = sscanf(amount, "%d:%255s", &devid, newsize);
+
+	if (ret != 2)
+		error("invalid format");
+
+	dev_idx = -1;
+	for(i = 0; i < fi_args.num_devices; i++) {
+		if (di_args[i].devid == devid) {
+			dev_idx = i;
+			break;
+		}
+	}
+
+	if (dev_idx < 0)
+		error("cannot find devid : %d", devid);
+
+	if (!strcmp(newsize, "max")) {
+		res_str = "max";
+	} else {
+		if (strlen(newsize) < 3)
+			error("invalid format");
+
+		sign = newsize[0];
+		if (sign != '-' && sign != '+')
+			error("invalid format");
+
+		inc_bytes = parse_size(&newsize[1]);
+
+		res_bytes = 0;
+		if (sign == '+')
+			res_bytes = di_args[0].total_bytes + inc_bytes;
+		else if (sign == '-')
+			res_bytes = di_args[0].total_bytes - inc_bytes;
+		else
+			error("invalid format");
+
+		res_str = pretty_size_mode(res_bytes, UNITS_DEFAULT);
+	}
+
+	printf("Resize device id %d (%s) from %s to %s\n", devid, di_args[dev_idx].path,
+		   pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
+		   res_str);
+
+	free(di_args);
+
 	memset(&args, 0, sizeof(args));
 	strncpy_null(args.name, amount);
 	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
-- 
2.25.1

