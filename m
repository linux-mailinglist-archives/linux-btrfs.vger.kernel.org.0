Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E563E5835C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiG0XsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 19:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiG0XsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 19:48:12 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6F65A3E2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 16:48:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AF665C0098;
        Wed, 27 Jul 2022 19:48:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Jul 2022 19:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1658965691; x=1659052091; bh=43eFHW2jGhHAmbBqVMpOm56Uk
        o1yE/LsVWkP/Z9P06I=; b=kupqMewl4xa3bIXlIuBVs5JrjjFiSlgWIDaP7/wTS
        2/OX8Ewal9XMSBDdhKa37YrpCLCSgcfMm55JJlYXfMXkNSfC6Tbw/KbIeF3ixhtk
        KPBXtitoZNRpAdlDbYSUK4jihZSeLu3NBazzHrXFWEQY75gGPXgv3D+xMGQrVtuA
        9z/et2rOQpSW+WeDK/3If4fquvikBJO/D+wzIW4K5Je3/8F5aT1YA6hAfIxkVFJS
        DQdahkgKfpkDNBIngJa9901HVcE5N6yqlYush32TT67r/loi95ft6DX7/D9shwWw
        x93sdi6Kdx/AjkkUeiYCXl+thvRkHB8g4KomuAzzOcSsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1658965691; x=1659052091; bh=43eFHW2jGhHAmbBqVMpOm56Uko1yE/LsVWk
        P/Z9P06I=; b=HLqIt6V0ABLlQpz6vOvV9zkI1em3QSNxsB0D/iY1LlTw4l9E4pj
        BARXuedJPkINjNBiY4F7QbXFO3cyAS4X896S7vEaCgx/dte6d9DQf5EqPE2nH43A
        4VpgPahqMu5t53rznb5Bj63OXdeA/bW30+QWk20+RoMhrLozVLv5LexJ2XRkhFhp
        iyD6Dk766iMFRsStMNCmGIPc/1jtMhl2JocLy9AbnzTzKrRHCuectNJPToHzAfyv
        puSTdGwHtdwXKlruEj9cMMMoApG5jO0O7XG6Vqse0ipYZXCUQ3fGdLK3MzQLJPgw
        vgdAwDH+hmhBla4ye1fPsrZZPlISLk9ADZA==
X-ME-Sender: <xms:us7hYjLJTHUsm4oQmSNW_zcamVh-UFMKR7TMgPRZqs7MVWxmak0fmA>
    <xme:us7hYnKyggwFFSKvXN4uLLZsTqEV04Q7YbhiNsMk8Lq82J4KCtqu3cPzW8O_A_sXI
    cf1gBXMQcDwLE6ZWs8>
X-ME-Received: <xmr:us7hYru-cBQhTLhsPgTd7fCx-RswuJbOrj777mYzCx_jVYvzrhOw6AKe6UWVJfJm5uUKgp1EPjL3GONi8NdO5K8_ILV5YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddufedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:us7hYsajpEJEOha1m8o1b_OS8jgOzzr_Z5SvbLbbuqzX73U9LcqPJw>
    <xmx:us7hYqZjCTYQ3YLS-NyTEVKSCA4vC4fZBLImTUwQ5KQsUcks7sAiFg>
    <xmx:us7hYgAudcMVbUlF7aAj6zIE3e4NvoUbh3ZkVxGQmVeTvMkVnfys1g>
    <xmx:u87hYjDYUodr8l2p_rGevg0dtWiiZYSmP0lP1vCReuF-eHChLe0oIQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 19:48:10 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: receive: add support for fs-verity
Date:   Wed, 27 Jul 2022 16:48:21 -0700
Message-Id: <0854817808a21d1f54910a33c966584c17147893.1658965607.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Process an enable_verity cmd by running the enable verity ioctl on the
file. Since enabling verity denies write access to the file, it is
important that we don't have any open write file descriptors.

This also revs the send stream format to version 3 with no format
changes besides the new commands and attributes.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  | 10 +++++
 cmds/receive.c       | 52 ++++++++++++++++++++++++
 common/send-stream.c | 16 ++++++++
 common/send-stream.h |  3 ++
 fsverity.h           | 94 ++++++++++++++++++++++++++++++++++++++++++++
 kernel-shared/send.h | 13 +++++-
 6 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 fsverity.h

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 92e0a4c9a..5d68ecbca 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -344,6 +344,15 @@ static int print_fileattr(const char *path, u64 attr, void *user)
 	return PRINT_DUMP(user, path, "fileattr", "fileattr=0x%llu", attr);
 }
 
