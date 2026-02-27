Return-Path: <linux-btrfs+bounces-22041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBagEKLhoGk4nwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22041-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:13:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B631B129C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AAAE3070B1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 00:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C81F1513;
	Fri, 27 Feb 2026 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQzsGscg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8801D5CDE;
	Fri, 27 Feb 2026 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151130; cv=none; b=NmQQ3SNZdo8+VHkUGjciPJxcw515xGov1dJDOz48Z15y75DtMOsUJV1vuxoo+pjbSGVmQzh2nKxKt3svjhmI3hgncp+lIzB7lqo5OKUGGiiul3M7cfliSFpVxUWD+ax7bs3YMrvIK/ibcpkIvItdhmnHj6NRJcR9tXI+uKsMsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151130; c=relaxed/simple;
	bh=u2Xwmug/8GVB1Rpy+IUtv4Yfybb1jbyZ5A2I+YnE2fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TW6XkU76FxqD704cI0kHuK1/SQb/VUshlB1GnOY/FPpTCcbtBxI4IVdfDvqhf7pbganbbK8Fz6qRWaQP/9YyPMlRWzMq+OMGbwz93OOVXXpCqRE4wtfWNmJXdKQc1+UNM5J6cICVMrpSbKm5hCvgKbLr+36aJuB8thNXyj/+Yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQzsGscg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F24C116C6;
	Fri, 27 Feb 2026 00:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772151129;
	bh=u2Xwmug/8GVB1Rpy+IUtv4Yfybb1jbyZ5A2I+YnE2fA=;
	h=From:To:Cc:Subject:Date:From;
	b=VQzsGscgqPPB4q9YeETiN3kHDl3iSUrBngs60s4ye+4Bp0qGydz/myhG8cHiajm+W
	 pwN0+n2XzmoylWElVC2OD6TtohGXuReNG/ka0rwn9AfIn1AWkJfUqtrDmwqALy5Z4v
	 gmX/gHHveWWJxPfDIpRUPLTOlJcX43NswKAklzAmqLkdQeth27/1PUkUv3mSDXR4Fl
	 eymIvWyGHvM9MkeBH9zEEo+Jo57o7Y5p2NpyN5xUSJ3BO1/HNxa9KP124JFpVuzoBY
	 iyo5YRI3htTIVB5dDx5JyaxAlbKuVA5qM5jF8pAnCbpG8j/CT1kEiim6qySAOQrn4t
	 xvO7WcUqxf3PA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test setting the same received UUID to a lot of subvolumes
Date: Fri, 27 Feb 2026 00:12:05 +0000
Message-ID: <6f697483d00fc7a001f2ce752a545d525cf2929c.1772151075.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22041-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98B631B129C
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Test that using the received subvol ioctl to set a received UUID on a root
does not trigger a transaction abort (and turn the filesystem to RO mode)
if a user abuses by assigning the same received UUID to a large number of
subvolumes.

This exercises a bug fixed by the following kernel patch:

 "btrfs: fix transaction abort on set received ioctl due to item overflow"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 .gitignore                        |  1 +
 configure.ac                      |  4 ++
 src/Makefile                      |  4 ++
 src/t_btrfs_received_uuid_ioctl.c | 50 +++++++++++++++++++++++
 tests/btrfs/347                   | 66 +++++++++++++++++++++++++++++++
 tests/btrfs/347.out               |  3 ++
 6 files changed, 128 insertions(+)
 create mode 100644 src/t_btrfs_received_uuid_ioctl.c
 create mode 100755 tests/btrfs/347
 create mode 100644 tests/btrfs/347.out

diff --git a/.gitignore b/.gitignore
index 2b5bedd5..0819d3c5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -213,6 +213,7 @@ tags
 /src/unlink-fsync
 /src/file_attr
 /src/truncate
+/src/t_btrfs_received_uuid_ioctl
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/configure.ac b/configure.ac
index f7519fa9..441f543c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -106,6 +106,10 @@ AC_CHECK_TYPES([struct btrfs_ioctl_get_subvol_rootref_args], [], [], [[
 #include <stddef.h>
 #include <linux/btrfs.h>
 ]])
