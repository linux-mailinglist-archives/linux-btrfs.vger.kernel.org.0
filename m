Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A1D1812C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 09:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgCKIR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 04:17:28 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36730 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKIR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 04:17:27 -0400
Received: by mail-pf1-f181.google.com with SMTP id i13so878331pfe.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vU/0jV7F8m15JbjAbEfvTnyzaUqHuKYjLpUR2hgj7bY=;
        b=FKla1E9Nx7fZZ7Sk0VuXgANrHdwX7ZvP3wODzZCNgF33T4t2ZH+IgHBwQn2QUMZsrB
         5OhmvZQqx6pIEKcvx4FfcCDe0NOkWZsH0c3Ji/x9rj6UkI5lOLjCwE0a83gHK4ULFkys
         WrXPls4nwYCIyoz73qrTaEQdNQP14l0T/JoBBGVcJbrRuO9U2nNuidjuHEAog4gC5SD8
         WpZ9be938hs9EB/iRwFFcBcHMJquZuCRxLE3lF29sJJWeZoH9mE2vzxojPd+Fh6z46q7
         nBqXW1YFeUkVqzx3zcNBUf4c+w9RLVqttwcLPdeU0mczVbkO19QC1v9zSvmmqFv5rR9a
         KfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vU/0jV7F8m15JbjAbEfvTnyzaUqHuKYjLpUR2hgj7bY=;
        b=p4F+2s+SBxxWLfmjQ4NPqKT6SdwEFo4F4f11L0eNsI26J8j8fOMyPJY1flnhVIoS3m
         51bkPsEetmMGNIkIThSROv/loPpP9iUNfHih2ztbwuYPUh/4NESLq2718DjIU9z+Lme7
         pMpxe/ouFBa+lJjvMVPNVXwcmFw8JeO+3DUWiNBQ40K7WFEXKBLksMou/BbuXhkSA8db
         hOEkuXuSXzGcBMhZYMcFe8ElYihVDMLHRJ/SszL3OTnIDzC/LmrRURdvS2L9e0CRvi0+
         t1WKZVEf/nC/nygW1M01zbePmSi4o6swYl56kTXtGp8Vj3jTXqUgH0KsOVDTGpGlWzN3
         2frg==
X-Gm-Message-State: ANhLgQ1dhlkO+u4ArqLjSgMXr3/4BDu3ySHb+B8iMvj2kb6izKQ5fbkf
        gMaqsxjbXl9U9v4aqksiRyN319lrVnU=
X-Google-Smtp-Source: ADFU+vtsKKluEms5hrRCcFVCofDIEFHcVl5iYV4L2DwGsgsB5gWkNcbYcc3wIg9krSt3u7mKWUpA6w==
X-Received: by 2002:a65:458e:: with SMTP id o14mr1744782pgq.323.1583914646308;
        Wed, 11 Mar 2020 01:17:26 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id j8sm4692039pjb.4.2020.03.11.01.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:17:25 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Filipe Manana <fdmanana@gmail.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH RESEND v2 3/3] btrfs-progs: tests: add test for receiving clone from duplicate subvolume
Date:   Wed, 11 Mar 2020 01:17:11 -0700
Message-Id: <999924f436ccad26b30f555ee106a131dff015c9.1583914311.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583914311.git.osandov@fb.com>
References: <cover.1583914311.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This test case is the reproducer for the previous fix.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
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
2.25.1

