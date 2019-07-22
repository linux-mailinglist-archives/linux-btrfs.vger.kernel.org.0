Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A670988
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfGVTPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 15:15:18 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37816 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbfGVTPR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 15:15:17 -0400
Received: by mail-pf1-f169.google.com with SMTP id 19so17834771pfa.4
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jci9Vezwk+zxr0CT5B5DenZvn0rcgTzyN2FOk3GsXWg=;
        b=RWGQqkgrvM2ZRtAl4k6ZNG3gqGHZKF5b564n+td7MXRwaOC0Cc1j8l88fQZoAbTMVB
         enGpULcqeMrvpa9Z6gCCwpkW/ECWMLV3FO7E6GW5YFlzG+Ef2jsI3NPmdAw6tWwouRL/
         VSny5SE20ZD4V7j0uSptX72PQzkW1F3uLkbR7mbPCPwSoiIKz4tmFzuDPtQ8Ewc5yc6Z
         pKau1oqxhIRS7GCZCIPgmDIpUcMgtMayvG7SaQr4tfdrF5JVAiun5lXmXtsjx1e0KFLX
         W7XNd06m/GWQNy58fZs5zgOPOfJ5Xez86rqLHPs7U5Sat6m//eHugUpjF/VA4YS99Yay
         /6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jci9Vezwk+zxr0CT5B5DenZvn0rcgTzyN2FOk3GsXWg=;
        b=t/yGl10ZUwCMZu/n40vAPkseodB6Ytn/vsULAcInHNMsxNsFCebJFS8V8u+iH3S0tt
         DTEhtNzSoYw/gEellGp4H6KvXSthi4+HJVlEi4oQuIIafj/Gm5L9RQEH2xv0QPm9BzPT
         nBvfgoNrFpuAfz50TOdqL3KQkoYaNyty0Bpo1HY1EEJ07HeHQc5IG2dvaQqAOwCFxxgT
         4e3sI+kwtbh+KISLo0XuIVoFMU+jkpxA/r2zzAOxq3ZygRex/o7GnBwt95YanqiFubD1
         t8Yatay4WuY9imoeKqXSqhk3syYUeY32tCHbhDqsp4mjLDF/d5VCHFpNmtyRTM9sFfUl
         H8fA==
X-Gm-Message-State: APjAAAU53iugtIoZXmNrnK5ejFm4B3rBY7auFvmAAOtX3yaTTc5HfI2Z
        BmzO2K4DjVtp4/vddmiW7qYkKo9kBOA=
X-Google-Smtp-Source: APXvYqzr29SwMYWmm5Xl5mSPpUzZ3m1NQvF21VEvXvfWms7BHg04FigoMfQn5XNZlGwM2nSiv0NQWQ==
X-Received: by 2002:a63:f357:: with SMTP id t23mr19776610pgj.421.1563822916317;
        Mon, 22 Jul 2019 12:15:16 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:a31b])
        by smtp.gmail.com with ESMTPSA id t11sm47262048pgb.33.2019.07.22.12.15.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:15:15 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 4/4] btrfs-progs: tests: add test for receiving clone from duplicate subvolume
Date:   Mon, 22 Jul 2019 12:15:05 -0700
Message-Id: <45fa864ecb8805596dd7a1052f9e68509e79447b.1563822638.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563822638.git.osandov@fb.com>
References: <cover.1563822638.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This test case is the reproducer for the previous fix.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 .../test.sh                                   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh

diff --git a/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh b/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh
new file mode 100755
index 00000000..be648605
--- /dev/null
+++ b/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# Test that when receiving a subvolume whose received UUID already exists in
+# the filesystem, we clone from the correct source (the subvolume that we are
+# receiving, not the existing subvolume). This is a regression test for
+# "btrfs-progs: receive: don't lookup clone root for received subvolume".
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+check_prereq mkfs.btrfs
+
+setup_root_helper
+
+rm -f disk
+run_check truncate -s 1G disk
+chmod a+w disk
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f disk
+run_check $SUDO_HELPER mount -o loop disk "$TEST_MNT"
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subvol"
+run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/subvol/foo" \
+	bs=1M count=1 status=none
+run_check $SUDO_HELPER cp --reflink "$TEST_MNT/subvol/foo" "$TEST_MNT/subvol/bar"
+run_check $SUDO_HELPER mkdir "$TEST_MNT/subvol/dir"
+run_check $SUDO_HELPER mv "$TEST_MNT/subvol/foo" "$TEST_MNT/subvol/dir"
+run_check $SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/subvol" ro true
+run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "$TEST_MNT/subvol"
+
+run_check $SUDO_HELPER mkdir "$TEST_MNT/first" "$TEST_MNT/second"
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "$TEST_MNT/first"
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "$TEST_MNT/second"
+
+run_check $SUDO_HELPER umount "$TEST_MNT"
+rm -f disk send.data
-- 
2.22.0

