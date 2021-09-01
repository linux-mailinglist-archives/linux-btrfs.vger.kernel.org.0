Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE033FE0D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbhIARDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbhIARDF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:03:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B905FC061796
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 10:02:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m4so74283pll.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YobspOtAz1+Sdf06vQkAR93CT6czB2ar8/rJ/GZ6Cs=;
        b=DVF0QuoysMADKI+Uk36IrlUjkmNaQEVFqpz7H8AfZLLH+3ksTzrXUSKxzeF2JXN17U
         Cy0/k8dB97mVQzSKQrT3T3IslRY0NnSrIQV5smt13P0uVmXBaL4PcXirOc3vjmjeidvs
         ZETEsWMLQ+NXpgME1Nd4aznuyidqux52JXSI6yrpDqzj2iLsmwgu1Mtq2CHrKv2CAvln
         n+JgMoCz2dld8xMQBENigy4Hu1U6okMOmOPVwBHbdPWMgmcUlHjUx6AM/FrGxJQLLQV9
         wiYNiDRxaDTHkwDcKzENMDpn1cQIcyw7j3LmD/SDtHmfeVELR0ia7YZGkWPvIeSXBghm
         f3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YobspOtAz1+Sdf06vQkAR93CT6czB2ar8/rJ/GZ6Cs=;
        b=aGN/igv2MONRkxIqmTnmNyK7/mhaWd8IGPGFhUpOSUqNA3rY+RfY6VKXijOiEyBQAW
         t6HIlX6u+2ZXIf9Q1wAZO7WMHUWvHULA20ZVtLvo1pGlXxRqaD0i9S4jPrhtCmiidtxh
         oYhRblHRpkC6Cl897eckf0RDxQEOcasEJYeFuTbh7CxUAgnP5hICA4fGzQW0HEKSi923
         pldGrJBnwB4yUMN/cXmLiavqp1ufDeoQBYcctMePBQ0Ijw/wPiwZowqsg5duV5Z6ZAQN
         PG5rYz3Hmts/qYZxSkhpS36N53xVVhfXc1aTldANtHiOtTBRN/4Qqtl/c8CHU5N7zDTK
         lfRg==
X-Gm-Message-State: AOAM532tBijB2ahCCu1WrxNa5hXx7m094yFxp+sxkfgvuKEty3W4t+5e
        fT/5bc8ZCFHVA6s0BqzMynwRqmT0w39RmA==
X-Google-Smtp-Source: ABdhPJxlfcEIPskxwVOEb8HGmwea/3letveiP0TIoBbY71RY9I7yYXBsq7m4I1vfiL+CZvoGyJHCsg==
X-Received: by 2002:a17:90b:38cd:: with SMTP id nn13mr405391pjb.108.1630515723923;
        Wed, 01 Sep 2021 10:02:03 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:02:03 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 10/10] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Wed,  1 Sep 2021 10:01:19 -0700
Message-Id: <c48dbaee54ec45a822d734ef08f76c2414291eb1.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Adapt the existing send/receive tests by passing '-o --force-compress'
to the mount commands in a new test. After writing a few files in the
various compression formats, send/receive them with and without
--force-decompress to test both the encoded_write path and the
fallback to decode+write.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 .../049-receive-write-encoded/test.sh         | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tests/misc-tests/049-receive-write-encoded/test.sh

diff --git a/tests/misc-tests/049-receive-write-encoded/test.sh b/tests/misc-tests/049-receive-write-encoded/test.sh
new file mode 100755
index 00000000..b9390e88
--- /dev/null
+++ b/tests/misc-tests/049-receive-write-encoded/test.sh
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
+	send_one "$algorithm" "$str" --stream-version 1
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
2.33.0

