Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169A424CFB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgHUHlg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgHUHk6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58161C061357
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d22so667854pfn.5
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83qY1yiGV6Av8ygbOO41/2N//qJALrswYkrshLQjEaI=;
        b=lEgZZeZz3dHdOoJtt5d8VNuVhl8oh1GerNwL6riHZgnlCETtA26dy9skXtG8r4+LZd
         DoASVZ0kDL/fuv4jLYePgszynxrI+WQs5E0FTiWaU4D6mQvcGDszmyowaArlV+h11YVN
         3hjp7/cObCFoR+6rs+/fCl8S6fL85bTSWEVF+P32lm2sd11oyQo7nAqx0CNNuZx0noOa
         YR4VEfJ1aic9wQJxsaWGUF8EZbBdgpDhGgqbImoHam6O0uu0lxCi62UG9tHVwFofrnnf
         H8D/gorWe6W2zjrEcgLuxKrOSXbS01dIZCJT7QXLCu4jZKnE5bl2pFVJ/6GXpEdOGXCa
         xSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83qY1yiGV6Av8ygbOO41/2N//qJALrswYkrshLQjEaI=;
        b=Iy3MMhia2GeKBIcxAE9+ZkINoSo/OixVmGLaoupcisdrhodKZBMMIEn/3DjSBX0qw0
         WT6wyltGjaeMFcsCSTRqpgMzU+fo8aOsssBEaYdhehg0N+dbqS0hxNUEloeAs1nks7Cd
         4C4UxogV9eqDIYVlvOkVwU2ruYg1zbOioFe0W7mmkLl4npIVNu7vookptvwJFTo6cl0M
         keBBtQ9q1d7L1CIJ70hPSbyQGKpXB47RdaPYeg0P1CmyDLIWQxPDjeHNkF3tbWfKv2X7
         S2yL25IkOViGlIUsQNzIBap4APK11fNzXlIZcXX29otTWHMrC2UrRlMKuIz2+Rdjnrvw
         Esug==
X-Gm-Message-State: AOAM532en2NNcMxW/HD1JLK0VoKryolrKeV6UGJLkdb43z5fHhd09s2s
        Wc0XzPkGu1oVj7RmG3xY8hjg9TNo3rpIDA==
X-Google-Smtp-Source: ABdhPJwqhfIDFP068+V2W1ChVQO5SsJKLf5jPoSErAlzXLd7vD0uTnfmOQfhNU/zO9ptzsOqTDGIyA==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr1391421pgh.255.1597995657124;
        Fri, 21 Aug 2020 00:40:57 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:55 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/11] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Fri, 21 Aug 2020 00:40:10 -0700
Message-Id: <ed0fbf9eed75975d31f61ee5a91b963d6ccba102.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
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
 .../040-receive-write-encoded/test.sh         | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tests/misc-tests/040-receive-write-encoded/test.sh

diff --git a/tests/misc-tests/040-receive-write-encoded/test.sh b/tests/misc-tests/040-receive-write-encoded/test.sh
new file mode 100755
index 00000000..4df6ccd6
--- /dev/null
+++ b/tests/misc-tests/040-receive-write-encoded/test.sh
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
+	send_one "$algorithm" "$str" --compressed
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
+	send_one "zlib" "$strzlib" --compressed
+	send_one "lzo" "$strlzo" --compressed
+	send_one "zstd" "$strzstd" --compressed
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
2.28.0

