Return-Path: <linux-btrfs+bounces-10742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80234A02763
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BB93A252B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31A1DD543;
	Mon,  6 Jan 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Mt0pnP1y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E41DE897
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172121; cv=none; b=HTP2zuLaAcvWsln5mrgg2SAR2gEAvVBcDTsnsrsnKpdWnVbEXSeQLa3eT6TZ5xDesL9dBlTTOsv2H1aQY5XrAFo/OI+TfWxVOFb1JSlWcTiejMCJbVtai3s6LfU3DxsS7JpvM2zyn/vHHiGZvrGqhTSG5kn5IUg9siIfIo5aiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172121; c=relaxed/simple;
	bh=o3H1x4Q5Xi8V5xSLYzaBelaOeikFpLwCebibEtqYS00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9khYfDmpzV8gxOvnxCTPLgktAFEZwMyYHg+rQjOBCI/idNZ9H1zQ7sTUqYGmtBMBJ0BN+0bBEdTO0881qGsjPhmtjGkpkZ+cw7q25NzWLWkNMsi/xYK/wFgU5jt2BqZ8NsSpmANzgmdNk8Cr66nXtIcOm8jnVS+gB5Qps4EZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=Mt0pnP1y; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506DifHo007625
	for <linux-btrfs@vger.kernel.org>; Mon, 6 Jan 2025 06:01:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=g
	kmB45qHAGRFPHsYQ7/cXZ5GwWJfjH/W88fr80aDp2Q=; b=Mt0pnP1yfXnBhzJCN
	gzpZw19D7aqHd6qTIZr5NH5T5nzz3rCn1xO0cnHTZQeP/hb2rUGdZRT8Ct9JL74i
	LYVtzkiLPp6vpZ7G212jNCjE6TQWTFewI/5YFnFNu5OmASSt23tX6xTpTF8ezgiG
	AkOWh1CPAbubv3Q5y7rhEG2HAw=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 440frbr8t4-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2025 06:01:52 -0800 (PST)
Received: from twshared11145.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 6 Jan 2025 14:01:51 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id BB909A39F443; Mon,  6 Jan 2025 14:01:47 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>, <linux-btrfs@vger.kernel.org>
CC: <neelx@suse.com>, <Johannes.Thumschirn@wdc.com>,
        Mark Harmstone
	<maharmstone@fb.com>
Subject: [PATCH v4 2/2] btrfs: add test for encoded reads
Date: Mon, 6 Jan 2025 14:01:34 +0000
Message-ID: <20250106140142.3140103-2-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250106140142.3140103-1-maharmstone@fb.com>
References: <20250106140142.3140103-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DQqCtCO1grVEabpzj_qj8unNfi7G6VO_
X-Proofpoint-GUID: DQqCtCO1grVEabpzj_qj8unNfi7G6VO_
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
This patch includes the miscellaneous fixes and formatting changes
suggested by Josef and Anand for version 3.

 .gitignore                |   2 +
 common/btrfs              |  32 ++++++
 m4/package_liburing.m4    |   2 +
 src/Makefile              |   1 +
 src/btrfs_encoded_read.c  | 195 +++++++++++++++++++++++++++++++
 src/btrfs_encoded_write.c | 226 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/333           | 233 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/333.out       |   2 +
 8 files changed, 693 insertions(+)
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
diff --git a/common/btrfs b/common/btrfs
index 95a9c8e6..46e5597b 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -1009,3 +1009,35 @@ _require_btrfs_raid_type()
 	_check_btrfs_raid_type $1 || \
 		_notrun "$1 isn't supported by the profile config or scratch device"
 }
