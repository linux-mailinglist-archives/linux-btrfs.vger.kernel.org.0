Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7EC4DCC66
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiCQR1h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiCQR1g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:36 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8616114DFE5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bc27so3155444pgb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWeARFa44iA3jS4ac9DyrmIZLzJAv6WrYv7ger6fmvw=;
        b=xma0LR9Njnc5jtBs9yq/Hj4zeFDikZsNTmL1yFTesGXJypxudmS0Q/G4l248s+49/p
         WdoY0P0weSJfZ4LC3OCzZ1QoSkQHajjjIIwqivsk9WqNRZRgGEBcuxh4e362F2qhsdBH
         SnoAPY535FkLx9lnVEzVgRgROzWHoD1aX/zgbmnm6IEW6NWajqQxEIU140vfQU08Okox
         tHNOfP1cHfHHzudj7EiUNgrj9vV7FOLbmK4KrVVIvtvX/AjgSXkD18j8zqKPpf0PdpaD
         gQOXUTX54GnLDTBYdtsxkhH9cFcE0u1mvAIQ4r2ldXdGxzW3RRvyrZ40GLXA6KzcOqzC
         qOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWeARFa44iA3jS4ac9DyrmIZLzJAv6WrYv7ger6fmvw=;
        b=JR/eyC9ZSbuookwzzqzoKxdGbI9VmuCw/vY3w7IvphkMZ2Tv63nbzckGrPO3UFFM82
         3LZTkoWVF8W8CLpvrm5W7BLsUaMJiSHqVRM6ivsnQrRBbZCTVXg1tQPnvxD2DkXynXhT
         UXXVKkcHE1eZfY4NSLzqfaAboODtpwKfQuWR9KPAtbh9CJ0Jy+/UXpfdjzOK5YOmm7S9
         OBpUH8HeQLaVZS9P34aDrKQa9NniyI+/j7CEY230ok4uBgas7++7gpoAjAzh/B3WbMyI
         BzDSep2ZvAR1sWkLH/kUy7htwtmHMRhxcuLe8OUyF6s+HLArOE6aBFCQPU0tYIqn2JU4
         /xug==
X-Gm-Message-State: AOAM533gYyJcvt7ViWQN2j/+e+BOM+lP2DTIXQdezoxoDi32UNqYTI0J
        OywDuHJoyjpAwWfjc3bpuLadNUAsT2fi4w==
X-Google-Smtp-Source: ABdhPJwRp9+u9PJm2lIUE98ZCL1btt6Bk9DUzhY+kjnJnTsH72ltk8aYMpZxa6zG82EyEUp8Dqt8kA==
X-Received: by 2002:a63:ea05:0:b0:381:1497:63ab with SMTP id c5-20020a63ea05000000b00381149763abmr4474401pgi.463.1647537979652;
        Thu, 17 Mar 2022 10:26:19 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:19 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 07/10] btrfs-progs: receive: process fallocate commands
Date:   Thu, 17 Mar 2022 10:25:50 -0700
Message-Id: <cb11e41ab1e99f484b4972b814126fc0452af91e.1647537098.git.osandov@fb.com>
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

Send stream v2 can emit fallocate commands, so receive must support them
as well. The implementation simply passes along the arguments to the
syscall. Note that mode is encoded as a u32 in send stream but fallocate
takes an int, so there is a unsigned->signed conversion there.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  9 +++++++++
 cmds/receive.c       | 25 +++++++++++++++++++++++++
 common/send-stream.c |  9 +++++++++
 common/send-stream.h |  2 ++
 4 files changed, 45 insertions(+)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 83701b62..fa397bcf 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -331,6 +331,14 @@ static int print_encoded_write(const char *path, const void *data, u64 offset,
 			  unencoded_offset, compression, encryption);
 }
 
+static int print_fallocate(const char *path, int mode, u64 offset, u64 len,
+			   void *user)
+{
+	return PRINT_DUMP(user, path, "fallocate",
+			  "mode=%d offset=%llu len=%llu",
+			  mode, offset, len);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -354,4 +362,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.utimes = print_utimes,
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
+	.fallocate = print_fallocate,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 5fd939ce..4893d693 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1260,6 +1260,30 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 				    compression);
 }
 
+static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
+			     void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("fallocate: path invalid: %s", path);
+		return ret;
+	}
+	ret = open_inode_for_write(rctx, full_path);
+	if (ret < 0)
+		return ret;
+	ret = fallocate(rctx->write_fd, mode, offset, len);
+	if (ret < 0) {
+		ret = -errno;
+		error("fallocate: fallocate on %s failed: %m", path);
+		return ret;
+	}
+	return 0;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1283,6 +1307,7 @@ static struct btrfs_send_ops send_ops = {
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
+	.fallocate = process_fallocate,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index ce7c40f5..2d0aa624 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -373,6 +373,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	u64 unencoded_offset;
 	int len;
 	int xattr_len;
+	int fallocate_mode;
 
 	ret = read_cmd(sctx);
 	if (ret)
@@ -537,6 +538,14 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	case BTRFS_SEND_C_END:
 		ret = 1;
 		break;
+	case BTRFS_SEND_C_FALLOCATE:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, &fallocate_mode);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_SIZE, &tmp);
+		ret = sctx->ops->fallocate(path, fallocate_mode, offset, tmp,
+					   sctx->user);
+		break;
 	}
 
 tlv_get_failed:
diff --git a/common/send-stream.h b/common/send-stream.h
index 44abbc9d..61a88d3d 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -57,6 +57,8 @@ struct btrfs_send_ops {
 			     u64 len, u64 unencoded_file_len, u64 unencoded_len,
 			     u64 unencoded_offset, u32 compression,
 			     u32 encryption, void *user);
+	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
+			 void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
-- 
2.35.1

