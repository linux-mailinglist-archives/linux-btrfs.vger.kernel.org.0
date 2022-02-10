Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5C4B15E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiBJTKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbiBJTKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5010BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z17so2667758plb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avR3vKfYvv03oOFT042JUUzsoH3WTQR7nOr7tDVoOAY=;
        b=dVqUVp4bOTh4XGBtYaS+naGV7+a5JbgHvmeM7VxsntlVowEv/nxTW8fcWyarrCBAo+
         +wxpOauvtTN/G5x+eQtt1E/+BnanRF+tU5CX7S8y4KV+qo5YBcRcuMazJMhSRFhdEmw4
         vNXBoAI2OvhVlv0AVgwezj5sUbm90AZqxg5gyApgyrkuOOYIw1OyA0eD89eChQtu+18x
         M/7nuojDQ2vAEy6QZZbFUbRPbQNtWPoEWz9PP6GGNJGfX4mgvB1Rb58qSPd2IIEyGnA+
         sATcsWxoOb0ZBXFmzsYlTSOdyWhUZ5GBSg+k34WIpPY/Hp+LvodNJ65dyLWpIpUBqiPa
         EeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avR3vKfYvv03oOFT042JUUzsoH3WTQR7nOr7tDVoOAY=;
        b=Kf88jJNVHeEkEHGrpWRnzrsOwTjHhnrv2Teej72FHlM//GoWQFa1cDNVzCJSipm8XT
         f9f/OmwVsJLiP4vJNNnpxOkKlBpmhIA3MkTmPhHtMIkhJRZd7Zbq1YiGGwsDTxxib6Y2
         68mZJszTm/dKkJCGxKdNvtwE0OxK3tkbLtR//vmwKOUaktFZ6YaoYur3tM97qUrbg2Yi
         UuAiwMhuWDW7wPDI1bBSomwNUw5kbyqK7aYvIareItIH5N1HXy6t69jRP1S0wbNCd/M5
         U9XMn9xHpU+GJaM+GBfDA2mHU4zzmKJiiQPW0IsTYLG0q1VLPUINYL4FnWQ7esHQcGWb
         5F2g==
X-Gm-Message-State: AOAM533m1Mhur0DG0otL5oNgeKGrjWOw084XuE79i97/92PFXsvdDK1v
        k1Y4OzRbqxerm+8Q4kmM16vZvB7hEC5hSw==
X-Google-Smtp-Source: ABdhPJw0XA4OkEbD38S397tip2GZ0BAFokYrhWQrj7z/TVa+uit7WztAhAjKcXT9FHpNkSZ+ljqYkA==
X-Received: by 2002:a17:90b:4b83:: with SMTP id lr3mr4313789pjb.135.1644520252029;
        Thu, 10 Feb 2022 11:10:52 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:51 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 06/10] btrfs-progs: receive: encoded_write fallback to explicit decode and write
Date:   Thu, 10 Feb 2022 11:10:13 -0800
Message-Id: <988fb54c81ae8b185a36fc7cfd0b4b9f873da76e.1644520114.git.osandov@fb.com>
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

An encoded_write can fail if the file system it is being applied to does
not support encoded writes or if it can't find enough contiguous space
to accommodate the encoded extent. In those cases, we can likely still
process an encoded_write by explicitly decoding the data and doing a
normal write.

Add the necessary fallback path for decoding data compressed with zlib,
lzo, or zstd. zlib and zstd have reusable decoding context data
structures which we cache in the receive context so that we don't have
to recreate them on every encoded_write.

Finally, add a command line flag for force-decompress which causes
receive to always use the fallback path rather than first attempting the
encoded write.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 Documentation/btrfs-receive.rst |   5 +
 cmds/receive.c                  | 261 +++++++++++++++++++++++++++++++-
 2 files changed, 259 insertions(+), 7 deletions(-)

diff --git a/Documentation/btrfs-receive.rst b/Documentation/btrfs-receive.rst
index 86ffdcc6..b9a3cad6 100644
--- a/Documentation/btrfs-receive.rst
+++ b/Documentation/btrfs-receive.rst
@@ -57,6 +57,11 @@ A subvolume is made read-only after the receiving process finishes successfully
         If */proc* is not accessible, eg. in a chroot environment, use this option to
         tell us where this filesystem is mounted.
 
+--force-decompress
+        if the stream contains compressed data (see *--compressed-data* in
+        ``btrfs-send(8)``), always decompress it instead of writing it with
+        encoded I/O
+
 --dump
         dump the stream metadata, one line per operation
 
diff --git a/cmds/receive.c b/cmds/receive.c
index 8226ca32..5fd939ce 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -40,6 +40,10 @@
 #include <sys/xattr.h>
 #include <uuid/uuid.h>
 
+#include <lzo/lzo1x.h>
+#include <zlib.h>
+#include <zstd.h>
+
 #include "kernel-shared/ctree.h"
 #include "ioctl.h"
 #include "cmds/commands.h"