+static int print_enable_verity (const char *path, u8 algorithm, u32 block_size,
+				int salt_len, char *salt,
+				int sig_len, char *sig, void *user)
+{
+	return PRINT_DUMP(user, path, "enable_verity",
+			  "algorithm=%u block_size=%u salt_len=%d sig_len=%d",
+			  algorithm, block_size, salt_len, sig_len);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -369,4 +378,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.encoded_write = print_encoded_write,
 	.fallocate = print_fallocate,
 	.fileattr = print_fileattr,
+	.enable_verity = print_enable_verity,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index aec324587..8ff5e3b10 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -63,6 +63,8 @@
 #include "common/path-utils.h"
 #include "stubs.h"
 
+#include "fsverity.h"
+
 struct btrfs_receive
 {
 	int mnt_fd;
@@ -1333,6 +1335,55 @@ static int process_fileattr(const char *path, u64 attr, void *user)
 	return 0;
 }
 
+static int process_enable_verity(const char *path, u8 algorithm, u32 block_size,
+				 int salt_len, char *salt,
+				 int sig_len, char *sig, void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+	struct fsverity_enable_arg verity_args = {
+		.version = 1,
+		.hash_algorithm = algorithm,
+		.block_size = block_size,
+	};
+	if (salt_len) {
+		verity_args.salt_size = salt_len;
+		verity_args.salt_ptr = (__u64)salt;
+	}
+	if (sig_len) {
+		verity_args.sig_size = sig_len;
+		verity_args.sig_ptr = (__u64)sig;
+	}
+	int ioctl_fd;
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("write: path invalid: %s", path);
+		goto out;
+	}
+
+	ioctl_fd = open(full_path, O_RDONLY);
+	if (ioctl_fd < 0) {
+		ret = -errno;
+		error("cannot open %s for verity ioctl: %m", full_path);
+		goto out;
+	}
+
+	/*
+	 * Enabling verity denies write access, so it cannot be done with an
+	 * open writeable file descriptor.
+	 */
+	close_inode_for_write(rctx);
+	ret = ioctl(ioctl_fd, FS_IOC_ENABLE_VERITY, &verity_args);
+	if (ret < 0)
+		fprintf(stderr, "Failed to enable verity on %s: %d\n", full_path, ret);
+
+	close(ioctl_fd);
+out:
+	return ret;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1358,6 +1409,7 @@ static struct btrfs_send_ops send_ops = {
 	.encoded_write = process_encoded_write,
 	.fallocate = process_fallocate,
 	.fileattr = process_fileattr,
+	.enable_verity = process_enable_verity,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index 96d1aa218..1a0c0a5b0 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -353,6 +353,12 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	char *xattr_name = NULL;
 	void *xattr_data = NULL;
 	void *data = NULL;
+	u8 verity_algorithm;
+	u32 verity_block_size;
+	int verity_salt_len;
+	void *verity_salt = NULL;
+	int verity_sig_len;
+	void *verity_sig = NULL;
 	struct timespec at;
 	struct timespec ct;
 	struct timespec mt;
@@ -537,6 +543,16 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 		TLV_GET_U64(sctx, BTRFS_SEND_A_SIZE, &tmp);
 		ret = sctx->ops->update_extent(path, offset, tmp, sctx->user);
 		break;
+	case BTRFS_SEND_C_ENABLE_VERITY:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U8(sctx, BTRFS_SEND_A_VERITY_ALGORITHM, &verity_algorithm);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_VERITY_BLOCK_SIZE, &verity_block_size);
+		TLV_GET(sctx, BTRFS_SEND_A_VERITY_SALT_DATA, &verity_salt, &verity_salt_len);
+		TLV_GET(sctx, BTRFS_SEND_A_VERITY_SIG_DATA, &verity_sig, &verity_sig_len);
+		ret = sctx->ops->enable_verity(path, verity_algorithm, verity_block_size,
+					       verity_salt_len, verity_salt,
+					       verity_sig_len, verity_sig, sctx->user);
+		break;
 	case BTRFS_SEND_C_END:
 		ret = 1;
 		break;
diff --git a/common/send-stream.h b/common/send-stream.h
index b5973b66f..6649b55b9 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -60,6 +60,9 @@ struct btrfs_send_ops {
 	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
 			 void *user);
 	int (*fileattr)(const char *path, u64 attr, void *user);
+	int (*enable_verity)(const char *path, u8 algorithm, u32 block_size,
+			     int salt_len, char *salt,
+			     int sig_len, char *sig, void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
diff --git a/fsverity.h b/fsverity.h
new file mode 100644
index 000000000..291ab4db9
--- /dev/null
+++ b/fsverity.h
@@ -0,0 +1,94 @@
+#ifndef _UAPI_LINUX_FSVERITY_H
+#define _UAPI_LINUX_FSVERITY_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define FS_VERITY_HASH_ALG_SHA256	1
+#define FS_VERITY_HASH_ALG_SHA512	2
+
+struct fsverity_enable_arg {
+	__u32 version;
+	__u32 hash_algorithm;
+	__u32 block_size;
+	__u32 salt_size;
+	__u64 salt_ptr;
+	__u32 sig_size;
+	__u32 __reserved1;
+	__u64 sig_ptr;
+	__u64 __reserved2[11];
+};
+
+struct fsverity_digest {
+	__u16 digest_algorithm;
+	__u16 digest_size; /* input/output */
+	__u8 digest[];
+};
+
+/*
+ * Struct containing a file's Merkle tree properties.  The fs-verity file digest
+ * is the hash of this struct.  A userspace program needs this struct only if it
+ * needs to compute fs-verity file digests itself, e.g. in order to sign files.
+ * It isn't needed just to enable fs-verity on a file.
+ *
+ * Note: when computing the file digest, 'sig_size' and 'signature' must be left
+ * zero and empty, respectively.  These fields are present only because some
+ * filesystems reuse this struct as part of their on-disk format.
+ */
+struct fsverity_descriptor {
+	__u8 version;		/* must be 1 */
+	__u8 hash_algorithm;	/* Merkle tree hash algorithm */
+	__u8 log_blocksize;	/* log2 of size of data and tree blocks */
+	__u8 salt_size;		/* size of salt in bytes; 0 if none */
+#ifdef __KERNEL__
+	__le32 sig_size;
+#else
+	__le32 __reserved_0x04;	/* must be 0 */
+#endif
+	__le64 data_size;	/* size of file the Merkle tree is built over */
+	__u8 root_hash[64];	/* Merkle tree root hash */
+	__u8 salt[32];		/* salt prepended to each hashed block */
+	__u8 __reserved[144];	/* must be 0's */
+#ifdef __KERNEL__
+	__u8 signature[];
+#endif
+};
+
+/*
+ * Format in which fs-verity file digests are signed in built-in signatures.
+ * This is the same as 'struct fsverity_digest', except here some magic bytes
+ * are prepended to provide some context about what is being signed in case the
+ * same key is used for non-fsverity purposes, and here the fields have fixed
+ * endianness.
+ *
+ * This struct is specific to the built-in signature verification support, which
+ * is optional.  fs-verity users may also verify signatures in userspace, in
+ * which case userspace is responsible for deciding on what bytes are signed.
+ * This struct may still be used, but it doesn't have to be.  For example,
+ * userspace could instead use a string like "sha256:$digest_as_hex_string".
+ */
+struct fsverity_formatted_digest {
+	char magic[8];			/* must be "FSVerity" */
+	__le16 digest_algorithm;
+	__le16 digest_size;
+	__u8 digest[];
+};
+
+#define FS_VERITY_METADATA_TYPE_MERKLE_TREE	1
+#define FS_VERITY_METADATA_TYPE_DESCRIPTOR	2
+#define FS_VERITY_METADATA_TYPE_SIGNATURE	3
+
+struct fsverity_read_metadata_arg {
+	__u64 metadata_type;
+	__u64 offset;
+	__u64 length;
+	__u64 buf_ptr;
+	__u64 __reserved;
+};
+
+#define FS_IOC_ENABLE_VERITY	_IOW('f', 133, struct fsverity_enable_arg)
+#define FS_IOC_MEASURE_VERITY	_IOWR('f', 134, struct fsverity_digest)
+#define FS_IOC_READ_VERITY_METADATA \
+	_IOWR('f', 135, struct fsverity_read_metadata_arg)
+
+#endif /* _UAPI_LINUX_FSVERITY_H */
diff --git a/kernel-shared/send.h b/kernel-shared/send.h
index 0236d9fd8..db1bec19f 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -102,8 +102,10 @@ enum btrfs_send_cmd {
 	BTRFS_SEND_C_ENCODED_WRITE	= 25,
 	BTRFS_SEND_C_MAX_V2		= 25,
 
+	BTRFS_SEND_C_ENABLE_VERITY	= 26,
+	BTRFS_SEND_C_MAX_V3		= 26,
 	/* End */
-	BTRFS_SEND_C_MAX		= 25,
+	BTRFS_SEND_C_MAX		= 26,
 };
 
 /* attributes in send stream */
@@ -170,8 +172,15 @@ enum {
 	BTRFS_SEND_A_ENCRYPTION		= 31,
 	BTRFS_SEND_A_MAX_V2		= 31,
 
+	/* Version 3 */
+	BTRFS_SEND_A_VERITY_ALGORITHM	= 32,
+	BTRFS_SEND_A_VERITY_BLOCK_SIZE	= 33,
+	BTRFS_SEND_A_VERITY_SALT_DATA	= 34,
+	BTRFS_SEND_A_VERITY_SIG_DATA	= 35,
+	BTRFS_SEND_A_MAX_V3		= 35,
+
 	/* End */
-	BTRFS_SEND_A_MAX		= 31,
+	BTRFS_SEND_A_MAX		= 35,
 };
 
 #endif
-- 
2.37.1

