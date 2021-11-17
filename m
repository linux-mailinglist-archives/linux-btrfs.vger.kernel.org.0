Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1F9454E7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbhKQUX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbhKQUX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:26 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE1C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:27 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id u16so2920921qvk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuOIH8fbs86hSqXLW0mlbnKinIhnIINetD6qp0jjmMA=;
        b=CW6xGJEnbbVaXx1uZIpciMVI+VWfzCy+eDr39Pi6r760ju2wHWGtmvNQbiULzXUieC
         f6CPlwljzGpPpNQuWYVTp10SpPyIUn7sYTYlCH7BNF2LHiotxFildhUYHnlPFqv0RSEB
         x1l1elWa9eMxJNBcVoxG7D/zD9oy3yV5rweEgMq0tAwclRKvZlz/EWvMRGRZghSN+mMP
         6ngw/sD4brt45VwDYpc7phrXkMhs7xb/bJdj1za0Lz3d9ATYnijnj7n54uwKA47xAyvY
         KhOizkhmw5fWPfnmuPNxyfXp4F94+I/0oINwakiQwvKoSOeVyD7iC2DWVfBW8sz9SvAY
         5ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuOIH8fbs86hSqXLW0mlbnKinIhnIINetD6qp0jjmMA=;
        b=CGmMWw+4byqvbL/8XFMgTOzb+/49qDm2I1NPDQf2HUtzWpco+FMZFDSNkOLk0IdyDx
         P///eA57qnxj3iFfJTEFdA3gVOoRm8lYfrcI6aZa/c7H3IKthRPqGtUHKcfvRxd5fRPk
         qz0oVOEKS3I8R8nZYSeWWy+/5yEC8A/+7lzROzGpqF+IeIw+fuBX3xaMLEM8W+pLkvKE
         A1XxoEv4qTbNgx1u4EWOO0dmz9WoGVRb+/wPGQCrqW1cMvs2MHgVcFBF7c8NQtW751nu
         1F8zajgRPIy/OoxsmN+Bz2ND6IUwjxuXYxk7pVyJMPosiQa2GM4d5gcj0Kt7mi8ZDfc/
         /ixg==
X-Gm-Message-State: AOAM531+2M9AUrcVMD+XSklJfwa9jklU97A49gcj2HGz/tK5aReySD+2
        fxAabYoSKWhFps4m2HOVjf6gBQP+13zLUw==
X-Google-Smtp-Source: ABdhPJzfZInzAlSiYvxCPEfLcK5jCUBewz/4CNf7RexJQYMuFSBwXrObF7VHx26sqOfPerAAIbRPMQ==
X-Received: by 2002:a0c:f9cc:: with SMTP id j12mr57362670qvo.2.1637180426319;
        Wed, 17 Nov 2021 12:20:26 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:26 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 10/10] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Wed, 17 Nov 2021 12:19:37 -0800
Message-Id: <2081e7c94ce9ff035fe4578aa5019523f033b446.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Adapt the existing send/receive tests by passing '-o compress-force' to
the mount commands in a new test. After writing a few files in the
various compression formats, send/receive them with and without
--force-decompress to test both the encoded_write path and the fallback
to decode+write.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 .../052-receive-write-encoded/test.sh         | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tests/misc-tests/052-receive-write-encoded/test.sh

diff --git a/tests/misc-tests/052-receive-write-encoded/test.sh b/tests/misc-tests/052-receive-write-encoded/test.sh
new file mode 100755
index 00000000..47330281
--- /dev/null
+++ b/tests/misc-tests/052-receive-write-encoded/test.sh
@@ -0,0 +1,114 @@
+#!/bin/bash
+#
+# test that we can send and receive encoded writes for three modes of
+# transparent compression: zlib, lzo, and zstd.
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+prepare_test_dev
+
+here=`pwd`
+
+# assumes the filesystem exists, and does mount, write, snapshot, send, unmount
+# for the specified encoding option
+send_one() {
+	local str
+	local subv
+	local snap
+
+	algorithm="$1"
+	shift
+	str="$1"
+	shift
+
+	subv="subv-$algorithm"
+	snap="snap-$algorithm"
+
+	run_check_mount_test_dev "-o" "compress-force=$algorithm"
+	cd "$TEST_MNT" || _fail "cannot chdir to TEST_MNT"
+
+	run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$subv"
+	run_check $SUDO_HELPER dd if=/dev/zero of="$subv/file1" bs=1M count=1
+	run_check $SUDO_HELPER dd if=/dev/zero of="$subv/file2" bs=500K count=1
+	run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$subv" "$snap"
+	run_check $SUDO_HELPER "$TOP/btrfs" send -f "$str" "$snap" "$@"
+
+	cd "$here" || _fail "cannot chdir back to test directory"
+	run_check_umount_test_dev
+}
+
+receive_one() {
+	local str
+	str="$1"
+	shift
+
+	run_check_mkfs_test_dev
+	run_check_mount_test_dev
+	run_check $SUDO_HELPER "$TOP/btrfs" receive "$@" -v -f "$str" "$TEST_MNT"
+	run_check_umount_test_dev
+	run_check rm -f -- "$str"
+}
+
+test_one_write_encoded() {
+	local str
+	local algorithm
+	algorithm="$1"
+	shift
+	str="$here/stream-$algorithm.stream"
+
+	run_check_mkfs_test_dev
+	send_one "$algorithm" "$str" --compressed-data
+	receive_one "$str" "$@"
+}
+
+test_one_stream_v1() {
+	local str
+	local algorithm
+	algorithm="$1"
+	shift
+	str="$here/stream-$algorithm.stream"
+
+	run_check_mkfs_test_dev
+	send_one "$algorithm" "$str" --proto 1
+	receive_one "$str" "$@"
+}
+
+test_mix_write_encoded() {
+	local strzlib
+	local strlzo
+	local strzstd
+	strzlib="$here/stream-zlib.stream"
+	strlzo="$here/stream-lzo.stream"
+	strzstd="$here/stream-zstd.stream"
+
+	run_check_mkfs_test_dev
+
+	send_one "zlib" "$strzlib" --compressed-data
+	send_one "lzo" "$strlzo" --compressed-data
+	send_one "zstd" "$strzstd" --compressed-data
+
+	receive_one "$strzlib"
+	receive_one "$strlzo"
+	receive_one "$strzstd"
+}
+
+test_one_write_encoded "zlib"
+test_one_write_encoded "lzo"
+test_one_write_encoded "zstd"
+
+# with decompression forced
+test_one_write_encoded "zlib" "--force-decompress"
+test_one_write_encoded "lzo" "--force-decompress"
+test_one_write_encoded "zstd" "--force-decompress"
+
+# send stream v1
+test_one_stream_v1 "zlib"
+test_one_stream_v1 "lzo"
+test_one_stream_v1 "zstd"
+
+# files use a mix of compression algorithms
+test_mix_write_encoded
-- 
2.34.0