@@ -75,6 +79,12 @@ struct btrfs_receive
 	char cur_subvol_path[PATH_MAX];
 
 	int honor_end_cmd;
+
+	bool force_decompress;
+
+	/* Reuse stream objects for encoded_write decompression fallback */
+	ZSTD_DStream *zstd_dstream;
+	z_stream *zlib_stream;
 };
 
 static int finish_subvol(struct btrfs_receive *rctx)
@@ -985,6 +995,219 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 	return 0;
 }
 
+static int decompress_zlib(struct btrfs_receive *rctx, const char *encoded_data,
+			   u64 encoded_len, char *unencoded_data,
+			   u64 unencoded_len)
+{
+	bool init = false;
+	int ret;
+
+	if (!rctx->zlib_stream) {
+		init = true;
+		rctx->zlib_stream = malloc(sizeof(z_stream));
+		if (!rctx->zlib_stream) {
+			error("failed to allocate zlib stream %m");
+			return -ENOMEM;
+		}
+	}
+	rctx->zlib_stream->next_in = (void *)encoded_data;
+	rctx->zlib_stream->avail_in = encoded_len;
+	rctx->zlib_stream->next_out = (void *)unencoded_data;
+	rctx->zlib_stream->avail_out = unencoded_len;
+
+	if (init) {
+		rctx->zlib_stream->zalloc = Z_NULL;
+		rctx->zlib_stream->zfree = Z_NULL;
+		rctx->zlib_stream->opaque = Z_NULL;
+		ret = inflateInit(rctx->zlib_stream);
+	} else {
+		ret = inflateReset(rctx->zlib_stream);
+	}
+	if (ret != Z_OK) {
+		error("zlib inflate init failed: %d", ret);
+		return -EIO;
+	}
+
+	while (rctx->zlib_stream->avail_in > 0 &&
+	       rctx->zlib_stream->avail_out > 0) {
+		ret = inflate(rctx->zlib_stream, Z_FINISH);
+		if (ret == Z_STREAM_END) {
+			break;
+		} else if (ret != Z_OK) {
+			error("zlib inflate failed: %d", ret);
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int decompress_zstd(struct btrfs_receive *rctx, const char *encoded_buf,
+			   u64 encoded_len, char *unencoded_buf,
+			   u64 unencoded_len)
+{
+	ZSTD_inBuffer in_buf = {
+		.src = encoded_buf,
+		.size = encoded_len
+	};
+	ZSTD_outBuffer out_buf = {
+		.dst = unencoded_buf,
+		.size = unencoded_len
+	};
+	size_t ret;
+
+	if (!rctx->zstd_dstream) {
+		rctx->zstd_dstream = ZSTD_createDStream();
+		if (!rctx->zstd_dstream) {
+			error("failed to create zstd dstream");
+			return -ENOMEM;
+		}
+	}
+	ret = ZSTD_initDStream(rctx->zstd_dstream);
+	if (ZSTD_isError(ret)) {
+		error("failed to init zstd stream: %s", ZSTD_getErrorName(ret));
+		return -EIO;
+	}
+	while (in_buf.pos < in_buf.size && out_buf.pos < out_buf.size) {
+		ret = ZSTD_decompressStream(rctx->zstd_dstream, &out_buf, &in_buf);
+		if (ret == 0) {
+			break;
+		} else if (ZSTD_isError(ret)) {
+			error("failed to decompress zstd stream: %s",
+			      ZSTD_getErrorName(ret));
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int decompress_lzo(const char *encoded_data, u64 encoded_len,
+			  char *unencoded_data, u64 unencoded_len,
+			  unsigned int sector_size)
+{
+	uint32_t total_len;
+	size_t in_pos, out_pos;
+
+	if (encoded_len < 4) {
+		error("lzo header is truncated");
+		return -EIO;
+	}
+	memcpy(&total_len, encoded_data, 4);
+	total_len = le32toh(total_len);
+	if (total_len > encoded_len) {
+		error("lzo header is invalid");
+		return -EIO;
+	}
+
+	in_pos = 4;
+	out_pos = 0;
+	while (in_pos < total_len && out_pos < unencoded_len) {
+		size_t sector_remaining;
+		uint32_t src_len;
+		lzo_uint dst_len;
+		int ret;
+
+		sector_remaining = -in_pos % sector_size;
+		if (sector_remaining < 4) {
+			if (total_len - in_pos <= sector_remaining)
+				break;
+			in_pos += sector_remaining;
+		}
+
+		if (total_len - in_pos < 4) {
+			error("lzo segment header is truncated");
+			return -EIO;
+		}
+
+		memcpy(&src_len, encoded_data + in_pos, 4);
+		src_len = le32toh(src_len);
+		in_pos += 4;
+		if (src_len > total_len - in_pos) {
+			error("lzo segment header is invalid");
+			return -EIO;
+		}
+
+		dst_len = sector_size;
+		ret = lzo1x_decompress_safe((void *)(encoded_data + in_pos),
+					    src_len,
+					    (void *)(unencoded_data + out_pos),
+					    &dst_len, NULL);
+		if (ret != LZO_E_OK) {
+			error("lzo1x_decompress_safe failed: %d", ret);
+			return -EIO;
+		}
+
+		in_pos += src_len;
+		out_pos += dst_len;
+	}
+	return 0;
+}
+
+static int decompress_and_write(struct btrfs_receive *rctx,
+				const char *encoded_data, u64 offset,
+				u64 encoded_len, u64 unencoded_file_len,
+				u64 unencoded_len, u64 unencoded_offset,
+				u32 compression)
+{
+	int ret = 0;
+	size_t pos;
+	ssize_t w;
+	char *unencoded_data;
+	int sector_shift;
+
+	unencoded_data = calloc(unencoded_len, 1);
+	if (!unencoded_data) {
+		error("allocating space for unencoded data failed: %m");
+		return -errno;
+	}
+
+	switch (compression) {
+	case BTRFS_ENCODED_IO_COMPRESSION_ZLIB:
+		ret = decompress_zlib(rctx, encoded_data, encoded_len,
+				      unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case BTRFS_ENCODED_IO_COMPRESSION_ZSTD:
+		ret = decompress_zstd(rctx, encoded_data, encoded_len,
+				      unencoded_data, unencoded_len);
+		if (ret)
+			goto out;
+		break;
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_4K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_8K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_16K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_32K:
+	case BTRFS_ENCODED_IO_COMPRESSION_LZO_64K:
+		sector_shift =
+			compression - BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + 12;
+		ret = decompress_lzo(encoded_data, encoded_len, unencoded_data,
+				     unencoded_len, 1U << sector_shift);
+		if (ret)
+			goto out;
+		break;
+	default:
+		error("unknown compression: %d", compression);
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	pos = unencoded_offset;
+	while (pos < unencoded_file_len) {
+		w = pwrite(rctx->write_fd, unencoded_data + pos,
+			   unencoded_file_len - pos, offset);
+		if (w < 0) {
+			ret = -errno;
+			error("writing unencoded data failed: %m");
+			goto out;
+		}
+		pos += w;
+		offset += w;
+	}
+out:
+	free(unencoded_data);
+	return ret;
+}
+
 static int process_encoded_write(const char *path, const void *data, u64 offset,
 				 u64 len, u64 unencoded_file_len,
 				 u64 unencoded_len, u64 unencoded_offset,
@@ -1020,13 +1243,21 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 	if (ret < 0)
 		return ret;
 
-	ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
-	if (ret < 0) {
-		ret = -errno;
-		error("encoded_write: writing to %s failed: %m", path);
-		return ret;
+	if (!rctx->force_decompress) {
+		ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
+		if (ret >= 0)
+			return 0;
+		/* Fall back for these errors, fail hard for anything else. */
+		if (errno != ENOSPC && errno != ENOTTY && errno != EINVAL) {
+			ret = -errno;
+			error("encoded_write: writing to %s failed: %m", path);
+			return ret;
+		}
 	}
-	return 0;
+
+	return decompress_and_write(rctx, data, offset, len, unencoded_file_len,
+				    unencoded_len, unencoded_offset,
+				    compression);
 }
 
 static struct btrfs_send_ops send_ops = {
@@ -1204,6 +1435,12 @@ out:
 		close(rctx->dest_dir_fd);
 		rctx->dest_dir_fd = -1;
 	}
+	if (rctx->zstd_dstream)
+		ZSTD_freeDStream(rctx->zstd_dstream);
+	if (rctx->zlib_stream) {
+		inflateEnd(rctx->zlib_stream);
+		free(rctx->zlib_stream);
+	}
 
 	return ret;
 }
@@ -1234,6 +1471,9 @@ static const char * const cmd_receive_usage[] = {
 	"-m ROOTMOUNT     the root mount point of the destination filesystem.",
 	"                 If /proc is not accessible, use this to tell us where",
 	"                 this file system is mounted.",
+	"--force-decompress",
+	"                 if the stream contains compressed data, always",
+	"                 decompress it instead of writing it with encoded I/O",
 	"--dump           dump stream metadata, one line per operation,",
 	"                 does not require the MOUNT parameter",
 	"-v               deprecated, alias for global -v option",
@@ -1277,12 +1517,16 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_DUMP = 257 };
+		enum {
+			GETOPT_VAL_DUMP = 257,
+			GETOPT_VAL_FORCE_DECOMPRESS,
+		};
 		static const struct option long_opts[] = {
 			{ "max-errors", required_argument, NULL, 'E' },
 			{ "chroot", no_argument, NULL, 'C' },
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
 			{ "quiet", no_argument, NULL, 'q' },
+			{ "force-decompress", no_argument, NULL, GETOPT_VAL_FORCE_DECOMPRESS },
 			{ NULL, 0, NULL, 0 }
 		};
 
@@ -1325,6 +1569,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_DUMP:
 			dump = 1;
 			break;
+		case GETOPT_VAL_FORCE_DECOMPRESS:
+			rctx.force_decompress = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
-- 
2.35.1

