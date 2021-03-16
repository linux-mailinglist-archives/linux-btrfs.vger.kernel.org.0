Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC833DE07
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCPTq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbhCPTpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E042C0613E7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e26so9537277pfd.9
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HADdv5K3OryTpYiXcmOT6Xw/vTCCME1y1dLqCdUeIrg=;
        b=jgk/SXUsODhQThpK+1SKnVlwNAEbHP7KKrasi5IbeIFWHWYuA2XtPXazw2aDNa4P4v
         PxjAjugwxcGxy5PrikedXAZ0w4OKK9vnqEBIJRTUqlozVoqXV0llfjkorDSjgQqtYcA+
         kVwZ2jNdZLdg5KBNZ27yVsgTUFe166MsKMj49/FMfnuUJ2zYEKPEdHM85d6jMC76kZlC
         bhlGgdMEeL8dEWlLqz7YC4Yp8cw4LciQEEz6ZSMkVI36iuJhIskPecv0BzowtcabDP78
         ImeAega99HfNHTJlc7pILL+BdTmrJo7mnhkz3JE8jVsGv1DKcWkF3vFwRlZ5Q05YNWL7
         AoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HADdv5K3OryTpYiXcmOT6Xw/vTCCME1y1dLqCdUeIrg=;
        b=dais5Vw7H7mHOOH+pp3Ts2V02INqMGsY3l86TRmKAQ/dlNjdY+V3IyPKhOkAQGnBca
         ZVeQVWE+eKuewBURsS1bDkKgkJhO7qisXQJ1gqDpinWJHcBiw5+q/dQPxz+v8X+M/Dni
         D1pn1JqCU+hFyvwcDPL2WrH5oJjZ13i59FaKk6LW3N2woaC/n1SN6Es47uUZlra5ci85
         fJhU47MtaKbGe2/VR1Rii+kIRbsHDiFNJGWvj91KSgesad5CH93w8CfXnjCi/NS0y4Pb
         dFSWz7YzYAl9AmXUoCLUntT71zJ4g5BUnNnp+Kqz3hCkcZe49zC6TZBvb0voO2SHfnNE
         4hbg==
X-Gm-Message-State: AOAM531/DyPKXhn4PSAegu4MHkdVVgMq7NLcHyangvhk3hzbC2msqAU8
        I7dy0S+MC4wq6UK8uApQgD5JTPHQsTvAQw==
X-Google-Smtp-Source: ABdhPJz1GhM8NXoddkaM4aO9UPIabTNLTWS3SXQr2PvCy5lkyPyLbhGdazh5ier/5zsAI3D6s/NcBw==
X-Received: by 2002:a62:7b83:0:b029:1f1:5ef3:b4d9 with SMTP id w125-20020a627b830000b02901f15ef3b4d9mr1091143pfc.65.1615923888207;
        Tue, 16 Mar 2021 12:44:48 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:47 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 09/11] btrfs-progs: receive: process setflags ioctl commands
Date:   Tue, 16 Mar 2021 12:44:03 -0700
Message-Id: <11124eac89be601d9165736cf13beaf68ab7140f.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 cmds/receive.c       | 24 ++++++++++++++++++++++++
 common/send-stream.c |  7 +++++++
 common/send-stream.h |  1 +
 4 files changed, 38 insertions(+)

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
index 9103dabb..3fc83bd1 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1336,6 +1336,29 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
 	return 0;
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
+		return ret;
+	}
+	ret = open_inode_for_write(rctx, full_path, false);
+	if (ret < 0)
+		return ret;
+	ret = ioctl(rctx->write_fd, FS_IOC_SETFLAGS, &flags);
+	if (ret < 0) {
+		ret = -errno;
+		error("setflags: setflags ioctl on %s failed: %m", path);
+		return ret;
+	}
+	return 0;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1360,6 +1383,7 @@ static struct btrfs_send_ops send_ops = {
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
 	.fallocate = process_fallocate,
+	.setflags = process_setflags,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index bc41396e..b9d35a34 100644
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
2.30.2

