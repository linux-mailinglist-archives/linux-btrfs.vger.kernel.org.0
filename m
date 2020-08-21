Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9AD24CFBA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 09:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHUHlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgHUHky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41CC06134F
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so614318pgh.6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXPPzuyYBv9yrhxztqxpjmIYf+lugfimCNZtMJJMfTo=;
        b=dJoPpfR0nYIY9JbTQcdiFIOkYm0RbveMUjuWboztRc4gCuQWglTcWJKAIl8RdJs6s4
         oY/+yc0DJbDqfAEZ+QOp9wUF13TSVNQGKwr7EPQquAM89m77Bp6ICqaHg6N3CseGdMOI
         LEde0T+rVM6i7wClpd7Mf6UX3OKvDmIzhDGn7Xi8nbTW/NAsiSgNnwD5Gy5kl6HDdXwB
         qY0Vo9MJ8gOcsv30swEsPXTZP0V0Akbhqoe6RoHMqAZ/5GGBIO694m9UepS5QM5CAons
         Vr0SSefxZkOisH9ixsBg1uVxklIlYrUQTsyKgJ22prybNUOtF0tCHWeuO1Ft+ymon3GF
         CLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXPPzuyYBv9yrhxztqxpjmIYf+lugfimCNZtMJJMfTo=;
        b=Uhty743wmy6MGRWn+Zwm5hIPjRKS0Ni2QrsjU6PHSGTN3iZB0s6jjOQSO/4eE6UBOf
         cZf/0dS0ZqPC4RLaLGezk0uDE6BWSEG5eXKkUDpOMjlRqitXnKapDtn9U4pWy0A67uRZ
         1QwIUDgbXXYxIQ/3SzOk1FuaMYaBdDTk5Cd8CdE9EYEweqBu/IBQR6fO7zYSEM5t46DH
         7rwZNhodUwvlgbnXDmf3bLQ0bCRskS3NqQhGK5+c3C/+5exuJXBL0VdZePwRUJDDbbWO
         wOw7gT9Z6eXYcb1FMJv5f/hPDWAkFktg7ZZ9/Lccyp9VdO7/ZJ3BBN4YOkuUY4+O5QDK
         046g==
X-Gm-Message-State: AOAM530xx+WcfCEe8jZBrd/8btsxg8WQNWNkvR7bZYcXoRh08QCj5UiT
        5QsVvvH0nBSH5XHRqyuqfkdfgWU0/D6t/w==
X-Google-Smtp-Source: ABdhPJyVjKhpRqfUYkX4N6avisVvxvU/6DAouvaPkL5rdfiPIfk/+hhAnUjpgHUy+jCoA1UkPFoYjg==
X-Received: by 2002:a63:4545:: with SMTP id u5mr1409777pgk.229.1597995653223;
        Fri, 21 Aug 2020 00:40:53 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:51 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] btrfs-progs: receive: process setflags ioctl commands
Date:   Fri, 21 Aug 2020 00:40:08 -0700
Message-Id: <694c8d01bc3542d9099f6b1dca144a5a1cf87b65.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

In send stream v2, send can emit a command for setting inode flags via
the setflags ioctl. Pass the flags attribute through to the ioctl call
in receive.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  6 ++++++
 cmds/receive.c       | 25 +++++++++++++++++++++++++
 common/send-stream.c |  7 +++++++
 common/send-stream.h |  1 +
 4 files changed, 39 insertions(+)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index acc0ba32..40f07ad4 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -337,6 +337,11 @@ static int print_fallocate(const char *path, int mode, u64 offset, u64 len,
 			  mode, offset, len);
 }
 
+static int print_setflags(const char *path, int flags, void *user)
+{
+	return PRINT_DUMP(user, path, "setflags", "flags=%d", flags);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -361,4 +366,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
 	.fallocate = print_fallocate,
+	.setflags = print_setflags,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 5c0930cb..50c843ed 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1381,6 +1381,30 @@ out:
 	return ret;
 }
 
+static int process_setflags(const char *path, int flags, void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("setflags: path invalid: %s", path);
+		goto out;
+	}
+	ret = open_inode_for_write(rctx, full_path, false);
+	if (ret < 0)
+		goto out;
+	ret = ioctl(rctx->write_fd, FS_IOC_SETFLAGS, &flags);
+	if (ret < 0) {
+		ret = -errno;
+		error("setflags: setflags ioctl on %s failed: %m", path);
+		goto out;
+	}
+out:
+	return ret;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1405,6 +1429,7 @@ static struct btrfs_send_ops send_ops = {
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
 	.fallocate = process_fallocate,
+	.setflags = process_setflags,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index d455cdfb..da0c0e5d 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -370,6 +370,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	int len;
 	int xattr_len;
 	int fallocate_mode;
+	int setflags_flags;
 
 	ret = read_cmd(sctx);
 	if (ret)
@@ -523,8 +524,14 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 		ret = sctx->ops->fallocate(path, fallocate_mode, offset, tmp,
 					   sctx->user);
 		break;
+	case BTRFS_SEND_C_SETFLAGS:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_SETFLAGS_FLAGS, &setflags_flags);
+		ret = sctx->ops->setflags(path, setflags_flags, sctx->user);
+		break;
 	}
 
+
 tlv_get_failed:
 out:
 	free(path);
diff --git a/common/send-stream.h b/common/send-stream.h
index a58739bb..5373bf69 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -72,6 +72,7 @@ struct btrfs_send_ops {
 			     u32 encryption, void *user);
 	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
 			 void *user);
+	int (*setflags)(const char *path, int flags, void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
-- 
2.28.0

