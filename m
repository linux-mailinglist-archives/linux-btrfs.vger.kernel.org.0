Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5566F454E79
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhKQUXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhKQUXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:23 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A77C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:24 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id m17so2898592qvx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pfjP+TEtFsuSw2Qlsvy4mF270tzb0QmXyxR0ariDEY=;
        b=cNW7N4wBrqaImzTy6aS6hlEtTvDbzJg3+sE6pOw/Ns8M7OdwybgQF0pCcCZY6kW2zR
         rfoF7PD0ByDgKM6nPW7F7hzh4IABb2siKD8aoC3IIPqoS7Vcqy5TZu31PcRp49Nud76z
         r83VzpIqCqT4TbpF6jI3uCDmHRcCYIniMcnru8FAQ2EFshx2iWEw9obldnuXaHtG0na9
         +kERxI37fGJnjuWXzSnaUbersCqoJq3XARuVLnD9UQOgkfeVvfkYVl3YJSxBWUP5kh3L
         GzGmfhP+EROT1i2DaJAh8EjXUNIdir0dBzfXk33kbeOX5KIIFNvd5zjXS/PEMXlnTdVq
         9c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pfjP+TEtFsuSw2Qlsvy4mF270tzb0QmXyxR0ariDEY=;
        b=cPZEYsCMh8QF0p9nhMcou2jXVnLo6K3Nbji08i7ccYGun1FzytGZQFlfF57jm+XTL2
         UsLp0dN8hhXJcjaePWgnXLqzMR1mjkBToZgXeTWU2HMm47UuHW3/wK6hSWdZObrFLlJI
         oOw/Fp4wNrAmzMCa3Ypr6Zxsi0Mv4C67am1WdfbeEptn30XltmagyvhQgitPRC0IZ5MI
         Avlm+AZBrVoYBgoQWjM2VEJkeENn7dAxiENNDZph8UVziKwQw828emVu6M/GA/xIKTbm
         mF7WzI17K7mo2aMtLeRtssP/NmfxxRqeVTu8MNUGjYGMltcc5yTH0J49b/c5jGwrgtLO
         Qfbg==
X-Gm-Message-State: AOAM533ZaElPUx+2oPFBQ36oMvdChJk/6Fc2PKIQWkwtGdeXoqtn8GK3
        QlYEUy8BdvKxDT6UEV0DYC4nCejnltgQrg==
X-Google-Smtp-Source: ABdhPJww5Sxq8HalNM4Qx394XIO9q/4agTCfz8ma+nS3Pf3BwaeWhJKpEiY840/dfqRqiSe4qK2zSQ==
X-Received: by 2002:a05:6214:2a8b:: with SMTP id jr11mr57857761qvb.19.1637180423537;
        Wed, 17 Nov 2021 12:20:23 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:23 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 07/10] btrfs-progs: receive: process fallocate commands
Date:   Wed, 17 Nov 2021 12:19:34 -0800
Message-Id: <6196a7a624faabd8778633eec0003ef0d5df5729.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 09bb947b..4ed7cbe5 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -332,6 +332,14 @@ static int print_encoded_write(const char *path, const void *data, u64 offset,
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
@@ -355,4 +363,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.utimes = print_utimes,
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
+	.fallocate = print_fallocate,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 60f9a3fe..a902a55e 100644
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
index 33227d3f..db0939a2 100644
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
2.34.0

