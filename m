Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901B24DCC5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiCQR1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiCQR1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C314DFE5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b8so5435698pjb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4Zc2VDwcN7WNUNPczgMrS6RYIapeQEbHJjjRCTXvSI=;
        b=3lO9WAU0II71mjlNVRHDpbb9L8LWK9QbcEUeh/sbYmZsFAtmkdVP3K/JFhtcSEX4Sn
         RsVRbCf1iRx325ddjWX5F8bFrCuptdeurb7FVXIv7a+iA/IIuxqdNAglEAAFM3BZd4cv
         wPqH806FTBYcsgX/6z3zzTiicAM1BBeCpM+11JA9+andTbjPZ58l7lFW1DzxmIemUa8R
         EAgGla0wWc2LwEACyYsvt15svyXSVPR+oM3LlJbNhucOrA1LESbLToSfWylI/G0GYhjT
         pkxvdVVLmxxy6l+j9Kx4qPTkTjmj9W7o7LoRaWXu3sunIVG7nTGr01DAa0KW4LqVNwVQ
         BJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4Zc2VDwcN7WNUNPczgMrS6RYIapeQEbHJjjRCTXvSI=;
        b=WFuSOBv1zZCMZgeHTKCCbYJjAx6u+F3zK4MMpTTUIpD4Lth/ZAWwye7VtbtY0m4QMX
         /Esq1DRyfNBe6v2sBymcOUimmN3lJpr0NOKxUgAIMg7DsOuDhbLl+7h+IwW1JbiIqMSV
         cMXBIPWBbYRH3IbhpY+iUVvDIfyRK6DKLKsIHyXHBMQgLmsVrw9seJULwGm7MBxH4G7s
         5bms/ioiyMJ93URxnPjux+M/X7ZBJUY4Iht2aaeU4E5QHE3ffXoiHan+5Siu9q8jcVWn
         H4vIIsUxc2Rnf5ncllp/fEhAlSOUujAhUo/MWpBT5gUEf1PlYM3RcIgaWKNkhYw06yli
         MhrA==
X-Gm-Message-State: AOAM532uQZZO8PMrRKTWmyNM6NFWB8/bt/E7+jFIzC3zQ8V4NoBXBQyD
        lW6i0wO0TPE5EYR4NEIR7omvf+t0ej6PaA==
X-Google-Smtp-Source: ABdhPJx3WA+g6YIxvZY89r+/2SvsJL9xQJ9DMRA4oqu0Nrgwv0rICn8VdiQ9VxKOmaaN+nayp99cVQ==
X-Received: by 2002:a17:902:8bc2:b0:149:1ce6:c28c with SMTP id r2-20020a1709028bc200b001491ce6c28cmr5939137plo.164.1647537980554;
        Thu, 17 Mar 2022 10:26:20 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 08/10] btrfs-progs: receive: process setflags ioctl commands
Date:   Thu, 17 Mar 2022 10:25:51 -0700
Message-Id: <7e92fa68eafefadb4f384b3b8cb2879b6edbcd89.1647537098.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index fa397bcf..df5991e1 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -339,6 +339,11 @@ static int print_fallocate(const char *path, int mode, u64 offset, u64 len,
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
@@ -363,4 +368,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
 	.fallocate = print_fallocate,
+	.setflags = print_setflags,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 4893d693..7f76a04f 100644
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
index 2d0aa624..21295cbb 100644
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
2.35.1

