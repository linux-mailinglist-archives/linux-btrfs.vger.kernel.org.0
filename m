Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E060F33DE0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbhCPTqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbhCPTpQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BFC0613EF
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4120646pjb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csjtCPkdL7tZ0Hw4uLrgE01zyi/QWaclx9nbiJQ12+k=;
        b=GlL1MupUUCck+C58n+nknBl7BOsxQ+q7L/a0RohyN9atfW008/oLMhFh/JYB5MXOme
         uUXN0HwwkFb2X3hbCWr6Fo5fcP1jBhQ71cP1N039j/kNVPBH7OIAtuv1C4is9lTPl/Uv
         saj/z5nRwCi6DnEVZkUkuDoHRqGn3Kn2D+pfRS3xn/jiMzELKxxjN9HqgK5XqiZCB8N0
         iGFr/bpmf2NEszY28pZQXXLrR6OjUz4+GvU/qorIVndkVzTbKf17AHxIJf6THypXoKj5
         h5julzh0zItmnmrIeTpdQXCrRcv7DQaFgmh7vZx3qpeSDNqbv4+gyEKdyW7jJB2Cjefc
         iS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csjtCPkdL7tZ0Hw4uLrgE01zyi/QWaclx9nbiJQ12+k=;
        b=TgT5HjBtrvaiengPL3/6j8wIRd0U3y1mXz6s8rd5uNorwxT4a4qcpQ6/EabLzbfQn1
         D1+Q+oN32Hs9tZ9KSfOgIboj1fxDdLYs670e+PI4ryVfpvzGNYt7EPmsrpGlyrx6yr4Q
         a/moB1Igs1JA9URGsN/5q/OhWhYAe2zhYlPUsKpQcmDQMTuYKj5cEuNdcHRs4x1oGQ+J
         yqKTN0DnR9BGOV/k1rGHg3pZR0k7zxSShqo+XX63kheM1BoOXcss79ZzdfuF/9Fyqhcq
         Emasq/OFdk6FB52GAZdzn4L1iwMUXyVuue5Ozd1XCDE8rn1yKV9TAECOFYXEkE4ySjbZ
         gqfA==
X-Gm-Message-State: AOAM5332vn2D3OpExa5B0Z3ME0sT4BIEa/Yd1+j72Mj3ecBC3QsdqIkH
        LQNaqkQCAhvYBXvt8roCnM/tkBEB0dkwZA==
X-Google-Smtp-Source: ABdhPJxDtOJ9qNhyYBLvbG6xRRmNP/szyGhfc6LFfiT/+MN1/08xcVlqFYTKrPS8tuqVNVZhF8W3Zg==
X-Received: by 2002:a17:902:ee95:b029:e5:e2c7:5f76 with SMTP id a21-20020a170902ee95b02900e5e2c75f76mr864196pld.25.1615923892239;
        Tue, 16 Mar 2021 12:44:52 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:51 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 11/11] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Tue, 16 Mar 2021 12:44:05 -0700
Message-Id: <10e4ab8447fd360b103229d866923f265204d940.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
 .../043-receive-write-encoded/test.sh         | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tests/misc-tests/043-receive-write-encoded/test.sh

diff --git a/tests/misc-tests/043-receive-write-encoded/test.sh b/tests/misc-tests/043-receive-write-encoded/test.sh
new file mode 100755
index 00000000..b9390e88
--- /dev/null
+++ b/tests/misc-tests/043-receive-write-encoded/test.sh
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
2.30.2

