Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400FD2B84D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgKRTTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgKRTTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE253C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:19:48 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f18so1856209pgi.8
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qASfdMugLX6dkJNB+g4DB9CS4PoJpLhsrJsEHm5JPHo=;
        b=g9Pgdk80zIKJmvTMpsBJ8RyqvR6ihfHqH60Twyb9UJwXyNRCAMOC2GbyKrKUy527mR
         iSg5zoJNfey4DZoUsFxzXjslAhiH1JIghrUVj435BWFNsjAKxc6XW/IqlR990B1EqHoU
         g3o0xkNgIPCxn4ijuiWumP+wXwF/5q2HC7J/nTk9RL9Wkrrs4Wp6MHtuFKvmWHiu53CN
         cCFnq2kk1fKjtC38KqsTNqbC5NoU/Ek0EriZ/8aL+tg0/olB9vuvJ3HvpfFkqEwWZ1Zv
         ROLAoVhI9gr82YZsnYlCEjSK6YcYDDOU7HOJj11qlBYbGJMOXr1GyTWufFY42VvH+okJ
         efeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qASfdMugLX6dkJNB+g4DB9CS4PoJpLhsrJsEHm5JPHo=;
        b=sR1o5KXLgigpqByq6F0f01+b0Du1QipKbRAfwM8LG9lWLav2UNUJRivJBelsgVM1xO
         jyjgoejPD3kjT7aOXaePiNsTvElzRp5spfUmnRYMtjc1IrkaGxgpaeQKeCsuDyvWkFH9
         tLqGlQz7+ELWqDbxwMHR2OrerqbOPNEoAe+F0ShrvaKReJbN7O18mJ9OwfmeAvvhN18g
         7F8fiNrbO/RER9z4Q0wI6TM8jurgnnh2cOOh0F/BFAVzLOeLjVDGDLangOexJDQkutBO
         lB+xxRxLG+RY0VSBF6EyMR7qqI+wMQWZ4gfbftNbPiQiRvSgXB6IsGyjOVsOzD3IFpGq
         jDEg==
X-Gm-Message-State: AOAM5304h6VuREDxC0zM5q9nyXrPiZcbB6rwuy7YPgpCk2jusJS6yv+r
        4L6+CQwnHOboANUwaTPFDCGdEHf52I1GKw==
X-Google-Smtp-Source: ABdhPJxZ7ymPheEqg1BwDPCXVWYQJR2jOlrQETu1Ux49c10JuOuG4RR1rxx/X3E8SOPzKEs4gwW2lA==
X-Received: by 2002:a63:fc1c:: with SMTP id j28mr9106892pgi.95.1605727187768;
        Wed, 18 Nov 2020 11:19:47 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:46 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/13] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Wed, 18 Nov 2020 11:19:00 -0800
Message-Id: <bdb71ff2f010742f1f2a4695b5ecb7e70f627638.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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
 .../042-receive-write-encoded/test.sh         | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tests/misc-tests/042-receive-write-encoded/test.sh

diff --git a/tests/misc-tests/042-receive-write-encoded/test.sh b/tests/misc-tests/042-receive-write-encoded/test.sh
new file mode 100755
index 00000000..b9390e88
--- /dev/null
+++ b/tests/misc-tests/042-receive-write-encoded/test.sh
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
2.29.2

