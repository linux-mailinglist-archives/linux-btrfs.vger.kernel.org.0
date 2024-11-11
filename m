Return-Path: <linux-btrfs+bounces-9430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F739C414C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 15:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509A828116E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296D1A0BE1;
	Mon, 11 Nov 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="auuSxge4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F511A0B0E
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336967; cv=none; b=o/50v3WSOZtYYg/8Csyb9Ijcekrt71IbO/DWHosQKAnG5BpuiQjM5oNv6WzhqC5mQdjpVXE8j08EN5Q4qX4/45vmqrqwNOnusyELRRUChG4eCvcyxZ81sQAeBKV4nNdouUVskoGUV/fAuE9l4hu4f2LUVkmJyn+kV9ByS/9i1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336967; c=relaxed/simple;
	bh=g+aLXkLbTLpeJf2hwS0MOSMeRqb+leEOZlJVSMmEU70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YRAD0qlTiNvlyoFnw7C4IZJXS99AVEcV1K2r7XEY51zWqcfmiTsqsHXZMdXFirlC0HkOlgMmJGOZAt6y/Ox5rvfX8RIMlFBt/+YIwkw4AKYSQcKWilP61XKvw4Tt+ZZx6GGIAU2E0TSvSIUcT2dxrvQt7L6qfMTUW5hcvgqKHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=auuSxge4; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABA7eWh012712
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 06:56:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=HQU9y8Sefx2pr1BHNJrOiwu
	1N5W6/mCkY8tcG5KJ6s0=; b=auuSxge4dcPan0yWH6iQ3wHfP+eeDw+QFjjbfra
	U65by7aRVoDXnrnICdaXaBMFh9+DodjgOKHSHlOXXLNMEiB5U7eINY0J3X5+Z9p4
	fRuB33ScXLX6/rf6h0gDSV0RmonNx34+5+qusc2u80WJYGxomkng7Y6fXlO3FJeD
	lpwQ=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ufw19e6d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 06:56:04 -0800 (PST)
Received: from twshared15700.17.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 11 Nov 2024 14:56:02 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 6853688EB48D; Mon, 11 Nov 2024 14:55:52 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>
CC: <linux-btrfs@vger.kernel.org>, Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: add test for encoded reads
Date: Mon, 11 Nov 2024 14:55:13 +0000
Message-ID: <20241111145547.3214398-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 46sCBXO_4r6cxrLCLP9JNukYIkREAjRz
X-Proofpoint-GUID: 46sCBXO_4r6cxrLCLP9JNukYIkREAjRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Add btrfs/333 and its helper programs btrfs_encoded_read and
btrfs_encoded_write, in order to test encoded reads.

We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
that it matches what we've written. If the new io_uring interface for
encoded reads is supported, we also check that that matches the ioctl.

Note that what we write isn't valid compressed data, so any non-encoded
reads on these files will fail.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 .gitignore                |   2 +
 src/Makefile              |   3 +-
 src/btrfs_encoded_read.c  | 175 ++++++++++++++++++++++++++++++
 src/btrfs_encoded_write.c | 206 +++++++++++++++++++++++++++++++++++
 tests/btrfs/333           | 220 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/333.out       |   2 +
 6 files changed, 607 insertions(+), 1 deletion(-)
 create mode 100644 src/btrfs_encoded_read.c
 create mode 100644 src/btrfs_encoded_write.c
 create mode 100755 tests/btrfs/333
 create mode 100644 tests/btrfs/333.out

diff --git a/.gitignore b/.gitignore
index f16173d9..efd47773 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,8 @@ tags
 /src/attr_replace_test
 /src/attr-list-by-handle-cursor-test
 /src/bstat
+/src/btrfs_encoded_read
+/src/btrfs_encoded_write
 /src/bulkstat_null_ocount
 /src/bulkstat_unlink_test
 /src/bulkstat_unlink_test_modified
diff --git a/src/Makefile b/src/Makefile
index a0396332..b42b8147 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,7 +34,8 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize pre=
allo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment
+	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment =
\
+	btrfs_encoded_read btrfs_encoded_write
=20
 EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/btrfs_encoded_read.c b/src/btrfs_encoded_read.c
