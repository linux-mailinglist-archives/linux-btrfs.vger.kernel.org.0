Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3994B15FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiBJTKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbiBJTKx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B258B21AE
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso5330251pjj.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4Zc2VDwcN7WNUNPczgMrS6RYIapeQEbHJjjRCTXvSI=;
        b=v8VgVbbHq+c+aQTJ4lxbzAnqYZrLoRPl1VYK0jMpWMizkhA8VRZ4mwOK9s8iNxpizo
         ssLyr45TXUjmy9o/F9raiI5aCwwml4DNCgIbMTtqAaX/x8Kz3SfrBWiVgUn8OCwbjrVJ
         LtVhWAW5RDEvFOGJTPaQ+6924+UBqJ75jT1oIUD/xlOXHq13AaMG0u8eLsyHuPYpb054
         CgItigYl47IElal4SlVsYrFL+ah6MoF3ybc9pEkiRgtWFjbYyiS9g9Xjyat0GP7l+GC6
         qROoSuqNNT7xKnzB20G+bFYRIofiya7FNtaCL552IcdsXXruoNkBuIA8vRYXO6H85TIY
         /ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4Zc2VDwcN7WNUNPczgMrS6RYIapeQEbHJjjRCTXvSI=;
        b=h/PTHi+NWdU1bOWYpJguUCjE01czvGapjeV2CT6oSF3x/QGC7qrLLtfvSVCY0SHcl6
         ljoHvOiwBYi8zW2HpHDPGcjo5t87NFRnW79UfegnbCjStXB1a0SbtBSMBLDJXPt2rWrf
         mSjZwKw9R9DAJvecJtHb35S5ejdY58qGoXMzN6dK+JsH5TKINzpskKV2/QzOmxlJ8q0C
         S9soJBtn4uPqeETBepfwoeakasTaqc7wRYm2A5XWRKNtrCTYFoM7yqxCU2RLMhPktBt9
         cvItczikk3S55+SJoFpqLibAyR88nOVyluONXKuwpq8Nn/XscO/9jGdaN672J6NXI/i1
         w1xA==
X-Gm-Message-State: AOAM530OV5j1I+k9pJfd1YfuEREYD5jELtPkbAYdeiIAam0iEzANgvTe
        b20WdupmekXBlgeIWryVmo0o1RMNTV3eZg==
X-Google-Smtp-Source: ABdhPJz0TZ/85unn4PO29HbG3au5W5hGqFSC1BwM0QApBwhsSb5+OjhcTNXQOpzt9evpOH9ZEzoQ2w==
X-Received: by 2002:a17:90b:3648:: with SMTP id nh8mr4333727pjb.145.1644520253920;
        Thu, 10 Feb 2022 11:10:53 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:53 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 08/10] btrfs-progs: receive: process setflags ioctl commands
Date:   Thu, 10 Feb 2022 11:10:15 -0800
Message-Id: <09ad694ee80c5e9c4423b88e9dc0128643b2b534.1644520114.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
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

