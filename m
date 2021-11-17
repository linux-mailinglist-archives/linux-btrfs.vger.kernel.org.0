Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F01454E76
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbhKQUXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbhKQUXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:21 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF62C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:22 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id s9so2886260qvk.12
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Sl50TrXPAfLx7f5u5FtuxTp2XMdHTIeMc7+9mVKPEw=;
        b=6Nu++7xoMXqVevdsyva7WFqDyhgEG+tYK6TJEemHEmpMXpXbHrrm7S4Dgia/3bHiZI
         qRv+ZfQjacrC8Gb6+Olb6R6nKSI5icK6zZ6MqP7xEyjT87kTd6TL1TiZCrwPEBxDOmkt
         RtrIZmP0K8e7Fn1+6Tp5D7Z+ic6PCA8mMxlZA2HqocDvlj3g216rB8KPCoJksfOcSAv6
         tFCBQCxLt/TWVwa5+TIkXJ9ugQ4TnnEiMVo7slcE/FTqeVFVzEDs+cVIpomWGG9Q5ahr
         mSM/L9vOxeNsgEQ6zs5mIAZ4/kNsrlF3wd8nUnzjKvfL9WBHWXFRBp9C/8w4p8DtP93+
         mSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Sl50TrXPAfLx7f5u5FtuxTp2XMdHTIeMc7+9mVKPEw=;
        b=IS7QtWBi7HYhYjxUoMMMTWREkPGDGAOGePvWeeLPh3kKLwwKCJtnHIQNzFcldVwyZP
         Kl+oBtsI4jTaIt4IYOJIXEGFLmotvymBxuO4UbcwApXdIMtLoBwCaoQzpMgIN/3nQtRX
         6yQhnk7szNx7AKEnkE79iDwWlFg3CyjgHdUi2lXo8e1r9A8FxaNYzImphoaAhRKUifjT
         qYkm0Y61K94nv/MWGcJ12T0UgkUd3hWKx216AbM1NVsbCBkZ5lbuX3LfWt3vzQj0RSV0
         Vfyevf9y5fbsz1hdbRmgBPbdx6b0vOrC1So41JPKlKuUwPuJ5Bj9PJRH1lduy5Z6XFyk
         uy+g==
X-Gm-Message-State: AOAM533+7ZzBegbs83zDQpk317kxByRlQBVyKaSvaXxQEr+O2m1kEhIc
        XTITE/vo8AS/XTWJT5EGl8ZgjAfFFQjaMw==
X-Google-Smtp-Source: ABdhPJzF+Zs5fzRYxI9AWfvRXvPJ7X/wNj9jzHlEvSpTE9Q7r+dKHB1+caP/ntV4JLsAVUyU5COwbg==
X-Received: by 2002:a05:6214:e66:: with SMTP id jz6mr51036509qvb.20.1637180421732;
        Wed, 17 Nov 2021 12:20:21 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:21 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 05/10] btrfs-progs: receive: process encoded_write commands
Date:   Wed, 17 Nov 2021 12:19:32 -0800
Message-Id: <11460fde702dd7f4e9599d5e3cc7a80df724f551.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

Add a new btrfs_send_op and support for both dumping and proper receive
processing which does actual encoded writes.

Encoded writes are only allowed on a file descriptor opened with an
extra flag that allows encoded writes, so we also add support for this
flag when opening or reusing a file for writing.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  16 +++++-
 cmds/receive.c       |  48 ++++++++++++++++
 common/send-stream.c |  29 ++++++++++
 common/send-stream.h |   4 ++
 ioctl.h              | 132 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 47a0a30e..09bb947b 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -319,6 +319,19 @@ static int print_update_extent(const char *path, u64 offset, u64 len,
 			  offset, len);
 }
 