+AC_CHECK_TYPES([struct btrfs_ioctl_received_subvol_args], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
 AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
 AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
 #include <stddef.h>
diff --git a/src/Makefile b/src/Makefile
index 577d816a..cc4efad4 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -107,6 +107,10 @@ ifeq ($(HAVE_FICLONE),yes)
      TARGETS += t_reflink_read_race
 endif
 
+ifeq ($(HAVE_LIBBTRFSUTIL), true)
+     LINUX_TARGETS += t_btrfs_received_uuid_ioctl
+endif
+
 ifeq ($(NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE),yes)
 LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
 endif
diff --git a/src/t_btrfs_received_uuid_ioctl.c b/src/t_btrfs_received_uuid_ioctl.c
new file mode 100644
index 00000000..bd058278
--- /dev/null
+++ b/src/t_btrfs_received_uuid_ioctl.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Program to set a received UUID on a btrfs subvolume.
+ */
+
+#include <sys/ioctl.h>
+#include <btrfs/ioctl.h>
+#include <uuid/uuid.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+int main(int argc, char **argv)
+{
+	struct btrfs_ioctl_received_subvol_args args;
+	uuid_t uuid;
+	int ret;
+	int fd;
+
+	if (argc != 3) {
+		fprintf(stderr, "Use: %s <uuid> <subvolume path>\n", argv[0]);
+		return 1;
+	}
+
+	ret = uuid_parse(argv[1], uuid);
+	if (ret == -1) {
+		fprintf(stderr,
+	"Invalid UUID. Example: 8c628557-6987-42b2-ba16-b7cc79ddfb43\n");
+		return 2;
+	}
+
+	fd = open(argv[2], O_RDONLY | O_DIRECTORY, 0666);
+	if (fd == -1) {
+		perror("Failed to open fd");
+		return 3;
+	}
+
+	memset(&args, 0, sizeof(args));
+	memcpy(args.uuid, uuid, BTRFS_UUID_SIZE);
+
+	ret = ioctl(fd, BTRFS_IOC_SET_RECEIVED_SUBVOL, &args);
+	if (ret == -1) {
+		perror("Failed to set received subvol");
+		return 4;
+	}
+
+	return 0;
+}
diff --git a/tests/btrfs/347 b/tests/btrfs/347
new file mode 100755
index 00000000..ebd53d97
--- /dev/null
+++ b/tests/btrfs/347
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 347
+#
+# Test that using the received subvol ioctl to set a received UUID on a root
+# does not trigger a transaction abort (and turn the filesystem to RO mode) if
+# a user abuses by assigning the same received UUID to a large number of
+# subvolumes.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol
+
+_require_test_program t_btrfs_received_uuid_ioctl
+_require_scratch
+_require_btrfs_support_sectorsize 4096
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix transaction abort on set received ioctl due to item overflow"
+
+# Use a 4K node/leaf size to make the test faster.
+_scratch_mkfs -n 4K >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# With a leaf size of 4K, we can get a BTRFS_UUID_KEY_RECEIVED_SUBVOL key with
+# maximum number of 496 root IDs (u64 values).
+#
+# We have:
+#
+#  total item size = sizeof(struct btrfs_item) + sizeof(u64) * 496
+#                  = 25 + 8 * 496 = 3993
+#
+#  BTRFS_LEAF_DATA_SIZE = leafsize - sizeof(struct btrfs_header)
+#                       = 4096 - 101 = 3995
+#
+# So 497 root IDs would be 3993 + 8 = 4001 which is > BTRFS_LEAF_DATA_SIZE.
+num_subvols=496
+
+for ((i = 1; i <= $num_subvols; i++)); do
+	_btrfs subvolume create $SCRATCH_MNT/sv_$i
+done
+
+for ((i = 1; i <= $num_subvols; i++)); do
+	$here/src/t_btrfs_received_uuid_ioctl \
+		8c628557-6987-42b2-ba16-b7cc79ddfb43 $SCRATCH_MNT/sv_$i
+done
+
+# Add one more subvolume and try to set its received UUID to the same UUID.
+# This should fail due to item overflow.
+_btrfs subvolume create $SCRATCH_MNT/sv_last
+$here/src/t_btrfs_received_uuid_ioctl \
+	8c628557-6987-42b2-ba16-b7cc79ddfb43 $SCRATCH_MNT/sv_last
+
+# The failure to set the received uuid on this last subvolume should not cause
+# in a transaction abort and turn the filesystem to RO mode - otherwise a
+# malicious user could disrupt a system. So check this by seeing if we can
+# create a file.
+echo -n "hello world" > $SCRATCH_MNT/foobar
+
+# Unmount and mount again, verify file foobar exists and with the right content.
+_scratch_cycle_mount
+echo "File foobar content: $(cat $SCRATCH_MNT/foobar)"
+
+# success, all done
+_exit 0
diff --git a/tests/btrfs/347.out b/tests/btrfs/347.out
new file mode 100644
index 00000000..b98b6cec
--- /dev/null
+++ b/tests/btrfs/347.out
@@ -0,0 +1,3 @@
+QA output created by 347
+Failed to set received subvol: Value too large for defined data type
+File foobar content: hello world
-- 
2.47.2


