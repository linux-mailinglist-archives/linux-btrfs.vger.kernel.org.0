Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A246421509
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhJDRSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhJDRSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:18:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F3C061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:16:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q201so4546709pgq.12
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eWv38nNENaQhYFaYalIT0LreLRxEmwXlJpw4I1pCAPQ=;
        b=bEGzHTKczAMhf+h6k4cnHpQLc83GS/Bow9jBOCjB8gRUxlrfTQfaCB44DI8bWclJUw
         LYYiNQNNYxDU/LTnefro8jatB3BYVqc2+AFdWUsErTCBsjIalt6ycyBT1pGERdzafLbD
         kIZjk6D2YblTRiKRi/IjZPm+FwjmVKMva3KeTa0Jsgi9lLNpxI7fgvW6brf8dKfEGQMw
         sXyR7s3Q+ztE2OE8ep3WpNxDbitrAwLq/Vq3k33mdvtT33hnB4x2ROemJxZerQvuIIOd
         WVurwW0LQkf6+MJGlJwlLq9GIQ3O6SwK3E8QMprwHSCP73OOhCclnMtEHJ1uvQdttG0T
         aKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eWv38nNENaQhYFaYalIT0LreLRxEmwXlJpw4I1pCAPQ=;
        b=pm+uHkYz1rzawN/cAjH/Onz/APc5z75k6v2rzznWXcAibsK2bkptLjeV7Jm5HOgosD
         ZFItfLY94KKvF0jUOHDNYBsnLyr0HrIvI+uUei7XgOC0ef2WW8WQkMbuI5B814XGHzIn
         JpPf7xw6qWNxO9eKq29ZmKpEtBSt0QHXdDoC7hJBVUqUrPeDSQ6YR9abe42BQNMBM9mY
         e4qWaRTbduzGuTdtkAhDa9yqTK6e5Ojgsy+4Dr6NpaSDpcyeS7NqkS+GXQXaNLbFzhZY
         qNAjgO51ep/z+Amai8dwwb9tS9DWoL/tS9qPHAbi+tTPLCVfA7907PESBbFRm9Xe1tn/
         lzvg==
X-Gm-Message-State: AOAM5338GxrORdt/yQuOQBX0bPi6EC6IqB+PKGJjL7Tg6sqL8MaI1gt7
        /45bMHaNY8jtjx3dUYU9dShPNWDIqgg7ZyGdgdDrzi4g
X-Google-Smtp-Source: ABdhPJx7RqYc7v0Otrqrobj82vNyJnLvtcSUJWQDzd/MBJTydzBBHPFsEiquN5QqCtAn7x6CQUmdag==
X-Received: by 2002:a65:4345:: with SMTP id k5mr11901194pgq.410.1633367785558;
        Mon, 04 Oct 2021 10:16:25 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([223.74.0.87])
        by smtp.gmail.com with ESMTPSA id y24sm14736582pfo.69.2021.10.04.10.16.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 10:16:25 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] Add a fstest for scrub error.
Date:   Tue,  5 Oct 2021 01:16:13 +0800
Message-Id: <1633367773-15797-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

reference to:
https://lore.kernel.org/linux-btrfs/5679da1e-2422-69c5-b4f8-326802363f7c@suse.com/
https://github.com/kdave/btrfs-progs/issues/389

It tests  in raid1 mode, if one of device
is gone away and come back, whether btrfs scrub could finish the job

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 tests/misc-tests/050-device-state-missing/test.sh | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 tests/misc-tests/050-device-state-missing/test.sh

diff --git a/tests/misc-tests/050-device-state-missing/test.sh b/tests/misc-tests/050-device-state-missing/test.sh
new file mode 100755
index 0000000..30b2c2c
--- /dev/null
+++ b/tests/misc-tests/050-device-state-missing/test.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+#
+
+source "$TEST_TOP/common"
+
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+setup_root_helper
+
+setup_loopdevs 2
+prepare_loopdevs
+
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -draid1 -mraid1 "${loopdevs[@]}"
+run_check $SUDO_HELPER mount -o space_cache=v2 "${loopdevs[1]}" "$TEST_MNT"
+run_check $SUDO_HELPER umount "$TEST_MNT"
+run_check $SUDO_HELPER losetup -d "${loopdevs[2]}"
+run_check $SUDO_HELPER mount -o degraded "${loopdevs[1]}" "$TEST_MNT"
+run_check $SUDO_HELPER touch "$TEST_MNT/file1.txt"
+run_check $SUDO_HELPER umount "$TEST_MNT"
+run_check $SUDO_HELPER losetup "${loopdevs[2]}" "$loopdev_prefix"2
+run_check $SUDO_HELPER mount "${loopdevs[1]}" "$TEST_MNT"
+run_check $SUDO_HELPER "$TOP/btrfs" scrub start "$TEST_MNT"
+sleep 3
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" scrub status "$TEST_MNT" | grep -q "finished" || _fail "scrub for raid1 and one dev is no update to data failed."
+run_check $SUDO_HELPER umount "$TEST_MNT"
+
+cleanup_loopdevs
-- 
1.8.3.1

