Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B04C8ED3
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiCAPUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 10:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCAPUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 10:20:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3825C6E;
        Tue,  1 Mar 2022 07:19:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b8so14316634pjb.4;
        Tue, 01 Mar 2022 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGJVi4HvyALFLJMDSJ4NRMx7FbjalA7V0ZLvSwrOZe4=;
        b=LlMdWBQkEP4xO0NgaE8OuVoaPxo3pfgZNlRnY8yvh6mpdQRt1cEC4IxwoX1eobRTrE
         PKtTt4k4fz7gDvI4Os3bWwWhOopUmLsOojy48u4WvVhP5BI5h/pPnAl8T/HnNwzsqEy0
         myOy7jt3zVmFPNQu9Mu35a8cfjc/eFmrReuRecJwOgF0lfaWBUxA+vv6dcmFCg31JxmN
         B0jeIuASA7675JwuBfPUxy1zNUOm3Z+95Y56ru2TuWJxhkV+pB+oT0DFVVurfkfCN925
         Od37728vbc23txjkad16vvnulGsrlVmnA/mCh9wBRqyjImCAIIZEjweCMvHvHR5OQ/9p
         +n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGJVi4HvyALFLJMDSJ4NRMx7FbjalA7V0ZLvSwrOZe4=;
        b=lNCT/udAElGswL/pO4bKJg09bzutVBoR1t5hXkBMOYN6AsJbDqQqbuRjhX3Qil2Q6y
         kIwCMwxy8GWWTLgAAi5o6doxg6F3BdS6WhY9zbTe3dUylfXSdCYgrZRcYQedc0zuu9tp
         B8RRXT1IY2UuPm/9eqGQ3WJQswzIZfUaJlnXk9ad37+l/MEgdgkPvW5oyIPEvIwxLF4B
         myJ7A3XN/p2atJQxpMxS6miHEFn7KKgOj9sYI6B/3QEEL/wqzWOz2ZWRsPwbO6TqNBWJ
         cN8yT9ZB7vuPFdPz6EbLEVhSPomubg9L1Tj630OQpoXuhsaPKuZzvSw0xdX+z9OKw+sw
         G7RA==
X-Gm-Message-State: AOAM5308pnMLV+ISX8zBO0413rS/Gb6bk04vWoMSHs9durhr7wCSV1fr
        jGQ32suX82er2FTfEWzBa6dwdOu6EdqxMw==
X-Google-Smtp-Source: ABdhPJw05PFWATIHq8MYHrd3Ke31olN0g3kUniTKrvlFJZb+RCV1vDgQKm1ca7g16NI5tl/Upz2gNw==
X-Received: by 2002:a17:902:f70b:b0:14d:643d:9c99 with SMTP id h11-20020a170902f70b00b0014d643d9c99mr26939699plo.18.1646147980064;
        Tue, 01 Mar 2022 07:19:40 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id g5-20020a63fa45000000b0037407b6ffdasm13232449pgk.5.2022.03.01.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:19:39 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: [PATCH] btrfs: add test for enable/disable quota and create/destroy qgroup repeatedly
Date:   Tue,  1 Mar 2022 15:19:30 +0000
Message-Id: <20220301151930.1315-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test enabling/disable quota and creating/destroying qgroup repeatedly
in asynchronous and confirm it does not cause kernel hang. This is a
regression test for the problem reported to linux-btrfs list [1].

The hang was recreated using the test case and fixed by kernel patch
titled

  btrfs: qgroup: fix deadlock between rescan worker and remove qgroup

[1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@gmail.com/

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 tests/btrfs/262     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/262.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/btrfs/262
 create mode 100644 tests/btrfs/262.out

diff --git a/tests/btrfs/262 b/tests/btrfs/262
new file mode 100755
index 00000000..9be380f9
--- /dev/null
+++ b/tests/btrfs/262
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 262
+#
+# Test the deadlock between qgroup and quota commands
+#
+. ./common/preamble
+_begin_fstest auto qgroup
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+
+_require_scratch
+
+# Run command that enable/disable quota and create/destroy qgroup asynchronously
+qgroup_deadlock_test()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount
+	echo "=== qgroup deadlock test ===" >> $seqres.full
+
+	pids=()
+	for ((i = 0; i < 200; i++)); do
+		$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
+		pids+=($!)
+		$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT 2>> $seqres.full &
+		pids+=($!)
+		$BTRFS_UTIL_PROG qgroup destroy 1/0 $SCRATCH_MNT 2>> $seqres.full &
+		pids+=($!)
+		$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT 2>> $seqres.full &
+		pids+=($!)		
+	done
+
+	for pid in "${pids[@]}"; do
+		wait $pid
+	done
+
+	_scratch_unmount
+	_check_scratch_fs
+}
+
+qgroup_deadlock_test
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
new file mode 100644
index 00000000..404badc3
--- /dev/null
+++ b/tests/btrfs/262.out
@@ -0,0 +1,2 @@
+QA output created by 262
+Silence is golden
-- 
2.25.1

