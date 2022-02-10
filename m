Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147EB4B15F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbiBJTK5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbiBJTK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB5610BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so6051460pjh.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIflKMx6orNUBBzvTaVkzMgSRIIbO7dH/hPzc4Os/l8=;
        b=UG22gwgjJH5/fKO1fssjXPyZOR+jjQRFtCOAkdl9Ae0zWi0ngzbJniER/LCyS4ZpqJ
         Omfu8HTL+sEgDBvkJIc7jCLImRcKlugM4pbAJhrMrDVeWX0Kd/8lNn80Niu2leJMJkSf
         dkFjbx3NQTqaUAlxCQASlcUT6wMfOssFZJ0jXV9nY3Dc1+m3y8LBZSZn+59pc5dktJW3
         LSxewc6kiplJTDadWFM9jhINvSteZdW+LMlKpZELBKm/njU9F7yQqeKNyNDHanaPGrfn
         7pe/2NYN3waMORzccbIvqdAL2wAUQuV9q20Ycm0pEHDYXq9dstiUqfCs/s3qFDfD1Vg4
         1Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIflKMx6orNUBBzvTaVkzMgSRIIbO7dH/hPzc4Os/l8=;
        b=249siMg1ajMz5CL5SqyPmEVPxRLt4pdvd6Km3of5fjAwJ9m2ilKg7o5IuD19k83iYY
         IIVpPpf0WP9OFONzO5h5wYrGz5LcaJiQTWihqpASt0P4ro1sUA1U73WDjgzYFolDykt1
         PGZAyEPlonD1fMxTU8hoGmQD61raumjkqpLacFXQLikH3FexXhdp3+nj2h6lkTbvkS2c
         DHXpSyMQB9/ZT3CWq8W47mVslJHcuL9ZJ9y4pJxtaTmQQZN2cNQSy507WWXU92dy9GSc
         UsdBcRHPTbmjl7UEk2uGlHR9D7KS3vtXUPUNEeHZUrcFVFXq126e1JuDv+FWnJrCcAjb
         2Png==
X-Gm-Message-State: AOAM532lpQmVkLsDF3FpkHDnTkZFVxU6VO5BbsFiKhpYC6QiAou/kRoV
        J+3u1MehWbDfmFKwTzTBn44ow7+bWC+/aQ==
X-Google-Smtp-Source: ABdhPJy8rEd2qGZM+2Ld3gbl0eqE3+asSg3LR6syYDgmxsW+eVB9Z82USkFfolFa7SN1WOqHszXUfA==
X-Received: by 2002:a17:90b:124e:: with SMTP id gx14mr4307120pjb.63.1644520255804;
        Thu, 10 Feb 2022 11:10:55 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:55 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 10/10] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Thu, 10 Feb 2022 11:10:17 -0800
Message-Id: <f2c81c98036da9e68d2ef96df36bcc8d74100316.1644520114.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