+static int print_encoded_write(const char *path, const void *data, u64 offset,
+			       u64 len, u64 unencoded_file_len,
+			       u64 unencoded_len, u64 unencoded_offset,
+			       u32 compression, u32 encryption, void *user)
+{
+	return PRINT_DUMP(user, path, "encoded_write",
+			  "offset=%llu len=%llu, unencoded_file_len=%llu, "
+			  "unencoded_len=%llu, unencoded_offset=%llu, "
+			  "compression=%u, encryption=%u",
+			  offset, len, unencoded_file_len, unencoded_len,
+			  unencoded_offset, compression, encryption);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -340,5 +353,6 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.chmod = print_chmod,
 	.chown = print_chown,
 	.utimes = print_utimes,
-	.update_extent = print_update_extent
+	.update_extent = print_update_extent,
+	.encoded_write = print_encoded_write,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 4d123a1f..38579efc 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -29,12 +29,14 @@
 #include <assert.h>
 #include <getopt.h>
 #include <limits.h>
+#include <errno.h>
 
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/uio.h>
 #include <sys/xattr.h>
 #include <uuid/uuid.h>
 
@@ -49,6 +51,7 @@
 #include "cmds/receive-dump.h"
 #include "common/help.h"
 #include "common/path-utils.h"
+#include "stubs.h"
 
 struct btrfs_receive
 {
@@ -982,6 +985,50 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 	return 0;
 }
 
+static int process_encoded_write(const char *path, const void *data, u64 offset,
+				 u64 len, u64 unencoded_file_len,
+				 u64 unencoded_len, u64 unencoded_offset,
+				 u32 compression, u32 encryption, void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+	struct iovec iov = { (char *)data, len };
+	struct btrfs_ioctl_encoded_io_args encoded = {
+		.iov = &iov,
+		.iovcnt = 1,
+		.offset = offset,
+		.len = unencoded_file_len,
+		.unencoded_len = unencoded_len,
+		.unencoded_offset = unencoded_offset,
+		.compression = compression,
+		.encryption = encryption,
+	};
+
+	if (encryption) {
+		error("encoded_write: encryption not supported");
+		return -EOPNOTSUPP;
+	}
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("encoded_write: path invalid: %s", path);
+		return ret;
+	}
+
+	ret = open_inode_for_write(rctx, full_path);
+	if (ret < 0)
+		return ret;
+
+	ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
+	if (ret < 0) {
+		ret = -errno;
+		error("encoded_write: writing to %s failed: %m", path);
+		return ret;
+	}
+	return 0;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1004,6 +1051,7 @@ static struct btrfs_send_ops send_ops = {
 	.chown = process_chown,
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
+	.encoded_write = process_encoded_write,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index 85b9998d..33227d3f 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -357,6 +357,8 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	struct timespec mt;
 	u8 uuid[BTRFS_UUID_SIZE];
 	u8 clone_uuid[BTRFS_UUID_SIZE];
+	u32 compression;
+	u32 encryption;
 	u64 tmp;
 	u64 tmp2;
 	u64 ctransid;
@@ -366,6 +368,9 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	u64 clone_offset;
 	u64 offset;
 	u64 ino;
+	u64 unencoded_file_len;
+	u64 unencoded_len;
+	u64 unencoded_offset;
 	int len;
 	int xattr_len;
 
@@ -452,6 +457,30 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 		TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
 		ret = sctx->ops->write(path, data, offset, len, sctx->user);
 		break;
+	case BTRFS_SEND_C_ENCODED_WRITE:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
+			    &unencoded_file_len);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN, &unencoded_len);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET,
+			    &unencoded_offset);
+		/* Compression and encryption default to none if omitted. */
+		if (sctx->cmd_attrs[BTRFS_SEND_A_COMPRESSION].data)
+			TLV_GET_U32(sctx, BTRFS_SEND_A_COMPRESSION, &compression);
+		else
+			compression = BTRFS_ENCODED_IO_COMPRESSION_NONE;
+		if (sctx->cmd_attrs[BTRFS_SEND_A_ENCRYPTION].data)
+			TLV_GET_U32(sctx, BTRFS_SEND_A_ENCRYPTION, &encryption);
+		else
+			encryption = BTRFS_ENCODED_IO_ENCRYPTION_NONE;
+		TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
+		ret = sctx->ops->encoded_write(path, data, offset, len,
+					       unencoded_file_len,
+					       unencoded_len, unencoded_offset,
+					       compression, encryption,
+					       sctx->user);
+		break;
 	case BTRFS_SEND_C_CLONE:
 		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
 		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
diff --git a/common/send-stream.h b/common/send-stream.h
index 2de51eac..44abbc9d 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -53,6 +53,10 @@ struct btrfs_send_ops {
 		      struct timespec *mt, struct timespec *ct,
 		      void *user);
 	int (*update_extent)(const char *path, u64 offset, u64 len, void *user);
+	int (*encoded_write)(const char *path, const void *data, u64 offset,
+			     u64 len, u64 unencoded_file_len, u64 unencoded_len,
+			     u64 unencoded_offset, u32 compression,
+			     u32 encryption, void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
diff --git a/ioctl.h b/ioctl.h
index 368a87b2..dcfe0b6c 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -777,6 +777,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 };
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_get_subvol_rootref_args) == 4096);
 