+
+_require_btrfs_iouring_encoded_read()
+{
+	local fn
+	local tmpfile
+	local ret
+
+	_require_command src/btrfs_encoded_read
+
+	_scratch_mkfs &> /dev/null
+	_scratch_mount
+
+	fn=3D`mktemp -p $SCRATCH_MNT`
+	tmpfile=3D`mktemp`
+
+	src/btrfs_encoded_read io_uring $fn 0 > $tmpfile
+	ret=3D$?
+
+	_scratch_unmount
+
+	if [[ $ret -ne 0 ]]; then
+		rm $tmpfile
+		_fail "btrfs_encoded_read failed" >>$seqres.full
+	fi
+
+	read ret < $tmpfile
+	rm $tmpfile
+
+	if [[ $ret =3D=3D -95 ]]; then
+		_notrun "btrfs io_uring encoded read failed with -EOPNOTSUPP"
+	fi
+}
diff --git a/m4/package_liburing.m4 b/m4/package_liburing.m4
index 0553966d..7fbf4a5f 100644
--- a/m4/package_liburing.m4
+++ b/m4/package_liburing.m4
@@ -1,6 +1,8 @@
 AC_DEFUN([AC_PACKAGE_WANT_URING],
   [ PKG_CHECK_MODULES([LIBURING], [liburing],
     [ AC_DEFINE([HAVE_LIBURING], [1], [Use liburing])
+      AC_DEFINE_UNQUOTED([LIBURING_MAJOR_VERSION], [`$PKG_CONFIG --modve=
rsion liburing | cut -d. -f1`], [liburing major version])
+      AC_DEFINE_UNQUOTED([LIBURING_MINOR_VERSION], [`$PKG_CONFIG --modve=
rsion liburing | cut -d. -f2`], [liburing minor version])
       have_uring=3Dtrue
     ],
     [ have_uring=3Dfalse ])
diff --git a/src/Makefile b/src/Makefile
index a0396332..1417c383 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -76,6 +76,7 @@ LLDLIBS +=3D -laio
 endif
=20
 ifeq ($(HAVE_URING), true)
+LINUX_TARGETS +=3D btrfs_encoded_read btrfs_encoded_write
 TARGETS +=3D uring_read_fault
 LLDLIBS +=3D -luring
 endif
diff --git a/src/btrfs_encoded_read.c b/src/btrfs_encoded_read.c
new file mode 100644
index 00000000..3ee0d8b0
--- /dev/null
+++ b/src/btrfs_encoded_read.c
@@ -0,0 +1,195 @@
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
+#include <liburing.h>
+#include "config.h"
+
+/* IORING_OP_URING_CMD defined from liburing 2.2 onwards */
+#if LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION =3D=3D 2 && LI=
BURING_MINOR_VERSION < 2)
+#define IORING_OP_URING_CMD 46
+#endif
+
+#ifndef BTRFS_IOC_ENCODED_READ
+struct btrfs_ioctl_encoded_io_args {
+	const struct iovec *iov;
+	unsigned long iovcnt;
+	__s64 offset;
+	__u64 flags;
+	__u64 len;
+	__u64 unencoded_len;
+	__u64 unencoded_offset;
+	__u32 compression;
+	__u32 encryption;
+	__u8 reserved[64];
+};
+
+#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, struct btrfs_=
ioctl_encoded_io_args)
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
+
+	/* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
+#if LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION =3D=3D 2 && LI=
BURING_MINOR_VERSION < 3)
+	sqe->off =3D BTRFS_IOC_ENCODED_READ;
+#else
+	sqe->cmd_op =3D BTRFS_IOC_ENCODED_READ;
+#endif
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
index 00000000..7e46d9fe
--- /dev/null
+++ b/src/btrfs_encoded_write.c
@@ -0,0 +1,226 @@
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
+#include <liburing.h>
+#include "config.h"
+
+/* IORING_OP_URING_CMD defined from liburing 2.2 onwards */
+#if LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION =3D=3D 2 && LI=
BURING_MINOR_VERSION < 2)
+#define IORING_OP_URING_CMD 46
+#endif
+
+#ifndef BTRFS_IOC_ENCODED_WRITE
+struct btrfs_ioctl_encoded_io_args {
+	const struct iovec *iov;
+	unsigned long iovcnt;
+	__s64 offset;
+	__u64 flags;
+	__u64 len;
+	__u64 unencoded_len;
+	__u64 unencoded_offset;
+	__u32 compression;
+	__u32 encryption;
+	__u8 reserved[64];
+};
+
+#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, struct btrfs=
_ioctl_encoded_io_args)
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
+
+	/* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
+#if LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION =3D=3D 2 && LI=
BURING_MINOR_VERSION < 3)
+	sqe->off =3D BTRFS_IOC_ENCODED_WRITE;
+#else
+	sqe->cmd_op =3D BTRFS_IOC_ENCODED_WRITE;
+#endif
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
index 00000000..f5b1d09f
--- /dev/null
+++ b/tests/btrfs/333
@@ -0,0 +1,233 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Meta Platforms, Inc.  All Rights Reserved.
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
+_require_command src/btrfs_encoded_read
+_require_command src/btrfs_encoded_write
+_require_btrfs_iouring_encoded_read
+
+do_encoded_read()
+{
+	local fn=3D$1
+	local type=3D$2
+	local exp_ret=3D$3
+	local exp_len=3D$4
+	local exp_unencoded_len=3D$5
+	local exp_unencoded_offset=3D$6
+	local exp_compression=3D$7
+	local exp_md5=3D$8
+
+	local tmpfile=3D`mktemp`
+
+	echo "running btrfs_encoded_read $type $fn 0 > $tmpfile" >>$seqres.full
+	src/btrfs_encoded_read $type $fn 0 > $tmpfile
+
+	if [[ $? -ne 0 ]]; then
+		echo "btrfs_encoded_read failed" >>$seqres.full
+		rm $tmpfile
+		return 1
+	fi
+
+	exec {FD}< $tmpfile
+
+	read -u ${FD} ret
+
+	if [[ $ret =3D=3D -1 ]]; then
+	echo "btrfs encoded read failed with -EPERM; are you running as root?" =
\
+		>>$seqres.full
+		exec {FD}<&-
+		return 1
+	elif [[ $ret -lt 0 ]]; then
+		echo "btrfs encoded read failed (errno $ret)" >>$seqres.full
+		exec {FD}<&-
+		return 1
+	fi
+
+	local status=3D0
+
+	if [[ $ret -ne $exp_ret ]]; then
+	echo "$fn: btrfs encoded read returned $ret, expected $exp_ret" >> \
+		$seqres.full
+		status=3D1
+	fi
+
+	read -u ${FD} len
+	read -u ${FD} unencoded_len
+	read -u ${FD} unencoded_offset
+	read -u ${FD} compression
+	read -u ${FD} encryption
+
+	local filesize=3D`stat -c%s $tmpfile`
+	local datafile=3D`mktemp`
+
+	tail -c +$((1+$filesize-$ret)) $tmpfile > $datafile
+
+	exec {FD}<&-
+	rm $tmpfile
+
+	local md5=3D`md5sum $datafile | cut -d ' ' -f 1`
+	rm $datafile
+
+	if [[ $len -ne $exp_len ]]; then
+	echo "$fn: btrfs encoded read had len of $len, expected $exp_len" \
+		>>$seqres.full
+		status=3D1
+	fi
+
+	if [[ $unencoded_len -ne $exp_unencoded_len ]]; then
+echo "$fn: btrfs encoded read had unencoded_len of $unencoded_len, expec=
ted $exp_unencoded_len" \
+		>>$seqres.full
+		status=3D1
+	fi
+
+	if [[ $unencoded_offset -ne $exp_unencoded_offset ]]; then
+echo "$fn: btrfs encoded read had unencoded_offset of $unencoded_offset,=
 expected $exp_unencoded_offset" \
+		>>$seqres.full
+		status=3D1
+	fi
+
+	if [[ $compression -ne $exp_compression ]]; then
+echo "$fn: btrfs encoded read had compression of $compression, expected =
$exp_compression" \
+		>>$seqres.full
+		status=3D1
+	fi
+
+	if [[ $encryption -ne 0 ]]; then
+echo "$fn: btrfs encoded read had encryption of $encryption, expected 0"=
 \
+		>>$seqres.full
+		status=3D1
+	fi
+
+	if [[ $md5 !=3D $exp_md5 ]]; then
+	echo "$fn: data returned had hash of $md5, expected $exp_md5" \
+		>>$seqres.full
+		status=3D1
+	fi
+
+	return $status
+}
+
+do_encoded_write()
+{
+	local fn=3D$1
+	local exp_ret=3D$2
+	local len=3D$3
+	local unencoded_len=3D$4
+	local unencoded_offset=3D$5
+	local compression=3D$6
+	local data_file=3D$7
+
+	local tmpfile=3D`mktemp`
+
+echo "running btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unenc=
oded_offset $compression < $data_file > $tmpfile" \
+	>>$seqres.full
+	src/btrfs_encoded_write ioctl $fn 0 $len $unencoded_len \
+		$unencoded_offset $compression < $data_file > $tmpfile
+
+	if [[ $? -ne 0 ]]; then
+		echo "btrfs_encoded_write failed" >>$seqres.full
+		rm $tmpfile
+		return 1
+	fi
+
+	exec {FD}< $tmpfile
+
+	read -u ${FD} ret
+
+	if [[ $ret =3D=3D -1 ]]; then
+echo "btrfs encoded write failed with -EPERM; are you running as root?" =
\
+		>>$seqres.full
+		exec {FD}<&-
+		return 1
+	elif [[ $ret -lt 0 ]]; then
+		echo "btrfs encoded write failed (errno $ret)" >>$seqres.full
+		exec {FD}<&-
+		return 1
+	fi
+
+	exec {FD}<&-
+	rm $tmpfile
+
+	return 0
+}
+
+test_file()
+{
+	local size=3D$1
+	local len=3D$2
+	local unencoded_len=3D$3
+	local unencoded_offset=3D$4
+	local compression=3D$5
+
+	local tmpfile=3D`mktemp -p $SCRATCH_MNT`
+	local randfile=3D`mktemp`
+
+	dd if=3D/dev/urandom of=3D$randfile bs=3D$size count=3D1 status=3Dnone
+	local md5=3D`md5sum $randfile | cut -d ' ' -f 1`
+
+	do_encoded_write $tmpfile $size $len $unencoded_len $unencoded_offset \
+		$compression $randfile \
+		|| _fail "encoded write ioctl failed"
+
+	rm $randfile
+
+	do_encoded_read $tmpfile ioctl $size $len $unencoded_len \
+		$unencoded_offset $compression $md5 \
+		|| _fail "encoded read ioctl failed"
+	do_encoded_read $tmpfile io_uring $size $len $unencoded_len \
+		$unencoded_offset $compression $md5 \
+		|| _fail "encoded read io_uring failed"
+
+	rm $tmpfile
+}
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+sector_size=3D$(_scratch_btrfs_sectorsize)
+
+# force max_inline to be the default of 2048, so that our inline test fi=
les
+# do actually get created inline
+_scratch_mount "-o max_inline=3D2048"
+
+if [[ $sector_size -eq 4096 ]]; then
+	test_file 40960 97966 98304 0 1 # zlib
+	test_file 40960 97966 98304 0 2 # zstd
+	test_file 40960 97966 98304 0 3 # lzo 4k
+	test_file 40960 97966 110592 4096 1 # bookended zlib
+	test_file 40960 97966 110592 4096 2 # bookended zstd
+	test_file 40960 97966 110592 4096 3 # bookended lzo 4k
+elif [[ $sector_size -eq 65536 ]]; then
+	test_file 65536 97966 131072 0 1 # zlib
+	test_file 65536 97966 131072 0 2 # zstd
+	test_file 65536 97966 131072 0 7 # lzo 64k
+	# can't test bookended extents on 64k, as max is only 2 sectors long
+else
+	_notrun "sector size $sector_size not supported by this test"
+fi
+
+# btrfs won't create inline files unless PAGE_SIZE =3D=3D sector size
+if [[ "$(_get_page_size)" -eq $sector_size ]]; then
+	test_file 892 1931 1931 0 1 # inline zlib
+	test_file 892 1931 1931 0 2 # inline zstd
+
+	if [[ $sector_size -eq 4096 ]]; then
+		test_file 892 1931 1931 0 3 # inline lzo 4k
+	elif [[ $sector_size -eq 65536 ]]; then
+		test_file 892 1931 1931 0 7 # inline lzo 64k
+	fi
+fi
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


