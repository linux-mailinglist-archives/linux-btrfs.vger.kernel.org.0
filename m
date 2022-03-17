Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE94DCC5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiCQR1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiCQR1k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D486E21047B
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v4so5454163pjh.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIflKMx6orNUBBzvTaVkzMgSRIIbO7dH/hPzc4Os/l8=;
        b=f8hjOBq53EbXo4sN7ojf8rUjF+GjY1rGIJSoTvvAPOJTKk0WrSx5nc5WkTcPi3bMUI
         00US3FfFlKua27qIk4M085NqCsaLkCEhabYXuv4y/dfoQpx2CK5ml1L97AeDI64qHoz+
         Z4hcq4UIZv3gCEda5TF6wYsAzikwFcMBU8AaXuczccWS7Uj+JmHFQ0XC4bIG+fnbd7T6
         g9XexcytwVwcaVbnzEzL2VDn3SaVCojXkM+sTCIPG2W/T6H5cOm4M+VYKTBloxJLM76B
         h8B1DDgrOIepPxdi10jmG5LpVZ7aTSyEcxO8btegZvRrUJC9yi4Qh6E+180km1EDqgdX
         A9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIflKMx6orNUBBzvTaVkzMgSRIIbO7dH/hPzc4Os/l8=;
        b=VXCDO9AD354RyoNZEeGLxYdV/Z/FBAr6X6ctdG4oFsMVbPG5fO4TtVsQ0RJDl4YM0L
         I5BqR+XDL8M6jAmbvzeLOsqvHcFrOAcnWjZrrd77WUV0x3+wumDzNV7z5biVt8xWd2EZ
         wMngxAtnpeczASXvksZZdfM9gGX5OY9jBhc4VSoPVJjNlly8NR6CDcIh6b8d4t4H1DOS
         YZPEazuVOlZX+baOnweI/siswiSMkHwFDOkkeTJoZVW6hbS0chtMpuGB6uHFSQdjI/cw
         osdfA4koEToCoHBsREz82El+WIuRSZ33k4Mc6pRz3kxoHi0U5pviH+IRy+4LVpDV4D0Q
         +jWQ==
X-Gm-Message-State: AOAM532sSd2s4N9+T2oe2HgohAmWpLw5viDN4dTLleo18DJcJFboIPgj
        cg9cFunlvx7lsEBxhXOMjPpk3nS+4UhjpA==
X-Google-Smtp-Source: ABdhPJwqFHPf9c9HxJ5Kihdzb4XSe0Ie19ArJ4kUP+HQ9335nTHOBKoezvl/5HqVPC8y3r8QHeySPQ==
X-Received: by 2002:a17:902:ce08:b0:153:8d90:a109 with SMTP id k8-20020a170902ce0800b001538d90a109mr6190283plg.157.1647537982984;
        Thu, 17 Mar 2022 10:26:22 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:22 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 10/10] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Thu, 17 Mar 2022 10:25:53 -0700
Message-Id: <7fe7eb90c6c1cbcb898a429d6235c551b3d9c3ba.1647537098.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1

