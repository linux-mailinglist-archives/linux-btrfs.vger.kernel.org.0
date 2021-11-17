Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD2454E7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbhKQUXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbhKQUXY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:24 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63FC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:25 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j17so3901202qtx.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAOn3AEyd6fPltmzp9raPazhE1nDGCuK1Tu0Uhde4Fk=;
        b=QD9d0VUhmbldwrUrK2TUTPRQv6n1QIV517IM6qB1p2DSj1c8imkMC+PeKMXyt+qokO
         aUKA3JPpG1CUbx1lg00qmij3tUsob5KUEtAEgvUwkWmlFv/IYscjnjGvqA8LmuRhhISG
         oCkgzFjmVLybEjFZveEvLSbF+RVyPQrAT+xfynSvhQR9qKN5bxKWuh+rscl407plWvmx
         Tp500z4iRMg55UQiwvSZpot8o8lpH/4gMmCbK4/VnYIqgrbICpsmSAUMVXV1+iFdwCu7
         35ZgsaRJGsuGbDFhX5p40nghWoAUOmKZcZOas7pD6MVuv0eIjQkmzMA6wrZPW/TQlm6b
         OrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAOn3AEyd6fPltmzp9raPazhE1nDGCuK1Tu0Uhde4Fk=;
        b=6iwpsMriZE6oCJ+liqgz59p3PavlkIAtRNFWLE8qqDzHSzjLYNbEwJ7cTbO6bAWNhl
         U9YZ9Ct4XJADVWSwkUCf6ffX5Rme3YamGcpDVhDrdF77sAjSWI5BqWLcCdixBhtNHgcA
         L8pgmy53UJqrOq8HAGAQy55xxZ45Eb4ttMeIZYqwqNCwhXB3DOA8lWH8DqaG5NHyqdyj
         lJJ0nAO7XyW4Dq4t5Brg3ydNjjyBLsgBhqY9Flvb3Z2YrDNaplh4miCtl7JWS/YDImmu
         0N2CmWdvzEhP5Et8Gyqca5UgP9LBVktPx9NVqXxEhsJPgNGwmdRSUhTM5OPzNimQDaA6
         LguA==
X-Gm-Message-State: AOAM533/tYF2+5RhP0pNWYVIu66VmYNKiPvUnODXpzFUGMCE/sdR2SG4
        I8DpyBcf55rwhUTr6W0iArL3krJRefP5bQ==
X-Google-Smtp-Source: ABdhPJxnP3SsNodnp8Nxn3ZnrFrQVmP7QZ+4CAB/a8XIIjMcZWC8PDlPjmhqV88DHeOGOcOtUcwZJg==
X-Received: by 2002:ac8:7f88:: with SMTP id z8mr20078718qtj.365.1637180424432;
        Wed, 17 Nov 2021 12:20:24 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:24 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 08/10] btrfs-progs: receive: process setflags ioctl commands
Date:   Wed, 17 Nov 2021 12:19:35 -0800
Message-Id: <3a061c9f2fe39fbeb5ec675b388f327ffebd0f20.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

In send stream v2, send can emit a command for setting inode flags via
the setflags ioctl. Pass the flags attribute through to the ioctl call
in receive.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  6 ++++++
 cmds/receive.c       | 25 +++++++++++++++++++++++++
 common/send-stream.c |  7 +++++++
 common/send-stream.h |  1 +
 4 files changed, 39 insertions(+)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 4ed7cbe5..53d3e4a8 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -340,6 +340,11 @@ static int print_fallocate(const char *path, int mode, u64 offset, u64 len,
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
@@ -364,4 +369,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
 	.fallocate = print_fallocate,
+	.setflags = print_setflags,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index a902a55e..ebd7289d 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -38,6 +38,7 @@
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <sys/xattr.h>
+#include <linux/fs.h>
 #include <uuid/uuid.h>
 
 #include <lzo/lzo1x.h>
@@ -1284,6 +1285,29 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
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
+	ret = open_inode_for_write(rctx, full_path);
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
@@ -1308,6 +1332,7 @@ static struct btrfs_send_ops send_ops = {
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
 	.fallocate = process_fallocate,
+	.setflags = process_setflags,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index db0939a2..f25450c8 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -374,6 +374,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	int len;
 	int xattr_len;
 	int fallocate_mode;
+	int setflags_flags;
 
 	ret = read_cmd(sctx);
 	if (ret)
@@ -546,8 +547,14 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
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
index 61a88d3d..3189f889 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -59,6 +59,7 @@ struct btrfs_send_ops {
 			     u32 encryption, void *user);
 	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
 			 void *user);
+	int (*setflags)(const char *path, int flags, void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
-- 
2.34.0

