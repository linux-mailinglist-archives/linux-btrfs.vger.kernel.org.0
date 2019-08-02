Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C27FE5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbfHBQMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 12:12:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41633 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfHBQMC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 12:12:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so74306933qtj.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjEH6VSX5ljt1iUXK9XBsRVEM9cTuTTtfBz6dXPXc1s=;
        b=lOeMbNYxAPrRuObd5RdpMQzfQYCr8KAG3SAYIvUoCq9Q9SBvL97SQdfLTaqUu50TZr
         92TX6SQlnmxwp2Tub4cX3JGgYL3inq8TqK5mnauJ/VpuRPnPj5XPUiuTUROVaZDZIfG6
         iwaU4Rsx4YhtXua/RWuMrqIOdShfV+r5nXRrVvkz4pJOZAaeEY8eutdWlNwcB9E/Ibh/
         WlP+hFCqiNb6VuHowU849BZAvQHkJafK5R8znICVfUjvdPBvWUz3TZhv9YQzGKfXQPrL
         GhlF7tTOHcv4Iqf6pZQq93lNO2qX/NbJrF5ovFMFDUY415Xk+DoODWytI0X/o5ET8sKc
         gc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjEH6VSX5ljt1iUXK9XBsRVEM9cTuTTtfBz6dXPXc1s=;
        b=om1pAcobryXnLJQjHjFmBwUZuXjxFEvGby/IgVjNWe3+PIPNQ573TNIf1VP9S/nvyj
         x1NEk0W8dmHg22Op1JsAW/JcVUmF7M0vQg/mph9MV038o2s142D4GpN+/SxPgZPJFZJM
         n34Q+kLYqhcFxuCe5kLo3mGj5aPFEp+pPz9nZ9Kc3pcC/wNidC8tGK2FYThlYo1s2fG/
         eiMAelMEeK5e8SiZi8e5BgyKk48z2YXV2Lh9KPzVFyAbIQgpVhN0vakoVKxxUM2l7upI
         3Fjsf6pPVHp864SBKnFERg0i1vrFnESBoXiEn7x21cys5HEz2wqb6PivLTmnVSEHzaba
         wOiA==
X-Gm-Message-State: APjAAAVPVwwiqmpA7RXPq38Q//iOWhgnoFTHzonZvJnLqPc/ajs32VQs
        oW9W7dLk1WM6j/92Z1Z8fqlTukMaqiQ=
X-Google-Smtp-Source: APXvYqwj8Kttmut9AymMJXdxoQC8hlchcYAq+JJq1fG22iRu5eacLvjHxEZ5sF1mz44nSKJZ5pWa5w==
X-Received: by 2002:a0c:d4d0:: with SMTP id y16mr95322081qvh.191.1564762320939;
        Fri, 02 Aug 2019 09:12:00 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b13sm44859776qtk.55.2019.08.02.09.11.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 09:12:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: add a alloc-chunk command
Date:   Fri,  2 Aug 2019 12:11:59 -0400
Message-Id: <20190802161159.18473-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is so we can force chunk allocation to test various parts of the
fs.  I used this to test my btrfsck patch for checking for empty block
groups, and a weird block group removal issue.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/filesystem.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 ioctl.h           |  1 +
 2 files changed, 49 insertions(+)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089a..93d51195 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1174,6 +1174,53 @@ static int cmd_filesystem_label(const struct cmd_struct *cmd,
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_label, "label");
 
+static const char * const cmd_filesystem_alloc_chunk_usage[] = {
+	"btrfs filesystem alloc-chunk [data|metadata|system] <path>",
+	"Force a chunk allocation of the specified type on the given filesystem.",
+	NULL
+};
+
+static int cmd_filesystem_alloc_chunk(const struct cmd_struct *cmd,
+				      int argc, char **argv)
+{
+	char *path;
+	DIR *dirstream = NULL;
+	int fd, ret, e;
+	u64 flags = 0;
+
+	clean_args_no_options(cmd, argc, argv);
+
+	if (check_argc_exact(argc - optind, 2))
+		return 1;
+
+	if (!strncmp(argv[optind], "data", strlen("data")))
+		flags = BTRFS_BLOCK_GROUP_DATA;
+	else if (!strncmp(argv[optind], "system", strlen("system")))
+		flags = BTRFS_BLOCK_GROUP_SYSTEM;
+	else if (!strncmp(argv[optind], "metadata", strlen("metadata")))
+		flags = BTRFS_BLOCK_GROUP_METADATA;
+
+	if (flags == 0) {
+		error("Must specify either data, system, or metadata");
+		return 1;
+	}
+
+	path = argv[optind + 1];
+	fd = btrfs_open_dir(path, &dirstream, 1);
+	if (fd < 0)
+		return 1;
+
+	ret = ioctl(fd, BTRFS_IOC_ALLOC_CHUNK, &flags);
+	e = errno;
+	close_file_or_dir(fd, dirstream);
+	if (ret) {
+		error("Failed to alloc chunk: %d", e);
+		return 1;
+	}
+	return 0;
+}
+static DEFINE_SIMPLE_COMMAND(filesystem_alloc_chunk, "alloc-chunk");
+
 static const char * const cmd_filesystem_balance_usage[] = {
 	"btrfs filesystem balance [args...] (alias of \"btrfs balance\")",
 	"Please see \"btrfs balance --help\" for more information.",
@@ -1209,6 +1256,7 @@ static const struct cmd_group filesystem_cmd_group = {
 		&cmd_struct_filesystem_resize,
 		&cmd_struct_filesystem_label,
 		&cmd_struct_filesystem_usage,
+		&cmd_struct_filesystem_alloc_chunk,
 		NULL
 	}
 };
diff --git a/ioctl.h b/ioctl.h
index 66ee599f..4a5c2891 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -929,6 +929,7 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_ALLOC_CHUNK _IOR(BTRFS_IOCTL_MAGIC, 63, __u64)
 #ifdef __cplusplus
 }
 #endif
-- 
2.21.0