+/*
+ * Data and metadata for an encoded read or write.
+ *
+ * Encoded I/O bypasses any encoding automatically done by the filesystem (e.g.,
+ * compression). This can be used to read the compressed contents of a file or
+ * write pre-compressed data directly to a file.
+ *
+ * BTRFS_IOC_ENCODED_READ and BTRFS_IOC_ENCODED_WRITE are essentially
+ * preadv/pwritev with additional metadata about how the data is encoded and the
+ * size of the unencoded data.
+ *
+ * BTRFS_IOC_ENCODED_READ fills the given iovecs with the encoded data, fills
+ * the metadata fields, and returns the size of the encoded data. It reads one
+ * extent per call. It can also read data which is not encoded.
+ *
+ * BTRFS_IOC_ENCODED_WRITE uses the metadata fields, writes the encoded data
+ * from the iovecs, and returns the size of the encoded data. Note that the
+ * encoded data is not validated when it is written; if it is not valid (e.g.,
+ * it cannot be decompressed), then a subsequent read may return an error.
+ *
+ * Since the filesystem page cache contains decoded data, encoded I/O bypasses
+ * the page cache. Encoded I/O requires CAP_SYS_ADMIN.
+ */
+struct btrfs_ioctl_encoded_io_args {
+	/* Input parameters for both reads and writes. */
+
+	/*
+	 * iovecs containing encoded data.
+	 *
+	 * For reads, if the size of the encoded data is larger than the sum of
+	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
+	 * ENOBUFS.
+	 *
+	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
+	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
+	 * increase in the future). This must also be less than or equal to
+	 * unencoded_len.
+	 */
+	const struct iovec __user *iov;
+	/* Number of iovecs. */
+	unsigned long iovcnt;
+	/*
+	 * Offset in file.
+	 *
+	 * For writes, must be aligned to the sector size of the filesystem.
+	 */
+	__s64 offset;
+	/* Currently must be zero. */
+	__u64 flags;
+
+	/*
+	 * For reads, the following members are output parameters that will
+	 * contain the returned metadata for the encoded data.
+	 * For writes, the following members must be set to the metadata for the
+	 * encoded data.
+	 */
+
+	/*
+	 * Length of the data in the file.
+	 *
+	 * Must be less than or equal to unencoded_len - unencoded_offset. For
+	 * writes, must be aligned to the sector size of the filesystem unless
+	 * the data ends at or beyond the current end of the file.
+	 */
+	__u64 len;
+	/*
+	 * Length of the unencoded (i.e., decrypted and decompressed) data.
+	 *
+	 * For writes, must be no more than 128 KiB (this limit may increase in
+	 * the future). If the unencoded data is actually longer than
+	 * unencoded_len, then it is truncated; if it is shorter, then it is
+	 * extended with zeroes.
+	 */
+	__u64 unencoded_len;
+	/*
+	 * Offset from the first byte of the unencoded data to the first byte of
+	 * logical data in the file.
+	 *
+	 * Must be less than unencoded_len.
+	 */
+	__u64 unencoded_offset;
+	/*
+	 * BTRFS_ENCODED_IO_COMPRESSION_* type.
+	 *
+	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
+	 */
+	__u32 compression;
+	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
+	__u32 encryption;
+	/*
+	 * Reserved for future expansion.
+	 *
+	 * For reads, always returned as zero. Users should check for non-zero
+	 * bytes. If there are any, then the kernel has a newer version of this
+	 * structure with additional information that the user definition is
+	 * missing.
+	 *
+	 * For writes, must be zeroed.
+	 */
+	__u8 reserved[32];
+};
+
+/* Data is not compressed. */
+#define BTRFS_ENCODED_IO_COMPRESSION_NONE 0
+/* Data is compressed as a single zlib stream. */
+#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB 1
+/*
+ * Data is compressed as a single zstd frame with the windowLog compression
+ * parameter set to no more than 17.
+ */
+#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
+/*
+ * Data is compressed sector by sector (using the sector size indicated by the
+ * name of the constant) with LZO1X and wrapped in the format documented in
+ * fs/btrfs/lzo.c. For writes, the compression sector size must match the
+ * filesystem sector size.
+ */
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K 5
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K 6
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K 7
+#define BTRFS_ENCODED_IO_COMPRESSION_TYPES 8
+
+/* Data is not encrypted. */
+#define BTRFS_ENCODED_IO_ENCRYPTION_NONE 0
+#define BTRFS_ENCODED_IO_ENCRYPTION_TYPES 1
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	notused,
@@ -951,6 +1079,10 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				   struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				    struct btrfs_ioctl_encoded_io_args)
+#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				     struct btrfs_ioctl_encoded_io_args)
 
 #ifdef __cplusplus
 }
-- 
2.34.0