new file mode 100644
index 00000000..a5082f70
--- /dev/null
+++ b/src/btrfs_encoded_read.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/uio.h>
+#include <sys/ioctl.h>
+#include <linux/btrfs.h>
+#include "config.h"
+
+#ifdef HAVE_LIBURING_H
+#include <liburing.h>
+#endif
+
+#define BTRFS_MAX_COMPRESSED 131072
+#define QUEUE_DEPTH 1
+
+static int encoded_read_ioctl(const char *filename, long long offset)
+{
+	int ret, fd;
+	char buf[BTRFS_MAX_COMPRESSED];
+	struct iovec iov;
+	struct btrfs_ioctl_encoded_io_args enc;
+
+	fd =3D open(filename, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "open failed for %s\n", filename);
+		return 1;
+	}
+
+	iov.iov_base =3D buf;
+	iov.iov_len =3D sizeof(buf);
+
+	enc.iov =3D &iov;
+	enc.iovcnt =3D 1;
+	enc.offset =3D offset;
+	enc.flags =3D 0;
+
+	ret =3D ioctl(fd, BTRFS_IOC_ENCODED_READ, &enc);
+
+	if (ret < 0) {
+		printf("%i\n", -errno);
+		close(fd);
+		return 0;
+	}
+
+	close(fd);
+
+	printf("%i\n", ret);
+	printf("%llu\n", enc.len);
+	printf("%llu\n", enc.unencoded_len);
+	printf("%llu\n", enc.unencoded_offset);
+	printf("%u\n", enc.compression);
+	printf("%u\n", enc.encryption);
+
+	fwrite(buf, ret, 1, stdout);
+
+	return 0;
+}
+
+static int encoded_read_io_uring(const char *filename, long long offset)
+{
+#ifdef HAVE_LIBURING_H
+	int ret, fd;
+	char buf[BTRFS_MAX_COMPRESSED];
+	struct iovec iov;
+	struct btrfs_ioctl_encoded_io_args enc;
+	struct io_uring ring;
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+
+	io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
+
+	fd =3D open(filename, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "open failed for %s\n", filename);
+		ret =3D 1;
+		goto out_uring;
+	}
+
+	iov.iov_base =3D buf;
+	iov.iov_len =3D sizeof(buf);
+
+	enc.iov =3D &iov;
+	enc.iovcnt =3D 1;
+	enc.offset =3D offset;
+	enc.flags =3D 0;
+
+	sqe =3D io_uring_get_sqe(&ring);
+	if (!sqe) {
+		fprintf(stderr, "io_uring_get_sqe failed\n");
+		ret =3D 1;
+		goto out_close;
+	}
+
+	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
+	sqe->cmd_op =3D BTRFS_IOC_ENCODED_READ;
+
+	io_uring_submit(&ring);
+
+	ret =3D io_uring_wait_cqe(&ring, &cqe);
+	if (ret < 0) {
+		fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
+		ret =3D 1;
+		goto out_close;
+	}
+
+	io_uring_cqe_seen(&ring, cqe);
+
+	if (cqe->res < 0) {
+		printf("%i\n", cqe->res);
+		ret =3D 0;
+		goto out_close;
+	}
+
+	printf("%i\n", cqe->res);
+	printf("%llu\n", enc.len);
+	printf("%llu\n", enc.unencoded_len);
+	printf("%llu\n", enc.unencoded_offset);
+	printf("%u\n", enc.compression);
+	printf("%u\n", enc.encryption);
+
+	fwrite(buf, cqe->res, 1, stdout);
+
+	ret =3D 0;
+
+out_close:
+	close(fd);
+
+out_uring:
+	io_uring_queue_exit(&ring);
+
+	return ret;
+#else
+	fprintf(stderr, "liburing not linked in\n");
+	return 1;
+#endif
+}
+
+static void usage()
+{
+	fprintf(stderr, "Usage: btrfs_encoded_read ioctl|io_uring filename offs=
et\n");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *filename;
+	long long offset;
+
+	if (argc !=3D 4) {
+		usage();
+		return 1;
+	}
+
+	filename =3D argv[2];
+
+	offset =3D atoll(argv[3]);
+	if (offset =3D=3D 0 && errno !=3D 0) {
+		usage();
+		return 1;
+	}
+
+	if (!strcmp(argv[1], "ioctl")) {
+		return encoded_read_ioctl(filename, offset);
+	} else if (!strcmp(argv[1], "io_uring")) {
+		return encoded_read_io_uring(filename, offset);
+	} else {
+		usage();
+		return 1;
+	}
+}
diff --git a/src/btrfs_encoded_write.c b/src/btrfs_encoded_write.c
new file mode 100644
index 00000000..dbb62722
--- /dev/null
+++ b/src/btrfs_encoded_write.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/uio.h>
+#include <sys/ioctl.h>
+#include <linux/btrfs.h>
+#include "config.h"
+
+#ifdef HAVE_LIBURING_H
+#include <liburing.h>
+#endif
+
+#define BTRFS_MAX_COMPRESSED 131072
+#define QUEUE_DEPTH 1
+
+static int encoded_write_ioctl(const char *filename, long long offset,
+			       long long len, long long unencoded_len,
+			       long long unencoded_offset, int compression,
+			       char *buf, size_t size)
+{
+	int ret, fd;
+	struct iovec iov;
+	struct btrfs_ioctl_encoded_io_args enc;
+
+	fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
+	if (fd < 0) {
+		fprintf(stderr, "open failed for %s\n", filename);
+		return 1;
+	}
+
+	iov.iov_base =3D buf;
+	iov.iov_len =3D size;
+
+	memset(&enc, 0, sizeof(enc));
+	enc.iov =3D &iov;
+	enc.iovcnt =3D 1;
+	enc.offset =3D offset;
+	enc.len =3D len;
+	enc.unencoded_len =3D unencoded_len;
+	enc.unencoded_offset =3D unencoded_offset;
+	enc.compression =3D compression;
+
+	ret =3D ioctl(fd, BTRFS_IOC_ENCODED_WRITE, &enc);
+
+	if (ret < 0) {
+		printf("%i\n", -errno);
+		close(fd);
+		return 0;
+	}
+
+	printf("%i\n", ret);
+
+	close(fd);
+
+	return 0;
+}
+
+static int encoded_write_io_uring(const char *filename, long long offset=
,
+				  long long len, long long unencoded_len,
+				  long long unencoded_offset, int compression,
+				  char *buf, size_t size)
+{
+#ifdef HAVE_LIBURING_H
+	int ret, fd;
+	struct iovec iov;
+	struct btrfs_ioctl_encoded_io_args enc;
+	struct io_uring ring;
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+
+	io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
+
+	fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
+	if (fd < 0) {
+		fprintf(stderr, "open failed for %s\n", filename);
+		ret =3D 1;
+		goto out_uring;
+	}
+
+	iov.iov_base =3D buf;
+	iov.iov_len =3D size;
+
+	memset(&enc, 0, sizeof(enc));
+	enc.iov =3D &iov;
+	enc.iovcnt =3D 1;
+	enc.offset =3D offset;
+	enc.len =3D len;
+	enc.unencoded_len =3D unencoded_len;
+	enc.unencoded_offset =3D unencoded_offset;
+	enc.compression =3D compression;
+
+	sqe =3D io_uring_get_sqe(&ring);
+	if (!sqe) {
+		fprintf(stderr, "io_uring_get_sqe failed\n");
+		ret =3D 1;
+		goto out_close;
+	}
+
+	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
+	sqe->cmd_op =3D BTRFS_IOC_ENCODED_WRITE;
+
+	io_uring_submit(&ring);
+
+	ret =3D io_uring_wait_cqe(&ring, &cqe);
+	if (ret < 0) {
+		fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
+		ret =3D 1;
+		goto out_close;
+	}
+
+	io_uring_cqe_seen(&ring, cqe);
+
+	if (cqe->res < 0) {
+		printf("%i\n", cqe->res);
+		ret =3D 0;
+		goto out_close;
+	}
+
+	printf("%i\n", cqe->res);
+
+	ret =3D 0;
+
+out_close:
+	close(fd);
+
+out_uring:
+	io_uring_queue_exit(&ring);
+
+	return ret;
+#else
+	fprintf(stderr, "liburing not linked in\n");
+	return 1;
+#endif
+}
+
+static void usage()
+{
+	fprintf(stderr, "Usage: btrfs_encoded_write ioctl|io_uring filename off=
set len unencoded_len unencoded_offset compression\n");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *filename;
+	long long offset, len, unencoded_len, unencoded_offset;
+	int compression;
+	char buf[BTRFS_MAX_COMPRESSED];
+	size_t size;
+
+	if (argc !=3D 8) {
+		usage();
+		return 1;
+	}
+
+	filename =3D argv[2];
+
+	offset =3D atoll(argv[3]);
+	if (offset =3D=3D 0 && errno !=3D 0) {
+		usage();
+		return 1;
+	}
+
+	len =3D atoll(argv[4]);
+	if (len =3D=3D 0 && errno !=3D 0) {
+		usage();
+		return 1;
+	}
+
+	unencoded_len =3D atoll(argv[5]);
+	if (unencoded_len =3D=3D 0 && errno !=3D 0) {
+		usage();
+		return 1;
+	}
+
+	unencoded_offset =3D atoll(argv[6]);
+	if (unencoded_offset =3D=3D 0 && errno !=3D 0) {
+		usage();
+		return 1;
+	}
+
+	compression =3D atoi(argv[7]);
+	if (compression =3D=3D 0 && errno !=3D 0) {
+		usage();
+		return 1;
+	}
+
+	size =3D fread(buf, 1, BTRFS_MAX_COMPRESSED, stdin);
+
+	if (!strcmp(argv[1], "ioctl")) {
+		return encoded_write_ioctl(filename, offset, len, unencoded_len,
+					   unencoded_offset, compression, buf,
+					   size);
+	} else if (!strcmp(argv[1], "io_uring")) {
+		return encoded_write_io_uring(filename, offset, len,
+					      unencoded_len, unencoded_offset,
+					      compression, buf, size);
+	} else {
+		usage();
+		return 1;
+	}
+}
diff --git a/tests/btrfs/333 b/tests/btrfs/333
new file mode 100755
index 00000000..8e4de4c0
--- /dev/null
+++ b/tests/btrfs/333
@@ -0,0 +1,220 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test No. btrfs/333
+#
+# Test btrfs encoded reads
+
+. ./common/preamble
+_begin_fstest auto quick compress rw
+
+. ./common/filter
+. ./common/btrfs
+
+_supported_fs btrfs
+
+do_encoded_read() {
+    local fn=3D$1
+    local type=3D$2
+    local exp_ret=3D$3
+    local exp_len=3D$4
+    local exp_unencoded_len=3D$5
+    local exp_unencoded_offset=3D$6
+    local exp_compression=3D$7
+    local exp_md5=3D$8
+
+    local tmpfile=3D`mktemp`
+
+    echo "running btrfs_encoded_read $type $fn 0 > $tmpfile" >>$seqres.f=
ull
+    src/btrfs_encoded_read $type $fn 0 > $tmpfile
+
+    if [[ $? -ne 0 ]]; then
+        echo "btrfs_encoded_read failed" >>$seqres.full
+        rm $tmpfile
+        return 1
+    fi
+
+    exec {FD}< $tmpfile
+
+    read -u ${FD} ret
+
+    if [[ $ret =3D=3D -95 && $type -eq "io_uring" ]]; then
+        echo "btrfs io_uring encoded read failed with -EOPNOTSUPP, skipp=
ing" >>$seqres.full
+        exec {FD}<&-
+        return 1
+    fi
+
+    if [[ $ret -lt 0 ]]; then
+        if [[ $ret =3D=3D -1 ]]; then
+            echo "btrfs encoded read failed with -EPERM; are you running=
 as root?" >>$seqres.full
+        else
+            echo "btrfs encoded read failed (errno $ret)" >>$seqres.full
+        fi
+        exec {FD}<&-
+        return 1
+    fi
+
+    local status=3D0
+
+    if [[ $ret -ne $exp_ret ]]; then
+        echo "$fn: btrfs encoded read returned $ret, expected $exp_ret" =
>>$seqres.full
+        status=3D1
+    fi
+
+    read -u ${FD} len
+    read -u ${FD} unencoded_len
+    read -u ${FD} unencoded_offset
+    read -u ${FD} compression
+    read -u ${FD} encryption
+
+    local filesize=3D`stat -c%s $tmpfile`
+    local datafile=3D`mktemp`
+
+    dd if=3D$tmpfile of=3D$datafile bs=3D1 count=3D$ret skip=3D$(($files=
ize-$ret)) status=3Dnone
+
+    exec {FD}<&-
+    rm $tmpfile
+
+    local md5=3D`md5sum $datafile | cut -d ' ' -f 1`
+    rm $datafile
+
+    if [[ $len -ne $exp_len ]]; then
+        echo "$fn: btrfs encoded read had len of $len, expected $exp_len=
" >>$seqres.full
+        status=3D1
+    fi
+
+    if [[ $unencoded_len -ne $exp_unencoded_len ]]; then
+        echo "$fn: btrfs encoded read had unencoded_len of $unencoded_le=
n, expected $exp_unencoded_len" >>$seqres.full
+        status=3D1
+    fi
+
+    if [[ $unencoded_offset -ne $exp_unencoded_offset ]]; then
+        echo "$fn: btrfs encoded read had unencoded_offset of $unencoded=
_offset, expected $exp_unencoded_offset" >>$seqres.full
+        status=3D1
+    fi
+
+    if [[ $compression -ne $exp_compression ]]; then
+        echo "$fn: btrfs encoded read had compression of $compression, e=
xpected $exp_compression" >>$seqres.full
+        status=3D1
+    fi
+
+    if [[ $encryption -ne 0 ]]; then
+        echo "$fn: btrfs encoded read had encryption of $encryption, exp=
ected 0" >>$seqres.full
+        status=3D1
+    fi
+
+    if [[ $md5 !=3D $exp_md5 ]]; then
+        echo "$fn: data returned had hash of $md5, expected $exp_md5" >>=
$seqres.full
+        status=3D1
+    fi
+
+    return $status
+}
+
+do_encoded_write() {
+    local fn=3D$1
+    local exp_ret=3D$2
+    local len=3D$3
+    local unencoded_len=3D$4
+    local unencoded_offset=3D$5
+    local compression=3D$6
+    local data_file=3D$7
+
+    local tmpfile=3D`mktemp`
+
+    echo "running btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $u=
nencoded_offset $compression < $data_file > $tmpfile" >>$seqres.full
+    src/btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unencoded_o=
ffset $compression < $data_file > $tmpfile
+
+    if [[ $? -ne 0 ]]; then
+        echo "btrfs_encoded_write failed" >>$seqres.full
+        rm $tmpfile
+        return 1
+    fi
+
+    exec {FD}< $tmpfile
+
+    read -u ${FD} ret
+
+    if [[ $ret -lt 0 ]]; then
+        if [[ $ret =3D=3D -1 ]]; then
+            echo "btrfs encoded write failed with -EPERM; are you runnin=
g as root?" >>$seqres.full
+        else
+            echo "btrfs encoded write failed (errno $ret)" >>$seqres.ful=
l
+        fi
+        exec {FD}<&-
+        return 1
+    fi
+
+    exec {FD}<&-
+    rm $tmpfile
+
+    return 0
+}
+
+test_file() {
+    local size=3D$1
+    local len=3D$2
+    local unencoded_len=3D$3
+    local unencoded_offset=3D$4
+    local compression=3D$5
+
+    local tmpfile=3D`mktemp -p $SCRATCH_MNT`
+    local randfile=3D`mktemp`
+
+    dd if=3D/dev/urandom of=3D$randfile bs=3D1 count=3D$size status=3Dno=
ne
+    local md5=3D`md5sum $randfile | cut -d ' ' -f 1`
+
+    do_encoded_write $tmpfile $size $len $unencoded_len $unencoded_offse=
t \
+        $compression $randfile || _fail "encoded write ioctl failed"
+
+    rm $randfile
+
+    do_encoded_read $tmpfile ioctl $size $len $unencoded_len \
+        $unencoded_offset $compression $md5 || _fail "encoded read ioctl=
 failed"
+    do_encoded_read $tmpfile io_uring $size $len $unencoded_len \
+        $unencoded_offset $compression $md5 || _fail "encoded read io_ur=
ing failed"
+
+    rm $tmpfile
+}
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+sector_size=3D$(_scratch_btrfs_sectorsize)
+
+if [[ $sector_size -ne 4096 && $sector_size -ne 65536 ]]; then
+    _notrun "sector size $sector_size not supported by this test"
+fi
+
+_scratch_mount "-o max_inline=3D2048"
+
+if [[ $sector_size -eq 4096 ]]; then
+    test_file 40960 97966 98304 0 1 # zlib
+    test_file 40960 97966 98304 0 2 # zstd
+    test_file 40960 97966 98304 0 3 # lzo 4k
+    test_file 40960 97966 110592 4096 1 # bookended zlib
+    test_file 40960 97966 110592 4096 2 # bookended zstd
+    test_file 40960 97966 110592 4096 3 # bookended lzo 4k
+elif [[ $sector_size -eq 65536 ]]; then
+    test_file 65536 97966 131072 0 1 # zlib
+    test_file 65536 97966 131072 0 2 # zstd
+    test_file 65536 97966 131072 0 7 # lzo 64k
+    # can't test bookended extents on 64k, as max is only 2 sectors long
+fi
+
+# btrfs won't create inline files unless PAGE_SIZE =3D=3D sector size
+if [[ "$(_get_page_size)" -eq $sector_size ]]; then
+    test_file 892 1931 1931 0 1 # inline zlib
+    test_file 892 1931 1931 0 2 # inline zstd
+
+    if [[ $sector_size -eq 4096 ]]; then
+        test_file 892 1931 1931 0 3 # inline lzo 4k
+    elif [[ $sector_size -eq 65536 ]]; then
+        test_file 892 1931 1931 0 7 # inline lzo 64k
+    fi
+fi
+
+_scratch_unmount
+
+echo Silence is golden
+status=3D0
+exit
diff --git a/tests/btrfs/333.out b/tests/btrfs/333.out
new file mode 100644
index 00000000..60a15898
--- /dev/null
+++ b/tests/btrfs/333.out
@@ -0,0 +1,2 @@
+QA output created by 333
+Silence is golden
--=20
2.45.2


