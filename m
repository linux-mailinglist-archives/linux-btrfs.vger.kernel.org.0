Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C07454E67
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhKQUXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbhKQUXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:08 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC73C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:09 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so3852655qtj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=16AJr8eJMyUTL7KFAYHrcl6ITlDIzYBXKh9YST7ElNs=;
        b=ilOdJ4/XNqAEYFS+G+8HrEpzA78VwOGPpUGG8n7V73uuUB/l71ljlD9Hh+TzlsDdq9
         KROIkqYVZzCydCLBwegqSbsSWnD2SoZ5S+fTRRPyqFbV0o5BCdOuNaa3Wl+p7sN4BxQN
         xvCDEm35Vxe3mF3u5fGidtvxa4h2IoknWXFzeKlkd5yabEovY1Ww/ReczGk9qj92EvJ1
         2pHOTdDUO2AAYU1HXDyqkvZn5B4q3dwhstIAoEcH1ZBpds+hlt07KFS81EJQr59arjVf
         qN+HU7A0Tm31avioMcL+4sJZmWSBTkmMkChDCxpazDTKrTKK7KDGgobBeknpmkd2yqsx
         JyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=16AJr8eJMyUTL7KFAYHrcl6ITlDIzYBXKh9YST7ElNs=;
        b=qa67i0YBZly/FT6R3A98ksjW94Q7f/PD364T+mNaxGaMFXAuzT9Hm0REbdUUlTQUBp
         dyr4hla7R3CVQS5A9nbCIAIHTSfid+taSupBYqSQsnxwKpL5egE7tzwr6Llr4OAGcrwh
         TO2JRrNR9gRCv6BXW94AlCd/gW3F2m5Fv+7eBvo3IXqF9YDaBKMEx105ub/aZmt/q902
         jkbnfg9dCTd2uSGCnEQAf5e+oANW/SqMHVXB0G8u2/bJajawcZ6WpvmvdyOBjlmq23Kn
         WazNI0IT3/CoZqDViGtBR0yLLDRJ7uQoEsHaqDeQJ8cKV2OaheZbumLZy4ILeu9ooFmc
         VJpA==
X-Gm-Message-State: AOAM5337Goz730hdWxwTT/4sIVk5MTkdADrzSiS4ZOBRi00yKHh3RhGc
        9NS/lu7NErjhu0Kgvw6Jv6fJOham5bOtew==
X-Google-Smtp-Source: ABdhPJxUcRM3ShmqXu6S1Pau1Dlmfnh5sCJ7ECK0cwfJo+7KYuU3E+lYh00DKrDWqW98tnVtuHM1/Q==
X-Received: by 2002:a05:622a:40f:: with SMTP id n15mr20549510qtx.296.1637180408264;
        Wed, 17 Nov 2021 12:20:08 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:07 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 08/17] btrfs: add definitions + documentation for encoded I/O ioctls
Date:   Wed, 17 Nov 2021 12:19:18 -0800
Message-Id: <87e8a3e6268ad5115728ba5c8ef3a2387a0595b9.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In order to allow sending and receiving compressed data without
decompressing it, we need an interface to write pre-compressed data
directly to the filesystem and the matching interface to read compressed
data without decompressing it. This adds the definitions for ioctls to
do that and detailed explanations of how to use them.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/uapi/linux/btrfs.h | 132 +++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 738619994e26..7505acfa18d7 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -868,6 +868,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 		__u8 align[7];
 };
 
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
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -996,5 +1124,9 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				    struct btrfs_ioctl_encoded_io_args)
+#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				     struct btrfs_ioctl_encoded_io_args)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.34.0

