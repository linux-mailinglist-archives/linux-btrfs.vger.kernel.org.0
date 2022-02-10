Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225954B15EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbiBJTKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbiBJTKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:52 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40401167
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:53 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso2003717pjl.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWeARFa44iA3jS4ac9DyrmIZLzJAv6WrYv7ger6fmvw=;
        b=BRSnKBpjjPr8kcAP1VodyKCc5QnR7rBmS/9/iKacnUuQsUw9y1ACjglp0w/rcsO51J
         w09OHfnY4ERYromZxPd5d54ZiIdbRWY7CxuBh8jwbWEJ6Nsut6xzYbIX26BYw0E+18t2
         iUhha4/o8jD65FlK+Z3B6Vwba8JMS4xaO5Elk6rCC//Xf2wwzA5IhoH5aJA7NA0jyGdj
         OZU3mrjhL2f2GeOuOPRKtuGMhGJBvytIuZeBYXymv6leOl1i7pG7/OJbhjF3PYXnNjnq
         i6DT5HlB38/JxZ+W8NfY29J9G8ZVm2qKOoTUwgX334Bid9GLOnwYpU3zVsFuVDTdtfbx
         U5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWeARFa44iA3jS4ac9DyrmIZLzJAv6WrYv7ger6fmvw=;
        b=AktQ//aeLO9N/xRHn7PhtqIPAxOkK/D8WZ4ih8xdDAlLNXtte0+5mtUOO/ACLmHtkq
         1vzZuw/bLkNiCP/AN8EoHKO0TZDDJf8F8H08RFl5gP3Mzg/eQ37zrPlX467DuNH7kdPO
         /1XCOsGElmnvjKq0QPWlix2+5wEHPdGHQrwpepPtwyX+z0WcDk/umoP25/Oix97NUED7
         oLZ4Eu0sdUHrA1i+5RH0A7OPGvp+6mHA/54/HqXRaEl+CCTAUd2aM8WMuGCFV4PQ0/G6
         +M9u+lRFYkh9OwWyoePGoFRHrMSdY+P2C2OSNxBrtyOo/OnKBo8sRviN7ovYPhvNNmpW
         NVTQ==
X-Gm-Message-State: AOAM531AiUOqzxa6iYGroG0UCLokFibSr+vXjaVYaYTfuNI0n4aX8RZK
        TIIeYdVEhnVu5biyLJbQvBKkswoEp0ne/A==
X-Google-Smtp-Source: ABdhPJzUhQ76IIY9id7Aew1VDsm+PKaJmC68AOz4wKYw/eKSbkuO2SAHymCnOlN2/pFk42XDc2Jfpg==
X-Received: by 2002:a17:90b:951:: with SMTP id dw17mr4414129pjb.10.1644520252900;
        Thu, 10 Feb 2022 11:10:52 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:52 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 07/10] btrfs-progs: receive: process fallocate commands
Date:   Thu, 10 Feb 2022 11:10:14 -0800
Message-Id: <d66a4f6d988b6609ba9909e2949eaac33f5330cd.1644520114.git.osandov@fb.com>
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

